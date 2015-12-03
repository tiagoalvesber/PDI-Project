function [xMax, xMin, yMax, yMin] = croppedImage(img)
    xMin = Inf;
    xMax = 0;    
    yMin = Inf;
    yMax = 0;
    
    [h, w] = size(img);
    
    for x = 1:h,
        for y = 1:w,
            if(img(x,y) == 255),
            
                if(xMin > x),
                    xMin = x;
                end
                
                if(xMax < x),
                    xMax = x;
                end
                
                if(yMin > y),
                    yMin = y;
                end
                
                if(yMax < y),
                    yMax = y;
                end
            
            end
        end
    end
    
    if xMin == Inf
        xMin = 1;
    end
    
    if yMin == Inf
        yMin = 1;
    end
    
    if xMax == 0
        xMax = h;
    end
    
    if yMax == 0
        yMax = w;
    end
end