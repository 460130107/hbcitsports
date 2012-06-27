/*
SQLyog ��ҵ�� - MySQL GUI v8.14 
MySQL - 5.5.25 : Database - smms
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`smms` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `smms`;

/*Table structure for table `t_department` */

DROP TABLE IF EXISTS `t_department`;

CREATE TABLE `t_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `departname` varchar(50) NOT NULL COMMENT '��������',
  `departshortname` varchar(10) DEFAULT NULL COMMENT 'ϵ��������д',
  `departtype` tinyint(1) NOT NULL COMMENT '�������ͣ�true��ʾ��ѧ����false��ʾ��ѧ��',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='�������ű�';

/*Data for the table `t_department` */

insert  into `t_department`(`id`,`departname`,`departshortname`,`departtype`) values (1,'˼�������빫��������ѧ��','���岿',0),(2,'���������ϵ','�����ϵ',1),(3,'���Ϲ���ϵ','����ϵ',1),(4,'���繤��ϵ','����ϵ',1);

/*Table structure for table `t_fieldjudge` */

DROP TABLE IF EXISTS `t_fieldjudge`;

CREATE TABLE `t_fieldjudge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gp2itid` int(11) NOT NULL COMMENT 'group2item���id',
  `judge_1` varchar(20) DEFAULT NULL COMMENT '���г�',
  `judge_2` varchar(20) DEFAULT NULL COMMENT '���г�����',
  `judge_3` text COMMENT '����Ա',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�������б�';

/*Data for the table `t_fieldjudge` */

/*Table structure for table `t_finalitem` */

DROP TABLE IF EXISTS `t_finalitem`;

CREATE TABLE `t_finalitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gp2itid` int(11) NOT NULL COMMENT '�������Ŀ��ϵid group2item',
  `finalitemname` varchar(50) NOT NULL COMMENT '��ֺ����Ŀ����',
  `finalitemtype` varchar(2) NOT NULL COMMENT '��ֺ����Ŀ���ͣ�1Ԥ����2������3Ԥ����',
  `date` varchar(10) DEFAULT NULL COMMENT '��Ŀ��������',
  `time` varchar(5) DEFAULT NULL COMMENT '��Ŀ����ʱ��',
  `groupnum` int(11) DEFAULT NULL COMMENT '��������',
  `promotionnum` int(11) DEFAULT NULL COMMENT '��������',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�������Ŀ��Ԥ������������ģ�';

/*Data for the table `t_finalitem` */

/*Table structure for table `t_group` */

DROP TABLE IF EXISTS `t_group`;

CREATE TABLE `t_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupname` varchar(50) NOT NULL COMMENT '������ƣ���ѧ���С��̹�������',
  `grouptype` tinyint(1) NOT NULL COMMENT '������ͣ�trueѧ����false�̹�',
  `groupsex` tinyint(3) DEFAULT NULL COMMENT '�����Ա�����true�У�falseŮ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='����';

/*Data for the table `t_group` */

/*Table structure for table `t_group2item` */

DROP TABLE IF EXISTS `t_group2item`;

CREATE TABLE `t_group2item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gp2spid` int(11) NOT NULL COMMENT '������˶����ϵgroup2sports id',
  `itemid` int(11) NOT NULL COMMENT '��Ŀid',
  `matchtype` varchar(1) NOT NULL COMMENT '�������ͣ�1Ԥ������2Ԥ��+������3֮��������չ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='��������Ŀ��Ӧ��ϵ��';

/*Data for the table `t_group2item` */

/*Table structure for table `t_group2sports` */

DROP TABLE IF EXISTS `t_group2sports`;

CREATE TABLE `t_group2sports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sportsid` int(11) NOT NULL COMMENT '�˶���id',
  `groupid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='������˶����ϵ��';

/*Data for the table `t_group2sports` */

/*Table structure for table `t_item` */

DROP TABLE IF EXISTS `t_item`;

CREATE TABLE `t_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `itemname` varchar(50) NOT NULL COMMENT '��Ŀ����',
  `itemtype` varchar(1) NOT NULL COMMENT '��Ŀ���ͣ�1������2������3����',
  `scoreformatid` int(11) DEFAULT NULL COMMENT '�ɼ���ʽID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='��Ŀ��';

/*Data for the table `t_item` */

insert  into `t_item`(`id`,`itemname`,`itemtype`,`scoreformatid`) values (1,'100��','1',1),(2,'��Զ','2',5),(3,'110�׿���','1',1),(4,'200��','1',1),(5,'400��','1',2),(6,'800��','1',3),(7,'1500��','1',3),(8,'400����','1',2),(9,'����','2',4),(10,'������Զ','2',4),(11,'Ǧ��','2',4),(12,'����','2',7),(13,'��ǹ','2',8),(14,'4*100��','3',2),(15,'4*400��','3',2);

/*Table structure for table `t_mark` */

DROP TABLE IF EXISTS `t_mark`;

CREATE TABLE `t_mark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sp2dpid` int(11) NOT NULL COMMENT '�˶����벿�Ź�ϵ��id',
  `sum` int(11) DEFAULT NULL COMMENT '�ܷ�',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='���ֱ�';

/*Data for the table `t_mark` */

/*Table structure for table `t_match` */

DROP TABLE IF EXISTS `t_match`;

CREATE TABLE `t_match` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `finalitemid` int(11) NOT NULL COMMENT '��ֺ����id',
  `teamnum` int(11) DEFAULT NULL COMMENT '�ڼ�С��',
  `runway` int(11) DEFAULT NULL COMMENT '�ܵ���',
  `playerid` int(11) DEFAULT NULL COMMENT '�˶�Աid',
  `score` varchar(50) DEFAULT NULL,
  `foul` tinyint(1) DEFAULT NULL COMMENT '�Ƿ񷸹�Υ�ͣ�trueΥ�ͣ�false����״̬',
  `recordlevel` int(11) NOT NULL DEFAULT '0' COMMENT '��¼����',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�������������飩';

/*Data for the table `t_match` */

/*Table structure for table `t_official` */

DROP TABLE IF EXISTS `t_official`;

CREATE TABLE `t_official` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sportsid` int(11) NOT NULL COMMENT '�˶���id',
  `presidium` text COMMENT '�����ϯ��',
  `org_committee_1` varchar(10) DEFAULT NULL COMMENT '�����ί��-����',
  `org_committee_2` varchar(20) DEFAULT NULL COMMENT '�����ί��-������',
  `org_committee_3` text COMMENT '�����ί��-ίԱ',
  `secretariat_1` varchar(10) DEFAULT NULL COMMENT '������鴦-���鳤',
  `secretariat_2` varchar(10) DEFAULT NULL COMMENT '������鴦-�����鳤',
  `secretariat_3` varchar(20) DEFAULT NULL COMMENT '������鴦-�����鸺����',
  `secretariat_4` varchar(20) DEFAULT NULL COMMENT '������鴦-�����鸺����',
  `secretariat_5` varchar(20) DEFAULT NULL COMMENT '������鴦-��Ʒ�鸺����',
  `secretariat_6` varchar(20) DEFAULT NULL COMMENT '������鴦-�����鸺����',
  `secretariat_7` varchar(20) DEFAULT NULL COMMENT '������鴦-���ڱ����鸺����',
  `arbitration` text COMMENT '�ٲ�ίԱ��',
  `chiefjudge_1` varchar(10) DEFAULT NULL COMMENT '�ܲ��г�',
  `chiefjudge_2` text COMMENT '���ܲ��г�',
  `trackjudge` varchar(10) DEFAULT NULL COMMENT '�������г�',
  `trackjudge_rollcall_1` varchar(10) DEFAULT NULL COMMENT '��¼���г�',
  `trackjudge_rollcall_2` varchar(10) DEFAULT NULL COMMENT '��¼���г�����',
  `trackjudge_rollcall_3` text COMMENT '��¼Ա',
  `startingpoint_1` varchar(10) DEFAULT NULL COMMENT '�����г�',
  `startingpoint_2` varchar(10) DEFAULT NULL COMMENT '�����г�����',
  `startingpoint_3` text COMMENT '����Ա',
  `timejudge_1` varchar(10) DEFAULT NULL COMMENT '��ʱ��',
  `timejudge_2` text COMMENT '��ʱԱ',
  `timejudge_3` varchar(20) DEFAULT NULL COMMENT '˾��Ա',
  `endpoint_1` varchar(10) DEFAULT NULL COMMENT '�յ���г�',
  `endpoint_2` varchar(10) DEFAULT NULL COMMENT '�յ���г�����',
  `endpoint_3` text COMMENT '�յ����Ա',
  `endpoint_4` varchar(10) DEFAULT NULL COMMENT '�յ��¼��',
  `endpoint_5` varchar(20) DEFAULT NULL COMMENT '�յ��¼Ա',
  `fieldjudge` varchar(10) DEFAULT NULL COMMENT '�������г�',
  `fieldjudge_1` varchar(10) DEFAULT NULL COMMENT '�����ܼ�¼���г�',
  `fieldjudge_2` text COMMENT '������¼Ա',
  `fieldjudge_3` varchar(10) DEFAULT NULL COMMENT '������鳤',
  `fieldjudge_4` text COMMENT '�������Ա',
  `fieldjudge_5` text COMMENT '���������鳤',
  `fieldjudge_6` text COMMENT '��������Ա',
  `remarks_1` text COMMENT '�μӰ취',
  `remarks_2` text COMMENT '����˵��',
  `remarks_3` text COMMENT '�Ʒַ���',
  `remarks_4` text COMMENT '����',
  `remarks_5` text COMMENT '������',
  `openingceremony` text COMMENT '��Ļʽ',
  `closingceremony` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='������Ա��';

/*Data for the table `t_official` */

/*Table structure for table `t_player` */

DROP TABLE IF EXISTS `t_player`;

CREATE TABLE `t_player` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sp2dpid` int(11) NOT NULL COMMENT '�˶���-������ϵ��id',
  `playernum` varchar(10) DEFAULT NULL,
  `playername` varchar(10) DEFAULT NULL COMMENT '�˶�Ա����',
  `playersex` tinyint(1) DEFAULT NULL COMMENT '�˶�Ա�Ա�true�У�falseŮ',
  `groupid` int(11) DEFAULT NULL COMMENT '���id',
  `registitem` varchar(255) DEFAULT NULL COMMENT '������������Ŀ����;������itemid�ַ���������1;2;3������1��2��3��������Ŀ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�˶�Ա��';

/*Data for the table `t_player` */

/*Table structure for table `t_playernum` */

DROP TABLE IF EXISTS `t_playernum`;

CREATE TABLE `t_playernum` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sp2dpid` int(11) NOT NULL COMMENT '�˶���2���ű�id sports2department',
  `beginnum` varchar(4) DEFAULT NULL COMMENT '��ʼ����',
  `endnum` varchar(4) DEFAULT NULL,
  `numtype` tinyint(1) DEFAULT NULL COMMENT '�������ͣ�trueѧ����false�̹�',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�˶�Ա����ֲ���';

/*Data for the table `t_playernum` */

/*Table structure for table `t_position` */

DROP TABLE IF EXISTS `t_position`;

CREATE TABLE `t_position` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `finalitemid` int(11) DEFAULT NULL COMMENT '�������id',
  `playerid` int(11) DEFAULT NULL COMMENT '�˶�Աid',
  `position` int(11) DEFAULT NULL COMMENT '����',
  `score` varchar(50) DEFAULT NULL COMMENT '�ɼ������ּ���������',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�������α�';

/*Data for the table `t_position` */

/*Table structure for table `t_record` */

DROP TABLE IF EXISTS `t_record`;

CREATE TABLE `t_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `itemid` int(11) NOT NULL COMMENT '��Ŀid',
  `sex` tinyint(1) DEFAULT NULL COMMENT 'true�У�falseŮ',
  `score` varchar(50) DEFAULT NULL COMMENT '�ɼ�',
  `playername` varchar(10) DEFAULT NULL COMMENT '�˶�Ա����',
  `departname` varchar(50) DEFAULT NULL COMMENT 'ϵ��',
  `sportsname` varchar(50) DEFAULT NULL COMMENT '�˶�������',
  `recordtime` varchar(10) DEFAULT NULL COMMENT '�Ƽ�¼ʱ��',
  `recordlevel` varchar(2) DEFAULT NULL COMMENT '��¼����0Ժ����1ʡ��',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='������¼��';

/*Data for the table `t_record` */

/*Table structure for table `t_rule` */

DROP TABLE IF EXISTS `t_rule`;

CREATE TABLE `t_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sportsid` int(11) NOT NULL COMMENT '�˶���id',
  `position` int(11) DEFAULT NULL COMMENT '���Σ�Ĭ��8',
  `mark` varchar(50) DEFAULT NULL COMMENT '���֣��м���,�������磺9,7,6,5,4,3,2,1',
  `recordmark_low` int(11) DEFAULT NULL COMMENT '��Ժ��¼�ļӷ�����Ĭ��9',
  `recordmark_high` int(11) DEFAULT NULL COMMENT '��ʡ��¼�ļӷ���',
  `perman` int(11) DEFAULT NULL COMMENT 'ÿϵÿ���˶�Ա�ޱ��������������⣩',
  `perdepartment` int(11) DEFAULT NULL COMMENT 'ÿ��ÿ��ϵ����λ�ޱ�����',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='��������';

/*Data for the table `t_rule` */

/*Table structure for table `t_scoreformat` */

DROP TABLE IF EXISTS `t_scoreformat`;

CREATE TABLE `t_scoreformat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `format` varchar(20) NOT NULL DEFAULT '' COMMENT '�ɼ���ʽ',
  `reg` varchar(10) NOT NULL DEFAULT '' COMMENT '�ɼ�����JavaScript��',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='�ɼ���ʽ��';

/*Data for the table `t_scoreformat` */

insert  into `t_scoreformat`(`id`,`format`,`reg`) values (1,'##.##','/^[1-5]?\\d'),(2,'#.##.##','/^[1-9]?\\.'),(3,'##.##.##','/^[1-9]?\\d'),(4,'#.##','/^[1-2]\\.\\'),(5,'#.##','/^[4-9]\\.\\'),(6,'##.##','/^[1-2]?\\d'),(7,'##.##','/^[1-7]\\d\\'),(9,'##.##','/^\\d\\d\\.\\d');

/*Table structure for table `t_sports` */

DROP TABLE IF EXISTS `t_sports`;

CREATE TABLE `t_sports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sportsname` varchar(50) NOT NULL COMMENT '�˶�������',
  `sportsbegin` varchar(10) NOT NULL COMMENT '��ʼ����',
  `sportsend` varchar(10) NOT NULL COMMENT '��������',
  `registend` varchar(10) NOT NULL COMMENT '������ֹ����',
  `address` varchar(50) NOT NULL COMMENT '���ص�',
  `current` tinyint(1) NOT NULL COMMENT '�Ƿ�ǰ�˶���',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='�˶����';

/*Data for the table `t_sports` */

insert  into `t_sports`(`id`,`sportsname`,`sportsbegin`,`sportsend`,`registend`,`address`,`current`) values (1,'�ӱ���Ժ��12���˶���','2012-02-01','2012-02-02','2012-01-30','��У���ٳ�',0),(2,'�ӱ���Ժ��13���˶���','2012-09-01','2012-09-02','2012-08-18','��У������ٳ�',1),(3,'�ӱ���Ժ��11���˶���','2010-01-10','2010-01-11','2010-01-01','ѧԺ�ﾶ������У����',0);

/*Table structure for table `t_sports2department` */

DROP TABLE IF EXISTS `t_sports2department`;

CREATE TABLE `t_sports2department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sportsid` int(11) NOT NULL COMMENT '�˶���id',
  `departid` int(11) NOT NULL COMMENT '����id',
  `teamleader` varchar(50) DEFAULT NULL COMMENT '���',
  `coach` varchar(50) DEFAULT NULL COMMENT '����',
  `doctor` varchar(50) DEFAULT NULL COMMENT '��ҽ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�˶����벿�Ŷ�Ӧ��';

/*Data for the table `t_sports2department` */

/*Table structure for table `t_stujudge` */

DROP TABLE IF EXISTS `t_stujudge`;

CREATE TABLE `t_stujudge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sp2dpid` int(11) NOT NULL COMMENT '�˶����벿�Ź�ϵid sports2department',
  `contact` varchar(20) DEFAULT NULL COMMENT '��ϵ������',
  `tel` varchar(50) DEFAULT NULL COMMENT '��ϵ�绰',
  `member` text COMMENT '���г�Ա',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ѧ�����б�';

/*Data for the table `t_stujudge` */

/*Table structure for table `t_sysadmin` */

DROP TABLE IF EXISTS `t_sysadmin`;

CREATE TABLE `t_sysadmin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '�û���',
  `password` varchar(255) NOT NULL COMMENT '����',
  `userright` int(11) NOT NULL COMMENT '�û�Ȩ��',
  `realname` varchar(50) NOT NULL COMMENT '�û���ʵ����',
  `departid` int(11) NOT NULL COMMENT '��λid�������ű����˺ŵ�departidӦ��Ӧt_department���id������Ա�Ͳ���Ա����Ӧ��',
  PRIMARY KEY (`id`),
  KEY `FK_department2sysadmin` (`departid`),
  CONSTRAINT `FK_department2sysadmin` FOREIGN KEY (`departid`) REFERENCES `t_department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='�˺ű�';

/*Data for the table `t_sysadmin` */

insert  into `t_sysadmin`(`id`,`username`,`password`,`userright`,`realname`,`departid`) values (2,'admin','96e79218965eb72c92a549dd5a330112',31,'ϵͳ����Ա',1),(5,'sohu','96e79218965eb72c92a549dd5a330112',22,'�Ѻ���',4),(6,'sina','96e79218965eb72c92a549dd5a330112',12,'����',3);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
