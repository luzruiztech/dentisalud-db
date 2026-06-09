# DentiSalud — Sistema de Gestión de Citas Odontológicas

**Base de datos relacional completa para la gestión de agendas, turnos y pacientes de un centro odontológico.**

> Proyecto final del curso SQL — Coderhouse (2024)
> Desarrollado por **Luz Emily Ruiz Neiva**

---

## Descripción

DentiSalud es un sistema de base de datos diseñado para resolver un problema real del sector salud: la gestión eficiente de citas, agendas de profesionales y datos de pacientes en un centro odontológico.

El proyecto cubre el ciclo completo de diseño e implementación de una base de datos relacional en producción:

- Modelado de entidades y relaciones (DER)
- Creación de estructura de tablas normalizadas
- Implementación de lógica de negocio con objetos SQL avanzados
- Sistema de roles y permisos por perfil de usuario
- Automatización con scripts de backup y administración

---

## Arquitectura y tecnologías

| Tecnología | Uso |
|---|---|
| **MySQL** | Motor de base de datos principal |
| **MySQL Workbench** | Diseño del modelo y desarrollo de queries |
| **Docker + Docker Compose** | Entorno reproducible y portátil |
| **Makefile** | Automatización de tareas de administración |
| **Shell scripting** | Scripts de inicialización y backup |
| **GitHub** | Control de versiones y documentación |

---

## Entidades del modelo

El sistema gestiona **8 entidades principales** relacionadas entre sí:

| Entidad | Descripción |
|---|---|
| `pacientes` | Datos personales, documento, fecha de nacimiento, obra social |
| `odontologos` | Registro de profesionales del centro |
| `agendas` | Agendas de los profesionales con vigencia y disponibilidad |
| `horarios` | Horarios disponibles por profesional y consultorio |
| `consultorios` | Espacios físicos de atención con sus características |
| `servicios` | Prestaciones ofrecidas por el centro |
| `tipo_consulta` | Clasificación de atención (primera vez / seguimiento) |
| `citas` | Registro completo de turnos con estado, servicio y profesional |

---

## ⚙️ Objetos SQL implementados

### Vistas
- **`vista_citas_atendidas`** — Lista de citas por paciente ordenadas cronológicamente, con profesional asignado
- **`vista_horarios_inactivos`** — Detección de horarios sin actividad dentro de una agenda
- **`vista_atenciones_medico`** — Historial de atenciones por profesional ordenado por fecha

### Funciones
- **`f_citas_atendidas_por_servicio`** — Cantidad de citas en un rango de fechas para un servicio dado; retorna mensaje de error si no hay resultados
- **`f_citas_atendidas_paciente`** — Contador de atenciones por paciente para control de historial clínico
- **`f_horarios_disponibles_agendas`** — Listado de horarios activos para una agenda; alerta si no hay disponibilidad

### Stored Procedures
- **`sp_crear_nuevo_paciente`** — Alta de paciente con validación de datos
- **`sp_cambiar_estado_cita`** — Actualización de estado de turno con control de valores inválidos
- **`sp_buscar_paciente`** — Búsqueda por número de documento con manejo de errores

### Triggers
- **`registro_cambios_agenda`** — Auditoría automática de cambios de estado en agendas (activa/inactiva), con registro de fecha y estado anterior
- **`validar_fecha_nacimiento`** — Validación de que la fecha de nacimiento no supere la fecha actual al insertar un paciente
- **`evitar_eliminar_pacientes_con_citas`** — Integridad referencial: bloquea la eliminación de pacientes con citas asociadas

### Roles y usuarios

| Usuario | Rol | Permisos |
|---|---|---|
| `admision` | `gestion_agendas` | CRUD completo sobre todas las tablas |
| `medico` | `visor_agendas` | Solo lectura (SELECT) sobre tablas y vistas |
| `superusuario` | `administrador_bbdd` | Acceso total a tablas, objetos y configuración |

---

## Cómo ejecutar el proyecto

### Requisitos previos
- Docker Desktop instalado
- Make instalado (Linux/Mac nativo; Windows: instalar via Chocolatey)

### Pasos

```bash
# 1. Clonar el repositorio
git clone https://github.com/Luz-88/Proyecto-Final-CoderHouse_Luz_Ruiz.git
cd Proyecto-Final-CoderHouse_Luz_Ruiz

# 2. Levantar el entorno (MySQL en Docker)
make
# Si da error de conexión al socket, volver a ejecutar: make

# 3. Comandos disponibles
make access-db     # Acceder a la base de datos
make test-db       # Visualizar datos de todas las tablas
make backup-db     # Generar backup de la base de datos
make clean-db      # Limpiar la base de datos
```

---

## Estructura del repositorio

```
├── structure/          # Scripts DDL: creación de tablas y relaciones
├── objects/            # Scripts de vistas, funciones, SPs y triggers
├── backups/            # Backups generados automáticamente
├── docker-compose.yml  # Configuración del entorno Docker
├── Makefile            # Automatización de tareas de administración
├── wait_docker.sh      # Script de inicialización del contenedor
└── .env                # Variables de entorno (credenciales locales)
```

---

## Contexto y decisiones de diseño

Este proyecto fue diseñado pensando en los desafíos reales de un sistema de salud:

- **Integridad de datos:** los triggers garantizan que no se creen registros inválidos ni se eliminen datos con dependencias activas
- **Auditoría:** el trigger de auditoría de agendas permite rastrear cambios de estado en el tiempo, un requisito común en entornos regulados
- **Separación de roles:** el modelo de usuarios simula un entorno de producción real con acceso diferenciado por perfil (admisión, profesional, administrador)
- **Portabilidad:** Docker permite que cualquier desarrollador levante el entorno sin configuración manual del motor

---

## 👩‍💻 Sobre la autora

**Luz Emily Ruiz Neiva**
Analista IT con más de 6 años de experiencia en soporte de sistemas de salud (HIS/ERP), bases de datos (SQL Server, Oracle) e integraciones HL7. Actualmente en transición hacia roles de Cloud Support Engineer con foco en AWS.

🔗 [LinkedIn](https://www.linkedin.com/in/luzruizn)

---

*Proyecto desarrollado como entrega final del curso SQL en Coderhouse — Comisión 53180*
