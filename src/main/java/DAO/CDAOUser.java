package DAO;

import entity.User;
import Utilitaire.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import java.sql.Timestamp;
import java.util.List;

public class CDAOUser implements IDAOUser {
    @Override
    public void addUser(User user) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(user);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    public void updateUser(User user) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.update(user);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    public void deleteUser(User user) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.delete(user);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    public User getUser(int id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(User.class, id);
        }
    }

    @Override
    public List<User> getAllUsers() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM User", User.class).list();
        }
    }

    @Override
    public User authenticate(String username, String password) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<User> query = session.createQuery(
                    "FROM User WHERE username = :username AND password = :password",
                    User.class
            );
            query.setParameter("username", username);
            query.setParameter("password", password); // Dans un vrai projet, utilisez un hachage sécurisé

            return query.uniqueResult();
        }
    }

    @Override
    public boolean isUsernameTaken(String username) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Long> query = session.createQuery(
                    "SELECT COUNT(u) FROM User u WHERE u.username = :username",
                    Long.class
            );
            query.setParameter("username", username);

            return query.uniqueResult() > 0;
        }
    }

    @Override
    public boolean isEmailTaken(String email) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Long> query = session.createQuery(
                    "SELECT COUNT(u) FROM User u WHERE u.email = :email",
                    Long.class
            );
            query.setParameter("email", email);

            return query.uniqueResult() > 0;
        }
    }

    @Override
    public void updateLastLogin(int userId) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();

            User user = session.get(User.class, userId);
            if (user != null) {
                user.setLastLogin(new Timestamp(System.currentTimeMillis()));
                session.update(user);
            }

            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw new RuntimeException(e);
        }
    }
}