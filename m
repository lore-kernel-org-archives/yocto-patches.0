Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15943.1795520516614188248
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Nov 2026 03:41:57 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wAHMWB3dwVrRdQAAA--.4185S3;
	Tue, 24 Nov 2026 19:39:35 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowACXKWr5dwVrLcFAAA--.28459S6;
	Tue, 24 Nov 2026 19:41:50 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [meta-selinux][PATCH 4/4] refpolicy: run selint over the policy sources
Date: Tue, 24 Nov 2026 19:41:37 +0800
Message-ID: <20261124114137.2203106-5-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124114137.2203106-1-chenqi_hycx@cetc.com.cn>
References: <20261124114137.2203106-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowACXKWr5dwVrLcFAAA--.28459S6
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYBCmsEQRspEwAAsA
X-CM-DELIVERINFO: =?B?kzOgTac9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOOlI2Du8d65gBCGhVRqdwZXxbs2EkPD7wReo4SgJeaGZRqxzCf5ZXoVyqvWm4+cYuE2F
	g9m7v2rCZYab04BYzZXvq/Oy/3z4zCRlZrQ78qjqvnPGwHz5IT7ICLCYnmOQBw==
X-Coremail-Antispam: 1Uk129KBj93XoWxAw1rur1rurWruw4DZw4DJrc_yoW5trW3pa
	1akas8A3WUWFyxKrn2kF4UWr1aga98Ca1DW398Ka1qy398ZF48Ca1rtr9xuFWru3sxJw12
	qrs0vFW3WayUAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_Gw7v73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYw7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lw4CEc2x0rVAKj4xxMxkIecxEwVAFwVW8KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jrv_JF1lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
	IE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07j7hL8UUUUU=
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 11:42:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5504
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

Lint the policy sources so that a local patch introducing a SELint
finding fails the build instead of silently reaching the image.

The check runs after do_compile, which leaves behind the modules.conf
and the generated files that selint wants in source mode; the check then
only reads ${S}.  Hanging it off do_compile also keeps it correct under
devtool: externalsrc puts the source tree in do_compile's
file-checksums, so an edited source re-runs do_compile and with it the
check.

do_selint is deliberately not [nostamp].  A task that always runs
invalidates its dependents, so every bitbake invocation would redo
compile, install and packaging.  A .bbappend can set
do_selint[noexec] = "1" to skip the check.

The config is selint's default plus the three checks that refpolicy CI
disables (C-005, C-008, W-005).

Assisted-by: Codewhale:deepseek-flash
Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 recipes-security/refpolicy/files/selint.conf    | 16 ++++++++++++++++
 recipes-security/refpolicy/refpolicy_common.inc | 11 ++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)
 create mode 100644 recipes-security/refpolicy/files/selint.conf

diff --git a/recipes-security/refpolicy/files/selint.conf b/recipes-security/refpolicy/files/selint.conf
new file mode 100644
index 0000000..0bb14cf
--- /dev/null
+++ b/recipes-security/refpolicy/files/selint.conf
@@ -0,0 +1,16 @@
+# Plain copy of selint v1.5.1's default config, plus refpolicy CI's disables.
+# -c replaces the installed config, so re-sync this when bumping SRCREV.
+
+severity = "convention"
+
+# C-005, C-008 and W-005 are disabled like in refpolicy's lint-policy CI.
+disable = { C-001, C-005, C-006, C-008, W-005, W-010, W-011, E-003, E-004 }
+
+enable_source = { W-010, W-011, E-003, E-004 }
+
+assume_users = { system_u }
+assume_roles = { object_r }
+
+ordering_rules = "refpolicy-lax"
+ordering_requires = { bool, attribute, attribute_role, type, class, role }
+ordering_requires_same_flavor = false
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index be0aa83..c9d752b 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -10,6 +10,7 @@ RPROVIDES:${PN} = "refpolicy"
 SRC_URI += "file://customizable_types \
             file://setrans-mls.conf \
             file://setrans-mcs.conf \
+            file://selint.conf \
            "
 
 # Base patches applied to all Yocto-based platforms.  Your own version of
@@ -94,7 +95,7 @@ FILES:${PN}-dev =+ " \
 
 EXTRANATIVEPATH += "bzip2-native"
 
-DEPENDS = "bzip2-replacement-native checkpolicy-native policycoreutils-native semodule-utils-native m4-native"
+DEPENDS = "bzip2-replacement-native checkpolicy-native policycoreutils-native semodule-utils-native m4-native selint-native"
 
 RDEPENDS:${PN}-dev = " \
     python3-core \
@@ -192,6 +193,14 @@ set_policy_booleans() {
     done
 }
 
+# Lint the policy sources so that a SELint finding fails the build.
+do_selint() {
+    cd ${S}
+    selint -c ${UNPACKDIR}/selint.conf \
+        --source --recursive --summary --fail policy
+}
+addtask selint after do_compile before do_install
+
 do_compile() {
     oe_runmake bare
     if [ -f "${WORKDIR}/modules.conf" ] ; then
-- 
2.43.0

