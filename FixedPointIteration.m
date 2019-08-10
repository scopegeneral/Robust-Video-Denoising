function newQ = FixedPointIteration(P,X,mu,tau)
    oldQ = zeros(size(X));
    
    for i = 1:30
        R = oldQ - tau*P.*(oldQ-X);
        newQ = SoftThreshold(R,mu*tau);
        error = sum(sum((oldQ-newQ).^2));
        %fprintf("=======error = %f========\n",error);
        if error <= 1e-5
            break;
        end
        oldQ = newQ;
    end
end