%%%%%%%%%%%%%%%%%%%%% GUI RADIAL STRAINS CALCULATION %%%%%%%%%%%%%%%%%%%%%%%%



function varargout = CrEAP(varargin)
% CREAP MATLAB code for CrEAP.fig
%      CREAP, by itself, creates a new CREAP or raises the existing
%      singleton*.
%
%      H = CREAP returns the handle to a new CREAP or the handle to
%      the existing singleton*.
%
%      CREAP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CREAP.M with the given input arguments.
%
%      CREAP('Property','s',...) creates a new CREAP or raises the
%      existing singleton*.  Starting from the left, property s pairs are
%      applied to the GUI before CrEAP_OpeningFcn gets called.  An
%      unrecognized property name or invalid s makes property application
%      stop.  All inputs are passed to CrEAP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CrEAP

% Last Modified by GUIDE v2.5 26-Nov-2015 18:26:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CrEAP_OpeningFcn, ...
                   'gui_OutputFcn',  @CrEAP_OutputFcn, ...
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

% --- Executes just before CrEAP is made visible.
function CrEAP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CrEAP (see VARARGIN)

% Choose default command line output for CrEAP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%initialize logo image
baseFileName = 'logo.png';
if exist(baseFileName, 'file')
  theImage = imread(baseFileName);
  axes(handles.axes17); 
  imshow(theImage);
else
  message = sprintf('Image file not found:\n%s', baseFileName);
  uiwait(warndlg(message));
end

%initialize load led (green) on ON
baseFileName = 'ledGreenON.jpg';
if exist(baseFileName, 'file')
  theImage = imread(baseFileName);
  axes(handles.axes20); 
  imshow(theImage);
else
  message = sprintf('Image file not found:\n%s', baseFileName);
  uiwait(warndlg(message));
end


% UIWAIT makes CrEAP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CrEAP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ImageElaboration.
function ImageElaboration_Callback(hObject, eventdata, handles)
% hObject    handle to ImageElaboration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Image Image_compl Image_sharpen Image_bin Image_filt

Amount_n = str2double(get(handles.Amount_n,'String'));
Radius_n = str2double(get(handles.Radius_n,'String'));
Threshold_n = str2double(get(handles.Threshold_n,'String'));
Value_n = str2double(get(handles.Value_n,'String'));
RadiusMask_n = str2double(get(handles.RadiusMask_n,'String'));

Image_gray = rgb2gray(Image);
% Sharpen image, specifying the radius and amount parameters 
Image_sharpen = imsharpen(Image_gray,'Radius',Radius_n,'Amount',Amount_n,'Threshold',Threshold_n);
% Convert image to binary image, based on threshold
Image_bin = im2bw(Image_sharpen,Value_n);
% Filteres the image with a filter h
h = fspecial('disk',RadiusMask_n);
Image_filt = imfilter(Image_bin,h);
% Complement image
Image_compl = imcomplement (Image_filt);

axes(handles.axes14); imshow(Image_sharpen)
axes(handles.axes15); imshow(Image_bin)
axes(handles.axes16); imshow(Image_filt)
axes(handles.axes2); imshow(Image_compl)



% --- Executes on slider movement.
function RadiusMask_Callback(hObject, eventdata, handles)
% hObject    handle to RadiusMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'s') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

RadiusMask_v = get(hObject,'Value');
set(handles.RadiusMask_n, 'String', RadiusMask_v);
global Image Image_compl Image_sharpen Image_bin Image_filt

Amount_n = str2double(get(handles.Amount_n,'String'));
Radius_n = str2double(get(handles.Radius_n,'String'));
Threshold_n = str2double(get(handles.Threshold_n,'String'));
Value_n = str2double(get(handles.Value_n,'String'));
RadiusMask_n = str2double(get(handles.RadiusMask_n,'String'));

Image_gray = rgb2gray(Image);
% Sharpen image, specifying the radius and amount parameters 
Image_sharpen = imsharpen(Image_gray,'Radius',Radius_n,'Amount',Amount_n,'Threshold',Threshold_n);
% Convert image to binary image, based on threshold
Image_bin = im2bw(Image_sharpen,Value_n);
% Filteres the image with a filter h
h = fspecial('disk',RadiusMask_n);
Image_filt = imfilter(Image_bin,h);
% Complement image
Image_compl = imcomplement (Image_filt);

axes(handles.axes14); imshow(Image_sharpen)
axes(handles.axes15); imshow(Image_bin)
axes(handles.axes16); imshow(Image_filt)
axes(handles.axes2); imshow(Image_compl)

% --- Executes during object creation, after setting all properties.
function RadiusMask_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RadiusMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(gcbo,'Value',8);


function RadiusMask_n_Callback(hObject, eventdata, handles)
% hObject    handle to RadiusMask_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RadiusMask_n as text
%        str2double(get(hObject,'String')) returns contents of RadiusMask_n as a double


% --- Executes during object creation, after setting all properties.
function RadiusMask_n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RadiusMask_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(gcbo,'String',8);

% --- Executes on slider movement.
function Value_Callback(hObject, eventdata, handles)
% hObject    handle to s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'s') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


Value_v = get(hObject,'Value');
set(handles.Value_n, 'String', Value_v);

global Image Image_compl Image_sharpen Image_bin Image_filt

Amount_n = str2double(get(handles.Amount_n,'String'));
Radius_n = str2double(get(handles.Radius_n,'String'));
Threshold_n = str2double(get(handles.Threshold_n,'String'));
Value_n = str2double(get(handles.Value_n,'String'));
RadiusMask_n = str2double(get(handles.RadiusMask_n,'String'));

Image_gray = rgb2gray(Image);
% Sharpen image, specifying the radius and amount parameters 
Image_sharpen = imsharpen(Image_gray,'Radius',Radius_n,'Amount',Amount_n,'Threshold',Threshold_n);
% Convert image to binary image, based on threshold
Image_bin = im2bw(Image_sharpen,Value_n);
% Filteres the image with a filter h
h = fspecial('disk',RadiusMask_n);
Image_filt = imfilter(Image_bin,h);
% Complement image
Image_compl = imcomplement (Image_filt);

axes(handles.axes14); imshow(Image_sharpen)
axes(handles.axes15); imshow(Image_bin)
axes(handles.axes16); imshow(Image_filt)
axes(handles.axes2); imshow(Image_compl)


% --- Executes during object creation, after setting all properties.
function s_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function Value_n_Callback(hObject, eventdata, handles)
% hObject    handle to Value_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Value_n as text
%        str2double(get(hObject,'String')) returns contents of Value_n as a double


% --- Executes during object creation, after setting all properties.
function Value_n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Value_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(gcbo,'String',0.1);

% --- Executes on slider movement.
function Amount_Callback(hObject, eventdata, handles)
% hObject    handle to Amount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'s') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

Amount_v = get(hObject,'Value');
set(handles.Amount_n, 'String', Amount_v);

global Image Image_compl Image_sharpen Image_bin Image_filt

Amount_n = str2double(get(handles.Amount_n,'String'));
Radius_n = str2double(get(handles.Radius_n,'String'));
Threshold_n = str2double(get(handles.Threshold_n,'String'));
Value_n = str2double(get(handles.Value_n,'String'));
RadiusMask_n = str2double(get(handles.RadiusMask_n,'String'));

Image_gray = rgb2gray(Image);
% Sharpen image, specifying the radius and amount parameters 
Image_sharpen = imsharpen(Image_gray,'Radius',Radius_n,'Amount',Amount_n,'Threshold',Threshold_n);
% Convert image to binary image, based on threshold
Image_bin = im2bw(Image_sharpen,Value_n);
% Filteres the image with a filter h
h = fspecial('disk',RadiusMask_n);
Image_filt = imfilter(Image_bin,h);
% Complement image
Image_compl = imcomplement (Image_filt);

axes(handles.axes14); imshow(Image_sharpen)
axes(handles.axes15); imshow(Image_bin)
axes(handles.axes16); imshow(Image_filt)
axes(handles.axes2); imshow(Image_compl)





% --- Executes during object creation, after setting all properties.
function Amount_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Amount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
 set(gcbo,'Value',20);

% --- Executes on slider movement.
function Radius_Callback(hObject, eventdata, handles)
% hObject    handle to Radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'s') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Radius_v = get(hObject,'Value');
set(handles.Radius_n, 'String', Radius_v);

global Image Image_compl Image_sharpen Image_bin Image_filt

Amount_n = str2double(get(handles.Amount_n,'String'));
Radius_n = str2double(get(handles.Radius_n,'String'));
Threshold_n = str2double(get(handles.Threshold_n,'String'));
Value_n = str2double(get(handles.Value_n,'String'));
RadiusMask_n = str2double(get(handles.RadiusMask_n,'String'));

Image_gray = rgb2gray(Image);
% Sharpen image, specifying the radius and amount parameters 
Image_sharpen = imsharpen(Image_gray,'Radius',Radius_n,'Amount',Amount_n,'Threshold',Threshold_n);
% Convert image to binary image, based on threshold
Image_bin = im2bw(Image_sharpen,Value_n);
% Filteres the image with a filter h
h = fspecial('disk',RadiusMask_n);
Image_filt = imfilter(Image_bin,h);
% Complement image
Image_compl = imcomplement (Image_filt);

axes(handles.axes14); imshow(Image_sharpen)
axes(handles.axes15); imshow(Image_bin)
axes(handles.axes16); imshow(Image_filt)
axes(handles.axes2); imshow(Image_compl)


% --- Executes during object creation, after setting all properties.
function Radius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(gcbo,'Value',6);

% --- Executes on slider movement.
function Threshold_Callback(hObject, eventdata, handles)
% hObject    handle to Threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'s') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Threshold_v = get(hObject,'Value');
set(handles.Threshold_n, 'String', Threshold_v);

global Image Image_compl Image_sharpen Image_bin Image_filt

Amount_n = str2double(get(handles.Amount_n,'String'));
Radius_n = str2double(get(handles.Radius_n,'String'));
Threshold_n = str2double(get(handles.Threshold_n,'String'));
Value_n = str2double(get(handles.Value_n,'String'));
RadiusMask_n = str2double(get(handles.RadiusMask_n,'String'));

Image_gray = rgb2gray(Image);
% Sharpen image, specifying the radius and amount parameters 
Image_sharpen = imsharpen(Image_gray,'Radius',Radius_n,'Amount',Amount_n,'Threshold',Threshold_n);
% Convert image to binary image, based on threshold
Image_bin = im2bw(Image_sharpen,Value_n);
% Filteres the image with a filter h
h = fspecial('disk',RadiusMask_n);
Image_filt = imfilter(Image_bin,h);
% Complement image
Image_compl = imcomplement (Image_filt);

axes(handles.axes14); imshow(Image_sharpen)
axes(handles.axes15); imshow(Image_bin)
axes(handles.axes16); imshow(Image_filt)
axes(handles.axes2); imshow(Image_compl)


% --- Executes during object creation, after setting all properties.
function Threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(gcbo,'Value',0);


function Amount_n_Callback(hObject, eventdata, handles)
% hObject    handle to Amount_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Amount_n as text
%        str2double(get(hObject,'String')) returns contents of Amount_n as a double


% --- Executes during object creation, after setting all properties.
function Amount_n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Amount_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(gcbo,'String',20);


function Radius_n_Callback(hObject, eventdata, handles)
% hObject    handle to Radius_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Radius_n as text
%        str2double(get(hObject,'String')) returns contents of Radius_n as a double


% --- Executes during object creation, after setting all properties.
function Radius_n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Radius_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(gcbo,'String',6);


function Threshold_n_Callback(hObject, eventdata, handles)
% hObject    handle to Threshold_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Threshold_n as text
%        str2double(get(hObject,'String')) returns contents of Threshold_n as a double


% --- Executes during object creation, after setting all properties.
function Threshold_n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Threshold_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(gcbo,'String',0);


% --- Executes on button press in Images.
function Images_Callback(hObject, eventdata, handles)
% hObject    handle to Images (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'s') returns toggle state of Images


% --- Executes on button press in Video.
function Video_Callback(hObject, eventdata, handles)
% hObject    handle to Video (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'s') returns toggle state of Video


% --- Executes on button press in Load.
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Image pathname rect scale_factor Images_value vect_tempi fps num_frame pathname_video

fps = str2double(get(handles.fps,'String'));

theImage = imread('ledYellowON.jpg');
axes(handles.axes20); 
imshow(theImage);

if (Images_value == 1)
    
    [filename, pathname] = uigetfile( ...
    {'*.jpg';'*.fig';'*.tiff';'*.bmp';'*.pgm'},'Select Files');
if (filename == 0)
    %Green Led turns ON when video is converted
    theImage = imread('ledGreenON.jpg');
    axes(handles.axes20); 
    imshow(theImage);
    h = msgbox('Invalid Value', 'Error','error');
else
    ImageName = strcat (pathname,filename);
    
    %Green Led turns ON when image is acquired
    theImage = imread('ledGreenON.jpg');
    axes(handles.axes20); 
    imshow(theImage);
    
    Image = imread(ImageName);
    figure(1), imshow(ImageName), title('Select the region of interest:')
    rect = getrect;  
    I_c = imcrop (Image, [rect(1),rect(2),rect(3),rect(4)]);
    [n_row, n_col]= size(I_c);
    scale_factor = (300/min(n_row,n_col));
    I_crop = imresize(I_c,scale_factor);
    axes(handles.axes1)
    imshow(Image)
    Image = I_crop;
    axes(handles.axes2)
    imshow(Image)
    close(figure(1))
end

else
    [filename_video, pathname_video] = uigetfile( ...
    {'*.avi';'*.wmv';'*.webm'},'Select File');
if (filename_video == 0)

    %Green Led turns ON when video is converted
    theImage = imread('ledGreenON.jpg');
    axes(handles.axes20); 
    imshow(theImage);
    h = msgbox('Invalid Value', 'Error','error');

else
    VideoName = strcat (pathname_video,filename_video);
    Video = VideoReader(VideoName);
    
    lastFrame= read (Video, inf);
    
    duration = Video.Duration;
    num_frames = Video.NumberOfFrames;
    n_frame = 0;

    fps_new = fps;
    
    if (fps_new == 0)
         fps_new = 5;
    end

    if (fps_new > Video.FrameRate)
        fps_new = Video.FrameRate;
    end
    
    passo = Video.FrameRate/fps_new;


    for frame = 1 : passo :  num_frames-1;
        curr_Frame = read(Video, frame);
        CurrentFileName = sprintf('Img (%d).jpg', n_frame);
        CurrentFullFileName = fullfile(pathname_video, CurrentFileName);
        imwrite(curr_Frame, CurrentFullFileName, 'jpg');
        n_frame = n_frame+1;
        num_frame = n_frame - 1;
    end

    passo_tempo = (1/fps);
    durat_camp = num_frame*(1/fps);
    vect_tempi = [0 : passo_tempo : durat_camp];
    
    %Green Led turns ON when video is converted
    theImage = imread('ledGreenON.jpg');
    axes(handles.axes20); 
    imshow(theImage);
    
    Name = char('Img (0).jpg');
    ImageName = strcat (pathname_video,Name);
    Image = imread(ImageName);
    figure(1), imshow(Image), title('Select the region of interest:')
    rect = getrect;  
    I_c = imcrop (Image, [rect(1),rect(2),rect(3),rect(4)]);
    [n_row, n_col]= size(I_c);
    scale_factor = (300/min(n_row,n_col));
    I_crop = imresize(I_c,scale_factor);
    axes(handles.axes1)
    imshow(I_crop)
    Image = I_crop;
    axes(handles.axes2)
    imshow(Image)
    close(figure(1))
end
end


function   [xc,yc,R,a] = circfit(x,y)

   x=x(:); y=y(:);
   a=[x y ones(size(x))]\[-(x.^2+y.^2)];
   xc = -.5*a(1);
   yc = -.5*a(2);
   R  =  sqrt((a(1)^2+a(2)^2)/4-a(3));
   
   
% --- Executes on button press in Select.
function Select_Callback(hObject, eventdata, handles)
% hObject    handle to Select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Select with the mouse the spots corresponding on your markers. Double click on the last one.

global Image_compl I_marker Rfit0

[I_marker] = bwselect(Image_compl,4);
% Show the image that has only the markers

axes(handles.axes2); imshow(I_marker);

% Detect and show the centroids of each markers
centroid = regionprops (I_marker,'centroid');

hold on;
for ii = 1: numel(centroid)
        plot(centroid(ii).Centroid(1),centroid(ii).Centroid(2),'b*','MarkerSize',20);
end


% Fitting a circle to centroid points
matrix_c = [centroid(1).Centroid;centroid(2).Centroid;centroid(3).Centroid;centroid(4).Centroid];
x = matrix_c (:,1);
y = matrix_c (:,2);

[xfit,yfit,Rfit0] = circfit(x,y);
hold on
rectangle('position',[xfit-Rfit0,yfit-Rfit0,Rfit0*2,Rfit0*2],...
    'curvature',[1,1],'linestyle','-','edgecolor','r');


% --- Executes on button press in Run.
function Run_Callback(hObject, eventdata, handles)
% hObject    handle to Run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global pathname rect scale_factor I_marker Rfit0 vect_tempi num_frame Images_value pathname_video fps V d

Amount_n = str2double(get(handles.Amount_n,'String'));
Radius_n = str2double(get(handles.Radius_n,'String'));
Threshold_n = str2double(get(handles.Threshold_n,'String'));
Value_n = str2double(get(handles.Value_n,'String'));
RadiusMask_n = str2double(get(handles.RadiusMask_n,'String'));

nV = str2num(get(handles.nV,'String'));
v =  str2num(get(handles.v,'String'));
Vmax = nV*v;
V = [0:v:Vmax];



if (Images_value == 1)
    
    working_handle = msgbox('working...');
    
    for i = 1:nV

        filename = strcat('Img (',num2str(i),').jpg');
        Name = strcat(pathname,filename);
        I = imread (Name);
        I_c = imcrop (I, [rect(1),rect(2),rect(3),rect(4)]);
        I_crop = imresize(I_c,scale_factor);
        I_gray = rgb2gray(I_crop);
        I_sharpen = imsharpen(I_gray,'Radius',Radius_n,'Amount',Amount_n,'Threshold',Threshold_n);
        I_bin = im2bw(I_sharpen,Value_n);
        h = fspecial('disk',RadiusMask_n);
        I_filt = imfilter(I_bin,h);
        I_compl = imcomplement (I_filt);  

        if (v < 1.5)
            % Find markers automatically (displacements are supposed to be small: the centroids of each markers must be pixells which belong to the markers in the previous image)
            [Y_pix,X_pix] = find(I_marker>0);
            I_marker = bwselect(I_compl,X_pix,Y_pix,4);
        else
            % Find markers manually
            figure, imshow(I_compl), title('Select your markers:');
            I_marker = bwselect(I_compl,4);
        end

        centroid = regionprops (I_marker,'centroid');


        matrix_c = [centroid(1).Centroid;centroid(2).Centroid;centroid(3).Centroid;centroid(4).Centroid];
        x = matrix_c (:,1);
        y = matrix_c (:,2);

       % Fitting a circle to centroid points

        [xfit(i),yfit(i),Rfit(i)] = circfit(x,y);
        hold on
        rectangle('position',[xfit(i)-Rfit(i),yfit(i)-Rfit(i),Rfit(i)*2,Rfit(i)*2],...
            'curvature',[1,1],'linestyle','-','edgecolor','r'); 


        % Estimate radial deformation
        strain(i) = (abs((Rfit(i)-Rfit0)/Rfit0)*100); 

    end

    %closing "working" box
    if ishandle(working_handle)
         delete(working_handle);
    end
    clear working_handle;
        
    h = msgbox('Calculation Completed');
    
    d = [0,strain];
    Results=[V',d'];
    
    figure
    plot(V,d,'b-*'); title('Electrically induced Radial Strain VS Drive Voltage')
    grid on
    xlabel('Voltage [KV]')
    ylabel('Radial strains (%)')

    assignin ('base','RadialStrain',strain);
    assignin ('base','Voltage',V);
    
else
    
    working_video_handle = msgbox('working...');
    
    for i = 1:num_frame

        filename = strcat('Img (',num2str(i),').jpg');
        Name = strcat(pathname_video,filename);
        I = imread (Name);
        I_c = imcrop (I, [rect(1),rect(2),rect(3),rect(4)]);
        I_crop = imresize(I_c,scale_factor);
        I_gray = rgb2gray(I_crop);
        I_sharpen = imsharpen(I_gray,'Radius',Radius_n,'Amount',Amount_n,'Threshold',Threshold_n);
        I_bin = im2bw(I_sharpen,Value_n);
        h = fspecial('disk',RadiusMask_n);
        I_filt = imfilter(I_bin,h);
        I_compl = imcomplement (I_filt);  

        if (fps >= 2)
            % Find markers automatically (displacements are supposed to be small: the centroids of each markers must be pixells which belong to the markers in the previous image)
            [Y_pix,X_pix] = find(I_marker>0);
            I_marker = bwselect(I_compl,X_pix,Y_pix,4);
        else
            % Find markers manually
            figure, imshow(I_compl), title('Select your markers:');
            I_marker = bwselect(I_compl,4);
        end
        
        centroid = regionprops (I_marker,'centroid');
        matrix_c = [centroid(1).Centroid;centroid(2).Centroid;centroid(3).Centroid;centroid(4).Centroid];
        x = matrix_c (:,1);
        y = matrix_c (:,2);

       % Fitting a circle to centroid points

        [xfit(i),yfit(i),Rfit(i)] = circfit(x,y);
        hold on
        rectangle('position',[xfit(i)-Rfit(i),yfit(i)-Rfit(i),Rfit(i)*2,Rfit(i)*2],...
            'curvature',[1,1],'linestyle','-','edgecolor','r'); 


        % Estimate radial deformation
        strain(i) = (abs((Rfit(i)-Rfit0)/Rfit0)*100); 

    end

    %closing "working" box
    if ishandle(working_video_handle)
         delete(working_video_handle);
    end
    clear working_video_handle;    
        
    h = msgbox('Calculation Completed');
    
    d = [0,strain];
    Results=[vect_tempi',d'];
 
    figure
    plot(vect_tempi,d,'b-*'); title('Electrically induced Radial Strain VS Time')
    grid on
    xlabel('Time [s]')
    ylabel('Radial strains (%)')

    assignin ('base','RadialStrain',strain);
    assignin ('base','vect_tempi',vect_tempi);
end



    function edit17_Callback(hObject, eventdata, handles)
    % hObject    handle to edit17 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of edit17 as text
    %        str2double(get(hObject,'String')) returns contents of edit17 as a double


    % --- Executes during object creation, after setting all properties.
    function edit17_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to edit17 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit17.
function edit17_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function Value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(gcbo,'Value',0.1);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function nV_Callback(hObject, eventdata, handles)
% hObject    handle to nV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nV as text
%        str2double(get(hObject,'String')) returns contents of nV as a double



% --- Executes during object creation, after setting all properties.
function nV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v_Callback(hObject, eventdata, handles)
% hObject    handle to v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v as text
%        str2double(get(hObject,'String')) returns contents of v as a double


% --- Executes during object creation, after setting all properties.
function v_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fps_Callback(hObject, eventdata, handles)
% hObject    handle to fps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fps as text
%        str2double(get(hObject,'String')) returns contents of fps as a double


% --- Executes during object creation, after setting all properties.
function fps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(gcbo,'String',5);


% --- Executes when selected object is changed in uipanel6.
function uipanel6_SelectionChangeFcn(hObject, eventdata, handles)
global Images_value Video_value
A = get(hObject,'string');
switch A
    case 'Images'
        Images_value = 1;
        Video_value = 0;
    case 'Video'
        Video_value = 1;
        Images_value = 0;
end
assignin ('base','Images_value',Images_value);
assignin ('base','Video_value',Video_value);


% --- Executes on button press in Save_var.
function Save_var_Callback(hObject, eventdata, handles)
% hObject    handle to Save_var (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Images_value pathname pathname_video vect_tempi V d 

if (Images_value == 1)
    
    [filename_1, pathname] = uiputfile( ...
    {'.txt';'*.*'},'Save File as..');

    if (filename_1 == 0)
        h = msgbox('Invalid Value', 'Error','error');
    else
        A=[V;d];
        name_file = strcat(pathname,filename_1);
        fileID = fopen(name_file,'w');
        fprintf(fileID,'%6s %12s\n','Voltage(kV)','Strain(%)');
        fprintf(fileID,'%6.2f %12.8f\n',A);
        fclose(fileID);
    end
    
else
    [filename_video_1, pathname_video] = uiputfile( ...
    {'.txt';'*.*'},'Save File as..');
    if (filename_video_1 == 0)
        h = msgbox('Invalid Value', 'Error','error');

    else
        A=[vect_tempi;d];
        name_video_1 = strcat(pathname_video,filename_video_1);
        fileID = fopen(name_video_1,'w');
        fprintf(fileID,'%6s %12s\n','Time(s)','Strain(%)');
        fprintf(fileID,'%6.2f %12.8f\n',A);
        fclose(fileID);
    end

end


% --- Executes on button press in recrop.
function recrop_Callback(hObject, eventdata, handles)
% hObject    handle to recrop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global Image pathname rect scale_factor Images_value  pathname_video

theImage = imread('ledYellowON.jpg');
axes(handles.axes20); 
imshow(theImage);

if (Images_value == 1)
    
    ImageName = strcat (pathname,'Img (0).jpg');
    
    %Green Led turns ON when image is acquired
    theImage = imread('ledGreenON.jpg');
    axes(handles.axes20); 
    imshow(theImage);
    
    Image = imread(ImageName);
    figure(1), imshow(ImageName), title('Select the region of interest:')
    rect = getrect;  
    I_c = imcrop (Image, [rect(1),rect(2),rect(3),rect(4)]);
    [n_row, n_col]= size(I_c);
    scale_factor = (300/min(n_row,n_col));
    I_crop = imresize(I_c,scale_factor);
    axes(handles.axes1)
    imshow(Image)
    Image = I_crop;
    axes(handles.axes2)
    imshow(Image)
    close(figure(1))
    
else
    Name = char('Img (0).jpg');
    ImageName = strcat (pathname_video,Name);
    
    %Green Led turns ON when image is acquired
    theImage = imread('ledGreenON.jpg');
    axes(handles.axes20); 
    imshow(theImage);
    
    Image = imread(ImageName);
    figure(1), imshow(Image), title('Select the region of interest:')
    rect = getrect;  
    I_c = imcrop (Image, [rect(1),rect(2),rect(3),rect(4)]);
    [n_row, n_col]= size(I_c);
    scale_factor = (300/min(n_row,n_col));
    I_crop = imresize(I_c,scale_factor);
    axes(handles.axes1)
    imshow(I_crop)
    Image = I_crop;
    axes(handles.axes2)
    imshow(Image)
    close(figure(1))
end
