%%
% Temos que calcular a diferenca entre a imagem inicial fixa e corrente, 
% depois calculamos a diferen�a dos sobels da imagem inicial e corrente
% somamos os resulatdos entre as imagens, e calculamos o limiariza��o da 
% imagem resultante,depois calculamos o centro de massa em rela��o a imagem
% e salvamos as coordenadas, depois verificamos a dire��o do objeto. Para 
% reconhecer os objetos na imagem � aplicado o regionGrowing em cima do centro 
% de massa e econtrados os objetos separados, � aplicado um label sobre os 
% obejtos.
% 
%
%kalmam filtro
% detectar a imagem fixa //suavizar as imagens e realizar a diferen�a entre elas 
% diferen�a(imagemFixa, ImagemCorrente)
% sobel(imagemFixa)
% sobel(imagemCorrente) 
% somaDasImagens(SobelFixa, SobelCorrente)
% limiariza_Otsu(ImagemSomada)
% aberura e fechamento (images) // dilatar imagens 
% regionGrow(Imagem) // por conta da imagem fixa os objetos s�o conectados
% centroMassa(ImagemLimiarizada)
% capturaCoordenadas(CentroDeMassa)
% assim basta verificar a continuidade entre os objetos.
% labelFigure(listaRegioes) // passa a lista de (x,y) de cada centro, 
%� sobre esses pontos s�o aplicados as labels de objetos 
%%

%figure;
clear;
close all;
PATH = 'seq_1/';
[FRAMES, dummy] = size(dir(fullfile(PATH, '*.jpg')));
[fixed_image, fixed_frame] = detectFixedImage(PATH);
OUT_PATH = strcat(datestr(now),'/');
mkdir(OUT_PATH);
delete(strcat(OUT_PATH, '/*.jpg'));
for i = fixed_frame:FRAMES-1,
   
    kernel = fspecial('average', [7 7]);
    im0 = convert_to_grayscale(imread(strcat(PATH, num2str(i-1),'.jpg')));
    caminho = strcat(PATH, num2str(i),'.jpg');
    im1 = convert_to_grayscale(imread(caminho));
    
    im0_blur = imfilter(im0, kernel);
    im1_blur = imfilter(im1, kernel);
    fixed_image_blur = imfilter(fixed_image, kernel);
    
    current_pair_difference = diferenceImage(im0_blur, im1_blur,10);
    
    im0_sobel = filter_sobel(im0_blur);
    im1_sobel = filter_sobel(im1_blur);
    fixed_image_sobel = filter_sobel(fixed_image_blur);
    
    dif_im1_fixed = diferenceImage( double(fixed_image_blur),double(im1_blur),25);
    dif_im1_fixed = medfilt2(dif_im1_fixed, [5 5]);
    dif_im1_fixed_sobel = filter_sobel(dif_im1_fixed);
    sobel_soma = double(dif_im1_fixed_sobel) + double(dif_im1_fixed);
    
    sobel_soma = medfilt2(sobel_soma, [5 5]);
    bw = im2bw(sobel_soma, graythresh(sobel_soma))*255;
   
    se = strel('disk',10);
    se3x3 = strel('disk',7);
    
    closed_img = imclose(bw,se);
%     closed_img = imerode(closed_img,se3x3);

    
%     show_figure(closed_img, caminho);
    output = im1;
    label=bwlabel(closed_img);
    for(j=1:max(max(label)))
        [xMax, xMin, yMax, yMin] = croppedImage((label==j)*255); 
        
        xy = centerOfMass( im1(xMin:xMax, yMin:yMax) );
        xc = xy(1);
        yc = xy(2);
        
        output = insertShape(output, 'Rectangle', [yMin xMin yMax-yMin xMax-xMin], 'LineWidth', 1);
        
        output = insertText(output,[yc+yMin, xc+xMin], strcat('o', num2str(j)));
        
    end
    imwrite(output, strcat(OUT_PATH, num2str(i),'.jpg'));

%     show_figure(, caminho);
end
