Return-Path: <amanna@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C4210ED65C
	for <webhook@archiver.kernel.org>; Fri, 27 Mar 2026 12:16:09 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.70502.1774613761489021070
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Mar 2026 05:16:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=Ha8bUdhz;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.168.131, mailfrom: amanna@qti.qualcomm.com)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R6w3rC1860238
	for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Mar 2026 12:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6qkdlbqCJ+fxKyPTuHgsrw
	PxsY8HgmCATwvg0SxSARE=; b=Ha8bUdhzLkW4GQSqFRiYNCNwNYCvHdfaxeIDXe
	TXmXBUAzYZrXtqzm25v5yVuSCXVyqg/IZ7L+Pl8n98LI+1Vs7paYyrbpQVDbYKex
	LBwrzIskSxyLJfgyuVFtGR9EyNzZ+0Jut8K6BlXwe5s5fvzQG+jlLyh8pCIb2s9x
	1zFUaZCcjpa4Miv0BU9FQdLsIcet9LvcRFiLktAcpLBhhBouUGTi2QlR7tRFemys
	KvGPvbY8HVnaI28mlPlstYTSfDVrp8m9++Rq/GGT16aVovxF5wG3clLm/UKABXAd
	DHNu6f3SSAvfd2lGJah+pTVHxY09cCgt0AEivtqfMAXz8hxA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5bxv2y8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Mar 2026 12:16:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 62RCFxn9006905
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Mar 2026 12:15:59 GMT
Received: from hu-amanna-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 27 Mar 2026 05:15:58 -0700
From: Abhilasha Manna <amanna@qti.qualcomm.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: Abhilasha Manna <amanna@qti.qualcomm.com>
Subject: [meta-selinux][PATCH] refpolicy: backport fix from upstream (PR #1095)
Date: Fri, 27 Mar 2026 17:45:48 +0530
Message-ID: <20260327121548.2628667-1-amanna@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=A99h/qWG c=1 sm=1 tr=0 ts=69c67500 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=s_hYgeEOXMeHEowCWyQA:9
X-Proofpoint-ORIG-GUID: -82n-bWihczR6bB_tSjGdtkZSpT9tbGA
X-Proofpoint-GUID: -82n-bWihczR6bB_tSjGdtkZSpT9tbGA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA4MyBTYWx0ZWRfXyughbNqmjNYe
 kx9XdZ3wyoL26OCoQC6TyzlmpYx84vXGHIch/c+fdWh6hDelj3vg0Jkq7usinn+kIesBmq5dCAa
 ewTrdFSdpQHuxRDAIIy0JifO53bHtUKpm/VrW/HYZngT1hJU9EiFAdUeI/xiWokL80wyg+cPdx5
 NZ/pM3IhIdKG4hA5LAaSOuplcaf3bfWIzAMETBUTUXKbBRAQrZWJ0Mj8mpZ+hxZzNw0lVpVHnrB
 H2vXR44UV523ADW/ueVUt4IVolOL5Ppej/42wd8Hc9mkdXCtjp/tmUxbP+hOkZIn7zeX7tVIe7j
 uKSK8Kie6mDXvC/cLq40ZYHOC51Mi/l6B2JLHGeBkh+NdYOfDpPQtYkLNUYmBCVPXcsZAk2xbKP
 Qa5G9XRVKB4vvd1Gy0I1s4kPJB3cnSaAurbYqIdes9VKv229341ZEmbWrvu16KJhP/pOKjgFC1x
 Le5QQt4apFZ8ga8/P6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270083
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Mar 2026 12:16:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3567

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


