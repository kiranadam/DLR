% function for ZEROS sized image with calculated new rows and cols
function R_img = rotated_image(m,n,c)

     if(c==3)
        R_img = zeros(int32(m),int32(n),c,'uint8');
     else
        R_img = zeros(int32(m),int32(n),'uint8');
     end
end
