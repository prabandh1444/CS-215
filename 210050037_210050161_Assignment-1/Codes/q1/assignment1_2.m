figure;
x = linspace(-50,50,10000);
z = zeros(10000,1);
a=1;
b=2;
dx=0.01;
y = (1/b)*exp(-(((x-a)/b)+exp(-(x-a)/b)));
for i=1:10000
    for j=1:i
        z(i,1)=z(i,1)+y(j)*dx;
    end
end
mean=0;
for i=1:10000
    mean=mean+x(i)*y(i)*dx;
end

var=0;
for i=1:10000
    var=var+(y(i)*(x(i)-mean)^2)*dx;
end

plot(x,y,'r','DisplayName','PDF');
figure;
plot(x,z,'g','DisplayName','CDF');
xlabel('x');
ylabel('Gumbel');
zlabel('Gumbel')
xlim([-5,20]);
legend;
disp(var)