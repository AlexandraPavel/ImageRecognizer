function [w] = learn(X, y)
  [N M] = size(X);
  % construim matricea X_tilda
  X_tilda = zeros(N, M + 1);
  X_tilda(1:N, 1:M) = X;
  % punem elementele de 1 asa numite bias in matricea X_tilda
  bias = ones(N, 1);
  X_tilda(1:N, M + 1) = bias(1:N);
  w = zeros(M + 1);
  % descompunerea QR cu metoda Householder
  [Q R] = Householder(X_tilda);
  y = Q' * y;
  % resolvam sistemul de ecuatii supradeterminat cu
  % ajutorul SST-ului
  [w] = SST(R, y);
endfunction