    global M;
    patchRow = sum(patch,2);
    patchColumn = sum(patch,1);
    template = [patchRow' patchColumn];
    templateSSD = M - template;
    templateSSD = templateSSD.^2;
    templateSSD = sum(templateSSD,2);
    
    Ind = zeros(5,size(M,3));
    for i = 1:size(M,3)
        [~,sortIn] = sort(templateSSD(:,:,i));
        Ind(:,i) = sortIn(1:5);
    end
    