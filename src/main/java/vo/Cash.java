package vo;

public class Cash {
	private int cashNo;
	private String email; // Foreign Key 외래키
	private String cashDate;
	private String kind;
	private String memo;
	private String updatedate;
	private String createdate;
	private int money;
	
	public Cash() {
		super();
	}
	
	public int getCashNo() {
		return cashNo;
	}
	public String getEmail() {
		return email;
	}
	public String getCashDate() {
		return cashDate;
	}
	public String getKind() {
		return kind;
	}
	public String getMemo() {
		return memo;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public String getCreatedate() {
		return createdate;
	}
	public int getMoney() {
		return money;
	}
	public void setCashNo(int cashNo) {
		this.cashNo = cashNo;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setCashDate(String cashDate) {
		this.cashDate = cashDate;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public void setMoney(int money) {
		this.money = money;
	}

	@Override
	public String toString() {
		return "Cash [cashNo=" + cashNo + ", email=" + email + ", cashDate=" + cashDate + ", kind=" + kind + ", memo="
				+ memo + ", updatedate=" + updatedate + ", createdate=" + createdate + ", money=" + money + "]";
	}
	
}
