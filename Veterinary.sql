CREATE SCHEMA [vet]
GO

CREATE TABLE [vet].[firma] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [nume_firma] nvarchar(255),
  [surname] nvarchar(255),
  [first_name] nvarchar(255),
  [addres] nvarchar(255),
  [owner_phone] nvarchar(255),
  [owner_email] nvarchar(255)
)
GO

CREATE TABLE [vet].[sediu] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_firma] int,
  [addres] nvarchar(255),
  [capacitate_animale] int
)
GO

CREATE TABLE [vet].[owner] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [surname] nvarchar(255),
  [first_name] nvarchar(255),
  [addres] nvarchar(255),
  [owner_phone] nvarchar(255),
  [owner_email] nvarchar(255)
)
GO

CREATE TABLE [vet].[client] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_owner] int,
  [name] nvarchar(255),
  [sterilizare] boolean
)
GO

CREATE TABLE [vet].[employee] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_sediu] int,
  [nume_firma] nvarchar(255),
  [surname] nvarchar(255),
  [first_name] nvarchar(255),
  [addres] nvarchar(255),
  [owner_phone] nvarchar(255),
  [owner_email] nvarchar(255),
  [employee_type] Enum
)
GO

CREATE TABLE [vet].[doctor] (
  [id_employee] int,
  [valori_de_adaugat] nvarchar(255)
)
GO

CREATE TABLE [vet].[receptionist] (
  [id_employee] int,
  [valori_de_adaugat] nvarchar(255)
)
GO

CREATE TABLE [vet].[treatment] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [valori_de_adaugat] nvarchar(255)
)
GO

CREATE TABLE [vet].[InsertName] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_treatment] int,
  [id_medicine] int
)
GO

CREATE TABLE [vet].[medicine] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255),
  [producer] nvarchar(255)
)
GO

CREATE TABLE [vet].[appointment] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_doctor] int,
  [id_client] int,
  [id_treatment] int,
  [appointment_type] Enum,
  [needs_cage] boolean,
  [valori_de_adaugat] nvarchar(255)
)
GO

CREATE TABLE [vet].[fisa_medicala] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_appointment] int,
  [id_client] int,
  [valori_de_adaugat] nvarchar(255)
)
GO

CREATE TABLE [vet].[surgery] (
  [id_appointment] int PRIMARY KEY IDENTITY(1, 1),
  [id_cage] int,
  [valori_de_adaugat] nvarchar(255)
)
GO

CREATE TABLE [vet].[cage_schedule] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_cage] int,
  [id_surgery] int,
  [timp_start] datetime,
  [timp_sfarsit] datetime
)
GO

CREATE TABLE [vet].[cage] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [capacitate] nvarchar(255),
  [valori_de_adaugat] nvarchar(255)
)
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'cand este sterilizat',
@level0type = N'Schema', @level0name = 'vet',
@level1type = N'Table',  @level1name = 'client',
@level2type = N'Column', @level2name = 'sterilizare';
GO

ALTER TABLE [vet].[sediu] ADD FOREIGN KEY ([id_firma]) REFERENCES [vet].[firma] ([id])
GO

ALTER TABLE [vet].[client] ADD FOREIGN KEY ([id_owner]) REFERENCES [vet].[owner] ([id])
GO

ALTER TABLE [vet].[employee] ADD FOREIGN KEY ([id_sediu]) REFERENCES [vet].[sediu] ([id])
GO

ALTER TABLE [vet].[employee] ADD FOREIGN KEY ([id]) REFERENCES [vet].[doctor] ([id_employee])
GO

ALTER TABLE [vet].[InsertName] ADD FOREIGN KEY ([id_medicine]) REFERENCES [vet].[treatment] ([id])
GO

ALTER TABLE [vet].[InsertName] ADD FOREIGN KEY ([id_medicine]) REFERENCES [vet].[medicine] ([id])
GO

ALTER TABLE [vet].[employee] ADD FOREIGN KEY ([id]) REFERENCES [vet].[receptionist] ([id_employee])
GO

ALTER TABLE [vet].[appointment] ADD FOREIGN KEY ([id_doctor]) REFERENCES [vet].[doctor] ([id_employee])
GO

ALTER TABLE [vet].[appointment] ADD FOREIGN KEY ([id_client]) REFERENCES [vet].[client] ([id])
GO

ALTER TABLE [vet].[appointment] ADD FOREIGN KEY ([id_treatment]) REFERENCES [vet].[treatment] ([id])
GO

ALTER TABLE [vet].[fisa_medicala] ADD FOREIGN KEY ([id_appointment]) REFERENCES [vet].[appointment] ([id])
GO

ALTER TABLE [vet].[fisa_medicala] ADD FOREIGN KEY ([id_client]) REFERENCES [vet].[client] ([id])
GO

ALTER TABLE [vet].[appointment] ADD FOREIGN KEY ([id]) REFERENCES [vet].[surgery] ([id_appointment])
GO

ALTER TABLE [vet].[cage_schedule] ADD FOREIGN KEY ([id_surgery]) REFERENCES [vet].[surgery] ([id_appointment])
GO

ALTER TABLE [vet].[cage_schedule] ADD FOREIGN KEY ([id_cage]) REFERENCES [vet].[cage] ([id])
GO
