package DAO;

import entity.Voiture;
import java.util.List;

public interface IDAOVoiture {
    void addVoiture(Voiture car);
    void updateVoiture(Voiture car);
    void deleteVoiture(Voiture car);
    Voiture getVoiture(int id);
    List<Voiture> getAllVoitures();
    List<Voiture> getVoituresByParc(int parcId);
    List<Voiture> getVoituresWithoutParc();
    List<String> getTopRentedCarsLabels();
    List<Integer> getTopRentedCarsData();
    List<String> getSatisfactionLabels();
    List<Integer> getSatisfactionData();
    List<String> getUtilizationLabels();
    List<Double> getUtilizationData();
    int getTotalClients();
    int getTotalVoitures();
    int getActiveLocations();
}