%% Problem 1: Sobel Edge Detection

clc
clear
close

%Problem Statement: Load in the crystals image and output 4 variations of
%the crystals image, one of them should be the original image and the other
%3 variations should be different.

%Variables
%Inputs
% crystals.jpeg
%Outputs
% Original Crystal Image
% Normalized Horizontal Edges
% Normalized Vertical Edges
% Combined Vertical and Horizontal Edges

%Task 1
images = [];
images(1) = subplot(2,2,1);
images(2) = subplot(2,2,2);
images(3) = subplot(2,2,3);
images(4) = subplot(2,2,4);

crystal = imread('crystals.jpeg');

image(crystal, 'Parent', images(1))

red = crystal (:, :, 1);
green = crystal (:, :, 2);
blue = crystal (:, :, 3); 

Red = 0.2989.*red;
Green = 0.5870.*green;
Blue = 0.1140.*blue;
intensity = Red + Green + Blue;

Gray = cat (3, intensity, intensity, intensity);

%Task 2
HorizontalMatrix = [-1, -2, -1; 0, 0, 0; 1, 2, 1];
Vertical = [-1, 0, 1; -2, 0, 2; -1, 0, 1];

%Task 3
test = im2double(Gray);

HorzConv = conv2((double(intensity)), (double(HorizontalMatrix)));
VertConv = conv2((double(intensity)), (double(Vertical)));

arg1 = HorzConv.^2 + VertConv.^2;
arg2 = arg1.^0.5;

image(arg2, 'Parent', images(3));

image(HorzConv, 'Parent', images(2))
image(VertConv, 'Parent', images(4))


%% Problem 2: Where's Waldo?

clc
clear
close

%Problem Statement: Create a function that would find the small image's
%location in the bigger image in order to find Waldo

%Variables
%Inputs
% Waldo Image
% Background Image
%Outputs
% Red square around Waldo in bigger image
% Waldo's location

clc
clear
close

%Task1 
Waldo = imread('P2_Waldo2.png');
Image = imread('P2_wheresWaldo2.jpg'); 

[row1, col1 , layer1] = size(Waldo);
[row2, col2, layer2] =size(Image);  


if col2 < col1 || row2 < row1

    error('The background image has smaller dimensions than the Waldo image.');

end 

%Task2 
[topLeft,botLeft,topRight,botRight] = findWaldo(Waldo,Image,row1,col1,row2,col2);

%Task3
fprintf('Waldo can be found between y = %0.0f & %0.0f and x = %0.0f & %0.0f.',topLeft,botLeft,topRight,botRight);
