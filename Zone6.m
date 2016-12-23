% function for Zone 6
function R_img = Zone6(img,alpha)
    
    if(alpha>240 && alpha<255)
        alpha = 240;
    end

    % alpha is subtracted by 180 degrees
    alpha_180 = alpha - 180;

    % S & Sb as per the paper which are slope and slope_normal
    S = tand(alpha_180);
    Sb = tand(alpha_180+90);
    
    % Get the dimension of the image rows, cols ( and channels if present)
    dim = size(img);
    
    % Checker if image a rgb or gray 
    check = size(dim,2);
    
    if(alpha>=255 && alpha<=270)
         R_img = rot_90(rot_90(rot_90(img)));
    else
        % nu_m and nu_n as per paper
        nu_m = round(abs(S*dim(2)));
        nu_n = round(abs(dim(1)/Sb));
        
        % rows and cols for new rotated image
        m_rt = dim(1) + nu_m;
        n_rt = dim(2) + nu_n;
        
        % blank image with zeros
        R_img = rotated_image(m_rt,n_rt,check);
    
        for y = dim(1):-1:1
            % start points of rotating image  
            y_rt = int32(m_rt - (dim(1)-y));
            x_rt = int32(abs(y/Sb));
            
            y_st = y_rt;
            x_st = x_rt;
            
            for x = 1:1:dim(2)  
                % check if its RGB image
                iy_rt = m_rt - y_rt +1;
                ix_rt = n_rt - x_rt +1;
                
                if(check==3)
                    % check if angle is not 90 degrees
                    R_img(iy_rt,ix_rt,:) = img(y,x,:);
                    
                    % interpolation for the double line
                    if(y_rt>5 && y>1)
                        for i = 1:1:5
                            R_img(iy_rt+i,ix_rt,:) = img(y,x,:);
                        end
                    end
                else
                    % check for grayscale values only
                    R_img(iy_rt,ix_rt) = img(y,x);
                    
                    % interpolation for the double line
                    if(y_rt>5 && y>1)
                        for i = 1:1:5
                            R_img(iy_rt+i,ix_rt) = img(y,x);
                        end
                    end
                end
                % new values for points
                x_rt = x_st + x;
                y_rt = y_st - S*x;        
            end
        end  
    end 
end