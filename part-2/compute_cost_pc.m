function [cost] = compute_cost_pc(points, centroids)
  [N D] = size(points);
  [NC m] = size(centroids);
  max_length = idivide(N, NC, "ceil");
  Cluster = zeros(NC, N);
  % pastram in cluster distantele min dintre
  % fiecare punct si centroid
  for i = 1:N
    max = norm(points(i, :) - centroids(1, :));
    max_index = 1;
    for j = 2:NC
      distance = norm(points(i, :) - centroids(j, :));
      if distance < max
        max = distance;
        max_index = j;
      endif
    endfor
    
    % punem costul in clusterul max_index pentru 
    % acel punct
    for z = 1:N
      if Cluster(max_index, z) == 0
        Cluster(max_index, z) = max;
        break;
      endif
    endfor  
  endfor
  % facem suma tuturor costurilor
  cost = sum(sum(Cluster));
endfunction

