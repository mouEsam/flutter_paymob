package com.flowapp.flutter_paymob.models.payment;

import com.fasterxml.jackson.annotation.*;

public class Customer {
    private String firstName;
    private String lastName;
    private String building;
    private String floor;
    private String street;
    private String apartment;
    private String city;
    private String state;
    private String country;
    private String email;
    private String phoneNumber;
    private String postalCode;

    @JsonProperty("first_name")
    public String getFirstName() { return firstName; }
    @JsonProperty("first_name")
    public void setFirstName(String value) { this.firstName = value; }

    @JsonProperty("last_name")
    public String getLastName() { return lastName; }
    @JsonProperty("last_name")
    public void setLastName(String value) { this.lastName = value; }

    @JsonProperty("building")
    public String getBuilding() { return building; }
    @JsonProperty("building")
    public void setBuilding(String value) { this.building = value; }

    @JsonProperty("floor")
    public String getFloor() { return floor; }
    @JsonProperty("floor")
    public void setFloor(String value) { this.floor = value; }

    @JsonProperty("street")
    public String getStreet() { return street; }
    @JsonProperty("street")
    public void setStreet(String value) { this.street = value; }

    @JsonProperty("apartment")
    public String getApartment() { return apartment; }
    @JsonProperty("apartment")
    public void setApartment(String value) { this.apartment = value; }

    @JsonProperty("city")
    public String getCity() { return city; }
    @JsonProperty("city")
    public void setCity(String value) { this.city = value; }

    @JsonProperty("state")
    public String getState() { return state; }
    @JsonProperty("state")
    public void setState(String value) { this.state = value; }

    @JsonProperty("country")
    public String getCountry() { return country; }
    @JsonProperty("country")
    public void setCountry(String value) { this.country = value; }

    @JsonProperty("email")
    public String getEmail() { return email; }
    @JsonProperty("email")
    public void setEmail(String value) { this.email = value; }

    @JsonProperty("phone_number")
    public String getPhoneNumber() { return phoneNumber; }
    @JsonProperty("phone_number")
    public void setPhoneNumber(String value) { this.phoneNumber = value; }

    @JsonProperty("postal_code")
    public String getPostalCode() { return postalCode; }
    @JsonProperty("postal_code")
    public void setPostalCode(String value) { this.postalCode = value; }
}
