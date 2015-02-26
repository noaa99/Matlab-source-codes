function varargout = Serial_Robot_Tracker(varargin)
% SERIAL_ROBOT_TRACKER M-file for Serial_Robot_Tracker.fig
%      SERIAL_ROBOT_TRACKER, by itself, creates a new SERIAL_ROBOT_TRACKER or raises the existing
%      singleton*.
%
%      H = SERIAL_ROBOT_TRACKER returns the handle to a new SERIAL_ROBOT_TRACKER or the handle to
%      the existing singleton*.
%
%      SERIAL_ROBOT_TRACKER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SERIAL_ROBOT_TRACKER.M with the given input arguments.
%
%      SERIAL_ROBOT_TRACKER('Property','Value',...) creates a new SERIAL_ROBOT_TRACKER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Serial_Robot_Tracker_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Serial_Robot_Tracker_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Serial_Robot_Tracker

% Last Modified by GUIDE v2.5 10-Sep-2009 19:42:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Serial_Robot_Tracker_OpeningFcn, ...
                   'gui_OutputFcn',  @Serial_Robot_Tracker_OutputFcn, ...
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


% --- Executes just before Serial_Robot_Tracker is made visible.
function Serial_Robot_Tracker_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for Serial_Robot_Tracker
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Input file global variables
global g_File_dirPath
global g_File_path g_File_path_chk
g_File_dirPath = '';
g_File_path = '';
g_File_path_chk = 0;
set(handles.text_step_point, 'String', 'File Name');

global g_File_2_dirPath
global g_File_2_path g_File_2_path_chk
g_File_2_dirPath = '';
g_File_2_path = '';
g_File_2_path_chk = 0;
set(handles.text_default, 'String', 'File Name');

global g_File_3_dirPath
global g_File_3_path g_File_3_path_chk
g_File_3_dirPath = '';
g_File_3_path = '';
g_File_3_path_chk = 0;
set(handles.text_case_1, 'String', 'File Name');

global g_File_4_dirPath
global g_File_4_path g_File_4_path_chk
g_File_4_dirPath = '';
g_File_4_path = '';
g_File_4_path_chk = 0;
set(handles.text_case_2, 'String', 'File Name');

global g_File_5_dirPath
global g_File_5_path g_File_5_path_chk
g_File_5_dirPath = '';
g_File_5_path = '';
g_File_5_path_chk = 0;
set(handles.text21, 'String', 'File Name');

global g_File_6_dirPath
global g_File_6_path g_File_6_path_chk
g_File_6_dirPath = '';
g_File_6_path = '';
g_File_6_path_chk = 0;
set(handles.text22, 'String', 'File Name');

set(handles.edit_legend_1,'String','');
set(handles.edit_legend_2,'String','');
set(handles.edit_legend_3,'String','');
set(handles.edit_legend_4,'String','');
set(handles.edit_legend_5,'String','');
set(handles.edit_legend_6,'String','');


global g_hold_1 g_hold_2 g_hold_3 g_hold_4
global g_hold_5 g_hold_6 
g_hold_1 = 0; g_hold_2 = 0; g_hold_3 = 0; g_hold_4 = 0;
g_hold_5 = 0; g_hold_6 = 0; 

global L1 L2 L3 L4 L5 L6 
L1 = 'step1'; L2 = 'step2'; L3 = 'case1';
L4 = 'case2'; L5 = 'case3'; L6 = 'case6';
clc;

% --- Outputs from this function are returned to the command line.
function varargout = Serial_Robot_Tracker_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in step_point_file_bt.
function step_point_file_bt_Callback(hObject, eventdata, handles)

global g_File_dirPath g_File_path g_File_path_chk

if g_File_path_chk
    [FileName,PathName] = uigetfile('*.txt','Select the TXT Tracker File',g_File_path);
    
    if PathName == 0 %if the user pressed cancelled, then we exit this callback
        return
    end
    
    g_File_path = PathName;
else
    [FileName,PathName] = uigetfile('*.txt','Select the TXT Tracker File');
    
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
ck = (ch_name == 'TXT');
if ck(1,1) || ck(1,2) || ck(1,3)
    set(handles.text_step_point,'String',FileName);
    g_File_dirPath = [PathName,FileName];
else
    msgbox('파일을 잘못 선택하였습니다.','Error','error');
    set(handles.text_step_point,'String','');
end

% --- Executes on button press in default_file_bt.
function default_file_bt_Callback(hObject, eventdata, handles)

global g_File_2_dirPath g_File_2_path g_File_2_path_chk

if g_File_2_path_chk
    [FileName,PathName] = uigetfile('*.txt','Select the TXT Tracker File',g_File_2_path);
    
    if PathName == 0 %if the user pressed cancelled, then we exit this callback
        return
    end
    
    g_File_2_path = PathName;
else
    [FileName,PathName] = uigetfile('*.txt','Select the TXT Tracker File');
    
    if PathName == 0 %if the user pressed cancelled, then we exit this callback
        return
    end
    
    g_File_2_path = PathName;
    g_File_2_path_chk = 1;
end

if PathName == 0 %if the user pressed cancelled, then we exit this callback
    return
end

sz = size(FileName);
ch_name = upper([FileName(1,sz(1,2)-2),FileName(1,sz(1,2)-1),FileName(1,sz(1,2))]);
ck = (ch_name == 'TXT');
if ck(1,1) || ck(1,2) || ck(1,3)
    set(handles.text_default,'String',FileName);
    g_File_2_dirPath = [PathName,FileName];
else
    msgbox('파일을 잘못 선택하였습니다.','Error','error');
    set(handles.text_default,'String','');
end


% --- Executes on button press in bt_case_1.
function bt_case_1_Callback(hObject, eventdata, handles)

global g_File_3_dirPath g_File_3_path g_File_3_path_chk

if g_File_3_path_chk
    [FileName,PathName] = uigetfile('*.txt','Select the TXT Tracker File',g_File_3_path);
    
    if PathName == 0 %if the user pressed cancelled, then we exit this callback
        return
    end
    
    g_File_3_path = PathName;
else
    [FileName,PathName] = uigetfile('*.txt','Select the TXT Tracker File');
    
    if PathName == 0 %if the user pressed cancelled, then we exit this callback
        return
    end
    
    g_File_3_path = PathName;
    g_File_3_path_chk = 1;
end

if PathName == 0 %if the user pressed cancelled, then we exit this callback
    return
end

sz = size(FileName);
ch_name = upper([FileName(1,sz(1,2)-2),FileName(1,sz(1,2)-1),FileName(1,sz(1,2))]);
ck = (ch_name == 'TXT');
if ck(1,1) || ck(1,2) || ck(1,3)
    set(handles.text_case_1,'String',FileName);
    g_File_3_dirPath = [PathName,FileName];
else
    msgbox('파일을 잘못 선택하였습니다.','Error','error');
    set(handles.text_case_1,'String','');
end

% --- Executes on button press in bt_case_2.
function bt_case_2_Callback(hObject, eventdata, handles)

global g_File_4_dirPath
global g_File_4_path g_File_4_path_chk

if g_File_4_path_chk
    [FileName,PathName] = uigetfile('*.txt','Select the TXT Tracker File',g_File_4_path);
    
    if PathName == 0 %if the user pressed cancelled, then we exit this callback
        return
    end
    
    g_File_4_path = PathName;
else
    [FileName,PathName] = uigetfile('*.txt','Select the TXT Tracker File');
    
    if PathName == 0 %if the user pressed cancelled, then we exit this callback
        return
    end
    
    g_File_4_path = PathName;
    g_File_4_path_chk = 1;
end

if PathName == 0 %if the user pressed cancelled, then we exit this callback
    return
end

sz = size(FileName);
ch_name = upper([FileName(1,sz(1,2)-2),FileName(1,sz(1,2)-1),FileName(1,sz(1,2))]);
ck = (ch_name == 'TXT');
if ck(1,1) || ck(1,2) || ck(1,3)
    set(handles.text_case_2,'String',FileName);
    g_File_4_dirPath = [PathName,FileName];
else
    msgbox('파일을 잘못 선택하였습니다.','Error','error');
    set(handles.text_case_2,'String','');
end

% --- Executes on button press in bt_case_3.
function bt_case_3_Callback(hObject, eventdata, handles)

global g_File_5_dirPath
global g_File_5_path g_File_5_path_chk

if g_File_5_path_chk
    [FileName,PathName] = uigetfile('*.txt','Select the TXT Tracker File',g_File_5_path);
    
    if PathName == 0 %if the user pressed cancelled, then we exit this callback
        return
    end
    
    g_File_5_path = PathName;
else
    [FileName,PathName] = uigetfile('*.txt','Select the TXT Tracker File');
    
    if PathName == 0 %if the user pressed cancelled, then we exit this callback
        return
    end
    
    g_File_5_path = PathName;
    g_File_5_path_chk = 1;
end

if PathName == 0 %if the user pressed cancelled, then we exit this callback
    return
end

sz = size(FileName);
ch_name = upper([FileName(1,sz(1,2)-2),FileName(1,sz(1,2)-1),FileName(1,sz(1,2))]);
ck = (ch_name == 'TXT');
if ck(1,1) || ck(1,2) || ck(1,3)
    set(handles.text21,'String',FileName);
    g_File_5_dirPath = [PathName,FileName];
else
    msgbox('파일을 잘못 선택하였습니다.','Error','error');
    set(handles.text21,'String','');
end


% --- Executes on button press in bt_case_4.
function bt_case_4_Callback(hObject, eventdata, handles)

global g_File_6_dirPath
global g_File_6_path g_File_6_path_chk

if g_File_6_path_chk
    [FileName,PathName] = uigetfile('*.txt','Select the TXT Tracker File',g_File_6_path);
    
    if PathName == 0 %if the user pressed cancelled, then we exit this callback
        return
    end
    
    g_File_6_path = PathName;
else
    [FileName,PathName] = uigetfile('*.txt','Select the TXT Tracker File');
    
    if PathName == 0 %if the user pressed cancelled, then we exit this callback
        return
    end
    
    g_File_6_path = PathName;
    g_File_6_path_chk = 1;
end

if PathName == 0 %if the user pressed cancelled, then we exit this callback
    return
end

sz = size(FileName);
ch_name = upper([FileName(1,sz(1,2)-2),FileName(1,sz(1,2)-1),FileName(1,sz(1,2))]);
ck = (ch_name == 'TXT');
if ck(1,1) || ck(1,2) || ck(1,3)
    set(handles.text22,'String',FileName);
    g_File_6_dirPath = [PathName,FileName];
else
    msgbox('파일을 잘못 선택하였습니다.','Error','error');
    set(handles.text22,'String','');
end


% --- Executes on button press in bt_case_5.
function bt_case_5_Callback(hObject, eventdata, handles)
global g_File_7_dirPath
global g_File_7_path g_File_7_path_chk

if g_File_7_path_chk
    [FileName,PathName] = uigetfile('*.txt','Select the TXT Tracker File',g_File_7_path);
    
    if PathName == 0 %if the user pressed cancelled, then we exit this callback
        return
    end
    
    g_File_7_path = PathName;
else
    [FileName,PathName] = uigetfile('*.txt','Select the TXT Tracker File');
    
    if PathName == 0 %if the user pressed cancelled, then we exit this callback
        return
    end
    
    g_File_7_path = PathName;
    g_File_7_path_chk = 1;
end

if PathName == 0 %if the user pressed cancelled, then we exit this callback
    return
end

sz = size(FileName);
ch_name = upper([FileName(1,sz(1,2)-2),FileName(1,sz(1,2)-1),FileName(1,sz(1,2))]);
ck = (ch_name == 'TXT');
if ck(1,1) || ck(1,2) || ck(1,3)
    set(handles.text23,'String',FileName);
    g_File_7_dirPath = [PathName,FileName];
else
    msgbox('파일을 잘못 선택하였습니다.','Error','error');
    set(handles.text23,'String','');
end


% --- Executes on button press in bt_case_6.
function bt_case_6_Callback(hObject, eventdata, handles)
global g_File_8_dirPath
global g_File_8_path g_File_8_path_chk

if g_File_8_path_chk
    [FileName,PathName] = uigetfile('*.txt','Select the TXT Tracker File',g_File_8_path);
    
    if PathName == 0 %if the user pressed cancelled, then we exit this callback
        return
    end
    
    g_File_8_path = PathName;
else
    [FileName,PathName] = uigetfile('*.txt','Select the TXT Tracker File');
    
    if PathName == 0 %if the user pressed cancelled, then we exit this callback
        return
    end
    
    g_File_8_path = PathName;
    g_File_8_path_chk = 1;
end

if PathName == 0 %if the user pressed cancelled, then we exit this callback
    return
end

sz = size(FileName);
ch_name = upper([FileName(1,sz(1,2)-2),FileName(1,sz(1,2)-1),FileName(1,sz(1,2))]);
ck = (ch_name == 'TXT');
if ck(1,1) || ck(1,2) || ck(1,3)
    set(handles.text24,'String',FileName);
    g_File_8_dirPath = [PathName,FileName];
else
    msgbox('파일을 잘못 선택하였습니다.','Error','error');
    set(handles.text24,'String','');
end

% --- Executes on button press in bt_plot_1.
function bt_plot_1_Callback(hObject, eventdata, handles)

global g_hold_1

if (g_hold_1 == 1)
    g_hold_1 = 0;
    tmp1 = 'OFF';
else if (g_hold_1 == 0)
        g_hold_1 = 1;
        tmp1 = 'ON';
    end
end

set(handles.text_plot_1, 'String', tmp1);



% --- Executes on button press in bt_plot_2.
function bt_plot_2_Callback(hObject, eventdata, handles)

global g_hold_2

if (g_hold_2 == 1)
    g_hold_2 = 0;
    tmp2 = 'OFF';
else if (g_hold_2 == 0)
        g_hold_2 = 1;
        tmp2 = 'ON';
    end
end

set(handles.text_plot_2,'String', tmp2);

% --- Executes on button press in bt_plot_3.
function bt_plot_3_Callback(hObject, eventdata, handles)

global g_hold_3

if (g_hold_3 == 1)
    g_hold_3 = 0;
    tmp3 = 'OFF';
else if (g_hold_3 == 0)
        g_hold_3 = 1;
        tmp3 = 'ON';
    end
end

set(handles.text_plot_3,'String', tmp3);

% --- Executes on button press in bt_plot_4.
function bt_plot_4_Callback(hObject, eventdata, handles)

global g_hold_4

if (g_hold_4 == 1)
    g_hold_4 = 0;
    tmp4 = 'OFF';
else if (g_hold_4 == 0)
        g_hold_4 = 1;
        tmp4 = 'ON';
    end
end

set(handles.text_plot_4,'String', tmp4);

% --- Executes on button press in bt_plot_5.
function bt_plot_5_Callback(hObject, eventdata, handles)
global g_hold_5

if (g_hold_5 == 1)
    g_hold_5 = 0;
    tmp5 = 'OFF';
else if (g_hold_5 == 0)
        g_hold_5 = 1;
        tmp5 = 'ON';
    end
end

set(handles.text_plot_5,'String', tmp5);

% --- Executes on button press in bt_plot_6.
function bt_plot_6_Callback(hObject, eventdata, handles)
global g_hold_6

if (g_hold_6 == 1)
    g_hold_6 = 0;
    tmp6 = 'OFF';
else if (g_hold_6 == 0)
        g_hold_6 = 1;
        tmp6 = 'ON';
    end
end

set(handles.text_plot_6,'String', tmp6);


function plot_xy_Callback(hObject, eventdata, handles)

global g_File_dirPath g_File_2_dirPath g_File_3_dirPath g_File_4_dirPath
global g_File_path_chk g_File_2_path_chk g_File_3_path_chk g_File_4_path_chk
global g_File_5_dirPath g_File_6_dirPath 
global g_File_5_path_chk g_File_6_path_chk 

global g_hold_1 g_hold_2 g_hold_3 g_hold_4
global g_hold_5 g_hold_6 
global L1 L2 L3 L4 L5 L6 

fig_num = 1;
fig_name = 'XY Plane';
tmp = figure(fig_num);
if (tmp == 1)
    close figure 1;
end


if g_File_path_chk == 1
    file_1 = load(g_File_dirPath);
    if (g_hold_1 == 1)
        initial = [100; file_1(1, 2); file_1(1, 3); file_1(1, 4)];
        fig_num = tracker_plot(file_1, 'xy', fig_name, initial, 1, g_hold_1, 'b', fig_num);
%         leg_1 = L1;
    end
end
if g_File_2_path_chk == 1
    file_2 = load(g_File_2_dirPath);
    if (g_hold_2 == 1)
        initial = [100; file_2(1, 2); file_2(1, 3); file_2(1, 4)];
        fig_num = tracker_plot(file_2, 'xy', fig_name, initial, 1, g_hold_1, 'r', fig_num);
%         leg_2 = L2;
     end
end
if g_File_3_path_chk == 1
    file_3 = load(g_File_3_dirPath);
    if (g_hold_3 == 1)
        initial = [100; file_3(1, 2); file_3(1, 3); file_3(1, 4)];
        fig_num = tracker_plot(file_3, 'xy', fig_name, initial, 0, g_hold_3, 'k', fig_num);
%         leg_3 = L3;
    end
end
if g_File_4_path_chk == 1
    file_4 = load(g_File_4_dirPath);
    if (g_hold_4 == 1)
        initial = [100; file_4(1, 2); file_4(1, 3); file_4(1, 4)];
        fig_num = tracker_plot(file_4, 'xy', fig_name, initial, 0, g_hold_4, 'g', fig_num);
%         leg_4 = L4;
    end
end
if g_File_5_path_chk == 1
    file_5 = load(g_File_5_dirPath);
    if (g_hold_5 == 1)
        initial = [100; file_5(1, 2); file_5(1, 3); file_5(1, 4)];
        fig_num = tracker_plot(file_5, 'xy', fig_name, initial, 0, g_hold_5, 'm', fig_num);
%         leg_5 = L5;
    end
end
if g_File_6_path_chk == 1
    file_6 = load(g_File_6_dirPath);
    if (g_hold_6 == 1)
        initial = [100; file_6(1, 2); file_6(1, 3); file_6(1, 4)];
        fig_num = tracker_plot(file_6, 'xy', fig_name, initial, 0, g_hold_6, 'y', fig_num);
%         leg_6 = L6;
    end
end
xlabel('X-Axis(mm)'); ylabel('Y-Axis(mm)'); title('XY Plane');
my_legend(g_hold_1, g_hold_2, g_hold_3, g_hold_4, g_hold_5, g_hold_6, L1, L2, L3, L4, L5, L6);





% --- Executes on button press in plot_yz.
function plot_yz_Callback(hObject, eventdata, handles)
global g_File_dirPath g_File_2_dirPath g_File_3_dirPath g_File_4_dirPath
global g_File_path_chk g_File_2_path_chk g_File_3_path_chk g_File_4_path_chk
global g_File_5_dirPath g_File_6_dirPath 
global g_File_5_path_chk g_File_6_path_chk 

global g_hold_1 g_hold_2 g_hold_3 g_hold_4
global g_hold_5 g_hold_6 
global L1 L2 L3 L4 L5 L6 

fig_num = 2;
fig_name = 'YZ Plane';
tmp = figure(fig_num);
if (tmp == 2)
    close figure 2;
end


if g_File_path_chk == 1
    file_1 = load(g_File_dirPath);
    if (g_hold_1 == 1)
        initial = [100; file_1(1, 2); file_1(1, 3); file_1(1, 4)];
        fig_num = tracker_plot(file_1, 'yz', fig_name, initial, 1, g_hold_1, 'b', fig_num);
%         leg_1 = L1;
    end
end
if g_File_2_path_chk == 1
    file_2 = load(g_File_2_dirPath);
    if (g_hold_2 == 1)
        initial = [100; file_2(1, 2); file_2(1, 3); file_2(1, 4)];
        fig_num = tracker_plot(file_2, 'yz', fig_name, initial, 1, g_hold_1, 'r', fig_num);
%         leg_2 = L2;
     end
end
if g_File_3_path_chk == 1
    file_3 = load(g_File_3_dirPath);
    if (g_hold_3 == 1)
        initial = [100; file_3(1, 2); file_3(1, 3); file_3(1, 4)];
        fig_num = tracker_plot(file_3, 'yz', fig_name, initial, 0, g_hold_3, 'k', fig_num);
%         leg_3 = L3;
    end
end
if g_File_4_path_chk == 1
    file_4 = load(g_File_4_dirPath);
    if (g_hold_4 == 1)
        initial = [100; file_4(1, 2); file_4(1, 3); file_4(1, 4)];
        fig_num = tracker_plot(file_4, 'yz', fig_name, initial, 0, g_hold_4, 'g', fig_num);
%         leg_4 = L4;
    end
end
if g_File_5_path_chk == 1
    file_5 = load(g_File_5_dirPath);
    if (g_hold_5 == 1)
        initial = [100; file_5(1, 2); file_5(1, 3); file_5(1, 4)];
        fig_num = tracker_plot(file_5, 'yz', fig_name, initial, 0, g_hold_5, 'm', fig_num);
%         leg_5 = L5;
    end
end
if g_File_6_path_chk == 1
    file_6 = load(g_File_6_dirPath);
    if (g_hold_6 == 1)
        initial = [100; file_6(1, 2); file_6(1, 3); file_6(1, 4)];
        fig_num = tracker_plot(file_6, 'yz', fig_name, initial, 0, g_hold_6, 'y', fig_num);
%         leg_6 = L6;
    end
end
xlabel('Y-Axis(mm)'); ylabel('Z-Axis(mm)'); title('YZ Plane');
my_legend(g_hold_1, g_hold_2, g_hold_3, g_hold_4, g_hold_5, g_hold_6, L1, L2, L3, L4, L5, L6);


% --- Executes on button press in plot_xz.
function plot_xz_Callback(hObject, eventdata, handles)

global g_File_dirPath g_File_2_dirPath g_File_3_dirPath g_File_4_dirPath
global g_File_path_chk g_File_2_path_chk g_File_3_path_chk g_File_4_path_chk
global g_File_5_dirPath g_File_6_dirPath 
global g_File_5_path_chk g_File_6_path_chk 

global g_hold_1 g_hold_2 g_hold_3 g_hold_4
global g_hold_5 g_hold_6 
global L1 L2 L3 L4 L5 L6 

fig_num = 3;
fig_name = 'XZ Plane';
tmp = figure(fig_num);
if (tmp == 3)
    close figure 3;
end


if g_File_path_chk == 1
    file_1 = load(g_File_dirPath);
    if (g_hold_1 == 1)
        initial = [100; file_1(1, 2); file_1(1, 3); file_1(1, 4)];
        fig_num = tracker_plot(file_1, 'xz', fig_name, initial, 1, g_hold_1, 'b', fig_num);
%         leg_1 = L1;
    end
end
if g_File_2_path_chk == 1
    file_2 = load(g_File_2_dirPath);
    if (g_hold_2 == 1)
        initial = [100; file_2(1, 2); file_2(1, 3); file_2(1, 4)];
        fig_num = tracker_plot(file_2, 'xz', fig_name, initial, 1, g_hold_1, 'r', fig_num);
%         leg_2 = L2;
     end
end
if g_File_3_path_chk == 1
    file_3 = load(g_File_3_dirPath);
    if (g_hold_3 == 1)
        initial = [100; file_3(1, 2); file_3(1, 3); file_3(1, 4)];
        fig_num = tracker_plot(file_3, 'xz', fig_name, initial, 0, g_hold_3, 'k', fig_num);
%         leg_3 = L3;
    end
end
if g_File_4_path_chk == 1
    file_4 = load(g_File_4_dirPath);
    if (g_hold_4 == 1)
        initial = [100; file_4(1, 2); file_4(1, 3); file_4(1, 4)];
        fig_num = tracker_plot(file_4, 'xz', fig_name, initial, 0, g_hold_4, 'g', fig_num);
%         leg_4 = L4;
    end
end
if g_File_5_path_chk == 1
    file_5 = load(g_File_5_dirPath);
    if (g_hold_5 == 1)
        initial = [100; file_5(1, 2); file_5(1, 3); file_5(1, 4)];
        fig_num = tracker_plot(file_5, 'xz', fig_name, initial, 0, g_hold_5, 'm', fig_num);
%         leg_5 = L5;
    end
end
if g_File_6_path_chk == 1
    file_6 = load(g_File_6_dirPath);
    if (g_hold_6 == 1)
        initial = [100; file_6(1, 2); file_6(1, 3); file_6(1, 4)];
        fig_num = tracker_plot(file_6, 'xz', fig_name, initial, 0, g_hold_6, 'y', fig_num);
%         leg_6 = L6;
    end
end
xlabel('X-Axis(mm)'); ylabel('Z-Axis(mm)'); title('XZ Plane');
my_legend(g_hold_1, g_hold_2, g_hold_3, g_hold_4, g_hold_5, g_hold_6, L1, L2, L3, L4, L5, L6);


% --- Executes on button press in plot_xyz.
function plot_xyz_Callback(hObject, eventdata, handles)

global g_File_dirPath g_File_2_dirPath g_File_3_dirPath g_File_4_dirPath
global g_File_path_chk g_File_2_path_chk g_File_3_path_chk g_File_4_path_chk
global g_File_5_dirPath g_File_6_dirPath 
global g_File_5_path_chk g_File_6_path_chk 

global g_hold_1 g_hold_2 g_hold_3 g_hold_4
global g_hold_5 g_hold_6 
global L1 L2 L3 L4 L5 L6 

fig_num = 4;
fig_name = 'XYZ Plane';
tmp = figure(fig_num);
if (tmp == 4)
    close figure 4;
end


if g_File_path_chk == 1
    file_1 = load(g_File_dirPath);
    if (g_hold_1 == 1)
        initial = [100; file_1(1, 2); file_1(1, 3); file_1(1, 4)];
        fig_num = tracker_plot(file_1, '3D', fig_name, initial, 1, g_hold_1, 'b', fig_num);
%         leg_1 = L1;
    end
end
if g_File_2_path_chk == 1
    file_2 = load(g_File_2_dirPath);
    if (g_hold_2 == 1)
        initial = [100; file_2(1, 2); file_2(1, 3); file_2(1, 4)];
        fig_num = tracker_plot(file_2, '3D', fig_name, initial, 1, g_hold_1, 'r', fig_num);
%         leg_2 = L2;
     end
end
if g_File_3_path_chk == 1
    file_3 = load(g_File_3_dirPath);
    if (g_hold_3 == 1)
        initial = [100; file_3(1, 2); file_3(1, 3); file_3(1, 4)];
        fig_num = tracker_plot(file_3, '3D', fig_name, initial, 0, g_hold_3, 'k', fig_num);
%         leg_3 = L3;
    end
end
if g_File_4_path_chk == 1
    file_4 = load(g_File_4_dirPath);
    if (g_hold_4 == 1)
        initial = [100; file_4(1, 2); file_4(1, 3); file_4(1, 4)];
        fig_num = tracker_plot(file_4, '3D', fig_name, initial, 0, g_hold_4, 'g', fig_num);
%         leg_4 = L4;
    end
end
if g_File_5_path_chk == 1
    file_5 = load(g_File_5_dirPath);
    if (g_hold_5 == 1)
        initial = [100; file_5(1, 2); file_5(1, 3); file_5(1, 4)];
        fig_num = tracker_plot(file_5, '3D', fig_name, initial, 0, g_hold_5, 'm', fig_num);
%         leg_5 = L5;
    end
end
if g_File_6_path_chk == 1
    file_6 = load(g_File_6_dirPath);
    if (g_hold_6 == 1)
        initial = [100; file_6(1, 2); file_6(1, 3); file_6(1, 4)];
        fig_num = tracker_plot(file_6, '3D', fig_name, initial, 0, g_hold_6, 'y', fig_num);
%         leg_6 = L6;
    end
end
xlabel('Y-Axis(mm)'); ylabel('Y-Axis(mm)'); zlabel('Z-Axis(mm)'); title('XYZ Plane');
my_legend(g_hold_1, g_hold_2, g_hold_3, g_hold_4, g_hold_5, g_hold_6, L1, L2, L3, L4, L5, L6);

% --- Executes on button press in plot_x_bt.
function plot_x_bt_Callback(hObject, eventdata, handles)
global g_File_dirPath g_File_2_dirPath g_File_3_dirPath g_File_4_dirPath
global g_File_path_chk g_File_2_path_chk g_File_3_path_chk g_File_4_path_chk
global g_File_5_dirPath g_File_6_dirPath 
global g_File_5_path_chk g_File_6_path_chk 

global g_hold_1 g_hold_2 g_hold_3 g_hold_4
global g_hold_5 g_hold_6 
global L1 L2 L3 L4 L5 L6 

fig_num = 5;
fig_name = 'X Plane';
tmp = figure(fig_num);
if (tmp == 5)
    close figure 5;
end


if g_File_path_chk == 1
    file_1 = load(g_File_dirPath);
    if (g_hold_1 == 1)
        initial = [100; file_1(1, 2); file_1(1, 3); file_1(1, 4)];
        fig_num = tracker_plot(file_1, 'x', fig_name, initial, 1, g_hold_1, 'b', fig_num);
%         leg_1 = L1;
    end
end
if g_File_2_path_chk == 1
    file_2 = load(g_File_2_dirPath);
    if (g_hold_2 == 1)
        initial = [100; file_2(1, 2); file_2(1, 3); file_2(1, 4)];
        fig_num = tracker_plot(file_2, 'x', fig_name, initial, 1, g_hold_1, 'r', fig_num);
%         leg_2 = L2;
     end
end
if g_File_3_path_chk == 1
    file_3 = load(g_File_3_dirPath);
    if (g_hold_3 == 1)
        initial = [100; file_3(1, 2); file_3(1, 3); file_3(1, 4)];
        fig_num = tracker_plot(file_3, 'x', fig_name, initial, 0, g_hold_3, 'k', fig_num);
%         leg_3 = L3;
    end
end
if g_File_4_path_chk == 1
    file_4 = load(g_File_4_dirPath);
    if (g_hold_4 == 1)
        initial = [100; file_4(1, 2); file_4(1, 3); file_4(1, 4)];
        fig_num = tracker_plot(file_4, 'x', fig_name, initial, 0, g_hold_4, 'g', fig_num);
%         leg_4 = L4;
    end
end
if g_File_5_path_chk == 1
    file_5 = load(g_File_5_dirPath);
    if (g_hold_5 == 1)
        initial = [100; file_5(1, 2); file_5(1, 3); file_5(1, 4)];
        fig_num = tracker_plot(file_5, 'x', fig_name, initial, 0, g_hold_5, 'm', fig_num);
%         leg_5 = L5;
    end
end
if g_File_6_path_chk == 1
    file_6 = load(g_File_6_dirPath);
    if (g_hold_6 == 1)
        initial = [100; file_6(1, 2); file_6(1, 3); file_6(1, 4)];
        fig_num = tracker_plot(file_6, 'x', fig_name, initial, 0, g_hold_6, 'y', fig_num);
%         leg_6 = L6;
    end
end
xlabel('Time(sec)'); ylabel('X-Axis(mm)'); title('X Plane');
my_legend(g_hold_1, g_hold_2, g_hold_3, g_hold_4, g_hold_5, g_hold_6, L1, L2, L3, L4, L5, L6);


% --- Executes on button press in plot_y_bt.
function plot_y_bt_Callback(hObject, eventdata, handles)

global g_File_dirPath g_File_2_dirPath g_File_3_dirPath g_File_4_dirPath
global g_File_path_chk g_File_2_path_chk g_File_3_path_chk g_File_4_path_chk
global g_File_5_dirPath g_File_6_dirPath 
global g_File_5_path_chk g_File_6_path_chk 

global g_hold_1 g_hold_2 g_hold_3 g_hold_4
global g_hold_5 g_hold_6 
global L1 L2 L3 L4 L5 L6 

fig_num = 6;
fig_name = 'Y Plane';
tmp = figure(fig_num);
if (tmp == 6)
    close figure 6;
end


if g_File_path_chk == 1
    file_1 = load(g_File_dirPath);
    if (g_hold_1 == 1)
        initial = [100; file_1(1, 2); file_1(1, 3); file_1(1, 4)];
        fig_num = tracker_plot(file_1, 'y', fig_name, initial, 1, g_hold_1, 'b', fig_num);
%         leg_1 = L1;
    end
end
if g_File_2_path_chk == 1
    file_2 = load(g_File_2_dirPath);
    if (g_hold_2 == 1)
        initial = [100; file_2(1, 2); file_2(1, 3); file_2(1, 4)];
        fig_num = tracker_plot(file_2, 'y', fig_name, initial, 1, g_hold_1, 'r', fig_num);
%         leg_2 = L2;
     end
end
if g_File_3_path_chk == 1
    file_3 = load(g_File_3_dirPath);
    if (g_hold_3 == 1)
        initial = [100; file_3(1, 2); file_3(1, 3); file_3(1, 4)];
        fig_num = tracker_plot(file_3, 'y', fig_name, initial, 0, g_hold_3, 'k', fig_num);
%         leg_3 = L3;
    end
end
if g_File_4_path_chk == 1
    file_4 = load(g_File_4_dirPath);
    if (g_hold_4 == 1)
        initial = [100; file_4(1, 2); file_4(1, 3); file_4(1, 4)];
        fig_num = tracker_plot(file_4, 'y', fig_name, initial, 0, g_hold_4, 'g', fig_num);
%         leg_4 = L4;
    end
end
if g_File_5_path_chk == 1
    file_5 = load(g_File_5_dirPath);
    if (g_hold_5 == 1)
        initial = [100; file_5(1, 2); file_5(1, 3); file_5(1, 4)];
        fig_num = tracker_plot(file_5, 'y', fig_name, initial, 0, g_hold_5, 'm', fig_num);
%         leg_5 = L5;
    end
end
if g_File_6_path_chk == 1
    file_6 = load(g_File_6_dirPath);
    if (g_hold_6 == 1)
        initial = [100; file_6(1, 2); file_6(1, 3); file_6(1, 4)];
        fig_num = tracker_plot(file_6, 'y', fig_name, initial, 0, g_hold_6, 'y', fig_num);
%         leg_6 = L6;
    end
end
xlabel('Time(sec)'); ylabel('Y-Axis(mm)'); title('Y Plane');
my_legend(g_hold_1, g_hold_2, g_hold_3, g_hold_4, g_hold_5, g_hold_6, L1, L2, L3, L4, L5, L6);

% --- Executes on button press in plot_z_bt.
function plot_z_bt_Callback(hObject, eventdata, handles)

global g_File_dirPath g_File_2_dirPath g_File_3_dirPath g_File_4_dirPath
global g_File_path_chk g_File_2_path_chk g_File_3_path_chk g_File_4_path_chk
global g_File_5_dirPath g_File_6_dirPath 
global g_File_5_path_chk g_File_6_path_chk 

global g_hold_1 g_hold_2 g_hold_3 g_hold_4
global g_hold_5 g_hold_6 
global L1 L2 L3 L4 L5 L6 

fig_num = 7;
fig_name = 'Z Plane';
tmp = figure(fig_num);
if (tmp == 7)
    close figure 7;
end


if g_File_path_chk == 1
    file_1 = load(g_File_dirPath);
    if (g_hold_1 == 1)
        initial = [100; file_1(1, 2); file_1(1, 3); file_1(1, 4)];
        fig_num = tracker_plot(file_1, 'z', fig_name, initial, 1, g_hold_1, 'b', fig_num);
%         leg_1 = L1;
    end
end
if g_File_2_path_chk == 1
    file_2 = load(g_File_2_dirPath);
    if (g_hold_2 == 1)
        initial = [100; file_2(1, 2); file_2(1, 3); file_2(1, 4)];
        fig_num = tracker_plot(file_2, 'z', fig_name, initial, 1, g_hold_1, 'r', fig_num);
%         leg_2 = L2;
     end
end
if g_File_3_path_chk == 1
    file_3 = load(g_File_3_dirPath);
    if (g_hold_3 == 1)
        initial = [100; file_3(1, 2); file_3(1, 3); file_3(1, 4)];
        fig_num = tracker_plot(file_3, 'z', fig_name, initial, 0, g_hold_3, 'k', fig_num);
%         leg_3 = L3;
    end
end
if g_File_4_path_chk == 1
    file_4 = load(g_File_4_dirPath);
    if (g_hold_4 == 1)
        initial = [100; file_4(1, 2); file_4(1, 3); file_4(1, 4)];
        fig_num = tracker_plot(file_4, 'z', fig_name, initial, 0, g_hold_4, 'g', fig_num);
%         leg_4 = L4;
    end
end
if g_File_5_path_chk == 1
    file_5 = load(g_File_5_dirPath);
    if (g_hold_5 == 1)
        initial = [100; file_5(1, 2); file_5(1, 3); file_5(1, 4)];
        fig_num = tracker_plot(file_5, 'z', fig_name, initial, 0, g_hold_5, 'm', fig_num);
%         leg_5 = L5;
    end
end
if g_File_6_path_chk == 1
    file_6 = load(g_File_6_dirPath);
    if (g_hold_6 == 1)
        initial = [100; file_6(1, 2); file_6(1, 3); file_6(1, 4)];
        fig_num = tracker_plot(file_6, 'z', fig_name, initial, 0, g_hold_6, 'y', fig_num);
%         leg_6 = L6;
    end
end
xlabel('Time(sec)'); ylabel('Z-Axis(mm)'); title('Z Plane');
my_legend(g_hold_1, g_hold_2, g_hold_3, g_hold_4, g_hold_5, g_hold_6, L1, L2, L3, L4, L5, L6);


function edit_legend_1_Callback(hObject, eventdata, handles)

global L1

L1 = get(hObject, 'String');

% --- Executes during object creation, after setting all properties.
function edit_legend_1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_legend_2_Callback(hObject, eventdata, handles)

global L2

L2 = get(hObject, 'String');

% --- Executes during object creation, after setting all properties.
function edit_legend_2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_legend_3_Callback(hObject, eventdata, handles)

global L3

L3 = get(hObject, 'String');

% --- Executes during object creation, after setting all properties.
function edit_legend_3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_legend_4_Callback(hObject, eventdata, handles)

global L4

L4 = get(hObject, 'String');

% --- Executes during object creation, after setting all properties.
function edit_legend_4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_legend_5_Callback(hObject, eventdata, handles)

global L5

L5 = get(hObject, 'String');


% --- Executes during object creation, after setting all properties.
function edit_legend_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_legend_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_legend_6_Callback(hObject, eventdata, handles)

global L6

L6 = get(hObject, 'String');

% --- Executes during object creation, after setting all properties.
function edit_legend_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_legend_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_legend_7_Callback(hObject, eventdata, handles)

global L7

L7 = get(hObject, 'String');


% --- Executes during object creation, after setting all properties.
function edit_legend_7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_legend_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_legend_8_Callback(hObject, eventdata, handles)

global L8

L8 = get(hObject, 'String');


% --- Executes during object creation, after setting all properties.
function edit_legend_8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_legend_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over plot_xy.
function plot_xy_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to plot_xy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


