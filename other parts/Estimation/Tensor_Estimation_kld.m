m=1000;
n=5;
alphabet=5;
f=7;
%data = unidrnd(alphabet,m,n);
%ber=binornd(1,9/10*ones(1000,5));
%incomdata=data.*ber;
empirical_triplets=empirical_triplets_gen(data,alphabet,m,n);
empirical_triplets_2=empirical_triplets_gen(incomdata,alphabet,m,n);
X=empirical_triplets;
K=alphabet;
lambda=init_lambda(f);
oglambda=lambda;
matrices=init_matrices(n,alphabet,f);
ogmatrices=matrices;
I=eye(K);
for i=1:K-1
    Q(:,i)=I(:,i)-I(:,i+1);
end
E=zeros(K,f);
E(1,:)=ones(1,f);

I=eye(f);
Ql=zeros(f,f-1);
for i=1:f-1
    Ql(:,i)=I(:,i)-I(:,i+1);
end
e1=I(:,1);
r=10;
    for m=1:n
      Bm = opti1(X,matrices,lambda,m,200,K,f,-0.0001,Q,E);
      Am= E-Q*Bm;
      matrices{1,m}=Am;
    end
    gamma = opti2(X,matrices,lambda,m,200,K,f,-0.0001,Ql,e1);%opti2
    lambda=e1-Ql*gamma;
