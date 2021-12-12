function [cost,S] = costgraph(KH,StepSigma,DirSigma,Sigma)

global nbcall
nbcall=nbcall+1;

Sigma = Sigma + StepSigma * DirSigma;

K_total = sumKbeta(KH, Sigma.^2);
[S, cost]= solve_S(K_total);