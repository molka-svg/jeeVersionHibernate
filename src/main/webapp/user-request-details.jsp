<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Détails de ma Demande - Location de Voitures</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<body>
<!-- Navbar avec notifications -->
<c:set var="notificationCount" value="${notificationCount}" scope="request" />
<c:set var="notifications" value="${notifications}" scope="request" />
<jsp:include page="navbar.jsp" />

<div class="container my-4">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Détails de ma Demande #${rentalRequest.id}</h2>
    <a href="RentalRequestServlet?action=myRequests" class="btn btn-secondary">
      <i class="fas fa-arrow-left mr-1"></i> Retour à mes demandes
    </a>
  </div>

  <div class="row">
    <div class="col-md-6">
      <div class="card mb-4">
        <div class="card-header">
          <h5 class="mb-0">Informations de la demande</h5>
        </div>
        <div class="card-body">
          <p><strong>Statut:</strong>
            <c:choose>
              <c:when test="${rentalRequest.status eq 'PENDING'}">
                <span class="badge badge-warning">En attente</span>
              </c:when>
              <c:when test="${rentalRequest.status eq 'APPROVED'}">
                <span class="badge badge-success">Approuvée</span>
              </c:when>
              <c:when test="${rentalRequest.status eq 'REJECTED'}">
                <span class="badge badge-danger">Rejetée</span>
              </c:when>
            </c:choose>
          </p>
          <p><strong>Date de début:</strong> ${rentalRequest.startDate}</p>
          <p><strong>Date de fin:</strong> ${rentalRequest.endDate}</p>
          <p><strong>Date de demande:</strong> ${rentalRequest.createdAt}</p>
          <c:if test="${not empty rentalRequest.updatedAt}">
            <p><strong>Dernière mise à jour:</strong> ${rentalRequest.updatedAt}</p>
          </c:if>

          <c:if test="${not empty rentalRequest.message}">
            <div class="alert alert-info">
              <strong>Votre message:</strong><br>
                ${rentalRequest.message}
            </div>
          </c:if>

          <c:if test="${not empty rentalRequest.adminResponse}">
            <div class="alert alert-secondary">
              <strong>Réponse de l'administrateur:</strong><br>
                ${rentalRequest.adminResponse}
            </div>
          </c:if>
        </div>
      </div>
    </div>

    <div class="col-md-6">
      <div class="card">
        <div class="card-header">
          <h5 class="mb-0">Informations de la voiture</h5>
        </div>
        <div class="card-body">
          <div class="text-center mb-3">
            <img src="${voiture.imageUrl}" alt="${voiture.marque} ${voiture.modele}" class="img-fluid rounded" style="max-height: 200px;">
          </div>
          <h5>${voiture.marque} ${voiture.modele}</h5>
          <p><strong>Matricule:</strong> ${voiture.matricule}</p>
          <p><strong>Kilométrage:</strong> ${voiture.kilometrage} km</p>

          <c:if test="${rentalRequest.status eq 'APPROVED'}">
            <div class="alert alert-success mt-3">
              <h6 class="alert-heading">Votre demande a été approuvée!</h6>
              <p>Vous pouvez venir chercher la voiture à la date convenue. N'oubliez pas d'apporter votre permis de conduire et une pièce d'identité.</p>
            </div>
          </c:if>

          <c:if test="${rentalRequest.status eq 'REJECTED'}">
            <div class="alert alert-danger mt-3">
              <h6 class="alert-heading">Votre demande a été rejetée</h6>
              <p>Vous pouvez faire une nouvelle demande pour une autre voiture ou pour des dates différentes.</p>
            </div>
          </c:if>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>