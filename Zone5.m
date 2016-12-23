% function for Zone 5
function R_img = Zone5(img,alpha)
    
    if(alpha>195 && alpha<210)
        alpha = 210;
    end
    
    % subtract 180 from alpha
    alpha_180 = alpha - 180;
    
    % S & Sb as per the paper which are slope and slope_normal
    S = tand(alpha_180);
    Sb = tand(alpha_180+90);
    
    % Get the dimension of the image rows, cols ( and channels if present)
    dim = size(img);
    
    % Checker if image a rgb or gray 
    check = size(dim,2);
   
    % the value for nu_m and nu_n as per paper
    nu_m = round(S*dim(2));
    nu_n = round(abs(dim(1)/Sb));
    
    % rows and columns for new rotated image
    m_rt = dim(1) + nu_m ;
    n_rt = dim(2) + nu_n ;
     
    % rotated image initialization
    R_img = rotated_image(m_rt,n_rt,check); 
    
    if(alpha>=180 && alpha<=195)
        R_img = rot_90(rot_90(img));
    else
        for y = dim(1):-1:1
         
            % Start point co-ordinates for new image
            y_rt = int32(m_rt - (dim(1)-y));
            x_rt = int32(abs(y/Sb));
            
            y_st = y_rt;
            x_st = x_rt;
            
            for x = 1:1:dim(2)
                % check if its an RGB image
                iy_rt = m_rt - y_rt + 1;
                ix_rt = n_rt - x_rt + 1;
            
                if(check==3)
                    R_img(iy_rt,ix_rt,:) = img(y,x,:);
                    % for double line
                    if(y_rt>=2 && y > 1)
                        R_img(iy_rt+1,ix_rt,:) = img(y,x,:);
                    end      
                else
                    % if image is grayscale image
                    R_img(iy_rt,ix_rt) = img(y,x);
                    % for double line
                    if(y_rt>=2 && y > 1)
                        R_img(iy_rt+1,ix_rt) = img(y,x);
                    end  
                end 
                % new udpate values of points based on slope      
                x_rt = x_st + x;
                y_rt = y_st - S*x;  
            end
        end
    end
end
