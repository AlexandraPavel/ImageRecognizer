function [centroids] = clustering_pc(points, NC)
  [N D] = size(points);
  % vom avea lungimea maxima a unui cluster
  % partea intreaga superiora
  max_length = idivide(N, NC, "ceil");
  
  Cluster = zeros(NC, max_length);
  centroids = zeros(NC, D);
  centroids_last = zeros(NC, D);
  
  % initealizam fiecare cluster cu
  % i, i + 1*NC, i + 2 * NC ...
  % si centroizii
  for i = 1:NC
    aux = i:NC:N;
    Cluster(i, 1:length(aux')) = aux;
    centroids(i, :) = mean(points(aux(:), :)); 
  endfor
  
  % repetarea pasilor 2, 3 si 4
  centroids_last = centroids;
  do
    centroids_last = centroids;
    % initializam de fiecare data cu 0 clusterele
    Cluster = zeros(NC, N);
    
    % calculam distanta dintre fiecare punct si centroids
    % si facem minimul
    for i = 1:N
      min = norm(points(i, :) - centroids(1, :));
      min_index = 1;
      for j = 2:NC
        distance = norm(points(i, :) - centroids(j, :));
        if distance < min
          min = distance;
          min_index = j;
        endif
      endfor
      
      % cautam in clusterul max_index punem indicele punctului i
      for z = 1:N
        if Cluster(min_index, z) == 0
          Cluster(min_index, z) = i;
         break;
        endif
      endfor
    endfor
    
    % calculam media coordonatelor punctelor din clustere
    % si cream noii centroizi
    for i = 1:NC
      aux = Cluster(i, :);
      if aux(2) != 0
        centroids(i, :) = mean(points(aux(find(aux)), :));
      else
        centroids(i, :) = points(aux(find(aux)), :);
      endif
    endfor
  until norm(centroids - centroids_last) <= 1e-6
endfunction
