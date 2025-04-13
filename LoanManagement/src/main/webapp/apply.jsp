<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="css/style.css">
    <title>Apply for Loan</title>
</head>
<body>

<!-- Top Navigation Bar -->
<div class="upbar">
    <div class="title">
        <h1 style="margin: 0; font-size: 1.8rem;">Loan Origination System</h1>
    </div>
    <div class="logo">
        <img src="images/anybank-logo.png" alt="AnyBank Logo">
    </div>
</div>

<!-- Loan Application Form -->
<div class="container">
    <h2>Loan Application Form</h2>
    <form action="apply" method="post">
        <input type="text" name="firstName" placeholder="First Name" required>
        <input type="text" name="lastName" placeholder="Last Name" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="text" name="phone" placeholder="Phone" required>
        <input type="date" name="dob" required>
        <input type="text" name="aadhar" placeholder="Aadhar Number" required>
        <input type="text" name="pan" placeholder="PAN Number" required>
        <select name="loanType" required>
            <option value="">Select Loan Type</option>
            <option>Home</option>
            <option>Personal</option>
            <option>Auto</option>
            <option>Gold</option>
            <option>Education</option>
        </select>
        <input type="number" name="amount" placeholder="Loan Amount" required>
        <input type="number" name="duration" placeholder="Duration (Years)" required>
        <button type="submit">Submit</button>
    </form>
</div>

</body>
</html>
