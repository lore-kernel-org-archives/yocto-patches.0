Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20042.1794797797172472080
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Nov 2026 18:56:37 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wAnL7NhcPpqXdQAAA--.934S3;
	Mon, 16 Nov 2026 10:54:26 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowABn+WnccPpqPNA3AA--.14039S2;
	Mon, 16 Nov 2026 10:56:29 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [PATCH 0/6] meta-selinux: fix systemd 262 denials and ensure SELinux tests work on every variant
Date: Mon, 16 Nov 2026 10:56:14 +0800
Message-ID: <20261116025620.2558594-1-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowABn+WnccPpqPNA3AA--.14039S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYNCmr5tRgFSgACsw
X-CM-DELIVERINFO: =?B?uDb2vac9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoONahKFcN3sR551ZGDSnKFd8rHgF+PoM4iOLMVjtJ5YpjqROjqFR4U6ep6X5L4Bi7iXeT
	vzb6Rhylx7KI5wXFWMV5aRBlGnxz2xTFyYapbkYPDyIFMVKHmOuAV3pML9bUmA==
X-Coremail-Antispam: 1Uk129KBj93XoW3Ww1fXr45AFyfZrW8XFWkGrX_yoW7GFykpF
	4jkr98Aa9IqFW0yrsrC3Z8Wrn5Ja4Yqas8Wry3Cr4kAw4qyF90gF18tF1v9aykuw13G3W7
	Xr1xXFySq3W7trgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GrUv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY27kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4kE6xkIj40Ew7xC0wCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1Y6r17MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU
	0xZFpf9x07jUCztUUUUU=
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 02:56:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5398
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

1-3 make the policy usable.  Bump refpolicy to 720c02a1b for the
systemd 262 fixes, carry the shadow lock fix that upstream has not
merged (PR #1280), and run `make bare` before do_compile so a changed
POLICY_BOOLEANS is not defeated by stale generated files.

4 decides the cases from /proc/self/attr/current, and logs in as a
user_u test account where the session is unconfined.

5-6 make the variable overridable with ??= and default
ssh_sysadm_login to true on targeted, where ssh root otherwise fails
with "/bin/sh: Permission denied".

Tested with core-image-minimal on qemux86-64 and qemuarm64,
refpolicy-mcs 15 passed, refpolicy-targeted 14 passed 1 skipped.

Chen Qi (6):
  refpolicy: bump to latest
  refpolicy: fix shadow lock issue
  refpolicy_common: ensure we start from a clean state in do_compile
  oeqa: decide the SELinux cases on the domain, not the policy name
  refpolicy_common: use ??= for POLICY_BOOLEANS
  refpolicy-targeted: allow ssh_sysadm_login by default

 lib/oeqa/runtime/cases/selinux.py             | 543 ++++++++++++++----
 .../refpolicy/refpolicy-targeted_git.bb       |   2 +
 ...tile-alias-common-var-volatile-paths.patch |   5 +-
 ...e-unconfined_u-definition-to-unconfi.patch |  13 +-
 ...box-set-aliases-for-bin-sbin-and-usr.patch |   5 +-
 ...ed-make-unconfined_u-the-default-sel.patch |   7 +-
 ...y-policy-to-common-yocto-hostname-al.patch |   5 +-
 ...sr-bin-bash-context-to-bin-bash.bash.patch |   9 +-
 ...abel-resolv.conf-in-var-run-properly.patch |   5 +-
 ...-apply-login-context-to-login.shadow.patch |   5 +-
 ...-fc-hwclock-add-hwclock-alternatives.patch |   5 +-
 ...g-apply-policy-to-dmesg-alternatives.patch |   5 +-
 ...ssh-apply-policy-to-ssh-alternatives.patch |   5 +-
 ...ply-policy-to-network-commands-alter.patch |   5 +-
 ...ply-rpm_exec-policy-to-cpio-binaries.patch |   5 +-
 ...c-su-apply-policy-to-su-alternatives.patch |   5 +-
 ...fc-fstools-fix-real-path-for-fstools.patch |   5 +-
 ...fix-update-alternatives-for-sysvinit.patch |  11 +-
 ...l-apply-policy-to-brctl-alternatives.patch |   5 +-
 ...apply-policy-to-nologin-alternatives.patch |   9 +-
 ...apply-policy-to-sulogin-alternatives.patch |   5 +-
 ...tp-apply-policy-to-ntpd-alternatives.patch |   5 +-
 ...pply-policy-to-kerberos-alternatives.patch |   5 +-
 ...ap-apply-policy-to-ldap-alternatives.patch |   5 +-
 ...ply-policy-to-postgresql-alternative.patch |   5 +-
 ...ply-policy-to-usermanage-alternative.patch |   5 +-
 ...etty-add-file-context-to-start_getty.patch |   5 +-
 ...k-apply-policy-to-vlock-alternatives.patch |   5 +-
 ...for-init-scripts-and-systemd-service.patch |   9 +-
 ...bs_dist-set-aliase-for-root-director.patch |   5 +-
 ...ystem-logging-add-rules-for-the-syml.patch |   7 +-
 ...ystem-logging-add-rules-for-syslogd-.patch |   7 +-
 ...ernel-files-add-rules-for-the-symlin.patch |   5 +-
 ...ystem-logging-fix-auditd-startup-fai.patch |   7 +-
 ...ernel-terminal-don-t-audit-tty_devic.patch |   5 +-
 ...ystem-systemd-enable-support-for-sys.patch |   7 +-
 ...es-system-systemd-systemd-user-fixes.patch |  13 +-
 ...ystem-logging-grant-getpcap-capabili.patch |   7 +-
 ...ystem-allow-services-to-read-tmpfs-u.patch |  15 +-
 ...ernel-domain-allow-all-domains-to-co.patch |   9 +-
 ...-allow-systemd-logind-to-inherit-fds.patch |  11 +-
 ...stemd-tmpfiles-to-read-bin_t-symlink.patch |  17 +-
 ...-systemd-networkd-and-systemd-rfkill.patch |  13 +-
 ...main-used-for-login-program-to-conne.patch |  20 +-
 ...temd-add-rules-for-systemd-ssh-issue.patch |  15 +-
 ...ystem-mount-make-mount_t-domain-MLS-.patch |   5 +-
 ...oles-sysadm-MLS-sysadm-rw-to-clearan.patch |   7 +-
 ...ervices-rpc-make-nfsd_t-domain-MLS-t.patch |  13 +-
 ...dmin-dmesg-make-dmesg_t-MLS-trusted-.patch |   5 +-
 ...ernel-kernel-make-kernel_t-MLS-trust.patch |   9 +-
 ...ystem-init-make-init_t-MLS-trusted-f.patch |   9 +-
 ...ystem-systemd-make-systemd-tmpfiles_.patch |   9 +-
 ...ystem-systemd-systemd-make-systemd_-.patch |  15 +-
 ...ystem-logging-add-the-syslogd_t-to-t.patch |   7 +-
 ...ystem-init-make-init_t-MLS-trusted-f.patch |   9 +-
 ...ystem-init-all-init_t-to-read-any-le.patch |   9 +-
 ...ystem-logging-allow-auditd_t-to-writ.patch |   7 +-
 ...ernel-kernel-make-kernel_t-MLS-trust.patch |   9 +-
 ...ystem-setrans-allow-setrans_t-use-fd.patch |   5 +-
 ...ystem-systemd-make-_systemd_t-MLS-tr.patch |   9 +-
 ...ystem-logging-make-syslogd_runtime_t.patch |   7 +-
 ...allow-creating-the-shadow-lock-files.patch |  41 ++
 .../refpolicy/refpolicy_common.inc            |   4 +-
 recipes-security/refpolicy/refpolicy_git.inc  |   2 +-
 64 files changed, 620 insertions(+), 432 deletions(-)
 create mode 100644 recipes-security/refpolicy/refpolicy/0058-authlogin-allow-creating-the-shadow-lock-files.patch

-- 
2.43.0

