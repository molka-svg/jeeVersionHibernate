<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Mes Demandes - Location de Voitures</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
  <style>
    .status-badge {
      font-size: 0.9rem;
    }
    .request-card {
      transition: transform 0.3s;
      margin-bottom: 20px;
    }
    .request-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
  </style>
</head>
<body>
<!-- Navbar avec notifications -->
<c:set var="notificationCount" value="${notificationCount}" scope="request" />
<c:set var="notifications" value="${notifications}" scope="request" />
<jsp:include page="navbar.jsp" />

<div class="container my-4">
  <h2 class="mb-4">Mes Demandes de Location</h2>

  <div class="row">
    <c:forEach var="request" items="${userRequests}">
      <div class="col-md-6">
        <div class="card request-card">
          <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0">${request.carName}</h5>
            <c:choose>
              <c:when test="${request.status eq 'PENDING'}">
                <span class="badge badge-warning status-badge">En attente</span>
              </c:when>
              <c:when test="${request.status eq 'APPROVED'}">
                <span class="badge badge-success status-badge">Approuvée</span>
              </c:when>
              <c:when test="${request.status eq 'REJECTED'}">
                <span class="badge badge-danger status-badge">Rejetée</span>
              </c:when>
            </c:choose>
          </div>
          <div class="card-body">
            <p>
              <strong>Date de début:</strong> ${request.startDate}<br>
              <strong>Date de fin:</strong> ${request.endDate}<br>
              <strong>Date de demande:</strong> ${request.createdAt}
            </p>
            <c:if test="${not empty request.adminResponse}">
              <div class="alert alert-info">
                <strong>Réponse de l'administrateur:</strong><br>
                  ${request.adminResponse}
              </div>
            </c:if>
            <a href="RentalRequestServlet?action=viewRequest&id=${request.id}" class="btn btn-primary btn-block">
              Voir les détails
            </a>
          </div>
        </div>
      </div>
    </c:forEach>

    <c:if test="${empty userRequests}">
      <div class="col-12">
        <div class="alert alert-info" role="alert">
          Vous n'avez pas encore fait de demande de location.
        </div>
      </div>
    </c:if>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>