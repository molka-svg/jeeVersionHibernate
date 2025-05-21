<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Louer une Voiture - Location de Voitures</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
  <style>
    .car-card {
      transition: transform 0.3s;
      margin-bottom: 20px;
    }
    .car-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0,0,0,0.1);
    }
    .car-img {
      height: 200px;
      object-fit: cover;
    }
    .unavailable {
      opacity: 0.6;
    }
    .badge-car-status {
      position: absolute;
      top: 10px;
      right: 10px;
    }
  </style>
</head>
<body>
<!-- Navbar avec notifications -->
<c:set var="notificationCount" value="${notificationCount}" scope="request" />
<c:set var="notifications" value="${notifications}" scope="request" />
<jsp:include page="navbar.jsp" />

<div class="container my-4">
  <h2 class="mb-4">Louer une Voiture</h2>

  <c:if test="${not empty successMessage}">
    <div class="alert alert-success" role="alert">
        ${successMessage}
    </div>
  </c:if>

  <c:if test="${not empty errorMessage}">
    <div class="alert alert-danger" role="alert">
        ${errorMessage}
    </div>
  </c:if>

  <!-- Filtres -->
  <div class="card mb-4">
    <div class="card-body">
      <form action="RentalRequestServlet" method="get" class="form-inline">
        <input type="hidden" name="action" value="rentCar">
        <div class="form-group mr-2">
          <label for="marque" class="mr-2">Marque:</label>
          <select class="form-control" id="marque" name="marque">
            <option value="">Toutes</option>
            <c:forEach var="marque" items="${marques}">
              <option value="${marque}" ${param.marque eq marque ? 'selected' : ''}>${marque}</option>
            </c:forEach>
          </select>
        </div>
        <button type="submit" class="btn btn-primary">Filtrer</button>
      </form>
    </div>
  </div>

  <!-- Liste des voitures disponibles -->
  <div class="row">
    <c:forEach var="voiture" items="${voitures}">
      <c:if test="${voiture.disponible}">
        <div class="col-md-4">
          <div class="card car-card">
            <img src="${voiture.imageUrl}" class="card-img-top car-img" alt="${voiture.marque} ${voiture.modele}">
            <div class="card-body">
              <h5 class="card-title">${voiture.marque} ${voiture.modele}</h5>
              <p class="card-text">
                <strong>Matricule:</strong> ${voiture.matricule}<br>
                <strong>Kilométrage:</strong> ${voiture.kilometrage} km
              </p>
              <button type="button" class="btn btn-primary btn-block" data-toggle="modal" data-target="#rentModal${voiture.id}">
                Louer cette voiture
              </button>
            </div>
          </div>
        </div>

        <!-- Modal de location -->
        <div class="modal fade" id="rentModal${voiture.id}" tabindex="-1" role="dialog" aria-labelledby="rentModalLabel${voiture.id}" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="rentModalLabel${voiture.id}">Louer ${voiture.marque} ${voiture.modele}</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <form action="RentalRequestServlet" method="post">
                <input type="hidden" name="action" value="createRequest">
                <input type="hidden" name="carId" value="${voiture.id}">

                <div class="modal-body">
                  <div class="form-group">
                    <label for="startDate${voiture.id}">Date de début</label>
                    <input type="date" class="form-control" id="startDate${voiture.id}" name="startDate" min="${today}" required>
                  </div>
                  <div class="form-group">
                    <label for="endDate${voiture.id}">Date de fin</label>
                    <input type="date" class="form-control" id="endDate${voiture.id}" name="endDate" min="${today}" required>
                  </div>
                  <div class="form-group">
                    <label for="message${voiture.id}">Message (optionnel)</label>
                    <textarea class="form-control" id="message${voiture.id}" name="message" rows="3"></textarea>
                  </div>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
                  <button type="submit" class="btn btn-primary">Soumettre la demande</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </c:if>
    </c:forEach>

    <c:if test="${empty voitures}">
      <div class="col-12">
        <div class="alert alert-info" role="alert">
          Aucune voiture disponible pour le moment.
        </div>
      </div>
    </c:if>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
  // Validation des dates
  document.querySelectorAll('form').forEach(form => {
    form.addEventListener('submit', function(event) {
      const startDateInput = this.querySelector('input[name="startDate"]');
      const endDateInput = this.querySelector('input[name="endDate"]');

      if (startDateInput && endDateInput) {
        const startDate = new Date(startDateInput.value);
        const endDate = new Date(endDateInput.value);

        if (endDate < startDate) {
          alert('La date de fin doit être postérieure à la date de début.');
          event.preventDefault();
        }
      }
    });
  });
</script>
</body>
</html>