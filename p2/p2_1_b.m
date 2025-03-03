%% 2.1.b)
t = out.ScopeData{1}.Values.Time;
y = out.ScopeData{1}.Values.Data;

K = max(y);
To_Y = find(y > 0.01 * K, 1);  % Encuentra el primer índice con más del 2% de la salida final
To_X = t(To_Y);  % Tiempo correspondiente
Tp_Y = find(y > 0.632 * K, 1);  % Índice donde la salida alcanza el 63.2% del valor final
Tp_X = t(Tp_Y);  % Tiempo correspondiente

figure;
plot(t, y, 'b', 'LineWidth', 2);
hold on;
yline(K, 'r--', 'LineWidth', 2);  
text(t(end)*0.01, max(y) + max(y) / 20, sprintf('  K = %.4f', K), 'FontSize', 12, 'Color', 'red');
plot(To_X, y(To_Y), 'ro', 'MarkerSize', 8, 'LineWidth', 2); % Punto Td
plot(Tp_X, y(Tp_Y), 'go', 'MarkerSize', 8, 'LineWidth', 2); % Punto τ
xlabel('Tiempo (s)');
ylabel('Salida');
title('Grafica del modelo sistema planta = 1');
legend('Respuesta', 'Ganancia K', 'Retardo To', 'Constante de tiempo Tp');
grid on;

