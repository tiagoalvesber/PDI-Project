clear;
close all;
<<<<<<< HEAD
PATH = 'seq_2/';
FRAMES = 8;
=======
PATH = 'input_sofa/';
[FRAMES, dummy] = dir(fullfile(PATH, '*.jpg'));
>>>>>>> origin/master

im_fixed = convert_to_grayscale(imread('input_sofa/in000085.jpg'));

for i = 86:FRAMES,

    im0 = convert_to_grayscale(imread(strcat(PATH, sprintf('in%06d',i-1),'.jpg')));
    im1 = convert_to_grayscale(imread(strcat(PATH, sprintf('in%06d',i), '.jpg')));
    
    kernel = fspecial('average', [5 5]);
    
    im0_blur = imfilter(im0, kernel);
    im1_blur = imfilter(im1, kernel);
    im_fixed_blur = imfilter(im_fixed, kernel);
    
    im0_sobel = filter_sobel(im0_blur);
    im1_sobel = filter_sobel(im1_blur);
    im_fixed_sobel = filter_sobel(im_fixed_blur);
    
    subtract_sobel = uint8(im0_sobel- im_fixed_sobel)*255;
%     subtract_gray = (im0_blur - im1_blur);
    subtract_gray = im_fixed_blur - im0_blur;
    
    sobel_subtract_gray = filter_sobel(subtract_gray);
    
    subtract_dif = subtract_sobel + subtract_gray;
    
    teste_BW = im2bw(subtract_gray, 0.05)*255;
    
    subtract_canny = edge(im_fixed_blur-im0_blur,'sobel');
    subtract_fixa_1 = im_fixed_blur - im1_blur; 
    imwrite(subtract_canny, strcat('out/', num2str(i),'.png'));

 %  subtract_dif = sobel_subtract_gray;
 %   show_figure(sobel_subtract_gray*255);
 
    [xMax, xMin, yMax, yMin] = croppedImage(subtract_dif);
%     xy = centerOfMass( im0_blur(xMin:xMax, yMin:yMax));
%     xc = xy(1);
%     yc = xy(2);
 
    nova = im0_blur(xMin:xMax, yMin:yMax);
    
    
    [xMax, xMin, yMax, yMin] = croppedImage(subtract_dif);
%     xy = centerOfMass( im1_blur(xMin:xMax, yMin:yMax));
%     xc = xy(1);
%     yc = xy(2);
    nova1 = im1_blur(xMin:xMax, yMin:yMax);
    
    nova = nova - nova1;

    subtract_BW = im2bw(nova, graythresh(nova))*255;
     
    se = strel('diamond',5);
    
    subtract_closed = imclose(subtract_BW, se) ; 
    subtract_open = imdilate(subtract_closed, se);
 %   subtract_open = imopen(subtract_closed, se);
 
  
     
%      show_figure(subtract_open);
%    im0_blur = butterworthbpf(im0_blur,40,120,4);
%    im1_blur = butterworthbpf(im1_blur,40,120,4);
   


%    subtract_BW = im2bw(subtract_dif, graythresh(subtract_dif))*255;
  
%     se = strel('diamond',2);
%     subtract_open = imopen(subtract_BW, se);
%     subtract_closed = imclose(subtract_open, se);
%     subtract_open = imopen(subtract_closed, se);
        
%    subtract_n = subtract_BW + subtract_sobel;
%    show_figure(subtract_BW);
%     show_figure(subtract_BW);
%     filter_homomorfico(im1_blur,15,1);
    
% 
%     if(i-1 < 3)
%         subplot(FRAMES-1,2,i-1);
%     else
%         subplot(FRAMES-1,2,i-1);
%     end
%     titulo = 'imagem - '+ i;
%     imshow(nova);  


end
