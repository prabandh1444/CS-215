rng(0);
clearvars;
load('../../data/points2D_Set1')
scatter(x,y);
hold on;
sample_mean_x = sum(x)/300;
sample_mean_y = sum(y)/300;
sample_mean = [sample_mean_x;sample_mean_y];
sample_covariance=zeros(2,2);
sample_covariance(1,1)=sum((x-sample_mean_x).^2)/(300);
sample_covariance(2,2)=sum((y-sample_mean_y).^2)/(300);
Z=((x-sample_mean_y).*(y-sample_mean_y));
sample_covariance(1,2)=sum(Z)/(300);
sample_covariance(2,1)=sample_covariance(1,2);
[V,D]=eig(sample_covariance);
end_point = sample_mean + V(:,2)*(1.5);
end_point_1 = sample_mean - V(:,2)*(1.5);
plot([end_point(1),end_point_1(1)],[end_point(2),end_point_1(2)])
disp(V(:,2))


