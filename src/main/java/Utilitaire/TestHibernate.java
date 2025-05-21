package Utilitaire;

import entity.Client;
import org.hibernate.Session;
import org.hibernate.query.Query;
import Utilitaire.HibernateUtil;

public class TestHibernate {
    public static void main(String[] args) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "SELECT COUNT(c) FROM Client c WHERE c.ncin = :ncin";
            Query<Long> query = session.createQuery(hql, Long.class);
            query.setParameter("ncin", 123459);
            Long count = query.getSingleResult();
            System.out.println("Nombre de clients: " + count);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}