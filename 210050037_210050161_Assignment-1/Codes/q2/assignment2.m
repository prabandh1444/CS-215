rng(0);
r1=poissrnd(3,1,10^6);
r2=poissrnd(4,1,10^6);
r=r1+r2;
p_exp=zeros(25,1);
p_the=zeros(25,1);
for k=1:25
  for i=1:10^6
    if(r(i)==(k))
        p_exp(k,1)=p_exp(k,1)+1;
    end
  end
end
p_exp=p_exp/10^6;
disp(p_exp)
for x=1:25
p_the(x)=(exp(-7)*(7)^x)/(factorial(x));
end
disp(p_the)
comp=p_exp-p_the;
disp(abs(comp))



