function pid=sistema_experto(pid,num,den,espec)

% Simulamos el modelo
  [tout,yout]=simular(pid,num,den);
    
% Calculo de las caracteristicas del sistema
  [tr,tp,Mp,ts,ys]=caracteristicas(tout,yout);
  [tout,yout]=simular(pid,num,den,tr,tp,Mp,ts,ys);
  
% Abrimos el modelo Simulink
  open_system('modelo');
  disp(' ');
  disp(' Pulse enter para ejecutar el control experto');
  pause;

  % APARTADO 2 (reglas de la base de conocimientos)
  % Si tr>4s => Aumentar Kp, aumentar Ki, disminuir Kd
  % Si tp>=20s => Aumentar Kp, disminuir Ki, disminuir Kd
  % Si Mp>15% => Disminuir Kp, disminuir Ki, aumentar Kd
  % Si tss>=30s => Aumentar Kp, aumentar Ki, disminuye Kd
  % Si yss != 1 => Aumentar Ki
  % FIN APARTADO 2

  last_ys = ys;
  cambio_ys = 0.1;
  
% Reglas del sistema experto para adaptar las caracteristicas a las especificaciones
  salir=[0,0,0,0,0];
  while ~all(salir)

    % Regla para el tiempo de subida, de pico y de setting
    if ~salir(1) || ~salir(2) || ~salir(4)
        if espec(1)<=tr || espec(2)<tp || espec(4)<ts
          pid(1)=pid(1)+0.5;
        end 
    end

    % Regla para la sobreelongacion
    if salir(1) && salir(2) && salir(4) && ~salir(3)
        if espec(3)<=Mp 
          pid(1)=pid(1)-0.2;
          %pid(2)=pid(2)-0.1;
          pid(3)=pid(3)+0.5;
        end
    end
    
    % Regla para el estado estacionario
    if abs(espec(5) - ys) >= 1e-5
        if ys < espec(5)
            if last_ys > espec(5) && all(salir(1:4))
                cambio_ys = cambio_ys / 2;
            end
            pid(2) = pid(2) + cambio_ys;
        else
            if last_ys < espec(5) && all(salir(1:4))
                cambio_ys = cambio_ys / 2;
            end
            pid(2) = pid(2) - cambio_ys;
        end
        last_ys = ys;
    end
    
    
    % Caracteristicas del sistema bajo la nueva situacion
    [tout,yout]=simular(pid,num,den,tr,tp,Mp,ts,ys);
    [tr,tp,Mp,ts,ys]=caracteristicas(tout,yout);
    
    % Si se cumplen las especificaciones, entonces salir
    
    if tr<=espec(1)
        salir(1)=1;
    else
        salir(1)=0;
    end

    if tp<espec(2)
        salir(2)=1;
    else
        salir(2)=0;
    end
    
    if Mp<=espec(3)
        salir(3)=1;
    else
        salir(3)=0;
    end
    
    if ts<espec(4)
        salir(4)=1;
    else
        salir(4)=0;
    end
    
    if abs(espec(5) - ys) < 1e-5
        salir(5)=1;
    else
        salir(5)=0;
    end
    
    fprintf('Kp = %.3f, Ki = %.3f, Kd = %.3f, salir = [%d, %d, %d, %d, %d]\n', pid(1), pid(2), pid(3), salir(1), salir(2), salir(3), salir(4), salir(5));
  end
  [tout,yout]=simular(pid,num,den,tr,tp,Mp,ts,ys);
  disp(' ');
  disp(' PID sintonizado, pulse enter para salir');
  pause;
  
% Cerramos el modelo Simulink
  %close_system('modelo');

% Dato curioso, estos cambios en las ganancias para suplir unas
% caracteristicas muy restrictivas hacen que no cambie la señal
% ni en un numero elevado de iteraciones
  %last_ys = ys;
  %cambio_ys = 0.1;
  
% Reglas del sistema experto para adaptar las caracteristicas a las especificaciones
  %salir=[0,0,0,0,0];
  %while ~all(salir)

    % Regla para el tiempo de subida, de pico y de setting
    %if ~salir(1) || ~salir(2) || ~salir(4)
        %if espec(1)<=tr || espec(2)<tp || espec(4)<ts
          %pid(1)=pid(1)+0.5;
        %end 
    %end

    % Regla para la sobreelongacion
    %if ~salir(3)
        %if espec(3)<=Mp 
          %pid(1)=pid(1)-0.2;
          %pid(2)=pid(2)-0.1;
          %pid(3)=pid(3)+0.1;
        %end
    %end
    
    % Regla para el estado estacionario
    %if abs(espec(5) - ys) >= 1e-5
        %if ys < espec(5)
            %if last_ys > espec(5) && all(salir(1:4))
                %cambio_ys = cambio_ys / 2;
            %end
            %pid(2) = pid(2) + cambio_ys;
        %else
            %if last_ys < espec(5) && all(salir(1:4))
                %cambio_ys = cambio_ys / 2;
            %end
            %pid(2) = pid(2) - cambio_ys;
        %end
        %last_ys = ys;
    %end