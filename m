Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.29937.1795327896098109595
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 21 Nov 2026 22:11:36 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wAn+1wKhwJrMzEAAA--.1285S3;
	Sun, 22 Nov 2026 14:09:14 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowABH2GiLhwJrkBE+AA--.9795S4;
	Sun, 22 Nov 2026 14:11:26 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [PATCH v2 2/4] refpolicy_common: ensure we start from a clean state in do_compile
Date: Sun, 22 Nov 2026 14:11:20 +0800
Message-ID: <20261122061122.2042600-3-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122061122.2042600-1-chenqi_hycx@cetc.com.cn>
References: <20261122061122.2042600-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowABH2GiLhwJrkBE+AA--.9795S4
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYTCmsBn+ED+QAAsw
X-CM-DELIVERINFO: =?B?Ml/t/6c9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOFa/r1iAD8uJ7SNfDBqCVpwBW2GZvU+CkDFUGl+wt1TspFpiAK5DOGgAKdpwx7cddri0
	gpsbB+VKj0i0+7E45pLAreBResFT24JFowssT5bNPNz6Hff5vafeiuI5ZYqNBzf+23qTR/
	8xgecixypjPGI=
X-Coremail-Antispam: 1Uk129KBj93XoW7KrWUZF48Gr1rXryfJF1fAFc_yoW8Gr4Dpw
	4jvFyYyF4DXF1xWws7uF43ur12gasxWw48Z3y5Cw4vv3s8XFyxuw48t3srWFWfZ3y3Xr9r
	CwnIv3y7WayUAacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GFUv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYT7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2
	z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_
	JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwAKzVCY07xG64k0F24lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
	6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIY
	CTnIWIevJa73UjIFyTuYvjxU2RwZDUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 22 Nov 2026 06:11:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5490
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
index 4b5108a..3f629bc 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -193,6 +193,7 @@ set_policy_booleans() {
 }
 
 do_compile() {
+    oe_runmake bare
     if [ -f "${WORKDIR}/modules.conf" ] ; then
         cp -f ${WORKDIR}/modules.conf ${S}/policy/modules.conf
     fi
-- 
2.43.0

