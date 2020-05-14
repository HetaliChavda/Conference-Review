import java.io.Console;
import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Locale;

public class PaperReviewDriver {

	//JDBC Driver Name and Database URL
	private String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	private String DB_URL = "jdbc:mysql://localhost/conference_review?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
	
	//Database Credentials
	private String USERNAME = "root";
	private String PASSWORD = "root";
	
	private Connection conn;
	
	public void connect() {
		try {
			conn = DriverManager.getConnection(DB_URL,USERNAME,PASSWORD);
			System.out.println("-----------------------------------------");
			System.out.println("Database Connected.");
			System.out.println("-----------------------------------------");
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void disconnect() {
		try {
			conn.close();
			System.out.println("-----------------------------------------");
			System.out.println("Database Connection Closed.");
			System.out.println("-----------------------------------------");
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public void getSubmittedPaperDetailsByAuthorId() {
		Statement stmt = null;
		
		try {
			System.out.println("-----------------------------------------");
			System.out.println("QUERY 1:\nResult of submitted paper details by author's primary key i.e. by author.id");
			System.out.println("-----------------------------------------");
			stmt = conn.createStatement();
			String query = "SELECT p.id AS PaperID, p.title AS PaperTitle, p.abstract AS PaperAbstract, a.email_address AS AuthorEmail, a.first_name AS AuthorFirstName, a.last_name AS AuthorLastName\n" + 
					"FROM author_paper ap\n" + 
					"INNER JOIN author a on a.id = ap.author_id\n" + 
					"INNER JOIN paper p on p.id = ap.paper_id\n" + 
					"WHERE a.status = 1 AND p.status = 1\n" +
					"ORDER BY a.id ASC";
			
			ResultSet rs = stmt.executeQuery(query);
			
			if (!rs.next()) {
				System.out.println("No data found for Submitted Papers.");
				System.out.println("\n-----------------------------------------\n");
			} else {
				while (rs.next()) {
					int paperId = rs.getInt("PaperID");
					String paperTitle = rs.getString("PaperTitle");
					String paperAbstract = rs.getString("PaperAbstract");
					String authorEmail = rs.getString("AuthorEmail");
					String authorFirstName = rs.getString("AuthorFirstName");
					String authorLastName = rs.getString("AuthorLastName");
					
					System.out.println("Paper ID: " + paperId);
					System.out.println("Paper Title: " + paperTitle);
					System.out.println("Paper Abstract: " + paperAbstract);
					System.out.println("Author Email: " + authorEmail);
					System.out.println("Author First Name: " + authorFirstName);
					System.out.println("Author Last Name: " + authorLastName);
					System.out.println("\n-----------------------------------------\n");
				}
			}
			
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			// TODO: handle finally clause
			try {
				if(stmt != null)
					stmt.close();
			} catch (SQLException e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}
	}
	
	public static String dateFormater(String dateFromDB, String expectedFormat, String oldFormat) {
	    SimpleDateFormat dateFormat = new SimpleDateFormat(oldFormat);
	    java.util.Date date = null;
	    String convertedDate = null;
	    try {
	        date = dateFormat.parse(dateFromDB);
	        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(expectedFormat);
	        convertedDate = simpleDateFormat.format(date);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return convertedDate;
	}
	
	public void getAllRecommendedPaperReviews() {
		Statement stmt = null;
		
		try {
			System.out.println("-----------------------------------------");
			System.out.println("QUERY 2:\nResult of all reviews of papers which are recommended to be published.");
			System.out.println("-----------------------------------------");
			stmt = conn.createStatement();
			String query = "SELECT review.* FROM review\n" + 
					"INNER JOIN paper ON paper.id = review.paper_id\n" + 
					"WHERE review.recommendation LIKE '%I recommend%' AND review.status = 1 AND paper.status = 1\n" + 
					"ORDER BY paper.id ASC";
			
			ResultSet rs = stmt.executeQuery(query);
			
			if (!rs.next()) {
				System.out.println("No data found for papers which are recommended to be published.");
				System.out.println("\n-----------------------------------------\n");
			} else {
				
				
				DateFormat format = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss", Locale.ENGLISH);
				
				while (rs.next()) {
					int id = rs.getInt("id");
					int paperId = rs.getInt("paper_id");
					int reviewerId = rs.getInt("reviewer_id");
					String recommendation = rs.getString("recommendation");
					String authorComments = rs.getString("author_comments");
					String committeeComments = rs.getString("committee_comments");
					String technicalMeritScore = rs.getString("technical_merit_score");
					String originalityScore = rs.getString("originality_score");
					String readabilityScore = rs.getString("readability_score");
					String relevanceScore = rs.getString("relevance_score");
					String status = (rs.getInt("Status") == 1) ? "Active" : "Inactive";
					String createdAt = dateFormater(rs.getString("created_at"), "MM/dd/yyyy HH:mm:ss", "YYYY-MM-DD HH:MM:SS");
					String updatedAt = dateFormater(rs.getString("updated_at"), "MM/dd/yyyy HH:mm:ss", "YYYY-MM-DD HH:MM:SS");
					
					System.out.println("ID: " + id);
					System.out.println("Paper ID: " + paperId);
					System.out.println("Reviewer ID: " + reviewerId);
					System.out.println("Recommendation: " + recommendation);
					System.out.println("Author Comments: " + authorComments);
					System.out.println("Committee Comments: " + committeeComments);
					System.out.println("Committee Comments: " + technicalMeritScore);
					System.out.println("Committee Comments: " + originalityScore);
					System.out.println("Committee Comments: " + readabilityScore);
					System.out.println("Committee Comments: " + relevanceScore);
					System.out.println("Status: " + status);
					System.out.println("Created At: " + createdAt);
					System.out.println("Updated At: " + updatedAt);
					System.out.println("\n-----------------------------------------\n");
				}
			}
			
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			// TODO: handle finally clause
			try {
				if(stmt != null)
					stmt.close();
			} catch (SQLException e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}
	}
	
	public void getCountOfSubmittedPapers() {
		Statement stmt = null;
		
		try {
			System.out.println("-----------------------------------------");
			System.out.println("QUERY 3:\nCount of total papers that are submitted.");
			System.out.println("-----------------------------------------");
			
			stmt = conn.createStatement();
			String query = "SELECT COUNT(*) AS TOTAL FROM paper";
			
			ResultSet rs = stmt.executeQuery(query);
			
			if (!rs.next()) {
				System.out.println("No data found for Submitted Papers.");
				System.out.println("-----------------------------------------");
			} else {
				System.out.println("Total Submitted Papers: " + rs.getString(1));
				System.out.println("-----------------------------------------");
			}
			
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			// TODO: handle finally clause
			try {
				if(stmt != null)
					stmt.close();
			} catch (SQLException e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}
	}
	
	@SuppressWarnings({ "unused", "null" })
	public void newPaperSubmission(String paperTitle, String paperAbstract, String fileName, String[] authorFirstName, String[] authorLastName, String[] authorEmail) {
		PreparedStatement paperStmt = null;
		PreparedStatement authorStmt = null;
		PreparedStatement authorPaperStmt = null;
		
		int paperID = 0;
		int[] authorID = new int[authorFirstName.length];
		
		try {
			System.out.println("-----------------------------------------");
			System.out.println("QUERY 4:\nCreating record for new Paper Submission");
			System.out.println("-----------------------------------------");
			
			String paperQuery = "INSERT INTO paper(title, abstract, file_name)";
			paperQuery += "VALUES (?,?,?)";
			
			paperStmt = conn.prepareStatement(paperQuery, Statement.RETURN_GENERATED_KEYS);
			paperStmt.setString(1, paperTitle);
			paperStmt.setString(2, paperAbstract);
			paperStmt.setString(3, fileName);
			int insertedPaperRecord = paperStmt.executeUpdate();
			
			if(insertedPaperRecord == 0) {
				throw new SQLException("Creating Paper Record Failed, no rows affected.");
			} else {
				System.out.println("Record for Paper created successfully.");
			}
			
			try (ResultSet rs = paperStmt.getGeneratedKeys()){
				if(rs.next()) {
					paperID = rs.getInt(1);
				} else {
					throw new SQLException("Creating Paper Record Failed, no paper id obtained.");
				}
			} 
			
			String authorQuery = "INSERT INTO author(first_name, last_name, email_address)";
			authorQuery += " VALUES (?,?,?)";
			
			authorStmt = conn.prepareStatement(authorQuery, Statement.RETURN_GENERATED_KEYS);
			
			if(authorFirstName.length == authorLastName.length && authorLastName.length == authorEmail.length) {
				
				for(int i=0; i<authorFirstName.length; i++) {
					authorStmt.setString(1, authorFirstName[i]);
					authorStmt.setString(2, authorLastName[i]);
					authorStmt.setString(3, authorEmail[i]);
					authorStmt.addBatch();
				}
				int[] result = authorStmt.executeBatch();
				
				if(result.length > 0) {
					System.out.println("Record for Author created successfully.");
					int j=0;
					ResultSet rs = authorStmt.getGeneratedKeys();
					while(rs.next()) {
						int authorId = rs.getInt(1);
						authorID[j] = authorId;
						j++;
					}
				} 
			} else {
				System.out.println("Error in inserting data into author tables as length of required array does not match.");
			}
			
			if(authorID.length > 0) {
				String authorPaperQuery = "INSERT INTO author_paper(author_id, paper_id, contact_author_id)";
				authorPaperQuery += " VALUES (?,?,?)";
				
				authorPaperStmt = conn.prepareStatement(authorPaperQuery, Statement.RETURN_GENERATED_KEYS);
				
				for (int a : authorID) {
					authorPaperStmt.setInt(1, a);
					authorPaperStmt.setInt(2, paperID);
					authorPaperStmt.setInt(3, authorID[0]);
					authorPaperStmt.addBatch();
				}
				
				int[] insertedAPCount = authorPaperStmt.executeBatch();
				
				if(insertedAPCount.length == 0) {
					throw new SQLException("Creating Paper Record Failed, no rows affected.");
				} else {
					System.out.println("Record for AuthorPaper created successfully.");
				}
			} 
			
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			// TODO: handle finally clause
			try {
				if(paperStmt != null)
					paperStmt.close();
				if(authorStmt != null)
					authorStmt.close();
			} catch (SQLException e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}
	}
	
	public void deleteAuthorRecord(int authorID) {
		PreparedStatement stmt = null;
		try {
			System.out.println("-----------------------------------------");
			System.out.println("QUERY 5:\nDeleting First Author Row");
			System.out.println("-----------------------------------------");
			
			String query = "DELETE FROM author WHERE author.id = ?";
			
			stmt = conn.prepareStatement(query);
			stmt.setInt(1, authorID);
			int rowsDeleted = stmt.executeUpdate();
			
			if (rowsDeleted > 0) {
				System.out.println("Author deleted successfully.");
			} else { 
				
			}
			
		} catch (SQLException e) {
			// TODO: handle exception
			System.out.println(e.getMessage()+"\n\n");
			System.out.println("Record is not deleted because id attribute of author relation is a foriegn key in author_paper relation.");
			System.out.println("It is because author with provided id exists in author_paper relation.");
		}finally {
			// TODO: handle finally clause
			try {
				if(stmt != null)
					stmt.close();
			} catch (SQLException e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}
	}
	
	public static void main(String[] args) throws SQLException {
		// TODO Auto-generated method stub
		
		PaperReviewDriver demo = new PaperReviewDriver();
		
		String paperTitle = "MRI Bone Segmentation Using Deformable Models and Shape Priors";
		String paperAbstract = "This paper addresses the problem of automatically segmenting bone structures in low resolution clinical MRI datasets. "
				+ "The novel aspect of the proposed method is the combination of physically-based deformable models with shape priors. "
				+ "Models evolve under the influence of forces that exploit image information and prior knowledge on shape variations. "
				+ "The prior defines a Principal Component Analysis (PCA) of global shape variations and a Markov Random Field (MRF) of local deformations, "
				+ "imposing spatial restrictions in shapes evolution. For a better efficiency, various levels of details are considered and "
				+ "the differential equations system is solved by a fast implicit integration scheme.";
		String fileName = "85988-8_15.pdf";
		String[] firstNames = {"Jerome","Nadia"};
		String[] lastNames = {"Schmid", "Thalmann"};
		String[] emails = {"jerome_schmid@gmail.com", "nadia_thalmann@gmail.com"};
		
		demo.connect();
		demo.getSubmittedPaperDetailsByAuthorId();
		demo.getAllRecommendedPaperReviews();
		demo.getCountOfSubmittedPapers();
		demo.newPaperSubmission(paperTitle, paperAbstract, fileName, firstNames, lastNames, emails);
		demo.deleteAuthorRecord(1);
		demo.disconnect();
		
	}

}
