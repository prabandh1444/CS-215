rng(0);
M=100;
N=[5,10,20,40,60,80,100,500,1000,10000];
error2=zeros(M,10);
for j=1:10
  for i=1:M
      r=normrnd(0,1,N(j),1);
      avg_mean=sum(r)/N(j);
      absolute_mean=0;
      error2(i,j)=abs(avg_mean-absolute_mean);
  end
end
figure
boxplot(error2,N);
disp(error2)
