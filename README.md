# 引言
Android Studio提供的代码模板可帮助我们减少重复编写同一段代码的负担，而且可以遵循优化后的设计和标准。AS采用的是[Apache FreeMarker](http://freemarker.org/)模板引擎。
在网上，关于模板开发的资料比较少，而且Studio版本较低，也缺少实际开发中很多功能的示例（比如说Studio在加入kotlin后，我们怎么生成kotlin的模板）。这篇文章将基于TemplateBuilder模板插件，简化模板生成的难度。
**环境：**
Android Studio 3.1.1
TemplateBuilder 2.0

# TemplateBuilder
简单介绍下TemplateBuilder的使用。
## 插件安装
在Studio菜单栏选择【File】-【Settings】，在左侧菜单中选择【Plugins】，点击【Browse repositories】。在弹出框中输入TemplateBuilder，点击安装并重启Studio后生效。
![这里写图片描述](https://img-blog.csdn.net/20180419115829829?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTA5ODcwMzk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
## 创建模板
#### 定义模板：
这里定义了activityName、textViewName变量，之后在生成模板时，由用户输入。
``` java
public class ${activityName} extends AppCompatActivity {
    private TextView ${textViewName};
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }
}
```
#### 生成模板
选中模板文件，按下【ALT + T】（或在Tools下选择Generate Template），配置模板信息
![这里写图片描述](https://img-blog.csdn.net/201804191240559?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTA5ODcwMzk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
##### 属性说明：
- **Template Category 对应模板的分类，对应选择导入模板时的模板分类，这里默认值是电脑的用户名。**
- **Template Name 对应模板名称，对应选择导入模板时的模板名称，默认值是当前的Project名称。**
- **Template Description 对应模板描述信息，对应导入模板时弹出的导入界面的文字描述，默认为空。**
- **Template Folder 对应生成模板所存放的位置，如果是Mac操作系统则默认为/Applications/Android Studio.app/Contents/plugins/android/lib/templates， Windows系统的话由于差异比较大，就默认为空了，可以自行配置[Android Studio安装目录]/plugins/android/lib/templates（这里只需要配置一次即可，插件将自动保存该位置）。**
- **Input data 配置模板变量**
在【Configure Template Data】下点击【add】配置刚才模板中定义的变量，配置完毕后点击【Finish】。
![这里写图片描述](https://img-blog.csdn.net/20180419125012700?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTA5ODcwMzk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
重启Studio后就可使用该自定义模板。
![这里写图片描述](https://img-blog.csdn.net/20180419125226632?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTA5ODcwMzk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
##### 关于Input data的使用，先解释下每个属性对应的含义
- **id 变量名，必须和模板中使用的变量名对应，必填**
- **name 变量简介，必填**
- **type 变量类型，string和boolean两种，通过下拉框选择，必填**
- **default 变量对应的默认值，选填**
- **help 添加该变量时的提示信息，选填**
# 定义模板
这里我使用TemplateBuilder插件生成mvp的模板。通过修改相关的属性，实现Activity和layout动态生成，并在AndroidManifest.xml中注册。最后添加kotlin的模板配置，这样模板最终完成。
## 创建Java模板
首先创建一个MVP的Activity，将动态的属性声明为变量。
``` java
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
```
创建对应的Layout布局文件

```
<?xml version="1.0" encoding="utf-8"?>
<android.support.constraint.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="@color/white">

    <include
        android:id="@+id/include_layout"
        layout="@layout/lin_title"
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        app:layout_constraintLeft_toLeftOf="parent"
        app:layout_constraintRight_toRightOf="parent"
        app:layout_constraintTop_toTopOf="parent" />

</android.support.constraint.ConstraintLayout>
```
## 模板生成
选中两个模板文件，点击【ALT + T】，弹出【Configure Template Data】窗口。定义activityClass、layoutName、titleName三个变量，并【Finish】，生成模板。
![这里写图片描述](https://img-blog.csdn.net/20180419130815864?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTA5ODcwMzk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
模板文件存放在...\Android Studio\plugins\android\lib\templates下
![这里写图片描述](https://img-blog.csdn.net/20180419131020722?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTA5ODcwMzk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
模板文件后缀名都是以【.ftl】结尾。

 - globals.xml.ftl 全局变量文件 存放的是一些全局变量
 - recipe.xml.ftl 配置要引用的模板路径以及生成文件的路径
 - template.xml 模板的配置信息,以及要输入的参数.定义了模板的流程框架 基本结构
 - template_blank_activity.png 显示的缩略图（只是展示用）
 - LinActivity.java.ftl Activity模板文件

#### 修改配置
进入到...\Android Studio\plugins\android\lib\templates\linw9目录下
##### 1.修改template.xml文件
为方便用户输入Activity名称或Layout名称，自动提示Layout或Activity名称，需要在文件中添加两个属性：
constraints="class|unique|nonempty"
suggest="\${layoutToActivity(layoutName)}"
suggest="\${activityToLayout(activityClass)}"
```
<?xml version="1.0"?>
<template
    format="5"
    revision="5"
    name="LinMvpActivity"
    minApi="7"
    minBuildApi="14"
    description="Mvp Activity">

    <category value="linw9" />
    <formfactor value="Mobile" />

    <!-- input data -->
    

    <parameter
        id="activityClass"
        name="Activity Name"
        type="string"
		constraints="class|unique|nonempty"
		suggest="${layoutToActivity(layoutName)}"
        default="MvpActivity"
        help="" />

    <parameter
        id="layoutName"
        name="Layout Name"
        type="string"
		constraints="layout|unique|nonempty"
        suggest="${activityToLayout(activityClass)}"
        default="activity_mvp"
        help="" />

    <parameter
        id="titleName"
        name="Title Name"
        type="string"
        default="Title"
        help="" />

    <!-- 128x128 thumbnails relative to com.puke.template.xml -->
    <thumbs>
        <!-- default thumbnail is required -->
        <thumb>template_cover.png</thumb>
    </thumbs>

    <globals file="globals.xml.ftl" />
    <execute file="recipe.xml.ftl" />

</template>
```
##### 2.修改AndroidManifest.xml文件
进入到...\Android Studio\plugins\android\lib\templates\linw9\LinMvpActivity\root 目录下，打开AndroidManifest.xml.ftl文件，修改内容让Studio自动注册Activity。需要注意的是：需要对AndroidManifest进行代码格式化（Format），不然使用的时候Studio可能会提示Merge。
只针对Java代码的模板到此结束，重新启动Studio后即可使用该模板。

```
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="${packageName}">

    <application>
        <activity android:name="${packageName}.${activityClass}">
            
        </activity>
    </application>
</manifest>
```
##### 3.增加Kotlin模板
在网上，我没有查找到关于Kotlin模板配置的相关文章，这里给大家讲解下我的方法。
我是通过学习Studio自带的模板，从中找到了配置Kotlin模板的方法，仅供大家参考。
###### 1.创建Kotlin模板
进入到...\Android Studio\plugins\android\lib\templates\linw9\LinMvpActivity\root\src\app_package目录下，直接创建kotlin模板
```
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
```

###### 2.修改recipe.xml.ftl
进入到...\Android Studio\plugins\android\lib\templates\linw9\LinMvpActivity目录下，打开recipe.xml.ftl
将java改为${ktOrJavaExt}变量。

```
<?xml version="1.0"?>
<recipe>

	<instantiate from="root/src/app_package/LinActivity.${ktOrJavaExt}.ftl"
		to="${escapeXmlAttribute(srcOut)}/${activityClass}.${ktOrJavaExt}" />

	<instantiate from="root/res/layout/activity_lin.xml.ftl"
		to="${escapeXmlAttribute(resOut)}/layout/${layoutName}.xml" />

     <merge from="root/AndroidManifest.xml.ftl"
           to="${escapeXmlAttribute(manifestOut)}/AndroidManifest.xml" />
		   
</recipe>
```
###### 3.修改globals.xml.ftl
进入到...\Android Studio\plugins\android\lib\templates\linw9\LinMvpActivity目录下，打开globals.xml.ftl
添加ktOrJavaExt变量声明：
![这里写图片描述](https://img-blog.csdn.net/20180419134151226?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTA5ODcwMzk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
	
```
<?xml version="1.0"?>
<globals>
	<#assign generateKotlin=(((includeKotlinSupport!false) || (language!'Java')?string == 'Kotlin'))>
    <global id="generateKotlin" type="boolean" value="${generateKotlin?string}" />
	<global id="ktOrJavaExt" type="string" value="${generateKotlin?string('kt','java')}" />
	
    <global id="resOut" value="${resDir}" />
    <global id="srcOut" value="${srcDir}/${slashedPackageName(packageName)}" />
    <global id="relativePackage" value="<#if relativePackage?has_content>${relativePackage}<#else>${packageName}</#if>" />
	
	 
</globals>
```
###### 4.结束
重启Studio后，就可以生成Java或Kotlin的代码。对于写的不好的地方，希望大家多提建议。

