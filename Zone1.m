% function for Zone 1
function R_img = Zone1(img,alpha)
    
    if(alpha>15 && alpha<30)
        alpha = 30;
    end
    
    % S & Sb as per the paper which are slope and slope_normal
    S = tand(alpha);
    Sb = tand(alpha+90);
    
    % Get the dimension of the image rows, cols ( and channels if present)
    dim = size(img);
    
    % Checker if image a rgb or gray 
    check = size(dim,2);
   
    % the value for nu_m and nu_n as per paper
    nu_m = round(S*dim(2));
    nu_n = round(abs(dim(1)/Sb));
    
    % rows and columns for new rotated image
    m = dim(1);
    n = dim(2);
    
    m_rt = m + nu_m ;
    n_rt = n + nu_n ;
     
    % rotated image memory allocated
    R_img = rotated_image(m_rt,n_rt,check); 
    
    if(alpha>=0 && alpha<=15)
        R_img = img;
    else
        for y = dim(1):-1:1    
            % Start point co-ordinates for new image
            y_rt = int32(m_rt - (dim(1)-y));
            x_rt = int32(abs(y/Sb));
            
            y_st = y_rt;
            x_st = x_rt;
            
            for x = 1:1:dim(2)
                % check if its an RGB image
                if(check==3)
                    R_img(y_rt,x_rt,:) = img(y,x,:);
                    % for double line fill up
                    if(y_rt>1 && y>1 && x~=dim(2))
                        R_img(y_rt-1,x_rt,:) = img(y,x,:);
                    end
                else
                    % if image is grayscale image
                    R_img(y_rt,x_rt) = img(y,x);
                    % for double line
                    if(y_rt>1 && y>1 && x~=dim(2))
                        R_img(y_rt-1,x_rt) = img(y,x);
                    end
                end 
                % new udpate values of points based on slope      
                x_rt = x_st + x;
                y_rt = y_st - S*x;
            end
        end
    end         
end