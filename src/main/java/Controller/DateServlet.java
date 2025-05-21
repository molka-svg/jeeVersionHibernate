package Controller;

import DAO.CDAODate;
import DAO.CDAOClient;
import DAO.CDAOVoiture;
import entity.DateAssociation;
import entity.Client;
import entity.Voiture;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

public class DateServlet extends HttpServlet {
    private CDAODate daoDate;
    private CDAOClient daoClient;
    private CDAOVoiture daoVoiture;

    @Override
    public void init() {
        daoDate = new CDAODate();
        daoClient = new CDAOClient();
        daoVoiture = new CDAOVoiture();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            DateAssociation dateAssoc = new DateAssociation();
            dateAssoc.setId(id);
            daoDate.deleteDate(dateAssoc);
            response.sendRedirect("DateServlet");
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            DateAssociation dateAssoc = daoDate.getDate(id);
            request.setAttribute("editDate", dateAssoc);
            List<Client> clients = daoClient.getAllClients();
            List<Voiture> voitures = daoVoiture.getAllVoitures();
            request.setAttribute("clients", clients);
            request.setAttribute("voitures", voitures);
            RequestDispatcher rd = request.getRequestDispatcher("/dateForm.jsp");
            rd.forward(request, response);
        } else if ("add".equals(action)) {
            List<Client> clients = daoClient.getAllClients();
            List<Voiture> voitures = daoVoiture.getAllVoitures();
            request.setAttribute("clients", clients);
            request.setAttribute("voitures", voitures);
            RequestDispatcher rd = request.getRequestDispatcher("/dateForm.jsp");
            rd.forward(request, response);
        } else {
            List<DateAssociation> dates = daoDate.getAllDates();
            request.setAttribute("dates", dates);
            RequestDispatcher rd = request.getRequestDispatcher("/dateList.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String clientIdParam = request.getParameter("clientId");
        String voitureIdParam = request.getParameter("voitureId");
        String dateDebutParam = request.getParameter("dateDebut");
        String dateFinParam = request.getParameter("dateFin");
        String satisfactionParam = request.getParameter("satisfaction");
        DateAssociation dateAssoc = new DateAssociation();
        if (idParam != null && !idParam.isEmpty()) {
            dateAssoc.setId(Integer.parseInt(idParam));
        }
        Client clt = daoClient.getClient(Integer.parseInt(clientIdParam));
        Voiture car = daoVoiture.getVoiture(Integer.parseInt(voitureIdParam));
        LocalDate dateDebut = LocalDate.parse(dateDebutParam);
        LocalDate dateFin = dateFinParam != null && !dateFinParam.isEmpty() ? LocalDate.parse(dateFinParam) : null;
        Integer satisfaction = satisfactionParam != null && !satisfactionParam.isEmpty() ? Integer.parseInt(satisfactionParam) : null;
        if (dateFin != null && dateFin.isBefore(dateDebut)) {
            request.setAttribute("error", "La date de fin doit être postérieure à la date de début.");
            List<Client> clients = daoClient.getAllClients();
            List<Voiture> voitures = daoVoiture.getAllVoitures();
            request.setAttribute("clients", clients);
            request.setAttribute("voitures", voitures);
            request.setAttribute("editDate", dateAssoc);
            RequestDispatcher rd = request.getRequestDispatcher("/dateForm.jsp");
            rd.forward(request, response);
            return;
        }
        if (dateAssoc.getId() == null) {
            if (!daoDate.isCarAvailable(car.getId(), dateDebut, dateFin)) {
                request.setAttribute("error", "La voiture n'est pas disponible pour la période sélectionnée.");
                List<Client> clients = daoClient.getAllClients();
                List<Voiture> voitures = daoVoiture.getAllVoitures();
                request.setAttribute("clients", clients);
                request.setAttribute("voitures", voitures);
                request.setAttribute("editDate", dateAssoc);
                RequestDispatcher rd = request.getRequestDispatcher("/dateForm.jsp");
                rd.forward(request, response);
                return;
            }
        }
        dateAssoc.setClient(clt);
        dateAssoc.setVoiture(car);
        dateAssoc.setDateDebut(dateDebut);
        dateAssoc.setDateFin(dateFin);
        dateAssoc.setSatisfaction(satisfaction);
        if (dateAssoc.getId() != null && dateAssoc.getId() != 0) {
            daoDate.updateDate(dateAssoc);
        } else {
            daoDate.addDate(dateAssoc);
        }
        response.sendRedirect("DateServlet");
    }
}