function [Wsub, A, W, dGenSort, K] = new_rcaBase_Train(Rxx, Ryy, Rxy, K, C)
    % Compute spatial filters maximizing reliability across trials given precomputed auto-
    % and cross-covariance matrices.
    %
    % Rxx: covariance matrix of "data record 1"
    % Ryy: covariance matrix of "data record 2"
    % Rxy: cross-covariance matrix of data records 1 and 2
    % K: number of autocovariance dimensions to diagonalize (defaults to the number of eigenvalues explaining 60% of total power)
    % C: number of components to return (defaults to 3)
    %
    % Wsub: channel x component matrix of top C reliability-maximizing projection [Wsub(:,1),...,Wsub(:,C)]
    % A: channel x component matrix of corresponding forward models [A(:,1),...,A(:,C)]
    % W: channel x component matrix of all RCA projections [W(:,1),...,W(:,nChannels)]
    % dGenSort: vector of sorted (ascending) generalized eigenvalues (value conveys correlation coefficient)
    %
    % (c) Jacek P. Dmochowski, 2014
    % Refactored by Alexandra Yakovleva, 2023

    Rxx(isnan(Rxx)) = 0;
    Ryy(isnan(Ryy)) = 0;
    Rxy(isnan(Rxy)) = 0;

    % Argument checking
    if nargin < 5 || isempty(C)
        C = 3;
    end
    
    if nargin < 4 || isempty(K)
        if nargin < 3
            error('At least 3 arguments required');
        end
        
        if any(size(Rxx) ~= size(Ryy)) || any(size(Rxx) ~= size(Rxy))
            error('Rxx, Ryy, and Rxy must have the same size');
        end
        
        [~, eigDiag] = eig(Rxx + Ryy);
        [~, indxKnee] = knee_pt(diag(eigDiag), 1:length(diag(eigDiag)));
        
        K = length(diag(eigDiag)) - indxKnee;
        fprintf('Using %d bases to diagonalize pooled autocovariance\n', K + 1);
    end

    [Vpool, Dpool] = eig(Rxx + Ryy);
    [dPool, sortIndx] = sort(diag(Dpool), 'ascend');
    Vpool = Vpool(:, sortIndx);
    dPool = dPool(end - K:end);
    Rw = Vpool(:, end - K:end) * diag(1./dPool) * Vpool(:, end - K:end)' * (Rxy + Rxy');

    [Vgen, Dgen] = eig(Rw);
    dGen = diag(Dgen);
    [dGenSort, b] = sort(abs(dGen));
    W = Vgen(:, b(end:-1:1));

    Wsub = W(:, 1:C);
    Rpool = 0.5 * (Rxx + Ryy);
    A = (Rpool * Wsub) / (Wsub' * Rpool * Wsub);
end
