<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
&lt;!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Gestion des Demandes - Car Management</title>
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

    .btn-secondary {
      background: #64748b;
      color: #ffffff;
      padding: 8px 16px;
      border-radius: 8px;
      transition: background 0.3s ease, transform 0.3s ease;
    }

    .btn-secondary:hover {
      background: #475569;
      transform: scale(1.05);
    }

    .btn-success {
      background: #10b981;
      color: #ffffff;
      padding: 8px 16px;
      border-radius: 8px;
      transition: background 0.3s ease, transform 0.3s ease;
    }

    .btn-success:hover {
      background: #059669;
      transform: scale(1.05);
    }

    .btn-danger {
      background: #ef4444;
      color: #ffffff;
      padding: 8px 16px;
      border-radius: 8px;
      transition: background 0.3s ease, transform 0.3s ease;
    }

    .btn-danger:hover {
      background: #dc2626;
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

    .notification-badge {
      position: absolute;
      top: -5px;
      right: -5px;
      background-color: #ef4444;
      color: white;
      border-radius: 50%;
      width: 20px;
      height: 20px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 12px;
      font-weight: bold;
    }

    .notification-panel {
      position: absolute;
      right: 0;
      top: 100%;
      width: 320px;
      max-height: 400px;
      overflow-y: auto;
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
      z-index: 50;
      display: none;
    }

    .dark .notification-panel {
      background-color: #1f2937;
      border: 1px solid var(--border-dark);
    }

    .notification-item {
      padding: 12px;
      border-bottom: 1px solid var(--border-light);
      transition: background-color 0.3s ease;
    }

    .dark .notification-item {
      border-bottom: 1px solid var(--border-dark);
    }

    .notification-item:hover {
      background-color: #f3f4f6;
    }

    .dark .notification-item:hover {
      background-color: #374151;
    }

    .notification-item:last-child {
      border-bottom: none;
    }

    .notification-unread {
      background-color: #ebf5ff;
    }

    .dark .notification-unread {
      background-color: #1e3a8a;
    }

    .status-badge {
      display: inline-block;
      padding: 0.25rem 0.75rem;
      border-radius: 9999px;
      font-size: 0.75rem;
      font-weight: 600;
      text-transform: uppercase;
    }

    .status-pending {
      background-color: #fef3c7;
      color: #92400e;
    }

    .dark .status-pending {
      background-color: #78350f;
      color: #fef3c7;
    }

    .status-approved {
      background-color: #d1fae5;
      color: #065f46;
    }

    .dark .status-approved {
      background-color: #065f46;
      color: #d1fae5;
    }

    .status-rejected {
      background-color: #fee2e2;
      color: #b91c1c;
    }

    .dark .status-rejected {
      background-color: #b91c1c;
      color: #fee2e2;
    }

    .modal {
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background-color: rgba(0, 0, 0, 0.5);
      display: flex;
      align-items: center;
      justify-content: center;
      z-index: 100;
      opacity: 0;
      visibility: hidden;
      transition: opacity 0.3s ease, visibility 0.3s ease;
    }

    .modal.show {
      opacity: 1;
      visibility: visible;
    }

    .modal-content {
      background-color: white;
      border-radius: 12px;
      max-width: 500px;
      width: 100%;
      padding: 24px;
      transform: translateY(20px);
      transition: transform 0.3s ease;
    }

    .dark .modal-content {
      background-color: #1f2937;
    }

    .modal.show .modal-content {
      transform: translateY(0);
    }

    .form-input {
      width: 100%;
      padding: 10px 12px;
      border: 1px solid var(--border-light);
      border-radius: 8px;
      background-color: white;
      transition: border-color 0.3s ease, box-shadow 0.3s ease;
    }

    .dark .form-input {
      background-color: #1f2937;
      border-color: var(--border-dark);
      color: white;
    }

    .form-input:focus {
      outline: none;
      border-color: var(--secondary-color);
      box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.3);
    }
  </style>
</head>
<body class="min-h-screen">
&lt;!-- Header -->
<header class="header fixed top-0 left-0 right-0 z-50 p-4 flex justify-between items-center">
  <div class="flex items-center space-x-4">
    <button id="sidebar-toggle" class="p-2 rounded-lg btn-primary">
      <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
      </svg>
    </button>
    <h1 class="text-2xl font-semibold text-gray-900 dark:text-white">Gestion des Demandes de Location</h1>
  </div>
  <div class="flex items-center space-x-4">
    <button id="theme-toggle" class="p-2 rounded-lg bg-gray-200 dark:bg-gray-700 btn-primary">
      <svg id="theme-icon" class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z"></path>
      </svg>
    </button>
    <div class="relative">
      <button id="notification-toggle" class="p-2 rounded-lg bg-gray-200 dark:bg-gray-700 btn-primary relative">
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"></path>
        </svg>
        <c:if test="${pendingRequestsCount > 0}">
          <span class="notification-badge">${pendingRequestsCount}</span>
        </c:if>
      </button>
      <div id="notification-panel" class="notification-panel">
        <div class="p-3 border-b border-gray-200 dark:border-gray-700 font-semibold">
          Demandes en attente
        </div>
        <c:choose>
          <c:when test="${not empty pendingRequests}">
            <c:forEach var="request" items="${pendingRequests}" end="4">
              <div class="notification-item">
                <div class="flex justify-between items-start">
                  <div>
                    <p class="font-medium">Demande de ${request.userName}</p>
                    <p class="text-sm text-gray-600 dark:text-gray-400">
                        ${request.carName} (${request.startDate} - ${request.endDate})
                    </p>
                  </div>
                  <a href="RentalRequestServlet?action=viewRequest&id=${request.id}" class="text-blue-600 hover:text-blue-800 dark:text-blue-400 dark:hover:text-blue-300 text-sm">
                    Voir
                  </a>
                </div>
              </div>
            </c:forEach>
            <div class="p-3 border-t border-gray-200 dark:border-gray-700 text-center">
              <a href="RentalRequestServlet?action=list&filter=pending" class="text-blue-600 hover:text-blue-800 dark:text-blue-400 dark:hover:text-blue-300 text-sm">
                Voir toutes les demandes
              </a>
            </div>
          </c:when>
          <c:otherwise>
            <div class="p-4 text-center text-gray-500 dark:text-gray-400">
              Aucune demande en attente
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
    <div class="relative">
      <button id="user-dropdown-toggle" class="flex items-center space-x-2 p-2 rounded-lg bg-gray-200 dark:bg-gray-700 btn-primary">
        <img src="https://via.placeholder.com/32" alt="Utilisateur" class="w-8 h-8 rounded-full">
        <span class="hidden md:block text-gray-900 dark:text-white">Admin</span>
      </button>
      <div id="user-dropdown" class="dropdown dropdown-hidden absolute right-0 mt-2 w-48 bg-white dark:bg-gray-800 rounded-lg shadow-lg">
        <a href="#" class="block px-4 py-2 text-gray-900 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700">Profil</a>
        <a href="#" class="block px-4 py-2 text-gray-900 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700">Paramètres</a>
        <a href="AuthServlet?action=logout" class="block px-4 py-2 text-gray-900 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700">Déconnexion</a>
      </div>
    </div>
  </div>
</header>

&lt;!-- Sidebar Navigation -->
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
      <a href="RentalRequestServlet?action=list" class="sidebar-item flex items-center space-x-3 p-3 bg-gray-100 dark:bg-gray-700">
        <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"></path>
        </svg>
        <span class="sidebar-text text-gray-900 dark:text-white">Demandes</span>
      </a>
      <a href="UserServlet?action=list" class="sidebar-item flex items-center space-x-3 p-3">
        <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path>
        </svg>
        <span class="sidebar-text text-gray-900 dark:text-white">Utilisateurs</span>
      </a>
    </nav>
  </div>
</div>

&lt;!-- Main Content -->
<main class="md:ml-64 pt-20 p-6 min-h-screen">
  <div class="container mx-auto">
    <div class="flex justify-between items-center mb-6">
      <div class="flex space-x-2">
        <a href="RentalRequestServlet?action=list" class="btn-secondary py-2 px-4 ${empty param.filter ? 'bg-blue-600' : ''}">
          Toutes
        </a>
        <a href="RentalRequestServlet?action=list&filter=pending" class="btn-secondary py-2 px-4 ${param.filter == 'pending' ? 'bg-blue-600' : ''}">
          En attente
        </a>
        <a href="RentalRequestServlet?action=list&filter=approved" class="btn-secondary py-2 px-4 ${param.filter == 'approved' ? 'bg-blue-600' : ''}">
          Approuvées
        </a>
        <a href="RentalRequestServlet?action=list&filter=rejected" class="btn-secondary py-2 px-4 ${param.filter == 'rejected' ? 'bg-blue-600' : ''}">
          Rejetées
        </a>
      </div>
      <div class="flex items-center">
        <input type="text" id="searchInput" placeholder="Rechercher..." class="form-input mr-2">
        <button id="searchButton" class="btn-primary py-2 px-4">
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
          </svg>
        </button>
      </div>
    </div>

    <c:if test="${not empty successMessage}">
      <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-6" role="alert">
        <span class="block sm:inline">${successMessage}</span>
      </div>
    </c:if>

    <c:if test="${not empty errorMessage}">
      <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-6" role="alert">
        <span class="block sm:inline">${errorMessage}</span>
      </div>
    </c:if>

    <div class="card overflow-hidden">
      <div class="overflow-x-auto">
        <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
          <thead class="bg-gray-50 dark:bg-gray-800">
          <tr>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
              ID
            </th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
              Client
            </th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
              Voiture
            </th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
              Période
            </th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
              Statut
            </th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
              Date de demande
            </th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
              Actions
            </th>
          </tr>
          </thead>
          <tbody class="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
          <c:choose>
            <c:when test="${not empty rentalRequests}">
              <c:forEach var="request" items="${rentalRequests}">
                <tr class="request-row" data-id="${request.id}" data-user="${request.userName}" data-car="${request.carName}">
                  <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900 dark:text-white">
                      ${request.id}
                  </td>
                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 dark:text-gray-300">
                      ${request.userName}
                  </td>
                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 dark:text-gray-300">
                      ${request.carName}
                  </td>
                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 dark:text-gray-300">
                      ${request.startDate} - ${request.endDate}
                  </td>
                  <td class="px-6 py-4 whitespace-nowrap">
                    <c:choose>
                      <c:when test="${request.status == 'PENDING'}">
                        <span class="status-badge status-pending">En attente</span>
                      </c:when>
                      <c:when test="${request.status == 'APPROVED'}">
                        <span class="status-badge status-approved">Approuvée</span>
                      </c:when>
                      <c:when test="${request.status == 'REJECTED'}">
                        <span class="status-badge status-rejected">Rejetée</span>
                      </c:when>
                    </c:choose>
                  </td>
                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 dark:text-gray-300">
                      ${request.createdAt}
                  </td>
                  <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                    <div class="flex space-x-2">
                      <a href="RentalRequestServlet?action=viewRequest&id=${request.id}" class="text-blue-600 hover:text-blue-900 dark:text-blue-400 dark:hover:text-blue-300">
                        Voir
                      </a>
                      <c:if test="${request.status == 'PENDING'}">
                        <button class="text-green-600 hover:text-green-900 dark:text-green-400 dark:hover:text-green-300 approve-btn" data-id="${request.id}">
                          Approuver
                        </button>
                        <button class="text-red-600 hover:text-red-900 dark:text-red-400 dark:hover:text-red-300 reject-btn" data-id="${request.id}">
                          Rejeter
                        </button>
                      </c:if>
                    </div>
                  </td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr>
                <td colspan="7" class="px-6 py-4 text-center text-gray-500 dark:text-gray-400">
                  Aucune demande de location trouvée
                </td>
              </tr>
            </c:otherwise>
          </c:choose>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</main>

&lt;!-- Approve Modal -->
<div id="approveModal" class="modal">
  <div class="modal-content">
    <div class="flex justify-between items-center mb-4">
      <h3 class="text-xl font-semibold text-gray-900 dark:text-white">Approuver la demande</h3>
      <button class="close-modal text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-300">
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
        </svg>
      </button>
    </div>
    <form action="RentalRequestServlet" method="post">
      <input type="hidden" name="action" value="approveRequest">
      <input type="hidden" name="requestId" id="approveRequestId" value="">

      <p class="mb-4 text-gray-600 dark:text-gray-300">
        Êtes-vous sûr de vouloir approuver cette demande de location ? Un email de confirmation sera envoyé au client.
      </p>

      <div class="mb-4">
        <label for="approveMessage" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
          Message (optionnel)
        </label>
        <textarea id="approveMessage" name="message" rows="3" class="form-input" placeholder="Ajouter un message pour le client..."></textarea>
      </div>

      <div class="flex justify-end space-x-3">
        <button type="button" class="btn-secondary close-modal">Annuler</button>
        <button type="submit" class="btn-success">Approuver</button>
      </div>
    </form>
  </div>
</div>

&lt;!-- Reject Modal -->
<div id="rejectModal" class="modal">
  <div class="modal-content">
    <div class="flex justify-between items-center mb-4">
      <h3 class="text-xl font-semibold text-gray-900 dark:text-white">Rejeter la demande</h3>
      <button class="close-modal text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-300">
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
        </svg>
      </button>
    </div>
    <form action="RentalRequestServlet" method="post">
      <input type="hidden" name="action" value="rejectRequest">
      <input type="hidden" name="requestId" id="rejectRequestId" value="">

      <p class="mb-4 text-gray-600 dark:text-gray-300">
        Êtes-vous sûr de vouloir rejeter cette demande de location ? Un email de notification sera envoyé au client.
      </p>

      <div class="mb-4">
        <label for="rejectReason" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
          Raison du rejet
        </label>
        <textarea id="rejectReason" name="message" rows="3" class="form-input" placeholder="Expliquez pourquoi la demande est rejetée..." required></textarea>
      </div>

      <div class="flex justify-end space-x-3">
        <button type="button" class="btn-secondary close-modal">Annuler</button>
        <button type="submit" class="btn-danger">Rejeter</button>
      </div>
    </form>
  </div>
</div>

&lt;!-- Footer -->
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

  // Notification Toggle
  const notificationToggle = document.getElementById('notification-toggle');
  const notificationPanel = document.getElementById('notification-panel');
  notificationToggle.addEventListener('click', () => {
    if (notificationPanel.style.display === 'block') {
      notificationPanel.style.display = 'none';
    } else {
      notificationPanel.style.display = 'block';
    }
  });

  // Close dropdowns when clicking outside
  document.addEventListener('click', (event) => {
    if (!userDropdownToggle.contains(event.target) && !userDropdown.contains(event.target)) {
      userDropdown.classList.add('dropdown-hidden');
      userDropdown.classList.remove('dropdown-visible');
    }

    if (!notificationToggle.contains(event.target) && !notificationPanel.contains(event.target)) {
      notificationPanel.style.display = 'none';
    }
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

  // Search functionality
  const searchInput = document.getElementById('searchInput');
  const searchButton = document.getElementById('searchButton');
  const requestRows = document.querySelectorAll('.request-row');

  function performSearch() {
    const searchTerm = searchInput.value.toLowerCase();

    requestRows.forEach(row => {
      const id = row.getAttribute('data-id');
      const user = row.getAttribute('data-user').toLowerCase();
      const car = row.getAttribute('data-car').toLowerCase();

      if (id.includes(searchTerm) || user.includes(searchTerm) || car.includes(searchTerm)) {
        row.style.display = '';
      } else {
        row.style.display = 'none';
      }
    });
  }

  searchButton.addEventListener('click', performSearch);
  searchInput.addEventListener('keyup', (event) => {
    if (event.key === 'Enter') {
      performSearch();
    }
  });

  // Modal functionality
  const approveModal = document.getElementById('approveModal');
  const rejectModal = document.getElementById('rejectModal');
  const approveButtons = document.querySelectorAll('.approve-btn');
  const rejectButtons = document.querySelectorAll('.reject-btn');
  const closeModalButtons = document.querySelectorAll('.close-modal');
  const approveRequestIdInput = document.getElementById('approveRequestId');
  const rejectRequestIdInput = document.getElementById('rejectRequestId');

  approveButtons.forEach(button => {
    button.addEventListener('click', () => {
      const requestId = button.getAttribute('data-id');
      approveRequestIdInput.value = requestId;
      approveModal.classList.add('show');
    });
  });

  rejectButtons.forEach(button => {
    button.addEventListener('click', () => {
      const requestId = button.getAttribute('data-id');
      rejectRequestIdInput.value = requestId;
      rejectModal.classList.add('show');
    });
  });

  closeModalButtons.forEach(button => {
    button.addEventListener('click', () => {
      approveModal.classList.remove('show');
      rejectModal.classList.remove('show');
    });
  });

  // Close modal when clicking outside
  window.addEventListener('click', (event) => {
    if (event.target === approveModal) {
      approveModal.classList.remove('show');
    }
    if (event.target === rejectModal) {
      rejectModal.classList.remove('show');
    }
  });

  // GSAP Animations
  gsap.from('.card', {
    opacity: 0,
    y: 30,
    duration: 0.8,
    ease: 'power3.out'
  });
</script>
</body>
</html>