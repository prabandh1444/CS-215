clearvars;                                                                             % clears the variables from the memory .


index = 19200 ;
ind = 1 ;
index_one = 1;
count = 1 ;
index_two = 1;
standard_array = zeros(index,16);
sum_one = zeros(index,index_one); 
sum_two = zeros(index,index_two);
arr = zeros(index,16);
  

for index_one=1:16                                                                      % loop through each of the 16 images, goal is to find mean
    file = ['../../data/data_fruit/image_' num2str(index_one) '.png'];                  % to store the location of the image
    img = imread(file);                                                                 % reads the image file present at given location
    img_new = double(reshape(img,[19200,1]));                                           % image after being rescaled to a vector of length 19200
    sum_one = sum_one + img_new;                                                        % array to store sums of all elements belonging to a particular column across the 16 images
end
mean = sum_one/16;                                                                      % this array now stores mean of all images


for index_two=1:16                                                                      % loop through each of the 16 images, goal is to find standard deviation
    file = ['../../data/data_fruit/image_' num2str(index_two) '.png'];                  % to store the location of the image
    img = imread(file);                                                                 % reads the image file present at given location
    img_new = double(reshape(img,[19200,1]));                                           % image after being rescaled to a vector of length 19200
    sum_two = sum_two + (img_new-mean).^2;                                              % array to store sigma(element-mean)^2
    arr(:,index_two) = img_new;                                                         % matrix stores all the images after being resized to 19200✕1 vector, with all the data of each image in respective column
end


standard_deviation = sqrt(sum_two/16);                                                  % this array now stores standard deviations for all images
while index>=1                                                                          % loop through all 19200 rows, goal is to find the standardized matrix
    standard_array(19201-index,:) = (arr(19201-index,:)-mean(19201-index))/standard_deviation(19201-index);                             % matrix is standardized if each element is replaced with (element-mean)/(standard deviation)
    index = index - 1 ;
end

matrix = standard_array*transpose(standard_array);
covariance_matrix = matrix/16;                                                          % our covariance matrix whose dimensions are 19200✕19200
[V,D] = eigs(covariance_matrix,4);                                                      % finds and stores the 4 largest eigenvalues in descending order in diagonal of matrix D, and corresponding eigenvectors in V 

subplot(2,3,1)                                                                          % using the MATLAB function subplot() to draw images side by side as instructed, first image in the series
image(rescale(reshape(mean,[80,80,3])))                                                 % this draws our Mean Image
title('Mean Image');                                                                    % specifying the title


while count<=4
    name = ['Eigenvalue # ' num2str(count) ' => Image'];                                   % using this since my title includes usage of variables
    subplot(2,3,count+1)                                                                   % second, third, fourth and fifth images in the series are thus printed side by side by the end of this for loop
    image(rescale(reshape(V(:,count),[80,80,3])))                                          % this draws each of our Eigenvector Images one by one
    title(name);                                                                        % specifying the title
    count = count + 1 ;
end


eigen_values = eigs(covariance_matrix,10);                              % array stores the 10 largest eigenvalues in descending order
x = 1:1:10;
figure;                                                                 % draws the following plot in a new figure
plot(x,eigen_values,'linestyle','none','marker','o','linewidth',2);     % plots just the Eigenvalues using the marker 'o' and with double the usual thickness and with no lines joining these points
title(' Top 10 Eigen Values ');                                         % specifying the title
xlabel('<-- N -->','FontWeight','bold');                                % specifying the label for x-axis, and font style
ylabel('<- EigenValue ->','FontWeight','bold');                         % specifying the label for y-axis, and font style


% we find the closest representation of the original fruit image from a linear combination of mean and 4 eigenvectors. In the following for loop, we first find what the co-efficients 
% for linear combination should be, and then we display thus produced image

index_two = index_two - 15 ;
while index_two<=16
    name1 = ['Original Image - ' num2str(index_two)];                          % using variables name1 and name2 since the title includes usage of variables
    name2 = ['Closest Representation Of Image - ' num2str(index_two)];
    figure;                                                            % draws plots for each iteration of for loop in a new figure
    subplot(2,2,1)
    image(rescale(reshape(arr(:,index_two),[80,80,3])))                        % displays the original fruit image
    title(name1);                                                      % specifying the title
    mean_one = transpose(mean)*V(:,1);                                    % scalar that is obtained by dot product of mean array and 1st eigenvector
    mean_two = transpose(mean)*V(:,2);                                    % scalar that is obtained by dot product of mean array and 2nd eigenvector
    mean_three = transpose(mean)*V(:,3);                                    % scalar that is obtained by dot product of mean array and 3rd eigenvector
    mean_four = transpose(mean)*V(:,4);                                    % scalar that is obtained by dot product of mean array and 4th eigenvector
    mean_five = transpose(arr(:,index_two))*mean;                                  % scalar that is obtained by dot product of this particular image array and mean array
    mean_six = transpose(mean)*mean;                                      % scalar representing the dot product of mean array with itself
    eigen_one = transpose(arr(:,index_two))*V(:,1);                               % scalar that is obtained by dot product of this particular image array and 1st eigenvector
    eigen_two = transpose(arr(:,index_two))*V(:,2);                               % scalar that is obtained by dot product of this particular image array and 2nd eigenvector
    eigen_three = transpose(arr(:,index_two))*V(:,3);                               % scalar that is obtained by dot product of this particular image array and 3rd eigenvector
    eigen_four = transpose(arr(:,index_two))*V(:,4);                               % scalar that is obtained by dot product of this particular image array and 4th eigenvector
    dummy = (mean_five-(eigen_one*mean_one)-(eigen_two*mean_two)-(eigen_three*mean_three)-(eigen_four*mean_four))/((mean_six-(mean_one)^2-(mean_two)^2-(mean_three)^2-(mean_four)^2));     % co-efficient of mean
    img = (dummy*mean)+((eigen_one-(dummy*mean_one))*V(:,1))+((eigen_two-(dummy*mean_two))*V(:,2))+((eigen_three-(dummy*mean_three))*V(:,3))+((eigen_four-(dummy*mean_four))*V(:,4));    % a 19200✕1 array containing 
                                                                                                                                             % all the data of closest representation image
    subplot(2,2,2)
    image(rescale(reshape(img,[80,80,3])))                             % displays the closest representation of the original fruit image
    title(name2);                                                      % specifying the title
    index_two = index_two + 1 ;
end


array = [7,11,16];                                                     % ill be using the 7th, 11th and 16th images and ofcourse, the mean and 4 principle eigenvectors to produce my new fruit images
while ind<4 
    sum_three = zeros(19200 ,1);                                                                    % we iterate through each of the following steps thrice, in order to produce 3 new fruit images
    k = array(ind);
    weights = zeros(4,1);
    vector = arr(:,k)-mean(k);                                         % subtract the mean in order to normalize the data

    m = 1 ;
    while m<=4
        weights(m) = transpose(vector)*V(:,m);  % these are scalars that well be multiplying with respective eigen vectors to form our linear combination of mean and eigenvectors
        m = m + 1 ;
    end

    m = m - 4 ;
    while m<5
        sum_three = sum_three + (weights(m)*V(:,m));
        m = m + 1;
    end

    img = mean + sum_three;                                                 % mean value of images subtracted when data was normalized earlier has to be added, we thus have a 19200✕1 array containing all the data of a new image
    name = ['Newly Generated Image - ' num2str(ind)];                  % using this since my title includes usage of variables
    figure;                                                            % draws plots for each iteration of for loop in a new figure
    image(rescale(reshape(img,[80,80,3])))                             % displays our 3 new fruits which have been formed by using data of all 16 original fruits by the end of the for loop
    title(name);                                                       % specifying the title

    ind = ind + 1 ;

end
