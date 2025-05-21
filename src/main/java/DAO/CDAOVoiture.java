package DAO;

import entity.Voiture;
import Utilitaire.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class CDAOVoiture implements IDAOVoiture {
    @Override
    public void addVoiture(Voiture car) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(car);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    public void updateVoiture(Voiture car) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.update(car);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    public void deleteVoiture(Voiture car) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.delete(car);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    public Voiture getVoiture(int id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Voiture.class, id);
        }
    }

    @Override
    public List<Voiture> getAllVoitures() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Voiture", Voiture.class).list();
        }
    }

    @Override
    public List<Voiture> getVoituresByParc(int parcId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Voiture> query = session.createQuery("FROM Voiture v WHERE v.parc.id = :parcId", Voiture.class);
            query.setParameter("parcId", parcId);
            return query.list();
        }
    }

    @Override
    public List<Voiture> getVoituresWithoutParc() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Voiture v WHERE v.parc IS NULL", Voiture.class).list();
        }
    }

    @Override
    public List<String> getTopRentedCarsLabels() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Object[]> query = session.createQuery("SELECT v.marque, v.modele, COUNT(d.id) FROM Voiture v LEFT JOIN DateAssociation d ON v.id = d.voiture.id GROUP BY v.id, v.marque, v.modele ORDER BY COUNT(d.id) DESC", Object[].class);
            query.setMaxResults(5);
            List<String> labels = new ArrayList<>();
            for (Object[] row : query.list()) {
                labels.add(row[0] + " " + row[1]);
            }
            return labels;
        }
    }

    @Override
    public List<Integer> getTopRentedCarsData() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Object[]> query = session.createQuery("SELECT v.marque, v.modele, COUNT(d.id) FROM Voiture v LEFT JOIN DateAssociation d ON v.id = d.voiture.id GROUP BY v.id, v.marque, v.modele ORDER BY COUNT(d.id) DESC", Object[].class);
            query.setMaxResults(5);
            List<Integer> data = new ArrayList<>();
            for (Object[] row : query.list()) {
                data.add(((Long) row[2]).intValue());
            }
            return data;
        }
    }

    @Override
    public List<String> getSatisfactionLabels() {
        List<String> labels = new ArrayList<>();
        labels.add("Très satisfait");
        labels.add("Satisfait");
        labels.add("Neutre");
        labels.add("Insatisfait");
        labels.add("Très insatisfait");
        return labels;
    }

    @Override
    public List<Integer> getSatisfactionData() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Object[]> query = session.createQuery("SELECT d.satisfaction, COUNT(d.id) FROM DateAssociation d WHERE d.satisfaction IS NOT NULL GROUP BY d.satisfaction", Object[].class);
            int[] counts = new int[5];
            for (Object[] row : query.list()) {
                Integer satisfaction = (Integer) row[0];
                Long count = (Long) row[1];
                if (satisfaction >= 1 && satisfaction <= 5) {
                    counts[satisfaction - 1] = count.intValue();
                }
            }
            List<Integer> data = new ArrayList<>();
            for (int i = 4; i >= 0; i--) {
                data.add(counts[i]);
            }
            return data;
        }
    }

    @Override
    public List<String> getUtilizationLabels() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                            "SELECT DISTINCT DATE_FORMAT(d.dateDebut, '%Y-%m') as formatted_date " +
                                    "FROM DateAssociation d " ,
                                     String.class)
                    .list();
        }
    }

    @Override
    public List<Double> getUtilizationData() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Object[]> query = session.createQuery("SELECT v.marque, v.modele, COUNT(d.id) FROM Voiture v LEFT JOIN DateAssociation d ON v.id = d.voiture.id WHERE d.dateDebut >= :startDate AND d.dateDebut <= :endDate GROUP BY v.id, v.marque, v.modele", Object[].class);
            LocalDate endDate = LocalDate.now();
            LocalDate startDate = endDate.minusMonths(6);
            query.setParameter("startDate", startDate);
            query.setParameter("endDate", endDate);
            List<Double> data = new ArrayList<>();
            for (Object[] row : query.list()) {
                data.add(((Long) row[2]).doubleValue());
            }
            return data;
        }
    }

    @Override
    public int getTotalClients() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Long> query = session.createQuery("SELECT COUNT(*) FROM Client", Long.class);
            return query.getSingleResult().intValue();
        }
    }

    @Override
    public int getTotalVoitures() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Long> query = session.createQuery("SELECT COUNT(*) FROM Voiture", Long.class);
            return query.getSingleResult().intValue();
        }
    }

    @Override
    public int getActiveLocations() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Long> query = session.createQuery("SELECT COUNT(*) FROM DateAssociation d WHERE d.dateFin IS NULL OR d.dateFin >= :currentDate", Long.class);
            query.setParameter("currentDate", LocalDate.now());
            return query.getSingleResult().intValue();
        }
    }
}