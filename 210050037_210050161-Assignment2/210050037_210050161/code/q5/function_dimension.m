function projection = function_dimension(basis,X)
Y=basis'*X;
projection=Y(701:784);
end