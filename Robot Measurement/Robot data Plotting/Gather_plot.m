function varargout = Gather_plot(varargin)
% GATHER_PLOT M-file for Gather_plot.fig
%      GATHER_PLOT, by itself, creates a new GATHER_PLOT or raises the existing
%      singleton*.
%
%      H = GATHER_PLOT returns the handle to a new GATHER_PLOT or the handle to
%      the existing singleton*.
%
%      GATHER_PLOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GATHER_PLOT.M with the given input arguments.
%
%      GATHER_PLOT('Property','Value',...) creates a new GATHER_PLOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gather_plot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gather_plot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gather_plot

% Last Modified by GUIDE v2.5 03-Jul-2009 20:27:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gather_plot_OpeningFcn, ...
                   'gui_OutputFcn',  @Gather_plot_OutputFcn, ...
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
clc;
% clear all;
% End initialization code - DO NOT EDIT


% --- Executes just before Gather_plot is made visible.
function Gather_plot_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for Gather_plot
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global g_File_dirPath
global g_File_path g_File_path_chk
g_File_dirPath = '';
g_File_path = '';
g_File_path_chk = 0;
set(handles.text1, 'String', 'File Name');

global radio1 radio2 radio3 radio4 radio5 radio6
global radio7 radio8 radio9 radio10 radio11 radio12
radio1 = 0; radio2 = 0; radio3 = 0;
radio4 = 0; radio5 = 0; radio6 = 0;
radio7 = 0; radio8 = 0; radio9 = 0;
radio10 = 0; radio11 = 0; radio12 = 0;

global uip1 uip2 uip3 uip4 uip5 uip6
global uip7 uip8 uip9 uip10 uip11 uip12
uip1 = 'Position';
uip2 = 'Position';
uip3 = 'Position';
uip4 = 'Position';
uip5 = 'Position';
uip6 = 'Position';
uip7 = 'Position';
uip8 = 'Position';
uip9 = 'Position';
uip10 = 'Position';
uip11 = 'Position';
uip12 = 'Position';

global ckb1 ckb2 ckb3 ckb4 ckb5 ckb6
ckb1 = 0; ckb2 = 0; ckb3 = 0; ckb4 = 0; ckb5 = 0; ckb6 = 0;

global samp
samp = 1;
set(handles.samp,'String','1');
set(handles.edit10, 'String', '1');




% --- Outputs from this function are returned to the command line.
function varargout = Gather_plot_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global g_File_dirPath g_File_path g_File_path_chk file file_in

if g_File_path_chk
    [FileName,PathName] = uigetfile('*.GDT','Select the GDT File',g_File_path);
    
    if PathName == 0 %if the user pressed cancelled, then we exit this callback
        return
    end
    
    g_File_path = PathName;
else
    [FileName,PathName] = uigetfile('*.GDT','Select the GDT File');
    
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
    set(handles.text1,'String',FileName);
    g_File_dirPath = [PathName,FileName];
else
    msgbox('파일을 잘못 선택하였습니다.','Error','error');
    set(handles.text1,'String','');
end

h = waitbar(0, 'Please wait...');
waitbar(30/100);
file = load(g_File_dirPath);
waitbar(60/100);
file_in = file;

% for i=1:100, % computation here %
% waitbar(i/100)
waitbar(100/100);
% end

close(h);


function samp_Callback(hObject, eventdata, handles)

global samp
samp = str2double(get(hObject, 'String'));




% --- Executes during object creation, after setting all properties.
function samp_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in radio1.
function radio1_Callback(hObject, eventdata, handles)
global radio1 file_in

s = size(file_in);

if (s(1, 2) < 2)
    msgbox('Selected column is vacant');
    set(handles.radio1, 'Value', 0);
end


radio1 = get(hObject, 'Value');


% --- Executes on button press in radio2.
function radio2_Callback(hObject, eventdata, handles)
global radio2 file_in

s = size(file_in);

if (s(1, 2) < 4)
    msgbox('Selected column is vacant');
    set(handles.radio2, 'Value', 0);
end

radio2 = get(hObject, 'Value');


% --- Executes on button press in radio3.
function radio3_Callback(hObject, eventdata, handles)
global radio3 file_in

s = size(file_in);

if (s(1, 2) < 6)
    msgbox('Selected column is vacant');
    set(handles.radio3, 'Value', 0);
end

radio3 = get(hObject, 'Value');


% --- Executes on button press in radio4.
function radio4_Callback(hObject, eventdata, handles)
global radio4 file_in

s = size(file_in);

if (s(1, 2) < 10)
    msgbox('Selected column is vacant');
    set(handles.radio4, 'Value', 0);
end

radio4 = get(hObject, 'Value');


% --- Executes on button press in radio5.
function radio5_Callback(hObject, eventdata, handles)
global radio5 file_in

s = size(file_in);

if (s(1, 2) < 12)
    msgbox('Selected column is vacant');
    set(handles.radio5, 'Value', 0);
end

radio5 = get(hObject, 'Value');


% --- Executes on button press in radio6.
function radio6_Callback(hObject, eventdata, handles)
global radio6 file_in

s = size(file_in);

if (s(1, 2) < 14)
    msgbox('Selected column is vacant');
    set(handles.radio6, 'Value', 0);
end

radio6 = get(hObject, 'Value');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global samp
global radio1 radio2 radio3 radio4 radio5 radio6
global radio7 radio8 radio9 radio10 radio11 radio12

global uip1 uip2 uip3 uip4 uip5 uip6
global uip7 uip8 uip9 uip10 uip11 uip12
global ckb1 ckb2 ckb3 ckb4 ckb5 ckb6
global file file_in

% file = load(g_File_dirPath);

b2r = 120000/(2^17);
p2v = 4;

index = file(:,1)/1000*samp;

if (radio1 == 1 && ckb1 ~= 1)
    figure('name', 'Column 2');
    if (uip1 == 'Position')
        plot(index, file(:,2)/(2^17)*360); grid on;
        ylabel('Degree'); title('Servo Encoder Position', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip1 == 'Velocity')
        plot(index, file(:,2)/p2v*b2r); grid on;
        ylabel('Rpm'); title('Servo Velocity', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip1 == 'Torque  ')
        plot(index, file(:,2)/32767*100); grid on;
        ylabel('%'); title('Torque', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip1 == 'Default ')
        plot(index, file_in(:,2)); grid on;
        title('Default ', 'fontsize', 12, 'fontweight', 'b');
    end
    xlabel('Time[sec]'); 
end

if (radio2 == 1 && ckb2 ~= 1)
    figure('name', 'Column 4');
    if (uip2 == 'Position')
        plot(index, file(:,4)/(2^17)*360); grid on;
        ylabel('Degree'); title('Servo Encoder Position', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip2 == 'Velocity')
        plot(index, file(:,4)/p2v*b2r); grid on;
        ylabel('Rpm'); title('Servo Velocity', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip2 == 'Torque  ')
        plot(index, file(:,4)/32767*100); grid on;
        ylabel('%'); title('Torque', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip2 == 'Default ')
        plot(index, file_in(:,4)); grid on;
        title('Default ', 'fontsize', 12, 'fontweight', 'b');
    end
    xlabel('Time[sec]'); 
end

if (radio3 == 1 && ckb3 ~= 1)
    figure('name', 'Column 6');
    if (uip3 == 'Position')
        plot(index, file(:,6)/(2^17)*360); grid on;
        ylabel('Degree'); title('Servo Encoder Position', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip3 == 'Velocity')
        plot(index, file(:,6)/p2v*b2r); grid on;
        ylabel('Rpm'); title('Servo Velocity', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip3 == 'Torque  ')
        plot(index, file(:,6)/32767*100); grid on;
        ylabel('%'); title('Torque', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip3 == 'Default ')
        plot(index, file_in(:,6)); grid on;
        title('Default ', 'fontsize', 12, 'fontweight', 'b');
    end
    xlabel('Time[sec]'); 
end

if (radio4 == 1 && ckb4 ~= 1)
    figure('name', 'Column 10');
    if (uip4 == 'Position')
        plot(index, file(:,10)/(2^17)*360); grid on;
        ylabel('Degree'); title('Servo Encoder Position', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip4 == 'Velocity')
        plot(index, file(:,10)/p2v*b2r); grid on;
        ylabel('Rpm'); title('Servo Velocity', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip4 == 'Torque  ')
        plot(index, file(:,10)/32767*100); grid on;
        ylabel('%'); title('Torque', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip4 == 'Default ')
        plot(index, file_in(:,10)); grid on;
        title('Default ', 'fontsize', 12, 'fontweight', 'b');
    end
    xlabel('Time[sec]'); 
end

if (radio5 == 1 && ckb5 ~= 1)
    figure('name', 'Column 12');
    if (uip5 == 'Position')
        plot(index, file(:,12)/(2^17)*360); grid on;
        ylabel('Degree'); title('Servo Encoder Position', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip5 == 'Velocity')
        plot(index, file(:,12)/p2v*b2r); grid on;
        ylabel('Rpm'); title('Servo Velocity', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip5 == 'Torque  ')
        plot(index, file(:,12)/32767*100); grid on;
        ylabel('%'); title('Torque', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip5 == 'Default ')
        plot(index, file_in(:,12)); grid on;
        title('Default ', 'fontsize', 12, 'fontweight', 'b');
    end
    xlabel('Time[sec]'); 
end

if (radio6 == 1 && ckb6 ~= 1)
    figure('name', 'Column 14');
    if (uip6 == 'Position')
        plot(index, file(:,14)/(2^17)*360); grid on;
        ylabel('Degree'); title('Servo Encoder Position', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip6 == 'Velocity')
        plot(index, file(:,14)/p2v*b2r); grid on;
        ylabel('Rpm'); title('Servo Velocity', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip6 == 'Torque  ')
        plot(index, file(:,14)/32767*100); grid on;
        ylabel('%'); title('Torque', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip6 == 'Default ')
        plot(index, file_in(:,14)); grid on;
        title('Default ', 'fontsize', 12, 'fontweight', 'b');
    end
    xlabel('Time[sec]'); 
end

if (radio7 == 1 && ckb1 ~= 1)
    figure('name', 'Column 3');
    if (uip7 == 'Position')
        plot(index, file(:,3)/(2^17)*360, 'r'); grid on;
        ylabel('Degree'); title('Servo Encoder Position', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip7 == 'Velocity')
        plot(index, file(:,3)/p2v*b2r, 'r'); grid on;
        ylabel('Rpm'); title('Servo Velocity', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip7 == 'Torque  ')
        plot(index, file(:,3)/32767*100, 'r'); grid on;
        ylabel('%'); title('Torque', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip7 == 'Default ')
        plot(index, file_in(:,3)); grid on;
        title('Default ', 'fontsize', 12, 'fontweight', 'b');
    end
    xlabel('Time[sec]'); 
end

if (radio8 == 1 && ckb2 ~= 1)
    figure('name', 'Column 5');
    if (uip8 == 'Position')
        plot(index, file(:,5)/(2^17)*360, 'r'); grid on;
        ylabel('Degree'); title('Servo Encoder Position', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip8 == 'Velocity')
        plot(index, file(:,5)/p2v*b2r, 'r'); grid on;
        ylabel('Rpm'); title('Servo Velocity', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip8 == 'Torque  ')
        plot(index, file(:,5)/32767*100, 'r'); grid on;
        ylabel('%'); title('Torque', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip8 == 'Default ')
        plot(index, file_in(:,5)); grid on;
        title('Default ', 'fontsize', 12, 'fontweight', 'b');
    end
    xlabel('Time[sec]'); 
end

if (radio9 == 1 && ckb3 ~= 1)
    figure('name', 'Column 7');
    if (uip9 == 'Position')
        plot(index, file(:,7)/(2^17)*360, 'r'); grid on;
        ylabel('Degree'); title('Servo Encoder Position', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip9 == 'Velocity')
        plot(index, file(:,7)/p2v*b2r, 'r'); grid on;
        ylabel('Rpm'); title('Servo Velocity', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip9 == 'Torque  ')
        plot(index, file(:,7)/32767*100, 'r'); grid on;
        ylabel('%'); title('Torque', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip9 == 'Default ')
        plot(index, file_in(:,7)); grid on;
        title('Default ', 'fontsize', 12, 'fontweight', 'b');
    end
    xlabel('Time[sec]'); 
end

if (radio10 == 1 && ckb4 ~= 1)
    figure('name', 'Column 11');
    if (uip10 == 'Position')
        plot(index, file(:,11)/(2^17)*360, 'r'); grid on;
        ylabel('Degree'); title('Servo Encoder Position', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip10 == 'Velocity')
        plot(index, file(:,11)/p2v*b2r, 'r'); grid on;
        ylabel('Rpm'); title('Servo Velocity', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip10 == 'Torque  ')
        plot(index, file(:,11)/32767*100, 'r'); grid on;
        ylabel('%'); title('Torque', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip10 == 'Default ')
        plot(index, file_in(:,11)); grid on;
        title('Default ', 'fontsize', 12, 'fontweight', 'b');
    end
    xlabel('Time[sec]'); 
end

if (radio11 == 1 && ckb5 ~= 1)
    figure('name', 'Column 13');
    if (uip11 == 'Position')
        plot(index, file(:,13)/(2^17)*360, 'r'); grid on;
        ylabel('Degree'); title('Servo Encoder Position', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip11 == 'Velocity')
        plot(index, file(:,13)/p2v*b2r, 'r'); grid on;
        ylabel('Rpm'); title('Servo Velocity', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip11 == 'Torque  ')
        plot(index, file(:,13)/32767*100, 'r'); grid on;
        ylabel('%'); title('Torque', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip11 == 'Default ')
        plot(index, file_in(:,13)); grid on;
        title('Default ', 'fontsize', 12, 'fontweight', 'b');
    end
    xlabel('Time[sec]'); 
end

if (radio12 == 1 && ckb6 ~= 1)
    figure('name', 'Column 15');
    if (uip12 == 'Position')
        plot(index, file(:,15)/(2^17)*360, 'r'); grid on;
        ylabel('Degree'); title('Servo Encoder Position', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip12 == 'Velocity')
        plot(index, file(:,15)/p2v*b2r, 'r'); grid on;
        ylabel('Rpm'); title('Servo Velocity', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip12 == 'Torque  ')
        plot(index, file(:,15)/32767*100, 'r'); grid on;
        ylabel('%'); title('Torque', 'fontsize', 12, 'fontweight', 'b');
    end
    if (uip12 == 'Default ')
        plot(index, file_in(:,15)); grid on;
        title('Default ', 'fontsize', 12, 'fontweight', 'b');
    end
    xlabel('Time[sec]'); 
end

if (ckb1 == 1)
    figure('name', 'Column 2 vs 3');
    if (uip1 == 'Position')
        plot(index, file(:,2)/(2^17)*360, index, file(:,3)/(2^17)*360, 'r'); grid on;
        ylabel('Degree'); title('Servo Encoder Position', 'fontsize', 12, 'fontweight', 'b');
        legend('Column2', 'Column3');
    end
    if (uip1 == 'Velocity')
        plot(index, file(:,2)/p2v*b2r, index, file(:,3)*b2r, 'r'); grid on;
        ylabel('Rpm'); title('Servo Velocity', 'fontsize', 12, 'fontweight', 'b');
        legend('Column2', 'Column3');
    end
    if (uip1 == 'Torque  ')
        plot(index, file(:,2)/32767*100, index, file(:,3)/32767*100, 'r'); grid on;
        ylabel('%'); title('Torque', 'fontsize', 12, 'fontweight', 'b');
        legend('Column2', 'Column3');
    end
    if (uip1 == 'Default ')
        plot(index, file_in(:,2), index, file_in(:,3)); grid on;
        title('Default ', 'fontsize', 12, 'fontweight', 'b');
    end
    xlabel('Time[sec]'); 
end


if (ckb2 == 1)
    figure('name', 'Column 4 vs 5');
    if (uip2 == 'Position')
        plot(index, file(:,4)/(2^17)*360, index, file(:,5)/(2^17)*360, 'r'); grid on;
        ylabel('Degree'); title('Servo Encoder Position', 'fontsize', 12, 'fontweight', 'b');
        legend('Column4', 'Column5');
    end
    if (uip2 == 'Velocity')
        plot(index, file(:,4)/p2v*b2r, index, file(:,5)*b2r, 'r'); grid on;
        ylabel('Rpm'); title('Servo Velocity', 'fontsize', 12, 'fontweight', 'b');
        legend('Column4', 'Column5');
    end
    if (uip2 == 'Torque  ')
        plot(index, file(:,4)/32767*100, index, file(:,5)/32767*100, 'r'); grid on;
        ylabel('%'); title('Torque', 'fontsize', 12, 'fontweight', 'b');
        legend('Column4', 'Column5');
    end
    if (uip2 == 'Default ')
        plot(index, file_in(:,4), index, file_in(:,5)); grid on;
        title('Default ', 'fontsize', 12, 'fontweight', 'b');
    end
    xlabel('Time[sec]'); 
end

if (ckb3 == 1)
    figure('name', 'Column 6 vs 7');
    if (uip3 == 'Position')
        plot(index, file(:,6)/(2^17)*360, index, file(:,7)/(2^17)*360, 'r'); grid on;
        ylabel('Degree'); title('Servo Encoder Position', 'fontsize', 12, 'fontweight', 'b');
        legend('Column6', 'Column7');
    end
    if (uip3 == 'Velocity')
        plot(index, file(:,6)/p2v*b2r, index, file(:,7)*b2r, 'r'); grid on;
        ylabel('Rpm'); title('Servo Velocity', 'fontsize', 12, 'fontweight', 'b');
        legend('Column6', 'Column7');
    end
    if (uip3 == 'Torque  ')
        plot(index, file(:,6)/32767*100, index, file(:,7)/32767*100, 'r'); grid on;
        ylabel('%'); title('Torque', 'fontsize', 12, 'fontweight', 'b');
        legend('Column6', 'Column7');
    end
    if (uip3 == 'Default ')
        plot(index, file_in(:,6), index, file_in(:,7)); grid on;
        title('Default ', 'fontsize', 12, 'fontweight', 'b');
    end
    xlabel('Time[sec]'); 
end

if (ckb4 == 1)
    figure('name', 'Column 10 vs 11');
    if (uip4 == 'Position')
        plot(index, file(:,10)/(2^17)*360, index, file(:,11)/(2^17)*360, 'r'); grid on;
        ylabel('Degree'); title('Servo Encoder Position', 'fontsize', 12, 'fontweight', 'b');
        legend('Column10', 'Column11');
    end
    if (uip4 == 'Velocity')
        plot(index, file(:,10)/p2v*b2r, index, file(:,11)*b2r, 'r'); grid on;
        ylabel('Rpm'); title('Servo Velocity', 'fontsize', 12, 'fontweight', 'b');
        legend('Column10', 'Column11');
    end
    if (uip4 == 'Torque  ')
        plot(index, file(:,10)/32767*100, index, file(:,11)/32767*100, 'r'); grid on;
        ylabel('%'); title('Torque', 'fontsize', 12, 'fontweight', 'b');
        legend('Column10', 'Column11');
    end
    if (uip4 == 'Default ')
        plot(index, file_in(:,10), index, file_in(:,11)); grid on;
        title('Default ', 'fontsize', 12, 'fontweight', 'b');
    end
    xlabel('Time[sec]'); 
end

if (ckb5 == 1)
    figure('name', 'Column 12 vs 13');
    if (uip5 == 'Position')
        plot(index, file(:,12)/(2^17)*360, index, file(:,13)/(2^17)*360, 'r'); grid on;
        ylabel('Degree'); title('Servo Encoder Position', 'fontsize', 12, 'fontweight', 'b');
        legend('Column12', 'Column13');
    end
    if (uip5 == 'Velocity')
        plot(index, file(:,12)/p2v*b2r, index, file(:,13)*b2r, 'r'); grid on;
        ylabel('Rpm'); title('Servo Velocity', 'fontsize', 12, 'fontweight', 'b');
        legend('Column12', 'Column13');
    end
    if (uip5 == 'Torque  ')
        plot(index, file(:,12)/32767*100, index, file(:,13)/32767*100, 'r'); grid on;
        ylabel('%'); title('Torque', 'fontsize', 12, 'fontweight', 'b');
        legend('Column12', 'Column13');
    end
    if (uip5 == 'Default ')
        plot(index, file_in(:,12), index, file_in(:,13)); grid on;
        title('Default ', 'fontsize', 12, 'fontweight', 'b');
    end
    xlabel('Time[sec]'); 
end

if (ckb6 == 1)
    figure('name', 'Column 14 vs 15');
    if (uip6 == 'Position')
        plot(index, file(:,14)/(2^17)*360, index, file(:,15)/(2^17)*360, 'r'); grid on;
        ylabel('Degree'); title('Servo Encoder Position', 'fontsize', 12, 'fontweight', 'b');
        legend('Column14', 'Column15');
    end
    if (uip6 == 'Velocity')
        plot(index, file(:,14)/p2v*b2r, index, file(:,15)*b2r, 'r'); grid on;
        ylabel('Rpm'); title('Servo Velocity', 'fontsize', 12, 'fontweight', 'b');
        legend('Column14', 'Column15');
    end
    if (uip6 == 'Torque  ')
        plot(index, file(:,14)/32767*100, index, file(:,15)/32767*100, 'r'); grid on;
        ylabel('%'); title('Torque', 'fontsize', 12, 'fontweight', 'b');
        legend('Column14', 'Column15');
    end
    if (uip6 == 'Default ')
        plot(index, file_in(:,14), index, file_in(:,15)); grid on;
        title('Default ', 'fontsize', 12, 'fontweight', 'b');
    end
    xlabel('Time[sec]'); 
end


% --- Executes when selected object is changed in uipanel4.
function uipanel4_SelectionChangeFcn(hObject, eventdata, handles)
global uip1

uip1 = get(eventdata.NewValue,'string');

% --- Executes when selected object is changed in uipanel9.
function uipanel9_SelectionChangeFcn(hObject, eventdata, handles)
global uip6

uip6 = get(eventdata.NewValue,'string');


% --- Executes when selected object is changed in uipanel5.
function uipanel5_SelectionChangeFcn(hObject, eventdata, handles)
global uip2

uip2 = get(eventdata.NewValue,'string');


% --- Executes when selected object is changed in uipanel6.
function uipanel6_SelectionChangeFcn(hObject, eventdata, handles)
global uip3

uip3 = get(eventdata.NewValue,'string');


% --- Executes when selected object is changed in uipanel7.
function uipanel7_SelectionChangeFcn(hObject, eventdata, handles)
global uip4

uip4 = get(eventdata.NewValue,'string');


% --- Executes when selected object is changed in uipanel8.
function uipanel8_SelectionChangeFcn(hObject, eventdata, handles)
global uip5

uip5 = get(eventdata.NewValue,'string');


% --- Executes on button press in radiobutton56.
function radiobutton56_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton56 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton56


% --- Executes when selected object is changed in uipanel17.
function uipanel17_SelectionChangeFcn(hObject, eventdata, handles)
global uip7

uip7 = get(eventdata.NewValue,'string');



% --- Executes when selected object is changed in uipanel18.
function uipanel18_SelectionChangeFcn(hObject, eventdata, handles)
global uip8

uip8 = get(eventdata.NewValue,'string');



% --- Executes when selected object is changed in uipanel19.
function uipanel19_SelectionChangeFcn(hObject, eventdata, handles)
global uip9

uip9 = get(eventdata.NewValue,'string');



% --- Executes when selected object is changed in uipanel20.
function uipanel20_SelectionChangeFcn(hObject, eventdata, handles)
global uip10

uip10 = get(eventdata.NewValue,'string');


% --- Executes when selected object is changed in uipanel21.
function uipanel21_SelectionChangeFcn(hObject, eventdata, handles)
global uip11

uip11 = get(eventdata.NewValue,'string');



% --- Executes when selected object is changed in uipanel22.
function uipanel22_SelectionChangeFcn(hObject, eventdata, handles)
global uip12

uip12 = get(eventdata.NewValue,'string');


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
global ckb1 file_in
global radio1 radio7 uip1 uip7

s = size(file_in);

if (s(1, 2) < 3)
    msgbox('The component of column 2 or 3 is vacant');
    set(handles.checkbox1, 'Value', 0);
end


ckb1 = get(hObject, 'Value');

if (ckb1 == 1)
    if (radio1 ~= 1 || radio7 ~= 1)
        msgbox('Please check the column 2 & 3');
        set(handles.radio1,'Value', 1);
        set(handles.radiobutton75,'Value', 1);
    end
    if (uip1(1) ~= uip7(1))
        msgbox('Please set the same component at the column 2 & 3');
        uip7 = uip1;
    end
end



% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
global ckb2 file_in
global radio2 radio8 uip2 uip8

s = size(file_in);

if (s(1, 2) < 5)
    msgbox('The component of column 4 or 5 is vacant');
    set(handles.checkbox2, 'Value', 0);
end

ckb2 = get(hObject, 'Value');

if (ckb2 == 1)
    if (radio2 ~= 1 || radio8 ~= 1)
        msgbox('Please check the column 4 & 5');
        set(handles.radio2,'Value', 1);
        set(handles.radiobutton76,'Value', 1);
    end
    if (uip2 ~= uip8)
        msgbox('Please set the same component at the column 4 & 5');
        uip8 = uip2;
    end
end

% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
global ckb3 file_in
global radio3 radio9 uip3 uip9

s = size(file_in);

if (s(1, 2) < 7)
    msgbox('The component of column 6 or 7 is vacant');
    set(handles.checkbox3, 'Value', 0);
end

ckb3 = get(hObject, 'Value');
if (ckb3 == 1)
    if (radio3 ~= 1 || radio9 ~= 1)
        msgbox('Please check the column 6 & 7');
        set(handles.radio3,'Value', 1);
        set(handles.radiobutton77,'Value', 1);
    end
    if (uip3 ~= uip9)
        msgbox('Please set the same component at the column 6 & 7');
        uip9 = uip3;
    end
end

% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
global ckb4 file_in
global radio4 radio10 uip4 uip10

s = size(file_in);

if (s(1, 2) < 11)
    msgbox('The component of column 10 or 11 is vacant');
    set(handles.checkbox4, 'Value', 0);
end

ckb4 = get(hObject, 'Value');
if (ckb4 == 1)
    if (radio4 ~= 1 || radio10 ~= 1)
        msgbox('Please check the column 10 & 11');
        set(handles.radio4,'Value', 1);
        set(handles.radiobutton78,'Value', 1);
    end
    if (uip4 ~= uip10)
        msgbox('Please set the same component at the column 10 & 11');
        uip10 = uip4;
    end
end

% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
global ckb5 file_in
global radio5 radio11 uip5 uip11

s = size(file_in);

if (s(1, 2) < 13)
    msgbox('The component of column 12 or 13 is vacant');
    set(handles.checkbox5, 'Value', 0);
end

ckb5 = get(hObject, 'Value');
if (ckb5 == 1)
    if (radio5 ~= 1 || radio11 ~= 1)
        msgbox('Please check the column 12 & 13');
        set(handles.radio5,'Value', 1);
        set(handles.radiobutton79,'Value', 1);
    end
    if (uip5 ~= uip11)
        msgbox('Please set the same component at the column 12 & 13');
        uip11 = uip5;
    end
end

% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
global ckb6 file_in
global radio6 radio12 uip6 uip12

s = size(file_in);

if (s(1, 2) < 15)
    msgbox('The component of column 14 or 15 is vacant');
    set(handles.checkbox6, 'Value', 0);
end

ckb6 = get(hObject, 'Value');
if (ckb6 == 1)
    if (radio6 ~= 1 || radio12 ~= 1)
        msgbox('Please check the column 14 & 15');
        set(handles.radio6,'Value', 1);
        set(handles.radiobutton80,'Value', 1);
    end
    if (uip6 ~= uip12)
        msgbox('Please set the same component at the column 14 & 15');
        uip12 = uip6;
    end
end

% --- Executes on button press in radiobutton75.
function radiobutton75_Callback(hObject, eventdata, handles)
global radio7 file_in

s = size(file_in);

if (s(1, 2) < 3)
    msgbox('Selected column is vacant');
    set(handles.radiobutton75, 'Value', 0);
end

radio7 = get(hObject, 'Value');


% --- Executes on button press in radiobutton76.
function radiobutton76_Callback(hObject, eventdata, handles)
global radio8 file_in

s = size(file_in);

if (s(1, 2) < 5)
    msgbox('Selected column is vacant');
    set(handles.radiobutton76, 'Value', 0);
end

radio8 = get(hObject, 'Value');


% --- Executes on button press in radiobutton77.
function radiobutton77_Callback(hObject, eventdata, handles)
global radio9 file_in

s = size(file_in);

if (s(1, 2) < 7)
    msgbox('Selected column is vacant');
    set(handles.radiobutton77, 'Value', 0);
end

radio9 = get(hObject, 'Value');


% --- Executes on button press in radiobutton78.
function radiobutton78_Callback(hObject, eventdata, handles)
global radio10 file_in

s = size(file_in);

if (s(1, 2) < 11)
    msgbox('Selected column is vacant');
    set(handles.radiobutton78, 'Value', 0);
end

radio10 = get(hObject, 'Value');


% --- Executes on button press in radiobutton79.
function radiobutton79_Callback(hObject, eventdata, handles)
global radio11 file_in

s = size(file_in);

if (s(1, 2) < 13)
    msgbox('Selected column is vacant');
    set(handles.radiobutton79, 'Value', 0);
end

radio11 = get(hObject, 'Value');


% --- Executes on button press in radiobutton80.
function radiobutton80_Callback(hObject, eventdata, handles)
global radio12 file_in

s = size(file_in);

if (s(1, 2) < 15)
    msgbox('Selected column is vacant');
    set(handles.radiobutton80, 'Value', 0);
end

radio12 = get(hObject, 'Value');



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
global val

val = str2double(get(hObject, 'String'));

% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
global oper

oper = get(hObject, 'Value');
% str = get(hObject, 'String'); 
% oper1 = str(oper); 


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject, 'string', {'product', 'plus', 'minus', 'divide'});

% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
global col file_in

col = get(hObject, 'Value');

s = size(file_in);

if (col <= 6)
    if (s(1,2) < col+1)
        msgbox('Selected column is vacant');
    end
end
if (col >= 7)
    if (s(1,2) < col+3)
        msgbox('Selected column is vacant');
    end
end


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject, 'string', {'2', '3', '4', '5', '6', '7', '10', '11', '12', '13', '14', '15'});

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global col oper val file_in

switch oper
    case 1
        if (col >= 1 && col <= 6)
            file_in(:,col+1) = file_in(:, col+1)*val;
        end
        if (col >= 7 && col <= 12)
            file_in(:,col+3) = file_in(:, col+3)*val;
        end
    case 2
        if (col >= 1 && col <= 6)
            file_in(:,col+1) = file_in(:, col+1)+val;
        end
        if (col >= 7 && col <= 12)
            file_in(:,col+3) = file_in(:, col+3)+val;
        end
    case 3
        if (col >= 1 && col <= 6)
            file_in(:,col+1) = file_in(:, col+1)-val;
        end
        if (col >= 7 && col <= 12)
            file_in(:,col+3) = file_in(:, col+3)-val;
        end
    case 4
        if (val == 0)
            msgbox('You cannot divide by zero');
        end
        if (col >= 1 && col <= 6)
            file_in(:,col+1) = file_in(:, col+1)/val;
        end
        if (col >= 7 && col <= 12)
            file_in(:,col+3) = file_in(:, col+3)/val;
        end
end

if (col == 1)
    set(handles.text9, 'String', val);
    if (oper == 1)
        set(handles.text28, 'String', 'X');
    end
    if (oper == 2)
        set(handles.text28, 'String', '+');
    end
    if (oper == 3)
        set(handles.text28, 'String', '-');
    end
    if (oper == 4)
        set(handles.text28, 'String', '/');
    end
end

if (col == 2)
    set(handles.text10, 'String', val);
    if (oper == 1)
        set(handles.text31, 'String', 'X');
    end
    if (oper == 2)
        set(handles.text31, 'String', '+');
    end
    if (oper == 3)
        set(handles.text31, 'String', '-');
    end
    if (oper == 4)
        set(handles.text31, 'String', '/');
    end
end

if (col == 3)
    set(handles.text11, 'String', val);
    if (oper == 1)
        set(handles.text26, 'String', 'X');
    end
    if (oper == 2)
        set(handles.text26, 'String', '+');
    end
    if (oper == 3)
        set(handles.text26, 'String', '-');
    end
    if (oper == 4)
        set(handles.text26, 'String', '/');
    end
end

if (col == 4)
    set(handles.text12, 'String', val);
    if (oper == 1)
        set(handles.text29, 'String', 'X');
    end
    if (oper == 2)
        set(handles.text29, 'String', '+');
    end
    if (oper == 3)
        set(handles.text29, 'String', '-');
    end
    if (oper == 4)
        set(handles.text29, 'String', '/');
    end
end
if (col == 5)
    set(handles.text13, 'String', val);
    if (oper == 1)
        set(handles.text27, 'String', 'X');
    end
    if (oper == 2)
        set(handles.text27, 'String', '+');
    end
    if (oper == 3)
        set(handles.text27, 'String', '-');
    end
    if (oper == 4)
        set(handles.text27, 'String', '/');
    end
end
if (col == 6)
    set(handles.text14, 'String', val);
    if (oper == 1)
        set(handles.text30, 'String', 'X');
    end
    if (oper == 2)
        set(handles.text30, 'String', '+');
    end
    if (oper == 3)
        set(handles.text30, 'String', '-');
    end
    if (oper == 4)
        set(handles.text30, 'String', '/');
    end
end

if (col == 7)
    set(handles.text15, 'String', val);
    if (oper == 1)
        set(handles.text34, 'String', 'X');
    end
    if (oper == 2)
        set(handles.text34, 'String', '+');
    end
    if (oper == 3)
        set(handles.text34, 'String', '-');
    end
    if (oper == 4)
        set(handles.text34, 'String', '/');
    end
end
if (col == 8)
    set(handles.text18, 'String', val);
    if (oper == 1)
        set(handles.text37, 'String', 'X');
    end
    if (oper == 2)
        set(handles.text37, 'String', '+');
    end
    if (oper == 3)
        set(handles.text37, 'String', '-');
    end
    if (oper == 4)
        set(handles.text37, 'String', '/');
    end
end
if (col == 9)
    set(handles.text16, 'String', val);
    if (oper == 1)
        set(handles.text32, 'String', 'X');
    end
    if (oper == 2)
        set(handles.text32, 'String', '+');
    end
    if (oper == 3)
        set(handles.text32, 'String', '-');
    end
    if (oper == 4)
        set(handles.text32, 'String', '/');
    end
end
if (col == 10)
    set(handles.text19, 'String', val);
    if (oper == 1)
        set(handles.text35, 'String', 'X');
    end
    if (oper == 2)
        set(handles.text35, 'String', '+');
    end
    if (oper == 3)
        set(handles.text35, 'String', '-');
    end
    if (oper == 4)
        set(handles.text35, 'String', '/');
    end
end
if (col == 11)
    set(handles.text17, 'String', val);
    if (oper == 1)
        set(handles.text33, 'String', 'X');
    end
    if (oper == 2)
        set(handles.text33, 'String', '+');
    end
    if (oper == 3)
        set(handles.text33, 'String', '-');
    end
    if (oper == 4)
        set(handles.text33, 'String', '/');
    end
end
if (col == 12)
    set(handles.text20, 'String', val);
    if (oper == 1)
        set(handles.text36, 'String', 'X');
    end
    if (oper == 2)
        set(handles.text36, 'String', '+');
    end
    if (oper == 3)
        set(handles.text36, 'String', '-');
    end
    if (oper == 4)
        set(handles.text36, 'String', '/');
    end
end

% value = [value_1 value_2 value_3 value_4 value_5 value_6 value_7 value_8 value_9 value_10 value_11 value_12];
% aa=value_3;

