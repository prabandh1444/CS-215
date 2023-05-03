rng(0);
Y=poissrnd(4,1,10^5);
Z=zeros(1,10^6);
p_exp=zeros(25,1);
p_the=zeros(25,1);
p=0.8;
for i=1:10^5
    Z(1,i)=binornd(Y(1,i),p);
end
for k=1:25
  for i=1:10^5
    if(Z(1,i)==(k))
        p_exp(k,1)=p_exp(k,1)+1;
    end
  end
end
p_exp=p_exp/10^5;
disp(p_exp)
for x=1:25
p_the(x)=(exp(-3.2)*(3.2)^x)/(factorial(x));
end
disp(p_the)
comp=p_exp-p_the;
disp(abs(comp))