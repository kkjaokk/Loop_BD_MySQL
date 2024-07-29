-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.28-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para loop
CREATE DATABASE IF NOT EXISTS `loop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `loop`;

-- Copiando estrutura para tabela loop.avaliacoes
CREATE TABLE IF NOT EXISTS `avaliacoes` (
  `idAvalia` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `nota` int(11) NOT NULL,
  `review` varchar(50) NOT NULL,
  PRIMARY KEY (`idAvalia`),
  KEY `game_id` (`game_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `avaliacoes_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `game` (`idGame`),
  CONSTRAINT `avaliacoes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `usuario` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela loop.avaliacoes: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela loop.biblioteca
CREATE TABLE IF NOT EXISTS `biblioteca` (
  `idBibli` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  PRIMARY KEY (`idBibli`),
  KEY `user_id` (`user_id`),
  KEY `game_id` (`game_id`),
  CONSTRAINT `biblioteca_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuario` (`idUser`),
  CONSTRAINT `biblioteca_ibfk_2` FOREIGN KEY (`game_id`) REFERENCES `game` (`idGame`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela loop.biblioteca: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela loop.categoria
CREATE TABLE IF NOT EXISTS `categoria` (
  `idCategoria` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `descricao` varchar(50) NOT NULL,
  PRIMARY KEY (`idCategoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela loop.categoria: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela loop.desenvolvedora
CREATE TABLE IF NOT EXISTS `desenvolvedora` (
  `idDev` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(70) NOT NULL,
  `descricao` varchar(100) NOT NULL,
  `cnpj` varchar(50) NOT NULL,
  PRIMARY KEY (`idDev`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela loop.desenvolvedora: ~4 rows (aproximadamente)
INSERT INTO `desenvolvedora` (`idDev`, `nome`, `descricao`, `cnpj`) VALUES
	(1, 'Steam', 'Steam e legal', '231434'),
	(2, 'Steam', 'Steam e legal', '231434'),
	(3, 'testeduplica', 'teste', '11111'),
	(4, 'From Software', 'fez dark souls', '435345');

-- Copiando estrutura para tabela loop.game
CREATE TABLE IF NOT EXISTS `game` (
  `idGame` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(70) NOT NULL,
  `descricao` varchar(100) NOT NULL,
  `preco` double NOT NULL,
  `lancamento` date DEFAULT NULL,
  `desenvolvedora_idDev` int(11) NOT NULL,
  PRIMARY KEY (`idGame`),
  KEY `fk_game_desenvolvedora1_idx` (`desenvolvedora_idDev`),
  CONSTRAINT `fk_game_desenvolvedora1` FOREIGN KEY (`desenvolvedora_idDev`) REFERENCES `desenvolvedora` (`idDev`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela loop.game: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela loop.game_has_categoria
CREATE TABLE IF NOT EXISTS `game_has_categoria` (
  `game_idGame` int(11) NOT NULL,
  `categoria_idCategoria` int(11) NOT NULL,
  PRIMARY KEY (`game_idGame`,`categoria_idCategoria`),
  KEY `fk_game_has_categoria_categoria1_idx` (`categoria_idCategoria`),
  KEY `fk_game_has_categoria_game1_idx` (`game_idGame`),
  CONSTRAINT `fk_game_has_categoria_categoria1` FOREIGN KEY (`categoria_idCategoria`) REFERENCES `categoria` (`idCategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_game_has_categoria_game1` FOREIGN KEY (`game_idGame`) REFERENCES `game` (`idGame`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela loop.game_has_categoria: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela loop.metodo_pagamento
CREATE TABLE IF NOT EXISTS `metodo_pagamento` (
  `idPaga` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `descricao` varchar(50) NOT NULL,
  PRIMARY KEY (`idPaga`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela loop.metodo_pagamento: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela loop.pedido
CREATE TABLE IF NOT EXISTS `pedido` (
  `idPedido` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `pagamento_id` int(11) NOT NULL,
  `data_pedido` date NOT NULL,
  PRIMARY KEY (`idPedido`),
  KEY `user_id` (`user_id`),
  KEY `pagamento_id` (`pagamento_id`),
  CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuario` (`idUser`),
  CONSTRAINT `pedido_ibfk_2` FOREIGN KEY (`pagamento_id`) REFERENCES `metodo_pagamento` (`idPaga`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela loop.pedido: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela loop.pedido_itens
CREATE TABLE IF NOT EXISTS `pedido_itens` (
  `idItem` int(11) NOT NULL AUTO_INCREMENT,
  `pedido_id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `valor` double NOT NULL,
  PRIMARY KEY (`idItem`),
  KEY `pedido_id` (`pedido_id`),
  KEY `game_id` (`game_id`),
  CONSTRAINT `pedido_itens_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedido` (`idPedido`),
  CONSTRAINT `pedido_itens_ibfk_2` FOREIGN KEY (`game_id`) REFERENCES `game` (`idGame`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela loop.pedido_itens: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela loop.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `idUser` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(25) NOT NULL,
  `pais` varchar(50) NOT NULL,
  `pontos` double NOT NULL,
  PRIMARY KEY (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela loop.usuario: ~5 rows (aproximadamente)
INSERT INTO `usuario` (`idUser`, `nome`, `email`, `senha`, `pais`, `pontos`) VALUES
	(1, 'teste', 'teste@gmail.com', 'teste123', 'testepais', 50),
	(2, 'joao', 'joao@gmail.com', '21432', 'brasil', 200),
	(3, 'teste2', 'teste2@gmail', 'teste12345', 'brasil2', 245),
	(4, 'vamola', 'baoce@gmail.com', 'olamundo', 'brasil3', 350),
	(5, 'vamola2', 'baoce2@gmail.com', 'olamundo2', 'brasil4', 351);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
