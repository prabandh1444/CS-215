clc
% this helps in clearing all the text from the command window.

clearvars
% this helps in removing all variables from the current active workspace.

clc
% this helps in clearing all the text from the command window.

rng('default') ;
% this helps in specifying the seed in the MATLAB so that the results are consistent.
s = rng ;
% specifies the mersene twister using a seed.

b = zeros(1,100000) ;
n = zeros(1,100000) ;
for i =1:100000
    b(i) = Prob();
    n(i) = i/100000 ;
end
histogram(b,200) ;
title('Histogram')
% this results in the histogram plot of the 100000 draws of P().

m = Sorting(b) ;
% this I have sorted so that CDF(x) is proportional to No of draws < x.
figure(2)
% this is for plotting the cdf.
plot(m,n);
xlabel('x') ;
ylabel('CDF') ;
title('Cumulative Distribution Function') ;
legend('CDF','Location','northwest') ;
% CDF for Px() will be shown on screen .

B = zeros(6,10000) ;
M = [2,4,8,16,32,64] ;
for i = 1:6
    for j = 1:10000
        for k = 1:M(i)
            B(i,j) = B(i,j) + Prob() ;
        end
        B(i,j) = B(i,j)/M(i) ;
    end
    figure;
    histogram(B(i,:),900) ;
    title('Histogram') ;
end

for i=1:6
    B(i,:) = Sorting(B(i,:)) ;
end
M = ARRAY() ;
figure;
plot(m,n) ;
hold on
for i =1:6
    plot(B(i,:),M) ;
    hold on
end
xlabel('X') ;
ylabel('CDFs:Yn( )') ;
title('CDFs for different values of N ')
legend('N=1', 'N=2','N=4', 'N=8', 'N=16', 'N=32', 'N=64','Location','northwest')
% legend function creates a legend with descriptive labels for
% each plotted data series

% function ARRAY definition 
function [array] = ARRAY()
array = zeros(1,10000) ;
for l=1:10000
    array(l) = l/10000 ;
end
end

% defining a function that uses random probability generator
function PRA = Prob()
c = rand(1,2) ;
PRA = sign(randn)*max(c) ; % max(c) prints max element from the array
end
% sgn(x) function returns an array whose size same as x where each element
% of x will be replaced by signum function value of x .
% sgn(x) = 1 for x>0 ; sgn(x) = 0 for x=0 ; sgn(x) = -1 for x<0 .

% function Sorting definition
function [SORT] = Sorting(input)
SORT = sort(input) ;
end
