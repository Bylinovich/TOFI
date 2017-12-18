package crud;

import entity.Distance;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import utils.HibernateSessionFactory;

import java.util.List;

/**
 * Created by Vlad on 04.12.2017.
 */
public class DistanceController {
    public Distance getDistance(String from, String to) {
        Session session = HibernateSessionFactory.getSessionFactory().openSession();
        session.beginTransaction();
        Criteria criteria = session.createCriteria(Distance.class);
        System.out.println(from);
        System.out.println(to);
        criteria.add(Restrictions.eq("countryFrom", from));
        criteria.add(Restrictions.eq("countryTo", to));
        List distances = criteria.list();
        session.getTransaction().commit();
        session.close();
        if (distances.size() == 0) {
            System.out.println("!!!!");
            return null;
        }
        System.out.println("????");
        return (Distance) distances.get(0);
    }
}
