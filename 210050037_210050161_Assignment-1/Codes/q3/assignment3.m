R = randi([0,1],10000,1000);
rng(0);
R=2*R-1;
z=sum(R,2);
z=z*0.001;
hist(z,100)
x=1:1000;
y = zeros(1000,1000);
for i=1:1000
    for j=1:1000
        for k=1:j
            y(i,j)=y(i,j)+R(i,k);
        end
    end
end
figure;
y=y*0.001;
for i=1:1000
   plot(x,y(i,:));
   hold on;
end
emp_mean=sum(z,"all")/10000;
var=0;
for i=1:10000
    var=var+((z(i)-emp_mean)^2/10000);
end
disp(var);
disp(emp_mean);


