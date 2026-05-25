Return-Path: <bin.cao.cn@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FE4CD5BBF
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 08:01:08 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11508.1779696064354403299
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 25 May 2026 01:01:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=NAY40G/n;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=9605d0fa9a=bin.cao.cn@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P6R9sn1695407
	for <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 01:01:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=zmiZLbWfynwYhTfPj05s
	iy9yzGvzsZTkv/vEjF8T/x0=; b=NAY40G/nMeSh1xvijNYxs++p1ZXPRzC3IHss
	DtF0l1ZXdy57ReZu2LvszZ/OhTwYm5eojKWKNuU/zVLM5hu4krl2wx7SSMVmt8Ic
	tpIFrJnHudP/NKLGMJzrfvSWQ2ngrwFO5fLOWZyHKDo/oxc7k2+gfs1gbw6QUtEw
	fqzNO8jguRMGhtnPTKvPnAOShCeUDUbGgad8D3rkKjVM5JlxT+7exayMIs8RMka2
	MTH/u1GqXQoIe/wmxdhcznCy1M9CJcu0nSoDjVj6C8qZZLntmXaM20WmsB3j4exb
	DNPTRo11YxPJ/0/qPazFfkUXWU/md1A6+mN2dqHBKKMSXuO8yA==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eb7h1t4rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 01:01:03 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 25 May 2026 01:01:03 -0700
Received: from pek-lpggp2.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 25 May 2026 01:01:02 -0700
From: Bin Cao <bin.cao.cn@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-security][PATCH] samhain: fix server startup failure on systemd-based systems
Date: Mon, 25 May 2026 16:01:00 +0800
Message-ID: <20260525080101.29235-1-bin.cao.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: E4xf-A-njV-lbVbjpNNGlaTUICvAcdj5
X-Proofpoint-ORIG-GUID: E4xf-A-njV-lbVbjpNNGlaTUICvAcdj5
X-Authority-Analysis: v=2.4 cv=OuB/DS/t c=1 sm=1 tr=0 ts=6a1401bf cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=nDJU2pNIAAAA:8 a=t7CeM3EgAAAA:8
 a=xFsppLJb4dZK0fmGZ8cA:9 a=cvUpGn6QkLxiVzwzn9tb:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA4MCBTYWx0ZWRfX7RoSBD5zlGqu
 sPdajacRNQdRy6CBx59Fw25PWzrVJ9Ef2ZhrRe9XvHmCC3D5IRgB9GqdILymYmuqWLRtCqSdw19
 XMEFCpv+vuD/a9zgPQOLNDOBIW0Acfj0OQ97htyeCGhv5FjuoIzqIxmFH4yVrchwaYSdwapcPWv
 HSaGnnOMcol8G0KcweaWcxhjP9YSdWdtYSC1KEz0v/RqDoZBzIhxpqpsrq//Tayr3/5QvRmmP6X
 Tw8ezW0AmEB+ohKO/ZF7udNJ9sYRCL8o1NYVXIaHr0MZlWYzKBcdorJ4AWbyzFaEckeWUFOtG+w
 UPjpAIOFebv0eGmzwwNSMboEr/rzZmnTvWCNzjQDUdlQmmQ9EWRRJHX/65TxUl3mK/4aaiythbA
 Jvr7QlN5JLVPMuoZBzCwb1VMWLAOG/Yl+V+kciGQFI2R0ksx8b/5+HQIqICRdBYEV87/psessde
 QIcPM3h3f1zoaX+377w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250080
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 08:01:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4035

Fix two issues preventing samhain-server (yule) from starting:

1. The compiled-in PID file path /var/run/samhain.pid fails because
   /var/run is a symlink to /run on systemd-based systems, and
   samhain's security check rejects symlinks for PID directories.
   Add SetLockfilePath = /run/yule.pid to yulerc.template, following
   the same approach used in 0004-Set-the-PID-Lock-path-for-samhain.pid
   for the standalone/client configuration.

2. The init scripts unconditionally source /etc/default/rcS which does
   not exist on systemd-based systems, producing a confusing error
   message. Source it conditionally instead.

Signed-off-by: Bin Cao <bin.cao.cn@windriver.com>
---
 ...-set-SetLockfilePath-to-run-yule.pid.patch | 41 +++++++++++++++++++
 recipes-ids/samhain/files/samhain-client.init |  3 +-
 recipes-ids/samhain/files/samhain-server.init |  3 +-
 recipes-ids/samhain/samhain.inc               |  5 ++-
 4 files changed, 48 insertions(+), 4 deletions(-)
 create mode 100644 recipes-ids/samhain/files/0013-yulerc-set-SetLockfilePath-to-run-yule.pid.patch

diff --git a/recipes-ids/samhain/files/0013-yulerc-set-SetLockfilePath-to-run-yule.pid.patch b/recipes-ids/samhain/files/0013-yulerc-set-SetLockfilePath-to-run-yule.pid.patch
new file mode 100644
index 00000000..889fd9b5
--- /dev/null
+++ b/recipes-ids/samhain/files/0013-yulerc-set-SetLockfilePath-to-run-yule.pid.patch
@@ -0,0 +1,41 @@
+From 7070832b4652f3cdaa2e37325fc6f9456859cb5d Mon Sep 17 00:00:00 2001
+From: Bin Cao <bin.cao.cn@windriver.com>
+Date: Mon, 25 May 2026 14:55:37 +0800
+Subject: [PATCH] yulerc: set SetLockfilePath to /run/yule.pid
+
+On systemd-based systems, /var/run is a symlink to /run. Samhain's
+security-hardened code uses lstat() to verify the PID file directory
+is a real directory and rejects symlinks. This causes yule (the samhain
+server) to fail to start with "Path of PID directory refers to a
+non-directory object".
+
+Set SetLockfilePath explicitly to /run/yule.pid to bypass the
+compiled-in default of /var/run/samhain.pid.
+
+This is the same approach used in 0004-Set-the-PID-Lock-path-for-
+samhain.pid.patch for the standalone/client configuration.
+
+Upstream-Status: Inappropriate [OE-specific configuration]
+Signed-off-by: Bin Cao <bin.cao.cn@windriver.com>
+---
+ yulerc.template | 4 ++++
+ 1 file changed, 4 insertions(+)
+
+diff --git a/yulerc.template b/yulerc.template
+index 512bc0d..24b437c 100644
+--- a/yulerc.template
++++ b/yulerc.template
+@@ -173,6 +173,10 @@ Daemon=yes
+ # SetLoopTime = 60
+ SetLoopTime = 600
+ 
++## Path to the PID file
++#
++SetLockfilePath = /run/yule.pid
++
+ ## Normally, client messages are regarded as data within a
+ ## server message of fixed severity. The following two
+ ## options cause the server to use the original severity/class
+-- 
+2.34.1
+
diff --git a/recipes-ids/samhain/files/samhain-client.init b/recipes-ids/samhain/files/samhain-client.init
index d5fabede..c714f8ce 100644
--- a/recipes-ids/samhain/files/samhain-client.init
+++ b/recipes-ids/samhain/files/samhain-client.init
@@ -13,7 +13,8 @@ DAEMON=/usr/sbin/samhain
 RETVAL=0
 PIDFILE=/var/run/samhain.pid
 
-. /etc/default/rcS
+# Source rcS only if it exists (not present on systemd-based systems)
+[ -f /etc/default/rcS ] && . /etc/default/rcS
 
 . /etc/default/samhain-client
 
diff --git a/recipes-ids/samhain/files/samhain-server.init b/recipes-ids/samhain/files/samhain-server.init
index c456e51c..49a28de6 100644
--- a/recipes-ids/samhain/files/samhain-server.init
+++ b/recipes-ids/samhain/files/samhain-server.init
@@ -13,7 +13,8 @@ DAEMON=/usr/sbin/yule
 RETVAL=0
 PIDFILE=/var/run/yule.pid
 
-. /etc/default/rcS
+# Source rcS only if it exists (not present on systemd-based systems)
+[ -f /etc/default/rcS ] && . /etc/default/rcS
 
 . /etc/default/samhain-server
 
diff --git a/recipes-ids/samhain/samhain.inc b/recipes-ids/samhain/samhain.inc
index fc4e4237..85359cdf 100644
--- a/recipes-ids/samhain/samhain.inc
+++ b/recipes-ids/samhain/samhain.inc
@@ -3,7 +3,7 @@ HOMEPAGE    = "http://www.la-samhna.de/samhain/"
 LICENSE     = "GPL-2.0-only"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=8ca43cbc842c2336e835926c2166c28b"
 
-PV = "4.5.2"
+PV = "4.5.3"
 
 SRC_URI = "https://la-samhna.de/archive/samhain_signed-${PV}.tar.gz \
            file://${INITSCRIPT_NAME}.init \
@@ -20,9 +20,10 @@ SRC_URI = "https://la-samhna.de/archive/samhain_signed-${PV}.tar.gz \
            file://0009-fix-build-with-new-version-attr.patch \
            file://0010-Fix-initializer-element-is-not-constant.patch \
            file://0001-Format-test-output-to-match-Automake-standards.patch \
+           file://0013-yulerc-set-SetLockfilePath-to-run-yule.pid.patch \
            "
 
-SRC_URI[sha256sum] = "0b5d3534fd60ecf45dfd79bd415e81f7a56eba7f1755771735e204f334033578"
+SRC_URI[sha256sum] = "e7837adfde3d59a23c59e1bf3ebacdf71bce018619194cfad938cd30cbb9d15b"
 
 UPSTREAM_CHECK_URI = "https://www.la-samhna.de/samhain/archive.html"
 UPSTREAM_CHECK_REGEX = "samhain_signed-(?P<pver>(\d+(\.\d+)+))\.tar"
-- 
2.43.0


