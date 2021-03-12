function [values, colind, rowptr] = matrix_to_csr(A)
  nz = length(find(A));
  [n m] = size(A);
  values = zeros(nz, 1);
  colind = zeros(nz, 1);
  rowptr = zeros(n + 1, 1);
  counter = 1;
  aux = 1;
  valid = 0;
  for i = 1:n
    valid = 0;
    for j = 1:n
      if A(i,j) != 0
        values(counter) = A(i, j);
        colind(counter) = j;
        counter++;
        if valid == 0
          rowptr(aux) = counter - 1;
          aux++;
          valid = 1;
        endif
      endif
    endfor
  endfor
  rowptr(n + 1) = nz + 1;
  colind = colind';
  values = values';
  rowptr = rowptr';
endfunction