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
set(handles.edit1,'string',[pathname,filename])  %设置edit1的字符内容
file=get(handles.edit1,'string');
A1=imread(file);
axes(handles.axes1);        % 将打开的图像文件显示在轴1
imagesc(A1);                %对图像进行缩放显示


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
file=get(handles.edit1,'string');    %得到图像的文件名和路径
A=imread(file);
I=rgb2gray(A);        %将真彩色图像转换为灰度图像
background=imopen(I,strel('disk',15));  %图像开启运算
I2=imsubtract(I,background);            %图像减法运算
I3=imadjust(I2);                        %图像增强
level=graythresh(I3);                   %阈值设置
bw=im2bw(I3,level);                     %图像黑白转换
[labeled,numObjects]=bwlabel(bw,4);     %图像标识
pseudo_color=label2rgb(labeled,@spring,'c','shuffle');  %伪彩色标识
axes(handles.axes1);        %设置显示图像的轴
imshow(pseudo_color);
graindata=regionprops(labeled,'basic');  %设置区域属性
figure;
hist([graindata.Area],20);      %颗粒面积直方图


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
H=['可以联系QQ962296332']  %设置文本内容
helpdlg(H,'help text');          %帮助窗口


% --------------------------------------------------------------------
function gray_Callback(hObject, eventdata, handles)
% hObject    handle to gray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file=get(handles.edit1,'string');   %得到图像的文件名及路径
rgb=imread(file);                   %灰度图像转换
A=rgb2gray(rgb);                    %显示图像
colormap(gray);                     %设置色彩索引图


% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uiputfile('*.png');   %得到保存图像的文件名和路径
set(handles.edit1,'string',[pathname,filename]);  %显示保存图像的文件名和路径
A=getimage(handles.axes1);      
imwrite(A,filename,'jpg');    %将图像写入文件


% --------------------------------------------------------------------
function fft_Callback(hObject, eventdata, handles)
% hObject    handle to fft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file=get(handles.edit1,'string');   %得到图像的文件名和路径
X=imread(file);
I=rgb2gray(X);  %灰度变换
ffti=fft2(I);     %傅里叶变换
sffti=fftshift(ffti);   %平移
RR=real(sffti);   %实部
II=imag(sffti);   %虚部
A=sqrt(RR.^2+II.^2);  %距离
A=(A-min(min(A)))/(max(max(A))-min(min(A)))*255;
axes(handles.axes2);    %设置图像显示轴
imshow(A); 
colormap(hot);   %设置色彩索引图像


% --------------------------------------------------------------------
function surface_Callback(hObject, eventdata, handles)
% hObject    handle to surface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file=get(handles.edit1,'string');   %得到图像的文件名和路径
X=imread(file);
I=rgb2gray(X);  %灰度变换
P=double(I);  %数据类型转换
axes(handles.axes1);    %设置图像显示轴
surf(P);       %三维显示
colormap(hot);
shading('interp');  %插值平滑
view(45,80);       %设置视角
axes(handles.axes2);    %设置图像显示轴
imagesc(X);          %显示原始图像


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile('*.jpg');
%在图形界面打开图像文件
set(handles.edit1,'string',[pathname,filename]);
%可编辑框1中的字符设置为路径和文件名
file=get(handles.edit1,'string');
%得到可编辑框1中的字符串
I=imread(file);
%读入图像
I1=rgb2gray(I);
%灰度转化
axes(handles.axes2);    %设置图像显示轴2中
imagesc(I1);          %显示原始图像
%色彩索引图像为灰色
colormap(gray)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile('*.jpg');
%在图形界面打开图像文件
set(handles.edit2,'string',[pathname,filename]);
%可编辑框1中的字符设置为路径和文件名
file=get(handles.edit2,'string');
%得到可编辑框1中的字符串
I2=imread(file);
%读入图像
I3=rgb2gray(I2);
%灰度转化
axes(handles.axes3);    %设置图像显示轴3中
imagesc(I3);          %显示原始图像
%色彩索引图像为灰色
colormap(gray);


% --------------------------------------------------------------------
function fuse_Callback(hObject, eventdata, handles)
% hObject    handle to fuse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file=get(handles.edit1,'string');   %得到图像的文件名和路径
I=imread(file);
I1=rgb2gray(I);
file=get(handles.edit2,'string');
I2=imread(file);
I3=rgb2gray(I2);
XFUS=wfusimg(I1,I3,'sym4',5,'max','max');  %对I1和I3进行图像融合
axes(handles.axes1);    %将融合图像显示在轴1中
imagesc(XFUS);  
colormap(gray);        %色彩索引图为灰色
