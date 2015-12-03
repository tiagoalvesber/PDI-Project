function [sobel] = filter_sobel(image)
    h = fspecial('sobel');
    fd = im2double(image);
    fx = imfilter(fd, h, 'replicate');
    fy = imfilter(fd, h', 'replicate');
    
    sobel = sqrt(fx.^2 + fy.^2);
end