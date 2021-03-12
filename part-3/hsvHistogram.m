function [sol] = hsvHistogram(path_to_image, count_bins)
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
  img = cast(imread(aux), "double");
  
  %rgb2hsv
  [H, S, V] = RGB2HSV(img);
  
  % pentru h
  
  % lungimea fiecarui interval este data de variabila n
  % calculata astfel
  impart = count_bins / 1.01;
  n = 360 / impart;
  % cream capetele intervalelor
  edges = 0:count_bins;
  edges = edges .* n;
  edges = edges ./ 360;
  suma = 1;
  m = zeros(count_bins + 1, 1);
  H = H ./ 360;
  % am transformat o matrice intr-un vector
  S_prime = H(:)';
  % folosesc histc pentru a numara elementele pentru
  % intervalele edges
  [m, idx] = histc (S_prime, edges);
  m = m(1:count_bins);
  sol = m;
  suma = suma + count_bins;
  
  % pentru s si v
  for i = 1:1:2
    % lungimea fiecarui interval este data de variabila n
    % calculata astfel
    impart = count_bins / 1.01;
    n = 100 / impart;
    % cream capetele intervalelor
    edges = 0:count_bins;
    edges = edges .* n;
    edges = edges ./ 100;
    m = zeros(count_bins + 1, 1);
    % folosesc histc pentru a numara elementele pentru
    % intervalele edges
    if i == 1
      % am transformat o matrice intr-un vector
      S_prime = S(:)';
      [m, idx] = histc (S_prime, edges, 2);
    else
      S_prime = V(:)';
      [m, idx] = histc (S_prime, edges, 2);
    endif
    m = m(1:count_bins);
    sol = [sol m];
  endfor
endfunction