
/* Trigger: registro_cambios_agenda, este trigguer registra los cambios reliados en el estado de las agendas, 
esta puede estar activa (1) o inactiva (0), los cambios realizados se registraran en la tabla registro_cambios_agenda, registrando la fecha del cambio,
el estado anterior y el estado actual. Tb+ablas intervinientes : agendas y registro_cambios_agenda
 */

DROP TABLE IF EXISTS registro_cambios_agenda;
-- Tabla donde se guarda la informacion del trigger.
CREATE TABLE registro_cambios_agenda (
    id_registro INT AUTO_INCREMENT PRIMARY KEY,
    fecha_cambio DATE,
    hora_cambio TIME,
    id_agenda_pk INT,
    descripcion_agenda VARCHAR(255),
    estado_anterior INT,
    estado_actual INT
);

-- Trigger:
DROP TRIGGER IF EXISTS registrar_cambio_estado_agenda;
DELIMITER //
CREATE TRIGGER registrar_cambio_estado_agenda
AFTER UPDATE ON agendas
FOR EACH ROW
BEGIN
    -- Verificar si el estado anterior es diferente al nuevo estado
    IF OLD.estado <> NEW.estado THEN
        -- Insertar en la tabla de registro de cambios
        INSERT INTO registro_cambios_agenda (fecha_cambio, hora_cambio, id_agenda_pk, descripcion_agenda, estado_anterior, estado_actual)
        VALUES (CURDATE(), CURTIME(), NEW.id_agenda_pk, NEW.descripcion, OLD.estado, NEW.estado);
    END IF;
END //
DELIMITER ;

-- UPDATE agendas SET estado = 1 WHERE id_agenda_pk = 4;

-- SELECT *
-- FROM registro_cambios_agenda;

/* Trigger: validar_fecha_nacimiento, el siguiente trigger valida que al crearse un nuevo registro en la tabla pacientes, la fehca de nacimiento no sea mayor a la fecha actual,
si esto sucese se generar un mensaje de error y evita la insercion del registro. Interviene solo la tabla pacientes.
 */
DROP TRIGGER IF EXISTS validar_fecha_nacimiento;
DELIMITER //
CREATE TRIGGER validar_fecha_nacimiento
BEFORE INSERT ON pacientes
FOR EACH ROW
BEGIN
    DECLARE fecha_actual DATE;
    DECLARE mensaje_error VARCHAR(255);
    
    SET fecha_actual = CURDATE();   
    IF NEW.fecha_nac > fecha_actual THEN       
        SET mensaje_error = 'La fecha de nacimiento debe ser anterior a la fecha actual.';
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje_error;
    END IF;
END //
DELIMITER ;

-- INSERT INTO pacientes (id_paciente_pk, apellido_pac, nombre_pac, nacionalidad_pac, tipo_doc_pac, nro_documento, fecha_nac, sexo_pac, email_pac, telf, obra_social, plan, nro_credencial)
-- VALUES
-- (16, 'Zalazar', 'Ricardo', 'Argentina', 'DNI', 33245678, '2024-05-27', 'Masculino', 'zalazar@gmail.com', 52334455 , 'Medife', 'Plan 333', 423456787);


/* evitar_eliminar_pacientes_con_citas, el siguiente trigger evita que se elimine el registro de un paciente si este tiene citas relacionadas, si se intenta eliminar un paciente con citas, 
se genera un mensaje de error y evita que se elimine el registro. Las tablas intervinientes son las tablas pacientes y citas.
 */
DROP TRIGGER IF EXISTS evitar_eliminar_pacientes_con_citas;
DELIMITER //
CREATE TRIGGER evitar_eliminar_pacientes_con_citas
BEFORE DELETE ON pacientes
FOR EACH ROW
BEGIN
    DECLARE n_citas INT;

        SELECT COUNT(*) INTO n_citas
    FROM citas
    WHERE id_paciente_pk = OLD.id_paciente_pk;
       IF n_citas > 0 THEN -- si la cita es mayor que cero
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No se puede eliminar el paciente porque tiene citas asociadas.';
    END IF;
END;
//
DELIMITER ;

-- DELETE FROM pacientes WHERE id_paciente_pk = 1;

 
