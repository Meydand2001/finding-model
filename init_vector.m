function [v] = init_vector(v_length)
%INIT_VECTOR creates of vector of a given length which is a valid 
%probability vector.
%   Detailed explanation goes here
v = rand(v_length,1);
v = v./sum(v);
end

