function [A, b] = generate_probabilities_system(rows)
  A = zeros(rows, rows);
  % calculam nr de elemente din matrice
  n = rows * (rows + 1) / 2;
  
  % am construit o parte din diagonala punand
  % valorile pt varfurile matricii si pt elementele 
  % de pe al doilea nivel
  A(1, 1) = 4;
  A(1, 2) = -1;
  A(1, 3) = -1;
  A(n, n) = 4;
  A(n - rows + 1, n - rows + 1) = 4; 
  counter = 2;
  aux = 0;
  % construim doar partea superior triunghiulare
  % a matricii dorite
  for i = 2:n
    aux++;
    % cand trecem la un nou nivel aux == counter
    % variabila counter este de fapt nr de elemente 
    % de pe acel nivel
    if aux == counter && i != n
      if n - rows + 1 != i 
        % pentru variabilele din centru initializam diagonala
        if counter * (counter + 1) / 2  != i 
          if counter * (counter - 1) / 2 + 1 != i && counter != rows
              A(i, i) = 6;
          else
            % cele de margine
            A(i, i) = 5;
          endif
        else
         % cele de margine
          A(i, i) = 5;
        endif
      endif
      % langa diagonala principala punem 0
      A(i, i + 1) = 0; 
      counter++;
      aux = 0;
    elseif i != n 
      % cand nu suntem in cazul ultimului element
      if n - rows + 1 != i
        %cand nu suntem in cazul varfului din stanga jos
        % pentru variabilele din centru initializam diagonala
        if counter * (counter + 1) / 2  != i
          if counter*(counter-1)/2 + 1 != i  && counter != rows
            A(i, i) = 6;
          else
            % cele de margine
            A(i, i) = 5;
          endif
        else
          % cele de margine
          A(i, i) = 5;
       endif
      endif
      % langa diagonala principala punem -1 in acest caz
      A(i, i + 1) = -1;
    endif
    
    % a doua runda de -1 din matrice 
    if aux == 0 && i + counter - 1 <= n && i != n
      % in cazul in care este ultimul element de pe acel 
      % nivel deaorece crestem nivelul (counter) mai sus
      A(i, i + counter - 1) = -1;
      if i + counter <= n
        A(i, i + counter) = -1;
      endif
    elseif i + counter <= n && i!=n
      A(i, i + counter) = -1;
      if i + counter + 1 <= n
        A(i, i + counter + 1) = -1;
      endif
    endif
   endfor
   
   % face inversa matricii A si finalizam
   % calculand forma finala a acestei matrici
   D = diag(diag(A));
   A =  A' + A - D;
   b = zeros(n, 1);
   for i = 0:rows - 1
     b(n - i) = 1;
   endfor
endfunction