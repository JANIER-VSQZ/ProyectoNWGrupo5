-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-12-2025 a las 02:00:41
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ecommerce`
--
CREATE DATABASE IF NOT EXISTS `ecommerce` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `ecommerce`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bitacora`
--

CREATE TABLE `bitacora` (
  `bitacoracod` int(11) NOT NULL,
  `bitacorafch` datetime DEFAULT NULL,
  `bitprograma` varchar(255) DEFAULT NULL,
  `bitdescripcion` varchar(255) DEFAULT NULL,
  `bitobservacion` mediumtext DEFAULT NULL,
  `bitTipo` char(3) DEFAULT NULL,
  `bitusuario` bigint(18) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carretilla`
--

CREATE TABLE `carretilla` (
  `usercod` bigint(10) NOT NULL,
  `productId` int(11) NOT NULL,
  `crrctd` int(5) NOT NULL,
  `crrprc` decimal(12,2) NOT NULL,
  `crrfching` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `carretilla`
--

INSERT INTO `carretilla` (`usercod`, `productId`, `crrctd`, `crrprc`, `crrfching`) VALUES
(8, 2, 3, 200.00, '2025-12-11 17:40:20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carretillaanon`
--

CREATE TABLE `carretillaanon` (
  `anoncod` varchar(128) NOT NULL,
  `productId` int(11) NOT NULL,
  `crrctd` int(5) NOT NULL,
  `crrprc` decimal(12,2) NOT NULL,
  `crrfching` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_factura`
--

CREATE TABLE `detalles_factura` (
  `detalles_factura_id` int(11) NOT NULL,
  `factura_id` int(11) NOT NULL,
  `nombreProducto` varchar(255) DEFAULT NULL,
  `sku` varchar(50) DEFAULT NULL,
  `precio` decimal(12,2) DEFAULT NULL,
  `impuesto` decimal(12,2) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `subtotal` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalles_factura`
--

INSERT INTO `detalles_factura` (`detalles_factura_id`, `factura_id`, `nombreProducto`, `sku`, `precio`, `impuesto`, `cantidad`, `subtotal`) VALUES
(1, 2, 'Manzana', 'PRD1', 200.00, 15.00, 1, 215.00),
(2, 2, 'Lapiz', 'PRD2', 150.00, 7.50, 2, 315.00),
(3, 2, 'mouse', 'PRD3', 190.00, 7.00, 3, 591.00),
(4, 2, 'teclado', 'PRD4', 390.00, 15.00, 1, 405.00),
(5, 3, 'Manzana', 'PRD1', 200.00, 15.00, 1, 215.00),
(6, 3, 'Lapiz', 'PRD2', 150.00, 7.50, 2, 315.00),
(7, 3, 'mouse', 'PRD3', 190.00, 7.00, 3, 591.00),
(8, 3, 'teclado', 'PRD4', 390.00, 15.00, 1, 405.00),
(9, 4, 'Manzana', 'PRD1', 200.00, 15.00, 1, 215.00),
(10, 4, 'Lapiz', 'PRD2', 150.00, 7.50, 2, 315.00),
(11, 4, 'mouse', 'PRD3', 190.00, 7.00, 3, 591.00),
(12, 4, 'teclado', 'PRD4', 390.00, 15.00, 1, 405.00),
(13, 5, 'Cargador', '1', 585.00, 15.00, 1, 600.00),
(14, 5, 'Intercomunicador', '2', 2600.00, 50.00, 2, 5300.00),
(15, 6, 'Cargador', '1', 585.00, 15.00, 1, 600.00),
(16, 6, 'Intercomunicador', '2', 2600.00, 50.00, 2, 5300.00),
(17, 7, 'Cargador', '1', 585.00, 15.00, 1, 600.00),
(18, 7, 'Intercomunicador', '2', 2600.00, 50.00, 2, 5300.00),
(19, 8, 'Cargador', '1', 585.00, 15.00, 1, 600.00),
(20, 8, 'Intercomunicador', '2', 2600.00, 50.00, 2, 5300.00),
(21, 9, 'Cargador', '1', 585.00, 15.00, 1, 600.00),
(22, 9, 'Intercomunicador', '2', 2600.00, 50.00, 2, 5300.00),
(23, 10, 'Intercomunicador', '3', 2650.00, 397.50, 2, 6095.00),
(24, 10, 'Funda', '15', 580.00, 87.00, 1, 667.00),
(25, 11, 'Adaptador', '2', 200.00, 30.00, 1, 230.00),
(26, 12, 'Adaptador', '2', 200.00, 30.00, 1, 230.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas`
--

CREATE TABLE `facturas` (
  `factura_Id` int(11) NOT NULL,
  `orderIdPaypal` varchar(50) NOT NULL,
  `captureIdPaypal` varchar(50) NOT NULL,
  `fechaFactura` datetime NOT NULL DEFAULT current_timestamp(),
  `usuario_id` bigint(10) NOT NULL,
  `nombreCliente` varchar(120) NOT NULL,
  `apellidoCliente` varchar(120) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `impuesto` decimal(12,2) DEFAULT NULL,
  `moneda` varchar(5) DEFAULT 'USD'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `facturas`
--

INSERT INTO `facturas` (`factura_Id`, `orderIdPaypal`, `captureIdPaypal`, `fechaFactura`, `usuario_id`, `nombreCliente`, `apellidoCliente`, `total`, `impuesto`, `moneda`) VALUES
(1, '4SY23245UA1662421', '9LW1657834949021T', '2025-12-11 00:29:56', 5, 'John', 'Doe', 1526.00, 53.75, 'USD'),
(2, '4B813140048490053', '2VP95524EE690605P', '2025-12-11 00:33:29', 5, 'John', 'Doe', 1526.00, 53.75, 'USD'),
(3, '5E451407GA897844S', '6SA27168N89848308', '2025-12-11 08:26:36', 5, 'John', 'Doe', 1526.00, 53.75, 'USD'),
(4, '93475613952486233', '1JR33332L6411825P', '2025-12-11 11:04:38', 8, 'John', 'Doe', 1526.00, 53.75, 'USD'),
(5, '2EF15665YP9807514', '8A110481KW5649202', '2025-12-11 14:55:02', 8, 'John', 'Doe', 5900.00, 206.40, 'USD'),
(6, '97840963WA291181L', '1UU417517V175972R', '2025-12-11 14:56:51', 8, 'John', 'Doe', 5900.00, 206.40, 'USD'),
(7, '88W65985X5702105Y', '80R31087CX528432N', '2025-12-11 15:02:33', 8, 'John', 'Doe', 5900.00, 206.40, 'USD'),
(8, '0F079227817862906', '38370185WK697994Y', '2025-12-11 15:20:03', 8, 'John', 'Doe', 5900.00, 206.40, 'USD'),
(9, '93226337610248419', '1A306061MP4730808', '2025-12-11 15:22:14', 8, 'John', 'Doe', 5900.00, 206.40, 'USD'),
(10, '2DX9681906199694L', '7DW45199JA639510E', '2025-12-11 17:11:25', 8, 'John', 'Doe', 6762.00, 1014.30, 'USD'),
(11, '6HA4258674856494A', '7H441295GP7084629', '2025-12-11 18:48:35', 10, 'John', 'Doe', 230.00, 34.50, 'USD'),
(12, '59A73331888048712', '35871932NF503171P', '2025-12-11 18:51:05', 12, 'John', 'Doe', 230.00, 34.50, 'USD');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `funciones`
--

CREATE TABLE `funciones` (
  `fncod` varchar(255) NOT NULL,
  `fndsc` varchar(255) DEFAULT NULL,
  `fnest` char(3) DEFAULT NULL,
  `fntyp` char(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `funciones`
--

INSERT INTO `funciones` (`fncod`, `fndsc`, `fnest`, `fntyp`) VALUES
('Controllers\\Checkout\\Accept', 'Controllers\\Checkout\\Accept', 'ACT', 'CTR'),
('Controllers\\Checkout\\Checkout', 'Controllers\\Checkout\\Checkout', 'ACT', 'CTR'),
('Controllers\\Checkout\\Resumen', 'Controllers\\Checkout\\Resumen', 'ACT', 'CTR'),
('Controllers\\Facturas\\TabFacturas', 'Controllers\\Facturas\\TabFacturas', 'ACT', 'CTR'),
('Controllers\\Factura\\Factura', 'Controllers\\Factura\\Factura', 'ACT', 'CTR'),
('Controllers\\Rol\\RolList', 'Controllers\\Rol\\RolList', 'ACT', 'CTR'),
('Controllers\\Usuario\\UsuarioList', 'Controllers\\Usuario\\UsuarioList', 'ACT', 'CTR'),
('hola', 'para probar', 'ACT', '1'),
('Lista_Facturas', 'Lista_Facturas', 'ACT', 'MNU'),
('Lista_Funciones', 'Lista_Funciones', 'ACT', 'MNU'),
('Lista_Productos', 'Lista_Productos', 'ACT', 'MNU'),
('Lista_Roles', 'Lista_Roles', 'ACT', 'MNU'),
('Lista_Usuarios', 'Lista_Usuarios', 'ACT', 'MNU'),
('Menu_PaymentCheckout', 'Menu_PaymentCheckout', 'ACT', 'MNU'),
('perro', 'halador', '1', '1'),
('xd', 'se pego con un poste', 'ACT', 'USR');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `funciones_roles`
--

CREATE TABLE `funciones_roles` (
  `rolescod` varchar(128) NOT NULL,
  `fncod` varchar(255) NOT NULL,
  `fnrolest` char(3) DEFAULT NULL,
  `fnexp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `funciones_roles`
--

INSERT INTO `funciones_roles` (`rolescod`, `fncod`, `fnrolest`, `fnexp`) VALUES
('Admin', 'Controllers\\Checkout\\Accept', 'ACT', NULL),
('Admin', 'Controllers\\Checkout\\Checkout', 'ACT', NULL),
('Admin', 'Controllers\\Checkout\\Resumen', 'ACT', NULL),
('Admin', 'Controllers\\Facturas\\TabFacturas', 'ACT', NULL),
('Admin', 'Controllers\\Factura\\Factura', 'ACT', NULL),
('Admin', 'Controllers\\Rol\\RolList', 'ACT', NULL),
('Admin', 'Controllers\\Usuario\\UsuarioList', 'ACT', NULL),
('Admin', 'Lista_Facturas', 'ACT', NULL),
('Admin', 'Lista_Funciones', 'ACT', NULL),
('Admin', 'Lista_Productos', 'ACT', NULL),
('Admin', 'Lista_Roles', 'ACT', NULL),
('Admin', 'Lista_Usuarios', 'ACT', NULL),
('Cliente', 'Controllers\\Checkout\\Accept', 'ACT', NULL),
('Cliente', 'Controllers\\Checkout\\Checkout', 'ACT', NULL),
('Cliente', 'Controllers\\Checkout\\Resumen', 'ACT', NULL),
('Cliente', 'Controllers\\Facturas\\TabFacturas', 'ACT', NULL),
('Cliente', 'Controllers\\Factura\\Factura', 'ACT', NULL),
('Cliente', 'Lista_Facturas', 'ACT', NULL),
('jaja', 'Controllers\\Checkout\\Accept', 'ACT', NULL),
('jaja', 'Controllers\\Checkout\\Checkout', 'ACT', NULL),
('jaja', 'Controllers\\Checkout\\Resumen', 'ACT', NULL),
('jaja', 'Controllers\\Facturas\\TabFacturas', 'ACT', NULL),
('jaja', 'Controllers\\Rol\\RolList', 'ACT', NULL),
('jaja', 'Controllers\\Usuario\\UsuarioList', 'ACT', NULL),
('jaja', 'hola', 'ACT', NULL),
('jaja', 'Lista_Facturas', 'ACT', NULL),
('jaja', 'Lista_Roles', 'ACT', NULL),
('jaja', 'Menu_PaymentCheckout', 'ACT', NULL),
('jaja2', 'hola', 'ACT', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `products`
--

CREATE TABLE `products` (
  `productId` int(11) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `productDescription` text NOT NULL,
  `productPrice` decimal(10,2) NOT NULL,
  `productImgUrl` varchar(255) NOT NULL,
  `productStock` int(11) NOT NULL DEFAULT 0,
  `productStatus` char(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `products`
--

INSERT INTO `products` (`productId`, `productName`, `productDescription`, `productPrice`, `productImgUrl`, `productStock`, `productStatus`) VALUES
(1, 'Cargador', 'Cargador Samsung Tipo C 45W', 600.00, 'public/imgs/productos/cargador.jpg', 34, 'ACT'),
(2, 'Adaptador', 'Adaptador USB a C', 200.00, 'public/imgs/productos/adaptador.jpg', 33, 'ACT'),
(3, 'Intercomunicador', 'Intercomunicador con Video', 2650.00, 'public/imgs/productos/intercomunicador.jpg', 5, 'ACT'),
(4, 'Echo Show', 'Echo Show 5', 2500.00, 'public/imgs/productos/echoshow.jpg', 7, 'ACT'),
(5, 'Parlante', 'Parlante Pall Power Mini', 1600.00, 'public/imgs/productos/parlante.jpg', 12, 'ACT'),
(6, 'Cable', 'Cable XLR a XLR Roxtone', 450.00, 'public/imgs/productos/cablexlr.jpg', 44, 'ACT'),
(7, 'Audífonos', 'Audífonos kilpxtreme Style Inalámbrico', 1380.00, 'public/imgs/productos/audifonosklip.jpg', 13, 'ACT'),
(8, 'Cerradura Smart', 'Cerradura Smart Compatible con Alexa', 2890.00, 'public/imgs/productos/cerradura.jpg', 8, 'ACT'),
(9, 'Proyector RCA', 'Proyector RCA', 4500.00, 'public/imgs/productos/proyector.jpg', 8, 'ACT'),
(10, 'Cable RCA', 'Cable RCA a 3.5 Mivic\'s 6pm', 120.00, 'public/imgs/productos/cablerca.jpg', 24, 'ACT'),
(11, 'Router Cudy', 'Router Cudy 867MBPS, AC1200', 680.00, 'public/imgs/productos/routercudy.jpg', 10, 'ACT'),
(12, 'Silla Gamer', 'Silla Gamer Esscencial 220lb Nenotech', 2980.00, 'public/imgs/productos/sillagamer.jpg', 7, 'ACT'),
(13, 'Cable AUX', 'Cable Auxiliar para Iphone', 320.00, 'public/imgs/productos/cableaux.jpg', 23, 'ACT'),
(14, 'Adaptador HDMI', 'Adaptador Mini HDMI a HDMI', 250.00, 'public/imgs/productos/adaptadorhdmi.jpg', 24, 'ACT'),
(15, 'Funda', 'Funda para Laptop', 580.00, 'public/imgs/productos/funda.jpg', 8, 'ACT'),
(16, 'Cámara Inalámbrica', 'Cámara Inalámbrica Doble Lente', 1200.00, 'public/imgs/productos/camara.jpg', 6, 'ACT'),
(17, 'Memoria Micro SD', 'Memoria Micro SD 256GB Hikvision', 1490.00, 'public/imgs/productos/memoriamicrosd.jpg', 33, 'ACT'),
(18, 'Mueble', 'Mueble para Computadora', 1500.00, 'public/imgs/productos/mueble.jpg', 5, 'ACT'),
(19, 'Adaptador Mini HDMI', 'Adaptador Mini/Micro HDMI a HDMI', 250.00, 'public/imgs/productos/adaptadormini.jpg', 11, 'ACT'),
(20, 'Lámpara Solar', 'Lámpara Solar 90W', 1650.00, 'public/imgs/productos/lamparasolar.jpg', 23, 'ACT'),
(21, 'Parlante Bluetooth', 'Parlante Bluetooth Klipxtreme', 780.00, 'public/imgs/productos/parlantebluetooth.jpg', 44, 'ACT'),
(22, 'Memoria Micro SD', 'Memoria Micro SD 64GB Hiksemi', 190.00, 'public/imgs/productos/memoriamicrosd2.jpg', 44, 'ACT'),
(23, 'Cargador MagSafe', 'Cargador MagSafe', 350.00, 'public/imgs/productos/cargadormagsafe.jpg', 32, 'ACT'),
(24, 'Adaptador Bluetooth', 'Adaptador Bluetooth USB 4.0', 280.00, 'public/imgs/productos/adaptadorbluetooth.jpg', 23, 'ACT'),
(25, 'Router Cudy', 'Router Cudy AC1200 Gigabyt', 900.00, 'public/imgs/productos/routercudy2.jpg', 12, 'ACT'),
(26, 'Memoria USB', 'Memoria USB Hikvision 32GB de Metal', 190.00, 'public/imgs/productos/memoriausb.jpg', 45, 'ACT'),
(27, 'Proyector Epson', 'Proyector Epson 3000 Lumens', 13900.00, 'public/imgs/productos/proyectorepson.jpg', 5, 'ACT'),
(28, 'Lector Biométrico', 'Lector Biométrico 3nStar', 5800.00, 'public/imgs/productos/lectorbiometrico.jpg', 12, 'ACT'),
(29, 'Cámara Xiaomi', 'Cámara de Seguridad Xiaomi', 1500.00, 'public/imgs/productos/camaraseguridad.jpg', 23, 'ACT'),
(30, 'Repetidor Cudy', 'Repetidor Cudy 867MBPS AC1200', 950.00, 'public/imgs/productos/repetidorcudy.jpg', 14, 'ACT'),
(31, 'Cable Extensión HDMI', 'Cable Extensión HDMI Ugreen 2m', 220.00, 'public/imgs/productos/cableextension.jpg', 33, 'ACT'),
(32, 'Cable Audio', 'Cable de Audio 3.5mm a Doble Salida', 150.00, 'public/imgs/productos/cableaudio.jpg', 24, 'ACT'),
(33, 'Cámara Deportiva', 'Cámara Deportiva 4K Wi-Fi', 1500.00, 'public/imgs/productos/camaradeportiva.jpg', 34, 'ACT'),
(34, 'Router Mercusys', 'Router Mercusys Turbo Mbps330 High Power', 750.00, 'public/imgs/productos/routermercusys.jpg', 22, 'ACT'),
(35, 'Impresora Epson', 'Impresora Epson L5290', 12800.00, 'public/imgs/productos/impresoraepson.jpg', 5, 'ACT');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `rolescod` varchar(128) NOT NULL,
  `rolesdsc` varchar(45) DEFAULT NULL,
  `rolesest` char(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`rolescod`, `rolesdsc`, `rolesest`) VALUES
('Admin', 'Admin', 'ACT'),
('Cliente', 'Cliente', 'ACT'),
('jaja', 'capitan', 'ACT'),
('jaja2', 'capitan superior', 'ACT');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles_usuarios`
--

CREATE TABLE `roles_usuarios` (
  `usercod` bigint(10) NOT NULL,
  `rolescod` varchar(128) NOT NULL,
  `roleuserest` char(3) DEFAULT NULL,
  `roleuserfch` datetime DEFAULT NULL,
  `roleuserexp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `roles_usuarios`
--

INSERT INTO `roles_usuarios` (`usercod`, `rolescod`, `roleuserest`, `roleuserfch`, `roleuserexp`) VALUES
(1, 'jaja', 'INA', NULL, NULL),
(3, 'jaja', 'ACT', NULL, NULL),
(3, 'jaja2', 'ACT', NULL, NULL),
(4, 'jaja2', 'ACT', NULL, NULL),
(5, 'jaja', 'ACT', NULL, NULL),
(8, 'jaja', 'ACT', NULL, NULL),
(9, 'jaja', 'ACT', NULL, NULL),
(10, 'Admin', 'ACT', NULL, NULL),
(12, 'Cliente', 'ACT', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `usercod` bigint(10) NOT NULL,
  `useremail` varchar(80) DEFAULT NULL,
  `username` varchar(80) DEFAULT NULL,
  `userpswd` varchar(128) DEFAULT NULL,
  `userfching` datetime DEFAULT NULL,
  `userpswdest` char(3) DEFAULT NULL,
  `userpswdexp` datetime DEFAULT NULL,
  `userest` char(3) DEFAULT NULL,
  `useractcod` varchar(128) DEFAULT NULL,
  `userpswdchg` varchar(128) DEFAULT NULL,
  `usertipo` char(3) DEFAULT NULL COMMENT 'Tipo de Usuario, Normal, Consultor o Cliente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`usercod`, `useremail`, `username`, `userpswd`, `userfching`, `userpswdest`, `userpswdexp`, `userest`, `useractcod`, `userpswdchg`, `usertipo`) VALUES
(1, 'algo@algo.com', 'juan', '12345', '2025-11-14 06:05:00', 'ACT', '2025-11-22 03:06:00', 'ACT', '1214', '12412', 'CLI'),
(2, '', '', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', '', '', ''),
(3, 'juan@mecanico.com', 'pedro', '23421234', '2025-11-14 00:00:00', 'ACT', '2025-11-14 00:00:00', 'ACT', '12343', '213432', 'NOR'),
(4, 'juan2@mecanico.com', 'pedro', '23421234', '2025-11-14 10:49:00', 'ACT', '2025-11-14 10:49:00', 'ACT', '1234', '12421', 'NOR'),
(5, 'hola@hola.com', 'John Doe', '$2y$10$wNT9QfZitt6C1e1c7NiP7OJgj9U54VQCNiC1Hx0nxKNNjWC0CR0YS', '2025-12-10 09:54:02', 'ACT', '2026-03-10 00:00:00', 'ACT', 'cd7c7f655d0459d4151d6be98bcd004fa79654b673322100d32516042aebafbd', '2025-12-10 09:54:02', 'NOR'),
(7, 'juan3@mecanico.com', 'John Doe', '$2y$10$NNjOankZRjbagMsCA35kFOSDkWVWPnduDF8YCF81tHAWJ2fChy5YS', '2025-12-10 11:35:45', 'ACT', '2026-03-10 00:00:00', 'ACT', 'f60728cbbca401821adcb1bcdf9bf11adda6ee766168e5ce526ab6395c2df20a', '2025-12-10 11:35:45', 'CON'),
(8, 'algo2@algo.com', 'Janier Vasquez', '$2y$10$PVAVbQ390/WyI2Q2Lgf6qu53IpjYXCwYh.H0xl6.DFWFTe3tFbKQG', '2025-12-11 11:02:31', 'ACT', '2026-03-11 00:00:00', 'ACT', 'dc8afb32228f788e5a0076aa1e9fbb628f7738e15972726d7383d958bd5db28a', '2025-12-11 11:02:31', 'CLI'),
(9, 'vasquezjanier31@gmail.com', 'Janier Vasquez', '$2y$10$XgrMRFAbNR/f3cbvgVxOrOaTsEyDEWcyd5fJy/OBwFJ.VTp3f87lq', '2025-12-11 17:52:23', 'ACT', '2026-03-11 00:00:00', 'ACT', '3cd435ff45ac814d6fbe16fa90dcd5fafe7e5a15c1854c62b699ced993342ad9', '2025-12-11 17:52:23', 'CLI'),
(10, 'useradmin@gmail.com', 'Administrador', '$2y$10$PXVwqJ6DnvpgQIdNeivsMOCk/NMN2LqYmGrkKAo/BI3NbLPaFfw5q', '2025-12-11 18:41:16', 'ACT', '2026-03-11 00:00:00', 'ACT', 'f9f31a7a003a7fb5e4ea86b4af0eaec065704b0da31ad1206b1df5826b5cf4a5', '2025-12-11 18:41:16', 'CON'),
(11, 'vasquezjanier4@gmail.com', 'Cliente', '$2y$10$fdNnjXhh5B9ognbZ6dLGTuARYGT7zhAyE1lglGDfC3vHVDw57EIlO', '2025-12-11 18:44:52', 'ACT', '2026-03-11 00:00:00', 'ACT', '1af34255e804c74518b638eacefd763a35bd41eaaa2faef4fd9f5b3851d99d2f', '2025-12-11 18:44:52', 'CLI'),
(12, 'pedrofunez23@gmail.com', 'Cliente', '$2y$10$5IEZGQgrj6VKjc1Rgoxm7O6VFI87zW.S7chlr3Hp6/.zCNoh5T6Vy', '2025-12-11 18:45:59', 'ACT', '2026-03-11 00:00:00', 'ACT', 'dde6d593145876c346bdddfc902e2338b659ba61a6eb7bcdd9cb4fec3b42a9bd', '2025-12-11 18:45:59', 'CLI');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bitacora`
--
ALTER TABLE `bitacora`
  ADD PRIMARY KEY (`bitacoracod`);

--
-- Indices de la tabla `carretilla`
--
ALTER TABLE `carretilla`
  ADD PRIMARY KEY (`usercod`,`productId`),
  ADD KEY `productId_idx` (`productId`);

--
-- Indices de la tabla `carretillaanon`
--
ALTER TABLE `carretillaanon`
  ADD PRIMARY KEY (`anoncod`,`productId`),
  ADD KEY `productId_idx` (`productId`);

--
-- Indices de la tabla `detalles_factura`
--
ALTER TABLE `detalles_factura`
  ADD PRIMARY KEY (`detalles_factura_id`),
  ADD KEY `fk_facturaId` (`factura_id`);

--
-- Indices de la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD PRIMARY KEY (`factura_Id`),
  ADD KEY `fk_usuarioId` (`usuario_id`);

--
-- Indices de la tabla `funciones`
--
ALTER TABLE `funciones`
  ADD PRIMARY KEY (`fncod`);

--
-- Indices de la tabla `funciones_roles`
--
ALTER TABLE `funciones_roles`
  ADD PRIMARY KEY (`rolescod`,`fncod`),
  ADD KEY `rol_funcion_key_idx` (`fncod`);

--
-- Indices de la tabla `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`productId`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`rolescod`);

--
-- Indices de la tabla `roles_usuarios`
--
ALTER TABLE `roles_usuarios`
  ADD PRIMARY KEY (`usercod`,`rolescod`),
  ADD KEY `rol_usuario_key_idx` (`rolescod`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usercod`),
  ADD UNIQUE KEY `useremail_UNIQUE` (`useremail`),
  ADD KEY `usertipo` (`usertipo`,`useremail`,`usercod`,`userest`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bitacora`
--
ALTER TABLE `bitacora`
  MODIFY `bitacoracod` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `detalles_factura`
--
ALTER TABLE `detalles_factura`
  MODIFY `detalles_factura_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `facturas`
--
ALTER TABLE `facturas`
  MODIFY `factura_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `products`
--
ALTER TABLE `products`
  MODIFY `productId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `usercod` bigint(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carretilla`
--
ALTER TABLE `carretilla`
  ADD CONSTRAINT `carretilla_prd_key` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `carretilla_user_key` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `carretillaanon`
--
ALTER TABLE `carretillaanon`
  ADD CONSTRAINT `carretillaanon_prd_key` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalles_factura`
--
ALTER TABLE `detalles_factura`
  ADD CONSTRAINT `fk_facturaId` FOREIGN KEY (`factura_id`) REFERENCES `facturas` (`factura_Id`);

--
-- Filtros para la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD CONSTRAINT `fk_usuarioId` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`usercod`);

--
-- Filtros para la tabla `funciones_roles`
--
ALTER TABLE `funciones_roles`
  ADD CONSTRAINT `funcion_rol_key` FOREIGN KEY (`rolescod`) REFERENCES `roles` (`rolescod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `rol_funcion_key` FOREIGN KEY (`fncod`) REFERENCES `funciones` (`fncod`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `roles_usuarios`
--
ALTER TABLE `roles_usuarios`
  ADD CONSTRAINT `rol_usuario_key` FOREIGN KEY (`rolescod`) REFERENCES `roles` (`rolescod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `usuario_rol_key` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
