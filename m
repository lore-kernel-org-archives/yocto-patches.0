Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16192.1795520515355143533
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Nov 2026 03:42:02 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wBnewBzdwVrQNQAAA--.1104S3;
	Tue, 24 Nov 2026 19:39:31 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowACXKWr5dwVrLcFAAA--.28459S3;
	Tue, 24 Nov 2026 19:41:46 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [meta-selinux][PATCH 1/4] selint: add recipe
Date: Tue, 24 Nov 2026 19:41:34 +0800
Message-ID: <20261124114137.2203106-2-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124114137.2203106-1-chenqi_hycx@cetc.com.cn>
References: <20261124114137.2203106-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowACXKWr5dwVrLcFAAA--.28459S3
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYBCmsEQRspEgABsA
X-CM-DELIVERINFO: =?B?54RYO6c9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOOlI2Du8d65gBCGhVRqdwZU2fcS8Jmk4qy2rRWZ3YIS8odFkBghl466AlOnWPRPa0aIF
	JOKltOzIeMi9yjWgzsDvq/Oy/3z4zCRlZrQ78qjqnfHXbMz7ZlCp9CQQLO8slA==
X-Coremail-Antispam: 1Uk129KBj93XoW7KrW8Xr1UZF17Jw1rJw4rCrX_yoW8Zr1rpa
	1rtrWYkr4IgF4xGa9xCa4jgF4Yv3ykCr43Z39rWay0yFZ0yF1UXr4kKr13XFyrGrn7tw10
	q343Zr9xGayDCFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_Gw7v73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYa7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lw4CEc2x0rVAKj4xxMxkIecxEwVAFwVW8KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
	CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU8mjg7UUUUU==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 11:42:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5506
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

SELint statically checks SELinux policy source files.  The native build
is what refpolicy uses at build time; a target package is provided too.

Version 1.5.1 (fdf0d417bf).  The testsuite is disabled so the recipe
does not pull in the check framework.

Assisted-by: Codewhale:deepseek-flash
Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 recipes-security/selint/selint_git.bb | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 recipes-security/selint/selint_git.bb

diff --git a/recipes-security/selint/selint_git.bb b/recipes-security/selint/selint_git.bb
new file mode 100644
index 0000000..a2d5e41
--- /dev/null
+++ b/recipes-security/selint/selint_git.bb
@@ -0,0 +1,27 @@
+SUMMARY = "Static analysis tool for SELinux policy source files"
+DESCRIPTION = "SELint checks refpolicy style .te, .if and .fc files for \
+convention, style, warning and error level issues."
+HOMEPAGE = "https://github.com/SELinuxProject/selint"
+SECTION = "devel"
+LICENSE = "Apache-2.0"
+LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
+
+SRC_URI = "git://github.com/SELinuxProject/selint.git;branch=main;protocol=https"
+# Bumping this means re-syncing files/selint.conf in the refpolicy recipe.
+SRCREV = "fdf0d417bcefc6a82be7349d47bbef14e8d5fbbb"
+PV = "1.5.1+git"
+
+UPSTREAM_CHECK_GITTAGREGEX = "(?P<pver>\d+(\.\d+)+)"
+
+# libconfuse and uthash come from meta-oe; the rest are for autoreconf.
+DEPENDS = "libconfuse uthash pkgconfig-native autoconf-archive-native \
+           bison-native flex-native"
+
+# The testsuite would need the check framework for no benefit here.
+EXTRA_OECONF = "--without-check"
+
+CONFFILES:${PN} = "${sysconfdir}/selint.conf"
+
+inherit autotools
+
+BBCLASSEXTEND = "native"
-- 
2.43.0

