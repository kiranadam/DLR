%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      Main                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% input the image path

prompt = 'Please enter the image path : \n';
str = input(prompt,'s');
img = imread(str);
figure
imshow(img)
title('Original Image')

%% Enter the angle 
angle = ' Please enter angle from 0 to 360 degrees : ';
alpha = input(angle);

%% Call DLR_test with angle 'alpha' for image 'img'
R_img = DLR_test(img,alpha);

check = size(R_img);

% Angle 360-alpha = - alpha using this property
alpha_360 = 360 - alpha;

%% Call DLR_test with angle 'alpha_360' for image 'R_img'
RR_img = DLR_test(R_img,alpha_360);

RR_img = rgb2gray(RR_img);

%% Get the absolute slope with angle 'alpha'
S = abs(tand(alpha));

%% Convert input image to gray scale
img_S = rgb2gray(img);

%% Get dimension of image 'img_S' & 'RR_img'
[img_rows, img_cols] = size(img_S);

[RR_rows, RR_cols] = size(RR_img);

%% Crop the image based the dimensions needed
if(alpha>= 0 && alpha<=15|| alpha>= 75 && alpha<=105 || alpha>= 165 && alpha<=195 || alpha>= 255 && alpha<=285 || alpha>= 345 && alpha<=360)
    R_crop = img_S;
else
   
    RR_y = int32(img_rows/power(sind(alpha+90),2));
    RR_x = int32(img_cols/power(cosd(alpha),2));
    
    RR_crop = RR_img(RR_rows/2-RR_y/2+1:RR_rows/2+RR_y/2,RR_cols/2-RR_x/2+1:RR_cols/2+RR_x/2);
    
    figure
    imshow(RR_crop)
    title('Cropped Image')
    R_crop = imresize(RR_crop,[img_rows img_cols]);
end


%% Call SSIM index function for images 'img_S' and 'RR_crop' to check similarity
[mssim, ssim_map] = ssim(img_S, R_crop);
figure
imshow(max(0, ssim_map).^4)
title('SSIM Map')

%% Call PSN function to check PSNR error for images 'img_S' and 'RR_crop'
PSN(img_S,R_crop);
