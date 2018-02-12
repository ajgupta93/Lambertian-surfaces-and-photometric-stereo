load('facedata.mat');
figure
subplot(1,2,1);
imagesc(albedo);
colormap(gray);

subplot(1,2,2);
imagesc(uniform_albedo);
colormap(gray);