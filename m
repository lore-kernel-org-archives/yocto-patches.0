Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13858.1793940891869011586
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 05 Nov 2026 20:54:52 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wC3K9wmXe1qrJoDAA--.17855S3;
	Fri, 06 Nov 2026 12:52:54 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowADnd2jIXO1qmt8tAA--.32741S6;
	Fri, 06 Nov 2026 12:51:33 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [meta-selinux][wrynose][PATCH 5/5] packagegroup/selinux: require selinux-init only for sysvinit
Date: Fri,  6 Nov 2026 12:54:25 +0800
Message-ID: <20261106045426.2536283-5-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106045426.2536283-1-chenqi_hycx@cetc.com.cn>
References: <20261106045426.2536283-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowADnd2jIXO1qmt8tAA--.32741S6
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYDCmrsh9MP1gAAsF
X-CM-DELIVERINFO: =?B?f8jxRKc9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOAN5QhYBP/Hfs96vmoQs/I/RZF56e3gwBw0xvh1O7Js5QTXW7if5QssHGo8EUxkXDz1x
	X++nEIhAyYYkmh3FyN5eZhTX8ruIa9FiLn52svHMAkfqG1GlAa7ddourGtwcbQ==
X-Coremail-Antispam: 1Uk129KBj93XoW7KrykXrWfXw1xuFW8Gry3trc_yoW8Cr4Upr
	sFyF1UJr10gFy8Xrnru3W2gw4ruFWrCa4UA345Ka48tFn8ur18XF9rWF45GFZrXF13Z3W8
	A3WY93yDKaykXagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GrDv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY77kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwAKzVCY07xG64k0F24lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVWUXVWUAwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
	cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
	43ZEXa7IU86bytUUUUU==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Nov 2026 04:55:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5250
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

The selinux-init for systemd is quite misleading. systemd itself
can load selinux policies. Extra userspace tools are not needed
for systemd.

In fact, the init script does nothing but only checks some tools.
And the result can be misleading as these tool are not necessary
for systemd.

Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 recipes-security/packagegroups/packagegroup-core-selinux.bb    | 2 +-
 recipes-security/packagegroups/packagegroup-selinux-minimal.bb | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-security/packagegroups/packagegroup-core-selinux.bb b/recipes-security/packagegroups/packagegroup-core-selinux.bb
index 148c8a2..b5dc1e4 100644
--- a/recipes-security/packagegroups/packagegroup-core-selinux.bb
+++ b/recipes-security/packagegroups/packagegroup-core-selinux.bb
@@ -20,7 +20,7 @@ RDEPENDS:${PN} = " \
 	setools \
 	setools-console \
 	selinux-autorelabel \
-	selinux-init \
+	${@bb.utils.contains('DISTRO_FEATURES', 'sysvinit', 'selinux-init', '', d)} \
 	selinux-labeldev \
 	refpolicy \
 	coreutils \
diff --git a/recipes-security/packagegroups/packagegroup-selinux-minimal.bb b/recipes-security/packagegroups/packagegroup-selinux-minimal.bb
index f06b183..b8e2825 100644
--- a/recipes-security/packagegroups/packagegroup-selinux-minimal.bb
+++ b/recipes-security/packagegroups/packagegroup-selinux-minimal.bb
@@ -20,7 +20,7 @@ RDEPENDS:${PN} = "\
 	policycoreutils-sestatus \
 	policycoreutils-setfiles \
 	selinux-autorelabel \
-	selinux-init \
+	${@bb.utils.contains('DISTRO_FEATURES', 'sysvinit', 'selinux-init', '', d)} \
 	selinux-labeldev \
 	refpolicy \
 "
-- 
2.43.0

