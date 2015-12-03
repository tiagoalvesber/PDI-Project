function [histogram] = histogramImage(image)
    [altura, largura] = size(image);
    histogram = zeros(256,1);
    image = uint8(image);
    for i =1: altura,
        for j = 1: largura,
            pixel = image(i,j);
            histogram(pixel+1) = histogram(pixel+1) + 1; 
        end 
    end

    total = largura*altura;

    probabilidades = histogram/total;
    histogram = cumsum(probabilidades) * 255;

end