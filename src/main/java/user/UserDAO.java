package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import user.User;
import bbs.Bbs;

public class UserDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public UserDAO() {
        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
            String dbURL = "jdbc:mysql://localhost:3306/BBS";
            String dbID = "root";
            String dbPw = "marisstella";
           
            conn = DriverManager.getConnection(dbURL, dbID, dbPw);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int login(String userID, String userPw) {
        String SQL = "SELECT userPw FROM USER WHERE userID = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID); // 수정: userID 바인딩
            rs = pstmt.executeQuery();
            if (rs.next()) {
                if (rs.getString(1).equals(userPw)) { 
                    return 1; // 로그인 성공
                } else {
                    return 0; // 비밀번호 불일치
                }
            }
            return -1; // 아이디가 없음
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // 데이터 베이스 오류
    }
    
    public int register(User user){
    	String SQL = "INSERT INTO USER VALUES(?,?,?,?,?)";
    	
    	try {
    		pstmt = conn.prepareStatement(SQL);
    		pstmt.setString(1,user.getUserID());
    		pstmt.setString(2,user.getUserPw());
    		pstmt.setString(3,user.getUserEmail());
    		pstmt.setString(4,user.getUserGender());
    		pstmt.setString(5,user.getUserName());
    		return pstmt.executeUpdate();
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    	return -1; // db error 
    }
    
    public User getUserInfo(String userID) {
        String SQL = "SELECT userName, userEmail, userGender, userID FROM USER WHERE userID = ?";
        User user = null;

        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserName(rs.getString("userName"));
                user.setUserEmail(rs.getString("userEmail"));
                user.setUserGender(rs.getString("userGender"));
                user.setUserID(rs.getString("userID"));
            }

            rs.close();
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }



}
