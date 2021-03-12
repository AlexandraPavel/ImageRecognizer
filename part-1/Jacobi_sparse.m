function [x] = Jacobi_sparse(G_values, G_colind, G_rowptr, c, tol)
  n = length(G_rowptr) - 1;
  x = zeros(n, 1:n);
  % variabila Gx indica produsul G*x_i
  Gx = csr_multiplication(G_values, G_colind, G_rowptr, x);
  x0 = Gx + c;
  
  Gx = csr_multiplication(G_values, G_colind, G_rowptr, x0);
  x = Gx + c;
  
  % se opreste cand diferentele dintre x si x precedent sunt 
  % mai mici decat eroarea tol
  while norm(x - x0) > tol
    x0 = x;
    Gx = csr_multiplication(G_values, G_colind, G_rowptr, x);
    x = Gx + c;
  endwhile
endfunction