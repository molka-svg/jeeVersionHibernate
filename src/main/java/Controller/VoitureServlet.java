package Controller;

import entity.Voiture;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import DAO.CDAOParc;
import DAO.CDAOVoiture;
import entity.Parc;
import java.io.IOException;
import java.util.List;
import jakarta.json.Json;
import jakarta.json.JsonArrayBuilder;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
@WebServlet(name = "VoitureServlet", urlPatterns = {"/VoitureServlet"})
public class VoitureServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "Uploads/images";
    private CDAOVoiture daoVoiture;
    private CDAOParc daoParc;

    @Override
    public void init() throws ServletException {
        daoVoiture = new CDAOVoiture();
        daoParc = new CDAOParc();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "home":
                List<Voiture> voitures = daoVoiture.getAllVoitures();
                for (Voiture car : voitures) {
                    if (car.getImageUrl() != null && !car.getImageUrl().isEmpty()) {
                        String imageUrl = car.getImageUrl();
                        if (!imageUrl.startsWith("http")) {
                            imageUrl = request.getContextPath() + imageUrl;
                            car.setImageUrl(imageUrl);
                        }
                    } else {
                        car.setImageUrl(request.getContextPath() + "/" + UPLOAD_DIR + "/default.jpg");
                    }
                }
                request.setAttribute("featuredCars", voitures);
                request.setAttribute("topCarsLabels", jsonArrayToString(daoVoiture.getTopRentedCarsLabels()));
                request.setAttribute("topCarsData", jsonArrayToString(daoVoiture.getTopRentedCarsData()));
                request.setAttribute("satisfactionLabels", jsonArrayToString(daoVoiture.getSatisfactionLabels()));
                request.setAttribute("satisfactionData", jsonArrayToString(daoVoiture.getSatisfactionData()));
                request.setAttribute("utilizationLabels", jsonArrayToString(daoVoiture.getUtilizationLabels()));
                request.setAttribute("utilizationData", jsonArrayToString(daoVoiture.getUtilizationData()));
                request.setAttribute("totalClients", daoVoiture.getTotalClients());
                request.setAttribute("totalVoitures", daoVoiture.getTotalVoitures());
                request.setAttribute("activeLocations", daoVoiture.getActiveLocations());
                RequestDispatcher rd = request.getRequestDispatcher("/home.jsp");
                rd.forward(request, response);
                break;
            case "list":
                request.setAttribute("voitures", daoVoiture.getAllVoitures());
                request.setAttribute("parcs", daoParc.getAllParcs());
                request.getRequestDispatcher("/voitureList.jsp").forward(request, response);
                break;
            case "add":
                request.setAttribute("parcs", daoParc.getAllParcs());
                request.getRequestDispatcher("/voitureForm.jsp").forward(request, response);
                break;
            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                request.setAttribute("voiture", daoVoiture.getVoiture(id));
                request.setAttribute("parcs", daoParc.getAllParcs());
                request.getRequestDispatcher("/voitureForm.jsp").forward(request, response);
                break;
            case "delete":
                int idToDelete = Integer.parseInt(request.getParameter("id"));
                Voiture car = daoVoiture.getVoiture(idToDelete);
                if (car != null) {
                    daoVoiture.deleteVoiture(car);
                }
                response.sendRedirect("VoitureServlet?action=list");
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private String jsonArrayToString(List<?> list) {
        JsonArrayBuilder arrayBuilder = Json.createArrayBuilder();
        for (Object item : list) {
            if (item instanceof String) {
                arrayBuilder.add((String) item);
            } else if (item instanceof Number) {
                arrayBuilder.add(((Number) item).doubleValue());
            } else {
                arrayBuilder.add(item.toString());
            }
        }
        return arrayBuilder.build().toString();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "save";
        }

        switch (action) {
            case "save":
                Voiture voiture = new Voiture();
                voiture.setMatricule(request.getParameter("matricule"));
                voiture.setMarque(request.getParameter("marque"));
                voiture.setModele(request.getParameter("modele"));
                voiture.setKilometrage(Float.parseFloat(request.getParameter("kilometrage")));
                String parcIdParam = request.getParameter("parcId");
                if (parcIdParam != null && !parcIdParam.isEmpty()) {
                    Parc parc = daoParc.getParc(Integer.parseInt(parcIdParam));
                    voiture.setParc(parc);
                }
                String imageUrl = request.getParameter("imageUrl");
                if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                    voiture.setImageUrl(imageUrl);
                } else {
                    voiture.setImageUrl("/" + UPLOAD_DIR + "/default.jpg");
                }
                String id = request.getParameter("id");
                if (id != null && !id.isEmpty()) {
                    voiture.setId(Integer.parseInt(id));
                    daoVoiture.updateVoiture(voiture);
                } else {
                    daoVoiture.addVoiture(voiture);
                }
                response.sendRedirect("VoitureServlet?action=list");
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}