function [tau1solrobust,tau2solrobust]=recoveryfit4(E,cocaine,s,mse1,mse2)
%close all
%s=1; %subject 
Base=0.9*E{s}.rr.prctile_95/1000;
%{
figure(1);
for i=1:length(E{s}.C),
    ind= E{s}.C{i}.rr.timestamp> E{s}.C{i}.window_time(3);
    plot(E{s}.C{i}.rr.sample(ind))
    hold on
end
%}
clear datac;j=0;
datac=[];
for i=1:length(E{s}.C),
    if cocaine==-1 || E{s}.C{i}.window.mark==cocaine
    ind= find((E{s}.C{i}.rr.timestamp> E{s}.C{i}.window_time(3))& ( E{s}.C{i}.rr.sample<Base*1000) );
    j=j+1;
    datac{j}.time=(E{s}.C{i}.rr.timestamp(ind)-min(E{s}.C{i}.rr.timestamp(ind)))/60000; %minutes
    datac{j}.samples=E{s}.C{i}.rr.sample(ind);
    end
%    hold on;
    
   
  % pause
 
   
   
    
end

%figure(2);
clear data;ii=0;
for i=1:length(E{s}.N),
   ind= find((E{s}.N{i}.rr.timestamp> E{s}.N{i}.window_time(3))& ( E{s}.N{i}.rr.sample< Base*1000) );

%    plot(E{s}.N{i}.rr.avg.t60,'r');
    data{i}.time=(E{s}.N{i}.rr.timestamp(ind)-min(E{s}.N{i}.rr.timestamp(ind)))/60000; %minutes
    data{i}.samples=E{s}.N{i}.rr.sample(ind);
    
    indx=data{i}.time>3;
    data{i}.time(indx)=[];
    data{i}.samples(indx)=[];
    
%    hold on;
    
    
  % pause
   
   
    
end



%%%%
%%%%Calculate rough slope estimates for recovery and drug
%%%%

clear slope slopec ;
fastind=[];
%figure(3);

for ii=1:length(data),
if length(data{ii}.samples)==0, continue;end;
coeff=regress(log(Base*1000-data{ii}.samples).',[ones(length(data{ii}.time),1) data{ii}.time.']);
slope(ii)=-coeff(2);
if slope(ii)>0.5*median(slope)
 %   plot(data{ii}.time,data{ii}.samples);
    fastind=[fastind ii];
%    hold on
end

end
fprintf('activity slope= %f\n',mean(slope))
tau1est=median(slope);
if ~isempty(datac)
for ii=1:length(datac),
coeff=regress(log(Base*1000-datac{ii}.samples).',[ones(length(datac{ii}.time),1) datac{ii}.time.']);
slopec(ii)=-coeff(2);
end
fprintf('drug slope= %f\n',mean(slopec))
tau2est=median(slopec);
end
clear datax;figure(4);
for jj=1:length(fastind)
datax{jj}=data{fastind(jj)};
end

%datax=data;


clear f0;
for ii=1:length(datax);
    f0(ii)=(Base*1000-datax{ii}.samples(1))/1000;
end

    
x=fminunc(@(x) recovery2robust([Base x(2:end)], datax,sqrt(mse1{s})),[Base tau1est f0  ]); %0.1*ones(1,length(datax))
recoveryplot2new(x,datax);
xold=x;
tau1=x(2);
if ~isempty(datac)
options=optimset('MaxFunEvals',5000);
x=fmincon(@(x) recovery3conrobust([Base tau1 x(3:end)] ,datac,sqrt(mse2{s})),[Base tau1 tau2est 0.25*ones(1,length(datac)) .1*ones(1,length(datac))],...
[],[],[],[],[0 0 .01 zeros(1,length(datac)) zeros(1,length(datac))],[],[],options);

recoveryplot3connew(x,datac);
end
Basesol{s}=Base;
tau1solrobust{s}=tau1;
if isempty(datac)
    tau2solrobust{s}=0;
else
tau2solrobust{s}=x(3);
end
end
