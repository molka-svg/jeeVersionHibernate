package Controller;

import DAO.CDAOParc;
import entity.Parc;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ParcServlet", urlPatterns = {"/ParcServlet"})
public class ParcServlet extends HttpServlet {
    private CDAOParc daoParc;

    @Override
    public void init() {
        daoParc = new CDAOParc();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Parc parc = daoParc.getParc(id);
            if (parc != null) {
                daoParc.deleteParc(parc);
            }
            response.sendRedirect("ParcServlet");
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Parc parc = daoParc.getParc(id);
            request.setAttribute("editParc", parc);
            RequestDispatcher rd = request.getRequestDispatcher("/parcForm.jsp");
            rd.forward(request, response);
        } else if ("add".equals(action)) {
            RequestDispatcher rd = request.getRequestDispatcher("/parcForm.jsp");
            rd.forward(request, response);
        } else {
            List<Parc> parcs = daoParc.getAllParcs();
            request.setAttribute("parcs", parcs);
            RequestDispatcher rd = request.getRequestDispatcher("/parcList.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String capaciteParam = request.getParameter("capacite");
        String adresse = request.getParameter("adresse");
        Parc parc = new Parc();
        if (idParam != null && !idParam.isEmpty()) {
            parc.setId(Integer.parseInt(idParam));
        }
        parc.setCapacite(Integer.parseInt(capaciteParam));
        parc.setAdresse(adresse);
        if (parc.getId() != null && parc.getId() != 0) {
            daoParc.updateParc(parc);
        } else {
            daoParc.addParc(parc);
        }
        response.sendRedirect("ParcServlet");
    }
}