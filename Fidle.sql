-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        8.0.20 - MySQL Community Server - GPL
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- 导出 fidle 的数据库结构
CREATE DATABASE IF NOT EXISTS `fidle` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `fidle`;

-- 导出  表 fidle.activity_category 结构
CREATE TABLE IF NOT EXISTS `activity_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category_id` bigint DEFAULT NULL COMMENT '类别id',
  `category_designation` varchar(20) DEFAULT NULL COMMENT '类别描述',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_activity_id_idx` (`category_id`),
  CONSTRAINT `fk_activity_id` FOREIGN KEY (`category_id`) REFERENCES `activity_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务类别表';

-- 正在导出表  fidle.activity_category 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `activity_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_category` ENABLE KEYS */;

-- 导出  表 fidle.activity_enshrine 结构
CREATE TABLE IF NOT EXISTS `activity_enshrine` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL COMMENT '用户id',
  `activity_id` bigint DEFAULT NULL COMMENT '活动id',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ae_user_id_idx` (`user_id`),
  KEY `fk_ae_activity_id_idx` (`activity_id`),
  CONSTRAINT `fk_ae_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `activity_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ae_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='活动收藏表';

-- 正在导出表  fidle.activity_enshrine 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `activity_enshrine` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_enshrine` ENABLE KEYS */;

-- 导出  表 fidle.activity_image 结构
CREATE TABLE IF NOT EXISTS `activity_image` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `activity_id` bigint DEFAULT NULL COMMENT '活动id',
  `image_link` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '图片链接',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_activity_image_idx` (`activity_id`),
  CONSTRAINT `fk_activity_image` FOREIGN KEY (`activity_id`) REFERENCES `activity_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='活动图片';

-- 正在导出表  fidle.activity_image 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `activity_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_image` ENABLE KEYS */;

-- 导出  表 fidle.activity_info 结构
CREATE TABLE IF NOT EXISTS `activity_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `pub_id` bigint DEFAULT NULL COMMENT '用户表id',
  `title` varchar(100) DEFAULT NULL COMMENT '标题',
  `address` varchar(100) DEFAULT NULL COMMENT '活动地点',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `description` varchar(2000) DEFAULT NULL COMMENT '详细描述',
  `category` int DEFAULT NULL COMMENT '类别',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pub_id_idx` (`pub_id`),
  CONSTRAINT `fk_pub_id` FOREIGN KEY (`pub_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='活动信息表';

-- 正在导出表  fidle.activity_info 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `activity_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_info` ENABLE KEYS */;

-- 导出  表 fidle.activity_report_message 结构
CREATE TABLE IF NOT EXISTS `activity_report_message` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `whistleblower_id` bigint DEFAULT NULL COMMENT '举报者id',
  `reported_activity_id` bigint DEFAULT NULL COMMENT '被举报活动信息id',
  `title` varchar(100) DEFAULT NULL COMMENT '标题',
  `reason` varchar(200) DEFAULT NULL COMMENT '举报理由',
  `state` int DEFAULT NULL COMMENT '状态：int（-1：未送出 0：未处理  1：未通过  2：已处理）',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_arm_whis_id_idx` (`whistleblower_id`),
  KEY `fk_arm_activity_id_idx` (`reported_activity_id`),
  CONSTRAINT `fk_arm_activity_id` FOREIGN KEY (`reported_activity_id`) REFERENCES `activity_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_arm_whis_id` FOREIGN KEY (`whistleblower_id`) REFERENCES `activity_report_message` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='活动举报信息表';

-- 正在导出表  fidle.activity_report_message 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `activity_report_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_report_message` ENABLE KEYS */;

-- 导出  表 fidle.activity_tag 结构
CREATE TABLE IF NOT EXISTS `activity_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `activity_id` bigint DEFAULT NULL COMMENT '活动id',
  `tag_id` bigint DEFAULT NULL COMMENT '标签id',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_activityid_idx` (`activity_id`),
  KEY `fk_tagid_idx` (`tag_id`),
  CONSTRAINT `fk_activityid` FOREIGN KEY (`activity_id`) REFERENCES `activity_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_activitytagid` FOREIGN KEY (`tag_id`) REFERENCES `tag_of_activity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='活动标签对应表';

-- 正在导出表  fidle.activity_tag 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `activity_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_tag` ENABLE KEYS */;

-- 导出  表 fidle.admin 结构
CREATE TABLE IF NOT EXISTS `admin` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '账号',
  `password` varchar(50) DEFAULT NULL COMMENT '密码',
  `salt` varchar(50) DEFAULT NULL COMMENT '盐',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='管理员表';

-- 正在导出表  fidle.admin 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;

-- 导出  表 fidle.credit 结构
CREATE TABLE IF NOT EXISTS `credit` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL COMMENT '用户id',
  `credit_score` int DEFAULT NULL COMMENT '信誉分',
  `like_num` int DEFAULT NULL COMMENT '点赞数',
  `dislike_num` int DEFAULT NULL COMMENT '点踩数',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `fk_credit_user_idx` (`user_id`),
  CONSTRAINT `fk_credit_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户信誉表';

-- 正在导出表  fidle.credit 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `credit` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit` ENABLE KEYS */;

-- 导出  表 fidle.goods_category 结构
CREATE TABLE IF NOT EXISTS `goods_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category_id` bigint DEFAULT NULL COMMENT '类别id',
  `category_designation` varchar(20) DEFAULT NULL COMMENT '类别描述',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_goods_id_idx` (`category_id`),
  CONSTRAINT `fk_goods_id` FOREIGN KEY (`category_id`) REFERENCES `goods_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='二手类别表';

-- 正在导出表  fidle.goods_category 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `goods_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods_category` ENABLE KEYS */;

-- 导出  表 fidle.goods_enshrine 结构
CREATE TABLE IF NOT EXISTS `goods_enshrine` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL COMMENT '用户id',
  `goods_id` bigint DEFAULT NULL COMMENT '二手物品id',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_goods_enshrine_idx` (`user_id`),
  KEY `fk_goods_id_idx` (`goods_id`),
  CONSTRAINT `fk_ge_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `goods_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ge_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='二手收藏表';

-- 正在导出表  fidle.goods_enshrine 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `goods_enshrine` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods_enshrine` ENABLE KEYS */;

-- 导出  表 fidle.goods_evaluation 结构
CREATE TABLE IF NOT EXISTS `goods_evaluation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `goods_id` bigint DEFAULT NULL COMMENT '二手订单id',
  `valuator_id` bigint DEFAULT NULL COMMENT '评价者id',
  `evaluation` int DEFAULT NULL COMMENT '评价:（-1：差评  1：好评）',
  `reason` varchar(100) DEFAULT NULL COMMENT '评价理由',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ge_valuator_id_idx` (`valuator_id`),
  KEY `fk_ge_goods_id_idx` (`goods_id`),
  CONSTRAINT `fk_ge_goodss_id` FOREIGN KEY (`goods_id`) REFERENCES `goods_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ge_valuator_id` FOREIGN KEY (`valuator_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='二手评价表';

-- 正在导出表  fidle.goods_evaluation 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `goods_evaluation` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods_evaluation` ENABLE KEYS */;

-- 导出  表 fidle.goods_image 结构
CREATE TABLE IF NOT EXISTS `goods_image` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `goods_id` bigint DEFAULT NULL COMMENT '二手id',
  `image_link` varchar(100) DEFAULT NULL COMMENT '图片链接',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_goods_image_idx` (`goods_id`),
  CONSTRAINT `fk_goods_image` FOREIGN KEY (`goods_id`) REFERENCES `goods_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='二手物品图片表';

-- 正在导出表  fidle.goods_image 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `goods_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods_image` ENABLE KEYS */;

-- 导出  表 fidle.goods_indent 结构
CREATE TABLE IF NOT EXISTS `goods_indent` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `goods_id` bigint DEFAULT NULL COMMENT '二手物品id',
  `buyer_id` bigint DEFAULT NULL COMMENT '买家id',
  `seller_id` bigint DEFAULT NULL COMMENT '卖家id',
  `buyer_evaluate_id` bigint DEFAULT NULL COMMENT '买家评价项id',
  `seller_evaluate_id` bigint DEFAULT NULL COMMENT '卖家评价项id',
  `is_seller_evaluated` int DEFAULT NULL COMMENT '卖家评价状态',
  `is_buyer_evaluated` int DEFAULT NULL COMMENT '买家评价状态',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_goods_info_id_idx` (`goods_id`),
  KEY `fk_pub_id_idx` (`buyer_id`),
  KEY `fk_seller_id_idx` (`seller_id`),
  KEY `fk_buyer_evaluation_idx` (`buyer_evaluate_id`),
  KEY `fk_seller_evaluation_idx` (`seller_evaluate_id`),
  CONSTRAINT `fk_buyer_evaluation` FOREIGN KEY (`buyer_evaluate_id`) REFERENCES `goods_evaluation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_buyer_id` FOREIGN KEY (`buyer_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_goods_info_id` FOREIGN KEY (`goods_id`) REFERENCES `goods_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_seller_evaluation` FOREIGN KEY (`seller_evaluate_id`) REFERENCES `goods_evaluation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_seller_id` FOREIGN KEY (`seller_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT=' 二手订单表';

-- 正在导出表  fidle.goods_indent 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `goods_indent` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods_indent` ENABLE KEYS */;

-- 导出  表 fidle.goods_info 结构
CREATE TABLE IF NOT EXISTS `goods_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `seller_id` bigint DEFAULT NULL COMMENT '卖家id',
  `title` varchar(100) DEFAULT NULL COMMENT '标题',
  `price` decimal(10,0) DEFAULT NULL COMMENT '价格',
  `original_price` decimal(10,0) DEFAULT NULL COMMENT '原价',
  `description` varchar(2000) DEFAULT NULL COMMENT '详细描述',
  `category` int DEFAULT NULL COMMENT '类别',
  `condition` int DEFAULT NULL COMMENT '新旧程度',
  `is_sold` int DEFAULT NULL COMMENT '是否售出（0：在售 1：已售）',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_seller_id_idx` (`seller_id`),
  CONSTRAINT `fk_info_seller_id` FOREIGN KEY (`seller_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='物品信息表';

-- 正在导出表  fidle.goods_info 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `goods_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods_info` ENABLE KEYS */;

-- 导出  表 fidle.goods_report_message 结构
CREATE TABLE IF NOT EXISTS `goods_report_message` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `whistleblower_id` bigint DEFAULT NULL COMMENT '举报者id',
  `reported_goods_id` bigint DEFAULT NULL COMMENT '被举报二手物品id',
  `title` varchar(100) DEFAULT NULL COMMENT '标题',
  `reason` varchar(200) DEFAULT NULL COMMENT '举报理由',
  `state` int DEFAULT NULL COMMENT '状态：int（-1：未送出 0：未处理  1：未通过  2：已处理）',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_grm_whis_id_idx` (`whistleblower_id`),
  KEY `fk_grm_goods_id_idx` (`reported_goods_id`),
  CONSTRAINT `fk_grm_goods_id` FOREIGN KEY (`reported_goods_id`) REFERENCES `goods_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_grm_whis_id` FOREIGN KEY (`whistleblower_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='二手举报信息表';

-- 正在导出表  fidle.goods_report_message 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `goods_report_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods_report_message` ENABLE KEYS */;

-- 导出  表 fidle.goods_tag 结构
CREATE TABLE IF NOT EXISTS `goods_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `goods_id` bigint DEFAULT NULL COMMENT '物品id',
  `tag_id` bigint DEFAULT NULL COMMENT '标签id',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_goods_id_idx` (`goods_id`),
  KEY `fk_tag_id_idx` (`tag_id`),
  CONSTRAINT `fk_goods_tag_id` FOREIGN KEY (`goods_id`) REFERENCES `goods_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `tag_of_goods` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='二手物品标签对应表';

-- 正在导出表  fidle.goods_tag 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `goods_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods_tag` ENABLE KEYS */;

-- 导出  表 fidle.system_message 结构
CREATE TABLE IF NOT EXISTS `system_message` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `acc_id` bigint DEFAULT NULL COMMENT '接收者id',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '标题',
  `content` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '内容',
  `link` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '链接',
  `state` int DEFAULT NULL COMMENT '状态（-1：未送出 0：未读  1：已读）',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sm_user_id_idx` (`acc_id`),
  CONSTRAINT `fk_sm_acc_id` FOREIGN KEY (`acc_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统消息表';

-- 正在导出表  fidle.system_message 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `system_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_message` ENABLE KEYS */;

-- 导出  表 fidle.tag_of_activity 结构
CREATE TABLE IF NOT EXISTS `tag_of_activity` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` varchar(10) DEFAULT NULL COMMENT '内容',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='活动标签表';

-- 正在导出表  fidle.tag_of_activity 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `tag_of_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag_of_activity` ENABLE KEYS */;

-- 导出  表 fidle.tag_of_goods 结构
CREATE TABLE IF NOT EXISTS `tag_of_goods` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` varchar(10) DEFAULT NULL COMMENT '内容',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='二手物品标签表';

-- 正在导出表  fidle.tag_of_goods 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `tag_of_goods` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag_of_goods` ENABLE KEYS */;

-- 导出  表 fidle.tag_of_task 结构
CREATE TABLE IF NOT EXISTS `tag_of_task` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` varchar(10) DEFAULT NULL COMMENT '内容',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务标签表';

-- 正在导出表  fidle.tag_of_task 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `tag_of_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag_of_task` ENABLE KEYS */;

-- 导出  表 fidle.task_category 结构
CREATE TABLE IF NOT EXISTS `task_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category_id` bigint DEFAULT NULL COMMENT '类别id',
  `category_designation` varchar(20) DEFAULT NULL COMMENT '类别描述',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_task_id_idx` (`category_id`),
  CONSTRAINT `fk_task_id` FOREIGN KEY (`category_id`) REFERENCES `task_information` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务类别类';

-- 正在导出表  fidle.task_category 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `task_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_category` ENABLE KEYS */;

-- 导出  表 fidle.task_delegate 结构
CREATE TABLE IF NOT EXISTS `task_delegate` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `task_info_id` bigint DEFAULT NULL COMMENT '任务信息id',
  `pub_id` bigint DEFAULT NULL COMMENT '发布方id',
  `acc_id` bigint DEFAULT NULL COMMENT '接收方id',
  `acc_evaluate_id` bigint DEFAULT NULL COMMENT '接收方评价项id',
  `pub_evaluate_id` bigint DEFAULT NULL COMMENT '发布方评价项id',
  `is_pub_evaluated` int DEFAULT NULL COMMENT '发布方评价状态',
  `is_acc_evaluated` int DEFAULT NULL COMMENT '接收方评价状态',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `fk_td_delegate_info_idx` (`task_info_id`),
  KEY `fk_td_pub_id_idx` (`pub_id`),
  KEY `fk_td_acc_id_idx` (`acc_id`),
  KEY `fk_acc_evaluate_id_idx` (`acc_evaluate_id`),
  KEY `fk_evaluate_id_idx` (`pub_evaluate_id`),
  CONSTRAINT `fk_acc_evaluate_id` FOREIGN KEY (`acc_evaluate_id`) REFERENCES `task_evaluation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_evaluate_id` FOREIGN KEY (`pub_evaluate_id`) REFERENCES `task_evaluation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_td_acc_id` FOREIGN KEY (`acc_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_td_delegate_info_id` FOREIGN KEY (`task_info_id`) REFERENCES `task_information` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_td_pub_id` FOREIGN KEY (`pub_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务委托项表';

-- 正在导出表  fidle.task_delegate 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `task_delegate` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_delegate` ENABLE KEYS */;

-- 导出  表 fidle.task_enshrine 结构
CREATE TABLE IF NOT EXISTS `task_enshrine` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL COMMENT '用户id',
  `task_id` bigint DEFAULT NULL COMMENT '任务委托表',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_te_user_id_idx` (`user_id`),
  KEY `fk_te_task_id_idx` (`task_id`),
  CONSTRAINT `fk_te_task_id` FOREIGN KEY (`task_id`) REFERENCES `task_information` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_te_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务收藏表';

-- 正在导出表  fidle.task_enshrine 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `task_enshrine` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_enshrine` ENABLE KEYS */;

-- 导出  表 fidle.task_evaluation 结构
CREATE TABLE IF NOT EXISTS `task_evaluation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `task_delegate_id` bigint DEFAULT NULL COMMENT '任务委托项id',
  `valuator_id` bigint DEFAULT NULL COMMENT '评价者id',
  `evaluation` int DEFAULT NULL COMMENT '评价(-1：差评 1:好评)',
  `reason` varchar(100) DEFAULT NULL COMMENT '理由',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_te_task_id_idx` (`task_delegate_id`),
  KEY `fk_te_valu_id_idx` (`valuator_id`),
  CONSTRAINT `fk_te_tasks_id` FOREIGN KEY (`task_delegate_id`) REFERENCES `task_information` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_te_valu_id` FOREIGN KEY (`valuator_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务评价表';

-- 正在导出表  fidle.task_evaluation 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `task_evaluation` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_evaluation` ENABLE KEYS */;

-- 导出  表 fidle.task_information 结构
CREATE TABLE IF NOT EXISTS `task_information` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `pub_id` bigint DEFAULT NULL COMMENT '发布者id',
  `task_state` int DEFAULT NULL COMMENT '任务状态 (-1：已取消  0：未接收 1：进行中 2：已完成)',
  `title` varchar(100) DEFAULT NULL COMMENT '标题',
  `reward` decimal(10,0) DEFAULT NULL COMMENT '酬劳',
  `start_time` datetime DEFAULT NULL COMMENT '任务开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '任务结束时间',
  `category` int DEFAULT NULL COMMENT '类别',
  `description` varchar(2000) DEFAULT NULL COMMENT '描述',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_task_pub_id_idx` (`pub_id`),
  CONSTRAINT `fk_task_pub_id` FOREIGN KEY (`pub_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务信息表';

-- 正在导出表  fidle.task_information 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `task_information` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_information` ENABLE KEYS */;

-- 导出  表 fidle.task_report_message 结构
CREATE TABLE IF NOT EXISTS `task_report_message` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `whistleblower_id` bigint DEFAULT NULL COMMENT '举报者id',
  `reported_task_id` bigint DEFAULT NULL COMMENT '被举报活动信息id',
  `title` varchar(100) DEFAULT NULL COMMENT '标题',
  `reason` varchar(200) DEFAULT NULL COMMENT '举报理由',
  `state` int DEFAULT NULL COMMENT '状态：int（-1：未送出 0：未处理  1：未通过  2：已处理）',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_trm_whis_id_idx` (`whistleblower_id`),
  KEY `fk_trm_task_id_idx` (`reported_task_id`),
  CONSTRAINT `fk_trm_task_id` FOREIGN KEY (`reported_task_id`) REFERENCES `task_information` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_trm_whis_id` FOREIGN KEY (`whistleblower_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务举报消息表';

-- 正在导出表  fidle.task_report_message 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `task_report_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_report_message` ENABLE KEYS */;

-- 导出  表 fidle.task_tag 结构
CREATE TABLE IF NOT EXISTS `task_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `task_id` bigint DEFAULT NULL COMMENT '任务id',
  `tag_id` bigint DEFAULT NULL COMMENT '标签id',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tag_id_idx` (`tag_id`),
  KEY `fk_tag_task_id_idx` (`task_id`),
  CONSTRAINT `fk_tagid` FOREIGN KEY (`tag_id`) REFERENCES `tag_of_task` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_taskid` FOREIGN KEY (`task_id`) REFERENCES `task_information` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务标签对应表';

-- 正在导出表  fidle.task_tag 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `task_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_tag` ENABLE KEYS */;

-- 导出  表 fidle.user 结构
CREATE TABLE IF NOT EXISTS `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(40) DEFAULT NULL COMMENT '用户名',
  `tel` varchar(20) DEFAULT NULL COMMENT '电话号码',
  `qq` varchar(20) DEFAULT NULL COMMENT 'qq',
  `wechat_account` varchar(100) DEFAULT NULL COMMENT '微信账号',
  `portrait` varchar(100) DEFAULT NULL COMMENT '头像链接',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';

-- 正在导出表  fidle.user 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
