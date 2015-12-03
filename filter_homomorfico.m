function [homo] = filter_homomorfico(imagem, m, n)
    
    lp = butterlp(imagem, m, n);
    af = fftshift(fft2(imagem));
    afp = af.*lp;
    aflpi = ifft2(afp);
    
    show_figure(aflpi);
end