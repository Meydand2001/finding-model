function [data_set,incompleted_data_set] = generate_data_set(samples,dimension,alphabet,erasure_probability)
% generate_data_set is a function which generates a random set.
% samples are the amount of rows in the data set (each row is a sample).
% dimension is the size of the vector sample (coloum).
% alphabet is the number of options hich each value can take.
% erasure_probability is the probability which we would erase a value from
% the complete data_set.
data_set = unidrnd(alphabet,samples,dimension);
erasure_set=binornd(1,(1-erasure_probability)*ones(samples,dimension));
incompleted_data_set=data_set.*erasure_set;
end