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
dim = size(img);

img_S = rgb2gray(img);

%% Enter the angle 
angle = ' Please enter angle from 0 to 360 degrees : ';
alpha = input(angle);

%% Call midpoint_method with angle 'alpha' for image 'img'
R_img = midpoint_method(img,alpha);

check = size(R_img);

% Angle 360-alpha = - alpha using this property
alpha_360 = 360 - alpha;

%% Call midpoint_method with angle 'alpha_360' for image 'R_img'
RR_img = midpoint_method(R_img,alpha_360);

RR_img = rgb2gray(RR_img);

dim_RR = size(RR_img);

%% Crop the image based the dimensions needed
if(alpha== 0 || alpha==90 || alpha==180 || alpha==270 || alpha==360)
    R_crop = img_S;
else
 
    R_crop = RR_img((dim_RR(1)/2 - dim(1)/2+1):(dim_RR(1)/2 + dim(1)/2),(dim_RR(2)/2 - dim(2)/2+1):(dim_RR(2)/2 + dim(2)/2));
    
    figure
    imshow(R_crop)
    title('Cropped Image')
    
end


%% Call SSIM index function for images 'img_S' and 'RR_crop' to check similarity
[mssim, ssim_map] = ssim(img_S, R_crop);
figure
imshow(max(0, ssim_map).^4)
title('SSIM Map')

%% Call PSN function to check PSNR error for images 'img_S' and 'RR_crop'
PSN(img_S,R_crop);
