<?xml version="1.0"?>
<recipe>

	<instantiate from="root/src/app_package/LinActivity.${ktOrJavaExt}.ftl"
		to="${escapeXmlAttribute(srcOut)}/${activityClass}.${ktOrJavaExt}" />

	<instantiate from="root/res/layout/activity_lin.xml.ftl"
		to="${escapeXmlAttribute(resOut)}/layout/${layoutName}.xml" />

     <merge from="root/AndroidManifest.xml.ftl"
           to="${escapeXmlAttribute(manifestOut)}/AndroidManifest.xml" />
		   
</recipe>
