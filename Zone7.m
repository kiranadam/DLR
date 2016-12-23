% function for Zone 7
function R_img = Zone7(img,alpha)

    % Get the Slope and slope normal
    if(alpha>285 && alpha<300)
        alpha = 300;
    end
    
    S = tand(alpha);
    Sb = tand(alpha+90);
    
    % Get the dimensions of the image rows, colums (channels if present)
    dim = size(img);
    
    % Check if the image is RGB or Grayscale
    check = size(dim,2);

    if(alpha>=270 && alpha<=285)
        R_img = rot_90(rot_90((rot_90(img))));
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
            % Start point co-ordinates for new image
            y_rt = int32(y);
            x_rt = nu_n - int32(abs(y/Sb))+1;
            
            y_st = y_rt;
            x_st = x_rt;
            
            for x = 1:1:dim(2)
                % Check if its an RGB image
                if(check==3)
                    R_img(y_rt,x_rt,:) = img(y,x,:);
                    % for double line
                    if(y_rt<m_rt && y<dim(1))
                        for i= 1:1:5
                            R_img(y_rt+i,x_rt,:) = img(y,x,:);
                        end
                    end
                else
                    % if image is grayscale image
                    R_img(y_rt,x_rt) = img(y,x);
                    % for double line
                    if(y_rt<m_rt && y<dim(1))
                        for i= 1:1:5
                            R_img(y_rt+i,x_rt) = img(y,x);
                        end
                    end
                end 
                % new udpate values of points based on slope      
                x_rt = x_st + x;
                y_rt = y_st - S*x;
            end
        end
    end      
end