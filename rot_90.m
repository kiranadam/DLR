function R_img = rot_90(img)

    dim = size(img);
    
    check = size(dim,2);
    
    R_img = rotated_image(dim(2),dim(1),check);
    
    for y = 1:1:dim(1)
        for x= 1:1:dim(2)
            y_rt = y;
            x_rt = dim(2) - x + 1;
            if(check==3)
                R_img(x_rt,y_rt,:) = img(y,x,:);
            else
                R_img(x_rt,y_rt) = img(y,x);
            end
        end
    end
end
            