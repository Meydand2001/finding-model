function [alpha] = alpha_calculator(r,v,dim,alphabet,F)
%Calculating the initial alpha vector by using the -norm(r)/norm(v) or each
%seperate section of these vectors.
alpha=zeros(1,dim*F+1);
    for j=1:dim*F+1
        if j~=dim*F+1
            alpha(j)=-norm(r((j-1)*alphabet+1:j*alphabet))/norm(v((j-1)*alphabet+1:j*alphabet));
            if isnan(alpha(j))
                alpha(j)=-1;
            end    
        else
            alpha(j)=-norm(r((j-1)*alphabet+1:end))/norm(v((j-1)*alphabet+1:end));
            if isnan(alpha(j))
                alpha(j)=-1;
            end    
        end
    end
end