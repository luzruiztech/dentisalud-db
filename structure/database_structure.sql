
DROP DATABASE IF EXISTS Gestion_citas_dentisalud;
CREATE DATABASE Gestion_citas_dentisalud;

USE Gestion_citas_dentisalud; 

CREATE TABLE odontologos (
id_odontologo INT PRIMARY KEY AUTO_INCREMENT,
apellido       VARCHAR (100),
nombre         VARCHAR (100),
nacionalidad   VARCHAR (100),
tipo_doc       VARCHAR (10),
nro_doc        INT,
matricula      INT,
email         VARCHAR (100) UNIQUE NOT NULL,
fecha_registro DATETIME,
fecha_ult_act  DATE
);

CREATE TABLE agendas (
id_agenda_pk    INT PRIMARY KEY AUTO_INCREMENT,
id_odontologo  INT,
descripcion     VARCHAR (100),
fecha_desde     DATE,
fecha_hasta     DATE,
estado          BOOLEAN

);
CREATE TABLE horarios (
id_horarios_pk INT PRIMARY KEY AUTO_INCREMENT,
id_agenda_pk    INT,
dias_semana     VARCHAR (50),
hora_desde      TIME,  -- SE CAMBIO TIPO DE CAMPO A TIME
hora_hasta      TIME,  -- SE CAMBIO TIPO DE CAMPO A TIME
duracion        INT,
id_servicio_pk  INT,  -- SE ELIMINARON FECHA INICIO Y FIN DE LOS HORARIOS YA QUE LA VIGENCIA SE LOS DA LA AGENDA
tconsulta_pk    INT,
consultorio_pk  INT,
estado_horario  BOOLEAN

);
CREATE TABLE consultorios (
consultorio_pk INT PRIMARY KEY AUTO_INCREMENT,
id_servicio_pk INT,
descripcion    VARCHAR (100),
estado         BOOLEAN

);
CREATE TABLE tipo_consulta (
tconsulta_pk  INT PRIMARY KEY AUTO_INCREMENT,
tipo_consulta VARCHAR (100)
);
CREATE TABLE servicios (
id_servicio_pk  INT PRIMARY KEY AUTO_INCREMENT,
descripcio_serv VARCHAR (100)
);

CREATE TABLE pacientes (
id_paciente_pk     INT PRIMARY KEY AUTO_INCREMENT,
apellido_pac       VARCHAR (100),
nombre_pac         VARCHAR (100),
nacionalidad_pac   VARCHAR (100),
tipo_doc_pac       VARCHAR (10),
nro_documento      INT,  
fecha_nac          DATE DEFAULT NULL, 
sexo_pac           VARCHAR (100) DEFAULT 'Desconocido',
email_pac         VARCHAR (100) UNIQUE NOT NULL,
telf               INT,
obra_social        VARCHAR (100),
plan               VARCHAR (100),
nro_credencial     INT

);
CREATE TABLE citas (
id_cita_pk       INT PRIMARY KEY AUTO_INCREMENT,
id_paciente_pk   INT,
id_odontologo    INT,
id_agenda_pk     INT,
id_horarios_pk   INT,
fecha_programada DATETIME,
hora_inicio      TIME, 
hora_fin         TIME,   
estado_progreso  VARCHAR (50)
);

-- FK 
-- AGENDAS
ALTER TABLE agendas
      ADD CONSTRAINT fk_agenda_odont
      FOREIGN KEY (id_odontologo) REFERENCES odontologos(id_odontologo);
      
-- CONSULTORIOS
ALTER TABLE consultorios
      ADD CONSTRAINT fk_consultorio_serv
      FOREIGN KEY (id_servicio_pk) REFERENCES servicios(id_servicio_pk);
      
-- HORARIOS
ALTER TABLE horarios
      ADD CONSTRAINT fk_horario_agenda
      FOREIGN KEY (id_agenda_pk) REFERENCES agendas (id_agenda_pk);
      
ALTER TABLE horarios
      ADD CONSTRAINT fk_horario_serv
      FOREIGN KEY (id_servicio_pk) REFERENCES servicios (id_servicio_pk);
      
ALTER TABLE horarios
      ADD CONSTRAINT fk_horario_tconsul  
      FOREIGN KEY (tconsulta_pk) REFERENCES tipo_consulta (tconsulta_pk);
      
ALTER TABLE horarios
      ADD CONSTRAINT fk_horario_consultorio 
            FOREIGN KEY (consultorio_pk) REFERENCES consultorios (consultorio_pk);
            
-- CITAS
ALTER TABLE citas
      ADD CONSTRAINT fk_cita_pac
      FOREIGN KEY (id_paciente_pk) REFERENCES pacientes (id_paciente_pk);
      
ALTER TABLE citas
      ADD CONSTRAINT fk_cita_odon
      FOREIGN KEY (id_odontologo) REFERENCES odontologos (id_odontologo);

ALTER TABLE citas
      ADD CONSTRAINT fk_cita_agen
      FOREIGN KEY (id_agenda_pk) REFERENCES agendas (id_agenda_pk);
      
ALTER TABLE citas
      ADD CONSTRAINT fk_cita_hor
      FOREIGN KEY (id_horarios_pk) REFERENCES horarios (id_horarios_pk);
      
