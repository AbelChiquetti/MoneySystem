SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';



-- -----------------------------------------------------
-- Table `ci_sessions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ci_sessions` (
        `id` varchar(128) NOT NULL,
        `ip_address` varchar(45) NOT NULL,
        `timestamp` int(10) unsigned DEFAULT 0 NOT NULL,
        `data` blob NOT NULL,
        KEY `ci_sessions_timestamp` (`timestamp`)
);


-- -----------------------------------------------------
-- Table `notas_fiscais`
-- -----------------------------------------------------
CREATE TABLE notas_fiscais (
    idNota INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(20), -- Ex.: "Serviço" ou "Produto"
    descricao TEXT,
    valor DECIMAL(10, 2),
    desconto DECIMAL(10, 2),
    valor_final DECIMAL(10, 2),
    cliente_id INT,
    os_id INT,
    data_emissao DATE,
    status VARCHAR(20), -- Ex.: "Emitida", "Cancelada"
    FOREIGN KEY (cliente_id) REFERENCES clientes (idClientes),
    FOREIGN KEY (os_id) REFERENCES os (idOs)
);


-- -----------------------------------------------------
-- Table `clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clientes` (
  `idClientes` INT(11) NOT NULL AUTO_INCREMENT,
  `asaas_id` VARCHAR(255) DEFAULT NULL,
  `nomeCliente` VARCHAR(255) NOT NULL,
  `sexo` VARCHAR(20) NULL,
  `pessoa_fisica` BOOLEAN NOT NULL DEFAULT 1,
  `documento` VARCHAR(20) NOT NULL,
  `telefone` VARCHAR(20) NOT NULL,
  `celular` VARCHAR(20) NULL DEFAULT NULL,
  `email` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(200) NOT NULL,
  `dataCadastro` DATE NULL DEFAULT NULL,
  `rua` VARCHAR(70) NULL DEFAULT NULL,
  `numero` VARCHAR(15) NULL DEFAULT NULL,
  `bairro` VARCHAR(45) NULL DEFAULT NULL,
  `cidade` VARCHAR(45) NULL DEFAULT NULL,
  `estado` VARCHAR(20) NULL DEFAULT NULL,
  `cep` VARCHAR(20) NULL DEFAULT NULL,
  `contato` varchar(45) DEFAULT NULL,
  `complemento` varchar(45) DEFAULT NULL,
  `fornecedor` BOOLEAN NOT NULL DEFAULT 0,
  PRIMARY KEY (`idClientes`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `resets_de_senha` ( 
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(200) NOT NULL , 
  `token` VARCHAR(255) NOT NULL , 
  `data_expiracao` DATETIME NOT NULL, 
  `token_utilizado` TINYINT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `categorias` (
  `idCategorias` INT NOT NULL AUTO_INCREMENT,
  `categoria` VARCHAR(80) NULL,
  `cadastro` DATE NULL,
  `status` TINYINT(1) NULL,
  `tipo` VARCHAR(15) NULL,
  PRIMARY KEY (`idCategorias`))
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `contas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `contas` (
  `idContas` INT NOT NULL AUTO_INCREMENT,
  `conta` VARCHAR(45) NULL,
  `banco` VARCHAR(45) NULL,
  `numero` VARCHAR(45) NULL,
  `saldo` DECIMAL(10,2) NULL,
  `cadastro` DATE NULL,
  `status` TINYINT(1) NULL,
  `tipo` VARCHAR(80) NULL,
  PRIMARY KEY (`idContas`))
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `permissoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `permissoes` (
  `idPermissao` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(80) NOT NULL,
  `permissoes` TEXT NULL,
  `situacao` TINYINT(1) NULL,
  `data` DATE NULL,
  PRIMARY KEY (`idPermissao`))
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuarios` (
  `idUsuarios` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(80) NOT NULL,
  `rg` VARCHAR(20) NULL DEFAULT NULL,
  `cpf` VARCHAR(20) NOT NULL,
  `cep` VARCHAR(9) NOT NULL,
  `rua` VARCHAR(70) NULL DEFAULT NULL,
  `numero` VARCHAR(15) NULL DEFAULT NULL,
  `bairro` VARCHAR(45) NULL DEFAULT NULL,
  `cidade` VARCHAR(45) NULL DEFAULT NULL,
  `estado` VARCHAR(20) NULL DEFAULT NULL,
  `email` VARCHAR(80) NOT NULL,
  `senha` VARCHAR(200) NOT NULL,
  `telefone` VARCHAR(20) NOT NULL,
  `celular` VARCHAR(20) NULL DEFAULT NULL,
  `situacao` TINYINT(1) NOT NULL,
  `dataCadastro` DATE NOT NULL,
  `permissoes_id` INT NOT NULL,
  `dataExpiracao` date DEFAULT NULL,
  `url_image_user` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`idUsuarios`),
  INDEX `fk_usuarios_permissoes1_idx` (`permissoes_id` ASC),
  CONSTRAINT `fk_usuarios_permissoes1`
    FOREIGN KEY (`permissoes_id`)
    REFERENCES `permissoes` (`idPermissao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;



-- -----------------------------------------------------
-- Table `lancamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lancamentos` (
  `idLancamentos` INT(11) NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(255) NULL DEFAULT NULL,
  `valor` DECIMAL(10, 2) NULL DEFAULT 0,
  `desconto` DECIMAL(10, 2) NULL DEFAULT 0,
  `valor_desconto` DECIMAL(10, 2) NULL DEFAULT 0,
  `tipo_desconto` varchar(8) NULL DEFAULT NULL,
  `data_vencimento` DATE NOT NULL,
  `data_pagamento` DATE NULL DEFAULT NULL,
  `baixado` TINYINT(1) NULL DEFAULT 0,
  `cliente_fornecedor` VARCHAR(255) NULL DEFAULT NULL,
  `forma_pgto` VARCHAR(100) NULL DEFAULT NULL,
  `tipo` VARCHAR(45) NULL DEFAULT NULL,
  `anexo` VARCHAR(250) NULL,
  `observacoes` TEXT NULL,
  `clientes_id` INT(11) NULL DEFAULT NULL,
  `categorias_id` INT NULL,
  `contas_id` INT NULL,
  `vendas_id` INT NULL,
  `usuarios_id` INT NOT NULL,
  PRIMARY KEY (`idLancamentos`),
  INDEX `fk_lancamentos_clientes1` (`clientes_id` ASC),
  INDEX `fk_lancamentos_categorias1_idx` (`categorias_id` ASC),
  INDEX `fk_lancamentos_contas1_idx` (`contas_id` ASC),
  INDEX `fk_lancamentos_usuarios1` (`usuarios_id` ASC),
  CONSTRAINT `fk_lancamentos_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lancamentos_categorias1`
    FOREIGN KEY (`categorias_id`)
    REFERENCES `categorias` (`idCategorias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lancamentos_contas1`
    FOREIGN KEY (`contas_id`)
    REFERENCES `contas` (`idContas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lancamentos_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `Garantia`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `garantias` (
  `idGarantias` INT NOT NULL AUTO_INCREMENT,
  `dataGarantia` DATE NULL,
  `refGarantia` VARCHAR(15) NULL,
  `textoGarantia` TEXT NULL,
  `usuarios_id` INT(11) NULL,
  PRIMARY KEY (`idGarantias`),
  INDEX `fk_garantias_usuarios1` (`usuarios_id` ASC),
  CONSTRAINT `fk_garantias_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `os`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `os` (
  `idOs` INT(11) NOT NULL AUTO_INCREMENT,
  `dataInicial` DATE NULL DEFAULT NULL,
  `dataFinal` DATE NULL DEFAULT NULL,
  `garantia` VARCHAR(45) NULL DEFAULT NULL,
  `descricaoProduto` TEXT NULL DEFAULT NULL,
  `defeito` TEXT NULL DEFAULT NULL,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  `observacoes` TEXT NULL DEFAULT NULL,
  `laudoTecnico` TEXT NULL DEFAULT NULL,
  `valorTotal` DECIMAL(10, 2) NULL DEFAULT 0,
  `desconto`DECIMAL(10, 2) NULL DEFAULT 0,
  `valor_desconto` DECIMAL(10, 2) NULL DEFAULT 0,
  `tipo_desconto` varchar(8) NULL DEFAULT NULL,
  `clientes_id` INT(11) NOT NULL,
  `usuarios_id` INT(11) NOT NULL,
  `lancamento` INT(11) NULL DEFAULT NULL,
  `faturado` TINYINT(1) NOT NULL,
  `garantias_id` int(11) NULL,
  PRIMARY KEY (`idOs`),
  INDEX `fk_os_clientes1` (`clientes_id` ASC),
  INDEX `fk_os_usuarios1` (`usuarios_id` ASC),
  INDEX `fk_os_lancamentos1` (`lancamento` ASC),
  INDEX `fk_os_garantias1` (`garantias_id` ASC),
  CONSTRAINT `fk_os_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_os_lancamentos1`
    FOREIGN KEY (`lancamento`)
    REFERENCES `lancamentos` (`idLancamentos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_os_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `produtos` (
  `idProdutos` INT(11) NOT NULL AUTO_INCREMENT,
  `codDeBarra` VARCHAR(70) NOT NULL,
  `descricao` VARCHAR(80) NOT NULL,
  `unidade` VARCHAR(10) NULL DEFAULT NULL,
  `precoCompra` DECIMAL(10,2) NULL DEFAULT NULL,
  `precoVenda` DECIMAL(10,2) NOT NULL,
  `estoque` INT(11) NOT NULL,
  `estoqueMinimo` INT(11) NULL DEFAULT NULL,
  `saida`	TINYINT(1) NULL DEFAULT NULL,
  `entrada`	TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`idProdutos`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

INSERT INTO `produtos` (`idProdutos`, `codDeBarra`, `descricao`, `unidade`, `precoCompra`, `precoVenda`, `estoque`, `estoqueMinimo`, `saida`, `entrada`) VALUES
(1, '0101050170', 'R5WF - VISION CLEAR 70', 'M', 136.50, 410.00, 600, 0, 1, 1),
(2, '0101052105', 'R5WF - DIAMOND HD 05', 'M', 182.00, 850.00, 15, 7, 1, 1),
(3, '0101050505', 'R5WF - NRI 05 II', 'M', 72.00, 385.00, 30, 15, 1, 1),
(4, '0101050520', 'R5WF - NRI 20 II', 'M', 72.00, 385.00, 30, 15, 1, 1),
(5, '0101050535', 'R5WF - NRI 35 II', 'M', 72.00, 385.00, 30, 15, 1, 1),
(6, '0101050550', 'R5WF - NRI 50 II', 'M', 72.00, 385.00, 30, 15, 1, 1),
(7, '0101050205', 'R5WF - VISION BLACK 05', 'M', 119.20, 495.00, 15, 7, 1, 1),
(8, '0101050235', 'R5WF - VISION BLACK 35', 'M', 119.20, 495.00, 15, 7, 1, 1),
(9, '0101050250', 'R5WF - VISION BLACK 50', 'M', 119.20, 495.00, 15, 7, 1, 1),
(10, '0101052120', 'R5WF - DIAMOND HD 20', 'M', 208.00, 850.00, 15, 7, 1, 1),
(11, '0101052135', 'R5WF - DIAMOND HD 35', 'M', 208.00, 850.00, 15, 7, 1, 1),
(12, '0101052150', 'R5WF - DIAMOND HD 50', 'M', 208.00, 850.00, 15, 7, 1, 1),
(13, '0101050180', 'R5WF - VISION CLEAR 80', 'M', 156.00, 410.00, 15, 7, 1, 1),
(14, '0101050220', 'R5WF - VISION BLACK 20', 'M', 119.20, 495.00, 15, 7, 1, 1),
(15, '0102052235', 'R5WF - NR 35', 'M', 36.00, 45.00, 30, 15, 1, 1),
(16, '0102052205', 'R5WF - NR 05', 'M', 36.00, 45.00, 30, 15, 1, 1),
(17, '0102052220', 'R5WF - NR 20', 'M', 36.00, 45.00, 30, 15, 1, 1),
(18, '0101052185', 'ASWF - ADESIVO EXPOSITOR COLOR STABLE', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(19, '0101052186', 'R5WF - ADESIVO EXPOSITOR DIAMOND', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(20, '0101052187', 'R5WF - ADESIVO EXPOSITOR DIAMOND PLUS', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(21, '0101052188', 'R5WF - ADESIVO EXPOSITOR NR', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(22, '0101052189', 'R5WF - ADESIVO EXPOSITOR NRI', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(23, '0101052190', 'R5WF - ADESIVO EXPOSITOR SELECT', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(24, '0101052191', 'R5WF - ADESIVO EXPOSITOR VISION BLACK', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(25, '0101052192', 'RED DEVIL', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(26, '0101052193', 'SHORT ALUMINIUM SQUEEGEE', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(27, '0101052194', 'SHORT CUT', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(28, '0101052195', 'SPRAYER TRIGER HEAD', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(29, '0101052196', 'STRONGER DOCTOR', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(30, '0101052197', 'THE CONQUERER', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(31, '0101052198', 'TRI - EDGE ORANGE', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(32, '0101052199', 'R5WF - BANDEIROLAS', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(33, '0101052200', 'R5WF - BARRACA INFLAVEL', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(34, '0101052201', 'BASE PARA EXPOSITOR', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(35, '0101052202', 'BLOCO DE ORDEM SERVICO', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(36, '0101052203', 'R5WF - BONE', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(37, '0101052204', 'R5WF - BOOK DE ARQUITETURA', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(38, '0101052205', 'CAIXA DE CALOR MESA', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(39, '0101052206', 'CAIXA PAPELAO 090x090x1540', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(40, '0101052207', 'R5WF - CAMISETA R5WF - G', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(41, '0101052208', 'R5WF - CAMISETA R5WF - GG', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(42, '0101052209', 'R5WF - CAMISETA R5WF - M', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(43, '0101052210', 'R5WF - CAMISETA R5WF - P', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(44, '0101052211', 'R5WF - CAMISETA R5WF - PP', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(45, '0101052212', 'R5WF - CAMISETA R5WF - XG', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(46, '0101052213', 'R5WF - CAMISETA R5WF - XXG', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(47, '0101052214', 'R5WF - CAMISETA SELECT DEALER - G', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(48, '0101052215', 'R5WF - CAMISETA SELECT DEALER - GG', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(49, '0101052216', 'R5WF - CAMISETA SELECT DEALER - M', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(50, '0101052217', 'R5WF - CAMISETA SELECT DEALER - P', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(51, '0101052218', 'R5WF - CAMISETA SELECT DEALER - PP', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(52, '0101052219', 'R5WF - CAMISETA SELECT DEALER - XG', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(53, '0101052220', 'ENVELOPE - R5WF', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(54, '0101052221', '5" SQUEEGEE BLADE', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(55, '0101052222', '6" TRIUMPH SCRAPER', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(56, '0101052223', '6¨BLOCK WHITE BLACK EDGE', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(57, '0101052224', '9" LONG REINFORCED PLASTIC HANDLE', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(58, '0101052225', 'AFIADOR DE ESPATULA', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(59, '0101052226', 'AIWAYS RETRACTABLE', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(60, '0101052227', 'AMERICAN LINE SINGLE EDGE RAZOR BLADE 1.5"', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(61, '0101052228', 'BLACK HARD CARD', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(62, '0101052229', 'BLUE MAX SQUEEGEE', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(63, '0101052230', 'BORRACHA BLUE MAX ST', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(64, '0101052231', 'BULLDOZER', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(65, '0101052232', 'CABO DE FORCA', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(66, '0101052233', 'CAST ALUMINIUM HANDLE', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(67, '0101052234', 'DIGITAL MICROMETER - USA', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(68, '0101052235', 'ESPATULA MINI BATEDOR', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(69, '0101052236', 'ESTATULA BATMAN ST', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(70, '0101052237', 'ESTATULA TIAZINHA', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(71, '0101052238', 'ESTATULA TRAPEZIO', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(72, '0101052239', 'ESTILETE ANTI-RETRATIL', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(73, '0101052240', 'FUSION HAND DEE TOOL', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(74, '0101052241', 'GUIA DE LIMPEZA 15CM', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(75, '0101052242', 'GUIA DE LIMPEZA 25CM', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(76, '0101052243', 'GUIA DE LIMPEZA 35CM', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(77, '0101052244', 'KIT DE RODO PPF', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(78, '0101052245', 'LAMINA RASPADOR RATINHO', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(79, '0101052246', 'LIL CHIZLER', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(80, '0101052247', 'LUVA PRETA', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(81, '0101052248', 'NT PRO A1 "RED DOT" KNIFE', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(82, '0101052249', 'ORANGE CRUSH', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(83, '0101052250', 'R5WF - BLACK CHROME', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(84, '0101052251', 'RODO DE LIMPEZA AZUL', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(85, '0101052252', 'RODO VERMELHO DE PPF MEDIUM', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(86, '0101052253', 'TESTE HÉLICE', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(87, '0101052254', 'FITAS PADRONIZADAS', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(88, '0101052255', 'R5WF - PROTETOR DE VOLANTE', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(89, '0101052256', 'R5WF - PROTETOR PARA BANCO', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(90, '0101052257', 'R5WF - PROTETOR PARA PAINEL / PORTA-MALAS', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(91, '0101052258', 'R5WF - PROTETOR PARA PORTAS', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(92, '0101052259', 'TUBETES DE PAPELAO', 'UN', 0.00, 0.00, 0, 1, 1, 1),
(93, '0101050205', 'R5WF - VISION BLACK 05', 'M', 60.08, 140.00, 12, 15, 1, 1),
(94, '0101050235', 'R5WF - VISION BLACK 35', 'M', 60.08, 140.00, 0, 15, 1, 1),
(95, '0101050250', 'R5WF - VISION BLACK 50', 'M', 60.08, 140.00, 27, 30, 1, 1),
(96, '0203050507', 'R5WF - DR 05', 'M', 29.33, 98.00, 0, 15, 1, 1),
(97, '0203050415', 'R5WF - DR 15', 'M', 29.33, 98.00, 22, 30, 1, 1),
(98, '0203050715', 'R5WF - DR PLUS 15', 'M', 116.57, 259.04, 0, 15, 1, 1),
(99, '0203050725', 'R5WF - DR PLUS 25', 'M', 116.57, 259.04, 0, 15, 1, 1),
(100, '0203050825', 'R5WF - DR PLUS 25 1,83', 'M', 148.53, 338.78, 0, 15, 1, 1),
(101, '0203050735', 'R5WF - DR PLUS 35', 'M', 116.57, 259.04, 0, 15, 1, 1),
(102, '0203050835', 'R5WF - DR PLUS 35 1,83', 'M', 151.53, 336.74, 0, 15, 1, 1),
(103, '0203050705', 'R5WF - DR PLUS 5', 'M', 116.57, 259.04, 0, 15, 1, 1),
(104, '0203051320', 'R5WF - ROSE GOLD 20', 'M', 120.43, 267.63, 0, 15, 1, 1),
(105, '0203051335', 'R5WF - ROSE GOLD 35', 'M', 120.43, 267.63, 0, 15, 1, 1),
(106, '0206051000', 'R5WF - SECURITY 100 CLEAR', 'M', 41.06, 92.00, 22, 30, 1, 1),
(107, '0203050315', 'R5WF - SILVER 15', 'M', 26.60, 97.13, 14, 30, 1, 1),
(108, '0203050920', 'R5WF - SILVER 20 PLUS', 'M', 79.63, 176.97, 0, 15, 1, 1),
(109, '0203051020', 'R5WF - SILVER 20 PLUS 1,83', 'M', 99.07, 220.15, 0, 15, 1, 1),
(110, '0204050715', 'R5WF - SILVER BLUE 15', 'M', 29.33, 98.00, 0, 15, 1, 1),
(111, '0204050815', 'R5WF - SILVER BRONZE 15', 'M', 36.00, 98.00, 22, 0, 1, 1),
(112, '0204051115', 'R5WF - SILVER GOLD 15', 'M', 36.00, 98.00, 0, 15, 1, 1),
(113, '0203050915', 'R5WF - SILVER GOLD 15', 'M', 36.00, 98.00, 0, 15, 1, 1),
(114, '0203050615', 'R5WF - SILVER GREEN 15', 'M', 36.00, 98.00, 0, 15, 1, 1),
(115, '0208050900', 'R5WF - WHITE MATT (BRANCO JATEADO)', 'M', 15.83, 50.40, 22, 30, 1, 1);

-- -----------------------------------------------------
-- Table `produtos_os`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `produtos_os` (
  `idProdutos_os` INT(11) NOT NULL AUTO_INCREMENT,
  `quantidade` INT(11) NOT NULL,
  `descricao` VARCHAR(80) NULL,
  `preco` DECIMAL(10,2) NULL DEFAULT 0,
  `os_id` INT(11) NOT NULL,
  `produtos_id` INT(11) NOT NULL,
  `subTotal` DECIMAL(10,2) NULL DEFAULT 0,
  PRIMARY KEY (`idProdutos_os`),
  INDEX `fk_produtos_os_os1` (`os_id` ASC),
  INDEX `fk_produtos_os_produtos1` (`produtos_id` ASC),
  CONSTRAINT `fk_produtos_os_os1`
    FOREIGN KEY (`os_id`)
    REFERENCES `os` (`idOs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produtos_os_produtos1`
    FOREIGN KEY (`produtos_id`)
    REFERENCES `produtos` (`idProdutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `servicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servicos` (
  `idServicos` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(45) NULL DEFAULT NULL,
  `preco` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idServicos`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `servicos_os`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servicos_os` (
  `idServicos_os` INT(11) NOT NULL AUTO_INCREMENT,
  `servico` VARCHAR(80) NULL,
  `quantidade` DOUBLE NULL,
  `preco` DECIMAL(10,2) NULL DEFAULT 0,
  `os_id` INT(11) NOT NULL,
  `servicos_id` INT(11) NOT NULL,
  `subTotal` DECIMAL(10,2) NULL DEFAULT 0,
  PRIMARY KEY (`idServicos_os`),
  INDEX `fk_servicos_os_os1` (`os_id` ASC),
  INDEX `fk_servicos_os_servicos1` (`servicos_id` ASC),
  CONSTRAINT `fk_servicos_os_os1`
    FOREIGN KEY (`os_id`)
    REFERENCES `os` (`idOs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servicos_os_servicos1`
    FOREIGN KEY (`servicos_id`)
    REFERENCES `servicos` (`idServicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `vendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vendas` (
  `idVendas` INT NOT NULL AUTO_INCREMENT,
  `dataVenda` DATE NULL,
  `valorTotal` DECIMAL(10, 2) NULL DEFAULT 0,
  `desconto` DECIMAL(10, 2) NULL DEFAULT 0,
  `valor_desconto` DECIMAL(10, 2) NULL DEFAULT 0,
  `tipo_desconto` varchar(8) NULL DEFAULT NULL,
  `faturado` TINYINT(1) NULL,
  `observacoes` TEXT NULL,
  `observacoes_cliente` TEXT NULL,
  `clientes_id` INT(11) NOT NULL,
  `usuarios_id` INT(11) NULL,
  `lancamentos_id` INT(11) NULL,
  `status` VARCHAR(45) NULL,
  `garantia` INT(11) NULL,
  PRIMARY KEY (`idVendas`),
  INDEX `fk_vendas_clientes1` (`clientes_id` ASC),
  INDEX `fk_vendas_usuarios1` (`usuarios_id` ASC),
  INDEX `fk_vendas_lancamentos1` (`lancamentos_id` ASC),
  CONSTRAINT `fk_vendas_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendas_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendas_lancamentos1`
    FOREIGN KEY (`lancamentos_id`)
    REFERENCES `lancamentos` (`idLancamentos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;


--
-- Estrutura da tabela `cobrancas`
--
CREATE TABLE IF NOT EXISTS `cobrancas` (
  `idCobranca` INT(11) NOT NULL AUTO_INCREMENT,
  `charge_id` varchar(255) DEFAULT NULL,
  `conditional_discount_date` date DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `custom_id` int(11) DEFAULT NULL,
  `expire_at` date NOT NULL,
  `message` varchar(255) NOT NULL,
  `payment_method` varchar(11) DEFAULT NULL,
  `payment_url` varchar(255) DEFAULT NULL,
  `request_delivery_address` varchar(64) DEFAULT NULL,
  `status` varchar(36) NOT NULL,
  `total` varchar(15) DEFAULT NULL,
  `barcode` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `payment_gateway` varchar(255) NULL DEFAULT NULL,
  `payment` varchar(64) NOT NULL,
  `pdf` varchar(255) DEFAULT NULL,
  `vendas_id` int(11) DEFAULT NULL,
  `os_id` int(11) DEFAULT NULL,
  `clientes_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`idCobranca`),
  INDEX `fk_cobrancas_os1` (`os_id` ASC),
  CONSTRAINT `fk_cobrancas_os1` FOREIGN KEY (`os_id`) REFERENCES `os` (`idOs`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  INDEX `fk_cobrancas_vendas1` (`vendas_id` ASC),
  CONSTRAINT `fk_cobrancas_vendas1` FOREIGN KEY (`vendas_id`) REFERENCES `vendas` (`idVendas`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  INDEX `fk_cobrancas_clientes1` (`clientes_id` ASC),
  CONSTRAINT `fk_cobrancas_clientes1` FOREIGN KEY (`clientes_id`) REFERENCES `clientes` (`idClientes`) ON DELETE NO ACTION ON UPDATE NO ACTION

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `itens_de_vendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itens_de_vendas` (
  `idItens` INT NOT NULL AUTO_INCREMENT,
  `subTotal` DECIMAL(10,2) NULL DEFAULT 0,
  `quantidade` INT(11) NULL,
  `preco` DECIMAL(10,2) NULL DEFAULT 0,
  `vendas_id` INT NOT NULL,
  `produtos_id` INT(11) NOT NULL,
  PRIMARY KEY (`idItens`),
  INDEX `fk_itens_de_vendas_vendas1` (`vendas_id` ASC),
  INDEX `fk_itens_de_vendas_produtos1` (`produtos_id` ASC),
  CONSTRAINT `fk_itens_de_vendas_vendas1`
    FOREIGN KEY (`vendas_id`)
    REFERENCES `vendas` (`idVendas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_de_vendas_produtos1`
    FOREIGN KEY (`produtos_id`)
    REFERENCES `produtos` (`idProdutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `anexos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `anexos` (
  `idAnexos` INT NOT NULL AUTO_INCREMENT,
  `anexo` VARCHAR(45) NULL,
  `thumb` VARCHAR(45) NULL,
  `url` VARCHAR(300) NULL,
  `path` VARCHAR(300) NULL,
  `os_id` INT(11) NOT NULL,
  PRIMARY KEY (`idAnexos`),
  INDEX `fk_anexos_os1` (`os_id` ASC),
  CONSTRAINT `fk_anexos_os1`
    FOREIGN KEY (`os_id`)
    REFERENCES `os` (`idOs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `documentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `documentos` (
  `idDocumentos` INT NOT NULL AUTO_INCREMENT,
  `documento` VARCHAR(70) NULL,
  `descricao` TEXT NULL,
  `file` VARCHAR(100) NULL,
  `path` VARCHAR(300) NULL,
  `url` VARCHAR(300) NULL,
  `cadastro` DATE NULL,
  `categoria` VARCHAR(80) NULL,
  `tipo` VARCHAR(15) NULL,
  `tamanho` VARCHAR(45) NULL,
  PRIMARY KEY (`idDocumentos`))
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `marcas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marcas` (
  `idMarcas` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(100) NULL,
  `cadastro` DATE NULL,
  `situacao` TINYINT(1) NULL,
  PRIMARY KEY (`idMarcas`))
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `equipamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `equipamentos` (
  `idEquipamentos` INT NOT NULL AUTO_INCREMENT,
  `equipamento` VARCHAR(150) NOT NULL,
  `num_serie` VARCHAR(80) NULL,
  `modelo` VARCHAR(80) NULL,
  `cor` VARCHAR(45) NULL,
  `descricao` VARCHAR(150) NULL,
  `tensao` VARCHAR(45) NULL,
  `potencia` VARCHAR(45) NULL,
  `voltagem` VARCHAR(45) NULL,
  `data_fabricacao` DATE NULL,
  `marcas_id` INT NULL,
  `clientes_id` INT(11) NULL,
  PRIMARY KEY (`idEquipamentos`),
  INDEX `fk_equipanentos_marcas1_idx` (`marcas_id` ASC),
  INDEX `fk_equipanentos_clientes1_idx` (`clientes_id` ASC),
  CONSTRAINT `fk_equipanentos_marcas1`
    FOREIGN KEY (`marcas_id`)
    REFERENCES `marcas` (`idMarcas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipanentos_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `equipamentos_os`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `equipamentos_os` (
  `idEquipamentos_os` INT NOT NULL AUTO_INCREMENT,
  `defeito_declarado` VARCHAR(200) NULL,
  `defeito_encontrado` VARCHAR(200) NULL,
  `solucao` VARCHAR(45) NULL,
  `equipamentos_id` INT NULL,
  `os_id` INT(11) NULL,
  PRIMARY KEY (`idEquipamentos_os`),
  INDEX `fk_equipamentos_os_equipanentos1_idx` (`equipamentos_id` ASC),
  INDEX `fk_equipamentos_os_os1_idx` (`os_id` ASC),
  CONSTRAINT `fk_equipamentos_os_equipanentos1`
    FOREIGN KEY (`equipamentos_id`)
    REFERENCES `equipamentos` (`idEquipamentos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipamentos_os_os1`
    FOREIGN KEY (`os_id`)
    REFERENCES `os` (`idOs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `logs` (
  `idLogs` INT NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(80) NULL,
  `tarefa` VARCHAR(100) NULL,
  `data` DATE NULL,
  `hora` TIME NULL,
  `ip` VARCHAR(45) NULL,
  PRIMARY KEY (`idLogs`))
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `emitente`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `emitente` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(255) NULL ,
  `cnpj` VARCHAR(45) NULL ,
  `ie` VARCHAR(50) NULL ,
  `rua` VARCHAR(70) NULL ,
  `numero` VARCHAR(15) NULL ,
  `bairro` VARCHAR(45) NULL ,
  `cidade` VARCHAR(45) NULL ,
  `uf` VARCHAR(20) NULL ,
  `telefone` VARCHAR(20) NULL ,
  `email` VARCHAR(255) NULL ,
  `url_logo` VARCHAR(225) NULL ,
  `cep` VARCHAR(20) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `email_queue`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `email_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `to` varchar(255) NOT NULL,
  `cc` varchar(255) DEFAULT NULL,
  `bcc` varchar(255) DEFAULT NULL,
  `message` text NOT NULL,
  `status` enum('pending','sending','sent','failed') DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `headers` text,
  PRIMARY KEY (`id`)
)ENGINE = InnoDB
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `anotacaoes_os`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `anotacoes_os` (
    `idAnotacoes` INT(11) NOT NULL AUTO_INCREMENT,
    `anotacao` VARCHAR(255) NOT NULL ,
    `data_hora` DATETIME NOT NULL ,
    `os_id` INT(11) NOT NULL ,
    PRIMARY KEY (`idAnotacoes`)
) ENGINE = InnoDB
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `configuracoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `configuracoes` ( 
  `idConfig` INT NOT NULL AUTO_INCREMENT , `config` VARCHAR(20) NOT NULL UNIQUE, `valor` TEXT NULL , PRIMARY KEY (`idConfig`)
  ) ENGINE = InnoDB CHARSET=utf8mb4 COLLATE utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `migrations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `migrations` (
  `version` BIGINT(20) NOT NULL
);

INSERT IGNORE INTO `configuracoes` (`idConfig`, `config`, `valor`) VALUES
(2, 'app_name', 'MoneySystem'),
(3, 'app_theme', 'white'),
(4, 'per_page', '10'),
(5, 'os_notification', 'cliente'),
(6, 'control_estoque', '1'),
(7, 'notifica_whats', 'Prezado(a), {CLIENTE_NOME} a OS de nº {NUMERO_OS} teve o status alterado para: {STATUS_OS} segue a descrição {DESCRI_PRODUTOS} com valor total de {VALOR_OS}! Para mais informações entre em contato conosco. Atenciosamente, {EMITENTE} {TELEFONE_EMITENTE}.'),
(8, 'control_baixa', '0'),
(9, 'control_editos', '1'),
(10, 'control_datatable', '1'),
(11, 'pix_key', ''),
(12, 'os_status_list', '[\"Aberto\",\"Faturado\",\"Negocia\\u00e7\\u00e3o\",\"Em Andamento\",\"Or\\u00e7amento\",\"Finalizado\",\"Cancelado\",\"Aguardando Pe\\u00e7as\",\"Aprovado\"]'),
(13, 'control_edit_vendas', '1'),
(14, 'email_automatico', '1'),
(15, 'control_2vias', '0');

INSERT IGNORE INTO `permissoes` (`idPermissao`, `nome`, `permissoes`, `situacao`, `data`) VALUES
(1, 'Administrador', 'a:53:{s:8:"aCliente";s:1:"1";s:8:"eCliente";s:1:"1";s:8:"dCliente";s:1:"1";s:8:"vCliente";s:1:"1";s:8:"aProduto";s:1:"1";s:8:"eProduto";s:1:"1";s:8:"dProduto";s:1:"1";s:8:"vProduto";s:1:"1";s:8:"aServico";s:1:"1";s:8:"eServico";s:1:"1";s:8:"dServico";s:1:"1";s:8:"vServico";s:1:"1";s:3:"aOs";s:1:"1";s:3:"eOs";s:1:"1";s:3:"dOs";s:1:"1";s:3:"vOs";s:1:"1";s:6:"aVenda";s:1:"1";s:6:"eVenda";s:1:"1";s:6:"dVenda";s:1:"1";s:6:"vVenda";s:1:"1";s:9:"aGarantia";s:1:"1";s:9:"eGarantia";s:1:"1";s:9:"dGarantia";s:1:"1";s:9:"vGarantia";s:1:"1";s:8:"aArquivo";s:1:"1";s:8:"eArquivo";s:1:"1";s:8:"dArquivo";s:1:"1";s:8:"vArquivo";s:1:"1";s:10:"aPagamento";N;s:10:"ePagamento";N;s:10:"dPagamento";N;s:10:"vPagamento";N;s:11:"aLancamento";s:1:"1";s:11:"eLancamento";s:1:"1";s:11:"dLancamento";s:1:"1";s:11:"vLancamento";s:1:"1";s:8:"cUsuario";s:1:"1";s:9:"cEmitente";s:1:"1";s:10:"cPermissao";s:1:"1";s:7:"cBackup";s:1:"1";s:10:"cAuditoria";s:1:"1";s:6:"cEmail";s:1:"1";s:8:"cSistema";s:1:"1";s:8:"rCliente";s:1:"1";s:8:"rProduto";s:1:"1";s:8:"rServico";s:1:"1";s:3:"rOs";s:1:"1";s:6:"rVenda";s:1:"1";s:11:"rFinanceiro";s:1:"1";s:9:"aCobranca";s:1:"1";s:9:"eCobranca";s:1:"1";s:9:"dCobranca";s:1:"1";s:9:"vCobranca";s:1:"1";}', 1, 'admin_created_at');

INSERT IGNORE INTO `usuarios` (`idUsuarios`, `nome`, `rg`, `cpf`, `cep`, `rua`, `numero`, `bairro`, `cidade`, `estado`, `email`, `senha`, `telefone`, `celular`, `situacao`, `dataCadastro`, `permissoes_id`,`dataExpiracao`) VALUES
(1, 'admin_name', '433763620', '000.000.000-00', '00000-000', 'Rua Exemplo', '10', 'Alvorada', 'Teste', 'SC', 'admin_email', 'admin_password', '000000-0000', '', 1, 'admin_created_at', 1, '2028-01-01');

INSERT IGNORE INTO `migrations`(`version`) VALUES ('20210125173741');

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
