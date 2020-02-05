%% Temperature Data Processing

clc
clear
close

%Problem Statement: Organize similar data from multiple days

TempData = load('TempData.csv');
Overall = xlsread('OVERALL.xls');

%Task 1
MaxTemp = max(TempData, [], 2); %Maximum temperature of each day (row)
MinTemp = min(TempData, [], 2); %Minimum temperature of each day (row)
AvgTemp = mean(TempData, 2); %Average temperature of each day (row)

[DayMax TempMax] = find (TempData==MaxTemp); %Find the maximum temperature (max value of each row) for each day
MaxTempDays = horzcat(DayMax, TempMax); %Putting days and max temperature together: day # on the left and max reading # (column number) on the right

[DayMin TempMin] = find (TempData==MinTemp); %Find the minimum temperature (min value of each row) for each day
MinTempDays = horzcat(DayMin, TempMin); %Putting days and min temperature together: day # on the left and min reading # (column number) on the right


AllData = [MinTemp, AvgTemp, MaxTemp]; %Data sorting, minimum temperatures on first column, average on second, maximum at third
csvwrite ('MA3Task1.csv', AllData) %Exporting sorted data to MA3Task1.csv file

fprintf('Pick a day number from 1 to 366: %d\n', 64)
fprintf('Day %d minimum temperature: %.1f C\nDay %d average temperature: %.1f C\nDay %d maximum temperature: %.1f C\n\n', 64, MinTemp(64), 64, AvgTemp(64), 64, MaxTemp(64))

%Task 2
LowAvg = min(AvgTemp); %Temperature reading of -15.2 for lowest temperature average
HighAvg = max(AvgTemp); %Temperature reading of 88.6 for highest temperature average

[DayNumLowT] = find(AvgTemp == LowAvg); %This outputs 36, so that means day # 36 has the lowest average temperature
[DayNumHighT] = find(AvgTemp == HighAvg); %This outputs 215, so that means day # 215 has the highest average temperature
 
LowMinTemp = min(MinTemp); %Most extreme minimum temperature with a reading of -24
HighMaxTemp = max(MaxTemp); %Most extreme maximum temperature with a reading of 103

[DayNumMinT] = find(MinTemp == min(MinTemp)); %This outputs 36, so that means day # 36 has lowest minimum temperature, same result from the lowest average temperature
[DayNumMaxT] = find(MaxTemp == max(MaxTemp)); %This outputs 216, so that means day # 216 has highest maximum temperature

fprintf('Day %.f has lowest average temperature with temperature reading of %.1f \n', DayNumLowT, LowAvg)
fprintf('Day %.f has highest average temperature with temperature reading of %.1f \n', DayNumHighT, HighAvg)
fprintf('Day %.f has lowest minimum temperature with temperature reading of %.1f \n', DayNumMinT, LowMinTemp)
fprintf('Day %.f has highest maximum temperature with temperature reading of %.1f \n\n', DayNumMaxT, HighMaxTemp)

%Task 3
MinOverall = Overall(1); 
MeanOverall =Overall(2);
MaxOverall = Overall(3);

ColdDays = MinTemp < MinOverall; %Finding days where minimum temperature is lower than the long term data minimum temperature
OverAvg = AvgTemp > MeanOverall; %Finding days with average temperature is higher than the long term data average temperature
UnderAvg = AvgTemp < MeanOverall; %Finding days where the average temperature is lower than the long term data average temperature
HotDays = MaxTemp > MaxOverall; %Finding days where the maximum temperature is higher than the long term data maximum temperature

[ColdDays] = find (ColdDays ==1); %Days # where conditions are met, 0 of the days meet the conditions
[OverAvg] = find (OverAvg == 1); %Days # where conditions are met, it's a 181x1 matrix so 181 days meet the conditions
[UnderAvg] = find (UnderAvg ==1); %Days # where  conditions are met, it's a 185x1 matrix so 185 days meet the conditions
[HotDays] = find (HotDays == 1); %Days # where conditions are met, day # 208, 215, 216, 218 meet the conditions

ColdTemp = MinTemp(ColdDays); %Empty matrix for cold temperatures
ColdDays = horzcat (ColdTemp, ColdDays); %Empty maxtrix for cold temperatures and days

OverTemp = AvgTemp(OverAvg); %Temperature for each day that met the conditions for over average the long term recorded data
OverAvg = horzcat (OverTemp, OverAvg); %Matrix of temperature (left) and corresponding day # (right) for over average temperatures

UnderTemp = AvgTemp(UnderAvg); %Temperature for each day that met the conditions for under average the long term recorded data
UnderAvg = horzcat (UnderTemp, UnderAvg); %Matrix of temperature (left) and corresponding day # (right) for under average temperatures

HotTemp = MaxTemp(HotDays); %Temperature for each day that met the conditions to be really hot temperatures
HotDays = horzcat (HotTemp, HotDays); %Matrix of temperature (left) and corresponding day # (right) for really hot temperatures

save('MA3Task3.mat', 'ColdDays', 'OverAvg', 'UnderAvg', 'HotDays')

fprintf('There were %.f days that were colder than the minimum long term temperature\n', length(ColdTemp))
fprintf('There were %.f days that were hotter than the average long term temperature\n', length(OverTemp))
fprintf('There were %.f days that were colder than the average long term temperature\n', length(UnderTemp))
fprintf('There were %.f days that were hotter than the maximum long term temperature\n\n', length(HotTemp))

%Task 4
MinTempDiff = LowMinTemp - MinOverall; %Difference between lowest minimum temperature long term minimum
UnderAvgTempDiff = LowAvg - MeanOverall;  %Difference between lowest average temperature long term average
OverAvgTempDiff = HighAvg - MeanOverall;  %Difference between highest maximum temperature long term average
MaxTempDiff = HighMaxTemp - MaxOverall; %Difference between highest maximum temperature long term maximum

TempDiff = [MinTempDiff; UnderAvgTempDiff; OverAvgTempDiff; MaxTempDiff]; %Arragning temperature differences into a column vector (4x1)
csvwrite('MA3Task4.csv', TempDiff) %Exporting sorted data to MA3Task4.csv
fprintf('The difference between the lowest minimum temperature and long term minimum is %.1f\n', MinTempDiff)
fprintf('The difference between the lowest average temperature and long term average is %.1f\n', UnderAvgTempDiff)
fprintf('The difference between the highest average temperature and long term average is %.1f\n', OverAvgTempDiff)
fprintf('The difference between the lowest minimum temperature and long term maximum is %.1f\n\n', MaxTempDiff)

%Task 5
[DayNum TempNum] = size(TempData); %Results in a 366x14 array, can use this to multiply the row and columns together to find total number of temperature readings
TempHalf = (DayNum*TempNum)/2;
TempExcess = sum(TempData > MeanOverall); %Find the total # of temperature readings for each column that are greater than the average long term temperature
TempExcess = sum(TempExcess); %Add the numbers together from each column that resulted from line 96 to find the total number of temperature readings

fprintf('There should be %.f temperature readings above and below the long term average temperature\n', TempHalf)
fprintf('There were %.f temperature readings that were below the long term average temperature\n', (TempHalf - TempExcess))

%Task 6
DataSort = sort(TempData,2); %Sorting temperatures of each day (row) in ascending order 
FinalData = [DataSort, AllData]; %Putting the sorted data set and the min, mean, max into one matrix (with the sorted data being on the left)
csvwrite('MA3_Final.csv', FinalData); %Writing the data sets into csv file

%Task 7
MinOverallplot = repmat(MinOverall,366); 
MeanOverallplot = repmat(MeanOverall,366);
MaxOverallplot = repmat(MaxOverall,366);

plot (1:366, MinTemp, 'b*', 1:366, AvgTemp, 'go', 1:366, MaxTemp,'rx', 1:366, MinOverallplot, 'b-',1:366, MeanOverallplot, 'g-',1:366, MaxOverallplot, 'r-')
xlabel ('Days')
ylabel ('Temperature [degrees C]')
legend ('Daily Minimum','Daily Average','Daily Maximum', 'Long Term Minimum', 'Long Term Average', 'Long Term Maximum')
grid on