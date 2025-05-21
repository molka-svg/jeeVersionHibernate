<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Mes Notifications - Location de Voitures</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
  <style>
    .notification-item {
      transition: background-color 0.3s;
      border-left: 4px solid transparent;
    }
    .notification-item:hover {
      background-color: #f8f9fa;
    }
    .notification-item.unread {
      border-left-color: #007bff;
      background-color: rgba(0, 123, 255, 0.05);
    }
    .notification-date {
      font-size: 0.8rem;
      color: #6c757d;
    }
  </style>
</head>
<body>
<!-- Navbar avec notifications -->
<c:set var="notificationCount" value="${unreadCount}" scope="request" />
<c:set var="notifications" value="${notifications}" scope="request" />
<jsp:include page="navbar.jsp" />

<div class="container my-4">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Mes Notifications</h2>
    <c:if test="${unreadCount > 0}">
      <a href="NotificationServlet?action=markAllAsRead" class="btn btn-outline-primary">
        <i class="fas fa-check-double mr-1"></i> Marquer tout comme lu
      </a>
    </c:if>
  </div>

  <div class="card">
    <div class="card-header">
      <div class="d-flex justify-content-between align-items-center">
        <h5 class="mb-0">Toutes les notifications</h5>
        <span class="badge badge-primary">${unreadCount} non lues</span>
      </div>
    </div>
    <div class="list-group list-group-flush">
      <c:forEach var="notification" items="${notifications}">
        <a href="NotificationServlet?action=view&id=${notification.id}" class="list-group-item list-group-item-action notification-item ${notification.read ? '' : 'unread'}">
          <div class="d-flex justify-content-between align-items-center">
            <h6 class="mb-1">${notification.title}</h6>
            <small class="notification-date">${notification.formattedDate}</small>
          </div>
          <p class="mb-1">${notification.message}</p>
          <c:if test="${!notification.read}">
            <small class="text-primary">Non lu</small>
          </c:if>
        </a>
      </c:forEach>

      <c:if test="${empty notifications}">
        <div class="list-group-item text-center">
          <p class="mb-0">Vous n'avez pas de notifications.</p>
        </div>
      </c:if>
    </div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>