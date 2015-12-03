function [u,v] = opticalFlow(imagem1, imagem2, raio)
    [fx, fy, ft] = derivateImages(imagem1, imagem2);
    u = zeros(size(imagem1));
    v = zeros(size(imagem2));
   
    for i = 1 + raio: size(fx,1) - raio
        for j = 1 + raio: size(fx,2) - raio
        
              correntFx = fx(i-raio:i+raio,j-raio:j+raio);
              correntFy = fy(i-raio:i+raio,j-raio:j+raio);
              correntFt = ft(i-raio:i+raio,j-raio:j+raio);
                            
              correntFx = correntFx';
              correntFy = correntFy';
              correntFt = correntFt';
              
              correntFx = correntFx(:);
              correntFy = correntFy(:);
              correntFt = -correntFt(:);
              
              A = [correntFx  correntFy];
              U = pinv(A'*A)*A'*correntFt;
              
              u(i,j) = U(1);
              v(i,j) = U(2);
        end
    end
end