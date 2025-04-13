<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*,model.LoanApplication" %>
<html>
<head>
    <link rel="stylesheet" href="css/style.css">
    <title>Admin Dashboard</title>
</head>
<body>
<div class="container">

    <h2>Pending Loan Applications</h2>
    <table>
        <tr>
            <th>ID</th><th>Name</th><th>Type</th><th>Amount</th><th>Duration</th><th>Action</th>
        </tr>
        <%
            List<LoanApplication> loans = (List<LoanApplication>) request.getAttribute("loans");
            for (LoanApplication loan : loans) {
        %>
        <tr>
            <td><%=loan.getAppId()%></td>
            <td><%=loan.getFirstName()%> <%=loan.getLastName()%></td>
            <td><%=loan.getLoanType()%></td>
            <td><%=loan.getAmount()%></td>
            <td><%=loan.getDuration()%> years</td>
            <td>
                <td>
				     <a href="approve?appId=<%=loan.getAppId()%>"><button class="approve">Approve</button></a>
        			 <a href="reject?appId=<%=loan.getAppId()%>"><button class="reject">Reject</button></a>
				</td>
        </tr>
        <% } %>
    </table>
</div>
</body>
</html>
