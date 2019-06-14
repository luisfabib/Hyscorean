function varargout = Hyscorean_GraphicalSettings(varargin)
%==========================================================================
% Hyscorean Graphical Settings 
%==========================================================================
% This function collects all callbacks and function for the graphicsl
% settings GUI to work. This GUI enables the user to choose different
% MATLAB graphical parameters for the different plots generated by
% Hyscorean. 
%
% (see Hyscorean manual for more information)
%==========================================================================
%
% Copyright (C) 2019  Luis Fabregas, Hyscorean 2019
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License 3.0 as published by
% the Free Software Foundation.
%==========================================================================
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Hyscorean_GraphicalSettings_OpeningFcn, ...
                   'gui_OutputFcn',  @Hyscorean_GraphicalSettings_OutputFcn, ...
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
%==========================================================================

%==========================================================================
function Hyscorean_GraphicalSettings_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
warning('off','all')
Path =  fileparts(which('Hyscorean'));
jFrame=get(hObject,'javaframe');
jicon=javax.swing.ImageIcon(fullfile(Path, 'bin', 'logo.png'));
jFrame.setFigureIcon(jicon);
handles.output = hObject;
warning('on','all')
guidata(hObject, handles);

handles.output = hObject;
%Load default settings set on Hyscorean preference
GraphicalSettings = getpref('hyscorean','graphicalsettings');
handles.GraphicalSettings = GraphicalSettings;
%Set the different UI elements to their corresponding values
set(handles.Absolute,'value',handles.GraphicalSettings.Absolute);
set(handles.Imaginary,'value',handles.GraphicalSettings.Imaginary);
set(handles.Real,'value',handles.GraphicalSettings.Real);
set(handles.Colormap,'value',handles.GraphicalSettings.Colormap);
set(handles.PlotType,'value',handles.GraphicalSettings.PlotType);
set(handles.Linewidth,'string',num2str(handles.GraphicalSettings.LineWidth));
set(handles.ContourLevels,'string',num2str(handles.GraphicalSettings.Levels));
guidata(hObject, handles);
return
%==========================================================================

%==========================================================================
function varargout = Hyscorean_GraphicalSettings_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
%==========================================================================

%==========================================================================
function PlotType_Callback(hObject, eventdata, handles)
%Update graphicsl settings structure in handles
handles.GraphicalSettings.PlotType = (get(hObject,'value'));
guidata(hObject, handles);
return
%==========================================================================

%==========================================================================
function Colormap_Callback(hObject, eventdata, handles)
%Update graphicsl settings structure in handles
handles.GraphicalSettings.Colormap = (get(hObject,'value'));
List =get(hObject,'string');
handles.GraphicalSettings.ColormapName = List{handles.GraphicalSettings.Colormap};
guidata(hObject, handles);
return
%==========================================================================

%==========================================================================
function SaveButton_Callback(hObject, eventdata, handles)
%Return the current settings to Hyscorean
setappdata(0,'GraphicalSettings',handles.GraphicalSettings)
setpref('hyscorean','graphicalsettings',handles.GraphicalSettings)
close()
return
%==========================================================================

%==========================================================================
function SaveDefault_Callback(hObject, eventdata, handles)
GraphicalSettings = handles.GraphicalSettings;
choice = questdlg('These settings will be saved for further sessions. Do you want to overwrite the previous default settigns?', ...
  'Hyscorean', ...
  'Yes','No','Yes');
switch choice
  case 'Yes'
    Answer = 1;
  case 'No'
    Answer = 0;
end
if Answer
setpref('hyscorean','graphicalsettings',GraphicalSettings)
end
return
%==========================================================================

%==========================================================================
function LoadDefault_Callback(hObject, eventdata, handles)
% hObject    handle to LoadDefault (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GraphicalSettings = getpref('hyscorean','graphicalsettings');
handles.GraphicalSettings = GraphicalSettings;
set(handles.Absolute,'value',handles.GraphicalSettings.Absolute);
set(handles.Imaginary,'value',handles.GraphicalSettings.Imaginary);
set(handles.Real,'value',handles.GraphicalSettings.Real);
set(handles.Colormap,'value',handles.GraphicalSettings.Colormap);
set(handles.PlotType,'value',handles.GraphicalSettings.PlotType);
set(handles.Linewidth,'string',num2str(handles.GraphicalSettings.Linewidth));
set(handles.ContourLevels,'string',num2str(handles.GraphicalSettings.Levels));
guidata(hObject, handles);
return
%==========================================================================

%==========================================================================
function ContourLevels_Callback(hObject, eventdata, handles)
handles.GraphicalSettings.Levels = str2double(get(hObject,'string'));
guidata(hObject, handles);
%==========================================================================

%==========================================================================
function Linewidth_Callback(hObject, eventdata, handles)
handles.GraphicalSettings.LineWidth = str2double(get(hObject,'string'));
guidata(hObject, handles);
%==========================================================================

%==========================================================================
function Absolute_Callback(hObject, eventdata, handles)
handles.GraphicalSettings.Absolute = (get(hObject,'value'));
handles.GraphicalSettings.Imaginary = get(handles.Imaginary,'value');
handles.GraphicalSettings.Real = get(handles.Real,'value');
guidata(hObject, handles);
%==========================================================================

%==========================================================================
function Real_Callback(hObject, eventdata, handles)
handles.GraphicalSettings.Real = get(hObject,'value');
handles.GraphicalSettings.Absolute = get(handles.Absolute,'value');
handles.GraphicalSettings.Imaginary = get(handles.Imaginary,'value');
guidata(hObject, handles);
%==========================================================================

%==========================================================================
function Imaginary_Callback(hObject, eventdata, handles)
handles.GraphicalSettings.Imaginary = (get(hObject,'value'));
handles.GraphicalSettings.Absolute = get(handles.Absolute,'value');
handles.GraphicalSettings.Real = get(handles.Real,'value');
guidata(hObject, handles);
%==========================================================================
