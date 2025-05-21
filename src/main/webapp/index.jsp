<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Car Management - Location de Voitures</title>
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

    .hero-section {
      background-image: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1485291571150-772bcfc10da5?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
      background-size: cover;
      background-position: center;
      height: 80vh;
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      text-align: center;
    }

    .feature-card {
      padding: 2rem;
      text-align: center;
      border-radius: 12px;
      background-color: white;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .feature-card:hover {
      transform: translateY(-10px);
      box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
    }

    .dark .feature-card {
      background-color: var(--card-bg-dark);
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
    }

    .car-card {
      overflow: hidden;
      transition: transform 0.3s ease;
    }

    .car-card:hover {
      transform: translateY(-5px);
    }

    .car-card img {
      width: 100%;
      height: 200px;
      object-fit: cover;
      transition: transform 0.3s ease;
    }

    .car-card:hover img {
      transform: scale(1.05);
    }

    .testimonial {
      padding: 2rem;
      border-radius: 12px;
      background-color: white;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
      margin: 1rem;
    }

    .dark .testimonial {
      background-color: var(--card-bg-dark);
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
    }

    .testimonial-avatar {
      width: 60px;
      height: 60px;
      border-radius: 50%;
      object-fit: cover;
    }

    .cta-section {
      background-image: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1503376780353-7e6692767b70?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
      background-size: cover;
      background-position: center;
      padding: 6rem 0;
      color: white;
      text-align: center;
    }
  </style>
</head>
<body class="min-h-screen">
<!-- Header -->
<header class="header fixed top-0 left-0 right-0 z-50 p-4 flex justify-between items-center">
  <div class="flex items-center space-x-4">
    <a href="index.jsp" class="flex items-center space-x-2">
      <svg class="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 17V7h12a2 2 0 012 2v6a2 2 0 01-2 2H9zm-6 0a2 2 0 01-2-2V9a2 2 0 012-2h2v10H3z"></path>
      </svg>
      <span class="text-2xl font-semibold text-gray-900 dark:text-white">Car Management</span>
    </a>
  </div>
  <div class="flex items-center space-x-4">
    <nav class="hidden md:flex space-x-6">
      <a href="#features" class="text-gray-700 hover:text-blue-600 dark:text-gray-300 dark:hover:text-blue-400">Fonctionnalités</a>
      <a href="#cars" class="text-gray-700 hover:text-blue-600 dark:text-gray-300 dark:hover:text-blue-400">Nos Voitures</a>
      <a href="#testimonials" class="text-gray-700 hover:text-blue-600 dark:text-gray-300 dark:hover:text-blue-400">Témoignages</a>
      <a href="#contact" class="text-gray-700 hover:text-blue-600 dark:text-gray-300 dark:hover:text-blue-400">Contact</a>
    </nav>
    <button id="theme-toggle" class="p-2 rounded-lg bg-gray-200 dark:bg-gray-700">
      <svg id="theme-icon" class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z"></path>
      </svg>
    </button>
    <div class="flex space-x-2">
      <a href="AuthServlet?action=login" class="btn-primary">Connexion</a>
      <a href="AuthServlet?action=register" class="btn-secondary">Inscription</a>
    </div>
  </div>
</header>

<!-- Hero Section -->
<section class="hero-section">
  <div class="container mx-auto px-4">
    <h1 class="text-4xl md:text-6xl font-bold mb-6">Location de Voitures Simple et Rapide</h1>
    <p class="text-xl md:text-2xl mb-8 max-w-3xl mx-auto">Trouvez la voiture parfaite pour vos besoins et réservez en quelques clics</p>
    <a href="AuthServlet?action=register" class="btn-primary text-lg py-3 px-8">Commencer Maintenant</a>
  </div>
</section>

<!-- About Section -->
<section class="py-16 bg-gray-50 dark:bg-gray-800">
  <div class="container mx-auto px-4">
    <div class="max-w-3xl mx-auto text-center">
      <h2 class="text-3xl font-bold mb-6">À Propos de Car Management</h2>
      <p class="text-lg mb-8 text-gray-600 dark:text-gray-300">
        Car Management est une plateforme de location de voitures développée par <strong>Ferchichi Molka</strong> et <strong>Ben Youssef Ahmed Yassine</strong>.
        Notre service permet aux utilisateurs de louer facilement des véhicules pour leurs déplacements personnels ou professionnels.
        Avec une interface intuitive et un processus de réservation simplifié, nous rendons la location de voitures accessible à tous.
      </p>
      <p class="text-lg text-gray-600 dark:text-gray-300">
        Notre mission est de fournir un service de qualité, des véhicules bien entretenus et une expérience client exceptionnelle.
      </p>
    </div>
  </div>
</section>

<!-- Features Section -->
<section id="features" class="py-16">
  <div class="container mx-auto px-4">
    <h2 class="text-3xl font-bold text-center mb-12">Nos Fonctionnalités</h2>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
      <div class="feature-card">
        <div class="bg-blue-100 dark:bg-blue-900 p-3 rounded-full w-16 h-16 flex items-center justify-center mx-auto mb-6">
          <svg class="w-8 h-8 text-blue-600 dark:text-blue-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"></path>
          </svg>
        </div>
        <h3 class="text-xl font-semibold mb-4">Réservation Facile</h3>
        <p class="text-gray-600 dark:text-gray-300">Réservez votre voiture en quelques clics et recevez une confirmation instantanée.</p>
      </div>
      <div class="feature-card">
        <div class="bg-green-100 dark:bg-green-900 p-3 rounded-full w-16 h-16 flex items-center justify-center mx-auto mb-6">
          <svg class="w-8 h-8 text-green-600 dark:text-green-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
          </svg>
        </div>
        <h3 class="text-xl font-semibold mb-4">Sécurité Garantie</h3>
        <p class="text-gray-600 dark:text-gray-300">Tous nos véhicules sont régulièrement entretenus et assurés pour votre sécurité.</p>
      </div>
      <div class="feature-card">
        <div class="bg-purple-100 dark:bg-purple-900 p-3 rounded-full w-16 h-16 flex items-center justify-center mx-auto mb-6">
          <svg class="w-8 h-8 text-purple-600 dark:text-purple-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
          </svg>
        </div>
        <h3 class="text-xl font-semibold mb-4">Prix Compétitifs</h3>
        <p class="text-gray-600 dark:text-gray-300">Nous proposons des tarifs attractifs et transparents, sans frais cachés.</p>
      </div>
    </div>
  </div>
</section>

<!-- Cars Section -->
<section id="cars" class="py-16 bg-gray-50 dark:bg-gray-800">
  <div class="container mx-auto px-4">
    <h2 class="text-3xl font-bold text-center mb-12">Nos Voitures Disponibles</h2>
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
      <!-- Car 1 -->
      <div class="card car-card overflow-hidden">
        <img src="https://images.unsplash.com/photo-1541899481282-d53bffe3c35d?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" alt="Renault Clio" class="w-full h-48 object-cover">
        <div class="p-6">
          <h3 class="text-xl font-semibold mb-2">Renault Clio</h3>
          <div class="flex justify-between mb-4">
            <span class="text-gray-600 dark:text-gray-300">Économique</span>
            <span class="font-semibold text-blue-600">500dt/jour</span>
          </div>
          <div class="flex flex-wrap gap-2 mb-4">
            <span class="bg-gray-100 dark:bg-gray-700 px-3 py-1 rounded-full text-sm">5 places</span>
            <span class="bg-gray-100 dark:bg-gray-700 px-3 py-1 rounded-full text-sm">Manuelle</span>
            <span class="bg-gray-100 dark:bg-gray-700 px-3 py-1 rounded-full text-sm">Essence</span>
          </div>
          <a href="AuthServlet?action=login" class="btn-primary w-full block text-center">Réserver</a>
        </div>
      </div>

      <!-- Car 2 -->
      <div class="card car-card overflow-hidden">
        <img src="https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" alt="Peugeot 308" class="w-full h-48 object-cover">
        <div class="p-6">
          <h3 class="text-xl font-semibold mb-2">Peugeot 308</h3>
          <div class="flex justify-between mb-4">
            <span class="text-gray-600 dark:text-gray-300">Compacte</span>
            <span class="font-semibold text-blue-600">589dt/jour</span>
          </div>
          <div class="flex flex-wrap gap-2 mb-4">
            <span class="bg-gray-100 dark:bg-gray-700 px-3 py-1 rounded-full text-sm">5 places</span>
            <span class="bg-gray-100 dark:bg-gray-700 px-3 py-1 rounded-full text-sm">Automatique</span>
            <span class="bg-gray-100 dark:bg-gray-700 px-3 py-1 rounded-full text-sm">Diesel</span>
          </div>
          <a href="AuthServlet?action=login" class="btn-primary w-full block text-center">Réserver</a>
        </div>
      </div>

      <!-- Car 3 -->
      <div class="card car-card overflow-hidden">
        <img src="https://images.unsplash.com/photo-1553440569-bcc63803a83d?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" alt="Volkswagen Golf" class="w-full h-48 object-cover">
        <div class="p-6">
          <h3 class="text-xl font-semibold mb-2">Volkswagen Golf</h3>
          <div class="flex justify-between mb-4">
            <span class="text-gray-600 dark:text-gray-300">Compacte</span>
            <span class="font-semibold text-blue-600">700dt/jour</span>
          </div>
          <div class="flex flex-wrap gap-2 mb-4">
            <span class="bg-gray-100 dark:bg-gray-700 px-3 py-1 rounded-full text-sm">5 places</span>
            <span class="bg-gray-100 dark:bg-gray-700 px-3 py-1 rounded-full text-sm">Manuelle</span>
            <span class="bg-gray-100 dark:bg-gray-700 px-3 py-1 rounded-full text-sm">Essence</span>
          </div>
          <a href="AuthServlet?action=login" class="btn-primary w-full block text-center">Réserver</a>
        </div>
      </div>
    </div>
    <div class="text-center mt-10">
      <a href="AuthServlet?action=login" class="btn-secondary py-2 px-6">Voir toutes nos voitures</a>
    </div>
  </div>
</section>

<!-- Testimonials Section -->
<section id="testimonials" class="py-16">
  <div class="container mx-auto px-4">
    <h2 class="text-3xl font-bold text-center mb-12">Ce que disent nos clients</h2>
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
      <!-- Testimonial 1 -->
      <div class="testimonial">
        <div class="flex items-center mb-4">
          <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="Client" class="testimonial-avatar mr-4">
          <div>
            <h4 class="font-semibold">Si Yassin</h4>
            <div class="flex text-yellow-400">
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
            </div>
          </div>
        </div>
        <p class="text-gray-600 dark:text-gray-300">"Service impeccable ! La voiture était propre et en parfait état. Le processus de réservation était simple et rapide. Je recommande vivement."</p>
      </div>

      <!-- Testimonial 2 -->
      <div class="testimonial">
        <div class="flex items-center mb-4">
          <img src="https://randomuser.me/api/portraits/women/44.jpg" alt="Client" class="testimonial-avatar mr-4">
          <div>
            <h4 class="font-semibold">Si Molka</h4>
            <div class="flex text-yellow-400">
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
            </div>
          </div>
        </div>
        <p class="text-gray-600 dark:text-gray-300">"J'ai loué une voiture pour un week-end et tout s'est parfaitement déroulé. Le personnel est très professionnel et à l'écoute. Je n'hésiterai pas à revenir."</p>
      </div>

      <div class="testimonial">
        <div class="flex items-center mb-4">
          <img src="https://randomuser.me/api/portraits/men/67.jpg" alt="Client" class="testimonial-avatar mr-4">
          <div>
            <h4 class="font-semibold">Lucas Bernard</h4>
            <div class="flex text-yellow-400">
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
            </div>
          </div>
        </div>
        <p class="text-gray-600 dark:text-gray-300">"Excellent rapport qualité-prix. Les voitures sont récentes et bien entretenues. La prise en charge et la restitution sont rapides. Je suis très satisfait de mon expérience."</p>
      </div>
    </div>
  </div>
</section>

<!-- CTA Section -->
<section class="cta-section">
  <div class="container mx-auto px-4">
    <h2 class="text-3xl md:text-4xl font-bold mb-6">Prêt à prendre la route ?</h2>
    <p class="text-xl mb-8 max-w-2xl mx-auto">Inscrivez-vous dès maintenant et profitez de nos offres spéciales pour votre première location.</p>
    <div class="flex flex-col md:flex-row justify-center gap-4">
      <a href="AuthServlet?action=register" class="btn-primary text-lg py-3 px-8">S'inscrire</a>
      <a href="AuthServlet?action=login" class="btn-secondary text-lg py-3 px-8">Se connecter</a>
    </div>
  </div>
</section>

<!-- Contact Section -->
<section id="contact" class="py-16 bg-gray-50 dark:bg-gray-800">
  <div class="container mx-auto px-4">
    <h2 class="text-3xl font-bold text-center mb-12">Contactez-nous</h2>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-12">
      <div>
        <h3 class="text-xl font-semibold mb-4">Informations de contact</h3>
        <div class="space-y-4">
          <div class="flex items-start">
            <svg class="w-6 h-6 text-blue-600 mr-3 mt-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"></path>
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path>
            </svg>
            <div>
              <h4 class="font-semibold">Adresse</h4>
              <p class="text-gray-600 dark:text-gray-300">Iset Rades</p>
            </div>
          </div>
          <div class="flex items-start">
            <svg class="w-6 h-6 text-blue-600 mr-3 mt-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"></path>
            </svg>
            <div>
              <h4 class="font-semibold">Téléphone</h4>
              <p class="text-gray-600 dark:text-gray-300">71 548 500</p>
            </div>
          </div>
          <div class="flex items-start">
            <svg class="w-6 h-6 text-blue-600 mr-3 mt-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
            </svg>
            <div>
              <h4 class="font-semibold">Email</h4>
              <p class="text-gray-600 dark:text-gray-300">ferchichimolka391@gmail.com </p>
            </div>
          </div>
        </div>
        <div class="mt-8">
          <h3 class="text-xl font-semibold mb-4">Horaires d'ouverture</h3>
          <ul class="space-y-2 text-gray-600 dark:text-gray-300">
            <li>Lundi - Vendredi: 8h00 - 19h00</li>
            <li>Samedi: 9h00 - 18h00</li>
            <li>Dimanche: 10h00 - 16h00</li>
          </ul>
        </div>
      </div>
      <div>
        <form class="space-y-6">
          <div>
            <label for="name" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Nom complet</label>
            <input type="text" id="name" name="name" class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-md focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white">
          </div>
          <div>
            <label for="email" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Email</label>
            <input type="email" id="email" name="email" class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-md focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white">
          </div>
          <div>
            <label for="subject" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Sujet</label>
            <input type="text" id="subject" name="subject" class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-md focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white">
          </div>
          <div>
            <label for="message" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Message</label>
            <textarea id="message" name="message" rows="4" class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-md focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white"></textarea>
          </div>
          <button type="submit" class="btn-primary py-2 px-6">Envoyer le message</button>
        </form>
      </div>
    </div>
  </div>
</section>

<!-- Footer -->
<footer class="bg-gray-800 text-white py-12">
  <div class="container mx-auto px-4">
    <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
      <div>
        <h3 class="text-xl font-semibold mb-4">Car Management</h3>
        <p class="text-gray-300 mb-4">Votre partenaire de confiance pour la location de voitures. Nous proposons un service de qualité à des prix compétitifs.</p>
        <div class="flex space-x-4">
          <a href="#" class="text-gray-300 hover:text-white">
            <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24"><path d="M22 12c0-5.523-4.477-10-10-10S2 6.477 2 12c0 4.991 3.657 9.128 8.438 9.878v-6.987h-2.54V12h2.54V9.797c0-2.506 1.492-3.89 3.777-3.89 1.094 0 2.238.195 2.238.195v2.46h-1.26c-1.243 0-1.63.771-1.63 1.562V12h2.773l-.443 2.89h-2.33v6.988C18.343 21.128 22 16.991 22 12z"></path></svg>
          </a>
          <a href="#" class="text-gray-300 hover:text-white">
            <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24"><path d="M12.315 2c2.43 0 2.784.013 3.808.06 1.064.049 1.791.218 2.427.465a4.902 4.902 0 011.772 1.153 4.902 4.902 0 011.153 1.772c.247.636.416 1.363.465 2.427.048 1.067.06 1.407.06 4.123v.08c0 2.643-.012 2.987-.06 4.043-.049 1.064-.218 1.791-.465 2.427a4.902 4.902 0 01-1.153 1.772 4.902 4.902 0 01-1.772 1.153c-.636.247-1.363.416-2.427.465-1.067.048-1.407.06-4.123.06h-.08c-2.643 0-2.987-.012-4.043-.06-1.064-.049-1.791-.218-2.427-.465a4.902 4.902 0 01-1.772-1.153 4.902 4.902 0 01-1.153-1.772c-.247-.636-.416-1.363-.465-2.427-.047-1.024-.06-1.379-.06-3.808v-.63c0-2.43.013-2.784.06-3.808.049-1.064.218-1.791.465-2.427a4.902 4.902 0 011.153-1.772A4.902 4.902 0 015.45 2.525c.636-.247 1.363-.416 2.427-.465C8.901 2.013 9.256 2 11.685 2h.63zm-.081 1.802h-.468c-2.456 0-2.784.011-3.807.058-.975.045-1.504.207-1.857.344-.467.182-.8.398-1.15.748-.35.35-.566.683-.748 1.15-.137.353-.3.882-.344 1.857-.047 1.023-.058 1.351-.058 3.807v.468c0 2.456.011 2.784.058 3.807.045.975.207 1.504.344 1.857.182.466.399.8.748 1.15.35.35.683.566 1.15.748.353.137.882.3 1.857.344 1.054.048 1.37.058 4.041.058h.08c2.597 0 2.917-.01 3.96-.058.976-.045 1.505-.207 1.858-.344.466-.182.8-.398 1.15-.748.35-.35.566-.683.748-1.15.137-.353.3-.882.344-1.857.048-1.055.058-1.37.058-4.041v-.08c0-2.597-.01-2.917-.058-3.96-.045-.976-.207-1.505-.344-1.858a3.097 3.097 0 00-.748-1.15 3.098 3.098 0 00-1.15-.748c-.353-.137-.882-.3-1.857-.344-1.023-.047-1.351-.058-3.807-.058zM12 6.865a5.135 5.135 0 110 10.27 5.135 5.135 0 010-10.27zm0 1.802a3.333 3.333 0 100 6.666 3.333 3.333 0 000-6.666zm5.338-3.205a1.2 1.2 0 110 2.4 1.2 1.2 0 010-2.4z"></path></svg>
          </a>
          <a href="#" class="text-gray-300 hover:text-white">
            <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24"><path d="M8.29 20.251c7.547 0 11.675-6.253 11.675-11.675 0-.178 0-.355-.012-.53A8.348 8.348 0 0022 5.92a8.19 8.19 0 01-2.357.646 4.118 4.118 0 001.804-2.27 8.224 8.224 0 01-2.605.996 4.107 4.107 0 00-6.993 3.743 11.65 11.65 0 01-8.457-4.287 4.106 4.106 0 001.27 5.477A4.072 4.072 0 012.8 9.713v.052a4.105 4.105 0 003.292 4.022 4.095 4.095 0 01-1.853.07 4.108 4.108 0 003.834 2.85A8.233 8.233 0 012 18.407a11.616 11.616 0 006.29 1.84"></path></svg>
          </a>
        </div>
      </div>
      <div>
        <h3 class="text-xl font-semibold mb-4">Liens rapides</h3>
        <ul class="space-y-2">
          <li><a href="#" class="text-gray-300 hover:text-white">Accueil</a></li>
          <li><a href="#features" class="text-gray-300 hover:text-white">Fonctionnalités</a></li>
          <li><a href="#cars" class="text-gray-300 hover:text-white">Nos voitures</a></li>
          <li><a href="#testimonials" class="text-gray-300 hover:text-white">Témoignages</a></li>
          <li><a href="#contact" class="text-gray-300 hover:text-white">Contact</a></li>
        </ul>
      </div>
      <div>
        <h3 class="text-xl font-semibold mb-4">Services</h3>
        <ul class="space-y-2">
          <li><a href="#" class="text-gray-300 hover:text-white">Location courte durée</a></li>
          <li><a href="#" class="text-gray-300 hover:text-white">Location longue durée</a></li>
          <li><a href="#" class="text-gray-300 hover:text-white">Location avec chauffeur</a></li>
          <li><a href="#" class="text-gray-300 hover:text-white">Transfert aéroport</a></li>
          <li><a href="#" class="text-gray-300 hover:text-white">Assurance tous risques</a></li>
        </ul>
      </div>
      <div>
        <h3 class="text-xl font-semibold mb-4">Newsletter</h3>
        <p class="text-gray-300 mb-4">Inscrivez-vous à notre newsletter pour recevoir nos offres spéciales.</p>
        <form class="flex">
          <input type="email" placeholder="Votre email" class="px-4 py-2 w-full rounded-l-md focus:outline-none">
          <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded-r-md hover:bg-blue-700 focus:outline-none">S'inscrire</button>
        </form>
      </div>
    </div>
    <div class="border-t border-gray-700 mt-8 pt-8 text-center">
      <p class="text-gray-300">© 2025 Car Management. Tous droits réservés. Développé par Ferchichi Molka et Ben Youssef Ahmed Yassine.</p>
    </div>
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
  gsap.registerPlugin(ScrollTrigger);

  // Animate features
  gsap.from('.feature-card', {
    scrollTrigger: {
      trigger: '#features',
      start: 'top 80%',
    },
    opacity: 0,
    y: 50,
    stagger: 0.2,
    duration: 1,
    ease: 'power3.out'
  });

  // Animate cars
  gsap.from('.car-card', {
    scrollTrigger: {
      trigger: '#cars',
      start: 'top 80%',
    },
    opacity: 0,
    y: 50,
    stagger: 0.2,
    duration: 1,
    ease: 'power3.out'
  });

  // Animate testimonials
  gsap.from('.testimonial', {
    scrollTrigger: {
      trigger: '#testimonials',
      start: 'top 80%',
    },
    opacity: 0,
    y: 50,
    stagger: 0.2,
    duration: 1,
    ease: 'power3.out'
  });
</script>
</body>
</html>