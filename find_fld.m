function [array_of_sizes,fld] = find_fld(data_set,alphabet,model_order,N,epsilon,max_iterations,tries,threshold)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
g_alphabet=factor(model_order);
M=size(g_alphabet,2);
array_of_sizes=cell(N,1);
fld=cell(N,1);
afld=cell(N,1);
for n=1:N
    array_of_sizes{n}=g_alphabet;
    fld{n}=1:M;
    afld{n}=[];
end

rwu=0;
bin_vector=zeros(1,M);
coupling=couple(fld,N,M);
while rwu~=tries
    rwu=rwu+1;
    [~,c_tensors,~,~] = pmf_est_shm_em(data_set,alphabet,g_alphabet,M,array_of_sizes,fld,epsilon,max_iterations);
    new_array_of_sizes=cell(1,N);  
    array_of_vidx=cell(1,N);
    array_of_removal=cell(1,N);
    
    for n=1:N
        array_of_size=array_of_sizes{n};  
        c_matrix=tens2mat(c_tensors{n},1,2:(M+1)); %reshape each a_tensor.
        col=size(c_matrix,2);
        sm=size(array_of_size,2);
        accumulated=1;
        vidx=1;
        thresholdn=threshold*sqrt(20000/size(data_set,1));
        for m=1:sm
            kcluster=accumulated*array_of_size(m);
            [kld_distance,idx]=cluster_coloumns(c_matrix,col,kcluster); % cluster its vectors according to the sizes.
            if kld_distance < threshold && kcluster~=prod(array_of_size) % use kld of all the clusters and compare to a threshold
               accumulated=accumulated*array_of_size(m);
               vidx=idx;
               thresholdn=sqrt(thresholdn*kld_distance);
               rwu=0;
            end
        end
        new_array_of_sizes{n}=factor(prod(array_of_size)/accumulated);
        array_of_removal{n}=factor(accumulated);
        array_of_vidx{n}=vidx;
    end
    [fld,afld,array_of_sizes,bin_vector,coupling]=update_fld(N,M,g_alphabet,fld,afld,array_of_sizes,array_of_removal,array_of_vidx,bin_vector,coupling);
end
end

function [fld,afld,array_of_sizes,bin_vector,coupling]=update_fld(N,M,g_alphabet,fld,afld,array_of_sizes,array_of_removal,array_of_vidx,bin_vector,coupling)
    %quant=sum(g_alphabet==g_alphabet(m))==1;
removal_quantity=zeros(N,1);
for n=1:N
    removal_quantity(n)=size(array_of_removal{n},2);
end
[~,removal_order]=sort(removal_quantity);
for m=1:M
    %quant=sum(g_alphabet==g_alphabet(m))==1;
    for n=1:N
        if bin_vector(m)==0
            if sum(g_alphabet(m)==array_of_removal{removal_order(n)})>=1 && sum(fld{n}==m)==1
                %remove and impose order
                newfldn=setdiff(fld{removal_order(n)},m);
                newafldn=setdiff(1:M,newfldn);
                array_of_vidx=impose_order(N,M,m,removal_order(n),g_alphabet,fld,afld,newfldn,newafldn,array_of_sizes,array_of_vidx);
                fld{removal_order(n)}=newfldn;
                afld{removal_order(n)}=newafldn;
                if size(array_of_removal{removal_order(n)},2)==1
                    array_of_removal{removal_order(n)}=1;
                else
                    removal=array_of_removal{removal_order(n)};
                    array_of_removal{removal_order(n)}=removal(2:end);
                end
                array_of_sizes{removal_order(n)}=g_alphabet(fld{removal_order(n)});
                coupling=couple(fld,N,M);
                if size(coupling{m},2)>1
                    couplingm=coupling{m};
                    for k=1:size(couplingm,2)
                        bin_vector(couplingm(k))=2;
                    end
                else
                    bin_vector(m)=1;
                end
            end
        elseif bin_vector(m)==1
            if sum(g_alphabet(m)==array_of_removal{removal_order(n)})>=1 && sum(fld{n}==m)==1
                [valid_score,array_of_vidx]=validation(removal_order(n),m,fld,array_of_sizes,array_of_vidx);
                if  valid_score==1
                %remove no need to impose order
                    fld{removal_order(n)}=setdiff(fld{removal_order(n)},m);
                    afld{removal_order(n)}=setdiff(1:M,fld{removal_order(n)});
                    if size(array_of_removal{removal_order(n)},2)==1
                        array_of_removal{removal_order(n)}=1;
                    else
                        removal=array_of_removal{removal_order(n)};
                        array_of_removal{removal_order(n)}=removal(2:end);
                    end
                    array_of_sizes{removal_order(n)}=g_alphabet(fld{removal_order(n)});
                    coupling=couple(fld,N,M);
                    if size(coupling{m},2)>1
                        couplingm=coupling{m};
                       for k=1:size(couplingm,2)
                           bin_vector(couplingm(k))=2;
                       end
                    else
                        bin_vector(m)=1;
                    end
                end
            end
        else
            if sum(g_alphabet(m)==array_of_removal{removal_order(n)})>=1 && sum(fld{n}==m)==1
                couplingm=coupling{m};
                r_matrix=fld2r(fld,N,M);
                checkindex=find(1-r_matrix(:,couplingm(1)),1,'first');
                newfldn=setdiff(fld{removal_order(n)},m);
                newafldn=setdiff(1:M,newfldn);
                [valid_score,new_array_of_vidx]=validation_order(N,M,m,removal_order(n),checkindex,g_alphabet,fld,afld,newfldn,newafldn,array_of_sizes,array_of_vidx);
                if  valid_score==1
                %remove and impose order
                    array_of_vidx=new_array_of_vidx;
                    fld{removal_order(n)}=newfldn;
                    afld{removal_order(n)}=newafldn;
                    if size(array_of_removal{removal_order(n)},2)==1
                        array_of_removal{removal_order(n)}=1;
                    else
                        removal=array_of_removal{removal_order(n)};
                        array_of_removal{removal_order(n)}=removal(2:end);
                    end
                    array_of_sizes{removal_order(n)}=g_alphabet(fld{removal_order(n)});
                    coupling=couple(fld,N,M);
                    if size(coupling{m},2)>1
                        couplingm=coupling{m};
                        for k=1:size(couplingm,2)
                            bin_vector(couplingm(k))=2;
                        end
                    else
                        bin_vector(m)=1;
                    end
                end
            end
        end
    end
end
end

function [valid_score,vidx]=validation(n,m,fld,array_of_sizes,vidx)
valid_score=1;
fldn=fld{n};
sizes=array_of_sizes{n};
vidxn=vidx{n};
if ismember(m,fldn)
    vidxn=mat2tens(vidxn,sizes,1:size(fldn,2),[]);
    vidxncheck=sum(vidxn,find(~(fldn-m)))./sizes(fldn==m);
    check=vidxn-vidxncheck;
    if ~all(~check(:))
        valid_score=0;
    else
        vidx{n}=tens2mat(vidxncheck,1:size(fldn,2),[]);
    end
end
end

function vidx=impose_order(N,M,m,j,g_alphabet,fld,afld,newfldj,newafldj,array_of_sizes,vidx)
fldj=fld{j};
afldj=afld{j};
sizej=array_of_sizes{j};
[~,order]=sort(vidx{j});
comp_matrix=0:prod(g_alphabet(afldj))-1;
comp_matrix=repmat(comp_matrix.*prod(sizej),prod(sizej),1);
comp_order=order+comp_matrix;
comp_order=comp_order(:);
d_permutation=1:size(g_alphabet,2);
d_permutation(1)=m; d_permutation(m)=1;
imposed_order=mat2tens(comp_order,g_alphabet,1:size(g_alphabet,2),[]);
imposed_order=permute(imposed_order,d_permutation);
imposed_order=tens2mat(imposed_order,1:size(g_alphabet,2),[]);
for n=1:N
    fldn=fld{n};
    sizes=array_of_sizes{n};
    afldn=afld{n};
    vidxn=vidx{n};
    if size(vidxn,1)~=1
        tens_v=ones(1,M);
        tens_v(fldn)=g_alphabet(fldn);
        tensor_vidx=mat2tens(vidxn,tens_v,1:M,[]);
        fill_v=ones(1,M);
        fill_v(afldn)=g_alphabet(afldn);
        full_tensor_vidx=repmat(tensor_vidx,fill_v);
        d_per=1:M; d_per(1)=m; d_per(m)=1;
        full_tensor_vidx=permute(full_tensor_vidx,d_per);
        full_vidx=tens2mat(full_tensor_vidx,1:M,[]);
        new_full_vidx=full_vidx(imposed_order);
        new_full_tensor_vidx=mat2tens(new_full_vidx,g_alphabet,1:M,[]);
        new_full_tensor_vidx=permute(new_full_tensor_vidx,d_per);
        if n==j
            new_full_vidx=tens2mat(new_full_tensor_vidx,newfldj,newafldj);
        else
            new_full_vidx=tens2mat(new_full_tensor_vidx,fldn,afldn);
        end
        new_vidx=new_full_vidx(:,1);
        vidx{n}=new_vidx;
    end     
end
end

function [valid_score,nvidx]=validation_order(N,M,m,j,checkj,g_alphabet,fld,afld,newfldj,newafldj,array_of_sizes,vidx)
valid_score=0;
nvidx=vidx;
fldj=fld{j};
afldj=afld{j};
sizej=array_of_sizes{j};
[~,order]=sort(nvidx{j});
comp_matrix=0:prod(g_alphabet(afldj))-1;
comp_matrix=repmat(comp_matrix.*prod(sizej),prod(sizej),1);
comp_order=order+comp_matrix;
comp_order=comp_order(:);
d_permutation=1:size(g_alphabet,2);
d_permutation(1)=m; d_permutation(m)=1;
imposed_order=mat2tens(comp_order,g_alphabet,1:size(g_alphabet,2),[]);
imposed_order=permute(imposed_order,d_permutation);
imposed_order=tens2mat(imposed_order,1:size(g_alphabet,2),[]);

fldcheckj=fld{checkj};
sizescheckj=array_of_sizes{checkj};
afldcheckj=afld{checkj};
vidxcheckj=1:prod(sizescheckj);
tens_vc=ones(1,M);
tens_vc(fldcheckj)=g_alphabet(fldcheckj);
tensor_vidxc=mat2tens(vidxcheckj,tens_vc,1:M,[]);
fill_vc=ones(1,M);
fill_vc(afldcheckj)=g_alphabet(afldcheckj);
full_tensor_vidxc=repmat(tensor_vidxc,fill_vc);
d_per=1:M; d_per(1)=m; d_per(m)=1;
full_tensor_vidxc=permute(full_tensor_vidxc,d_per);
full_vidxc=tens2mat(full_tensor_vidxc,1:M,[]);
new_full_vidxc=full_vidxc(imposed_order);
if sum(new_full_vidxc==full_vidxc)==size(imposed_order)
    valid_score=1;
end
if valid_score==0
    return;
end

for n=1:N
    fldn=fld{n};
    sizes=array_of_sizes{n};
    afldn=afld{n};
    vidxn=nvidx{n};
    if size(vidxn,1)~=1
        tens_v=ones(1,M);
        tens_v(fldn)=g_alphabet(fldn);
        tensor_vidx=mat2tens(vidxn,tens_v,1:M,[]);
        fill_v=ones(1,M);
        fill_v(afldn)=g_alphabet(afldn);
        full_tensor_vidx=repmat(tensor_vidx,fill_v);
        d_per=1:M; d_per(1)=m; d_per(m)=1;
        full_tensor_vidx=permute(full_tensor_vidx,d_per);
        full_vidx=tens2mat(full_tensor_vidx,1:M,[]);
        new_full_vidx=full_vidx(imposed_order);
        new_full_tensor_vidx=mat2tens(new_full_vidx,g_alphabet,1:M,[]);
        new_full_tensor_vidx=permute(new_full_tensor_vidx,d_per);
        if n==j
            new_full_vidx=tens2mat(new_full_tensor_vidx,newfldj,newafldj);
        else
            new_full_vidx=tens2mat(new_full_tensor_vidx,fldn,afldn);
        end
        new_vidx=new_full_vidx(:,1);
        nvidx{n}=new_vidx;
    end     
end
end


function r_matrix=fld2r(fld,N,M)
r_matrix=zeros(M,N);
for n=1:N
    r_matrix(fld{n},n)=1;
end
end

function coupling=couple(fld,N,M)
r_matrix=fld2r(fld,N,M);
coupling=cell(M,1);
for m=1:M
    b=r_matrix==r_matrix(m,:);
    sb=sum(b,2);
    coupind=find(sb==N);
    coupling{m}=coupind;
end
end




%{
function fld=update_fld(N,g_alphabet,old_fld,old_array_of_sizes,array_of_removal,array_of_vidx)
fld=cell(1,N);
for n=1:N
    sizes=old_array_of_sizes{n};
    removal=array_of_removal{n};
    vidx=array_of_vidx;
    old_fldn=old_fld{n};
    if removal==1
        fld{n}=old_fld{n};
        break;
    end
    for m=1:size(removal,2)
        if sum(sizes==removal(m))==1
            fld{n}=setdiff(old_fldn,old_fldn(sizes==removal(m)));
            array_of_sizes{n}=setdiff(sizes,removal(m));
        else
            removal_idx=find_valid_removal(N,old_fld,old_array_of_sizes,array_of_removal,vidx);
            fld{n}=setdiff(old_fldn,old_fldn(removal_idx));
            array_of_sizes{n}=setdiff(sizes,sizes(removal_idx));
        end
        array_of_vidx=update_vidx(array_of_vidx);
    end
end
end


function removal_idx=find_valid_removal(N,old_fld,old_array_of_sizes,vidx)
option_con=zeros(1,M);
for m=1:M
    valid_score=validation(N,m,old_fld,old_array_of_sizes,vidx);
    option_con(m)=valid_score;
end
removal_idx=find(option_con,1,'first');
end


function valid_score=validation(N,m,old_fld,old_array_of_sizes,vidx)
valid_score=1;
for n=1:N
    old_fldn=old_fld{n};
    sizes=old_array_of_sizes{n};
    if ~ismember(m,old_fldn)
        vidx=mat2tens(vidx,sizes);
        check=vidx-sum(vidx,m)./sizes(m);
        if ~all(~check)
            valid_score=0;
        end
    end
end
end


function vidx=update_vidx(N,M,k,m,old_fld,old_array_of_sizes,array_of_vidx)
vidx=array_of_vidx{k};
[sorted,order]=sort(vidx);
tens_vidx=mat2tens(sorted,old_array_of_sizes{k});
tens_order=mat2tens(order,old_array_of_sizes{k});
p_vector=1:M; p_vector(m)=1; p_vector(1)=m;
tens_vidx=permute(tens_vidx,p_vector);
tens_order=permute(tens_order,p_vector);
vec_order=reshape(tens_order,1,mult(old_array_of_sizes{k}));
for n=1:N
    tens_vidx=mat2tens(vidx,sizes);
end
end
%}