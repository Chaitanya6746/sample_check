<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Campus Placement Tracker</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        /* Global Styles */
        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --success: #4cc9f0;
            --info: #4895ef;
            --warning: #f72585;
            --danger: #e63946;
            --light: #f8f9fa;
            --dark: #212529;
            --gray: #6c757d;
            --sidebar-width: 280px;
            --header-height: 70px;
            --transition-speed: 0.3s;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: #f5f8ff;
            overflow-x: hidden;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideInLeft {
            from { transform: translateX(-50px); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        @keyframes shimmer {
            0% { background-position: -1000px 0; }
            100% { background-position: 1000px 0; }
        }

        /* Header */
        .header {
            position: fixed;
            top: 0;
            right: 0;
            left: var(--sidebar-width);
            height: var(--header-height);
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 30px;
            z-index: 100;
            transition: all var(--transition-speed);
        }

        .header.sidebar-closed {
            left: 70px;
        }

        .search-bar {
            display: flex;
            align-items: center;
            background-color: #f1f3f9;
            border-radius: 8px;
            padding: 8px 15px;
            width: 300px;
        }

        .search-bar input {
            background: transparent;
            border: none;
            outline: none;
            margin-left: 10px;
            width: 100%;
            color: var(--dark);
        }

        .profile-section {
            display: flex;
            align-items: center;
            gap: 15px;
            cursor: pointer;
        }

        .profile-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 16px;
        }

        .notification-icon {
            position: relative;
            margin-right: 20px;
            cursor: pointer;
        }

        .notification-icon .badge {
            position: absolute;
            top: -8px;
            right: -8px;
            background-color: var(--danger);
            color: white;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            font-size: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            animation: pulse 1.5s infinite;
        }

        /* Sidebar */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
            width: var(--sidebar-width);
            background: linear-gradient(135deg, var(--secondary), var(--primary));
            color: white;
            z-index: 200;
            box-shadow: 3px 0 10px rgba(0, 0, 0, 0.1);
            transition: all var(--transition-speed);
            overflow-y: auto;
        }

        .sidebar.closed {
            width: 70px;
        }

        .logo-container {
            display: flex;
            align-items: center;
            padding: 20px;
            height: var(--header-height);
            background: rgba(255, 255, 255, 0.1);
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: all var(--transition-speed);
            white-space: nowrap;
        }

        .logo i {
            font-size: 28px;
        }

        .sidebar.closed .logo span {
            display: none;
        }

        .toggle-btn {
            position: absolute;
            top: 23px;
            right: -12px;
            width: 24px;
            height: 24px;
            background-color: var(--primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
            z-index: 300;
            transition: all var(--transition-speed);
        }

        .toggle-btn i {
            color: white;
            font-size: 12px;
            transition: all var(--transition-speed);
        }

        .sidebar.closed .toggle-btn i {
            transform: rotate(180deg);
        }

        .menu-container {
            padding: 20px 10px;
        }

        .menu-title {
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: rgba(255, 255, 255, 0.6);
            margin: 15px 0 10px 15px;
            transition: all var(--transition-speed);
            white-space: nowrap;
        }

        .sidebar.closed .menu-title {
            opacity: 0;
        }

        .menu-item {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            margin: 5px 0;
            border-radius: 8px;
            cursor: pointer;
            transition: all var(--transition-speed);
            white-space: nowrap;
        }

        .menu-item:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .menu-item.active {
            background-color: rgba(255, 255, 255, 0.2);
        }

        .menu-item i {
            font-size: 18px;
            width: 30px;
            text-align: center;
        }

        .menu-item span {
            margin-left: 10px;
            transition: all var(--transition-speed);
        }

        .sidebar.closed .menu-item span {
            display: none;
        }

        /* Main Content */
        .main-content {
            margin-left: var(--sidebar-width);
            margin-top: var(--header-height);
            padding: 30px;
            transition: all var(--transition-speed);
        }

        .main-content.sidebar-closed {
            margin-left: 70px;
        }

        .section-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 20px;
            color: var(--dark);
            animation: fadeIn 0.6s ease-out;
        }

        .dashboard-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background-color: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            display: flex;
            flex-direction: column;
            transition: all 0.3s;
            animation: fadeIn 0.6s ease-out;
            position: relative;
            overflow: hidden;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .stat-card .icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
            font-size: 24px;
            color: white;
        }

        .stat-card .icon.blue {
            background-color: var(--primary);
        }

        .stat-card .icon.purple {
            background-color: var(--secondary);
        }

        .stat-card .icon.cyan {
            background-color: var(--success);
        }

        .stat-card .icon.red {
            background-color: var(--danger);
        }

        .stat-card h3 {
            color: var(--gray);
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 10px;
        }

        .stat-card .number {
            font-size: 28px;
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 5px;
        }

        .stat-card .trend {
            font-size: 12px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .trend.up {
            color: #10b981;
        }

        .trend.down {
            color: #ef4444;
        }

        .ripple {
            position: absolute;
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.05);
            right: -30px;
            bottom: -30px;
        }

        /* Charts Section */
        .charts-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 30px;
            animation: fadeIn 0.8s ease-out;
        }

        .chart-card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            padding: 20px;
            height: 340px;
            transition: all 0.3s;
        }

        .chart-card:hover {
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .chart-title {
            font-size: 16px;
            font-weight: 600;
            color: var(--dark);
        }

        .chart-options select {
            border: 1px solid #e2e8f0;
            padding: 5px 10px;
            border-radius: 6px;
            outline: none;
            color: var(--gray);
            font-size: 12px;
        }

        .chart-container {
            height: 250px;
            width: 100%;
            position: relative;
        }

        /* Placement Drives Section */
        .drives-section {
            animation: fadeIn 1s ease-out;
        }

        .tabs {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

        .tab {
            cursor: pointer;
            padding: 10px 0;
            font-size: 14px;
            font-weight: 500;
            color: var(--gray);
            position: relative;
            transition: all 0.3s;
        }

        .tab.active {
            color: var(--primary);
            font-weight: 600;
        }

        .tab::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background-color: var(--primary);
            transition: all 0.3s;
        }

        .tab.active::after {
            width: 100%;
        }

        .drives-list {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            padding: 10px;
            max-height: 400px;
            overflow-y: auto;
        }

        .drive-card {
            border-radius: 8px;
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            transition: all 0.3s;
            cursor: pointer;
            animation: slideInLeft 0.5s ease-out;
            background-color: #f8f9fa;
            position: relative;
            overflow: hidden;
        }

        .drive-card:hover {
            background-color: #f1f3f9;
        }

        .drive-details {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .company-logo {
            width: 50px;
            height: 50px;
            border-radius: 8px;
            background-color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 16px;
            color: var(--primary);
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .drive-info h4 {
            font-size: 16px;
            margin-bottom: 5px;
            color: var(--dark);
        }

        .drive-meta {
            display: flex;
            gap: 15px;
            font-size: 12px;
            color: var(--gray);
        }

        .drive-meta span {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .drive-status {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 13px;
            font-weight: 500;
            padding: 5px 12px;
            border-radius: 6px;
        }

        .status-upcoming {
            background-color: rgba(67, 97, 238, 0.1);
            color: var(--primary);
        }

        .status-ongoing {
            background-color: rgba(76, 201, 240, 0.1);
            color: var(--success);
        }

        .status-completed {
            background-color: rgba(16, 185, 129, 0.1);
            color: #10b981;
        }

        .status-passed {
            background-color: rgba(16, 185, 129, 0.1);
            color: #10b981;
        }

        .status-failed {
            background-color: rgba(239, 68, 68, 0.1);
            color: #ef4444;
        }

        .view-more {
            text-align: center;
            margin-top: 20px;
        }

        .view-more-btn {
            background-color: transparent;
            border: 1px solid var(--primary);
            color: var(--primary);
            padding: 8px 20px;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .view-more-btn:hover {
            background-color: var(--primary);
            color: white;
        }

        /* Drive Details Popup */
        .popup-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.5);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 1000;
            animation: fadeIn 0.3s ease-out;
        }

        .popup-content {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            width: 700px;
            max-width: 90%;
            max-height: 90vh;
            overflow-y: auto;
            animation: fadeIn 0.5s ease-out;
        }

        .popup-header {
            padding: 20px;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .popup-title {
            font-size: 18px;
            font-weight: 600;
            color: var(--dark);
        }

        .close-popup {
            background: none;
            border: none;
            font-size: 20px;
            cursor: pointer;
            color: var(--gray);
        }

        .popup-body {
            padding: 20px;
        }

        .company-header {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
        }

        .company-logo-lg {
            width: 80px;
            height: 80px;
            border-radius: 12px;
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            color: var(--primary);
        }

        .company-info h3 {
            font-size: 22px;
            margin-bottom: 5px;
        }

        .company-meta {
            color: var(--gray);
            font-size: 14px;
            margin-bottom: 10px;
        }

        .eligibility-section, .process-section {
            margin-bottom: 30px;
        }

        .section-label {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 15px;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .eligibility-list {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }

        .eligibility-item {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 14px;
        }

        .eligibility-item i {
            color: var(--success);
        }

        .process-timeline {
            position: relative;
            padding-left: 30px;
        }

        .timeline-line {
            position: absolute;
            left: 7px;
            top: 8px;
            bottom: 8px;
            width: 2px;
            background-color: #e2e8f0;
        }

        .timeline-item {
            position: relative;
            margin-bottom: 25px;
        }

        .timeline-dot {
            position: absolute;
            left: -30px;
            top: 0;
            width: 16px;
            height: 16px;
            border-radius: 50%;
            background-color: white;
            border: 2px solid var(--primary);
            z-index: 1;
        }

        .timeline-dot.active {
            background-color: var(--primary);
        }

        .timeline-content {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
        }

        .timeline-content h5 {
            font-size: 15px;
            margin-bottom: 5px;
            color: var(--dark);
        }

        .timeline-content p {
            font-size: 13px;
            color: var(--gray);
            line-height: 1.5;
        }

        .popup-footer {
            padding: 20px;
            border-top: 1px solid #e2e8f0;
            display: flex;
            justify-content: flex-end;
            gap: 15px;
        }

        .popup-btn {
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-outline {
            background-color: transparent;
            border: 1px solid var(--gray);
            color: var(--gray);
        }

        .btn-outline:hover {
            background-color: #f1f3f9;
        }

        .btn-primary {
            background-color: var(--primary);
            border: none;
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--secondary);
        }

        /* Admin Dashboard Specific Styles */
        .admin-dashboard .icon.orange {
            background-color: #f59e0b;
        }

        .admin-dashboard .icon.green {
            background-color: #10b981;
        }

        .management-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
            animation: fadeIn 0.8s ease-out;
        }

        .management-card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            transition: all 0.3s;
        }

        .management-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            padding: 20px;
            background: linear-gradient(45deg, var(--primary), var(--info));
            color: white;
        }

        .card-header h3 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .card-header p {
            font-size: 13px;
            opacity: 0.8;
        }

        .card-body {
            padding: 20px;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .action-btn {
            padding: 8px 15px;
            border-radius: 6px;
            font-size: 13px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 5px;
            transition: all 0.3s;
            flex: 1;
            justify-content: center;
        }

        .btn-add {
            background-color: rgba(16, 185, 129, 0.1);
            color: #10b981;
            border: 1px solid rgba(16, 185, 129, 0.2);
        }

        .btn-add:hover {
            background-color: rgba(16, 185, 129, 0.2);
        }

        .btn-manage {
            background-color: rgba(67, 97, 238, 0.1);
            color: var(--primary);
            border: 1px solid rgba(67, 97, 238, 0.2);
        }

        .btn-manage:hover {
            background-color: rgba(67, 97, 238, 0.2);
        }

        /* Loading animation */
        .loading-shimmer {
            background: linear-gradient(to right, #f6f7f8 8%, #edeef1 18%, #f6f7f8 33%);
            background-size: 1000px 100%;
            animation: shimmer 2s infinite linear;
        }

        /* Responsive styles */
        @media (max-width: 1024px) {
            .charts-section {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 0;
                transform: translateX(-100%);
            }
            
            .sidebar.closed {
                width: 0;
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .main-content.sidebar-closed {
                margin-left: 0;
            }
            
            .header {
                left: 0;
            }
            
            .header.sidebar-closed {
                left: 0;
            }
            
            .toggle-btn {
                right: auto;
                left: 20px;
            }
            
            .sidebar.closed .toggle-btn {
                left: 20px;
            }
            
            .dashboard-stats {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Student Dashboard -->
    <div class="student-dashboard">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="logo-container">
                <div class="logo">
                    <i class="fas fa-graduation-cap"></i>
                    <span>Placement Tracker</span>
                </div>
                <div class="toggle-btn">
                    <i class="fas fa-chevron-left"></i>
                </div>
            </div>
            <div class="menu-container">
                <div class="menu-title">Main Menu</div>
                <div class="menu-item active">
                    <i class="fas fa-th-large"></i>
                    <span>Dashboard</span>
                </div>
                <div class="menu-item">
                    <i class="fas fa-building"></i>
                    <span>Companies</span>
                </div>
                <div class="menu-item">
                    <i class="fas fa-briefcase"></i>
                    <span>Placement Drives</span>
                </div>
                <div class="menu-item">
                    <i class="fas fa-file-alt"></i>
                    <span>My Applications</span>
                </div>
                <div class="menu-title">Profile</div>
                <div class="menu-item">
                    <i class="fas fa-user"></i>
                    <span>My Profile</span>
                </div>
                <div class="menu-item">
                    <i class="fas fa-file-upload"></i>
                    <span>Resume</span>
                </div>
                <div class="menu-item">
                    <i class="fas fa-cog"></i>
                    <span>Settings</span>
                </div>
                <div class="menu-title">Other</div>
                <div class="menu-item">
                    <i class="fas fa-question-circle"></i>
                    <span>Help & Support</span>
                </div>
                <div class="menu-item">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Logout</span>
                </div>
            </div>
        </div>

        <!-- Header -->
        <div class="header">
            <div class="search-bar">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Search for companies, drives...">
            </div>
            <div class="profile-section">
                <div class="notification-icon">
                    <i class="fas fa-bell"></i>
                    <div class="badge">3</div>
                </div>
                <div class="profile-avatar">JS</div>
                <div class="profile-name">John Smith</div>
                <i class="fas fa-chevron-down"></i>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="section-title">Student Dashboard</div>
            
            <!-- Stats Section -->
            <div class="dashboard-stats">
                <div class="stat-card">
                    <div class="icon blue">
                        <i class="fas fa-briefcase"></i>
                    </div>
                    <h3>Upcoming Drives</h3>
                    <div class="number">12</div>
                    <div class="trend up">
                        <i class="fas fa-arrow-up"></i>
                        <span>23% from last month</span>
                    </div>
                    <div class="ripple"></div>
                </div>
                
                <div class="stat-card">
                    <div class="icon purple">
                        <i class="fas fa-file-alt"></i>
                    </div>
                    <h3>Active Applications</h3>
                    <div class="number">8</div>
                    <div class="trend up">
                        <i class="fas fa-arrow-up"></i>
                        <span>12% from last month</span>
                    </div>
                    <div class="ripple"></div>
                </div>
                
                <div class="stat-card">
                    <div class="icon cyan">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <h3>Interviews Cleared</h3>
                    <div class="number">5</div>
                    <div class="trend up">
                        <i class="fas fa-arrow-up"></i>
                        <span>18% from last month</span>
                    </div>
                    <div class="ripple"></div>
                </div>
                
                <div class="stat-card">
                    <div class="icon red">
                        <i class="fas fa-trophy"></i>
                    </div>
                    <h3>Offers Received</h3>
                    <div class="number">3</div>
                    <div class="trend up">
                        <i class="fas fa-arrow-up"></i>
                        <span>100% from last month</span>
                    </div>
                    <div class="ripple"></div>
                </div>
            </div>
            
            <!-- Charts Section -->
            <div class="charts-section">
                <div class="chart-card">
                    <div class="chart-header">
                        <div class="chart-title">Placement Success Rate</div>
                        <div class="chart-options">
                            <select>
                                <option>This Year</option>
                                <option>Last Year</option>
                                <option>All Time</option>
                            </select>
                        </div>
                    </div>
                    <div class="chart-container">
                        <canvas id="successRateChart"></canvas>
                    </div>
                </div>
                
                <div class="chart-card">
                    <div class="chart-header">
                        <div class="chart-title">Application Progress</div>
                        <div class="chart-options">
                            <select>
                                <option>All Applications</option>
                                <option>Recent Applications</option>
                            </select>
                        </div>
                    </div>
                    <div class="chart-container">
                        <canvas id="progressChart"></canvas>
                    </div>
                </div>
            </div>
            
            <!-- Placement Drives Section -->
            <div class="drives-section">
                <div class="section-title">Placement Drives</div>
                <div class="tabs">
                    <div class="tab active">Upcoming Drives</div>
                    <div class="tab">Attended Drives</div>
                </div>
                
                <!-- Upcoming Drives -->
                <div class="drives-list">
                    <div class="drive-card" onclick="showDriveDetails()">
                        <div class="drive-details">
                            <div class="company-logo">
                                <i class="fab fa-google"></i>
                            </div>
                            <div class="drive-info">
                                <h4>Google Software Engineer</h4>
                                <div class="drive-meta">
                                    <span><i class="fas fa-calendar"></i> May 15, 2025</span>
                                    <span><i class="fas fa-map-marker-alt"></i> Main Campus</span>
                                    <span><i class="fas fa-users"></i> 120 Applicants</span>
                                </div>
                            </div>
                        </div>
                        <div class="drive-status status-upcoming">Upcoming</div>
                    </div>
                    
                    <div class="drive-card">
                        <div class="drive-details">
                            <div class="company-logo">
                                <i class="fab fa-microsoft"></i>
                            </div>
                            <div class="drive-info">
                                <h4>Microsoft Cloud Developer</h4>
                                <div class="drive-meta">
                                    <span><i class="fas fa-calendar"></i> May 18, 2025</span>
                                    <span><i class="fas fa-map-marker-alt"></i> Tech Block</span>
                                    <span><i class="fas fa-users"></i> 85 Applicants</span>
                                </div>
                            </div>
                        </div>
                        <div class="drive-status status-upcoming">Upcoming</div>
                    </div>
                    
                    <div class="drive-card">
                        <div class="drive-details">
                            <div class="company-logo">
                                <i class="fab fa-amazon"></i>
                            </div>
                            <div class="drive-info">
                                <h4>Amazon SDE Intern</h4>
                                <div class="drive-meta">
                                    <span><i class="fas fa-calendar"></i> May 20, 2025</span>
                                    <span><i class="fas fa-map-marker-alt"></i> Online</span>
                                    <span><i class="fas fa-users"></i> 150 Applicants</span>
                                </div>
                            </div>
                        </div>
                        <div class="drive-status status-upcoming">Upcoming</div>
                    </div>
                    
                    <div class="drive-card">
                        <div class="drive-details">
                            <div class="company-logo">
                                <i class="fab fa-apple"></i>
                            </div>
                            <div class="drive-info">
                                <h4>Apple iOS Developer</h4>
                                <div class="drive-meta">
                                    <span><i class="fas fa-calendar"></i> May 25, 2025</span>
                                    <span><i class="fas fa-map-marker-alt"></i> Main Campus</span>
                                    <span><i class="fas fa-users"></i> 70 Applicants</span>
                                </div>
                            </div>
                        </div>
                        <div class="drive-status status-upcoming">Upcoming</div>
                    </div>
                    
                    <div class="drive-card">
                        <div class="drive-details">
                            <div class="company-logo">
                                <i class="fab fa-salesforce"></i>
                            </div>
                            <div class="drive-info">
                                <h4>Salesforce Admin</h4>
                                <div class="drive-meta">
                                    <span><i class="fas fa-calendar"></i> May 28, 2025</span>
                                    <span><i class="fas fa-map-marker-alt"></i> Tech Block</span>
                                    <span><i class="fas fa-users"></i> 45 Applicants</span>
                                </div>
                            </div>
                        </div>
                        <div class="drive-status status-upcoming">Upcoming</div>
                    </div>
                </div>
                
                <div class="view-more">
                    <button class="view-more-btn">View More</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Drive Details Popup -->
    <div class="popup-overlay" id="driveDetailsPopup">
        <div class="popup-content">
            <div class="popup-header">
                <div class="popup-title">Drive Details</div>
                <button class="close-popup" onclick="closeDriveDetails()">&times;</button>
            </div>
            <div class="popup-body">
                <div class="company-header">
                    <div class="company-logo-lg">
                        <i class="fab fa-google"></i>
                    </div>
                    <div class="company-info">
                        <h3>Google Software Engineer</h3>
                        <div class="company-meta">
                            <p><i class="fas fa-calendar"></i> May 15, 2025 | <i class="fas fa-map-marker-alt"></i> Main Campus</p>
                            <p><i class="fas fa-users"></i> 120 Applicants | <i class="fas fa-clock"></i> Applications close in 5 days</p>
                        </div>
                    </div>
                </div>
                
                <div class="eligibility-section">
                    <div class="section-label">
                        <i class="fas fa-check-circle"></i> Eligibility Criteria
                    </div>
                    <div class="eligibility-list">
                        <div class="eligibility-item">
                            <i class="fas fa-check"></i>
                            <span>Minimum CGPA: 8.0/10</span>
                        </div>
                        <div class="eligibility-item">
                            <i class="fas fa-check"></i>
                            <span>Backlog: None</span>
                        </div>
                        <div class="eligibility-item">
                            <i class="fas fa-check"></i>
                            <span>Branch: CSE, IT, ECE</span>
                        </div>
                        <div class="eligibility-item">
                            <i class="fas fa-check"></i>
                            <span>Batch: 2026</span>
                        </div>
                        <div class="eligibility-item">
                            <i class="fas fa-check"></i>
                            <span>Skills: Java, Python, DSA</span>
                        </div>
                        <div class="eligibility-item">
                            <i class="fas fa-check"></i>
                            <span>Package: 18-22 LPA</span>
                        </div>
                    </div>
                </div>
                
                <div class="process-section">
                    <div class="section-label">
                        <i class="fas fa-sitemap"></i> Selection Process
                    </div>
                    <div class="process-timeline">
                        <div class="timeline-line"></div>
                        
                        <div class="timeline-item">
                            <div class="timeline-dot active"></div>
                            <div class="timeline-content">
                                <h5>Round 1: Online Assessment</h5>
                                <p>90-minute online coding test with DSA problems and multiple-choice questions on computer science fundamentals. Top performers will move to the next round.</p>
                            </div>
                        </div>
                        
                        <div class="timeline-item">
                            <div class="timeline-dot"></div>
                            <div class="timeline-content">
                                <h5>Round 2: Technical Interview</h5>
                                <p>60-minute technical interview focusing on algorithm design, problem-solving, and coding proficiency. Expect questions on data structures, algorithms, and system design.</p>
                            </div>
                        </div>
                        
                        <div class="timeline-item">
                            <div class="timeline-dot"></div>
                            <div class="timeline-content">
                                <h5>Round 3: Team Fit Interview</h5>
                                <p>45-minute interview with potential team members to assess your collaboration skills, technical knowledge, and problem-solving approach in real-world scenarios.</p>
                            </div>
                        </div>
                        
                        <div class="timeline-item">
                            <div class="timeline-dot"></div>
                            <div class="timeline-content">
                                <h5>Round 4: HR Interview</h5>
                                <p>30-minute final interview with HR to discuss your expectations, career goals, and cultural fit with the company.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="popup-footer">
                <button class="popup-btn btn-outline" onclick="closeDriveDetails()">Close</button>
                <button class="popup-btn btn-primary">Apply Now</button>
            </div>
        </div>
    </div>
    
    <!-- Switch to Admin Dashboard Button -->
    <button id="switchDashboard" style="position: fixed; bottom: 20px; right: 20px; z-index: 1000; background-color: var(--primary); color: white; border: none; border-radius: 50%; width: 50px; height: 50px; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 10px rgba(0,0,0,0.2); cursor: pointer;">
        <i class="fas fa-exchange-alt"></i>
    </button>
    
    <!-- Admin Dashboard (Hidden by default) -->
    <div class="admin-dashboard" style="display: none;">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="logo-container">
                <div class="logo">
                    <i class="fas fa-user-shield"></i>
                    <span>Admin Panel</span>
                </div>
                <div class="toggle-btn">
                    <i class="fas fa-chevron-left"></i>
                </div>
            </div>
            <div class="menu-container">
                <div class="menu-title">Main Menu</div>
                <div class="menu-item active">
                    <i class="fas fa-th-large"></i>
                    <span>Dashboard</span>
                </div>
                <div class="menu-item">
                    <i class="fas fa-building"></i>
                    <span>Companies</span>
                </div>
                <div class="menu-item">
                    <i class="fas fa-university"></i>
                    <span>Colleges & Branches</span>
                </div>
                <div class="menu-item">
                    <i class="fas fa-users"></i>
                    <span>Students</span>
                </div>
                <div class="menu-item">
                    <i class="fas fa-briefcase"></i>
                    <span>Placement Drives</span>
                </div>
                <div class="menu-item">
                    <i class="fas fa-clipboard-check"></i>
                    <span>Applications</span>
                </div>
                <div class="menu-title">Reports</div>
                <div class="menu-item">
                    <i class="fas fa-chart-bar"></i>
                    <span>Analytics</span>
                </div>
                <div class="menu-item">
                    <i class="fas fa-file-export"></i>
                    <span>Export Reports</span>
                </div>
                <div class="menu-title">Settings</div>
                <div class="menu-item">
                    <i class="fas fa-cog"></i>
                    <span>System Settings</span>
                </div>
                <div class="menu-item">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Logout</span>
                </div>
            </div>
        </div>

        <!-- Header -->
        <div class="header">
            <div class="search-bar">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Search for companies, students...">
            </div>
            <div class="profile-section">
                <div class="notification-icon">
                    <i class="fas fa-bell"></i>
                    <div class="badge">5</div>
                </div>
                <div class="profile-avatar">AM</div>
                <div class="profile-name">Admin Manager</div>
                <i class="fas fa-chevron-down"></i>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="section-title">Admin Dashboard</div>
            
            <!-- Stats Section -->
            <div class="dashboard-stats">
                <div class="stat-card">
                    <div class="icon blue">
                        <i class="fas fa-building"></i>
                    </div>
                    <h3>Companies</h3>
                    <div class="number">25</div>
                    <div class="trend up">
                        <i class="fas fa-arrow-up"></i>
                        <span>12% from last month</span>
                    </div>
                    <div class="ripple"></div>
                </div>
                
                <div class="stat-card">
                    <div class="icon orange">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3>Students</h3>
                    <div class="number">750</div>
                    <div class="trend up">
                        <i class="fas fa-arrow-up"></i>
                        <span>5% from last month</span>
                    </div>
                    <div class="ripple"></div>
                </div>
                
                <div class="stat-card">
                    <div class="icon green">
                        <i class="fas fa-briefcase"></i>
                    </div>
                    <h3>Active Drives</h3>
                    <div class="number">12</div>
                    <div class="trend up">
                        <i class="fas fa-arrow-up"></i>
                        <span>33% from last month</span>
                    </div>
                    <div class="ripple"></div>
                </div>
                
                <div class="stat-card">
                    <div class="icon purple">
                        <i class="fas fa-clipboard-check"></i>
                    </div>
                    <h3>Placements</h3>
                    <div class="number">152</div>
                    <div class="trend up">
                        <i class="fas fa-arrow-up"></i>
                        <span>15% from last month</span>
                    </div>
                    <div class="ripple"></div>
                </div>
            </div>
            
            <!-- Management Cards -->
            <div class="management-cards">
                <div class="management-card">
                    <div class="card-header">
                        <h3>Company Management</h3>
                        <p>Add and manage companies for placement drives</p>
                    </div>
                    <div class="card-body">
                        <div class="action-buttons">
                            <button class="action-btn btn-add">
                                <i class="fas fa-plus"></i> Add Company
                            </button>
                            <button class="action-btn btn-manage">
                                <i class="fas fa-cog"></i> Manage
                            </button>
                        </div>
                    </div>
                </div>
                
                <div class="management-card">
                    <div class="card-header">
                        <h3>College & Branch</h3>
                        <p>Manage colleges and branches for the system</p>
                    </div>
                    <div class="card-body">
                        <div class="action-buttons">
                            <button class="action-btn btn-add">
                                <i class="fas fa-plus"></i> Add College
                            </button>
                            <button class="action-btn btn-manage">
                                <i class="fas fa-cog"></i> Manage
                            </button>
                        </div>
                    </div>
                </div>
                
                <div class="management-card">
                    <div class="card-header">
                        <h3>Placement Drives</h3>
                        <p>Create and manage placement drive schedules</p>
                    </div>
                    <div class="card-body">
                        <div class="action-buttons">
                            <button class="action-btn btn-add">
                                <i class="fas fa-plus"></i> Add Drive
                            </button>
                            <button class="action-btn btn-manage">
                                <i class="fas fa-cog"></i> Manage
                            </button>
                        </div>
                    </div>
                </div>
                
                <div class="management-card">
                    <div class="card-header">
                        <h3>Student Profiles</h3>
                        <p>Add and manage student information</p>
                    </div>
                    <div class="card-body">
                        <div class="action-buttons">
                            <button class="action-btn btn-add">
                                <i class="fas fa-plus"></i> Add Student
                            </button>
                            <button class="action-btn btn-manage">
                                <i class="fas fa-cog"></i> Manage
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Charts Section -->
            <div class="charts-section">
                <div class="chart-card">
                    <div class="chart-header">
                        <div class="chart-title">Placement Statistics</div>
                        <div class="chart-options">
                            <select>
                                <option>This Year</option>
                                <option>Last Year</option>
                                <option>All Time</option>
                            </select>
                        </div>
                    </div>
                    <div class="chart-container">
                        <canvas id="adminStatsChart"></canvas>
                    </div>
                </div>
                
                <div class="chart-card">
                    <div class="chart-header">
                        <div class="chart-title">Branch-wise Placements</div>
                        <div class="chart-options">
                            <select>
                                <option>All Branches</option>
                                <option>CSE</option>
                                <option>IT</option>
                                <option>ECE</option>
                            </select>
                        </div>
                    </div>
                    <div class="chart-container">
                        <canvas id="branchChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Scripts -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.1/chart.min.js"></script>
    <script>
        // Toggle Sidebar
        document.querySelector('.toggle-btn').addEventListener('click', function() {
            const sidebar = document.querySelector('.sidebar');
            const mainContent = document.querySelector('.main-content');
            const header = document.querySelector('.header');
            
            sidebar.classList.toggle('closed');
            mainContent.classList.toggle('sidebar-closed');
            header.classList.toggle('sidebar-closed');
        });
        
        // Show Drive Details Popup
        function showDriveDetails() {
            document.getElementById('driveDetailsPopup').style.display = 'flex';
        }
        
        // Close Drive Details Popup
        function closeDriveDetails() {
            document.getElementById('driveDetailsPopup').style.display = 'none';
        }
        
        // Switch Between Dashboards
        document.getElementById('switchDashboard').addEventListener('click', function() {
            const studentDashboard = document.querySelector('.student-dashboard');
            const adminDashboard = document.querySelector('.admin-dashboard');
            
            if (studentDashboard.style.display !== 'none') {
                studentDashboard.style.display = 'none';
                adminDashboard.style.display = 'block';
            } else {
                studentDashboard.style.display = 'block';
                adminDashboard.style.display = 'none';
            }
        });
        
        // Initialize Charts
        window.addEventListener('load', function() {
            // Student Dashboard Charts
            const successRateCtx = document.getElementById('successRateChart').getContext('2d');
            const successRateChart = new Chart(successRateCtx, {
                type: 'bar',
                data: {
                    labels: ['Google', 'Microsoft', 'Amazon', 'Apple', 'IBM', 'Oracle'],
                    datasets: [{
                        label: 'Success Rate (%)',
                        data: [85, 70, 65, 80, 60, 75],
                        backgroundColor: [
                            'rgba(67, 97, 238, 0.7)',
                            'rgba(76, 201, 240, 0.7)',
                            'rgba(67, 97, 238, 0.7)',
                            'rgba(76, 201, 240, 0.7)',
                            'rgba(67, 97, 238, 0.7)',
                            'rgba(76, 201, 240, 0.7)'
                        ],
                        borderColor: [
                            'rgba(67, 97, 238, 1)',
                            'rgba(76, 201, 240, 1)',
                            'rgba(67, 97, 238, 1)',
                            'rgba(76, 201, 240, 1)',
                            'rgba(67, 97, 238, 1)',
                            'rgba(76, 201, 240, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            max: 100,
                            ticks: {
                                callback: function(value) {
                                    return value + '%';
                                }
                            }
                        }
                    }
                }
            });
            
            const progressCtx = document.getElementById('progressChart').getContext('2d');
            const progressChart = new Chart(progressCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Applied', 'Screening', 'Interview', 'Selected', 'Rejected'],
                    datasets: [{
                        data: [35, 20, 15, 20, 10],
                        backgroundColor: [
                            'rgba(67, 97, 238, 0.7)',
                            'rgba(76, 201, 240, 0.7)',
                            'rgba(16, 185, 129, 0.7)',
                            'rgba(59, 130, 246, 0.7)',
                            'rgba(239, 68, 68, 0.7)'
                        ],
                        borderColor: [
                            'rgba(67, 97, 238, 1)',
                            'rgba(76, 201, 240, 1)',
                            'rgba(16, 185, 129, 1)',
                            'rgba(59, 130, 246, 1)',
                            'rgba(239, 68, 68, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'right'
                        }
                    }
                }
            });
            
            // Admin Dashboard Charts
            const adminStatsCtx = document.getElementById('adminStatsChart').getContext('2d');
            const adminStatsChart = new Chart(adminStatsCtx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                    datasets: [{
                        label: 'Applications',
                        data: [250, 320, 280, 400, 350, 450],
                        borderColor: 'rgba(67, 97, 238, 1)',
                        backgroundColor: 'rgba(67, 97, 238, 0.1)',
                        tension: 0.4,
                        fill: true
                    },
                    {
                        label: 'Selections',
                        data: [100, 150, 120, 180, 160, 200],
                        borderColor: 'rgba(16, 185, 129, 1)',
                        backgroundColor: 'rgba(16, 185, 129, 0.1)',
                        tension: 0.4,
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
            
            const branchCtx = document.getElementById('branchChart').getContext('2d');
            const branchChart = new Chart(branchCtx, {
                type: 'bar',
                data: {
                    labels: ['CSE', 'IT', 'ECE', 'EEE', 'MECH', 'CIVIL'],
                    datasets: [{
                        label: 'Total Students',
                        data: [150, 120, 100, 80, 70, 60],
                        backgroundColor: 'rgba(67, 97, 238, 0.7)',
                        borderColor: 'rgba(67, 97, 238, 1)',
                        borderWidth: 1
                    },
                    {
                        label: 'Placed Students',
                        data: [120, 85, 60, 40, 30, 20],
                        backgroundColor: 'rgba(16, 185, 129, 0.7)',
                        borderColor: 'rgba(16, 185, 129, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        });
    </script>
</body>
</html>
