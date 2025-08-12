use sakila;

-- 1 ------------

create table employees (
    employeeNumber int primary key,
    lastName varchar(50) not null,
    firstName VARCHAR(50) not null,
    email varchar(100) not nullL,
    age int,
    lastUpdate datetime,
    lastUpdateUser varchar(50)
);


insert into employees (lastName, firstName, email, age)
values
('Juarez', 'Pepito', 'PJuarez@gmail.com', 30),
('Nico', 'Pagani', 'nicopagani@gmail.com', 25);	

insert into employees (lastName, firstName, email, age)
values ('Perez', 'Luis', NULL, 28);

-- Si la columna email está definida como NOT NULL (como en el ejemplo que puse), MySQL tira un error:

-- 2 -------------

	-- UPDATE employees SET employeeNumber = employeeNumber - 20;
	
	-- Esto resta 20 a todos los employeeNumber.
	-- Si employeeNumber es clave primaria, se podria:
	-- Romper el orden secuencial.
	-- Generar conflictos si el valor ya existe.
	-- Incluso provocar error si la PK pierde unicidad.

	

	-- UPDATE employees SET employeeNumber = employeeNumber + 20;
	-- Esto suma 20 a todos los employeeNumber.
	-- Puede dejar huecos en la numeración, pero no genera error.
    -- En la práctica, modificar una PK así no es buena idea porque rompe referencias en otras tablas.


-- 3 -------------

alter table employees
modify age int check (age between 16 and 70);

-- 4 -------------
-- film: almacena datos de películas (film_id PK).
-- actor: almacena datos de actores (actor_id PK).
-- film_actor: es una tabla intermedia (muchos a muchos) con:
-- film_id (FK = film.film_id)
-- actor_id (FK → actor.actor_id)
-- La integridad referencial nos asegura que:
-- No se pueda asociar un actor a una película que no exista.
-- No se pueda borrar un actor/película sin borrar primero su relación en film_actor (o usando ON DELETE CASCADE si estuviera definido).


-- 5 -------------

alter table employees
add lastUpdate datetime default now(),
add lastUpdateUser varchar(50);

-- trigger para insert
create trigger employees_before_insert
before insert on employees
for each row
begin
    set new.lastUpdateUser = CURRENT_USER();
end;
-- trigger para update
create trigger employees_before_update
before insert on employees
for each row
begin
    set new.lastUpdateUser = CURRENT_USER();
end;

-- 6 -------------

show triggers from sakila like 'film_text'
