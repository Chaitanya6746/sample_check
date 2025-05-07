<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Campus Placement Tracker - Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --success: #4cc9f0;
            --info: #4895ef;
            --warning: #f72585;
            --danger: #e63946;
            --light: #f8f9fa;
            --dark: #212529;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background-color: #f5f7fb;
            overflow-x: hidden;
            min-height: 100vh;
        }
        
        /* Sidebar Styles */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 250px;
            background: linear-gradient(180deg, var(--primary), var(--secondary));
            color: white;
            padding: 1.5rem 1rem;
            transition: all 0.3s ease;
            z-index: 1000;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        }
        
        .sidebar.collapsed {
            width: 70px;
        }
        
        .sidebar-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 2rem;
        }
        
        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            overflow: hidden;
        }
        
        .logo i {
            font-size: 1.8rem;
        }
        
        .logo-text {
            font-size: 1.2rem;
            font-weight: 600;
            white-space: nowrap;
        }
        
        .toggle-btn {
            cursor: pointer;
            font-size: 1.2rem;
            transition: all 0.3s ease;
        }
        
        .sidebar-menu {
            margin-top: 2rem;
            overflow: hidden;
        }
        
        .menu-label {
            text-transform: uppercase;
            font-size: 0.7rem;
            letter-spacing: 1px;
            margin: 1.5rem 0 0.5rem;
            opacity: 0.8;
            white-space: nowrap;
        }
        
        .sidebar.collapsed .menu-label {
            display: none;
        }
        
        .menu-item {
            display: flex;
            align-items: center;
            padding: 0.7rem;
            border-radius: 5px;
            margin: 0.3rem 0;
            cursor: pointer;
            transition: all 0.3s ease;
            white-space: nowrap;
        }
        
        .menu-item:hover, .menu-item.active {
            background-color: rgba(255, 255, 255, 0.1);
        }
        
        .menu-item i {
            font-size: 1.2rem;
            min-width: 30px;
            margin-right: 10px;
        }
        
        .sidebar.collapsed .menu-item span {
            display: none;
        }
        
        /* Main Content Styles */
        .main-content {
            margin-left: 250px;
            padding: 2rem;
            transition: all 0.3s ease;
            min-height: 100vh;
        }
        
        .main-content.expanded {
            margin-left: 70px;
        }
        
        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }
        
        .search-bar {
            display: flex;
            align-items: center;
            background-color: white;
            border-radius: 50px;
            padding: 0.5rem 1rem;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            width: 300px;
        }
        
        .search-bar i {
            color: #6c757d;
            margin-right: 10px;
        }
        
        .search-bar input {
            border: none;
            outline: none;
            background: transparent;
            width: 100%;
            font-size: 0.9rem;
        }
        
        .user-profile {
            display: flex;
            align-items: center;
            gap: 15px;
            cursor: pointer;
            position: relative;
        }
        
        .notifications {
            position: relative;
            margin-right: 20px;
            cursor: pointer;
        }
        
        .notifications i {
            font-size: 1.2rem;
            color: #6c757d;
        }
        
        .notification-count {
            position: absolute;
            top: -5px;
            right: -5px;
            background-color: var(--danger);
            color: white;
            font-size: 0.7rem;
            width: 18px;
            height: 18px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 1.2rem;
        }
        
        .user-info {
            display: flex;
            flex-direction: column;
        }
        
        .user-name {
            font-weight: 600;
            font-size: 0.9rem;
        }
        
        .user-role {
            font-size: 0.8rem;
            color: #6c757d;
        }
        
        .profile-dropdown {
            position: absolute;
            top: 100%;
            right: 0;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            width: 200px;
            padding: 1rem;
            margin-top: 10px;
            z-index: 1000;
            display: none;
        }
        
        .profile-dropdown.show {
            display: block;
            animation: fadeIn 0.3s ease;
        }
        
        .profile-dropdown-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 0.7rem;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .profile-dropdown-item:hover {
            background-color: #f5f7fb;
        }
        
        .profile-dropdown-item i {
            color: var(--primary);
            font-size: 1rem;
        }
        
        /* Dashboard Cards */
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .card {
            background-color: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        
        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            animation: gradientShift 3s infinite linear;
        }
        
        .card:nth-child(2)::before {
            background: linear-gradient(90deg, var(--info), var(--success));
        }
        
        .card:nth-child(3)::before {
            background: linear-gradient(90deg, var(--warning), var(--danger));
        }
        
        .card:nth-child(4)::before {
            background: linear-gradient(90deg, var(--success), var(--info));
        }
        
        .card-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 50px;
            height: 50px;
            border-radius: 12px;
            margin-bottom: 1rem;
            background-color: rgba(67, 97, 238, 0.1);
            color: var(--primary);
            font-size: 1.5rem;
        }
        
        .card:nth-child(2) .card-icon {
            background-color: rgba(72, 149, 239, 0.1);
            color: var(--info);
        }
        
        .card:nth-child(3) .card-icon {
            background-color: rgba(247, 37, 133, 0.1);
            color: var(--warning);
        }
        
        .card:nth-child(4) .card-icon {
            background-color: rgba(76, 201, 240, 0.1);
            color: var(--success);
        }
        
        .card-title {
            font-size: 0.9rem;
            color: #6c757d;
            margin-bottom: 0.3rem;
        }
        
        .card-value {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        
        .card-trend {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 0.8rem;
        }
        
        .trend-up {
            color: var(--success);
        }
        
        .trend-down {
            color: var(--danger);
        }
        
        /* Charts Section */
        .charts-section {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .chart-container {
            background-color: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }
        
        .section-title {
            font-size: 1.2rem;
            font-weight: 600;
        }
        
        .section-actions {
            display: flex;
            gap: 10px;
        }
        
        .action-btn {
            background-color: transparent;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 0.3rem 0.8rem;
            font-size: 0.8rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .action-btn:hover {
            background-color: var(--primary);
            color: white;
            border-color: var(--primary);
        }
        
        .chart-placeholder {
            width: 100%;
            height: 300px;
            background-color: #f5f7fb;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            color: #6c757d;
        }
        
        /* Table Section */
        .table-section {
            background-color: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-bottom: 2rem;
        }
        
        .placement-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }
        
        .placement-table th, .placement-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        .placement-table th {
            font-weight: 600;
            color: #6c757d;
        }
        
        .status {
            display: inline-block;
            padding: 0.3rem 0.8rem;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 500;
        }
        
        .status-applied {
            background-color: rgba(72, 149, 239, 0.1);
            color: var(--info);
        }
        
        .status-interview {
            background-color: rgba(76, 201, 240, 0.1);
            color: var(--success);
        }
        
        .status-offer {
            background-color: rgba(67, 97, 238, 0.1);
            color: var(--primary);
        }
        
        .status-rejected {
            background-color: rgba(247, 37, 133, 0.1);
            color: var(--warning);
        }
        
        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        .animate-fade-in {
            animation: fadeIn 0.5s ease forwards;
        }
        
        .animate-pulse {
            animation: pulse 2s infinite;
        }
        
        /* Responsive Styles */
        @media (max-width: 1200px) {
            .charts-section {
                grid-template-columns: 1fr;
            }
        }
        
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
            }
            
            .sidebar.show {
                transform: translateX(0);
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .dashboard-cards {
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            }
            
            .search-bar {
                width: 200px;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <div class="logo">
                <i class="fas fa-graduation-cap"></i>
                <span class="logo-text">PlacementTracker</span>
            </div>
            <div class="toggle-btn" id="toggleSidebar">
                <i class="fas fa-bars"></i>
            </div>
        </div>
        
        <div class="sidebar-menu">
            <div class="menu-label">Main</div>
            <div class="menu-item active">
                <i class="fas fa-th-large"></i>
                <span>Dashboard</span>
            </div>
            <div class="menu-item">
                <i class="fas fa-briefcase"></i>
                <span>Companies</span>
            </div>
            <div class="menu-item">
                <i class="fas fa-calendar-alt"></i>
                <span>Placement Drives</span>
            </div>
            <div class="menu-item">
                <i class="fas fa-file-alt"></i>
                <span>Applications</span>
            </div>
            
            <div class="menu-label">Admin</div>
            <div class="menu-item">
                <i class="fas fa-university"></i>
                <span>Colleges</span>
            </div>
            <div class="menu-item">
                <i class="fas fa-users"></i>
                <span>Students</span>
            </div>
            <div class="menu-item">
                <i class="fas fa-clipboard-check"></i>
                <span>Screening</span>
            </div>
            <div class="menu-item">
                <i class="fas fa-boxes"></i>
                <span>Resources</span>
            </div>
            
            <div class="menu-label">Reports</div>
            <div class="menu-item">
                <i class="fas fa-chart-bar"></i>
                <span>Analytics</span>
            </div>
            <div class="menu-item">
                <i class="fas fa-file-download"></i>
                <span>Reports</span>
            </div>
        </div>
    </div>
    
    <!-- Main Content -->
    <div class="main-content" id="mainContent">
        <div class="topbar">
            <div class="search-bar">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Search...">
            </div>
            
            <div class="user-actions">
                <div class="notifications">
                    <i class="fas fa-bell"></i>
                    <div class="notification-count">3</div>
                </div>
                
                <div class="user-profile" id="userProfile">
                    <div class="avatar">J</div>
                    <div class="user-info">
                        <div class="user-name">John Doe</div>
                        <div class="user-role">Admin</div>
                    </div>
                    <i class="fas fa-chevron-down"></i>
                    
                    <div class="profile-dropdown" id="profileDropdown">
                        <div class="profile-dropdown-item">
                            <i class="fas fa-user"></i>
                            <span>My Profile</span>
                        </div>
                        <div class="profile-dropdown-item">
                            <i class="fas fa-cog"></i>
                            <span>Settings</span>
                        </div>
                        <div class="profile-dropdown-item">
                            <i class="fas fa-question-circle"></i>
                            <span>Help</span>
                        </div>
                        <div class="profile-dropdown-item">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Logout</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Dashboard Cards -->
        <div class="dashboard-cards">
            <div class="card animate-fade-in" style="animation-delay: 0.1s">
                <div class="card-icon">
                    <i class="fas fa-calendar-alt"></i>
                </div>
                <div class="card-title">Upcoming Drives</div>
                <div class="card-value">12</div>
                <div class="card-trend trend-up">
                    <i class="fas fa-arrow-up"></i>
                    <span>4 more than last month</span>
                </div>
            </div>
            
            <div class="card animate-fade-in" style="animation-delay: 0.2s">
                <div class="card-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="card-title">Attended Drives</div>
                <div class="card-value">8</div>
                <div class="card-trend trend-up">
                    <i class="fas fa-arrow-up"></i>
                    <span>2 more than last month</span>
                </div>
            </div>
            
            <div class="card animate-fade-in" style="animation-delay: 0.3s">
                <div class="card-icon">
                    <i class="fas fa-briefcase"></i>
                </div>
                <div class="card-title">Job Offers</div>
                <div class="card-value">5</div>
                <div class="card-trend trend-up">
                    <i class="fas fa-arrow-up"></i>
                    <span>3 more than last month</span>
                </div>
            </div>
            
            <div class="card animate-fade-in" style="animation-delay: 0.4s">
                <div class="card-icon">
                    <i class="fas fa-building"></i>
                </div>
                <div class="card-title">Registered Companies</div>
                <div class="card-value">24</div>
                <div class="card-trend trend-up">
                    <i class="fas fa-arrow-up"></i>
                    <span>7 more than last month</span>
                </div>
            </div>
        </div>
        
        <!-- Charts Section -->
        <div class="charts-section">
            <div class="chart-container animate-fade-in" style="animation-delay: 0.5s">
                <div class="section-header">
                    <div class="section-title">Placement Statistics</div>
                    <div class="section-actions">
                        <button class="action-btn">Weekly</button>
                        <button class="action-btn">Monthly</button>
                        <button class="action-btn">Yearly</button>
                    </div>
                </div>
                <div class="chart-placeholder">
                    <i class="fas fa-chart-bar"></i> Placement Success Rates by Company
                </div>
            </div>
            
            <div class="chart-container animate-fade-in" style="animation-delay: 0.6s">
                <div class="section-header">
                    <div class="section-title">Branch Distribution</div>
                </div>
                <div class="chart-placeholder">
                    <i class="fas fa-chart-pie"></i> Placement Distribution by Branch
                </div>
            </div>
        </div>
        
        <!-- Recent Applications Table -->
        <div class="table-section animate-fade-in" style="animation-delay: 0.7s">
            <div class="section-header">
                <div class="section-title">Recent Applications</div>
                <div class="section-actions">
                    <button class="action-btn">View All</button>
                </div>
            </div>
            
            <table class="placement-table">
                <thead>
                    <tr>
                        <th>Student</th>
                        <th>Company</th>
                        <th>Role</th>
                        <th>Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>John Doe</td>
                        <td>Google</td>
                        <td>Software Engineer</td>
                        <td>May 5, 2025</td>
                        <td><span class="status status-interview">Interview</span></td>
                    </tr>
                    <tr>
                        <td>Jane Smith</td>
                        <td>Microsoft</td>
                        <td>UX Designer</td>
                        <td>May 4, 2025</td>
                        <td><span class="status status-offer">Offer</span></td>
                    </tr>
                    <tr>
                        <td>Bob Johnson</td>
                        <td>Amazon</td>
                        <td>Product Manager</td>
                        <td>May 3, 2025</td>
                        <td><span class="status status-applied">Applied</span></td>
                    </tr>
                    <tr>
                        <td>Alice Williams</td>
                        <td>Meta</td>
                        <td>Data Analyst</td>
                        <td>May 2, 2025</td>
                        <td><span class="status status-rejected">Rejected</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    
    <script>
        // Toggle Sidebar
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('mainContent');
        const toggleSidebar = document.getElementById('toggleSidebar');
        
        toggleSidebar.addEventListener('click', () => {
            sidebar.classList.toggle('collapsed');
            mainContent.classList.toggle('expanded');
        });
        
        // Toggle Profile Dropdown
        const userProfile = document.getElementById('userProfile');
        const profileDropdown = document.getElementById('profileDropdown');
        
        userProfile.addEventListener('click', (e) => {
            e.stopPropagation();
            profileDropdown.classList.toggle('show');
        });
        
        document.addEventListener('click', (e) => {
            if (profileDropdown.classList.contains('show') && !userProfile.contains(e.target)) {
                profileDropdown.classList.remove('show');
            }
        });
        
        // For mobile view
        const menuItems = document.querySelectorAll('.menu-item');
        menuItems.forEach(item => {
            item.addEventListener('click', () => {
                menuItems.forEach(i => i.classList.remove('active'));
                item.classList.add('active');
                
                if (window.innerWidth <= 768) {
                    sidebar.classList.remove('show');
                }
            });
        });
    </script>
</body>
</html>
