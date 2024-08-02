function [pmf] = hm2pmf(lambda,b_matrices,a_tensors,F,alphabet,M,g_alphabet,N,fld)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
matmult=ones(1,F);
for m=1:M
    %matrix=b_matrices{m};
    matmult=kr(b_matrices{m},matmult);
end
inner_vector=matmult*lambda;
tensormult=ones(1,prod(g_alphabet));
for n=1:N
    a_tensor=a_tensors{n};
    a_matrix=tens2mat(a_tensor,1,2:(size(n,2)+1));
    a_matrix=fullmatrix(a_matrix,alphabet,M,g_alphabet,fld{n});
    tensormult=kr(a_matrix,tensormult);
end
pmf_vector=tensormult*inner_vector;
pmf=mat2tens(pmf_vector,alphabet*ones(1,N),1:N);
end


function [full]= fullmatrix(matrix,alphabet,M,g_alphabet,fld)
    cummatrix=matrix;
    for g=2:prod(g_alphabet(setdiff(1:M,fld)))
        cummatrix=[cummatrix;matrix];
    end
    %[alphabet;g_alphabet']'
    %[1,setdiff(1:M,fld)+1]
    %fld+1
    %cummatrix
    %size(cummatrix)
    tensor=mat2tens(cummatrix,[alphabet;g_alphabet']',[1,setdiff(1:M,fld)+1],fld+1);
    full=tens2mat(tensor,1,2:M+1);
end