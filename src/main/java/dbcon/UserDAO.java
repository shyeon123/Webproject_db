package dbcon;

import com.JDBC;

import jakarta.servlet.ServletContext;
import dbcon.UserDTO;

public class UserDAO extends JDBC {
	public UserDAO(String drv, String url, String id, String pass) {
		super(drv, url, id, pass);
	}

	public UserDAO(ServletContext application) {
		super(application);
	}

	public UserDTO getUserDTO(String uid, String upass) {
		UserDTO dto = new UserDTO();

		String query = "SELECT * FROM users WHERE id=? AND pass=?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			rs = psmt.executeQuery();

			if (rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setPhone(rs.getString("phone"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

}
