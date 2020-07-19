data artificial;
input x y;
ylog=log(y);
cards;
0 .1
3 .4
8 2
13 10
16 15
20 16
PROC MEANS;
VAR Y;
OUTPUT out=new
mean=ybar;
/*proc print data=new;*/
/*proc print data=artificial;*/
proc reg data=artificial;
model y=x;
output out=b
p=yhat1
r=yresid1;
proc reg data=artificial;
model ylog=x;
output out=c
p=yhat2
r=yresid2;
/*proc print data=c;*/
/*proc print data=b;*/
data transformed;
set c;
if(_n_=1) then set new;
loginverse=exp(yhat2);
se=(y-loginverse)**2;
sto=(y-ybar)**2;
data first;
set b;
if(_n_=1) then set new;
sto=(y-ybar)**2;
se=(y-yhat1)**2;
proc means data=transformed sum;
var se sto;
output out=t1 sum=sse1 ssto1;
proc means data=first sum;
var se sto;
output out=t2 sum=sse2 ssto2;

/*proc print data=t1;*/
/*proc print data=t2;*/
data newdata;
set t1;
rsquared=1-(sse1/ssto1);
data newdata2;
set t2;
rsquared=1-(sse2/ssto2);
proc print data=newdata;
proc print data=newdata2;
run;
