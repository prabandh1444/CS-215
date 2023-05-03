rng(0);
clearvars;
x = zeros(10^7,1);
y = zeros(10^7,1);
% not exactly radius but a distance parameter
radius = 1;
% max value of parameter 
twopi = 2 * pi;
for i=1:10^7                         
   theta = twopi * rand();        
   r = radius * sqrt(rand());
% radius proportional to sqrt(U), U~U(0,1)
   x(i) = 2*r*cos(theta);
   y(i) = r*sin(theta);
end
histogram2(x,y,'DisplayStyle','tile');