package DAO;

import entity.Parc;
import java.util.List;

public interface IDAOParc {
    void addParc(Parc parc);
    void updateParc(Parc parc);
    void deleteParc(Parc parc);
    Parc getParc(int id);
    List<Parc> getAllParcs();
}