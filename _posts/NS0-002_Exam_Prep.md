## NS0-002 Exam Prep

#### StorageGrid Fundamentals

StorageGrid由多个不同的节点组成Grid，协同工作管理和存储对象数据。

管理节点负责管理整个Grid；存储节点负责向磁盘存储对象数据；Archive节点(可选)负责向磁带存储数据。API Gateway Node(可选)，负载均衡。



和StorageGrid进行数据交互的方式有两种API：

1. 通过S3存储协议
2. 通过OpenStack Swift存储协议



另外一个核心概念是Meta Data ILM，通过ILM来管理数据进入Grid的时候，这些数据的生命周期的管理。例如，数据存放在什么地方，如何存放，有几个副本等等。



数据由对象本身，和描述对象的Meta-Data组成。



![image-20190701103751338](../../../../Library/Application Support/typora-user-images/image-20190701103751338.png)





一个对象或者存放在S3 Bucket(桶)里面，或者放到Swift Container(容器)中。

Bucket和Container属于一个Tenant，一个Grid可以包含多个Tenant。



![image-20190701104039227](../../../../Library/Application Support/typora-user-images/image-20190701104039227.png)





![image-20190701104504894](../../../../Library/Application Support/typora-user-images/image-20190701104504894.png)







ILM可以理解为Ingesting数据的过滤器，根据用户设定的规则，对数据进行操作。



Grid可以跨数据中心，对象和Meta-Data在数据中心之间进行保护，通过ILM规则。



![image-20190701104851545](../../../../Library/Application Support/typora-user-images/image-20190701104851545.png)





至少有一个Admin Node，每一个Grid系统有个Primary Admin Node，可以有多个Admin Node，但是不支持Failover。Storage Node最少有3个，可以跨不同的区域的不同的Site。



为了提高性能，可以使用外部的LB。也可以使用StorageGrid Gateway Node。



StorageGrid有3中部署方式：



![image-20190701105303112](../../../../Library/Application Support/typora-user-images/image-20190701105303112.png)



除了API之外，如果NFS和SMB的客户端想访问StorageGrid上的数据，可以通过NAS Bridge来实现。



![image-20190701105857362](../../../../Library/Application Support/typora-user-images/image-20190701105857362.png)





管理方式：

- Management Interface
- API - 3rd Party

![image-20190701110101496](../../../../Library/Application Support/typora-user-images/image-20190701110101496.png)



* Grid - 类似ONTAP中的Cluster
* Tenant - 类似ONTAP中的SVM

都可以通过各自的Web管理界面或者API进行管理



至少要创建一个Tenant account，客户端才可以向Grid存取数据。



监控功能：



![image-20190701111510597](../../../../Library/Application Support/typora-user-images/image-20190701111510597.png)



**ILM** -  Information lifecycle management is a set of rules that determins how objects are created, distributed, and managed over time.



![image-20190701111643543](../../../../Library/Application Support/typora-user-images/image-20190701111643543.png)



x![image-20190701112117152](../../../../Library/Application Support/typora-user-images/image-20190701112117152.png)





![image-20190701112321798](../../../../Library/Application Support/typora-user-images/image-20190701112321798.png)



![image-20190701112447188](../../../../Library/Application Support/typora-user-images/image-20190701112447188.png)





ILM Rule: 

- 最先match的规则生效
- 对Ingest的对象的Meta-Data做检查，看符合那一条规则
- 必须至少有一个默认的规则，当安装完StorageGrid后，默认的规则是存放两个副本



客户端通过HTTP发送PUT指令，存放对象。Storage Grid默认会把数据存放在同一个Site中的两个存储节点上，以保留2个副本。并返回给客户端一个该对象的UID。客户端通过这个UID进行后面的访问。这称为Dual Commit。Dual Commit发生在ILM之前。



![image-20190701113254182](../../../../Library/Application Support/typora-user-images/image-20190701113254182.png)





应该说当数据首次进入Grid之前，还没有存储为对象。只有进入了系统，通过Dual commit之后，生成了UID之后，才成为一个对象。而ILM此时才能够根据该对象的Meta-Data进行数据的生命周期管理。



如上面的例子，数据完成首次存放后，ILM会根据Meta-Data进行评估，按照规则进行存放。

一个副本放到Vancouver，一个副本放到Paris，还有一个磁带副本放到Tokyo。完成后，Dual Commit中的另一个副本就不再需要，被删除。



![image-20190701113812730](../../../../Library/Application Support/typora-user-images/image-20190701113812730.png)





另外一种保护方式是通过Erasure Coding。



![image-20190701114127621](../../../../Library/Application Support/typora-user-images/image-20190701114127621.png)





客户端还可以通过GET指令获取数据，优先会得到磁盘的数据。如果所有磁盘都没有该对象，则通过磁带获取。



客户端还可以通过DELETE指令，删除对象。删除对象意味着Grid会把所有副本都删除。删除的方式是先删除对象的Object Key，此时对客户端已经不可见。然后ILM会评估，然后删除对象和Meta-data。



Cloud Strorage Pool：

可以减少本地的数据占用

Metadata依然留在本地，对象数据本身可以移动到Cloud Storage Pool，例如Amazon S3。







