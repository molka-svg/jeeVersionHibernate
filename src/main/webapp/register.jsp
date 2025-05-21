<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Inscription - Location de Voitures</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
  <style>
    body {
      background-color: #f8f9fa;
    }
    .register-container {
      max-width: 600px;
      margin: 50px auto;
      padding: 30px;
      background-color: white;
      border-radius: 5px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    .register-header {
      text-align: center;
      margin-bottom: 30px;
    }
    .register-header i {
      font-size: 50px;
      color: #28a745;
    }
  </style>
</head>
<body>
<!-- Navbar -->
<jsp:include page="navbar.jsp" />

<div class="container">
  <div class="register-container">
    <div class="register-header">
      <i class="fas fa-user-plus mb-3"></i>
      <h3>Créer un compte</h3>
    </div>

    <c:if test="${not empty error}">
      <div class="alert alert-danger" role="alert">
          ${error}
      </div>
    </c:if>

    <form action="AuthServlet" method="post">
      <input type="hidden" name="action" value="register">

      <div class="form-row">
        <div class="form-group col-md-6">
          <label for="username">Nom d'utilisateur</label>
          <div class="input-group">
            <div class="input-group-prepend">
              <span class="input-group-text"><i class="fas fa-user"></i></span>
            </div>
            <input type="text" class="form-control" id="username" name="username" required>
          </div>
        </div>
        <div class="form-group col-md-6">
          <label for="email">Email</label>
          <div class="input-group">
            <div class="input-group-prepend">
              <span class="input-group-text"><i class="fas fa-envelope"></i></span>
            </div>
            <input type="email" class="form-control" id="email" name="email" required>
          </div>
        </div>
      </div>

      <div class="form-group">
        <label for="fullName">Nom complet</label>
        <div class="input-group">
          <div class="input-group-prepend">
            <span class="input-group-text"><i class="fas fa-id-card"></i></span>
          </div>
          <input type="text" class="form-control" id="fullName" name="fullName" required>
        </div>
      </div>

      <div class="form-group">
        <label for="phone">Téléphone</label>
        <div class="input-group">
          <div class="input-group-prepend">
            <span class="input-group-text"><i class="fas fa-phone"></i></span>
          </div>
          <input type="text" class="form-control" id="phone" name="phone">
        </div>
      </div>

      <div class="form-row">
        <div class="form-group col-md-6">
          <label for="password">Mot de passe</label>
          <div class="input-group">
            <div class="input-group-prepend">
              <span class="input-group-text"><i class="fas fa-lock"></i></span>
            </div>
            <input type="password" class="form-control" id="password" name="password" required>
          </div>
        </div>
        <div class="form-group col-md-6">
          <label for="confirmPassword">Confirmer le mot de passe</label>
          <div class="input-group">
            <div class="input-group-prepend">
              <span class="input-group-text"><i class="fas fa-lock"></i></span>
            </div>
            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
          </div>
        </div>
      </div>

      <button type="submit" class="btn btn-success btn-block">S'inscrire</button>
    </form>

    <div class="text-center mt-3">
      <p>Vous avez déjà un compte? <a href="AuthServlet?action=login">Connectez-vous</a></p>
    </div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>