-- Insercion de datos mediante codigo:

USE Gestion_citas_dentisalud;

-- Insercion tabla Odontologos:

INSERT INTO Gestion_citas_dentisalud.odontologos (id_odontologo, apellido, nombre, nacionalidad, tipo_doc, nro_doc, matricula, email, fecha_registro, fecha_ult_act)
VALUES 
       (1, 'Martínez', 'María', 'Argentina', 'DNI', '56789012', '654321', 'maria@email.com', '2023-04-15 12:00:00', '2023-04-17'),
       (2, 'Castro',  'Jorge', 'Argentina', 'DNI',	'56789012',	'654321','castro@email.com','2022-04-15 09:00:00', '2023-04-17'),
       (3, 'Sánchez', 'Laura',  'Argentina', 'DNI',	'34567890',	'432109', 'laura@email.com', '2021-04-19 11:00:00', '2022-03-12'),
       (4, 'González', 'Marta', 'Chilena',	'RUT', '56789012', '210987', 'marta@email.com','2020-05-20 08:00:00', '2023-03-12'),
       (5, 'Juarez', 'Bethy', 'colombiana',	'CI', '55789012', '214987',	'bethy@email.com','2021-06-20 09:00:00', '2022-12-12');


-- Insercion en tabla agendas:

INSERT INTO Gestion_citas_dentisalud.agendas (id_agenda_pk, id_odontologo, descripcion, fecha_desde, fecha_hasta, estado)
VALUES
(1, 1, 'Ortodoncia dra. Maria Martinez', '2024-04-15', '2025-04-15', 1),
(2, 2, 'Extraciones dr. Jorge Castro', '2024-01-11', '2025-011-11', 1),
(3, 5, 'Estetica deltal  dra. Bethy Juarez', '2024-03-03', '2025-03-03', 1),
(4, 4, 'Odontologia General Marta Gonzalez', '2024-01-03', '2025-01-03', 0),
(5, 3, 'Odontologia General Laura Sanchez', '2024-01-13', '2025-01-13', 0);	  


-- Insercion en tabla Servicios:

INSERT INTO Gestion_citas_dentisalud.servicios (id_servicio_pk, descripcio_serv)
VALUES
(1, 'Ortodoncia'),
(2, 'Extracciones'),
(3, 'Estetica Dental'),
(4, 'Odontologia General');


-- Insercion en tabla tipo_consulta:

INSERT INTO Gestion_citas_dentisalud.tipo_consulta (tconsulta_pk, tipo_consulta)
VALUES
(1, 'Primera Consulta'),
(2, 'Consulta de Seguimiento');


-- Insercion en tabla consultorios:

INSERT INTO Gestion_citas_dentisalud.consultorios (consultorio_pk, id_servicio_pk, descripcion, estado)
VALUES
(1, 2, 'Consultorio de Ortodoncia', '1'),
(2, 3, 'Consultorio de Extracciones', '1'),
(3, 4, 'Consultorio de Estetica', '0'),
(4, 1, 'Odontologia General', '1');


-- Insercion en tabla horario:

INSERT INTO horarios (id_horarios_pk, id_agenda_pk, dias_semana, hora_desde, hora_hasta, duracion, id_servicio_pk, tconsulta_pk, consultorio_pk, estado_horario)
VALUES
(1, 1, 'Lunes', '08:00:00', '12:30:00', 30, 1, 1, 1, 1),
(2, 1, 'Lunes', '14:00:00', '18:30:00', 30, 1, 2, 1, 0),
(3, 4, 'Martes', '08:00:00', '12:30:00', 30, 4, 1, 2, 0),
(4, 3, 'Martes', '14:00:00', '18:30:00', 30, 3, 2, 2, 1),
(5, 4, 'Miércoles', '08:00:00', '12:30:00', 30, 4, 2, 2, 1),
(6, 5, 'Miércoles', '14:00:00', '18:30:00', 30, 3, 1, 4, 1),
(7, 4, 'Jueves', '08:00:00', '12:30:00', 30, 4, 2, 3, 1),
(8, 5, 'Jueves', '14:00:00', '18:30:00', 30, 2, 1, 3, 1),
(9, 1, 'Viernes', '08:00:00', '12:30:00', 30, 1, 2, 1, 1),
(10, 2, 'Viernes', '14:00:00', '18:30:00', 30, 2, 2, 2, 1),
(11, 5, 'Lunes', '08:00:00', '12:14:00', 30, 4, 1, 1, 1),
(12, 5, 'Lunes', '14:00:00', '18:22:00', 30, 4, 2, 1, 1);


-- Insercion en tabla pacientes:
INSERT INTO pacientes (id_paciente_pk, apellido_pac, nombre_pac, nacionalidad_pac, tipo_doc_pac, nro_documento, fecha_nac, sexo_pac, email_pac, telf, obra_social, plan, nro_credencial)
VALUES
(1, 'González', 'Lucía', 'Argentina', 'DNI', 12345678, '1980-05-15', 'Femenino', 'lucia@email.com', 112334455 , 'OSDE', 'Plan 210', 123456789),
(2, 'Rodríguez', 'Juan', 'Argentina', 'DNI', 23456789, '1975-10-20', 'Masculino', 'juan@email.com', 223445566 , 'Swiss Medical', 'Plan Plata', 987654321),
(3, 'García', 'María', 'Argentina', 'DNI', 34567890, '1988-07-08', 'Femenino', 'maria@email.com', 344556677, 'Particular', 'Particular', NULL),
(4, 'López', 'Carlos', 'Argentina', 'DNI', 45678901, '1970-12-30', 'Masculino', 'carlos@email.com', 445667788, 'OSDE', 'Plan 310', 456789123),
(5, 'Martínez', 'Ana', 'Argentina', 'DNI', 56789012, '1990-03-25', 'Femenino', 'ana@email.com', 566778899, 'Swiss Medical', 'Plan Oro', 321654987),
(6, 'Fernández', 'Diego', 'Argentina', 'DNI', 67890123, '1985-08-12', 'Masculino', 'diego@email.com', 667789900, 'Particular', 'Particular', NULL),
(7, 'Pérez', 'Laura', 'Argentina', 'DNI', 78901234, '1965-06-03', 'Femenino', 'laura@email.com', 778890011, 'OSDE', 'Plan 420', 789456123),
(8, 'Gómez', 'Miguel', 'Argentina', 'DNI', 89012345, '1978-11-18', 'Masculino', 'miguel@email.com', 88001122, 'Swiss Medical', 'Plan Platino', 852147963),
(9, 'Díaz', 'Paula', 'Argentina', 'DNI', 90123456, '1983-09-22', 'Femenino', 'paula@email.com', 99001233, 'Particular', 'Particular', NULL),
(10, 'Torres', 'José', 'Argentina', 'DNI', 12345677, '1992-02-10', 'Masculino', 'jose@email.com', 11223455, 'OSDE', 'Plan 530', 369852147);


-- Insercion en tabla citas:

INSERT INTO citas (id_paciente_pk, id_odontologo, id_agenda_pk, id_horarios_pk, fecha_programada, hora_inicio, hora_fin, estado_progreso)
VALUES

(1, 5, 3, 4, '2024-03-15', '08:00:00', '08:30:00', 'Atendido'),
(2, 2, 2, 8, '2024-04-20', '10:30:00', '11:00:00', 'Ausente'),
(3, 1, 1, 1, '2024-05-10', '14:00:00', '14:30:00', 'Pendiente'),
(4, 3, 5, 7, '2024-04-05', '08:30:00', '09:00:00', 'Atendido'),
(5, 4, 4, 8, '2024-07-12', '12:00:00', '12:30:00', 'Pendiente'),
(6, 2, 2, 1, '2024-04-18', '16:30:00', '17:00:00', 'Atendido'),
(7, 1, 1, 9, '2024-03-22', '09:00:00', '09:30:00', 'Atendido'),
(8, 4, 4, 3, '2024-04-05', '13:30:00', '14:00:00', 'Ausente'),
(9, 3, 5, 6, '2024-11-10', '15:00:00', '15:30:00', 'Pendiente'),
(10,5, 3, 10, '2024-12-15', '11:30:00', '12:00:00', 'Pendiente');




