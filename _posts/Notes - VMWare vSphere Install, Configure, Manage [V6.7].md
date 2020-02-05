

### Notes - VMWare vSphere Install, Configure, Manage [V6.7] 

- Instructor: 高金良 gaojinliang@easthome.com
- Licenses：

- VCS6-STD-C VMware vCenter Server 6 Standard for vSphere 6 – 2 instance license key - 
  `4H093-XC384-W8N9D-0R82K-9DE0H`

- VS6-EPL-C VMware vSphere 6 Enterprise Plus for 10 processors - 2 keys - 
  `04203-QYH9K-88T85-0PC02-11X7P`

##### Day 1 - Jun 10th

50%讲课，50%实验

出勤率需要80%以上。考试记录和培训记录都要有，才能有证书。

==至少做3遍实验==。

两台主机，第一遍，看实验手册。第二遍，不看手册做。

第三遍，整个实验做完用5分钟回顾。



**VMWare 认证级别和方向： 4个认证5个方向** 

VCA/VCP/VCAP/VCDX

小学/中学/高中/大学

VCP方向：==本次课程DCV，数据中心虚拟化==

DCV/CMA/DTM/NV/DW...

VMWare的背景介绍，目前的方向。

虚拟化起家，1998年在美国成立。==VMWare对自己的定位，混合云数据中心解决方案==。

- SDDC - 软件定义的数据中心

- SDC - 软件定义计算 由**vSphere**来实现；**ESXi**，虚拟化操作系统；**vCenter**，虚拟化管理软件，统一管理物理服务器，多主机的管理和融合。`vSphere = ESXi + VC+ vR + VUM + ...`

  - Server-OS-App

  - Server-OS(ESXi)-VM1-OS-App1

    ​			   -VM2-OS-App2

    ​                …… (**v6.7单个Host最多可以放1024个虚拟机**)

  - Pools - 虚拟资源池，公平共享，公平竞争，在资源不够的情况下依然可以合理分配资源

  vSphere的相关课程：
  - **ICM(本课程)**
  - 优化
  - 设计
  - Troubleshooting

- SDN：NSX-V/NSX-T 软件定义网络

- SDS: vSAN/VVOL 软件定义存储，分布式聚合存储，vSAN和vSphere的版本相同，也是6.7。目前买horizon送vSAN。目前70-80%跑的都是关键业务，刚推出的时候不建议跑关键业务。VVOL免费。

- EUC: Horizon/View，目前版本7.7

- Hybrid Cloud：

  云计算：把资源以服务的形式交付给客户

  VRealize Suites:私有云套件

  * Automation: vRA (自动化)
  * Business: vRB (财务分析，成本核算)
  * Operations： vRO/vRops (性能分析；容量分析；Troubleshooting；成本分析)

  公有云部分，采用和公有云例如AWS合作的方式，租用AWS的数据中心的方式，里面运行VMware的软件。可以实现无缝上云，无缝管理。vSphere成为混合云操作系统。国内和阿里云，腾讯云合作。

- DW：Workspace ONE 使用了Airwatch，通过15.4亿美金买了Airwatch。移动端的统一化管理。自动对手机推送管理配置，邮箱自动配置等等。

###### Lesson 1：Overview of vSphere and Virtual Machines

关于VM，虚拟机是一个个的目录，通过文件进行管理。

- 操作系统 - Guest OS
- VMWare Tools：驱动，提高性能；增加功能，让Hypervisor可以了解虚机，相当于一个agent
- Virtual Resources

**CPU：**

- PCPU：纯物理CPU
- LCPU：超线程
- VCPU：虚拟CPU，最大数量 <= LCPU的数量



**物理内存：**

- 虚拟内存：可以分配超过物理内存的最大容量
- vSWAP：交换文件，通过硬盘来支持更大的内存



**网络：虚拟交换机，Virtual Switch**

- 虚拟交换机上连接物理网卡的端口：uplink (上行端口)
- 和虚拟机连接的端口：虚拟机端口组 (VM Port Group)

**存储和Datastore：**

	- VFMS，NFS，vS，VVol
	- Datastore

**管理客户端**

- VMWare Host Client
- vSphere Web Client
- vSphere Client

   都是基于浏览器的。



   **5.0-5.1-5.5-6.0:**

- vSphere Client (安装版)
- vSphere Web Client (Flash)

   **6.5:**

- vSphere Web Client (Flash) — VC

- Host Client (HTML5) — 连ESCi主机

- vSphere Client (HTML5) — VC

  安装版已经删除

   **6.7U1：**100%的Flash版本的功能都具备了



   本次课程Flash和HTML5的都会用到。



虚拟机文件：

- Configuration File - VM_name.vmx
- Swap Files: VM_name.vswap,vmx-VM_name.vswap
- Virtual Disk File: 
  - Disk descriptor file, VM_name.vmdk (描述文件) 
  - Disk Data file，VM_name-flat.vmdk(数据文件)

虚拟硬件版本：每个ESXi会对应一个硬件版本。解决兼容性问题，不同版本vSphere混合的时候，创建虚拟机需要选择最低的虚拟硬件版本。



磁盘模式：独立磁盘（不支持快照）,永久独立，非永久独立（VM掉电数据丢失），从属磁盘(支持全功能，快照)



Disk Provisioning：

- Thick Provisioning:业务有频繁写入的时候，采用此种方式。==性能更好==。
- Thin Provisioning：业务写操作比较少。

网络：

- 有几种类型，推荐VMXNET3，10G网络。需要VMWare Tools，支持更多的功能，例如Jumbo Frame。
- SR-IOV pass-through:跳过VMKernel直接让虚拟网卡和物理网卡直接通讯。Single Root。

实验环境：



###### Lesson 2 - Overview of ESXi

ESX = VMKernel + Service Console(Redhat)

5.0之后把Service Console拿掉，通过开源的Busybox来实现。

ESXi = VMKernel + Busybox (ls/cat/more...)



==作业1：通过U盘，安装ESXi。1个U盘是安装盘，1个大U盘是安装好的==

[安装方法](https://kb.vmware.com/s/article/2004784)



DCUI - Direct Console UI,上灰下黄的界面，里面包含主机的管理地址。**F12**关机，**F2** 进入系统设置页面，类似于BIOS设置。



==作业2：密码的设置(看KB，四种模式) 2-42== 



Lockdown mode：2种模式，加入VC后才可以配置。

- Normal: 通过VC和DCUI可以连接主机
- Strict: 只能借助于VC
- 如果disable，各种方式都可以

如果VC坏了，可以通过设置白名单，设置后门，通过SSH的方式访问主机，以便于应急使用。



Security Profile:防火墙，缺省打开。

**Hostd**：守护进程 —— Host Client



多数据中心管理的最佳实践：

- RBAC： 

  - 总管理员+各个分管理员
  - 用户来源问题
  - 身份源问题

  root@ESXi

  root@localOS (VC localUser 源)

  administrator@vsphere.local

  NTP：时间同步

6.7新功能

- ESXi Quick Boot

###### Lesson 3 - Creating Virtual Machines

- 基本有三种方法创建VM。
  - 手动创建
  - 基于模板
  - 使用OVF

OVF - 开放式虚拟机格式 **Open Virtual Machine Format**

VM = OS + APP —> OVF 文件夹



解决了linux安装的复杂性。

Linux + APP ===> OVF，导入vSphere平台

Profile / Install.exe 可以根据自己需要让OVF更加个性化。

OVA文件：利用Tar格式把OVF归档成一个文件



VMWare Tools：ESXi安装完成后，会有相应的Tools文件夹。虚拟机安装tools时，直接从这些地方挂在Tools。



==作业3：Tools放到了各种操作系统的哪个文件夹中。==



###### Lesson 4 - vCenter

**VC的功能**

- 集中管理
- 高级功能

部署VC有两种：Windows or Linux



5.0/5.1/5.5：

- Windows VC (功能更强)
- Linux VC (SUSE)

6.0

Windows VC = Linux VC (SUSE)



6.5/6.7

Windows VC < Linux VC (Photon - VMWare的Linux)，vUM vSphere Update Manager,内嵌到了VCSA Applicance(OVF) 里面。

6.7是最后一个版本的Windows VC。



7.0

Linux VC only



**VC的两大模块：**

- PSC模块 - Platform Services Controller
- vCenter Server

可以把两个模块部署到同一台主机(嵌入式部署)，也可以分开部署(分布式部署)。



Auto Deploy：把ESXi部署到内存的组件。



安装VC时，最小的单位就是模块，PCS和VC。



内部进程：

- vpxd: vCenter Server的服务进程 
- vpxa:ESXi和VC的通讯进程
- hostd:ESXi的守护进程

**vCenter Server Appliance - VCSA**

6.5加入了更多的功能，比如VC 的HA。

使用内置数据库。不再适用外置DB。



link mode：可以让一个PCS链接多个VC，多个VC之间共享license和清单列表。

环境太大，超过单个VC的管理数量2000个。

合规性要求，例如多个DC，每个DC需要一个单独的VC管理。



VC的API



Native HA架构：AP的架构

一般是在一个机房。



**部署VC：**

- 满足基本的硬件要求
- VCSA的域名FQDN
- Deploy模式，嵌入式还是分布式
- 时间同步

安装分为两个阶段：

- 安装OVF
- 配置SSO

分布式部署：需要启动三次向导。

* Step 1：部署PSC
* Step 2：部署VC1
* Step 3：部署VC2

VC:5480设备管理界面。



##### Day 2 - Jun 11th

自己复习VC的剩下章节，还有存储和网络部分。



###### Lesson 5 Roles and Permissions

- 特权：一个特定的操作
- Role：几个特定的特权称为Role
- 用户和组的概念和Windows，Linux相同
- Object：左侧清单中的每一行都是。例如，主机，文件夹
- 权限：针对特定的对象选择相应的用户赋予role

默认有三种类型的Role：

1. 系统内置role，不能被删除
   1. Administrator
   2. Read-only
   3. No access
   4. No Cryptography administrator (不加密管理员)，除了涉密的操作都可以做
2. 示例Role，带(sample)的标识
3. 用户自定义Role

==选择对象 -> Add Permission -> 选择用户/组->选择Role==



- 规则1：子对象角色优先替代原则。子对象的优先权高于父对象的权限。
- 规则2：角色累加原则
- 规则3：子对象角色优先替代原则，对于组也同样适用
- 规则4：特定用户Role优先替代原则。针对特定的用户明确指定的role优先于其他的权限。

###### Lesson 6 Backup and Restore

https://vc:5480 登录到photon，root用户登录



172.20.10.10:3260

172.20.11.10:3260

172.20.10.51 VMkernel vmk0



###### Lesson 7 Configuring and Managing Virtual Networks

物理网卡：vmnicXX 作为数据传输通道不能够设置IP，可以设置VLAN。IP地址在GOS上面。

VSS 和 VDS

- VM Portal Group
- VMKernel 端口 - 三层接口，VMotion，HA，FT等功能，管理IP
- Uplink ports

创建多少vSwitch合适呢？根据物理服务器的物理网卡的数量，比较少的时候，一个就够了。业务通过VLAN隔离。如果比较多，可以创建多个，实现物理隔离流量。



![image-20190611105313060](../../../../Library/Application Support/typora-user-images/image-20190611105313060.png)

没有uplink的交换机，叫internal switch。



关于VLAN

Native VLAN，1/0

2-4094可以配置



VM和物理客户端都不需要知道VLAN，因为虚拟交换机和物理交换机会实现VLAN tagging的添加和删除。



vDS - 针对整个数据中心，配置在多个host之间同步。在数据中心级别创建一个逻辑交换机。主机会同步VDS的配置，拥有一个read-only的副本。另外，vDS具备更多的功能，Enterprise Plus才可以使用vDS。



- 控制层，Control plane
- I/O层，I/O plane

![image-20190611112148261](../../../../Library/Application Support/typora-user-images/image-20190611112148261.png)



VSS - 针对单个主机，配置都存在于单个主机内。例如vMotion，要在不同的host上都要创建相同的虚拟机端口组。随着主机数量的增加，管理负担会越来越大。



VC坏了的时候，VDS的control plane无法使用，但是host依然可以利用只读副本进行通讯。



###### Lesson 8 VSS Policies

1. 混杂模式：该是哪个VM的数据包给哪个VM，通过MAC-Port表来管理
2. MAC地址改变，接收方的MAC地址改变依然可以转发。初始MAC，运行中MAC。默认不做比对，可以传输。
3. 伪传输：发送端的MAC地址改变，依然可以传输。

Traffic-Shaping Policy：流量整形

控制VM的出口的流量。



NIC Teaming和Failover：

Failover可以通过设置明确的网卡failover顺序，也可以设置failback是yes or no



Teaming：

- 基于源虚拟端口ID ，按照顺序走即可(默认)，耗费的资源最少。但是无法保证物理端口流量均衡。没有内部检测机制，vDS才可以。
- 基于IP 哈希，资源稍消耗
- 基于源MAC 哈希

网络故障诊断：两种方式，beacon probing(信标)，需要至少2块物理网卡。



###### Lesson 9 Virtual Storage

==DAS==:直连附加存储

NAS：==NFS==，CIFS

SAN: ==iSCSI==, ==FC==，==FCoE==

IP Storage：NFS,iSCSI



DataStore: 存放虚机，Template，ISO image等。就是一个逻辑存储单元。

支持4种类型：

- VMFS
- NFS
- vSAN
- VVOL,vSphere Virtual Volume

![image-20190611141424352](../../../../Library/Application Support/typora-user-images/image-20190611141424352.png)



Enhanced Shared Nothing vMotion:增强型vMotion。非共享存储也可以做VMotion。

对于云迁移很有用。



**RDM**: 会产生一个VMDK的映射文件，**该映射文件只能存储在VMFS Datastore上**。块设备支持。

也就是说，如果VM存放在NFS的DS上，然后用RDM的话，因为无法存放映射文件，所以会失败。



**VMFS**：通过锁机制实现共享访问。集群文件系统。

目前支持VMFS5和VMFS6.VMFS5可以升级到6，但是需要重新格式化。



Block为可变块。

* Block：1M 存放>8K的文件
* Sub Block: 8K，存放1~8K的文件
* Metadata: <1K
* big block: 512M

支持热扩容。



vSAN：

必须创建vSAN集群。

不省钱，但是解决了灵活性的问题。



VVol：兼顾共享存储的优势，也通过策略可以驱动和使用存储。

把虚拟机用虚拟卷来管理，更加灵活。





FC SAN:



iSCSI：==创建iSCSI Software Initator -> 绑定VMKernel -> 连接target -> rescan 扫描设备==



**NFS Datastore:**





##### Day 3 - Jun 12nd

今天的内容比较少。lab 做8-12 比较多。



==作业：数据恢复方法：在VC的安装包里面有 native restore，回去查一下==





###### Lesson 10 VM Management

Template: 本身就是一台虚拟机

虚拟机有.vmx文件，而template把.vmx变成了.vmtx (模板文件)



SID：安全标识符 whoami/user

sysprep可以修改SID



从模板复制VM，会通过脚本把hostname，IP和SID修改，这样VM就不同了。

模板和Clone可以跨VC创建VM。



脚本创建工具：Customization Specification Manager。



Instant Clone：即时Clone。

在很短的时间内，快速生成大量的VM。

通过对现有运行的虚拟机做一个快照，第一台被冻结，产生增量。



只能通过6.7的API调用。



==作业：如何把删除的object添加回清单，例如VM==

答案：https://communities.vmware.com/thread/407185；https://kb.vmware.com/s/article/1006160



**Content Libraries：**



跨数据中心，如果带宽不够，如何通过模板来创建VM？

- 把模板导出，传到其他地区
- 通过文档，告诉其他地区的管理员如何制作模板
- Content Libraries：在主数据中心创建很多模板，放到仓库里面。然后发布到其他地区。可以周期性的做计划，传输这些模板。

三种libraries：

1. local
2. published
3. subscribed

VM硬件：

大部分硬件都可以热添加。删除硬件需要关机。

热插拔有条件：

1. 虚拟机硬件版本7以上
2. 虚拟机需要装VMware Tools
3. 虚拟机OS要支持
4. 个别硬件的这项功能的实现有开关控制

RDM的兼容模式：

* 物理模式：数据直接从OS-LUN，不支持快照，clone/FT,大小64T， `rdmp.vmdk`
* 虚拟模式：数据从OS-VMK-LUN，支持快照，clone/FT,大小62T，`rdm.vmdk`

Thin -> Thick

通过datastore的页面，inflate功能即可。



VM的Suspend：把VM的当前内存状态保存到磁盘文件 .vms。



###### Lesson 11: 虚拟机的迁移

**CPU affinity: CPU的关联性**

vCPU和特定的LCPU绑定了的意思。缺省情况下，是不绑定的，可以任选一个LCPU来使用。



EVC是集群级别的，6.7加入了VM级别的。这样对于一些老的设备设备上的VM可以通过EVC迁移到新型主机上。条件是：==vsphere 6.7 + Hardware version大于14==



NX/XD



Storage DRS功能可以实现存储资源自动调配。需要Enterprise Plus版本。

Storage vMotion不需要vMotion网络，可以通过VAAI(需要存储支持)，或者通过vSphere的Data Mover。



为了实现跨VC的Shared Nothing长距离的虚机vMotion，需要建立TCP/IP Stack。



Snapshot：是增量备份。和NetApp的快照工作原理不同。所以尽量不使用。



###### Lesson 12: vSAN

3-64台设备的磁盘可以通过vSAN一起使用。

SSD做缓存，HD/SSD做数据盘。



PFTT=N， 允许多少个故障，最多3个。

RAID1=N，副本的数量

主机数量：2n+1



vSAN要结合HA



##### Day 4 - Jun 13rd

今天lab做到16。



###### Lesson 13： 资源管理和监控 (重点)

**Virtual CPU and Memory Concept**



2路2核： 2个物理CPU，Socket/Slot

每个CPU有2个核 Core

LCPU：没有开超线程HT 就和Core数量相等。开了的话，1个Core等于2个LCPU。

vCPU的数量谁决定？



1. 任一时间一个LCPU只能为一个vCPU提供资源
2. 一台VM只有全部vCPU都获得LCPU资源后方可启动
3. vCPU/VM<=LCPU/Host



ReadyTime: 2000ms 一台VM等待LCPU的时间。缺省为2s。时间片50ms。

Usage：最后一个时间片的使用率



vCPU的分配原则：宁少勿多，够用就好。



Reservation:可以预留CPU资源，默认为0，不做预留

Share：份额，权重，默认为1：1：1，但是可以根据需求调整

Limit：可以用到的最大物理资源。默认是不限制



![image-20190613110310558](../../../../Library/Application Support/typora-user-images/image-20190613110310558.png)



**虚拟内存**

Overcommitment

虚拟内存的数量 > 物理内存数量



虚拟机开机时，实际申请的内存是需要多少要多少。并不是配置的内存。



内存回收机制，VMK内存不够时，会从VM中回收内存。

回收机制：公平原则

1. TPS，透明内存页共享：将内存分成4K的快，进行哈希去重，然后可以回收一部分空间。只针对每个OS的内存数据做去重。不会对OS间做。最佳实践：相同的OS和APP，可以提高去重比。
2. Balloon，气球驱动：通知各个VM的VMware Tools，会触发VMmemctl进程。查看idle的内存，按照公平原则回收。如果没有idle，非关键数据放到page file里面，回收一部分。对VM有一定影响。可以回收65%-95%。
3. Compression：内存压缩。4K-2K。VM的性能有影响。
4. vSWAP=Allocation 4G

启用回收算法的原则：

**HSHL**：High Software Hard Low



根据主机的剩余的物理内存的多少启动。



###### Lesson 14: 资源控制和资源池

对资源做整体的调度。

通过资源池的划分，可以给不同的业务来使用。隔离，共享资源。



财务部：2/3 预算，2个部门

工程部：1/3 预算，2各业务



可扩展预留：可以从上一级资源池借资源，如果上一级不够，还可以再向更上一级借。

虚拟资源池可以是集群级别，也可以是host级别。但是如果host放入到了集群里面，那么就不能再host级别创建资源池。



**Admission Control for CPU and Memory:**



 ![image-20190613113022869](../../../../Library/Application Support/typora-user-images/image-20190613113022869.png)



**vAPP：**

可以把多个虚机打包管理。





**资源监视工具**



**Storage I/O Control:** 可以给存储层面设置类似于CPU和MEM的reservation，share等。



网络层面只看丢包率即可。

Network I/O Control: VDS



- 平衡资源
- 添加资源
- 关闭资源
- 优化资源
- 对客户端业务优化

###### Lesson 15: Using Alarms

- 条件警报：基于特定的条件
- 事件警报：基于Event



###### Lesson 16: vSphere HA

HA: ESXi host级别的监控，保护VM业务。

FT：业务不停机，保护vCPU的数量从原来的1个增加到了8个。4.0推出的功能。



不同层级的数据保护。



![image-20190613162251414](../../../../Library/Application Support/typora-user-images/image-20190613162251414.png)





##### Day 5 - Jun 14th

最后一天的课程！



###### # Lesson 17 vSphere HA Architecture

* vCenter - 班主任
* Master - 班长
* Slave - 学生

Master:

- 广而告之
- 网络心跳检测，需要多条路径，走管理网络。如果VM没有响应心跳，master会使用存储作为备用心跳检测。(可配置)
- 选举master规则，谁连得共享存储多谁胜出；如果相同，哪个主机的MOID大(托管对象ID)，VC分配给主机的。当master故障时，选择新的master，然后检测心跳。因为选择master需要一定时间，所以会相对slave故障时的HA时间慢一些。



VMCP: VM组件保护，如果主机访问存储路径出问题，可以通过VMCP在好的主机上重启VM。



Cluster：容器，主机数2-64台，VM 8000个

- HA
- DRS
- vSAN
- EVC

对管理网络维护的时候，可以关闭Host Monitoring(心跳检测)



虚拟机重启可以通过：

1. 设置不同的优先级
2. 设置依赖关系，前面的VM启动到什么程度启动后续的VM
3. 设置Orchestrated 关系，直接依赖关系

来达到更好的HA切换。



Admission Control: 因为要在其他主机启动VM，同样也要考虑介入控制。

确保集群能够满足故障切换容量的一种策略。

三个策略：

1. 插槽策略：Slot=Max(CPUr,MEMr)
2. 资源预留百分比
3. 专用故障主机

最佳实践：

前两种都需要使用DRS功能，而DRS是Enterprise Plus



不设置预留的话，缺省使用(32MHz,100MB)，会有很多Slot。



不设置预留，多用share值提高性能。Share值只是在资源竞争的时候才会发挥作用。不同的权重。





**FT**

监控虚机，保护虚机。



需要HA和DRS功能相结合使用。

需要创建一个FT使用的VMKernel 网络。

FT一定要在一个机房。因为应答时间需要足够低。



**vSphere Replication**

复制软件，免费的。

SRM，灾备站点的时候，用作从





###### 关于考试：

https://www.vmware.com/education-services/certification/vcp6-5-dcv.html

先完成3，然后做4.



先做620，6.0版本的，选择第一个。

https://www.vmware.com/education-services/certification/vsphere6-foundation-exam.html



![image-20190614144217579](../../../../Library/Application Support/typora-user-images/image-20190614144217579.png)





考试注册完成后，在mylearn里面有考试链接。直接考试就可以。

48小时内完成。



再做622，6.5版本的

![image-20190614144337173](../../../../Library/Application Support/typora-user-images/image-20190614144337173.png)



**更多内容在微信群里面**。



###### Lesson 18：DRS





总结：

