Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13857.1793940891106861019
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 05 Nov 2026 20:54:51 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wAXAdcmXe1qqpoDAA--.13801S3;
	Fri, 06 Nov 2026 12:52:54 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowADnd2jIXO1qmt8tAA--.32741S4;
	Fri, 06 Nov 2026 12:51:30 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [meta-selinux][wrynose][PATCH 3/5] refpolicy_common: strip POLICY_CUSTOM_BUILDOPT before passing to make
Date: Fri,  6 Nov 2026 12:54:23 +0800
Message-ID: <20261106045426.2536283-3-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106045426.2536283-1-chenqi_hycx@cetc.com.cn>
References: <20261106045426.2536283-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowADnd2jIXO1qmt8tAA--.32741S4
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYDCmrshhUP1QACsA
X-CM-DELIVERINFO: =?B?dXzz86c9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOIpW4/8Z0l7A1TJMY5S9w3rJ99hsPWH+Sxb2eKoJFXSF7CtdCudD6aPyPkDrzc2Ik5KG
	r9gp6j2ZjTHxXbKctGZeZhTX8ruIa9FiLn52svHMIeQPbq+Iiteo3cNpnuCF7w==
X-Coremail-Antispam: 1Uk129KBj93XoW7tF17Gry7Zw48uFWUGrWrCrX_yoW8Gr18p3
	y2y34Yya4jqFyIgrsruF97W3srGas8Gw4UurWDGFs8A3s8Jay8C3yvq3s7Wa1rZFy7Awn7
	Aw1Yva47Cw4UAFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GrDv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYz7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_
	JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwAKzVCY07xG64k0F24lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVWUXVWUAwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
	cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIF
	yTuYvjxU2X_-DUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Nov 2026 04:55:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5249
Content-Type: text/plain; charset="utf-8"

From: Chiluka Rohith <rchiluka@qti.qualcomm.com>

POLICY_CUSTOM_BUILDOPT is passed directly to the refpolicy make command
as CUSTOM_BUILDOPT. When layers use ':append' to extend this variable
(e.g. POLICY_CUSTOM_BUILDOPT:append:distro = " option"), BitBake
introduces a leading space. Passing that raw value to make causes:

  make: *** No rule to make target 'option'.  Stop.

Signed-off-by: Chiluka Rohith <rchiluka@qti.qualcomm.com>
Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 recipes-security/refpolicy/refpolicy_common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 014714c..1566591 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -126,7 +126,7 @@ EXTRA_OEMAKE = "NAME=${POLICY_NAME} \
     DIRECT_INITRC=${POLICY_DIRECT_INITRC} \
     SYSTEMD=${POLICY_SYSTEMD} \
     MONOLITHIC=${POLICY_MONOLITHIC} \
-    CUSTOM_BUILDOPT=${POLICY_CUSTOM_BUILDOPT} \
+    CUSTOM_BUILDOPT=${@d.getVar('POLICY_CUSTOM_BUILDOPT').strip()} \
     QUIET=${POLICY_QUIET} \
     MLS_SENS=${POLICY_MLS_SENS} \
     MLS_CATS=${POLICY_MLS_CATS} \
-- 
2.43.0

