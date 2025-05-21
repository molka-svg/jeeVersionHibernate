package Controller;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.RequestDispatcher;

import DAO.CDAORentalRequest;
import DAO.CDAOVoiture;
import DAO.CDAONotification;
import DAO.IDAORentalRequest;
import DAO.IDAOVoiture;
import DAO.IDAONotification;
import entity.RentalRequest;
import entity.User;
import entity.Voiture;
import entity.Notification;

@WebServlet(name = "RentalRequestServlet", urlPatterns = {"/RentalRequestServlet"})
public class RentalRequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IDAORentalRequest rentalRequestDAO;
    private IDAOVoiture voitureDAO;
    private IDAONotification notificationDAO;

    @Override
    public void init() throws ServletException {
        rentalRequestDAO = new CDAORentalRequest();
        voitureDAO = new CDAOVoiture();
        notificationDAO = new CDAONotification();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            switch (action) {
                case "rentCar":
                    showRentCarPage(request, response, user);
                    break;
                case "list":
                    listRequests(request, response, user);
                    break;
                case "myRequests":
                    listUserRequests(request, response, user);
                    break;
                case "viewRequest":
                    viewRequest(request, response, user);
                    break;
                default:
                    if ("ADMIN".equals(user.getRole())) {
                        response.sendRedirect("RentalRequestServlet?action=list");
                    } else {
                        response.sendRedirect("RentalRequestServlet?action=rentCar");
                    }
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "createRequest";
        }

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            switch (action) {
                case "createRequest":
                    createRequest(request, response, user);
                    break;
                case "approveRequest":
                    approveRequest(request, response, user);
                    break;
                case "rejectRequest":
                    rejectRequest(request, response, user);
                    break;
                default:
                    if ("ADMIN".equals(user.getRole())) {
                        response.sendRedirect("RentalRequestServlet?action=list");
                    } else {
                        response.sendRedirect("RentalRequestServlet?action=rentCar");
                    }
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void showRentCarPage(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        if (!"USER".equals(user.getRole())) {
            response.sendRedirect("VoitureServlet?action=home");
            return;
        }

        try {
            List<Voiture> voitures = voitureDAO.getAllVoitures();
            List<Notification> notifications = notificationDAO.getUserNotifications(user.getId());
            int notificationCount = notificationDAO.getUnreadNotificationCount(user.getId());

            java.util.Date today = new java.util.Date();
            java.sql.Date sqlToday = new java.sql.Date(today.getTime());

            request.setAttribute("voitures", voitures);
            request.setAttribute("notifications", notifications);
            request.setAttribute("notificationCount", notificationCount);
            request.setAttribute("today", sqlToday);

            RequestDispatcher rd = request.getRequestDispatcher("/rent-car.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void listRequests(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect("RentalRequestServlet?action=rentCar");
            return;
        }

        try {
            String filter = request.getParameter("filter");
            List<RentalRequest> rentalRequests;

            if (filter != null) {
                rentalRequests = rentalRequestDAO.getRentalRequestsByStatus(filter.toUpperCase());
            } else {
                rentalRequests = rentalRequestDAO.getAllRentalRequests();
            }

            List<RentalRequest> pendingRequests = rentalRequestDAO.getRentalRequestsByStatus("PENDING");
            int pendingRequestsCount = pendingRequests.size();

            request.setAttribute("rentalRequests", rentalRequests);
            request.setAttribute("pendingRequests", pendingRequests);
            request.setAttribute("pendingRequestsCount", pendingRequestsCount);

            RequestDispatcher rd = request.getRequestDispatcher("/admin-requests.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void listUserRequests(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        try {
            List<RentalRequest> userRequests = rentalRequestDAO.getUserRentalRequests(user.getId());
            List<Notification> notifications = notificationDAO.getUserNotifications(user.getId());
            int notificationCount = notificationDAO.getUnreadNotificationCount(user.getId());

            request.setAttribute("userRequests", userRequests);
            request.setAttribute("notifications", notifications);
            request.setAttribute("notificationCount", notificationCount);

            RequestDispatcher rd = request.getRequestDispatcher("/user-requests.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void viewRequest(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        try {
            int requestId = Integer.parseInt(request.getParameter("id"));
            RentalRequest rentalRequest = rentalRequestDAO.getRentalRequest(requestId);

            if (rentalRequest == null) {
                request.setAttribute("errorMessage", "Demande introuvable");
                if ("ADMIN".equals(user.getRole())) {
                    RequestDispatcher rd = request.getRequestDispatcher("/admin-requests.jsp");
                    rd.forward(request, response);
                } else {
                    RequestDispatcher rd = request.getRequestDispatcher("/user-requests.jsp");
                    rd.forward(request, response);
                }
                return;
            }

            // Vérifier que l'utilisateur a le droit de voir cette demande
            if (!"ADMIN".equals(user.getRole()) && rentalRequest.getUserId() != user.getId()) {
                response.sendRedirect("RentalRequestServlet?action=myRequests");
                return;
            }

            Voiture voiture = voitureDAO.getVoiture(rentalRequest.getCarId());

            request.setAttribute("rentalRequest", rentalRequest);
            request.setAttribute("voiture", voiture);

            if ("ADMIN".equals(user.getRole())) {
                RequestDispatcher rd = request.getRequestDispatcher("/admin-request-details.jsp");
                rd.forward(request, response);
            } else {
                List<Notification> notifications = notificationDAO.getUserNotifications(user.getId());
                int notificationCount = notificationDAO.getUnreadNotificationCount(user.getId());

                request.setAttribute("notifications", notifications);
                request.setAttribute("notificationCount", notificationCount);

                RequestDispatcher rd = request.getRequestDispatcher("/user-request-details.jsp");
                rd.forward(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void createRequest(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        if (!"USER".equals(user.getRole())) {
            response.sendRedirect("VoitureServlet?action=home");
            return;
        }

        try {
            int carId = Integer.parseInt(request.getParameter("carId"));
            Date startDate = Date.valueOf(request.getParameter("startDate"));
            Date endDate = Date.valueOf(request.getParameter("endDate"));
            String message = request.getParameter("message");

            // Vérifier que la voiture existe
            Voiture voiture = voitureDAO.getVoiture(carId);
            if (voiture == null) {
                request.setAttribute("errorMessage", "Voiture introuvable");
                showRentCarPage(request, response, user);
                return;
            }

            // Vérifier que les dates sont valides
            java.util.Date today = new java.util.Date();
            if (startDate.before(new java.sql.Date(today.getTime())) || endDate.before(startDate)) {
                request.setAttribute("errorMessage", "Dates invalides");
                showRentCarPage(request, response, user);
                return;
            }

            // Vérifier que la voiture est disponible pour ces dates
            if (!rentalRequestDAO.isCarAvailable(carId, startDate, endDate)) {
                request.setAttribute("errorMessage", "La voiture n'est pas disponible pour ces dates");
                showRentCarPage(request, response, user);
                return;
            }

            // Créer la demande
            RentalRequest rentalRequest = new RentalRequest();
            rentalRequest.setUserId(user.getId());
            rentalRequest.setCarId(carId);
            rentalRequest.setStartDate(startDate);
            rentalRequest.setEndDate(endDate);
            rentalRequest.setMessage(message);
            rentalRequest.setStatus("PENDING");

            rentalRequestDAO.addRentalRequest(rentalRequest);

            // Créer une notification pour l'administrateur
            Notification notification = new Notification();
            notification.setUserId(0); // 0 pour l'administrateur
            notification.setTitle("Nouvelle demande de location");
            notification.setMessage("Une nouvelle demande de location a été créée par " + user.getFullName());
            notification.setType("REQUEST");
            notification.setTypeId(rentalRequest.getId());
            notification.setRead(false);

            notificationDAO.addNotification(notification);

            request.setAttribute("successMessage", "Votre demande a été soumise avec succès");
            showRentCarPage(request, response, user);

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Une erreur est survenue: " + e.getMessage());
            showRentCarPage(request, response, user);
        }
    }

    private void approveRequest(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect("RentalRequestServlet?action=rentCar");
            return;
        }

        try {
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            String message = request.getParameter("message");

            RentalRequest rentalRequest = rentalRequestDAO.getRentalRequest(requestId);

            if (rentalRequest == null) {
                request.setAttribute("errorMessage", "Demande introuvable");
                listRequests(request, response, user);
                return;
            }

            if (!"PENDING".equals(rentalRequest.getStatus())) {
                request.setAttribute("errorMessage", "Cette demande a déjà été traitée");
                listRequests(request, response, user);
                return;
            }

            // Mettre à jour la demande
            rentalRequest.setStatus("APPROVED");
            rentalRequest.setAdminResponse(message);

            rentalRequestDAO.updateRentalRequest(rentalRequest);

            // Mettre à jour la disponibilité de la voiture
            Voiture voiture = voitureDAO.getVoiture(rentalRequest.getCarId());
            voiture.setDisponible(false);
            voitureDAO.updateVoiture(voiture);

            // Créer une notification pour l'utilisateur
            Notification notification = new Notification();
            notification.setUserId(rentalRequest.getUserId());
            notification.setTitle("Demande de location approuvée");
            notification.setMessage("Votre demande de location a été approuvée");
            notification.setType("REQUEST");
            notification.setTypeId(requestId);
            notification.setRead(false);

            notificationDAO.addNotification(notification);

            request.setAttribute("successMessage", "La demande a été approuvée avec succès");
            listRequests(request, response, user);

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Une erreur est survenue: " + e.getMessage());
            listRequests(request, response, user);
        }
    }

    private void rejectRequest(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect("RentalRequestServlet?action=rentCar");
            return;
        }

        try {
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            String message = request.getParameter("message");

            RentalRequest rentalRequest = rentalRequestDAO.getRentalRequest(requestId);

            if (rentalRequest == null) {
                request.setAttribute("errorMessage", "Demande introuvable");
                listRequests(request, response, user);
                return;
            }

            if (!"PENDING".equals(rentalRequest.getStatus())) {
                request.setAttribute("errorMessage", "Cette demande a déjà été traitée");
                listRequests(request, response, user);
                return;
            }

            // Mettre à jour la demande
            rentalRequest.setStatus("REJECTED");
            rentalRequest.setAdminResponse(message);

            rentalRequestDAO.updateRentalRequest(rentalRequest);

            // Créer une notification pour l'utilisateur
            Notification notification = new Notification();
            notification.setUserId(rentalRequest.getUserId());
            notification.setTitle("Demande de location rejetée");
            notification.setMessage("Votre demande de location a été rejetée");
            notification.setType("REQUEST");
            notification.setTypeId(requestId);
            notification.setRead(false);

            notificationDAO.addNotification(notification);

            request.setAttribute("successMessage", "La demande a été rejetée");
            listRequests(request, response, user);

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Une erreur est survenue: " + e.getMessage());
            listRequests(request, response, user);
        }
    }
}