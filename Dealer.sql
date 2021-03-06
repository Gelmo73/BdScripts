CREATE DATABASE Dealer

GO

USE Dealer

GO

CREATE TABLE Marca (
IdMarca INT PRIMARY KEY IDENTITY(1,1),
NombreMarca NVARCHAR(20) NOT NULL
)

GO

CREATE TABLE Provincia (
IdProvincia INT PRIMARY KEY IDENTITY(1,1),
NombreProvincia NVARCHAR(30) NOT NULL
)

GO

CREATE TABLE Ciudad (
IdCiudad INT PRIMARY KEY IDENTITY(1,1),
NombreCiudad NVARCHAR(30) NOT NULL,
IdProvincia INT NOT NULL,
-----LLAVES FORANEAS
FOREIGN KEY (IdProvincia) REFERENCES Provincia(IdProvincia)
)

GO

CREATE TABLE Sector (
IdSector INT PRIMARY KEY IDENTITY(1,1),
NombreSector NVARCHAR(30) NOT NULL,
IdCiudad INT NOT NULL,
-----LLAVES FORANEAS
FOREIGN KEY (IdCiudad) REFERENCES Ciudad(IdCiudad)
)

GO

CREATE TABLE Modelo (
IdModelo INT PRIMARY KEY IDENTITY(1,1),
NombreModelo NVARCHAR(15) NOT NULL,
IdMarca INT NOT NULL,
-----LLAVES FORANEAS
FOREIGN KEY (IdMarca) REFERENCES Marca(IdMarca)
)

GO

CREATE TABLE Vehiculo (
Matricula NVARCHAR(7) PRIMARY KEY,
Color NVARCHAR(15) NOT NULL,
IdModelo INT NOT NULL,
-----LLAVES FORANEAS
FOREIGN KEY (IdModelo) REFERENCES Modelo(IdModelo)
)

GO 

CREATE TABLE Persona (
IdPersona INT PRIMARY KEY IDENTITY(1,1),
Cedula NVARCHAR(11) UNIQUE NOT NULL,
Nombre NVARCHAR(25) NOT NULL,
Apellido NVARCHAR(25) NOT NULL,
Calle NVARCHAR(15) NOT NULL,
Casa NVARCHAR(15) NOT NULL,
IdSector INT NOT NULL,
-----LLAVES FORANEAS
FOREIGN KEY (IdSector) REFERENCES Sector(IdSector)
)

GO

CREATE TABLE Telefono (
Telefono VARCHAR(15) PRIMARY KEY NOT NULL,
IdPersona INT NOT NULL,
FOREIGN KEY (IdPersona) REFERENCES Persona(IdPersona)
)

GO

CREATE TABLE Acciedente (
Referencia INT PRIMARY KEY IDENTITY (1,1),
Fecha DATE NOT NULL,
Hora TIME NOT NULL,
Calle NVARCHAR(20) NOT NULL,
Sector INT NOT NULL,
FOREIGN KEY (Sector) REFERENCES Sector(IdSector)
)

GO

CREATE TABLE MULTA (
Referencia INT PRIMARY KEY IDENTITY(1,1),
Matricula NVARCHAR(7) NOT NULL,
IdPersona INT NOT NULL,
Fecha DATE NOT NULL,
Hora TIME NOT NULL,
Calle NVARCHAR(20) NOT NULL,
Sector INT NOT NULL,
FOREIGN KEY (Sector) REFERENCES Sector(IdSector),
FOREIGN KEY (Matricula) REFERENCES Vehiculo(Matricula),
FOREIGN KEY (IdPersona) REFERENCES Persona(IdPersona)
)

GO

CREATE TABLE PersonaAccidentada (
IdPersona INT NOT NULL,
ReferenciaAccidente INT NOT NULL,
PRIMARY KEY(IdPersona, ReferenciaAccidente),
FOREIGN KEY (IdPersona) REFERENCES Persona(IdPersona),
FOREIGN KEY (ReferenciaAccidente) REFERENCES Acciedente(Referencia)
)

GO

CREATE TABLE VehiculoAccidentada (
Matricula NVARCHAR(7) NOT NULL,
ReferenciaAccidente INT NOT NULL,
PRIMARY KEY(Matricula, ReferenciaAccidente),
FOREIGN KEY (Matricula) REFERENCES Vehiculo(Matricula),
FOREIGN KEY (ReferenciaAccidente) REFERENCES Acciedente(Referencia)
)

GO

CREATE TABLE VehiculoPersona (
Matricula NVARCHAR(7),
IdPersona INT,
PRIMARY KEY(Matricula, IdPersona),
-----LLAVES FORANEAS
CONSTRAINT FK_Compuesto_Persona FOREIGN KEY (IdPersona) REFERENCES Persona(IdPersona),
CONSTRAINT FK_Compuesto_Vehiculo FOREIGN KEY (Matricula) REFERENCES Vehiculo(Matricula)
)