package bbs;

/*
자바빈즈
하나의 게시글의 정보를 담을 수 있는 인스턴스를 만들기 위한 틀
DB의 테이블과 흡사한 구조로 전반적인 게시글 하나를 관리해주는 하나의 자바 프로그램*/
// alt + shift +s -> r : getter setter method 자동완성
public class Bbs {
	private int bbsID;
	private String bbsTitle;
	private String userID;
	private String bbsContent;
	private String bbsDate;
	private int bbsAvailable;
	//private String uploadFile;
	private String fileName; // view에서 보이는 다운로드 링크
	private int viewCount; // 조회수
	private String bbsCategory;
	
	public int getBbsID() {
		return bbsID;
	}
	public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}
	public String getBbsTitle() {
		return bbsTitle;
	}
	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	
	
	public String getBbsContent() { 
		  return bbsContent;
	} 
	public void setBbsContent(String bbsContent) { 
		this.bbsContent = bbsContent; 
	}
	
	public String getBbsDate() {
		return bbsDate;
	}
	
	public void setBbsDate(String bbsDate) {
		this.bbsDate = bbsDate;
	}
	public int getBbsAvailable() {
		return bbsAvailable;
	}
	public void setBbsAvailable(int bbsAvailable) {
		this.bbsAvailable = bbsAvailable;
	}
	
	/*
	 * public String getUploadFile() { return uploadFile; } public void
	 * setUploadFile(String uploadFile) { this.uploadFile = uploadFile; }
	 */
    
    // 파일 이름에 대한 getter와 setter 메서드 추가
    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    
    public int getViewCount() {
        return viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }
    
    public String getBbsCategory() {
        return bbsCategory;
    }

    public void setBbsCategory(String bbsCategory) {
        this.bbsCategory = bbsCategory;
    }
}
