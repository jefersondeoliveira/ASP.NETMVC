SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `ERP` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `ERP` ;

-- -----------------------------------------------------
-- Table `ERP`.`Estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ERP`.`Estado` ;

CREATE  TABLE IF NOT EXISTS `ERP`.`Estado` (
  `idEstado` INT NOT NULL ,
  `Nome` VARCHAR(50) NOT NULL ,
  `Sigla` CHAR(2) NOT NULL ,
  PRIMARY KEY (`idEstado`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP`.`Cidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ERP`.`Cidade` ;

CREATE  TABLE IF NOT EXISTS `ERP`.`Cidade` (
  `idCidade` INT NOT NULL ,
  `Nome` VARCHAR(60) NOT NULL ,
  `IdEstado` INT NOT NULL ,
  PRIMARY KEY (`idCidade`) ,
  INDEX `fk_Cidade_Estado1_idx` (`IdEstado` ASC) ,
  CONSTRAINT `fk_Cidade_Estado1`
    FOREIGN KEY (`IdEstado` )
    REFERENCES `ERP`.`Estado` (`idEstado` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP`.`Pessoa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ERP`.`Pessoa` ;

CREATE  TABLE IF NOT EXISTS `ERP`.`Pessoa` (
  `IdPessoa` INT NOT NULL AUTO_INCREMENT ,
  `Nome` VARCHAR(60) NOT NULL ,
  `DataCadastro` DATETIME NOT NULL ,
  `Rua` VARCHAR(50) NULL ,
  `Numero` VARCHAR(10) NULL ,
  `bairro` VARCHAR(50) NULL ,
  `CEP` CHAR(8) NULL ,
  `TelefoneComercial` CHAR(10) NULL ,
  `TelefoneCelular` CHAR(10) NULL ,
  `IdCidade` INT NOT NULL ,
  PRIMARY KEY (`IdPessoa`) ,
  INDEX `fk_Pessoa_Cidade1_idx` (`IdCidade` ASC) ,
  CONSTRAINT `fk_Pessoa_Cidade1`
    FOREIGN KEY (`IdCidade` )
    REFERENCES `ERP`.`Cidade` (`idCidade` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP`.`PessoaFisica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ERP`.`PessoaFisica` ;

CREATE  TABLE IF NOT EXISTS `ERP`.`PessoaFisica` (
  `IdPessoa` INT NOT NULL ,
  `DataNascimento` DATETIME NOT NULL ,
  `CPF` CHAR(11) NOT NULL ,
  `TelefoneResidencial` CHAR(11) NULL ,
  `RG` VARCHAR(20) NULL ,
  PRIMARY KEY (`IdPessoa`) ,
  CONSTRAINT `fk_PessoaFisica_Pessoa`
    FOREIGN KEY (`IdPessoa` )
    REFERENCES `ERP`.`Pessoa` (`IdPessoa` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP`.`PessoaJuridica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ERP`.`PessoaJuridica` ;

CREATE  TABLE IF NOT EXISTS `ERP`.`PessoaJuridica` (
  `IdPessoa` INT NOT NULL ,
  `CNPJ` CHAR(14) NOT NULL ,
  `NomeFantasia` VARCHAR(60) NOT NULL ,
  PRIMARY KEY (`IdPessoa`) ,
  INDEX `fk_PessoaJuridica_Pessoa1_idx` (`IdPessoa` ASC) ,
  CONSTRAINT `fk_PessoaJuridica_Pessoa1`
    FOREIGN KEY (`IdPessoa` )
    REFERENCES `ERP`.`Pessoa` (`IdPessoa` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP`.`Departamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ERP`.`Departamento` ;

CREATE  TABLE IF NOT EXISTS `ERP`.`Departamento` (
  `idDepartamento` INT NOT NULL AUTO_INCREMENT ,
  `Descricao` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`idDepartamento`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP`.`Cargo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ERP`.`Cargo` ;

CREATE  TABLE IF NOT EXISTS `ERP`.`Cargo` (
  `IdCargo` INT NOT NULL AUTO_INCREMENT ,
  `Descricao` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`IdCargo`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP`.`Funcionario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ERP`.`Funcionario` ;

CREATE  TABLE IF NOT EXISTS `ERP`.`Funcionario` (
  `DataAdmissao` DATETIME NOT NULL ,
  `DataDemissao` DATETIME NULL ,
  `Salario` DECIMAL NULL ,
  `IdFuncionario` INT NOT NULL ,
  `IdDepartamento` INT NOT NULL ,
  `IdCargo` INT NOT NULL ,
  PRIMARY KEY (`IdFuncionario`) ,
  INDEX `fk_Funcionario_Departamento1_idx` (`IdDepartamento` ASC) ,
  INDEX `fk_Funcionario_Cargo1_idx` (`IdCargo` ASC) ,
  CONSTRAINT `fk_Funcionario_PessoaFisica1`
    FOREIGN KEY (`IdFuncionario` )
    REFERENCES `ERP`.`PessoaFisica` (`IdPessoa` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcionario_Departamento1`
    FOREIGN KEY (`IdDepartamento` )
    REFERENCES `ERP`.`Departamento` (`idDepartamento` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcionario_Cargo1`
    FOREIGN KEY (`IdCargo` )
    REFERENCES `ERP`.`Cargo` (`IdCargo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP`.`FuncionarioPagamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ERP`.`FuncionarioPagamento` ;

CREATE  TABLE IF NOT EXISTS `ERP`.`FuncionarioPagamento` (
  `IdMes` INT NOT NULL ,
  `MesReferencia` DATETIME NULL ,
  `TotalHoraExtra` DECIMAL(5,2) NULL ,
  `DataPagamentol` DATETIME NULL ,
  `ValorPagamento` DECIMAL(8,2) NULL ,
  `IdPessoa` INT NOT NULL ,
  PRIMARY KEY (`IdMes`) ,
  INDEX `fk_FuncionarioPagamento_Funcionario1_idx` (`IdPessoa` ASC) ,
  CONSTRAINT `fk_FuncionarioPagamento_Funcionario1`
    FOREIGN KEY (`IdPessoa` )
    REFERENCES `ERP`.`Funcionario` (`IdFuncionario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP`.`TipoMovimento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ERP`.`TipoMovimento` ;

CREATE  TABLE IF NOT EXISTS `ERP`.`TipoMovimento` (
  `IdTipoMovimento` INT NOT NULL AUTO_INCREMENT ,
  `Descricao` VARCHAR(50) NOT NULL ,
  `OperacaoEstoque` CHAR(1) NOT NULL ,
  `EntregaFornecedor` TINYINT(1) NULL ,
  `SolicitanteInterno` TINYINT(1) NULL ,
  `PedidoCliente` TINYINT(1) NULL ,
  PRIMARY KEY (`IdTipoMovimento`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP`.`FormaPagamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ERP`.`FormaPagamento` ;

CREATE  TABLE IF NOT EXISTS `ERP`.`FormaPagamento` (
  `idFormaPagamento` INT NOT NULL AUTO_INCREMENT ,
  `Descricao` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idFormaPagamento`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP`.`Movimento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ERP`.`Movimento` ;

CREATE  TABLE IF NOT EXISTS `ERP`.`Movimento` (
  `idMovimento` INT NOT NULL AUTO_INCREMENT ,
  `Data` DATETIME NOT NULL ,
  `IdTipoMovimento` INT NOT NULL ,
  `IdFormaPagamento` INT NOT NULL ,
  `IdPessoa` INT NOT NULL ,
  PRIMARY KEY (`idMovimento`) ,
  INDEX `fk_Movimento_TipoMovimento1_idx` (`IdTipoMovimento` ASC) ,
  INDEX `fk_Movimento_FormaPagamento1_idx` (`IdFormaPagamento` ASC) ,
  INDEX `fk_Movimento_Pessoa1_idx` (`IdPessoa` ASC) ,
  CONSTRAINT `fk_Movimento_TipoMovimento1`
    FOREIGN KEY (`IdTipoMovimento` )
    REFERENCES `ERP`.`TipoMovimento` (`IdTipoMovimento` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Movimento_FormaPagamento1`
    FOREIGN KEY (`IdFormaPagamento` )
    REFERENCES `ERP`.`FormaPagamento` (`idFormaPagamento` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Movimento_Pessoa1`
    FOREIGN KEY (`IdPessoa` )
    REFERENCES `ERP`.`Pessoa` (`IdPessoa` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP`.`TipoItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ERP`.`TipoItem` ;

CREATE  TABLE IF NOT EXISTS `ERP`.`TipoItem` (
  `idTipoItem` INT NOT NULL AUTO_INCREMENT ,
  `Descricao` VARCHAR(45) NULL ,
  PRIMARY KEY (`idTipoItem`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP`.`Unidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ERP`.`Unidade` ;

CREATE  TABLE IF NOT EXISTS `ERP`.`Unidade` (
  `idUnidade` INT NOT NULL AUTO_INCREMENT ,
  `Descricao` VARCHAR(45) NULL ,
  PRIMARY KEY (`idUnidade`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP`.`LinhaItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ERP`.`LinhaItem` ;

CREATE  TABLE IF NOT EXISTS `ERP`.`LinhaItem` (
  `idLinhaItem` INT NOT NULL AUTO_INCREMENT ,
  `Descricao` VARCHAR(45) NULL ,
  PRIMARY KEY (`idLinhaItem`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP`.`Item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ERP`.`Item` ;

CREATE  TABLE IF NOT EXISTS `ERP`.`Item` (
  `idItem` INT NOT NULL AUTO_INCREMENT ,
  `Descricao` VARCHAR(60) NULL ,
  `QuantidadeMinimaEstoque` DECIMAL(7,2) NULL ,
  `IdTipoItem` INT NOT NULL ,
  `IdUnidade` INT NOT NULL ,
  `IdLinhaItem` INT NOT NULL ,
  PRIMARY KEY (`idItem`) ,
  INDEX `fk_Item_TipoItem1_idx` (`IdTipoItem` ASC) ,
  INDEX `fk_Item_Unidade1_idx` (`IdUnidade` ASC) ,
  INDEX `fk_Item_LinhaItem1_idx` (`IdLinhaItem` ASC) ,
  CONSTRAINT `fk_Item_TipoItem1`
    FOREIGN KEY (`IdTipoItem` )
    REFERENCES `ERP`.`TipoItem` (`idTipoItem` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_Unidade1`
    FOREIGN KEY (`IdUnidade` )
    REFERENCES `ERP`.`Unidade` (`idUnidade` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_LinhaItem1`
    FOREIGN KEY (`IdLinhaItem` )
    REFERENCES `ERP`.`LinhaItem` (`idLinhaItem` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP`.`MovimentoItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ERP`.`MovimentoItem` ;

CREATE  TABLE IF NOT EXISTS `ERP`.`MovimentoItem` (
  `IdItem` INT NOT NULL ,
  `IdMovimento` INT NOT NULL ,
  `Quantidade` DECIMAL(7,2) NOT NULL ,
  `ValorUnitario` DECIMAL(8,2) NOT NULL ,
  PRIMARY KEY (`IdItem`, `IdMovimento`) ,
  INDEX `fk_Item_has_Movimento_Movimento1_idx` (`IdMovimento` ASC) ,
  INDEX `fk_Item_has_Movimento_Item1_idx` (`IdItem` ASC) ,
  CONSTRAINT `fk_Item_has_Movimento_Item1`
    FOREIGN KEY (`IdItem` )
    REFERENCES `ERP`.`Item` (`idItem` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_has_Movimento_Movimento1`
    FOREIGN KEY (`IdMovimento` )
    REFERENCES `ERP`.`Movimento` (`idMovimento` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP`.`Conta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ERP`.`Conta` ;

CREATE  TABLE IF NOT EXISTS `ERP`.`Conta` (
  `IdConta` INT NOT NULL AUTO_INCREMENT ,
  `Descricao` VARCHAR(45) NULL ,
  `Tipo` SMALLINT NULL ,
  PRIMARY KEY (`IdConta`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP`.`Lancamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ERP`.`Lancamento` ;

CREATE  TABLE IF NOT EXISTS `ERP`.`Lancamento` (
  `IdLancamento` INT NOT NULL AUTO_INCREMENT ,
  `DataPagamento` DATETIME NULL ,
  `DataVencimento` DATETIME NULL ,
  `Valor` DECIMAL(8,2) NULL ,
  `ValorBaixa` DECIMAL(8,2) NULL ,
  `IdParcela` SMALLINT NULL ,
  `Tipo` SMALLINT NULL ,
  `IdConta` INT NULL ,
  `IdMovimento` INT NULL ,
  `IdPessoa` INT NULL ,
  PRIMARY KEY (`IdLancamento`) ,
  INDEX `fk_Lancamento_Conta1_idx` (`IdConta` ASC) ,
  INDEX `fk_Lancamento_Movimento1_idx` (`IdMovimento` ASC) ,
  INDEX `fk_Lancamento_Pessoa1_idx` (`IdPessoa` ASC) ,
  CONSTRAINT `fk_Lancamento_Conta1`
    FOREIGN KEY (`IdConta` )
    REFERENCES `ERP`.`Conta` (`IdConta` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Lancamento_Movimento1`
    FOREIGN KEY (`IdMovimento` )
    REFERENCES `ERP`.`Movimento` (`idMovimento` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Lancamento_Pessoa1`
    FOREIGN KEY (`IdPessoa` )
    REFERENCES `ERP`.`Pessoa` (`IdPessoa` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP`.`SalarioReajuste`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ERP`.`SalarioReajuste` ;

CREATE  TABLE IF NOT EXISTS `ERP`.`SalarioReajuste` (
  `IdSalarioReajuste` INT NOT NULL AUTO_INCREMENT ,
  `Data` DATETIME NULL ,
  `Valor` DECIMAL(10,2) NULL ,
  `IdFuncionario` INT NOT NULL ,
  PRIMARY KEY (`IdSalarioReajuste`) ,
  INDEX `fk_SalarioReajuste_Funcionario1_idx` (`IdFuncionario` ASC) ,
  CONSTRAINT `fk_SalarioReajuste_Funcionario1`
    FOREIGN KEY (`IdFuncionario` )
    REFERENCES `ERP`.`Funcionario` (`IdFuncionario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP`.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ERP`.`Cliente` ;

CREATE  TABLE IF NOT EXISTS `ERP`.`Cliente` (
  `IdCliente` INT NOT NULL ,
  PRIMARY KEY (`IdCliente`) ,
  CONSTRAINT `fk_Cliente_Pessoa1`
    FOREIGN KEY (`IdCliente` )
    REFERENCES `ERP`.`Pessoa` (`IdPessoa` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP`.`Fornecedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ERP`.`Fornecedor` ;

CREATE  TABLE IF NOT EXISTS `ERP`.`Fornecedor` (
  `IdFornecedor` INT NOT NULL ,
  PRIMARY KEY (`IdFornecedor`) ,
  CONSTRAINT `fk_Fornecedor_Pessoa1`
    FOREIGN KEY (`IdFornecedor` )
    REFERENCES `ERP`.`Pessoa` (`IdPessoa` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `ERP`.`TipoMovimento`
-- -----------------------------------------------------
START TRANSACTION;
USE `ERP`;
INSERT INTO `ERP`.`TipoMovimento` (`IdTipoMovimento`, `Descricao`, `OperacaoEstoque`, `EntregaFornecedor`, `SolicitanteInterno`, `PedidoCliente`) VALUES (1, 'Compra', '+', 1, NULL, NULL);
INSERT INTO `ERP`.`TipoMovimento` (`IdTipoMovimento`, `Descricao`, `OperacaoEstoque`, `EntregaFornecedor`, `SolicitanteInterno`, `PedidoCliente`) VALUES (2, 'Venda', '-', NULL, 0, 1);
INSERT INTO `ERP`.`TipoMovimento` (`IdTipoMovimento`, `Descricao`, `OperacaoEstoque`, `EntregaFornecedor`, `SolicitanteInterno`, `PedidoCliente`) VALUES (3, 'Produção', '+', NULL, 1, NULL);

COMMIT;
