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
ID  int unique , 
Usuariocod int,



Foreign key(Usuariocod) references Usuario(cod)


)
GO

Create table  Jogo_Biblioteca(
JogoID int ,
BibliotecaID int ,
dataAdicao date

primary key(BibliotecaID),

FOREIGN KEY(JogoID) REFERENCES Jogo(ID),

)
go 

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


GO
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


Select* 
from jogo

Select*
from Usuario

Select* 
from Biblioteca

Select* 
from Jogo_Biblioteca

Select* 
from Desenvolvedora

select*
from Desenvolvedora_Jogo

select*
from Compra

select*
from ItemCompra

select*
from Publicadora

select *
from Publicadora_Jogo


--------------------------------------------------Consultas:-----------------------------------------------------------------------------
--Consultando:
------  Quantos genêros de jogos  tem disponível nos jogos propostos pela desenvolvedora?

select  deva.Nome as Desenvolvedora, jogo.Nome,count(genjog.GeneroID) as qtd_generos

from jogo left outer join Genero_Jogo genjog 
on jogo.ID = genjog.JogoID
left outer join Desenvolvedora_Jogo devjog
on genjog.JogoID = devjog.DesenvolvedoraID
inner join Desenvolvedora deva
on devjog.DesenvolvedoraID = deva.Nome

group by jogo.Nome,genjog.GeneroID,devjog.DesenvolvedoraID,deva.Nome,genjog.JogoID , jogo.ID

----------------------------------------------------------------------------------------------------------------------------------------
--Consultando:
--------  Quantas bibliotecas o jogo tem disponível para uso , e quais são suas respectivas datas de adições das bibliotecas ao jogo   

select jogo.Nome as Jogo , Count(Jog.BibliotecaID) , jog.dataAdicao
from jogo inner join Jogo_Biblioteca jog
on jogo.ID = jog.JogoID

group by Jogo.ID,jogo.Nome,Jog.BibliotecaID

-----------------------------------------------------------------------------------------------------------------------------------------
--Consultando:
-- Quantos Usuários temos nos jogos

select  jogo.Nome as Jogo, Count(Usu.Nome) as Usuário
from Usuario Usu inner join Biblioteca bibli
on Usu.cod = bibli.Usuariocod
left outer join Jogo_Biblioteca
on 
bibli.ID = Jogo_Biblioteca.BibliotecaID
inner join jogo
on Jogo_Biblioteca.JogoID = jogo.ID

group by Usu.Nome , Usu.cod , bibli.Usuariocod,bibli.ID , Jogo_Biblioteca.BibliotecaID,jogo.ID, jogo.Nome


-------------------------------------------------------------------------------------------------------------------------------------------------
--Consultando:
-- Qual a quantidade total de compras que foram efetuadas ,junto as suas datas, de jogos pelos usuários ordenando do maior para o menor? 

select usu.Nome ,jogo.Nome , sum(ic.CompraID) as quantidade_total_comprada,comp.dataCompra  
from Usuario usu left outer join Compra comp
on usu.cod = comp.Usuariocod
inner join ItemCompra ic
on comp.ID = ic.ID
left outer join jogo
on ic.JogoID = jogo.ID

GROUP BY usu.cod, usu.Nome ,jogo.Nome , ic.CompraID ,comp.dataCompra ,comp.Usuariocod ,ic.ID ,ic.JogoID , jogo.ID
order by ic.CompraID desc

--------------------------------------------------------------------------------------------------------------------------------------------------------
--Consultando:

-- Qual a quantidade total de compras que foram efetuadas ,junto as suas datas,
-- de jogos pelos usuários ordenando do menor para o maior , 
-- destacando o maior e o menor valor de compra, 
-- e o maior e o menor valor de item comprado 
-- Junto a todas as suas datas de compra seja item de compra , ou a compra em si.

select usu.Nome as Usuario ,jogo.Nome as Jogo, sum(ic.CompraID) as quantidade_total_comprada, 
max(comp.ID) as Maior_Valor_Compra, comp.dataCompra , min(comp.ID) AS Menor_Valor_Compra, 
comp.dataCompra , max(ic.CompraID) as Maior_valor_Item_Compra , comp.dataCompra ,
min(ic.CompraID) AS Menor_Valor_Item_Compra

from Usuario usu left outer join Compra comp
on usu.cod = comp.Usuariocod
inner join ItemCompra ic
on comp.ID = ic.ID
left outer join jogo
on ic.JogoID = jogo.ID

GROUP BY usu.cod, usu.Nome ,jogo.Nome , ic.CompraID ,comp.dataCompra ,comp.Usuariocod ,ic.ID ,ic.JogoID , jogo.ID
order by ic.CompraID asc 




