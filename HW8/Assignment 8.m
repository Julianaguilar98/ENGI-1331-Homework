%% Problem 1: Area between curves

clc
clear
close

%Problem Statement: Calculate the Riemann sums for each function then 
%output a table that includes areas for each function, Riemann sums for 
%Left Hand, Right Hand, and Middle Point, and the function with higher 
%left edge and the funciton with higher right edge for each row. 

%Variables:
%Inputs
% Number of rectangles
%Outputs
% Riemann Sums for Left Hand
% Riemann Sums for Right Hand
% Riemann Sums for Middle Point
% Areas

%Task 1
load('area_data.csv')

A = area_data(:, 1);
B = area_data(:, 2);
C = area_data(:, 3);
M = area_data(:, 4);
N = area_data(:, 5);
Z = area_data(:, 6);
W = area_data(:, 7);

[r, c] = size(area_data);

int1 = [];
int2 = [];
int3 = [];
int4 = [];

for i = 1:r
    A = area_data(i, 1);
    B = area_data(i, 2);
    C = area_data(i, 3);
    M = area_data(i, 4);
    N = area_data(i, 5);
    Z = area_data(i, 6);
    W = area_data(i, 7);
fn2left = fzero(@(x) intersect1(x,A,B,C,M,N), 0);
int1(i,1) = fn2left;
fn2right = fzero(@(x) intersect1(x,A,B,C,M,N), 3);
int2(i,1) = fn2right;
fn3left = fzero(@(x) intersect2(x,A,B,C,Z,W), 0);
int3(i,1) = fn3left;
fn3right = fzero(@(x) intersect2(x,A,B,C,Z,W), 3);
int4(i,1) = fn3right;
end

for i = 1:r
    IntersectWidth1(i,1) = int2(i) - int1(i);
    IntersectWidth2(i,1) = int4(i) - int3(i); 
end

LeftEdge = [];
RightEdge = [];
for i = 1:r
    if int1(i) < int3(i)
        LeftEdge = [LeftEdge; '3'];
    else
        LeftEdge = [LeftEdge; '2'];
    end
    if int2(i) > int4(i)
        RightEdge = [RightEdge; '3'];
    else
        RightEdge = [RightEdge; '2'];
    end
end

%Task 2
rectangles = input('Enter the number of rectangles when computing Riemann sum: ');

fn2Area = [];
fn3Area = [];

for i = 1:r
    A = area_data(i, 1);
    B = area_data(i, 2);
    C = area_data(i, 3);
    M = area_data(i, 4);
    N = area_data(i, 5);
    Z = area_data(i, 6);
    W = area_data(i, 7);
fn2areas = integral (@(x) func2(x,M,N), int1(i), int2(i));
fn3areas = integral (@(x) func3(x,Z,W), int3(i), int4(i));

fn2Area = [fn2Area; fn2areas];
fn3Area = [fn3Area; fn3areas];
end

xValues = [];
for i = 1:r
Values = linspace(int1(i), int2(i), rectangles+1);
xValues = [xValues; Values];
end

[j, k] = size(xValues);

results1 = [];
for i = 1:r
test = [];
    M = area_data(i, 4);
    N = area_data(i, 5);
    
  
for j = 1:k-1
          test = [test, M*xValues(i,j) + N];
end

test2 = sum(test);
test3 = (IntersectWidth1(i)/rectangles)*test2;
results1 = [results1, test3];
end

results2 = [];
for i = 1:r
test = [];
    M = area_data(i, 4);
    N = area_data(i, 5);
    
  
for j = 2:k
          test = [test, M*xValues(i,j) + N];
end

test2 = sum(test);
test3 = (IntersectWidth1(i)/rectangles)*test2;
results2 = [results2, test3];
end

xValues = [];
for i = 1:r
Values = linspace(int3(i), int4(i), rectangles+1);
xValues = [xValues; Values];
end

[j, k] = size(xValues);

results3 = [];
for i = 1:r
test = [];
    Z = area_data(i, 6);
    W = area_data(i, 7);
    
  
for j = 1:k-1
          test = [test, Z*xValues(i,j) + W];
end

test2 = sum(test);
test3 = (IntersectWidth2(i)/rectangles)*test2;
results3 = [results3, test3];
end

results4 = [];
for i = 1:r
test = [];
    Z = area_data(i, 6);
    W = area_data(i, 7);
    
  
for j = 2:k
          test = [test, Z*xValues(i,j) + W];
end

test2 = sum(test);
test3 = (IntersectWidth2(i)/rectangles)*test2;
results4 = [results4, test3];
end


%Task 3
fprintf('Area fn2\tLH\tRH\tMP\tArea fn3\tLH\tRH\tMP\tLeft edge\tRight edge\t\n')
for i = 1:r
    fprintf('%0.02f\t\t%0.02f\t%0.02f\t%0.02f\t%0.02f\t\t%0.02f\t%0.02f\t%0.02f\tFn%s\t\tFn%s\t\n', fn2Area(i), results1(i), results2(i), fn2Area(i), fn3Area(i), results3(i), results4(i), fn3Area(i), LeftEdge(i), RightEdge(i))  
end

%Extra Credit

Input = input(sprintf('\nChoose a row number to graph from ranging from 1 to %d: ', r));

%functions
function [y] = func1 (x,A,B,C)
y =  A.*x.^2 + B*x + C;
end

function [y] = func2 (x,M,N)
y = M.*x + N;
end

function [y] = func3 (x,Z,W)
y = Z.*x + W;
end

function [y] = intersect1(x,A,B,C,M,N)
y =  func1(x,A,B,C) - func2(x,M,N);
end

function [y] = intersect2(x,A,B,C,Z,W)
y = func1(x,A,B,C) - func3(x,Z,W);
end


