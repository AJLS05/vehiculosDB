-- Creación de datos de prueba
-- Clientes
CALL CrearCliente('Juan Pérez', 'Calle Principal 123, Ciudad A', 5551234567, 'Masculino', 45000.50);
CALL CrearCliente('Ana Gómez', 'Avenida Central 456, Ciudad B', 5559876543, 'Femenino', 62000.00);
CALL CrearCliente('Luis Martínez', 'Boulevard Secundario 789, Ciudad C', 5553456789, 'Masculino', 30000.75);
CALL CrearCliente('Sofía Rodríguez', 'Calle de la Esperanza 321, Ciudad D', 5556789012, 'Femenino', 75000.10);
CALL CrearCliente('Carlos López', 'Avenida del Sol 654, Ciudad E', 5558901234, 'Masculino', 50000.25);
--
-- Concesionario
CALL CrearConcesionario('Concesionario Centro', 'Calle Principal 100, Ciudad A', 5551234500);
CALL CrearConcesionario('AutoMarket Norte', 'Avenida del Norte 200, Ciudad B', 5559876500);
CALL CrearConcesionario('Vehículos del Sur', 'Boulevard del Sur 300, Ciudad C', 5553456700);
CALL CrearConcesionario('Distribuidora del Este', 'Calle de la Luz 400, Ciudad D', 5556789000);
CALL CrearConcesionario('Autos del Oeste', 'Avenida del Sol 500, Ciudad E', 5558901200);
--
-- Modelo
CALL CrearModelo('Sedan LX', 'Sedan', 'Marca1');
CALL CrearModelo('SUV Max', 'SUV', 'Marca2');
CALL CrearModelo('Coupe Sport', 'Coupe', 'Marca3');
CALL CrearModelo('Hatchback XR', 'Hatchback', 'Marca1');
CALL CrearModelo('Pickup Pro', 'Pickup', 'Marca2');
--
-- Planta
CALL CrearPlanta('Planta Norte', 'Zona Industrial Norte, Ciudad A');
CALL CrearPlanta('Planta Sur', 'Carretera del Sur, Ciudad B');
CALL CrearPlanta('Planta Central', 'Parque Industrial Centro, Ciudad C');
CALL CrearPlanta('Planta Este', 'Zona Este, Ciudad D');
CALL CrearPlanta('Planta Oeste', 'Complejo Industrial Oeste, Ciudad E');
--
-- Proveedor
CALL CrearProveedor('Proveedor A', 'Calle Comercio 100, Ciudad A', 5551234600);
CALL CrearProveedor('Proveedor B', 'Avenida Industria 200, Ciudad B', 5559876600);
CALL CrearProveedor('Proveedor C', 'Boulevard Proveedor 300, Ciudad C', 5553456800);
CALL CrearProveedor('Proveedor D', 'Calle de los Negocios 400, Ciudad D', 5556789100);
CALL CrearProveedor('Proveedor E', 'Avenida del Mercado 500, Ciudad E', 5558901300);
--
-- Vehiculo
CALL CrearVehiculo('1HGCM82633A123456', 1, 'Color1', 1234567890, 'Automática');
CALL CrearVehiculo('2HGCM82633A654321', 2, 'Color2', 2345678901, 'Manual');
CALL CrearVehiculo('3HGCM82633A789012', 3, 'Color3', 3456789012, 'Automática');
CALL CrearVehiculo('4HGCM82633A345678', 1, 'Color1', 4567890123, 'Manual');
CALL CrearVehiculo('5HGCM82633A987654', 2, 'Color2', 5678901234, 'Automática');
--
-- Ventas
CALL CrearVenta('2024-12-01', 1, 1, '1HGCM82633A123456', 20000.00);
CALL CrearVenta('2024-12-02', 2, 2, '2HGCM82633A654321', 25000.00);
CALL CrearVenta('2024-12-03', 3, 3, '3HGCM82633A789012', 18000.00);
CALL CrearVenta('2024-12-04', 4, 4, '4HGCM82633A345678', 22000.00);
CALL CrearVenta('2024-12-05', 5, 5, '5HGCM82633A987654', 26000.00);


