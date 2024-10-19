package vo;

public class Comment {
	private int commentNo;
	private int noticeNo; // FK : notice.admin 테이블 참조
	private String commentContent;
	private String commentWriter;
	private String updatedate;
	private String createdate;
	
	public Comment() {
		super();
	}
	public int getCommentNo() {
		return commentNo;
	}
	public int getNoticeNo() {
		return noticeNo;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public String getCommentWriter() {
		return commentWriter;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}
	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	public void setCommentWriter(String commentWriter) {
		this.commentWriter = commentWriter;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	
	@Override
	public String toString() {
		return "Comment [commentNo=" + commentNo + ", noticeNo=" + noticeNo + ", commentContent=" + commentContent
				+ ", commentWriter=" + commentWriter + ", updatedate=" + updatedate + ", createdate=" + createdate
				+ "]";
	}
	
}
