function smote_data=SMOTE_TFS(original_sample) %this function return THE re-sampling datasets
file_data=original_sample;
% file=dir('k:\new_experiment_no_missing\missing_data_experiment\original\*.csv');

T=file_data;
T=T';
[at in]=size(T);
positivesample=find(T(end,:)==1);
negtivesample=find(T(end,:)==0);
PT=T(:,positivesample);
[PT1 PT2]=size(PT);
NT=T(:,negtivesample);
[at1 in1]=size(NT);;

T1=PT;

        R1=2;
%         for u=1:2             
        Ra2=R1;
        N2=floor(PT2*Ra2);
        k=5;
        type='numeric';
        attribute='numeric';
        m=at;
        AttVector=zeros(1,m);
        AttVector(m)=1;
        sample2=SMOTE(T1,N2,k,type,attribute,AttVector);
        C2=sample2';
        T02=T';
        A2=[T02;C2];
        data=A2;

smote_data=data;
end