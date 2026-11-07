Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4866.1794034330296371379
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Nov 2026 22:52:11 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wDHStwhyu5q_UYEAA--.20601S3;
	Sat, 07 Nov 2026 14:50:10 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowABn+WnMye5q+ZouAA--.56892S2;
	Sat, 07 Nov 2026 14:48:45 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [meta-selinux][PATCH] refpolicy: upgrade to 20260922+git
Date: Sat,  7 Nov 2026 14:52:00 +0800
Message-ID: <20261107065200.2706875-1-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowABn+WnMye5q+ZouAA--.56892S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYECmrt2VQGpwAAsi
X-CM-DELIVERINFO: =?B?fA15iKc9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoODkXvEA96EkWVMgXpQVgXWaQwygsxppJ0Xq/s6sxxykJnnMvm1+UnqCX4WF/KRygRnwf
	laGNOFoacEafHJW86NL7sENV42QVu/GzZYc66+zfkwZxdZBEX55b9rOxn/Rgzw==
X-Coremail-Antispam: 1Uk129KBj9fXoW3CrW3tr47GFyfJr4fKr1rGrX_yoW8XrW7Wo
	W09a13ua1xCry7u3W2yanFgFyUuwsxWa4kJrZYk3WxCryFgFyYyrsrW3WUJ3yruF98ZFW5
	Aw1kJFnxu3s7J3Z3l-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn5kqx4xG64xvF2IEw4CE5I8CrVC2j2Wlc2xSY4AK67AK6r47Yxn0WfAS
	r-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI
	8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJ
	M28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwAKzVCY07xG64k0F24lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
	UjIFyTuYvjxUcIJmUUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 07 Nov 2026 06:52:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5252
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

Upstream changes since 20260616 (452 commits):

* New modules: adb, docportal, matrixbot, pipewire, rauc, tqftpserv and
  wireplumber
* Remove 24 modules for software that no longer exists, among them
  portmap, rshd, rlogin, remotelogin, telnet, i18n_input, prelink,
  tzdata, usbmodules, rssh, hddtemp, likewise, qpid, slpd, xfs and
  zarafa
* file_contexts.subs_dist: alias the systemd-sysext and confext staging
  directories (/etc/extensions, /run/extensions, /var/lib/extensions,
  /run/confexts, ...) onto the paths they are merged onto
* Enable the genfs_seclabel_symlinks, ioctl_skip_cloexec and
  userspace_initial_context policy capabilities; netlink_xperm and
  netif_wildcard stay off
* Rework the shadow transitions and access, and let sysadm_t transition
  to systemd_passwd_agent_t; su gains getcap
* Add systemd_stream_connect_logind() and use it from authlogin and
  locallogin, let a user manager remove a stale notify socket, and stop
  auditing domains that probe SELinux booleans
* Various MLS fixes for systemd, init, logging and the filesystem
  interfaces
* Rewrite segenxml.py (argparse, ElementTree, --Werror, -o)
* Bug fixes

The new subs_dist aliases use the whole-path-component "*"
substitution source, which libselinux only understands from 3340da2,
after 3.11.  The libselinux in this tree parses them without error but
never matches them, so sysext/confext labelling stays as it is and
becomes active once the userspace is newer than 3.11.

Recipe changes:

* Update PV and SRCREV_refpolicy.
* Refresh 0001, 0002, 0013, 0019 and 0026, which no longer apply to the
  new sources.  The policy lines they add are unchanged: the patches
  only pick up the new hunk offsets, 0013 gains one hunk boundary, and
  the context around 0019 now shows the systemd unit files that
  replaced the /usr/kerberos paths.

Assisted-by: Codewhale:deepseek-v4-pro
Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 ...latile-alias-common-var-volatile-paths.patch | 17 ++++++++++-------
 ...sybox-set-aliases-for-bin-sbin-and-usr.patch | 17 ++++++++++-------
 ...3-fc-fstools-fix-real-path-for-fstools.patch | 15 ++++++++-------
 ...-apply-policy-to-kerberos-alternatives.patch | 14 +++++++-------
 ...subs_dist-set-aliase-for-root-director.patch | 17 ++++++++++-------
 recipes-security/refpolicy/refpolicy_git.inc    |  4 ++--
 6 files changed, 47 insertions(+), 37 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch b/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
index 112f5cc..d269f72 100644
--- a/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
+++ b/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
@@ -1,4 +1,4 @@
-From 3bed8cf8fb9f6a1651d005619a2b029a838539ea Mon Sep 17 00:00:00 2001
+From 353f0521c52ea934cc1745d53fea8cad429b3a60 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 16:14:09 -0400
 Subject: [PATCH] fc/subs/volatile: alias common /var/volatile paths
@@ -15,19 +15,22 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 6 insertions(+)
 
 diff --git a/config/file_contexts.subs_dist b/config/file_contexts.subs_dist
-index a6b747fad..d64580e89 100644
+index deeadcb80..8b9423db8 100644
 --- a/config/file_contexts.subs_dist
 +++ b/config/file_contexts.subs_dist
-@@ -34,3 +34,9 @@
- # not for refpolicy intern, but for /var/run using applications,
+@@ -35,6 +35,12 @@
  # like systemd tmpfiles or systemd socket configurations
  /var/run /run
-+
+ 
 +# volatile aliases
 +# ensure the policy applied to the base filesystem objects are reflected in the
 +# volatile hierarchy.
 +/var/volatile/log /var/log
 +/var/volatile/tmp /var/tmp
--- 
-2.34.1
++
+ # systemd system extension (systemd-sysext) staging dirs merge onto /usr and /opt,
+ # and systemd configuration extension (systemd-confext) staging dirs merge onto /etc.
+ # The staged trees are overlaid onto the host tree with overlayfs, so they must carry
 
+-- 
+2.43.0
diff --git a/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch b/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
index 2bd7953..d7e525f 100644
--- a/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
+++ b/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
@@ -1,4 +1,4 @@
-From e0221dfaf60dc6dedbf04247fabd5b13490bbabf Mon Sep 17 00:00:00 2001
+From 1cb7a914b570ca8dd51ea7b4e6a4ffadedde709d Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 20:48:10 -0400
 Subject: [PATCH] fc/subs/busybox: set aliases for bin, sbin and usr
@@ -15,19 +15,22 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 6 insertions(+)
 
 diff --git a/config/file_contexts.subs_dist b/config/file_contexts.subs_dist
-index d64580e89..8a5274283 100644
+index 8b9423db8..bae4ef439 100644
 --- a/config/file_contexts.subs_dist
 +++ b/config/file_contexts.subs_dist
-@@ -40,3 +40,9 @@
- # volatile hierarchy.
+@@ -41,6 +41,12 @@
  /var/volatile/log /var/log
  /var/volatile/tmp /var/tmp
-+
+ 
 +# busybox aliases
 +# quickly match up the busybox built-in tree to the base filesystem tree
 +/usr/lib/busybox/bin /usr/bin
 +/usr/lib/busybox/sbin /usr/bin
 +/usr/lib/busybox/usr /usr
--- 
-2.34.1
++
+ # systemd system extension (systemd-sysext) staging dirs merge onto /usr and /opt,
+ # and systemd configuration extension (systemd-confext) staging dirs merge onto /etc.
+ # The staged trees are overlaid onto the host tree with overlayfs, so they must carry
 
+-- 
+2.43.0
diff --git a/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch b/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
index 33942dd..ab254d3 100644
--- a/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
+++ b/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
@@ -1,4 +1,4 @@
-From 3ed3519c26ea0146415bf915a78bad55086abbde Mon Sep 17 00:00:00 2001
+From 4beb1c28718bce5b470ea886c2cd0a38ca7a7463 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Mon, 27 Jan 2014 03:54:01 -0500
 Subject: [PATCH] fc/fstools: fix real path for fstools
@@ -14,7 +14,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 11 insertions(+)
 
 diff --git a/policy/modules/system/fstools.fc b/policy/modules/system/fstools.fc
-index ece09e6b4..aad5a608e 100644
+index 8386937c4..02adc5400 100644
 --- a/policy/modules/system/fstools.fc
 +++ b/policy/modules/system/fstools.fc
 @@ -1,7 +1,9 @@
@@ -27,7 +27,7 @@ index ece09e6b4..aad5a608e 100644
  /usr/bin/btrfs			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/bin/cfdisk			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/bin/clubufflush		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-@@ -15,23 +17,29 @@
+@@ -15,10 +17,13 @@
  /usr/bin/e2mmpstatus		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/bin/fatsort		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/bin/fdisk			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
@@ -41,6 +41,7 @@ index ece09e6b4..aad5a608e 100644
  /usr/bin/install-mbr		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/bin/jfs_.*			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/bin/losetup.*		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+@@ -26,13 +31,16 @@
  /usr/bin/lsraid			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/bin/mkdosfs		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/bin/mke2fs			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
@@ -57,7 +58,7 @@ index ece09e6b4..aad5a608e 100644
  /usr/bin/partx			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/bin/raidautorun		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/bin/raidstart		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-@@ -43,8 +51,10 @@
+@@ -44,8 +52,10 @@
  /usr/bin/sfdisk			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/bin/smartctl		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/bin/swapoff		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
@@ -68,7 +69,7 @@ index ece09e6b4..aad5a608e 100644
  /usr/bin/zdb			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/bin/zhack			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/bin/zinject		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-@@ -53,6 +63,7 @@
+@@ -54,6 +64,7 @@
  /usr/bin/ztest			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  
  /usr/bin/fstrim		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
@@ -76,6 +77,6 @@ index ece09e6b4..aad5a608e 100644
  
  ifdef(`distro_gentoo',`
  /var/db/smartmontools(/.*)?		gen_context(system_u:object_r:fsadm_db_t,s0)
--- 
-2.34.1
 
+-- 
+2.43.0
diff --git a/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch b/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
index 8b052f3..893c839 100644
--- a/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
@@ -1,4 +1,4 @@
-From c5f2bec748a7afbb6ea6ff4fdb2e729f749d7e99 Mon Sep 17 00:00:00 2001
+From 7d14d563c9e6256274e9b31068b8ae42d2fc4a08 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:55:05 +0800
 Subject: [PATCH] fc/kerberos: apply policy to kerberos alternatives
@@ -11,7 +11,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 10 insertions(+)
 
 diff --git a/policy/modules/services/kerberos.fc b/policy/modules/services/kerberos.fc
-index 81627d2db..4966b06d4 100644
+index aae6c841d..9afe60ec4 100644
 --- a/policy/modules/services/kerberos.fc
 +++ b/policy/modules/services/kerberos.fc
 @@ -12,9 +12,13 @@ HOME_DIR/\.k5login	--	gen_context(system_u:object_r:krb5_home_t,s0)
@@ -26,9 +26,9 @@ index 81627d2db..4966b06d4 100644
 +/usr/bin/kadmin\.local	--	gen_context(system_u:object_r:kadmind_exec_t,s0)
 +/usr/bin/kpropd	--	gen_context(system_u:object_r:kpropd_exec_t,s0)
  
- /usr/kerberos/sbin/krb5kdc	--	gen_context(system_u:object_r:krb5kdc_exec_t,s0)
- /usr/kerberos/sbin/kadmind	--	gen_context(system_u:object_r:kadmind_exec_t,s0)
-@@ -39,6 +43,12 @@ HOME_DIR/\.k5login	--	gen_context(system_u:object_r:krb5_home_t,s0)
+ /usr/lib/systemd/system/kadmin\.service	--	gen_context(system_u:object_r:kerberos_unit_t,s0)
+ /usr/lib/systemd/system/krb5kdc\.service	--	gen_context(system_u:object_r:kerberos_unit_t,s0)
+@@ -42,6 +46,12 @@ HOME_DIR/\.k5login	--	gen_context(system_u:object_r:krb5_home_t,s0)
  /var/kerberos/krb5kdc/principal.*	gen_context(system_u:object_r:krb5kdc_principal_t,s0)
  /var/kerberos/krb5kdc/principal.*\.ok	--	gen_context(system_u:object_r:krb5kdc_lock_t,s0)
  
@@ -41,6 +41,6 @@ index 81627d2db..4966b06d4 100644
  /var/log/krb5kdc\.log.*	--	gen_context(system_u:object_r:krb5kdc_log_t,s0)
  /var/log/kadmin\.log.*	--	gen_context(system_u:object_r:kadmind_log_t,s0)
  /var/log/kadmind\.log.*	--	gen_context(system_u:object_r:kadmind_log_t,s0)
--- 
-2.34.1
 
+-- 
+2.43.0
diff --git a/recipes-security/refpolicy/refpolicy/0026-file_contexts.subs_dist-set-aliase-for-root-director.patch b/recipes-security/refpolicy/refpolicy/0026-file_contexts.subs_dist-set-aliase-for-root-director.patch
index cf4d59d..6f6b2fc 100644
--- a/recipes-security/refpolicy/refpolicy/0026-file_contexts.subs_dist-set-aliase-for-root-director.patch
+++ b/recipes-security/refpolicy/refpolicy/0026-file_contexts.subs_dist-set-aliase-for-root-director.patch
@@ -1,4 +1,4 @@
-From 795b2380c6f1e3541384f69d0f00e8933dfacf93 Mon Sep 17 00:00:00 2001
+From 25b8af93a5684abf449afed1414ca6e38184e0ae Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Sun, 5 Apr 2020 22:03:45 +0800
 Subject: [PATCH] file_contexts.subs_dist: set aliase for /root directory
@@ -14,17 +14,20 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 4 insertions(+)
 
 diff --git a/config/file_contexts.subs_dist b/config/file_contexts.subs_dist
-index 8a5274283..f54517d89 100644
+index bae4ef439..fb966318b 100644
 --- a/config/file_contexts.subs_dist
 +++ b/config/file_contexts.subs_dist
-@@ -46,3 +46,7 @@
- /usr/lib/busybox/bin /usr/bin
+@@ -47,6 +47,10 @@
  /usr/lib/busybox/sbin /usr/bin
  /usr/lib/busybox/usr /usr
-+
+ 
 +# The script genhomedircon.py will expand `/root` (i.e. root's home
 +# directory) to `/home/root`. Add an alias for it.
 +/root /home/root
--- 
-2.34.1
++
+ # systemd system extension (systemd-sysext) staging dirs merge onto /usr and /opt,
+ # and systemd configuration extension (systemd-confext) staging dirs merge onto /etc.
+ # The staged trees are overlaid onto the host tree with overlayfs, so they must carry
 
+-- 
+2.43.0
diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
index 4d207a2..dbc8cc8 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -1,8 +1,8 @@
-PV = "2.20260616+git"
+PV = "2.20260922+git"
 
 SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
 
-SRCREV_refpolicy = "30d3cf5abd1872d3da5dd44de37de4251674f736"
+SRCREV_refpolicy = "acf41c52116fef3a9dcd8f1f39b133e0372fce7c"
 
 UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
 
-- 
2.43.0

