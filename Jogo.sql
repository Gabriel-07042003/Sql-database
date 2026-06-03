use master
create database Jogo
go
use Jogo
go

Create table jogo(
ID int Check(ID>0),
Nome varchar(50),
dataLancamento date,
preco decimal(6,2),
espacoArmazenamento decimal(5,2),
descricaojogo varchar(255),
descricaoRequisitos varchar(255),


PRIMARY KEY(ID) 

)
go

CREATE TABLE Usuario(
cod int,
Nome varchar(50),
datanasc date ,
email varchar(100),
senha varchar(20),
telefone varchar(11) check(len(telefone)=10 or len(telefone) = 11)

primary key(cod)

)
go

CREATE TABLE Biblioteca(
ID int,
Usuariocod int

primary key(ID,Usuariocod), 
Foreign key (Usuariocod) references Usuario(cod)

)
GO
Create table Jogo_Biblioteca(
JogoID int,
BibliotecaID int,
dataAdicao date

Primary key(JogoID,BibliotecaID),

FOREIGN KEY(BibliotecaID) REFERENCES Biblioteca(ID),
FOREIGN KEY(JogoID) REFERENCES Jogo(ID)

)
GO

Create table Desenvolvedora(
ID int,
Nome varchar(100)

Primary key(ID)


)
GO
create table Desenvolvedora_Jogo (

DesenvolvedoraID int,
JogoID int

Primary key(DesenvolvedoraID,JogoID)
FOREIGN KEY (DesenvolvedoraID) references Jogo(ID),
FOREIGN KEY (JogoID) References Jogo(ID)

)
go

 create table Publicadora (
 ID int,
 Nome varchar(100)

 Primary key (ID)
	
)
GO

Create table Publicadora_Jogo(

PublicadoraID int,
JogoID int

Primary key (PublicadoraID,JogoID),
Foreign key (PublicadoraID) references Publicadora(ID),
Foreign key (JogoID) references Jogo(ID)

)
go

Create table Genero (
ID int,
Nome varchar(20)

Primary key(ID)
)
go

Create table Genero_Jogo(

GeneroID Int,
JogoID int

Primary key(GeneroID,JogoID)
Foreign key (GeneroID) references Genero(ID),
FOREIGN KEY (JogoID) references Jogo(ID)

)
go

CREATE TABLE Compra(
ID int,
dataCompra date,
Usuariocod int

Primary key(ID),
Foreign key(Usuariocod) references Usuario(cod)


)
go

Create table ItemCompra (
ID int,
JogoID int,
CompraID int

Primary key (ID,JogoID,CompraID)
Foreign key (JogoID) REFERENCES Jogo(ID),
FOREIGN KEY (CompraID) references Compra(ID)

)
GO


