CREATE DATABASE proyectoSA;

USE proyectoSA;

CREATE TABLE IF NOT EXISTS `Usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `contrasena` VARCHAR(45) NULL,
  `celular` VARCHAR(45) NULL,
  `foto` VARCHAR(500) NULL,
  `tipo_usuario` BOOLEAN NULL DEFAULT 0,
  PRIMARY KEY (`id`));


CREATE TABLE IF NOT EXISTS `Producto` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `imagen` VARCHAR(500) NULL,
  `valor_unitario` DECIMAL NOT NULL,
  `stock` INT NULL DEFAULT 0,
  `precio_cliente` DECIMAL NULL,
  `proveedor` INT NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_Producto_Usuario_idx` (`proveedor` ASC) VISIBLE,
  CONSTRAINT `fk_Producto_Usuario`
    FOREIGN KEY (`proveedor`)
    REFERENCES `Usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `Categoria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));


CREATE TABLE IF NOT EXISTS `Categoria_Producto` (
  `Producto_codigo` INT NOT NULL,
  `Categoria_id` INT NOT NULL,
  `visible` BOOLEAN NOT NULL DEFAULT 0,
  PRIMARY KEY (`Producto_codigo`, `Categoria_id`),
  INDEX `fk_Categoria_Producto_Categoria1_idx` (`Categoria_id` ASC) VISIBLE,
  CONSTRAINT `fk_Categoria_Producto_Producto1`
    FOREIGN KEY (`Producto_codigo`)
    REFERENCES `Producto` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Categoria_Producto_Categoria1`
    FOREIGN KEY (`Categoria_id`)
    REFERENCES `Categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `Tarjeta` (
  `numero` VARCHAR(45) NOT NULL,
  `caducidad` VARCHAR(45) NULL,
  `codigo` VARCHAR(45) NULL,
  `tipo_tarjeta` BOOLEAN NULL DEFAULT 0,
  `Usuario_id` INT NOT NULL,
  PRIMARY KEY (`numero`),
  INDEX `fk_Tarjeta_Usuario1_idx` (`Usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_Tarjeta_Usuario1`
    FOREIGN KEY (`Usuario_id`)
    REFERENCES `Usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `Carrito` (
  `idCarrito` INT NOT NULL,
  `Usuario_id` INT NOT NULL,
  `total` DECIMAL NULL,
  PRIMARY KEY (`idCarrito`),
  INDEX `fk_Carrito_Usuario1_idx` (`Usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_Carrito_Usuario1`
    FOREIGN KEY (`Usuario_id`)
    REFERENCES `Usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `Compra` (
  `id` INT NOT NULL,
  `idcarrito` INT NOT NULL,
  `fecha_compra` DATE NULL,
  `idtarjeta` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Compra_Carrito1_idx` (`idcarrito` ASC) VISIBLE,
  INDEX `fk_Compra_Tarjeta1_idx` (`idtarjeta` ASC) VISIBLE,
  CONSTRAINT `fk_Compra_Carrito1`
    FOREIGN KEY (`idcarrito`)
    REFERENCES `Carrito` (`idCarrito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Compra_Tarjeta1`
    FOREIGN KEY (`idtarjeta`)
    REFERENCES `Tarjeta` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `DetalleCarrito` (
  `codigoProducto` INT NOT NULL,
  `idCarrito` INT NOT NULL,
  `cantidad` INT NULL,
  `subtotal` DECIMAL NULL,
  PRIMARY KEY (`codigoProducto`, `idCarrito`),
  INDEX `fk_DetalleCarrito_Carrito1_idx` (`idCarrito` ASC) VISIBLE,
  CONSTRAINT `fk_DetalleCarrito_Producto1`
    FOREIGN KEY (`codigoProducto`)
    REFERENCES `Producto` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DetalleCarrito_Carrito1`
    FOREIGN KEY (`idCarrito`)
    REFERENCES `Carrito` (`idCarrito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


/* PROCEDIMIENTOS ALMACENADOS */

DELIMITER //
CREATE PROCEDURE crear_usuario (
  IN `p_nombre` VARCHAR(45),
  IN `p_apellido` VARCHAR(45),
  IN `p_email` VARCHAR(45),
  IN `p_contrasena` VARCHAR(45),
  IN `p_celular` VARCHAR(45),
  IN `p_foto` VARCHAR(500),
  IN `p_tipo_usuario` BOOLEAN)
BEGIN
  INSERT INTO Usuario (nombre, apellido, email, contrasena, celular, foto, tipo_usuario) VALUES (p_nombre, p_apellido, p_email, p_contrasena, p_celular, p_foto, p_tipo_usuario);
  SELECT * FROM Usuario WHERE email=p_email AND contrasena=p_contrasena;
END //
DELIMITER ;

/* CALL crear_usuario('Hugo', 'Figueroa', 'hfiguer.c97@gmail.com', '12345', '11111111', '', 1); */

DELIMITER //
CREATE PROCEDURE ver_usuario (
  IN `p_id_cliente` INT)
BEGIN
  SELECT * FROM Usuario WHERE id=p_id_cliente;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE login_usuario (
  IN `p_email` VARCHAR(45),
  IN `p_contrasena` VARCHAR(45))
BEGIN
  SELECT * FROM Usuario WHERE email=p_email AND contrasena=p_contrasena;
END //
DELIMITER ;