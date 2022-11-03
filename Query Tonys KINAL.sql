Drop database if exists  DBTonysKinal2020;
Create database DBTonysKinal2020;

Use DBTonysKinal2020;

Create table Empresas(	
	codigoEmpresa int auto_increment not null,
    nombreEmpresa varchar(150) not null,
    direccion varchar(150) not null,
    telefono varchar(10) not null,
    primary key PK_codigoEmpresa (codigoEmpresa)
);

Create table TipoEmpleado(
	codigoTipoEmpleado int not null auto_increment,
    descripcion varchar(50) not null,
    primary key PK_codigoTipoEmpleado (codigoTipoEmpleado)
);


Create table Empleados(
	codigoEmpleado int auto_increment not null,
    numeroEmpleado int not null,
    apellidosEmpleado varchar(150) not null,
    nombresEmpleado varchar(150) not null,
    direccionEmpleado varchar(150) not null,
    telefonoContacto varchar(10) not null,
    gradoCocinero varchar(50),
    codigoTipoEmpleado int not null,
    primary key PK_codigoEmpleado (codigoEmpleado),
    constraint FK_Empleados_TipoEmpleado foreign key 
		(codigoTipoEmpleado) references TipoEmpleado(codigoTipoEmpleado)
);


Create table TipoPlato(
	codigoTipoPlato int auto_increment not null,
    descripcionTipo varchar(100) not null,
    primary key PK_codigoTipoPlato(codigoTipoPlato)
);

Create table Productos(
	codigoProducto int not null,
    nombreProducto varchar(150) not null,
    cantidad int not null,
    primary key PK_codigoProducto (codigoProducto)
);

Create table Servicios(
	codigoServicio int auto_increment not null,
    fechaServicio date not null,
    tipoServicio varchar(150) not null,
    horaServicio time not null,
    lugarServicio varchar(150) not null,
    telefonoContacto varchar(10) not null,
    codigoEmpresa int not null,       
    primary key PK_codigoServicio (codigoServicio),
    constraint FK_Servicios_Empresas foreign key (codigoEmpresa) references Empresas(codigoEmpresa)    
);

Create table Presupuestos(
	codigoPresupuesto int auto_increment not null,
    fechaSolicitud date not null,
    cantidadPresupuesto decimal (10,2) not null,   
    codigoEmpresa int not null,    
    primary key PK_codigoPresupuesto (codigoPresupuesto),
    constraint FK_Presupuestos_Empresas foreign key (codigoEmpresa) references Empresas(codigoEmpresa)
);


Create table Platos(
	codigoPlato int auto_increment not null,
    cantidad int not null,
    nombrePlato varchar(50) not null,
    descripcionPlato varchar(150) not null,
    precioPlato decimal(10,2) not null,
    codigoTipoPlato int not null,
	-- TipoPlato_codigoTipoPlato int not null,
    primary key PK_codigoPlato (codigoPlato),
    constraint FK_Platos_TipoPlato1 foreign key (codigoTipoPlato) references TipoPlato(codigoTipoPlato)
);


Create table Productos_has_Platos(
	Productos_codigoProducto int not null,
    codigoPlato int not null,
    codigoProducto int not null,
    primary key PK_Productos_codigoProducto (Productos_codigoProducto),
    constraint FK_Productos_has_Platos_Productos1 foreign key (codigoProducto) references Productos(codigoProducto),
    constraint FK_Productos_has_Platos_Platos1 foreign key (codigoPlato) references Platos(codigoPlato)
);


Create table Servicios_has_Platos(
	Servicios_codigoServicio int not null,
    codigoPlato int not null,
    codigoServicio int not null,
    primary key PK_Servicios_codigoServicio (Servicios_codigoServicio),
    constraint FK_Servicios_has_Platos_Servicios1 foreign key (codigoServicio) references Servicios(codigoServicio),
    constraint FK_Servicios_has_Platos_Platos1 foreign key (codigoPlato) references Platos(codigoPlato)    
);

Create table Servicios_has_Empleados(
	Servicios_codigoServicio int not null,
    codigoServicio int not null,
    codigoEmpleado int not null,    
    fechaEvento date not null,
    horaEvento time not null,
    lugarEvento varchar(150) not null,
    primary key PK_Servicios_codigoServicio (Servicios_codigoServicio),
    constraint FK_Servicios_has_Empleados_Servicios1 foreign key (codigoServicio) references Servicios(codigoServicio),
    constraint FK_Servicios_has_Empleados_Empleados1 foreign key (codigoEmpleado) references Empleados(codigoEmpleado)
);


Use DBTonysKinal2020;

-- --------- Procedimientos almacenados Entidad Empresas ---------------------

-- Agregar Empresas----
Delimiter $$
	Create procedure sp_AgregarEmpresa (in nombreEmpresa varchar(150), in direccion varchar(150), in telefono varchar(10))
		Begin
			Insert into Empresas (nombreEmpresa, direccion, telefono)
				values (nombreEmpresa, direccion, telefono);
        End$$    
Delimiter ;    


call sp_AgregarEmpresa ('Campero', 'Guatemala Ciudad,', '12345678');
call sp_AgregarEmpresa ('Farmacia Galeno', 'Mixco', '1740');

-- Listar Empresas----

Delimiter $$
	Create procedure sp_ListarEmpresas()
		Begin
			select 
				Empresas.codigoEmpresa,
				Empresas.nombreEmpresa, 
                Empresas.direccion, 
                Empresas.telefono
                from Empresas;
        End$$
Delimiter ;

call sp_ListarEmpresas();
-- Editar Empresas----



Delimiter $$
	Create procedure sp_EditarEmpresa(in codEmp int, in nomEmp varchar(150), in direc varchar(150), in tel varchar(10))
		Begin
			update Empresas
				set
					nombreEmpresa = nomEmp, 
                    direccion = direc, 
                    telefono = tel
                    where codigoEmpresa = codEmp;
        End$$
Delimiter ;

-- Eliminar Empresas----

Delimiter $$
	Create procedure sp_EliminarEmpresa(in codEmp int)
		Begin
			delete
				from Empresas
                    where codigoEmpresa = codEmp;
        End$$
Delimiter ;



-- Buscar Empresas----
-- drop procedure sp_BuscarEmpresa;
Delimiter $$
	Create procedure sp_BuscarEmpresa(in codEmp int)
		Begin
			select 
				Empresas.codigoEmpresa,
				Empresas.nombreEmpresa, 
                Empresas.direccion, 
                Empresas.telefono
                from Empresas 
					where codigoEmpresa = codEmp;
        End$$
Delimiter ;


call sp_ListarEmpresas();

-- ALTER USER 'root'@'localhost' identified WITH mysql_native_password BY 'admin';


call sp_BuscarEmpresa(3);

call sp_EditarEmpresa(6,'Pedros','Casita','11111111');


--            ENTIDAD PRESUPUESTO  --

-- AGREGAR

Delimiter $$
	Create procedure sp_AgregarPresupuesto(in fechaSolicitud date, in cantidadPresupuesto decimal(10,2), in codigoEmpresa int)
		Begin
			Insert into Presupuestos (fechaSolicitud, cantidadPresupuesto, codigoEmpresa)
				values (fechaSolicitud, cantidadPresupuesto, codigoEmpresa);
        End$$
Delimiter ;

call sp_AgregarPresupuesto('2019-12-03', 12000.00, 1);
call sp_AgregarPresupuesto('2020-01-01', 12000.00, 2);
call sp_AgregarPresupuesto('2020-01-01', 5289.35, 1);

-- LISTAR


Delimiter $$
	Create procedure sp_ListarPresupuestos()
		Begin
			Select 
				Presupuestos.codigoPresupuesto,
                Presupuestos.fechaSolicitud,
                Presupuestos.cantidadPresupuesto,
                Presupuestos.codigoEmpresa
                from Presupuestos;               
        End$$
Delimiter ;

call sp_ListarPresupuestos();


-- ELIMINAR ----


Delimiter $$
	Create procedure sp_EliminarPresupuesto(in codPresup int)
		Begin
			delete
				from Presupuestos
                    where codigoPresupuesto = codPresup;
        End$$
Delimiter ;


sp_
-- BUSCAR ----

Delimiter $$
	Create procedure sp_BuscarPresupuesto(in codPresup int)
		Begin
			select 
				Presupuestos.fechaSolicitud, 
                Presupuestos.cantidadPresupuesto, 
                Presupuestos.codigoEmpresa
                from Presupuestos 
					where codigoPresupuesto = codPresup;
        End$$
Delimiter ;

call sp_BuscarPresupuesto(1);

-- EDITAR ----

-- drop procedure sp_EditarPresupuesto;

Delimiter $$
	Create procedure sp_EditarPresupuesto(in codPresup int, in fecSolic date, in cantPresup decimal(10,2))
		Begin
			update Presupuestos
				set 
					fechaSolicitud = fecSolic, 
                    cantidadPresupuesto = cantPresup
                    where codigoPresupuesto = codPresup;
        End$$
Delimiter ;


Delimiter $$
	Create procedure sp_ListarServicios()
    Begin
		Select
			Servicios.codigoServicio, 
            Servicios.fechaServicio, 
            Servicios.tipoServicio, 
            Servicios.horaServicio, 
            Servicios.lugarServicio, 
            Servicios.telefonoContacto, 
            Servicios.codigoEmpresa
		from Servicios;
    End$$   

Delimiter ;

Delimiter $$
	Create procedure sp_AgregarServicio(in fechaServicio date, 
		in tipoServicio varchar(150), 
        in horaServicio time, 
        in lugarServicio varchar(150), 
        in telefonoContacto varchar(10), 
        in codigoEmpresa int)
	Begin
		insert into Servicios (fechaServicio, tipoServicio, horaServicio, lugarServicio, telefonoContacto, codigoEmpresa)
			values (fechaServicio, tipoServicio, horaServicio, lugarServicio, telefonoContacto, codigoEmpresa);
    End$$

Delimiter ;

call sp_AgregarServicio ('2020-04-15','Cualquier cosa','15:15:00','Zona 11', '12547896',2);



Delimiter $$
	Create procedure sp_EliminarServicio(in codServicio int)
		Begin
			delete from Servicios
                    where codigoServicio = codServicio;
        End$$
Delimiter ;



call sp_AgregarServicio('2020-06-09', 'Bufette', now(), 'Antigua Guatemala', '54405158',1 );
call sp_AgregarServicio('2020-06-09', 'Bufette', '15:30:00', 'Antigua Guatemala', '54405158',1 );

call sp_ListarServicios;

-- drop procedure sp_EditarServicio;

Delimiter $$
	Create procedure sp_EditarServicio(in codServi int,
		in fecServi date, 
		in tipoServi varchar(150), 
        in hServi time, 
        in luServi varchar(150), 
        in telCont varchar(10))
		Begin
			update Servicios
				set 
					fechaServicio = fecServi, 
                    tipoServicio = tipoServi, 
                    horaServicio = hServi, 
                    lugarServicio = luServi, 
                    telefonoContacto = telCont
                    where codigoServicio = codServi;
        End$$
Delimiter ;


call sp_ListarServicios;

call sp_EditarServicio(2,'1998,01-01', 'Ninguno', '00:00:00','Mexico', '12345678');



Delimiter $$
	Create procedure sp_BuscarServicio(in codServi int)
		Begin
			select 				
				Servicios.fechaServicio, 
				Servicios.tipoServicio, 
				Servicios.horaServicio, 
				Servicios.lugarServicio, 
				Servicios.telefonoContacto, 
				Servicios.codigoEmpresa
                from Servicios 
					where codigoServicio = codServi;
        End$$
Delimiter ;

call sp_ListarServicios();



 alter user 'root'@'localhost' identified WITH mysql_native_password BY 'admin';
 
 call sp_ListarEmpresas();