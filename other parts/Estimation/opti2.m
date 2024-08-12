function [gamma] = opti2(X,matrices,lambda,m,N,K,F,alpha,Q,E)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

gamma=zeros(F-1,1);
for i=1:F-1
    gamma(i,:)=(F-i)/F;
end

for n=1:N
    dermat=zeros(F-1,1);
    for f=1:F-1
        for j=1:5   
            for k=j+1:5
                for l=k+1:5
                        Aj= matrices{1,j};
                        Ak = matrices{1,k};
                        Al = matrices{1,l};
                        Clkj=kr(Al,Ak,Aj);
                        Xm=X{j,k,l};
                        Xm = tens2mat(Xm,[1,2,3]);
                        b=(Clkj*Q(:,f))./(Clkj*(E-Q*gamma));
                        der=Xm'*b;                   
                        dermat(f)=dermat(f)+der;
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
    for  i=1:F-1
        gamma(index(i))= gamma(index(i))+alpha*dermat(index(i));      
    end
end
end