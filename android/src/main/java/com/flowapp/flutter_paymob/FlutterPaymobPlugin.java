package com.flowapp.flutter_paymob;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;

import com.flowapp.flutter_paymob.models.payment.*;
import com.paymob.acceptsdk.IntentConstants;
import com.paymob.acceptsdk.PayActivity;
import com.paymob.acceptsdk.PayActivityIntentKeys;
import com.paymob.acceptsdk.ThreeDSecureWebViewActivty;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.Set;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;

/**
 * FlutterPaymobPlugin
 */
public class FlutterPaymobPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity

    // Arbitrary number and used only in this activity. Change it as you wish.
    static final int ACCEPT_PAYMENT_REQUEST = 10;
    private MethodChannel channel;
    private Activity activity;
    private Context context;
    private Result pendingResult;

    public void StartPayActivityNoToken(Payment payment) {
        Intent pay_intent = createIntent(payment);

        activity.startActivityForResult(pay_intent, ACCEPT_PAYMENT_REQUEST);
        Intent secure_intent = new Intent(context, ThreeDSecureWebViewActivty.class);
        secure_intent.putExtra("ActionBar", payment.getActionbar());
    }

    public void StartPayActivityToken(Payment payment) {
        Intent pay_intent = createIntent(payment);

        pay_intent.putExtra(PayActivityIntentKeys.TOKEN, payment.getToken());
        // card masked Pan in case of saved card.

        if (payment.getMaskedPanNumber() != null) {
            pay_intent.putExtra(PayActivityIntentKeys.MASKED_PAN_NUMBER, payment.getMaskedPanNumber());
        }

        if (payment.getCustomer() != null) {
            // this is the customer billing data, it should be passed, when paying with a saved Card.
            pay_intent.putExtra(PayActivityIntentKeys.FIRST_NAME, payment.getCustomer().getFirstName());
            pay_intent.putExtra(PayActivityIntentKeys.LAST_NAME, payment.getCustomer().getLastName());
            pay_intent.putExtra(PayActivityIntentKeys.BUILDING, payment.getCustomer().getBuilding());
            pay_intent.putExtra(PayActivityIntentKeys.FLOOR, payment.getCustomer().getFloor());
            pay_intent.putExtra(PayActivityIntentKeys.APARTMENT, payment.getCustomer().getApartment());
            pay_intent.putExtra(PayActivityIntentKeys.CITY, payment.getCustomer().getCity());
            pay_intent.putExtra(PayActivityIntentKeys.STATE, payment.getCustomer().getState());
            pay_intent.putExtra(PayActivityIntentKeys.COUNTRY, payment.getCustomer().getCountry());
            pay_intent.putExtra(PayActivityIntentKeys.EMAIL, payment.getCustomer().getEmail());
            pay_intent.putExtra(PayActivityIntentKeys.PHONE_NUMBER, payment.getCustomer().getPhoneNumber());
            pay_intent.putExtra(PayActivityIntentKeys.POSTAL_CODE, payment.getCustomer().getPostalCode());
        }

        activity.startActivityForResult(pay_intent, ACCEPT_PAYMENT_REQUEST);
    }

    private Intent createIntent(Payment payment) {
        Intent intent = new Intent(context, PayActivity.class);
        intent.putExtra(PayActivityIntentKeys.PAYMENT_KEY, payment.getPaymentKey());
        intent.putExtra(PayActivityIntentKeys.THREE_D_SECURE_ACTIVITY_TITLE, "Verification");
        // this key is used to define the language. takes for ex ("ar", "en") as inputs.
        intent.putExtra("language", payment.getLanguage());
        if (payment.getThemeColor() != null) {
            //this key is used to set the theme color(Actionbar, statusBar, button).
            intent.putExtra(PayActivityIntentKeys.THEME_COLOR, payment.getThemeColor());
        }
        // this key is to whether display the Actionbar or not.
        intent.putExtra("ActionBar", payment.getActionbar());
        // this key is used to display the "save card" checkbox.
        intent.putExtra(PayActivityIntentKeys.SHOW_SAVE_CARD, payment.getShowSaveCard());
        // this key is used to save the card by default.
        intent.putExtra(PayActivityIntentKeys.SAVE_CARD_DEFAULT, payment.getSaveCardDefault());
        return intent;
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_paymob");
        channel.setMethodCallHandler(this);
        context = flutterPluginBinding.getApplicationContext();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

        switch (call.method) {
            case "getPlatformVersion":
                result.success("Android " + android.os.Build.VERSION.RELEASE);
                break;
            case "StartPayActivityNoToken":
                try {
                    pendingResult = result;
                    Payment payment = Converter.fromJsonString(String.valueOf(call.argument("payment")));
                    StartPayActivityNoToken(payment);
                } catch (IOException e) {
                    pendingResult.error("error", e.getMessage(), null);
                }
                break;
            case "StartPayActivityToken":
                try {
                    pendingResult = result;
                    Payment payment = Converter.fromJsonString(String.valueOf(call.argument("payment")));
                    StartPayActivityToken(payment);
                } catch (IOException e) {
                    pendingResult.error("error", e.getMessage(), null);
                }
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    private void finishWithSuccess(Bundle bundle) {
        JSONObject json = new JSONObject();
        Set<String> keys = bundle.keySet();
        for (String key : keys) {
            try {
                json.put(key, bundle.get(key));
            } catch(JSONException e) {
                //Handle exception here
            }
        }
        pendingResult.success(json.toString());
    }

    private void finishWithError(String errorCode, String errorMessage, String details) {
        pendingResult.error(errorCode, errorMessage, null);
    }


    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
        Bundle extras = data.getExtras();
        if (requestCode == ACCEPT_PAYMENT_REQUEST) {

            if (resultCode == IntentConstants.USER_CANCELED) {
                // User canceled and did no payment request was fired
                finishWithError("USER_CANCELED", "User canceled!!", null);
            } else if (resultCode == IntentConstants.MISSING_ARGUMENT) {
                // You forgot to pass an important key-value pair in the intent's extras
                finishWithError("MISSING_ARGUMENT", "Missing Argument == " + extras.getString(IntentConstants.MISSING_ARGUMENT_VALUE), null);
            } else if (resultCode == IntentConstants.TRANSACTION_ERROR) {
                // An error occurred while handling an API's response
                finishWithError("TRANSACTION_ERROR", "Reason == " + extras.getString(IntentConstants.TRANSACTION_ERROR_REASON), null);
            } else if (resultCode == IntentConstants.TRANSACTION_REJECTED) {
                // User attempted to pay but their transaction was rejected

                // Use the static keys declared in PayResponseKeys to extract the fields you want

//                finishWithError("TRANSACTION_REJECTED", extras.getString(PayResponseKeys.DATA_MESSAGE), null);
                finishWithSuccess(extras);
            } else if (resultCode == IntentConstants.TRANSACTION_REJECTED_PARSING_ISSUE) {
                // User attempted to pay but their transaction was rejected. An error occured while reading the returned JSON
                finishWithError("TRANSACTION_REJECTED_PARSING_ISSUE", extras.getString(IntentConstants.RAW_PAY_RESPONSE), null);
            } else if (resultCode == IntentConstants.TRANSACTION_SUCCESSFUL) {
                // User finished their payment successfullyTRANSACTION_SUCCESSFUL

                // Use the static keys declared in PayResponseKeys to extract the fields you want
                finishWithSuccess(extras);
            } else if (resultCode == IntentConstants.TRANSACTION_SUCCESSFUL_PARSING_ISSUE) {
                // User finished their payment successfully. An error occured while reading the returned JSON.
                finishWithError("TRANSACTION_SUCCESSFUL_PARSING_ISSUE", "TRANSACTION_SUCCESSFUL - Parsing Issue", null);
            } else if (resultCode == IntentConstants.TRANSACTION_SUCCESSFUL_CARD_SAVED) {
                // User finished their payment successfully and card was TRANSACTION_SUCCESSFUL_CARD_SAVED saved.
                finishWithSuccess(extras);
            } else if (resultCode == IntentConstants.USER_CANCELED_3D_SECURE_VERIFICATION) {

                // Note that a payment process was attempted. You can extract the original returned values
                // Use the static keys declared in PayResponseKeys to extract the fields you want
//                finishWithError("USER_CANCELED_3D_SECURE_VERIFICATION", "User canceled 3-d scure verification!!", extras.getString(PayResponseKeys.PENDING));
                finishWithSuccess(extras);
            } else if (resultCode == IntentConstants.USER_CANCELED_3D_SECURE_VERIFICATION_PARSING_ISSUE) {

                // Note that a payment process was attempted.
                // User finished their payment successfully. An error occured while reading the returned JSON.
                finishWithError("USER_CANCELED_3D_SECURE_VERIFICATION_PARSING_ISSUE", "User canceled 3-d scure verification - Parsing Issue!!", extras.getString(IntentConstants.RAW_PAY_RESPONSE));
            } else {
                return false;
            }
        }
        return true;
    }


    @Override
    public void onAttachedToActivity(ActivityPluginBinding activityPluginBinding) {
        // TODO: your plugin is now attached to an Activity
        activity = activityPluginBinding.getActivity();
        activityPluginBinding.addActivityResultListener(this);
    }


    @Override
    public void onDetachedFromActivityForConfigChanges() {
        // TODO: the Activity your plugin was attached to was
        // destroyed to change configuration.
        // This call will be followed by onReattachedToActivityForConfigChanges().
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding activityPluginBinding) {
        // TODO: your plugin is now attached to a new Activity
        // after a configuration change.
    }

    @Override
    public void onDetachedFromActivity() {
        // TODO: your plugin is no longer associated with an Activity.
        // Clean up references.

    }
}
