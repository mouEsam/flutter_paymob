package com.flowapp.flutter_paymob.models.result;

import com.fasterxml.jackson.annotation.*;

public class PaymentResult {
    private String dataMessage;
    private String token;
    private String maskedPan;

    @JsonProperty("data_message")
    public String getDataMessage() { return dataMessage; }
    @JsonProperty("data_message")
    public void setDataMessage(String value) { this.dataMessage = value; }

    @JsonProperty("token")
    public String getToken() { return token; }
    @JsonProperty("token")
    public void setToken(String value) { this.token = value; }

    @JsonProperty("masked_pan")
    public String getMaskedPan() { return maskedPan; }
    @JsonProperty("masked_pan")
    public void setMaskedPan(String value) { this.maskedPan = value; }
}
