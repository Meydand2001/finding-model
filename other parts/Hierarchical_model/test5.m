t=200;
ravec=zeros(t,1);
rabvec=zeros(t,1);
rabar=zeros(t,1);
rbbar=zeros(t,1);
rabvec2=zeros(t,1);
for i=1:t
    A=rand(5,2,2,1);
    B=rand(5,2,1,2);
    C=rand(1,1,2,2);
    max_earsed=unidrnd(4);
    vector=unidrnd(4,1,max_earsed);
    vector=unique(vector);
    gamma=4-size(vector,2);
    C(:,vector)=0;
    Acom=repmat(A,1,1,1,2);
    Bcom=repmat(B,1,1,2,1);
    Ccom=repmat(C,1,2,1,1);
    t=reshape(Ccom,1,8);
    Ab=reshape(Acom,5,8);
    Bb=reshape(Bcom,5,8);
    Ab=Ab(:,t~=0);
    Bb=Bb(:,t~=0);
    t=t(t~=0);
    ravec(i)=rank(Ab*diag(t)*Bb');
    rabvec(i)=rank(Ab)+rank(Bb)-2*gamma;
    rabar(i)=min(gamma,4);
    rbbar(i)=min(gamma,4);
    rabvec2(i)=rabar(i)+ rbbar(i)-2*gamma;
end


