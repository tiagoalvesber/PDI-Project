function [image, fixed_frame] = detectFixedImage(path)
    [FRAMES, dummy] = size(dir(fullfile(path, '*.jpg')));
    FIXED = false;
    for i = 2:FRAMES-1
        im0 = convert_to_grayscale(imread(strcat(path, num2str(i-1),'.jpg')));
        im1 = convert_to_grayscale(imread(strcat(path, num2str(i),'.jpg')));
        
        im0_blur = medfilt2(im0, [5 5]);
        im1_blur = medfilt2(im1, [5 5]);
        
        subtract_image = im0_blur - im1_blur;
        
        FIXED = inspectImage(subtract_image, 0.005);
        
        if(FIXED)
            image = convert_to_grayscale(imread(strcat(path, num2str(i-2),'.jpg')));
            fixed_frame = i-1;
            break;
        end
    end
end
