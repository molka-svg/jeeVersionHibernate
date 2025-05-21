package DAO;

import entity.DateAssociation;
import java.time.LocalDate;
import java.util.List;

public interface IDAODate {
    void addDate(DateAssociation dateAssoc);
    void updateDate(DateAssociation dateAssoc);
    void deleteDate(DateAssociation dateAssoc);
    DateAssociation getDate(int id);
    List<DateAssociation> getAllDates();
    boolean isCarAvailable(int voitureId, LocalDate dateDebut, LocalDate dateFin);
}