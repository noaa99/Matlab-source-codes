function out = DTMF_Decoder_v2(sound_sample, p_mode)
% function result = DTMF_Decoder(sound_sample);
% Lab 3 - Part 4. DTMF signal decoder
% Given a DTMF sound sample, decode the sample into the corresponding 
%   telephoen keypad character.
%
% Input parameters (arguments) are:
%     sound_sample = sound vector
%     p_mode : processing mode ( 1 : over-rap processing, 0 : does not
%     over-rap )
%
% Output values returned are:
%     result = character corresponding to tone
%
% Developed by: Hyunjong Choi and Chris Paige
% Revised: 2/2/2015
tic
% Touchpad character array
touchpad = ...
    ['1' '2' '3' 'A'; 
     '4' '5' '6' 'B';
     '7' '8' '9' 'C';
     '*' '0' '#' 'D'];
% Defined frequencies     
row_freq = [941, 852, 770, 697];
col_freq = [1209, 1336, 1477, 1633];

% Define parameters
N = 800;    % Length of processing at a time
Fs = 8000;  % Sampling frequency
L = length(sound_sample);   % Length of input signal
% If the sample of input is too short, return with a message.
if L < 800
    disp(['The sample signal is too short to detect numbers']);
    out = 0;
    return;
end
 % Calculate the number of iteration based on the input signal
if p_mode == 1
    iter = floor(L/(N/2));
else
    iter = ceil(L/N);  
end
mode = zeros(1, iter);  % Initialize 'on' or 'off' buffer
% Initialize flags and counters at each mode ('on' and 'off')
on_start_flag = 0;
off_start_flag = 0;
on_count = 0;
off_count = 0;
digit_idx = 1;  % The index of final result array

% Calculate the frequencies between each row/column frequency. store for IF
% statements.
row_freq_middle = 1:3;
col_freq_middle = 1:3;
for i = 1:3
    row_freq_middle(i) = ((row_freq(i) + row_freq(i+1)) / 2);
    col_freq_middle(i) = ((col_freq(i) + col_freq(i+1)) / 2);
end
% Special case to compensate for rows '4' '5' '6' 'B', which seemed
% to use lower values that expected
row_freq_middle(3) = 715;

% Start iteration
for n = 1 : iter
    % If the iteration is the last one, the length is variable 
    if n == iter
        if p_mode == 1
            input = sound_sample(N/2*(n-1)+1: end);
        else
            input = sound_sample(N*(n-1)+1: end);
        end
    else
        % The length of processing signal at a time is always N
        if p_mode == 1
            input = sound_sample(N/2*(n-1)+1: N/2*(n+1));
        else
            input = sound_sample(N*(n-1)+1: N*n);
        end
    end
    % Detect the mode whether it is keypad pressed or not
    re = Detect_Mode(input, Fs);
    mode(n) = re.mode;
    
    % If mode is 'on', which is considered that keypad is pressed
    if mode(n)
        % Update on_count value, this could be used to calculate the period
        on_count = on_count + 1;
        
        % Take fft of sound sample from the result of 'Detect_Mode'
        fft_sample = re.mag;
        sound_length = length(fft_sample);
        
        if n ~= iter
            magnitude(:, n) = abs(fft_sample(1:1024/2+1));
        end
        if n == 1
            frequencies = re.f;
        end
        
        % Eliminate redundant, duplicated values in fft
        fft_sample_half = fft_sample(1:round(sound_length/2 - 1));
        
        % Calcuate the lower part of frequency
        hz_1100_breakpoint_loc = round((length(fft_sample_half) / 4000) * 1100);

        % Get fft samples from 0 to 1100 Hz
        fft_sample_lower = abs(fft_sample_half(1:hz_1100_breakpoint_loc));
        % Get fft samples from 1100 to 4000Hz
        fft_sample_upper = abs(fft_sample_half(hz_1100_breakpoint_loc+1:length(fft_sample_half)));

        % Get max magnitude and frequecy location from lower and upper vectors
        % Frequency is half of what it should be due to sample rate
        [max_lower_mag, max_lower_freq]  = max(fft_sample_lower);
        [max_upper_mag, max_upper_freq]  = max(fft_sample_upper);

        max_lower_freq = max_lower_freq * (1100/hz_1100_breakpoint_loc);
        max_upper_freq = 1100 + max_upper_freq * (1100/hz_1100_breakpoint_loc); %compensate for 1100Hz offset

        % Correlate max upper and lower frequency with touchpad index
        max_lower_freq_index = 0;
        max_upper_freq_index = 0;

        if(max_lower_freq <= row_freq_middle(3))
           max_lower_freq_index =  1;
        elseif(max_lower_freq <= row_freq_middle(2))
           max_lower_freq_index =  2;
        elseif(max_lower_freq <= row_freq_middle(1))
           max_lower_freq_index =  3;
        else
           max_lower_freq_index =  4;
        end

        if(max_upper_freq <= col_freq_middle(1))
           max_upper_freq_index =  1;
        elseif(max_upper_freq <= col_freq_middle(2))
           max_upper_freq_index =  2;
        elseif(max_upper_freq <= col_freq_middle(3))
           max_upper_freq_index =  3;
        else
           max_upper_freq_index =  4;
        end
        
        if p_mode == 1
            time_factor = N/Fs/2;
        else
            time_factor = N/Fs;
        end
        % If 'on' mode start for the first time
        if ~on_start_flag
            on_start_flag = 1;
            % If the mode is changed from 'off' mode to 'on' mode,
            % displaying the period of 'off' mode
            if off_start_flag
                off_start_flag = 0;
                disp(['The length of pause is ', num2str(off_count*time_factor), ' sec']);
                off_count = 0;
            end
            % Put the touchpad result into result buffer, the index always
            % should be '1' here
            result_buff(on_count) = touchpad(max_lower_freq_index, max_upper_freq_index);
        else
        % If 'on' mode continues
            % Put the touchpad result into result buffer
            result_buff(on_count) = touchpad(max_lower_freq_index, max_upper_freq_index);
            % The final result should be decided when consecutive two
            % results are the same. So it compares the previous result.
            % Two results could be 1600 samples / 8000 = 0.2 sec
            if (result_buff(on_count) == result_buff(on_count-1))
                result = result_buff(on_count);
            end
            
            % If continuous 'on' mode is the last one
            if (n == iter)
                disp(['The keypad "', num2str(result),'" pressed during ', num2str(on_count*time_factor), ' sec']);
                out(digit_idx) = result;
            end
            
        end
    else
    % If mode is 'off', which is considered that keypad is not pressed
        % Update off_count value, this could be used to calculate the period
        off_count = off_count + 1;
        
        % If 'off' mode starts from the 'on' mode
        if on_start_flag
            on_start_flag = 0;
            disp(['The keypad "', num2str(result),'" pressed during ', num2str(on_count*time_factor), ' sec']);
            out(digit_idx) = result;
            on_count = 0;
            off_start_flag = 1;
            digit_idx = digit_idx + 1;
        else
            off_start_flag = 1;
        end
    end
    % End of mode
end
% End of iteration
toc
% out.mag = magnitude;
% out.f = frequencies;

