-- Para la Creación de la Base de Datos
-- Codigo para la creación de las Tablas
use vehiculosdb;
-- Tabla: PLANTAS
CREATE TABLE PLANTAS (
    idPlanta INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(255) NOT NULL
);

-- Tabla: PROVEEDORES
CREATE TABLE PROVEEDORES (
    idProveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    noTelefono BIGINT NOT NULL
);

-- Tabla: MODELOS
CREATE TABLE MODELOS (
    idModelo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    estiloCarroceria VARCHAR(50) NOT NULL,
    marca ENUM('Marca1', 'Marca2', 'Marca3') NOT NULL -- Reemplazar con valores reales
);

-- Tabla: MODELOSXPANTAS
CREATE TABLE MODELOSXPANTAS (
    idModelo INT,
    idPlanta INT,
    PRIMARY KEY (idModelo, idPlanta),
    FOREIGN KEY (idModelo) REFERENCES MODELOS(idModelo),
    FOREIGN KEY (idPlanta) REFERENCES PLANTAS(idPlanta)
);

-- Tabla: MODELOSXPROVEEDORES
CREATE TABLE MODELOSXPROVEEDORES (
    idModelo INT,
    idProveedor INT,
    PRIMARY KEY (idModelo, idProveedor),
    FOREIGN KEY (idModelo) REFERENCES MODELOS(idModelo),
    FOREIGN KEY (idProveedor) REFERENCES PROVEEDORES(idProveedor)
);

-- Tabla: VEHICULOS
CREATE TABLE VEHICULOS (
    VIN VARCHAR(17) PRIMARY KEY, -- VIN es único
    idModelo INT NOT NULL,
    color ENUM('Color1', 'Color2', 'Color3') NOT NULL, -- Reemplazar con valores reales
    noMotor BIGINT NOT NULL,
    transmision ENUM('Manual', 'Automática') NOT NULL,
    FOREIGN KEY (idModelo) REFERENCES MODELOS(idModelo)
);

-- Tabla: CONCESIONARIOS
CREATE TABLE CONCESIONARIOS (
    idConcesionario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    noTelefono BIGINT NOT NULL
);

-- Tabla: VEHICULOSXCONCESIONARIOS
CREATE TABLE VEHICULOSXCONCESIONARIOS (
    VIN VARCHAR(17),
    idConcesionario INT,
    PRIMARY KEY (VIN, idConcesionario),
    FOREIGN KEY (VIN) REFERENCES VEHICULOS(VIN),
    FOREIGN KEY (idConcesionario) REFERENCES CONCESIONARIOS(idConcesionario)
);

-- Tabla: CLIENTES
CREATE TABLE CLIENTES (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    noTelefono BIGINT NOT NULL,
    sexo ENUM('Masculino', 'Femenino') NOT NULL,
    ingresosAnuales DECIMAL(10, 2) NOT NULL
);

-- Tabla: VENTAS
CREATE TABLE VENTAS (
    idVenta INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    idConcesionario INT NOT NULL,
    idCliente INT NOT NULL,
    VIN VARCHAR(17) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (idConcesionario) REFERENCES CONCESIONARIOS(idConcesionario),
    FOREIGN KEY (idCliente) REFERENCES CLIENTES(idCliente),
    FOREIGN KEY (VIN) REFERENCES VEHICULOS(VIN)
);

-- Tabla: BITACORA
CREATE TABLE BITACORA (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tabla VARCHAR(50) NOT NULL,                           -- Nombre de la tabla afectada
    accion ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,   -- Tipo de operación (INSERT, UPDATE, DELETE)
    usuario VARCHAR(50) NOT NULL,                         -- Usuario que realizó la operación
    fecha DATETIME NOT NULL,                              -- Fecha y hora de la operación
    detalles TEXT                                         -- Detalles adicionales (opcional)
);

-- Codigo para la creación de los Procedimientos Almacenados
-- Procedimiento para Crear una nueva planta
DELIMITER //
CREATE PROCEDURE CrearPlanta(
    IN p_nombre VARCHAR(100),
    IN p_ubicacion VARCHAR(255)
)
BEGIN
    INSERT INTO PLANTAS (nombre, ubicacion)
    VALUES (p_nombre, p_ubicacion);
END;
//
DELIMITER ;

DELIMITER //
-- Procedimiento para Modificar una planta existente
CREATE PROCEDURE ModificarPlanta(
    IN p_idPlanta INT,
    IN p_nombre VARCHAR(100),
    IN p_ubicacion VARCHAR(255)
)
BEGIN
    UPDATE PLANTAS
    SET nombre = p_nombre, ubicacion = p_ubicacion
    WHERE idPlanta = p_idPlanta;
END;
//
DELIMITER ;

DELIMITER //
-- Procedimiento para Eliminar una planta
CREATE PROCEDURE EliminarPlanta(
    IN p_idPlanta INT
)
BEGIN
    DELETE FROM PLANTAS
    WHERE idPlanta = p_idPlanta;
END;
//
DELIMITER ;
DELIMITER //
-- Procedimiento para Crear un Proveedor 
CREATE PROCEDURE CrearProveedor(IN p_nombre VARCHAR(100), IN p_direccion VARCHAR(255), IN p_noTelefono BIGINT)
BEGIN
    INSERT INTO PROVEEDORES (nombre, direccion, noTelefono) VALUES (p_nombre, p_direccion, p_noTelefono);
END;
//
DELIMITER ;
DELIMITER //
-- Procedimiento para Modificar un Proveedor
CREATE PROCEDURE ModificarProveedor(IN p_idProveedor INT, IN p_nombre VARCHAR(100), IN p_direccion VARCHAR(255), IN p_noTelefono BIGINT)
BEGIN
    UPDATE PROVEEDORES SET nombre = p_nombre, direccion = p_direccion, noTelefono = p_noTelefono WHERE idProveedor = p_idProveedor;
END;
//
DELIMITER ;
DELIMITER //
-- Procedimiento para Eliminar un Proveedor
CREATE PROCEDURE EliminarProveedor(IN p_idProveedor INT)
BEGIN
    DELETE FROM PROVEEDORES WHERE idProveedor = p_idProveedor;
END;
//
DELIMITER ;
DELIMITER //
-- Procedimiento para Crear un Modelo
CREATE PROCEDURE CrearModelo(IN p_nombre VARCHAR(100), IN p_estiloCarroceria VARCHAR(50), IN p_marca ENUM('Marca1', 'Marca2', 'Marca3'))
BEGIN
    INSERT INTO MODELOS (nombre, estiloCarroceria, marca) VALUES (p_nombre, p_estiloCarroceria, p_marca);
END;
//
DELIMITER ;
DELIMITER //
-- Procedimiento para Modificar un Modelo
CREATE PROCEDURE ModificarModelo(IN p_idModelo INT, IN p_nombre VARCHAR(100), IN p_estiloCarroceria VARCHAR(50), IN p_marca ENUM('Marca1', 'Marca2', 'Marca3'))
BEGIN
    UPDATE MODELOS SET nombre = p_nombre, estiloCarroceria = p_estiloCarroceria, marca = p_marca WHERE idModelo = p_idModelo;
END;
//
DELIMITER ;
DELIMITER //
-- Procedimiento para Eliminar un Modelo
CREATE PROCEDURE EliminarModelo(IN p_idModelo INT)
BEGIN
    DELETE FROM MODELOS WHERE idModelo = p_idModelo;
END;
//
DELIMITER ;
DELIMITER //
-- Procedimiento para Crear un Vehiculo
CREATE PROCEDURE CrearVehiculo(IN p_VIN VARCHAR(17), IN p_idModelo INT, IN p_color ENUM('Color1', 'Color2', 'Color3'), IN p_noMotor BIGINT, IN p_transmision ENUM('Manual', 'Automática'))
BEGIN
    INSERT INTO VEHICULOS (VIN, idModelo, color, noMotor, transmision) VALUES (p_VIN, p_idModelo, p_color, p_noMotor, p_transmision);
END;
//
DELIMITER ;
DELIMITER //
-- Procedimiento para Modificar un Vehiculo
CREATE PROCEDURE ModificarVehiculo(IN p_VIN VARCHAR(17), IN p_idModelo INT, IN p_color ENUM('Color1', 'Color2', 'Color3'), IN p_noMotor BIGINT, IN p_transmision ENUM('Manual', 'Automática'))
BEGIN
    UPDATE VEHICULOS SET idModelo = p_idModelo, color = p_color, noMotor = p_noMotor, transmision = p_transmision WHERE VIN = p_VIN;
END;
//
DELIMITER ;
DELIMITER //
-- Procedimiento para Eliminar un Vehiculo
CREATE PROCEDURE EliminarVehiculo(IN p_VIN VARCHAR(17))
BEGIN
    DELETE FROM VEHICULOS WHERE VIN = p_VIN;
END;
//
DELIMITER ;
DELIMITER //
-- Procedimiento para Crear un Concesionario
CREATE PROCEDURE CrearConcesionario(IN p_nombre VARCHAR(100), IN p_direccion VARCHAR(255), IN p_noTelefono BIGINT)
BEGIN
    INSERT INTO CONCESIONARIOS (nombre, direccion, noTelefono) VALUES (p_nombre, p_direccion, p_noTelefono);
END;
//
DELIMITER ;
DELIMITER //
-- Procedimiento para Modificar un Concesionario
CREATE PROCEDURE ModificarConcesionario(IN p_idConcesionario INT, IN p_nombre VARCHAR(100), IN p_direccion VARCHAR(255), IN p_noTelefono BIGINT)
BEGIN
    UPDATE CONCESIONARIOS SET nombre = p_nombre, direccion = p_direccion, noTelefono = p_noTelefono WHERE idConcesionario = p_idConcesionario;
END;
//
DELIMITER ;
DELIMITER //
-- Procedimiento para Eliminar un Concesionario
CREATE PROCEDURE EliminarConcesionario(IN p_idConcesionario INT)
BEGIN
    DELETE FROM CONCESIONARIOS WHERE idConcesionario = p_idConcesionario;
END;
//
DELIMITER ;
DELIMITER //
-- Procedimiento para Crear un Cliente
CREATE PROCEDURE CrearCliente(IN p_nombre VARCHAR(100), IN p_direccion VARCHAR(255), IN p_noTelefono BIGINT, IN p_sexo ENUM('Masculino', 'Femenino'), IN p_ingresosAnuales DECIMAL(10,2))
BEGIN
    INSERT INTO CLIENTES (nombre, direccion, noTelefono, sexo, ingresosAnuales) VALUES (p_nombre, p_direccion, p_noTelefono, p_sexo, p_ingresosAnuales);
END;
//
DELIMITER ;
DELIMITER //
-- Procedimiento para Modificar un Cliente
CREATE PROCEDURE ModificarCliente(IN p_idCliente INT, IN p_nombre VARCHAR(100), IN p_direccion VARCHAR(255), IN p_noTelefono BIGINT, IN p_sexo ENUM('Masculino', 'Femenino'), IN p_ingresosAnuales DECIMAL(10,2))
BEGIN
    UPDATE CLIENTES SET nombre = p_nombre, direccion = p_direccion, noTelefono = p_noTelefono, sexo = p_sexo, ingresosAnuales = p_ingresosAnuales WHERE idCliente = p_idCliente;
END;
//
DELIMITER ;
DELIMITER //
-- Procedimiento para Eliminar un Cliente
CREATE PROCEDURE EliminarCliente(IN p_idCliente INT)
BEGIN
    DELETE FROM CLIENTES WHERE idCliente = p_idCliente;
END;
//
DELIMITER ;
DELIMITER //
-- Procedimiento para Crear una Venta
CREATE PROCEDURE CrearVenta(IN p_fecha DATE, IN p_idConcesionario INT, IN p_idCliente INT, IN p_VIN VARCHAR(17), IN p_precio DECIMAL(10,2))
BEGIN
    INSERT INTO VENTAS (fecha, idConcesionario, idCliente, VIN, precio) VALUES (p_fecha, p_idConcesionario, p_idCliente, p_VIN, p_precio);
END;
//
DELIMITER ;
DELIMITER //
-- Procedimiento para Modificar una Venta
CREATE PROCEDURE ModificarVenta(IN p_idVenta INT, IN p_fecha DATE, IN p_idConcesionario INT, IN p_idCliente INT, IN p_VIN VARCHAR(17), IN p_precio DECIMAL(10,2))
BEGIN
    UPDATE VENTAS SET fecha = p_fecha, idConcesionario = p_idConcesionario, idCliente = p_idCliente, VIN = p_VIN, precio = p_precio WHERE idVenta = p_idVenta;
END;
//
DELIMITER ;
DELIMITER //
-- Procedimiento para Eliminar una Venta
CREATE PROCEDURE EliminarVenta(IN p_idVenta INT)
BEGIN
    DELETE FROM VENTAS WHERE idVenta = p_idVenta;
END;
//
DELIMITER ;

-- Codigo para la creación de los Triggers
-- Trigger para la tabla PLANTAS
DELIMITER //
CREATE TRIGGER BitacoraInsertPlantas
AFTER INSERT ON PLANTAS
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (tabla, accion, usuario, fecha, detalles)
    VALUES ('PLANTAS', 'INSERT', USER(), NOW(), CONCAT('idPlanta: ', NEW.idPlanta, ', nombre: ', NEW.nombre, ', ubicacion: ', NEW.ubicacion));
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER BitacoraUpdatePlantas
AFTER UPDATE ON PLANTAS
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (tabla, accion, usuario, fecha, detalles)
    VALUES ('PLANTAS', 'UPDATE', USER(), NOW(), CONCAT('idPlanta: ', OLD.idPlanta, ' -> ', NEW.idPlanta, ', nombre: ', OLD.nombre, ' -> ', NEW.nombre, ', ubicacion: ', OLD.ubicacion, ' -> ', NEW.ubicacion));
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER BitacoraDeletePlantas
AFTER DELETE ON PLANTAS
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (tabla, accion, usuario, fecha, detalles)
    VALUES ('PLANTAS', 'DELETE', USER(), NOW(), CONCAT('idPlanta: ', OLD.idPlanta, ', nombre: ', OLD.nombre, ', ubicacion: ', OLD.ubicacion));
END;
//
DELIMITER ;

-- Trigger para la tabla PROVEEDORES
DELIMITER //
CREATE TRIGGER BitacoraInsertProveedores
AFTER INSERT ON PROVEEDORES
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (tabla, accion, usuario, fecha, detalles)
    VALUES ('PROVEEDORES', 'INSERT', USER(), NOW(), CONCAT('idProveedor: ', NEW.idProveedor, ', nombre: ', NEW.nombre, ', direccion: ', NEW.direccion, ', noTelefono: ', NEW.noTelefono));
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER BitacoraUpdateProveedores
AFTER UPDATE ON PROVEEDORES
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (tabla, accion, usuario, fecha, detalles)
    VALUES ('PROVEEDORES', 'UPDATE', USER(), NOW(), CONCAT('idProveedor: ', OLD.idProveedor, ' -> ', NEW.idProveedor, ', nombre: ', OLD.nombre, ' -> ', NEW.nombre, ', direccion: ', OLD.direccion, ' -> ', NEW.direccion, ', noTelefono: ', OLD.noTelefono, ' -> ', NEW.noTelefono));
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER BitacoraDeleteProveedores
AFTER DELETE ON PROVEEDORES
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (tabla, accion, usuario, fecha, detalles)
    VALUES ('PROVEEDORES', 'DELETE', USER(), NOW(), CONCAT('idProveedor: ', OLD.idProveedor, ', nombre: ', OLD.nombre, ', direccion: ', OLD.direccion, ', noTelefono: ', OLD.noTelefono));
END;
//
DELIMITER ;

-- Trigger para la tabla CLIENTES
DELIMITER //
CREATE TRIGGER BitacoraInsertClientes
AFTER INSERT ON CLIENTES
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (tabla, accion, usuario, fecha, detalles)
    VALUES ('CLIENTES', 'INSERT', USER(), NOW(), CONCAT('idCliente: ', NEW.idCliente, ', nombre: ', NEW.nombre, ', direccion: ', NEW.direccion, ', noTelefono: ', NEW.noTelefono));
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER BitacoraUpdateClientes
AFTER UPDATE ON CLIENTES
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (tabla, accion, usuario, fecha, detalles)
    VALUES ('CLIENTES', 'UPDATE', USER(), NOW(), CONCAT('idCliente: ', OLD.idCliente, ' -> ', NEW.idCliente, ', nombre: ', OLD.nombre, ' -> ', NEW.nombre, ', direccion: ', OLD.direccion, ' -> ', NEW.direccion, ', noTelefono: ', OLD.noTelefono, ' -> ', NEW.noTelefono, ', sexo: ', OLD.sexo, ' -> ', NEW.sexo, ', ingresosAnuales: ', OLD.ingresosAnuales, ' -> ', NEW.ingresosAnuales));
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER BitacoraDeleteClientes
AFTER DELETE ON CLIENTES
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (tabla, accion, usuario, fecha, detalles)
    VALUES ('CLIENTES', 'DELETE', USER(), NOW(), CONCAT('idCliente: ', OLD.idCliente, ', nombre: ', OLD.nombre, ', direccion: ', OLD.direccion, ', noTelefono: ', OLD.noTelefono, ', sexo: ', OLD.sexo, ', ingresosAnuales: ', OLD.ingresosAnuales));
END;
//
DELIMITER ;

-- Trigger para la tabla VEHICULOS
DELIMITER //
CREATE TRIGGER BitacoraInsertVehiculos
AFTER INSERT ON VEHICULOS
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (tabla, accion, usuario, fecha, detalles)
    VALUES ('VEHICULOS', 'INSERT', USER(), NOW(), CONCAT('VIN: ', NEW.VIN, ', idModelo: ', NEW.idModelo, ', color: ', NEW.color, ', noMotor: ', NEW.noMotor, ', transmision: ', NEW.transmision));
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER BitacoraUpdateVehiculos
AFTER UPDATE ON VEHICULOS
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (tabla, accion, usuario, fecha, detalles)
    VALUES ('VEHICULOS', 'UPDATE', USER(), NOW(), CONCAT('VIN: ', OLD.VIN, ' -> ', NEW.VIN, ', idModelo: ', OLD.idModelo, ' -> ', NEW.idModelo, ', color: ', OLD.color, ' -> ', NEW.color, ', noMotor: ', OLD.noMotor, ' -> ', NEW.noMotor, ', transmision: ', OLD.transmision, ' -> ', NEW.transmision));
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER BitacoraDeleteVehiculos
AFTER DELETE ON VEHICULOS
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (tabla, accion, usuario, fecha, detalles)
    VALUES ('VEHICULOS', 'DELETE', USER(), NOW(), CONCAT('VIN: ', OLD.VIN, ', idModelo: ', OLD.idModelo, ', color: ', OLD.color, ', noMotor: ', OLD.noMotor, ', transmision: ', OLD.transmision));
END;
//
DELIMITER ;

-- Trigger para la tabla MODELOS
DELIMITER //
CREATE TRIGGER BitacoraInsertModelos
AFTER INSERT ON MODELOS
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (tabla, accion, usuario, fecha, detalles)
    VALUES ('MODELOS', 'INSERT', USER(), NOW(), CONCAT('idModelo: ', NEW.idModelo, ', nombre: ', NEW.nombre, ', estiloCarroceria: ', NEW.estiloCarroceria, ', marca: ', NEW.marca));
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER BitacoraUpdateModelos
AFTER UPDATE ON MODELOS
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (tabla, accion, usuario, fecha, detalles)
    VALUES ('MODELOS', 'UPDATE', USER(), NOW(), CONCAT('idModelo: ', OLD.idModelo, ' -> ', NEW.idModelo, ', nombre: ', OLD.nombre, ' -> ', NEW.nombre, ', estiloCarroceria: ', OLD.estiloCarroceria, ' -> ', NEW.estiloCarroceria, ', marca: ', OLD.marca, ' -> ', NEW.marca));
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER BitacoraDeleteModelos
AFTER DELETE ON MODELOS
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (tabla, accion, usuario, fecha, detalles)
    VALUES ('MODELOS', 'DELETE', USER(), NOW(), CONCAT('idModelo: ', OLD.idModelo, ', nombre: ', OLD.nombre, ', estiloCarroceria: ', OLD.estiloCarroceria, ', marca: ', OLD.marca));
END;
//
DELIMITER ;

-- Trigger para la tabla CONCESIONARIOS
DELIMITER //
CREATE TRIGGER BitacoraInsertConcesionarios
AFTER INSERT ON CONCESIONARIOS
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (tabla, accion, usuario, fecha, detalles)
    VALUES ('CONCESIONARIOS', 'INSERT', USER(), NOW(), CONCAT('idConcesionario: ', NEW.idConcesionario, ', nombre: ', NEW.nombre, ', direccion: ', NEW.direccion, ', noTelefono: ', NEW.noTelefono));
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER BitacoraUpdateConcesionarios
AFTER UPDATE ON CONCESIONARIOS
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (tabla, accion, usuario, fecha, detalles)
    VALUES ('CONCESIONARIOS', 'UPDATE', USER(), NOW(), CONCAT('idConcesionario: ', OLD.idConcesionario, ' -> ', NEW.idConcesionario, ', nombre: ', OLD.nombre, ' -> ', NEW.nombre, ', direccion: ', OLD.direccion, ' -> ', NEW.direccion, ', noTelefono: ', OLD.noTelefono, ' -> ', NEW.noTelefono));
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER BitacoraDeleteConcesionarios
AFTER DELETE ON CONCESIONARIOS
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (tabla, accion, usuario, fecha, detalles)
    VALUES ('CONCESIONARIOS', 'DELETE', USER(), NOW(), CONCAT('idConcesionario: ', OLD.idConcesionario, ', nombre: ', OLD.nombre, ', direccion: ', OLD.direccion, ', noTelefono: ', OLD.noTelefono));
END;
//
DELIMITER ;

-- Trigger para la tabla VENTAS
DELIMITER //
CREATE TRIGGER BitacoraInsertVentas
AFTER INSERT ON VENTAS
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (tabla, accion, usuario, fecha, detalles)
    VALUES ('VENTAS', 'INSERT', USER(), NOW(), CONCAT('idVenta: ', NEW.idVenta, ', fecha: ', NEW.fecha, ', idConcesionario: ', NEW.idConcesionario, ', idCliente: ', NEW.idCliente, ', VIN: ', NEW.VIN, ', precio: ', NEW.precio));
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER BitacoraUpdateVentas
AFTER UPDATE ON VENTAS
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (tabla, accion, usuario, fecha, detalles)
    VALUES ('VENTAS', 'UPDATE', USER(), NOW(), CONCAT('idVenta: ', OLD.idVenta, ' -> ', NEW.idVenta, ', fecha: ', OLD.fecha, ' -> ', NEW.fecha, ', idConcesionario: ', OLD.idConcesionario, ' -> ', NEW.idConcesionario, ', idCliente: ', OLD.idCliente, ' -> ', NEW.idCliente, ', VIN: ', OLD.VIN, ' -> ', NEW.VIN, ', precio: ', OLD.precio, ' -> ', NEW.precio));
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER BitacoraDeleteVentas
AFTER DELETE ON VENTAS
FOR EACH ROW
BEGIN
    INSERT INTO BITACORA (tabla, accion, usuario, fecha, detalles)
    VALUES ('VENTAS', 'DELETE', USER(), NOW(), CONCAT('idVenta: ', OLD.idVenta, ', fecha: ', OLD.fecha, ', idConcesionario: ', OLD.idConcesionario, ', idCliente: ', OLD.idCliente, ', VIN: ', OLD.VIN, ', precio: ', OLD.precio));
END;
//
DELIMITER ;

-- Codigo para la creación de Vistas
--
-- 1. Mostrar tendencias de ventas para varias marcas en los últimos 3 años, por año, mes, semana. Luego separe estos datos por género del comprador y luego por rango de ingresos.
--
CREATE VIEW TendenciasVentas AS
SELECT 
    YEAR(v.fecha) AS Anio,
    MONTH(v.fecha) AS Mes,
    WEEK(v.fecha) AS Semana,
    m.marca AS Marca,
    c.sexo AS Genero,
    CASE 

     --
	 -- Discrimina los ingresos anuales categorizandolos en rangos
	 --
    
        WHEN c.ingresosAnuales <= 25000 THEN 'Bajo'
        WHEN c.ingresosAnuales > 25000 AND c.ingresosAnuales <= 75000 THEN 'Medio'
        ELSE 'Alto'
    END AS RangoIngresos,
    COUNT(v.idVenta) AS TotalVentas
FROM 
    VENTAS v
JOIN 
    VEHICULOS ve ON v.VIN = ve.VIN
JOIN 
    MODELOS m ON ve.idModelo = m.idModelo
JOIN 
    CLIENTES c ON v.idCliente = c.idCliente    
 --
 -- Toma la fecha actual con CURDATE y consigue los ultimos tres años restandolo con el DATE_SUB
 --
WHERE 
    v.fecha >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
GROUP BY 
    Anio, Mes, Semana, Marca, Genero, RangoIngresos;

-- 2. Vista que identifica vehículos con transmisiones defectuosas
CREATE VIEW TransmisionesDefectuosas AS
SELECT 
    v.VIN,                           
    c.nombre AS Cliente,             
    c.direccion AS Direccion,        
    c.noTelefono AS Telefono         
FROM 
    VEHICULOS v                 
JOIN VENTAS vt ON v.VIN = vt.VIN     -- Relación de vehículos con las ventas realizadas
JOIN CLIENTES c ON vt.idCliente = c.idCliente -- Relación de ventas con los clientes
JOIN MODELOSXPROVEEDORES mp ON v.idModelo = mp.idModelo -- Relación de modelos con proveedores
JOIN PROVEEDORES p ON mp.idProveedor = p.idProveedor    -- Relación de proveedores con sus detalles
WHERE 
    p.nombre = 'XXX'                 -- Transmisiones del proveedor 'XXX'
    AND vt.fecha BETWEEN '2024-11-01' AND '2024-11-30'; -- Rango de fechas

--
-- 3. Encuentra las 2 mejores marcas por unidad de ventas en el último año.
--
CREATE OR REPLACE VIEW MejoresMarcasXUnidad AS
SELECT 
    m.marca AS Marca, 
    COUNT(v.idVenta) AS TotalVentas
FROM 
    VENTAS v
JOIN 
    VEHICULOS ve ON v.VIN = ve.VIN
JOIN 
    MODELOS m ON ve.idModelo = m.idModelo
WHERE 
    YEAR(v.fecha) between year(curdate())-1 and year(curdate())
GROUP BY 
    m.marca
ORDER BY 
    TotalVentas DESC
LIMIT 2;

-- 4. Vista para obtener las 2 mejores marcas de vehículos vendidos en el último año 
CREATE OR REPLACE VIEW MejoresMarcasXvehiculo AS
SELECT 
    m.marca,
    SUM(v.precio) AS total_dolares
FROM 
    VENTAS v
JOIN 
    VEHICULOS ve ON v.VIN = ve.VIN
JOIN 
    MODELOS m ON ve.idModelo = m.idModelo
WHERE 
    v.fecha >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY 
    m.marca
ORDER BY 
    total_dolares DESC
LIMIT 2;

-- 5. Vista que identifica los meses con más ventas de convertibles
CREATE VIEW VentasConvertibles AS
SELECT 
    MONTHNAME(vt.fecha) AS Mes,      -- Mes de la venta
    COUNT(vt.idVenta) AS TotalVentas -- Número total de ventas realizadas en el mes
FROM 
    VENTAS vt                        
JOIN VEHICULOS v ON vt.VIN = v.VIN   -- Relación de ventas con los vehículos
JOIN MODELOS m ON v.idModelo = m.idModelo -- Relación de vehículos con los modelos
WHERE 
    m.estiloCarroceria = 'Convertible' -- Modelos convertibles
GROUP BY Mes                         -- Agrupar las ventas por mes
ORDER BY TotalVentas DESC;           -- Ordenar por el número total de ventas, en orden descendente

-- 6. Vista para obtener el concesionario con el tiempo promedio de venta de vehículos
CREATE VIEW distribuidoresPromedio AS
SELECT c.nombre AS concesionario,
       AVG(DATEDIFF(CURDATE(), v.fecha)) AS tiempo_promedio
FROM VEHICULOSXCONCESIONARIOS vxc
JOIN CONCESIONARIOS c ON vxc.idConcesionario = c.idConcesionario
JOIN VENTAS v ON vxc.VIN = v.VIN
GROUP BY c.nombre
ORDER BY tiempo_promedio DESC;
--
-- 7. (Extra) Mostrar los datos de vehiculo con su concesionario
CREATE VIEW concesionariosConVehiculos AS
SELECT 
    c.nombre AS nombre_concesionario,
    c.direccion AS direccion_concesionario,
    c.noTelefono AS telefono_concesionario,
    vxc.VIN AS vin_vehiculo,
    mo.nombre AS modelo_vehiculo,
    mo.marca AS marca_vehiculo,
    ve.color AS color_vehiculo,
    ve.transmision AS transmision_vehiculo,
    ve.noMotor AS numero_motor_vehiculo
FROM VEHICULOSXCONCESIONARIOS vxc
JOIN CONCESIONARIOS c ON vxc.idConcesionario = c.idConcesionario
JOIN VEHICULOS ve ON vxc.VIN = ve.VIN
JOIN MODELOS mo ON ve.idModelo = mo.idModelo
ORDER BY c.nombre, mo.nombre;