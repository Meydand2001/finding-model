%timevector=zeros(1,100);
%alphainfo2={1,100};
       for i=1:10
           tic;
           [pmf1,alphaanalyzer]=pmf_est_squarem2(incompleted_data_set,5,5,0.0000001,500);
           timevector(1,i+20)=toc;
           %info=[alphaanalyzer;normanalyzer];
           alphainfo2{i+20}=alphaanalyzer;
           %tic;
           %[pmf2,iter]=pmf_est_Em(incompleted_data_set,5,5,0.0000001,1500);
           %timeinfo(2,10+i)=toc;
           %iterinfo(1,10+i)=iter;
       end
 