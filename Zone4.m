function R_img = Zone4(img,alpha)

    if(alpha>150 && alpha<165)
        alpha = 150;
    end
    
    alpha_180 = 180 + alpha;
    
    % S & Sb as per the paper which are slope and slope_normal
    S = tand(alpha_180);
    Sb = tand(alpha_180+90);
    
    % Get the dimensions of the image rows, colums (channels if present)
    dim = size(img);
    
    % Check if the image is RGB or Grayscale
    check = size(dim,2);

    % the value for nu_m and nu_n as per paper
    nu_m = round(abs(S*dim(2)));
    nu_n = round(abs(dim(1)/Sb));
    
    % rows and columns for new rotated image
    m_rt = dim(1) + nu_m ;
    n_rt = dim(2) + nu_n ;
     
    % rotated image
    R_img = rotated_image(m_rt,n_rt,check); 
    
    if(alpha>=165 && alpha<=180)
        R_img = rot_90(rot_90(img));   
    else
        for y = dim(1):-1:1   
            % Start point co-ordinates for new image
            y_rt = int32(y);
            x_rt = nu_n - int32(abs(y/Sb))+1;
            
            y_st = y_rt;
            x_st = x_rt;
            
            for x = 1:1:dim(2)
                % check if its an RGB image
                iy_rt = m_rt - y_rt + 1;
                ix_rt = n_rt - x_rt + 1;
           
                if(check==3)
                    R_img(iy_rt,ix_rt,:) = img(y,x,:);
                    % for double line
                    if(y_rt<m_rt && y<dim(1))
                        R_img(iy_rt-1,ix_rt,:) = img(y,x,:);
                    end
                else
                    % if image is grayscale image
                    R_img(iy_rt,ix_rt) = img(y,x);
                    % for double line
                    if(y_rt<m_rt && y<dim(1))
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