
function newc=Grad(newc)

x1=newc(1,1);
x2=newc(1,2);
x3=newc(1,3);
x4=newc(1,4);
ev1=ev1(x1,x2);
ev2=ev2(x1,x2);
ev3=ev3(x3,x4);
ev4=ev4(x3,x4);

syms x;%Figure out "lambda"
q=ev1-ev2-ev3+ev4+4*(ev1^2*x+ev4^2*x+x1*ev1+x4*ev4)+2*(ev2^2*x+ev3^2*x+x2*ev2+x3*ev3)+2*(x1*ev2+x2*ev1+x3*ev4+x4*ev3+2*ev1*ev2*x+2*ev3*ev4*x)==0;
x=solve(q);
lambda=x;

newc(1,1)=x1+lambda*ev1;
newc(1,2)=newc(1,2)+lambda*ev2;
newc(1,3)=newc(1,3)+lambda*ev3;
newc(1,4)=newc(1,4)+lambda*ev4;

if abs(lambda)>0.2 %The condition of Jump out of recursive 
    newc=Grad(newc);
end
end


function Eva=ev1(x1,x2)
Eva=1+4*x1+2*x2;
end
function Eva=ev2(x1,x2)
Eva=-1+2*x2+2*x1;
end
function Eva=ev3(x3,x4)
Eva=-1+2*x3+2*x4;
end
function Eva=ev4(x3,x4)
Eva=1+4*x4+2*x3;
end
