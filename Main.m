rng(1);

tic;

K = 50;                  %No of Frames
sigma = 0;
kappa = 0;
d = 0;

cd 'mmread';
Vi = mmread('../Data/1.htm');
cd ..;

global V;

[height,width,~] = size(Vi.frames(1).cdata);

V1 = zeros(height,width,K);
V = zeros(size(V1));
for i = 1:K
    V1(:,:,i) = 255.0*im2double(rgb2gray(Vi.frames(i).cdata));
    V(:,:,i) = V1(:,:,i) + sigma*randn(height,width,1);
    V(:,:,i) = V(:,:,i) + poissrnd(kappa*V1(:,:,i)) - kappa*V1(:,:,i);
    V(:,:,i) = imnoise(V(:,:,i)/255.0,'salt & pepper',d)*255.0;
    if i == 1
        fprintf("PSNR of Noisy Image = %f\n", psnr(V(:,:,1),V1(:,:,1)));
    end
    %V(:,:,i) = MedianFilter(V(:,:,i));
end

Z = zeros(size(V));     %Result
C = zeros(size(V));     %Count



[Patches,Map] = TemplatePreProcess();  %Patches


%TODO: remove impulse noise before template match

for t = 1:1
    for i = 1:4:size(V,1)-7
        for j = 1:4:size(V,2)-7
            fprintf("%d %d\n",i,j);
            patch = V(i:i+7,j:j+7,t);
            Ind = TemplateMatch(patch);
            X = zeros(64,5*size(V,3));
            for l = 1:size(Ind,2)
                X(:,(l-1)*5+1:l*5) = Patches(:,Ind(:,l),l);
            end
            %Y = reshape(X(:,26),[8,8]);
            [P,sig] = Curated(X);
            [n1,n2] = size(X);
            r = sum(P(:))/(n1*n2);
            mu = (sqrt(n1) + sqrt(n2))*sqrt(r)*sig;
            tau = 1;
            X = FixedPointIteration(P,X,mu,tau);
            X = X(:,1+5*(t-1));
            x = Map(Ind(1,t),t,1);
            y = Map(Ind(1,t),t,2);
            Z(x:x+7,y:y+7,t) = Z(x:x+7,y:y+7,t) + reshape(X,[8,8]);
            C(x:x+7,y:y+7,t) = C(x:x+7,y:y+7,t) + 1;        
        end
    end
end

Z = Z./C;
fprintf("PSNR of Denoised = %f\n", psnr(Z(:,:,1),V1(:,:,1)));
toc;


