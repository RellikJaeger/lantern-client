package org.getlantern.lantern.fragment;

import android.app.Activity;
import android.content.res.TypedArray;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.text.Html;
import android.text.InputType;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.fragment.app.Fragment;

import java.util.Arrays;
import java.util.ArrayList;

import org.getlantern.lantern.LanternApp;
import org.getlantern.mobilesdk.Logger;
import org.getlantern.lantern.model.Utils;
import org.getlantern.lantern.R;

public class UserForm extends Fragment {
    private static final String TAG = "UserForm";

    private Button mSendBtn;
    private String mSendBtnText;
    private String mFormType;
    private EditText textInput;

    private CharSequence[] mFormDetails;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.user_form, container, true);

        mSendBtn = (Button)view.findViewById(R.id.sendBtn);
        if (mSendBtnText != null) {
            mSendBtn.setText(mSendBtnText);
        }

        if (mFormDetails != null) {

            TextView formDetails = (TextView)view.findViewById(R.id.formDetails);
            ArrayList<String> items = new ArrayList<String>();

            for (CharSequence s : Arrays.asList(mFormDetails)) {
                    items.add(s.toString());
            }
            formDetails.setText(Html.fromHtml(TextUtils.join("<br/>", items)));
        }

        textInput = (EditText)view.findViewById(R.id.email);
        LinearLayout normView  = (LinearLayout)view.findViewById(R.id.auth_device_view);

        View separator = view.findViewById(R.id.separator);

        if (mFormType != null) {
            if (mFormType.equals("verify")) {
                Logger.debug(TAG, "verify form type..");
                TextView updated = (TextView)view.findViewById(R.id.makeSureUpdated);
                if (updated != null)
                    updated.setVisibility(View.VISIBLE);
                Drawable icon = getContext().getResources().getDrawable(R.drawable.vcode);
                textInput.setCompoundDrawablesWithIntrinsicBounds(icon, null, null, null);
                textInput.setInputType(InputType.TYPE_CLASS_NUMBER);
            } else if (mFormType.equals("referral")) {
                textInput.setCompoundDrawablesWithIntrinsicBounds( R.drawable.star, 0, 0, 0);
                // Using setBackgroundDrawable to support API 15.
                mSendBtn.setBackgroundDrawable(getContext().getResources().getDrawable(R.drawable.text_invite));
                mSendBtn.setTextColor(getContext().getResources().getColor(R.color.pink));
            } else {
                Utils.configureEmailInput(textInput, separator);
            }
        }

        return view;
    }

    @Override
    public void onInflate(Activity activity, AttributeSet attrs, Bundle savedInstanceState) {

        super.onInflate(activity, attrs, savedInstanceState);

        TypedArray a = activity.obtainStyledAttributes(attrs,
                R.styleable.UserForm);

        mSendBtnText = a.getString(R.styleable.UserForm_sendBtnText);
        mFormType = a.getString(R.styleable.UserForm_formType);
        if (mFormType != null && mFormType.equals("referral")) {
            mFormDetails = LanternApp.getSession().getReferralArray(getResources());
        } else {
            mFormDetails = a.getTextArray(R.styleable.UserForm_formList);
        }
    }

    public String getUserInput() {
        if (textInput != null) {
            return textInput.getText().toString();
        }
        return null;
    }
}
