function [mediana] = filter_median(imagem, raio)

    vector = zeros(raio*raio);
    for i = 1 + raio: size(imagem,1)-raio
         for j = 1 + raio: size(imagem,2) -raio,
               windows = imagem(i-raio:i+raio, j-raio:raio+j);
         end
    end
end