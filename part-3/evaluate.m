function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
  % construim calea spre fiecare folder dorit
  % pentru invatare
  N = length("cats");
  path_dir1 = blanks (N + 1);
  path_dir1 = strcat(path_to_testset, "cats/");
  N = length("not_cats");
  path_dir2 = blanks (N + 1);
  path_dir2 = strcat(path_to_testset, "not_cats/");
  
  % iau toate numele imaginilor
  img_dir1 = getImgNames(path_dir1);
  img_dir2 = getImgNames(path_dir2);
  
  % creez calea spre fiecare imagine
  img_dir1 = strcat(path_dir1, img_dir1);
  img_dir2 = strcat(path_dir2, img_dir2);
  
  percentage = 0;
  [N1 M1] = size(img_dir1);
  [N2 M2] = size(img_dir2);
  y = 0;
  if histogram == 'RGB'
    for i = 1:N1
      % apelez pentru fiecare imagine functia de
      % generare a histogramei
      [sol] = rgbHistogram(img_dir1(i, :), count_bins);
      sol = cast(sol, "double");
      sol = [sol 1];
      % daca nunmarul y >= 0 atunci invatarea a avut succes
      y = sol * w;
      if y >= 0
        percentage++;
      endif
    endfor
    for i = 1:N2
      % apelez pentru fiecare imagine functia de
      % generare a histogramei
      [sol] = rgbHistogram(img_dir2(i, :), count_bins);
      sol = cast(sol, "double");
      sol = [sol 1];
      y = sol * w;
      % daca nunmarul y < 0 atunci invatarea a avut succes
      if y < 0
        percentage++;
      endif
    endfor
  elseif histogram == 'HSV'
    for i = 1:N1
      % apelez pentru fiecare imagine functia de
      % generare a histogramei
      [sol] = hsvHistogram(img_dir1(i, :), count_bins);
      sol = cast(sol, "double");
      sol = [sol 1];
      y = sol * w;
      % daca nunmarul y >= 0 atunci invatarea a avut succes
      if y >= 0
        percentage++;
      endif
    endfor
    for i = 1:N2
      % apelez pentru fiecare imagine functia de
      % generare a histogramei
      [sol] = hsvHistogram(img_dir2(i, :), count_bins);
      sol = cast(sol, "double");
      sol = [sol 1];
      y = sol * w;
      % daca nunmarul y < 0 atunci invatarea a avut succes
      if y < 0
        percentage++;
      endif
     endfor
  endif
  
  percentage = percentage / (N1 + N2);
endfunction