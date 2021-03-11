function P = Loop_closure_Grassey(t_init,t2,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,t1)

t3 = t_init(1);
t4 = t_init(2);
t5 = t_init(3);
t6 = t_init(4);
t7 = t_init(5);
t8 = t_init(6);
t9 = t_init(7);
t10 = t_init(8);
t11 = t_init(9);
t12 = t_init(10);

P(1) = r1*cos(t1) + r2*cos(t2) + r12*cos(t12) - r11*cos(t11);
P(2) = r1*sin(t1) + r2*sin(t2) + r12*sin(t12) - r11*sin(t11);
P(3) = r9*cos(t9) - r8*cos(t8) + r7*cos(t7);
P(4) = r9*sin(t9) - r8*sin(t8) + r7*sin(t7);
P(5) = -r7*cos(t7) - r6*cos(t6) + r5*cos(t5) + r4*cos(t4);
P(6) = -r7*sin(t7) - r6*sin(t6) + r5*sin(t5) + r4*sin(t4);
P(7) = r9*cos(t9) + r10*cos(t10) - r11*cos(t11);
P(8) = r9*sin(t9) + r10*sin(t10) - r11*sin(t11);
P(9) = r1*cos(t1) + r2*cos(t2) - r3*cos(t3) + r5*cos(t5);
P(10) = r1*sin(t1) + r2*sin(t2) - r3*sin(t3) + r5*sin(t5);


