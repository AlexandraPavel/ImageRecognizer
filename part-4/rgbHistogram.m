function [sol] = rgbHistogram(path_to_image, count_bins)
  % luam toate imaginilor din directorul
  % path to image
  img = dir(path_to_image);
  % preluam toate numele imaginilor
  name = char(img.name);
  % ne folosim de functia pwd ca sa ne
  % dea calea absoluta spre directorul curent
  aux = pwd;
  N = length(path_to_image) - length(name);
  path = blanks (N + 1);
  path = strcat(path, "/");
  path_to_image = strcat(path, path_to_image);
  % am construit calea absoluta spre fiecare imagine 
  % in variabila aux
  aux = strcat(aux, path_to_image);
  % citim in format RGB imaginile
  img = imread(aux);
  
  [N M L] = size(img);
  % lungimea fiecarui interval este data de variabila n
  % calculata astfel
  n = 256 / count_bins;
  % cream capetele intervalelor
  edges = zeros(1, n + 1); 
  edges = 1:count_bins + 1;
  edges--;
  edges = edges .* n;
  suma = 1;
  
  % pentru fiecare culoare punem in vectorul sol 
  m = zeros(count_bins, 1);
  sol = zeros(count_bins*3, 1);
  for i = 1:3
    S = zeros(N,M);
    % am transformat o matrice intr-un vector
    S(:,:) = img(:,:,i);
    S_prime = S(:)';
    % folosesc histc pentru a numara elementele pentru
    % intervalele edges
    [m, idx] = histc (S_prime, edges);
    [S D] = size(m);
    m = m(1:count_bins);
    sol(suma:suma + count_bins -1) = m;
    suma = suma + count_bins;
  endfor
  sol = sol';
endfunction