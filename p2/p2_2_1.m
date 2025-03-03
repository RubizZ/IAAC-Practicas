%% 2.2.1

% Encuentra el valor final y la pendiente máxima
K = 1.388888881295065e+02;
To = 6.5;
Tp = 12;

fprintf('Ganancia K = %.3f, Retardo To = %.3f, Constante de tiempo Tp = %.3f\n', K, To, Tp);

% Cálculo de parámetros del PID
Kp_p = (1.2 * Tp) / (K * To);  % Control P

Kp_pi = (0.9 * Tp) / (K * To);  % Control PI
Ti_pi = 3.3 * To;
Ki_pi = Kp_pi / Ti_pi;

Kp_pid = (1.2 * Tp) / (K * To);  % Control PID
Ti_pid = 2 * To;
Ki_pid = Kp_pid / Ti_pid;
Td_pid = 0.5 * To;
Kd_pid = Kp_pid * Td_pid;

fprintf('P: Kp = %.3f\n', Kp_p);
fprintf('PI: Kp = %.3f, Kp = %.3f\n', Kp_pi, Ki_pi);
fprintf('PID: Kp = %.3f, Ki = %.3f, Kd = %.3f\n', Kp_pid, Ki_pid, Kd_pid);

%% Resultados

% P -> 
