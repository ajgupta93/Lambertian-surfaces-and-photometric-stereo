% This script creates all the necessary matrices for problem 3.
% Then calculates the new points based of off the given points and passes
% them into the given function, plotsquare.m

%3.1: No rigid body transformation%
K = eye(3);
E = eye(4);
IO = eye(3,4);

AP1 = K * IO * E * [-1; -0.5; 2; 1];
AP2 = K * IO * E * [ 1; -0.5; 2; 1];
AP3 = K * IO * E * [ 1;  0.5; 2; 1];
AP4 = K * IO * E * [-1;  0.5; 2; 1];

disp(E);
disp(K);

save_fig = figure;
subplot(2,2,1);
title('(3.1)');
plotsquare([AP1 AP2 AP3 AP4]);

%3.2: Translation%
K = eye(3);
E = [1, 0, 0, 0;
     0, 1, 0, 0;
     0, 0, 1, 1;
     0, 0, 0, 1];
IO = eye(3,4);

AP1 = K * IO * E * [-1; -0.5; 2; 1];
AP2 = K * IO * E * [ 1; -0.5; 2; 1];
AP3 = K * IO * E * [ 1;  0.5; 2; 1];
AP4 = K * IO * E * [-1;  0.5; 2; 1];

disp(E);
disp(K);

subplot(2,2,2)
title('(3.2)');
plotsquare([AP1 AP2 AP3 AP4])

%3.3: Translation and rotation%
K = eye(3);
Z = [cosd(60), -sind(60), 0;
     sind(60),  cosd(60), 0;
            0,         0, 1];
Y = [ cosd(45), 0, sind(45);
             0, 1,        0;
     -sind(45), 0, cosd(45)];
R = Y*Z;
T = [0;0;1];
E = [R T; 0,0,0,1];
IO = eye(3,4);

AP1 = K * IO * E * [-1; -0.5; 2; 1];
AP2 = K * IO * E * [ 1; -0.5; 2; 1];
AP3 = K * IO * E * [ 1;  0.5; 2; 1];
AP4 = K * IO * E * [-1;  0.5; 2; 1];

disp(E);
disp(K);

subplot(2,2,3);
title('(3.3)');
plotsquare([AP1 AP2 AP3 AP4]);

%3.4: Translation and rotation, long distance%
K = [15,  0, 0;
      0, 15, 0;
      0,  0, 1];
Z = [cosd(60), -sind(60), 0;
     sind(60),  cosd(60), 0;
            0,         0, 1];
Y = [ cosd(90), 0, sind(90);
             0, 1,        0;
     -sind(90), 0, cosd(90)];
R = Y*Z;
T = [0;0;13];
E = [R T; 0,0,0,1];
IO = eye(3,4);

AP1 = K * IO * E * [-1; -0.5; 2; 1];
AP2 = K * IO * E * [ 1; -0.5; 2; 1];
AP3 = K * IO * E * [ 1;  0.5; 2; 1];
AP4 = K * IO * E * [-1;  0.5; 2; 1];

disp(E);
disp(K);

subplot(2,2,4);
title('(3.4)');
plotsquare([AP1 AP2 AP3 AP4]);
saveas(save_fig, '3-1ImageProjs.jpg');