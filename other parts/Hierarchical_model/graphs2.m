close all;
load results/log_likelihood6.mat; load results/iter6.mat; load results/kld_accuracy6.mat; load results/param_accuracy6.mat; 
loglikelihoodavg=sum(log_likelihood,1)./100;
figure;
loglog(iter(1,:),-loglikelihoodavg);
grid on;
title("Average of Minus Log Likelihood as a Function of The Number of Iterations");
xlabel("Iterations"); ylabel("Minus Log Likelihood");
figure;
histogram(kld_accuracy);
grid;
title("KLD")
xlabel("KLD Value"); ylabel("Number of Trials");
figure;
histogram(param_accuracy);
grid;
title("Parameter accuracy");
xlabel("Parameter accuracy"); ylabel("Number of Trials");

load results/log_likelihood2.mat; load results/iter2.mat; load results/kld_accuracy2.mat;
loglikelihoodavg=sum(log_likelihood,2)./50;
figure;
v=zeros(size(iter,3),1);
v(:)=iter(1,1,:);
loglog(v,-loglikelihoodavg(1,:));
hold on;
loglog(v,-loglikelihoodavg(2,:));
loglog(v,-loglikelihoodavg(3,:));
grid on;
title("Average Minus Log Likelihood as a Function of The Number of Iterations");
xlabel("Iterations"); ylabel("Minus Log Likelihood");
legend("f=1","f=2","f=3");
figure
kld_accuracy_avg=sum(kld_accuracy,2)./50;
plot(1:3,kld_accuracy_avg);
grid on;
title("Average KLD as a Function of The Model Order");
xlabel("Model Order"); ylabel("KLD");


load results/log_likelihood5.mat; load results/iter5.mat; load results/kld_accuracy5.mat;
S=[2000,5000,10000,20000,50000,100000,200000];
%{
figure;
v=zeros(size(iter,3),1);
v(:)=iter(1,1,:);
loglikelihoodavg=sum(log_likelihood,2)./10;
S=[2000,5000,10000,20000,50000,100000,200000];
for s=1:7
    size(-log_likelihood(s,:))
    loglog(v,-log_likelihood(s,:)./S(s));
    hold on;
end
grid on;
title("Average Log Likelihood(Normalized) as a Function of The Number of Iterations");
xlabel("Iterations"); ylabel("Log Likelihood");
legend("Samples=2000","Samples=5000","Samples=10000","Samples=20000","Samples=50000","Samples=100000","Samples=200000");
%}
figure;
kld_accuracy_avg=sum(kld_accuracy,2)./10;
loglog(S,kld_accuracy_avg);
grid on;
title("KLD When Using Different Number of Samples");
xlabel("Samples"); ylabel("KLD");

load results/kld_cpd1.mat; 
%loglikelihoodavg=sum(log_cpd,2)./50;
figure;
subplot(1,2,1);
histogram(kld_accuracy1(1,:));
grid on;
title("KLD Using HM EM")
xlabel("KLD Value"); ylabel("Number of Trials");
subplot(1,2,2);
histogram(kld_accuracy1(2,:));
grid on;
title("KLD Using EM")
xlabel("KLD Value"); ylabel("Number of Trials");
load results/kld_cpd2.mat; 
figure;
subplot(1,2,1);
histogram(kld_accuracy2(1,:));
grid on;
title("KLD Using HM EM")
xlabel("KLD Value"); ylabel("Number of Trials");
subplot(1,2,2);
histogram(kld_accuracy2(2,:));
grid on;
title("KLD Using EM")
xlabel("KLD Value"); ylabel("Number of Trials");


