rng(0);
clearvars;
M=100;
error=zeros(M,5);
N=[10,10^2,10^3,10^4,10^5];
for j=1:5
  for k=1:M
    X=zeros(N(j),2);
    % taking N samples
    for i=1:N(j)
        W=[randn();randn()];
        % generating two iids as x and y
        C=[1.6250,-1.9486;-1.9486,3.8750;];
        mu=[1;2];
        [V,D] = eig(C);
        % eigen decomposition of C
        A=V*sqrtm(D);
        % A is found
        x=A*W+mu;
        % samples are created
        X(i,1)=x(1);
        X(i,2)=x(2);
    end
    MLE_mean = sum(X)/(N(j));
    MLE_mean=MLE_mean';
    error(k,j)=(norm(mu-MLE_mean))/norm(mu);
  end
end
boxplot(error,log10(N));
