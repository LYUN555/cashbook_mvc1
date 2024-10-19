package vo;

// cashbook.member 테이블
public class Member {

	private String email;
	private String pw;
	private String birth;
	private String updatedate;
	private String createdate;

	public Member() {
		super();
	}
	
	public String getEmail() {
		return email;
	}
	public String getPw() {
		return pw;
	}
	public String getBirth() {
		return birth;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}

	@Override
	public String toString() {
		return "Member [email=" + email + ", pw=" + pw + ", birth=" + birth + ", updatedate=" + updatedate
				+ ", createdate=" + createdate + "]";
	}
	
}
