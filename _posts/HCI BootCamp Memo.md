---
layout: post
title: HCI Bootcamp Memo - Aug 13-14 2018 
---

- 4 types of Deployment
  - [x] new vCenter Install
  - [x] exiting vCenter Install
  - [ ] adding additional HCI clusters
  - [x] expanding exiting HCI cluster
    - adding compute nodes
    - adding storage nodes
- Blaze (Compute Node image)
- Ember (Storage Node image)

**Next-gen HCI platform maybe on Cisco, not on Supermicro.**

HCI is not replacing Flexpod

- Compute node: Two SATA M2 SSD

  - SSD1 : ESXi
  - SSD2: NDE and Blaze

- Storage node: 1 SATA M2 SSD

  - NDE, Ember, and ElementOS

- PSU1 - UP, 负责左边的散热

- PSI2 - Down， 负责右边的散热

- Cannot intermix Storage node disks between models; **Can intermix Solidfire disks with HCI disks**

- Lowest S/N compute node hosts all virtual appliances (mnode, etc...)

- Recommend using 1 mNode to monitor multiple HCI Clusters

- Key of Installation: **Installation Workbook** 

- 1 hour/node deployment time

- ConfigBuilder to generate Installation workbook - End of Aug

- ConfigAdvisor to validate the workbook and post-NDE

- May offer SW in the future

- joining existing vCenter may removed from the future NDE version, cause it is troublesome

- Nodes placement best practice? 

  - currently no chassis affinity - next version will have

  - populate chassis: 2 compute nodes, 2 storage nodes

  - lowest S/N compute node 

    - emulates node name: NDE uses Storage and Compute S/N to assign names

      - Storage 
      - compute

    - 事先需要知道节点的S/N，然后物理上和用户的要求一致

      

    - | Compute | Compute |
      | ------- | ------- |
      | Storage | Storage |

    - NDE doesn't configure IPMI. Manual configure through TUI.

    - Easiest way to find the NDE version, using API

    - When configure Bond10G, using AP first, run NDE, and change it to LACP



Mitch Mueller

Mitchelm@netapp.com

