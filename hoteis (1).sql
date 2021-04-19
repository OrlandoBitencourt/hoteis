-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 19-Abr-2021 às 21:35
-- Versão do servidor: 10.4.17-MariaDB
-- versão do PHP: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `hoteis`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `cidades`
--

CREATE TABLE `cidades` (
  `id_cidades` int(11) NOT NULL,
  `nome_cidades` varchar(200) DEFAULT NULL,
  `id_regioes` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `cidades`
--

INSERT INTO `cidades` (`id_cidades`, `nome_cidades`, `id_regioes`) VALUES
(1, 'Blumenau', 1),
(2, 'Criciúma', 2),
(3, 'Timbó', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `estados`
--

CREATE TABLE `estados` (
  `id_estados` int(11) NOT NULL,
  `nome_estados` varchar(200) DEFAULT NULL,
  `uf_estados` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `estados`
--

INSERT INTO `estados` (`id_estados`, `nome_estados`, `uf_estados`) VALUES
(1, 'Santa Catarina', 'SC');

-- --------------------------------------------------------

--
-- Estrutura da tabela `hoteis`
--

CREATE TABLE `hoteis` (
  `id_hoteis` int(11) NOT NULL,
  `nome_hoteis` varchar(200) DEFAULT NULL,
  `classificacao_hoteis` int(1) DEFAULT NULL,
  `academia_hoteis` tinyint(1) DEFAULT NULL,
  `piscina_hoteis` tinyint(1) DEFAULT NULL,
  `all_inclusive_hoteis` tinyint(1) DEFAULT NULL,
  `id_cidades` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `hoteis`
--

INSERT INTO `hoteis` (`id_hoteis`, `nome_hoteis`, `classificacao_hoteis`, `academia_hoteis`, `piscina_hoteis`, `all_inclusive_hoteis`, `id_cidades`) VALUES
(1, 'Himmenblau', 3, 0, 0, 1, 1),
(2, 'Ibis', 5, 1, 1, 1, 1),
(3, 'Ibis Budget', 3, 0, 0, 0, 2),
(4, 'Zeitfest', 4, 0, 0, 1, 3),
(5, 'Park Hotel', 5, 1, 1, 1, 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `quartos`
--

CREATE TABLE `quartos` (
  `id_quartos` int(11) NOT NULL,
  `descricao_quartos` varchar(200) DEFAULT NULL,
  `preco_quartos` double(7,2) DEFAULT NULL,
  `disponibilidade` tinyint(1) DEFAULT NULL,
  `id_hoteis` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `quartos`
--

INSERT INTO `quartos` (`id_quartos`, `descricao_quartos`, `preco_quartos`, `disponibilidade`, `id_hoteis`) VALUES
(1, 'single', 100.00, 1, 1),
(2, 'single', 180.00, 1, 2),
(3, 'single', 100.00, 1, 3),
(4, 'Double', 120.00, 1, 3),
(5, 'vazio', 100.00, 0, 1),
(6, 'Suite casal', 200.00, 1, 4),
(7, 'Suite premium max', 999.00, 0, 5),
(8, 'Suite presidencial', 900.00, 1, 5);

-- --------------------------------------------------------

--
-- Estrutura da tabela `regioes`
--

CREATE TABLE `regioes` (
  `id_regioes` int(11) NOT NULL,
  `nome_regioes` varchar(200) DEFAULT NULL,
  `id_estados` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `regioes`
--

INSERT INTO `regioes` (`id_regioes`, `nome_regioes`, `id_estados`) VALUES
(1, 'Nordeste', 1),
(2, 'Sul', 1);

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `cidades`
--
ALTER TABLE `cidades`
  ADD PRIMARY KEY (`id_cidades`),
  ADD KEY `regioes_fk` (`id_regioes`);

--
-- Índices para tabela `estados`
--
ALTER TABLE `estados`
  ADD PRIMARY KEY (`id_estados`);

--
-- Índices para tabela `hoteis`
--
ALTER TABLE `hoteis`
  ADD PRIMARY KEY (`id_hoteis`),
  ADD KEY `cidades_fk` (`id_cidades`);

--
-- Índices para tabela `quartos`
--
ALTER TABLE `quartos`
  ADD PRIMARY KEY (`id_quartos`),
  ADD KEY `hoteis_fk` (`id_hoteis`);

--
-- Índices para tabela `regioes`
--
ALTER TABLE `regioes`
  ADD PRIMARY KEY (`id_regioes`),
  ADD KEY `estados_fk` (`id_estados`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `cidades`
--
ALTER TABLE `cidades`
  MODIFY `id_cidades` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `estados`
--
ALTER TABLE `estados`
  MODIFY `id_estados` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `hoteis`
--
ALTER TABLE `hoteis`
  MODIFY `id_hoteis` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `quartos`
--
ALTER TABLE `quartos`
  MODIFY `id_quartos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `regioes`
--
ALTER TABLE `regioes`
  MODIFY `id_regioes` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `cidades`
--
ALTER TABLE `cidades`
  ADD CONSTRAINT `regioes_fk` FOREIGN KEY (`id_regioes`) REFERENCES `regioes` (`id_regioes`);

--
-- Limitadores para a tabela `hoteis`
--
ALTER TABLE `hoteis`
  ADD CONSTRAINT `cidades_fk` FOREIGN KEY (`id_cidades`) REFERENCES `cidades` (`id_cidades`);

--
-- Limitadores para a tabela `quartos`
--
ALTER TABLE `quartos`
  ADD CONSTRAINT `hoteis_fk` FOREIGN KEY (`id_hoteis`) REFERENCES `hoteis` (`id_hoteis`);

--
-- Limitadores para a tabela `regioes`
--
ALTER TABLE `regioes`
  ADD CONSTRAINT `estados_fk` FOREIGN KEY (`id_estados`) REFERENCES `estados` (`id_estados`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
