%% Problem 1: Resistor Decoder

clc
clear
close

%Problem Statement: Determine the resistance or color band based on user inputs.

%Variables:
%Inputs
% Resistance as a vector
% Color band as string array
%Outputs
% Color band combination
% Resistance of color band


ColorGuide = load('P2_ColorGuide.mat');
ColorCode = ColorGuide.ColorCode;
Multiplier = ColorGuide.Multiplier;

%Task 1 

FirstColor = menu ('Pick first color band:', ColorCode{:}); %prompts to pick first color
SecondColor = menu ('Pick second color band:', ColorCode{:}); %promps to pick second color
ThirdColor = menu ('Pick third color band:', Multiplier{:}); %prompts to pick third color

if FirstColor == 0 || SecondColor == 0 || ThirdColor == 0 %Check if user closed menu, generate error if closed but proceed otherwise
    error('Error: User did not enter value, program terminated.')
elseif FirstColor == 1
    fprintf('First Digit: 0\n')
elseif FirstColor == 2
    fprintf('First Digit: 1\n')
elseif FirstColor == 3
    fprintf('First Digit: 2\n')
elseif FirstColor == 4
    fprintf('First Digit: 3\n')
elseif FirstColor == 5
    fprintf('First Digit: 4\n')
elseif FirstColor == 6
    fprintf('First Digit: 5\n')
elseif FirstColor == 7
    fprintf('First Digit: 6\n')
elseif FirstColor == 8
    fprintf('First Digit: 7\n')
elseif FirstColor == 9
    fprintf('First Digit: 8\n')
elseif FirstColor == 10
    fprintf('First Digit: 9\n')
end

if FirstColor == 0 || SecondColor == 0 || ThirdColor == 0 %Check if user closed menu, generate error if closed but proceed otherwise
    error('Error: User did not enter value, program terminated.')
elseif SecondColor == 1
    fprintf('Second Digit: 0\n')
elseif SecondColor == 2
    fprintf('Second Digit: 1\n')
elseif SecondColor == 3
    fprintf('Second Digit: 2\n')
elseif SecondColor == 4
    fprintf('Second Digit: 3\n')
elseif SecondColor == 5
    fprintf('Second Digit: 4\n')
elseif SecondColor == 6
    fprintf('Second Digit: 5\n')
elseif SecondColor == 7
    fprintf('Second Digit: 6\n')
elseif SecondColor == 8
    fprintf('Second Digit: 7\n')
elseif SecondColor == 9
    fprintf('Second Digit: 8\n')
elseif SecondColor == 10
    fprintf('Second Digit: 9\n')
end

if FirstColor == 0 || SecondColor == 0 || ThirdColor == 0 %Check if user closed menu, generate error if closed but proceed otherwise
    error('Error: User did not enter value, program terminated.')
elseif ThirdColor == 1
    fprintf('Multiplier: 1\n')
elseif ThirdColor == 2
    fprintf('Multiplier: 10\n')
elseif ThirdColor == 3
    fprintf('Multiplier: 100\n')
elseif ThirdColor == 4
    fprintf('Multiplier: 1000\n')
elseif ThirdColor == 5
    fprintf('Multiplier: 10000\n')
elseif ThirdColor == 6
    fprintf('Multiplier: 100000\n')
elseif ThirdColor == 7
    fprintf('Multiplier: 1000000\n')
end

%Task 2 
options = ["Resistance", "Color Band"]; %Choices for menu
Choice = menu('Resistance or Color Band', options{:}); 

[ColorStart ColorEnd] = size(ColorCode); %Used to find number of color codes
[MultiplierStart MultiplierEnd] = size(Multiplier); %Used to find number of multpliers

AllColors = [ColorStart-1:1:ColorEnd-1]; %The number for each color code
ColorsNum = vertcat (AllColors, ColorCode); %Putting color code and their respective number together

AllMultipliers= [MultiplierStart-1:1:MultiplierEnd-1]; %The multiplier numbers location for each color
AllMultipliers =  10.^AllMultipliers; %Getting the actual multplier numbers
MultipliersNum = vertcat (AllMultipliers, Multiplier); %Putting color code and their respective multiplier together

if Choice == 1 %User picks resistance
    Resistance = input ('Enter the resistance in ohms as a vector: '); 

    ColorBand1 = find(Resistance(1) == AllColors); %Finding color that corresponds to number that user inputted for first value
    ColorBand2 = find(Resistance(2) == AllColors); %Finding color that corresponds to number that user inputted for second value
    ZerosNum = length(Resistance(3:end)); %Finding how many zeros are inputted by user
    
    if Resistance(3:end) ~= 0 %If there are any digits after first two digits not zero then program terminates
        error('Error: Not all digits after first two digits are zeros, program terminated.')
    elseif ZerosNum >= 1 %If conditions above are not met then program continues
         ColorBand3 = ZerosNum + 1; %Associating the color with number of zeros inputted
    elseif ZerosNum == 0 %If there are no digits after the first two then it proceeds with this task
        ColorBand3 = 1; %If there are no digits then multiplier is 1, which is Black (the first color)
    end
    
    ColorOutput1 = (ColorsNum(2, ColorBand1)); %Outputs the first color from user input
    ColorOutput2 = (ColorsNum(2, ColorBand2)); %Outputs the second color from user input
    ColorOutput3 = (MultipliersNum(2, ColorBand3)); %Outputs the third color from user input

    fprintf('The correct color band is: %s %s %s', ColorOutput1, ColorOutput2, ColorOutput3)

%Task 3
elseif Choice == 2 %User picks color band
    ColorBand = input('Enter the color band as a string array (3 colors): ');
    if length(ColorBand) ~= 3
        error('User did not input only three colors, program terminated.')
    end
    ColorBand1 = ColorBand(1); %First color user inputted
    ColorBand2 = ColorBand(2); %Second color user inputted
    ColorBand3 = ColorBand(3); %Third color user inputted
    
    FirstDigit = find(ColorBand1 == ColorsNum(2,:));
    FirstDigit = FirstDigit-1;
    
    SecondDigit = find(ColorBand2 == ColorsNum(2,:));
    SecondDigit = SecondDigit-1;
    
    ThirdDigit = find(ColorBand3 == ColorsNum(2,:));
    ThirdDigit = 10^(ThirdDigit-1);
    
    if FirstDigit == 0
        fprintf('The resistance for the given color band is %i %c.', SecondDigit*ThirdDigit, char(937))
    else
        fprintf('The resistance for the given color band is %i%i %c.', FirstDigit, SecondDigit*ThirdDigit, char(937))
    end        
end
%% Problem 2: Mass-Spring Model

clc
clear
close

%Problem Statement: Determine the distance the figure moves based on user entered values.

%Variables:
%Inputs
% W = weight [N]
% k1 = spring constant 1 [N/m]
% k2 = spring constant 2 [N/m]
% d = position [m]
%Outputs
% x = distance [m]

%Task 1
W = input('Enter the weight [N]: ');

if length(W) == 1
    k1 = input('Enter the k_1 value [N/m]: ');
    k2 = input('Enter the k_2 value [N/m]: ');
    d = input('Enter the rest position, d [m]: ');
    x = W/k1;
    if x < d
        fprintf('The weight will pass through a distance of %.4f m.', x)
    else
        x = (W+(2*k2*d))/(2*k2+k1);
    end
end

%Task 2
if length (W) > 1
    k1 = input('Enter the k_1 value [N/m]: ');
    k2 = input('Enter the k_2 value [N/m]: ');
    d = input('Enter the rest position, d [m]: ');
    x = W./k1;
    if x < d;
        fprintf('The max weight given (%.f) will pass through a distance of %.2f m.', max(W), max(x))
    else x >= d;
        x = ( W + ( 2 * k2 * d ) ) / ( 2 * k2 + k1 );
        fprintf('The max weight given (%.f) will pass through a distance of %.2f m.', max(W), max(x))
    end
        plot(W, x ,'ro')
         grid on
         axis([0, 7000, 0, 3])
         xlabel('Weight (W) [N]')
         ylabel('Distance moved through (x) [m]')
         title('Relationship of Weight and string compression')
 end

