function [H,S,V] = RGB2HSV(img)
  [N M L] = size(img);
  R = zeros(N, M);
  G = zeros(N, M);
  B = zeros(N, M);
  % preiam fiecare matrice in parte pentru 
  % fiecare culoare
  R = img(:, :, 1);
  G = img(:, :, 2);
  B = img(:, :, 3);
  % le normez 
  R = R ./ 255;
  G = G ./ 255;
  B = B ./ 255;
  C_max = zeros(N, M);
  C_min = zeros(N, M);
  % calculez minimul si maximul dintre fiecare 
  % element di le stochez in matricele C_max si C_min
  C_max = max(max(R, G), B);
  C_min = min(min(R, G), B);
  % fac diferenta lor si le castez la double
  D = C_max - C_min;
  D = cast(D, "double");
  H = zeros(N, M);
  H = cast(H, "double");
  S = zeros(N, M);
  S = cast(S, "double");
  V = zeros(N, M);
  V = cast(V, "double");
  
  % folosesc vectorizarea booleana pentru a calcula forma HSV
  H(C_max == R & C_max ~= C_min) = (60 * ((G(C_max == R & C_max ~= C_min) - B(C_max == R & C_max ~= C_min)) ./ D(C_max == R & C_max ~= C_min)) + 360);
  H(C_max == G & C_max ~= C_min) = (60 * ((B(C_max == G & C_max ~= C_min) - R(C_max == G & C_max ~= C_min)) ./ D(C_max == G & C_max ~= C_min)) + 120); 
  H(C_max == B & C_max ~= C_min) = (60 * ((R(C_max == B & C_max ~= C_min) - G(C_max == B & C_max ~= C_min)) ./ D(C_max == B & C_max ~= C_min)) + 240);
  S(C_max == 0) = 0; 
  S(C_max != 0) = (D(C_max != 0) ./ C_max(C_max != 0)); 
  H = mod(H, 360);
  V = C_max;
  
endfunction