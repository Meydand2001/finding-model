function [Amin] = admm(X,matrices,j,lambda,n,r)
%ADMM Summary of this function goes here
%   Detailed explanation goes here
%initialization
Aj=matrices{1,j};
Arj=Aj';
Uj=zeros(size(Aj));
Gj=zeros(size(lambda*lambda'));
s=size(matrices,2);
for k=1:s
    for l=k+1:s
        if k~=j && l~=j
            Ak = matrices{1,k};
            Al = matrices{1,l};
            mat=(Al'*Al).*(Ak'*Ak);
            Gj=Gj+mat;
        end    
    end
end
Gj=(lambda*lambda').*Gj;

Vj=zeros(size(Arj));
for k=1:s
    for l=k+1:s
        if k~=j && l~=j
            Ak = matrices{1,k};
            Al = matrices{1,l};
            sr=sort([j,k,l]);
            Xj=X{sr(1),sr(2),sr(3)};
            Xj = tens2mat(Xj,1);
            %size(Xj)
            Q=kr(Al,Ak);
            %size(Q)
            mat=Q'*Xj';
            Vj=Vj+mat;
        end    
    end
end
Vj= diag(lambda)*Vj;
%iteration
for i=1:n
    Arj=(Gj+r.*eye(size(Gj,1)))^-1 *(Vj+r.*(Aj+Uj)');
    Aj=projector(Aj-Arj'+Uj,size(Aj,1));
    Uj=Uj+Aj-Arj';
end
Amin=Aj;
end

