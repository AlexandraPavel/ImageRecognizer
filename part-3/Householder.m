function [Q R] = Householder(A)
	[m n] = size(A);
	Q = eye(m);
  
	for p = 1 : min(m - 1,n)
		sigma = -norm(A(p:m, p));
		if A(p, p) < 0
			sigma = -sigma;
		endif;

		% calculam reflectorul Householder
		vp(1:m, 1) = 0;
		vp(p) = A(p, p) + sigma;
		vp(p + 1:m) = A(p + 1:m, p);
		beta = sigma * vp(p);
	
    % daca beta e diferit de zero
		if beta ~= 0
      % pt Hp transformare coloana p
      A(p, p) = -sigma;
		  A(p + 1:m, p) = 0;
		  
      % pt Hp transformare coloanele p+1:n
       t = vp(p:m)' * A(p:m, p + 1 :n) ./ beta;
		    A(p:m, p + 1:n) = A(p:m, p + 1:n) .- t .* vp(p:m);
	
  	  % pt Htransformare coloanele 1:n
       t = vp(p:m)' * Q(p:m, 1:m) ./ beta;
		   Q(p:m, 1:m) = Q(p:m, 1:m) .- t .* vp(p:m);
     endif
  endfor;
  
	R = A;
	Q = Q';
endfunction