-- Insertar un cliente de prueba
INSERT INTO Cliente (id_cliente, nombre, apellido, email, telefono, direccion)
VALUES (100, 'Pedro', 'Pérez', 'pedro.perez@email.com', '123456789', 'Calle 123');

-- Insertar una sucursal necesaria (porque un vehículo necesita sucursal)
INSERT INTO Sucursal (id_sucursal, nombre, direccion, ciudad)
VALUES (100, 'Sucursal Test', 'Carrera 45', 'Bogotá');

-- Insertar un vehículo asociado a esa sucursal
INSERT INTO Vehiculo (id_vehiculo, marca, modelo, año, placa, estado, id_sucursal)
VALUES (100, 'Toyota', 'Corolla', 2020, 'ABC123', 'Disponible', 100);

-- Insertar un alquiler que relacione el cliente con el vehículo
INSERT INTO Alquiler (id_alquiler, id_cliente, id_vehiculo, fecha_inicio, fecha_fin, total)
VALUES (100, 100, 100, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 500000);

-- Comprobar que el alquiler fue insertado
SELECT * FROM Alquiler WHERE id_cliente = 100;

-- Ahora eliminar el cliente
DELETE FROM Cliente WHERE id_cliente = 100;

-- Verificar que el alquiler también se eliminó
SELECT * FROM Alquiler WHERE id_cliente = 100;

-- Listar vehículos que están 'Disponible' y cuya sucursal esté en una ciudad dada
SELECT v.*
FROM Vehiculo v
INNER JOIN Sucursal s ON v.id_sucursal = s.id_sucursal
WHERE v.estado = 'Disponible'
  AND s.ciudad = 'Bogotá'; -- Cambia 'Bogotá' por la ciudad que necesites

-- Alquileres donde la fecha_fin aún no ha pasado (considerados "activos")
SELECT a.id_alquiler, c.nombre, c.apellido, v.marca, v.modelo, a.fecha_inicio, a.fecha_fin
FROM Alquiler a
INNER JOIN Cliente c ON a.id_cliente = c.id_cliente
INNER JOIN Vehiculo v ON a.id_vehiculo = v.id_vehiculo
WHERE a.fecha_fin >= CURRENT_TIMESTAMP;

-- Ingresos por sucursal, pero solo de vehículos que tienen más de 3 alquileres
SELECT s.nombre AS sucursal, SUM(a.total) AS ingresos_totales
FROM Alquiler a
INNER JOIN Vehiculo v ON a.id_vehiculo = v.id_vehiculo
INNER JOIN Sucursal s ON v.id_sucursal = s.id_sucursal
WHERE v.id_vehiculo IN (
    SELECT id_vehiculo
    FROM Alquiler
    GROUP BY id_vehiculo
    HAVING COUNT(*) > 3
)
GROUP BY s.nombre;

-- Vehículos que han sido alquilados más de 5 veces
SELECT *
FROM Vehiculo
WHERE id_vehiculo IN (
    SELECT id_vehiculo
    FROM Alquiler
    GROUP BY id_vehiculo
    HAVING COUNT(*) > 5
);

-- Sumar el monto total de todos los pagos registrados
SELECT SUM(monto) AS total_pagado
FROM Pago;
