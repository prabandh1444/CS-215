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
%%
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
%%
for i=1:10
    P0 = mean_matrix(:,i) + sqrt(max_eigen(i))*PCA_matrix(:,i);
    P1 = mean_matrix(:,i) - sqrt(max_eigen(i))*PCA_matrix(:,i);
    P2 = mean_matrix(:,i);
    P0=reshape(P0,[],28);
    P1=reshape(P1,[],28);
    P2=reshape(P2,[],28);
    subplot(1,3,1);
    axis equal;
    imagesc(P1);
    subplot(1,3,2);
    imagesc(P2);
    subplot(1,3,3);
    imagesc(P0);
    figure;
end
