
rng(0);
clearvars;
load("../../data/mnist.mat")
axis equal;
digits_train = cast(digits_train,"double");
mean_matrix = zeros(28^2,10);
covariance_Matrix = zeros(28^2,28^2,10);
number_matrix = zeros(10,1);
eigen_mat=zeros(784,784,10);
PCA_matrix = zeros(784,10);
max_eigen = zeros(10,1);
for i=1:60000
    B = reshape(digits_train(:,:,i),[],1);
    mean_matrix(:,labels_train(i)+1)=mean_matrix(:,labels_train(i)+1)+B;
    number_matrix(labels_train(i)+1)= number_matrix(labels_train(i)+1)+1;
end
for i=1:10
    mean_matrix(:,i)=mean_matrix(:,i)/number_matrix(i);
    C = reshape(mean_matrix(:,i),[],28);
end
% Creating a Covariance Matrix
for i=1:60000
     B = reshape(digits_train(:,:,i),[],1);
     B=B-mean_matrix(:,labels_train(i)+1);
     covariance_Matrix(:,:,labels_train(i)+1)= covariance_Matrix(:,:,labels_train(i)+1)+B*B';
end

for i=1:10
    covariance_Matrix(:,:,i)=covariance_Matrix(:,:,i)/(number_matrix(i));
    e = eig(covariance_Matrix(:,:,i));
    [V,D]=eig(covariance_Matrix(:,:,i));
    max_eigen(i)=e(784);
    eigen_mat(:,:,i)=V;
    %scatter(e*0+i-1,e)
    %hold on;
    PCA_matrix(:,i)=V(:,784);
end
digits_train_modified = zeros(28,28,60000);
for i=1:60000
    B = reshape(digits_train(:,:,i),[],1);
    C=eigen_mat(:,:,labels_train(i)+1);
    B = C'*B;
    B(1:700)=0;
    B=C*B;
    digits_train_modified(:,:,i)=reshape(B,[],28);
end
%%
N=[1,2,3,4,5,6,8,14,16,18];
for i=1:10
    axis equal;
    subplot(1,2,1);
    imagesc(digits_train_modified(:,:,N(i)));
    subplot(1,2,2);
    imagesc(digits_train(:,:,N(i)));
    figure
end