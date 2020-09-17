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

 Date: 16/09/2020 17:26:45
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
INSERT INTO `sys_modulelist` VALUES (465742386767650816, 463561666653642761, '同步记录', 'SYNCRECORD', 'icon-reorder', 'syncRecord/syncRecordList', 'navTab', 1, 1, 'Subsystem', 1, 6, 'admin', '2020-09-15 15:00:48');

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
INSERT INTO `sys_role_modulelist` VALUES (1, 465742386767650816);

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
INSERT INTO `sys_sync_data` VALUES (49523664857100288, '[{\"keys\":\"id,area_name,area_code,area_level,parent_code,longitude,latitude,create_user,create_time,sort_num,application_name\",\"values\":[\"466116992468836352\",\"test\",\"11111\",\"3\",\"410000000000\",null,null,\"admin\",\"2020-09-16 15:49:21\",null,\"Portal\"],\"eventType\":\"INSERT\",\"tableName\":\"sys_area\"}]', '2020-09-16 15:49:22');
INSERT INTO `sys_sync_data` VALUES (49523715557847040, '[{\"keys\":\"id,area_name,area_code,area_level,parent_code,longitude,latitude,create_user,create_time,sort_num,application_name\",\"values\":[\"466116992468836352\",\"test1\",\"11111\",\"3\",\"410000000000\",null,null,\"admin\",\"2020-09-16 15:49:21\",null,\"Portal\"],\"eventType\":\"UPDATE\",\"keysPrimary\":\"id,\",\"valuesPrimary\":[\"466116992468836352\"],\"tableName\":\"sys_area\"}]', '2020-09-16 15:49:34');
INSERT INTO `sys_sync_data` VALUES (49529814264606720, '[{\"keys\":\"id,\",\"values\":[\"466116992468836352\"],\"eventType\":\"DELETE\",\"tableName\":\"sys_area\"}]', '2020-09-16 16:13:48');

-- ----------------------------
-- Table structure for sys_sync_data_item
-- ----------------------------
DROP TABLE IF EXISTS `sys_sync_data_item`;
CREATE TABLE `sys_sync_data_item`  (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `data_id` bigint(20) NOT NULL COMMENT 'DML数据记录表id',
  `application_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '项目名称',
  `sync_status` int(11) NOT NULL DEFAULT 0 COMMENT '状态（ -1 已忽略、0 待同步、1 已同步、2 同步失败、3 推送失败）',
  `sync_time` datetime(0) NULL DEFAULT NULL COMMENT '数据同步时间',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `inx_syncitem_dataidAppName`(`data_id`, `application_name`) USING BTREE,
  INDEX `inx_syncitem_dataid`(`data_id`) USING BTREE,
  INDEX `inx_syncitem_applicationName`(`application_name`) USING BTREE,
  INDEX `inx_syncitem_dataid_syncStatus`(`sync_status`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '子系统同步DML数据记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_sync_data_item
-- ----------------------------
INSERT INTO `sys_sync_data_item` VALUES (49523664873877504, 49523664857100288, 'Subsystem', 1, '2020-09-16 16:13:33', '2020-09-16 15:49:22');
INSERT INTO `sys_sync_data_item` VALUES (49523715587207168, 49523715557847040, 'Subsystem', 1, '2020-09-16 16:13:34', '2020-09-16 15:49:34');
INSERT INTO `sys_sync_data_item` VALUES (49529814281383936, 49529814264606720, 'Subsystem', 1, '2020-09-16 16:13:48', '2020-09-16 16:13:48');

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
