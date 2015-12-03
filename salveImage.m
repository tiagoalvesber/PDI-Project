function [out] = salveImage(image,name,path)
    path = strcat('../',path, '/out/')
    imwrite(image,strcat(path, num2str(name-1),'.jpg'));
end