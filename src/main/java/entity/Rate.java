package entity;

import crud.CurrencyController;
import crud.DistanceController;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Date;

/**
 * Created by Vlad on 11.11.2016.
 */
@Entity
@Table(name = "rates")
public class Rate extends AbstractEntity {

    @Column(name = "beginDate", nullable = false, length = 30)
    private Date beginDate;
    @Column(name = "endDate", nullable = false, length = 30)
    private Date endDate;
    @Column(name = "price", nullable = false)
    private int price;

    public Rate(){}

    public Rate(Date beginDate, Date endDate, int price) {
        this.beginDate = beginDate;
        this.endDate = endDate;
        this.price = price;
    }

    public double calculateParcelCost(Parcel parcel){
        double cost;
        String fromCountry = parcel.getFromCountry();
        String toCountry = parcel.getToCountry();
        DistanceController distanceController = new DistanceController();
        Distance distance = distanceController.getDistance(fromCountry, toCountry);
        float dist = distance.getDistance();
        if (dist < 100) {
            dist = 100;
        }
        cost = parcel.getWeight() * this.price * (dist / 100);
        if (parcel.getExpress()){
            cost *= 1.2;
        }
        int t = (int) (cost * 100);
        cost = (float)t/100;
        return cost;
    }

    public Date getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(Date beginDate) {
        this.beginDate = beginDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }
}