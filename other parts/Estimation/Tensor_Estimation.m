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
lambda=init_lambda(f);
oglambda=lambda;
matrices=init_matrices(n,alphabet,f);
ogmatrices=matrices;
r=10;
for i=1:r
    for j=1:n
      aj = admm(X,matrices,j,lambda,10,1);
      matrices{1,j}=aj;
    end
      %lambda = admm2(X,matrices,lambda,10,1);
end
for i=1:r
    lambda = admm2(X,matrices,lambda,4,1);
end
