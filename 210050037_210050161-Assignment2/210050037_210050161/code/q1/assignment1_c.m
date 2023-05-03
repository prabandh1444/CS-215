rng(0);
clearvars;
p1=[0,0];
p2=[pi,0];
p3=[pi/3,exp(1)];
x = zeros(5000,1);
y = zeros(5000,1);
a = p2-p1;
b = p3-p1;
for i=1:5000
    u1=rand();
    u2 =rand();
    if(u1+u2>1)
        u1=1-u1;
        u2=1-u2;
    end
    w = p1+a*u1+b*u2;
    x(i)=w(1);
    y(i)=w(2);
end
scatter(x,y);
