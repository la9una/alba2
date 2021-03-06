SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Table `alba2`.`estado_alumno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`estado_alumno` ;

CREATE TABLE IF NOT EXISTS `alba2`.`estado_alumno` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `estado_alumno_descripcion_unique` (`descripcion` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`estado_documento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`estado_documento` ;

CREATE TABLE IF NOT EXISTS `alba2`.`estado_documento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `estado_documento_descripcion_unique` (`descripcion` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`sexo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`sexo` ;

CREATE TABLE IF NOT EXISTS `alba2`.`sexo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `abreviatura` VARCHAR(10) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `sexo_abreviatura_unique` (`abreviatura` ASC),
  UNIQUE INDEX `sexo_descripcion_unique` (`descripcion` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`tipo_documento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`tipo_documento` ;

CREATE TABLE IF NOT EXISTS `alba2`.`tipo_documento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(40) NOT NULL,
  `abreviatura` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tipo_documento_descripcion_unique` (`descripcion` ASC),
  UNIQUE INDEX `tipo_documento_abreviatura_unique` (`abreviatura` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`perfil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`perfil` ;

CREATE TABLE IF NOT EXISTS `alba2`.`perfil` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `apellido` VARCHAR(30) NOT NULL,
  `nombre` VARCHAR(30) NOT NULL,
  `tipo_documento_id` INT NOT NULL,
  `numero_documento` VARCHAR(30) NOT NULL,
  `estado_documento_id` INT NULL DEFAULT NULL,
  `sexo_id` INT NOT NULL,
  `fecha_nacimiento` DATE NULL DEFAULT NULL,
  `lugar_nacimiento` VARCHAR(255) NULL DEFAULT NULL,
  `telefono` VARCHAR(60) NULL DEFAULT NULL,
  `telefono_alternativo` VARCHAR(60) NULL DEFAULT NULL,
  `email` VARCHAR(99) NULL DEFAULT NULL,
  `fecha_alta` DATETIME NOT NULL,
  `foto` VARCHAR(255) NULL DEFAULT NULL,
  `observaciones` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `perfil_estado_documento_idx` (`estado_documento_id` ASC),
  INDEX `perfil_sexo_idx` (`sexo_id` ASC),
  INDEX `perfil_tipo_documento_idx` (`tipo_documento_id` ASC),
  CONSTRAINT `perfil_estado_documento_fk`
    FOREIGN KEY (`estado_documento_id`)
    REFERENCES `alba2`.`estado_documento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `perfil_sexo_fk`
    FOREIGN KEY (`sexo_id`)
    REFERENCES `alba2`.`sexo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `perfil_tipo_documento_fk`
    FOREIGN KEY (`tipo_documento_id`)
    REFERENCES `alba2`.`tipo_documento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`cuenta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`cuenta` ;

CREATE TABLE IF NOT EXISTS `alba2`.`cuenta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(99) NOT NULL,
  `codigo` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`alumno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`alumno` ;

CREATE TABLE IF NOT EXISTS `alba2`.`alumno` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `perfil_id` INT NOT NULL,
  `cuenta_id` INT NULL DEFAULT NULL,
  `estado_id` INT NOT NULL,
  `observaciones` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `alumno_perfil_idx` (`perfil_id` ASC),
  INDEX `alumno_estado_idx` (`estado_id` ASC),
  INDEX `alumno_cuenta_idx` (`cuenta_id` ASC),
  CONSTRAINT `alumno_estado_fk`
    FOREIGN KEY (`estado_id`)
    REFERENCES `alba2`.`estado_alumno` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `alumno_perfil_fk`
    FOREIGN KEY (`perfil_id`)
    REFERENCES `alba2`.`perfil` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `alumno_cuenta_fk`
    FOREIGN KEY (`cuenta_id`)
    REFERENCES `alba2`.`cuenta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`alumno_estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`alumno_estado` ;

CREATE TABLE IF NOT EXISTS `alba2`.`alumno_estado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `alumno_id` INT NOT NULL,
  `estado_id` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `alumno_estado_alumno_idx` (`alumno_id` ASC),
  INDEX `alumno_estado_estado_idx` (`estado_id` ASC),
  CONSTRAINT `alumno_estado_alumno_fk`
    FOREIGN KEY (`alumno_id`)
    REFERENCES `alba2`.`alumno` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `alumno_estado_estado_fk`
    FOREIGN KEY (`estado_id`)
    REFERENCES `alba2`.`estado_alumno` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`estado_ciclo_lectivo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`estado_ciclo_lectivo` ;

CREATE TABLE IF NOT EXISTS `alba2`.`estado_ciclo_lectivo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `estado_ciclo_lectivo_descripcion_unique` (`descripcion` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`nivel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`nivel` ;

CREATE TABLE IF NOT EXISTS `alba2`.`nivel` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nivel_descripcion_unique` (`descripcion` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`ciclo_lectivo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`ciclo_lectivo` ;

CREATE TABLE IF NOT EXISTS `alba2`.`ciclo_lectivo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `anio` SMALLINT(6) NOT NULL,
  `nivel_id` INT NOT NULL,
  `descripcion` VARCHAR(60) NULL DEFAULT NULL,
  `fecha_inicio` DATE NULL DEFAULT NULL,
  `fecha_fin` DATE NULL DEFAULT NULL,
  `estado_id` INT NOT NULL,
  `activo` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ciclo_lectivo_anio_nivel_unique` (`anio` ASC, `nivel_id` ASC),
  INDEX `ciclo_lectivo_nivel_idx` (`nivel_id` ASC),
  INDEX `ciclo_lectivo_estado_idx` (`estado_id` ASC),
  CONSTRAINT `ciclo_lectivo_estado_fk`
    FOREIGN KEY (`estado_id`)
    REFERENCES `alba2`.`estado_ciclo_lectivo` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `ciclo_lectivo_nivel_fk`
    FOREIGN KEY (`nivel_id`)
    REFERENCES `alba2`.`nivel` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`ciclo_lectivo_estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`ciclo_lectivo_estado` ;

CREATE TABLE IF NOT EXISTS `alba2`.`ciclo_lectivo_estado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ciclo_lectivo_id` INT NOT NULL,
  `estado_id` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `ciclo_lectivo_estado_ciclo_lectivo_idx` (`ciclo_lectivo_id` ASC),
  INDEX `ciclo_lectivo_estado_estado_idx` (`estado_id` ASC),
  CONSTRAINT `ciclo_lectivo_estado_ciclo_lectivo_fk`
    FOREIGN KEY (`ciclo_lectivo_id`)
    REFERENCES `alba2`.`ciclo_lectivo` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `ciclo_lectivo_estado_estado_fk`
    FOREIGN KEY (`estado_id`)
    REFERENCES `alba2`.`estado_ciclo_lectivo` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`pais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`pais` ;

CREATE TABLE IF NOT EXISTS `alba2`.`pais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `codigo` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `pais_nombre_unique` (`nombre` ASC),
  UNIQUE INDEX `pais_codigo_unique` (`codigo` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`provincia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`provincia` ;

CREATE TABLE IF NOT EXISTS `alba2`.`provincia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pais_id` INT NOT NULL,
  `nombre` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `provincia_unique` (`pais_id` ASC, `nombre` ASC),
  CONSTRAINT `provincia_pais_fk`
    FOREIGN KEY (`pais_id`)
    REFERENCES `alba2`.`pais` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`ciudad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`ciudad` ;

CREATE TABLE IF NOT EXISTS `alba2`.`ciudad` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `provincia_id` INT NOT NULL,
  `nombre` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ciudad_unique` (`provincia_id` ASC, `nombre` ASC),
  CONSTRAINT `ciudad_provincia_fk`
    FOREIGN KEY (`provincia_id`)
    REFERENCES `alba2`.`provincia` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`dependencia_organizativa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`dependencia_organizativa` ;

CREATE TABLE IF NOT EXISTS `alba2`.`dependencia_organizativa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(99) NOT NULL,
  `dependencia_padre_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `dependencia_organizativa_dependencia_padre_idx` (`dependencia_padre_id` ASC),
  CONSTRAINT `dependencia_organizativa_dependencia_padre_fk`
    FOREIGN KEY (`dependencia_padre_id`)
    REFERENCES `alba2`.`dependencia_organizativa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`establecimiento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`establecimiento` ;

CREATE TABLE IF NOT EXISTS `alba2`.`establecimiento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(99) NOT NULL,
  `codigo` VARCHAR(99) NOT NULL,
  `numero` VARCHAR(20) NULL,
  `telefono` VARCHAR(60) NULL,
  `telefono_alternativo` VARCHAR(60) NULL,
  `fax` VARCHAR(60) NULL,
  `email` VARCHAR(99) NULL,
  `sitio_web` VARCHAR(99) NULL,
  `dependencia_organizativa_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `establecimiento_dependencia_organizativa_idx` (`dependencia_organizativa_id` ASC),
  UNIQUE INDEX `establecimiento_codigo_unique` (`codigo` ASC),
  CONSTRAINT `establecimiento_dependencia_organizativa_fk`
    FOREIGN KEY (`dependencia_organizativa_id`)
    REFERENCES `alba2`.`dependencia_organizativa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`estado_plan_estudio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`estado_plan_estudio` ;

CREATE TABLE IF NOT EXISTS `alba2`.`estado_plan_estudio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(99) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `estado_plan_estudio_descripcion_unique` (`descripcion` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`plan_estudio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`plan_estudio` ;

CREATE TABLE IF NOT EXISTS `alba2`.`plan_estudio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nivel_id` INT NOT NULL,
  `codigo` VARCHAR(45) NOT NULL,
  `nombre_completo` VARCHAR(255) NOT NULL,
  `nombre_corto` VARCHAR(99) NOT NULL,
  `duracion` TINYINT NOT NULL,
  `estado_id` INT NOT NULL,
  `plan_estudio_origen_id` INT NULL DEFAULT NULL COMMENT 'Indica el plan de estudios original\nen caso de que el actual haya sido \ncreado a partir de otro existente.',
  `resoluciones` VARCHAR(255) NULL DEFAULT NULL,
  `normativas` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `plan_estudio_nivel_idx` (`nivel_id` ASC),
  UNIQUE INDEX `plan_estudio_codigo_unique` (`codigo` ASC),
  INDEX `plan_estudio_estado_idx` (`estado_id` ASC),
  INDEX `plan_estudio_plan_estudio_origen_idx` (`plan_estudio_origen_id` ASC),
  CONSTRAINT `plan_estudio_nivel_fk`
    FOREIGN KEY (`nivel_id`)
    REFERENCES `alba2`.`nivel` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `plan_estudio_estado_fk`
    FOREIGN KEY (`estado_id`)
    REFERENCES `alba2`.`estado_plan_estudio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `plan_estudio_plan_estudio_origen_fk`
    FOREIGN KEY (`plan_estudio_origen_id`)
    REFERENCES `alba2`.`plan_estudio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`anio_plan_estudio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`anio_plan_estudio` ;

CREATE TABLE IF NOT EXISTS `alba2`.`anio_plan_estudio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `plan_estudio_id` INT NOT NULL,
  `descripcion` VARCHAR(30) NOT NULL,
  `orden` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `plan_estudio_anio_plan_estudio_idx` (`plan_estudio_id` ASC),
  CONSTRAINT `plan_estudio_anio_plan_estudio_fk`
    FOREIGN KEY (`plan_estudio_id`)
    REFERENCES `alba2`.`plan_estudio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'es la tabla que configura los nombres de los años que se dan en cada plan de estudios';


-- -----------------------------------------------------
-- Table `alba2`.`tipo_responsable`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`tipo_responsable` ;

CREATE TABLE IF NOT EXISTS `alba2`.`tipo_responsable` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tipo_responsable_descripcion_unique` (`descripcion` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`nivel_instruccion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`nivel_instruccion` ;

CREATE TABLE IF NOT EXISTS `alba2`.`nivel_instruccion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nivel_instruccion_descripcion_unique` (`descripcion` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`actividad_responsable`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`actividad_responsable` ;

CREATE TABLE IF NOT EXISTS `alba2`.`actividad_responsable` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `actividad_responsable_descripcion_unique` (`descripcion` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`responsable`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`responsable` ;

CREATE TABLE IF NOT EXISTS `alba2`.`responsable` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `perfil_id` INT NOT NULL,
  `actividad_id` INT NOT NULL,
  `nivel_instruccion_id` INT NOT NULL,
  `tipo_responsable_id` INT NULL DEFAULT NULL,
  `ocupacion` VARCHAR(255) NULL DEFAULT NULL,
  `autorizado_retirar` TINYINT(1) NOT NULL DEFAULT 0,
  `vive` TINYINT(1) NOT NULL DEFAULT 1,
  `observaciones` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `responsable_unique` (`perfil_id` ASC),
  INDEX `responsable_tipo_responsable_idx` (`tipo_responsable_id` ASC),
  INDEX `responsable_nivel_instruccion_idx` (`nivel_instruccion_id` ASC),
  INDEX `responsable_actividad_responsable_idx` (`actividad_id` ASC),
  CONSTRAINT `responsable_tipo_responsable_fk`
    FOREIGN KEY (`tipo_responsable_id`)
    REFERENCES `alba2`.`tipo_responsable` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `responsable_perfil_fk`
    FOREIGN KEY (`perfil_id`)
    REFERENCES `alba2`.`perfil` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `responsable_nivel_instruccion_fk`
    FOREIGN KEY (`nivel_instruccion_id`)
    REFERENCES `alba2`.`nivel_instruccion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `responsable_actividad_fk`
    FOREIGN KEY (`actividad_id`)
    REFERENCES `alba2`.`actividad_responsable` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`sede`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`sede` ;

CREATE TABLE IF NOT EXISTS `alba2`.`sede` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `establecimiento_id` INT NOT NULL,
  `codigo` VARCHAR(99) NOT NULL,
  `nombre` VARCHAR(99) NOT NULL,
  `telefono` VARCHAR(60) NULL DEFAULT NULL,
  `telefono_alternativo` VARCHAR(60) NULL DEFAULT NULL,
  `fax` VARCHAR(60) NULL DEFAULT NULL,
  `principal` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `sede_unique` (`establecimiento_id` ASC, `nombre` ASC),
  UNIQUE INDEX `sede_codigo_unique` (`codigo` ASC),
  CONSTRAINT `sede_establecimiento_fk`
    FOREIGN KEY (`establecimiento_id`)
    REFERENCES `alba2`.`establecimiento` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`turno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`turno` ;

CREATE TABLE IF NOT EXISTS `alba2`.`turno` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `turno_descripcion_unique` (`descripcion` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`seccion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`seccion` ;

CREATE TABLE IF NOT EXISTS `alba2`.`seccion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sede_id` INT NOT NULL,
  `ciclo_lectivo_id` INT NOT NULL,
  `turno_id` INT NOT NULL,
  `anio_plan_estudio_id` INT NOT NULL,
  `identificador` VARCHAR(30) NOT NULL,
  `cupo_maximo` SMALLINT(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `seccion_unique` (`sede_id` ASC, `ciclo_lectivo_id` ASC, `turno_id` ASC, `anio_plan_estudio_id` ASC, `identificador` ASC),
  INDEX `seccion_turno_idx` (`turno_id` ASC),
  INDEX `seccion_anio_plan_estudio_idx` (`anio_plan_estudio_id` ASC),
  INDEX `seccion_ciclo_lectivo_idx` (`ciclo_lectivo_id` ASC),
  CONSTRAINT `seccion_anio_plan_estudio_fk`
    FOREIGN KEY (`anio_plan_estudio_id`)
    REFERENCES `alba2`.`anio_plan_estudio` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `seccion_sede_fk`
    FOREIGN KEY (`sede_id`)
    REFERENCES `alba2`.`sede` (`id`),
  CONSTRAINT `seccion_turno_fk`
    FOREIGN KEY (`turno_id`)
    REFERENCES `alba2`.`turno` (`id`),
  CONSTRAINT `seccion_ciclo_lectivo_fk`
    FOREIGN KEY (`ciclo_lectivo_id`)
    REFERENCES `alba2`.`ciclo_lectivo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`domicilio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`domicilio` ;

CREATE TABLE IF NOT EXISTS `alba2`.`domicilio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(99) NOT NULL,
  `cp` VARCHAR(30) NULL DEFAULT NULL,
  `pais_id` INT NULL DEFAULT NULL,
  `provincia_id` INT NULL DEFAULT NULL,
  `ciudad_id` INT NULL DEFAULT NULL,
  `principal` TINYINT(1) NOT NULL DEFAULT 1,
  `observaciones` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `sede_domicilio_pais_idx` (`pais_id` ASC),
  INDEX `sede_domicilio_provincia_idx` (`provincia_id` ASC),
  INDEX `sede_domicilio_ciudad_idx` (`ciudad_id` ASC),
  CONSTRAINT `sede_domicilio_ciudad_fk`
    FOREIGN KEY (`ciudad_id`)
    REFERENCES `alba2`.`ciudad` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `sede_domicilio_pais_fk`
    FOREIGN KEY (`pais_id`)
    REFERENCES `alba2`.`pais` (`id`),
  CONSTRAINT `sede_domicilio_provincia_fk`
    FOREIGN KEY (`provincia_id`)
    REFERENCES `alba2`.`provincia` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`servicio_salud`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`servicio_salud` ;

CREATE TABLE IF NOT EXISTS `alba2`.`servicio_salud` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(30) NOT NULL,
  `abreviatura` VARCHAR(30) NOT NULL,
  `nombre` VARCHAR(255) NOT NULL,
  `telefono` VARCHAR(60) NOT NULL,
  `telefono_alternativo` VARCHAR(60) NULL DEFAULT NULL,
  `email` VARCHAR(99) NULL DEFAULT NULL,
  `sitio_web` VARCHAR(99) NULL DEFAULT NULL,
  `observaciones` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `servicio_salud_codigo_unique` (`codigo` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`area_asignatura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`area_asignatura` ;

CREATE TABLE IF NOT EXISTS `alba2`.`area_asignatura` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  `nivel_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `area_asignatura_nivel_idx` (`nivel_id` ASC),
  CONSTRAINT `area_asignatura_nivel_fk`
    FOREIGN KEY (`nivel_id`)
    REFERENCES `alba2`.`nivel` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`asignatura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`asignatura` ;

CREATE TABLE IF NOT EXISTS `alba2`.`asignatura` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(99) NOT NULL,
  `nombre_corto` VARCHAR(45) NOT NULL,
  `area_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `asignatura_codigo_unique` (`codigo` ASC),
  INDEX `asignatura_area_idx` (`area_id` ASC),
  CONSTRAINT `asignatura_area_fk`
    FOREIGN KEY (`area_id`)
    REFERENCES `alba2`.`area_asignatura` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`asignatura_plan_estudio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`asignatura_plan_estudio` ;

CREATE TABLE IF NOT EXISTS `alba2`.`asignatura_plan_estudio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `plan_estudio_id` INT NOT NULL,
  `asignatura_id` INT NOT NULL,
  `anio_plan_estudio_id` INT NOT NULL,
  `carga_horaria_semanal` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `plan_estudio_asignatura_plan_estudio_idx` (`plan_estudio_id` ASC),
  INDEX `plan_estudio_asignatura_asignatura_idx` (`asignatura_id` ASC),
  INDEX `plan_estudio_asignatura_anio_plan_estudio_idx` (`anio_plan_estudio_id` ASC),
  CONSTRAINT `plan_estudio_asignatura_plan_estudio_fk`
    FOREIGN KEY (`plan_estudio_id`)
    REFERENCES `alba2`.`plan_estudio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `plan_estudio_asignatura_asignatura_fk`
    FOREIGN KEY (`asignatura_id`)
    REFERENCES `alba2`.`asignatura` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `plan_estudio_asignatura_anio_plan_estudio_fk`
    FOREIGN KEY (`anio_plan_estudio_id`)
    REFERENCES `alba2`.`anio_plan_estudio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`plan_estudio_estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`plan_estudio_estado` ;

CREATE TABLE IF NOT EXISTS `alba2`.`plan_estudio_estado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `plan_estudio_id` INT NOT NULL,
  `estado_id` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `plan_estudio_estado_plan_estudio_idx` (`plan_estudio_id` ASC),
  INDEX `plan_estudio_estado_estado_idx` (`estado_id` ASC),
  CONSTRAINT `plan_estudio_estado_plan_estudio_fk`
    FOREIGN KEY (`plan_estudio_id`)
    REFERENCES `alba2`.`plan_estudio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `plan_estudio_estado_estado_fk`
    FOREIGN KEY (`estado_id`)
    REFERENCES `alba2`.`estado_plan_estudio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`estado_inscripcion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`estado_inscripcion` ;

CREATE TABLE IF NOT EXISTS `alba2`.`estado_inscripcion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `estado_inscripcion_descripcion_unique` (`descripcion` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`condicion_inscripcion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`condicion_inscripcion` ;

CREATE TABLE IF NOT EXISTS `alba2`.`condicion_inscripcion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL COMMENT 'Repitiente\nReinscripto\nIngresante\nPromovido\nEn Compensación',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `condicion_inscripcion_descripcion_unique` (`descripcion` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`inscripcion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`inscripcion` ;

CREATE TABLE IF NOT EXISTS `alba2`.`inscripcion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `alumno_id` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `turno_id` INT NOT NULL COMMENT 'Turno de preferencia\n',
  `ciclo_lectivo_id` INT NOT NULL,
  `estado_id` INT NOT NULL,
  `sede_id` INT NOT NULL,
  `condicion_id` INT NULL DEFAULT NULL COMMENT 'Por ejemplo si es \nhermano de un alumno\nactual o hijo de \nun docente',
  `anio_plan_estudio_id` INT NULL DEFAULT NULL,
  `observaciones` VARCHAR(999) NULL,
  PRIMARY KEY (`id`),
  INDEX `inscripcion_alumno_idx` (`alumno_id` ASC),
  INDEX `inscripcion_plan_estudio_anio_idx` (`anio_plan_estudio_id` ASC),
  INDEX `inscripcion_turno_idx` (`turno_id` ASC),
  INDEX `inscripcion_estado_idx` (`estado_id` ASC),
  INDEX `inscripcion_sede_idx` (`sede_id` ASC),
  INDEX `inscripcion_ciclo_lectivo_idx` (`ciclo_lectivo_id` ASC),
  INDEX `inscripcion_condicion_idx` (`condicion_id` ASC),
  CONSTRAINT `inscripcion_alumno_fk`
    FOREIGN KEY (`alumno_id`)
    REFERENCES `alba2`.`alumno` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `inscripcion_anio_plan_estudio_fk`
    FOREIGN KEY (`anio_plan_estudio_id`)
    REFERENCES `alba2`.`anio_plan_estudio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `inscripcion_turno_fk`
    FOREIGN KEY (`turno_id`)
    REFERENCES `alba2`.`turno` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `inscripcion_estado_fk`
    FOREIGN KEY (`estado_id`)
    REFERENCES `alba2`.`estado_inscripcion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `inscripcion_sede_fk`
    FOREIGN KEY (`sede_id`)
    REFERENCES `alba2`.`sede` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `inscripcion_ciclo_lectivo_fk`
    FOREIGN KEY (`ciclo_lectivo_id`)
    REFERENCES `alba2`.`ciclo_lectivo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `inscripcion_condicion_fk`
    FOREIGN KEY (`condicion_id`)
    REFERENCES `alba2`.`condicion_inscripcion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`inscripcion_estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`inscripcion_estado` ;

CREATE TABLE IF NOT EXISTS `alba2`.`inscripcion_estado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `inscripcion_id` INT NOT NULL,
  `estado_id` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `inscripcion_estado_inscripcion_idx` (`inscripcion_id` ASC),
  INDEX `inscripcion_estado_estado_idx` (`estado_id` ASC),
  CONSTRAINT `inscripcion_estado_inscripcion_fk`
    FOREIGN KEY (`inscripcion_id`)
    REFERENCES `alba2`.`inscripcion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `inscripcion_estado_estado_fk`
    FOREIGN KEY (`estado_id`)
    REFERENCES `alba2`.`estado_inscripcion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`alumno_seccion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`alumno_seccion` ;

CREATE TABLE IF NOT EXISTS `alba2`.`alumno_seccion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `alumno_id` INT NOT NULL,
  `seccion_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `alumno_seccion_seccion_idx` (`seccion_id` ASC),
  INDEX `alumno_seccion_alumno_idx` (`alumno_id` ASC),
  UNIQUE INDEX `alumno_seccion_alumno_seccion_unique` (`alumno_id` ASC, `seccion_id` ASC),
  CONSTRAINT `alumno_seccion_seccion_fk`
    FOREIGN KEY (`seccion_id`)
    REFERENCES `alba2`.`seccion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `alumno_seccion_alumno_fk`
    FOREIGN KEY (`alumno_id`)
    REFERENCES `alba2`.`alumno` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`tipo_periodo_ciclo_lectivo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`tipo_periodo_ciclo_lectivo` ;

CREATE TABLE IF NOT EXISTS `alba2`.`tipo_periodo_ciclo_lectivo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  `periodos_por_ciclo` TINYINT NOT NULL,
  `nivel_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `tipo_periodo_nivel_idx` (`nivel_id` ASC),
  UNIQUE INDEX `tipo_periodo_descripcion_unique` (`descripcion` ASC),
  UNIQUE INDEX `tipo_periodo_nivel_unique` (`nivel_id` ASC),
  CONSTRAINT `tipo_periodo_nivel_fk`
    FOREIGN KEY (`nivel_id`)
    REFERENCES `alba2`.`nivel` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`estado_periodo_ciclo_lectivo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`estado_periodo_ciclo_lectivo` ;

CREATE TABLE IF NOT EXISTS `alba2`.`estado_periodo_ciclo_lectivo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `estado_periodo_ciclo_lectivo_descripcion_unique` (`descripcion` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`periodo_ciclo_lectivo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`periodo_ciclo_lectivo` ;

CREATE TABLE IF NOT EXISTS `alba2`.`periodo_ciclo_lectivo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ciclo_lectivo_id` INT NOT NULL,
  `tipo_periodo_id` INT NOT NULL,
  `fecha_inicio` DATE NULL DEFAULT NULL,
  `fecha_fin` DATE NULL DEFAULT NULL,
  `orden` TINYINT NOT NULL,
  `estado_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `periodo_ciclo_lectivo_ciclo_lectivo_idx` (`ciclo_lectivo_id` ASC),
  INDEX `periodo_ciclo_lectivo_tipo_periodo_idx` (`tipo_periodo_id` ASC),
  INDEX `periodo_ciclo_lectivo_estado_idx` (`estado_id` ASC),
  CONSTRAINT `periodo_ciclo_lectivo_ciclo_lectivo_fk`
    FOREIGN KEY (`ciclo_lectivo_id`)
    REFERENCES `alba2`.`ciclo_lectivo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `periodo_ciclo_lectivo_tipo_periodo_fk`
    FOREIGN KEY (`tipo_periodo_id`)
    REFERENCES `alba2`.`tipo_periodo_ciclo_lectivo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `periodo_ciclo_lectivo_estado_fk`
    FOREIGN KEY (`estado_id`)
    REFERENCES `alba2`.`estado_periodo_ciclo_lectivo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`docente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`docente` ;

CREATE TABLE IF NOT EXISTS `alba2`.`docente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `perfil_id` INT NOT NULL,
  `codigo` VARCHAR(255) NOT NULL,
  `observaciones` VARCHAR(999) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `docente_perfil_idx` (`perfil_id` ASC),
  UNIQUE INDEX `docente_codigo_unique` (`codigo` ASC),
  CONSTRAINT `docente_perfil_fk`
    FOREIGN KEY (`perfil_id`)
    REFERENCES `alba2`.`perfil` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`estado_docente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`estado_docente` ;

CREATE TABLE IF NOT EXISTS `alba2`.`estado_docente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `estado_docente_descripcion_unique` (`descripcion` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`docente_estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`docente_estado` ;

CREATE TABLE IF NOT EXISTS `alba2`.`docente_estado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `estado_id` INT NOT NULL,
  `docente_id` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  INDEX `docente_estado_docente_idx` (`docente_id` ASC),
  INDEX `docente_estado_estado_idx` (`estado_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `docente_estado_estado_fk`
    FOREIGN KEY (`estado_id`)
    REFERENCES `alba2`.`estado_docente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `docente_estado_docente_fk`
    FOREIGN KEY (`docente_id`)
    REFERENCES `alba2`.`docente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`tipo_designacion_docente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`tipo_designacion_docente` ;

CREATE TABLE IF NOT EXISTS `alba2`.`tipo_designacion_docente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tipo_designacion_docente_descripcion_unique` (`descripcion` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`estado_designacion_docente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`estado_designacion_docente` ;

CREATE TABLE IF NOT EXISTS `alba2`.`estado_designacion_docente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `estado_designacion_docente_descripcion_unique` (`descripcion` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`designacion_docente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`designacion_docente` ;

CREATE TABLE IF NOT EXISTS `alba2`.`designacion_docente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `docente_id` INT NOT NULL,
  `asignatura_plan_estudio_id` INT NOT NULL,
  `tipo_designacion_id` INT NOT NULL COMMENT '- Titular\n- Interino\n- Suplente',
  `fecha_inicio` DATE NULL DEFAULT NULL,
  `fecha_fin` DATE NULL DEFAULT NULL,
  `estado_id` INT NOT NULL,
  INDEX `designacion_docente_docente_idx` (`docente_id` ASC),
  PRIMARY KEY (`id`),
  INDEX `designacion_docente_tipo_designacion_idx` (`tipo_designacion_id` ASC),
  INDEX `designacion_docente_estado_idx` (`estado_id` ASC),
  INDEX `designacion_docente_asignatura_idx` (`asignatura_plan_estudio_id` ASC),
  CONSTRAINT `designacion_docente_docente_fk`
    FOREIGN KEY (`docente_id`)
    REFERENCES `alba2`.`docente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `designacion_docente_tipo_designacion_fk`
    FOREIGN KEY (`tipo_designacion_id`)
    REFERENCES `alba2`.`tipo_designacion_docente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `designacion_docente_estado_fk`
    FOREIGN KEY (`estado_id`)
    REFERENCES `alba2`.`estado_designacion_docente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `designacion_docente_asignatura_fk`
    FOREIGN KEY (`asignatura_plan_estudio_id`)
    REFERENCES `alba2`.`asignatura_plan_estudio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`documentacion_inscripcion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`documentacion_inscripcion` ;

CREATE TABLE IF NOT EXISTS `alba2`.`documentacion_inscripcion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `inscripcion_id` INT NOT NULL,
  `documento_alumno` TINYINT(1) NOT NULL,
  `certificado_nacimiento` TINYINT(1) NOT NULL,
  `documento_responsables` TINYINT(1) NOT NULL,
  `certificado_vacunas` TINYINT(1) NOT NULL,
  `planilla_completa` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `documentacion_inscripcion_inscripcion_idx` (`inscripcion_id` ASC),
  CONSTRAINT `documentacion_inscripcion_inscripcion_fk`
    FOREIGN KEY (`inscripcion_id`)
    REFERENCES `alba2`.`inscripcion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`estado_vacunacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`estado_vacunacion` ;

CREATE TABLE IF NOT EXISTS `alba2`.`estado_vacunacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `estado_vacunacion_descripcion_unique` (`descripcion` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`ficha_salud`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`ficha_salud` ;

CREATE TABLE IF NOT EXISTS `alba2`.`ficha_salud` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `alumno_id` INT NOT NULL,
  `servicio_salud_id` INT NULL DEFAULT NULL,
  `numero_afiliado` VARCHAR(99) NULL DEFAULT NULL,
  `estado_vacunacion_id` INT NOT NULL,
  `enfermedad` VARCHAR(255) NULL DEFAULT NULL,
  `internacion` VARCHAR(255) NULL DEFAULT NULL,
  `alergia` VARCHAR(255) NULL DEFAULT NULL,
  `tratamiento` VARCHAR(255) NULL DEFAULT NULL,
  `limitacion_fisica` VARCHAR(255) NULL DEFAULT NULL,
  `otros` VARCHAR(255) NULL DEFAULT NULL,
  `altura` VARCHAR(45) NULL DEFAULT NULL,
  `peso` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `ficha_salud_servicio_salud_idx` (`servicio_salud_id` ASC),
  INDEX `ficha_salud_estado_vacunacion_idx` (`estado_vacunacion_id` ASC),
  UNIQUE INDEX `ficha_salud_alumno_unique` (`alumno_id` ASC),
  CONSTRAINT `ficha_salud_servicio_salud_fk`
    FOREIGN KEY (`servicio_salud_id`)
    REFERENCES `alba2`.`servicio_salud` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ficha_salud_estado_vacunacion_fk`
    FOREIGN KEY (`estado_vacunacion_id`)
    REFERENCES `alba2`.`estado_vacunacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ficha_salud_alumno_fk`
    FOREIGN KEY (`alumno_id`)
    REFERENCES `alba2`.`alumno` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`tipo_contacto_emergencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`tipo_contacto_emergencia` ;

CREATE TABLE IF NOT EXISTS `alba2`.`tipo_contacto_emergencia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tipo_contacto_emergencia_descripcion_unique` (`descripcion` ASC))
ENGINE = InnoDB
COMMENT = '- Médico\n- Familiar\n- Institución';


-- -----------------------------------------------------
-- Table `alba2`.`contacto_emergencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`contacto_emergencia` ;

CREATE TABLE IF NOT EXISTS `alba2`.`contacto_emergencia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `alumno_id` INT NOT NULL,
  `tipo_contacto_emergencia_id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `domicilio` VARCHAR(99) NULL DEFAULT NULL,
  `telefono` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `contacto_emergencia_tipo_contacto_emergencia_idx` (`tipo_contacto_emergencia_id` ASC),
  INDEX `contacto_emergencia_alumno_idx` (`alumno_id` ASC),
  CONSTRAINT `contacto_emergencia_tipo_contacto_fk`
    FOREIGN KEY (`tipo_contacto_emergencia_id`)
    REFERENCES `alba2`.`tipo_contacto_emergencia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `contacto_emergencia_alumno_fk`
    FOREIGN KEY (`alumno_id`)
    REFERENCES `alba2`.`alumno` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`inscripcion_informacion_adicional`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`inscripcion_informacion_adicional` ;

CREATE TABLE IF NOT EXISTS `alba2`.`inscripcion_informacion_adicional` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `inscripcion_id` INT NOT NULL,
  `cantidad_hermanos` TINYINT NULL DEFAULT NULL,
  `hermanos_en_establecimiento` TINYINT NULL DEFAULT NULL,
  `distancia_establecimiento` VARCHAR(45) NULL DEFAULT NULL,
  `habitantes_hogar` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `inscripcion_informacion_adicional_inscripcion_idx` (`inscripcion_id` ASC),
  UNIQUE INDEX `inscripcion_informacion_adicional_inscripcion_unique` (`inscripcion_id` ASC),
  CONSTRAINT `inscripcion_informacion_adicional_inscripcion_fk`
    FOREIGN KEY (`inscripcion_id`)
    REFERENCES `alba2`.`inscripcion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`establecimiento_procedencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`establecimiento_procedencia` ;

CREATE TABLE IF NOT EXISTS `alba2`.`establecimiento_procedencia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `inscripcion_id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `nivel_id` INT NULL DEFAULT NULL,
  `pais_id` INT NULL DEFAULT NULL,
  `provincia_id` INT NULL DEFAULT NULL,
  `ciudad_id` INT NULL DEFAULT NULL,
  `establecimiento_id` INT NULL DEFAULT NULL,
  `observaciones` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  INDEX `establecimiento_procedencia_inscripcion_idx` (`inscripcion_id` ASC),
  INDEX `establecimiento_procedencia_pais_idx` (`pais_id` ASC),
  INDEX `establecimiento_procedencia_provincia_idx` (`provincia_id` ASC),
  INDEX `establecimiento_procedencia_ciudad_idx` (`ciudad_id` ASC),
  INDEX `establecimiento_procedencia_nivel_idx` (`nivel_id` ASC),
  INDEX `establecimiento_procedencia_establecimiento_idx` (`establecimiento_id` ASC),
  CONSTRAINT `establecimiento_procedencia_inscripcion_fk`
    FOREIGN KEY (`inscripcion_id`)
    REFERENCES `alba2`.`inscripcion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `establecimiento_procedencia_pais_fk`
    FOREIGN KEY (`pais_id`)
    REFERENCES `alba2`.`pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `establecimiento_procedencia_provincia_fk`
    FOREIGN KEY (`provincia_id`)
    REFERENCES `alba2`.`provincia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `establecimiento_procedencia_ciudad_fk`
    FOREIGN KEY (`ciudad_id`)
    REFERENCES `alba2`.`ciudad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `establecimiento_procedencia_nivel_fk`
    FOREIGN KEY (`nivel_id`)
    REFERENCES `alba2`.`nivel` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `establecimiento_procedencia_establecimiento_fk`
    FOREIGN KEY (`establecimiento_id`)
    REFERENCES `alba2`.`establecimiento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`actualizacion_salud`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`actualizacion_salud` ;

CREATE TABLE IF NOT EXISTS `alba2`.`actualizacion_salud` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ficha_salud_id` INT NOT NULL,
  `observaciones` VARCHAR(255) NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `actualizacion_salud_ficha_salud_idx` (`ficha_salud_id` ASC),
  CONSTRAINT `actualizacion_salud_ficha_salud_fk`
    FOREIGN KEY (`ficha_salud_id`)
    REFERENCES `alba2`.`ficha_salud` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`designacion_docente_seccion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`designacion_docente_seccion` ;

CREATE TABLE IF NOT EXISTS `alba2`.`designacion_docente_seccion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `designacion_docente_id` INT NOT NULL,
  `seccion_id` INT NOT NULL,
  `horas_semanales` TINYINT NULL DEFAULT NULL,
  INDEX `designacion_docente_seccion_seccion_idx` (`seccion_id` ASC),
  INDEX `designacion_docente_seccion_designacion_docente_idx` (`designacion_docente_id` ASC),
  PRIMARY KEY (`id`),
  INDEX `designacion_docente_seccion_unique` (`designacion_docente_id` ASC, `seccion_id` ASC),
  CONSTRAINT `designacion_docente_seccion_designacion_docente_fk`
    FOREIGN KEY (`designacion_docente_id`)
    REFERENCES `alba2`.`designacion_docente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `designacion_docente_seccion_seccion_fk`
    FOREIGN KEY (`seccion_id`)
    REFERENCES `alba2`.`seccion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`tipo_calificacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`tipo_calificacion` ;

CREATE TABLE IF NOT EXISTS `alba2`.`tipo_calificacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  `valor_aprobacion` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tipo_calificacion_descripcion_unique` (`descripcion` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`tipo_inasistencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`tipo_inasistencia` ;

CREATE TABLE IF NOT EXISTS `alba2`.`tipo_inasistencia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  `maximas_permitidas` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `descripcion_unique` (`descripcion` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`configuracion_plan_estudio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`configuracion_plan_estudio` ;

CREATE TABLE IF NOT EXISTS `alba2`.`configuracion_plan_estudio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `plan_estudio_id` INT NOT NULL,
  `tipo_calificacion_id` INT NOT NULL,
  `tipo_inasistencia_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `plan_estudio_configuracion_plan_estudio_idx` (`plan_estudio_id` ASC),
  INDEX `configuracion_plan_estudio_tipo_calificacion_idx` (`tipo_calificacion_id` ASC),
  INDEX `configuracion_plan_estudio_tipo_inasistencia_idx` (`tipo_inasistencia_id` ASC),
  UNIQUE INDEX `configuracion_plan_estudio_plan_estudio_unique` (`plan_estudio_id` ASC),
  CONSTRAINT `plan_estudio_configuracion_plan_estudio_fk`
    FOREIGN KEY (`plan_estudio_id`)
    REFERENCES `alba2`.`plan_estudio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `configuracion_plan_estudio_tipo_calificacion_fk`
    FOREIGN KEY (`tipo_calificacion_id`)
    REFERENCES `alba2`.`tipo_calificacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `configuracion_plan_estudio_tipo_inasistencia_fk`
    FOREIGN KEY (`tipo_inasistencia_id`)
    REFERENCES `alba2`.`tipo_inasistencia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`tipo_evaluacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`tipo_evaluacion` ;

CREATE TABLE IF NOT EXISTS `alba2`.`tipo_evaluacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tipo_evaluacion_descripcion_unique` (`descripcion` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`evaluacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`evaluacion` ;

CREATE TABLE IF NOT EXISTS `alba2`.`evaluacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo_evaluacion_id` INT NOT NULL,
  `periodo_ciclo_lectivo_id` INT NOT NULL,
  `seccion_id` INT NOT NULL,
  `docente_id` INT NOT NULL,
  `asignatura_plan_estudio_id` INT NOT NULL,
  `promedia` TINYINT(1) NOT NULL DEFAULT 1,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `evaluacion_tipo_evaluacion_idx` (`tipo_evaluacion_id` ASC),
  INDEX `evaluacion_periodo_ciclo_lectivo_idx` (`periodo_ciclo_lectivo_id` ASC),
  INDEX `evaluacion_seccion_idx` (`seccion_id` ASC),
  INDEX `evaluacion_docente_idx` (`docente_id` ASC),
  INDEX `evaluacion_asignatura_plan_estudio_idx` (`asignatura_plan_estudio_id` ASC),
  CONSTRAINT `evaluacion_tipo_evaluacion_fk`
    FOREIGN KEY (`tipo_evaluacion_id`)
    REFERENCES `alba2`.`tipo_evaluacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `evaluacion_periodo_ciclo_lectivo_fk`
    FOREIGN KEY (`periodo_ciclo_lectivo_id`)
    REFERENCES `alba2`.`periodo_ciclo_lectivo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `evaluacion_seccion_fk`
    FOREIGN KEY (`seccion_id`)
    REFERENCES `alba2`.`seccion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `evaluacion_docente_fk`
    FOREIGN KEY (`docente_id`)
    REFERENCES `alba2`.`docente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `evaluacion_asignatura_plan_estudio_fk`
    FOREIGN KEY (`asignatura_plan_estudio_id`)
    REFERENCES `alba2`.`asignatura_plan_estudio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`valor_calificacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`valor_calificacion` ;

CREATE TABLE IF NOT EXISTS `alba2`.`valor_calificacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo_calificacion_id` INT NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `valor_numerico` FLOAT NOT NULL,
  `orden` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `valor_calificacion_tipo_calificacion_idx` (`tipo_calificacion_id` ASC),
  UNIQUE INDEX `valor_calificacion_tipo_y_descripcion_unique` (`tipo_calificacion_id` ASC, `descripcion` ASC),
  CONSTRAINT `valor_calificacion_tipo_calificacion_fk`
    FOREIGN KEY (`tipo_calificacion_id`)
    REFERENCES `alba2`.`tipo_calificacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`calificacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`calificacion` ;

CREATE TABLE IF NOT EXISTS `alba2`.`calificacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `evaluacion_id` INT NOT NULL,
  `alumno_id` INT NOT NULL,
  `valor_calificacion_id` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `calificacion_evaluacion_idx` (`evaluacion_id` ASC),
  INDEX `calificacion_alumno_idx` (`alumno_id` ASC),
  INDEX `calificacion_valor_calificacion_idx` (`valor_calificacion_id` ASC),
  CONSTRAINT `calificacion_evaluacion_fk`
    FOREIGN KEY (`evaluacion_id`)
    REFERENCES `alba2`.`evaluacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `calificacion_alumno_fk`
    FOREIGN KEY (`alumno_id`)
    REFERENCES `alba2`.`alumno` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `calificacion_valor_calificacion_fk`
    FOREIGN KEY (`valor_calificacion_id`)
    REFERENCES `alba2`.`valor_calificacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`valor_inasistencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`valor_inasistencia` ;

CREATE TABLE IF NOT EXISTS `alba2`.`valor_inasistencia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo_inasistencia_id` INT NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `descripcion_larga` VARCHAR(45) NOT NULL,
  `valor_numerico` FLOAT NOT NULL,
  `orden` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `valor_inasistencia_tipo_inasistencia_idx` (`tipo_inasistencia_id` ASC),
  UNIQUE INDEX `valor_inasistencia_tipo_y_descripcion_unique` (`tipo_inasistencia_id` ASC, `descripcion` ASC),
  CONSTRAINT `valor_inasistencia_tipo_inasistencia_fk`
    FOREIGN KEY (`tipo_inasistencia_id`)
    REFERENCES `alba2`.`tipo_inasistencia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`inasistencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`inasistencia` ;

CREATE TABLE IF NOT EXISTS `alba2`.`inasistencia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `alumno_id` INT NOT NULL,
  `seccion_id` INT NOT NULL,
  `valor_inasistencia_id` INT NOT NULL,
  `justificada` TINYINT(1) NOT NULL DEFAULT 0,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `inasistencia_alumno_idx` (`alumno_id` ASC),
  INDEX `inasistencia_seccion_idx` (`seccion_id` ASC),
  INDEX `inasistencia_valor_inasistencia_idx` (`valor_inasistencia_id` ASC),
  CONSTRAINT `inasistencia_alumno_fk`
    FOREIGN KEY (`alumno_id`)
    REFERENCES `alba2`.`alumno` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `inasistencia_seccion_fk`
    FOREIGN KEY (`seccion_id`)
    REFERENCES `alba2`.`seccion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `inasistencia_valor_inasistencia_fk`
    FOREIGN KEY (`valor_inasistencia_id`)
    REFERENCES `alba2`.`valor_inasistencia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`ficha_alumno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`ficha_alumno` ;

CREATE TABLE IF NOT EXISTS `alba2`.`ficha_alumno` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `alumno_id` INT NOT NULL,
  `codigo` VARCHAR(255) NOT NULL,
  `informacion_sensible` MEDIUMTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ficha_alumno_unique` (`alumno_id` ASC),
  CONSTRAINT `ficha_alumno_alumno_fk`
    FOREIGN KEY (`alumno_id`)
    REFERENCES `alba2`.`alumno` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`tipo_incidencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`tipo_incidencia` ;

CREATE TABLE IF NOT EXISTS `alba2`.`tipo_incidencia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'Podría ser por ejemplo: \"Accidente\", \"Episodio de conducta\", etc.';


-- -----------------------------------------------------
-- Table `alba2`.`incidencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`incidencia` ;

CREATE TABLE IF NOT EXISTS `alba2`.`incidencia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `alumno_id` INT NOT NULL,
  `tipo_incidencia_id` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `detalle` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `incidencia_alumno_idx` (`alumno_id` ASC),
  INDEX `incidencia_tipo_incidencia_idx` (`tipo_incidencia_id` ASC),
  CONSTRAINT `incidencia_alumno_fk`
    FOREIGN KEY (`alumno_id`)
    REFERENCES `alba2`.`alumno` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `incidencia_tipo_incidencia_fk`
    FOREIGN KEY (`tipo_incidencia_id`)
    REFERENCES `alba2`.`tipo_incidencia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`seguimiento_incidencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`seguimiento_incidencia` ;

CREATE TABLE IF NOT EXISTS `alba2`.`seguimiento_incidencia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `incidencia_id` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `detalle` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `seguimiento_incidencia_incidencia_idx` (`incidencia_id` ASC),
  CONSTRAINT `seguimiento_incidencia_incidencia_fk`
    FOREIGN KEY (`incidencia_id`)
    REFERENCES `alba2`.`incidencia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`adjunto_seguimiento_incidencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`adjunto_seguimiento_incidencia` ;

CREATE TABLE IF NOT EXISTS `alba2`.`adjunto_seguimiento_incidencia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `seguimiento_incidencia_id` INT NOT NULL,
  `filename` VARCHAR(255) NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `adjunto_seguimiento_incidencia_seguimiento_incidencia_idx` (`seguimiento_incidencia_id` ASC),
  CONSTRAINT `adjunto_seguimiento_incidencia_seguimiento_incidencia_fk`
    FOREIGN KEY (`seguimiento_incidencia_id`)
    REFERENCES `alba2`.`seguimiento_incidencia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`sede_domicilio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`sede_domicilio` ;

CREATE TABLE IF NOT EXISTS `alba2`.`sede_domicilio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sede_id` INT NOT NULL,
  `domicilio_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `sede_domicilio_sede_idx` (`sede_id` ASC),
  INDEX `sede_domicilio_domicilio_idx` (`domicilio_id` ASC),
  UNIQUE INDEX `sede_domicilio_unique` (`sede_id` ASC, `domicilio_id` ASC),
  CONSTRAINT `sede_domicilio_sede_fk1`
    FOREIGN KEY (`sede_id`)
    REFERENCES `alba2`.`sede` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sede_domicilio_domicilio_fk1`
    FOREIGN KEY (`domicilio_id`)
    REFERENCES `alba2`.`domicilio` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`perfil_domicilio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`perfil_domicilio` ;

CREATE TABLE IF NOT EXISTS `alba2`.`perfil_domicilio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `perfil_id` INT NOT NULL,
  `domicilio_id` INT NOT NULL,
  INDEX `perfil_domicilio_domicilio_idx` (`domicilio_id` ASC),
  INDEX `perfil_domicilio_perfil_idx` (`perfil_id` ASC),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `perfil_domicilio_unique` (`perfil_id` ASC, `domicilio_id` ASC),
  CONSTRAINT `perfil_domicilio_perfil_fk`
    FOREIGN KEY (`perfil_id`)
    REFERENCES `alba2`.`perfil` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `perfil_domicilio_domicilio_fk`
    FOREIGN KEY (`domicilio_id`)
    REFERENCES `alba2`.`domicilio` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`servicio_salud_domicilio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`servicio_salud_domicilio` ;

CREATE TABLE IF NOT EXISTS `alba2`.`servicio_salud_domicilio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `servicio_salud_id` INT NOT NULL,
  `domicilio_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `servicio_salud_domicilio_domicilio_idx` (`domicilio_id` ASC),
  INDEX `servicio_salud_domicilio_servicio_salud_idx` (`servicio_salud_id` ASC),
  UNIQUE INDEX `servicio_salud_domicilio_unique` (`servicio_salud_id` ASC, `domicilio_id` ASC),
  CONSTRAINT `servicio_salud_domicilio_servicio_salud_fk`
    FOREIGN KEY (`servicio_salud_id`)
    REFERENCES `alba2`.`servicio_salud` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `servicio_salud_domicilio_domicilio_fk`
    FOREIGN KEY (`domicilio_id`)
    REFERENCES `alba2`.`domicilio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`servicio_salud_contacto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`servicio_salud_contacto` ;

CREATE TABLE IF NOT EXISTS `alba2`.`servicio_salud_contacto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `servicio_salud_domicilio_id` INT NOT NULL,
  `telefono` VARCHAR(60) NOT NULL,
  `telefono_alternativo` VARCHAR(60) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `servicio_salud_contacto_domicilio_idx` (`servicio_salud_domicilio_id` ASC),
  UNIQUE INDEX `servicio_salud_domicilio_unique` (`servicio_salud_domicilio_id` ASC),
  CONSTRAINT `servicio_salud_contacto_domicilio_fk`
    FOREIGN KEY (`servicio_salud_domicilio_id`)
    REFERENCES `alba2`.`servicio_salud_domicilio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`responsable_alumno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`responsable_alumno` ;

CREATE TABLE IF NOT EXISTS `alba2`.`responsable_alumno` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `responsable_id` INT NOT NULL,
  `alumno_id` INT NOT NULL,
  INDEX `responsable_alumno_alumno_idx` (`alumno_id` ASC),
  INDEX `responsable_alumno_responsable_idx` (`responsable_id` ASC),
  UNIQUE INDEX `responsable_alumno_unique` (`responsable_id` ASC, `alumno_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `responsable_alumno_responsable_fk`
    FOREIGN KEY (`responsable_id`)
    REFERENCES `alba2`.`responsable` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `responsable_alumno_alumno_fk`
    FOREIGN KEY (`alumno_id`)
    REFERENCES `alba2`.`alumno` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
