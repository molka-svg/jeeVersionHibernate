<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${voiture == null ? 'Ajouter' : 'Modifier'} Voiture - Car Management</title>
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

    .form-label {
      display: block;
      margin-bottom: 6px;
      font-weight: 500;
      color: var(--text-primary);
    }

    .dark .form-label {
      color: #e5e7eb;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-select {
      width: 100%;
      padding: 10px 12px;
      border: 1px solid var(--border-light);
      border-radius: 8px;
      background-color: white;
      transition: border-color 0.3s ease, box-shadow 0.3s ease;
      appearance: none;
      background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%236b7280'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M19 9l-7 7-7-7'%3E%3C/path%3E%3C/svg%3E");
      background-repeat: no-repeat;
      background-position: right 10px center;
      background-size: 20px;
    }

    .dark .form-select {
      background-color: #1f2937;
      border-color: var(--border-dark);
      color: white;
      background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%23e5e7eb'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M19 9l-7 7-7-7'%3E%3C/path%3E%3C/svg%3E");
    }

    .form-select:focus {
      outline: none;
      border-color: var(--secondary-color);
      box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.3);
    }

    .image-preview {
      width: 100%;
      height: 200px;
      border-radius: 8px;
      border: 2px dashed var(--border-light);
      display: flex;
      align-items: center;
      justify-content: center;
      overflow: hidden;
      position: relative;
    }

    .dark .image-preview {
      border-color: var(--border-dark);
    }

    .image-preview img {
      max-width: 100%;
      max-height: 100%;
      object-fit: contain;
    }

    .image-preview-placeholder {
      color: var(--text-secondary);
      text-align: center;
      padding: 20px;
    }

    .dark .image-preview-placeholder {
      color: #9ca3af;
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
    <h1 class="text-2xl font-semibold text-gray-900 dark:text-white">${voiture == null ? 'Ajouter une voiture' : 'Modifier la voiture'}</h1>
  </div>
  <div class="flex items-center space-x-4">
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
  <div class="max-w-2xl mx-auto">
    <div class="card p-6 mb-6">
      <form action="VoitureServlet" method="post" class="space-y-6">
        <input type="hidden" name="action" value="save">
        <c:if test="${voiture != null}">
          <input type="hidden" name="id" value="${voiture.id}">
        </c:if>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div class="form-group">
            <label for="matricule" class="form-label">Matricule:</label>
            <input type="text" id="matricule" name="matricule" value="${voiture.matricule}" required class="form-input" placeholder="Ex: AB-123-CD">
            <p class="text-sm text-gray-500 mt-1">Numéro d'immatriculation de la voiture</p>
          </div>

          <div class="form-group">
            <label for="marque" class="form-label">Marque:</label>
            <input type="text" id="marque" name="marque" value="${voiture.marque}" required class="form-input" placeholder="Ex: Renault, Peugeot...">
          </div>

          <div class="form-group">
            <label for="modele" class="form-label">Modèle:</label>
            <input type="text" id="modele" name="modele" value="${voiture.modele}" required class="form-input" placeholder="Ex: Clio, 308...">
          </div>

          <div class="form-group">
            <label for="kilometrage" class="form-label">Kilométrage:</label>
            <input type="number" step="0.1" id="kilometrage" name="kilometrage" value="${voiture.kilometrage}" required class="form-input" placeholder="Ex: 25000">
            <p class="text-sm text-gray-500 mt-1">Kilométrage actuel du véhicule</p>
          </div>
        </div>

        <div class="form-group">
          <label for="parcId" class="form-label">Parc:</label>
          <select id="parcId" name="parcId" class="form-select">
            <option value="">Aucun parc</option>
            <c:forEach var="parc" items="${parcs}">
              <option value="${parc.id}" <c:if test="${voiture != null && voiture.parcId == parc.id}">selected</c:if>>${parc.adresse}</option>
            </c:forEach>
          </select>
          <p class="text-sm text-gray-500 mt-1">Parc où la voiture est stationnée</p>
        </div>

        <div class="form-group">
          <label for="imageUrl" class="form-label">Image URL:</label>
          <input type="text" id="imageUrl" name="imageUrl" value="${voiture.imageUrl}" class="form-input" placeholder="https://exemple.com/image.jpg">
          <p class="text-sm text-gray-500 mt-1">URL de l'image de la voiture</p>
        </div>

        <div class="form-group">
          <label class="form-label">Aperçu de l'image:</label>
          <div class="image-preview" id="imagePreview">
            <c:choose>
              <c:when test="${not empty voiture.imageUrl}">
                <img src="${voiture.imageUrl}" alt="Aperçu de la voiture" id="previewImg">
              </c:when>
              <c:otherwise>
                <div class="image-preview-placeholder" id="previewPlaceholder">
                  <svg class="w-16 h-16 mx-auto mb-2 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                  </svg>
                  <p>Aucune image sélectionnée</p>
                </div>
              </c:otherwise>
            </c:choose>
          </div>
        </div>

        <div class="flex space-x-4">
          <button type="submit" class="btn-primary py-2 px-6 flex items-center">
            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
            </svg>
            ${voiture == null ? 'Ajouter' : 'Modifier'}
          </button>
          <a href="VoitureServlet?action=list" class="btn-secondary py-2 px-6 flex items-center">
            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
            </svg>
            Retour à la liste
          </a>
        </div>
      </form>
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

  // Image Preview
  const imageUrlInput = document.getElementById('imageUrl');
  const imagePreview = document.getElementById('imagePreview');
  const previewImg = document.getElementById('previewImg');
  const previewPlaceholder = document.getElementById('previewPlaceholder');

  imageUrlInput.addEventListener('input', updateImagePreview);

  function updateImagePreview() {
    const imageUrl = imageUrlInput.value.trim();

    if (imageUrl) {
      // Si une image existe déjà
      if (previewImg) {
        previewImg.src = imageUrl;
      } else {
        // Sinon, créer une nouvelle image
        const img = document.createElement('img');
        img.src = imageUrl;
        img.alt = "Aperçu de la voiture";
        img.id = "previewImg";

        // Supprimer le placeholder s'il existe
        if (previewPlaceholder) {
          previewPlaceholder.remove();
        }

        imagePreview.appendChild(img);
      }
    } else {
      // Si l'URL est vide et qu'il n'y a pas de placeholder
      if (!previewPlaceholder) {
        // Supprimer l'image si elle existe
        if (previewImg) {
          previewImg.remove();
        }

        // Créer le placeholder
        const placeholder = document.createElement('div');
        placeholder.className = "image-preview-placeholder";
        placeholder.id = "previewPlaceholder";
        placeholder.innerHTML = `
                    <svg class="w-16 h-16 mx-auto mb-2 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                    </svg>
                    <p>Aucune image sélectionnée</p>
                `;

        imagePreview.appendChild(placeholder);
      }
    }
  }

  // GSAP Animations
  gsap.from('.card', {
    opacity: 0,
    y: 30,
    duration: 1,
    ease: 'power3.out'
  });
</script>
</body>
</html>