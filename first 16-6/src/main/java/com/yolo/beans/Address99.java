package com.yolo.beans;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
 
@Entity
@Table(name = "ADDRESS99", schema = "LMS_SOL1")
public class Address99 {
 
    @Id @GeneratedValue
    @Column(name = "ADDRESS_ID")
    private int ADDRESS_ID;
 
    

	@Column(name = "STREET")
    private String street;
 
    @Column(name = "CITY")
    private String city;
 
    @Column(name = "COUNTRY")
    private String country;
 
    public Address99() {
 
    }
 
    public Address99(String street, String city, String country) {
        this.street = street;
        this.city = city;
        this.country = country;
    }
 
    public int getADDRESS_ID() {
		return ADDRESS_ID;
	}

	public void setADDRESS_ID(int aDDRESS_ID) {
		ADDRESS_ID = aDDRESS_ID;
	}
 
    public String getStreet() {
        return street;
    }
 
    public void setStreet(String street) {
        this.street = street;
    }
 
    public String getCity() {
        return city;
    }
 
    public void setCity(String city) {
        this.city = city;
    }
 
    public String getCountry() {
        return country;
    }
 
    public void setCountry(String country) {
        this.country = country;
    }
 
    @Override
    public String toString() {
        return "Address [id=" + ADDRESS_ID + ", street=" + street + ", city=" + city
                + ", country=" + country + "]";
    }
     
}