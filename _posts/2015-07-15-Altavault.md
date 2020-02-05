---
layout: post
title: 从Steelstore, 到今天的AltaVault
subtitle: Steelstore to AltaVault
---

2014年，NetApp用8000万美金从 Riverbed （河床？）手中收购了其SteelStore产品线，用来补充自身的云整体解决方案。

今年，NetApp对该产品重新包装，并重命名为AltaVault。

传统的备份软件，在面临接入到云的时候，总要面临一个问题，就是在利用云带来的种种好处的同时，如何能够和云进行无缝对接。AltaVault是解决这一难题的很好的答案。在架构上并不复杂，AltaVault利用各备份软件对CIFS和NFS协议的支持，通过这两个协议提供为前端的备份软件提供共享的备份目的端，然后通过去重，加密，压缩，将数据备份到AltaVault的本地存储上。然后再通过后端对各种云的支持，将数据异步的备份到云端。

服务器中的传统备份软件 <— CIFS/NFS —> AltaVault  <— 备份/恢复 —> 云 （公有/私有）

通过这样的架构，AltaVault可以无缝集成到现有的备份方案中，并且附加了一系列云备份关心的数据安全，尽量减小对网络带宽的需求等功能。

AltaVault作为NetApp的云整体解决方案中的一环，势必成为其向云推进的一个重要的产品线。

在此，转载一篇文章。

[NetApp SteelStore 云集成储存设备 改变备份方式](http://www.chinastor.com/a/cloud/04151501R015.html)