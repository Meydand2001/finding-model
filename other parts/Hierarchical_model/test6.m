A=rand(5,2,2,2);
B=rand(5,2,2,1);
C=rand(5,2,2,1);
Bcom=repmat(B,1,1,1,2);
Ccom=repmat(C,1,1,1,2);
Ab=reshape(A,5,8);
Bb=reshape(Bcom,5,8);
Cb=reshape(Ccom,5,8);
matrices=cell(1,3);
matrices{1}=Ab; matrices{2}=Bb; matrices{3}=Cb;
cpd=cpdgen(matrices);
X=cell(1,5);
for k=1:5
    X{k}=Ab*diag(Cb(k,:))*Bb';
end

A2=A(:,:,:,1)+A(:,:,:,2);
Ab2=reshape(A2,5,4);
Bb2=reshape(B,5,4);
Cb2=reshape(C,5,4);
matrices2=cell(1,3);
matrices2{1}=Ab2; matrices2{2}=Bb2; matrices2{3}=Cb2;
cpd2=cpdgen(matrices2);




