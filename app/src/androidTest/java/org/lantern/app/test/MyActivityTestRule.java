package org.lantern.app.test;

import org.junit.runner.Description;
import org.junit.runners.model.Statement;

import androidx.test.rule.ActivityTestRule;
import androidx.test.InstrumentationRegistry;
import androidx.test.uiautomator.UiDevice;

import androidx.test.espresso.Espresso;
import androidx.test.espresso.FailureHandler;
import androidx.test.espresso.base.DefaultFailureHandler;

import android.content.Context;
import org.hamcrest.Matcher;
import android.view.View;
import android.app.Activity;
import java.lang.Throwable;
import java.io.File;


public class MyActivityTestRule<T extends Activity> extends ActivityTestRule<T> {

  UiDevice mDevice;
  
  public MyActivityTestRule(java.lang.Class<T> cls, boolean initialTouchMode, boolean launchActivity) {
    super(cls, initialTouchMode, launchActivity);
    mDevice = UiDevice.getInstance(InstrumentationRegistry.getInstrumentation());
  }

  public MyActivityTestRule(java.lang.Class<T> cls) {
    this(cls, false, true);
  }

  @Override
  public Statement apply(Statement base, Description description) {
    final String testClassName = description.getClassName();
    final String testMethodName = description.getMethodName();
    final Context context =  InstrumentationRegistry.getTargetContext();
    Espresso.setFailureHandler(new FailureHandler() {
      @Override public void handle(Throwable throwable, Matcher<View> matcher) {
        seq++;
        new DefaultFailureHandler(context).handle(throwable, matcher);
      }
    });
    return super.apply(base, description);
  }

  private static int seq;
}
