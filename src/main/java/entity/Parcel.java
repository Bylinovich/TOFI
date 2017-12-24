package entity;

import crud.CurrencyController;
import crud.OrderController;
import crud.ParcelController;
import crud.RateController;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Created by Андрей on 11.11.2016.
 */
@Entity
@Table(name = "parcels")
public class Parcel extends AbstractEntity{
    @Column(name = "orderId")
    private long orderId;
    @Column(name = "recipientInfo", length = 100)
    private String recipientInfo;
    @Column(name = "rateId")
    private long rateId;
    @Column(name = "description", length = 50)
    private String description;
    @Column(name = "weight", nullable = false)
    private double weight;
    @Column(name = "toCountryId", nullable = false)
    private int toCountryId;
    @Column(name = "fromCountryId", nullable = false)
    private int fromCountryId;
    @Column(name = "toCountry", nullable = false)
    private String toCountry;
    @Column(name = "fromCountry", nullable = false)
    private String fromCountry;
    @Column(name = "express", nullable = false)
    private boolean express;
    @Column(name = "state")
    private String state;
    @Column(name = "cost")
    private double cost;
    @Column(name = "currency")
    private String currency;
    @Column(name = "conversionCost")
    private double conversionCost;



    public Parcel(String recipientInfo, double weight, int toCountryId, int fromCountryId, boolean express, String currency) {
        this.recipientInfo = recipientInfo;
        this.weight = weight;
        this.toCountryId = toCountryId;
        this.fromCountryId = fromCountryId;
        this.express = express;
        this.currency = currency;

    }

    public Parcel() {

    }

    public String getCurrency() {return currency;}

    public void setCurrency(String currency) {this.currency = currency;}

    public void setToCountry(String toCountry) {
        this.toCountry = toCountry;
    }

    public void setFromCountry(String fromCountry) {
        this.fromCountry = fromCountry;
    }

    public String getToCountry() {
        return toCountry;
    }

    public String getFromCountry() {
        return fromCountry;
    }

    public String getRecipientInfo() {
        return recipientInfo;
    }

    public void setRecipientInfo(String recipientInfo) {
        this.recipientInfo = recipientInfo;
    }

    public void setOrderId(long orderId) {
        this.orderId = orderId;
    }

    public void setRateId(long rateId) {
        this.rateId = rateId;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setWeight(double weight) {
        RateController rateController = new RateController();
        Rate rate = rateController.getRateById(this.getRateId());
        this.weight = weight;
        this.setCost(rate.calculateParcelCost(this));
        CurrencyController currencyController= new CurrencyController();
        this.setConversionCost(currencyController.conversion(this.getCost(), this.getCurrency()));
        ParcelController parcelController = new ParcelController();
        parcelController.updateParcel(this);
        OrderController orderController = new OrderController();
        Order order = orderController.getOrderById(this.getOrderId());
        order.updateCost();
    }

    public void setToCountryId(int toCountryId) {
        this.toCountryId = toCountryId;
    }

    public void setFromCountryId(int fromCountryId) {
        this.fromCountryId = fromCountryId;
    }

    public void setExpress(boolean express) {
        this.express = express;
    }

    public void setCost(double cost) {
        this.cost = cost;
        this.cost *= 100;
        this.cost = Math.round(this.cost);
        this.cost /= 100;
    }

    public long getOrderId() {
        return orderId;
    }

    public long getRateId() {
        return rateId;
    }

    public String getDescription() {
        return description;
    }

    public double getWeight() {
        return weight;
    }

    public int getToCountryId() {
        return toCountryId;
    }

    public int getFromCountryId() {
        return fromCountryId;
    }

    public boolean getExpress() {
        return express;
    }

    public String isExpress() {
        if (this.getExpress()){
            return "Yes";
        }
        return "No";
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getState() {

        return state;
    }

    public double getCost() {
        return cost;
    }

    public double getConversionCost() {
        return conversionCost;
    }

    public void setConversionCost(double cost) {
        this.conversionCost = cost;
        this.conversionCost *= 100;
        this.conversionCost = Math.round(this.conversionCost);
        this.conversionCost /= 100;
    }
}
