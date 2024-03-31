SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' ORDER BY apellido1 DESC, apellido2 DESC, nombre DESC;
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' AND telefono IS NULL;
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999 ;
SELECT nombre, apellido1, apellido2, telefono, NIF FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND NIF LIKE '%K';
SELECT * FROM universidad.asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;
SELECT d.nombre, p.apellido1, p.apellido2, p.nombre FROM persona p INNER JOIN profesor pr ON pr.id_profesor = p.id INNER JOIN departamento d ON pr.id_departamento = d.id ORDER BY p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC;
SELECT a.nombre, ce.anyo_inicio, ce.anyo_fin FROM asignatura a INNER JOIN alumno_se_matricula_asignatura  asm ON a.id = asm.id_asignatura INNER JOIN curso_escolar ce ON asm.id_asignatura = ce.id INNER JOIN persona p ON p.id = asm.id_alumno WHERE p.nif = '26902806M';
SELECT DISTINCT d.nombre AS nombre_departamento FROM departamento d INNER JOIN profesor pr ON pr.id_departamento = d.id INNER JOIN asignatura a ON a.id = pr.id_profesor INNER JOIN grado g ON g.id = a.id_grado WHERE g.nombre = ' Grau en Enginyeria Informàtica (Pla 2015)' or a.id_profesor IS NOT NULL;
SELECT DISTINCT p.nombre, p.apellido1, p.apellido2 FROM persona p INNER JOIN alumno_se_matricula_asignatura asm ON asm.id_alumno = p.id INNER JOIN curso_escolar ce ON ce.id = asm.id_curso_escolar WHERE ce.anyo_inicio = 2018 AND ce.anyo_fin = 2019;

/*LEFT JOIN / RIGHT JOIN*/

SELECT d.nombre, CONCAT(p.nombre, ' ' , p.apellido1, ' ', p.apellido2) AS nombre_profesor FROM persona AS p LEFT JOIN profesor AS pr ON p.id = pr.id_profesor LEFT JOIN departamento AS d ON d.id = pr.id_departamento ORDER BY d.nombre DESC, p.apellido1 DESC, p.apellido2, p.nombre;
SELECT CONCAT(p.nombre, ' ' , p.apellido1, ' ', p.apellido2) AS nombre_profesor, pr.id_departamento AS id_departamento FROM persona AS p RIGHT JOIN profesor AS pr ON pr.id_profesor = p.id WHERE pr.id_departamento IS NULL;
SELECT departamento.nombre AS nombre_departamento FROM departamento LEFT JOIN profesor ON profesor.id_departamento = departamento.id WHERE profesor.id_departamento IS NULL;
SELECT DISTINCT CONCAT(p.nombre, ' ', p.apellido1, ' ', p.apellido2) AS nombre_profesor FROM persona AS p LEFT JOIN profesor AS pr ON p.id = pr.id_profesor LEFT JOIN asignatura AS a ON a.id_profesor = pr.id_profesor  WHERE a.id IS NOT NULL AND p.tipo = 'profesor';
SELECT asignatura.nombre AS nomre_asignatura FROM asignatura LEFT JOIN persona ON asignatura.id_profesor = persona.id WHERE id_profesor IS NULL;
SELECT DISTINCT d.nombre AS nombre_departamento FROM departamento d LEFT JOIN profesor p ON p.id_departamento = d.id LEFT JOIN asignatura AS a ON a.id_profesor = p.id_profesor LEFT JOIN curso_escolar AS c ON c.id = a.curso WHERE a.curso IS NULL;

/*Consultes resum. */

SELECT COUNT(tipo) AS numero_alumnos FROM persona WHERE tipo = 'alumno';
SELECT COUNT(tipo) AS alumnos_1999 FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;
SELECT d.nombre AS nombre_departamento, COUNT(pr.id_profesor) AS numero_profesores FROM departamento d INNER JOIN profesor pr ON pr.id_departamento = d.id GROUP BY d.nombre ORDER BY numero_profesores DESC;
SELECT d.nombre, COUNT(pr.id_profesor) AS num_profesores FROM departamento d LEFT JOIN profesor pr ON d.id = pr.id_departamento GROUP BY d.nombre;
SELECT g.nombre, COUNT(a.id) AS num_asignaturas FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre ORDER BY num_asignaturas DESC;
SELECT g.nombre, COUNT(a.id) AS num_asignaturas FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre HAVING COUNT(a.id) > 40 ORDER BY num_asignaturas DESC;
SELECT g.nombre AS nombre_grado, a.tipo AS tipo_asignatura, SUM(a.creditos) AS total_creditos FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre, a.tipo;
SELECT ce.anyo_inicio AS anyo_inicio_curso, COUNT(DISTINCT asm.id_alumno) AS num_alumnos_matriculados FROM curso_escolar ce LEFT JOIN alumno_se_matricula_asignatura asm ON ce.id = asm.id_curso_escolar GROUP BY ce.anyo_inicio ORDER BY ce.anyo_inicio;
SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) AS numero_asignaturas FROM persona p LEFT JOIN profesor pr ON pr.id_profesor = p.id LEFT JOIN asignatura a ON p.id = a.id_profesor WHERE p.tipo = 'profesor' GROUP BY p.id, p.nombre, p.apellido1, p.apellido2 ORDER BY numero_asignaturas DESC;
SELECT CONCAT (nombre, ' ', apellido1, ' ', apellido2) AS alumno_mas_joven FROM persona WHERE tipo = 'alumno' ORDER BY fecha_nacimiento DESC LIMIT 1;
SELECT CONCAT(p.nombre, ' ', p.apellido1, ' ', p.apellido2) AS nombre_profesor FROM persona p INNER JOIN profesor pr ON p.id = pr.id_profesor INNER JOIN departamento  d ON pr.id_departamento = d.id LEFT JOIN asignatura  a ON pr.id_profesor = a.id_profesor WHERE a.id IS NULL;
