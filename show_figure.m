function [ output_args ] = show_figure( img, title )
    figure('name', title)
    imshow(uint8(img));
end

