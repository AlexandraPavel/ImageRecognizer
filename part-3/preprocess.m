function [X, y] = preprocess(path_to_dataset, histogram, count_bins)
  % construim calea spre fiecare folder dorit
  % pentru invatare
  N = length("cats");
  path_dir1 = blanks (N + 1);
  path_dir1 = strcat(path_to_dataset, "cats/");
  N = length("not_cats");
  path_dir2 = blanks (N + 1);
  path_dir2 = strcat(path_to_dataset, "not_cats/");
  
  % iau toate numele imaginilor
  img_dir1 = getImgNames(path_dir1);
  img_dir2 = getImgNames(path_dir2);
  
  % creez calea spre fiecare imagine
  img_dir1 = strcat(path_dir1, img_dir1);
  img_dir2 = strcat(path_dir2, img_dir2);
  
  [N1 M1] = size(img_dir1);
  [N2 M2] = size(img_dir2);
  X = zeros(N1 + N2, count_bins * 3);
  y = zeros(N1 + N2, 1);
  % creez vectorul coloana y conform cerintei
  y(1:N1) = 1;
  y(N1 + 1:N1 + N2) = -1;
  if histogram == 'RGB'
    % apelez pentru fiecare imagine functiile de procesare
    % stochez in matricea X solutiile
    for i = 1:N1
      [sol] = rgbHistogram(img_dir1(i, :), count_bins);
      X(i, :) = sol;
    endfor
    % apelez pentru fiecare imagine functiile de procesare
    % stochez in matricea X solutiile
    for i = 1:N2
      [sol] = rgbHistogram(img_dir2(i, :), count_bins);
      X(i + N1, :) = sol;
    endfor
  elseif histogram == 'HSV'
    % apelez pentru fiecare imagine functiile de procesare
    % stochez in matricea X solutiile
    for i = 1:N1
      [sol] = hsvHistogram(img_dir1(i, :), count_bins);
      X(i, :) = sol;
    endfor
    % apelez pentru fiecare imagine functiile de procesare
    % stochez in matricea X solutiile
    for i = 1:N2
      [sol] = hsvHistogram(img_dir2(i, :), count_bins);
      X(i + N1, :) = sol;
     endfor
  endif
endfunction