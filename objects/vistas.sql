
/* vista_citas_atendidas: Esta vista muestra las citas atendidas por pacientes, desde la mas reciente a la mas antigua e indica el profesional que la atendio.
Las tablas utilizadas para generar esta vista son las siguientes: citas, pacientes, odontologos*/

USE Gestion_citas_dentisalud;

CREATE VIEW vista_citas_atendidas AS
    SELECT 
        c.id_cita_pk,
        CONCAT(p.nombre_pac, ' ', apellido_pac) AS nombre_completo,
        DATE_FORMAT(c.fecha_programada, '%d/%m/%Y') AS fecha_cita,
        c.hora_inicio,
        c.hora_fin,
        c.estado_progreso AS estado,
        CONCAT(odon.nombre, ' ', apellido) AS profesional_que_atendio
    FROM
        pacientes as p
            INNER JOIN
        citas as c ON p.id_paciente_pk = c.id_paciente_pk
            INNER JOIN
        odontologos as odon ON c.id_odontologo = odon.id_odontologo
    WHERE
        c.estado_progreso = 'Atendido'
    ORDER BY fecha_programada DESC;

-- SELECT * 
-- FROM vista_citas_atendidas;

/* vista_horarios_inactivos: Las agendas pueden tener mas de un horario configurado y algunos podrían estar inactivos, 
esta vista facilita la visualización de los horarios inactivos que podrían existir dentro de una agenda determinada.
Las tablas utilizadas para generar esta vista son las siguientes: horarios, agendas */

CREATE VIEW vista_horarios_inactivos AS
    SELECT 
        a.descripcion AS agenda,
        h.dias_semana,
        h.hora_desde,
        h.hora_hasta,
        h.estado_horario AS horario_inactivo
    FROM
        horarios AS h
            INNER JOIN
        agendas AS a ON h.id_agenda_pk = a.id_agenda_pk
    WHERE
        h.estado_horario = 0;

-- SELECT * 
-- FROM vista_horarios_inactivos;

/* vista_atenciones_medico: Esta vista muestra las citas atendidas por un medico desde la fecha mas actual a la mas antigua.
Las tablas utilizadas para generar esta vista son las siguientes: horarios, agendas */

CREATE VIEW vista_atenciones_medico AS
SELECT 
  --  o.apellido, 
   -- o.nombre, 
	CONCAT(o.nombre, ' ', apellido) AS nombre_medico,
    COUNT(c.id_cita_pk) AS total_atenciones,
    MAX(c.fecha_programada) AS Fecha_cita,
    ag.descripcion AS descripcion_agenda
FROM 
    citas c
INNER JOIN 
    agendas AS ag ON c.id_agenda_pk = ag.id_agenda_pk   
INNER JOIN 
    odontologos o ON c.id_odontologo = o.id_odontologo
WHERE c.estado_progreso = 'Atendido'    
GROUP BY 
    o.apellido, o.nombre, ag.descripcion
ORDER BY fecha_cita DESC;

-- SELECT * 
-- FROM vista_atenciones_medico;
