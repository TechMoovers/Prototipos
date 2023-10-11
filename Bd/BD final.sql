CREATE DATABASE bdPrototipoPi;
USE bdPrototipoPi;

CREATE TABLE clienteEmpresa(
	idCliente INT PRIMARY KEY AUTO_INCREMENT,
    razaoSocial VARCHAR(50),
    nomeFantasia VARCHAR(50),
    cnpj CHAR(14)
);

INSERT INTO clienteEmpresa VALUES 
(null, 'JBS S/A', 'Friboi', '02916265004076'),
(null, 'Transporte de gado JBS','Uboi', '02916265000160');

select * from clienteEmpresa;

CREATE TABLE usuario (
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nomeUsuario VARCHAR(50),
    emailUsuario VARCHAR(50),
    senhaUsuario char (8),
	FkCliente INT,
    constraint fkcli FOREIGN KEY (FkCliente) REFERENCES clienteEmpresa (idCliente)
);

select*from clienteEmpresa join usuario on idCliente = FkCliente;

INSERT INTO usuario VALUES
(null, 'Friboi', 'friboi@gmail.com', 'Friboi47', 1),
(null, 'Uboi', 'uboi@gmail.com', 'uboi1547','2');

select * from usuario;

DESCRIBE usuario;

CREATE TABLE Especie (
	idEspecie INT PRIMARY KEY AUTO_INCREMENT,
    especieBovino VARCHAR(20),
    temperaturaIdealEspecie DECIMAL,
    CONSTRAINT chkEspecieBovino CHECK (especieBovino IN ('Nelore', 'Angus', 'Brahman', 'Brangus', 'Senepol', 'Hereford'))
    
);



INSERT INTO Especie VALUES
(null, 'Nelore', 21),
(null,'Angus', 22);

select * from Especie;

create table Boi (
idBoi int primary key auto_increment,
QtdBois int,
FkCliente int,
FkEspecie int,
constraint FkEsp foreign key (FkEspecie)
references Especie  (idEspecie),
constraint fkClient foreign key (fkCliente)
references clienteEmpresa (idCliente)
);

insert into Boi values
(null, 40 , '1','1'),
(null, 30 ,'2','2');

select * from Boi;

DESCRIBE Especie;

create table Caminhao (
idTransp int primary key auto_increment,
TipoCarroceria varchar(40),
QtdBovinos int,
placaVeiculo char(7),
fkEspecie int,
fkCliente int,
fkSensores int,
constraint FkEspe foreign key (FkEspecie)
references Especie  (idEspecie),
constraint fkClint foreign key (fkCliente)
references clienteEmpresa (idCliente)
);

insert into Caminhao values
(null,'fechada','50','hju5478','1','1','1'),
(null,'Aberta', '40','fhu4785','1','1','1');

alter table Caminhao add constraint fkSenso foreign key (fkSensores)
references Sensores (idSensor);

 describe Caminhao;
 
 create TABLE Sensores (
	idSensor INT PRIMARY KEY AUTO_INCREMENT,
    temperaturaSensor DECIMAL, 
    umidadeSensor DECIMAL,
    horario DATETIME default current_timestamp,
    fkCaminhao int,
    constraint fktransp foreign key (fkCaminhao) 
    references Caminhao (idTransp)
);


insert into Sensores values
(null,'30','20','2023-03-14 20:19:17','1'),
(null,'20','15','2023-04-15 20:35:00','2');


create table DadosAnteriores(
idDados int primary key auto_increment,
umidade decimal,
temperatura decimal,
horario DATETIME default current_timestamp,
fkSensores int,
constraint fkSens foreign key (fkSensores)
references Sensores (idSensor)
);

insert into DadosAnteriores values
(null,'25','10','2023-05-10 20:37','1'),
(null,'22','35','2023-05-10 20:35','2');







drop database bdprototipopi;