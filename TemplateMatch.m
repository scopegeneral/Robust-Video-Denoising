function Ind = TemplateMatch(patch)
    global V
    
    ssd = size(size(1:4:size(V,1)-7,2)*size(1:4:size(V,2)-7,2),size(V,3));
    for t = 1:size(V,3)
        in = 1;
        for i = 1:4:size(V,1)-7
            for j = 1:4:size(V,2)-7
                ssd(in,t) = sum(sum(abs(patch-V(i:i+7,j:j+7,t))));
                in = in + 1;
            end
        end
    end
    
    Ind = zeros(5,size(V,3));
    for i = 1:size(V,3)
        [~,sortIn] = sort(ssd(:,i));
        Ind(:,i) = sortIn(1:5);
    end
    
end