function [ DFTx, Fd ] = plot_DFT_mag( x, fsample, figure_num )
% function [ DFTx, Fd ] = plot_DFT_mag( x, fsample, figure_num );

% The input arguments are :
%     x = time domain samples of a discrete-time sequence
%     fsample = sampling frequency (samples / second)
%     figure_num = number of the figure to use for the two plots

% The output arguments are :
%     DFTx = DFT spectrum values (complex) [same # samples as x]
%     Fd = Digital frequency values for each DFT sample

% Length of signal
N = length(x);
% Perform the DFT computation
n = 0 : N-1;
for k = 0 : N-1
    dftx(k+1) = sum(x.*exp(-j.*2.*pi.*n.*k./N));
end

% Normalize the magnitude response by dividing the number of samples.
DFTx = dftx/N;
% Digital frequency value
Fd = 0 : 1/N : 1-1/N;
% Analog frequency value (Fa = Fd * fsample)
Fa = Fd*fsample;

% Plot figure with figure_num
figure(figure_num);
subplot(2,1,1);
stem(Fd, abs(DFTx), '.'); grid on;
title('Magnitude response of DFT'); 
xlabel('Digital Frequency(Fd)');
ylabel('Magnitude response');
subplot(2,1,2);
stem(Fa, abs(DFTx), '.'); grid on;
title('Magnitude response of DFT'); 
xlabel('Analog Frequency(Fa)');
ylabel('Magnitude response');


end

