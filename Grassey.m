r1 = 75;
r2 = 26;
r3 = 56;
r4 = 77;
r5 = 75;
r6 = 75;
r7 = 77;
r8 = 109;
r9 = 75;
r10 = 97;
r11 = 77;
r12 = 56;
t1 = 0.085;

omega = 0.15;
t_begin = 0;
t_end = round(2*2*pi/omega,0);
Ts = 0.05;
t = [t_begin:Ts:t_end]';

t2=1.4+omega*t;               
dt2=omega+0*t;

t_init = [1.8 1.1 2.8 2.9 1.1 1.9 2.7 0.4 1.3 2.3];

[t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,dt3,dt4,dt5,dt6,dt7,dt8,dt9,dt10,dt11,dt12] = kinematics_grassey(r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,t1,t2,dt2,t_init,t);

index = 1; 
    
    A = 0;
    B = r1*exp(j*t1);
    C = B + r2*exp(j*t2(index));
    H = C + r12*exp(j*(t12(index)));
    F = A + r7 * exp(j*(t7(index)+pi));
    E = F + r6 * exp(j*(t6(index)+pi));
    D = E + r4 * exp(j*(t4(index)));
    G = A + r9 * exp(j*(t9(index)));
    
    
    figure
    assembly=[A, B, C, H, A, F, E, D, A, B, C, D, A, G, F, G, H];
    plot(real(assembly),imag(assembly),'ro-')
    xlabel('[m]')
    ylabel('[m]')
    title('assembly')
    axis equal

    
figure
load Grassey_movie Movie
movie(Movie)
