begin transaction;

CREATE TABLE `gestione_film_sql`.`Attore` (
  `idAttore` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `anno_nascita` INT NOT NULL,
  `nazionalita` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAttore`));

CREATE TABLE `gestione_film_sql`.`Film` (
  `idFilm` INT NOT NULL,
  `titolo` VARCHAR(45) NOT NULL,
  `anno_produzione` INT NOT NULL,
  `nazionalita` VARCHAR(45) NOT NULL,
  `regista` VARCHAR(45) NOT NULL,
  `nazionalita` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFilm`));

CREATE TABLE `gestione_film_sql`.`Attore_film` (
  `id_attore` INT NOT NULL,
  `id_film` INT NOT NULL,
  INDEX `id_attore_idx` (`id_attore` ASC) VISIBLE,
  INDEX `id_film_idx` (`id_film` ASC) VISIBLE,
  CONSTRAINT `id_attore`
    FOREIGN KEY (`id_attore`)
    REFERENCES `gestione_film_sql`.`Attore` (`idAttore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_film`
    FOREIGN KEY (`id_film`)
    REFERENCES `gestione_film_sql`.`Film` (`idFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `gestione_film_sql`.`Sala` (
  `idSala` INT NOT NULL,
  `posti` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `citta` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSala`));

CREATE TABLE `gestione_film_sql`.`Proiezione` (
  `idProiezione` INT NOT NULL,
  `idfilm` INT NOT NULL,
  `idsala` INT NOT NULL,
  `incasso` INT NOT NULL,
  `data_proiezione` DATE NOT NULL,
  PRIMARY KEY (`idProiezione`),
  INDEX `fk_Proiezione_1_idx` (`idfilm` ASC) VISIBLE,
  INDEX `idsala_idx` (`idsala` ASC) VISIBLE,
  CONSTRAINT `idfilm`
    FOREIGN KEY (`idfilm`)
    REFERENCES `gestione_film_sql`.`Film` (`idFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idsala`
    FOREIGN KEY (`idsala`)
    REFERENCES `gestione_film_sql`.`Sala` (`idSala`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

commit;