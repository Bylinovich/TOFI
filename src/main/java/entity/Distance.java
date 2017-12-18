package entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Created by Vlad on 11.11.2016.
 */
@Entity
@Table(name = "distance")
public class Distance extends AbstractEntity {

    @Column(name = "countryFrom", nullable = false, length = 30)
    private String countryFrom;
    @Column(name = "countryTo", nullable = false, length = 30)
    private String countryTo;
    @Column(name = "distance", nullable = false)
    private int distance;

    public Distance() {
    }

    public void setCountryFrom(String countryFrom) {
        this.countryFrom = countryFrom;
    }

    public void setCountryTo(String countryTo) {
        this.countryTo = countryTo;
    }

    public void setDistance(int distance) {
        this.distance = distance;
    }

    public String getCountryFrom() {

        return countryFrom;
    }

    public String getCountryTo() {
        return countryTo;
    }

    public int getDistance() {
        return distance;
    }

    public Distance(String countryFrom, String countryTo, int distance) {

        this.countryFrom = countryFrom;
        this.countryTo = countryTo;
        this.distance = distance;
    }
}