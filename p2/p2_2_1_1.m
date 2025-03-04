t = out.ScopeData1{1}.Values.Time;
u = out.ScopeData1{1}.Values.Data;

% Suponiendo que "t" es el vector de tiempo y "u" es la señal de control
du = diff(u); % Aproximación de la derivada

% Buscar el primer cambio de signo en du (de positivo a negativo → máximo local)
for i = 2:length(du)
    if du(i-1) > 0 && du(i) < 0  % Cambio de signo indica un pico
        t_primer_pico = t(i); % Guardar el tiempo del primer pico
        break;
    end
end

% Encontrar el índice más cercano al tiempo del primer pico
N = find(t > t_primer_pico, 1);  

% Extraer la parte de la señal en estado estable
u_estable = u(N:end);

max_u = max(u_estable);
min_u = min(u_estable);

% Aplicar un margen del 10% para evitar cortes bruscos
upper_limit = 1.1 * max_u;
lower_limit = 1.1 * min_u;

fprintf('Límites de saturación: min = %.4f, max = %.4f\n', lower_limit, upper_limit);
