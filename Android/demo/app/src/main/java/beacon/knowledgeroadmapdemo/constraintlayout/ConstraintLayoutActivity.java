package beacon.knowledgeroadmapdemo.constraintlayout;

import android.os.Bundle;
import android.transition.TransitionManager;
import android.view.View;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.constraintlayout.widget.ConstraintSet;
import androidx.constraintlayout.widget.Group;
import beacon.knowledgeroadmapdemo.R;

/**
*
* @Author Mark.Yu
* @Date 2019/4/22
**/
public class ConstraintLayoutActivity extends AppCompatActivity {
    private TextView tvGoneMarginA;
    private TextView tvGoneMarginB;

    private TextView tvGroupController;
    private Group group;

    private TextView tvAnimation;

    private ConstraintSet constraintSet1 = new ConstraintSet();
    private ConstraintSet constraintSet2 = new ConstraintSet();
    private ConstraintLayout constraintLayout;
    private int currentLayoutId = R.layout.activity_constraintlayout;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_constraintlayout);
        initViews();

        constraintSet1.clone(this, R.layout.activity_constraintlayout);
        constraintSet2.clone(this, R.layout.activity_constraintlayout2);
    }

    private void initViews() {
        constraintLayout = findViewById(R.id.constraint_layout);

        tvGoneMarginA = findViewById(R.id.tv_gone_margin_a);
        tvGoneMarginB = findViewById(R.id.tv_gone_margin_b);
        tvGoneMarginB.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(tvGoneMarginA.getVisibility() == View.VISIBLE){
                    tvGoneMarginA.setVisibility(View.GONE);
                    tvGoneMarginB.setText("Show Left");
                } else {
                    tvGoneMarginA.setVisibility(View.VISIBLE);
                    tvGoneMarginB.setText("Gone Left");
                }
            }
        });

        tvGroupController = findViewById(R.id.tv_group_controller);
        group = findViewById(R.id.group);
        tvGroupController.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(group.getVisibility() == View.VISIBLE){
                    group.setVisibility(View.GONE);
                    tvGroupController.setText("Show Group");
                } else {
                    group.setVisibility(View.VISIBLE);
                    tvGroupController.setText("Gone Group");
                }
            }
        });

        tvAnimation = findViewById(R.id.tv_animation);
        tvAnimation.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                TransitionManager.beginDelayedTransition(constraintLayout);
                if(currentLayoutId == R.layout.activity_constraintlayout){
                    constraintSet2.applyTo(constraintLayout);
                    currentLayoutId = R.layout.activity_constraintlayout2;
                } else {
                    constraintSet1.applyTo(constraintLayout);
                    currentLayoutId = R.layout.activity_constraintlayout;
                }
            }
        });
    }


}
