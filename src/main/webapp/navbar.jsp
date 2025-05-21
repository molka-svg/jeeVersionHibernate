<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">
            <i class="fas fa-car mr-2"></i>Location de Voitures
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Accueil</a>
                </li>

                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <!-- Utilisateur non connecté -->
                        <li class="nav-item">
                            <a class="nav-link" href="AuthServlet?action=login">Connexion</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="AuthServlet?action=register">Inscription</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <!-- Utilisateur connecté -->
                        <c:if test="${sessionScope.user.role eq 'ADMIN'}">
                            <!-- Menu Admin -->
                            <li class="nav-item">
                                <a class="nav-link" href="VoitureServlet?action=list">Gestion Voitures</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="RentalRequestServlet?action=list">Demandes de Location</a>
                            </li>
                        </c:if>
                        <c:if test="${sessionScope.user.role eq 'USER'}">
                            <!-- Menu Utilisateur -->
                            <li class="nav-item">
                                <a class="nav-link" href="RentalRequestServlet?action=rentCar">Louer une Voiture</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="RentalRequestServlet?action=myRequests">Mes Demandes</a>
                            </li>
                        </c:if>

                        <!-- Notifications -->
                        <c:if test="${sessionScope.user.role eq 'USER'}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="notificationDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fas fa-bell"></i>
                                    <c:if test="${notificationCount > 0}">
                                        <span class="badge badge-danger">${notificationCount}</span>
                                    </c:if>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="notificationDropdown">
                                    <c:if test="${empty notifications}">
                                        <span class="dropdown-item">Aucune notification</span>
                                    </c:if>
                                    <c:forEach items="${notifications}" var="notification">
                                        <a class="dropdown-item ${notification.read ? '' : 'bg-light'}" href="NotificationServlet?action=view&id=${notification.id}">
                                            <small class="text-muted">${notification.formattedDate}</small><br>
                                                ${notification.title}
                                        </a>
                                    </c:forEach>
                                    <c:if test="${not empty notifications}">
                                        <div class="dropdown-divider"></div>
                                        <a class="dropdown-item text-center" href="NotificationServlet?action=markAllAsRead">Marquer tout comme lu</a>
                                    </c:if>
                                </div>
                            </li>
                        </c:if>

                        <!-- Profil utilisateur -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-user mr-1"></i>${sessionScope.user.username}
                            </a>
                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="#">Mon Profil</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="AuthServlet?action=logout">Déconnexion</a>
                            </div>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>