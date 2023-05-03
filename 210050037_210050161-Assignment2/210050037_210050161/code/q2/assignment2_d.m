rng(0);
clearvars;
N=[10,10^2,10^3,10^4,10^5];
for j=1:5
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
    MLE_covariance=zeros(2,2);
    x = X(:,1);
    y = X(:,2);
    sample_mean_X = MLE_mean(1);
    sample_mean_Y = MLE_mean(2);
    MLE_covariance(1,1)=sum((x-sample_mean_X).^2)/(N(j));
    MLE_covariance(2,2)=sum((y-sample_mean_Y).^2)/(N(j));
    Z=((x-sample_mean_X).*(y-sample_mean_Y));
    MLE_covariance(1,2)=sum(Z)/(N(j));
    MLE_covariance(2,1)=MLE_covariance(1,2);
    MLE_mean=MLE_mean';
    [V1,D1] = eig(MLE_covariance);
    D1=sqrtm(D1);
    root_lamda_1=D1(1,1);
    root_lamda_2=D1(2,2);
    v1=V1(:,1)/(norm(V1(:,1)));
    v2=V1(:,2)/(norm(V1(:,2)));
    e1=MLE_mean+root_lamda_1*v1;
    e2=MLE_mean+root_lamda_2*v2;
    e3=MLE_mean-root_lamda_1*v1;
    e4=MLE_mean-root_lamda_2*v2;
    disp(e1)
    scatter(x,y)
    xlabel("x-axis")
    ylabel("y-label")
    hold on
    plot([e1(1),e3(1)],[e1(2),e3(2)])
    hold on
    plot([e2(1),e4(1)],[e2(2),e4(2)])
    hold on
    figure;
end