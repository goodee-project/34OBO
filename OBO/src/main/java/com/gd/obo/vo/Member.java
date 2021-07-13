//작성자 : 손영현
package com.gd.obo.vo;

import lombok.Data;


@Data
public class Member {
	private String memberId;
	private int addressId;
	private String memberName;
	private String memberPhone;
	private String memberbirth;
	private String memberEmail;
	private String memberPw;
	private String memberNickname;
	private String memberState;
	private String memberGender;
	private String createDate;
	private String updateDate;
}
