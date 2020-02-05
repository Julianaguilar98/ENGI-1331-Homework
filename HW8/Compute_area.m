function [y] = Compute_area (rectangles)

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
end
