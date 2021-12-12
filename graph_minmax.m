function [S, Sigma, obj] = graph_minmax(KH, option)
num = size(KH, 1);
numker = size(KH, 3);


%--------------------------------------------------------------------------------
% Options used in subroutines
%--------------------------------------------------------------------------------
if ~isfield(option,'goldensearch_deltmax')
    option.goldensearch_deltmax=5e-2;
end
if ~isfield(option,'goldensearchmax')
    optiongoldensearchmax=1e-8;
end
if ~isfield(option,'firstbasevariable')
    option.firstbasevariable='first';
end

nloop = 1;
loop = 1;
goldensearch_deltmaxinit = option.goldensearch_deltmax;


%% initialization
Sigma = ones(numker,1);
Sigma = Sigma / sum(Sigma); 
A_gamma = sumKbeta(KH, Sigma.^2);
[S, obj1] = solve_S(A_gamma);
[grad] = graphGrad(KH, S, Sigma);
obj(nloop) = obj1;

Sigmaold  = Sigma;

%------------------------------------------------------------------------------%
% Update Main loop
%------------------------------------------------------------------------------%
while loop
    nloop = nloop+1;
    
    [Sigma,S,obj(nloop)] = graphupdate(KH,Sigmaold,grad,obj(nloop-1),option);
    
    if max(abs(Sigma-Sigmaold))<option.numericalprecision &&...
            option.goldensearch_deltmax > optiongoldensearchmax
        option.goldensearch_deltmax=option.goldensearch_deltmax/10;
    elseif option.goldensearch_deltmax~=goldensearch_deltmaxinit
        option.goldensearch_deltmax*10;
    end
    
    [grad] = graphGrad(KH, S, Sigma);
    %----------------------------------------------------
    % check variation of Sigma conditions
    %----------------------------------------------------
    if  max(abs(Sigma-Sigmaold))<option.seuildiffsigma
        loop = 0;
        fprintf(1,'variation convergence criteria reached \n');
    end
    %-----------------------------------------------------
    % Updating Variables
    %----------------------------------------------------
    Sigmaold  = Sigma;
end




end