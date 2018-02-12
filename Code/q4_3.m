load('facedata.mat');
[ht, wd] = size(heightmap);
u = zeros([ht - 1, wd - 1]);
v = zeros([ht - 1, wd - 1]);
w = zeros([ht - 1, wd - 1]);
X = zeros([ht - 1, wd - 1]);
Y = zeros([ht - 1, wd - 1]);
Z = zeros([ht - 1, wd - 1]);
for i=2:ht - 1
    for j = 2:wd - 1
        dx = heightmap(i, j + 1) - heightmap(i, j - 1);
        dy = heightmap(i + 1, j) - heightmap(i - 1, j);
        mag = norm([dx, dy, 1]);
        u(i, j) = -dx / mag;
        v(i, j) = -dy / mag;
        w(i, j) = 1 / mag;
        X(i, j) = j;
        Y(i, j) = i;
        Z(i, j) = heightmap(i, j);
    end
end

for j = 2:wd - 1
    dx = heightmap(1, j + 1) - heightmap(1, j - 1);
    dy = heightmap(2, j) - heightmap(1, j);
    mag = norm([dx, dy, 1]);
    u(1, j) = -dx / mag;
    v(1, j) = -dy / mag;
    w(1, j) = 1 / mag;
    X(1, j) = j;
    Y(1, j) = 1;
    Z(1, j) = heightmap(1, j);
    dx = heightmap(ht, j + 1) - heightmap(ht, j - 1);
    dy = heightmap(ht, j) - heightmap(ht - 1, j);
    mag = norm([dx, dy, 1]);
    u(ht, j) = -dx / mag;
    v(ht, j) = -dy / mag;
    w(ht, j) = 1 / mag;
    X(ht, j) = j;
    Y(ht, j) = ht;
    Z(ht, j) = heightmap(ht, j);
end

for j = 2:ht - 1
     dy = heightmap(j + 1, 1) - heightmap(j - 1, 1);
     dx = heightmap(j, 2) - heightmap(j, 1);
     mag = norm([dx, dy, 1]);
     u(j, 1) = -dx / mag;
     v(j, 1) = -dy / mag;
     w(j, 1) = 1 / mag;
     X(j, 1) = 1;
     Y(j, 1) = j;
     Z(j, 1) = heightmap(j, 1);
     dy = heightmap(j + 1, wd) - heightmap(j - 1, wd);
     dx = heightmap(j, wd) - heightmap(j, wd - 1);
     mag = norm([dx, dy, 1]);
     u(j, wd) = -dx / mag;
     v(j, wd) = -dy / mag;
     w(j, wd) = 1 / mag;
     X(j, wd) = wd;
     Y(j, wd) = j;
     Z(j, wd) = heightmap(j,wd);
 end

dy = heightmap(2, 1) - heightmap(1,1);
dx = heightmap(1,2) - heightmap(1,1);
mag = norm([dx, dy, 1]);
u(1,1) = -dx / mag;
v(1,1) = -dy / mag;
w(1,1) = 1 / mag;
X(1,1) = 1;
Y(1,1) = 1;
Z(1,1) = heightmap(1,1);

dy = heightmap(1,wd) - heightmap(1, wd-1);
dx = heightmap(2, wd) - heightmap(1, wd);
mag = norm([dx, dy, 1]);
u(1,wd) = -dx / mag;
v(1,wd) = -dy / mag;
w(1,wd) = 1 / mag;
X(1,wd) = wd;
Y(1,wd) = 1;
Z(1,wd) = heightmap(1,wd);

dy = heightmap(ht, 1) - heightmap(ht-1, 1);
dx = heightmap(ht, 2) - heightmap(ht, 1);
mag = norm([dx, dy, 1]);
u(ht, 1) = -dx / mag;
v(ht, 1) = -dy / mag;
w(ht, 1) = 1 / mag;
X(ht, 1) = 1;
Y(ht, 1) = ht;
Z(ht, 1) = heightmap(ht,1);

dy = heightmap(ht, wd) - heightmap(ht - 1, wd);
dx = heightmap(ht, wd) - heightmap(ht, wd - 1);
mag = norm([dx, dy, 1]);
u(ht, wd) = -dx / mag;
v(ht, wd) = -dy / mag;
w(ht, wd) = 1 / mag;
X(ht, wd) = wd;
Y(ht, wd) = ht;
Z(ht, wd) = heightmap(ht,wd);

save('normals.mat','u','v','w');

%% Downsampling

sampling_rate = 2;
X = downsample(X,sampling_rate);
X = downsample(X',sampling_rate)';
Y = downsample(Y,sampling_rate);
Y = downsample(Y',sampling_rate)';
Z = downsample(Z,sampling_rate);
Z = downsample(Z',sampling_rate)';
heightmap = downsample(heightmap,sampling_rate);
heightmap = downsample(heightmap',sampling_rate)';
u = downsample(u,sampling_rate);
u = downsample(u',sampling_rate)';
v = downsample(v,sampling_rate);
v = downsample(v',sampling_rate)';
w = downsample(w,sampling_rate);
w = downsample(w',sampling_rate)';

figure,
quiver3(X, Y, Z, u, v, w,1);
