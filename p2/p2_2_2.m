%% 2.2.2

t = out.ScopeData1{1}.Values.Time;
y = out.ScopeData1{1}.Values.Data;

Ku_p = 6.515e-2;
fprintf('Ganancia crítica P (Ku) = %.4e\n', Ku_p);
Ku_pi = 2.002;
fprintf('Ganancia crítica PI (Ku) = %.4e\n', Ku_pi);
Ku_pid = 6.515e-2;
fprintf('Ganancia crítica PID (Ku) = %.4e\n', Ku_pid);

% Encuentra las posiciones de los picos observando cuando la derivada cambia de positiva a negativa
dydt = diff(y);  % Diferencia de la señal
pks_locs = find(dydt(1:end-1) > 0 & dydt(2:end) < 0) + 1; % Picos (donde la derivada cambia de positiva a negativa)

% Calcular el periodo crítico (Tu) como la diferencia de tiempo entre dos picos sucesivos
Tu = mean(diff(t(pks_locs)));  % Promedio de los intervalos entre los picos
fprintf('Periodo crítico (Tu) = %.2f\n', Tu);

% Cálculo de parámetros del PID
Kp_p = 0.5 * Ku_p;  % Control P

Kp_pi = 0.45 * Ku_pi;  % Control PI
Ti_pi = Tu / 1.2;
Ki_pi = Kp_pi / Ti_pi;

Kp_pid = 0.6 * Ku_pid;  % Control PID
Ti_pid = Tu / 2;
Ki_pid = Kp_pid / Ti_pid;
Td_pid = Tu / 8;
Kd_pid = Kp_pid * Td_pid;

fprintf('P: Kp = %.3f\n', Kp_p);
fprintf('PI: Kp = %.3f, Ki = %.3f\n', Kp_pi, Ki_pi);
fprintf('PID: Kp = %.3f, Ki = %.3f, Kd = %.3f\n', Kp_pid, Ki_pid, Kd_pid);

%% Resultados

% P -> 
