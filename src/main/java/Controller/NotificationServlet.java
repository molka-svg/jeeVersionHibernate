package Controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.RequestDispatcher;

import DAO.CDAONotification;
import DAO.IDAONotification;
import entity.Notification;
import entity.User;
import java.util.List;

@WebServlet(name = "NotificationServlet", urlPatterns = {"/NotificationServlet"})
public class NotificationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IDAONotification notificationDAO;

    @Override
    public void init() throws ServletException {
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
                case "view":
                    viewNotification(request, response, user);
                    break;
                case "markAsRead":
                    markAsRead(request, response, user);
                    break;
                case "markAllAsRead":
                    markAllAsRead(request, response, user);
                    break;
                case "list":
                    listNotifications(request, response, user);
                    break;
                default:
                    response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Pour l'instant, pas d'actions POST nécessaires pour les notifications
        response.sendRedirect("NotificationServlet?action=list");
    }

    private void listNotifications(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        try {
            List<Notification> notifications = notificationDAO.getUserNotifications(user.getId());
            int unreadCount = notificationDAO.getUnreadNotificationCount(user.getId());

            request.setAttribute("notifications", notifications);
            request.setAttribute("unreadCount", unreadCount);

            RequestDispatcher rd = request.getRequestDispatcher("/notifications.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void viewNotification(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        try {
            int notificationId = Integer.parseInt(request.getParameter("id"));
            Notification notification = notificationDAO.getNotification(notificationId);

            if (notification == null || notification.getUserId() != user.getId()) {
                response.sendRedirect("index.jsp");
                return;
            }

            // Marquer la notification comme lue
            notificationDAO.markAsRead(notificationId);

            // Rediriger en fonction du type de notification
            if ("REQUEST".equals(notification.getType())) {
                response.sendRedirect("RentalRequestServlet?action=viewRequest&id=" + notification.getTypeId());
            } else {
                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void markAsRead(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        try {
            int notificationId = Integer.parseInt(request.getParameter("id"));
            Notification notification = notificationDAO.getNotification(notificationId);

            if (notification == null || notification.getUserId() != user.getId()) {
                response.sendRedirect("index.jsp");
                return;
            }

            notificationDAO.markAsRead(notificationId);
            response.sendRedirect(request.getHeader("Referer"));
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void markAllAsRead(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        try {
            notificationDAO.markAllAsRead(user.getId());
            response.sendRedirect(request.getHeader("Referer"));
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}