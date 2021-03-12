function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
  % apelem functia preprocess 
  [X, y] = preprocess(path_to_testset, histogram, count_bins);
  [N M] = size(X);
  % scalam fiecare coloana in parte
  X(:, 1:M) = (X(:, 1:M) - mean(X(:, 1:M))) ./ std(X(:, 1:M));
  % construim matricea X_tilda asa cum se precizeaza in enunt 
  X_tilda = zeros(N, M + 1);
  X_tilda(1:N, 1:M) = X;
  bias = ones(N, 1);
  X_tilda(1:N, M + 1) = bias(1:N);
  y_tilda = zeros(N, 1);
  
  % inmultim fiecare linie cu w
  y_tilda(1:N) = X_tilda(1:N, :) * w;
  percentage = 0;
  for i = 1:N
    % cazurile in care invatarea a avut succes
    if y(i) >= 0 && y_tilda(i) >=0
        percentage++;
    elseif y(i) < 0 && y_tilda(i) < 0
        percentage++;
    endif
  endfor
  % calcularea procentului
  percentage = percentage / N;
endfunction