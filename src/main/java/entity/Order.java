package entity;

import crud.OrderController;
import crud.ParcelController;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Андрей on 11.11.2016.
 */
@Entity
@Table(name = "orders")
public class Order extends AbstractEntity {
    @Column(name = "userId", nullable = false)
    private long userId;
    @Column(name = "date")
    private Date date;
    @Column(name = "totalCost")
    private double totalCost;
    @Column(name = "currency")
    private String currency;
    @Column(name = "conversionTotalCost")
    private double conversionTotalCost;
    @Transient
    private ArrayList<Parcel> parcels = null;


    public Order() {
    }

    public Order(long userID) {
        this();
        this.userId = userID;
        this.parcels = new ArrayList<Parcel>();
    }

    public String getCurrency() {return currency;}

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public void setUserId(long userID) {
        this.userId = userID;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public void setTotalCost(double totalCost) {
        this.totalCost = totalCost;
    }

    public void setParcels(ArrayList<Parcel> parcels) {
        this.parcels = parcels;
    }

    public long getUserId() {
        return userId;
    }

    public Date getDate() {
        return date;
    }

    public double getTotalCost() {
        return totalCost;
    }

    public ArrayList<Parcel> getParcels() {
        if (parcels!=null){
            return parcels;
        }
        ParcelController parcelController = new ParcelController();
        ArrayList<Parcel> orderParcels = (ArrayList<Parcel>) parcelController.getOrderParcels(this.getId());
        if (orderParcels!=null){
            return orderParcels;
        }
        return new ArrayList<Parcel>();
    }

    public void updateCost(){
        totalCost = 0;
        conversionTotalCost = 0;
        List<Parcel> parcels = this.getParcels();
        for (Parcel parcel: parcels
             ) {
            totalCost += parcel.getCost();
            conversionTotalCost += parcel.getConversionCost();
        }
        OrderController orderController = new OrderController();
        if (parcels.size() == 0) {
            orderController.deleteOrder(this.getId());
        } else {
            orderController.updateOrder(this);
        }
    }

    public void addParcel(Parcel parcel){
        parcels.add(parcel);
        totalCost+=parcel.getCost();
        this.totalCost *= 100;
        this.totalCost = Math.round(this.totalCost);
        this.totalCost /= 100;
        conversionTotalCost+=parcel.getConversionCost();
        this.conversionTotalCost *= 100;
        this.conversionTotalCost = Math.round(this.conversionTotalCost);
        this.conversionTotalCost /= 100;
    }

    public void deleteParcel(long parcelId){
//        for (int i =0; i < parcels.size(); i++){
//            if (parcels.get(i).getId() == parcelId){
//                this.totalCost -= parcels.get(i).getCost();
//                parcels.remove(i);
//                break;
//            }
//        }
        this.totalCost -= parcels.get((int) parcelId).getCost();
        this.conversionTotalCost-=parcels.get((int) parcelId).getConversionCost();
        this.totalCost *= 100;
        this.totalCost = Math.round(this.totalCost);
        this.totalCost /= 100;
        this.conversionTotalCost *= 100;
        this.conversionTotalCost = Math.round(this.conversionTotalCost);
        this.conversionTotalCost /= 100;
        parcels.remove((int)parcelId);
    }

    public double getConversionTotalCost() {
        return conversionTotalCost;
    }

    public void setConversionTotalCost(double conversionTotalCost) {
        this.conversionTotalCost = conversionTotalCost;
    }
}
