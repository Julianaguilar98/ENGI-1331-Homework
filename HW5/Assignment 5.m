%% Problem 1: Resistor Decoder

%Housekeeping Commands
clc
clear
close

%Problem Statement: Prompt the user to enter resistance or color band, if
%they input values incorrectly then repeat questions a certain amount of times or
%until they input values correctly. If inputted correctly then determine
%the resistance or color band based on user inputs. Prompt user with
%question if they want to run program again.

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

[ColorStart ColorEnd] = size(ColorCode); %Used to find number of color codes
[MultiplierStart MultiplierEnd] = size(Multiplier); %Used to find number of multpliers

AllColors = [ColorStart-1:1:ColorEnd-1]; %The number for each color code
ColorsNum = vertcat (AllColors, ColorCode); %Putting color code and their respective number together

AllMultipliers= [MultiplierStart-1:1:MultiplierEnd-1]; %The multiplier numbers location for each color
AllMultipliers =  10.^AllMultipliers; %Getting the actual multplier numbers
MultipliersNum = vertcat (AllMultipliers, Multiplier); %Putting color code and their respective multiplier together

%Task 3
x = 0; %Starting value for number of times program was run
Choice = 1; %Evaluating first loop to true so program can run
R = 0; %Starting value for number of times Resistance was picked
C = 0; %Starting value for number of times Color Band was picked

while Choice == 1
    x = x + 1; %Number of the times the program was run
    
%Task 1
menuOptions = ["Resistance", "Color Band"]; %Menu choices
userChoice = menu('Will you be entering a resistance or color band?', menuOptions{:}); %Menu prompt

if userChoice == 0
    error('Error: User did not enter value, program terminated.')
end

if userChoice == 1
    R = R + 1; %Number of times resistance was picked
    
    fprintf('Converting Resistance to Color Band\n\n')
    Resistance = input('Enter the resistance in ohms as a vector: ');
    i = 0; %Starting number for the while loops
    numDigits = find(Resistance(3:end) ~= 0);
    numDigits = length(numDigits);

while (numDigits >= 1) && (i < 2) %All digits after first two are not 0 and the function didn't loop 3 times
    Resistance = input('Enter an appropriate resistance in ohms as a vector: '); %Will keep asking for maximum of three times
    numDigits = find(Resistance(3:end) ~= 0);
    numDigits = length(numDigits);
    i = i+1; %Will keep looping if both conditions above are met  
end

if numDigits >= 1 %If there are any digits after first two digits not zero then they are replaced
    warning(sprintf('All values past the second position are\nbeing assumed as 0'))
    Resistance(3:end) = 0;
end

ZerosNum = length(Resistance(3:end));
if ZerosNum >= 1 
    ColorBand3 = ZerosNum + 1;
elseif ZerosNum == 0 
    ColorBand3 = 1; 
end

ColorBand1 = find(Resistance(1) == AllColors); %Finding color that corresponds to number that user inputted for first value
ColorBand2 = find(Resistance(2) == AllColors); %Finding color that corresponds to number that user inputted for second value
ZerosNum = length(Resistance(3:end)); %Finding how many zeros are inputted by user

ColorOutput1 = (ColorsNum(2, ColorBand1)); %Outputs the first color from user input
ColorOutput2 = (ColorsNum(2, ColorBand2)); %Outputs the second color from user input
ColorOutput3 = (MultipliersNum(2, ColorBand3)); %Outputs the third color from user input

fprintf('The correct color band is: %s %s %s\n\n', ColorOutput1, ColorOutput2, ColorOutput3)
end

%Task 2
if userChoice == 2
    C = C + 1; %Number of times color band was picked
    
    fprintf('Converting Color Band to Resistance\n\n')
    ColorBand = input('Enter the color band as a cell array (3 colors): ');

checkLength = length(ColorBand);
i = 0; %Starting number for the while loops

while (checkLength ~= 3) && (i < 4) %If there are more than three colors and the function didn't loop 5 times
    if checkLength > 3
        ColorBand = input('Enter the color band as a cell array (3 colors): '); %Will keep asking for maximum of five times
        checkLength = length(ColorBand);
    elseif checkLength < 3
        attempts = 4 - i; %number of attempts left
        if attempts ~= 1
        warning (sprintf('You have %d attempts left', attempts))
        ColorBand = input('Enter the color band as a cell array (3 colors): '); %Will keep asking for maximum of five times
        checkLength = length(ColorBand);
        elseif attempts == 1
        warning (sprintf('You have %d attempt left', attempts))
        ColorBand = input('Enter the color band as a cell array (3 colors): '); %Will keep asking for maximum of five times
        checkLength = length(ColorBand);
        end
    end
    i = i+1; %Will keep looping if both conditions above are met  
end

if checkLength > 3
    warning('More than three colors were entered, only using the first three colors entered')
    
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
        fprintf('The resistance for the given color band is %i.\n\n', SecondDigit*ThirdDigit)
    else
        fprintf('The resistance for the given color band is %i%i.\n\n', FirstDigit, SecondDigit*ThirdDigit)
    end
    
elseif checkLength < 3
    error('Appropriate color band not entered')
elseif checkLength == 3
    
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
        fprintf('The resistance for the given color band is %i.\n\n', SecondDigit*ThirdDigit)
    else
        fprintf('The resistance for the given color band is %i%i.\n\n', FirstDigit, SecondDigit*ThirdDigit)
    end        
    
end

end

%Task 3
Options = ["Yes", "No"];
Choice = menu('Would you like to enter another resistance or color band?', Options{:});

if Choice == 2
fprintf('Number of times the program was run: %d\n', x)
fprintf('Number of times resistance was chosen: %d\n', R)
fprintf('Number of times color band was chosen: %d\n', C)
end
end

%% Problem 2: Simulation of Inventory

%Housekeeping Commands
clc
clear
close

%Problem Statement: Determine the inventory for each week from user's sales
%and initial inventory input, output result as a table and graph. Prompt
%user with question if they want to run the program again.

%Variables:
%Inputs
% Initial inventory
% Sales information
%Outputs
% # of Weeks
% Inventory for each week


%Task 3
Choice = 1; %To allow the program to be run for the first time

while Choice == 1 %Will evaluate if user wants to run program again from question prompted at the end of the program


%Task 1
initial = input('Input the initial inventory for week 1: ');
sales = input('Input the sales information as a vector: ');

%Task 2
while initial <= 0
    initial = input('Enter new initial inventory value: ');
end

numNeg = find(sales < 0);
lengthNeg = length(numNeg);

while lengthNeg > 0
    warning('At least one value from sales is less than zero')
    sales(numNeg(1)) = input('Enter a new value to replace the first negative (unreplaced) value in the sales vector: ');
    while sales(numNeg(1)) < 0
        sales(numNeg(1)) = input('Re-enter the value so that it''s at least zero: ');
    end
    numNeg = find (sales < 0);
    lengthNeg = length(numNeg);
end
    
%Task 1
numWeeks = length(sales); %Finding how many values were inputted

weeks = numWeeks + 1;
weeks = 2:weeks; %Don't need first week because first week is determined by user

inventory(1:numWeeks) = 0; %Making the vector as long as the amount of sales the user inputted
inventory(1) = initial; %The first value for inventory was determined by the user


production(weeks) = sales(weeks-1);
production = production(1:end-1);
production(1) = initial;

i = 0;
while i < numWeeks
    inventory(weeks) = production(weeks - 1) + inventory(weeks - 1) - sales(weeks - 1);
    i = i + 1;
end

inventory = inventory(1:end-1);
negativeInventory = find(inventory < 0);
negativeLength = length(negativeInventory);

 if negativeLength >= 1 %Function to show inventory until it before it becomes negative
        lastInventory = negativeInventory(1); %The first time inventory becomes negative
        inventory = inventory(1:lastInventory-1);
        L = length(inventory);
        sales = sales(1:L);
        weeks = (1:L);
        warning(sprintf('Inventory is below zero at Week %i', L+1))
 else
     L = length(inventory);
     weeks = (1:L);
 end

fprintf('Week: \t\t')
fprintf('%d \t', weeks)

fprintf('\nSales: \t\t')
fprintf('%d \t', sales)

fprintf('\nInventory: \t')
fprintf('%d \t', inventory)
fprintf('\n\n')

%Task 3
plot(weeks, inventory, 'b*')
xlabel('Time [week]')
ylabel('Inventory levels [units]')
title('Inventory Levels')
grid on


Options = ["Yes" "No"];
Choice = menu('Would you like to enter another data set?', Options{:});
end

