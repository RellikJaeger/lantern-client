 package org.getlantern.lantern.activity;

import android.graphics.Bitmap;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.EActivity;

import org.getlantern.lantern.LanternApp;
import org.getlantern.lantern.R;
import org.getlantern.mobilesdk.Logger;
import org.getlantern.lantern.model.PaymentHandler;
import org.getlantern.lantern.model.LanternHttpClient;
import org.getlantern.lantern.model.ProPlan;
import org.getlantern.mobilesdk.model.SessionManager;

import java.util.Locale;
import java.util.Map;
import java.util.HashMap;

import okhttp3.HttpUrl;

@EActivity(R.layout.webview)
public class Gate2ShopActivity extends WebViewActivity {
    private static final String TAG = Gate2ShopActivity.class.getName();
    private static final String PROVIDER = "Gate2Shop";
    private static final SessionManager session = LanternApp.getSession();

    private PaymentHandler paymentHandler;

    private HttpUrl buildUrl() {
        final ProPlan proPlan = session.getSelectedPlan();
        if (proPlan == null) {
            Logger.error(TAG, "Could not find selected pro plan");
            return null;
        }

        final String planId = proPlan.getId();
        final Map<String, String> params = new HashMap<String, String>();
        params.put("email", session.email());
        params.put("widgetKey", "m2_1");
        params.put("deviceName", session.deviceName());
        params.put("forcePaymentProvider", "gate2shop");
        params.put("platform", "android");
        params.put("locale", lang());
        params.put("currency", session.getSelectedPlanCurrency().toLowerCase());
        params.put("plan", planId);
        return LanternHttpClient.createProUrl("/payment-gateway-widget", params);
    }

    private String lang() {
        final Locale locale = new Locale(session.getLanguage());
        final String locLang = locale.getLanguage();
        final String country = locale.getCountry();
        if (locLang.equalsIgnoreCase("zh")) {
            if (country.equalsIgnoreCase("CN")) {
                return "zh_CN";
            } else if (country.equalsIgnoreCase("TW")) {
                return "zh_TW";
            } else {
                return "zh_CN";
            }
        } else if (locLang.equals("pt") && country.equalsIgnoreCase("BR")) {
            return "pt_BR";
        }
        return locLang;
    }


    @AfterViews
    void afterViews() {
        final HttpUrl url = buildUrl();
        if (url == null) {
            Logger.error(TAG, "Unable to construct url");
            return;
        }
        paymentHandler = new PaymentHandler(this, PROVIDER);
        setWebViewClient();
        openWebview(url.toString());
    }

    private void purchaseSuccess(final String url) {
        paymentHandler.sendPurchaseRequest();
    }

    private void setWebViewClient() {
        webView.setWebViewClient(new WebViewClient() {
            @Override
            public void onPageFinished(WebView view, String url) {
                super.onPageFinished(view, url);
                if (url.contains("gate2shop-success")) {
                    hideProgressDialog();
                    purchaseSuccess(url);
                    return;
                }
            }
            @Override
            public void onPageStarted(WebView view, String url, Bitmap favicon)
            {
                showProgressDialog();
            }
        });

    }
}  
