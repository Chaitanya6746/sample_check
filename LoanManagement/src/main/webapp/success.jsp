<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Application Submitted</title>
    <link rel="stylesheet" href="css/style.css">
    <script>
        window.onload = function () {
            let appId = "<%= request.getAttribute("applicationId") %>";
            let status = "<%= request.getAttribute("status") %>";
            document.getElementById("appId").innerText = appId;
            document.getElementById("status").innerText = status;
            document.getElementById("successModal").style.display = "flex";
        }
        function closeModal() {
            document.getElementById("successModal").style.display = "none";
            window.location.href = "index.jsp";
        }
    </script>
</head>
<body>
<div class="modal-backdrop" id="successModal" style="display: none;">
  <div class="modal">
    <h3>Application Submitted!</h3>
    <p>Application ID: <span id="appId"></span></p>
    <p>Status: <span id="status"></span></p>
    <button onclick="closeModal()">OK</button>
  </div>
</div>

</body>
</html>
