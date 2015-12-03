function [ output ] = convert_to_grayscale( img )
    [h, w, bands] = size(img);
    % se for rgb, converter para tons de cinza
    if bands > 1
        output = rgb2gray(img);
    end
%     output = double(output);

end

