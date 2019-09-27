function varargout = GamblingMachine(varargin)
% GAMBLINGMACHINE MATLAB code for GamblingMachine.fig
%      GAMBLINGMACHINE, by itself, creates a new GAMBLINGMACHINE or raises the existing
%      singleton*.
%
%      H = GAMBLINGMACHINE returns the handle to a new GAMBLINGMACHINE or the handle to
%      the existing singleton*.
%
%      GAMBLINGMACHINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GAMBLINGMACHINE.M with the given input arguments.
%
%      GAMBLINGMACHINE('Property','Value',...) creates a new GAMBLINGMACHINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GamblingMachine_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GamblingMachine_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GamblingMachine

% Last Modified by GUIDE v2.5 29-Aug-2019 10:50:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GamblingMachine_OpeningFcn, ...
                   'gui_OutputFcn',  @GamblingMachine_OutputFcn, ...
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


% --- Executes just before GamblingMachine is made visible.
function GamblingMachine_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GamblingMachine (see VARARGIN)

% Choose default command line output for GamblingMachine
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GamblingMachine wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GamblingMachine_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in GoButton.
function GoButton_Callback(hObject, eventdata, handles)
% hObject    handle to GoButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
go_state=get(hObject, 'Value')+get(handles.YesCheckBox, 'Value')

set(handles.StopButton1, 'Value',0)
set(handles.StopButton2, 'Value',0)
set(handles.StopButton3, 'Value',0)

Stop_Matrix=[get(handles.Slot1,'Value'),get(handles.Slot2,'Value'),get(handles.Slot3,'Value')];
while ~(get(handles.StopButton1, 'Value')&&get(handles.StopButton2, 'Value')&&get(handles.StopButton3, 'Value'))

        set(hObject, 'String', 'Rolling!!!')
        
        Stop1=get(handles.StopButton1, 'Value')
        Stop2=get(handles.StopButton2, 'Value')
        Stop3=get(handles.StopButton3, 'Value')

        if Stop_Matrix(1)==0
            S1=num2str(randi([0,9]))
            set(handles.Slot1, 'String', S1)
        end
        
        if Stop1==1
            Stop_Matrix(1)=1
        end
         
        if Stop_Matrix(2)==0    
            S2=num2str(randi([0,9]))
            set(handles.Slot2, 'String', S2)
        end
        
        if Stop2==1
            Stop_Matrix(2)=1
        end
        
        if Stop_Matrix(3)==0     
             S3=num2str(randi([0,9]))
             set(handles.Slot3, 'String', S3)
        end
        
        if Stop3==1
            Stop_Matrix(3)=1
        end
        
        Stop_Matrix
        
        pause(0)
end

switch go_state
    case 2 %%Only possible if BetLife option is chosen
     %%Calculating value of roll
     Roll_Matrix=[S1,S2,S3]
     if sum(Roll_Matrix)/3==max(Roll_Matrix)||(Roll_Matrix(1)==Roll_Matrix(2))||(Roll_Matrix(2)==Roll_Matrix(3))||(Roll_Matrix(1)==Roll_Matrix(3))
         Gain=100
         New_Balance=get(handles.BalanceText,'Value')+Gain
         set(handles.BalanceText,'Value',New_Balance)
         set(handles.BalanceText,'String',num2str(New_Balance))
         
     else
         msgbox('You have lost!!! Goodbye and try again next time!!', 'Lose Condition')
         pause(5)
         close all
     end
     
    case 1

     %%Calculating value of roll
     Roll_Matrix=[S1,S2,S3]
     if sum(Roll_Matrix)/3==max(Roll_Matrix)
         
         switch Roll_Matrix(1)
             case 7
                 Gain=str2num(get(handles.BettingText, 'String'))*100
                 New_Balance=get(handles.BalanceText,'Value')+Gain
                 set(handles.BalanceText,'Value',New_Balance)
                 set(handles.BalanceText,'String',num2str(New_Balance))
             otherwise
                 Gain=str2num(get(handles.BettingText, 'String'))*50
                 New_Balance=get(handles.BalanceText,'Value')+Gain
                 set(handles.BalanceText,'Value',New_Balance)
                 set(handles.BalanceText,'String',num2str(New_Balance))
         end
         
    elseif (Roll_Matrix(1)==Roll_Matrix(2))||(Roll_Matrix(2)==Roll_Matrix(3))
         Gain=str2num(get(handles.BettingText, 'String'))*5
         New_Balance=get(handles.BalanceText,'Value')+Gain
         set(handles.BalanceText,'Value',New_Balance)
         set(handles.BalanceText,'String',num2str(New_Balance))
         
    elseif (Roll_Matrix(1)==Roll_Matrix(3))
         Gain=str2num(get(handles.BettingText, 'String'))
         New_Balance=get(handles.BalanceText,'Value')+Gain
         set(handles.BalanceText,'Value',New_Balance)
         set(handles.BalanceText,'String',num2str(New_Balance))
         
     else
         Gain=-str2num(get(handles.BettingText, 'String'))
         New_Balance=get(handles.BalanceText,'Value')+Gain
         set(handles.BalanceText,'Value',New_Balance)
         set(handles.BalanceText,'String',num2str(New_Balance))
         
     end
     
    case 0
     set(hObject, 'String', 'PUSH 2 GO!!!')
     set(andles.Slot1, 'String', 'READY')
     set(handles.Slot2, 'String', 'SET')
     set(handles.Slot3, 'String', 'GO')
    otherwise
     set(handles.Slot1, 'String', 'ERROR')
     set(handles.Slot2, 'String', 'ERROR')
     set(handles.Slot3, 'String', 'ERROR')
end

Gain=num2str(Gain)
Str='You have Earned '
ProvokeText=insertAfter(Str, 'Earned ',Gain)
set(handles.text6, 'String', ProvokeText)


if str2num(get(handles.BalanceText,'String'))<0
    set(hObject, 'String', 'YOU LOSE!!!')
elseif str2num(get(handles.BalanceText,'String'))>999
    set(hObject, 'String', 'CONGRATS A WINNER IS YOU!!!')
end

% --- Executes on button press in YesCheckBox.
function YesCheckBox_Callback(hObject, eventdata, handles)
% hObject    handle to YesCheckBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of YesCheckBox

if get(hObject, 'Value')==1
    msgbox('Should you proceed you will gain 100 coins if you hit any of the rewards, if you loses you will be locked out','Deal')

elseif get(hObject, 'Value')==0
    msgbox('Deal Voided')
end
    
% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on slider movement.
function MoneyAdjuster_Callback(hObject, eventdata, handles)
% hObject    handle to MoneyAdjuster (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
MinValue=get(hObject, 'Min')
MaxValue=get(hObject, 'Max')*get(handles.BalanceText, 'Value')
ChosenValue=ceil(get(hObject,'Value')*MaxValue)
set(handles.BettingText, 'String', num2str(ChosenValue))

% --- Executes during object creation, after setting all properties.
function MoneyAdjuster_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MoneyAdjuster (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in StopButton1.
function StopButton1_Callback(hObject, eventdata, handles)
% hObject    handle to StopButton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in StopButton2.
function StopButton2_Callback(hObject, eventdata, handles)
% hObject    handle to StopButton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in StopButton3.
function StopButton3_Callback(hObject, eventdata, handles)
% hObject    handle to StopButton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in StopButton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to StopButton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of StopButton2


% --- Executes on button press in HelpButton.
function HelpButton_Callback(hObject, eventdata, handles)
% hObject    handle to HelpButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('This is a game where you adjust the amount of money you wish to bet. The amount of coins that you earn varies with the output you get. The game operates will you pressing the PUSH2GO!!!/Rolling!!! button followed by pressing the StopButtons# to stop the roulette. You win if get 999 coins and lose if you lost everyting. There is also a do or die option. Good Luck.', 'Help Text') 

