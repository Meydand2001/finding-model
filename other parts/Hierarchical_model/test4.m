t=100;
logical_indices=zeros(4,t);
for i=1:t
    for j=1:4
        if j==1
            C=rand(10,3,1,3,1,3);
            A=rand(10,1,1,3,1,3);
            fc=27; fa=9;
            max_earsed=unidrnd(27);
            vector=unidrnd(27,1,max_earsed);
            vector=unique(vector);
            gamma=27-size(vector,2);
            C(:,vector)=0;
            C=repmat(C,1,1,3,1,3,1);
            A=repmat(A,1,3,3,1,3,1);
            C=reshape(C,10,243);
            A=reshape(A,10,243);
            A=A(:,C(1,:)~=0);
            ra=rank(A);
            logical_indices(j,i)= ra>=min(fa/fc*gamma,9);
        elseif j==2
            C=rand(10,3,1,3,1,3);
            A=rand(10,3,1,3,3,3);
             fc=27; fa=81;
            max_earsed=unidrnd(27);
            vector=unidrnd(27,1,max_earsed);
            vector=unique(vector);
            gamma=27-size(vector,2);
            C(:,vector)=0;
            C=repmat(C,1,1,3,1,3,1);
            A=repmat(A,1,1,3,1,1,1);
            C=reshape(C,10,243);
            A=reshape(A,10,243);
            A=A(:,C(1,:)~=0);
            ra=rank(A);
            logical_indices(j,i)= ra>=min(fa/fc*gamma,10);
        elseif j==3
            C=rand(10,3,1,3,1,3);
            A=rand(10,1,3,1,3,1);
            fc=27; fa=9;
            max_earsed=unidrnd(27);
            vector=unidrnd(27,1,max_earsed);
            vector=unique(vector);
            gamma=27-size(vector,2);
            C(:,vector)=0;
            C=repmat(C,1,1,3,1,3,1);
            A=repmat(A,1,3,1,3,1,3);
            C=reshape(C,10,243);
            A=reshape(A,10,243);
            A=A(:,C(1,:)~=0);
            ra=rank(A);
            logical_indices(j,i)= ra>=min(fa/fc*gamma,9);
        else
            C=rand(10,3,1,3,1,3);
            A=rand(10,1,1,3,3,1);
            fc=27; fa=9;
            max_earsed=unidrnd(27);
            vector=unidrnd(27,1,max_earsed);
            vector=unique(vector);
            gamma=27-size(vector,2);
            C(:,vector)=0;
            C=repmat(C,1,1,3,1,3,1);
            A=repmat(A,1,3,3,1,1,3);
            C=reshape(C,10,243);
            A=reshape(A,10,243);
            A=A(:,C(1,:)~=0);
            ra=rank(A);
            logical_indices(j,i)= ra>=min(fa/fc*gamma,9);
        end
    end
end
