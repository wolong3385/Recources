function [T TT]=MWMOTE_im(data_sample);
%T is a 11 times 100 matrix, TT is the average values of each iterative
%time, that is it is a 11 time 10 matrix
A=data_sample;
xdata=A(:,1:end-1);
group = A(:,end);
T=[];
TT=[];
MWMTOE_COUNTER=0;
for j=1:10
    indices = crossvalind('Kfold',group,5);
    for i = 1:5
        MWMTOE_COUNTER=MWMTOE_COUNTER+1
        Test = (indices == i); Train = ~Test;
        TrainingSample=xdata(Train,:);
        TrainingLabel=group(Train,1);
        TestingSample=xdata(Test,:);
        TestingLabel=group(Test,1);
        Training_data=[TrainingSample TrainingLabel]; % training data for resampling
        MWMTOE_COUNTER
        Training_data=MWMOTE_TFS(Training_data); % MWMOTE Oversampling
        MWMTOE_COUNTER
        TrainingSample=Training_data(:,1:end-1);
        TrainingLabel=Training_data(:,end);
        
        
        tree=ClassificationTree.fit(TrainingSample, TrainingLabel);
        OutLabel=predict(tree,TestingSample);
        [Acc Pre Recall FM GM FPR AUC Kappa MS MCC ER]= resultanalysis(OutLabel,TestingLabel);
        results=[Acc Pre Recall FM GM FPR AUC Kappa MS MCC ER]';
        T=[T results];
    end
    NANA=isnan(T);
    T(NANA)=0;
    STDD=mean(T')';
    TT=[TT STDD];
end