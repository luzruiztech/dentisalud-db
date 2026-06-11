
/* Funcion: f_citas_atendidas_por_servicio, esta funcion indicas la cantidad de citas atendidas en un rango de fechas para un determinado servicio, Si no existen citas para el rango y servicio ingresado, 
   esta funcion retornara un mensaje de error indicando que hay 0 citas para ese conjunto de datos.
   Las tablas interviniestes son: citas, horarios, agendas y servicios.
 */
 
DROP FUNCTION  IF EXISTS f_citas_atendidas_por_servicio;
DELIMITER //
CREATE FUNCTION f_citas_atendidas_por_servicio(
    fecha_desde DATE,
    fecha_hasta DATE,
    servicio VARCHAR(100)
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE num_citas INT;
    
    SELECT COUNT(*)
    INTO num_citas
    FROM citas AS c
    INNER JOIN horarios AS h ON c.id_horarios_pk = h.id_horarios_pk
    INNER JOIN agendas AS a ON c.id_agenda_pk = a.id_agenda_pk
    INNER JOIN servicios AS s ON a.id_odontologo = s.id_servicio_pk
    WHERE c.fecha_programada BETWEEN fecha_desde AND fecha_hasta
    AND s.descripcio_serv = servicio
    AND c.estado_progreso = 'Atendido';

    IF num_citas = 0 THEN SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT  = '>>> 0 CITAS PARA EL SERVICIO Y RANGO INGRESADO <<<', MYSQL_ERRNO = 1000;
            ELSE
        RETURN num_citas;
    END IF;
END//
DELIMITER ;

-- NOTA:Tambien robar con el servicio Odontologia General con 0 citas atendidas...
-- SELECT f_citas_atendidas_por_servicio('2024-03-13', '2024-04-18', 'Estetica dental'); 

/* Funcion: f_citas_atendidas_paciente, esta funcion indicas la cantidad de veces que ha sido 'Atendido' un paciente y asi controlar sus atenciones, como tambien cuando este no ha sido atendido, 
   Las tablas interviniestes son: pacientes, y cias.
 */
 
 DROP FUNCTION  IF EXISTS f_citas_atendidas_paciente; 
 DELIMITER //
CREATE FUNCTION f_citas_atendidas_paciente(
    id_paciente INT
)
RETURNS VARCHAR(200)
DETERMINISTIC
BEGIN
    DECLARE citas_pac INT;
    DECLARE nombre_completo_pac VARCHAR(200);
    
    SELECT CONCAT(apellido_pac, ' ', nombre_pac) INTO nombre_completo_pac
    FROM pacientes
    WHERE id_paciente_pk = id_paciente;
    
    IF nombre_completo_pac IS NULL THEN
        RETURN 'Paciente nunca antes Atendido';
    ELSE
        SELECT COUNT(*)
        INTO citas_pac
        FROM citas
        WHERE id_paciente_pk = id_paciente AND estado_progreso = 'Atendido';
        
        RETURN CONCAT(nombre_completo_pac, ' ha sido atendido ', citas_pac, ' veces.');
    END IF;
END//
DELIMITER ;

-- SELECT f_citas_atendidas_paciente(1);

/* Funcion: f_horarios_disponibles_agendas, esta funcion muestra los horarios disponibles o activos dentro de una desterminada agenda, 
en caso de que no existan horarios activos, retorna la informacion de que no existen horarios para esa agenda.
Las tablas interviniestes son: horarios, y cias.
 */

DROP FUNCTION IF EXISTS f_horarios_disponibles_agendas;
DELIMITER //
CREATE FUNCTION f_horarios_disponibles_agendas(
    id_agenda INT
)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE horarios_disponibles VARCHAR(255);
    
    SELECT GROUP_CONCAT(
        'Día: ', dias_semana, ', ',
        'Desde: ', TIME_FORMAT(hora_desde, '%H:%i'), ', ',
        'Hasta: ', TIME_FORMAT(hora_hasta, '%H:%i')
        ORDER BY dias_semana, hora_desde
        SEPARATOR '; '
    )
    INTO horarios_disponibles
    FROM horarios
    WHERE id_agenda_pk = id_agenda
    AND estado_horario = 1
    AND id_horarios_pk NOT IN (
        SELECT id_horarios_pk
        FROM citas
        WHERE id_agenda_pk = id_agenda
    );

    IF horarios_disponibles IS NULL THEN
        RETURN 'No existen horarios disponibles para esta agenda';
    ELSE
        RETURN horarios_disponibles;
    END IF;
END//
DELIMITER ;

-- SELECT f_horarios_disponibles_agendas (5);





