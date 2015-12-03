function [object]  = inspectImage (imagem, d)

   [h,w] = size(imagem);
   
   total = h*w*255;
   
   soma = sum(imagem(:));    
   prob = soma / total;
   if(prob > d)
       object = true;
   else
       object = false;
   end
        
end