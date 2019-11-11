SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `user_info`
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `user_id` varchar(32) NOT NULL,
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名',
  `password` varchar(200) DEFAULT NULL COMMENT '密码',
  `real_name` varchar(50) DEFAULT NULL COMMENT '姓名',
  `sex` varchar(1) DEFAULT NULL COMMENT '性别（1男、2女）',
  `phone` varchar(50) DEFAULT NULL COMMENT '电话',
  `bank_name` varchar(50) DEFAULT NULL COMMENT '开户行',
  `bank_account` varchar(50) DEFAULT NULL COMMENT '银行卡号',
  `company` varchar(50) DEFAULT NULL COMMENT '公司',
  `address` varchar(100) DEFAULT NULL COMMENT '地址',
  `category` varchar(2) DEFAULT NULL COMMENT '类型（1管理员、2员工、3代理、4客户）',
  `remark` varchar(50) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `user_info`
-- ----------------------------
BEGIN;
INSERT INTO `user_info` VALUES ('1', 'wangliang', 'C6B57E47569E3F27D35B1877B6687029', '王亮', '1', '11111111111', null, null, '中商环宇', '北京市大兴区绿地缤纷城', '1', null, now(), now());
INSERT INTO `user_info` VALUES ('2', 'yuangong1', 'A', '员工A', '1', '11111111112', null, null, '中商环宇', '北京市大兴区绿地缤纷城', '2', null, now(), now());
INSERT INTO `user_info` VALUES ('3', 'yuangong2', 'A', '员工B', '2', '11111111113', null, null, '中商环宇', '北京市大兴区绿地缤纷城', '2', null, now(), now());
INSERT INTO `user_info` VALUES ('4', 'yuangong3', 'A', '员工C', '1', '11111111114', null, null, '中商环宇', '北京市大兴区绿地缤纷城', '2', null, now(), now());
INSERT INTO `user_info` VALUES ('5', 'daili1', 'A', '代理A', '1', '11111111115', null, null, null, null, '3', null, now(), now());
INSERT INTO `user_info` VALUES ('6', 'daili2', 'A', '代理B', '1', '11111111116', null, null, null, null, '3', null, now(), now());
INSERT INTO `user_info` VALUES ('7', 'daili3', 'A', '代理C', '1', '11111111117', null, null, null, null, '3', null, now(), now());
INSERT INTO `user_info` VALUES ('8', 'daili4', 'A', '代理D', '2', '11111111118', null, null, null, null, '3', null, now(), now());
INSERT INTO `user_info` VALUES ('9', 'daili5', 'A', '代理E', '1', '11111111119', null, null, null, null, '3', null, now(), now());
INSERT INTO `user_info` VALUES ('10', 'kehu1', 'A', '客户A', '1', '11111111120', null, null, null, null, '4', null, now(), now());
INSERT INTO `user_info` VALUES ('11', 'kehu2', 'A', '客户B', '2', '11111111120', null, null, null, null, '4', null, now(), now());
INSERT INTO `user_info` VALUES ('12', 'kehu3', 'A', '客户C', '1', '11111111120', null, null, null, null, '4', null, now(), now());
INSERT INTO `user_info` VALUES ('13', 'kehu4', 'A', '客户D', '1', '11111111120', null, null, null, null, '4', null, now(), now());
INSERT INTO `user_info` VALUES ('14', 'kehu5', 'A', '客户E', '1', '11111111120', null, null, null, null, '4', null, now(), now());
INSERT INTO `user_info` VALUES ('15', 'kehu6', 'A', '客户F', '2', '11111111120', null, null, null, null, '4', null, now(), now());
INSERT INTO `user_info` VALUES ('16', 'kehu7', 'A', '客户G', '2', '11111111120', null, null, null, null, '4', null, now(), now());
INSERT INTO `user_info` VALUES ('17', 'kehu8', 'A', '客户H', '1', '11111111120', null, null, null, null, '4', null, now(), now());
INSERT INTO `user_info` VALUES ('18', 'kehu9', 'A', '客户I', '1', '11111111120', null, null, null, null, '4', null, now(), now());
INSERT INTO `user_info` VALUES ('19', 'kehu10', 'A', '客户J', '1', '11111111120', null, null, null, null, '4', null, now(), now());
COMMIT;

-- ----------------------------
--  Table structure for `user_rln`
-- ----------------------------
DROP TABLE IF EXISTS `user_rln`;
CREATE TABLE `user_rln` (
  `rln_id` varchar(32) NOT NULL,
  `user_id` varchar(32) NOT NULL,
  `par_user_id` varchar(32) DEFAULT NULL COMMENT '上级用户id',
  `real_name` varchar(50) DEFAULT NULL COMMENT '姓名',
  `agent_id` varchar(32) DEFAULT NULL COMMENT '代理用户id',
  `status` varchar(2) DEFAULT NULL COMMENT '状态（1正常、2进行中）',
  PRIMARY KEY (`rln_id`),
  KEY `user_id_index` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `user_rln`
-- ----------------------------
BEGIN;
INSERT INTO `user_rln` VALUES ('001', '1', null, '', null, '1');
INSERT INTO `user_rln` VALUES ('002', '2', '1', '', null, '1');
INSERT INTO `user_rln` VALUES ('003', '3', '1', '', null, '1');
INSERT INTO `user_rln` VALUES ('004', '4', '1', '', null, '1');
INSERT INTO `user_rln` VALUES ('005', '5', '2', '', null, '1');
INSERT INTO `user_rln` VALUES ('006', '6', '2', '', null, '1');
INSERT INTO `user_rln` VALUES ('007', '7', '4', '', null, '1');
INSERT INTO `user_rln` VALUES ('008', '8', '4', '', null, '1');
INSERT INTO `user_rln` VALUES ('009', '9', '4', '', null, '1');
INSERT INTO `user_rln` VALUES ('010', '10', '5', '', '5', '1');
INSERT INTO `user_rln` VALUES ('011', '11', '5', '', '5', '1');
INSERT INTO `user_rln` VALUES ('012', '12', '5', '', '5', '1');
INSERT INTO `user_rln` VALUES ('013', '13', '6', '', '6', '1');
INSERT INTO `user_rln` VALUES ('014', '14', '7', '', '7', '1');
INSERT INTO `user_rln` VALUES ('015', '15', '7', '', '7', '1');
INSERT INTO `user_rln` VALUES ('016', '16', '9', '', '9', '1');
INSERT INTO `user_rln` VALUES ('017', '17', '11', '', '5', '1');
INSERT INTO `user_rln` VALUES ('018', '18', '13', '', '6', '1');
INSERT INTO `user_rln` VALUES ('019', '19', '13', '', '6', '1');
COMMIT;