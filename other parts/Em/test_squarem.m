profile on;
for i=1:10
    [pmf1,alphaanalyzer]=pmf_est_squarem2(incompleted_data_set,5,5,0.000001,200);
    %info=alphaanalyzer;
end
profile viewer;