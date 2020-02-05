### HCI 学习笔记

#### 第一课 SnapMirror - BuffGold Project （SolidFire，HCI Snapmirror ONTAP）



很多用户已经在使用我们的ONTAP系列，并且其中有35%的用户都在使用SnapMirror功能，而且经过过去的数据分析，我们的SolidFire有相当一部分会75%卖给我们的ONTAP用户。所以为了提供给这些SolidFire用户一个更加高性价比的DR解决方案，我们推出了从SolidFire通过SnapMirror 到ONTAP的功能。

不需要SolidFire安装任何的新的License，只需要ONTAP上有一个SnapMirror License即可。配置可以通过SolidFire UI/API，或者ONTAP的CLI/API来设置。要求ONTAP版本在9.3以上，Element OS版本在10.1以上。目前是单向从 `SolidFire -> ONTAP`。但是是一个完整的DR解决方案。目前支持AFF和FAS系列，对于软件版本ONTAP Select 或者 ONTAP Cloud，AltaVault还不支持。对于HCI/SF集群之间的同步功能不受任何影响，并不是为了取代这个功能存在的。块卷之间的iSCSI或者FC。1：1的Replication，不支持级联。





OneCollect的1.2.1已经发布，其中包含了收集HCI的信息的新插件。通过OneCollect可以收集vSphere, ONTAP Select和底层的SolidFire的信息，使用XML的格式存放。

OneCollect的下载地址：

https://mysupport.netapp.com/tools/download/ECMLP2671381DT.html?productID=62128&pcfContentID=ECMLP2671381



CPOC:

[CPOC HCI LAB](http://booked.csopslabs.netapp.com/)

