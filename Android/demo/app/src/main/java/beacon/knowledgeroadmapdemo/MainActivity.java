package beacon.knowledgeroadmapdemo;

import androidx.appcompat.app.AppCompatActivity;
import beacon.knowledgeroadmapdemo.constraintlayout.ConstraintLayoutActivity;
import beacon.knowledgeroadmapdemo.constraintlayout.LayoutPerformanceActivity;

import android.app.Activity;
import android.content.Intent;
import android.content.res.Resources;
import android.graphics.Color;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {
    private static PageConfig[] pages = new PageConfig[]{
            new PageConfig("约束布局", ConstraintLayoutActivity.class),
            new PageConfig("约束布局性能测试", LayoutPerformanceActivity.class)
    };

    private LinearLayout container;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        container = findViewById(R.id.container);
        initView();
    }

    private void initView(){
        LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, dpToPixel(40));
        layoutParams.topMargin = dpToPixel(10);
        for(PageConfig pageConfig : pages){
            container.addView(createPageItemView(pageConfig), layoutParams);
        }
    }

    private View createPageItemView(PageConfig pageConfig){
        TextView textView = new TextView(this);
        textView.setText(pageConfig.description);
        textView.setTextColor(Color.WHITE);
        textView.setBackgroundColor(Color.parseColor("#ff33b5e5"));
        textView.setPadding(dpToPixel(10), 0, 0, 0);
        textView.setGravity(Gravity.CENTER_VERTICAL);
        textView.setTag(pageConfig);
        textView.setOnClickListener(this);
        return textView;
    }

    @Override
    public void onClick(View v) {
        PageConfig pageConfig = (PageConfig) v.getTag();
        if(pageConfig != null){
            startActivity(new Intent(this, pageConfig.activityClass));
        }
    }

    private int dpToPixel(float dp) {
        final DisplayMetrics metrics = getResources().getDisplayMetrics();
        return (int)(dp * (metrics.densityDpi / 160f));
    }

    private static class PageConfig{
        String description;
        Class<? extends Activity> activityClass;

        public PageConfig(String description, Class<? extends Activity> activityClass) {
            this.description = description;
            this.activityClass = activityClass;
        }
    }
}
