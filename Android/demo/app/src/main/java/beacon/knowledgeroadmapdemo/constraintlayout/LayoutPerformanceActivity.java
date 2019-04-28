package beacon.knowledgeroadmapdemo.constraintlayout;

import android.os.AsyncTask;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import beacon.knowledgeroadmapdemo.R;

public class LayoutPerformanceActivity extends AppCompatActivity {
    private TextView testConstraintLayoutAtMostButton;
    private TextView testConstraintLayoutExactlyButton;
    private TextView testTraditionalLayoutAtMostButton;
    private TextView testTraditionalLayoutExactlyButton;
    private TextView testResultText;

    private static int TOTAL = 1000;
    private static int WIDTH = 1920;
    private static int HEIGHT = 1080;

    private MeasureLayoutAsyncTask runningTask;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_layout_performance);

        testConstraintLayoutAtMostButton = findViewById(R.id.tv_test_constraint_layout_at_most);
        testConstraintLayoutExactlyButton = findViewById(R.id.tv_test_constraint_layout_exactly);
        testTraditionalLayoutAtMostButton = findViewById(R.id.tv_test_traditional_layout_at_most);
        testTraditionalLayoutExactlyButton = findViewById(R.id.tv_test_traditional_layout_exactly);
        testResultText = findViewById(R.id.tv_test_result);

        testConstraintLayoutAtMostButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                testResultText.setText("Testing");
                runningTask = new MeasureLayoutAsyncTask(R.layout.performance_constraint_layout, View.MeasureSpec.AT_MOST);
                testConstraintLayoutAtMostButton.setEnabled(false);
                testConstraintLayoutExactlyButton.setEnabled(false);
                testTraditionalLayoutAtMostButton.setEnabled(false);
                testTraditionalLayoutExactlyButton.setEnabled(false);
                runningTask.execute();
            }
        });

        testConstraintLayoutExactlyButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                testResultText.setText("Testing");
                runningTask = new MeasureLayoutAsyncTask(R.layout.performance_constraint_layout, View.MeasureSpec.EXACTLY);
                testConstraintLayoutAtMostButton.setEnabled(false);
                testConstraintLayoutExactlyButton.setEnabled(false);
                testTraditionalLayoutAtMostButton.setEnabled(false);
                testTraditionalLayoutExactlyButton.setEnabled(false);
                runningTask.execute();
            }
        });

        testTraditionalLayoutAtMostButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                testResultText.setText("Testing");
                runningTask = new MeasureLayoutAsyncTask(R.layout.performance_traditional_layout, View.MeasureSpec.AT_MOST);
                testConstraintLayoutAtMostButton.setEnabled(false);
                testConstraintLayoutExactlyButton.setEnabled(false);
                testTraditionalLayoutAtMostButton.setEnabled(false);
                testTraditionalLayoutExactlyButton.setEnabled(false);
                runningTask.execute();
            }
        });

        testTraditionalLayoutExactlyButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                testResultText.setText("Testing");
                runningTask = new MeasureLayoutAsyncTask(R.layout.performance_traditional_layout, View.MeasureSpec.EXACTLY);
                testConstraintLayoutAtMostButton.setEnabled(false);
                testConstraintLayoutExactlyButton.setEnabled(false);
                testTraditionalLayoutAtMostButton.setEnabled(false);
                testTraditionalLayoutExactlyButton.setEnabled(false);
                runningTask.execute();
            }
        });
    }

    @Override
    protected void onPause() {
        super.onPause();
        if(runningTask != null && !runningTask.isCancelled()){
            runningTask.cancel(true);
            runningTask = null;
        }
    }

    /**
     * AsyncTask that triggers measure/layout in the background. Not to leak the Context of the
     * Views, take the View instances as WeakReferences.
     */
    private class MeasureLayoutAsyncTask extends AsyncTask<Void, Void, Boolean> {
        private int layoutId;
        private int measureMode;
        private volatile long totalMeasureDuration;

        public MeasureLayoutAsyncTask(int layoutId, int measureMode){
            super();
            this.layoutId = layoutId;
            this.measureMode = measureMode;
        }

        @Override
        protected Boolean doInBackground(Void... voids) {
            for(int i=0; i<TOTAL; i++){
                if(isCancelled()){
                    return false;
                }

                //每次重新创建布局实例，防止测量缓存导致时间上的偏差
                View view = LayoutInflater.from(LayoutPerformanceActivity.this)
                        .inflate(layoutId, null);
                long startTime = System.nanoTime();
                measureAndLayout(view, measureMode);
                totalMeasureDuration += System.nanoTime() - startTime;
            }
            return true;
        }

//        @Override
//        protected void onProgressUpdate(Integer... values) {
//            //每次重新创建布局实例，防止测量缓存导致时间上的偏差
//            View view = LayoutInflater.from(LayoutPerformanceActivity.this)
//                    .inflate(layoutId, null);
//            long startTime = System.nanoTime();
//            measureAndLayout(view, measureMode);
//            totalMeasureDuration += System.nanoTime() - startTime;
//        }

        @Override
        protected void onPostExecute(Boolean success) {
            if(success){
                testResultText.setText("平均布局时间:" + (totalMeasureDuration/TOTAL) + "ns");
            }
            testConstraintLayoutAtMostButton.setEnabled(true);
            testConstraintLayoutExactlyButton.setEnabled(true);
            testTraditionalLayoutAtMostButton.setEnabled(true);
            testTraditionalLayoutExactlyButton.setEnabled(true);
        }

        private void measureAndLayout(View view, int measureMode) {
            int widthMeasureSpec = View.MeasureSpec.makeMeasureSpec(WIDTH, measureMode);
            int heightMeasureSpec = View.MeasureSpec.makeMeasureSpec(HEIGHT, measureMode);
            view.measure(widthMeasureSpec, heightMeasureSpec);
            view.layout(0, 0, view.getMeasuredWidth(), view.getMeasuredHeight());
        }
    }
}
