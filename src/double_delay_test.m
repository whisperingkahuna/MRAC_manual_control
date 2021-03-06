% case 2
time = linspace(0, 89.99, 90000);
signal = models.forcing_func_mcruer(time, "6-4");

s = tf('s');
k_c = 30;
p = 0.2;
H_c = k_c/(s*(s + p));

omega_c = 3;
delay = 0.3;
delay_0 = 0.2;
L = omega_c/s * exp(-delay * s);

k_d = omega_c/k_c;
k_p = p * k_d;
H_p_2delays = s * k_d * exp(-delay * s) + k_p * exp(-delay_0 * s);
H_p = (k_p + s * k_d) * exp(-delay * s);

cl_sys_L = feedback(L, 1);
cl_sys = feedback(H_p * H_c, 1);
cl_sys_2delays = feedback((H_p_2delays_0 + H_p_2delays_1) * H_c, 1);

[y_L, t] = lsim(cl_sys_L, signal, time);
[y, t] = lsim(cl_sys, signal, time);
[y_2delays, t] = lsim(cl_sys_2delays, signal, time);

figure;
plot(time, signal);
hold on;
plot(time, y_L);
hold on;
plot(time, y);
hold on;
plot(time, y_2delays);
%% case 1
time = linspace(0, 89.99, 90000);
signal = models.forcing_func_mcruer(time, "6-4");

s = tf('s');
k_c = 90;
p = 6;
H_c = k_c/(s*(s + p));

omega_c = 3;
delay = 0.3;
L = omega_c/s * exp(-delay * s);
k_d = omega_c/k_c;
k_p = p * k_d;
H_p = (k_p + s * k_d) * exp(-delay * s);

cl_sys_L = feedback(L, 1);
cl_sys = feedback(H_p * H_c, 1);
[y_L, t] = lsim(cl_sys_L, signal, time);
[y, t] = lsim(cl_sys, signal, time);

figure;
plot(time, signal);
hold on;
plot(time, y_L);
hold on;
plot(time, y);
