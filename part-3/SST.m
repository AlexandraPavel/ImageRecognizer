function [x] = SST(A, b)
  [n m] = size(A);
  % facem minimul dintre m si n pentru
  % ca aveam de a face cu un sistem de
  % ecuatii supradeterminat
  n = min(m,n);
  y = zeros(n, 1);
  x = zeros(n, 1);
  b = b(1:n);
  y(n) = b(n) / A(n, n);
  for i = n - 1:-1:1
    y(i) = (b(i) - A(i, i + 1 : n) * y(i + 1 : n)) / A(i, i);
  endfor
  x = y(:);
endfunction
    