residuos = Y - feval(fitresult, X);
figure;
plot(X, residuos, 'o');
yline(0, '--r'); % Línea en 0 para ver la distribución
xlabel('X (Tiempo)');
ylabel('Residuos');
title('Análisis de residuos');
grid on;
