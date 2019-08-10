function X = SoftThreshold(A,c)
    X = zeros(size(A));
    [U,S,V] = svd(A);
    for i = 1:min(size(S,1),size(S,2))
        if S(i,i) > c
            X = X + U(:,i)*(S(i,i)-c)*V(:,i)';
        end
    end
end