
 [pmf1,alphaanalyzer,test]=pmf_est_squarem2(incompleted_data_set,5,5,0.0000001,50,[20,25,30,35,40],1);
 for i=1:5
    subplot(2,3,i);
    plot(-20:-1,test(i,:));
    grid on;
    title('log-likelihood as a function of $\alpha_1$','Interpreter','latex');
    xlabel('$\alpha_1$','Interpreter','latex');
    ylabel('log-likelihood');
 end