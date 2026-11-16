Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20382.1794797800161814519
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Nov 2026 18:56:41 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wD3sslmcPpqYNQAAA--.948S3;
	Mon, 16 Nov 2026 10:54:30 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowABn+WnccPpqPNA3AA--.14039S3;
	Mon, 16 Nov 2026 10:56:30 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [PATCH 1/6] refpolicy: bump to latest
Date: Mon, 16 Nov 2026 10:56:15 +0800
Message-ID: <20261116025620.2558594-2-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116025620.2558594-1-chenqi_hycx@cetc.com.cn>
References: <20261116025620.2558594-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowABn+WnccPpqPNA3AA--.14039S3
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYNCmr5tRgFSgADsx
X-CM-DELIVERINFO: =?B?Q8OP76c9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoONahKFcN3sR551ZGDSnKFd9Oyf95H3hydTUGBI9qMpMXfH9/s2F4N6/7v0gi1R14NA7O
	S49C1S+dTrHld3lbvnJ5aRBlGnxz2xTFyYapbkYP/PSwPpLEIx12YMqzNBsj3g==
X-Coremail-Antispam: 1Uk129KBj9fXoWDuFWrCr1Duw4xZFW8GF43XFc_yoWfKFWUXo
	W8KanIqa1xCry7GF1Ika17ZFyUZwsIqa97JrWrJF18GFWktFy3tFs7CwnxJFWrWFy8ZF45
	ZryUu34kZr9rJr1Ul-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn5kqx4xG64xvF2IEw4CE5I8CrVC2j2Wlc2xSY4AK67AK6r4UYxn0WfAS
	r-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUUbVkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI
	8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJ
	M28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2I
	x0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xv
	wVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lw4CEc2x0rVAKj4xxMxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_
	GrUvcSsGvfC2KfnxnUUI43ZEXa7IU16pB3UUUUU==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 02:56:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5400
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

Bump to latest mainly for fixing issues for new systemd.

The commits are:
```
720c02a1b Merge pull request #1282 from ChenQi1989/bugfix-systemd
59a48ba7e Merge pull request #1284 from dsugar100/main
d6ef7f26b systemd: let the user manager getattr clock devices
98421e290 systemd: allow systemd-coredumpd to start
c89e5d936 systemd: give /run/sysctl.d its own type
b88bdf4fe systemd: let user systemd-tmpfiles read /usr
8c2498a23 ntp: let systemd-timesyncd read the IPv6 sysctls
13afa2496 systemd: allow varlink socket xattr access
c9085fb7c logging: grant journald access to /run/systemd/units
2c5e71180 fapolicyd: ptrace permission for user namespace
```

Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 ...tile-alias-common-var-volatile-paths.patch |  5 +----
 ...e-unconfined_u-definition-to-unconfi.patch | 13 +++++-------
 ...box-set-aliases-for-bin-sbin-and-usr.patch |  5 +----
 ...ed-make-unconfined_u-the-default-sel.patch |  7 ++-----
 ...y-policy-to-common-yocto-hostname-al.patch |  5 +----
 ...sr-bin-bash-context-to-bin-bash.bash.patch |  9 +++------
 ...abel-resolv.conf-in-var-run-properly.patch |  5 +----
 ...-apply-login-context-to-login.shadow.patch |  5 +----
 ...-fc-hwclock-add-hwclock-alternatives.patch |  5 +----
 ...g-apply-policy-to-dmesg-alternatives.patch |  5 +----
 ...ssh-apply-policy-to-ssh-alternatives.patch |  5 +----
 ...ply-policy-to-network-commands-alter.patch |  5 +----
 ...ply-rpm_exec-policy-to-cpio-binaries.patch |  5 +----
 ...c-su-apply-policy-to-su-alternatives.patch |  5 +----
 ...fc-fstools-fix-real-path-for-fstools.patch |  5 +----
 ...fix-update-alternatives-for-sysvinit.patch | 11 ++++------
 ...l-apply-policy-to-brctl-alternatives.patch |  5 +----
 ...apply-policy-to-nologin-alternatives.patch |  9 +++------
 ...apply-policy-to-sulogin-alternatives.patch |  5 +----
 ...tp-apply-policy-to-ntpd-alternatives.patch |  5 +----
 ...pply-policy-to-kerberos-alternatives.patch |  5 +----
 ...ap-apply-policy-to-ldap-alternatives.patch |  5 +----
 ...ply-policy-to-postgresql-alternative.patch |  5 +----
 ...ply-policy-to-usermanage-alternative.patch |  5 +----
 ...etty-add-file-context-to-start_getty.patch |  5 +----
 ...k-apply-policy-to-vlock-alternatives.patch |  5 +----
 ...for-init-scripts-and-systemd-service.patch |  9 +++------
 ...bs_dist-set-aliase-for-root-director.patch |  5 +----
 ...ystem-logging-add-rules-for-the-syml.patch |  7 ++-----
 ...ystem-logging-add-rules-for-syslogd-.patch |  7 ++-----
 ...ernel-files-add-rules-for-the-symlin.patch |  5 +----
 ...ystem-logging-fix-auditd-startup-fai.patch |  7 ++-----
 ...ernel-terminal-don-t-audit-tty_devic.patch |  5 +----
 ...ystem-systemd-enable-support-for-sys.patch |  7 ++-----
 ...es-system-systemd-systemd-user-fixes.patch | 13 +++++-------
 ...ystem-logging-grant-getpcap-capabili.patch |  7 ++-----
 ...ystem-allow-services-to-read-tmpfs-u.patch | 15 ++++++--------
 ...ernel-domain-allow-all-domains-to-co.patch |  9 +++------
 ...-allow-systemd-logind-to-inherit-fds.patch | 11 ++++------
 ...stemd-tmpfiles-to-read-bin_t-symlink.patch | 17 +++++++---------
 ...-systemd-networkd-and-systemd-rfkill.patch | 13 +++++-------
 ...main-used-for-login-program-to-conne.patch | 20 +++++++++----------
 ...temd-add-rules-for-systemd-ssh-issue.patch | 15 ++++++--------
 ...ystem-mount-make-mount_t-domain-MLS-.patch |  5 +----
 ...oles-sysadm-MLS-sysadm-rw-to-clearan.patch |  7 ++-----
 ...ervices-rpc-make-nfsd_t-domain-MLS-t.patch | 13 +++++-------
 ...dmin-dmesg-make-dmesg_t-MLS-trusted-.patch |  5 +----
 ...ernel-kernel-make-kernel_t-MLS-trust.patch |  9 +++------
 ...ystem-init-make-init_t-MLS-trusted-f.patch |  9 +++------
 ...ystem-systemd-make-systemd-tmpfiles_.patch |  9 +++------
 ...ystem-systemd-systemd-make-systemd_-.patch | 15 ++++++--------
 ...ystem-logging-add-the-syslogd_t-to-t.patch |  7 ++-----
 ...ystem-init-make-init_t-MLS-trusted-f.patch |  9 +++------
 ...ystem-init-all-init_t-to-read-any-le.patch |  9 +++------
 ...ystem-logging-allow-auditd_t-to-writ.patch |  7 ++-----
 ...ernel-kernel-make-kernel_t-MLS-trust.patch |  9 +++------
 ...ystem-setrans-allow-setrans_t-use-fd.patch |  5 +----
 ...ystem-systemd-make-_systemd_t-MLS-tr.patch |  9 +++------
 ...ystem-logging-make-syslogd_runtime_t.patch |  7 ++-----
 recipes-security/refpolicy/refpolicy_git.inc  |  2 +-
 60 files changed, 143 insertions(+), 319 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch b/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
index d269f72..49438fa 100644
--- a/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
+++ b/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
@@ -1,4 +1,4 @@
-From 353f0521c52ea934cc1745d53fea8cad429b3a60 Mon Sep 17 00:00:00 2001
+From 99ea3d625e107b4ea8add75682652c7e1c8a9429 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 16:14:09 -0400
 Subject: [PATCH] fc/subs/volatile: alias common /var/volatile paths
@@ -31,6 +31,3 @@ index deeadcb80..8b9423db8 100644
  # systemd system extension (systemd-sysext) staging dirs merge onto /usr and /opt,
  # and systemd configuration extension (systemd-confext) staging dirs merge onto /etc.
  # The staged trees are overlaid onto the host tree with overlayfs, so they must carry
-
--- 
-2.43.0
diff --git a/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch b/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch
index a87a7bc..54a7203 100644
--- a/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch
+++ b/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch
@@ -1,4 +1,4 @@
-From 72c80020c69df0035a39fb1d6db8c75b2a4f7fa8 Mon Sep 17 00:00:00 2001
+From 7f13171702da2e79f2d5aacf83a8ced3c275b07c Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Wed, 19 Feb 2025 21:35:02 +0800
 Subject: [PATCH] Revert "users: Move unconfined_u definition to unconfined
@@ -18,10 +18,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  3 files changed, 10 insertions(+), 14 deletions(-)
 
 diff --git a/policy/modules/kernel/kernel.te b/policy/modules/kernel/kernel.te
-index 287b0098f..26978623b 100644
+index 3756a0135..084550ee2 100644
 --- a/policy/modules/kernel/kernel.te
 +++ b/policy/modules/kernel/kernel.te
-@@ -37,6 +37,9 @@ role sysadm_r;
+@@ -45,6 +45,9 @@ role sysadm_r;
  role staff_r;
  role user_r;
  
@@ -32,7 +32,7 @@ index 287b0098f..26978623b 100644
  	role secadm_r;
  	role auditadm_r;
 diff --git a/policy/modules/system/unconfined.te b/policy/modules/system/unconfined.te
-index 1c98f5e85..4ef723b85 100644
+index 169ecd759..580a483c3 100644
 --- a/policy/modules/system/unconfined.te
 +++ b/policy/modules/system/unconfined.te
 @@ -8,9 +8,6 @@ policy_module(unconfined)
@@ -45,7 +45,7 @@ index 1c98f5e85..4ef723b85 100644
  userdom_base_user_template(unconfined)
  userdom_manage_home_role(unconfined_r, unconfined_t)
  userdom_manage_tmp_role(unconfined_r, unconfined_t)
-@@ -277,14 +274,3 @@ unconfined_domain_noaudit(unconfined_execmem_t)
+@@ -269,14 +266,3 @@ optional_policy(`
  optional_policy(`
  	unconfined_dbus_chat(unconfined_execmem_t)
  ')
@@ -78,6 +78,3 @@ index 25402afd8..ca203758c 100644
  #
  # The following users correspond to Unix identities.
  # These identities are typically assigned as the user attribute
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch b/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
index d7e525f..02f1c2f 100644
--- a/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
+++ b/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
@@ -1,4 +1,4 @@
-From 1cb7a914b570ca8dd51ea7b4e6a4ffadedde709d Mon Sep 17 00:00:00 2001
+From 8468ca5ac7bf49c912e867692866def91e20f5c3 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 20:48:10 -0400
 Subject: [PATCH] fc/subs/busybox: set aliases for bin, sbin and usr
@@ -31,6 +31,3 @@ index 8b9423db8..bae4ef439 100644
  # systemd system extension (systemd-sysext) staging dirs merge onto /usr and /opt,
  # and systemd configuration extension (systemd-confext) staging dirs merge onto /etc.
  # The staged trees are overlaid onto the host tree with overlayfs, so they must carry
-
--- 
-2.43.0
diff --git a/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch b/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch
index f5c75e7..8dd07e1 100644
--- a/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch
+++ b/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch
@@ -1,4 +1,4 @@
-From 34f61ba8c90107644ab2be8cc5a4eb70f2b3c0da Mon Sep 17 00:00:00 2001
+From dd3d0185ab5546b61810a461a216915d0cfe6b1d Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Mon, 20 Apr 2020 11:50:03 +0800
 Subject: [PATCH] refpolicy-targeted: make unconfined_u the default selinux
@@ -38,7 +38,7 @@ index ce614b41b..c0903d98b 100644
 +root:unconfined_u:s0-mcs_systemhigh
 +__default__:unconfined_u:s0
 diff --git a/policy/modules/system/unconfined.te b/policy/modules/system/unconfined.te
-index 4ef723b85..671d38664 100644
+index 580a483c3..a78743317 100644
 --- a/policy/modules/system/unconfined.te
 +++ b/policy/modules/system/unconfined.te
 @@ -20,6 +20,11 @@ type unconfined_execmem_t alias ada_t;
@@ -76,6 +76,3 @@ index ca203758c..e737cd9cc 100644
 -	gen_user(root, sysadm, sysadm_r staff_r ifdef(`enable_mls',`secadm_r auditadm_r'), s0, s0 - mls_systemhigh, mcs_allcats)
 +	gen_user(root, sysadm, unconfined_r sysadm_r staff_r ifdef(`enable_mls',`secadm_r auditadm_r'), s0, s0 - mls_systemhigh, mcs_allcats)
  ')
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch b/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch
index 616bfb9..7d80860 100644
--- a/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch
+++ b/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch
@@ -1,4 +1,4 @@
-From 497c78fb77d0b00e02f7268b470dc2c8378eafdc Mon Sep 17 00:00:00 2001
+From 02f5eafeec3df2027d520cae23c58e8c9c0c95b6 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] fc/hostname: apply policy to common yocto hostname
@@ -21,6 +21,3 @@ index 83ddeb573..cf523bc4c 100644
  /usr/bin/hostname	--	gen_context(system_u:object_r:hostname_exec_t,s0)
 +/usr/bin/hostname\.net-tools	--	gen_context(system_u:object_r:hostname_exec_t,s0)
 +/usr/bin/hostname\.coreutils	--	gen_context(system_u:object_r:hostname_exec_t,s0)
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch b/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch
index b5121cf..c47b828 100644
--- a/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch
+++ b/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch
@@ -1,4 +1,4 @@
-From 9ca5ab98c9bd1fe320fe131b8e9d79bce7378a68 Mon Sep 17 00:00:00 2001
+From 9fb0297420393e8d9f6823315569aaab6cbd4d7d Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 21:37:32 -0400
 Subject: [PATCH] fc/bash: apply /usr/bin/bash context to /bin/bash.bash
@@ -15,10 +15,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/kernel/corecommands.fc b/policy/modules/kernel/corecommands.fc
-index 59164d5c6..469dbe67c 100644
+index 45a87fae4..07c74a4e5 100644
 --- a/policy/modules/kernel/corecommands.fc
 +++ b/policy/modules/kernel/corecommands.fc
-@@ -155,6 +155,7 @@ ifdef(`distro_gentoo',`
+@@ -158,6 +158,7 @@ ifdef(`distro_gentoo',`
  /usr/bin(/.*)?				gen_context(system_u:object_r:bin_t,s0)
  /usr/bin/d?ash			--	gen_context(system_u:object_r:shell_exec_t,s0)
  /usr/bin/bash			--	gen_context(system_u:object_r:shell_exec_t,s0)
@@ -26,6 +26,3 @@ index 59164d5c6..469dbe67c 100644
  /usr/bin/bash2			--	gen_context(system_u:object_r:shell_exec_t,s0)
  /usr/bin/fish			--	gen_context(system_u:object_r:shell_exec_t,s0)
  /usr/bin/git-shell		--	gen_context(system_u:object_r:shell_exec_t,s0)
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch b/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch
index 3cb2e91..8aa04df 100644
--- a/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch
+++ b/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch
@@ -1,4 +1,4 @@
-From dd13c78e2540ace19b4c671f0e5a8c8d8e842930 Mon Sep 17 00:00:00 2001
+From f2871ad9554240bcb02a2b7f7498771c0c94dddc Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 4 Apr 2019 10:45:03 -0400
 Subject: [PATCH] fc/resolv.conf: label resolv.conf in var/run/ properly
@@ -24,6 +24,3 @@ index 2e035b326..eab862b3d 100644
  
  ifdef(`distro_gentoo',`
  /var/lib/dhcpc(/.*)?		gen_context(system_u:object_r:dhcpc_state_t,s0)
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch b/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch
index 86c4b07..10392cd 100644
--- a/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch
+++ b/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch
@@ -1,4 +1,4 @@
-From eec64127ce7d0c50b40ae7fd8a8891def106ef37 Mon Sep 17 00:00:00 2001
+From 26b0e440206a4a6d1fabed669a21fd96eb475cf2 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 21:43:53 -0400
 Subject: [PATCH] fc/login: apply login context to login.shadow
@@ -23,6 +23,3 @@ index 584b78fa3..ace52ee63 100644
  /usr/bin/pam_console_apply	--	gen_context(system_u:object_r:pam_console_exec_t,s0)
  /usr/bin/pam_timestamp_check	--	gen_context(system_u:object_r:pam_exec_t,s0)
  /usr/bin/tcb_convert		--	gen_context(system_u:object_r:updpwd_exec_t,s0)
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch b/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch
index c86b568..871f0d3 100644
--- a/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch
@@ -1,4 +1,4 @@
-From 85a5dda3e1ec15ca867ff459256e987d3fc98718 Mon Sep 17 00:00:00 2001
+From f320908cf3df534dd35aa9c680e32c80a4381d26 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 21:59:18 -0400
 Subject: [PATCH] fc/hwclock: add hwclock alternatives
@@ -21,6 +21,3 @@ index 4ed95240e..b8e6b801c 100644
  /usr/bin/hwclock	--	gen_context(system_u:object_r:hwclock_exec_t,s0)
 +/usr/bin/hwclock\.util-linux	--	gen_context(system_u:object_r:hwclock_exec_t,s0)
  
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch b/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch
index ac52d2f..fa8b3f7 100644
--- a/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch
@@ -1,4 +1,4 @@
-From 7a8bf5af71c6b931cd7f8f3f103ed4de119339f0 Mon Sep 17 00:00:00 2001
+From e900c5de27ac6c9f2780ddbd4b0a339808051ec7 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 08:26:55 -0400
 Subject: [PATCH] fc/dmesg: apply policy to dmesg alternatives
@@ -18,6 +18,3 @@ index e52fdfcf8..526b92ed2 100644
 @@ -1 +1,2 @@
  /usr/bin/dmesg		--		gen_context(system_u:object_r:dmesg_exec_t,s0)
 +/usr/bin/dmesg\.util-linux		--		gen_context(system_u:object_r:dmesg_exec_t,s0)
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch b/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch
index e049627..c9a16ec 100644
--- a/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch
@@ -1,4 +1,4 @@
-From 87366cc35ac0d63581076ad1885064f8f26e7469 Mon Sep 17 00:00:00 2001
+From 15bb77687cd69ac02f12e59b468f15880664ae0a Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 09:20:58 -0400
 Subject: [PATCH] fc/ssh: apply policy to ssh alternatives
@@ -23,6 +23,3 @@ index f9dd0752d..13d9dd35d 100644
  /usr/bin/ssh-agent		--	gen_context(system_u:object_r:ssh_agent_exec_t,s0)
  /usr/bin/ssh-keygen		--	gen_context(system_u:object_r:ssh_keygen_exec_t,s0)
  /usr/bin/sshd			--	gen_context(system_u:object_r:sshd_exec_t,s0)
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch b/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch
index 5c87320..8222c79 100644
--- a/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch
+++ b/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch
@@ -1,4 +1,4 @@
-From 9fa0c7e1c999f0362cc1661366d6cd2767a7019d Mon Sep 17 00:00:00 2001
+From fcfb4879982be60f0270cd8b5722bbeb7c34b763 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Tue, 9 Jun 2015 21:22:52 +0530
 Subject: [PATCH] fc/sysnetwork: apply policy to network commands alternatives
@@ -34,6 +34,3 @@ index eab862b3d..4c9dac6f3 100644
  /usr/bin/pump			    --	gen_context(system_u:object_r:dhcpc_exec_t,s0)
  /usr/bin/tc			        --	gen_context(system_u:object_r:ifconfig_exec_t,s0)
  
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch b/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch
index 13a9540..b17c744 100644
--- a/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch
+++ b/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch
@@ -1,4 +1,4 @@
-From 6a3fdc4dc073cf37a782292fc1cd006f9c26f68c Mon Sep 17 00:00:00 2001
+From 801744f67c0359d103c1339b2a06fd77ef8115d6 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 09:54:07 -0400
 Subject: [PATCH] fc/rpm: apply rpm_exec policy to cpio binaries
@@ -21,6 +21,3 @@ index 059c35a68..22e2a3f65 100644
  /usr/bin/cpio	--	gen_context(system_u:object_r:rpm_exec_t,s0)
 +/usr/bin/cpio\.cpio	--	gen_context(system_u:object_r:rpm_exec_t,s0)
  ')
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch b/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch
index a822887..3c3c2da 100644
--- a/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch
@@ -1,4 +1,4 @@
-From 03cc031e0154e032cdcaf75d1f6eeaa473cc37a1 Mon Sep 17 00:00:00 2001
+From 5ea2df182f6514eb9581a498b1a9ebc120fa7f49 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 13 Feb 2014 00:33:07 -0500
 Subject: [PATCH] fc/su: apply policy to su alternatives
@@ -22,6 +22,3 @@ index 3375c9692..a9868cd58 100644
  /usr/bin/su		--	gen_context(system_u:object_r:su_exec_t,s0)
 +/usr/bin/su\.shadow		--	gen_context(system_u:object_r:su_exec_t,s0)
 +/usr/bin/su\.util-linux		--	gen_context(system_u:object_r:su_exec_t,s0)
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch b/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
index ab254d3..496c1b1 100644
--- a/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
+++ b/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
@@ -1,4 +1,4 @@
-From 4beb1c28718bce5b470ea886c2cd0a38ca7a7463 Mon Sep 17 00:00:00 2001
+From 34132461d20d9e1e3174f73022edf159e3606c2c Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Mon, 27 Jan 2014 03:54:01 -0500
 Subject: [PATCH] fc/fstools: fix real path for fstools
@@ -77,6 +77,3 @@ index 8386937c4..02adc5400 100644
  
  ifdef(`distro_gentoo',`
  /var/db/smartmontools(/.*)?		gen_context(system_u:object_r:fsadm_db_t,s0)
-
--- 
-2.43.0
diff --git a/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch b/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
index 260d796..d1ba3cc 100644
--- a/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
+++ b/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
@@ -1,4 +1,4 @@
-From fb8cdae6d8b2b196e47941fff258882c2880f89a Mon Sep 17 00:00:00 2001
+From 5c90ced9220fc8febc784e12af7728a16566b044 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] fc/init: fix update-alternatives for sysvinit
@@ -27,10 +27,10 @@ index 56476f85b..22368afea 100644
  /usr/lib/upstart/shutdown	--	gen_context(system_u:object_r:shutdown_exec_t,s0)
  
 diff --git a/policy/modules/kernel/corecommands.fc b/policy/modules/kernel/corecommands.fc
-index 469dbe67c..9020ced10 100644
+index 07c74a4e5..fba998bf8 100644
 --- a/policy/modules/kernel/corecommands.fc
 +++ b/policy/modules/kernel/corecommands.fc
-@@ -164,6 +164,8 @@ ifdef(`distro_gentoo',`
+@@ -167,6 +167,8 @@ ifdef(`distro_gentoo',`
  /usr/bin/mkfs\.cramfs		--	gen_context(system_u:object_r:bin_t,s0)
  /usr/bin/mksh			--	gen_context(system_u:object_r:shell_exec_t,s0)
  /usr/bin/mountpoint		--	gen_context(system_u:object_r:bin_t,s0)
@@ -40,7 +40,7 @@ index 469dbe67c..9020ced10 100644
  /usr/bin/sash			--	gen_context(system_u:object_r:shell_exec_t,s0)
  /usr/bin/sesh			--	gen_context(system_u:object_r:shell_exec_t,s0)
 diff --git a/policy/modules/system/init.fc b/policy/modules/system/init.fc
-index 19c876336..e865bea85 100644
+index 775a86a35..000bd52b9 100644
 --- a/policy/modules/system/init.fc
 +++ b/policy/modules/system/init.fc
 @@ -28,6 +28,7 @@ ifdef(`distro_gentoo',`
@@ -51,6 +51,3 @@ index 19c876336..e865bea85 100644
  /usr/bin/open_init_pty	--	gen_context(system_u:object_r:initrc_exec_t,s0)
  /usr/bin/sepg_ctl	--	gen_context(system_u:object_r:initrc_exec_t,s0)
  /usr/bin/systemd	--	gen_context(system_u:object_r:init_exec_t,s0)
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch b/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch
index 72b1fd6..8116889 100644
--- a/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch
@@ -1,4 +1,4 @@
-From 89b022f8aa33ad403b76c3fe53caf1a5fbfe4a4b Mon Sep 17 00:00:00 2001
+From 4ca53f6752e68ec011b7c87dca1a6f82a27c3f87 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:19:54 +0800
 Subject: [PATCH] fc/brctl: apply policy to brctl alternatives
@@ -18,6 +18,3 @@ index c7cdc3358..231b82dc5 100644
  /usr/bin/brctl	--	gen_context(system_u:object_r:brctl_exec_t,s0)
 +/usr/bin/brctl\.bridge-utils	--	gen_context(system_u:object_r:brctl_exec_t,s0)
  
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch b/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch
index 03f565c..741a117 100644
--- a/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch
@@ -1,4 +1,4 @@
-From c34bda34ad6855b5a75a6573dcc7b6450b1646d1 Mon Sep 17 00:00:00 2001
+From 9c8555823354b79eae2c4e6078c7520b147c962c Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:21:51 +0800
 Subject: [PATCH] fc/corecommands: apply policy to nologin alternatives
@@ -11,10 +11,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/kernel/corecommands.fc b/policy/modules/kernel/corecommands.fc
-index 9020ced10..851529abd 100644
+index fba998bf8..110e7471d 100644
 --- a/policy/modules/kernel/corecommands.fc
 +++ b/policy/modules/kernel/corecommands.fc
-@@ -167,6 +167,8 @@ ifdef(`distro_gentoo',`
+@@ -170,6 +170,8 @@ ifdef(`distro_gentoo',`
  /usr/bin/mountpoint\.sysvinit		--	gen_context(system_u:object_r:bin_t,s0)
  /usr/bin/mountpoint\.util-linux		--	gen_context(system_u:object_r:bin_t,s0)
  /usr/bin/nologin		--	gen_context(system_u:object_r:shell_exec_t,s0)
@@ -23,6 +23,3 @@ index 9020ced10..851529abd 100644
  /usr/bin/sash			--	gen_context(system_u:object_r:shell_exec_t,s0)
  /usr/bin/sesh			--	gen_context(system_u:object_r:shell_exec_t,s0)
  /usr/bin/scponly		--	gen_context(system_u:object_r:shell_exec_t,s0)
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch b/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch
index 1cf6ca5..06b09c1 100644
--- a/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch
@@ -1,4 +1,4 @@
-From 074f896320aec752cf1df689982da3d6c26f48a1 Mon Sep 17 00:00:00 2001
+From f3a90d85fe025d70377eb1a2054fbbedafac52b8 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:43:28 +0800
 Subject: [PATCH] fc/locallogin: apply policy to sulogin alternatives
@@ -19,6 +19,3 @@ index 761b02490..a434e5013 100644
 +/usr/bin/sulogin\.util-linux	--	gen_context(system_u:object_r:sulogin_exec_t,s0)
  /usr/bin/sushell	--	gen_context(system_u:object_r:sulogin_exec_t,s0)
  
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch b/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch
index ae9a5c7..8da40c3 100644
--- a/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch
@@ -1,4 +1,4 @@
-From bc7cf91865d4f49a2af1100e1a0b692fead807e8 Mon Sep 17 00:00:00 2001
+From e58804cde28e40af0a730fb3f6f210434b41531d Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:45:23 +0800
 Subject: [PATCH] fc/ntp: apply policy to ntpd alternatives
@@ -22,6 +22,3 @@ index ccea79c30..f24cd7c48 100644
  /usr/bin/ntpdate			--	gen_context(system_u:object_r:ntpdate_exec_t,s0)
  /usr/bin/sntp				--	gen_context(system_u:object_r:ntpdate_exec_t,s0)
  
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch b/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
index 893c839..55015f6 100644
--- a/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
@@ -1,4 +1,4 @@
-From 7d14d563c9e6256274e9b31068b8ae42d2fc4a08 Mon Sep 17 00:00:00 2001
+From ed9a362cfced476ff23bd9a2102a422947f05042 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:55:05 +0800
 Subject: [PATCH] fc/kerberos: apply policy to kerberos alternatives
@@ -41,6 +41,3 @@ index aae6c841d..9afe60ec4 100644
  /var/log/krb5kdc\.log.*	--	gen_context(system_u:object_r:krb5kdc_log_t,s0)
  /var/log/kadmin\.log.*	--	gen_context(system_u:object_r:kadmind_log_t,s0)
  /var/log/kadmind\.log.*	--	gen_context(system_u:object_r:kadmind_log_t,s0)
-
--- 
-2.43.0
diff --git a/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch b/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch
index b4a6674..ea8bf30 100644
--- a/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch
@@ -1,4 +1,4 @@
-From 5028db3655914d148e82237533dc8c07f99be535 Mon Sep 17 00:00:00 2001
+From bd8e5053e24e6dffc1ba46c6cd91ce4b9fd9733d Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 11:06:13 +0800
 Subject: [PATCH] fc/ldap: apply policy to ldap alternatives
@@ -35,6 +35,3 @@ index 40c09df5e..cc6c98221 100644
  /run/ldapi	-s	gen_context(system_u:object_r:slapd_runtime_t,s0)
  /run/openldap(/.*)?	gen_context(system_u:object_r:slapd_runtime_t,s0)
  /run/slapd.*	-s	gen_context(system_u:object_r:slapd_runtime_t,s0)
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch b/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch
index def5e80..3b7a873 100644
--- a/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch
+++ b/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch
@@ -1,4 +1,4 @@
-From 4f43e9a674623e562b1805bd06a61ef4690973d8 Mon Sep 17 00:00:00 2001
+From 57fde72ec018d30f72d6bc15d336b36e05135bdc Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 11:13:16 +0800
 Subject: [PATCH] fc/postgresql: apply policy to postgresql alternatives
@@ -32,6 +32,3 @@ index f31a52cf8..f9bf46870 100644
  ifdef(`distro_redhat', `
  /usr/share/jonas/pgsql(/.*)?		gen_context(system_u:object_r:postgresql_db_t,s0)
  ')
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0022-fc-usermanage-apply-policy-to-usermanage-alternative.patch b/recipes-security/refpolicy/refpolicy/0022-fc-usermanage-apply-policy-to-usermanage-alternative.patch
index 9ca5223..75c00ca 100644
--- a/recipes-security/refpolicy/refpolicy/0022-fc-usermanage-apply-policy-to-usermanage-alternative.patch
+++ b/recipes-security/refpolicy/refpolicy/0022-fc-usermanage-apply-policy-to-usermanage-alternative.patch
@@ -1,4 +1,4 @@
-From 8f2b61f8473e0eb191446f639af7ef71fc50fbec Mon Sep 17 00:00:00 2001
+From bb0d28fe4d127af7c294c9b50c2b2971bc4b11bc Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 11:25:34 +0800
 Subject: [PATCH] fc/usermanage: apply policy to usermanage alternatives
@@ -44,6 +44,3 @@ index c228ebce6..9ac425e92 100644
  
  /usr/lib/cracklib_dict.* --	gen_context(system_u:object_r:crack_db_t,s0)
  
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch b/recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch
index e9b70b2..747abfc 100644
--- a/recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch
+++ b/recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch
@@ -1,4 +1,4 @@
-From 75ad7b87b85a3fb0f0d00b88831a3171a01e8fa0 Mon Sep 17 00:00:00 2001
+From a258e7f272e01704b31aa96fbf7addfd0ae658dc Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 16:07:30 +0800
 Subject: [PATCH] fc/getty: add file context to start_getty
@@ -22,6 +22,3 @@ index c7701c930..8b70b609a 100644
  
  
  /var/log/mgetty\.log.*	--	gen_context(system_u:object_r:getty_log_t,s0)
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0024-fc-vlock-apply-policy-to-vlock-alternatives.patch b/recipes-security/refpolicy/refpolicy/0024-fc-vlock-apply-policy-to-vlock-alternatives.patch
index a03a10a..5180199 100644
--- a/recipes-security/refpolicy/refpolicy/0024-fc-vlock-apply-policy-to-vlock-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0024-fc-vlock-apply-policy-to-vlock-alternatives.patch
@@ -1,4 +1,4 @@
-From 75acb49606229cb4f8d626249efc75544dc37219 Mon Sep 17 00:00:00 2001
+From 41e094594228a1187dfb72b3e1fd28e57ce4d2e7 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Wed, 18 Dec 2019 15:04:41 +0800
 Subject: [PATCH] fc/vlock: apply policy to vlock alternatives
@@ -19,6 +19,3 @@ index bdd3e6a9f..fb5b28d7c 100644
 +/usr/bin/vlock\.kbd		--	gen_context(system_u:object_r:vlock_exec_t,s0)
  /usr/bin/vlock-main	--	gen_context(system_u:object_r:vlock_exec_t,s0)
  
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0025-fc-add-fcontext-for-init-scripts-and-systemd-service.patch b/recipes-security/refpolicy/refpolicy/0025-fc-add-fcontext-for-init-scripts-and-systemd-service.patch
index 25fd308..9c7cfb6 100644
--- a/recipes-security/refpolicy/refpolicy/0025-fc-add-fcontext-for-init-scripts-and-systemd-service.patch
+++ b/recipes-security/refpolicy/refpolicy/0025-fc-add-fcontext-for-init-scripts-and-systemd-service.patch
@@ -1,4 +1,4 @@
-From 4db66a10c2917fe08f643726b9854d1230090bcc Mon Sep 17 00:00:00 2001
+From 99b50a0f1394a42bdbdd91f1df58095349cbb081 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 30 Jun 2020 10:45:57 +0800
 Subject: [PATCH] fc: add fcontext for init scripts and systemd service files
@@ -14,7 +14,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  4 files changed, 5 insertions(+)
 
 diff --git a/policy/modules/services/cron.fc b/policy/modules/services/cron.fc
-index 8c9a749bc..f5a52b406 100644
+index 5508e00ba..57f53089d 100644
 --- a/policy/modules/services/cron.fc
 +++ b/policy/modules/services/cron.fc
 @@ -1,4 +1,5 @@
@@ -24,7 +24,7 @@ index 8c9a749bc..f5a52b406 100644
  /etc/cron\.d(/.*)?	gen_context(system_u:object_r:system_cron_spool_t,s0)
  /etc/crontab	--	gen_context(system_u:object_r:system_cron_spool_t,s0)
 diff --git a/policy/modules/services/rngd.fc b/policy/modules/services/rngd.fc
-index 367592c8d..6b5a5f11e 100644
+index 626025247..3db1da377 100644
 --- a/policy/modules/services/rngd.fc
 +++ b/policy/modules/services/rngd.fc
 @@ -1,4 +1,5 @@
@@ -59,6 +59,3 @@ index 0b6698d63..e2a43f305 100644
  /usr/lib/systemd/systemd-journald -- gen_context(system_u:object_r:syslogd_exec_t,s0)
  /usr/lib/systemd/systemd-kmsg-syslogd	--	gen_context(system_u:object_r:syslogd_exec_t,s0)
  
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0026-file_contexts.subs_dist-set-aliase-for-root-director.patch b/recipes-security/refpolicy/refpolicy/0026-file_contexts.subs_dist-set-aliase-for-root-director.patch
index 6f6b2fc..85722dc 100644
--- a/recipes-security/refpolicy/refpolicy/0026-file_contexts.subs_dist-set-aliase-for-root-director.patch
+++ b/recipes-security/refpolicy/refpolicy/0026-file_contexts.subs_dist-set-aliase-for-root-director.patch
@@ -1,4 +1,4 @@
-From 25b8af93a5684abf449afed1414ca6e38184e0ae Mon Sep 17 00:00:00 2001
+From 710ca608ba3e2be53ec52ae15f4747f9f0226f1f Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Sun, 5 Apr 2020 22:03:45 +0800
 Subject: [PATCH] file_contexts.subs_dist: set aliase for /root directory
@@ -28,6 +28,3 @@ index bae4ef439..fb966318b 100644
  # systemd system extension (systemd-sysext) staging dirs merge onto /usr and /opt,
  # and systemd configuration extension (systemd-confext) staging dirs merge onto /etc.
  # The staged trees are overlaid onto the host tree with overlayfs, so they must carry
-
--- 
-2.43.0
diff --git a/recipes-security/refpolicy/refpolicy/0027-policy-modules-system-logging-add-rules-for-the-syml.patch b/recipes-security/refpolicy/refpolicy/0027-policy-modules-system-logging-add-rules-for-the-syml.patch
index c2972f8..4837ee1 100644
--- a/recipes-security/refpolicy/refpolicy/0027-policy-modules-system-logging-add-rules-for-the-syml.patch
+++ b/recipes-security/refpolicy/refpolicy/0027-policy-modules-system-logging-add-rules-for-the-syml.patch
@@ -1,4 +1,4 @@
-From 318c45578888ef3d697f095869100dce81247c0d Mon Sep 17 00:00:00 2001
+From 4bb33be4fbc4dfdaf3270ef73930ac735f4ded5e Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/system/logging: add rules for the symlink of
@@ -30,7 +30,7 @@ index e2a43f305..7bedcdc00 100644
  /var/log/dmesg		--	gen_context(system_u:object_r:var_log_t,s0)
  /var/log/syslog		--	gen_context(system_u:object_r:var_log_t,s0)
 diff --git a/policy/modules/system/logging.if b/policy/modules/system/logging.if
-index 3dd2c06c2..7d108709f 100644
+index 718106ce9..d5e4d2bd4 100644
 --- a/policy/modules/system/logging.if
 +++ b/policy/modules/system/logging.if
 @@ -1091,10 +1091,12 @@ interface(`logging_append_all_inherited_logs',`
@@ -86,6 +86,3 @@ index 3dd2c06c2..7d108709f 100644
  ')
  
  ########################################
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-syslogd-.patch b/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-syslogd-.patch
index 167f2c0..b5d1451 100644
--- a/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-syslogd-.patch
+++ b/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-syslogd-.patch
@@ -1,4 +1,4 @@
-From 88aa13b30249ebcaada8075508efa603a041915b Mon Sep 17 00:00:00 2001
+From 546ad846bca275db44e46853b54188a1cfb66626 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 10:33:18 -0400
 Subject: [PATCH] policy/modules/system/logging: add rules for syslogd symlink
@@ -18,7 +18,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 314b2559b..5d1930a58 100644
+index 3cae9b02d..338e9821a 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -429,6 +429,7 @@ files_search_spool(syslogd_t)
@@ -29,6 +29,3 @@ index 314b2559b..5d1930a58 100644
  
  # for systemd but can not be conditional
  files_runtime_filetrans(syslogd_t, syslogd_tmp_t, dir, "log")
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0029-policy-modules-kernel-files-add-rules-for-the-symlin.patch b/recipes-security/refpolicy/refpolicy/0029-policy-modules-kernel-files-add-rules-for-the-symlin.patch
index 367852f..d5c0ecf 100644
--- a/recipes-security/refpolicy/refpolicy/0029-policy-modules-kernel-files-add-rules-for-the-symlin.patch
+++ b/recipes-security/refpolicy/refpolicy/0029-policy-modules-kernel-files-add-rules-for-the-symlin.patch
@@ -1,4 +1,4 @@
-From 97db230c2b1ddf0a9b725e4bee879fc5c13c86a5 Mon Sep 17 00:00:00 2001
+From 6b81457c237ddd074136515bfa1409812a3351f4 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/kernel/files: add rules for the symlink of
@@ -97,6 +97,3 @@ index 0b2e449b9..79ea2171f 100644
  ')
  
  ########################################
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0030-policy-modules-system-logging-fix-auditd-startup-fai.patch b/recipes-security/refpolicy/refpolicy/0030-policy-modules-system-logging-fix-auditd-startup-fai.patch
index da1bd03..369172e 100644
--- a/recipes-security/refpolicy/refpolicy/0030-policy-modules-system-logging-fix-auditd-startup-fai.patch
+++ b/recipes-security/refpolicy/refpolicy/0030-policy-modules-system-logging-fix-auditd-startup-fai.patch
@@ -1,4 +1,4 @@
-From 41e8dbe65aa55bb892f4e794ce822cdc2cd22339 Mon Sep 17 00:00:00 2001
+From 57bd59c5148aba28987d30ca101d30b516e9f185 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/system/logging: fix auditd startup failures
@@ -17,7 +17,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 5d1930a58..90797d54f 100644
+index 338e9821a..f451c0dec 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -120,6 +120,7 @@ allow auditctl_t auditd_log_t:file read_file_perms;
@@ -44,6 +44,3 @@ index 5d1930a58..90797d54f 100644
  allow audisp_remote_t var_log_t:dir search_dir_perms;
  
  manage_dirs_pattern(audisp_remote_t, audit_spool_t, audit_spool_t)
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0031-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch b/recipes-security/refpolicy/refpolicy/0031-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch
index 436b5f8..2a17048 100644
--- a/recipes-security/refpolicy/refpolicy/0031-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch
+++ b/recipes-security/refpolicy/refpolicy/0031-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch
@@ -1,4 +1,4 @@
-From dd08a7cc9679cda711ed3537102458d56224ef5d Mon Sep 17 00:00:00 2001
+From 1cc1a4f02fc829a3b569eeeb191139bbbc1cc67b Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/kernel/terminal: don't audit tty_device_t in
@@ -33,6 +33,3 @@ index 48310450b..fffebdb0c 100644
  ')
  
  ########################################
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0032-policy-modules-system-systemd-enable-support-for-sys.patch b/recipes-security/refpolicy/refpolicy/0032-policy-modules-system-systemd-enable-support-for-sys.patch
index 241ac31..50931cb 100644
--- a/recipes-security/refpolicy/refpolicy/0032-policy-modules-system-systemd-enable-support-for-sys.patch
+++ b/recipes-security/refpolicy/refpolicy/0032-policy-modules-system-systemd-enable-support-for-sys.patch
@@ -1,4 +1,4 @@
-From a9b04a012c6968668ae761818deb2254b0789a53 Mon Sep 17 00:00:00 2001
+From fb629b9f53a5c64911777c94fb3db9a4af4e90d4 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 4 Feb 2016 06:03:19 -0500
 Subject: [PATCH] policy/modules/system/systemd: enable support for
@@ -29,7 +29,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index e773deab1..df23d7c62 100644
+index aaf7b7baa..76f9dfec5 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
 @@ -10,7 +10,7 @@ policy_module(systemd)
@@ -41,6 +41,3 @@ index e773deab1..df23d7c62 100644
  
  ## <desc>
  ## <p>
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-systemd-systemd-user-fixes.patch b/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-systemd-systemd-user-fixes.patch
index 30f0f91..3fc83fa 100644
--- a/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-systemd-systemd-user-fixes.patch
+++ b/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-systemd-systemd-user-fixes.patch
@@ -1,4 +1,4 @@
-From 38eae959958cbf3c1a17a22e853d1765786638a4 Mon Sep 17 00:00:00 2001
+From 96b8fffea94f14a290e6c871ea3e28783f865d50 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 4 Feb 2021 10:48:54 +0800
 Subject: [PATCH] policy/modules/system/systemd: systemd --user fixes
@@ -31,10 +31,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 35 insertions(+)
 
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index 378a4ca3d..f22b8ea82 100644
+index e399a81ab..278f89e15 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
-@@ -268,6 +268,37 @@ template(`systemd_role_template',`
+@@ -282,6 +282,37 @@ template(`systemd_role_template',`
  	')
  ')
  
@@ -73,10 +73,10 @@ index 378a4ca3d..f22b8ea82 100644
  ## <summary>
  ##   Allow the specified domain to be started as a daemon by the
 diff --git a/policy/modules/system/userdomain.if b/policy/modules/system/userdomain.if
-index 6a1009d26..9c32410a5 100644
+index 9f09650f5..e967bcaff 100644
 --- a/policy/modules/system/userdomain.if
 +++ b/policy/modules/system/userdomain.if
-@@ -1489,6 +1489,10 @@ template(`userdom_admin_user_template',`
+@@ -1533,6 +1533,10 @@ template(`userdom_admin_user_template',`
  	optional_policy(`
  		userhelper_exec($1_t)
  	')
@@ -87,6 +87,3 @@ index 6a1009d26..9c32410a5 100644
  ')
  
  ########################################
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-logging-grant-getpcap-capabili.patch b/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-logging-grant-getpcap-capabili.patch
index 60a76b3..05b7599 100644
--- a/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-logging-grant-getpcap-capabili.patch
+++ b/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-logging-grant-getpcap-capabili.patch
@@ -1,4 +1,4 @@
-From 73445954288e54a76a1eaeaf0cbe43c3b56d3eaa Mon Sep 17 00:00:00 2001
+From 1abf865b6d17ba31ef426dea804197f0eecbb04d Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 28 May 2024 11:21:48 +0800
 Subject: [PATCH] policy/modules/system/logging: grant getpcap capability to
@@ -21,7 +21,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 90797d54f..cf4fdb2fe 100644
+index f451c0dec..7693581cd 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -402,6 +402,8 @@ optional_policy(`
@@ -33,6 +33,3 @@ index 90797d54f..cf4fdb2fe 100644
  dontaudit syslogd_t self:capability { sys_ptrace net_admin };
  dontaudit syslogd_t self:cap_userns { kill sys_ptrace };
  # setpgid for metalog
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-allow-services-to-read-tmpfs-u.patch b/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-allow-services-to-read-tmpfs-u.patch
index 961a337..ac3444a 100644
--- a/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-allow-services-to-read-tmpfs-u.patch
+++ b/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-allow-services-to-read-tmpfs-u.patch
@@ -1,4 +1,4 @@
-From c73aa825771f481be83b6a31e85fa8a885965671 Mon Sep 17 00:00:00 2001
+From 98ebadda5476bf2df073c393c21bc9ac416d9845 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 30 Aug 2024 12:39:48 +0800
 Subject: [PATCH] policy/modules/system: allow services to read tmpfs under
@@ -67,7 +67,7 @@ index a900226bf..75b94785b 100644
  mcs_process_set_categories(getty_t)
  
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index cf4fdb2fe..9200dcbdb 100644
+index 7693581cd..fdc880a43 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -491,6 +491,7 @@ files_read_kernel_symbol_table(syslogd_t)
@@ -79,10 +79,10 @@ index cf4fdb2fe..9200dcbdb 100644
  
  mls_file_write_all_levels(syslogd_t) # Need to be able to write to /var/run/ and /var/log directories
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index df23d7c62..b34125656 100644
+index 76f9dfec5..36c818c89 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -1478,6 +1478,7 @@ files_watch_root_dirs(systemd_networkd_t)
+@@ -1492,6 +1492,7 @@ files_watch_root_dirs(systemd_networkd_t)
  files_list_runtime(systemd_networkd_t)
  
  fs_getattr_all_fs(systemd_networkd_t)
@@ -91,10 +91,10 @@ index df23d7c62..b34125656 100644
  fs_read_nsfs_files(systemd_networkd_t)
  fs_watch_memory_pressure(systemd_networkd_t)
 diff --git a/policy/modules/system/udev.te b/policy/modules/system/udev.te
-index e245a66a4..5cc9484eb 100644
+index f62745d83..2374c147d 100644
 --- a/policy/modules/system/udev.te
 +++ b/policy/modules/system/udev.te
-@@ -144,6 +144,7 @@ files_dontaudit_getattr_tmp_dirs(udev_t)
+@@ -150,6 +150,7 @@ files_dontaudit_getattr_tmp_dirs(udev_t)
  
  fs_getattr_all_fs(udev_t)
  fs_list_inotifyfs(udev_t)
@@ -102,6 +102,3 @@ index e245a66a4..5cc9484eb 100644
  fs_read_cgroup_files(udev_t)
  fs_rw_anon_inodefs_files(udev_t)
  fs_list_tmpfs(udev_t)
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0036-policy-modules-kernel-domain-allow-all-domains-to-co.patch b/recipes-security/refpolicy/refpolicy/0036-policy-modules-kernel-domain-allow-all-domains-to-co.patch
index ce7dd82..1943a2e 100644
--- a/recipes-security/refpolicy/refpolicy/0036-policy-modules-kernel-domain-allow-all-domains-to-co.patch
+++ b/recipes-security/refpolicy/refpolicy/0036-policy-modules-kernel-domain-allow-all-domains-to-co.patch
@@ -1,4 +1,4 @@
-From 905963229d0456b9e38917f6c2fba8bb57a3e705 Mon Sep 17 00:00:00 2001
+From 2e5a52120c8d750255e225db69f00a59e8a5550f Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 3 Oct 2024 21:12:33 +0800
 Subject: [PATCH] policy/modules/kernel/domain: allow all domains to connect to
@@ -23,10 +23,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/kernel/domain.te b/policy/modules/kernel/domain.te
-index 7c7fe8f32..241084c4b 100644
+index 20ce796b7..d84be4dab 100644
 --- a/policy/modules/kernel/domain.te
 +++ b/policy/modules/kernel/domain.te
-@@ -134,6 +134,7 @@ files_list_root(domain)
+@@ -135,6 +135,7 @@ files_list_root(domain)
  ifdef(`init_systemd',`
  	optional_policy(`
  		shutdown_sigchld(domain)
@@ -34,6 +34,3 @@ index 7c7fe8f32..241084c4b 100644
  	')
  ')
  
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0037-systemd-allow-systemd-logind-to-inherit-fds.patch b/recipes-security/refpolicy/refpolicy/0037-systemd-allow-systemd-logind-to-inherit-fds.patch
index 45a419f..6fe5fd9 100644
--- a/recipes-security/refpolicy/refpolicy/0037-systemd-allow-systemd-logind-to-inherit-fds.patch
+++ b/recipes-security/refpolicy/refpolicy/0037-systemd-allow-systemd-logind-to-inherit-fds.patch
@@ -1,4 +1,4 @@
-From e25f4ac72ae24ac301a334bf9bad4c2992664ee3 Mon Sep 17 00:00:00 2001
+From 43b89d6969a85004629962e4f5d21bae64707230 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 18 Feb 2025 09:54:06 +0800
 Subject: [PATCH] systemd: allow systemd-logind to inherit fds
@@ -20,7 +20,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 22 insertions(+)
 
 diff --git a/policy/modules/admin/su.if b/policy/modules/admin/su.if
-index 4566b522b..b6c7ca0a5 100644
+index 8f16790e0..ce7754102 100644
 --- a/policy/modules/admin/su.if
 +++ b/policy/modules/admin/su.if
 @@ -232,6 +232,10 @@ template(`su_role_template',`
@@ -35,10 +35,10 @@ index 4566b522b..b6c7ca0a5 100644
  		allow $3 $1_su_t:process signal;
  
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index f22b8ea82..cc2709551 100644
+index 278f89e15..1f0e4cdb7 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
-@@ -1582,6 +1582,24 @@ interface(`systemd_use_logind_fds',`
+@@ -1660,6 +1660,24 @@ interface(`systemd_use_logind_fds',`
  	allow $1 systemd_logind_t:fd use;
  ')
  
@@ -63,6 +63,3 @@ index f22b8ea82..cc2709551 100644
  ######################################
  ## <summary>
  ##      Watch logind sessions dirs.
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0038-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch b/recipes-security/refpolicy/refpolicy/0038-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
index b36cc5c..3e45e9b 100644
--- a/recipes-security/refpolicy/refpolicy/0038-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
+++ b/recipes-security/refpolicy/refpolicy/0038-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
@@ -1,4 +1,4 @@
-From 634dc2988ce5eaff7d1cd27cd5c9eeb32183e637 Mon Sep 17 00:00:00 2001
+From d8fc6cb3eb08eafa403e056ad6fd8efb33f1ee6a Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 18 Feb 2025 15:26:19 +0800
 Subject: [PATCH] systemd: allow systemd-tmpfiles to read bin_t symlink
@@ -23,10 +23,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  4 files changed, 23 insertions(+)
 
 diff --git a/policy/modules/kernel/corecommands.fc b/policy/modules/kernel/corecommands.fc
-index 851529abd..1480e1104 100644
+index 110e7471d..abb1c63db 100644
 --- a/policy/modules/kernel/corecommands.fc
 +++ b/policy/modules/kernel/corecommands.fc
-@@ -251,6 +251,7 @@ ifdef(`distro_gentoo',`
+@@ -256,6 +256,7 @@ ifdef(`distro_gentoo',`
  /usr/lib/sftp-server		--	gen_context(system_u:object_r:bin_t,s0)
  /usr/lib/ssh(/.*)?			gen_context(system_u:object_r:bin_t,s0)
  /usr/lib/sudo/sesh		--	gen_context(system_u:object_r:shell_exec_t,s0)
@@ -61,10 +61,10 @@ index 08ed91f19..0fa4cbf7d 100644
 +	read_lnk_files_pattern($1, bin_t, bin_t)
 +')
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index cc2709551..b67b78a69 100644
+index 1f0e4cdb7..3231f5c82 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
-@@ -156,6 +156,7 @@ template(`systemd_role_template',`
+@@ -160,6 +160,7 @@ template(`systemd_role_template',`
  
  	# user systemd-tmpfiles rules
  	allow $1_systemd_tmpfiles_t self:process setfscreate;
@@ -73,10 +73,10 @@ index cc2709551..b67b78a69 100644
  	domtrans_pattern($1_systemd_t, systemd_tmpfiles_exec_t, $1_systemd_tmpfiles_t)
  	read_files_pattern($1_systemd_t, $1_systemd_tmpfiles_t, $1_systemd_tmpfiles_t)
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index b34125656..c1c873fa5 100644
+index 36c818c89..4fc898752 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -2169,6 +2169,9 @@ kernel_getattr_proc(systemd_tmpfiles_t)
+@@ -2193,6 +2193,9 @@ kernel_getattr_proc(systemd_tmpfiles_t)
  kernel_read_kernel_sysctls(systemd_tmpfiles_t)
  kernel_read_network_state(systemd_tmpfiles_t)
  
@@ -86,6 +86,3 @@ index b34125656..c1c873fa5 100644
  dev_getattr_fs(systemd_tmpfiles_t)
  dev_manage_all_dev_nodes(systemd_tmpfiles_t)
  dev_read_urand(systemd_tmpfiles_t)
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0039-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch b/recipes-security/refpolicy/refpolicy/0039-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch
index 57b4296..1bd7d7e 100644
--- a/recipes-security/refpolicy/refpolicy/0039-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch
+++ b/recipes-security/refpolicy/refpolicy/0039-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch
@@ -1,4 +1,4 @@
-From eeb5333253ad0fd19cf065b79c76012d88acfd61 Mon Sep 17 00:00:00 2001
+From c798867cd66fb9994f7e5888e470d976ea3a3c45 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 26 Sep 2025 15:15:44 +0800
 Subject: [PATCH] systemd: fix for systemd-networkd and systemd-rfkill
@@ -35,10 +35,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 5 insertions(+), 1 deletion(-)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index c1c873fa5..4a790c5dc 100644
+index 4fc898752..f31862c1b 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -1427,7 +1427,7 @@ systemd_log_parse_environment(systemd_modules_load_t)
+@@ -1441,7 +1441,7 @@ systemd_log_parse_environment(systemd_modules_load_t)
  # networkd local policy
  #
  
@@ -47,7 +47,7 @@ index c1c873fa5..4a790c5dc 100644
  allow systemd_networkd_t self:netlink_generic_socket create_socket_perms;
  allow systemd_networkd_t self:netlink_kobject_uevent_socket create_socket_perms;
  allow systemd_networkd_t self:netlink_netfilter_socket create_socket_perms;
-@@ -1470,12 +1470,15 @@ corenet_udp_bind_generic_node(systemd_networkd_t)
+@@ -1484,12 +1484,15 @@ corenet_udp_bind_generic_node(systemd_networkd_t)
  dev_read_urand(systemd_networkd_t)
  dev_read_sysfs(systemd_networkd_t)
  dev_write_kmsg(systemd_networkd_t)
@@ -63,7 +63,7 @@ index c1c873fa5..4a790c5dc 100644
  
  fs_getattr_all_fs(systemd_networkd_t)
  fs_list_tmpfs(systemd_networkd_t)
-@@ -1914,6 +1917,7 @@ logging_send_syslog_msg(systemd_pstore_t)
+@@ -1930,6 +1933,7 @@ logging_send_syslog_msg(systemd_pstore_t)
  # Rfkill local policy
  #
  
@@ -71,6 +71,3 @@ index c1c873fa5..4a790c5dc 100644
  allow systemd_rfkill_t self:netlink_kobject_uevent_socket create_socket_perms;
  
  manage_dirs_pattern(systemd_rfkill_t, systemd_rfkill_var_lib_t, systemd_rfkill_var_lib_t)
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0040-systemd-allow-domain-used-for-login-program-to-conne.patch b/recipes-security/refpolicy/refpolicy/0040-systemd-allow-domain-used-for-login-program-to-conne.patch
index 46d3046..e4f0c08 100644
--- a/recipes-security/refpolicy/refpolicy/0040-systemd-allow-domain-used-for-login-program-to-conne.patch
+++ b/recipes-security/refpolicy/refpolicy/0040-systemd-allow-domain-used-for-login-program-to-conne.patch
@@ -1,7 +1,8 @@
-From f94cd726509a88f8efd72b175fe3079544e9ef26 Mon Sep 17 00:00:00 2001
+From 03f2558a168c4ff3fa879774d7cb416bcc991225 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 6 Feb 2026 22:13:03 +0800
 Subject: [PATCH] systemd: allow domain used for login program to connect to
+
  systemd-logind over unix socket
 
 Fix the following AVC denials:
@@ -25,10 +26,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  3 files changed, 22 insertions(+)
 
 diff --git a/policy/modules/system/authlogin.if b/policy/modules/system/authlogin.if
-index 82d3f6684..db1fcc344 100644
+index 5add629ac..6518f230e 100644
 --- a/policy/modules/system/authlogin.if
 +++ b/policy/modules/system/authlogin.if
-@@ -230,6 +230,7 @@ interface(`auth_login_pgm_domain',`
+@@ -233,6 +233,7 @@ interface(`auth_login_pgm_domain',`
  		systemd_read_logind_state($1)
  		systemd_write_inherited_logind_sessions_pipes($1)
  		systemd_use_passwd_agent_fds($1)
@@ -37,7 +38,7 @@ index 82d3f6684..db1fcc344 100644
  ')
  
 diff --git a/policy/modules/system/systemd.fc b/policy/modules/system/systemd.fc
-index 505a054ff..e44d82a88 100644
+index dacf27a49..6622a1c74 100644
 --- a/policy/modules/system/systemd.fc
 +++ b/policy/modules/system/systemd.fc
 @@ -127,6 +127,7 @@ HOME_ROOT/.+\.home	--	gen_context(system_u:object_r:systemd_homed_storage_t,s0)
@@ -46,13 +47,13 @@ index 505a054ff..e44d82a88 100644
  /run/systemd/io\.systemd\.NamespaceResource	-s	gen_context(system_u:object_r:systemd_nsresourced_runtime_t,s0)
 +/run/systemd/io\.systemd\.Login	-s	gen_context(system_u:object_r:systemd_logind_runtime_t,s0)
  
- /run/tmpfiles\.d	-d	gen_context(system_u:object_r:systemd_tmpfiles_conf_t,s0)
- /run/tmpfiles\.d/.*		<<none>>
+ /run/sysctl\.d(/.*)?	gen_context(system_u:object_r:systemd_sysctl_runtime_t,s0)
+ 
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index b67b78a69..cc57a29f4 100644
+index 3231f5c82..777376536 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
-@@ -1601,6 +1601,26 @@ interface(`systemd_inherit_logind_fds',`
+@@ -1679,6 +1679,26 @@ interface(`systemd_inherit_logind_fds',`
  	allow systemd_logind_t $1:fd use;
  ')
  
@@ -79,6 +80,3 @@ index b67b78a69..cc57a29f4 100644
  ######################################
  ## <summary>
  ##      Watch logind sessions dirs.
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0041-systemd-add-rules-for-systemd-ssh-issue.patch b/recipes-security/refpolicy/refpolicy/0041-systemd-add-rules-for-systemd-ssh-issue.patch
index 875896b..d3941c2 100644
--- a/recipes-security/refpolicy/refpolicy/0041-systemd-add-rules-for-systemd-ssh-issue.patch
+++ b/recipes-security/refpolicy/refpolicy/0041-systemd-add-rules-for-systemd-ssh-issue.patch
@@ -1,4 +1,4 @@
-From 37f557b73474ed2f746c8bb6c2cd5c5d7de3a7d5 Mon Sep 17 00:00:00 2001
+From 53f8aaaaf41eb79be05b1dd18c1dff48f5b77a38 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Mon, 9 Feb 2026 15:42:19 +0800
 Subject: [PATCH] systemd: add rules for systemd-ssh-issue
@@ -49,7 +49,7 @@ index 75b94785b..48a29461a 100644
  	# Gentoo default /etc/issue makes agetty
  	# do a DNS lookup for the hostname
 diff --git a/policy/modules/system/systemd.fc b/policy/modules/system/systemd.fc
-index e44d82a88..130c62370 100644
+index 6622a1c74..bfaa1c4c9 100644
 --- a/policy/modules/system/systemd.fc
 +++ b/policy/modules/system/systemd.fc
 @@ -49,6 +49,7 @@
@@ -70,10 +70,10 @@ index e44d82a88..130c62370 100644
  /run/nologin	--	gen_context(system_u:object_r:systemd_sessions_runtime_t,s0)
  
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index cc57a29f4..3a513a17e 100644
+index 777376536..34e8cdc57 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
-@@ -3212,3 +3212,22 @@ interface(`systemd_use_inherited_machined_ptys', `
+@@ -3310,3 +3310,22 @@ interface(`systemd_use_inherited_machined_ptys', `
  	allow $1 systemd_machined_t:fd use;
  	allow $1 systemd_machined_devpts_t:chr_file rw_inherited_term_perms;
  ')
@@ -97,7 +97,7 @@ index cc57a29f4..3a513a17e 100644
 +	read_files_pattern($1, systemd_ssh_issue_runtime_t, systemd_ssh_issue_runtime_t)
 +')
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index 4a790c5dc..c7dc5570c 100644
+index f31862c1b..3b3be2be6 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
 @@ -309,6 +309,14 @@ corenet_port(systemd_socket_proxyd_port_t)
@@ -115,7 +115,7 @@ index 4a790c5dc..c7dc5570c 100644
  type systemd_sysctl_t;
  type systemd_sysctl_exec_t;
  init_daemon_domain(systemd_sysctl_t, systemd_sysctl_exec_t)
-@@ -2090,6 +2098,33 @@ fs_getattr_nsfs_files(systemd_sysctl_t)
+@@ -2114,6 +2122,33 @@ miscfiles_read_localization(systemd_sysctl_t)
  
  systemd_log_parse_environment(systemd_sysctl_t)
  
@@ -149,6 +149,3 @@ index 4a790c5dc..c7dc5570c 100644
  #########################################
  #
  # Sysusers local policy
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0042-policy-modules-system-mount-make-mount_t-domain-MLS-.patch b/recipes-security/refpolicy/refpolicy/0042-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
index a659716..28634e8 100644
--- a/recipes-security/refpolicy/refpolicy/0042-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
+++ b/recipes-security/refpolicy/refpolicy/0042-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
@@ -1,4 +1,4 @@
-From 4f1a73b96f69d58c077396f7579eba99992a1c15 Mon Sep 17 00:00:00 2001
+From e101b81c3cee551ed287e76072e4b8c0dec0c86d Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Sat, 15 Feb 2014 04:22:47 -0500
 Subject: [PATCH] policy/modules/system/mount: make mount_t domain MLS trusted
@@ -30,6 +30,3 @@ index 687c532e1..319ddd2bb 100644
  
  selinux_get_enforce_mode(mount_t)
  
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0043-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch b/recipes-security/refpolicy/refpolicy/0043-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
index c2c2352..d60df92 100644
--- a/recipes-security/refpolicy/refpolicy/0043-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
+++ b/recipes-security/refpolicy/refpolicy/0043-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
@@ -1,4 +1,4 @@
-From 296b3dfb91f6d0c8943541c12e0c07a41d39f73c Mon Sep 17 00:00:00 2001
+From bc45c909d968444213865ac03863c9dd0d264471 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Mon, 28 Jan 2019 14:05:18 +0800
 Subject: [PATCH] policy/modules/roles/sysadm: MLS - sysadm rw to clearance
@@ -23,7 +23,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/roles/sysadm.te b/policy/modules/roles/sysadm.te
-index 3a8242568..d783d4582 100644
+index d93e88b26..edb01ddae 100644
 --- a/policy/modules/roles/sysadm.te
 +++ b/policy/modules/roles/sysadm.te
 @@ -57,6 +57,8 @@ logging_watch_all_logs(sysadm_t)
@@ -35,6 +35,3 @@ index 3a8242568..d783d4582 100644
  
  selinux_read_policy(sysadm_t)
  
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0044-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch b/recipes-security/refpolicy/refpolicy/0044-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
index 806499d..5e72249 100644
--- a/recipes-security/refpolicy/refpolicy/0044-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
+++ b/recipes-security/refpolicy/refpolicy/0044-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
@@ -1,4 +1,4 @@
-From d017af66a1eded70679188844c227ce239b0d794 Mon Sep 17 00:00:00 2001
+From 186f9fb2ac9aacc1e266e61390ddf66c8bd983f7 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Fri, 23 Aug 2013 12:01:53 +0800
 Subject: [PATCH] policy/modules/services/rpc: make nfsd_t domain MLS trusted
@@ -15,10 +15,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 7 insertions(+)
 
 diff --git a/policy/modules/kernel/kernel.te b/policy/modules/kernel/kernel.te
-index cb82f6635..75aa94bc6 100644
+index f150103ad..31ea5b040 100644
 --- a/policy/modules/kernel/kernel.te
 +++ b/policy/modules/kernel/kernel.te
-@@ -392,6 +392,8 @@ mls_process_read_all_levels(kernel_t)
+@@ -413,6 +413,8 @@ mls_process_read_all_levels(kernel_t)
  mls_process_write_all_levels(kernel_t)
  mls_file_write_all_levels(kernel_t)
  mls_file_read_all_levels(kernel_t)
@@ -28,10 +28,10 @@ index cb82f6635..75aa94bc6 100644
  ifdef(`distro_redhat',`
  	# Bugzilla 222337
 diff --git a/policy/modules/services/rpcbind.te b/policy/modules/services/rpcbind.te
-index a0bedbe69..fdd93a469 100644
+index 3eb875743..24d159f01 100644
 --- a/policy/modules/services/rpcbind.te
 +++ b/policy/modules/services/rpcbind.te
-@@ -75,6 +75,11 @@ logging_send_syslog_msg(rpcbind_t)
+@@ -78,6 +78,11 @@ logging_send_syslog_msg(rpcbind_t)
  
  miscfiles_read_localization(rpcbind_t)
  
@@ -43,6 +43,3 @@ index a0bedbe69..fdd93a469 100644
  ifdef(`distro_debian',`
  	term_dontaudit_use_unallocated_ttys(rpcbind_t)
  ')
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0045-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch b/recipes-security/refpolicy/refpolicy/0045-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
index dadd446..c7049b8 100644
--- a/recipes-security/refpolicy/refpolicy/0045-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
+++ b/recipes-security/refpolicy/refpolicy/0045-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
@@ -1,4 +1,4 @@
-From 836b210ce616aed73769bff2c8b2a5904de900fe Mon Sep 17 00:00:00 2001
+From 419559f02ce386c974888bec5ac46ddb686b5604 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 30 Jun 2020 10:18:20 +0800
 Subject: [PATCH] policy/modules/admin/dmesg: make dmesg_t MLS trusted reading
@@ -31,6 +31,3 @@ index 2b98b0e7f..9432cc78a 100644
  optional_policy(`
  	seutil_sigchld_newrole(dmesg_t)
  ')
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0046-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch b/recipes-security/refpolicy/refpolicy/0046-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
index 0c7490e..4ec74b8 100644
--- a/recipes-security/refpolicy/refpolicy/0046-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
+++ b/recipes-security/refpolicy/refpolicy/0046-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
@@ -1,4 +1,4 @@
-From 51446ea7377a19f2353c03cf0ad98261f8348c45 Mon Sep 17 00:00:00 2001
+From 23f3640ca8598453d32945b420aa0040964de965 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Fri, 13 Oct 2017 07:20:40 +0000
 Subject: [PATCH] policy/modules/kernel/kernel: make kernel_t MLS trusted for
@@ -59,10 +59,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/kernel/kernel.te b/policy/modules/kernel/kernel.te
-index 75aa94bc6..329103506 100644
+index 31ea5b040..7afea5a10 100644
 --- a/policy/modules/kernel/kernel.te
 +++ b/policy/modules/kernel/kernel.te
-@@ -394,6 +394,8 @@ mls_file_write_all_levels(kernel_t)
+@@ -415,6 +415,8 @@ mls_file_write_all_levels(kernel_t)
  mls_file_read_all_levels(kernel_t)
  mls_socket_write_all_levels(kernel_t)
  mls_fd_use_all_levels(kernel_t)
@@ -71,6 +71,3 @@ index 75aa94bc6..329103506 100644
  
  ifdef(`distro_redhat',`
  	# Bugzilla 222337
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0047-policy-modules-system-init-make-init_t-MLS-trusted-f.patch b/recipes-security/refpolicy/refpolicy/0047-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
index 3b71066..5b565ea 100644
--- a/recipes-security/refpolicy/refpolicy/0047-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
+++ b/recipes-security/refpolicy/refpolicy/0047-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
@@ -1,4 +1,4 @@
-From b2e14817293ee3b353e5a333e84c8e7aa82ab280 Mon Sep 17 00:00:00 2001
+From 786f4c752369f2683badc81c9c9d8f59027cac83 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Fri, 15 Jan 2016 03:47:05 -0500
 Subject: [PATCH] policy/modules/system/init: make init_t MLS trusted for
@@ -27,10 +27,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 4 insertions(+)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index 388c9b28c..25b74378a 100644
+index 94df50d40..a71699800 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
-@@ -256,6 +256,10 @@ mls_process_write_all_levels(init_t)
+@@ -260,6 +260,10 @@ mls_process_write_all_levels(init_t)
  mls_fd_use_all_levels(init_t)
  mls_process_set_level(init_t)
  
@@ -41,6 +41,3 @@ index 388c9b28c..25b74378a 100644
  # the following one is needed for libselinux:is_selinux_enabled()
  # otherwise the call fails and sysvinit tries to load the policy
  # again when using the initramfs
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-make-systemd-tmpfiles_.patch b/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
index 57cc208..ae5de93 100644
--- a/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
+++ b/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
@@ -1,4 +1,4 @@
-From 4de0cdb34e58244bf7594c567c170c8923f4b907 Mon Sep 17 00:00:00 2001
+From ed2ff14cdabaed88df624bff746a937f7f9671d0 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 4 Feb 2016 06:03:19 -0500
 Subject: [PATCH] policy/modules/system/systemd: make systemd-tmpfiles_t domain
@@ -43,10 +43,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 5 insertions(+)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index c7dc5570c..7ead872e9 100644
+index 3b3be2be6..ba0e1bed7 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -2313,6 +2313,11 @@ sysnet_relabel_config(systemd_tmpfiles_t)
+@@ -2338,6 +2338,11 @@ sysnet_relabel_config(systemd_tmpfiles_t)
  
  systemd_log_parse_environment(systemd_tmpfiles_t)
  
@@ -58,6 +58,3 @@ index c7dc5570c..7ead872e9 100644
  userdom_manage_user_runtime_root_dirs(systemd_tmpfiles_t)
  userdom_relabel_user_runtime_root_dirs(systemd_tmpfiles_t)
  
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-systemd-systemd-make-systemd_-.patch b/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-systemd-systemd-make-systemd_-.patch
index 2cb9fc5..f8259d9 100644
--- a/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-systemd-systemd-make-systemd_-.patch
+++ b/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-systemd-systemd-make-systemd_-.patch
@@ -1,4 +1,4 @@
-From 1ee01571a182d70db76fce86ddd447de4dfd3c32 Mon Sep 17 00:00:00 2001
+From 50ae17a013d4516737750d1d444cee997020d0e1 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 18 Jun 2020 09:59:58 +0800
 Subject: [PATCH] policy/modules/system/systemd: systemd-*: make systemd_*_t
@@ -43,10 +43,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 12 insertions(+)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index 7ead872e9..26f06e482 100644
+index ba0e1bed7..0c599b1cd 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -476,6 +476,9 @@ optional_policy(`
+@@ -479,6 +479,9 @@ optional_policy(`
  	unconfined_dbus_send(systemd_backlight_t)
  ')
  
@@ -56,7 +56,7 @@ index 7ead872e9..26f06e482 100644
  #######################################
  #
  # Binfmt local policy
-@@ -690,6 +693,9 @@ udev_read_runtime_files(systemd_generator_t)
+@@ -698,6 +701,9 @@ udev_read_runtime_files(systemd_generator_t)
  # for systemd-getty-generator
  userdom_use_user_ttys(systemd_generator_t)
  
@@ -66,7 +66,7 @@ index 7ead872e9..26f06e482 100644
  ifdef(`distro_gentoo',`
  	corecmd_shell_entry_type(systemd_generator_t)
  ')
-@@ -1212,6 +1218,9 @@ userdom_relabelto_user_runtime_dirs(systemd_logind_t)
+@@ -1220,6 +1226,9 @@ userdom_relabelto_user_runtime_dirs(systemd_logind_t)
  userdom_setattr_user_ttys(systemd_logind_t)
  userdom_use_user_terminals(systemd_logind_t)
  
@@ -76,7 +76,7 @@ index 7ead872e9..26f06e482 100644
  # Needed to work around patch not yet merged into the systemd-logind supported on RHEL 7.x
  # The change in systemd by Nicolas Iooss on 02-Feb-2016 with hash 4b51966cf6c06250036e428608da92f8640beb96
  # should fix the problem where user directories in /run/user/$UID/ are not getting the proper context
-@@ -1949,6 +1958,9 @@ udev_read_runtime_files(systemd_rfkill_t)
+@@ -1965,6 +1974,9 @@ udev_read_runtime_files(systemd_rfkill_t)
  
  systemd_log_parse_environment(systemd_rfkill_t)
  
@@ -86,6 +86,3 @@ index 7ead872e9..26f06e482 100644
  #########################################
  #
  # Resolved local policy
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-logging-add-the-syslogd_t-to-t.patch b/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
index 8027c14..e9cb230 100644
--- a/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
+++ b/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
@@ -1,4 +1,4 @@
-From 48ce274e3d696199ea98d8b2e389e3824cf08071 Mon Sep 17 00:00:00 2001
+From 05ab3fd791005bfac6f466158f1d08ef1334038f Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/system/logging: add the syslogd_t to trusted
@@ -18,7 +18,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 9200dcbdb..255b831f8 100644
+index fdc880a43..c0b71c4ba 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -495,6 +495,9 @@ fs_list_tmpfs(syslogd_t)
@@ -31,6 +31,3 @@ index 9200dcbdb..255b831f8 100644
  
  term_write_console(syslogd_t)
  # Allow syslog to a terminal
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-make-init_t-MLS-trusted-f.patch b/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
index daef8c7..9d1506e 100644
--- a/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
+++ b/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
@@ -1,4 +1,4 @@
-From da5692ab6d8641e047575ea65273ed5113c87ce2 Mon Sep 17 00:00:00 2001
+From 633b99f1a0e3c81c10b31478662520e09eb39399 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 28 May 2019 16:41:37 +0800
 Subject: [PATCH] policy/modules/system/init: make init_t MLS trusted for
@@ -17,10 +17,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index 25b74378a..242ceb78c 100644
+index a71699800..84651d57d 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
-@@ -255,6 +255,7 @@ mls_file_write_all_levels(init_t)
+@@ -259,6 +259,7 @@ mls_file_write_all_levels(init_t)
  mls_process_write_all_levels(init_t)
  mls_fd_use_all_levels(init_t)
  mls_process_set_level(init_t)
@@ -28,6 +28,3 @@ index 25b74378a..242ceb78c 100644
  
  # MLS trusted for lowering/raising the level of files
  mls_file_downgrade(init_t)
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-init-all-init_t-to-read-any-le.patch b/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-init-all-init_t-to-read-any-le.patch
index 161c584..b3f25b3 100644
--- a/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-init-all-init_t-to-read-any-le.patch
+++ b/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-init-all-init_t-to-read-any-le.patch
@@ -1,4 +1,4 @@
-From 1609f49b78df89b699a26406e795e439dbc33ece Mon Sep 17 00:00:00 2001
+From 060bc09c8312c133863406e626c6513da1b7c85d Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Wed, 3 Feb 2016 04:16:06 -0500
 Subject: [PATCH] policy/modules/system/init: all init_t to read any level
@@ -22,10 +22,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index 242ceb78c..8188f8aec 100644
+index 84651d57d..309d277d0 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
-@@ -261,6 +261,9 @@ mls_key_write_all_levels(init_t)
+@@ -265,6 +265,9 @@ mls_key_write_all_levels(init_t)
  mls_file_downgrade(init_t)
  mls_file_upgrade(init_t)
  
@@ -35,6 +35,3 @@ index 242ceb78c..8188f8aec 100644
  # the following one is needed for libselinux:is_selinux_enabled()
  # otherwise the call fails and sysvinit tries to load the policy
  # again when using the initramfs
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0053-policy-modules-system-logging-allow-auditd_t-to-writ.patch b/recipes-security/refpolicy/refpolicy/0053-policy-modules-system-logging-allow-auditd_t-to-writ.patch
index 944d3ae..267b6c4 100644
--- a/recipes-security/refpolicy/refpolicy/0053-policy-modules-system-logging-allow-auditd_t-to-writ.patch
+++ b/recipes-security/refpolicy/refpolicy/0053-policy-modules-system-logging-allow-auditd_t-to-writ.patch
@@ -1,4 +1,4 @@
-From f36eaaf7a0da3f7aec39bac3a1953742a8364155 Mon Sep 17 00:00:00 2001
+From f8e022825bf01bfbfce96ad82fd9be134b8b1892 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 25 Feb 2016 04:25:08 -0500
 Subject: [PATCH] policy/modules/system/logging: allow auditd_t to write socket
@@ -22,7 +22,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 255b831f8..1ee634f76 100644
+index c0b71c4ba..98f97df99 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -236,6 +236,8 @@ miscfiles_read_localization(auditd_t)
@@ -34,6 +34,3 @@ index 255b831f8..1ee634f76 100644
  
  seutil_dontaudit_read_config(auditd_t)
  
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0054-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch b/recipes-security/refpolicy/refpolicy/0054-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
index deceb3d..df91abc 100644
--- a/recipes-security/refpolicy/refpolicy/0054-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
+++ b/recipes-security/refpolicy/refpolicy/0054-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
@@ -1,4 +1,4 @@
-From b09860b6c092539deb05b7d4f0eff1d7505ab289 Mon Sep 17 00:00:00 2001
+From b24c09364f5af2c39e2f7d517004ec92450f483f Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 31 Oct 2019 17:35:59 +0800
 Subject: [PATCH] policy/modules/kernel/kernel: make kernel_t MLS trusted for
@@ -15,10 +15,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/kernel/kernel.te b/policy/modules/kernel/kernel.te
-index 329103506..287b0098f 100644
+index 7afea5a10..3756a0135 100644
 --- a/policy/modules/kernel/kernel.te
 +++ b/policy/modules/kernel/kernel.te
-@@ -396,6 +396,7 @@ mls_socket_write_all_levels(kernel_t)
+@@ -417,6 +417,7 @@ mls_socket_write_all_levels(kernel_t)
  mls_fd_use_all_levels(kernel_t)
  # https://bugzilla.redhat.com/show_bug.cgi?id=667370
  mls_file_downgrade(kernel_t)
@@ -26,6 +26,3 @@ index 329103506..287b0098f 100644
  
  ifdef(`distro_redhat',`
  	# Bugzilla 222337
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-setrans-allow-setrans_t-use-fd.patch b/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
index 69025fd..619ffc5 100644
--- a/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
+++ b/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
@@ -1,4 +1,4 @@
-From 9ee2c564ec3b5e2663356ac78b9b8709d557f4cb Mon Sep 17 00:00:00 2001
+From 773a0783685f57c67edc970594cd80572ce619b3 Mon Sep 17 00:00:00 2001
 From: Roy Li <rongqing.li@windriver.com>
 Date: Sat, 22 Feb 2014 13:35:38 +0800
 Subject: [PATCH] policy/modules/system/setrans: allow setrans_t use fd at any
@@ -25,6 +25,3 @@ index 0a87a8d70..738badc52 100644
  
  selinux_compute_access_vector(setrans_t)
  
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch b/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
index 9a3d5bf..73f26e6 100644
--- a/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
+++ b/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
@@ -1,4 +1,4 @@
-From 61869545d8823fbfcbed0bab49838cdb0a5b2a95 Mon Sep 17 00:00:00 2001
+From f73df947af7dd0663abb17acb0039299a54b4c88 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Mon, 22 Feb 2021 11:28:12 +0800
 Subject: [PATCH] policy/modules/system/systemd: make *_systemd_t MLS trusted
@@ -24,10 +24,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index 3a513a17e..4e3ec2bb0 100644
+index 34e8cdc57..704b14970 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
-@@ -267,6 +267,9 @@ template(`systemd_role_template',`
+@@ -281,6 +281,9 @@ template(`systemd_role_template',`
  		xserver_read_xdm_state($1_systemd_t)
  		xserver_use_user_fonts($1_systemd_t)
  	')
@@ -37,6 +37,3 @@ index 3a513a17e..4e3ec2bb0 100644
  ')
  
  ######################################
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-logging-make-syslogd_runtime_t.patch b/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-logging-make-syslogd_runtime_t.patch
index 2953fa1..8533431 100644
--- a/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-logging-make-syslogd_runtime_t.patch
+++ b/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-logging-make-syslogd_runtime_t.patch
@@ -1,4 +1,4 @@
-From b507082584e70abfcf6446e38da92b848f6ae586 Mon Sep 17 00:00:00 2001
+From fa14ec9b06a71d62569d27d2a09bab99ac675179 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Sat, 18 Dec 2021 17:31:45 +0800
 Subject: [PATCH] policy/modules/system/logging: make syslogd_runtime_t MLS
@@ -31,7 +31,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 1ee634f76..75c97645a 100644
+index 98f97df99..c14d4d408 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -459,6 +459,8 @@ allow syslogd_t syslogd_runtime_t:file map;
@@ -43,6 +43,3 @@ index 1ee634f76..75c97645a 100644
  kernel_read_system_state(syslogd_t)
  kernel_read_network_state(syslogd_t)
  kernel_read_kernel_sysctls(syslogd_t)
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
index 67a727b..31c08e7 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -2,7 +2,7 @@ PV = "2.20260922+git"
 
 SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
 
-SRCREV_refpolicy = "8f247dafb92bd12cbfb53a11ff58be17a88df86a"
+SRCREV_refpolicy = "720c02a1bc565fe5a6e3bdb299385167f582eac0"
 
 UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
 
-- 
2.43.0

