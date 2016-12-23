%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Function for Double Line Rotation                    %
%         Based on Digital Object Identi?er 10.1109/TIP.2015.2440763      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% This is the function to calculate the Double Line Rotation based on the paper " Double Line Rotation " by Ashtari A. H et al. with Digital Object Identi?er 10.1109/TIP.2015.2440763

% Input : 
% img : Image to rotated with DLR algorithm
% alpha : Angle to be rotated in degrees

% Output :
% R_img : Rotated Image


function R_img = DLR_test(img,alpha)
 
    % Zone 1 
    if(alpha>=0 && alpha<=45)
        R_img = Zone1(img,alpha); 
    end
    
    % Zone 2
    if(alpha>45 && alpha<=90)
        R_img = Zone2(img,alpha);   
    end
    
    % Zone 3
    if(alpha>90 && alpha<=135)
        R_img = Zone3(img,alpha);
    end
    
    % Zone 4
    if(alpha>135 && alpha<=180)
        R_img = Zone4(img,alpha);
    end
    
    % Zone 5
    if(alpha>180 && alpha<=225)
        R_img = Zone5(img,alpha);
    end
    
    % Zone 6
    if(alpha>225 && alpha<=270)
        R_img = Zone6(img,alpha);
    end
    
    % Zone 7
    if(alpha>270 && alpha<=315)
        R_img = Zone7(img,alpha);
    end
    
    % Zone 8
    if(alpha>315 && alpha<=360)
        R_img = Zone8(img,alpha);
    end
    figure 
    imshow(R_img) 
    title(['DLR Rotated Image at ',num2str(alpha),' degree'])
   
end












