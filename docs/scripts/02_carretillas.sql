CREATE TABLE
    `products` (
        `productId` int(11) NOT NULL AUTO_INCREMENT,
        `productName` varchar(255) NOT NULL,
        `productDescription` text NOT NULL,
        `productPrice` decimal(10, 2) NOT NULL,
        `productImgUrl` varchar(255) NOT NULL,
        `productStock` int(11) NOT NULL DEFAULT 0,
        `productStatus` char(3) NOT NULL,
        PRIMARY KEY (`productId`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;

CREATE TABLE
    `carretilla` (
        `usercod` BIGINT(10) NOT NULL,
        `productId` int(11) NOT NULL,
        `crrctd` INT(5) NOT NULL,
        `crrprc` DECIMAL(12, 2) NOT NULL,
        `crrfching` DATETIME NOT NULL,
        PRIMARY KEY (`usercod`, `productId`),
        INDEX `productId_idx` (`productId` ASC),
        CONSTRAINT `carretilla_user_key` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT `carretilla_prd_key` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE NO ACTION ON UPDATE NO ACTION
    );

CREATE TABLE
    `carretillaanon` (
        `anoncod` varchar(128) NOT NULL,
        `productId` bigint(18) NOT NULL,
        `crrctd` int(5) NOT NULL,
        `crrprc` decimal(12, 2) NOT NULL,
        `crrfching` datetime NOT NULL,
        PRIMARY KEY (`anoncod`, `productId`),
        KEY `productId_idx` (`productId`),
        CONSTRAINT `carretillaanon_prd_key` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE NO ACTION ON UPDATE NO ACTION
    );

    drop table facturas;
    CREATE TAble Facturas(
    factura_Id int PRIMARY KEY AUTO_INCREMENT,
    orderIdPaypal VARCHAR(50) NOT NULL,
    captureIdPaypal VARCHAR(50) NOT NULL,
    fechaFactura DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    usuario_id bigint(10) not null,
    nombreCliente VARCHAR(120) Not Null,
    apellidoCliente VARCHAR(120) NOT NULL,
    total DECIMAL(12,2) NOT NULL,
    impuesto DECIMAL(12,2),
    moneda VARCHAR(5) DEFAULT 'USD',
    constraint fk_usuarioId FOREIGN KEY (usuario_id) REFERENCES usuario(usercod)
);

drop TABLE detalles_factura;

Create table detalles_factura(
    detalles_factura_id int PRIMARY KEY AUTO_INCREMENT,
    factura_id INT Not NULL,
    nombreProducto VARCHAR(255),
    sku VARCHAR(50),
    precio DECIMAL(12, 2),
    impuesto Decimal(12, 2),
    cantidad int,
    subtotal DECIMAL(12,2),

    constraint fk_facturaId FOREIGN KEY (factura_id) REFERENCES Facturas(factura_id)
);