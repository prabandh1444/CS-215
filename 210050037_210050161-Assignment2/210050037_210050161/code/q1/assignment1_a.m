rng(0);
clearvars;
x = zeros(5000,1);
y = zeros(5000,1);
% not exactly radius but a distance parameter
radius = 1;
% max value of parameter 
twopi = 2 * pi;
for i=1:5000                         
   theta = twopi * rand();        
   r = radius * sqrt(rand());
% radius proportional to sqrt(U), U~U(0,1)
   x(i) = 2*r*cos(theta);
   y(i) = r*sin(theta);
end
scatter(x,y);