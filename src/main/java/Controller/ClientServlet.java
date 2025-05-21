package Controller;

import DAO.CDAOClient;
import entity.Client;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ClientServlet", urlPatterns = {"/ClientServlet"})
public class ClientServlet extends HttpServlet {
    private CDAOClient daoClient;

    @Override
    public void init() {
        daoClient = new CDAOClient();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Client clt = new Client();
            clt.setId(id);
            daoClient.deleteClient(clt);
            response.sendRedirect("ClientServlet");
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Client clt = daoClient.getClient(id);
            request.setAttribute("editClient", clt);
            RequestDispatcher rd = request.getRequestDispatcher("/clientForm.jsp");
            rd.forward(request, response);
        } else if ("add".equals(action)) {
            RequestDispatcher rd = request.getRequestDispatcher("/clientForm.jsp");
            rd.forward(request, response);
        } else {
            List<Client> clients = daoClient.getAllClients();
            request.setAttribute("clients", clients);
            RequestDispatcher rd = request.getRequestDispatcher("/clientList.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("clientId");
        String ncinParam = request.getParameter("ncin");
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String numTelParam = request.getParameter("numTel");
        String email = request.getParameter("email");
        String adresse = request.getParameter("adresse");
        String numPermisParam = request.getParameter("numPermis");
        Client clt = new Client();
        if (idParam != null && !idParam.isEmpty()) {
            clt.setId(Integer.valueOf(idParam));
        }
        clt.setNcin(Integer.parseInt(ncinParam));
        clt.setNom(nom);
        clt.setPrenom(prenom);
        clt.setNumTel(Integer.parseInt(numTelParam));
        clt.setEmail(email);
        clt.setAdresse(adresse);
        clt.setNumPermis(Integer.parseInt(numPermisParam));
        if (clt.getId() != null && clt.getId() != 0) {
            daoClient.updateClient(clt);
        } else {
            daoClient.addClient(clt);
        }
        response.sendRedirect("ClientServlet");
    }
}