clear
clc
warning off;

path = pwd;
addpath(genpath(path));

dataName{1} = 'flower17';


for name = 1
    load(['./',dataName{name},'_Kmatrix']);
    Y(Y==-1)=2;
    numclass = length(unique(Y));
    numker = size(KH,3);
    num = size(KH,1);
    KH = remove_large(KH);
    KH = knorm(KH);
    KH = kcenter(KH);
    KH = divide_std(KH);
%     KH(KH<0) = 0;

    options.seuildiffsigma=1e-4;        % stopping criterion for weight variation
    %------------------------------------------------------
    % Setting some numerical parameters
    %------------------------------------------------------
    options.goldensearch_deltmax=1e-1; % initial precision of golden section search
    options.numericalprecision=1e-16;   % numerical precision weights below this value
    % are set to zero
    %------------------------------------------------------
    % some algorithms paramaters
    %------------------------------------------------------
    options.firstbasevariable='first'; % tie breaking method for choosing the base
    % variable in the reduced gradient method
    options.nbitermax=500;             % maximal number of iteration
    options.seuil=0;                   % forcing to zero weights lower than this
    options.seuilitermax=10;           % value, for iterations lower than this one

    options.miniter=0;                 % minimal number of iterations
    options.threshold = 1e-4;
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    qnorm = 2;

    [S,Sigma,obj] = graph_minmax(KH, options);
    
    S1 = (S + S') / 2;
    D = diag(1 ./ sqrt(sum(S1)));
    L =  D * S1 * D;
    [H,~] = eigs(L, numclass, 'LA');
    res= myNMIACC(H,Y,numclass);
    disp(res);

end




