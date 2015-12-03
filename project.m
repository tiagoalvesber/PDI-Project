%%
% Temos que calcular a diferenca entre a imagem inicial fixa e corrente, 
% depois calculamos a diferença dos sobels da imagem inicial e corrente
% somamos os resulatdos entre as imagens, e calculamos o limiarização da 
% imagem resultante,depois calculamos o centro de massa em relação a imagem
% e salvamos as coordenadas, depois verificamos a direção do objeto. Para 
% reconhecer os objetos na imagem é aplicado o regionGrowing em cima do centro 
% de massa e econtrados os objetos separados, é aplicado um label sobre os 
% obejtos.
% 
%
%kalmam filtro
% detectar a imagem fixa //suavizar as imagens e realizar a diferença entre elas 
% diferença(imagemFixa, ImagemCorrente)
% sobel(imagemFixa)
% sobel(imagemCorrente) 
% somaDasImagens(SobelFixa, SobelCorrente)
% limiariza_Otsu(ImagemSomada)
% aberura e fechamento (images) // dilatar imagens 
% regionGrow(Imagem) // por conta da imagem fixa os objetos são conectados
% centroMassa(ImagemLimiarizada)
% capturaCoordenadas(CentroDeMassa)
% assim basta verificar a continuidade entre os objetos.
% labelFigure(listaRegioes) // passa a lista de (x,y) de cada centro, 
%é sobre esses pontos são aplicados as labels de objetos 
%%

%figure;
clear;
close all;
PATH = 'seq_2/';
[FRAMES, dummy] = size(dir(fullfile(PATH, '*.jpg')));
[fixed_image, fixed_frame] = detectFixedImage(PATH);

for i = fixed_frame:FRAMES,
   
    kernel = fspecial('average', [5 5]);
    im0 = convert_to_grayscale(imread(strcat(PATH, num2str(i-1),'.jpg')));
    caminho = strcat(PATH, num2str(i),'.jpg');
    im1 = convert_to_grayscale(imread(caminho));
    
    im0_blur = imfilter(im0, kernel);
    im1_blur = imfilter(im1, kernel);
    fixed_image_blur = imfilter(fixed_image, kernel);
    
    current_pair_difference = diferenceImage(im0_blur, im1_blur,25);
    
    im0_sobel = filter_sobel(im0_blur);
    im1_sobel = filter_sobel(im1_blur);
    fixed_image_sobel = filter_sobel(fixed_image_blur);
    
    dif_im1_fixed = diferenceImage( double(fixed_image_blur),double(im1_blur),25);
    dif_im1_fixed = medfilt2(dif_im1_fixed, [5 5]);
    dif_im1_fixed_sobel = filter_sobel(dif_im1_fixed);
    sobel_soma = double(dif_im1_fixed_sobel) + double(dif_im1_fixed);
    
    sobel_soma = medfilt2(sobel_soma, [5 5]);
    bw = im2bw(sobel_soma, graythresh(sobel_soma))*255;
   
    se = strel('square',3);
    closed_img = imclose(bw,se);
    show_figure(closed_img, caminho);
    %     corrente = imfilter(corrente, kernel);
    %  corrente = butterworthbpf(corrente,10,120,4);
%     sobel_corrente = filter_sobel(corrente);
%     sobel_fixa = filter_sobel(fixed_image);
    %  imshow(sobel_corrente);
%     dif_sobel = double(sobel_corrente)*255 - double(sobel_fixa)*255 ;
    %  dif_corrente = double(fixa) - double(corrente);  
%     dif_edge_corr = double(dif_corrente)*255 + dif_sobel;
    %  dif_edge_corr = medfilt2(dif_edge_corr, [7 7]);
    %  dif_edge_corr = 

%     se = strel('diamond',5);
    % otsu_dif = im2bw(dif_corrente, 0.22)*255;
    %closed_img = imclose(otsu_dif,se);
    %  open_img = imopen(closed_img,se)
    %  otsu_dif = im2bw(dif_edge_corr, graythresh(dif_edge_corr))*255;
    %        show_figure(dif_edge_corr);      

end
