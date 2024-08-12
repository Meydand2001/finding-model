function [empirical_triplets] = empirical_triplets_gen(data,alphabet,m,n)
%empirical triplets generator 
%   the function generates the empirical probability of triplets r.v of the
%   data
%triplets=nchoosek(n,3);
empirical_triplets=cell(1,1,1);
%count=1;
tensor=zeros(alphabet,alphabet,alphabet);
for j=1:n
    for k=j+1:n
        for l=k+1:n
            samples=0;
            for s=1:m
                if(data(s,j)~=0 && data(s,k)~=0 && data(s,l)~=0)
                    tensor(data(s,j),data(s,k),data(s,l))= tensor(data(s,j),data(s,k),data(s,l))+1;
                    samples=samples+1;
                end    
            end
            tensor=tensor./samples;
            %vec={j,k,l};
            %empirical_triplets{j,k,l}=vec;
            empirical_triplets{j,k,l}=tensor;
            %count=count+1;
        end
    end
end

end