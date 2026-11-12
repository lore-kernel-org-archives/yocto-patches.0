Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3758.1794445390671821607
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Nov 2026 17:03:11 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wDHItbRD_Vqcb8GAA--.30789S3;
	Thu, 12 Nov 2026 09:01:06 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowAB3umpIEPVqBww0AA--.6135S2;
	Thu, 12 Nov 2026 09:03:05 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [meta-selinux][PATCH] conf/fragments/enable.conf: add fragment to turn on SELinux
Date: Thu, 12 Nov 2026 09:02:57 +0800
Message-ID: <20261112010257.2716698-1-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowAB3umpIEPVqBww0AA--.6135S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYJCmr0cNkFnQABsq
X-CM-DELIVERINFO: =?B?g29Ar6c9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOAAx8qh59oxNkorLMbRBtpTE9+oQZbm2i8KnXOlvksUfeFUbC+J/LuA4/jW+Lp8lDkS3
	Wh2IAZswj3anaV4oOfaKqEzd5U6CiwVRM7SIQA1i86onlP16Auy7DGPG0wYZSA==
X-Coremail-Antispam: 1Uk129KBj93XoW7KrW8Jry7JFWDJFWrtFy5GFX_yoW8ZF4Dp3
	y8Jws8Jw1xXFnrCw13C3Wjgw4rXF93GayUXrWak3y2v3s0kr18C3yDtF13XFsFvas3Ja48
	ArWftFZxua98X3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3qc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_KbIjqfuFe4nv
	WSU5nxnvy29KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20V
	C2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4kE6xkIj40Ew7xC0wCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jrv_JF1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
	IE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU81SoJUUUUU==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 01:03:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5310
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

Add a fragment for easier use of SELinux in Yocto.

Enable it with 'bitbake-config-build enable-fragment selinux/enable' or
OE_FRAGMENTS += "selinux/enable".

It sets the selinux/pam/xattr distro features, pulls the SELinux kernel
features, defaults to refpolicy-mcs, labels the rootfs at image build
time, and installs policycoreutils and auditd.

Assisted-by: Codewhale:deepseek-v4-flash
Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 conf/fragments/enable.conf | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 conf/fragments/enable.conf

diff --git a/conf/fragments/enable.conf b/conf/fragments/enable.conf
new file mode 100644
index 0000000..12abc74
--- /dev/null
+++ b/conf/fragments/enable.conf
@@ -0,0 +1,22 @@
+BB_CONF_FRAGMENT_SUMMARY = "Enable SELinux support in the image"
+BB_CONF_FRAGMENT_DESCRIPTION = "Add the selinux DISTRO_FEATURE together with pam and \
+xattr, pull in the SELinux kernel features and a reference policy, and install \
+policycoreutils (for sestatus, setenforce, ...) plus auditd for logging denials. \
+The policy defaults to refpolicy-mcs; set PREFERRED_PROVIDER_virtual/refpolicy to \
+use another one. auditd is provided by meta-oe (openembedded-layer), so that layer \
+needs to be in bblayers.conf too."
+
+DISTRO_FEATURES:append = " pam xattr selinux"
+
+KERNEL_FEATURES:append = " cgl/features/selinux/selinux.scc cgl/features/selinux/selinux-dev.scc"
+
+PREFERRED_PROVIDER_virtual/refpolicy ?= "refpolicy-mcs"
+
+# Label the rootfs at image build time instead of relabelling on first boot.
+IMAGE_CLASSES:append = " selinux-image"
+FIRST_BOOT_RELABEL ?= "0"
+
+IMAGE_INSTALL:append = " packagegroup-core-selinux auditd policycoreutils"
+
+# Use a standalone syslog rather than busybox-syslog.
+VIRTUAL-RUNTIME_base-utils-syslog ?= "sysklogd"
-- 
2.43.0

