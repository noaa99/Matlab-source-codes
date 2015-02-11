function plot_freq_responses(Fd, HF, fsample, figure_num)
% function plot_freq_responses(Fd, HF, fsample, figure_num);
% Fd = digital frequencies (cycle/sample) that correspond to the H(F) freq response values
% HF = an array of complex H(F) DTFT frequency response values to plot
% fsample = sampling frequency (samples / second) st
% figure_num = number of the 1 figure to use for the two plots

% First figure
figure(figure_num);
subplot(2, 1, 1);
plot(Fd, abs(HF)); grid on;
title('Frequency Response'); 
xlabel('Digital Frequency'); ylabel('Magnitude Response');
subplot(2, 1, 2);
plot(Fd, angle(HF)/pi); grid on;
xlabel('Digital Frequency'); ylabel('Phase Response / pi');
ylim([-1 1]);

% Second figure
figure(figure_num+1);
subplot(2, 1, 1);
plot(Fd*fsample, 20*log10(abs(HF))); grid on;
title('Frequency Response'); 
xlabel('Analog Frequency'); ylabel('Magnitude Response(dB)');
subplot(2, 1, 2);
plot(Fd*fsample, angle(HF)/pi); grid on;
xlabel('Analog Frequency'); ylabel('Phase Response / pi');
ylim([-1 1]);

end

