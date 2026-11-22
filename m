Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30213.1795327892033903951
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 21 Nov 2026 22:11:32 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wD3ylwMhwJrNTEAAA--.1308S3;
	Sun, 22 Nov 2026 14:09:16 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowABH2GiLhwJrkBE+AA--.9795S6;
	Sun, 22 Nov 2026 14:11:29 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [PATCH v2 4/4] conf/fragments: add a fragment to set ssh_sysadm_login
Date: Sun, 22 Nov 2026 14:11:22 +0800
Message-ID: <20261122061122.2042600-5-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122061122.2042600-1-chenqi_hycx@cetc.com.cn>
References: <20261122061122.2042600-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowABH2GiLhwJrkBE+AA--.9795S6
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYTCmsBn+ED+gAAsz
X-CM-DELIVERINFO: =?B?75PnOac9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOFa/r1iAD8uJ7SNfDBqCVpyxFcoNW+Aiq3HQfBJ3hg74ubFuG2CvVkSt/ymC6FOHL1xC
	qcO5TlTZHfABNv1omM7AreBResFT24JFowssT5bNyZxiwiTfaLZPwa+3SKnKKzf+23qTR/
	8xgecixypjPGI=
X-Coremail-Antispam: 1Uk129KBj93XoW7KrWUXw15AFy3Jr4DuFW3Jwc_yoW8WFW5pa
	nY9F4fAr1Iqr9aywnFyw42ga4FkF9xKr4UC34jgF1jvw4YkF1vkw1kKry7WF9IkFsxKryF
	v390qFy5WF4jy3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GFUv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY77kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2
	z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lw4CEc2x0rVAKj4xxMxkIecxEwVAFwVW8AwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
	s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
	1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
	A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI
	43ZEXa7IU8geOJUUUUU==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 22 Nov 2026 06:11:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5489
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

refpolicy-targeted makes root land in unconfined_u, and sshd_t needs
ssh_sysadm_login to transition there, so ssh root on a targeted image
fails with "/bin/sh: Permission denied" while the serial console works:

  avc: denied { transition } for comm="sshd-session"
       tcontext=unconfined_u:unconfined_r:unconfined_t

The boolean admits sshd_t to every user domain, so it stays off by
default: enable this fragment where root ssh is wanted.

Assisted-by: Codewhale:deepseek-v4-flash
Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 conf/fragments/ssh-sysadm-login.conf | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 conf/fragments/ssh-sysadm-login.conf

diff --git a/conf/fragments/ssh-sysadm-login.conf b/conf/fragments/ssh-sysadm-login.conf
new file mode 100644
index 0000000..6a1fdd1
--- /dev/null
+++ b/conf/fragments/ssh-sysadm-login.conf
@@ -0,0 +1,10 @@
+BB_CONF_FRAGMENT_SUMMARY = "Set ssh_sysadm_login, letting sshd_t reach the admin domains"
+BB_CONF_FRAGMENT_DESCRIPTION = "Turn on the ssh_sysadm_login policy boolean. \
+refpolicy-targeted puts root in unconfined_u, and sshd_t may only transition \
+there when the boolean is set, so without it `ssh root@<target>' fails with \
+'/bin/sh: Permission denied'. The boolean admits sshd_t to every user domain, \
+sysadm_r included, so it is off by default and this fragment is for images \
+that want root ssh."
+
+# The policy itself keeps the boolean off; this only sets the value.
+POLICY_BOOLEANS:append = " ssh_sysadm_login=true"
-- 
2.43.0

