function varargout = FR_servo(varargin)
% FR_SERVO M-file for FR_servo.fig
%      FR_SERVO, by itself, creates a new FR_SERVO or raises the existing
%      singleton*.
%
%      H = FR_SERVO returns the handle to a new FR_SERVO or the handle to
%      the existing singleton*.
%
%      FR_SERVO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FR_SERVO.M with the given input arguments.
%
%      FR_SERVO('Property','Value',...) creates a new FR_SERVO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FR_servo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FR_servo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FR_servo

% Last Modified by GUIDE v2.5 09-Jun-2009 09:31:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FR_servo_OpeningFcn, ...
                   'gui_OutputFcn',  @FR_servo_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT




% --- Executes just before FR_servo is made visible.
function FR_servo_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for FR_servo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global g_File_dirPath
global g_File_path g_File_path_chk
global Fs PM GM lim_x_s lim_x_e
global flag_filter s_num bw_start
global fig_all fig_close fig_open
g_File_dirPath = '';
g_File_path = '';
g_File_path_chk = 0;
set(handles.text_open_file, 'String', 'File Name');
flag_filter = 1;
set(handles.filter_on, 'Value', 1);
fig_all = 1;
fig_close = 0;
fig_open = 0;
set(handles.radio_all, 'Value', 1);

str_fs = get(handles.edit_fs, 'String');
Fs = str2double(str_fs);
str_xs = get(handles.edit_x_s, 'String');
lim_x_s = str2double(str_xs);
str_xe = get(handles.edit_x_e, 'String');
lim_x_e = str2double(str_xe);

samp_num = get(handles.edit_samp_num, 'String');
s_num = str2double(samp_num);

bw_s = get(handles.edit_bw_s, 'String');
bw_start = str2double(bw_s);

clc;


% --- Outputs from this function are returned to the command line.
function varargout = FR_servo_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in open_bt.
function open_bt_Callback(hObject, eventdata, handles)

global g_File_dirPath g_File_path g_File_path_chk

if g_File_path_chk
    [FileName,PathName] = uigetfile('*.GDT','Select the GDT Tracker File',g_File_path);
    
    if PathName == 0 %if the user pressed cancelled, then we exit this callback
        return
    end
    
    g_File_path = PathName;
else
    [FileName,PathName] = uigetfile('*.GDT','Select the GDT Tracker File');
    
    if PathName == 0 %if the user pressed cancelled, then we exit this callback
        return
    end
    
    g_File_path = PathName;
    g_File_path_chk = 1;
end

if PathName == 0 %if the user pressed cancelled, then we exit this callback
    return
end

sz = size(FileName);
ch_name = upper([FileName(1,sz(1,2)-2),FileName(1,sz(1,2)-1),FileName(1,sz(1,2))]);
ck = (ch_name == 'GDT');
if ck(1,1) || ck(1,2) || ck(1,3)
    set(handles.text_open_file,'String',FileName);
    g_File_dirPath = [PathName,FileName];
else
    msgbox('파일을 잘못 선택하였습니다.','Error','error');
    set(handles.text_open_file,'String','');
end


% --- Executes on button press in open_loop_bt.
function open_loop_bt_Callback(hObject, eventdata, handles)

global g_File_dirPath Fs PM GM
global lim_x_s lim_x_e
global flag_filter s_num bw_start
global fig_all fig_close fig_open

file = load(g_File_dirPath);

in = file(:, 2);
out = file(:, 3);

s = size(in);

% FFT function
[h1 f] = freqz(out, in, s(1,1), 1/Fs*1000); % Fs(Hz)
[h2 f] = freqz(out, in-out, s(1,1), 1/Fs*1000);

dp_freq = 500 / Fs;
k = s(1,1);

% searching range setting
if (flag_filter == 1)
    % average datas
    a = s_num; % avg sample number
    k = s(1,1)/a;
    for n = 1 : k
        h_close(n) = sum(h1((a*(n-1)+1):a*n))/a;
        h_open(n) = sum(h2((a*(n-1)+1):a*n))/a;
        h_f(n) = sum(f((a*(n-1)+1):a*n))/a;
    end
    
    h1 = h_close;
    h2 = h_open;
    f = h_f;
end


% searching start & end point
if (round(lim_x_s * k / dp_freq) <= 1)
    search_start = 1;
else
    search_start = round(lim_x_s * k / dp_freq);
end
search_end = round(lim_x_e * k / dp_freq);

% Phase margin
if (20*log10(abs(h2(search_start))) > 0)
    for n = search_start : search_end
       if (20*log10(abs(h2(n))) < 0)                    
           break;
       end
    end
end

if (20*log10(abs(h2(search_start))) < 0)
    for n = search_start : search_end
       if (20*log10(abs(h2(n))) > 0)                    
           break;
       end
    end
end

w_pm_1 = dp_freq/k*20*log10(abs(h2(n-1)))/(20*log10(abs(h2(n-1))) - 20*log10(abs(h2(n))));
w_pm = f(n) + w_pm_1; % phase margin frequency

pm_1 = (angle(h2(n))*180/pi - angle(h2(n-1))*180/pi)*w_pm_1/dp_freq/k;
PM = angle(h2(n))*180/pi + pm_1 + 180; % phase margin


tmp = num2str(PM); % handle the static text
tmp2 = num2str(w_pm);
set(handles.text_pm, 'String', tmp);
set(handles.text_pm_f, 'String', tmp2);

% Gain margin
if (min(angle(h2)*180/pi) > -180)
    set(handles.text_gm, 'String', 'INF');
    set(handles.text_gm_f, 'String', 'INF');
else

    if (180/pi*angle(h2(search_start)) > -180)
        for m = search_start : search_end
            if (180/pi*angle(h2(m)) < -180)                    
                break;
            end
        end
    end
    if (180/pi*angle(h2(search_start)) < -180)
        for m = search_start : search_end
           if (180/pi*angle(h2(m)) > -180)                    
               break;
           end
        end
    end

    w_gm_1 = dp_freq/k*(angle(h2(m-1))*180/pi - 180)/(angle(h2(m-1))*180/pi - angle(h2(m))*180/pi);
    w_gm = f(m) + w_gm_1; % gain margin frequency
    
    gm_1 = (20*log10(abs(h2(m))) - 20*log10(abs(h2(m-1))))*w_gm_1/dp_freq/k;
    GM = 20*log10(abs(h2(m))) + gm_1; % gain margin
    
    tmp3 = num2str(GM); % handle the static text
    tmp4 = num2str(w_gm);
    set(handles.text_gm, 'String', tmp3);
    set(handles.text_gm_f, 'String', tmp4);
end

% Margin peak
Mp_ini = max(20*log10(abs(h1(search_start:search_end))));
for n = search_start : search_end
    if (20*log10(abs(h1(n))) == Mp_ini)
        Mp_f = n;
        break;
    end
end


Mp_w = f(Mp_f); % Mp frequency

Mp_ini = num2str(Mp_ini); % handle the static text
Mp_w = num2str(Mp_w);
set(handles.text_mp, 'String', Mp_ini);
set(handles.text_mp_f, 'String', Mp_w);

% -3dB 
% if (20*log10(abs(h1(round(bw_start*k/dp_freq)))) > -3)
%     for n = round(bw_start*k/dp_freq) : search_end % searching after 50Hz
    for n = Mp_f : search_end
       if (20*log10(abs(h1(n))) < -3)                    
           break;
       end
    end
% end

% if (20*log10(abs(h1(round(bw_start*k/dp_freq)))) < -3)
%     for n = round(bw_start*k/dp_freq) : search_end % searching after 50Hz
%        if (20*log10(abs(h1(n))) > -3)                    
%            break;
%        end
%     end
% end

dB_n = n;

dB_1 = dp_freq/k + dp_freq/k*(20*log10(abs(h1(n)))+3)/(20*log10(abs(h1(n-1)) - 20*log10(abs(h1(n)))));
dB_f = f(n) + dB_1; % -3dB frequency

% figure(1); % -3dB plot
% subplot(2,1,1); semilogx(f(dB_n), 20*log10(abs(h1(dB_n))), 'og'); grid on; hold on;
% text(f(dB_n), 20*log10(abs(h1(dB_n))), '\leftarrow BW', 'FontSize', 12, 'FontWeight', 'Bold');

dB_f = num2str(dB_f); % handle the static text
set(handles.text_db, 'String', '-3');
set(handles.text_db_f, 'String', dB_f);


% Natural Frequency
ini = min(20*log10(abs(h1(search_start:dB_n))));
for n = search_start : dB_n
    if (20*log10(abs(h1(n))) == ini)
        N_f = n;
        break;
    end
end

Nf = f(N_f); % Natural frequency

ini = num2str(ini); % handle the static text
Nf = num2str(Nf); 
set(handles.text_nf, 'String', ini);
set(handles.text_nf_f, 'String', Nf);

% Natural frequency candidates
y1 = 20*log10(abs(h1(search_start:search_end)));
[aa bb cc dd] = extrema(y1);


% Plot the figures
if (fig_all == 1)
    figure('name', 'Closed loop');
    subplot(2,1,1); semilogx(f, 20*log10(abs(h1)), 'b'); grid on; hold on;
    subplot(2,1,1); semilogx(f(Mp_f), 20*log10(abs(h1(Mp_f))), '*k'); 
    text(f(Mp_f), 20*log10(abs(h1(Mp_f))), ['\leftarrow Mp(dB) = ', num2str(Mp_ini)], 'FontSize', 12, 'FontWeight', 'Bold');
    subplot(2,1,1); semilogx(f(dB_n), 20*log10(abs(h1(dB_n))), 'og'); 
    text(f(dB_n), 20*log10(abs(h1(dB_n))), ['\leftarrow BW[Hz] = ', num2str(dB_f)], 'FontSize', 12, 'FontWeight', 'Bold');
    subplot(2,1,1); semilogx(f(N_f), 20*log10(abs(h1(N_f))), '*r'); grid on; hold on;
    text(f(N_f), 20*log10(abs(h1(N_f))), ['\leftarrow NF[Hz] = ', num2str(Nf)], 'FontSize', 12, 'FontWeight', 'Bold');
%     subplot(2,1,1); semilogx(f(dd), cc, 'm*'); % Natural frequency candidates
    ylabel('Magnitude(dB)');title('Closed loop Bode Plot');
    xlim([lim_x_s lim_x_e]);
    subplot(2,1,2); semilogx(f, 180/pi*angle(h1), 'b'); grid on; 
    xlabel('Frequency(Hz)'); ylabel('Phase(degree)');
    xlim([lim_x_s lim_x_e]); ylim([-180 180]);

    figure('name', 'Open loop');
    subplot(2,1,1); semilogx(f, 20*log10(abs(h2)), 'b'); grid on; 
    ylabel('Magnitude(dB)'); title('Open loop Bode Plot');
    xlim([lim_x_s lim_x_e]);
    subplot(2,1,2); semilogx(f, 180/pi*angle(h2), 'b'); grid on; 
    xlabel('Frequency(Hz)'); ylabel('Phase(degree)');
    xlim([lim_x_s lim_x_e]); ylim([-180 180]);
end
if (fig_close == 1)
    figure('name', 'Closed loop');
    subplot(2,1,1); semilogx(f, 20*log10(abs(h1)), 'b'); grid on; hold on;
    subplot(2,1,1); semilogx(f(Mp_f), 20*log10(abs(h1(Mp_f))), '*k'); 
    text(f(Mp_f), 20*log10(abs(h1(Mp_f))), ['\leftarrow Mp(dB) = ', num2str(Mp_ini)], 'FontSize', 12, 'FontWeight', 'Bold');
    subplot(2,1,1); semilogx(f(dB_n), 20*log10(abs(h1(dB_n))), 'og'); 
    text(f(dB_n), 20*log10(abs(h1(dB_n))), '\leftarrow BW', 'FontSize', 12, 'FontWeight', 'Bold');
    subplot(2,1,1); semilogx(f(N_f), 20*log10(abs(h1(N_f))), '*r'); grid on; hold on;
    text(f(N_f), 20*log10(abs(h1(N_f))), ['\leftarrow NF[Hz] = ', num2str(Nf)], 'FontSize', 12, 'FontWeight', 'Bold');
%     subplot(2,1,1); semilogx(f(dd), cc, 'm*'); % Natural frequency candidates
    ylabel('Magnitude(dB)');title('Closed loop Bode Plot');
    xlim([lim_x_s lim_x_e]);
    subplot(2,1,2); semilogx(f, 180/pi*angle(h1), 'b'); grid on; 
    xlabel('Frequency(Hz)'); ylabel('Phase(degree)');
    xlim([lim_x_s lim_x_e]); ylim([-180 180]);
end
if (fig_open == 1)
    figure('name', 'Open loop');
    subplot(2,1,1); semilogx(f, 20*log10(abs(h2)), 'b'); grid on; 
    ylabel('Magnitude(dB)'); title('Open loop Bode Plot');
    xlim([lim_x_s lim_x_e]);
    subplot(2,1,2); semilogx(f, 180/pi*angle(h2), 'b'); grid on; 
    xlabel('Frequency(Hz)'); ylabel('Phase(degree)');
    xlim([lim_x_s lim_x_e]); ylim([-180 180]);
end



function edit_fs_Callback(hObject, eventdata, handles)

global Fs

str = get(hObject, 'String');
Fs = str2double(str);


% --- Executes during object creation, after setting all properties.
function edit_fs_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_x_s_Callback(hObject, eventdata, handles)

global lim_x_s

str = get(hObject, 'String');
lim_x_s = str2double(str);


% --- Executes during object creation, after setting all properties.
function edit_x_s_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_x_e_Callback(hObject, eventdata, handles)

global lim_x_e

str = get(hObject, 'String');
lim_x_e = str2double(str);

% --- Executes during object creation, after setting all properties.
function edit_x_e_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in filter_on.
function filter_on_Callback(hObject, eventdata, handles)

global flag_filter

flag_filter = get(hObject, 'Value');


function edit_samp_num_Callback(hObject, eventdata, handles)

global s_num

s_num = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function edit_samp_num_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_bw_s_Callback(hObject, eventdata, handles)

global bw_start

bw_start = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function edit_bw_s_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radio_all.
function radio_all_Callback(hObject, eventdata, handles)

global fig_all

fig_all = get(hObject, 'Value');

% --- Executes on button press in radio_close.
function radio_close_Callback(hObject, eventdata, handles)

global fig_close

fig_close = get(hObject, 'Value');


% --- Executes on button press in radio_open.
function radio_open_Callback(hObject, eventdata, handles)

global fig_open

fig_open = get(hObject, 'Value');




