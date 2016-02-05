% find the distribution of duration of walking , driving, sitting
cd C:\Users\mahbub\Desktop\ActivityClassifier\WithDriving\Testing
file='memphis_f_p35_s03_a10_test_weka'
%file=['memphis_f_' pid '_' sid '_a10_test_weka'];
s=['java -cp "','C:\Program Files (x86)\Weka-3-7\weka.jar'...
,'" weka.classifiers.meta.AdaBoostM1 -l ActivityModel_ChestAccel_AdaboostM1_with_Driving_HF_LF_withFieldData.model -T ',file,'.arff -p 0 >,',file,'_output_ADA.txt'];
dos(s);

%parse the predicted results from weka
wekaOutputFile=[file '_output_ADA'];
%[static,running,walking,driving,res]=Results('memphis_f_p35_s03_a10_test_weka_output_ADA');
[stationary,running,walking,driving,res]=Results(wekaOutputFile);

%getting the missing values in feature matrix
%featureFile=['C:\DataProcessingFramework\data\memphis\field\feature\f_' pid '_' sid '_a10_feature'];
load('C:\DataProcessingFramework\data\memphis\field\feature\f_p35_s03_a10_feature')
%load(featureFile);
[r c]=size(F.sensor(2).feature);checkMatrix=ones(r,c);
addResult=F.sensor(2).feature+checkMatrix;
missingInd=find(sum(addResult')==0);
notmissingInd=find(sum(addResult')~=0);

%load assosciated timestamp file
%timestampFile=[file '_timestamp.txt'];
timestamps=load('memphis_f_p35_s03_a10_test_weka_timestamp.txt');
%timestamps=load(timestampFile);

predicted=res(notmissingInd);
time=timestamps(notmissingInd);

%apply majority voting over one minutes
cd C:\DataProcessingFramework\code
majorityPredicted=[];
majorityOverMinute=1;     %majority over how many minutes
majorityPeriod=majorityOverMinute*60000;
minimumOutputRequired=3;
majorityTime=[];
for i=time(1):majorityPeriod:time(end)-majorityPeriod
    ind=find(time>=i & time<i+majorityPeriod);
    if length(ind)>=minimumOutputRequired
        majorityPredicted=[majorityPredicted majority(predicted(ind))];
        majorityTime=[majorityTime i];
    end
end;

%majority over 10 minutes sliding window, 5 minutes overlapping
majorityOverSliding=[];
minute=10;                      %majority over how many minutes
slidinglen=5;                   %sliding how many minutes
period=minute*60000;
slidingPeriod=(slidinglen-1)*60000;
reqNumberOfOutput=6;
majorityFinalTimestamp=[];
timeIncrement=period-slidingPeriod;

for i=majorityTime(1):timeIncrement:majorityTime(end)
    if i>majorityTime(end)
        break;
    end
    ind=find(majorityTime>=i & majorityTime<i+period);
    if length(ind)>=reqNumberOfOutput
        majorityOverSliding=[majorityOverSliding majority(majorityPredicted(ind))];
        majorityFinalTimestamp=[majorityFinalTimestamp i];
    end
end;

figure; plot_timeseries(majorityOverSliding,majorityFinalTimestamp,'r*',2);



%write to the csv file
dir='C:\Users\mahbub\Desktop\ActivityClassifier\WithDriving\Testing';
file='memphis_f_p35_s03_a10_test_weka';
name=[dir '\' file '_predictedValues'];
id=fopen([name,'.txt'],'w');

for i=1:length(majorityOverSliding)
    str1=num2str(int64(majorityFinalTimestamp(i)));
    %str2=num2str(int64(majorityTime(i)+majorityOverMinute*60000));
    line1=[str1 ',' num2str(majorityOverSliding(i))];
    %line2='';
    %{
    if majorityPredicted(i)==0
        line1=[str1 ',stationary_start'];
        line2=[str2 ',stationary_end'];
    elseif majorityPredicted(i)==1
        line1=[str1 ',walking_start'];
        line2=[str2 ',walking_end'];
    elseif majorityPredicted(i)==2
        line1=[str1 ',running_start'];
        line2=[str2 ',running_end'];
    elseif majorityPredicted(i)==3
        line1=[str1 ',driving_start'];
        line2=[str2 ',driving_end'];
    end
    %}
    fprintf(id,line1);
    fprintf(id,'\n');
    %fprintf(id,line2);
    %fprintf(id,'\n');
end
fclose(id);

%saving to a mat file
PredictedActivity.rawprediction.value=predicted;
PredictedActivity.rawprediction.timestamp=time;
PredictedActivity.majorityOverSliding.timestamp=majorityFinalTimestamp;
PredictedActivity.majorityOverSliding.value=majorityOverSliding;
save('C:\Users\mahbub\Desktop\ActivityClassifier\WithDriving\Testing\memphis_f_p35_s03_a10_test_weka_prediction.mat','PredictedActivity');
%}
%}
