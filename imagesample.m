function varargout = imagesample(varargin)
% IMAGESAMPLE MATLAB code for imagesample.fig
%      IMAGESAMPLE, by itself, creates a new IMAGESAMPLE or raises the existing
%      singleton*.
%
%      H = IMAGESAMPLE returns the handle to a new IMAGESAMPLE or the handle to
%      the existing singleton*.
%
%      IMAGESAMPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGESAMPLE.M with the given input arguments.
%
%      IMAGESAMPLE('Property','Value',...) creates a new IMAGESAMPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before imagesample_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to imagesample_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help imagesample

% Last Modified by GUIDE v2.5 14-Nov-2012 16:45:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imagesample_OpeningFcn, ...
                   'gui_OutputFcn',  @imagesample_OutputFcn, ...
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


% --- Executes just before imagesample is made visible.
function imagesample_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to imagesample (see VARARGIN)

% Choose default command line output for imagesample
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes imagesample wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = imagesample_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%


% --------------------------------------------------------------------
function open_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile('car.png')
set(handles.edit1,'string',[pathname,filename])  %����edit1���ַ�����
file=get(handles.edit1,'string');
A1=imread(file);
axes(handles.axes1);        % ���򿪵�ͼ���ļ���ʾ����1
imagesc(A1);                %��ͼ�����������ʾ


% --------------------------------------------------------------------
function edit_Callback(hObject, eventdata, handles)
% hObject    handle to edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function grains_Callback(hObject, eventdata, handles)
% hObject    handle to grains (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file=get(handles.edit1,'string');    %�õ�ͼ����ļ�����·��
A=imread(file);
I=rgb2gray(A);        %�����ɫͼ��ת��Ϊ�Ҷ�ͼ��
background=imopen(I,strel('disk',15));  %ͼ��������
I2=imsubtract(I,background);            %ͼ���������
I3=imadjust(I2);                        %ͼ����ǿ
level=graythresh(I3);                   %��ֵ����
bw=im2bw(I3,level);                     %ͼ��ڰ�ת��
[labeled,numObjects]=bwlabel(bw,4);     %ͼ���ʶ
pseudo_color=label2rgb(labeled,@spring,'c','shuffle');  %α��ɫ��ʶ
axes(handles.axes1);        %������ʾͼ�����
imshow(pseudo_color);
graindata=regionprops(labeled,'basic');  %������������
figure;
hist([graindata.Area],20);      %�������ֱ��ͼ


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function about_Callback(hObject, eventdata, handles)
% hObject    handle to about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
H=['������ϵQQ962296332']  %�����ı�����
helpdlg(H,'help text');          %��������


% --------------------------------------------------------------------
function gray_Callback(hObject, eventdata, handles)
% hObject    handle to gray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file=get(handles.edit1,'string');   %�õ�ͼ����ļ�����·��
rgb=imread(file);                   %�Ҷ�ͼ��ת��
A=rgb2gray(rgb);                    %��ʾͼ��
colormap(gray);                     %����ɫ������ͼ


% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uiputfile('*.png');   %�õ�����ͼ����ļ�����·��
set(handles.edit1,'string',[pathname,filename]);  %��ʾ����ͼ����ļ�����·��
A=getimage(handles.axes1);      
imwrite(A,filename,'jpg');    %��ͼ��д���ļ�


% --------------------------------------------------------------------
function fft_Callback(hObject, eventdata, handles)
% hObject    handle to fft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file=get(handles.edit1,'string');   %�õ�ͼ����ļ�����·��
X=imread(file);
I=rgb2gray(X);  %�Ҷȱ任
ffti=fft2(I);     %����Ҷ�任
sffti=fftshift(ffti);   %ƽ��
RR=real(sffti);   %ʵ��
II=imag(sffti);   %�鲿
A=sqrt(RR.^2+II.^2);  %����
A=(A-min(min(A)))/(max(max(A))-min(min(A)))*255;
axes(handles.axes2);    %����ͼ����ʾ��
imshow(A); 
colormap(hot);   %����ɫ������ͼ��


% --------------------------------------------------------------------
function surface_Callback(hObject, eventdata, handles)
% hObject    handle to surface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file=get(handles.edit1,'string');   %�õ�ͼ����ļ�����·��
X=imread(file);
I=rgb2gray(X);  %�Ҷȱ任
P=double(I);  %��������ת��
axes(handles.axes1);    %����ͼ����ʾ��
surf(P);       %��ά��ʾ
colormap(hot);
shading('interp');  %��ֵƽ��
view(45,80);       %�����ӽ�
axes(handles.axes2);    %����ͼ����ʾ��
imagesc(X);          %��ʾԭʼͼ��


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile('*.jpg');
%��ͼ�ν����ͼ���ļ�
set(handles.edit1,'string',[pathname,filename]);
%�ɱ༭��1�е��ַ�����Ϊ·�����ļ���
file=get(handles.edit1,'string');
%�õ��ɱ༭��1�е��ַ���
I=imread(file);
%����ͼ��
I1=rgb2gray(I);
%�Ҷ�ת��
axes(handles.axes2);    %����ͼ����ʾ��2��
imagesc(I1);          %��ʾԭʼͼ��
%ɫ������ͼ��Ϊ��ɫ
colormap(gray)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile('*.jpg');
%��ͼ�ν����ͼ���ļ�
set(handles.edit2,'string',[pathname,filename]);
%�ɱ༭��1�е��ַ�����Ϊ·�����ļ���
file=get(handles.edit2,'string');
%�õ��ɱ༭��1�е��ַ���
I2=imread(file);
%����ͼ��
I3=rgb2gray(I2);
%�Ҷ�ת��
axes(handles.axes3);    %����ͼ����ʾ��3��
imagesc(I3);          %��ʾԭʼͼ��
%ɫ������ͼ��Ϊ��ɫ
colormap(gray);


% --------------------------------------------------------------------
function fuse_Callback(hObject, eventdata, handles)
% hObject    handle to fuse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file=get(handles.edit1,'string');   %�õ�ͼ����ļ�����·��
I=imread(file);
I1=rgb2gray(I);
file=get(handles.edit2,'string');
I2=imread(file);
I3=rgb2gray(I2);
XFUS=wfusimg(I1,I3,'sym4',5,'max','max');  %��I1��I3����ͼ���ں�
axes(handles.axes1);    %���ں�ͼ����ʾ����1��
imagesc(XFUS);  
colormap(gray);        %ɫ������ͼΪ��ɫ
