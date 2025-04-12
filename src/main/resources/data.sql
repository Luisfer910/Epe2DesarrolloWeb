/**
 * Author:  LFMG9
 * Created: 12-04-2025
 */
-- Insertar hoteles
INSERT INTO hoteles (nombre, direccion, ciudad, pais, estrellas, descripcion, servicios) VALUES
('Hotel Plaza', 'Av. Principal 123', 'Santiago', 'Chile', 4, 'Hotel de lujo en el centro de la ciudad', 'WiFi, Piscina, Gimnasio, Restaurante'),
('Hotel Costa Azul', 'Playa Blanca 456', 'Viña del Mar', 'Chile', 3, 'Hotel con vista al mar', 'WiFi, Playa privada, Restaurante'),
('Hotel Montaña', 'Camino del Bosque 789', 'Pucón', 'Chile', 5, 'Resort de lujo en la montaña', 'WiFi, Spa, Piscina, Gimnasio, Restaurante, Bar');

-- Insertar habitaciones
INSERT INTO habitaciones (numero, tipo, capacidad, precio, disponible, descripcion, hotel_id) VALUES
('101', 'Individual', 1, 50000, true, 'Habitación individual con cama twin', 1),
('102', 'Doble', 2, 80000, true, 'Habitación doble con cama matrimonial', 1),
('103', 'Suite', 4, 150000, true, 'Suite de lujo con jacuzzi', 1),
('201', 'Individual', 1, 45000, true, 'Habitación individual con vista al mar', 2),
('202', 'Doble', 2, 75000, true, 'Habitación doble con balcón', 2),
('203', 'Familiar', 4, 120000, true, 'Habitación familiar con dos camas dobles', 2),
('301', 'Individual', 1, 60000, true, 'Habitación individual con vista a la montaña', 3),
('302', 'Doble', 2, 90000, true, 'Habitación doble con chimenea', 3),
('303', 'Suite', 2, 180000, true, 'Suite de lujo con jacuzzi y vista panorámica', 3);

-- Insertar un usuario administrador (tabla usuarios, no users)
INSERT INTO usuarios (nombre, apellido, correo, contraseña, telefono) VALUES
('Admin', 'Sistema', 'admin@hotel.com', '$2a$10$3BDkzAcX1jUv.RxJvZgK7.Jue6Hx2WQw1ZZwQnvCPIx9ySEFQNPC2', '123456789');
-- La contraseña es "admin123" hasheada con BCrypt

