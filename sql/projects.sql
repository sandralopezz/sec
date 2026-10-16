-- ============================================================
-- projects.sql — Examen de laboratorio IISSI-2 - Julio 2024
-- ============================================================
-- Este archivo crea la tabla Projects, una vista que hace JOIN
-- con Users para mostrar los datos del usuario asociado a cada
-- proyecto, e inserta datos de ejemplo para probar la aplicación.
-- ============================================================

-- Eliminamos la tabla si ya existe para poder recrearla limpia.
-- ON DELETE CASCADE significa que si se borra un usuario, sus proyectos
-- se borran automáticamente también.
DROP TABLE IF EXISTS Projects;

CREATE TABLE Projects (
    projectId    INT           NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userId       INT           NOT NULL,
    name         VARCHAR(256)  NOT NULL,
    description  VARCHAR(1000),
    projectLeader VARCHAR(256) NOT NULL,
    budget       INT           NOT NULL,
    startingDate DATE          NOT NULL,
    endingDate   DATE,
    imageUrl     VARCHAR(512),
    FOREIGN KEY (userId) REFERENCES Users(userId) ON DELETE CASCADE
);

-- ============================================================
-- Vista ProjectsWithUsers
-- ============================================================
-- Esta vista hace un JOIN entre Projects y Users para devolver
-- en una sola consulta los datos del proyecto junto con el
-- avatar, nombre de usuario y edad del usuario asociado.
-- El enunciado dice "puede usar la vista ya proporcionada en
-- el archivo sql", así que esta vista es la que usará Silence
-- para generar el módulo API _projectswithusers.js
-- ============================================================

CREATE OR REPLACE VIEW ProjectsWithUsers AS
    SELECT
        Projects.*,
        Users.username,
        Users.fullName,
        Users.avatarUrl,
        Users.city,
        Users.age
    FROM Projects
    JOIN Users ON Projects.userId = Users.userId;

-- ============================================================
-- Datos de ejemplo
-- ============================================================
-- Insertamos 5 proyectos de ejemplo.
-- IMPORTANTE: los userId (1, 2, 3) deben coincidir con usuarios
-- que ya existan en la tabla Users (creados por schema.sql).
-- projectLeader debe tener longitud > 0 y múltiplo de 5
-- (regla de validación del Ejercicio 2): "Admin" = 5 letras ✓
-- budget debe estar entre 1000 y 1000000 ✓
-- ============================================================

INSERT INTO Projects (userId, name, description, projectLeader, budget, startingDate, endingDate, imageUrl) VALUES
    (1, 'Smart City Platform',
        'Desarrollo de una plataforma integral para la gestión de servicios urbanos inteligentes, incluyendo transporte, energía y residuos.',
        'Admin',
        250000,
        '2024-01-15',
        '2025-06-30',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Camponotus_flavomarginatus_ant.jpg/400px-Camponotus_flavomarginatus_ant.jpg'),

    (1, 'EduTech Mobile App',
        'Aplicación móvil para la gestión de contenidos educativos, seguimiento de alumnos y comunicación entre profesores y familias.',
        'Laura',
        85000,
        '2023-09-01',
        '2024-12-31',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Biologia_Galleria_Laboratori_di_Fisica.jpg/400px-Biologia_Galleria_Laboratori_di_Fisica.jpg'),

    (2, 'HealthCare API',
        'API REST para la integración de sistemas hospitalarios con plataformas externas de seguros y laboratorios.',
        'Pedro',
        120000,
        '2024-03-10',
        NULL,
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/Above_Gotham.jpg/400px-Above_Gotham.jpg'),

    (2, 'Green Energy Dashboard',
        'Panel de control en tiempo real para monitorizar la producción y consumo de energías renovables en instalaciones industriales.',
        'Marta',
        45000,
        '2023-11-20',
        '2024-08-15',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/16/Dew_on_a_spider_web_Luc_Viatour.jpg/400px-Dew_on_a_spider_web_Luc_Viatour.jpg'),

    (3, 'Logistics Tracker',
        'Sistema de seguimiento de envíos y gestión de rutas para empresas de logística y transporte.',
        'Carlos',
        67500,
        '2024-02-01',
        '2024-11-30',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/PNG_transparency_demonstration_1.png/400px-PNG_transparency_demonstration_1.png');
