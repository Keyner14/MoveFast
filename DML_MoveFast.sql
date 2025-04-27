-- Insertar clientes válidos
INSERT INTO Cliente (id_cliente, nombre, apellido, email, telefono, direccion) VALUES
(1, 'Juan', 'Pérez', 'juan.perez@example.com', '123456789', 'Calle 123'),
(2, 'Ana', 'Gómez', 'ana.gomez@example.com', '987654321', 'Carrera 45'),
(3, 'Luis', 'Martínez', 'luis.martinez@example.com', '1122334455', 'Avenida 10'),
(4, 'María', 'Rodríguez', 'maria.rodriguez@example.com', '5566778899', 'Calle 20'),
(5, 'Pedro', 'Sánchez', 'pedro.sanchez@example.com', '6677889900', 'Carrera 100');

-- Insertar errores en Cliente
-- Error 1: email duplicado
INSERT INTO Cliente (id_cliente, nombre, apellido, email, telefono, direccion) VALUES
(6, 'Carlos', 'López', 'juan.perez@example.com', '999999999', 'Calle 99');
-- Error 2: email NULL (NOT NULL constraint violation)
INSERT INTO Cliente (id_cliente, nombre, apellido, email, telefono, direccion) VALUES
(7, 'Lucía', 'Díaz', NULL, '111111111', 'Calle 111');

-------------------------------------------------------

-- Insertar sucursales válidas
INSERT INTO Sucursal (id_sucursal, nombre, direccion, ciudad) VALUES
(1, 'Sucursal Norte', 'Calle Norte 10', 'Cali'),
(2, 'Sucursal Sur', 'Carrera Sur 20', 'Cali'),
(3, 'Sucursal Centro', 'Avenida Central 30', 'Medellín'),
(4, 'Sucursal Este', 'Calle Este 40', 'Bogotá'),
(5, 'Sucursal Oeste', 'Carrera Oeste 50', 'Barranquilla');

-- Insertar errores en Sucursal
-- Error 1: ciudad NULL (NOT NULL constraint violation)
INSERT INTO Sucursal (id_sucursal, nombre, direccion, ciudad) VALUES
(6, 'Sucursal Fantasma', 'Calle Falsa 123', NULL);
-- Error 2: id_sucursal duplicado
INSERT INTO Sucursal (id_sucursal, nombre, direccion, ciudad) VALUES
(1, 'Sucursal Repetida', 'Otra dirección', 'Cartagena');

-------------------------------------------------------

-- Insertar vehículos válidos
INSERT INTO Vehiculo (id_vehiculo, marca, modelo, año, placa, estado, id_sucursal) VALUES
(1, 'Toyota', 'Corolla', 2020, 'ABC123', 'Disponible', 1),
(2, 'Mazda', 'CX-5', 2021, 'XYZ789', 'Alquilado', 2),
(3, 'Chevrolet', 'Spark', 2019, 'JKL456', 'Mantenimiento', 3),
(4, 'Renault', 'Duster', 2022, 'MNO321', 'Disponible', 4),
(5, 'Nissan', 'Sentra', 2023, 'PQR654', 'Disponible', 5);

-- Insertar errores en Vehiculo
-- Error 1: año fuera de rango (restricción CHECK)
INSERT INTO Vehiculo (id_vehiculo, marca, modelo, año, placa, estado, id_sucursal) VALUES
(6, 'Hyundai', 'Accent', 1995, 'DEF111', 'Disponible', 1);
-- Error 2: placa duplicada
INSERT INTO Vehiculo (id_vehiculo, marca, modelo, año, placa, estado, id_sucursal) VALUES
(7, 'Ford', 'Focus', 2020, 'ABC123', 'Disponible', 2);

-------------------------------------------------------

-- Insertar alquileres válidos
INSERT INTO Alquiler (id_alquiler, id_cliente, id_vehiculo, fecha_inicio, fecha_fin, total) VALUES
(1, 1, 1, '2025-04-01 10:00:00', '2025-04-05 10:00:00', 500.00),
(2, 2, 2, '2025-04-02 12:00:00', '2025-04-06 12:00:00', 600.00),
(3, 3, 3, '2025-04-03 09:00:00', '2025-04-04 09:00:00', 200.00),
(4, 4, 4, '2025-04-05 14:00:00', '2025-04-10 14:00:00', 800.00),
(5, 5, 5, '2025-04-06 08:00:00', '2025-04-11 08:00:00', 750.00);

-- Insertar errores en Alquiler
-- Error 1: id_cliente que no existe (foreign key violation)
INSERT INTO Alquiler (id_alquiler, id_cliente, id_vehiculo, fecha_inicio, fecha_fin, total) VALUES
(6, 99, 1, '2025-04-07 10:00:00', '2025-04-08 10:00:00', 100.00);
-- Error 2: fecha_inicio mayor que fecha_fin (lógica incorrecta, pero no rompe restricciones de SQL directamente)
INSERT INTO Alquiler (id_alquiler, id_cliente, id_vehiculo, fecha_inicio, fecha_fin, total) VALUES
(7, 1, 2, '2025-04-10 10:00:00', '2025-04-09 10:00:00', 300.00);

-------------------------------------------------------

-- Insertar pagos válidos
INSERT INTO Pago (id_pago, id_alquiler, fecha_pago, monto, metodo_pago) VALUES
(1, 1, '2025-04-01 15:00:00', 500.00, 'Tarjeta de Crédito'),
(2, 2, '2025-04-02 16:00:00', 600.00, 'Efectivo'),
(3, 3, '2025-04-03 17:00:00', 200.00, 'Transferencia'),
(4, 4, '2025-04-05 18:00:00', 800.00, 'Débito'),
(5, 5, '2025-04-06 19:00:00', 750.00, 'Tarjeta de Crédito');

-- Insertar errores en Pago
-- Error 1: monto negativo (violación CHECK monto > 0)
INSERT INTO Pago (id_pago, id_alquiler, fecha_pago, monto, metodo_pago) VALUES
(6, 1, '2025-04-07 20:00:00', -100.00, 'Efectivo');
-- Error 2: id_alquiler inexistente (foreign key violation)
INSERT INTO Pago (id_pago, id_alquiler, fecha_pago, monto, metodo_pago) VALUES
(7, 99, '2025-04-08 21:00:00', 500.00, 'Transferencia');
