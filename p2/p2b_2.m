%% 2.b)
tSis = out.ScopeData{1}.Values.Time;
ySis = out.ScopeData{1}.Values.Data;

tPO = out.ScopeData1{1}.Values.Time;
yPO = out.ScopeData1{1}.Values.Data;

figure;
plot(tSis, ySis, 'b', 'LineWidth', 2); hold on;
plot(tPO, yPO, 'r--', 'LineWidth', 2);
xlabel('Tiempo (s)');
ylabel('Salida');
title('Comparación de la Respuesta del Sistema Real y el Modelo Ajustado');
legend('Sistema Real', 'Modelo Ajustado');
grid on;

clear("out");