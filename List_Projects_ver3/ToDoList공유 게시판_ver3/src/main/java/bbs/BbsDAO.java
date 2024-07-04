package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/*DAO : 데이터 접근 객체의 약자, 실제로 데이터베이스에 접근을 해서 바로 빼올 수 있게 해주는 역할을 하는 클래스*/

public class BbsDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public BbsDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// BbsDAO class에서는 여러개의 메서드가 사용되기 때문에, 
	// 접근에 마찰이 일어나지 않기 위해 PreparedStatement는 각각 메서드 안에서 초기화
	public String getDate() { //게시판 작성시, 시간을 DB에 넣는 메서드
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
	}
	
	//게시판 작성시, 시간을 DB에 넣는 메서드
	public int getNext() { 
		String SQL = "SELECT bbsID FROM BBS ORDER By bbsID DESC";
		// 게시글 번호는 1부터 늘어나야 되기때문에 새로 생성할 때, 마지막에 쓰인 글을 가져와서 그 번호의 +1을 해야됨
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 게시글이 첫 게시물인 경우
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
    public int write(String bbsTitle, String userID, String bbsContent, String fileName, String bbsCategory) {
        String SQL = "INSERT INTO BBS (bbsID, bbsTitle, userID, bbsDate, bbsContent, bbsAvailable, fileName, bbsCategory) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext());
            pstmt.setString(2, bbsTitle);
            pstmt.setString(3, userID);
            pstmt.setString(4, getDate());
            pstmt.setString(5, bbsContent);
            pstmt.setInt(6, 1);
            if (fileName != null) {
                pstmt.setString(7, fileName);
            } else {
                pstmt.setNull(7, java.sql.Types.VARCHAR);  // uploadFile(fileName)이 null인 경우
            }
            pstmt.setString(8, bbsCategory);
            return pstmt.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public void increaseViewCount(int bbsID) {
        String SQL = "UPDATE BBS SET viewCount = viewCount + 1 WHERE bbsID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public ArrayList<Bbs> getList(int pageNumber) {
        String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
        ArrayList<Bbs> list = new ArrayList<Bbs>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Bbs bbs = new Bbs(); // bbs안에 데이터들을 삽입
                bbs.setBbsID(rs.getInt(1));
                bbs.setBbsTitle(rs.getString(2));
                bbs.setUserID(rs.getString(3));
                bbs.setBbsDate(rs.getString(4));
                bbs.setBbsContent(rs.getString(5));
                bbs.setBbsAvailable(rs.getInt(6));
                bbs.setFileName(rs.getString(7)); // 파일 이름 설정
                bbs.setViewCount(rs.getInt(8)); // 조회수 설정
                bbs.setBbsCategory(rs.getString(9)); // bbsCategory 설정
                list.add(bbs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list; // 데이터베이스 오류
    }
    
    // 페이징 처리 함수
	public boolean nextPage(int pageNumber) { 
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
    public Bbs getBbs(int bbsID) {
        String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                Bbs bbs = new Bbs(); // bbs안에 데이터들을 삽입
                bbs.setBbsID(rs.getInt(1));
                bbs.setBbsTitle(rs.getString(2));
                bbs.setUserID(rs.getString(3));
                bbs.setBbsDate(rs.getString(4));
                bbs.setBbsContent(rs.getString(5));
                bbs.setBbsAvailable(rs.getInt(6));
                bbs.setFileName(rs.getString(7)); // 파일 이름 설정
                bbs.setViewCount(rs.getInt(8)); // 조회수 설정
                bbs.setBbsCategory(rs.getString(9)); // bbsCategory 설정
                return bbs;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
	
	// 특정한 매개변수로 들어온 제목과 내용을 수정하는 함수
    public int update(int bbsID, String bbsTitle, String bbsContent, String fileName, String bbsCategory) {
        String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ?, fileName = ?, bbsCategory = ? WHERE bbsID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, bbsTitle);
            pstmt.setString(2, bbsContent);
            pstmt.setString(3, fileName);
            pstmt.setString(4, bbsCategory);
            pstmt.setInt(5, bbsID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }
	
    // bbsAvailable =0로 하여 글을 삭제하는 함수
	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable =0 WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

    // 총 게시물 수를 반환하는 메서드
    public int getTotalPostCount() {
        String SQL = "SELECT COUNT(*) FROM BBS WHERE bbsAvailable = 1";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }

    // 총 페이지 수를 반환하는 메서드
    public int getTotalPageCount() {
        int totalPostCount = getTotalPostCount();
        int pageSize = 10; // 페이지당 게시물 수
        int totalPageCount = (totalPostCount + pageSize - 1) / pageSize; // 총 페이지 수 계산
        return totalPageCount;
    }
    
    // 검색한 결과의 게시물 수를 반환하는 메서드
    public int getSearchPostCount(String searchType, String searchKeyword, String bbsCategory) {
        String SQL = "";
        if (searchType.equals("title")) {
            SQL = "SELECT COUNT(*) FROM BBS WHERE bbsTitle LIKE ? AND bbsAvailable = 1 AND bbsCategory = ?";
        } else if (searchType.equals("content")) {
            SQL = "SELECT COUNT(*) FROM BBS WHERE bbsContent LIKE ? AND bbsAvailable = 1 AND bbsCategory = ?";
        } else if (searchType.equals("writer")) {
            SQL = "SELECT COUNT(*) FROM BBS WHERE userID LIKE ? AND bbsAvailable = 1 AND bbsCategory = ?";
        }
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, "%" + searchKeyword + "%");
            pstmt.setString(2, bbsCategory);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }
    
    
    public ArrayList<Bbs> searchList(int pageNumber, String searchType, String searchKeyword, String bbsCategory) {
        ArrayList<Bbs> list = new ArrayList<Bbs>();
        String SQL = "";
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            if (searchType.equals("title")) {
                SQL = "SELECT * FROM BBS WHERE bbsTitle LIKE ? AND bbsAvailable = 1 AND bbsCategory = ? ORDER BY bbsID DESC LIMIT ?, 10";
            } else if (searchType.equals("content")) {
                SQL = "SELECT * FROM BBS WHERE bbsContent LIKE ? AND bbsAvailable = 1 AND bbsCategory = ? ORDER BY bbsID DESC LIMIT ?, 10";
            } else if (searchType.equals("writer")) {
                SQL = "SELECT * FROM BBS WHERE userID LIKE ? AND bbsAvailable = 1 AND bbsCategory = ? ORDER BY bbsID DESC LIMIT ?, 10";
            }
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, "%" + searchKeyword + "%");
            pstmt.setString(2, bbsCategory);
            pstmt.setInt(3, (pageNumber - 1) * 10);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Bbs bbs = new Bbs();
                bbs.setBbsID(rs.getInt(1));
                bbs.setBbsTitle(rs.getString(2));
                bbs.setUserID(rs.getString(3));
                bbs.setBbsDate(rs.getString(4));
                bbs.setBbsContent(rs.getString(5));
                bbs.setBbsAvailable(rs.getInt(6));
                bbs.setFileName(rs.getString(7));
                bbs.setViewCount(rs.getInt(8));
                bbs.setBbsCategory(rs.getString(9)); // bbsCategory 설정
                list.add(bbs);
            }
        } catch (SQLException e) { 
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    // 카테고리별 게시물 목록 가져오기
    public ArrayList<Bbs> getListByCategory(String bbsCategory, int pageNumber) {
        String SQL = "SELECT * FROM BBS WHERE bbsCategory = ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT ?, 10";
        ArrayList<Bbs> list = new ArrayList<Bbs>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, bbsCategory);
            pstmt.setInt(2, (pageNumber - 1) * 10);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Bbs bbs = new Bbs();
                bbs.setBbsID(rs.getInt(1));
                bbs.setBbsTitle(rs.getString(2));
                bbs.setUserID(rs.getString(3));
                bbs.setBbsDate(rs.getString(4));
                bbs.setBbsContent(rs.getString(5));
                bbs.setBbsAvailable(rs.getInt(6));
                bbs.setViewCount(rs.getInt(8));
                bbs.setBbsCategory(rs.getString(9));
                list.add(bbs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list; // 데이터베이스 오류
    }

    // 카테고리별 게시물 총 페이지 수 계산
    public int getTotalPageCountByCategory(String bbsCategory) {
        String SQL = "SELECT COUNT(*) FROM BBS WHERE bbsCategory = ? AND bbsAvailable = 1";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, bbsCategory);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return (rs.getInt(1) + 9) / 10; // 총 페이지 수 계산
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }
    
    // 전체 게시판의 게시글을 가져오는 메서드
    public ArrayList<Bbs> getAllList(int pageNumber) {
        String SQL = "SELECT * FROM BBS WHERE bbsAvailable = 1 ORDER BY bbsID DESC LIMIT ?, 10";
        ArrayList<Bbs> list = new ArrayList<Bbs>();
        try {
        	PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, (pageNumber - 1) * 10);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Bbs bbs = new Bbs();
                bbs.setBbsID(rs.getInt(1));
                bbs.setBbsTitle(rs.getString(2));
                bbs.setUserID(rs.getString(3));
                bbs.setBbsDate(rs.getString(4));
                bbs.setBbsContent(rs.getString(5));
                bbs.setBbsAvailable(rs.getInt(6));
                bbs.setViewCount(rs.getInt(8));
                bbs.setBbsCategory(rs.getString(9));
                list.add(bbs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
