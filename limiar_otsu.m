function [otsu] = limiar_otsu(image)
  
    [altura, largura] = size(image);
    histograma = zeros(256,1);

    for i =1: altura,
        for j = 1: largura,
            pixel = imgGray(i,j);
            histograma(pixel+1) = histograma(pixel+1) + 1; 
        end 
    end

    total = largura*altura;

    probabilidades = histograma/total;
    novos = cumsum(probabilidades) * 255;


end