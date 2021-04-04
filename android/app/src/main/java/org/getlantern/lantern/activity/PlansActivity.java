package org.getlantern.lantern.activity;

import android.content.Intent;
import android.os.Bundle;
import android.text.SpannableString;
import android.text.Spanned;
import android.text.style.ForegroundColorSpan;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import androidx.appcompat.app.AlertDialog;
import androidx.core.content.ContextCompat;
import androidx.fragment.app.FragmentActivity;
import com.google.android.material.dialog.MaterialAlertDialogBuilder;
import com.google.gson.JsonObject;
import okhttp3.HttpUrl;
import okhttp3.Response;
import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Click;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.ViewById;
import org.getlantern.lantern.LanternApp;
import org.getlantern.lantern.R;
import org.getlantern.lantern.model.*;
import org.getlantern.lantern.util.DateUtil;
import org.getlantern.mobilesdk.Lantern;
import org.getlantern.mobilesdk.Logger;
import org.joda.time.LocalDateTime;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@EActivity(R.layout.activity_plan)
public class PlansActivity extends FragmentActivity {

    private static final String TAG = PlansActivity.class.getName();
    private static final LanternHttpClient lanternClient = LanternApp.getLanternHttpClient();

    private ConcurrentHashMap<String, ProPlan> plans = new ConcurrentHashMap<String, ProPlan>();

    @ViewById
    View itemPlanYear1;

    @ViewById
    View itemPlanYear2;

    @ViewById
    TextView tvRenew;

    @ViewById
    TextView tvYinbi;

    @ViewById
    ImageView imgvYinbiInfo;

    @ViewById
    View mostPopularYear1;

    @ViewById
    View mostPopularYear2;

    @ViewById
    View content;

    private TextView tvOneMonthCostFirst, tvTwoMonthCostSecond, tvDurationFirst, tvDurationSecond, tvTotalCostFirst, tvTotalCostSecond;
    private AlertDialog yinbiInfoDialog;

    @AfterViews
    void afterViews() {
        initViews();
        updatePlans();
        setPaymentGateway();
        sendScreenViewEvent();
    }

    @Click
    void itemPlanYear1() {
        selectPlan(itemPlanYear1);
    }

    @Click
    void itemPlanYear2() {
        selectPlan(itemPlanYear2);
    }

    @Click
    void imgvClose() {
        onBackPressed();
    }

    @Click
    void imgvYinbiInfo() {
        Utils.showAlertDialog(this, getString(R.string.yinbi_cryptocurrency), getString(R.string.the_yinbi_foundation_description),
            ContextCompat.getDrawable(this, R.drawable.ic_yinbi_small));
    }

    private void initViews() {
        tvOneMonthCostFirst = (TextView) itemPlanYear1.findViewById(R.id.tvCost);
        tvTwoMonthCostSecond = (TextView) itemPlanYear2.findViewById(R.id.tvCost);
        tvTotalCostFirst = (TextView) itemPlanYear1.findViewById(R.id.tvTotalCost);
        tvTotalCostSecond = (TextView) itemPlanYear2.findViewById(R.id.tvTotalCost);
        tvDurationFirst = (TextView) itemPlanYear1.findViewById(R.id.tvDuration);
        tvDurationSecond = (TextView) itemPlanYear2.findViewById(R.id.tvDuration);
        if (LanternApp.getSession().yinbiEnabled()) {
            tvYinbi.setVisibility(View.VISIBLE);
            imgvYinbiInfo.setVisibility(View.VISIBLE);
        } else {
            tvYinbi.setVisibility(View.GONE);
            imgvYinbiInfo.setVisibility(View.GONE);
        }
    }

    private void sendScreenViewEvent() {
        final String screenType;
        if (!LanternApp.getSession().isPlayVersion() && LanternApp.getSession().yinbiEnabled() && !LanternApp.getSession().isProUser()) {
            screenType = "yinbi_plans_view";
        } else {
            screenType = "plans_view";
        }
        Lantern.sendEvent(this, screenType);
    }

    protected void setPaymentGateway() {
        final Map<String, String> params = new HashMap<String, String>();
        params.put("appVersion", LanternApp.getSession().appVersion());
        params.put("country", LanternApp.getSession().getCountryCode());
        // send any payment provider we get back from Firebase to the pro
        // server
        params.put("remoteConfigPaymentProvider", LanternApp.getSession().getRemoteConfigPaymentProvider());
        params.put("deviceOS", LanternApp.getSession().deviceOS());
        final HttpUrl url = LanternHttpClient.createProUrl("/user-payment-gateway", params);
        lanternClient.get(url, new LanternHttpClient.ProCallback() {
            @Override
            public void onFailure(final Throwable throwable, final ProError error) {
                if (error != null) {
                    Logger.error(TAG, "Unable to fetch user payment gateway:" + error);
                }
            }
            @Override
            public void onSuccess(final Response response, final JsonObject result) {
                final Map<String, String> params = new HashMap<String, String>();

                try {
                    final String provider = result.get("provider").getAsString();
                    if (provider != null) {
                        Logger.debug(TAG, "Payment provider is " + provider);
                        LanternApp.getSession().setPaymentProvider(provider);
                    }
                } catch (Exception e) {
                    Logger.error(TAG, "Unable to fetch plans", e);
                    return;
                }
            }
        });
    }

    protected void updatePlans() {
        LanternApp.getPlans(new LanternHttpClient.PlansCallback() {
            @Override
            public void onFailure(final Throwable throwable, final ProError error) {
                if (error != null && error.getMessage() != null) {
                    Utils.showUIErrorDialog(PlansActivity.this, error.getMessage());
                }
            }
            @Override
            public void onSuccess(final Map<String, ProPlan> proPlans) {
                if (proPlans == null) {
                    return;
                }
                plans.clear();
                plans.putAll(proPlans);
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        for (String planId : proPlans.keySet()) {
                            updatePrice(proPlans.get(planId));
                        }
                    }
                });
            }
        });
    }

    protected void updatePrice(ProPlan plan) {
        content.setVisibility(View.VISIBLE);
        String duration = getString(R.string.plan_duration, plan.numYears());
        String bonus = plan.getRenewalBonusExpected(this);
        String durationFormat = String.format("%s + %s", duration, bonus);
        CharSequence totalCost = getString(R.string.total_cost, plan.getCostWithoutTaxStr());
        if (plan.getDiscount() > 0) {
            totalCost += " - ";
            int startForegroundPos = totalCost.length();
            String discount = getString(R.string.discount, String.valueOf(Math.round(plan.getDiscount() * 100)));
            totalCost += discount;
            SpannableString totalCostSpanned = new SpannableString(totalCost);
            totalCostSpanned.setSpan(new ForegroundColorSpan(ContextCompat.getColor(this, R.color.secondary_pink)), startForegroundPos, totalCost.length(), Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
            totalCost = totalCostSpanned;
        }
        String oneMonth = plan.getFormatterPriceOneMonth();
        if (plan.numYears() == 1) {
            itemPlanYear1.setVisibility(View.VISIBLE);
            tvOneMonthCostFirst.setText(oneMonth);
            tvTotalCostFirst.setText(totalCost);
            itemPlanYear1.setTag(plan.getId());
            tvDurationFirst.setText(durationFormat);
            if (plan.isBestValue()) {
                mostPopularYear1.setVisibility(View.VISIBLE);
                itemPlanYear1.setSelected(true);
            }
        } else {
            itemPlanYear2.setVisibility(View.VISIBLE);
            tvTwoMonthCostSecond.setText(oneMonth);
            tvTotalCostSecond.setText(totalCost);
            itemPlanYear2.setTag(plan.getId());
            if (LanternApp.getSession().isProUser()) {
                tvRenew.setVisibility(View.VISIBLE);
                LocalDateTime localDateTime = LanternApp.getSession().getExpiration();
                if (DateUtil.INSTANCE.isToday(localDateTime)) {
                    tvRenew.setText(getString(R.string.membership_ends_today, bonus));
                } else if (DateUtil.INSTANCE.isBefore(localDateTime)) {
                    tvRenew.setText(getString(R.string.membership_has_expired, bonus));
                } else {
                    tvRenew.setText(getString(R.string.membership_end_soon, bonus));
                }
            } else {
                tvRenew.setVisibility(View.GONE);
            }
            if (plan.isBestValue()) {
                mostPopularYear2.setVisibility(View.VISIBLE);
                itemPlanYear2.setSelected(true);
                if (LanternApp.getSession().yinbiEnabled()) {
                    durationFormat += " + " + getString(R.string.free_extra_yinbi);
                }
            }
            tvDurationSecond.setText(durationFormat);
        }
    }

    private void selectPlan(View view) {
        if (view.getTag() == null) {
            return;
        }
        final String planId = (String) view.getTag();
        Logger.debug(TAG, "Plan selected: " + planId);

        final Bundle params = new Bundle();
        params.putString("plan_id", planId);
        params.putString("app_version", Utils.appVersion(this));
        Lantern.sendEvent(this, "plan_selected", params);

        LanternApp.getSession().setProPlan(plans.get(planId));
        startActivity(new Intent(this, CheckoutActivity_.class));
    }
}
