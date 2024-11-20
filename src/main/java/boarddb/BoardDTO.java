package boarddb;

public class BoardDTO {
	private String idx;
	private String id;
	private String title;
	private String content;
	private java.sql.Date postdate;
	private String ofile;
	private String sfile;
	private int visitcount;
	private int downcount;
	private String name;
	private int likesCount; // 좋아요 수 추가

	// Getter for likesCount
	public int getLikesCount() {
		return likesCount;
	}

	// Setter for likesCount
	public void setLikesCount(int likesCount) {
		this.likesCount = likesCount;
	}

	public String getIdx() {
		return idx;
	}

	public void setIdx(String idx) {
		this.idx = idx;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public java.sql.Date getPostdate() {
		return postdate;
	}

	public void setPostdate(java.sql.Date postdate) {
		this.postdate = postdate;
	}

	public String getOfile() {
		return ofile;
	}

	public void setOfile(String ofile) {
		this.ofile = ofile;
	}

	public String getSfile() {
		return sfile;
	}

	public void setSfile(String sfile) {
		this.sfile = sfile;
	}

	public int getVisitcount() {
		return visitcount;
	}

	public void setVisitcount(int visitcount) {
		this.visitcount = visitcount;
	}

	public int getDowncount() {
		return downcount;
	}

	public void setDowncount(int downcount) {
		this.downcount = downcount;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
