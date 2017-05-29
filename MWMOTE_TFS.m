function IDIMP_data=MWMOTE_TFS(original_sample);
file_data=original_sample;
A=file_data;
[rows cols]=size(A);
us0=find(A(:,cols)==0);
A0=A(us0,:);
[A01 A02]=size(A0);
us1=find(A(:,cols)==1);
A1=A(us1,:);
[m n]=size(A1);

R1=2;
k=R1*m;
k=floor(k);
G2=MWMOTE(A,k);
data=G2;
IDIMP_data=data;

