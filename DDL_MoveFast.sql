-- Tabla que almacena información de los clientes
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY, -- Identificador único de cliente
    nombre VARCHAR(100) NOT NULL, -- Nombre del cliente
    apellido VARCHAR(100) NOT NULL, -- Apellido del cliente
    email VARCHAR(100) UNIQUE NOT NULL, -- Email único del cliente
    telefono VARCHAR(20), -- Teléfono de contacto
    direccion VARCHAR(200) -- Dirección de residencia
);

-- Tabla que almacena las sucursales donde se encuentran los vehículos
CREATE TABLE Sucursal (
    id_sucursal INT PRIMARY KEY, -- Identificador único de sucursal
    nombre VARCHAR(100) NOT NULL, -- Nombre de la sucursal
    direccion VARCHAR(200) NOT NULL, -- Dirección de la sucursal
    ciudad VARCHAR(100) NOT NULL -- Ciudad donde se ubica la sucursal
);

-- Tabla que almacena los vehículos disponibles para alquiler
CREATE TABLE Vehiculo (
    id_vehiculo INT PRIMARY KEY, -- Identificador único del vehículo
    marca VARCHAR(50) NOT NULL, -- Marca del vehículo
    modelo VARCHAR(50) NOT NULL, -- Modelo del vehículo
    año INT NOT NULL CHECK (año BETWEEN 2000 AND 2025), -- Año de fabricación (entre 2000 y 2025)
    placa VARCHAR(20) UNIQUE NOT NULL, -- Placa única del vehículo
    estado VARCHAR(20) DEFAULT 'Disponible' 
        CHECK (estado IN ('Disponible', 'Alquilado', 'Mantenimiento')), -- Estado actual del vehículo
    id_sucursal INT, -- Sucursal donde se encuentra el vehículo
    FOREIGN KEY (id_sucursal) REFERENCES Sucursal(id_sucursal) ON UPDATE CASCADE -- Relación con Sucursal
);

-- Tabla que almacena los alquileres realizados
CREATE TABLE Alquiler (
    id_alquiler INT PRIMARY KEY, -- Identificador único del alquiler
    id_cliente INT NOT NULL, -- Cliente que realiza el alquiler
    id_vehiculo INT NOT NULL, -- Vehículo alquilado
    fecha_inicio TIMESTAMP NOT NULL, -- Fecha y hora de inicio del alquiler
    fecha_fin TIMESTAMP NOT NULL, -- Fecha y hora de fin del alquiler
    total DECIMAL(10,2), -- Costo total del alquiler
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente) ON DELETE CASCADE, -- Relación con Cliente, eliminación en cascada
    FOREIGN KEY (id_vehiculo) REFERENCES Vehiculo(id_vehiculo) -- Relación con Vehículo
);

-- Tabla que almacena los pagos realizados por los alquileres
CREATE TABLE Pago (
    id_pago INT PRIMARY KEY, -- Identificador único del pago
    id_alquiler INT NOT NULL, -- Alquiler al que pertenece el pago
    fecha_pago TIMESTAMP NOT NULL, -- Fecha y hora en que se realizó el pago
    monto DECIMAL(10,2) NOT NULL CHECK (monto > 0), -- Monto pagado, debe ser positivo
    metodo_pago VARCHAR(50), -- Método de pago utilizado (efectivo, tarjeta, etc.)
    FOREIGN KEY (id_alquiler) REFERENCES Alquiler(id_alquiler) -- Relación con Alquiler
);
