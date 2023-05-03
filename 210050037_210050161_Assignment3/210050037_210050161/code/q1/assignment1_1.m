rng(0);
clearvars;
N=[5, 10, 20, 40, 60, 80, 100, 500, 10^3, 10^4];
M=200;
mu_true = 10;
error_mle=zeros(M,10); 
error_map1=zeros(M,10);
error_map2=zeros(M,10);
for i=1:10
    for j=1:200
        z = normrnd(10,4,[1,N(i)]);
        sigma_true = 4;
        %%%%%%%%% Maximun_likelyhood %%%%%%%%
        MLE_mean = sum(z)/(N(i));
        error_mle(j,i)=abs(MLE_mean-mu_true)/(mu_true);
        %%%%%%%%% prior 1 %%%%%%%%%%
        sigma_prior = 1;
        mean_prior = 10.5;
        MAP_1 = (sigma_prior^2*MLE_mean+(mean_prior*(sigma_true)^2)/(N(i)))/(sigma_prior^2+(sigma_true)^2/(N(i)));
        error_map1(j,i)=abs(MAP_1-mu_true)/(mu_true);
        %%%%%%%%%%% prior 2 %%%%%%%%%
        a = 9.5;
        b = 11.5;
        if(MLE_mean<a)
            MAP_2=a;
        elseif(MLE_mean>b)
            MAP_2 = b;
        else 
            MAP_2 = MLE_mean;
        end
        error_map2(j,i)=abs(MAP_2-mu_true)/(mu_true);
    end
end
boxplot(error_mle,N);
figure;
boxplot(error_map1,N);
figure;
boxplot(error_map2,N);