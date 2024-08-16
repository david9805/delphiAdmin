create database empleados;

create table dependencias(
 id int auto_increment primary key,
 nombreDependencia varchar(100)
);

create table empleados(
	id int auto_increment primary key,
    identificacion int unique,
    nombres varchar(100) not null,
    apellidos varchar(100) not null,
    cargo varchar(50) not null,
    fkDependencia int,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY(fkDependencia) REFERENCES dependencias(id)
);
insert into dependencias(nombreDependencia) values('Recursos Humanos'),('Sistemas'),('Dirección');

INSERT INTO empleados (identificacion, nombres, apellidos, cargo, fkDependencia)
VALUES
(1001, 'Juan', 'Pérez', 'Reclutador', 1),         
(1002, 'Ana', 'García', 'Desarrolladora Frontend', 2), 
(1003, 'Luis', 'Martínez', 'Director de Proyectos', 3),
(1004, 'Laura', 'Rodríguez', 'Especialista en Capacitación', 1),
(1005, 'Carlos', 'Hernández', 'Administrador de Sistemas', 2); 
