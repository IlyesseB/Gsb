SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `Etat`;
CREATE TABLE `Etat` (
  `id` char(2) NOT NULL,
  `libelle` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `Etat` (`id`, `libelle`) VALUES
('CL',	'Saisie clôturée'),
('CR',	'Fiche créée, saisie en cours'),
('RB',	'Remboursée'),
('VA',	'Validée et mise en paiement');

DROP TABLE IF EXISTS `FicheFrais`;
CREATE TABLE `FicheFrais` (
  `idVisiteur` char(4) NOT NULL,
  `mois` char(6) NOT NULL,
  `nbJustificatifs` int(11) DEFAULT NULL,
  `montantValide` decimal(10,2) DEFAULT NULL,
  `dateModif` date DEFAULT NULL,
  `idEtat` char(2) DEFAULT 'CR',
  PRIMARY KEY (`idVisiteur`,`mois`),
  KEY `idEtat` (`idEtat`),
  CONSTRAINT `FicheFrais_ibfk_1` FOREIGN KEY (`idEtat`) REFERENCES `Etat` (`id`),
  CONSTRAINT `FicheFrais_ibfk_2` FOREIGN KEY (`idVisiteur`) REFERENCES `Visiteur` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `FicheFrais` (`idVisiteur`, `mois`, `nbJustificatifs`, `montantValide`, `dateModif`, `idEtat`) VALUES
('',	'02',	0,	0.00,	'2022-03-01',	'CL'),
('',	'03',	0,	0.00,	'2022-03-01',	'CR'),
('a131',	'02',	0,	0.00,	'2022-02-09',	'CR'),
('a17',	'03',	0,	0.00,	'2022-03-02',	'CR'),
('e10',	'03',	0,	0.00,	'2022-03-02',	'CR');

DROP TABLE IF EXISTS `FraisForfait`;
CREATE TABLE `FraisForfait` (
  `id` char(3) NOT NULL,
  `libelle` char(20) DEFAULT NULL,
  `montant` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `FraisForfait` (`id`, `libelle`, `montant`) VALUES
('ETP',	'Forfait Etape',	110.00),
('KM',	'Frais Kilométrique',	0.62),
('NUI',	'Nuitée Hôtel',	80.00),
('REP',	'Repas Restaurant',	25.00);

DROP TABLE IF EXISTS `LigneFraisForfait`;
CREATE TABLE `LigneFraisForfait` (
  `idVisiteur` char(4) NOT NULL,
  `mois` char(6) NOT NULL,
  `idFraisForfait` char(3) NOT NULL,
  `quantite` int(11) DEFAULT NULL,
  PRIMARY KEY (`idVisiteur`,`mois`,`idFraisForfait`),
  KEY `idFraisForfait` (`idFraisForfait`),
  CONSTRAINT `LigneFraisForfait_ibfk_1` FOREIGN KEY (`idVisiteur`, `mois`) REFERENCES `FicheFrais` (`idVisiteur`, `mois`),
  CONSTRAINT `LigneFraisForfait_ibfk_2` FOREIGN KEY (`idFraisForfait`) REFERENCES `FraisForfait` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `LigneFraisForfait` (`idVisiteur`, `mois`, `idFraisForfait`, `quantite`) VALUES
('',	'02',	'ETP',	0),
('',	'02',	'KM',	0),
('',	'02',	'NUI',	0),
('',	'02',	'REP',	0),
('',	'03',	'ETP',	1),
('',	'03',	'KM',	10),
('',	'03',	'NUI',	100),
('',	'03',	'REP',	1000),
('a131',	'02',	'ETP',	0),
('a131',	'02',	'KM',	0),
('a131',	'02',	'NUI',	0),
('a131',	'02',	'REP',	0),
('a17',	'03',	'ETP',	0),
('a17',	'03',	'KM',	0),
('a17',	'03',	'NUI',	0),
('a17',	'03',	'REP',	0),
('e10',	'03',	'ETP',	1),
('e10',	'03',	'KM',	12),
('e10',	'03',	'NUI',	123),
('e10',	'03',	'REP',	1234);

DROP TABLE IF EXISTS `LigneFraisHorsForfait`;
CREATE TABLE `LigneFraisHorsForfait` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idVisiteur` char(4) NOT NULL,
  `mois` char(6) NOT NULL,
  `libelle` varchar(100) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `montant` decimal(10,2) DEFAULT NULL,
  `mdp` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idVisiteur` (`idVisiteur`,`mois`),
  KEY `date` (`date`),
  KEY `mdp` (`mdp`),
  CONSTRAINT `LigneFraisHorsForfait_ibfk_1` FOREIGN KEY (`idVisiteur`, `mois`) REFERENCES `FicheFrais` (`idVisiteur`, `mois`),
  CONSTRAINT `LigneFraisHorsForfait_ibfk_2` FOREIGN KEY (`mdp`) REFERENCES `ModePaim` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `LigneFraisHorsForfait` (`id`, `idVisiteur`, `mois`, `libelle`, `date`, `montant`, `mdp`) VALUES
(1,	'e10',	'03',	'randiom',	'2022-03-02',	552.00,	1),
(2,	'',	'03',	'gfgf',	'2022-02-05',	5000.00,	NULL),
(3,	'',	'03',	'velo',	'2022-03-05',	1250.00,	NULL),
(4,	'',	'03',	'TEST111',	'2022-02-05',	55.00,	NULL),
(5,	'',	'03',	'TEST111',	'2022-02-05',	55.00,	NULL),
(6,	'',	'03',	'TEST111',	'2022-02-05',	55.00,	NULL);

DROP TABLE IF EXISTS `ModePaim`;
CREATE TABLE `ModePaim` (
  `id` int(11) NOT NULL,
  `lib` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `ModePaim` (`id`, `lib`) VALUES
(1,	'carte bleu'),
(2,	'cheque'),
(3,	'espece'),
(4,	'crypto');

DROP TABLE IF EXISTS `Visiteur`;
CREATE TABLE `Visiteur` (
  `id` char(4) NOT NULL,
  `nom` char(30) DEFAULT NULL,
  `prenom` char(30) DEFAULT NULL,
  `login` char(20) DEFAULT NULL,
  `mdp` char(20) DEFAULT NULL,
  `adresse` char(30) DEFAULT NULL,
  `cp` char(5) DEFAULT NULL,
  `ville` char(30) DEFAULT NULL,
  `dateEmbauche` date DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `numero` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `numero` (`numero`),
  CONSTRAINT `Visiteur_ibfk_1` FOREIGN KEY (`numero`) REFERENCES `Voiture` (`numero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `Visiteur` (`id`, `nom`, `prenom`, `login`, `mdp`, `adresse`, `cp`, `ville`, `dateEmbauche`, `telephone`, `numero`) VALUES
('b04',	'Bouraghda',	'Ilyesse',	'admin',	'password',	'osef',	'42170',	'st just',	NULL,	'06 51 45 65 78',	'FV-052-VF'),
('a131',	'Villechalane',	'Louis',	'lvillachane',	'jux7g',	'8 rue des Charmes',	'46000',	'Cahors',	'2005-12-21',	'01 01 01 10 02',	NULL),
('a17',	'Andre',	'David',	'dandre',	'oppg5',	'1 rue Petit',	'46200',	'Lalbenque',	'1998-11-23',	'01 01 01 10 05',	NULL),
('a55',	'Bedos',	'Christian',	'cbedos',	'gmhxd',	'1 rue Peranud',	'46250',	'Montcuq',	'1995-01-12',	'01 01 01 10 56',	NULL),
('a93',	'Tusseau',	'Louis',	'ltusseau',	'ktp3s',	'22 rue des Ternes',	'46123',	'Gramat',	'2000-05-01',	'01 01 01 10 59',	NULL),
('b13',	'Bentot',	'Pascal',	'pbentot',	'doyw1',	'11 allée des Cerises',	'46512',	'Bessines',	'1992-07-09',	'01 01 01 10 58',	NULL),
('b16',	'Bioret',	'Luc',	'lbioret',	'hrjfs',	'1 Avenue gambetta',	'46000',	'Cahors',	'1998-05-11',	'01 01 01 10 88',	NULL),
('b19',	'Bunisset',	'Francis',	'fbunisset',	'4vbnd',	'10 rue des Perles',	'93100',	'Montreuil',	'1987-10-21',	'01 01 01 10 26',	NULL),
('b25',	'Bunisset',	'Denise',	'dbunisset',	's1y1r',	'23 rue Manin',	'75019',	'paris',	'2010-12-05',	'01 01 01 10 23',	NULL),
('b28',	'Cacheux',	'Bernard',	'bcacheux',	'uf7r3',	'114 rue Blanche',	'75017',	'Paris',	'2009-11-12',	'01 01 01 23 56',	NULL),
('b34',	'Cadic',	'Eric',	'ecadic',	'6u8dc',	'123 avenue de la République',	'75011',	'Paris',	'2008-09-23',	'05 45 56 78 02',	NULL),
('b4',	'Charoze',	'Catherine',	'ccharoze',	'u817o',	'100 rue Petit',	'75019',	'Paris',	'2005-11-12',	'05 45 56 78 45',	NULL),
('b50',	'Clepkens',	'Christophe',	'cclepkens',	'bw1us',	'12 allée des Anges',	'93230',	'Romainville',	'2003-08-11',	'05 45 56 78 12',	NULL),
('b59',	'Cottin',	'Vincenne',	'vcottin',	'2hoh9',	'36 rue Des Roches',	'93100',	'Monteuil',	'2001-11-18',	'05 45 56 78 13',	NULL),
('c14',	'Daburon',	'François',	'fdaburon',	'7oqpv',	'13 rue de Chanzy',	'94000',	'Créteil',	'2002-02-11',	'05 45 56 78 14',	NULL),
('c3',	'De',	'Philippe',	'pde',	'gk9kx',	'13 rue Barthes',	'94000',	'Créteil',	'2010-12-14',	'05 45 56 78 15',	NULL),
('c54',	'Debelle',	'Michel',	'mdebelle',	'od5rt',	'181 avenue Barbusse',	'93210',	'Rosny',	'2006-11-23',	'05 45 56 78 16',	NULL),
('d13',	'Debelle',	'Jeanne',	'jdebelle',	'nvwqq',	'134 allée des Joncs',	'44000',	'Nantes',	'2000-05-11',	'05 45 56 78 17',	NULL),
('d51',	'Debroise',	'Michel',	'mdebroise',	'sghkb',	'2 Bld Jourdain',	'44000',	'Nantes',	'2001-04-17',	'05 45 56 78 19',	NULL),
('e10',	'coru',	'em',	'admin2',	'password',	'next',	'42170',	'st just',	'2022-03-02',	'05 45 56 78 56',	NULL),
('e22',	'Desmarquest',	'Nathalie',	'ndesmarquest',	'f1fob',	'14 Place d Arc',	'45000',	'Orléans',	'2005-11-12',	'05 45 56 78 45',	NULL),
('e24',	'Desnost',	'Pierre',	'pdesnost',	'4k2o5',	'16 avenue des Cèdres',	'23200',	'Guéret',	'2001-02-05',	'05 45 56 78 99',	NULL),
('e39',	'Dudouit',	'Frédéric',	'fdudouit',	'44im8',	'18 rue de l église',	'23120',	'GrandBourg',	'2000-08-01',	'05 45 56 78 415',	NULL),
('e49',	'Duncombe',	'Claude',	'cduncombe',	'qf77j',	'19 rue de la tour',	'23100',	'La souteraine',	'1987-10-10',	'05 45 78 26 15',	NULL),
('e5',	'Enault-Pascreau',	'Céline',	'cenault',	'y2qdu',	'25 place de la gare',	'23200',	'Gueret',	'1995-09-01',	'05 45 56 78 45',	NULL),
('e52',	'Eynde',	'Valérie',	'veynde',	'i7sn3',	'3 Grand Place',	'13015',	'Marseille',	'1999-11-01',	'05 45 56 78 59',	NULL),
('f21',	'Finck',	'Jacques',	'jfinck',	'mpb3t',	'10 avenue du Prado',	'13002',	'Marseille',	'2001-11-10',	'05 45 56 78 78',	NULL),
('f39',	'Frémont',	'Fernande',	'ffremont',	'xs5tq',	'4 route de la mer',	'13012',	'Allauh',	'1998-10-01',	'05 45 56 78 56',	NULL),
('f4',	'Gest',	'Alain',	'agest',	'dywvt',	'30 avenue de la mer',	'13025',	'Berre',	'1985-11-01',	'05 45 56 78 78',	NULL);

DROP TABLE IF EXISTS `Voiture`;
CREATE TABLE `Voiture` (
  `numero` varchar(20) NOT NULL,
  `constructeur` varchar(20) NOT NULL,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`numero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `Voiture` (`numero`, `type`) VALUES
('FV-052-VF',	'diesel');

-- 2022-03-08 10:13:33


f1fob
f1fob


-- Adminer 4.8.1 MySQL 5.5.5-10.5.12-MariaDB-0+deb11u1 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `APOURTAG`;
CREATE TABLE `APOURTAG` (
  `ref photo` int(10) NOT NULL,
  `ref tag` varchar(100) NOT NULL,
  PRIMARY KEY (`ref photo`,`ref tag`),
  KEY `ref tag` (`ref tag`),
  CONSTRAINT `APOURTAG_ibfk_1` FOREIGN KEY (`ref photo`) REFERENCES `PHOTO` (`id`),
  CONSTRAINT `APOURTAG_ibfk_2` FOREIGN KEY (`ref tag`) REFERENCES `TAG` (`libelleTag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `NOTER`;
CREATE TABLE `NOTER` (
  `refUtilisateur` varchar(40) NOT NULL,
  `refPhoto` int(40) NOT NULL,
  `note` int(11) NOT NULL,
  PRIMARY KEY (`refPhoto`,`refUtilisateur`),
  KEY `ref Utilisateur` (`refUtilisateur`),
  KEY `note` (`note`),
  CONSTRAINT `NOTER_ibfk_1` FOREIGN KEY (`refUtilisateur`) REFERENCES `UTILISATEUR` (`mail Utilisateur`),
  CONSTRAINT `NOTER_ibfk_2` FOREIGN KEY (`refPhoto`) REFERENCES `PHOTO` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `NOTER` (`refUtilisateur`, `refPhoto`, `note`) VALUES
('ilyesse.bouraghda@gmail.com',	1,	4),
('idriss.hml@gmail.com',	3,	5),
('idriss.hml@gmail.com',	1,	6),
('Antoine.bizo@gmail.com',	2,	6),
('Antoine.bizo@gmail.com',	1,	8),
('ilyesse.bouraghda@gmail.com',	2,	8),
('ilyesse.bouraghda@gmail.com',	3,	8),
('idriss.hml@gmail.com',	2,	9),
('Antoine.bizo@gmail.com',	3,	10);

DROP TABLE IF EXISTS `PHOTO`;
CREATE TABLE `PHOTO` (
  `id` int(10) NOT NULL,
  `lien` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `ref photographe` varchar(40) NOT NULL,
  `ref appareil` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ref photographe` (`ref photographe`),
  KEY `ref appareil` (`ref appareil`),
  CONSTRAINT `PHOTO_ibfk_1` FOREIGN KEY (`ref photographe`) REFERENCES `PHOTOGRAPHE` (`mail`),
  CONSTRAINT `PHOTO_ibfk_2` FOREIGN KEY (`ref appareil`) REFERENCES `TYPE APPAREIL` (`le type Appareil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `PHOTO` (`id`, `lien`, `date`, `ref photographe`, `ref appareil`) VALUES
(1,	'www.photo1.fr',	'2022-03-30',	'cristiano.ronaldo@gmail.com',	'appareils photo bridge'),
(2,	'www.photo2.fr',	'2022-03-30',	'stephane@gmail.com',	'appareils photo compact'),
(3,	'www.photo3.fr',	'2022-03-30',	'steve.jobs@gmail.com',	'appareils photo reflex');

DROP TABLE IF EXISTS `PHOTOGRAPHE`;
CREATE TABLE `PHOTOGRAPHE` (
  `mail` varchar(40) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `mot de passe` varchar(50) NOT NULL,
  PRIMARY KEY (`mail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `PHOTOGRAPHE` (`mail`, `nom`, `prenom`, `mot de passe`) VALUES
('cristiano.ronaldo@gmail.com',	'Ronaldo dos Santos Aveiro',	'cristiano',	'cr7'),
('stephane@gmail.com',	'stephane',	'islo',	'stephane10'),
('steve.jobs@gmail.com',	'steve',	'jobs',	'jobste');

DROP TABLE IF EXISTS `TAG`;
CREATE TABLE `TAG` (
  `libelleTag` varchar(100) NOT NULL,
  PRIMARY KEY (`libelleTag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `TARIF`;
CREATE TABLE `TARIF` (
  `note moyenne` int(11) NOT NULL,
  `prix` int(11) NOT NULL,
  PRIMARY KEY (`note moyenne`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `TYPE APPAREIL`;
CREATE TABLE `TYPE APPAREIL` (
  `le type Appareil` varchar(40) NOT NULL,
  PRIMARY KEY (`le type Appareil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `TYPE APPAREIL` (`le type Appareil`) VALUES
('appareils photo bridge'),
('appareils photo compact'),
('appareils photo reflex');

DROP TABLE IF EXISTS `UTILISATEUR`;
CREATE TABLE `UTILISATEUR` (
  `mail Utilisateur` varchar(40) NOT NULL,
  `mot de passe` varchar(50) NOT NULL,
  PRIMARY KEY (`mail Utilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `UTILISATEUR` (`mail Utilisateur`, `mot de passe`) VALUES
('Antoine.bizo@gmail.com',	'Antoine453'),
('idriss.hml@gmail.com',	'Idriss123'),
('ilyesse.bouraghda@gmail.com',	'Ilyesse000');

-- 2022-03-30 07:59:00
