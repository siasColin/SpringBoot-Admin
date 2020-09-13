/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.0.135_6001
 Source Server Type    : MySQL
 Source Server Version : 50730
 Source Host           : 192.168.0.135:6001
 Source Schema         : portal

 Target Server Type    : MySQL
 Target Server Version : 50730
 File Encoding         : 65001

 Date: 13/09/2020 13:12:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_application
-- ----------------------------
DROP TABLE IF EXISTS `sys_application`;
CREATE TABLE `sys_application`  (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `application_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '子系统名称/编码（唯一）',
  `application_name_zh` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '子系统中文名称',
  `application_url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '子系统地址',
  `login_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '子系统用户名',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '子系统密码',
  `create_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `sort_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `inx_sysApplication_name`(`application_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '子系统注册表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_application
-- ----------------------------
INSERT INTO `sys_application` VALUES (463584063687548928, 'Subsystem', '测试子系统', 'http://127.0.0.1:8082', NULL, NULL, 'admin', '2020-09-09 16:04:24', NULL);

-- ----------------------------
-- Table structure for sys_area
-- ----------------------------
DROP TABLE IF EXISTS `sys_area`;
CREATE TABLE `sys_area`  (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `area_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地区名称',
  `area_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地区编码',
  `area_level` int(11) NOT NULL COMMENT '地区等级(0 国家 1 省 2 直辖市 3 地级市 4 县 5 乡/镇 6 村)',
  `parent_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '父地区编码',
  `longitude` decimal(10, 6) NULL DEFAULT NULL COMMENT '经度',
  `latitude` decimal(10, 6) NULL DEFAULT NULL COMMENT '纬度',
  `create_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `sort_num` int(11) NULL DEFAULT NULL COMMENT '排序字段',
  `application_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建系统名称（每个系统的唯一标识）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `inx_sysarea_id`(`id`) USING BTREE,
  UNIQUE INDEX `inx_sysarea_areacode`(`area_code`) USING BTREE,
  INDEX `inx_sysarea_areaname`(`area_name`) USING BTREE,
  INDEX `inx_sysarea_parentcode`(`parent_code`) USING BTREE,
  INDEX `inx_sysarea_level`(`area_level`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '地区表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_area
-- ----------------------------
INSERT INTO `sys_area` VALUES (1, '河南省', '410000000000', 1, '41', 113.628962, 34.757272, 'admin', '2020-03-07 15:07:00', 0, NULL);
INSERT INTO `sys_area` VALUES (335383212932988928, '郑州市', '410100000000', 3, '410000000000', 113.628960, 34.757270, 'admin', '2020-03-07 15:08:10', 1, NULL);
INSERT INTO `sys_area` VALUES (400536107900534784, '新郑市', '410100000009', 4, '410100000000', NULL, NULL, 'admin', '2020-03-19 08:34:19', NULL, NULL);

-- ----------------------------
-- Table structure for sys_modulelist
-- ----------------------------
DROP TABLE IF EXISTS `sys_modulelist`;
CREATE TABLE `sys_modulelist`  (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `pid` bigint(20) NOT NULL COMMENT '父级菜单ID',
  `module_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `module_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单编码',
  `module_icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单图标（样式）',
  `module_url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单链接地址',
  `module_target` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '打开位置navTab（系统内打开）、_blank(新窗口打开) ,默认（navTab）',
  `module_type` int(11) NOT NULL COMMENT '菜单还是功能点，1菜单，0功能点',
  `module_status` int(11) NOT NULL COMMENT '菜单状态，1启用，0禁用',
  `application_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建系统名称（每个系统的唯一标识）',
  `module_attr` int(11) NULL DEFAULT 1 COMMENT '菜单属性（1 私有，2 共享）',
  `sort_num` int(11) NULL DEFAULT NULL COMMENT '排序字段',
  `create_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_sysmodullist_id`(`id`) USING BTREE,
  UNIQUE INDEX `idx_sysmodullist_code`(`module_code`, `application_name`) USING BTREE,
  INDEX `idx_sysmodullist_pid`(`pid`) USING BTREE,
  INDEX `idx_sysmodullist_name`(`module_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_modulelist
-- ----------------------------
INSERT INTO `sys_modulelist` VALUES (1, -1, '菜单', 'PROJECTNAME', '', '', 'navTab', 1, 1, 'Portal', 1, NULL, 'admin', '2020-03-21 18:41:27');
INSERT INTO `sys_modulelist` VALUES (2, 404512093411278848, '地区管理', 'AREAMANAGE', 'icon-reorder', '', 'navTab', 0, 1, 'Portal', 2, NULL, 'admin', '2020-03-21 18:42:27');
INSERT INTO `sys_modulelist` VALUES (404510340498391040, 404512093411278848, '机构管理', 'ORGMANAGE', 'icon-reorder', 'orgManage/orglist', 'navTab', 1, 1, 'Portal', 2, 2, 'admin', '2020-03-30 07:46:30');
INSERT INTO `sys_modulelist` VALUES (404510461441146880, 404512093411278848, '菜单管理', 'MENUMANAGE', 'icon-reorder', 'menuManage/menulist', 'navTab', 1, 1, 'Portal', 2, 3, 'admin', '2020-03-30 07:46:59');
INSERT INTO `sys_modulelist` VALUES (404510593343619072, 404512093411278848, '角色管理', 'ROLEMANAGE', 'icon-reorder', '', 'navTab', 0, 1, 'Portal', 2, 4, 'admin', '2020-03-30 07:47:31');
INSERT INTO `sys_modulelist` VALUES (404510764731269120, 404512093411278848, '用户管理', 'USERMANAGE', 'icon-reorder', 'userManage/userManageList', 'navTab', 0, 1, 'Portal', 2, 5, 'admin', '2020-03-30 07:48:11');
INSERT INTO `sys_modulelist` VALUES (404511178339975168, 2, '地区管理', 'AREAMANAGEFUNC', 'icon-reorder', 'areaManage/arealist', 'navTab', 1, 1, 'Portal', 2, 1, 'admin', '2020-03-30 07:49:50');
INSERT INTO `sys_modulelist` VALUES (404511379884670976, 404510593343619072, '角色管理', 'ROLEMANAGEFUNC', 'icon-reorder', 'roleManage/roleManageList', 'navTab', 1, 1, 'Portal', 2, 1, 'admin', '2020-03-30 07:50:38');
INSERT INTO `sys_modulelist` VALUES (404511457638678528, 404510593343619072, '角色菜单授权', 'ROLEANDMENU', 'icon-reorder', 'roleManage/roleAndMenu', 'navTab', 1, 1, 'Portal', 2, 3, 'admin', '2020-03-30 07:50:57');
INSERT INTO `sys_modulelist` VALUES (404512093411278848, 462864005579464704, '系统管理', 'SYSTEMMANAGE', 'icon-cog', '', 'navTab', 0, 1, 'Portal', 2, 1, 'admin', '2020-03-30 07:53:28');
INSERT INTO `sys_modulelist` VALUES (408870234521403392, 404510593343619072, '角色用户绑定', 'ROLEANDUSERBIND', 'icon-reorder', 'roleManage/roleAndUser', 'navTab', 1, 1, 'Portal', 2, 2, 'admin', '2020-04-11 08:31:10');
INSERT INTO `sys_modulelist` VALUES (462864005579464704, 1, '门户', 'PORTAL', '', '', 'navTab', 0, 1, 'Portal', 1, 0, 'admin', '2020-09-07 16:23:09');
INSERT INTO `sys_modulelist` VALUES (463242895539888128, 462864005579464704, '应用管理', 'APPLICATIONMANAGE', 'icon-sitemap', 'applicationManage/applicationManageList', 'navTab', 1, 1, 'Portal', 1, 2, 'admin', '2020-09-08 17:28:43');
INSERT INTO `sys_modulelist` VALUES (463561666653642752, 1, '测试子系统', 'SUBSYSTEM', NULL, NULL, 'navTab', 0, 1, 'Subsystem', 0, NULL, 'admin', '2020-09-09 14:35:24');
INSERT INTO `sys_modulelist` VALUES (463561666653642753, 463561666653642761, '地区管理', 'AREAMANAGE', 'icon-reorder', '', 'navTab', 0, 1, 'Subsystem', 2, NULL, 'admin', '2020-03-21 18:42:27');
INSERT INTO `sys_modulelist` VALUES (463561666653642754, 463561666653642761, '机构管理', 'ORGMANAGE', 'icon-reorder', 'orgManage/orglist', 'navTab', 1, 1, 'Subsystem', 2, 2, 'admin', '2020-03-30 07:46:30');
INSERT INTO `sys_modulelist` VALUES (463561666653642755, 463561666653642761, '菜单管理', 'MENUMANAGE', 'icon-reorder', 'menuManage/menulist', 'navTab', 1, 1, 'Subsystem', 2, 3, 'admin', '2020-03-30 07:46:59');
INSERT INTO `sys_modulelist` VALUES (463561666653642756, 463561666653642761, '角色管理', 'ROLEMANAGE', 'icon-reorder', '', 'navTab', 0, 1, 'Subsystem', 2, 4, 'admin', '2020-03-30 07:47:31');
INSERT INTO `sys_modulelist` VALUES (463561666653642757, 463561666653642761, '用户管理', 'USERMANAGE', 'icon-reorder', 'userManage/userManageList', 'navTab', 0, 1, 'Subsystem', 2, 5, 'admin', '2020-03-30 07:48:11');
INSERT INTO `sys_modulelist` VALUES (463561666653642758, 463561666653642753, '地区管理', 'AREAMANAGEFUNC', 'icon-reorder', 'areaManage/arealist', 'navTab', 1, 1, 'Subsystem', 2, 1, 'admin', '2020-03-30 07:49:50');
INSERT INTO `sys_modulelist` VALUES (463561666653642759, 463561666653642756, '角色管理', 'ROLEMANAGEFUNC', 'icon-reorder', 'roleManage/roleManageList', 'navTab', 1, 1, 'Subsystem', 2, 1, 'admin', '2020-03-30 07:50:38');
INSERT INTO `sys_modulelist` VALUES (463561666653642760, 463561666653642756, '角色菜单授权', 'ROLEANDMENU', 'icon-reorder', 'roleManage/roleAndMenu', 'navTab', 1, 1, 'Subsystem', 2, 3, 'admin', '2020-03-30 07:50:57');
INSERT INTO `sys_modulelist` VALUES (463561666653642761, 463561666653642752, '系统管理', 'SYSTEMMANAGE', 'icon-cog', '', 'navTab', 0, 1, 'Subsystem', 2, 1, 'admin', '2020-03-30 07:53:28');
INSERT INTO `sys_modulelist` VALUES (463561666653642762, 463561666653642756, '角色用户绑定', 'ROLEANDUSERBIND', 'icon-reorder', 'roleManage/roleAndUser', 'navTab', 1, 1, 'Subsystem', 2, 2, 'admin', '2020-04-11 08:31:10');
INSERT INTO `sys_modulelist` VALUES (463645654579732480, 463561666653642752, '任务管理', 'QUARTZMANAGE', 'icon-th', 'quartzManage/quzrtzManagelist', 'navTab', 1, 1, 'Subsystem', 1, 2, 'admin', '2020-09-09 20:09:08');
INSERT INTO `sys_modulelist` VALUES (463939432767086592, 463561666653642752, '文章管理', 'ARTICLEMANAGE', 'icon-book', '', 'navTab', 0, 1, 'Subsystem', 1, 3, 'admin', '2020-09-10 15:36:31');
INSERT INTO `sys_modulelist` VALUES (463939572810702848, 463939432767086592, '文章分类管理', 'ARTICLETYPE', 'icon-reorder', 'articleTypeManage/articleTypeList', 'navTab', 1, 1, 'Subsystem', 1, 0, 'admin', '2020-09-10 15:37:04');
INSERT INTO `sys_modulelist` VALUES (463939784589500416, 463939432767086592, '我的文章', 'MYARTICLE', 'icon-reorder', '', 'navTab', 0, 1, 'Subsystem', 1, 1, 'admin', '2020-09-10 15:37:54');
INSERT INTO `sys_modulelist` VALUES (463939914340294656, 463939784589500416, '发布文章', 'ARTICLEPUBLISH', 'icon-reorder', 'articleManage/article', 'navTab', 1, 1, 'Subsystem', 1, 1, 'admin', '2020-09-10 15:38:25');
INSERT INTO `sys_modulelist` VALUES (463940030316994560, 463939784589500416, '已发布', 'MYARTICLElIST', 'icon-reorder', 'articleManage/myArticleList', 'navTab', 1, 1, 'Subsystem', 1, 2, 'admin', '2020-09-10 15:38:53');
INSERT INTO `sys_modulelist` VALUES (463940168624168960, 463939432767086592, '文章管理', 'ARTICLElIST', 'icon-reorder', 'articleManage/articleList', 'navTab', 1, 1, 'Subsystem', 1, 2, 'admin', '2020-09-10 15:39:26');

-- ----------------------------
-- Table structure for sys_operatetype
-- ----------------------------
DROP TABLE IF EXISTS `sys_operatetype`;
CREATE TABLE `sys_operatetype`  (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `operate_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编码',
  `operate_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `operate_describe` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `create_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `inx_operate_id`(`id`) USING BTREE,
  UNIQUE INDEX `inx_operate_code`(`operate_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统权限表\r\n例如：ADMIN_AUTH（管理员权限），INSERT_AUTH（数据添加权限）\r\n' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_operatetype
-- ----------------------------
INSERT INTO `sys_operatetype` VALUES (1, 'INSERT_AUTH', '数据添加权限', '数据添加权限', 'admin', '2020-03-07 15:34:23');
INSERT INTO `sys_operatetype` VALUES (2, 'ADMIN_AUTH', '管理员权限', '管理员权限', 'admin', '2020-03-07 21:53:40');
INSERT INTO `sys_operatetype` VALUES (3, 'UPDATE_AUTH', '数据修改权限', '数据修改权限', 'admin', '2020-03-14 15:56:50');
INSERT INTO `sys_operatetype` VALUES (4, 'DELETE_AUTH', '数据删除权限', '数据删除权限', 'admin', '2020-03-14 15:57:48');

-- ----------------------------
-- Table structure for sys_org
-- ----------------------------
DROP TABLE IF EXISTS `sys_org`;
CREATE TABLE `sys_org`  (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `area_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '关联地区表',
  `org_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '机构名称',
  `org_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '机构编码',
  `parent_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '父级机构编码',
  `industryid` bigint(20) NULL DEFAULT NULL COMMENT '关联行业表（备用）',
  `org_address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机构地址',
  `org_logo` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机构logo',
  `create_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `sort_num` int(11) NULL DEFAULT NULL COMMENT '排序字段',
  `application_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建系统名称（每个系统的唯一标识）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `inx_sysorg_orgid`(`id`) USING BTREE,
  UNIQUE INDEX `inx_sysorg_orgcode`(`org_code`) USING BTREE,
  INDEX `inx_sysorg_parentcode`(`parent_code`) USING BTREE,
  INDEX `inx_sysorg_orgname`(`org_name`) USING BTREE,
  INDEX `inx_area_org`(`area_code`) USING BTREE,
  CONSTRAINT `sys_org_ibfk_1` FOREIGN KEY (`area_code`) REFERENCES `sys_area` (`area_code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '机构表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_org
-- ----------------------------
INSERT INTO `sys_org` VALUES (0, '410000000000', '河南省', '41000000000000', '-1', 0, '', '', NULL, NULL, NULL, NULL);
INSERT INTO `sys_org` VALUES (1, '410000000000', '河南省气象局', '41000041600000', '41000000000000', 416, NULL, NULL, 'admin', '2020-03-07 15:09:41', 0, NULL);
INSERT INTO `sys_org` VALUES (335386239865716736, '410000000000', '服务中心', '41000041601000', '41000041600000', 416, '', 'uploadfile/orgLogo/APP应用图标3.png', 'admin', '2020-03-07 15:11:46', 1, NULL);
INSERT INTO `sys_org` VALUES (404189543468695552, '410100000000', '郑州市', '41010000000000', '41000000000000', NULL, '', '', 'admin', '2020-03-29 10:31:46', NULL, NULL);
INSERT INTO `sys_org` VALUES (404189606702022656, '410100000000', '郑州市气象局', '41010041600000', '41010000000000', NULL, '', '', 'admin', '2020-03-29 10:32:01', NULL, NULL);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `role_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色编码',
  `role_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `role_attr` int(11) NOT NULL COMMENT '角色属性(0 共享，1 私有)',
  `org_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机构编码（role_attr为1时该字段不能为空）',
  `area_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '关联地区表地区编码',
  `role_status` int(11) NOT NULL COMMENT '状态，1启用，0禁用',
  `create_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `sort_num` int(11) NULL DEFAULT NULL COMMENT '排序字段',
  `application_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建系统名称（每个系统的唯一标识）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `inx_sysrole_id`(`id`) USING BTREE,
  UNIQUE INDEX `inx_sysrole_code`(`role_code`) USING BTREE,
  INDEX `inx_sysrole_status`(`role_status`) USING BTREE,
  INDEX `inx_sysrole_name`(`role_name`) USING BTREE,
  INDEX `inx_sysrole_areacode`(`area_code`) USING BTREE,
  CONSTRAINT `sys_role_ibfk_1` FOREIGN KEY (`area_code`) REFERENCES `sys_area` (`area_code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, 'ADMIN', '管理员', 0, NULL, '410000000000', 1, 'admin', '2020-03-07 15:36:42', 0, NULL);
INSERT INTO `sys_role` VALUES (403730211182542848, 'ZZADMIN', '郑州市管理员', 0, NULL, '410100000000', 1, 'admin', '2020-03-28 04:06:33', 1, NULL);
INSERT INTO `sys_role` VALUES (404189812852064256, 'ZZPRIVATETEST', '郑州市私有角色', 1, '41010041600000', '410100000000', 1, 'admin', '2020-03-29 10:32:51', 2, NULL);
INSERT INTO `sys_role` VALUES (424809644588851200, 'GENERAL', '普通用户', 0, NULL, '410000000000', 1, 'admin', '2020-05-25 16:08:42', 2, NULL);

-- ----------------------------
-- Table structure for sys_role_modulelist
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_modulelist`;
CREATE TABLE `sys_role_modulelist`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `modulelist_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `modulelist_id`) USING BTREE,
  INDEX `FK_Reference_modulelist_role`(`modulelist_id`) USING BTREE,
  CONSTRAINT `sys_role_modulelist_ibfk_1` FOREIGN KEY (`modulelist_id`) REFERENCES `sys_modulelist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_role_modulelist_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_modulelist
-- ----------------------------
INSERT INTO `sys_role_modulelist` VALUES (1, 1);
INSERT INTO `sys_role_modulelist` VALUES (403730211182542848, 1);
INSERT INTO `sys_role_modulelist` VALUES (424809644588851200, 1);
INSERT INTO `sys_role_modulelist` VALUES (1, 2);
INSERT INTO `sys_role_modulelist` VALUES (403730211182542848, 2);
INSERT INTO `sys_role_modulelist` VALUES (424809644588851200, 2);
INSERT INTO `sys_role_modulelist` VALUES (1, 404510340498391040);
INSERT INTO `sys_role_modulelist` VALUES (424809644588851200, 404510340498391040);
INSERT INTO `sys_role_modulelist` VALUES (1, 404510461441146880);
INSERT INTO `sys_role_modulelist` VALUES (424809644588851200, 404510461441146880);
INSERT INTO `sys_role_modulelist` VALUES (1, 404510593343619072);
INSERT INTO `sys_role_modulelist` VALUES (424809644588851200, 404510593343619072);
INSERT INTO `sys_role_modulelist` VALUES (1, 404510764731269120);
INSERT INTO `sys_role_modulelist` VALUES (424809644588851200, 404510764731269120);
INSERT INTO `sys_role_modulelist` VALUES (1, 404511178339975168);
INSERT INTO `sys_role_modulelist` VALUES (424809644588851200, 404511178339975168);
INSERT INTO `sys_role_modulelist` VALUES (1, 404511379884670976);
INSERT INTO `sys_role_modulelist` VALUES (424809644588851200, 404511379884670976);
INSERT INTO `sys_role_modulelist` VALUES (1, 404511457638678528);
INSERT INTO `sys_role_modulelist` VALUES (424809644588851200, 404511457638678528);
INSERT INTO `sys_role_modulelist` VALUES (1, 404512093411278848);
INSERT INTO `sys_role_modulelist` VALUES (424809644588851200, 404512093411278848);
INSERT INTO `sys_role_modulelist` VALUES (1, 408870234521403392);
INSERT INTO `sys_role_modulelist` VALUES (424809644588851200, 408870234521403392);
INSERT INTO `sys_role_modulelist` VALUES (1, 462864005579464704);
INSERT INTO `sys_role_modulelist` VALUES (424809644588851200, 462864005579464704);
INSERT INTO `sys_role_modulelist` VALUES (1, 463242895539888128);
INSERT INTO `sys_role_modulelist` VALUES (1, 463561666653642752);
INSERT INTO `sys_role_modulelist` VALUES (403730211182542848, 463561666653642752);
INSERT INTO `sys_role_modulelist` VALUES (404189812852064256, 463561666653642752);
INSERT INTO `sys_role_modulelist` VALUES (1, 463561666653642753);
INSERT INTO `sys_role_modulelist` VALUES (403730211182542848, 463561666653642753);
INSERT INTO `sys_role_modulelist` VALUES (404189812852064256, 463561666653642753);
INSERT INTO `sys_role_modulelist` VALUES (1, 463561666653642754);
INSERT INTO `sys_role_modulelist` VALUES (403730211182542848, 463561666653642754);
INSERT INTO `sys_role_modulelist` VALUES (404189812852064256, 463561666653642754);
INSERT INTO `sys_role_modulelist` VALUES (1, 463561666653642755);
INSERT INTO `sys_role_modulelist` VALUES (403730211182542848, 463561666653642755);
INSERT INTO `sys_role_modulelist` VALUES (404189812852064256, 463561666653642755);
INSERT INTO `sys_role_modulelist` VALUES (1, 463561666653642756);
INSERT INTO `sys_role_modulelist` VALUES (403730211182542848, 463561666653642756);
INSERT INTO `sys_role_modulelist` VALUES (404189812852064256, 463561666653642756);
INSERT INTO `sys_role_modulelist` VALUES (1, 463561666653642757);
INSERT INTO `sys_role_modulelist` VALUES (403730211182542848, 463561666653642757);
INSERT INTO `sys_role_modulelist` VALUES (404189812852064256, 463561666653642757);
INSERT INTO `sys_role_modulelist` VALUES (1, 463561666653642758);
INSERT INTO `sys_role_modulelist` VALUES (403730211182542848, 463561666653642758);
INSERT INTO `sys_role_modulelist` VALUES (404189812852064256, 463561666653642758);
INSERT INTO `sys_role_modulelist` VALUES (1, 463561666653642759);
INSERT INTO `sys_role_modulelist` VALUES (403730211182542848, 463561666653642759);
INSERT INTO `sys_role_modulelist` VALUES (404189812852064256, 463561666653642759);
INSERT INTO `sys_role_modulelist` VALUES (1, 463561666653642760);
INSERT INTO `sys_role_modulelist` VALUES (403730211182542848, 463561666653642760);
INSERT INTO `sys_role_modulelist` VALUES (404189812852064256, 463561666653642760);
INSERT INTO `sys_role_modulelist` VALUES (1, 463561666653642761);
INSERT INTO `sys_role_modulelist` VALUES (403730211182542848, 463561666653642761);
INSERT INTO `sys_role_modulelist` VALUES (404189812852064256, 463561666653642761);
INSERT INTO `sys_role_modulelist` VALUES (1, 463561666653642762);
INSERT INTO `sys_role_modulelist` VALUES (403730211182542848, 463561666653642762);
INSERT INTO `sys_role_modulelist` VALUES (404189812852064256, 463561666653642762);
INSERT INTO `sys_role_modulelist` VALUES (1, 463645654579732480);
INSERT INTO `sys_role_modulelist` VALUES (1, 463939432767086592);
INSERT INTO `sys_role_modulelist` VALUES (1, 463939572810702848);
INSERT INTO `sys_role_modulelist` VALUES (1, 463939784589500416);
INSERT INTO `sys_role_modulelist` VALUES (1, 463939914340294656);
INSERT INTO `sys_role_modulelist` VALUES (1, 463940030316994560);
INSERT INTO `sys_role_modulelist` VALUES (1, 463940168624168960);

-- ----------------------------
-- Table structure for sys_role_operatetype
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_operatetype`;
CREATE TABLE `sys_role_operatetype`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `operateType_id` bigint(20) NOT NULL COMMENT '功能操作表ID',
  PRIMARY KEY (`role_id`, `operateType_id`) USING BTREE,
  INDEX `FK_Reference_operateType_role`(`operateType_id`) USING BTREE,
  CONSTRAINT `sys_role_operatetype_ibfk_1` FOREIGN KEY (`operateType_id`) REFERENCES `sys_operatetype` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_role_operatetype_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和系统权限关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_operatetype
-- ----------------------------
INSERT INTO `sys_role_operatetype` VALUES (1, 1);
INSERT INTO `sys_role_operatetype` VALUES (403730211182542848, 1);
INSERT INTO `sys_role_operatetype` VALUES (404189812852064256, 1);
INSERT INTO `sys_role_operatetype` VALUES (424809644588851200, 1);
INSERT INTO `sys_role_operatetype` VALUES (1, 2);
INSERT INTO `sys_role_operatetype` VALUES (403730211182542848, 2);
INSERT INTO `sys_role_operatetype` VALUES (404189812852064256, 2);
INSERT INTO `sys_role_operatetype` VALUES (403730211182542848, 3);
INSERT INTO `sys_role_operatetype` VALUES (404189812852064256, 3);
INSERT INTO `sys_role_operatetype` VALUES (424809644588851200, 3);
INSERT INTO `sys_role_operatetype` VALUES (403730211182542848, 4);
INSERT INTO `sys_role_operatetype` VALUES (404189812852064256, 4);
INSERT INTO `sys_role_operatetype` VALUES (424809644588851200, 4);

-- ----------------------------
-- Table structure for sys_sync_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_sync_data`;
CREATE TABLE `sys_sync_data`  (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `info_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'DML数据内容',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `inx_sys_sync_datatime`(`create_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'DML数据记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_sync_data
-- ----------------------------
INSERT INTO `sys_sync_data` VALUES (46968340883206144, '[{\"keys\":\"id,pid,module_name,module_code,module_icon,module_url,module_target,module_type,module_status,application_name,module_attr,sort_num,create_user,create_time\",\"values\":[\"463561666653642753\",\"463561666653642761\",\"地区管理\",\"AREAMANAGE\",\"icon-reorder\",null,\"navTab\",\"0\",\"1\",\"Subsystem\",\"2\",null,\"admin\",\"2020-03-21 18:42:27\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_modulelist\"},{\"keys\":\"id,pid,module_name,module_code,module_icon,module_url,module_target,module_type,module_status,application_name,module_attr,sort_num,create_user,create_time\",\"values\":[\"463561666653642754\",\"463561666653642761\",\"机构管理\",\"ORGMANAGE\",\"icon-reorder\",\"orgManage/orglist\",\"navTab\",\"1\",\"1\",\"Subsystem\",\"2\",\"2\",\"admin\",\"2020-03-30 07:46:30\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_modulelist\"},{\"keys\":\"id,pid,module_name,module_code,module_icon,module_url,module_target,module_type,module_status,application_name,module_attr,sort_num,create_user,create_time\",\"values\":[\"463561666653642755\",\"463561666653642761\",\"菜单管理\",\"MENUMANAGE\",\"icon-reorder\",\"menuManage/menulist\",\"navTab\",\"1\",\"1\",\"Subsystem\",\"2\",\"3\",\"admin\",\"2020-03-30 07:46:59\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_modulelist\"},{\"keys\":\"id,pid,module_name,module_code,module_icon,module_url,module_target,module_type,module_status,application_name,module_attr,sort_num,create_user,create_time\",\"values\":[\"463561666653642756\",\"463561666653642761\",\"角色管理\",\"ROLEMANAGE\",\"icon-reorder\",null,\"navTab\",\"0\",\"1\",\"Subsystem\",\"2\",\"4\",\"admin\",\"2020-03-30 07:47:31\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_modulelist\"},{\"keys\":\"id,pid,module_name,module_code,module_icon,module_url,module_target,module_type,module_status,application_name,module_attr,sort_num,create_user,create_time\",\"values\":[\"463561666653642757\",\"463561666653642761\",\"用户管理\",\"USERMANAGE\",\"icon-reorder\",\"userManage/userManageList\",\"navTab\",\"0\",\"1\",\"Subsystem\",\"2\",\"5\",\"admin\",\"2020-03-30 07:48:11\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_modulelist\"},{\"keys\":\"id,pid,module_name,module_code,module_icon,module_url,module_target,module_type,module_status,application_name,module_attr,sort_num,create_user,create_time\",\"values\":[\"463561666653642758\",\"463561666653642753\",\"地区管理\",\"AREAMANAGEFUNC\",\"icon-reorder\",\"areaManage/arealist\",\"navTab\",\"1\",\"1\",\"Subsystem\",\"2\",\"1\",\"admin\",\"2020-03-30 07:49:50\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_modulelist\"},{\"keys\":\"id,pid,module_name,module_code,module_icon,module_url,module_target,module_type,module_status,application_name,module_attr,sort_num,create_user,create_time\",\"values\":[\"463561666653642759\",\"463561666653642756\",\"角色管理\",\"ROLEMANAGEFUNC\",\"icon-reorder\",\"roleManage/roleManageList\",\"navTab\",\"1\",\"1\",\"Subsystem\",\"2\",\"1\",\"admin\",\"2020-03-30 07:50:38\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_modulelist\"},{\"keys\":\"id,pid,module_name,module_code,module_icon,module_url,module_target,module_type,module_status,application_name,module_attr,sort_num,create_user,create_time\",\"values\":[\"463561666653642760\",\"463561666653642756\",\"角色菜单授权\",\"ROLEANDMENU\",\"icon-reorder\",\"roleManage/roleAndMenu\",\"navTab\",\"1\",\"1\",\"Subsystem\",\"2\",\"3\",\"admin\",\"2020-03-30 07:50:57\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_modulelist\"},{\"keys\":\"id,pid,module_name,module_code,module_icon,module_url,module_target,module_type,module_status,application_name,module_attr,sort_num,create_user,create_time\",\"values\":[\"463561666653642761\",\"463561666653642752\",\"系统管理\",\"SYSTEMMANAGE\",\"icon-cog\",null,\"navTab\",\"0\",\"1\",\"Subsystem\",\"2\",\"1\",\"admin\",\"2020-03-30 07:53:28\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_modulelist\"},{\"keys\":\"id,pid,module_name,module_code,module_icon,module_url,module_target,module_type,module_status,application_name,module_attr,sort_num,create_user,create_time\",\"values\":[\"463561666653642762\",\"463561666653642756\",\"角色用户绑定\",\"ROLEANDUSERBIND\",\"icon-reorder\",\"roleManage/roleAndUser\",\"navTab\",\"1\",\"1\",\"Subsystem\",\"2\",\"2\",\"admin\",\"2020-04-11 08:31:10\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_modulelist\"},{\"keys\":\"id,pid,module_name,module_code,module_icon,module_url,module_target,module_type,module_status,application_name,module_attr,sort_num,create_user,create_time\",\"values\":[\"463561666653642752\",\"1\",\"测试子系统\",\"SUBSYSTEM\",null,null,\"navTab\",\"0\",\"1\",\"Subsystem\",\"0\",null,\"admin\",\"2020-09-09 14:35:24\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642753\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642754\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642755\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642756\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642757\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642758\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642759\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642760\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642761\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642762\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642752\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"403730211182542848\",\"463561666653642753\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"403730211182542848\",\"463561666653642754\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"403730211182542848\",\"463561666653642755\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"403730211182542848\",\"463561666653642756\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"403730211182542848\",\"463561666653642757\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"403730211182542848\",\"463561666653642758\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"403730211182542848\",\"463561666653642759\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"403730211182542848\",\"463561666653642760\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"403730211182542848\",\"463561666653642761\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"403730211182542848\",\"463561666653642762\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"403730211182542848\",\"463561666653642752\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"404189812852064256\",\"463561666653642753\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"404189812852064256\",\"463561666653642754\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"404189812852064256\",\"463561666653642755\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"404189812852064256\",\"463561666653642756\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"404189812852064256\",\"463561666653642757\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"404189812852064256\",\"463561666653642758\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"404189812852064256\",\"463561666653642759\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"404189812852064256\",\"463561666653642760\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"404189812852064256\",\"463561666653642761\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"404189812852064256\",\"463561666653642762\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"404189812852064256\",\"463561666653642752\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"}]', '2020-09-09 14:35:25');
INSERT INTO `sys_sync_data` VALUES (46983481125269504, '[{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"1\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"2\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510340498391040\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510461441146880\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510593343619072\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510764731269120\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404511178339975168\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404511379884670976\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404511457638678528\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404512093411278848\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"408870234521403392\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"462864005579464704\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463242895539888128\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642752\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642753\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642754\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642755\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642756\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642757\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642758\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642759\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642760\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642761\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642762\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"1\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642752\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642761\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642753\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642758\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642754\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642755\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642756\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642759\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642762\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642760\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"462864005579464704\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404512093411278848\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"2\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404511178339975168\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510340498391040\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510461441146880\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510593343619072\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404511379884670976\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"408870234521403392\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404511457638678528\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510764731269120\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463242895539888128\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"}]', '2020-09-09 15:35:35');
INSERT INTO `sys_sync_data` VALUES (46983637199515648, '[{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"1\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"2\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510340498391040\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510461441146880\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510593343619072\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510764731269120\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404511178339975168\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404511379884670976\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404511457638678528\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404512093411278848\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"408870234521403392\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"462864005579464704\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463242895539888128\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642752\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642753\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642754\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642755\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642756\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642758\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642759\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642760\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642761\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642762\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"1\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642752\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642761\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642753\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642758\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642754\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642755\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642756\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642759\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642762\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642760\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642757\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"462864005579464704\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404512093411278848\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"2\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404511178339975168\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510340498391040\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510461441146880\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510593343619072\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404511379884670976\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"408870234521403392\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404511457638678528\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510764731269120\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463242895539888128\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"}]', '2020-09-09 15:36:12');
INSERT INTO `sys_sync_data` VALUES (46993335516688384, '[{\"keys\":\"id,area_name,area_code,area_level,parent_code,longitude,latitude,create_user,create_time,sort_num,application_name\",\"values\":[\"463586639548047360\",\"11111\",\"11111\",\"3\",\"410000000000\",null,null,\"admin\",\"2020-09-09 16:14:38\",null,\"Portal\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_area\"}]', '2020-09-09 16:14:44');
INSERT INTO `sys_sync_data` VALUES (46993688832274432, '[{\"keys\":\"id,\",\"values\":[\"463586639548047360\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_area\"}]', '2020-09-09 16:16:09');
INSERT INTO `sys_sync_data` VALUES (46994482956627968, '[{\"keys\":\"id,area_name,area_code,area_level,parent_code,longitude,latitude,create_user,create_time,sort_num,application_name\",\"values\":[\"463587808886448128\",\"1111\",\"1111\",\"3\",\"410000000000\",null,null,\"admin\",\"2020-09-09 16:19:17\",null,\"Subsystem\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_area\"}]', '2020-09-09 16:19:18');
INSERT INTO `sys_sync_data` VALUES (46995109099106304, '[{\"keys\":\"id,\",\"values\":[\"463587808886448128\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_area\"}]', '2020-09-09 16:21:47');
INSERT INTO `sys_sync_data` VALUES (46998589033443328, '[{\"keys\":\"id,area_name,area_code,area_level,parent_code,longitude,latitude,create_user,create_time,sort_num,application_name\",\"values\":[\"463591916603236352\",\"111\",\"1111\",\"3\",\"410000000000\",null,null,\"admin\",\"2020-09-09 16:35:36\",null,\"Subsystem\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_area\"}]', '2020-09-09 16:35:37');
INSERT INTO `sys_sync_data` VALUES (46998816222113792, '[{\"keys\":\"id,\",\"values\":[\"463591916603236352\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_area\"}]', '2020-09-09 16:36:31');
INSERT INTO `sys_sync_data` VALUES (46998980231983104, '[{\"keys\":\"id,area_name,area_code,area_level,parent_code,longitude,latitude,create_user,create_time,sort_num,application_name\",\"values\":[\"463592305742372864\",\"1111\",\"111\",\"3\",\"410000000000\",null,null,\"admin\",\"2020-09-09 16:37:09\",null,\"Subsystem\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_area\"}]', '2020-09-09 16:37:10');
INSERT INTO `sys_sync_data` VALUES (47000371251933184, '[{\"keys\":\"id,area_name,area_code,area_level,parent_code,longitude,latitude,create_user,create_time,sort_num,application_name\",\"values\":[\"463592305742372864\",\"11112222\",\"111\",\"3\",\"410000000000\",null,null,\"admin\",\"2020-09-09 16:37:09\",null,\"Subsystem\"],\"eventType\":\"UPDATE\",\"keysPrimary\":\"id,\",\"valuesPrimary\":[\"463592305742372864\"],\"tableName\":\"sys_area\"}]', '2020-09-09 16:42:42');
INSERT INTO `sys_sync_data` VALUES (47000485462831104, '[{\"keys\":\"id,area_name,area_code,area_level,parent_code,longitude,latitude,create_user,create_time,sort_num,application_name\",\"values\":[\"463592305742372864\",\"1111222233\",\"111\",\"3\",\"410000000000\",null,null,\"admin\",\"2020-09-09 16:37:09\",null,\"Subsystem\"],\"eventType\":\"UPDATE\",\"keysPrimary\":\"id,\",\"valuesPrimary\":[\"463592305742372864\"],\"tableName\":\"sys_area\"}]', '2020-09-09 16:43:09');
INSERT INTO `sys_sync_data` VALUES (47001615030841344, '[{\"keys\":\"id,\",\"values\":[\"463592305742372864\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_area\"}]', '2020-09-09 16:47:38');
INSERT INTO `sys_sync_data` VALUES (47001716038070272, '[{\"keys\":\"id,area_name,area_code,area_level,parent_code,longitude,latitude,create_user,create_time,sort_num,application_name\",\"values\":[\"463595041795923968\",\"1111\",\"1111\",\"3\",\"410000000000\",null,null,\"admin\",\"2020-09-09 16:48:01\",null,\"Subsystem\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_area\"}]', '2020-09-09 16:48:02');
INSERT INTO `sys_sync_data` VALUES (47001737588404224, '[{\"keys\":\"id,area_name,area_code,area_level,parent_code,longitude,latitude,create_user,create_time,sort_num,application_name\",\"values\":[\"463595041795923968\",\"1111\",\"111122\",\"3\",\"410000000000\",null,null,\"admin\",\"2020-09-09 16:48:01\",null,\"Subsystem\"],\"eventType\":\"UPDATE\",\"keysPrimary\":\"id,\",\"valuesPrimary\":[\"463595041795923968\"],\"tableName\":\"sys_area\"}]', '2020-09-09 16:48:07');
INSERT INTO `sys_sync_data` VALUES (47001796669370368, '[{\"keys\":\"id,area_name,area_code,area_level,parent_code,longitude,latitude,create_user,create_time,sort_num,application_name\",\"values\":[\"463595041795923968\",\"1111\",\"1111222222\",\"3\",\"410000000000\",null,null,\"admin\",\"2020-09-09 16:48:01\",null,\"Subsystem\"],\"eventType\":\"UPDATE\",\"keysPrimary\":\"id,\",\"valuesPrimary\":[\"463595041795923968\"],\"tableName\":\"sys_area\"}]', '2020-09-09 16:48:22');
INSERT INTO `sys_sync_data` VALUES (47002741943857152, '[{\"keys\":\"id,area_name,area_code,area_level,parent_code,longitude,latitude,create_user,create_time,sort_num,application_name\",\"values\":[\"463595041795923968\",\"1111\",\"11112\",\"3\",\"410000000000\",null,null,\"admin\",\"2020-09-09 16:48:01\",null,\"Subsystem\"],\"eventType\":\"UPDATE\",\"keysPrimary\":\"id,\",\"valuesPrimary\":[\"463595041795923968\"],\"tableName\":\"sys_area\"}]', '2020-09-09 16:52:07');
INSERT INTO `sys_sync_data` VALUES (47002801129680896, '[{\"keys\":\"id,\",\"values\":[\"463595041795923968\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_area\"}]', '2020-09-09 16:52:21');
INSERT INTO `sys_sync_data` VALUES (47002906301853696, '[{\"keys\":\"id,area_name,area_code,area_level,parent_code,longitude,latitude,create_user,create_time,sort_num,application_name\",\"values\":[\"463596232076484608\",\"1111\",\"1111\",\"3\",\"410000000000\",null,null,\"admin\",\"2020-09-09 16:52:45\",null,\"Subsystem\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_area\"}]', '2020-09-09 16:52:46');
INSERT INTO `sys_sync_data` VALUES (47002982118092800, '[{\"keys\":\"id,area_name,area_code,area_level,parent_code,longitude,latitude,create_user,create_time,sort_num,application_name\",\"values\":[\"463596232076484608\",\"1111222\",\"1111222\",\"3\",\"410000000000\",null,null,\"admin\",\"2020-09-09 16:52:45\",null,\"Subsystem\"],\"eventType\":\"UPDATE\",\"keysPrimary\":\"id,\",\"valuesPrimary\":[\"463596232076484608\"],\"tableName\":\"sys_area\"}]', '2020-09-09 16:53:04');
INSERT INTO `sys_sync_data` VALUES (47003586932535296, '[{\"keys\":\"id,area_name,area_code,area_level,parent_code,longitude,latitude,create_user,create_time,sort_num,application_name\",\"values\":[\"463596232076484608\",\"1111222\",\"11112223333\",\"3\",\"410000000000\",null,null,\"admin\",\"2020-09-09 16:52:45\",null,\"Subsystem\"],\"eventType\":\"UPDATE\",\"keysPrimary\":\"id,\",\"valuesPrimary\":[\"463596232076484608\"],\"tableName\":\"sys_area\"}]', '2020-09-09 16:55:28');
INSERT INTO `sys_sync_data` VALUES (47003868584243200, '[{\"keys\":\"id,area_name,area_code,area_level,parent_code,longitude,latitude,create_user,create_time,sort_num,application_name\",\"values\":[\"463597196837707776\",\"3333\",\"3333\",\"3\",\"11112223333\",null,null,\"admin\",\"2020-09-09 16:56:35\",null,\"Subsystem\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_area\"}]', '2020-09-09 16:56:36');
INSERT INTO `sys_sync_data` VALUES (47003906622386176, '[{\"keys\":\"id,area_name,area_code,area_level,parent_code,longitude,latitude,create_user,create_time,sort_num,application_name\",\"values\":[\"463597196837707776\",\"3333\",\"3333\",\"3\",\"1111222\",null,null,\"admin\",\"2020-09-09 16:56:35\",null,\"Subsystem\"],\"eventType\":\"UPDATE\",\"keysPrimary\":\"id,\",\"valuesPrimary\":[\"463597196837707776\"],\"tableName\":\"sys_area\"},{\"keys\":\"id,area_name,area_code,area_level,parent_code,longitude,latitude,create_user,create_time,sort_num,application_name\",\"values\":[\"463596232076484608\",\"1111222\",\"1111222\",\"3\",\"410000000000\",null,null,\"admin\",\"2020-09-09 16:52:45\",null,\"Subsystem\"],\"eventType\":\"UPDATE\",\"keysPrimary\":\"id,\",\"valuesPrimary\":[\"463596232076484608\"],\"tableName\":\"sys_area\"}]', '2020-09-09 16:56:45');
INSERT INTO `sys_sync_data` VALUES (47004566801641472, '[{\"keys\":\"id,\",\"values\":[\"463597196837707776\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_area\"}]', '2020-09-09 16:59:22');
INSERT INTO `sys_sync_data` VALUES (47004714151735296, '[{\"keys\":\"id,area_name,area_code,area_level,parent_code,longitude,latitude,create_user,create_time,sort_num,application_name\",\"values\":[\"463598041859940352\",\"333\",\"3333\",\"3\",\"1111222\",null,null,\"admin\",\"2020-09-09 16:59:57\",null,\"Subsystem\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_area\"}]', '2020-09-09 16:59:57');
INSERT INTO `sys_sync_data` VALUES (47004874307039232, '[{\"keys\":\"id,\",\"values\":[\"463598041859940352\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_area\"}]', '2020-09-09 17:00:35');
INSERT INTO `sys_sync_data` VALUES (47005143241617408, '[{\"keys\":\"id,\",\"values\":[\"463596232076484608\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_area\"}]', '2020-09-09 17:01:39');
INSERT INTO `sys_sync_data` VALUES (47006332091920384, '[{\"keys\":\"id,pid,module_name,module_code,module_icon,module_url,module_target,module_type,module_status,application_name,module_attr,sort_num,create_user,create_time\",\"values\":[\"463599658319536128\",\"463561666653642761\",\"11111\",\"1111\",null,null,\"navTab\",\"1\",\"1\",\"Subsystem\",\"1\",\"111\",\"admin\",\"2020-09-09 17:06:22\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_modulelist\"}]', '2020-09-09 17:06:23');
INSERT INTO `sys_sync_data` VALUES (47006475021217792, '[{\"keys\":\"id,pid,module_name,module_code,module_icon,module_url,module_target,module_type,module_status,application_name,module_attr,sort_num,create_user,create_time\",\"values\":[\"463599658319536128\",\"463561666653642761\",\"111112222\",\"1111\",null,null,\"navTab\",\"1\",\"1\",\"Subsystem\",\"1\",\"111\",\"admin\",\"2020-09-09 17:06:22\"],\"eventType\":\"UPDATE\",\"keysPrimary\":\"id,\",\"valuesPrimary\":[\"463599658319536128\"],\"tableName\":\"sys_modulelist\"}]', '2020-09-09 17:06:57');
INSERT INTO `sys_sync_data` VALUES (47006517417242624, '[{\"keys\":\"id,\",\"values\":[\"463599658319536128\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_modulelist\"}]', '2020-09-09 17:07:07');
INSERT INTO `sys_sync_data` VALUES (47011370075975680, '[{\"keys\":\"id,area_name,area_code,area_level,parent_code,longitude,latitude,create_user,create_time,sort_num,application_name\",\"values\":[\"463604698409132032\",\"111\",\"111\",\"3\",\"410000000000\",null,null,\"admin\",\"2020-09-09 17:26:24\",null,\"Portal\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_area\"}]', '2020-09-09 17:26:24');
INSERT INTO `sys_sync_data` VALUES (47011483657728000, '[{\"keys\":\"id,\",\"values\":[\"463604698409132032\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_area\"}]', '2020-09-09 17:26:51');
INSERT INTO `sys_sync_data` VALUES (47011968531853312, '[{\"keys\":\"id,area_code,org_name,org_code,parent_code,industryid,org_address,org_logo,create_user,create_time,sort_num,application_name\",\"values\":[\"463605284516978688\",\"410000000000\",\"111\",\"111\",\"41000000000000\",null,null,null,\"admin\",\"2020-09-09 17:28:43\",null,\"Portal\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_org\"}]', '2020-09-09 17:28:47');
INSERT INTO `sys_sync_data` VALUES (47012058256404480, '[{\"keys\":\"id,\",\"values\":[\"463605284516978688\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_org\"}]', '2020-09-09 17:29:08');
INSERT INTO `sys_sync_data` VALUES (47012130163552256, '[{\"keys\":\"id,area_code,org_name,org_code,parent_code,industryid,org_address,org_logo,create_user,create_time,sort_num,application_name\",\"values\":[\"463605456466665472\",\"410000000000\",\"1111\",\"1111\",\"41000000000000\",null,null,null,\"admin\",\"2020-09-09 17:29:24\",null,\"Subsystem\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_org\"}]', '2020-09-09 17:29:25');
INSERT INTO `sys_sync_data` VALUES (47012176653217792, '[{\"keys\":\"id,area_code,org_name,org_code,parent_code,industryid,org_address,org_logo,create_user,create_time,sort_num,application_name\",\"values\":[\"463605456466665472\",\"410000000000\",\"1111222\",\"111122\",\"41000000000000\",null,null,null,\"admin\",\"2020-09-09 17:29:24\",null,\"Subsystem\"],\"eventType\":\"UPDATE\",\"keysPrimary\":\"id,\",\"valuesPrimary\":[\"463605456466665472\"],\"tableName\":\"sys_org\"}]', '2020-09-09 17:29:36');
INSERT INTO `sys_sync_data` VALUES (47012202334941184, '[{\"keys\":\"id,\",\"values\":[\"463605456466665472\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_org\"}]', '2020-09-09 17:29:42');
INSERT INTO `sys_sync_data` VALUES (47014876803526656, '[{\"keys\":\"id,role_code,role_name,role_attr,org_code,area_code,role_status,create_user,create_time,sort_num,application_name\",\"values\":[\"463608204792750080\",\"Test\",\"测试\",\"0\",null,\"410000000000\",\"1\",\"admin\",\"2020-09-09 17:40:20\",\"1\",\"Portal\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463608204792750080\",\"2\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_operatetype\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463608204792750080\",\"1\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_operatetype\"}]', '2020-09-09 17:40:20');
INSERT INTO `sys_sync_data` VALUES (47014982051196928, '[{\"keys\":\"id,\",\"values\":[\"463608204792750080\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role\"}]', '2020-09-09 17:40:45');
INSERT INTO `sys_sync_data` VALUES (47018742483808256, '[{\"keys\":\"id,role_code,role_name,role_attr,org_code,area_code,role_status,create_user,create_time,sort_num,application_name\",\"values\":[\"463612067604127744\",\"Test111\",\"测试角色\",\"0\",null,\"410000000000\",\"1\",\"admin\",\"2020-09-09 17:55:41\",\"11\",\"Subsystem\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463612067604127744\",\"1\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_operatetype\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463612067604127744\",\"2\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_operatetype\"}]', '2020-09-09 17:55:42');
INSERT INTO `sys_sync_data` VALUES (47019091206631424, '[{\"keys\":\"id,role_code,role_name,role_attr,org_code,area_code,role_status,create_user,create_time,sort_num,application_name\",\"values\":[\"463612067604127744\",\"Test111\",\"测试角色2222\",\"0\",null,\"410000000000\",\"1\",\"admin\",\"2020-09-09 17:55:41\",\"11\",\"Subsystem\"],\"eventType\":\"UPDATE\",\"keysPrimary\":\"id,\",\"valuesPrimary\":[\"463612067604127744\"],\"tableName\":\"sys_role\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463612067604127744\",\"1\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_operatetype\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463612067604127744\",\"2\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_operatetype\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463612067604127744\",\"1\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_operatetype\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463612067604127744\",\"2\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_operatetype\"}]', '2020-09-09 17:57:05');
INSERT INTO `sys_sync_data` VALUES (47019154469318656, '[{\"keys\":\"id,role_code,role_name,role_attr,org_code,area_code,role_status,create_user,create_time,sort_num,application_name\",\"values\":[\"463612067604127744\",\"Test111\",\"测试角色22223333\",\"0\",null,\"410000000000\",\"1\",\"admin\",\"2020-09-09 17:55:41\",\"11\",\"Subsystem\"],\"eventType\":\"UPDATE\",\"keysPrimary\":\"id,\",\"valuesPrimary\":[\"463612067604127744\"],\"tableName\":\"sys_role\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463612067604127744\",\"1\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_operatetype\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463612067604127744\",\"2\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_operatetype\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463612067604127744\",\"1\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_operatetype\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463612067604127744\",\"2\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_operatetype\"}]', '2020-09-09 17:57:20');
INSERT INTO `sys_sync_data` VALUES (47024112610603008, '[{\"keys\":\"id,role_code,role_name,role_attr,org_code,area_code,role_status,create_user,create_time,sort_num,application_name\",\"values\":[\"463612067604127744\",\"Test1111221\",\"测试角色22223333\",\"0\",null,\"410000000000\",\"1\",\"admin\",\"2020-09-09 17:55:41\",\"11\",\"Subsystem\"],\"eventType\":\"UPDATE\",\"keysPrimary\":\"id,\",\"valuesPrimary\":[\"463612067604127744\"],\"tableName\":\"sys_role\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463612067604127744\",\"1\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_operatetype\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463612067604127744\",\"2\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_operatetype\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463612067604127744\",\"1\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_operatetype\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463612067604127744\",\"2\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_operatetype\"}]', '2020-09-09 18:17:02');
INSERT INTO `sys_sync_data` VALUES (47024180042428416, '[{\"keys\":\"id,\",\"values\":[\"463612067604127744\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role\"}]', '2020-09-09 18:17:18');
INSERT INTO `sys_sync_data` VALUES (47024281049657344, '[{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642752\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642753\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642754\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642755\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642756\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642757\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642758\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642759\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642760\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642761\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642762\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642752\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642761\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642753\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642758\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642754\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642755\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642756\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642759\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642762\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642760\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"}]', '2020-09-09 18:17:42');
INSERT INTO `sys_sync_data` VALUES (47024331993673728, '[{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642752\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642753\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642754\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642755\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642756\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642758\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642759\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642760\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642761\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642762\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642752\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642761\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642753\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642758\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642754\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642755\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642756\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642759\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642762\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642760\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642757\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"}]', '2020-09-09 18:17:54');
INSERT INTO `sys_sync_data` VALUES (47027259781443584, '[{\"keys\":\"id,role_code,role_name,role_attr,org_code,area_code,role_status,create_user,create_time,sort_num,application_name\",\"values\":[\"463620587883913216\",\"11111\",\"测试角色\",\"0\",null,\"410000000000\",\"1\",\"admin\",\"2020-09-09 18:29:32\",\"111\",\"Subsystem\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463620587883913216\",\"1\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_operatetype\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463620587883913216\",\"2\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_operatetype\"}]', '2020-09-09 18:29:32');
INSERT INTO `sys_sync_data` VALUES (47027541420568576, '[{\"keys\":\"id,role_code,role_name,role_attr,org_code,area_code,role_status,create_user,create_time,sort_num,application_name\",\"values\":[\"463620587883913216\",\"11111\",\"测试角色1\",\"0\",null,\"410000000000\",\"1\",\"admin\",\"2020-09-09 18:29:32\",\"111\",\"Subsystem\"],\"eventType\":\"UPDATE\",\"keysPrimary\":\"id,\",\"valuesPrimary\":[\"463620587883913216\"],\"tableName\":\"sys_role\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463620587883913216\",\"1\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_operatetype\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463620587883913216\",\"2\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_operatetype\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463620587883913216\",\"1\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_operatetype\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463620587883913216\",\"2\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_operatetype\"}]', '2020-09-09 18:30:40');
INSERT INTO `sys_sync_data` VALUES (47027676003201024, '[{\"keys\":\"id,role_code,role_name,role_attr,org_code,area_code,role_status,create_user,create_time,sort_num,application_name\",\"values\":[\"463620587883913216\",\"11111\",\"测试角色12\",\"0\",null,\"410000000000\",\"1\",\"admin\",\"2020-09-09 18:29:32\",\"111\",\"Subsystem\"],\"eventType\":\"UPDATE\",\"keysPrimary\":\"id,\",\"valuesPrimary\":[\"463620587883913216\"],\"tableName\":\"sys_role\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463620587883913216\",\"1\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_operatetype\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463620587883913216\",\"2\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_operatetype\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463620587883913216\",\"1\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_operatetype\"},{\"keys\":\"role_id,operateType_id\",\"values\":[\"463620587883913216\",\"2\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_operatetype\"}]', '2020-09-09 18:31:12');
INSERT INTO `sys_sync_data` VALUES (47027768827342848, '[{\"keys\":\"id,\",\"values\":[\"463620587883913216\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role\"}]', '2020-09-09 18:31:34');
INSERT INTO `sys_sync_data` VALUES (47030492113432576, '[{\"keys\":\"user_id,role_id\",\"values\":[\"420486952410734592\",\"424809644588851200\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_user_role\"}]', '2020-09-09 18:42:23');
INSERT INTO `sys_sync_data` VALUES (47038316637876224, '[{\"keys\":\"user_id,role_id\",\"values\":[\"420486952410734592\",\"424809644588851200\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_user_role\"}]', '2020-09-09 19:13:29');
INSERT INTO `sys_sync_data` VALUES (47038594200137728, '[{\"keys\":\"user_id,role_id\",\"values\":[\"420486952410734592\",\"424809644588851200\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_user_role\"}]', '2020-09-09 19:14:35');
INSERT INTO `sys_sync_data` VALUES (47038661715849216, '[{\"keys\":\"user_id,role_id\",\"values\":[\"420486952410734592\",\"424809644588851200\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_user_role\"}]', '2020-09-09 19:14:51');
INSERT INTO `sys_sync_data` VALUES (47038712479510528, '[{\"keys\":\"user_id,role_id\",\"values\":[\"420486952410734592\",\"424809644588851200\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_user_role\"}]', '2020-09-09 19:15:03');
INSERT INTO `sys_sync_data` VALUES (47038742112268288, '[{\"keys\":\"user_id,role_id\",\"values\":[\"420486952410734592\",\"424809644588851200\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_user_role\"}]', '2020-09-09 19:15:10');
INSERT INTO `sys_sync_data` VALUES (47046652515086336, '[{\"keys\":\"id,login_name,password,user_name,user_gender,phone_number,user_email,head_img,org_code,last_login_time,last_login_ip,user_status,application_name,create_user,create_time\",\"values\":[\"463639961663496192\",\"11111\",\"$2a$10$LvKvMV3lJWiFOnpmr.wxpOKxB6OBO1o7XSTTF1R4R8Vsf5qTtwk4W\",\"111111\",\"0\",\"18037570108\",null,\"image/boy-01.png\",\"41000041600000\",null,null,\"0\",\"Subsystem\",\"admin\",\"2020-09-09 19:46:31\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_user\"},{\"keys\":\"user_id,role_id\",\"values\":[\"463639961663496192\",\"1\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_user_role\"},{\"keys\":\"user_id,role_id\",\"values\":[\"463639961663496192\",\"424809644588851200\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_user_role\"}]', '2020-09-09 19:46:36');
INSERT INTO `sys_sync_data` VALUES (47046711570886656, '[{\"keys\":\"user_id,role_id\",\"values\":[\"463639961663496192\",\"1\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_user_role\"},{\"keys\":\"user_id,role_id\",\"values\":[\"463639961663496192\",\"424809644588851200\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_user_role\"},{\"keys\":\"user_id,role_id\",\"values\":[\"463639961663496192\",\"1\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_user_role\"}]', '2020-09-09 19:46:50');
INSERT INTO `sys_sync_data` VALUES (47046749621612544, '[{\"keys\":\"id,\",\"values\":[\"463639961663496192\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_user\"}]', '2020-09-09 19:46:59');
INSERT INTO `sys_sync_data` VALUES (47046859181027328, '[{\"keys\":\"id,login_name,password,user_name,user_gender,phone_number,user_email,head_img,org_code,last_login_time,last_login_ip,user_status,application_name,create_user,create_time\",\"values\":[\"463640187145084928\",\"1111\",\"$2a$10$lMrK0ofKZLvyLB0eB83rg.4rZ7Ngj2bjBZQr/k8QDmVR8X95eOYYm\",\"111111\",\"0\",\"18037570108\",null,\"image/boy-01.png\",\"41000041600000\",null,null,\"0\",\"Subsystem\",\"admin\",\"2020-09-09 19:47:25\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_user\"},{\"keys\":\"user_id,role_id\",\"values\":[\"463640187145084928\",\"1\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_user_role\"},{\"keys\":\"user_id,role_id\",\"values\":[\"463640187145084928\",\"424809644588851200\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_user_role\"}]', '2020-09-09 19:47:25');
INSERT INTO `sys_sync_data` VALUES (47046897286279168, '[{\"keys\":\"id,\",\"values\":[\"463640187145084928\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_user\"}]', '2020-09-09 19:47:34');
INSERT INTO `sys_sync_data` VALUES (47047010876420096, '[{\"keys\":\"id,login_name,password,user_name,user_gender,phone_number,user_email,head_img,org_code,last_login_time,last_login_ip,user_status,application_name,create_user,create_time\",\"values\":[\"463640338941140992\",\"11111\",\"$2a$10$iZPglYlpLqDpPdjWe6emMOT9wai2LVLrpxOnad91RcwdkAbkCssfi\",\"111111\",\"0\",\"18037570108\",null,\"image/boy-01.png\",\"41000041600000\",null,null,\"0\",\"Subsystem\",\"admin\",\"2020-09-09 19:48:01\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_user\"},{\"keys\":\"user_id,role_id\",\"values\":[\"463640338941140992\",\"1\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_user_role\"}]', '2020-09-09 19:48:01');
INSERT INTO `sys_sync_data` VALUES (47047489610084352, '[{\"keys\":\"id,login_name,password,user_name,user_gender,phone_number,user_email,head_img,org_code,last_login_time,last_login_ip,user_status,application_name,create_user,create_time\",\"values\":[\"463640338941140992\",\"11111\",\"$2a$10$A9nL5bNwPIkhf0Z01x8pgeOD0ndjwHZ05/KFEuumhRavFVxd.13yG\",\"111111\",\"0\",\"18037570108\",null,\"image/boy-01.png\",\"41000041600000\",null,null,\"0\",\"Subsystem\",\"admin\",\"2020-09-09 19:48:01\"],\"eventType\":\"UPDATE\",\"keysPrimary\":\"id,\",\"valuesPrimary\":[\"463640338941140992\"],\"tableName\":\"sys_user\"}]', '2020-09-09 19:49:56');
INSERT INTO `sys_sync_data` VALUES (47047615812497408, '[{\"keys\":\"id,\",\"values\":[\"463640338941140992\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_user\"}]', '2020-09-09 19:50:26');
INSERT INTO `sys_sync_data` VALUES (47052326494040064, '[{\"keys\":\"id,pid,module_name,module_code,module_icon,module_url,module_target,module_type,module_status,application_name,module_attr,sort_num,create_user,create_time\",\"values\":[\"463645654579732480\",\"463561666653642752\",\"任务管理\",\"QUARTZMANAGE\",\"icon-th\",\"quartzManage/quzrtzManagelist\",\"navTab\",\"1\",\"1\",\"Subsystem\",\"1\",\"2\",\"admin\",\"2020-09-09 20:09:08\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_modulelist\"}]', '2020-09-09 20:09:09');
INSERT INTO `sys_sync_data` VALUES (47052553389109248, '[{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"1\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"2\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510340498391040\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510461441146880\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510593343619072\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510764731269120\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404511178339975168\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404511379884670976\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404511457638678528\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404512093411278848\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"408870234521403392\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"462864005579464704\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463242895539888128\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642752\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642753\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642754\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642755\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642756\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642757\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642758\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642759\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642760\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642761\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642762\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"1\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642752\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642761\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642753\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642758\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642754\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642755\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642756\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642759\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642762\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642760\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642757\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463645654579732480\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"462864005579464704\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404512093411278848\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"2\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404511178339975168\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510340498391040\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510461441146880\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510593343619072\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404511379884670976\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"408870234521403392\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404511457638678528\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"404510764731269120\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463242895539888128\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"}]', '2020-09-09 20:10:03');
INSERT INTO `sys_sync_data` VALUES (47323304587456512, '[{\"keys\":\"id,login_name,password,user_name,user_gender,phone_number,user_email,head_img,org_code,last_login_time,last_login_ip,user_status,application_name,create_user,create_time\",\"values\":[\"404200473187385345\",\"admin\",\"$2a$10$Jw923tUCmRkkvZ/tv2YdYO3UKLN934VHz1ssADyxyPSM43sUWeAR6\",\"管理员\",\"0\",\"18037570119\",\"1540247870@qq.com\",\"http://192.168.0.135:8082/uploadfile/headImg/APP应用图标3.png\",\"41000041601000\",\"2020-03-07 15:13:43\",\"192.168.0.135\",\"0\",null,\"admin\",\"2020-03-07 15:13:59\"],\"eventType\":\"UPDATE\",\"keysPrimary\":\"id,\",\"valuesPrimary\":[\"404200473187385345\"],\"tableName\":\"sys_user\"}]', '2020-09-10 14:05:55');
INSERT INTO `sys_sync_data` VALUES (47346107546103808, '[{\"keys\":\"id,pid,module_name,module_code,module_icon,module_url,module_target,module_type,module_status,application_name,module_attr,sort_num,create_user,create_time\",\"values\":[\"463939432767086592\",\"463561666653642752\",\"文章管理\",\"ARTICLEMANAGE\",\"icon-book\",null,\"navTab\",\"0\",\"1\",\"Subsystem\",\"1\",\"3\",\"admin\",\"2020-09-10 15:36:31\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_modulelist\"}]', '2020-09-10 15:36:32');
INSERT INTO `sys_sync_data` VALUES (47346247015100416, '[{\"keys\":\"id,pid,module_name,module_code,module_icon,module_url,module_target,module_type,module_status,application_name,module_attr,sort_num,create_user,create_time\",\"values\":[\"463939572810702848\",\"463939432767086592\",\"文章分类管理\",\"ARTICLETYPE\",\"icon-reorder\",\"articleTypeManage/articleTypeList\",\"navTab\",\"1\",\"1\",\"Subsystem\",\"1\",\"0\",\"admin\",\"2020-09-10 15:37:04\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_modulelist\"}]', '2020-09-10 15:37:05');
INSERT INTO `sys_sync_data` VALUES (47346457057456128, '[{\"keys\":\"id,pid,module_name,module_code,module_icon,module_url,module_target,module_type,module_status,application_name,module_attr,sort_num,create_user,create_time\",\"values\":[\"463939784589500416\",\"463939432767086592\",\"我的文章\",\"MYARTICLE\",\"icon-reorder\",null,\"navTab\",\"0\",\"1\",\"Subsystem\",\"1\",\"1\",\"admin\",\"2020-09-10 15:37:54\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_modulelist\"}]', '2020-09-10 15:37:55');
INSERT INTO `sys_sync_data` VALUES (47346587760357376, '[{\"keys\":\"id,pid,module_name,module_code,module_icon,module_url,module_target,module_type,module_status,application_name,module_attr,sort_num,create_user,create_time\",\"values\":[\"463939914340294656\",\"463939784589500416\",\"发布文章\",\"ARTICLEPUBLISH\",\"icon-reorder\",\"articleManage/article\",\"navTab\",\"1\",\"1\",\"Subsystem\",\"1\",\"1\",\"admin\",\"2020-09-10 15:38:25\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_modulelist\"}]', '2020-09-10 15:38:26');
INSERT INTO `sys_sync_data` VALUES (47346701400829952, '[{\"keys\":\"id,pid,module_name,module_code,module_icon,module_url,module_target,module_type,module_status,application_name,module_attr,sort_num,create_user,create_time\",\"values\":[\"463940030316994560\",\"463939784589500416\",\"已发布\",\"MYARTICLElIST\",\"icon-reorder\",\"articleManage/myArticleList\",\"navTab\",\"1\",\"1\",\"Subsystem\",\"1\",\"2\",\"admin\",\"2020-09-10 15:38:53\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_modulelist\"}]', '2020-09-10 15:38:53');
INSERT INTO `sys_sync_data` VALUES (47346840106463232, '[{\"keys\":\"id,pid,module_name,module_code,module_icon,module_url,module_target,module_type,module_status,application_name,module_attr,sort_num,create_user,create_time\",\"values\":[\"463940168624168960\",\"463939432767086592\",\"文章管理\",\"ARTICLElIST\",\"icon-reorder\",\"articleManage/articleList\",\"navTab\",\"1\",\"1\",\"Subsystem\",\"1\",\"2\",\"admin\",\"2020-09-10 15:39:26\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_modulelist\"}]', '2020-09-10 15:39:26');
INSERT INTO `sys_sync_data` VALUES (47346920200892416, '[{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642752\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642753\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642754\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642755\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642756\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642757\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642758\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642759\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642760\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642761\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642762\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463645654579732480\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642752\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642761\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642753\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642758\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642754\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642755\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642756\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642759\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642762\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642760\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463561666653642757\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463645654579732480\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463939432767086592\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463939572810702848\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463939784589500416\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463939914340294656\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463940030316994560\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"},{\"keys\":\"role_id,modulelist_id\",\"values\":[\"1\",\"463940168624168960\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_role_modulelist\"}]', '2020-09-10 15:39:45');

-- ----------------------------
-- Table structure for sys_sync_data_item
-- ----------------------------
DROP TABLE IF EXISTS `sys_sync_data_item`;
CREATE TABLE `sys_sync_data_item`  (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `data_id` bigint(20) NOT NULL COMMENT 'DML数据记录表id',
  `application_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '项目名称',
  `sync_status` int(11) NOT NULL DEFAULT 0 COMMENT '状态（-1 推送失败、 0 待同步、1 已同步、2 同步失败）',
  `sync_time` datetime(0) NULL DEFAULT NULL COMMENT '数据同步时间',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `inx_syncitem_dataidAppName`(`data_id`, `application_name`) USING BTREE,
  INDEX `inx_syncitem_dataid`(`data_id`) USING BTREE,
  INDEX `inx_syncitem_applicationName`(`application_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '子系统同步DML数据记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_sync_data_item
-- ----------------------------
INSERT INTO `sys_sync_data_item` VALUES (46968340904177664, 46968340883206144, 'Subsystem', 0, NULL, '2020-09-09 14:35:25');
INSERT INTO `sys_sync_data_item` VALUES (46983481196572672, 46983481125269504, 'Subsystem', 0, NULL, '2020-09-09 15:35:35');
INSERT INTO `sys_sync_data_item` VALUES (46983637212098560, 46983637199515648, 'Subsystem', 0, NULL, '2020-09-09 15:36:12');
INSERT INTO `sys_sync_data_item` VALUES (46993335550242816, 46993335516688384, 'Subsystem', 0, NULL, '2020-09-09 16:14:44');
INSERT INTO `sys_sync_data_item` VALUES (46993688844857344, 46993688832274432, 'Subsystem', 0, NULL, '2020-09-09 16:16:09');
INSERT INTO `sys_sync_data_item` VALUES (46994482969210880, 46994482956627968, 'Subsystem', 0, NULL, '2020-09-09 16:19:18');
INSERT INTO `sys_sync_data_item` VALUES (46995109128466432, 46995109099106304, 'Subsystem', 0, NULL, '2020-09-09 16:21:47');
INSERT INTO `sys_sync_data_item` VALUES (46998589054414848, 46998589033443328, 'Subsystem', 0, NULL, '2020-09-09 16:35:37');
INSERT INTO `sys_sync_data_item` VALUES (46998816238891008, 46998816222113792, 'Subsystem', 0, NULL, '2020-09-09 16:36:31');
INSERT INTO `sys_sync_data_item` VALUES (46998980244566016, 46998980231983104, 'Subsystem', 0, NULL, '2020-09-09 16:37:10');
INSERT INTO `sys_sync_data_item` VALUES (47000371264516096, 47000371251933184, 'Subsystem', 0, NULL, '2020-09-09 16:42:42');
INSERT INTO `sys_sync_data_item` VALUES (47000485475414016, 47000485462831104, 'Subsystem', 0, NULL, '2020-09-09 16:43:09');
INSERT INTO `sys_sync_data_item` VALUES (47001615043424256, 47001615030841344, 'Subsystem', 0, NULL, '2020-09-09 16:47:38');
INSERT INTO `sys_sync_data_item` VALUES (47001716054847488, 47001716038070272, 'Subsystem', 0, NULL, '2020-09-09 16:48:02');
INSERT INTO `sys_sync_data_item` VALUES (47001737600987136, 47001737588404224, 'Subsystem', 0, NULL, '2020-09-09 16:48:07');
INSERT INTO `sys_sync_data_item` VALUES (47001796681953280, 47001796669370368, 'Subsystem', 0, NULL, '2020-09-09 16:48:22');
INSERT INTO `sys_sync_data_item` VALUES (47002741956440064, 47002741943857152, 'Subsystem', 0, NULL, '2020-09-09 16:52:07');
INSERT INTO `sys_sync_data_item` VALUES (47002801138069504, 47002801129680896, 'Subsystem', 0, NULL, '2020-09-09 16:52:21');
INSERT INTO `sys_sync_data_item` VALUES (47002906314436608, 47002906301853696, 'Subsystem', 0, NULL, '2020-09-09 16:52:46');
INSERT INTO `sys_sync_data_item` VALUES (47002982130675712, 47002982118092800, 'Subsystem', 0, NULL, '2020-09-09 16:53:04');
INSERT INTO `sys_sync_data_item` VALUES (47003586945118208, 47003586932535296, 'Subsystem', 0, NULL, '2020-09-09 16:55:28');
INSERT INTO `sys_sync_data_item` VALUES (47003868601020416, 47003868584243200, 'Subsystem', 0, NULL, '2020-09-09 16:56:36');
INSERT INTO `sys_sync_data_item` VALUES (47003906630774784, 47003906622386176, 'Subsystem', 0, NULL, '2020-09-09 16:56:45');
INSERT INTO `sys_sync_data_item` VALUES (47004566818418688, 47004566801641472, 'Subsystem', 0, NULL, '2020-09-09 16:59:22');
INSERT INTO `sys_sync_data_item` VALUES (47004714160123904, 47004714151735296, 'Subsystem', 0, NULL, '2020-09-09 16:59:57');
INSERT INTO `sys_sync_data_item` VALUES (47004874319622144, 47004874307039232, 'Subsystem', 0, NULL, '2020-09-09 17:00:35');
INSERT INTO `sys_sync_data_item` VALUES (47005143250006016, 47005143241617408, 'Subsystem', 0, NULL, '2020-09-09 17:01:39');
INSERT INTO `sys_sync_data_item` VALUES (47006332104503296, 47006332091920384, 'Subsystem', 0, NULL, '2020-09-09 17:06:23');
INSERT INTO `sys_sync_data_item` VALUES (47006475033800704, 47006475021217792, 'Subsystem', 0, NULL, '2020-09-09 17:06:57');
INSERT INTO `sys_sync_data_item` VALUES (47006517425631232, 47006517417242624, 'Subsystem', 0, NULL, '2020-09-09 17:07:07');
INSERT INTO `sys_sync_data_item` VALUES (47011370088558592, 47011370075975680, 'Subsystem', 0, NULL, '2020-09-09 17:26:24');
INSERT INTO `sys_sync_data_item` VALUES (47011483670310912, 47011483657728000, 'Subsystem', 0, NULL, '2020-09-09 17:26:51');
INSERT INTO `sys_sync_data_item` VALUES (47011969647538176, 47011968531853312, 'Subsystem', 0, NULL, '2020-09-09 17:28:47');
INSERT INTO `sys_sync_data_item` VALUES (47012058268987392, 47012058256404480, 'Subsystem', 0, NULL, '2020-09-09 17:29:08');
INSERT INTO `sys_sync_data_item` VALUES (47012130184523776, 47012130163552256, 'Subsystem', 0, NULL, '2020-09-09 17:29:25');
INSERT INTO `sys_sync_data_item` VALUES (47012176669995008, 47012176653217792, 'Subsystem', 0, NULL, '2020-09-09 17:29:36');
INSERT INTO `sys_sync_data_item` VALUES (47012202351718400, 47012202334941184, 'Subsystem', 0, NULL, '2020-09-09 17:29:42');
INSERT INTO `sys_sync_data_item` VALUES (47014876820303872, 47014876803526656, 'Subsystem', 0, NULL, '2020-09-09 17:40:20');
INSERT INTO `sys_sync_data_item` VALUES (47014982076362752, 47014982051196928, 'Subsystem', 0, NULL, '2020-09-09 17:40:45');
INSERT INTO `sys_sync_data_item` VALUES (47018742529945600, 47018742483808256, 'Subsystem', 0, NULL, '2020-09-09 17:55:42');
INSERT INTO `sys_sync_data_item` VALUES (47019091227602944, 47019091206631424, 'Subsystem', 0, NULL, '2020-09-09 17:57:05');
INSERT INTO `sys_sync_data_item` VALUES (47019154490290176, 47019154469318656, 'Subsystem', 0, NULL, '2020-09-09 17:57:20');
INSERT INTO `sys_sync_data_item` VALUES (47024112627380224, 47024112610603008, 'Subsystem', 0, NULL, '2020-09-09 18:17:02');
INSERT INTO `sys_sync_data_item` VALUES (47024180055011328, 47024180042428416, 'Subsystem', 0, NULL, '2020-09-09 18:17:18');
INSERT INTO `sys_sync_data_item` VALUES (47024281066434560, 47024281049657344, 'Subsystem', 0, NULL, '2020-09-09 18:17:42');
INSERT INTO `sys_sync_data_item` VALUES (47024332010450944, 47024331993673728, 'Subsystem', 0, NULL, '2020-09-09 18:17:54');
INSERT INTO `sys_sync_data_item` VALUES (47027259798220800, 47027259781443584, 'Subsystem', 0, NULL, '2020-09-09 18:29:32');
INSERT INTO `sys_sync_data_item` VALUES (47027541437345792, 47027541420568576, 'Subsystem', 0, NULL, '2020-09-09 18:30:40');
INSERT INTO `sys_sync_data_item` VALUES (47027676049338368, 47027676003201024, 'Subsystem', 0, NULL, '2020-09-09 18:31:12');
INSERT INTO `sys_sync_data_item` VALUES (47027768844120064, 47027768827342848, 'Subsystem', 0, NULL, '2020-09-09 18:31:34');
INSERT INTO `sys_sync_data_item` VALUES (47030492134404096, 47030492113432576, 'Subsystem', 0, NULL, '2020-09-09 18:42:23');
INSERT INTO `sys_sync_data_item` VALUES (47038316663042048, 47038316637876224, 'Subsystem', 0, NULL, '2020-09-09 19:13:29');
INSERT INTO `sys_sync_data_item` VALUES (47038594212720640, 47038594200137728, 'Subsystem', 0, NULL, '2020-09-09 19:14:35');
INSERT INTO `sys_sync_data_item` VALUES (47038661732626432, 47038661715849216, 'Subsystem', 0, NULL, '2020-09-09 19:14:51');
INSERT INTO `sys_sync_data_item` VALUES (47038712492093440, 47038712479510528, 'Subsystem', 0, NULL, '2020-09-09 19:15:03');
INSERT INTO `sys_sync_data_item` VALUES (47038742120656896, 47038742112268288, 'Subsystem', 0, NULL, '2020-09-09 19:15:10');
INSERT INTO `sys_sync_data_item` VALUES (47046652536057856, 47046652515086336, 'Subsystem', 0, NULL, '2020-09-09 19:46:36');
INSERT INTO `sys_sync_data_item` VALUES (47046711583469568, 47046711570886656, 'Subsystem', 0, NULL, '2020-09-09 19:46:50');
INSERT INTO `sys_sync_data_item` VALUES (47046749638389760, 47046749621612544, 'Subsystem', 0, NULL, '2020-09-09 19:46:59');
INSERT INTO `sys_sync_data_item` VALUES (47046859197804544, 47046859181027328, 'Subsystem', 0, NULL, '2020-09-09 19:47:25');
INSERT INTO `sys_sync_data_item` VALUES (47046897298862080, 47046897286279168, 'Subsystem', 0, NULL, '2020-09-09 19:47:34');
INSERT INTO `sys_sync_data_item` VALUES (47047010889003008, 47047010876420096, 'Subsystem', 0, NULL, '2020-09-09 19:48:01');
INSERT INTO `sys_sync_data_item` VALUES (47047489626861568, 47047489610084352, 'Subsystem', 0, NULL, '2020-09-09 19:49:56');
INSERT INTO `sys_sync_data_item` VALUES (47047615825080320, 47047615812497408, 'Subsystem', 0, NULL, '2020-09-09 19:50:26');
INSERT INTO `sys_sync_data_item` VALUES (47052326510817280, 47052326494040064, 'Subsystem', 0, NULL, '2020-09-09 20:09:09');
INSERT INTO `sys_sync_data_item` VALUES (47052553410080768, 47052553389109248, 'Subsystem', 0, NULL, '2020-09-09 20:10:03');
INSERT INTO `sys_sync_data_item` VALUES (47323305929633792, 47323304587456512, 'Subsystem', 0, NULL, '2020-09-10 14:05:55');
INSERT INTO `sys_sync_data_item` VALUES (47346107671932928, 47346107546103808, 'Subsystem', 0, NULL, '2020-09-10 15:36:32');
INSERT INTO `sys_sync_data_item` VALUES (47346247036071936, 47346247015100416, 'Subsystem', 0, NULL, '2020-09-10 15:37:05');
INSERT INTO `sys_sync_data_item` VALUES (47346457074233344, 47346457057456128, 'Subsystem', 0, NULL, '2020-09-10 15:37:55');
INSERT INTO `sys_sync_data_item` VALUES (47346587777134592, 47346587760357376, 'Subsystem', 0, NULL, '2020-09-10 15:38:26');
INSERT INTO `sys_sync_data_item` VALUES (47346701417607168, 47346701400829952, 'Subsystem', 0, NULL, '2020-09-10 15:38:53');
INSERT INTO `sys_sync_data_item` VALUES (47346840123240448, 47346840106463232, 'Subsystem', 0, NULL, '2020-09-10 15:39:26');
INSERT INTO `sys_sync_data_item` VALUES (47346920251224064, 47346920200892416, 'Subsystem', 0, NULL, '2020-09-10 15:39:45');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `login_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录名',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录密码',
  `user_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `user_gender` int(11) NOT NULL COMMENT '性别(0 男，1 女)',
  `phone_number` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话号码',
  `user_email` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `head_img` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `org_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '关联机构表机构编码',
  `last_login_time` datetime(0) NULL DEFAULT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后登录IP',
  `user_status` int(11) NOT NULL DEFAULT 0 COMMENT '用户状态(0 正常，2 禁用， 3 过期， 4 锁定)',
  `application_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建系统名称（每个系统的唯一标识）',
  `create_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `inx_sysuser_id`(`id`) USING BTREE,
  UNIQUE INDEX `inx_sysuser_loginname`(`login_name`) USING BTREE,
  UNIQUE INDEX `inx_sysuser_phonenumber`(`phone_number`) USING BTREE,
  INDEX `inx_sysuser_orgcode`(`org_code`) USING BTREE,
  INDEX `inx_sysuser_password`(`password`) USING BTREE,
  CONSTRAINT `sys_user_ibfk_1` FOREIGN KEY (`org_code`) REFERENCES `sys_org` (`org_code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (404200473187385345, 'admin', '$2a$10$Jw923tUCmRkkvZ/tv2YdYO3UKLN934VHz1ssADyxyPSM43sUWeAR6', '管理员', 0, '18037570119', '1540247870@qq.com', 'http://192.168.0.135:8082/uploadfile/headImg/APP应用图标3.png', '41000041601000', '2020-03-07 15:13:43', '192.168.0.135', 0, NULL, 'admin', '2020-03-07 15:13:59');
INSERT INTO `sys_user` VALUES (420486952410734592, 'sxf', '$2a$10$mqyV/0EML.puosBWkRZw7..vEVE2OaO3n56nsh4utbPFaHe6kf2xi', 'colin方', 0, '18037570102', '', 'image/boy-01.png', '41000041601000', NULL, NULL, 0, NULL, 'admin', '2020-05-13 17:51:51');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户表id',
  `role_id` bigint(20) NOT NULL COMMENT '角色表id',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE,
  INDEX `FK_Reference_role_user`(`role_id`) USING BTREE,
  CONSTRAINT `sys_user_role_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_user_role_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (404200473187385345, 1);
INSERT INTO `sys_user_role` VALUES (404200473187385345, 424809644588851200);
INSERT INTO `sys_user_role` VALUES (420486952410734592, 424809644588851200);

SET FOREIGN_KEY_CHECKS = 1;
