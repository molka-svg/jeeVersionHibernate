package DAO;

import entity.RentalRequest;
import entity.User;
import entity.Voiture;
import Utilitaire.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class CDAORentalRequest implements IDAORentalRequest {
    @Override
    public void addRentalRequest(RentalRequest request) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            request.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            session.save(request);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    public void updateRentalRequest(RentalRequest request) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            request.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
            session.update(request);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    public void deleteRentalRequest(RentalRequest request) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.delete(request);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    public RentalRequest getRentalRequest(int id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            RentalRequest request = session.get(RentalRequest.class, id);

            if (request != null) {
                // Charger les informations supplémentaires
                User user = session.get(User.class, request.getUserId());
                Voiture voiture = session.get(Voiture.class, request.getCarId());

                if (user != null) {
                    request.setUserName(user.getFullName());
                }

                if (voiture != null) {
                    request.setCarName(voiture.getMarque() + " " + voiture.getModele());
                }
            }

            return request;
        }
    }

    @Override
    public List<RentalRequest> getAllRentalRequests() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            List<RentalRequest> requests = session.createQuery("FROM RentalRequest ORDER BY createdAt DESC", RentalRequest.class).list();

            // Charger les informations supplémentaires pour chaque demande
            for (RentalRequest request : requests) {
                User user = session.get(User.class, request.getUserId());
                Voiture voiture = session.get(Voiture.class, request.getCarId());

                if (user != null) {
                    request.setUserName(user.getFullName());
                }

                if (voiture != null) {
                    request.setCarName(voiture.getMarque() + " " + voiture.getModele());
                }
            }

            return requests;
        }
    }

    @Override
    public List<RentalRequest> getRentalRequestsByStatus(String status) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<RentalRequest> query = session.createQuery(
                    "FROM RentalRequest WHERE status = :status ORDER BY createdAt DESC",
                    RentalRequest.class
            );
            query.setParameter("status", status);

            List<RentalRequest> requests = query.list();

            // Charger les informations supplémentaires pour chaque demande
            for (RentalRequest request : requests) {
                User user = session.get(User.class, request.getUserId());
                Voiture voiture = session.get(Voiture.class, request.getCarId());

                if (user != null) {
                    request.setUserName(user.getFullName());
                }

                if (voiture != null) {
                    request.setCarName(voiture.getMarque() + " " + voiture.getModele());
                }
            }

            return requests;
        }
    }

    @Override
    public List<RentalRequest> getUserRentalRequests(int userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<RentalRequest> query = session.createQuery(
                    "FROM RentalRequest WHERE userId = :userId ORDER BY createdAt DESC",
                    RentalRequest.class
            );
            query.setParameter("userId", userId);

            List<RentalRequest> requests = query.list();

            // Charger les informations supplémentaires pour chaque demande
            for (RentalRequest request : requests) {
                Voiture voiture = session.get(Voiture.class, request.getCarId());

                if (voiture != null) {
                    request.setCarName(voiture.getMarque() + " " + voiture.getModele());
                }
            }

            return requests;
        }
    }

    @Override
    public boolean isCarAvailable(int carId, Date startDate, Date endDate) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Long> query = session.createQuery(
                    "SELECT COUNT(r) FROM RentalRequest r " +
                            "WHERE r.carId = :carId AND r.status = 'APPROVED' " +
                            "AND ((r.startDate <= :startDate AND r.endDate >= :startDate) OR " +
                            "(r.startDate <= :endDate AND r.endDate >= :endDate) OR " +
                            "(r.startDate >= :startDate AND r.endDate <= :endDate))",
                    Long.class
            );
            query.setParameter("carId", carId);
            query.setParameter("startDate", startDate);
            query.setParameter("endDate", endDate);

            return query.uniqueResult() == 0;
        }
    }
}