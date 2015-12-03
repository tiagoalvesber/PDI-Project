function [out] = butterlp(img, d,n)
    out = 1- butter(img, d, n)
end