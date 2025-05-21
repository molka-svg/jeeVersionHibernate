<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Détails de la Demande - Location de Voitures</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<body>
<!-- Navbar -->
<jsp:include page="navbar.jsp" />

<div class="container my-4">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Détails de la Demande #${rentalRequest.id}</h2>
    <a href="RentalRequestServlet?action=list" class="btn btn-secondary">
      <i class="fas fa-arrow-left mr-1"></i> Retour à la liste
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
              <strong>Message de l'utilisateur:</strong><br>
                ${rentalRequest.message}
            </div>
          </c:if>

          <c:if test="${not empty rentalRequest.adminResponse}">
            <div class="alert alert-secondary">
              <strong>Réponse de l'administrateur:</strong><br>
                ${rentalRequest.adminResponse}
            </div>
          </c:if>

          <c:if test="${rentalRequest.status eq 'PENDING'}">
            <div class="mt-3">
              <button type="button" class="btn btn-success mr-2" data-toggle="modal" data-target="#approveModal">
                <i class="fas fa-check mr-1"></i> Approuver
              </button>
              <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#rejectModal">
                <i class="fas fa-times mr-1"></i> Rejeter
              </button>
            </div>
          </c:if>
        </div>
      </div>
    </div>

    <div class="col-md-6">
      <div class="card mb-4">
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
          <p><strong>Disponibilité:</strong>
            <c:choose>
              <c:when test="${voiture.disponible}">
                <span class="badge badge-success">Disponible</span>
              </c:when>
              <c:otherwise>
                <span class="badge badge-danger">Non disponible</span>
              </c:otherwise>
            </c:choose>
          </p>
        </div>
      </div>

      <div class="card">
        <div class="card-header">
          <h5 class="mb-0">Informations de l'utilisateur</h5>
        </div>
        <div class="card-body">
          <p><strong>Nom:</strong> ${rentalRequest.userName}</p>
          <p><strong>ID utilisateur:</strong> ${rentalRequest.userId}</p>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Modal d'approbation -->
<div class="modal fade" id="approveModal" tabindex="-1" role="dialog" aria-labelledby="approveModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="approveModalLabel">Approuver la demande #${rentalRequest.id}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form action="RentalRequestServlet" method="post">
        <input type="hidden" name="action" value="approveRequest">
        <input type="hidden" name="requestId" value="${rentalRequest.id}">

        <div class="modal-body">
          <p>Êtes-vous sûr de vouloir approuver cette demande de location?</p>
          <p><strong>Voiture:</strong> ${voiture.marque} ${voiture.modele}</p>
          <p><strong>Utilisateur:</strong> ${rentalRequest.userName}</p>
          <p><strong>Période:</strong> Du ${rentalRequest.startDate} au ${rentalRequest.endDate}</p>

          <div class="form-group">
            <label for="approveMessage">Message (optionnel)</label>
            <textarea class="form-control" id="approveMessage" name="message" rows="3"></textarea>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
          <button type="submit" class="btn btn-success">Approuver</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Modal de rejet -->
<div class="modal fade" id="rejectModal" tabindex="-1" role="dialog" aria-labelledby="rejectModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="rejectModalLabel">Rejeter la demande #${rentalRequest.id}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form action="RentalRequestServlet" method="post">
        <input type="hidden" name="action" value="rejectRequest">
        <input type="hidden" name="requestId" value="${rentalRequest.id}">

        <div class="modal-body">
          <p>Êtes-vous sûr de vouloir rejeter cette demande de location?</p>
          <p><strong>Voiture:</strong> ${voiture.marque} ${voiture.modele}</p>
          <p><strong>Utilisateur:</strong> ${rentalRequest.userName}</p>
          <p><strong>Période:</strong> Du ${rentalRequest.startDate} au ${rentalRequest.endDate}</p>

          <div class="form-group">
            <label for="rejectMessage">Motif du rejet</label>
            <textarea class="form-control" id="rejectMessage" name="message" rows="3" required></textarea>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
          <button type="submit" class="btn btn-danger">Rejeter</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>