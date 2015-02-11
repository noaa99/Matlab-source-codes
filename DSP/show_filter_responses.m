function [ poles, zeros, HF, Fd, hn, n ] = show_filter_responses( Ak, Bk, fsample, ...
    num_of_f_points, num_of_n_points, figure_num )
% function [ poles, zeros, HF, Fd, hn, n ] = show_filter_responses( Ak, Bk, fsample, ...
%     num_of_f_points, num_of_n_points, figure_num );

% < Inputs >
% Ak = a list of the Ak coefficients of the filter difference equation (coefficients of the ?y? terms) 
% Bk = a list of the Bk coefficients of the filter difference equation (coefficients of the ?x? terms) 
% fsample = sampling frequency (samples / second)
% num_of_f_points = the # of points for the freq. response plot
% num_of_n_points = the # of points for the unit sample response plot
% figure_num = number of the 1st figure to use for plots

% < Outputs >
% poles = a list of the complex pole locations (z values) for the Transfer Function (the roots of the H(z)
% denominator polynomial)
% zeros = a list of the complex zero locations (z values) for the Transfer Function (the roots of the H(z)
% numerator polynomial)
% HF = the complex DTFT frequency response values (linear scale)
% Fd = digital frequencies that match the freq response values
% hn =  has the unit sample response sequence values
% n = has the corresponding sample indices (0 to [num_of_n_points ? 1]);

% Calculate poles and zeros
poles = roots(Ak);
zeros = roots(Bk);

% Pole Zero diagram
figure(figure_num)
zplane(Bk, Ak);
grid on;
title('Pole/Zero Diagram in Z Plane')

% Frequency response plots
% H(z) vs F(digital frequency)
% H(F)[dB] vs fanalog(analog frequency)
[HF, W] = freqz(Bk, Ak, num_of_f_points);
Fd = W./(2*pi);
plot_freq_responses(Fd, HF, fsample, figure_num+1);

% Unit sample response
[hn n] = unit_sample_response(Bk, Ak, num_of_n_points, figure_num+3);

% Add finter analysis functions for Section 5
% Find the Peak magnitude response value and its digital frequency
peakMag = max(abs(HF));
peakIndices = find(abs(HF) == peakMag);
peakMagFreq = Fd(peakIndices);
disp(['Peak Magnitude response value is ',num2str(peakMag)]);
disp(['Digital Frequency of Peak Magnitude respons is ',num2str(peakMagFreq),'(Hz)']);

% Find the minimum magnitude response value and its digital frequency
minMag = min(abs(HF));
minIndices = find(abs(HF) == minMag);
minMagFreq = Fd(minIndices);
disp(['Minimun Magnitude response value is ',num2str(minMag)]);
disp(['Digital Frequency of Minimun Magnitude respons is ',num2str(minMagFreq),'(Hz)']);

% Maximun attenuation of the filter, in dB
maxAttenuation = 20*log10(peakMag) - 20*log10(minMag);
disp(['Maximum attenuation of the filter is ',num2str(maxAttenuation),'(dB)']);

% Magnitude response at the 3dB cutoff frequency
% cutoffdB = 20*log10(peakMag) - 3;
% cutoffVal = 10^(cutoffdB/20);
cutoffVal = peakMag*0.707;
disp(['Magnitude response at 3 dB cutoff frequency is ',num2str(cutoffVal)]);

% Determine the 3 dB cutoff frequency
aboveCutoffIndices = find(abs(HF) > cutoffVal);
aboveCutoffValues = abs(HF(aboveCutoffIndices));

% Get first value of HF that is > cutoff
if(length(aboveCutoffIndices) ~= 0)
    firstAboveIndice = aboveCutoffIndices(1);
else
    return;
end
lastAboveIndice = aboveCutoffIndices(length(aboveCutoffIndices));
firstHFValue = abs(HF(firstAboveIndice));
lastHFValue = abs(HF(lastAboveIndice));
% Create criteria
indicesGap = setdiff(1:max(aboveCutoffIndices), aboveCutoffIndices);

% Determine filter type
if (peakIndices <= firstAboveIndice & peakIndices < lastAboveIndice & isempty(indicesGap))
    filterType = 'Low-Pass Filter';
    cutoffFrequency = Fd(lastAboveIndice);
    bandwidth = cutoffFrequency - Fd(peakIndices);
elseif (peakIndices > firstAboveIndice & peakIndices >= lastAboveIndice & isempty(indicesGap))
    filterType = 'High-Pass Filter';
    cutoffFrequency = Fd(firstAboveIndice);
    bandwidth = Fd(peakIndices) - cutoffFrequency;
elseif (peakIndices > firstAboveIndice & peakIndices < lastAboveIndice & isempty(indicesGap))
    filterType = 'Band-Pass Filter';
    cutoffFrequency = [Fd(firstAboveIndice), Fd(lastAboveIndice)];
    bandwidth = Fd(lastAboveIndice) - Fd(firstAboveIndice);
elseif (~isempty(indicesGap))
    filterType = 'Band-Stop Filter';
    cutoffFrequency = [Fd(indicesGap(1)), Fd(indicesGap(length(indicesGap))+1)];
    bandwidth = Fd(indicesGap(length(indicesGap))+1) - Fd(indicesGap(1));
end
            
disp('');
disp(['Filter type is "', filterType,'".']);
disp(['The 3 dB cutoff frequency is ', num2str(cutoffFrequency)]);
disp(['3dB bandwidth of the filter is ', num2str(bandwidth), '(Hz)']);

end

