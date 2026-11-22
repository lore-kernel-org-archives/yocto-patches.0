Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.29935.1795327890943527159
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 21 Nov 2026 22:11:31 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wB3LFwHhwJrMTEAAA--.1359S3;
	Sun, 22 Nov 2026 14:09:12 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowABH2GiLhwJrkBE+AA--.9795S2;
	Sun, 22 Nov 2026 14:11:24 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [PATCH v2 0/4] meta-selinux: fix systemd 262 denials and run the SELinux tests on every variant
Date: Sun, 22 Nov 2026 14:11:18 +0800
Message-ID: <20261122061122.2042600-1-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowABH2GiLhwJrkBE+AA--.9795S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYTCmsBnhoDrwACsd
X-CM-DELIVERINFO: =?B?uj7uCKc9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOHShpPsBtNldyiwV+ylxQUnoiNUzAhk5d4IOHtKw9gdBq8ClAmYly0OH73IvGDQG++w1
	iSSQLKyb61MavIUSAB5/jkAw6Vnjm8cxnK3XFe3M5+v/3ExjDJBw3DDvh8vK+Q==
X-Coremail-Antispam: 1Uk129KBj93XoW7KrW8GFyxtF47tr1DJFWxXwc_yoW8Zw4fpa
	95KrZIyF17tF9ayrn7Ca1YqrW3Aas8Gw4DZ348Kw1jv3yYkF1kCw4rJw17XF1rAan3X3Wq
	vw1ava43GF4UAFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GFUv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYz7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2
	z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
	JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwAKzVCY07xG64k0F24lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVWUXVWUAwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
	cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIF
	yTuYvjxU2eMNUUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 22 Nov 2026 06:11:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5487
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

core-image-minimal on systemd 262 logged denials, and the oeqa cases
skipped instead of reporting them: they picked their behaviour from the
policy name rather than from the session's domain.

1 bumps refpolicy to c89bd1537 for the systemd 262 fixes and for the
shadow lock rework (upstream PR #1280).

2 runs `make bare` before do_compile, so a changed POLICY_BOOLEANS is
not defeated by stale generated files.

3 decides the cases from /proc/self/attr/current, and logs in as a
user_u test account where the session is unconfined.

4 adds a config fragment for ssh_sysadm_login rather than setting it in
the recipe, since turning it on admits sshd_t to every user domain and
should be the user's decision.  Enable it with
`OE_FRAGMENTS += "selinux/ssh-sysadm-login"` to test refpolicy-targeted,
where ssh root otherwise fails with "/bin/sh: Permission denied".

Tested with core-image-minimal on qemux86-64 and qemuarm64,
refpolicy-mcs 15 passed, refpolicy-targeted 14 passed 1 skipped, with
the refpolicy package in the image manifest checked each time.  All
five variants build: targeted, mcs, standard, mls and minimum.

changes in v2:
- upgrade refpolicy straight to c89bd1537: the shadow lock fix is
  upstream now, so no patch is carried for it
- set ssh_sysadm_login from an opt-in config fragment instead of from
  the recipe

Chen Qi (4):
  refpolicy: update to c89bd1537
  refpolicy_common: ensure we start from a clean state in do_compile
  oeqa: decide the SELinux cases on the domain, not the policy name
  conf/fragments: add a fragment to set ssh_sysadm_login

 conf/fragments/ssh-sysadm-login.conf          |  10 +
 lib/oeqa/runtime/cases/selinux.py             | 543 ++++++++++++++----
 ...main-used-for-login-program-to-conne.patch |  20 +-
 .../refpolicy/refpolicy_common.inc            |   1 +
 recipes-security/refpolicy/refpolicy_git.inc  |   2 +-
 5 files changed, 452 insertions(+), 124 deletions(-)
 create mode 100644 conf/fragments/ssh-sysadm-login.conf

-- 
2.43.0

