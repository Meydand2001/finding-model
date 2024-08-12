close all;
load log_likelihood1.mat; load iter1.mat; load kld_accuracy1.mat; load param_accuracy1.mat; 
loglikelihoodavg=sum(log_likelihood,1)./10;
figure;
plot(iter(1,:),loglikelihoodavg);
grid on;
title("Average Log Likelihood as a Function of The Number of Iterations");
xlabel("Iterations"); ylabel("Log Likelihood");
figure;
subplot(1,2,1);
histogram(kld_accuracy);
title("KLD")
subplot(1,2,2);
histogram(param_accuracy);
title("Parameter Accuracy");
load log_likelihood2.mat; load iter2.mat; load kld_accuracy2.mat;
loglikelihoodavg=sum(log_likelihood,2)./10;
figure;
subplot(1,2,1);
hold on;
v=zeros(size(iter,3),1);
v(:)=iter(1,1,:);
for f=1:5
    plot(v,loglikelihoodavg(f,:));
end
grid on;
title("Average Log Likelihood as a Function of The Number of Iterations");
xlabel("Iterations"); ylabel("Log Likelihood");
legend("f=1","f=2","f=3","f=4","f=5");
subplot(1,2,2);
kld_accuracy_avg=sum(kld_accuracy,2)./5;
plot(1:5,kld_accuracy_avg);
grid on;
title("Average KLD as a Function of The Model Order");
xlabel("Model Order"); ylabel("KLD");
load log_likelihood3.mat; load iter3.mat; load kld_accuracy3.mat;
kldlsk=kld_accuracy;
loglikelihoodavg=sum(log_likelihood,2)./10;
figure;
subplot(1,2,1);
hold on;
v=zeros(size(iter,3),1);
v(:)=iter(1,1,:);
for f=1:5
    plot(v,loglikelihoodavg(f,:));
end
grid on;
title("Average Log Likelihood as a Function of The Number of Iterations");
xlabel("Iterations"); ylabel("Log Likelihood");
legend("structure1","structure2","structure3","stucture4","structure5");
subplot(1,2,2);
kld_accuracy_avg=sum(kld_accuracy,2)./5;
bar(kld_accuracy_avg);
title("Average KLD as of different structures");
xlabel("structure number"); ylabel("KLD");


load log_likelihood4.mat; load iter4.mat; load kld_accuracy4.mat;
loglikelihoodavg=sum(log_likelihood,2)./10;
figure;
subplot(1,2,1);
hold on;
v=zeros(size(iter,3),1);
v(:)=iter(1,1,:);
for f=1:5
    plot(v,loglikelihoodavg(f,:));
end
grid on;
title("Average Log Likelihood as a Function of The Number of Iterations");
xlabel("Iterations"); ylabel("Log Likelihood");
legend("dependencies1","dependencies2","dependencies3","dependencies4","dependencies5");
subplot(1,2,2);
kld_accuracy_avg=sum(kld_accuracy,2)./5;
bar(kld_accuracy_avg);
title("Average KLD as of different dependencies");
xlabel("dependency structure number"); ylabel("KLD");


load log_likelihood5.mat; load iter5.mat; load kld_accuracy5.mat; load param_accuracy5.mat; 
figure;
subplot(1,2,1);
hold on;
v=zeros(size(iter,2),1);
v(:)=iter(1,:);
S=[2000,5000,10000,20000,50000,100000];
for s=1:6
    plot(v,log_likelihood(s,:)./S(s));
end
grid on;
title("Average Log Likelihood(Normalized) as a Function of The Number of Iterations");
xlabel("Iterations"); ylabel("Log Likelihood");
legend("Samples=2000","Samples=5000","Samples=10000","Samples=20000","Samples=50000","Samples=10000");
subplot(1,2,2);
plot(S,kld_accuracy);
title("KLD When Using Different Number of Samples");
xlabel("Samples"); ylabel("KLD");







