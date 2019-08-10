function res = psnr(A,B)
    res = sum(sum((A-B).^2));
    res = 10*log(255^2/res)/log(10);
end