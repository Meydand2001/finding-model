function [alpha] = alpha_modification(alpha,r,v)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if alpha>=-1
        alpha=-1;
        tetatag=teta-2*alpha*r+alpha^2*v;
        [lambdatag,matricestag]=teta2lm(tetatag,dim,alphabet,F);
        %cll=log_likelihood_calc(lambdatag,matricestag,data_set,samples,dim,alphabet,F);
    else 
        tetatag=teta-2*alpha*r+alpha^2*v;
        [lambdatag,matricestag]=teta2lm(tetatag,dim,alphabet,F);
        cll=log_likelihood_calc(lambdatag,matricestag,data_set,samples,dim,alphabet,F);
        while cll<log_likelihood
            alpha=(alpha-1)/2;
            tetatag=teta-2*alpha*r+alpha^2*v;
            [lambdatag,matricestag]=teta2lm(tetatag,dim,alphabet,F);
            cll=log_likelihood_calc(lambdatag,matricestag,data_set,samples,dim,alphabet,F);
        end
    end
    
    
end