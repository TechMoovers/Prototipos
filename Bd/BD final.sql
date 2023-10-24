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

INSERT INTO usuario VALUES
(null, 'Friboi', 'friboi@gmail.com', 'Friboi47', 1),
(null, 'Uboi', 'uboi@gmail.com', 'uboi1547','2');

select nomeUsuario as 'Nome', emailUsuario as 'Email', FkCliente as 'Empresa' from clienteEmpresa join usuario on idCliente = FkCliente;

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

select Especie.especieBovino as 'Especie', QtdBois as 'Quantos Bovinos' from Boi join Especie on idEspecie = FkEspecie; 

-- select*from Boi join clienteEmpresa  on idCliente = FkCliente;
select clienteEmpresa.idCliente as 'ID Cliente', razaoSocial as 'Razão Social', 
nomeFantasia as 'Fantasia', cnpj as 'CNPJ', QtdBois as 'Número de Bovinos' from Boi join clienteEmpresa on idCliente = FkCliente;

DESCRIBE Especie;

create table Caminhao ( 
idTransp int primary key auto_increment,
TipoCarroceria varchar(40),
QtdBovinos int,
placaVeiculo char(7),
fkEspecie int,
fkCliente int,
fkDadosSens int,
constraint FkEspe foreign key (FkEspecie)
references Especie  (idEspecie),
constraint fkClint foreign key (fkCliente)
references clienteEmpresa (idCliente)
);

insert into Caminhao values
(null,'fechada','50','hju5478','1','1','1'),
(null,'Aberta', '40','fhu4785','2','2','2');

describe Caminhao;
 
-- select * from Caminhao join Especie on idEspecie = FkEspecie;

select Caminhao.TipoCarroceria as 'Tipo da Carroceria', placaVeiculo as 'Placa do Veiculo', QtdBovinos as 'Bovinos',
especieBovino as 'Espécie', temperaturaIdealEspecie as 'Temperatura Ideal' from Especie join Caminhao on idTransp = FkEspecie;

 
-- select * from Caminhao join clienteEmpresa on idCliente = FkCliente join Especie on idEspecie = FkEspecie;

select Caminhao.TipoCarroceria as 'Tipo da Carroceria', placaVeiculo as 'Placa do Veiculo',  idCliente as 'ID Cliente', razaoSocial as 
'Razão Social', nomeFantasia as 'Fantasia', cnpj as 'CNPJ', especieBovino as 'Espécie', temperaturaIdealEspecie as 
'Temperatura Ideal' from Especie join Caminhao join clienteEmpresa on idTransp = FkEspecie;


create table DadosSensores(
idDados int primary key auto_increment,
umidade decimal,
temperatura decimal,
horario DATETIME default current_timestamp,
fkCaminhao int,
constraint fktransp foreign key (fkCaminhao) 
references Caminhao (idTransp)
);

alter table DadosSensores add column diaRegistro DATE;
select * from DadosSensores;

insert into DadosSensores values
(null,'25','10','2023-05-10 20:37','1','2023-10-23'),
(null,'22','35','2023-05-10 20:35','2','2023-10-24');

alter table Caminhao add constraint fkDadoSens foreign key (fkDadosSens)
references DadosSensores (idDados);

-- select * from DadosSensores join caminhao on idTransp = fkCaminhao;
select DadosSensores.idDados as 'ID Dados', umidade as 'Umidade', temperatura as 'Temperatura', horario as 'Horário', diaRegistro as 'Dia do Registro', idTransp as 'ID Transporte', TipoCarroceria as 'Tipo Carroceria', QtdBovinos as 'Quantidades de Bovinos', placaVeiculo as 'Placa do Veículo' from Caminhao join DadosSensores on idDados = fkCaminhao;   
								