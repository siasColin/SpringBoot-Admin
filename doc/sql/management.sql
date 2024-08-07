/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.0.135_6001
 Source Server Type    : MySQL
 Source Server Version : 50730
 Source Host           : 192.168.0.135:6001
 Source Schema         : management

 Target Server Type    : MySQL
 Target Server Version : 50730
 File Encoding         : 65001

 Date: 16/09/2020 17:27:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article_comment
-- ----------------------------
DROP TABLE IF EXISTS `article_comment`;
CREATE TABLE `article_comment`  (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `info_id` bigint(20) NOT NULL DEFAULT -1 COMMENT '评论文章的主键ID',
  `parent_id` bigint(20) NOT NULL COMMENT '父ID，被引用评论的ID，默认-1：表示是一级评论',
  `comment_content` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评论内容',
  `comment_time` datetime(0) NOT NULL COMMENT '评论时间',
  `from_user_id` bigint(20) NOT NULL COMMENT '评论人用户id',
  `to_user_id` bigint(20) NOT NULL COMMENT '被评论人用户id',
  `read_status` int(11) NOT NULL DEFAULT 0 COMMENT '是否已读（1 是，0 否）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `inx_article_comment`(`info_id`) USING BTREE,
  INDEX `inx_article_to_userid`(`to_user_id`) USING BTREE,
  INDEX `inx_article_from_userid`(`from_user_id`) USING BTREE,
  INDEX `inx_article_parentid`(`parent_id`) USING BTREE,
  CONSTRAINT `article_comment_ibfk_1` FOREIGN KEY (`info_id`) REFERENCES `article_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `article_comment_ibfk_2` FOREIGN KEY (`from_user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `article_comment_ibfk_3` FOREIGN KEY (`to_user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章评论回复表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_comment
-- ----------------------------
INSERT INTO `article_comment` VALUES (420487044802863104, 420484600073084928, -1, '了解', '2020-05-13 17:52:13', 420486952410734592, 404200473187385345, 1);
INSERT INTO `article_comment` VALUES (420493705185648640, 420484600073084928, -1, '哈哈', '2020-05-13 18:18:41', 404200473187385345, 404200473187385345, 0);
INSERT INTO `article_comment` VALUES (420493792414588928, 420484600073084928, -1, '123321', '2020-05-13 18:19:02', 420486952410734592, 404200473187385345, 1);
INSERT INTO `article_comment` VALUES (420493876124508160, 420484600073084928, 420493792414588928, '1234567', '2020-05-13 18:19:22', 404200473187385345, 420486952410734592, 1);
INSERT INTO `article_comment` VALUES (425134519216037888, 424810478500372480, -1, '123', '2020-05-26 13:39:38', 404200473187385345, 420486952410734592, 1);
INSERT INTO `article_comment` VALUES (463946711528693760, 463946574614028288, -1, '打它', '2020-09-10 16:05:26', 404200473187385345, 404200473187385345, 0);

-- ----------------------------
-- Table structure for article_info
-- ----------------------------
DROP TABLE IF EXISTS `article_info`;
CREATE TABLE `article_info`  (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `user_id` bigint(20) NOT NULL COMMENT '发布用户ID',
  `type_id` bigint(20) NOT NULL COMMENT '分类id',
  `info_title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `info_abstract` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '摘要',
  `info_content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `info_tags` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签（多个逗号分隔）',
  `info_attachments` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件',
  `info_filename` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件名字',
  `info_amount` int(11) NOT NULL DEFAULT 0 COMMENT '阅读量',
  `info_coverimg` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '封面图片',
  `info_open` int(11) NOT NULL DEFAULT 1 COMMENT '是否公开 0仅自己 1公开',
  `info_iscomment` int(11) NOT NULL DEFAULT 1 COMMENT '是否开启评论 0关闭 1开启',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '最后一次编辑时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `inx_quartz_userid`(`user_id`) USING BTREE,
  INDEX `inx_quartz_typeid`(`type_id`) USING BTREE,
  INDEX `inx_quartz_title`(`info_title`) USING BTREE,
  INDEX `inx_quartz_open`(`info_open`) USING BTREE,
  CONSTRAINT `article_info_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `article_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_info
-- ----------------------------
INSERT INTO `article_info` VALUES (420484600073084928, 404200473187385345, 418564852817133568, '所有入境进京人员原则上集中隔离14天', '所有入境进京人员原则上集中隔离14天，费用自理｜对于虚报信息隐瞒病情造成疫情传播的人员，将依法追究责任，并纳入信用体系', '<p>　　15日，北京市召开疫情防控第51场新闻发布会，北京市人民政府副秘书长陈蓓宣布境外进京人员的管控新措施：</p><p>　　即日起，首都机场全部国际及港澳台地区进港航班均停靠首都机场T3-D处置专区，全部人员严格落实健康申报卡填报。从3月16日0时起，所有境外进京人员，均应转送至集中隔离点进行14天的隔离观察，集中观察点将配置专业医护和工作人员，开展健康监测，发现问题及时处理。进行集中隔离观察期间，隔离人员的费用实施自理自备。对于虚报信息隐瞒病情造成疫情传播的人员，将依法追究责任，并纳入信用体系。</p><p>　　北京市疾控中心副主任庞星火通报5例境外输入新冠肺炎病例的情况。</p><p>　　庞星火通报，2020年3月14日，北京市报告5例境外输入新型冠状病毒肺炎确诊病例，其中西班牙3例，意大利1例，泰国1例。现将有关流行病学调查情况介绍如下。</p><p>　　史某某情况</p><p>　　史某某，男，17岁，户籍新疆维吾尔自治区。自2019年8月前往西班牙巴塞罗那某足球俱乐部训练，长期居住在巴塞罗那。当地时间3月12日乘国航CA846次航班返回北京，北京时间3月13日到达北京首都国际机场，下飞机前申报身体不适，自感发热，下飞机后机场检疫人员将其引导至隔离室为其测量体温为39.0℃，由海关检疫部门转120后转运至定点医院。3月14日诊断为确诊病例。</p><p>　　林某某情况</p><p>　　林某某，女，54岁，户籍福建省福州市，长期定居西班牙马德里，与其丈夫在西班牙马德里经营便利店。3月6日，患者出现头痛、浑身酸痛症状，体温37.3℃，随后出现关节酸痛、憋气等症状。3月10日自服感冒药症状有所缓解。当地时间3月12日乘EY076次航班，经停阿联酋阿布扎比，转乘EY888次航班，北京时间3月13日到达北京首都机场。下飞机前申报身体不适，由海关检疫部门转120后转运至定点医院。3月14日诊断为确诊病例。</p><p>　　蔡某某情况</p><p>　　蔡某某，男，23岁，户籍湖北省武汉市，在意大利留学，长期居住在意大利贝加莫市。患者2月18日出现咳痰症状，自服药物好转，未就诊。当地时间3月12日乘坐EY088次航班，经停阿联酋阿布扎比，转乘EY888次航班，北京时间3月13日到达北京首都国际机场。下飞机前申报身体不适，由海关检疫部门转120后转运至定点医院。3月14日诊断为确诊病例。</p><p>　　史某某情况</p><p>　　史某某，男，18岁，户籍山东省济宁市，在西班牙留学，长期居住在西班牙马德里市。患者于当地时间3月12日乘坐EY706经停阿联酋阿布扎比，转乘EY888航班，北京时间3月13日到达北京首都机场。患者自述无任何症状，下飞机后体温检测36.6℃，主动申报曾接触过有咳嗽症状的病人，由海关检疫部门转120后转运至定点医院。3月14日诊断为确诊病例。</p><p>　　王某某情况</p><p>　　王某某，女，31岁，户籍浙江省台州市，现住北京经济技术开发区。2月23日至3月4日去泰国曼谷、清迈旅游，3月4日，乘坐TG614航班返回北京。患者3月7日出现发热、咽痛、乏力、头痛等症状，就诊于某医疗机构，血常规和CT检测未见异常。3月12日，广东省疾控部门告知王某某，其在泰国旅游期间一同伴回国后检测为新冠核酸阳性。3月13日，王某某由120救护车送至东方医院北京经济技术开发区院区隔离，经大兴区疾控中心检测结果为核酸阳性，后由120救护车转运至大兴区人民医院。3月14日诊断为确诊病例。</p><p>　　庞星火介绍，以上病例为轻型或普通型，均在定点医院进行救治。目前追踪到密切接触者228人，其中49人在北京，均已按要求进行集中隔离医学观察，目前身体无异常。</p><p>　　“在此，真诚提示在境外的居民做好个人防护，若接触病例或出现症状后应及时在当地就诊，并接受隔离观察等措施，避免或尽量减少出行，减少外界接触，更不应国际长途旅行，以免造成传染病扩散。我市居民近期不要去有疫情的国家或地区旅行或旅游，旅途中的感染风险较大。”庞星火说。</p><p>　　━━━━━</p><p>　　明日起无症状入境进京人员原则上集中观察，费用自理</p><p>　　北京市人民政府副秘书长陈蓓发布加强境外输入疫情防控的有关措施。</p><p>　　陈蓓介绍，当前，境外疫情扩散蔓延呈现加速态势，为进一步防范境外疫情输入风险，从3月16日零时起，所有无症状入境进京人员，原则上均应转送至集中观察点进行14天集中观察，费用自理。有特殊情况的，经评估，可进行居家观察。</p><p>　　陈蓓说，此次对境外进京人员防控政策做出调整，是根据境外疫情形势发展，适应新的变化作出的相应调整。</p><p>　　陈蓓介绍，世界卫生组织宣布疫情已具有全球大流行特征。境外输入已经成为本市疫情防控的主要风险，境外输入病例已经成为本市新增确诊病例的主体。有些入境人员抵京时并无症状，数日后才出现症状得到确诊。</p><p>　　为了防止家庭聚集性感染和社区疫情扩散，确保您和家人安全，确保邻里安心，16日起所有无症状入境进京人员，原则上均应转送至集中观察点进行集中观察。集中观察点有专业的医护和工作人员，会定期开展健康监测，如果发现问题会及时处置，使您更安全、家人更放心、健康更有保障。</p><p>　　陈蓓表示，近期计划入境回京人员，请本人或家人提前与居住地社区沟通联系，提前咨询、报告有关情况，以便我们及时有效地做好相关服务保障工作。</p><p>　　据北京疾控中心消息，3月14日，北京市报告5例新冠肺炎确诊病例，其中3例来自西班牙、1例来自意大利的境外输入病例，不涉及京内小区。1例来自泰国的境外输入病例，活动过的小区是：北京经济技术开发区荣华街道林肯公园B区。</p><p>　　鉴于新冠肺炎已蔓延至100多个国家和地区，已具有全球大流行特征。提示提醒北京市居民，近期应不去国外有疫情的国家和地区旅行。</p><p>　　━━━━━</p><p>　　北京入境所有旅客均须填健康申明卡，瞒报将追责</p><p>　　北京海关副关长高瑞峰介绍海关口岸防控疫情的政策。</p><p>　　高瑞峰介绍，海关依据《中华人民共和国国境卫生检疫法》、《中华人民共和国传染病防治法》等法律法规和国务院联防联控方案规定，北京海关在北京市联防联控机制的领导下，面对境外日趋严峻复杂的形势，与各相关部门密切协作配合，认真落实“三查三排一转运”要求，做好交通工具登临检查、《中华人民共和国出/入境健康申明卡》（以下简称《健康申明卡》）收验、体温筛查、医学巡查、流行病学调查、医学排查、采样检测以及转运处置等工作，坚决遏制疫情通过口岸蔓延扩散。</p><p>　　高瑞峰介绍，在疫情防控海关卫生检疫工作链条中，依法、主动、如实填报《健康申明卡》是非常重要的一环。该卡主要包括6大项，涵盖旅客基本信息、联系方式及地址、旅行史、接触史、症状及用药史和新冠病毒核酸检测史等内容，既全面覆盖又简明扼要。</p><p>　　高瑞峰说，通过如实填报《健康申明卡》能够发挥两方面作用：一是有利于早发现、早隔离、早治疗。能够帮助海关在口岸及时准确地发现有症状、有流行病学史的高风险人员，第一时间进行医学排查、转运救治，从而有效控制疫情的跨境传播。二是有利于后续疫情防控工作。《健康申明卡》详细列明需填报的个人基本信息，包括证件号、联系方式、地址等，这些关键信息海关会及时通报给地方卫健部门，实现数据共享、联防联控，能够便于及时准确地做好后续追踪。</p><p>　　《健康申明卡》不仅有助于提高口岸卫生检疫效率，而且对保护本人和他人健康发挥着重要作用。《健康申明卡》入境人员填写主要有两种方式：一是纸本填写，来华旅客在航班上，会收到乘务员发放的《健康申明卡》，我们的通关现场也有纸质的《健康申明卡》。二是电子申报，通过微信小程序搜索“海关旅客指尖服务”，即可在线填写，方便不同人群的填报需求。</p><p>　　“填报《健康申明卡》有以下三点要求：一是要全面，所有项目不能漏项、缺项。二是要准确，一定要如实申报，如有隐瞒或虚假填报，将被依据法律追究相关责任。三是要清晰，填写工整，易于辨识。”高瑞峰表示，海关提醒各位出入境人员：为了您和他人的健康，请务必依法准确如实填报《健康申明卡》。</p><p>　　━━━━━</p><p>　　北京地坛医院收治的境外确诊病例 均在入境时已有症状</p><p>　　北京地坛医院副院长吴国安介绍近期境外确诊病例收治情况。</p><p>　　吴国安介绍，近期，境外输入新冠肺炎疫情日渐严重，境外输入病例日趋增多。北京地坛医院自2月29日起至3月14日24时累计接收机场转送医院筛查人员973人。经排查，发现确诊病例23人，平均年龄27.6岁，其中男性9例，女性14例。</p><p>　　吴国安介绍，所有确诊病例均为轻型或普通型病例，根据国家卫生健康委《新型冠状病毒肺炎诊疗方案（第七版）》，以及《北京市新型冠状病毒肺炎病例临床路径》（第二版），我们给予抗病毒和对症支持，以及中西医结合的综合治疗，目前境外输入病例病情平稳，其中2例轻症病例已经痊愈出院，返回其京外目的地。</p><p>　　3月14日0-24时共接收机场转运筛查人员207人，其中来自意大利32人，西班牙46人，韩国2人，日本4人，美国6人，其中阳性4人，其余均为阴性。昨天，北京地坛医院接收确诊病例4例，其中3例为西班牙输入病例，1例为意大利输入病例，男性3例，女性1例，均为普通型病例。另外，昨天确诊的另一例泰国输入病例已由大兴转至市级定点医院收治，该病例为女性，31岁，为普通型病例。</p><p>　　“需要指出的是，我院收治的境外输入病例在入境时均有发热或呼吸道症状，有的还曾到当地医院就诊。在此，特别提示已有呼吸道或发热症状的境外人员应主动避免带病带症国际长途旅行，应就地治疗或观察，不能将传染病风险带给同机者，更不能带入境。”吴国安说。</p><p>　　15日下午，北京市新型冠状病毒肺炎疫情防控工作新闻发布上。国航产品服务部总经理、国航海外疫情防控组成员张允介绍了3月12日CA988次航班有关空中防控情况。</p><p>　　女子登机前吃退烧药，还在飞机上撒谎……</p><p>　　3月12日，CA988次航班在美国洛杉矶旅客登机阶段，乘务员对所有旅客逐一进行了测温排查，没有发现体温超标的旅客。</p><p>　　航班起飞一小时后，座位在40b的旅客找到乘务员，自述感到憋气、乏力、脸部微麻，说自己没有同行者，登机前也未服用过任何药品，但自己一周前有短暂的发烧史。</p><p>　　乘务组为其测温是36.4℃，并将其安排到了客舱右后部留观隔离区。并按要求实施隔离处置程序，要求其全程佩戴口罩，指定了右后门的一个卫生间，为其单独使用。后续乘务组为这位旅客测温了4次，均在37℃以下。</p><p>　　航班落地前两小时，该旅客找到乘务员，陈述自己在美国任职公司有人感染，自己在美国已经发烧，并在登机前吃了退烧药，同时她说丈夫和孩子是和她同居，座位号是54k和54l。</p><p>　　乘务组立即将此情况报告机长，同时将其丈夫和孩子一同安排在了隔离区。经乘务组再次测温，一家人体温均正常，同时机组也把这个情况报告给了国航的运控中心。运控中心接到报告，立即通知相关部门启动了联防联控机制，并在飞机落地前做好了所有的准备工作。航程中乘务组按要求对全体旅客实施了两次机上测温，没有发现体温超标的旅客。</p><p>　　航班落地后海关检疫人员已经将40b乘客一家人带离排查。</p><p>　　北京报告5例境外输入病例，均在定点医院进行救治</p><p>　　北京市疾控中心副主任庞星火指出，3月14日，北京市报告5例境外输入新型冠状病毒肺炎确诊病例，其中西班牙3例，意大利1例，泰国1例。5例病例均为轻型或普通型，目前在定点医院进行救治。目前追踪到密切接触者228人，其中49人在北京，均已按要求进行集中隔离医学观察，目前身体无异常。</p><p>　在此，市疾控中心提示，在境外的居民做好个人防护，若接触病例或出现症状后应及时在当地就诊，并接受隔离观察等措施，避免或尽量减少出行，减少外界接触，更不应国际长途旅行，以免造成传染病扩散。居民近期不要去有疫情的国家或地区旅行或旅游，旅途中的感染风险较大。</p><p>　　来源：央视新闻、新京报等</p><p><br/></p>', '标签1', '', '', 4, 'uploadfile/article/showimg/1809121257CCCEC92F6378CBB920C0ED3A7C7545.jpg', 1, 1, '2020-05-13 17:42:31', NULL);
INSERT INTO `article_info` VALUES (424810478500372480, 420486952410734592, 418564852817133568, '测试标题', '测试摘要', '<p><img src=\"http://img.baidu.com/hi/jx2/j_0002.gif\"/></p>', 'hello', '', '', 9, 'uploadfile/article/showimg/test2.jpg', 1, 1, '2020-05-25 16:12:00', NULL);
INSERT INTO `article_info` VALUES (463946574614028288, 404200473187385345, 418564852817133568, '美军侦察机阴招迭出太险恶 多次冒充民航机前来“下套”', '东方网·演兵场记者夏阳9月9日报道：北大智库“南海战略态势感知”推测，昨日中午，一架美军RC-135W电子侦察机冒充马来西亚民航抵近中国领空，最近时距离海南领海基线仅约50海里。', '<p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; overflow-wrap: break-word; text-align: justify; color: rgb(80, 80, 80); line-height: 1.5; font-family: helvetica; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);\">东方网·演兵场记者夏阳9月9日报道：北大智库“南海战略态势感知”推测，昨日中午，一架美军RC-135W电子侦察机冒充马来西亚民航抵近中国领空，最近时距离海南领海基线仅约50海里。</p><p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; overflow-wrap: break-word; text-align: justify; color: rgb(80, 80, 80); line-height: 1.5; font-family: helvetica; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);\"><img src=\"/uploadfile/ueditor/image/20200910/1599724786299092107.jpg\" title=\"1599724786299092107.jpg\" alt=\"7562474982445724715.jpg\"/></p><p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; overflow-wrap: break-word; text-align: justify; color: rgb(80, 80, 80); line-height: 1.5; font-family: helvetica; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);\">图片说明：南海战略态势感</p><p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; overflow-wrap: break-word; text-align: justify; color: rgb(80, 80, 80); line-height: 1.5; font-family: helvetica; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);\">据“南海战略态势感知”所述，9月8日上午，美空军1架电码为AE01CE的RC-135W电子侦察机从冲绳嘉手纳起飞后信号消失，随后1架国籍显示为“马来西亚”电码为75054的飞机出现在同一航线。该机进入南海后飞往海南岛与西沙群岛之间空域密集行动，距离海南领海基线仅约50海里，推测是RC-135W挂虚假电码对中国进行侦察。</p><p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; overflow-wrap: break-word; text-align: justify; color: rgb(80, 80, 80); line-height: 1.5; font-family: helvetica; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);\">针对此事，据俄罗斯卫星网认为，美军将军机伪装成民航飞机的举动极易造成误判，是在将无辜者的生命置于危险之中，甚至在历史上已经引发了客机被误当做军机击落的严重事件。</p><p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; overflow-wrap: break-word; text-align: justify; color: rgb(80, 80, 80); line-height: 1.5; font-family: helvetica; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);\">比如发生在1983年大韩航空007号班机遭击落事件，当年大韩航空007号班机进入苏联领空，被一架苏-15截击机击落。原来，苏军的雷达操作人员将这架波音-747客机误认为美军RC-135W战略侦察机，因为当时后者也出现在了同一空域，并与韩国客机交叉飞行，由此才导致了苏军的误判。</p><p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; overflow-wrap: break-word; text-align: justify; color: rgb(80, 80, 80); line-height: 1.5; font-family: helvetica; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);\">事实上，这已经是本月美军侦察机第二次疑似采用虚假电码在南海开展活动。上一次发生在9月3日。当日上午，1架电码为07675C的飞机经由巴士海峡空域进入南海，后信号消失。下午15时许，信号短暂出现后再次消失，继而几乎同一位置出现了电码为AE01CE的美空军RC-135W电子侦察机，推测上午的07675C就是RC-135W采用的虚假电码。</p><p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; overflow-wrap: break-word; text-align: justify; color: rgb(80, 80, 80); line-height: 1.5; font-family: helvetica; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);\">当时，军事专家杜文龙在接受央视采访时就表示：美军机刻意伪装，极具欺骗性，很可能让南海周边国家的空管系统将其当作一架民航机。而美军电子侦察机，不仅在南海意图对中国进行侦察，周围国家也是其侦察目标。</p><p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; overflow-wrap: break-word; text-align: justify; color: rgb(80, 80, 80); line-height: 1.5; font-family: helvetica; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);\">杜文龙还强调，美军机电码伪装成民航飞机电码，很有可能导致误判，对南海上空飞行的所有民航飞机构成较大威胁，一旦被周边国家判断为入侵行为，极易造成武器误击，酿成悲剧。</p><p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; overflow-wrap: break-word; text-align: justify; color: rgb(80, 80, 80); line-height: 1.5; font-family: helvetica; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);\">美国RC-135侦察机，是美空军现役部队装备的一种战略侦察机，擅长在目标国沿海地区实施侦察行动，被美国空军视为与新一代军事侦察卫星和远程无人驾驶飞机并驾齐驱的美军21世纪最重要的侦察工具，性能比EP-3还优越。在越南战争、海湾战争、科索沃战争、阿富汗战争和伊拉克战争等军事行动中，RC-135侦察机为美军作战提供了情报保障。</p><p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; overflow-wrap: break-word; text-align: justify; color: rgb(80, 80, 80); line-height: 1.5; font-family: helvetica; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);\">根据型号的不同，各型RC-135侦察机可分别用于信号情报、电子情报和弹道导弹情报的侦察，例如上文提及的RC-135W重点收集的目标是电磁信号，任务是实时侦测空中各种电磁波信息，对目标进行定位、分析、记录和信息处理。其机载雷达可以收集预警、制导和引导雷达的频率等技术参数，并对其进行定位，世界上各种雷达参数都在其测量范围内。机上通信信号侦察系统可侦察到音频、话频、电传、电报等信号。</p><p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; overflow-wrap: break-word; text-align: justify; color: rgb(80, 80, 80); line-height: 1.5; font-family: helvetica; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);\">近段时间以来，除了以前常见的美国空军、海军的飞机现身南海空域，美国陆军侦察机也加入了这一行列，美国陆军“挑战者650”侦察机更是频繁活动。就在昨天，浙江近海附近出现一架隶属美国陆军、编号N488CR的“阿尔忒弥斯”侦察机，轨迹十分接近解放军早已经划定的演习区域，态度非常之嚣张。</p><p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; overflow-wrap: break-word; text-align: justify; color: rgb(80, 80, 80); line-height: 1.5; font-family: helvetica; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);\">“阿尔忒弥斯”是美国陆军第一架喷气式侦察机，机型为庞巴迪制造的“挑战者650”双引擎商务飞机，装有传感器。根据美军方公布的飞机照片，机身没有美军涂装，乍一看就是一架私人飞机，极具欺骗性。</p><p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; overflow-wrap: break-word; text-align: justify; color: rgb(80, 80, 80); line-height: 1.5; font-family: helvetica; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);\">声明：转载此文是出于传递更多信息之目的。若有来源标注错误或侵犯了您的合法权益，请作者持权属证明与本网联系，我们将及时更正、删除，谢谢。</p><p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; overflow-wrap: break-word; text-align: justify; color: rgb(80, 80, 80); line-height: 1.5; font-family: helvetica; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255);\">来源： 东方网</p><p><br/></p>', '军事', 'uploadfile/article/attachments/catalina.out', 'catalina.out', 2, 'uploadfile/article/showimg/7562474982445724715_20200910155540.jpg', 1, 1, '2020-09-10 16:04:53', NULL);

-- ----------------------------
-- Table structure for article_likes
-- ----------------------------
DROP TABLE IF EXISTS `article_likes`;
CREATE TABLE `article_likes`  (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `info_id` bigint(20) NOT NULL DEFAULT -1 COMMENT '文章ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_Reference_articleLikes_userid`(`user_id`) USING BTREE,
  INDEX `FK_Reference_articleLikes_infoid`(`info_id`) USING BTREE,
  CONSTRAINT `article_likes_ibfk_1` FOREIGN KEY (`info_id`) REFERENCES `article_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `article_likes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章点赞表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_likes
-- ----------------------------
INSERT INTO `article_likes` VALUES (424797810771156992, 404200473187385345, 420484600073084928, '2020-05-25 15:21:40');

-- ----------------------------
-- Table structure for article_type
-- ----------------------------
DROP TABLE IF EXISTS `article_type`;
CREATE TABLE `article_type`  (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `type_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文章类型编码',
  `type_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文章类型名',
  `create_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `sort_num` int(11) NULL DEFAULT NULL COMMENT '排序字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `inx_article_type_code`(`type_code`) USING BTREE,
  INDEX `inx_article_type_name`(`type_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_type
-- ----------------------------
INSERT INTO `article_type` VALUES (418564852817133568, 'TEST', '测试', '管理员', '2020-05-08 02:34:07', NULL);
INSERT INTO `article_type` VALUES (418564899046752256, 'TEST2', '测试2', '管理员', '2020-05-08 02:34:18', NULL);

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
INSERT INTO `sys_modulelist` VALUES (1, -1, '菜单', 'PROJECTNAME', NULL, NULL, 'navTab', 1, 1, 'Portal', 2, NULL, 'admin', '2020-03-21 18:41:27');
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
INSERT INTO `sys_modulelist` VALUES (463242895539888128, 462864005579464704, '应用管理1', 'APPLICATIONMANAGE', 'icon-sitemap', 'applicationManage/applicationManageList', 'navTab', 1, 1, 'Portal', 1, 2, 'admin', '2020-09-08 17:28:43');
INSERT INTO `sys_modulelist` VALUES (463561666653642752, 1, '测试子系统', 'SUBSYSTEM', NULL, NULL, 'navTab', 0, 1, 'Subsystem', 0, NULL, 'admin', '2020-09-09 14:35:24');
INSERT INTO `sys_modulelist` VALUES (463561666653642753, 463561666653642761, '地区管理', 'AREAMANAGE', 'icon-reorder', NULL, 'navTab', 0, 1, 'Subsystem', 2, NULL, 'admin', '2020-03-21 18:42:27');
INSERT INTO `sys_modulelist` VALUES (463561666653642754, 463561666653642761, '机构管理', 'ORGMANAGE', 'icon-reorder', 'orgManage/orglist', 'navTab', 1, 1, 'Subsystem', 2, 2, 'admin', '2020-03-30 07:46:30');
INSERT INTO `sys_modulelist` VALUES (463561666653642755, 463561666653642761, '菜单管理', 'MENUMANAGE', 'icon-reorder', 'menuManage/menulist', 'navTab', 1, 1, 'Subsystem', 2, 3, 'admin', '2020-03-30 07:46:59');
INSERT INTO `sys_modulelist` VALUES (463561666653642756, 463561666653642761, '角色管理', 'ROLEMANAGE', 'icon-reorder', NULL, 'navTab', 0, 1, 'Subsystem', 2, 4, 'admin', '2020-03-30 07:47:31');
INSERT INTO `sys_modulelist` VALUES (463561666653642757, 463561666653642761, '用户管理', 'USERMANAGE', 'icon-reorder', 'userManage/userManageList', 'navTab', 0, 1, 'Subsystem', 2, 5, 'admin', '2020-03-30 07:48:11');
INSERT INTO `sys_modulelist` VALUES (463561666653642758, 463561666653642753, '地区管理', 'AREAMANAGEFUNC', 'icon-reorder', 'areaManage/arealist', 'navTab', 1, 1, 'Subsystem', 2, 1, 'admin', '2020-03-30 07:49:50');
INSERT INTO `sys_modulelist` VALUES (463561666653642759, 463561666653642756, '角色管理', 'ROLEMANAGEFUNC', 'icon-reorder', 'roleManage/roleManageList', 'navTab', 1, 1, 'Subsystem', 2, 1, 'admin', '2020-03-30 07:50:38');
INSERT INTO `sys_modulelist` VALUES (463561666653642760, 463561666653642756, '角色菜单授权', 'ROLEANDMENU', 'icon-reorder', 'roleManage/roleAndMenu', 'navTab', 1, 1, 'Subsystem', 2, 3, 'admin', '2020-03-30 07:50:57');
INSERT INTO `sys_modulelist` VALUES (463561666653642761, 463561666653642752, '系统管理', 'SYSTEMMANAGE', 'icon-cog', NULL, 'navTab', 0, 1, 'Subsystem', 2, 1, 'admin', '2020-03-30 07:53:28');
INSERT INTO `sys_modulelist` VALUES (463561666653642762, 463561666653642756, '角色用户绑定', 'ROLEANDUSERBIND', 'icon-reorder', 'roleManage/roleAndUser', 'navTab', 1, 1, 'Subsystem', 2, 2, 'admin', '2020-04-11 08:31:10');
INSERT INTO `sys_modulelist` VALUES (463645654579732480, 463561666653642752, '任务管理', 'QUARTZMANAGE', 'icon-th', 'quartzManage/quzrtzManagelist', 'navTab', 1, 1, 'Subsystem', 1, 2, 'admin', '2020-09-09 20:09:08');
INSERT INTO `sys_modulelist` VALUES (463939432767086592, 463561666653642752, '文章管理', 'ARTICLEMANAGE', 'icon-book', NULL, 'navTab', 0, 1, 'Subsystem', 1, 3, 'admin', '2020-09-10 15:36:31');
INSERT INTO `sys_modulelist` VALUES (463939572810702848, 463939432767086592, '文章分类管理', 'ARTICLETYPE', 'icon-reorder', 'articleTypeManage/articleTypeList', 'navTab', 1, 1, 'Subsystem', 1, 0, 'admin', '2020-09-10 15:37:04');
INSERT INTO `sys_modulelist` VALUES (463939784589500416, 463939432767086592, '我的文章', 'MYARTICLE', 'icon-reorder', NULL, 'navTab', 0, 1, 'Subsystem', 1, 1, 'admin', '2020-09-10 15:37:54');
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
INSERT INTO `sys_org` VALUES (1, '410000000000', '河南省XX局', '41000041600000', '41000000000000', 416, NULL, NULL, 'admin', '2020-03-07 15:09:41', 0, NULL);
INSERT INTO `sys_org` VALUES (335386239865716736, '410000000000', 'XX中心', '41000041601000', '41000041600000', 416, '', 'uploadfile/orgLogo/APP应用图标3.png', 'admin', '2020-03-07 15:11:46', 1, NULL);
INSERT INTO `sys_org` VALUES (404189543468695552, '410100000000', '郑州市', '41010000000000', '41000000000000', NULL, '', '', 'admin', '2020-03-29 10:31:46', NULL, NULL);
INSERT INTO `sys_org` VALUES (404189606702022656, '410100000000', '郑州市XX局', '41010041600000', '41010000000000', NULL, '', '', 'admin', '2020-03-29 10:32:01', NULL, NULL);

-- ----------------------------
-- Table structure for sys_quartz
-- ----------------------------
DROP TABLE IF EXISTS `sys_quartz`;
CREATE TABLE `sys_quartz`  (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `quartzname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `cron` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '执行时间（Cron表达式）',
  `clazzname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务类名',
  `running` int(11) NOT NULL DEFAULT 0 COMMENT '状态（1 启用，0禁用）',
  `params` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '任务参数',
  `exp1` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上次任务开始执行时间',
  `exp2` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上次任务执行完成时间',
  `exp3` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '定时任务的服务标识码，启动多个服务时用于区分一个任务属于哪个服务',
  `exp4` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `exp5` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `inx_quartz_running`(`running`) USING BTREE,
  INDEX `inx_quartz_name`(`quartzname`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_quartz
-- ----------------------------
INSERT INTO `sys_quartz` VALUES (2, '测试2', '0/5 * * * * ?', 'cn.net.colin.quartz.job.HelloJob', 0, NULL, '2020-09-10 10:53:58', '2020-09-10 10:54:28', '1', NULL, NULL);
INSERT INTO `sys_quartz` VALUES (4, '测试4', '0/5 * * * * ?', 'cn.net.colin.quartz.job.HelloJob', 0, NULL, '2020-09-10 10:54:00', '2020-09-10 10:54:30', '1', NULL, NULL);
INSERT INTO `sys_quartz` VALUES (5, '测试5', '1/30 * * * * ?', 'cn.net.colin.quartz.job.HelloJob', 0, NULL, '2020-07-29 14:40:01', '2020-07-29 14:40:01', '0', NULL, NULL);

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
