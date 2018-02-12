close all;
clc;
clear;
load('synthetic_data.mat');
b = cell([100,100]);
a = zeros([100,100]);
n = cell([100,100]);
p = zeros([100,100]);
q = zeros([100,100]);
s = [l1;l2;l4];
psuedo_inv = inv((s'*s))*s';
im1 = im2double(im1);
im2 = im2double(im2);
im3 = im2double(im3);
im4 = im2double(im4);
for i=1:100
    for j=1:100
        e = [im1(i,j);im2(i,j);im4(i,j)];
        b{i,j} = psuedo_inv*e;
        a(i,j) = norm(b{i,j});
        n{i,j} = b{i,j}./a(i,j);
        p(i,j) = n{i,j}(1)/n{i,j}(3);
        q(i,j) = n{i,j}(2)/n{i,j}(3);
    end
end
figure,
imagesc(a),colormap(gray);

heightmap = zeros([100,100]);
for i=2:100
    heightmap(i,1) = heightmap(i-1,1)+q(i,1);
end

X = zeros([100,100]);
Y = zeros([100,100]);
u = zeros([100,100]);
v = zeros([100,100]);
w = zeros([100,100]);

%% Naive scanline integration

for i=1:100
    for j=1:100
        if(j~=1)
            heightmap(i,j) = heightmap(i,j-1)+p(i,j);
        end
        X(i,j) = j;
        Y(i,j) = i;
        u(i,j) = n{i,j}(1);
        v(i,j) = n{i,j}(2);
        w(i,j) = -n{i,j}(3);
    end
end

%% Horn's method

heightmap2 = integrate_horn2(p,q,ones([100,100]),100000,0);

%% Downsampling

sampling_rate = 5;
X = downsample(X,sampling_rate);
X = downsample(X',sampling_rate)';
Y = downsample(Y,sampling_rate);
Y = downsample(Y',sampling_rate)';
heightmap = downsample(heightmap,sampling_rate);
heightmap = downsample(heightmap',sampling_rate)';
heightmap2 = downsample(heightmap2,sampling_rate);
heightmap2 = downsample(heightmap2',sampling_rate)';
u = downsample(u,sampling_rate);
u = downsample(u',sampling_rate)';
v = downsample(v,sampling_rate);
v = downsample(v',sampling_rate)';
w = downsample(w,sampling_rate);
w = downsample(w',sampling_rate)';

figure,
imagesc(u);
colormap(gray);

figure,
imagesc(v);
colormap(gray);

figure,
imagesc(w);
colormap(gray);

figure,
quiver3(X, Y, heightmap, u, v, w);
hold on,
surf(X, Y, heightmap);
view(-35,45)

figure,
quiver3(X, Y, heightmap2, u, v, w);
hold on,
surf(X, Y, heightmap2);
view(-35,45)

