package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.LoanApplication;

public class LoanDAO {

    public int insertLoanApplication(LoanApplication loan) {
        String query = "INSERT INTO los_table (first_name, last_name, email, phone, dob, aadhar, pan, loan_type, amount, duration, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Pending')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, loan.getFirstName());
            ps.setString(2, loan.getLastName());
            ps.setString(3, loan.getEmail());
            ps.setString(4, loan.getPhone());
            ps.setString(5, loan.getDob());
            ps.setString(6, loan.getAadhar());
            ps.setString(7, loan.getPan());
            ps.setString(8, loan.getLoanType());
            ps.setDouble(9, loan.getAmount());
            ps.setInt(10, loan.getDuration());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<LoanApplication> getPendingLoans() {
        List<LoanApplication> loans = new ArrayList<>();
        String query = "SELECT * FROM los_table WHERE status = 'Pending'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                LoanApplication loan = new LoanApplication();
                loan.setAppId(rs.getInt("app_id"));
                loan.setFirstName(rs.getString("first_name"));
                loan.setLastName(rs.getString("last_name"));
                loan.setLoanType(rs.getString("loan_type"));
                loan.setAmount(rs.getDouble("amount"));
                loan.setDuration(rs.getInt("duration"));
                loan.setStatus(rs.getString("status"));
                loans.add(loan);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return loans;
    }

    public List<LoanApplication> getApprovedLoans() {
        List<LoanApplication> loans = new ArrayList<>();
        String query = "SELECT * FROM los_table WHERE status = 'Approved'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                LoanApplication loan = new LoanApplication();
                loan.setAppId(rs.getInt("app_id"));
                loan.setFirstName(rs.getString("first_name"));
                loan.setLastName(rs.getString("last_name"));
                loan.setLoanType(rs.getString("loan_type"));
                loan.setAmount(rs.getDouble("amount"));
                loan.setDuration(rs.getInt("duration"));
                loan.setStatus(rs.getString("status"));
                loans.add(loan);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return loans;
    }

    public void updateStatus(int appId, String status) {
        String query = "UPDATE los_table SET status = ? WHERE app_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, status);
            ps.setInt(2, appId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
