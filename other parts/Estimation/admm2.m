function [lambdamin] = admm2(X,matrices,lambda,n,r)
%ADMM2 Summary of this function goes here
%   Detailed explanation goes here
%Aj=matrices{1,j};
lamt=lambda;
u=zeros(size(lambda));
G=zeros(size(lambda*lambda'));
s=size(matrices,2);
for j=1:s
    for k=j+1:s
        for l=k+1:s
            Aj = matrices{1,j};
            Ak = matrices{1,k};
            Al = matrices{1,l};
            Q = kr(Al,Ak,Aj);
            mat=Q'*Q;
            G=G+mat;
        end    
    end
end

V=zeros(size(lambda));
for j=1:s
    for k=j+1:s
        for l=k+1:s
            Aj = matrices{1,j};
            Ak = matrices{1,k};
            Al = matrices{1,l};
            Xj=X{j,k,l};
            Xj=tens2mat(Xj,[1,2,3]);
            Q=kr(Al,Ak,Aj);
            mat=Q'*Xj;
            V=V+mat;
        end
    end
end

size(G);
size(V);
%iteration
for i=1:n
    %size(lambda)
    %size(lamt)
    lamt=(G+r.*eye(size(G)))^-1 *(V+r.*(lamt+u));
    %size(lamt)
    lambda=projector(lambda-lamt+u,size(lambda,1));
    %size(lambda)
    u=u+lambda-lamt;
end
%size(lambda)
lambdamin=lambda;
end

