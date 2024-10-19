package vo;

public class Admin {
	private String adminId;
	private String adminPw;
	private String createdate;
	public Admin() {
		super();
	}
	public String getAdminId() {
		return adminId;
	}
	public String getAdminPw() {
		return adminPw;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public void setAdminPw(String adminPw) {
		this.adminPw = adminPw;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	@Override
	public String toString() {
		return "Admin [adminId=" + adminId + ", adminPw=" + adminPw + ", createdate=" + createdate + "]";
	}
}
