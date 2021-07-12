-- --------------------------------------------------------
-- 호스트:                          3.36.93.39
-- 서버 버전:                        10.3.29-MariaDB-1:10.3.29+maria~xenial-log - mariadb.org binary distribution
-- 서버 OS:                        debian-linux-gnu
-- HeidiSQL 버전:                  11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- obo 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `obo` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `obo`;

-- 테이블 obo.address 구조 내보내기
CREATE TABLE IF NOT EXISTS `address` (
  `address_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `post_code` varchar(5) NOT NULL COMMENT '우편번호',
  `doro` varchar(20) DEFAULT NULL COMMENT '시도',
  `detail_address` varchar(20) DEFAULT NULL COMMENT '읍면',
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6351829 DEFAULT CHARSET=utf8 COMMENT='주소';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.adopt 구조 내보내기
CREATE TABLE IF NOT EXISTS `adopt` (
  `adopt_apply_id` int(11) NOT NULL,
  `staff_id` varchar(50) NOT NULL,
  `adopt_date` datetime NOT NULL,
  PRIMARY KEY (`adopt_apply_id`,`staff_id`),
  CONSTRAINT `FK_adopt_adopt_apply` FOREIGN KEY (`adopt_apply_id`) REFERENCES `adopt_apply` (`adopt_apply_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='입양';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.adopt_apply 구조 내보내기
CREATE TABLE IF NOT EXISTS `adopt_apply` (
  `adopt_apply_id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` varchar(50) NOT NULL,
  `animal_id` int(11) NOT NULL,
  `adopt_apply_document_id` int(11) NOT NULL,
  `apply_date` datetime NOT NULL,
  `apply_reject_date` datetime DEFAULT NULL COMMENT '반려되면 날짜를 넣는다',
  PRIMARY KEY (`adopt_apply_id`),
  KEY `FK_adopt_apply_member` (`member_id`),
  KEY `FK_adopt_apply_animal` (`animal_id`),
  KEY `FK_adopt_apply_adopt_apply_document` (`adopt_apply_document_id`),
  CONSTRAINT `FK_adopt_apply_adopt_apply_document` FOREIGN KEY (`adopt_apply_document_id`) REFERENCES `adopt_apply_document` (`adopt_apply_document_id`),
  CONSTRAINT `FK_adopt_apply_animal` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`animal_id`),
  CONSTRAINT `FK_adopt_apply_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='입양신청';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.adopt_apply_answer 구조 내보내기
CREATE TABLE IF NOT EXISTS `adopt_apply_answer` (
  `adopt_apply_document_id` int(11) NOT NULL,
  `adopt_apply_question_id` int(11) NOT NULL,
  `answer` text NOT NULL,
  PRIMARY KEY (`adopt_apply_document_id`,`adopt_apply_question_id`),
  KEY `FK_adopt_apply_answer_adopt_apply_question` (`adopt_apply_question_id`),
  CONSTRAINT `FK_adopt_apply_answer_adopt_apply_document` FOREIGN KEY (`adopt_apply_document_id`) REFERENCES `adopt_apply_document` (`adopt_apply_document_id`),
  CONSTRAINT `FK_adopt_apply_answer_adopt_apply_question` FOREIGN KEY (`adopt_apply_question_id`) REFERENCES `adopt_apply_question` (`adopt_apply_question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='입양신청답안';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.adopt_apply_document 구조 내보내기
CREATE TABLE IF NOT EXISTS `adopt_apply_document` (
  `adopt_apply_document_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`adopt_apply_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='신청 서류';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.adopt_apply_question 구조 내보내기
CREATE TABLE IF NOT EXISTS `adopt_apply_question` (
  `adopt_apply_question_id` int(11) NOT NULL AUTO_INCREMENT,
  `question` text NOT NULL,
  PRIMARY KEY (`adopt_apply_question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.animal 구조 내보내기
CREATE TABLE IF NOT EXISTS `animal` (
  `animal_id` int(11) NOT NULL AUTO_INCREMENT,
  `animal_category_id` int(11) NOT NULL,
  `shelter_id` int(11) NOT NULL,
  `animal_name` varchar(50) NOT NULL,
  `animal_age` int(11) NOT NULL COMMENT '개월',
  `animal_sex` enum('수컷','암컷') NOT NULL,
  `animal_weight` decimal(5,2) NOT NULL,
  `animal_kind` varchar(50) NOT NULL,
  `animal_find_place` varchar(50) DEFAULT NULL,
  `animal_note` text DEFAULT NULL COMMENT '회원들한테 보여줄 소개 ex 추정나이',
  `animal_enter_date` datetime NOT NULL,
  `animal_exit_date` datetime DEFAULT NULL,
  `animal_introduce` text DEFAULT NULL,
  `animal_state` enum('입양','보호중','안락사','자연사') NOT NULL,
  PRIMARY KEY (`animal_id`),
  KEY `FK_animal_animal_category` (`animal_category_id`),
  KEY `FK_animal_shelter` (`shelter_id`),
  CONSTRAINT `FK_animal_animal_category` FOREIGN KEY (`animal_category_id`) REFERENCES `animal_category` (`animal_category_id`),
  CONSTRAINT `FK_animal_shelter` FOREIGN KEY (`shelter_id`) REFERENCES `shelter` (`shelter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='age는 개월 수 -> 발견 당시 개월\r\nintroduce 나이 알아서 적기,,, 몇살 혹은 몇개월 등\r\n\r\n매달 1일에 나이 개월수 추가';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.animal_category 구조 내보내기
CREATE TABLE IF NOT EXISTS `animal_category` (
  `animal_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `species` varchar(50) NOT NULL,
  PRIMARY KEY (`animal_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.animal_file 구조 내보내기
CREATE TABLE IF NOT EXISTS `animal_file` (
  `animal_file_id` int(11) NOT NULL AUTO_INCREMENT,
  `animal_id` int(11) NOT NULL,
  `animal_file_name` varchar(50) NOT NULL,
  `animal_file_size` int(11) NOT NULL,
  `animal_file_ext` varchar(50) NOT NULL,
  `animal_file_date` datetime NOT NULL,
  PRIMARY KEY (`animal_file_id`),
  KEY `FK_animal_file_animal` (`animal_id`),
  CONSTRAINT `FK_animal_file_animal` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`animal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.animal_like 구조 내보내기
CREATE TABLE IF NOT EXISTS `animal_like` (
  `animal_id` int(11) NOT NULL,
  `member_id` varchar(50) CHARACTER SET utf8 NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`animal_id`,`member_id`),
  KEY `FK_animal_like_member` (`member_id`),
  CONSTRAINT `FK_animal_like_animal` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`animal_id`),
  CONSTRAINT `FK_animal_like_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.board 구조 내보내기
CREATE TABLE IF NOT EXISTS `board` (
  `board_id` int(11) NOT NULL AUTO_INCREMENT,
  `board_category_id` int(11) NOT NULL,
  `member_id` varchar(50) NOT NULL,
  `animal_category_id` int(11) DEFAULT NULL,
  `board_title` varchar(50) NOT NULL,
  `board_content` text NOT NULL,
  `create_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`board_id`),
  KEY `FK_board_board_category` (`board_category_id`),
  KEY `FK_board_member` (`member_id`),
  KEY `FK_board_animal_category` (`animal_category_id`),
  CONSTRAINT `FK_board_animal_category` FOREIGN KEY (`animal_category_id`) REFERENCES `animal_category` (`animal_category_id`),
  CONSTRAINT `FK_board_board_category` FOREIGN KEY (`board_category_id`) REFERENCES `board_category` (`board_category_id`),
  CONSTRAINT `FK_board_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.board_category 구조 내보내기
CREATE TABLE IF NOT EXISTS `board_category` (
  `board_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `board_category_name` varchar(50) NOT NULL,
  PRIMARY KEY (`board_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.board_comment 구조 내보내기
CREATE TABLE IF NOT EXISTS `board_comment` (
  `board_comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `board_id` int(11) NOT NULL,
  `member_id` varchar(50) NOT NULL,
  `board_comment_content` text NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`board_comment_id`),
  KEY `FK_board_comment_board` (`board_id`),
  KEY `FK_board_comment_member` (`member_id`),
  CONSTRAINT `FK_board_comment_board` FOREIGN KEY (`board_id`) REFERENCES `board` (`board_id`),
  CONSTRAINT `FK_board_comment_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.board_file 구조 내보내기
CREATE TABLE IF NOT EXISTS `board_file` (
  `board_file_id` int(11) NOT NULL AUTO_INCREMENT,
  `board_id` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  `board_file_original_name` varchar(50) NOT NULL,
  `board_file_name` varchar(50) NOT NULL,
  `board_file_size` int(11) NOT NULL,
  `board_file_ext` varchar(50) NOT NULL,
  PRIMARY KEY (`board_file_id`),
  KEY `FK_board_file_board` (`board_id`),
  CONSTRAINT `FK_board_file_board` FOREIGN KEY (`board_id`) REFERENCES `board` (`board_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.board_like 구조 내보내기
CREATE TABLE IF NOT EXISTS `board_like` (
  `board_id` int(11) NOT NULL,
  `member_id` varchar(50) NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`board_id`,`member_id`),
  KEY `FK_board_like_member` (`member_id`),
  CONSTRAINT `FK_board_like_board` FOREIGN KEY (`board_id`) REFERENCES `board` (`board_id`),
  CONSTRAINT `FK_board_like_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.care_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `care_info` (
  `care_info_id` int(11) NOT NULL AUTO_INCREMENT,
  `animal_category_id` int(11) NOT NULL,
  `care_time` int(11) NOT NULL COMMENT '케어 시기 월단위',
  `care_info_content` text NOT NULL,
  PRIMARY KEY (`care_info_id`),
  KEY `FK_care_info_animal_category` (`animal_category_id`),
  CONSTRAINT `FK_care_info_animal_category` FOREIGN KEY (`animal_category_id`) REFERENCES `animal_category` (`animal_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='시기를 계산을 위한 컬럼 추가 고민';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.care_plan 구조 내보내기
CREATE TABLE IF NOT EXISTS `care_plan` (
  `care_plan_id` int(11) NOT NULL AUTO_INCREMENT,
  `animal_id` int(11) NOT NULL,
  `member_id` varchar(50) NOT NULL,
  `staff_id` varchar(50) NOT NULL,
  `care_info_id` int(11) NOT NULL,
  `care_date` datetime NOT NULL COMMENT '케어를 할 정확한 날짜',
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`care_plan_id`),
  KEY `FK_care_plan_animal` (`animal_id`),
  KEY `FK_care_plan_member` (`member_id`),
  KEY `FK_care_plan_staff` (`staff_id`),
  KEY `FK_care_plan_care_info` (`care_info_id`),
  CONSTRAINT `FK_care_plan_animal` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`animal_id`),
  CONSTRAINT `FK_care_plan_care_info` FOREIGN KEY (`care_info_id`) REFERENCES `care_info` (`care_info_id`),
  CONSTRAINT `FK_care_plan_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `FK_care_plan_staff` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.care_record 구조 내보내기
CREATE TABLE IF NOT EXISTS `care_record` (
  `care_plan_id` int(11) NOT NULL,
  `staff_id_check` varchar(50) NOT NULL COMMENT '확인한직원',
  `record_date` datetime NOT NULL,
  `features` text DEFAULT NULL COMMENT '특이사항',
  PRIMARY KEY (`care_plan_id`,`staff_id_check`),
  KEY `FK_care_record_staff` (`staff_id_check`),
  CONSTRAINT `FK_care_record_care_plan` FOREIGN KEY (`care_plan_id`) REFERENCES `care_plan` (`care_plan_id`),
  CONSTRAINT `FK_care_record_staff` FOREIGN KEY (`staff_id_check`) REFERENCES `staff` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.donation_item_list 구조 내보내기
CREATE TABLE IF NOT EXISTS `donation_item_list` (
  `donation_item_list_id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` varchar(50) NOT NULL,
  `shelter_id` int(11) NOT NULL,
  `item_category_id` int(11) NOT NULL,
  `donation_date` datetime NOT NULL,
  `item_name` varchar(50) NOT NULL,
  `item_quantity` int(11) NOT NULL COMMENT '물품 수량',
  `item_description` text DEFAULT NULL,
  PRIMARY KEY (`donation_item_list_id`),
  KEY `FK_donation_item_list_member` (`member_id`),
  KEY `FK_donation_item_list_item_category` (`item_category_id`),
  KEY `FK_donation_item_list_shelter` (`shelter_id`),
  CONSTRAINT `FK_donation_item_list_item_category` FOREIGN KEY (`item_category_id`) REFERENCES `item_category` (`item_category_id`),
  CONSTRAINT `FK_donation_item_list_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `FK_donation_item_list_shelter` FOREIGN KEY (`shelter_id`) REFERENCES `shelter` (`shelter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='일반물품리스트';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.donation_money_list 구조 내보내기
CREATE TABLE IF NOT EXISTS `donation_money_list` (
  `donation_money_list_id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` varchar(50) NOT NULL,
  `shelter_id` int(11) NOT NULL,
  `donation_date` datetime NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`donation_money_list_id`),
  KEY `member_id` (`member_id`),
  KEY `FK_donation_money_list_shelter` (`shelter_id`),
  CONSTRAINT `FK_donation_money_list_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `FK_donation_money_list_shelter` FOREIGN KEY (`shelter_id`) REFERENCES `shelter` (`shelter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.item_category 구조 내보내기
CREATE TABLE IF NOT EXISTS `item_category` (
  `item_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_category_name` varchar(50) NOT NULL,
  PRIMARY KEY (`item_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.manager 구조 내보내기
CREATE TABLE IF NOT EXISTS `manager` (
  `manager_id` varchar(50) NOT NULL,
  `manager_password` varchar(50) NOT NULL,
  `manager_name` varchar(50) NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`manager_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.member 구조 내보내기
CREATE TABLE IF NOT EXISTS `member` (
  `member_id` varchar(50) NOT NULL,
  `address_id` int(11) unsigned NOT NULL,
  `member_name` varchar(50) NOT NULL,
  `member_phone` varchar(50) NOT NULL,
  `member_birth` datetime NOT NULL,
  `member_email` varchar(50) NOT NULL,
  `member_password` varchar(50) NOT NULL,
  `member_nickname` varchar(50) NOT NULL,
  `member_state` enum('0','1') NOT NULL DEFAULT '1',
  `member_gender` enum('남','여') NOT NULL,
  `create_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`member_id`),
  KEY `FK_member_address` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='가입할때 닉네임을 안쓰면 멤버아이디가 닉네임에 들어가도록 코딩';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.periodically_donation 구조 내보내기
CREATE TABLE IF NOT EXISTS `periodically_donation` (
  `periodically_donation_id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` varchar(50) NOT NULL,
  `shelter_id` int(11) NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `apply_date` datetime NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`periodically_donation_id`),
  KEY `FK_periodically_donation_member` (`member_id`),
  KEY `FK_periodically_donation_shelter` (`shelter_id`),
  CONSTRAINT `FK_periodically_donation_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `FK_periodically_donation_shelter` FOREIGN KEY (`shelter_id`) REFERENCES `shelter` (`shelter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='정기 후원, api 추가 필요';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.periodically_donation_list 구조 내보내기
CREATE TABLE IF NOT EXISTS `periodically_donation_list` (
  `periodically_donation_id` int(11) NOT NULL,
  `deposit_date` datetime NOT NULL COMMENT '입금날짜',
  PRIMARY KEY (`periodically_donation_id`,`deposit_date`),
  CONSTRAINT `FK_periodically_donation_list_periodically_donation` FOREIGN KEY (`periodically_donation_id`) REFERENCES `periodically_donation` (`periodically_donation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='정기 후원 돈 리스트\r\n이게 맞나?';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.periodically_volunteer_apply 구조 내보내기
CREATE TABLE IF NOT EXISTS `periodically_volunteer_apply` (
  `periodically_volunteer_apply_id` int(11) NOT NULL AUTO_INCREMENT,
  `periodically_volunteer_recruit_id` int(11) NOT NULL,
  `member_id` varchar(50) NOT NULL,
  `apply_date` datetime NOT NULL,
  `determination` text DEFAULT NULL,
  PRIMARY KEY (`periodically_volunteer_apply_id`),
  KEY `FK_periodically_volunteer_apply_member` (`member_id`),
  KEY `periodically_volunteer_recruit_id` (`periodically_volunteer_recruit_id`),
  CONSTRAINT `FK_periodically_volunteer_apply_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `FK_periodically_volunteer_apply_periodically_volunteer_recruit` FOREIGN KEY (`periodically_volunteer_recruit_id`) REFERENCES `periodically_volunteer_recruit` (`periodically_volunteer_recruit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='정기봉사 지원';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.periodically_volunteer_check 구조 내보내기
CREATE TABLE IF NOT EXISTS `periodically_volunteer_check` (
  `periodically_volunteer_apply_id` int(11) NOT NULL,
  `staff_id_check` varchar(50) NOT NULL,
  `volunteer_date` datetime NOT NULL COMMENT '실제로 봉사를 한 날짜',
  `check_date` datetime NOT NULL,
  PRIMARY KEY (`periodically_volunteer_apply_id`,`staff_id_check`),
  KEY `FK_periodically_volunteer_check_staff` (`staff_id_check`),
  CONSTRAINT `FK_periodically_volunteer_check_periodically_volunteer_apply` FOREIGN KEY (`periodically_volunteer_apply_id`) REFERENCES `periodically_volunteer_apply` (`periodically_volunteer_apply_id`),
  CONSTRAINT `FK_periodically_volunteer_check_staff` FOREIGN KEY (`staff_id_check`) REFERENCES `staff` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.periodically_volunteer_recruit 구조 내보내기
CREATE TABLE IF NOT EXISTS `periodically_volunteer_recruit` (
  `periodically_volunteer_recruit_id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` varchar(50) NOT NULL,
  `volunteer_category_id` int(11) NOT NULL,
  `periodically_volunteer_start_date` datetime NOT NULL,
  `recruit_count` int(11) NOT NULL COMMENT '모집인원',
  `register_date` datetime NOT NULL,
  `title` varchar(50) NOT NULL,
  `volunteer_cycle` enum('월','화','수','목','금','토','일') NOT NULL COMMENT '봉사주기(매주)',
  PRIMARY KEY (`periodically_volunteer_recruit_id`),
  KEY `FK_periodically_volunteer_recruit_staff` (`staff_id`),
  KEY `FK_periodically_volunteer_recruit_volunteer_category` (`volunteer_category_id`),
  CONSTRAINT `FK_periodically_volunteer_recruit_staff` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`),
  CONSTRAINT `FK_periodically_volunteer_recruit_volunteer_category` FOREIGN KEY (`volunteer_category_id`) REFERENCES `volunteer_category` (`volunteer_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='정기봉사모집\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.qualification_approval 구조 내보내기
CREATE TABLE IF NOT EXISTS `qualification_approval` (
  `qualification_volunteer_application_id` int(11) NOT NULL,
  `manager_id` varchar(50) NOT NULL,
  `approval_check` enum('Y','N') NOT NULL,
  `approval_date` datetime NOT NULL,
  PRIMARY KEY (`qualification_volunteer_application_id`,`manager_id`),
  KEY `FK_qualification_approval_manager` (`manager_id`),
  CONSTRAINT `FK_qualification_approval_manager` FOREIGN KEY (`manager_id`) REFERENCES `manager` (`manager_id`),
  CONSTRAINT `FK_qualification_approval_qualification_volunteer_application` FOREIGN KEY (`qualification_volunteer_application_id`) REFERENCES `qualification_volunteer_application` (`qualification_volunteer_application_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='자격 승인';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.qualification_file 구조 내보내기
CREATE TABLE IF NOT EXISTS `qualification_file` (
  `qualification_file_id` int(11) NOT NULL AUTO_INCREMENT,
  `qualification_file_name` varchar(50) NOT NULL,
  `qualification_file_size` int(11) NOT NULL,
  `qualification_file_ext` varchar(50) NOT NULL,
  PRIMARY KEY (`qualification_file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.qualification_type 구조 내보내기
CREATE TABLE IF NOT EXISTS `qualification_type` (
  `qualification_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `qualification_type_name` varchar(50) NOT NULL,
  PRIMARY KEY (`qualification_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.qualification_volunteer_application 구조 내보내기
CREATE TABLE IF NOT EXISTS `qualification_volunteer_application` (
  `qualification_volunteer_application_id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` varchar(50) NOT NULL,
  `volunteer_category_id` int(11) NOT NULL,
  `qualification_type_id` int(11) NOT NULL COMMENT '자격종류 ex.트리머, 미용사 머 등등',
  `qualification_file_id` int(11) NOT NULL,
  `applicate_date` datetime NOT NULL,
  PRIMARY KEY (`qualification_volunteer_application_id`),
  KEY `FK_qualification_volunteer_application_member` (`member_id`),
  KEY `FK_qualification_volunteer_application_volunteer_category` (`volunteer_category_id`),
  KEY `FK_qualification_volunteer_application_qualification_type` (`qualification_type_id`),
  KEY `FK_qualification_volunteer_application_qualification_file` (`qualification_file_id`),
  CONSTRAINT `FK_qualification_volunteer_application_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `FK_qualification_volunteer_application_qualification_file` FOREIGN KEY (`qualification_file_id`) REFERENCES `qualification_file` (`qualification_file_id`),
  CONSTRAINT `FK_qualification_volunteer_application_qualification_type` FOREIGN KEY (`qualification_type_id`) REFERENCES `qualification_type` (`qualification_type_id`),
  CONSTRAINT `FK_qualification_volunteer_application_volunteer_category` FOREIGN KEY (`volunteer_category_id`) REFERENCES `volunteer_category` (`volunteer_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='봉사 자격 신청';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.qualification_volunteer_category 구조 내보내기
CREATE TABLE IF NOT EXISTS `qualification_volunteer_category` (
  `qualification_type_id` int(11) NOT NULL,
  `volunteer_category_id` int(11) NOT NULL,
  PRIMARY KEY (`qualification_type_id`,`volunteer_category_id`),
  KEY `FK_qualification_volunteer_category_volunteer_category` (`volunteer_category_id`),
  CONSTRAINT `FK_qualification_volunteer_category_qualification_type` FOREIGN KEY (`qualification_type_id`) REFERENCES `qualification_type` (`qualification_type_id`),
  CONSTRAINT `FK_qualification_volunteer_category_volunteer_category` FOREIGN KEY (`volunteer_category_id`) REFERENCES `volunteer_category` (`volunteer_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='자격 봉사 카테고리';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.shelter 구조 내보내기
CREATE TABLE IF NOT EXISTS `shelter` (
  `shelter_id` int(11) NOT NULL AUTO_INCREMENT,
  `address_id` int(10) unsigned NOT NULL,
  `shelter_name` varchar(50) NOT NULL,
  `create_date` datetime NOT NULL,
  `introduction` text NOT NULL,
  `protect_duration` int(11) NOT NULL,
  `shelter_phone` varchar(50) NOT NULL,
  `account` varchar(50) NOT NULL COMMENT '계좌',
  `active` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`shelter_id`),
  KEY `FK_shelter_address` (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.shelter_file 구조 내보내기
CREATE TABLE IF NOT EXISTS `shelter_file` (
  `shelter_file_id` int(11) NOT NULL AUTO_INCREMENT,
  `shelter_id` int(11) NOT NULL,
  `shelter_file_name` varchar(50) NOT NULL,
  `shelter_file_size` int(11) NOT NULL,
  `shelter_file_ext` varchar(50) NOT NULL,
  `upload_date` datetime NOT NULL,
  PRIMARY KEY (`shelter_file_id`),
  KEY `FK_shelter_file_shelter` (`shelter_id`),
  CONSTRAINT `FK_shelter_file_shelter` FOREIGN KEY (`shelter_id`) REFERENCES `shelter` (`shelter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.staff 구조 내보내기
CREATE TABLE IF NOT EXISTS `staff` (
  `staff_id` varchar(50) NOT NULL,
  `staff_email` varchar(50) NOT NULL,
  `shelter_id` int(11) NOT NULL,
  `staff_name` varchar(50) NOT NULL,
  `staff_phone` varchar(50) NOT NULL,
  `staff_active` enum('0','1') NOT NULL,
  `staff_level` enum('0','1','2') NOT NULL,
  `staff_password` varchar(50) NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `FK_staff_shelter` (`shelter_id`),
  CONSTRAINT `FK_staff_shelter` FOREIGN KEY (`shelter_id`) REFERENCES `shelter` (`shelter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.volunteer_apply 구조 내보내기
CREATE TABLE IF NOT EXISTS `volunteer_apply` (
  `volunteer_apply_id` int(11) NOT NULL AUTO_INCREMENT,
  `volunteer_recruit_id` int(11) NOT NULL,
  `member_id` varchar(50) NOT NULL,
  `apply_date` datetime NOT NULL,
  PRIMARY KEY (`volunteer_apply_id`),
  KEY `FK_volunteer_apply_member` (`member_id`),
  KEY `volunteer_recruit_id` (`volunteer_recruit_id`),
  CONSTRAINT `FK_volunteer_apply_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `FK_volunteer_apply_volunteer_recruit` FOREIGN KEY (`volunteer_recruit_id`) REFERENCES `volunteer_recruit` (`volunteer_recruit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='일반봉사 지원';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.volunteer_category 구조 내보내기
CREATE TABLE IF NOT EXISTS `volunteer_category` (
  `volunteer_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `volunteer_category_name` varchar(50) NOT NULL,
  PRIMARY KEY (`volunteer_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.volunteer_check 구조 내보내기
CREATE TABLE IF NOT EXISTS `volunteer_check` (
  `volunteer_apply_id` int(11) NOT NULL,
  `staff_id_check` varchar(50) NOT NULL,
  `check_date` datetime NOT NULL,
  PRIMARY KEY (`volunteer_apply_id`,`staff_id_check`),
  KEY `FK_volunteer_check_staff` (`staff_id_check`),
  CONSTRAINT `FK_volunteer_check_staff` FOREIGN KEY (`staff_id_check`) REFERENCES `staff` (`staff_id`),
  CONSTRAINT `FK_volunteer_check_volunteer_apply` FOREIGN KEY (`volunteer_apply_id`) REFERENCES `volunteer_apply` (`volunteer_apply_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='일반봉사확인';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 obo.volunteer_recruit 구조 내보내기
CREATE TABLE IF NOT EXISTS `volunteer_recruit` (
  `volunteer_recruit_id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` varchar(50) NOT NULL,
  `volunteer_category_id` int(11) NOT NULL,
  `volunteer_date` datetime NOT NULL,
  `recruit_count` int(11) NOT NULL COMMENT '모집인원',
  `register_date` datetime NOT NULL,
  `volunteer_title` varchar(50) NOT NULL,
  PRIMARY KEY (`volunteer_recruit_id`),
  KEY `FK_volunteer_recruit_staff` (`staff_id`),
  KEY `FK_volunteer_recruit_volunteer_category` (`volunteer_category_id`),
  CONSTRAINT `FK_volunteer_recruit_staff` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`),
  CONSTRAINT `FK_volunteer_recruit_volunteer_category` FOREIGN KEY (`volunteer_category_id`) REFERENCES `volunteer_category` (`volunteer_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='일반봉사모집';

-- 내보낼 데이터가 선택되어 있지 않습니다.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
