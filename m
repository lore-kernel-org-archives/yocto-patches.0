Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20044.1794797801023615592
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Nov 2026 18:56:41 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wBnb9NncPpqY9QAAA--.912S3;
	Mon, 16 Nov 2026 10:54:32 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowABn+WnccPpqPNA3AA--.14039S5;
	Mon, 16 Nov 2026 10:56:37 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [PATCH 3/6] refpolicy_common: ensure we start from a clean state in do_compile
Date: Mon, 16 Nov 2026 10:56:17 +0800
Message-ID: <20261116025620.2558594-4-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116025620.2558594-1-chenqi_hycx@cetc.com.cn>
References: <20261116025620.2558594-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowABn+WnccPpqPNA3AA--.14039S5
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYNCmr5ttwQhQAAss
X-CM-DELIVERINFO: =?B?78kLhqc9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOBNkiu0Ezb1p2pGXeRzsQOOetiK1i/XRcVR42sQdltV/w6xTdwCCCiTY/98Br6F5tuw9
	kPmBKQlayPIxSCwzWfd5aRBlGnxz2xTFyYapbkYPu0kie1A4wdQL24IB56wyjQ==
X-Coremail-Antispam: 1Uk129KBj93XoW7KrWUZF48Gr1rXryfJF1fAFc_yoW8Gr4Dpw
	4jva4YyF4DXF1xWrs7uF43uF17KasxWw40v3yUCw40v3s8XFyxuw48t3sxWFWfZ3y3Xr9r
	GwnIv3y3WayUA3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GrUv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYh7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwAKzVCY07xG64k0F24lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU2xhLUUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 02:56:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5402
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

The `bare` make target is to "delete all remaining generated files,
including modules.conf, and booleans.conf."[1]

If we don't do 'make bare' at the start of do_compile, legacy build
artifacts such as booleans.conf, generated_definitions.conf, etc.
will remain there, making the building results unexpected.

For example, if we enable ssh_sysadm_login in legacy build directory,
things just don't take effect because even if do_compile is re-run
due to signature change, the generated_definitions.conf will not be
updated.

[1] https://github.com/SELinuxProject/refpolicy/blob/main/doc/BUILD_INSTALL.md#general-make-targets

Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 recipes-security/refpolicy/refpolicy_common.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 4fa2ae5..e6dac8e 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -194,6 +194,7 @@ set_policy_booleans() {
 }
 
 do_compile() {
+    oe_runmake bare
     if [ -f "${WORKDIR}/modules.conf" ] ; then
         cp -f ${WORKDIR}/modules.conf ${S}/policy/modules.conf
     fi
-- 
2.43.0

