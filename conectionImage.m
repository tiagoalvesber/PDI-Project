function [output] = conectionImage(img, img2)
    
    Ab = img-img2;
    Ba = img2-img;
    
    output = Ab + Ba;
end