package crud;

import entity.Parcel;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import utils.HibernateSessionFactory;

import java.util.List;

/**
 * Created by Андрей on 12.11.2016.
 */
public class ParcelController {

    public Boolean AddParcel(Parcel parcel) {
        Session session = HibernateSessionFactory.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            session.save(parcel);
        }catch (HibernateException e){
            e.printStackTrace();
            session.getTransaction().rollback();
            return false;
        }
        session.getTransaction().commit();
        session.close();
        return true;
    }

    public List<Parcel> getOrderParcels(long orderId) {
        Session session = HibernateSessionFactory.getSessionFactory().openSession();
        session.beginTransaction();
        Criteria criteria = session.createCriteria(Parcel.class);
        criteria.add(Restrictions.eq("orderId", orderId));
        List<Parcel> parcels = criteria.list();
        session.getTransaction().commit();
        session.close();
        if (parcels.size() == 0)
            return null;
        return parcels;
    }

    public Integer getParcelsCount(){
        Session session = HibernateSessionFactory.getSessionFactory().openSession();
        Criteria criteria = session.createCriteria(Parcel.class);
        criteria.setProjection(Projections.rowCount());
        Integer count = (int) (long) (Long) criteria.uniqueResult();
        return count;
    }

    public Integer getPageAmount(int pageSize, Long orderId){
        Session session = HibernateSessionFactory.getSessionFactory().openSession();
        Criteria criteriaCount = session.createCriteria(Parcel.class);
        if (orderId != null) {
            criteriaCount.add(Restrictions.eq("orderId", orderId));
        }
        criteriaCount.setProjection(Projections.rowCount());
        Integer count = (int) (long) (Long) criteriaCount.uniqueResult();
        Integer pageAmount =  (count - 1) / pageSize + 1;
        session.close();
        return pageAmount;
    }

    public List<Parcel> getPageOfParcels(int pageNumber, int pageSize, Long orderId){
        if (orderId != null) {
            return getOrderParcels(orderId);
        }
        Session session = HibernateSessionFactory.getSessionFactory().openSession();
        session.beginTransaction();
        Criteria criteria = session.createCriteria(Parcel.class);
        criteria.setFirstResult((pageNumber - 1)*pageSize);
        criteria.setMaxResults(pageSize);
        List<Parcel> list = (List<Parcel>) criteria.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

    public boolean updateParcel(Parcel parcel){
        Session session = HibernateSessionFactory.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            session.update(parcel);
        }catch (HibernateException e){
            e.printStackTrace();
            session.getTransaction().rollback();
            return false;
        }
        session.getTransaction().commit();
        session.close();
        return true;
    }

//    public boolean deleteParcel2(long parcelId) {
//        Session session = HibernateSessionFactory.getSessionFactory().openSession();
//        session.beginTransaction();
//        Criteria criteria = session.createCriteria(Parcel.class);
//        criteria.add(Restrictions.eq("ID", parcelId));
//        Parcel parcel = (Parcel) criteria.list().get(0);
//        try {
//            if (null != parcel) {
//                session.delete(parcel);
//            } else return false;
//        } catch (HibernateException e) {
//            e.printStackTrace();
//            session.getTransaction().rollback();
//        }
//        session.getTransaction().commit();
//        return true;
//    }
    public boolean deleteParcel(long parcelId) {
        Session session = HibernateSessionFactory.getSessionFactory().openSession();
        session.beginTransaction();
        Parcel parcel = (Parcel) session.load(Parcel.class, parcelId);
        try {
            if (parcel != null) {
                session.delete(parcel);
            } else
                return false;
        } catch (HibernateException e) {
            e.printStackTrace();
            session.getTransaction().rollback();
            return false;
        }
        session.getTransaction().commit();
        session.close();
        return true;
    }
}
