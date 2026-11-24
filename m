Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16190.1795520514694098701
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Nov 2026 03:41:55 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wA3IVt2dwVrQ9QAAA--.4299S3;
	Tue, 24 Nov 2026 19:39:34 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowACXKWr5dwVrLcFAAA--.28459S5;
	Tue, 24 Nov 2026 19:41:49 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [meta-selinux][PATCH 3/4] refpolicy: escape the dot in the /run/issue.d file context
Date: Tue, 24 Nov 2026 19:41:36 +0800
Message-ID: <20261124114137.2203106-4-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124114137.2203106-1-chenqi_hycx@cetc.com.cn>
References: <20261124114137.2203106-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowACXKWr5dwVrLcFAAA--.28459S5
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYBCmsEQuMpvgABsU
X-CM-DELIVERINFO: =?B?qhXWSKc9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOGf+ybSYYtFb9Hm0wXO+e7oQImF3BfO1NT32lpeRyv+oJuIse3EyixAAwipZk/3iOy8/
	NZBnmzR50a1+PcbQpnfvq/Oy/3z4zCRlZrQ78qjqtptRfFTqgY3IgccsdeqlfA==
X-Coremail-Antispam: 1Uk129KBj93XoW7KrW8GF1kAw48Gw1rGFW7GFX_yoW8WF17pr
	4xZF1IkF1kWF1rAFn2kFn7Wr4jy3ya9w4DG3yqvw47C348Zw1DGF4xJrZFgFZ0qrySk3sF
	q34Uta9aqF1jv3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_Gw7v73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYw7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lw4CEc2x0rVAKj4xxMxkIecxEwVAFwVW8KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jrv_JF1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
	IE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07jOBMNUUUUU=
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 11:42:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5502
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

SELint reports:

  systemd.fc: 103: (W): File context path contains a potentially
  unescaped regex character '.' at position 11: /run/issue.d(/.*)?
  (W-004)

/run/issue.d is a literal path, so escape the dot.

Assisted-by: Codewhale:deepseek-flash
Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 .../0041-systemd-add-rules-for-systemd-ssh-issue.patch          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/refpolicy/refpolicy/0041-systemd-add-rules-for-systemd-ssh-issue.patch b/recipes-security/refpolicy/refpolicy/0041-systemd-add-rules-for-systemd-ssh-issue.patch
index 875896b..b883fb3 100644
--- a/recipes-security/refpolicy/refpolicy/0041-systemd-add-rules-for-systemd-ssh-issue.patch
+++ b/recipes-security/refpolicy/refpolicy/0041-systemd-add-rules-for-systemd-ssh-issue.patch
@@ -64,7 +64,7 @@ index e44d82a88..130c62370 100644
  /var/lib/systemd/pstore(/.*)?	gen_context(system_u:object_r:systemd_pstore_var_lib_t,s0)
  /var/lib/systemd/rfkill(/.*)?	gen_context(system_u:object_r:systemd_rfkill_var_lib_t,s0)
  
-+/run/issue.d(/.*)? gen_context(system_u:object_r:systemd_ssh_issue_runtime_t,s0)
++/run/issue\.d(/.*)? gen_context(system_u:object_r:systemd_ssh_issue_runtime_t,s0)
 +
  /run/\.nologin[^/]*	--	gen_context(system_u:object_r:systemd_sessions_runtime_t,s0)
  /run/nologin	--	gen_context(system_u:object_r:systemd_sessions_runtime_t,s0)
-- 
2.43.0

