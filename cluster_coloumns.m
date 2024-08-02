function [kld_distance,idx] = cluster_coloumns(c_matrix,col,g)
if anynan(c_matrix)
    c_matrix
end
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
kld_distance=inf;
[idx,C]=kmedoids_balanced(c_matrix',col/g);
valid=checkpartition(idx,g,col/g);
if valid==0
    return;
end
kld_distance=kld_distance_cal(c_matrix,idx,C',col);
end

function [valid]=checkpartition(idx,g,clusters)
valid=1;
for i=1:clusters
    num=sum(idx==i);
   if num~=g 
       valid=0;
   end
end
end


function [kld_distance]=kld_distance_cal(matrix,idx,C,col)
kld_distance=0;
for i=1:col
    kld_distance=kld_distance+kld_accuracy_calc(matrix(:,i),C(:,idx(i)),10^-6);
end
kld_distance=kld_distance/col;
end


function [idx,C]=kmedoids_balanced(data,k)
     [idx,C]=kmedoids(data,k,"Distance",@kld_calc);
     cost_matrix=zeros(size(data,1),k);
     for i=1:k
          cost_matrix(:,i)=kld_calc(C(i,:),data);
     end
     cost_matrix=repmat(cost_matrix,1,size(data,1)/k);
     cost_of_non_assignment=10^6;
     if anynan(cost_matrix)
        cost_matrix
     end
     [assignments,~,~] = assignmunkres(cost_matrix,cost_of_non_assignment);
     idx(assignments(:,1))=mod(assignments(:,2),k);
     idx=double(idx);
     idx(idx==0)=k;
end
