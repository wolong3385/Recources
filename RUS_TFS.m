function RUS_data=RUS_TFS(original_sample)

A=original_sample;
data=original_sample;
R=0.7;
C=A;
[rows cols]=size(A);
us0=find(A(:,cols)==0);
A0=A(us0,:);
us1=find(A(:,cols)==1);
A1=A(us1,:);
[m1 n1]=size(A1);
[m0 n0]=size(A0);
k=R*m1;
k=floor(k);
v=randperm(m0) ;
s05=v(1:k);
A0(s05,:)=[];
new_data=[A1; A0];
RUS_data=new_data;
