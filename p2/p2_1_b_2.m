%% 2.1.b)
tSis = out.ScopeData{1}.Values.Time;
ySis = out.ScopeData{1}.Values.Data;

tPO = out.ScopeData1{1}.Values.Time;
yPO = out.ScopeData1{1}.Values.Data;

figure;
plot(tSis, ySis, 'b', 'LineWidth', 2); hold on;
plot(tPO, yPO, 'r--', 'LineWidth', 2);
xlabel('Tiempo (s)');
ylabel('Salida');
title('Comparación');
legend('Sistema Real', 'Primer Orden');
grid on;

clear("out");