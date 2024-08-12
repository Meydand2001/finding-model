function [Bm] = opti1(X,matrices,lambda,m,N,K,F,alpha,Q,Em)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Bm=zeros(K-1,F);
for i=1:K-1
    Bm(i,:)=(K-i)/K;
end

for n=1:N
    dermat=zeros(K-1,F);
    for  i=1:K-1
        for f=1:F
            for k=1:5
                for l=k+1:5
                    if k~=m && l~=m
                        Ak = matrices{1,k};
                        Al = matrices{1,l};
                        Clk=kr(Al,Ak)*diag(lambda);
                        s=sort([m,k,l]);
                        Xm=X{s(1),s(2),s(3)};
                        Xm = tens2mat(Xm,1);
                        der=-norm(Xm'./(Clk*(Em-Q*Bm)').*(Clk(:,f)*Q(:,i)'),1);
                        dermat(i,f)=dermat(i,f)+der;
                    end    
                end
            end
        end
    end
%
%for 
%for  i=1:K-1
%    for f=1:F
%find every time the maximum abs derivative.
% idealy we should sort the values.
%Bm(specific index)=Bm(specific index)+alpha*derivative
%repeating the calculation od derivatives and the step for n iterations.
%opti 2 is exactly the same but with a bit different der.
    absder=abs(dermat);
    [val,index]=sort(absder(:),'descend');
    for  i=1:(K-1)*F
        Bm(index(i))= Bm(index(i))+alpha*dermat(index(i));      
    end
end
end