<%@ page import="java.util.*,model.LoanApplication" %>
<html>
<head><link rel="stylesheet" href="css/style.css"><title>Approved Loans</title></head>
<body>
<div class="container">
    <h2>Approved Loans</h2>
    <table>
        <tr><th>ID</th><th>Name</th><th>Loan Type</th><th>Amount</th><th>Duration</th><th>EMI</th><th>Action</th></tr>
        <%
            List<LoanApplication> loans = (List<LoanApplication>) request.getAttribute("loans");
            for (LoanApplication loan : loans) {
        %>
        <tr>
            <td><%=loan.getAppId()%></td>
            <td><%=loan.getFirstName()%> <%=loan.getLastName()%></td>
            <td><%=loan.getLoanType()%></td>
            <td><%=loan.getAmount()%></td>
            <td><%=loan.getDuration()%></td>
            <td><%=loan.getEmi()%></td>
            <td><a href="paymentDetails?appId=<%=loan.getAppId()%>"><button>View Payments</button></a></td>
        </tr>
        <% } %>
    </table>
</div>
</body>
</html>
