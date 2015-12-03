clear;
close all;
PATH = 'seq_3/';
FRAMES = 5;


% figure;
%  subplot(FRAMES-1,2,1);
%  imshow(convert_to_grayscale(imread(strcat(PATH, num2str(1),'.jpg'))));
%%
% Temos que calcular a diferenca entre a imagem inicial fixa e corrente, 
% depois calculamos a diferença dos sobels da imagem inicial e corrente
% somamos os resulatdos entre as imagens, e calculamos o limiarização da 
% imagem resultante,depois calculamos o centro de massa em relação a imagem
% e salvamos as coordenadas, depois verificamos a direção do objeto.Para 
% reconhecer os objetos na imagem é aplicado o regionGrow encima do centro 
% de massa e econtrados os objetos separados, é aplicado um label sobre os 
% obejtos.
% 
% diferença(imagemFixa, ImagemCorrente)
% sobel(imagemFixa)
% sobel(imagemCorrente) 
% somaDasImagens(SobelFixa, SobelCorrente)
% limiariza_Otsu(ImagemSomada)
% centroMassa(ImagemLimiarizada)
% capturaCoordenadas(CentroDeMassa)
% regionGrow(Imagem) // por conta da imagem fixa os objetos são conectados
% assim basta verificar a continuidade entre os objetos.
% labelFigure(listaRegioes) // passa a lista de (x,y) de cada centro, 
%é sobre esses pontos são aplicados as labels de objetos 
%%

for i = 2:FRAMES,

    im0 = convert_to_grayscale(imread(strcat(PATH, num2str(i-1),'.jpg')));
    im1 = convert_to_grayscale(imread(strcat(PATH, num2str(i),'.jpg')));

    kernel = fspecial('average', [3 3]);
    im0_blur = imfilter(im0, kernel);
    im1_blur = imfilter(im1, kernel);

%    im0_blur = butterworthbpf(im0_blur,40,120,4);
%    im1_blur = butterworthbpf(im1_blur,40,120,4);
   
    
%    imgBttW0 = butterworthbpf(im0_blur,10,120,4);
%    imgBttW1 = butterworthbpf(im1_blur,10,120,4);
    
    
%     im0_level = graythresh(im0_blur);
%     im0_BW = im2bw(im0_blur, im0_level)*255;
% 
%     im1_level = graythresh(im1_blur);
%     im1_BW = im2bw(im1_blur, im1_level)*255;
%     
    img0_sobel = filter_sobel(im0_blur);
    img1_sobel = filter_sobel(im1_blur);

    
    subtract_sobel = uint8(img1_sobel- img0_sobel)*255;
    subtract_gray = im0_blur - im1_blur;
%    subtract = im0_BW-im1_BW;    
%     subtract = im0_blur-im1_blur; 

    subtract_dif = subtract_sobel + subtract_gray;
%     se = strel('square',10);
%     
%     subtract_closed = imclose(subtract_dif, se) ; 
%     subtract_open = imdilate(subtract_closed, se);
%  
%     subtract_closed = imclose(subtract_open, se) ; 
%     subtract_open = imdilate(subtract_closed, se);
%     
    %subtract_open = imdilate(subtract_closed, se);
%    show_figure(subtract_dif);
    
    subtract_BW = im2bw(subtract_dif, graythresh(subtract_dif))*255;
  
%     se = strel('diamond',2);
%     subtract_open = imopen(subtract_BW, se);
%     subtract_closed = imclose(subtract_open, se);
%     subtract_open = imopen(subtract_closed, se);
%    [xMax, xMin, yMax, yMin] = croppedImage(subtract_BW); 
%    subtract_BW =  insertShape(subtract_BW, 'Rectangle', [xMin yMin xMax-xMin yMax-yMin], 'LineWidth', 2);
       
%    subtract_n = subtract_BW + subtract_sobel;
%    show_figure(subtract_BW);
     show_figure(subtract_BW);
%     filter_homomorfico(im1_blur,15,1);



% teste = opticalFlowPDI(im0,im1) %HS(im0_blur, im1_blur, 0.2, 4, im0_blur, 'Teste');
% 
% show_figure(teste);

%     xMin = Inf;
%     xMax = 0;
%     
%     yMin = Inf;
%     yMax = 0;
%     
%     [h, w] = size(subtract);
%     
%     for x = 1:h,
%         for y = 1:w,
%             if(subtract(x,y) == 255),
%             
%                 if(xMin > x),
%                     xMin = x;
%                 end
%                 
%                 if(xMax < x),
%                     xMax = x;
%                 end
%                 
%                 if(yMin > y),
%                     yMin = y;
%                 end
%                 
%                 if(yMax < y),
%                     yMax = y;
%                 end
%             
%             end
%         end
%     end
%    output = insertShape(im1, 'Rectangle', [xMin yMin xMax-xMin yMax-yMin], 'LineWidth', 2);
   
%    xy = centerOfMass( im1(xMin:xMax, yMin:yMax) );
%    xc = xy(1);
%    yc = xy(2);
%    nova = subtract(xMin:xMax, yMin:yMax);
    
%   show_figure(output);
%   show_figure(subtract);
%    show_figure(mediamove(xMin:xMax, yMin:yMax));   

% if(i-1 < 3)
%     subplot(FRAMES-1,2,i-1);
% else
%     subplot(FRAMES-1,2,i-1);
% end
% titulo = 'imagem - '+ i;
% imshow(subtract_BW);  


end
