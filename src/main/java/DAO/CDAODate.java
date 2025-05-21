package DAO;

import entity.DateAssociation;
import Utilitaire.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import java.time.LocalDate;
import java.util.List;

public class CDAODate implements IDAODate {
    @Override
    public void addDate(DateAssociation dateAssoc) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(dateAssoc);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    public void updateDate(DateAssociation dateAssoc) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.update(dateAssoc);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    public void deleteDate(DateAssociation dateAssoc) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.delete(dateAssoc);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    public DateAssociation getDate(int id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(DateAssociation.class, id);
        }
    }

    @Override
    public List<DateAssociation> getAllDates() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM DateAssociation", DateAssociation.class).list();
        }
    }

    @Override
    public boolean isCarAvailable(int voitureId, LocalDate dateDebut, LocalDate dateFin) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "SELECT COUNT(*) FROM DateAssociation d WHERE d.voiture.id = :voitureId AND d.dateDebut <= :endDate AND (d.dateFin IS NULL OR d.dateFin >= :startDate)";
            Query<Long> query = session.createQuery(hql, Long.class);
            query.setParameter("voitureId", voitureId);
            query.setParameter("endDate", dateFin != null ? dateFin : dateDebut);
            query.setParameter("startDate", dateDebut);
            return query.getSingleResult() == 0;
        }
    }
}