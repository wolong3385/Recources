% this method return the missing data 
% this programme is used for information decompositon missing data
% imputation method
%function id(X)
% X be a column vector
% A is a matrix with missing values denoted as NaN 
function reovered=coefficient_IDIM_recovery(A);
A=A;
cofA=A;
[rows columns]=size(A);
for uu=1:columns
    originalX=A(:,uu);
    nanVals = isnan(originalX);
    Begain=min(originalX);  % compute many times
    End=max(originalX);
    K=sum(nanVals);
    if sum(nanVals)~=0
        [rows,cols] = find(nanVals);
        nmdr=find(nanVals==0);%not missing data row
        mdr=find(nanVals==1);%missing data row
        X=originalX(nmdr);
        if Begain==End;
            originalX(mdr)=End;
            originalX(mdr)=End;
        else
            imputeddata=idimputate(X,Begain,End,K);
            originalX(mdr)=imputeddata;
        end
        A(:,uu)=originalX;
    else
        A(:,uu)=originalX;
    end
end
reovered=A;

function rcd=idimputate(X,Begain0,End0,K);

X=X;
b=Begain0;
e=End0;
k=K;
delta=abs(b-e)/k;
st=[b];
ed=[];
m=[];
rcd=[];  %recovery data
rec1=[];
rcd2=[];
rcd3=[];
if k==1
    st=[b];
    ed=[e];
else
    for i=1:k-1;  % get the start points and end points of each interval
        st1=b+delta*i;
        st=[st st1];
        ed=[ed st1];
    end
    ed=[ed e];
end
for i=1:k   % get the middle value of each interval
    middleinterval=(st(i)+ed(i))/2;
    m=[m middleinterval]; %the middle values of the interval used for missing data recovery
end


if k<2
    z1=find1(X,st(1),ed(1));
    %%%        x1=imputedata(z1,delta,m(1));
    %  x1=imputedata(z1,delta,m(1));
    [x1 coefficient1]=imputedata(z1,delta,m(1));
    ximpute=[x1]';
    nonzero=(ximpute~=0);
    tcoefficient=[coefficient1];
    if sum(nonzero)~=0
        [rows cols]=find(nonzero);
        [denominator,nondenominator]=size(rows);
        recoveryx11=sum(ximpute);
        recoveryx11=recoveryx11/sum(tcoefficient);
        rcd11=[recoveryx11];
    else
        recoveryx11=mean(X);
        rcd11=[recoveryx11];
    end
    rcd=rcd11;
else % when K>2 use  the following programme
    
    if length(m)>1
        z1=find1(X,st(1),ed(1));
        [x1 coefficient1]=imputedata(z1,delta,m(1)); % return the coefficient of each data
        z1=find1(X,ed(1),m(2));
        x2=imputedata(z1,delta,m(1));
        [x2 coefficient2]=imputedata(z1,delta,m(1));% return the coefficient of each data
        ximpute=[x1 x2]';
        nonzero=ximpute~=0;
        tcoefficient=[coefficient1 coefficient2];
        if sum(nonzero)~=0
            [rows cols]=find(nonzero);
            recoveryx11=sum(ximpute);
            recoveryx11=recoveryx11/sum(tcoefficient);
            rcd11=[recoveryx11];
        else
            recoveryx11=mean(X);
            rcd11=[recoveryx11];
        end
    end
    %the following steps is for i=2:k-1
    rcd22=[];
    for i=2:k-1
        z1=find1(X,st(i),ed(i));
        
        [x1 coefficient1]=imputedata(z1,delta,m(i));
        z1=find1(X,m(i-1),st(i));
        [x2 coefficient2]=imputedata(z1,delta,m(i));
        z1=find1(X,ed(i),m(i+1));
        [x3 coefficient3]=imputedata(z1,delta,m(i));
        tcoefficient3=[coefficient1 coefficient2 coefficient3];
        ximpute=[x1 x2 x3]';
        nonzero=(ximpute~=0);
        if sum(nonzero)~=0
            recoveryx22=sum(ximpute);
            recoveryx22=recoveryx22/sum(tcoefficient3);
        else
            recoveryx22=mean(X);
        end
        rcd22=[rcd22 recoveryx22];
    end
    %%%%    while i==k
    z1=find1(X,st(k),ed(k));
    [x1 coefficient1]=imputedata(z1,delta,m(k));
    z1=find1(X,m(k-1),st(k));
    [x2 coefficient2]=imputedata(z1,delta,m(k));
    ximpute=[x1 x2]';
    nonzero=(ximpute~=0);
    tcoefficient=[coefficient1 coefficient2];
    if sum(nonzero)~=0
        [rows cols]=find(nonzero);
        [denominator,nondenominator]=size(rows);
        recoveryx33=sum(ximpute);
        recoveryx33=recoveryx33/sum(tcoefficient);
        rcd33=[recoveryx33];
    else
        recoveryx33=mean(X);
        rcd33=[recoveryx33];
    end
    % weight with cofficient of each data
    rcd11=rcd11';
    rcd22=rcd22';
    rcd33=rcd33';
    rcdcof=[rcd11; rcd22; rcd33];
    rcd=rcdcof;
end




%data recovery
function [x1 coefficient]=imputedata(A,a,b); % imputedata(z1,delta,m(k))
x=A;
delta=a;
mid=b;
if isempty(x)==0
    fun=@(t)(1-abs(t-mid)/delta).*t;
    fun1=@(t)1-abs(t-mid)/delta;
    x1=fun(x);
    coefficient=fun1(x);
else
    x1=[];
    coefficient=[];
end
% x1;
% coefficient;

% find out the values between x0 and x1 in B.
function [z1]=find1(X,x0,x1)
x0=x0;
x1=x1;
z1=[];
z2=[];
B=X;
for i=1:length(B);
    if B(i)>=x0 && B(i)<x1;
        z11=B(i);
        z1=[z1,z11];
    end
end
z1;
