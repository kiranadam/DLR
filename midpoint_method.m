function C = midpoint_method(img,deg)

    %Find the midpoint
    if(deg>155)
        midx = ceil((size(img,1))/2);
        midy = ceil((size(img,2))/2);
    else
        midx = ceil((size(img,2))/2);
        midy = ceil((size(img,1))/2);
    end

    [y,x] = meshgrid(1:size(img,2), 1:size(img,1));
    [t,r] = cart2pol(x-midx,y-midy);
    t1 = radtodeg(t)+deg;
    %Convert from degree to radians
    t = degtorad(t1);
    %Convert to Cartesian Co-ordinates
    [x,y] = pol2cart(t,r);
    tempx = round(x+midx);
    tempy = round(y+midy);

    if ( min(tempx ( : ) ) < 0 )
        newx = max(tempx(:))+abs(min(tempx(:)))+1;
        tempx = tempx+abs(min(tempx(:)))+1;
    else
        newx = max(tempx(:));
    end

    if( min(tempy ( : ) ) < 0 )
        newy = max(tempy(:)) + abs(min(tempy(:)))+1;
        tempy = tempy + abs(min(tempy(:)))+1;
    else
        newy = max(tempy(:));
    end
    
    tempy(tempy==0) = 1;
    tempx(tempx==0) = 1;
    
    dim = size(img);
    
    check = size(dim,2);
    
    if(check==3)
        C = uint8(zeros([newx newy 3]));
    else
        C = uint8(zeros([newx newy]));
    end

    for i = 1:size(img,1)
        for j = 1:size(img,2)
            if(check==3)
                C(tempx(i,j),tempy(i,j) ,:) = img(i,j,:); 
            else
                C(tempx(i,j),tempy(i,j)) = img(i,j);
            end
        end
    end

    figure,imshow(C);
end