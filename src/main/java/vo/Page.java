package vo;

public class Page {
	private int currentPage;
	private int rowPerPage;
	
	public Page() {
		super();
	}
	public int getBeginRow() {
		return (this.currentPage-1)*this.rowPerPage;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public int getRowPerPage() {
		return rowPerPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public void setRowPerPage(int rowPerPage) {
		this.rowPerPage = rowPerPage;
	}
	
	@Override
	public String toString() {
		return "Page [currentPage=" + currentPage + ", rowPerPage=" + rowPerPage + "]";
	}
	
}
