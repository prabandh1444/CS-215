rng(0);
M=100;
N=[5,10,20,40,60,80,100,500,1000,10000];
error1=zeros(M,10);
for j=1:10
  for i=1:M
      r=rand(N(j),1);
      avg_mean=sum(r)/N(j);
      absolute_mean=0.500;
      error1(i,j)=abs(avg_mean-absolute_mean);
  end
end
figure
boxplot(error1,N);
disp(error1)








