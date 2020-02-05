%% Problem 1: Phase Diagram

clc
clear
close

%Problem Statement: Ask user to input a two element vector of voltage and
%frequency then check to see if the inputted pair is inside any of the
%zones, if in a zone then output it as accepted device and if not then
%output it as a rejected device.

%Variables:
%Input
% Voltage
% Frequency
%Outputs
% Accepted Devices
% Rejected Devices

%Task 1

Middle1 = input('Input the middle point for the power curve of Zone A as a vector [x, y]: ');
Middle2 = input('Input the middle point for the exponential curve of Zone B as a vector [x, y]: ');

figure()

plot([0,3], [7500, 7500], '-m', 'LineWidth', 3)

xlabel('Voltage (V) [V]')

ylabel('Frequency (f) [Hz]')

title('Voltage vs. Frequency')

grid on

hold on

polyfit([3,6], [7500,9000], 1);

plot([3,6], [7500,9000], '-m', 'LineWidth', 3)

plot([6,6], [6000,9000], 'm', 'LineWidth', 3)

Curve1 = polyfit(log10 ([0.15, Middle1(1), 6]), log10 ([1000, Middle1(2), 6000]), 1); 

aa = [0:0.1:6];

bb = (10^Curve1(2))*aa.^Curve1(1);

plot(aa, bb, '-m', 'LineWidth', 3)

plot([12,15], [7500, 7500], ':b', 'LineWidth', 3)

plot([8,8], [0, 3000], ':b', 'LineWidth', 3)

Curve2 = polyfit([8, Middle2(1), 12], log([3000, Middle2(2), 7500]), 1);

cc = [8:0.1:12];

dd = (exp(Curve2(2)))*exp(Curve2(1)*cc);

plot(cc,dd, ':b', 'LineWidth', 3)

xticks([0:1:15])

axis([0,15,0,10000])

text(1.5, 6500, 'Zone A', 'Color', 'm', 'FontSize', 15)
text(10, 3000, 'Zone B', 'Color', 'b', 'FontSize', 15)

text(1.5, 5500, 'Accept', 'Color', 'm', 'FontSize', 15)
text(10, 2000, 'Accept', 'Color', 'b', 'FontSize', 15)

text(3, 2000, 'Reject', 'FontSize', 20)
text(8, 9000, 'Reject', 'FontSize', 20)

xvalues = [3:0.1:6];
Linear = 500*xvalues+6000;

again = 1;
reject = 0;
accept = 0;
count = 0;

tests = [];

while again == 1
    count = count +1;
%Task 2
Input = input('Enter a two-element vector [voltage, frequency]: ');

a = 0;

while a <= 1 &&  (length(Input) >=3 || length(Input) <= 1)
    Input = input('Enter a two-element vector [voltage, frequency]: ');
    a = a + 1;
end

if (length(Input) >=3 || length(Input) <= 1) && a == 2
        error('User did not enter a two-element vector, terminating program')
end

b = 0;
while Input(1) >= 16 || Input(1) < 0
    warning('The value for voltage is outside the range');
    Input(1) = input('Input a new value for voltage that is between 0 and 15: ');
    b = b+1;
end

c = 0;
while Input(2) > 10000 || Input(2) < 0
    warning('The value for frequency is outside the range');
    Input(2) = input('Input a new value for frequency that is between 0 and 10000: ');
    c = c+1;
end

tests = [tests; Input];

number = sprintf('%0.0f', count);

plot(Input(1), Input(2), 'or', 'MarkerFaceColor', 'r', 'MarkerSize', 20)
hold on
text(Input(1)-0.2, Input(2), number, 'FontSize', 15)

again = menu('Would you like to enter another pair of voltage and frequency?', 'Yes', 'No');
end

%Task 3
aa; %x value of Zone A curve from 0 to 6
bb; %y value of Zone A curve from 0 to 6000
cc; %x value of Zone B curve from 8 to 12
dd; %y value of Zone B curve from 3000 to 7500

[row, col] = size(tests);

fprintf('\nYour tests resulted in:\n')

for i = 1:row
voltage = tests(i,1);
frequency = tests(i,2);
if voltage <= 3
    Value = find(voltage == aa);
    if frequency >= bb(Value) && frequency <= 7500
        accept = accept + 1;
    else
        reject = reject + 1;
    end
end

if voltage > 3 && voltage <= 6
    Value = find(voltage == aa);
    Value2 = find(voltage == xvalues);
    if frequency >= bb(Value) && frequency <= Linear(Value2)
        accept = accept + 1;
    else
        reject = reject + 1;
    end
end

if voltage > 6 && voltage < 8
    reject = reject + 1;
end

if voltage >= 8 && voltage <= 12
    Value = find(voltage == cc);
    if frequency <= dd(Value)
        accept = accept + 1;
    else
        reject = reject + 1;
    end
end

if voltage > 12
    if frequency <= 7500
       accept = accept + 1;
    else
        reject = reject + 1;
    end
end
end

if accept == 1
    fprintf('\t%0.0f\t Accepted Device\n', accept)
else
    fprintf('\t%0.0f\t Accepted Devices\n', accept)
end
if reject == 1
    fprintf('\t%0.0f\t Rejected Device\n', reject)
else
    fprintf('\t%0.0f\t Rejected Devices\n', reject)
end

%Task 4
fprintf('\n Entry # | Voltage [V] | Frequency [Hz] | Status\n')

for i = 1:row
voltage = tests(i,1);
frequency = tests(i,2);
if voltage <= 3
    Value = find(voltage == aa);
    if frequency >= bb(Value) && frequency <= 7500
        fprintf('%0.0f\t\t%0.0f\t\t%0.0f\t\t%s\n', i, voltage, frequency, 'Accept Device in Zone A')
    else
        fprintf('%0.0f\t\t%0.0f\t\t%0.0f\t\t%s\n', i, voltage, frequency, 'Reject Device')
        reject = reject + 1;
    end
end

if voltage > 3 && voltage <= 6
    Value = find(voltage == aa);
    Value2 = find(voltage == xvalues);
    if frequency >= bb(Value) && frequency <= Linear(Value2)
        fprintf('%0.0f\t\t%0.0f\t\t%0.0f\t\t%s\n', i, voltage, frequency, 'Accept Device in Zone A')
    else
        fprintf('%0.0f\t\t%0.0f\t\t%0.0f\t\t%s\n', i, voltage, frequency, 'Reject Device')
    end
end

if voltage > 6 && voltage < 8
    fprintf('%0.0f\t\t%0.0f\t\t%0.0f\t\t%s\n', i, voltage, frequency, 'Reject Device')
end

if voltage >= 8 && voltage <= 12
    Value = find(voltage == cc);
    if frequency <= dd(Value)
        fprintf('%0.0f\t\t%0.0f\t\t%0.0f\t\t%s\n', i, voltage, frequency, 'Accept Device in Zone B')
    else
        fprintf('%0.0f\t\t%0.0f\t\t%0.0f\t\t%s\n', i, voltage, frequency, 'Reject Device')
    end
end

if voltage > 12
    if frequency <= 7500
        fprintf('%0.0f\t\t%0.0f\t\t%0.0f\t\t%s\n', i, voltage, frequency, 'Accept Device in Zone B')
    else
        fprintf('%0.0f\t\t%0.0f\t\t%0.0f\t\t%s\n', i, voltage, frequency, 'Reject Device')
    end
end

end




