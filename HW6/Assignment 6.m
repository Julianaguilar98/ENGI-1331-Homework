%% Problem 1: Statistics using limited built- in functions

clc
clear
close

%Problem Statement: Be able to find the mean and median of a vector without
%using built-in functions and display the results to command window.

%Variables:
%Input
% Vector
%Outputs
% Mean
% Median

%Task 1
Vector = csvread('Vector1_P1.csv');
[Row, Col] = size(Vector);
while (isvector(Vector) ~= 1) || (isstring(Vector) == 1) || (Row*Col == 1)
    warning('Data is not a vector')
    Vector = input('Enter a new vector: ');
    [Row, Col] = size(Vector);
end

%Task 2
Length = length(Vector);

total = 0;
for i = 1:Length
    total = total+Vector(i);
end

Mean = total/Length;

%Task 3
for r = 1:Length
    for c = 1:Length
        if Vector(r) < Vector(c)
            test = Vector(r);
            Vector(r) = Vector (c);
            Vector(c) = test;
        end
    end
end

if mod(Length, 2) == 0 
    Length1 = Length/2;
    Length2 = Length1 + 1;
    Value1 = Vector(Length1);
    Value2 = Vector(Length2);
    Median = (Value1 + Value2)/2;
    fprintf('The median is between the two middle positions of the vector\n\n')
elseif mod(Length, 2) == 1
    Length = Length/2;
    Length = Length + 0.5;
    Median = Vector(Length);
end

%Task 4
fprintf('Basic Statistics\n')
fprintf('Median:\t%0.2f\n', Median) 
fprintf('Mean:\t\t%0.2f\n\n', Mean)

if Mean > Median
    fprintf('The mean is greater than the median\n') 
elseif Mean < Median
    fprintf('The median is greater than the mean\n')
else
    fprintf('The mean is equal to the median\n')
end

%% Problem 2: Solar Cell Failures

clc
clear
close

%Problem Statement: Find the failed cells and output them intoa csv file

%Variables:
%Input
% Percent Difference
%Output
% Failed Cells

%Task 1
Matrix = csvread('Problem2.csv');
[Row, Col] = size(Matrix);

for r = 1:Row
    for c = 1:Col
        while Matrix(r,c) > 1000 || Matrix(r,c) < 0
           Matrix(r,c) = input(sprintf('Please replace Cell (%d,%d) with a new value: ', r, c));
        end
    end     

end
%Task 2
input = input('Enter the Percentage Difference check for failed cells: ');
Percentage = zeros(200,50);

for a = 1:Row
    for b = 1:Col
            if a==1 && b==1
            cell = Matrix(a+1, b+1) + Matrix(a, b+1)  + Matrix(a+1, b);
            MultCells = cell./3;
            Central = Matrix(a,b);
            
        elseif a==Row && b==1
            cell = Matrix(a-1, b+1) + Matrix(a-1, b)   + Matrix(a, b+1);
            MultCells = cell./3;
            Central = Matrix(a,b);
            
        elseif a==1 && b==Col
            cell = Matrix(a+1, b-1) + Matrix(a, b-1) +  + Matrix(a+1, b);
            MultCells = cell./3;
            Central = Matrix(a,b);
        
        elseif a==Row && b==Col
            cell = Matrix(a-1, b-1) + Matrix(a, b-1) + Matrix(a-1, b);
            MultCells = cell./3;
            Central = Matrix(a,b);
     
        elseif a==1 && (b > 1 && Col > b)
            cell = Matrix(a+1, b+1) + Matrix(a+1, b-1) + Matrix(a, b-1) + Matrix(a, b+1) +  + Matrix(a+1, b);
            MultCells = cell./5;
            Central = Matrix(a,b);
  
        elseif a==Row && (b > 1 && Col > b)
            cell = Matrix(a-1, b+1) + Matrix(a-1, b-1) + Matrix(a, b-1) + Matrix(a, b+1)  + Matrix(a-1, b);
            MultCells = cell./5;
            Central = Matrix(a,b);
        
        elseif (a > 1 && Row > a) && b==1
            cell = Matrix(a+1, b+1) + Matrix(a-1, b+1) + Matrix(a-1, b) + Matrix(a+1, b)  + Matrix(a, b+1);
            MultCells = cell./5;
            Central = Matrix(a,b);

        elseif (a > 1 && Row > a) && b==Col
            cell = Matrix(a-1, b) + Matrix(a+1, b) + Matrix(a-1, b-1) + Matrix(a, b-1) + Matrix(a+1, b-1);
            MultCells = cell./5;
            Central = Matrix(a,b);

         else
            cell = Matrix(a+1, b+1) + Matrix(a+1, b-1) + Matrix(a-1, b-1) + Matrix(a-1, b+1) + Matrix(a-1, b) + Matrix(a, b-1) + Matrix(a, b+1) + Matrix(a+1, b);
            MultCells = cell/8;
            Central = Matrix(a,b);   
         end
         
            Percentage(a,b) = ((MultCells - Central)/((MultCells+Central)/2)) * 100;
            Percentage = abs(Percentage);
            
%Task 3
Failures = [a, b, Matrix(a,b), MultCells, Percentage(a,b)];

if Percentage > input
    Failures = [a, b, Matrix(a,b), MultCells, Percentage];
    csvwrite('MA6_P2.csv', Failures)
end

    end
end

[Num1, Num2] = size(Failures);

Total = Num1;
Size = Row*Col;
Limit = Size*0.2;
fprintf('There are %0.0f failed cells', Num1);
if Total > Limit
    warning('Too many failed cells, significant repairs needed')
end


