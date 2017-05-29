function ROS_data=ROS_TFS(original_sample)

data=original_sample;
positivesample=find(data(:,end)==1);
negtivesample=find(data(:,end)==0);
PT=data(positivesample,:);
NT=data(negtivesample,:);
[PT1 PT2]=size(PT);
[PN1 PN2]=size(NT);
m=PT1;
k=2;
%         for u=1:2
t=k*PT1; % number of duplicated instances
t=fix(t);
a=rand(1,t);
b=a*m+1;
c=floor(b);
S=PT(c,:);
%                 data=[data;S];
new_data=[data;S];
%
ROS_data=new_data;
