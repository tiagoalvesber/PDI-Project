%%
% histograma da imagem e verifa as baixas frequencias, caso tenha uma
% grande quantidade usar o limar e atribuir o valor 0 a esses valores
% baixos.
% 1mg 
%  - calcular Histograma
%  - verificar as baixas frequencias e comparar com um limiar 
%%
function [dif] = diferenceImage(img1, img2, s)
 %   img1 =  butterworthbpf(img1 ,40,120,4);
 %   img2 =  butterworthbpf(img2 ,40,120,4);
    dif = uint8(img1) - uint8(img2);      
    for i = 1: size(dif,1),
        for j = 1: size(dif,2),            
            if(s >  dif(i,j))
                dif(i,j) = 0;
            else              
        end
    end

end