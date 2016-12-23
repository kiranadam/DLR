% function for Zone 8
function R_img = Zone8(img,alpha)

    if(alpha>330 && alpha<345)
        alpha=330;
    end

    % Get the Slope and slope normal
    S = tand(alpha);
    Sb = tand(alpha+90);
    
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
    
    if(alpha>=345 && alpha<=360)
        R_img = img;
    else 
        for y = dim(1):-1:1   
            % Start point co-ordinates for new image
            y_rt = int32(y);
            x_rt = nu_n - int32(abs(y/Sb))+1;
            
            y_st = y_rt;
            x_st = x_rt;
            
            for x = 1:1:dim(2)
                % check if its an RGB image
                if(check==3)
                    R_img(y_rt,x_rt,:) = img(y,x,:);
                    % for double line
                    if(y_rt<m_rt && y<dim(1))
                        R_img(y_rt+1,x_rt,:) = img(y,x,:);
                    end
                else
                    % if image is grayscale image
                    R_img(y_rt,x_rt) = img(y,x);
                    % for double line
                    if(y_rt<m_rt && y<dim(1))
                        R_img(y_rt+1,x_rt) = img(y,x);
                    end
                end 
                % new udpate values of points based on slope      
                x_rt = x_st + x;
                y_rt = y_st - S*x; 
            end
        end
    end       
end