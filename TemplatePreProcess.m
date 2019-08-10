function [Patches,Map] = TemplatePreProcess()
    global V;
    %M = zeros(size(1:4:size(V,1)-7,2)*size(1:4:size(V,2)-7,2),16,size(V,3));
    Patches = zeros(64,size(1:4:size(V,1)-7,2)*size(1:4:size(V,2)-7,2),size(V,3));
    Map = zeros(size(1:4:size(V,1)-7,2)*size(1:4:size(V,2)-7,2),size(V,3),2);
    for t = 1:size(V,3)
        in = 1;
        for i = 1:4:size(V,1)-7
            for j = 1:4:size(V,2)-7
                patch = V(i:i+7,j:j+7,t);
                Patches(:,in,t) = patch(:);
                %patchRow = sum(patch,2);
                %patchColumn = sum(patch,1);
                %template = [patchRow' patchColumn];
                %M(in,:,t) = template;
                Map(in,t,1) = i;
                Map(in,t,2) = j;
                in = in + 1;
            end
        end
    end
end