number_of_matrices=1000;
g_alphabet=1000.*ones(1,number_of_matrices);
coloumns=20;
[matrices] = init_matrices(number_of_matrices,g_alphabet,coloumns);
matrices()
for i=1:1000
    matrix=matrices{i};
    k=krank
end