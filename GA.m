
initialize=cell(25,1);%Initialize 25 chromosomes
for i=1:25
    initialize{i,1}=6*rand(1,4)-3;
    evaluate(i)=eval(initialize{i,1}(1,1),initialize{i,1}(1,2),initialize{i,1}(1,3),initialize{i,1}(1,4));
end

c=cell(5,1);%group by and Choose the five best
eva0=evaluate;
for j=1:5   
    tmp=999;
    for i=1:25
    if eva0(i)<tmp
        tmp=eva0(i);
        m=i;
    end
    end
    c{j,1}= initialize{m,1};
    eva(j)=eva0(m);
    eva0(m)=999;
end


c=selection(c,eva);
c=crossover(c);
c=mutation(c);
tmp=999;
m=0;


for i=1:5
    evaluate(i)=eval(c{i,1}(1,1),c{i,1}(1,2),c{i,1}(1,3),c{i,1}(1,4));
    if evaluate(i)<tmp
        tmp=evaluate(i);
        m=i;
    end
end

newc=c{m,1};
Best=tmp;
disp('Genetic Algorithm');
disp('Best=');
disp(Best);
disp('x1  x2  x3  x4 are');
disp(newc);
        
C=Grad(newc);%Gradient descent
Best=eval(C(1,1),C(1,2),C(1,3),C(1,4));
disp('Gradient descent')
disp(C);
disp('Best=');
disp(Best);
clear;

% x1=-1;x2=3/2;x3=3/2;x4=-1;
% m=eval(x1,x2,x3,x4);
% disp(m);

function Eval=eval(x1,x2,x3,x4)
Eval=x1-x2-x3+x4+2*x1^2+x2^2+x3^2+2*x4^2+2*x1*x2+2*x3*x4;
end



function newc=selection(c,eva)%selection
sumeva=0;
for i=1:5
    sumeva=eva(i)+sumeva; 
end
for i=1:5
    if i==1
proportion(i)=eva(i)/sumeva;
    else 
proportion(i)=eva(i)/sumeva+proportion(i-1);
    end
end
for i=1:5
 m=rand(1);
 n=1;
 while m>proportion(n)
 n=n+1;
 end
 newc{i,1}=c{n,1};
end
end

function c=crossover(c)%crossover
P=5;
m=0;
 for i=1:5
     evaluate(i)=eval(c{i,1}(1,1),c{i,1}(1,2),c{i,1}(1,3),c{i,1}(1,4));
     if evaluate(i)>5
         if m==0
             i=m;
         else c{i,1}(1,3)=tmp1;% position of crossover is 1
              c{i,1}(1,4)=tmp2;
             c{i,1}(1,3)=c{m,1}(1,3);
             c{i,1}(1,4)=c{m,1}(1,4);
             c{m,1}(1,3)=tmp1;
             c{m,1}(1,4)=tmp2;
             m=0;
         end
     end
 end 
end

function c=mutation(c)%mutation
P=0.1;%Mutation probability
for i=1:5
    for j=1:4
        if rand(1)<P
            c{i,1}(1,j)=6*rand(1)-3;
        end
    end
end
end
