figure;
x = linspace(-50,50,10000);
z = zeros(10000,1);
a=0;
b=1;
dx=0.01;
y = (1/pi)*(1./(1+x.^2));
for i=1:10000
    for j=1:i
        z(i,1)=z(i,1)+y(j)*dx;
    end
end
plot(x,y,'r','DisplayName','PDF');
figure;
plot(x,z,'g','DisplayName','CDF');
xlabel('x');
ylabel('Cauchy');
zlabel('Cauchy');
legend;