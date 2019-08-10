function [P,sig] = Curated(A)
   sigma = sqrt(var(A,1,2)); %normalised by no of observations
   meanA = mean(A,2);
   P = (A - meanA <= 2*sigma).*(A - meanA >= -2*sigma);
   sig = sum(sigma)/size(sigma,1);
end