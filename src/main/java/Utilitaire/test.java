package Utilitaire;

import DAO.CDAOClient;
import entity.Client;
import org.hibernate.Session;
import Utilitaire.HibernateUtil;

public class test {
    public static void main(String[] args) {
        CDAOClient daoClient = new CDAOClient();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Long count = session.createQuery("SELECT COUNT(c) FROM Client c WHERE c.ncin = :ncin", Long.class)
                    .setParameter("ncin", 123459)
                    .getSingleResult();
            if (count > 0) {
                return;
            }
        }
        Client clt = new Client();
        clt.setNcin(123459);
        clt.setNom("Kamel");
        clt.setPrenom("lahwel");
        clt.setNumTel(25987654);
        clt.setEmail("kamel@gmail.com");
        clt.setAdresse("mourouj");
        clt.setNumPermis(123456);
        daoClient.addClient(clt);
    }
}