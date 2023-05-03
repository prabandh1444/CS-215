rng(0);
clearvars;
N=[5, 10, 20, 40, 60, 80, 100, 500, 10^3, 10^4];
M=200;
lamda_true = 5;
error_mle=zeros(M,10); 
error_pm=zeros(M,10);
for i=1:10
    for j=1:200
        z = rand([1,N(i)]);
        z = (-1/lamda_true)*log(z);
        %%%%%%%%% Maximun_likelyhood %%%%%%%%
        MLE_lamda = (N(i))/(sum(z));
        error_mle(j,i)=abs(MLE_lamda-lamda_true)/(lamda_true);
        %%%%%%%%% prior 1 %%%%%%%%%%
        alpha = 5.5;
        beta = 1;
        MAP = (alpha + N(i))/(beta + sum(z));
        error_pm(j,i)=abs(MAP-lamda_true)/(lamda_true);
    end
end
boxplot(error_mle,N);
figure;
boxplot(error_pm,N);