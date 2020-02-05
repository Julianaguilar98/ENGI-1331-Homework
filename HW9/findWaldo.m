function [topL,botL,topR,botR] = findWaldo(Waldo,Image,row1,col1,row2,col2)

                     
for i = 1:row2-row1+1
    for j = 1:col2-col1+1
        
        if (Waldo(1,1,1) == Image(i,j,1)) && (Waldo(1,col1,1) ==Image(i,j+col1-1,1)) && (Waldo(row1,1,1)==Image(i+row1-1,j,1)) && (Waldo(row1,col1,1) == Image(i+row1-1,j+col1-1,1))

            if Waldo(1,1,2)==Image(i,j,2)&&Waldo(1,col1,2)==Image(i,j+col1-1,2)&&Waldo(row1,1,2)==Image(i+row1-1,j,2)&&Waldo(row1,col1,2)==Image(i+row1-1,j+col1-1,2)

                 if Waldo(1,1,3)==Image(i,j,3)&&Waldo(1,col1,3)==Image(i,j+col1-1,3)&&Waldo(row1,1,3)==Image(i+row1-1,j,3)&&Waldo(row1,col1,3)==Image(i+row1-1,j+col1-1,3)

            for m = 1:row1
                    for n = 1:col1

        red = Waldo(m,n,1);
        
        green = Waldo(m,n,2);

        blue =Waldo(m,n,3);

        D = Image(i+m-1,j+n-1,1); 

        [rowD,colD] =size(D);

        EE = Image(i+m-1,j+n-1,2); 

        FF = Image(i+m-1,j+n-1,3);

        if red == D && green == EE && blue == FF

        topL= i;

        topR= j;

        botL=i+row1-1;

        botR= j+col1-1;
        end
                    end
            end
                 end
            end
        end
    end
end

figure()

image(Image) 

x = [(topR + botR)/2];
y = [(topL + botL)/2];

hold on

        plot(x,y,'rs','MarkerSize',30,'LineWidth',4);
        
end    