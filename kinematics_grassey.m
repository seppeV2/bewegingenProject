function [t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,dt3,dt4,dt5,dt6,dt7,dt8,dt9,dt10,dt11,dt12] = kinematics_grassey(r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,t1,t2,dt2,t_init,t)

t3 = zeros(size(t));
t4 = zeros(size(t));
t5 = zeros(size(t));
t6 = zeros(size(t));
t7 = zeros(size(t));
t8 = zeros(size(t));
t9 = zeros(size(t));
t10 = zeros(size(t));
t11 = zeros(size(t));
t12 = zeros(size(t));

dt3 = zeros(size(t));
dt4 = zeros(size(t));
dt5 = zeros(size(t));
dt6 = zeros(size(t));
dt7 = zeros(size(t));
dt8 = zeros(size(t));
dt9 = zeros(size(t));
dt10 = zeros(size(t));
dt11 = zeros(size(t));
dt12 = zeros(size(t));

optim_options = optimset('Display','off');

Ts = t(2) - t(1);     
t_size = size(t,1); 

for k=1:t_size
    
    x = fsolve('Loop_closure_Grassey',t_init',optim_options,t2(k),r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,t1);
    
    t3(k) = x(1);
    t4(k) = x(2);
    t5(k) = x(3);
    t6(k) = x(4);
    t7(k) = x(5);
    t8(k) = x(6);
    t9(k) = x(7);
    t10(k) = x(8);
    t11(k) = x(9);
    t12(k) = x(10);
    
    A = [0, 0, 0, 0, 0, 0, 0, 0, r11*sin(t11(k)), -r12*sin(t12(k));
         0, 0, 0, 0, 0, 0, 0, 0, -r11*cos(t11(k)), r12*cos(t12(k));
         0, 0, 0, 0, -r7*sin(t7(k)), r8*sin(t8(k)), -r9*sin(t9(k)), 0, 0, 0;
         0, 0, 0, 0, r7*cos(t7(k)), -r8*cos(t8(k)), r9*cos(t9(k)), 0, 0, 0;
         0, -r4*sin(t4(k)), -r5*sin(t5(k)), r6*sin(t6(k)), r7*sin(t7(k)), 0, 0, 0, 0, 0;
         0, r4*cos(t4(k)), r5*cos(t5(k)), -r6*cos(t6(k)), -r7*cos(t7(k)), 0, 0, 0, 0, 0;
         0, 0, 0, 0, 0, 0, -r9*sin(t9(k)), -r10*sin(t10(k)), r11*sin(t11(k)), 0;
         0, 0, 0, 0, 0, 0, r9*cos(t9(k)), r10*cos(t10(k)), -r11*cos(t11(k)), 0;
         r3*sin(t3(k)), 0, -r5*sin(t5(k)), 0, 0, 0, 0, 0, 0, 0;
         -r3*cos(t3(k)), 0, r5*cos(t5(k)), 0, 0, 0, 0, 0, 0, 0];
        
    B = [r2*sin(t2(k))*dt2(k);
         -r2*cos(t2(k))*dt2(k);
         0;
         0;
         0;
         0;
         0;
         0;
         r2*sin(t2(k))*dt2(k);
         -r2*cos(t2(k))*dt2(k)];
    
    x = A\B;
    
    dt3(k) = x(1);
    dt4(k) = x(2);
    dt5(k) = x(3);
    dt6(k) = x(4);
    dt7(k) = x(5);
    dt8(k) = x(6);
    dt9(k) = x(7);
    dt10(k) = x(8);
    dt11(k) = x(9);
    dt12(k) = x(10);
    
    t_init = [t3(k) + Ts*dt3(k), t4(k) + Ts*dt4(k), t5(k) + Ts*dt5(k), t6(k) + Ts*dt6(k), t7(k) + Ts*dt7(k),
              t8(k) + Ts*dt8(k), t9(k) + Ts*dt9(k), t10(k) + Ts*dt10(k), t11(k) + Ts*dt11(k), t12(k) + Ts*dt12(k)]; 
    
end

% *** create movie ***

% point P = fixed
A = 0;
% point S = fixed
B = r1*exp(j*t1);
% define which positions we want as frames in our movie
frames = 100;    % number of frames in movie
delta = floor(t_size/frames); % time between frames
index_vec = [1:delta:t_size]';

% Create a window large enough for the whole mechanisme in all positions, to prevent scrolling.
% This is done by plotting a diagonal from (x_left, y_bottom) to (x_right, y_top), setting the
% axes equal and saving the axes into "movie_axes", so that "movie_axes" can be used for further
% plots.
x_left = -r9;
y_bottom = -( r7 + r6);
x_right = r1*cos(t1);
y_top = r11;

figure(10)
hold on
plot([x_left, x_right], [y_bottom, y_top]);
axis equal;
movie_axes = axis;   %save current axes into movie_axes

% draw and save movie frame
for m=1:length(index_vec)
    index = index_vec(m);
    C = B + r2*exp(j*t2(index));
    H = C + r12*exp(j*(t12(index)));
    F = A + r7 * exp(j*(t7(index)+pi));
    E = F + r6 * exp(j*(t6(index)+pi));
    D = E + r4 * exp(j*(t4(index)));
    G = A + r9 * exp(j*(t9(index)));
    
    loop1 = [A, B, C, H, A, F, E, D, A, B, C, D, A, G, F, G, H];
    
    figure(10)
    clf
    hold on
    plot(real(loop1),imag(loop1),'-o')
    
    axis(movie_axes);     % set axes as in movie_axes
    Movie(m) = getframe;  % save frame to a variable Film
end

% save movie
save Grassey_movie Movie
close(10)