entrada = [datos.efector(1:end-1,:), datos.efector(2:end,:)]'; 

salida_base = datos.angulo(:, 1)';
salida_hombro = datos.angulo(:, 2)';
salida_codo = datos.angulo(:, 3)';
salida_mv = datos.angulo(:, 4)';