%%
%  autor - Tiago Alves
%  data - 02-10-2015
%  
%  campos - 
%           img  - imagem passada
%           n - tamanho da janela
%%

function [niblack] = niblackPDI(img, raio, alfa)
    
    tic();
    imagem = double (img);
    resultado = zeros(size(imagem));
    for i = 1 + raio: size(imagem,1) - raio,
       for j = 1 + raio: size(imagem,2) -raio,
            pixel = imagem(i,j);                   
            window = imagem(i-raio:i+raio, j-raio:raio+j);
            desvio = std(window(:));
            media = mean(window(:));
        
            limiar = media + alfa*desvio;
            
            if(pixel >= limiar)
                limiar = 1;
            else
                limiar = 0;
            end
               
            resultado(i,j) = limiar;
        end
    end
    resultado = mat2gray(resultado);
    niblack = resultado;
    tic();
    
end