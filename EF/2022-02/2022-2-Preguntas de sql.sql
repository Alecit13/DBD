--Diseñar el modelo físico de base de datos para la plataforma de Rueda de Negocios, identificando las principales tablas y sus respectivos atributos, las relaciones entre las tablas, las llaves primarias y llaves secundarias.
--Nota:
--• El modelo físico de base de datos puede ser realizado mediante la herramienta de su preferencia.
--• La solución también puede ser realizada a mano, sin embargo, deberá utilizar letra legible y gráficos debidamente detallados; las imágenes adjuntas deben ser nítidas.
create database Rueda_Negocios
go
use Rueda_Negocios
go

--Creacion de tablas
create table empresas_peruanas(
    RUC int not null,
    razon_social nvarchar(30) not null,
    ciudad nvarchar(20) not null,
    cantidad_empleados int not null,
    facturacion_promedio money not null,
    constraint PKempresas primary key (RUC)
)
go
create table empresas_peruanas_servicios(
    codigo_empresas int not null,
    servicios nvarchar(20) not null,
    descripcion nvarchar(100),
    constraint PKempresa_peruana_servicio primary key (codigo_empresas,servicios),
    constraint FKruc foreign key (codigo_empresas)references empresas_peruanas(RUC),
)
go

create table empresa_peruana_contactos(
    codigo_empresas int not null,
    codigo_contacto int not null,
    constraint PKempresa_peruana_servicio primary key (codigo_contacto,codigo_empresas),
    constraint FKempresa_peruana foreign key (codigo_empresas) references empresas_peruanas(RUC),
    constraint FKcontactos foreign key (codigo_contacto) references contactos(DNI)
)
go
create table empresas_peruana_clientes(
    codigo_empresa int not null,
    codigo_cliente int not null,
    constraint PKempresas_clientes primary key (codigo_cliente,codigo_empresa),
    constraint FKempresa foreign key (codigo_empresa) references empresas_peruanas(RUC),
    constraint FKclientes foreign key (codigo_cliente) references clientes(RUC)
)

go
create table contactos (
    DNI int not null,
    nombres nvarchar(40) not null,
    apellido_paterno nvarchar(20) not null,
    apellido_materno nvarchar(20) not null,
    puesto nvarchar(20) not null,
    telefono numeric not null,
    correo nvarchar(30) not null,
    constraint PKcontactos primary key (DNI)
)
go



create table clientes(
    RUC int not null,
    razon_social nvarchar(30) not null,
    serevicios_ejecutados nvarchar(30) not null,
    constraint PKclientes primary key (RUC)
)
go
create table empresas_extranjeras(
    RUC int not null,
    razon_social nvarchar(30) not null,
    pais nvarchar(20) not null,
    ciudad nvarchar(20) not null,
)
go
create table empresas_extranjeras_clientes(
    codigo_empresa int not null,
    codigo_cliente int not null,
    constraint PKempresa_extranjera_cliente primary key (codigo_cliente,codigo_empresa),
    constraint FKempresa foreign key (codigo_empresa) references empresas_extranjeras (RUC),
    constraint FKclientes foreign key (codigo_cliente) references clientes (RUC)
)
go
create table empresas_extranjeras_servicios(
    codigo_empresa int not null,
    servicio nvarchar(20) not null,
    descripcion nvarchar(100),
    constraint PKempresa_extranjera_servicio primary key (codigo_empresa,servicio),
    constraint FKempresa_extranjera foreign key (codigo_empresa) references empresas_extranjeras(RUC)
)
go
--Pregunta 2 (2 p.).
--Crear un procedimiento almacenado o función que retorne la cantidad de actores
-- que participaron en películas de un determinado género (ingresado como parámetro) para un
-- determinado año (ingresado como parámetro).
CREATE DATABASE MovieDB;

GO

USE MovieDB;

-- tables
-- Table: actors
CREATE TABLE actors (
    id int  NOT NULL,
    name varchar(100)  NOT NULL,
    gender char(1)  NOT NULL,
    CONSTRAINT actors_pk PRIMARY KEY  (id)
);

-- Table: directors
CREATE TABLE directors (
    id int  NOT NULL,
    name varchar(100)  NOT NULL,
    CONSTRAINT directors_pk PRIMARY KEY  (id)
);

-- Table: genres
CREATE TABLE genres (
    id int  NOT NULL,
    description varchar(50)  NOT NULL,
    CONSTRAINT genres_pk PRIMARY KEY  (id)
);

-- Table: movie_cast
CREATE TABLE movie_cast (
    actor_id int  NOT NULL,
    movie_id int  NOT NULL,
    role varchar(50)  NOT NULL,
    CONSTRAINT movie_cast_pk PRIMARY KEY  (actor_id,movie_id)
);

-- Table: movies
CREATE TABLE movies (
    id int  NOT NULL,
    title varchar(50)  NOT NULL,
    year int  NOT NULL,
    language varchar(50)  NOT NULL,
    duration int  NOT NULL,
    director_id int  NOT NULL,
    genre_id int  NOT NULL,
    CONSTRAINT movies_pk PRIMARY KEY  (id)
);

-- Table: ratings
CREATE TABLE ratings (
    reviewer_id int  NOT NULL,
    movie_id int  NOT NULL,
    stars int  NOT NULL,
    comment varchar(255)  NOT NULL,
    CONSTRAINT ratings_pk PRIMARY KEY  (reviewer_id,movie_id)
);

-- Table: reviewers
CREATE TABLE reviewers (
    id int  NOT NULL,
    name varchar(100)  NOT NULL,
    CONSTRAINT reviewers_pk PRIMARY KEY  (id)
);

-- foreign keys
-- Reference: movie_casting_actors (table: movie_cast)
ALTER TABLE movie_cast ADD CONSTRAINT movie_casting_actors
    FOREIGN KEY (actor_id)
    REFERENCES actors (id);

-- Reference: movie_casting_movies (table: movie_cast)
ALTER TABLE movie_cast ADD CONSTRAINT movie_casting_movies
    FOREIGN KEY (movie_id)
    REFERENCES movies (id);

-- Reference: movies_directors (table: movies)
ALTER TABLE movies ADD CONSTRAINT movies_directors
    FOREIGN KEY (director_id)
    REFERENCES directors (id);

-- Reference: movies_genres (table: movies)
ALTER TABLE movies ADD CONSTRAINT movies_genres
    FOREIGN KEY (genre_id)
    REFERENCES genres (id);

-- Reference: rating_movies (table: ratings)
ALTER TABLE ratings ADD CONSTRAINT rating_movies
    FOREIGN KEY (movie_id)
    REFERENCES movies (id);

-- Reference: rating_reviewers (table: ratings)
ALTER TABLE ratings ADD CONSTRAINT rating_reviewers
    FOREIGN KEY (reviewer_id)
    REFERENCES reviewers (id);

insert into genres(id, description) values(1, 'Drama');
insert into genres(id, description) values(2, 'Comedia');
insert into genres(id, description) values(3, 'Terror');
insert into genres(id, description) values(4, 'Ciencia ficción');
insert into genres(id, description) values(5, 'Musical');


insert into reviewers(id, name) values (1,'Luis Campos');
insert into reviewers(id, name) values (2,'Vilma Becerra');
insert into reviewers(id, name) values (3,'Julio Noriega');
insert into reviewers(id, name) values (4,'Marcos Rivera');
insert into reviewers(id, name) values (5,'Amanda Ruiz');
insert into reviewers(id, name) values (6,'Enrique Contreras');

insert into directors(id,name) values (1, 'Christopher Nolan')
insert into directors(id,name) values (2, 'Sofia Coppola')
insert into directors(id,name) values (3, 'Martin Scorsese')

insert into movies( id,year,title, language, duration, director_id, genre_id) values(1,2020,'Inception', 'English',120, 1,4)
insert into movies( id,year,title, language, duration, director_id, genre_id) values(2,1998,'Following', 'English',120, 1,4)
insert into movies( id,year,title, language, duration, director_id, genre_id) values(3,2000,'Memento', 'English',120, 1,4)
insert into movies( id,year,title, language, duration, director_id, genre_id) values(4,2003,'Lost in Translation', 'English',120, 2,1)
insert into movies( id,year,title, language, duration, director_id, genre_id) values(5,2003,'Somewhere', 'English',120, 2,1)
insert into movies( id,year,title, language, duration, director_id, genre_id) values(6,1999,'The Virgin Suicides', 'English',120, 2,1)
insert into movies( id,year,title, language, duration, director_id, genre_id) values(7,2003,'Casino', 'English',120, 3,1)
insert into movies( id,year,title, language, duration, director_id, genre_id) values(8,1980,'Raging Bull', 'English',120, 3,1)
insert into movies( id,year,title, language, duration, director_id, genre_id) values(9,2016,'Silence', 'English',120, 3,1)
insert into movies( id,year,title, language, duration, director_id, genre_id) values(10,2020,'Silence2', 'English',120, 3,4)


insert into ratings(reviewer_id, movie_id, stars, comment) values (1,1,3, 'Buena película')
insert into ratings(reviewer_id, movie_id, stars, comment) values (1,2,4, 'Excelentes actuaciones')
insert into ratings(reviewer_id, movie_id, stars, comment) values (2,1,4, 'Excelentes actuaciones')
insert into ratings(reviewer_id, movie_id, stars, comment) values (2,2,4, 'Excelentes actuaciones')
insert into ratings(reviewer_id, movie_id, stars, comment) values (3,1,5, 'Excelente')
insert into ratings(reviewer_id, movie_id, stars, comment) values (3,3,5, 'Excelente')
insert into ratings(reviewer_id, movie_id, stars, comment) values (3,4,5, 'Excelente')

insert into ratings(reviewer_id, movie_id, stars, comment) values (1,5,3, 'Buena película')
insert into ratings(reviewer_id, movie_id, stars, comment) values (1,6,4, 'Excelentes actuaciones')
insert into ratings(reviewer_id, movie_id, stars, comment) values (2,5,4, 'Excelentes actuaciones')
insert into ratings(reviewer_id, movie_id, stars, comment) values (2,6,4, 'Excelentes actuaciones')
insert into ratings(reviewer_id, movie_id, stars, comment) values (3,5,5, 'Excelente')
insert into ratings(reviewer_id, movie_id, stars, comment) values (3,6,5, 'Excelente')
insert into ratings(reviewer_id, movie_id, stars, comment) values (3,7,5, 'Excelente')

insert into ratings(reviewer_id, movie_id, stars, comment) values (4,5,5, 'Excelente')
insert into ratings(reviewer_id, movie_id, stars, comment) values (4,6,5, 'Excelente')
insert into ratings(reviewer_id, movie_id, stars, comment) values (5,6,3, 'Buena película')
insert into ratings(reviewer_id, movie_id, stars, comment) values (5,5,4, 'Excelentes actuaciones')
insert into ratings(reviewer_id, movie_id, stars, comment) values (6,6,4, 'Excelentes actuaciones')
insert into ratings(reviewer_id, movie_id, stars, comment) values (6,7,4, 'Excelentes actuaciones')


insert into actors(id, name, gender) values(01,'alejandro','M')
insert into actors(id, name, gender) values(02,'fernando','M')


insert into movie_cast (actor_id, movie_id, role) values (1,1,'Prota')
insert into movie_cast (actor_id, movie_id, role) values(2,1,'Secundario')
insert into movie_cast (actor_id, movie_id, role) values(1,2,'Prota')
insert into movie_cast (actor_id, movie_id, role) values (1,10,'Prota')
go

select *
from movie_cast
-- End of file.
create view Actor_pelicula_genero as
select actor_id, movie_id,g.id, year from movie_cast
inner join movies m on movie_cast.movie_id = m.id
inner join genres g on m.genre_id = g.id

go
create procedure PRCActores_Por_Genero_Anio
@genero int,
@anio int,
@cantidad int output
as
begin
    set @cantidad=(select count(*) from Actor_pelicula_genero
                                   where id =@genero and year=@anio
                                          )
end
go

declare @can int
exec PRCActores_Por_Genero_Anio @genero = 4, @anio =2020, @cantidad =@can output
select @can


go

--Pregunta 3 (2 p.).
--Crear un procedimiento almacenado o función que retorne el nombre del actor (o actores) que
-- participó más veces en películas de un determinado género (ingresado como parámetro) para un
-- determinado año (ingresado como parámetro).

create view Actores_genero_anio as
select a.name,count(actor_id) as cantidad,g.id as genero,m.year
from movie_cast as mc
join actors as a on mc.actor_id = a.id
join movies m on mc.movie_id = m.id
join genres g on m.genre_id = g.id
group by g.id,a.name, m.year
go
create procedure PRCActores_genero_anio
@anio int,
@genero int,
@nombre varchar(100) output
as
begin
    set @nombre=(select name from Actores_genero_anio
                                 where cantidad=(select MAX(cantidad) from Actores_genero_anio
                                                                      where year=@anio and genero=@genero))
end

go
declare @nombr varchar(100)
exec PRCActores_genero_anio @anio = 2020, @genero = 4, @nombre = @nombr output
select @nombr
go

