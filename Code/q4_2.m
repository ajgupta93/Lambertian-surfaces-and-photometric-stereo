load('facedata.mat');
figure
subplot(1,2,1);
surf(heightmap,albedo);

subplot(1,2,2);
surf(heightmap,uniform_albedo);