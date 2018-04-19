package ${packageName}

import android.os.Bundle
import com.blackbox.medicalpension.common.mvp.base.BaseCommonActivity
import com.blackbox.medicalpension.common.mvp.mvp.BasePresenter

import kotlinx.android.synthetic.main.${layoutName}.*



class ${activityClass} : BaseCommonActivity(){
	
	override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.${layoutName})
        initTitleWithBack("${titleName}")
    }
	
     override fun createPresenter(): MutableList<BasePresenter<*>> ?{
        return null
    }
}