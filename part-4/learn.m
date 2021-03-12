function [w] = learn(X, y, lr, epochs)
  [N M] = size(X);
  % construim matricea X_tilda
  X_tilda = zeros(N, M + 1);
  X_tilda(1:N, 1:M) = X;
  % punem elementele de 1 asa numite bias in matricea X_tilda
  bias = ones(N, 1);
  X_tilda(1:N, M + 1) = bias(1:N);
  
  % generam random elemente in w care apartin
  % intervalului [-1;1]
  w = randi([-1000 1000], M + 1, 1);
  w = w ./ 1e+04;
  
  X_tilda(:, 1:M) = (X_tilda(:, 1:M) - mean(X_tilda(:, 1:M))) ./ std(X_tilda(:, 1:M));
  for epoch = 1:epochs
    %batch_size = randi([1 N], 1, 1);
    batch_size = 64;
    % generam batch_size indici de linii aleatoru
    v = randi([1 N], batch_size, 1);
    X_batch = zeros(batch_size, M + 1);
    % formam matricea X_batch folosind indicii din 
    % vectorul v
    X_batch = X_tilda(v(:), :);
    y_batch = zeros(batch_size, 1);
    % formam vectorul y_batch folosind indicii 
    % generati aleatoru din vectorul v
    y_batch(:) = y(v(1:batch_size), 1);
    % calucularea w 
    for i = 1:M + 1
      w(i) = w(i) - lr * 1 / N * sum(( X_batch(1:batch_size, :) * w - y_batch(1:batch_size)) .* X_batch(1:batch_size, i));
    endfor
  endfor
endfunction
