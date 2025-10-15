<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Common Admin Layout Styles -->
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: #f0f2f5;
        overflow-x: hidden;
    }

    /* Sidebar Styles */
    .sidebar {
        position: fixed;
        left: 0;
        top: 0;
        height: 100vh;
        width: 280px;
        background: linear-gradient(180deg, #1e3c72 0%, #2a5298 100%);
        padding: 20px 0;
        transition: all 0.3s ease;
        z-index: 1000;
        box-shadow: 4px 0 15px rgba(0,0,0,0.1);
    }

    .sidebar.collapsed {
        width: 80px;
    }

    .sidebar-header {
        padding: 0 20px 30px;
        border-bottom: 1px solid rgba(255,255,255,0.1);
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .logo {
        display: flex;
        align-items: center;
        gap: 12px;
        color: white;
        text-decoration: none;
        transition: all 0.3s;
        cursor: pointer;
    }

    .logo i {
        font-size: 32px;
        color: #4fc3f7;
    }

    .logo-text {
        display: flex;
        flex-direction: column;
        transition: opacity 0.3s;
    }

    .sidebar.collapsed .logo-text {
        opacity: 0;
        display: none;
    }

    .logo-text h2 {
        font-size: 20px;
        font-weight: 700;
    }

    .logo-text span {
        font-size: 12px;
        opacity: 0.8;
    }

    .toggle-btn {
        background: rgba(255,255,255,0.1);
        border: none;
        color: white;
        width: 35px;
        height: 35px;
        border-radius: 8px;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s;
    }

    .toggle-btn:hover {
        background: rgba(255,255,255,0.2);
    }

    .sidebar-menu {
        margin-top: 30px;
        padding: 0 15px;
    }

    .menu-item {
        display: flex;
        align-items: center;
        gap: 15px;
        padding: 14px 15px;
        color: rgba(255,255,255,0.8);
        text-decoration: none;
        border-radius: 10px;
        margin-bottom: 8px;
        transition: all 0.3s;
        position: relative;
        overflow: hidden;
        cursor: pointer;
    }

    .menu-item:hover {
        background: rgba(255,255,255,0.1);
        color: white;
        transform: translateX(5px);
    }

    .menu-item.active {
        background: rgba(79, 195, 247, 0.2);
        color: white;
    }

    .menu-item.active::before {
        content: '';
        position: absolute;
        left: 0;
        top: 0;
        height: 100%;
        width: 4px;
        background: #4fc3f7;
    }

    .menu-item i {
        font-size: 20px;
        width: 25px;
    }

    .menu-text {
        transition: opacity 0.3s;
    }

    .sidebar.collapsed .menu-text {
        opacity: 0;
        display: none;
    }

    .user-section {
        position: absolute;
        bottom: 20px;
        left: 15px;
        right: 15px;
        padding: 15px;
        background: rgba(255,255,255,0.1);
        border-radius: 12px;
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .user-avatar {
        width: 45px;
        height: 45px;
        border-radius: 50%;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 20px;
        font-weight: 600;
        flex-shrink: 0;
    }

    .user-info {
        flex: 1;
        transition: opacity 0.3s;
    }

    .sidebar.collapsed .user-info {
        opacity: 0;
        display: none;
    }

    .user-info .name {
        color: white;
        font-weight: 600;
        font-size: 14px;
        display: block;
        margin-bottom: 2px;
    }

    .user-info .role {
        color: rgba(255,255,255,0.7);
        font-size: 12px;
    }

    /* Main Content */
    .main-content {
        margin-left: 280px;
        padding: 30px;
        transition: all 0.3s ease;
        min-height: 100vh;
        opacity: 1;
    }

    .sidebar.collapsed ~ .main-content {
        margin-left: 80px;
    }

    /* Common Components */
    .page-header {
        background: white;
        padding: 25px 30px;
        border-radius: 15px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        margin-bottom: 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .page-header h1 {
        color: #2d3748;
        font-size: 28px;
        font-weight: 700;
    }

    .btn {
        padding: 12px 24px;
        border: none;
        border-radius: 10px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }

    .btn-primary {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
    }

    .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
    }

    .btn-danger {
        background: linear-gradient(135deg, #f56565 0%, #e53e3e 100%);
        color: white;
    }

    .btn-danger:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(245, 101, 101, 0.3);
    }

    .alert {
        padding: 15px 20px;
        border-radius: 10px;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .alert-success {
        background: #c6f6d5;
        color: #22543d;
        border-left: 4px solid #48bb78;
    }

    .alert-error {
        background: #fed7d7;
        color: #742a2a;
        border-left: 4px solid #f56565;
    }

    /* Loading Indicator */
    .loading-overlay {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(255, 255, 255, 0.8);
        display: none;
        align-items: center;
        justify-content: center;
        z-index: 9999;
    }

    .loading-overlay.active {
        display: flex;
    }

    .spinner {
        width: 50px;
        height: 50px;
        border: 4px solid #f3f3f3;
        border-top: 4px solid #667eea;
        border-radius: 50%;
        animation: spin 1s linear infinite;
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }

    /* Responsive */
    @media (max-width: 768px) {
        .sidebar {
            transform: translateX(-100%);
        }

        .sidebar.active {
            transform: translateX(0);
        }

        .main-content {
            margin-left: 0;
            padding: 20px;
        }
    }

    /* Tabs Container */
    .tabs-container {
        background: white;
        border-radius: 15px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        padding: 20px;
        margin-bottom: 30px;
    }
</style>
