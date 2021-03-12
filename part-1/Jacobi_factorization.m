function [G_J, c_J] = Jacobi_factorization(A, b)
  % pregatim matricile N si P
  D = diag(diag(A));
  L = D - tril(A);
  U = D - triu(A);
  N = D;
  P = L + U;
  % calculam forma G_j si c_J
  G_J = inv(N) * P;
  c_J = inv(N) * b;
endfunction
