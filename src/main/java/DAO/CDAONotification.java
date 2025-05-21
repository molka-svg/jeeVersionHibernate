package DAO;

import entity.Notification;
import Utilitaire.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import java.sql.Timestamp;
import java.util.List;

public class CDAONotification implements IDAONotification {
    @Override
    public void addNotification(Notification notification) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            notification.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            session.save(notification);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    public void updateNotification(Notification notification) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.update(notification);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    public void deleteNotification(Notification notification) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.delete(notification);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    public Notification getNotification(int id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Notification.class, id);
        }
    }

    @Override
    public List<Notification> getUserNotifications(int userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Notification> query = session.createQuery(
                    "FROM Notification WHERE userId = :userId ORDER BY createdAt DESC",
                    Notification.class
            );
            query.setParameter("userId", userId);

            return query.list();
        }
    }

    @Override
    public int getUnreadNotificationCount(int userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Long> query = session.createQuery(
                    "SELECT COUNT(n) FROM Notification n WHERE n.userId = :userId AND n.read = false",
                    Long.class
            );
            query.setParameter("userId", userId);

            return query.uniqueResult().intValue();
        }
    }

    @Override
    public void markAsRead(int notificationId) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();

            Notification notification = session.get(Notification.class, notificationId);
            if (notification != null) {
                notification.setRead(true);
                session.update(notification);
            }

            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    public void markAllAsRead(int userId) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();

            Query<?> query = session.createQuery(
                    "UPDATE Notification SET read = true WHERE userId = :userId AND read = false"
            );
            query.setParameter("userId", userId);
            query.executeUpdate();

            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw new RuntimeException(e);
        }
    }
}