function pmf = shm2pmf(b_tensor,c_tensors,alphabet,M,g_alphabet,N,fld)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
inner_vector=reshape(b_tensor,prod(g_alphabet),1);
tensormult=ones(1,prod(g_alphabet));
for n=1:N
    c_tensor=c_tensors{n};
    c_matrix=tens2mat(c_tensor,1,2:(size(n,2)+1));
    c_matrix=fullmatrix(c_matrix,alphabet,M,g_alphabet,fld{n});
    tensormult=kr(c_matrix,tensormult);
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