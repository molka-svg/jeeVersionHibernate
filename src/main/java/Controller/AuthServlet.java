package Controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.RequestDispatcher;

import DAO.CDAOUser;
import DAO.IDAOUser;
import entity.User;

@WebServlet(name = "AuthServlet", urlPatterns = {"/AuthServlet"})
public class AuthServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IDAOUser userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new CDAOUser();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "login";
        }

        switch (action) {
            case "logout":
                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.invalidate();
                }
                response.sendRedirect("index.jsp");
                break;
            case "login":
                request.getRequestDispatcher("login.jsp").forward(request, response);
                break;
            case "register":
                request.getRequestDispatcher("register.jsp").forward(request, response);
                break;
            default:
                response.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "login";
        }

        switch (action) {
            case "login":
                login(request, response);
                break;
            case "register":
                register(request, response);
                break;
            default:
                response.sendRedirect("index.jsp");
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            User user = userDAO.authenticate(username, password);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                // Mettre à jour la date de dernière connexion
                userDAO.updateLastLogin(user.getId());

                if ("ADMIN".equals(user.getRole())) {
                    response.sendRedirect("VoitureServlet?action=home");
                } else {
                    response.sendRedirect("RentalRequestServlet?action=rentCar");
                }
            } else {
                request.setAttribute("error", "Nom d'utilisateur ou mot de passe incorrect");
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Une erreur est survenue: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
        }
    }

    private void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Les mots de passe ne correspondent pas");
            RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
            rd.forward(request, response);
            return;
        }

        try {
            if (userDAO.isUsernameTaken(username)) {
                request.setAttribute("error", "Ce nom d'utilisateur est déjà pris");
                RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
                rd.forward(request, response);
                return;
            }

            if (userDAO.isEmailTaken(email)) {
                request.setAttribute("error", "Cet email est déjà utilisé");
                RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
                rd.forward(request, response);
                return;
            }

            User newUser = new User();
            newUser.setUsername(username);
            newUser.setEmail(email);
            newUser.setFullName(fullName);
            newUser.setPhone(phone);
            newUser.setPassword(password);
            newUser.setRole("USER");

            userDAO.addUser(newUser);

            request.setAttribute("successMessage", "Inscription réussie! Vous pouvez maintenant vous connecter.");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Une erreur est survenue lors de l'inscription: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
            rd.forward(request, response);
        }
    }
}