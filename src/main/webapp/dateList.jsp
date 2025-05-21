<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Locations</title>
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
        <h1 class="text-2xl font-semibold text-gray-900 dark:text-white">Liste des Locations</h1>
    </div>
    <div class="flex items-center space-x-4">
        <div class="relative">
            <input type="text" placeholder="Rechercher..." class="pl-10 pr-4 py-2 rounded-lg bg-gray-100 dark:bg-gray-700 border border-gray-300 dark:border-gray-600 focus:outline-none focus:ring-2 focus:ring-blue-500">
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
            <a href="VoitureServlet" class="sidebar-item flex items-center space-x-3 p-3">
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
    <div class="card p-6">
        <h2 class="text-3xl font-semibold mb-6 text-center text-gray-900 dark:text-white">Locations</h2>
        <div class="mb-4">
            <a href="DateServlet?action=add" class="btn-primary px-4 py-2 rounded-lg">Ajouter une Location</a>
        </div>
        <c:choose>
            <c:when test="${not empty dates}">
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                        <thead class="bg-gray-50 dark:bg-gray-800">
                        <tr>
                            <th class="py-3 px-4 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">ID</th>
                            <th class="py-3 px-4 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">Client</th>
                            <th class="py-3 px-4 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">Voiture</th>
                            <th class="py-3 px-4 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">Date de début</th>
                            <th class="py-3 px-4 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">Date de fin</th>
                            <th class="py-3 px-4 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">Satisfaction</th>
                            <th class="py-3 px-4 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">Actions</th>
                        </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200 dark:bg-gray-900 dark:divide-gray-700">
                        <c:forEach var="date" items="${dates}">
                            <tr>
                                <td class="py-3 px-4 text-gray-900 dark:text-white">${date.id}</td>
                                <td class="py-3 px-4 text-gray-900 dark:text-white">${date.client.nom} ${date.client.prenom}</td>
                                <td class="py-3 px-4 text-gray-900 dark:text-white">${date.voiture.marque} ${date.voiture.modele}</td>
                                <td class="py-3 px-4 text-gray-900 dark:text-white">${date.dateDebut}</td>
                                <td class="py-3 px-4 text-gray-900 dark:text-white">${date.dateFin != null ? date.dateFin : 'En cours'}</td>
                                <td class="py-3 px-4 text-gray-900 dark:text-white">${date.satisfaction != null ? date.satisfaction : 'Non évalué'}</td>
                                <td class="py-3 px-4 flex space-x-2">
                                    <div class="relative tooltip-parent">
                                        <a href="DateServlet?action=edit&id=${date.id}" class="bg-yellow-500 hover:bg-yellow-600 text-white px-3 py-1 rounded-lg transition">Modifier</a>
                                    </div>
                                    <div class="relative tooltip-parent">
                                        <a href="DateServlet?action=delete&id=${date.id}" class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded-lg transition" onclick="return confirm('Voulez-vous vraiment supprimer cette location ?');">Supprimer</a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <p class="text-center text-gray-600 dark:text-gray-400">Aucune location disponible.</p>
            </c:otherwise>
        </c:choose>
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
        stagger: 0.2,
        duration: 1,
        ease: 'power3.out'
    });
</script>
</body>
</html>