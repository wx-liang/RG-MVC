function [S, obj] = solve_S(A_gamma)
S = zeros(size(A_gamma));
num = size(A_gamma, 1);
for i = 1:num
    index = setdiff(1:num,i);
    S(i,index) = EProjSimplex_new(A_gamma(i,index) / 2);
end

obj = trace(A_gamma' * S) - norm(S,'fro')^2;

end