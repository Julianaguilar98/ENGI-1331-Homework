%% Problem 1

clc
clear
close

%Problem Statement: Determine the power in units of watts and the potential energy in units of joules from the data collected.

%Task 1

%Data 1
% m1 = mass [g]
% h1 = height [ft]
% t1 = time [min]

Data1 = [10, 50, 75; 5, 8, 10; 1, 0.5, 2.5];
m1 = Data1 (1,:);
h1 = Data1 (2,:);
t1 = Data1 (3,:);

%Data 2
%m2 = mass [lb_m]
%h2 = height [cm]
%t2 = time [h]
Data2 = [0.2, 0.45, 0.8, 0.9; 760, 700, 900, 1400; 0.025, 0.01, 0.02, 0.04];
m2 = Data2 (1,:);
h2 = Data2 (2,:);
t2 = Data2 (3,:);

m1 = m1/1000; %convert from grams to kilograms
h1 = h1/3.28084; %convert from feet to meters
t1 = t1*60; %convert from minutes to seconds
m2 = m2/2.20462; %convert from pound mass to kilograms
h2 = h2/100; %convert from centimers to meters
t2 = t2*3600; %convert from hours to seconds


g = 9.8; %Value for gravity (g) which is in m/s^2

%Potential Energy = Mass * Gravity * Height
PE1 = m1.*g.*h1;
PE2 = m2.*g.*h2;

%Power = Potential Energy / Time
P1 = PE1./t1;
P2 = PE2./t2;


%Task 2
Data1 = [m1; h1; t1];
Data2 = [m2; h2; t2];
Data = [Data1, Data2];

CombinedData = [PE1, PE2; P1, P2];
csvwrite('Problem1_results.csv',CombinedData);

%Task 3
AverageMass1 = mean(m1);
AverageMass2 = mean(m2);
AverageHeight1 = mean(h1);
AverageHeight2 = mean(h2);

TotalPE1 = sum(PE1);
TotalPE2 = sum(PE2);
TotalPower1 = sum(P1);
TotalPower2 = sum(P2);

%Task 4
PotentialEnergy = [PE1, PE2];
Power = [P1, P2];
Mass = [m1*1000, m2*1000];

figure(1) %Plot for Mass vs. Potential Energy
plot (Mass, PotentialEnergy,'ro');
xlabel ('Mass (m) [g]')
ylabel ('Potential Energy (PE) [J]')
title ('Potental Energy for All Measurements')
grid on
figure(2) %Plot for Mass vs. Power
plot (Mass, Power,'b*');
xlabel ('Mass (m) [g]')
ylabel ('Power (P) [W]')
title ('Power for All Measurements')
grid on


%% Problem 2

clc
clear
close

%Problem Statement: Add years and DeviceID and get the production rates

load('C:\Users\Jurj\Desktop\ENGI 1331\MA2\Problem2(2).mat')

Year = Prod(:,1)
Production = Prod(:,2:5);
DeviceID = DeviceID(1);

SelectDeviceID = 'IC555';
SelectYear = '2016';

NewYears = [2016, 2017];
DeviceID = '2N6464'; %New DeviceID
DeviceIDProduction = [400; 450];
YearProduction = [3000, 2000; 3150, 2500]; 

AllData = [NewYears, NewDeviceID];

save('AllData');

DeviceID = '2G1544' %Replace previous DeviceID


Growth = 30

figure(1)
plot (Year, Production,'bo')
xlabel ('Year')
ylabel ('Production [units]')
title ('2G1544 Yearly Production')
