Return-Path: <amanna@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024A310ED660
	for <webhook@archiver.kernel.org>; Fri, 27 Mar 2026 11:53:29 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.70116.1774612401444958455
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Mar 2026 04:53:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=BgXKq+8G;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.168.131, mailfrom: amanna@qti.qualcomm.com)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R6wH6b2538716
	for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Mar 2026 11:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6qkdlbqCJ+fxKyPTuHgsrw
	PxsY8HgmCATwvg0SxSARE=; b=BgXKq+8GN6hKpg/7oWwndBEr3xDotiDSh46keO
	X0g0gA/97oSDMs3uFstPDPMtX3Q82cqewBWaaou8QMW0nzlFInAxrTDgSLMTwR88
	GmdoaGAM+WmhLIt9VPRr0p2+/y4Jeqfj7sgOmlA8WYb8IURgoV/8Cbx0KCwP3d/p
	BXYTaDK2VS3Sck3lCaDEAxCaTQWesLIVSwylWLBpBIOV1KhsAmNXkCHzD6cC/6Y4
	Ek37zyRVXKsgYXcCUYImHDtFtzwVWwkGFKTRSRFGUVcQIud6oomI9a5lw+hdvr8f
	betIyIuyu7kHZK+dcO61OFRdYiqsykkQTG//V1lmG9X6QqdQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5883ktxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Mar 2026 11:53:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 62RBrJY0004852
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Mar 2026 11:53:19 GMT
Received: from hu-amanna-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 27 Mar 2026 04:53:18 -0700
From: Abhilasha Manna <amanna@qti.qualcomm.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: Abhilasha Manna <amanna@qti.qualcomm.com>
Subject: [PATCH] refpolicy: backport fix from upstream (PR #1095)
Date: Fri, 27 Mar 2026 17:22:57 +0530
Message-ID: <20260327115257.2625298-1-amanna@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SQWv0WgCG1v3mSexT43K86KY39gfrOs1
X-Authority-Analysis: v=2.4 cv=bopBxUai c=1 sm=1 tr=0 ts=69c66fb0 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=s_hYgeEOXMeHEowCWyQA:9
X-Proofpoint-ORIG-GUID: SQWv0WgCG1v3mSexT43K86KY39gfrOs1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA4MCBTYWx0ZWRfX1WSt9WPnpaqT
 5bCoEyc4dMSRzgo89uWLC5NWCq5ivVkWnRfAJEJd9NcvGf9FAfxjx1bePu07hTsx2RUSwCzbBSY
 01c9vR0VKQpG4jqltvaMN1Bpa/CZNjicWmmcJTRf5UbXH+EN3/DAVfmyT7tVNEwoB70IyS/80mB
 +3+IUzEHrdxf+grEUMDURyBKrezbmkV+APUwj/Lo1U4BI6GWZE0LG+O8CyIeSJXiiSu/U4wXxKD
 B4M0TjkWQFdfWkJhBny+3+40wczJTklOEZSxqYTAEZ8Q1nF/FGZ4nUUJaMVKgW1FqTJ0P6fSE0P
 1+haatAzmulR3fS0snLzptkyf8ChFuhAxWAUIVL2F03g/GZsq6qQP6uNKoXyaBKt9Uq4Jo3zd+U
 uCk9vGAvv3nGbn686G35mBcTOFDSfubqBq4h2Xq/WGMFFu+R+knGcpszewnPudIauFG5Y0xkT/D
 NXZTLgGgJDVRUC+uURw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 suspectscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270080
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Mar 2026 11:53:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3566

Backport upstream SELinux refpolicy change from:

  https://github.com/SELinuxProject/refpolicy/pull/1095/changes/e393fdc3c3943b27d9808311e92c14af68345f29

This change is required to keep meta-selinux in sync with
upstream refpolicy and to fix issues observed when building
or running SELinux-enabled images.

No functional changes beyond the upstream fix.

Signed-off-by: Abhilasha Manna <amanna@qti.qualcomm.com>
---
 .../refpolicy/refpolicy-targeted_git.bb       |  1 +
 ...irt-hook-scripts-with-dedicated-exec.patch | 74 +++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0078-virt-label-libvirt-hook-scripts-with-dedicated-exec.patch

diff --git a/recipes-security/refpolicy/refpolicy-targeted_git.bb b/recipes-security/refpolicy/refpolicy-targeted_git.bb
index de81d46..beda1c5 100644
--- a/recipes-security/refpolicy/refpolicy-targeted_git.bb
+++ b/recipes-security/refpolicy/refpolicy-targeted_git.bb
@@ -14,4 +14,5 @@ include refpolicy_${PV}.inc
 
 SRC_URI += " \
         file://0001-refpolicy-targeted-make-unconfined_u-the-default-sel.patch \
+        file://0078-virt-label-libvirt-hook-scripts-with-dedicated-exec.patch \
         "
diff --git a/recipes-security/refpolicy/refpolicy/0078-virt-label-libvirt-hook-scripts-with-dedicated-exec.patch b/recipes-security/refpolicy/refpolicy/0078-virt-label-libvirt-hook-scripts-with-dedicated-exec.patch
new file mode 100644
index 0000000..79209fc
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0078-virt-label-libvirt-hook-scripts-with-dedicated-exec.patch
@@ -0,0 +1,74 @@
+From 2edbd77f1f6aa720a9ed48f27f9dca43b8935261 Mon Sep 17 00:00:00 2001
+From: Abhilasha Manna <amanna@qti.qualcomm.com>
+Date: Wed, 18 Mar 2026 10:53:58 +0530
+Subject: [PATCH] virt: label libvirt hook scripts with dedicated exec type
+
+Hook scripts under /etc/libvirt/hooks/ are executable files
+invoked by libvirtd on lifecycle events. Their current label
+virt_etc_rw_t does not permit execute, causing AVC denials.
+
+Introduce virt_script_exec_t for hook scripts, add the
+virt_exec_script() interface, and update file_contexts to
+label /etc/libvirt/hooks(/.*)? accordingly.
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/pull/1095/changes/e393fdc3c3943b27d9808311e92c14af68345f29]
+
+Signed-off-by: Abhilasha Manna <amanna@qti.qualcomm.com>
+---
+ policy/modules/services/virt.fc |  2 ++
+ policy/modules/services/virt.if | 18 ++++++++++++++++++
+ policy/modules/services/virt.te |  5 +++++
+ 3 files changed, 25 insertions(+)
+
+diff --git a/policy/modules/services/virt.fc b/policy/modules/services/virt.fc
+index 1441a50dc..eb72de5be 100644
+--- a/policy/modules/services/virt.fc
++++ b/policy/modules/services/virt.fc
+@@ -72,3 +72,5 @@ HOME_DIR/VirtualMachines/isos(/.*)?	gen_context(system_u:object_r:virt_content_t
+ /run/user/[^/]*/libguestfs(/.*)?	gen_context(system_u:object_r:virt_home_t,s0)
+ /run/vdsm(/.*)?	gen_context(system_u:object_r:virt_runtime_t,s0)
+ /run/virtlockd\.pid	--	gen_context(system_u:object_r:virtlockd_run_t,s0)
++
++/etc/libvirt/hooks(/.*)?    --    system_u:object_r:virt_script_exec_t:s0
+diff --git a/policy/modules/services/virt.if b/policy/modules/services/virt.if
+index 9b28d670e..272034f0d 100644
+--- a/policy/modules/services/virt.if
++++ b/policy/modules/services/virt.if
+@@ -1274,3 +1274,21 @@ interface(`virt_admin',`
+ 	dev_list_all_dev_nodes($1)
+ 	allow $1 virt_ptynode:chr_file rw_term_perms;
+ ')
++
++########################################
++## <summary>
++##      Execute virt hook scripts.
++## </summary>
++## <param name="domain">
++##      <summary>
++##      Domain allowed to execute virt hook scripts.
++##      </summary>
++## </param>
++#
++interface(`virt_exec_script',`
++    gen_require(`
++        type virt_script_exec_t;
++    ')
++    files_search_etc($1)
++    allow $1 virt_script_exec_t:file exec_file_perms;
++')
+diff --git a/policy/modules/services/virt.te b/policy/modules/services/virt.te
+index b0bd0a8d4..50028f615 100644
+--- a/policy/modules/services/virt.te
++++ b/policy/modules/services/virt.te
+@@ -1257,3 +1257,8 @@ sysnet_dns_name_resolve(virtlogd_t)
+ 
+ virt_manage_log(virtlogd_t)
+ virt_read_config(virtlogd_t)
++
++type virt_script_exec_t;
++files_type(virt_script_exec_t)
++
++virt_exec_script(virtd_t)
+-- 
+2.43.0
+
-- 
2.43.0


