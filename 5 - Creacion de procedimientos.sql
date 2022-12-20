/*--------------------------------------------------CREACION DE PROCEDIMIENTOS-----------------------------------------------------------*/
USE Venta_Bebidas ;

-- Procedimiento que ordena campo de tabla con especificacion de asc or desc
DROP PROCEDURE IF EXISTS SP_Ordenar;
DELIMITER $$
CREATE PROCEDURE SP_Ordenar (IN p_tabla VARCHAR(50), IN p_campo VARCHAR(50), IN p_orden VARCHAR(50))
BEGIN
	IF p_tabla = '' THEN
		SELECT 'SELECCIONAR TABLA' ERROR;
	ELSE
		SET @ordenar_tabla = CONCAT(' ', p_tabla);
		IF p_campo = '' THEN
        SELECT 'SELECCIONAR CAMPO' ERROR;
			SET @ordenar_campo = '';
		ELSE
			IF p_orden = '' THEN 
				set p_orden = 'ASC';
				SET @sentido_orden = '';
			ELSE
				SET @ordenar_campo = CONCAT(' ORDER BY ', p_campo);
                SET @sentido_orden = CONCAT(' ', upper(p_orden));
			END IF;
		END IF;
    END IF;
	SET @clausula = CONCAT('SELECT * FROM ', @ordenar_tabla, @ordenar_campo, @sentido_orden);
    PREPARE EjecutarSQL FROM @clausula;
    EXECUTE EjecutarSQL;
    DEALLOCATE PREPARE EjecutarSQL;
END$$



/* Procedimiento para Insertar registros TABLA ARTICULOS*/

DROP PROCEDURE IF EXISTS SP_Alta_Articulos;
DELIMITER //

CREATE PROCEDURE SP_Alta_Articulos (	IN p_Descripcion varchar(50), 
										IN p_Hectos decimal(8,4), 
                                        IN p_IDMarca int,
                                        IN p_IDCalibre int,
                                        IN p_PrecioCompra decimal(10,2),
                                        IN p_PrecioVenta decimal(10,2))
Begin
				IF p_Descripcion = '' 
				OR p_Hectos = '' 
				OR p_IDMarca = '' 
				OR p_IDCalibre = '' 
				OR p_PrecioCompra = '' 
				OR p_PrecioVenta = ''
				THEN
					SELECT 'Parametro faltante o invalido' ERROR;
					ELSE
					INSERT INTO Articulos 	(DescArticulo,
											Hectos,
											ID_Marca,
											ID_Calibre,
											PrecioVenta,
											PrecioCompra)
					Values					(
											p_Descripcion, 
											p_Hectos, 
											p_IDMarca,
											p_IDCalibre,
											p_PrecioCompra,
											p_PrecioVenta);
		END IF;
SELECT * FROM articulos ORDER BY id_articulo DESC LIMIT 1;
END //

/* Procedimiento para Insertar registros TABLA CALIBRES*/

DROP PROCEDURE IF EXISTS SP_Alta_Calibres;
DELIMITER //

CREATE PROCEDURE SP_Alta_Calibres (	IN p_Descripcion varchar(50))
Begin
				IF p_Descripcion = '' 
				THEN
					SELECT 'Parametro faltante o invalido' ERROR;
					ELSE
					INSERT INTO Calibres 	(DescCalibre)
					Values					(p_Descripcion);
		END IF;
        SELECT * FROM calibres ORDER BY id_calibre DESC LIMIT 1;
END //

/* Procedimiento para Insertar registros TABLA CALIBRES*/

DROP PROCEDURE IF EXISTS SP_Alta_Calibres;
DELIMITER //

CREATE PROCEDURE SP_Alta_Calibres (	IN p_Descripcion varchar(50))
Begin
				IF p_Descripcion = '' 
				THEN
					SELECT 'Parametro faltante o invalido' ERROR;
					ELSE
					INSERT INTO Calibres 	(DescCalibre)
					Values					(p_Descripcion);
		END IF;
        SELECT * FROM calibres ORDER BY id_calibre DESC LIMIT 1;
END //


/* Procedimiento para Insertar registros TABLA CLIENTES*/

DROP PROCEDURE IF EXISTS SP_Alta_Clientes;
DELIMITER //

CREATE PROCEDURE SP_Alta_Clientes (	IN p_RazonSocial varchar(50),
									IN p_Categoria enum ('RI','MT','Exento','NC','CF'),
                                    IN p_ID_Localidad int,
                                    IN p_Direccion varchar(50) ,
                                    IN p_NumDireccion int ,
                                    IN p_Telefono int ,
                                    IN p_Email varchar(50) ,
                                    IN p_ID_Ruta int ,
                                    IN p_Identificador enum ('C.U.I.T.','D.N.I.') ,
                                    IN p_NumIdentificador numeric(13,0)
                                    )
Begin
			IF p_RazonSocial = '' 
				OR p_Categoria = '' 
				OR p_ID_Localidad = '' 
				OR p_Direccion = '' 
				OR p_NumDireccion = '' 
				OR p_Telefono = ''
				OR p_Email = '' 
				OR p_ID_Ruta = '' 
				OR p_Identificador = ''
				OR p_NumIdentificador = ''
				THEN
					SELECT 'Parametro faltante o invalido' ERROR;
					ELSE
					INSERT INTO Clientes 	(RazonSocial,
											Categoria,
											ID_Localidad,
											Direccion,
											NumDireccion,
											Telefono,
											Email,
											ID_Ruta,
											Identificador,
											NumIdentificador
											)
					Values					(p_RazonSocial,
											p_Categoria,
											p_ID_Localidad,
											p_Direccion  ,
											p_NumDireccion  ,
											p_Telefono  ,
											p_Email  ,
											p_ID_Ruta  ,
											p_Identificador  ,
											p_NumIdentificador
											);
		END IF;
        SELECT * FROM clientes ORDER BY id_cliente DESC LIMIT 1;
END //

/* Procedimiento para Insertar registros TABLA Divisiones*/

DROP PROCEDURE IF EXISTS SP_Alta_Divisiones;
DELIMITER //

CREATE PROCEDURE SP_Alta_Divisiones (IN p_Division varchar(50))
Begin
				IF p_Division = '' 
				THEN
					SELECT 'Parametro faltante o invalido' ERROR;
					ELSE
					INSERT INTO Divisiones	(DescDivision)
					Values					(p_Division);
		END IF;
        SELECT * FROM Divisiones ORDER BY id_Division DESC LIMIT 1;
END //

/* Procedimiento para Insertar registros TABLA MARCAS*/

DROP PROCEDURE IF EXISTS SP_Alta_Marcas;
DELIMITER //

CREATE PROCEDURE SP_Alta_Marcas (IN p_Descripcion_Marca varchar(50),IN p_ID_Division int)
Begin
				IF p_Descripcion_Marca = '' 
                or p_ID_Division = ''
				THEN
					SELECT 'Parametro faltante o invalido' ERROR;
					ELSE
					INSERT INTO Marcas	(DescMarca,
										ID_Division)
					Values				(p_Descripcion_Marca,
										p_ID_Division);
		END IF;
        SELECT * FROM Marcas ORDER BY id_Marca DESC LIMIT 1;
END //

/* Procedimiento para Insertar registros TABLA RUTAS*/

DROP PROCEDURE IF EXISTS SP_Alta_Rutas;
DELIMITER //

CREATE PROCEDURE SP_Alta_Rutas (IN p_ID_Ruta int, p_DiaVisita enum ('lunes','martes','miercoles','jueves','viernes'),IN p_ID_Vendedor int)
Begin
				IF p_ID_Ruta = '' 
                or p_DiaVisita = ''
				or p_ID_Vendedor = ''
				THEN
					SELECT 'Parametro faltante o invalido' ERROR;
					ELSE
					INSERT INTO Rutas	(ID_Ruta,
										DiaVisita,
                                        ID_Vendedor)
					Values				(p_ID_Ruta,
										p_DiaVisita,
                                        p_ID_Vendedor);
		END IF;
        SELECT * FROM Rutas ORDER BY id_Vendedor DESC LIMIT 1;
END //

/* Procedimiento para Insertar registros TABLA Vendedores*/

DROP PROCEDURE IF EXISTS SP_Alta_Vendedores;
DELIMITER //

CREATE PROCEDURE SP_Alta_Vendedores (IN p_NombreCompleto varchar(50),IN p_Supervisor varchar(50))
Begin
				IF p_NombreCompleto = '' 
                or p_Supervisor = ''
				THEN
					SELECT 'Parametro faltante o invalido' ERROR;
					ELSE
					INSERT INTO Vendedores	(Vendedor,
										supervisor)
					Values				(p_NombreCompleto,
										p_Supervisor);
		END IF;
        SELECT * FROM Vendedores ORDER BY id_Vendedor DESC LIMIT 1;
END //

/* Procedimiento para Insertar registros venta-detalleventas*/

DROP PROCEDURE IF EXISTS SP_Registro_Ventas;
DELIMITER //

CREATE PROCEDURE SP_Registro_Ventas (IN p_ID_Cliente int, 
                                     IN p_ModalidadPago enum ('Efectivo','Cta Cte'),
									 IN p_articulo1 int,
                                     IN p_cantidad1 int,
									 IN p_articulo2 int,
                                     IN p_cantidad2 int,
									 IN p_articulo3 int,
                                     IN p_cantidad3 int,
									 IN p_articulo4 int,
                                     IN p_cantidad4 int,
									 IN p_articulo5 int,
                                     IN p_cantidad5 int,
									 IN p_articulo6 int,
                                     IN p_cantidad6 int,
                                     IN p_articulo7 int,
                                     IN p_cantidad7 int,
									 IN p_articulo8 int,
                                     IN p_cantidad8 int,
									 IN p_articulo9 int,
                                     IN p_cantidad9 int)
Begin
	IF p_ID_Cliente = '' 
	or p_ModalidadPago = ''
	or p_articulo1 ='' 
	or p_cantidad1 ='' 
    THEN
    SELECT 'DEBE COMPLETAR ID_CLIENTE, Modo de PAGO, ART 1 Y CANT 1 AL MENOS PARA PROCEDER' ERROR;
    ELSE 
		INSERT INTO 

