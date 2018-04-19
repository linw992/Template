package ${packageName};

import android.os.Bundle;
import com.blackbox.medicalpension.common.mvp.base.BaseCommonActivity;
import com.blackbox.medicalpension.common.mvp.mvp.BasePresenter;

import org.jetbrains.annotations.Nullable;

import java.util.List;

public class ${activityClass} extends BaseCommonActivity{

	@Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.${layoutName});
		initTitleWithBack("${titleName}");
    }
	
    @Nullable
    @Override
    public List<BasePresenter<?>> createPresenter() {
        return null;
    }
}