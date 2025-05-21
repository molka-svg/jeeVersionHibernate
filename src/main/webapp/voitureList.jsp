<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Voitures - Car Management</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.11.5/gsap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.11.5/ScrollTrigger.min.js"></script>
    <style>
        :root {
            --primary-color: #1e40af;
            --secondary-color: #3b82f6;
            --background-light: #f9fafb;
            --background-dark: #111827;
            --text-primary: #111827;
            --text-secondary: #6b7280;
            --card-bg-light: #ffffff;
            --card-bg-dark: #1f2a44;
            --border-light: #e5e7eb;
            --border-dark: #374151;
        }

        body {
            background: var(--background-light);
            color: var(--text-primary);
            font-family: 'Inter', sans-serif;
            overflow-x: hidden;
        }

        .dark body {
            background: var(--background-dark);
            color: #f3f4f6;
        }

        .card {
            background: var(--card-bg-light);
            border: 1px solid var(--border-light);
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .dark .card {
            background: var(--card-bg-dark);
            border: 1px solid var(--border-dark);
        }

        .card:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }

        .btn-primary {
            background: var(--primary-color);
            color: #ffffff;
            padding: 8px 16px;
            border-radius: 8px;
            transition: background 0.3s ease, transform 0.3s ease;
        }

        .btn-primary:hover {
            background: var(--secondary-color);
            transform: scale(1.05);
        }

        .sidebar {
            background: var(--card-bg-light);
            border-right: 1px solid var(--border-light);
            transition: width 0.3s ease;
        }

        .dark .sidebar {
            background: var(--card-bg-dark);
            border-right: 1px solid var(--border-dark);
        }

        .sidebar-collapsed {
            width: 80px !important;
        }

        .sidebar-collapsed .sidebar-text {
            display: none;
        }

        .sidebar-item {
            transition: background 0.3s ease, transform 0.3s ease;
            border-radius: 8px;
        }

        .sidebar-item:hover {
            background: var(--border-light);
            transform: translateX(5px);
        }

        .dark .sidebar-item:hover {
            background: var(--border-dark);
        }

        .header {
            background: var(--card-bg-light);
            border-bottom: 1px solid var(--border-light);
            transition: box-shadow 0.3s ease;
        }

        .dark .header {
            background: var(--card-bg-dark);
            border-bottom: 1px solid var(--border-dark);
        }

        .header.scrolled {
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .dropdown {
            transition: opacity 0.3s ease, transform 0.3s ease;
        }

        .dropdown-hidden {
            opacity: 0;
            transform: translateY(10px);
            pointer-events: none;
        }

        .dropdown-visible {
            opacity: 1;
            transform: translateY(0);
            pointer-events: auto;
        }

        .tooltip {
            visibility: hidden;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .tooltip-parent:hover .tooltip {
            visibility: visible;
            opacity: 1;
        }

        .table-container {
            overflow-x: auto;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }

        .custom-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }

        .custom-table th {
            background-color: var(--primary-color);
            color: white;
            font-weight: 600;
            text-align: left;
            padding: 12px 16px;
        }

        .custom-table th:first-child {
            border-top-left-radius: 8px;
        }

        .custom-table th:last-child {
            border-top-right-radius: 8px;
        }

        .custom-table td {
            padding: 12px 16px;
            border-bottom: 1px solid var(--border-light);
        }

        .dark .custom-table td {
            border-bottom: 1px solid var(--border-dark);
        }

        .custom-table tr:last-child td {
            border-bottom: none;
        }

        .custom-table tr:nth-child(even) {
            background-color: rgba(0, 0, 0, 0.02);
        }

        .dark .custom-table tr:nth-child(even) {
            background-color: rgba(255, 255, 255, 0.02);
        }

        .custom-table tr:hover {
            background-color: rgba(59, 130, 246, 0.05);
        }

        .action-btn {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 6px;
            font-weight: 500;
            transition: all 0.3s ease;
            margin-right: 8px;
        }

        .edit-btn {
            background-color: #3b82f6;
            color: white;
        }

        .edit-btn:hover {
            background-color: #2563eb;
        }

        .delete-btn {
            background-color: #ef4444;
            color: white;
        }

        .delete-btn:hover {
            background-color: #dc2626;
        }

        .add-btn {
            display: inline-flex;
            align-items: center;
            background-color: #10b981;
            color: white;
            padding: 8px 16px;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            margin-bottom: 16px;
        }

        .add-btn:hover {
            background-color: #059669;
            transform: translateY(-2px);
        }

        .car-image {
            width: 100px;
            height: 70px;
            object-fit: cover;
            border-radius: 6px;
            transition: transform 0.3s ease;
        }

        .car-image:hover {
            transform: scale(1.5);
        }
    </style>
</head>
<body class="min-h-screen">
<!-- Header -->
<header class="header fixed top-0 left-0 right-0 z-50 p-4 flex justify-between items-center">
    <div class="flex items-center space-x-4">
        <button id="sidebar-toggle" class="p-2 rounded-lg btn-primary">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
            </svg>
        </button>
        <h1 class="text-2xl font-semibold text-gray-900 dark:text-white">Gestion des Voitures</h1>
    </div>
    <div class="flex items-center space-x-4">
        <div class="relative">
            <input type="text" id="search" placeholder="Rechercher..." class="pl-10 pr-4 py-2 rounded-lg bg-gray-100 dark:bg-gray-700 border border-gray-300 dark:border-gray-600 focus:outline-none focus:ring-2 focus:ring-blue-500">
            <svg class="w-5 h-5 absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
            </svg>
        </div>
        <button id="theme-toggle" class="p-2 rounded-lg bg-gray-200 dark:bg-gray-700 btn-primary">
            <svg id="theme-icon" class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z"></path>
            </svg>
        </button>
        <div class="relative">
            <button id="user-dropdown-toggle" class="flex items-center space-x-2 p-2 rounded-lg bg-gray-200 dark:bg-gray-700 btn-primary">
                <img src="https://via.placeholder.com/32" alt="Utilisateur" class="w-8 h-8 rounded-full">
                <span class="hidden md:block text-gray-900 dark:text-white">Admin</span>
            </button>
            <div id="user-dropdown" class="dropdown dropdown-hidden absolute right-0 mt-2 w-48 bg-white dark:bg-gray-800 rounded-lg shadow-lg">
                <a href="#" class="block px-4 py-2 text-gray-900 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700">Profil</a>
                <a href="#" class="block px-4 py-2 text-gray-900 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700">Paramètres</a>
                <a href="#" class="block px-4 py-2 text-gray-900 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700">Déconnexion</a>
            </div>
        </div>
    </div>
</header>

<!-- Sidebar Navigation -->
<div class="fixed top-0 left-0 h-full w-64 sidebar z-40">
    <div class="p-6">
        <h1 class="text-2xl font-semibold mb-8 flex items-center space-x-2">
            <svg class="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5-4h4a2 2 0 012 2v2H8V5a2 2 0 012-2z"></path>
            </svg>
            <span class="sidebar-text text-gray-900 dark:text-white">Location de voitures</span>
        </h1>
        <nav class="space-y-2">
            <a href="VoitureServlet?action=home" class="sidebar-item flex items-center space-x-3 p-3">
                <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path>
                </svg>
                <span class="sidebar-text text-gray-900 dark:text-white">Tableau de bord</span>
            </a>
            <a href="ClientServlet" class="sidebar-item flex items-center space-x-3 p-3">
                <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path>
                </svg>
                <span class="sidebar-text text-gray-900 dark:text-white">Clients</span>
            </a>
            <a href="VoitureServlet" class="sidebar-item flex items-center space-x-3 p-3 bg-gray-100 dark:bg-gray-700">
                <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 17V7h12a2 2 0 012 2v6a2 2 0 01-2 2H9zm-6 0a2 2 0 01-2-2V9a2 2 0 012-2h2v10H3z"></path>
                </svg>
                <span class="sidebar-text text-gray-900 dark:text-white">Voitures</span>
            </a>
            <a href="ParcServlet" class="sidebar-item flex items-center space-x-3 p-3">
                <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a2 2 0 012-2h2a2 2 0 012 2v5m-4 0h4"></path>
                </svg>
                <span class="sidebar-text text-gray-900 dark:text-white">Parcs</span>
            </a>
            <a href="DateServlet" class="sidebar-item flex items-center space-x-3 p-3">
                <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                </svg>
                <span class="sidebar-text text-gray-900 dark:text-white">Locations</span>
            </a>
        </nav>
    </div>
</div>

<!-- Main Content -->
<main class="md:ml-64 pt-20 p-6 min-h-screen">
    <div class="mb-8">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-3xl font-semibold text-gray-900 dark:text-white">Liste des Voitures</h2>
            <a href="VoitureServlet?action=add" class="add-btn">
                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                </svg>
                Ajouter une voiture
            </a>
        </div>

        <div class="card table-container">
            <table class="custom-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Matricule</th>
                    <th>Marque</th>
                    <th>Modèle</th>
                    <th>Kilométrage</th>
                    <th>Parc</th>
                    <th>Image</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="voiture" items="${voitures}">
                    <tr>
                        <td>${voiture.id}</td>
                        <td>${voiture.matricule}</td>
                        <td>${voiture.marque}</td>
                        <td>${voiture.modele}</td>
                        <td>${voiture.kilometrage} km</td>
                        <td>${voiture.parc != null ? voiture.parc.adresse : 'Sans parc'}</td>
                        <td>
                            <img src="${voiture.imageUrl}" alt="${voiture.marque} ${voiture.modele}" class="car-image" />
                        </td>
                        <td class="flex space-x-2">
                            <a href="VoitureServlet?action=edit&id=${voiture.id}" class="action-btn edit-btn">
                                    <span class="flex items-center">
                                        <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
                                        </svg>
                                        Modifier
                                    </span>
                            </a>
                            <a href="VoitureServlet?action=delete&id=${voiture.id}" onclick="return confirm('Voulez-vous supprimer cette voiture ?')" class="action-btn delete-btn">
                                    <span class="flex items-center">
                                        <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                                        </svg>
                                        Supprimer
                                    </span>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</main>

<!-- Footer -->
<footer class="bg-gray-800 text-white p-6 text-center">
    <p class="text-sm">© 2025 Agence de Location de Voitures. Tous droits réservés.</p>
    <div class="mt-2 flex justify-center space-x-4">
        <a href="#" class="text-blue-400 hover:text-blue-300 transition">Politique de confidentialité</a>
        <a href="#" class="text-blue-400 hover:text-blue-300 transition">Conditions d'utilisation</a>
        <a href="#" class="text-blue-400 hover:text-blue-300 transition">Nous contacter</a>
    </div>
</footer>

<script>
    // Theme Toggle
    const themeToggle = document.getElementById('theme-toggle');
    const themeIcon = document.getElementById('theme-icon');
    themeToggle.addEventListener('click', () => {
        document.documentElement.classList.toggle('dark');
        localStorage.setItem('theme', document.documentElement.classList.contains('dark') ? 'dark' : 'light');
        themeIcon.innerHTML = document.documentElement.classList.contains('dark') ?
            '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9 9 0 0012 21a9 9 0 008.354-5.646z"></path>' :
            '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z"></path>';
    });
    if (localStorage.getItem('theme') === 'dark') {
        document.documentElement.classList.add('dark');
        themeIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9 9 0 0012 21a9 9 0 008.354-5.646z"></path>';
    }

    // Sidebar Toggle
    const sidebarToggle = document.getElementById('sidebar-toggle');
    const sidebar = document.querySelector('.sidebar');
    sidebarToggle.addEventListener('click', () => {
        sidebar.classList.toggle('sidebar-collapsed');
    });

    // User Dropdown Toggle
    const userDropdownToggle = document.getElementById('user-dropdown-toggle');
    const userDropdown = document.getElementById('user-dropdown');
    userDropdownToggle.addEventListener('click', () => {
        userDropdown.classList.toggle('dropdown-hidden');
        userDropdown.classList.toggle('dropdown-visible');
    });

    // Header Shadow on Scroll
    const header = document.querySelector('.header');
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
    });

    // GSAP Animations
    gsap.from('.card', {
        scrollTrigger: {
            trigger: '.card',
            start: 'top 80%',
        },
        opacity: 0,
        y: 30,
        duration: 1,
        ease: 'power3.out'
    });
</script>
</body>
</html>