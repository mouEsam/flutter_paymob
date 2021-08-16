package com.flowapp.flutter_paymob.models.payment;

import android.graphics.Color;

import com.fasterxml.jackson.annotation.*;

public class Payment {
    private String paymentKey;
    private boolean saveCardDefault;
    private boolean showSaveCard;
    private String themeColor;
    private String language;
    private boolean actionbar;
    private String token;
    private String maskedPanNumber;
    private Customer customer;

    @JsonProperty("payment_key")
    public String getPaymentKey() { return paymentKey; }
    @JsonProperty("payment_key")
    public void setPaymentKey(String value) { this.paymentKey = value; }

    @JsonProperty("save_card_default")
    public boolean getSaveCardDefault() { return saveCardDefault; }
    @JsonProperty("save_card_default")
    public void setSaveCardDefault(boolean value) { this.saveCardDefault = value; }

    @JsonProperty("show_save_card")
    public boolean getShowSaveCard() { return showSaveCard; }
    @JsonProperty("show_save_card")
    public void setShowSaveCard(boolean value) { this.showSaveCard = value; }

    @JsonProperty("theme_color")
    public Integer getThemeColor() { return themeColor == null ? null : Color.parseColor(themeColor) ; }
    @JsonProperty("theme_color")
    public void setThemeColor(String value) { this.themeColor = value; }

    @JsonProperty("language")
    public String getLanguage() { return language; }
    @JsonProperty("language")
    public void setLanguage(String value) { this.language = value; }

    @JsonProperty("actionbar")
    public boolean getActionbar() { return actionbar; }
    @JsonProperty("actionbar")
    public void setActionbar(boolean value) { this.actionbar = value; }

    @JsonProperty("token")
    public String getToken() { return token; }
    @JsonProperty("token")
    public void setToken(String value) { this.token = value; }

    @JsonProperty("masked_pan_number")
    public String getMaskedPanNumber() { return maskedPanNumber; }
    @JsonProperty("masked_pan_number")
    public void setMaskedPanNumber(String value) { this.maskedPanNumber = value; }

    @JsonProperty("customer")
    public Customer getCustomer() { return customer; }
    @JsonProperty("customer")
    public void setCustomer(Customer value) { this.customer = value; }
}
