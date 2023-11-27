

%{write users class
%each has x,y position
%create no of users and randomize pstn 
%input for number of positives
classdef Environment
    properties (Access = private)
        Size_X = input('Dimensions of x-coordinate?\n');
        Size_Y = input('Dimensions for y-coordinate\n');
        Steps = input('How many steps do you want\n');
        %matrix to represent users and their position
        disp('The following matrix represents users in a space and their positions\n')
        xx = input('Enter integer for number of rows you want \n');
        yy = input('Enter integer for number of columns you want \n');
        Num_Users = xx * yy;
       % Users
         A = zeros(xx,yy); %empty the matrix first
         B = zeros(xx,yy); %updated matrix with positives and negatives
        
          % matrix   
        for i=1:xx
            
            for j=1:yy
                A(i,j) = randi(4); %assign specific position a random val from 1-4
            end 
        end
            disp(A)
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % for corner indices
            if A(1,2)==1 | A(2,1) ==1
                B(1,1)=1;
            else
                B(1,1) =0;
            end
            
             if A(xx,2)==1 | A(xx-1,1) ==1
                B(xx,1)=1;
            else
                B(xx,1) =0;
             end


              if A(1,yy-1)==1 | A(2,yy) ==1
                B(1,yy)=1;
            else
                B(1,yy) =0;
              end


               if A(xx-1,yy)==1 | A(xx,yy-1) ==1
                B(xx,yy)=1;
            else
                B(xx,yy) =0;
               end
             %  disp(B);
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%all indices excluding outline

          for k=2:xx-1
              for l=2:yy-1
                  if A(k,(l-1))==1 | A(k,(l+1))==1 | A(k+1,l)==1 | A(k-1,l)==1
                      B(k,l) =1; %%assigning positive(1) to index with at least one positive around them 
                  else
                      B(k,l) =0; %% assigning zero
                  end
              end
          end
         % disp(B);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         %outline except corners...still working on this

  for k=2:xx-1 %leftmost column
              for l=1
                  if A(k,(l+1))==1 | A(k+1,l)==1 | A(k-1,l)==1
                      B(k,l) =1; %%assigning positive(1) to index with at least one positive around them 
                  else
                      B(k,l) =0; %% assigning zero
                  end
              end
  end


   for k=2:xx-1 %%right most column
              for l=yy
                  if A(k,(l-1))==1 | A(k+1,l)==1 | A(k-1,l)==1
                      B(k,l) =1; %%assigning positive(1) to index with at least one positive around them 
                  else
                      B(k,l) =0; %% assigning zero
                  end
              end
   end

disp(B); %%contains updated matrix showing 1s for all positives and 0s for all negatives


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%counting all 1s(positives)
count_1 = 0;
for z=1:xx;
for p=1:yy;
    if B(z,p) == 1
        count_1 = count_1+1;
        
    end
end
end
 
disp(['The number of positive results are = ', num2str(count_1)]);



  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    methods
        function obj = Environment(x, y, steps, num_users)
            if nargin > 0
                obj.X = x;
                obj.Y = y;
                obj.Steps = steps;
                obj.Num_Users = num_users;
            end
        end
        
        function users = getUsers(obj, step)
            users = obj.Users;
        end
    end
end
