package vo;

public class Notice {
	private int noticeNo;
	private String noticeTitle;
	private String noticeContent;
	private String adminId;
	private String updatedate;
	private String createdate;
	
	public Notice() {
		super();
	}
	
	public int getNoticeNo() {
		return noticeNo;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public String getNoticeContent() {
		return noticeContent;
	}
	public String getAdminId() {
		return adminId;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setNoticeNo(int niticeNo) {
		this.noticeNo = niticeNo;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}

	@Override
	public String toString() {
		return "Notice [noticeNo=" + noticeNo + ", noticeTitle=" + noticeTitle + ", noticeContent=" + noticeContent
				+ ", adminId=" + adminId + ", updatedate=" + updatedate + ", createdate=" + createdate + "]";
	}
	
}
