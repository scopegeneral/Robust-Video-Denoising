function [out] = MedianFilter(image)

s = size(image);
out = image;
alpha = 26;
win = 1;
for i=2:s(1)-1
    for j=2:s(2)-1
        nld = zeros(1,8);
        vals = zeros(1,(min(i+win,s(1))-max(i-win,1))*(min(j+win,s(2))-max(j-win,1)));
        temp = 0;
        for i1=i-1:i+1
            for i2=j-1:j+1
                if not(i1==i && i2==j)
                    temp=temp+1;
                    nld(1,temp) = abs(image(i1,i2)-image(i,j));
                    vals(1,temp) = image(i1,i2);
                end
            end
        end
        temp = 0;
        for i1=max(i-win,1):min(i+win,s(1))
            for i2=max(j-win,1):min(j+win,s(2))
                    temp=temp+1;
                    vals(1,temp) = image(i1,i2);
            end
        end
        
        nld = -sort(-nld);
        vals = sort(vals);
        mtp = (nld(1)+nld(2)+nld(3)+nld(4)+nld(5))/5.0;
        ith = alpha+log2(mtp);
        if sum(nld)>=ith
            out(i,j)=vals(floor(temp/2));
        end
    end
end

end