load('normals.mat');
load('facedata.mat');
[ht, wd] = size(heightmap);
d1 = zeros([ht,wd]);
d2 = zeros([ht, wd]);
s1 = cell([ht, wd]);
s2 = cell([ht, wd]);
img1 = zeros([ht, wd]);
img2 = zeros([ht, wd]);
img3 = zeros([ht, wd]);
img4 = zeros([ht, wd]);
img5 = zeros([ht, wd]);
img6 = zeros([ht, wd]);
for i = 1:ht
    for j = 1:wd
        d1(i, j) = pdist([j, i, heightmap(i, j); lightsource(1, :)],'euclidean');
        d2(i, j) = pdist([j, i, heightmap(i, j); lightsource(2, :)],'euclidean');
        s1{i, j} = lightsource(1, :) - [j, i, heightmap(i, j)];
        mag = norm(s1{i, j});
        s1{i, j} = s1{i, j} ./ mag;
        s2{i, j} = lightsource(2, :) - [j, i, heightmap(i, j)];
        mag = norm(s2{i, j});
        s2{i, j} = s2{i, j} ./ mag;
        
        %% Realistic Albedo
        bs = albedo(i, j) * dot([u(i, j), v(i, j), w(i, j)], s1{i, j});
        bs = max(bs, 0);
        img1(i, j) = bs / (d1(i, j) * d1(i, j));
        
        bs = albedo(i, j) * dot([u(i, j), v(i, j), w(i, j)], s2{i, j});
        bs = max(bs, 0);
        img2(i, j) = bs / (d2(i, j) * d2(i, j));
        
        img3(i, j) = (img1(i, j) + img2(i, j)) ;%/ 2;
        
        %% Uniform Albedo
        
        bs_u = uniform_albedo(i, j) * dot([u(i, j), v(i, j), w(i, j)], s1{i, j});
        bs_u = max(bs_u, 0);
        img4(i, j) = bs_u / (d1(i, j) * d1(i, j));
        
        bs_u = uniform_albedo(i, j) * dot([u(i, j), v(i, j), w(i, j)], s2{i, j});
        bs_u = max(bs_u, 0);
        img5(i, j) = bs_u / (d2(i, j) * d2(i, j));
        
        img6(i, j) = (img4(i, j) + img5(i, j)) ;%/ 2;
    end
end
figure,
subplot(3,2,1)
imagesc(img1);
colormap(gray);
subplot(3,2,3)
imagesc(img2);
colormap(gray);
subplot(3,2,5)
imagesc(img3);
colormap(gray);
subplot(3,2,2)
imagesc(img4);
colormap(gray);
subplot(3,2,4)
imagesc(img5);
colormap(gray);
subplot(3,2,6)
imagesc(img6);
colormap(gray);