Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.29046.1793862380721839371
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Nov 2026 23:06:20 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=jleUO9g2;
 spf=pass (domain: cisco.com, ip: 173.37.86.78, mailfrom: dkelaiya@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4780; q=dns/txt;
  s=iport01; t=1793862380; x=1795071980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mZ0Kj4iLKYWqDyi7d6sM6I5X+7Ag1RMpHUsRqHWeq/Q=;
  b=jleUO9g2nrr3N74n5nfJ5iiLGo102D+8SveYsvPLqa+ZjRf5N7/Szq2f
   6USCkfWujE76iwctnUEFsRmwSJfUcZ06Cm27RHhSRJicRww7L8pdi+j3j
   khnAD+QuwYjn2bwsXnYR0CY70xDTo8oNPY5gxQq9V+FnvyP0L1gcZPc7l
   6blhLM6DBSEp7L2T2c+bwT9U+d2hOvZlB7VXDJ1W47P64/yrZFhXj0kyV
   zYMeyaitw1byWcoNJI8yNFeQvvT7ZHpn4RGX8DFw5v7fHXDZ/cYKZK+Xj
   ngBnyGU93eyWkwd4woLUq8iSZvWvv8YXa1MjU8M6MxztOgc5gqMRj/6Wc
   w==;
X-CSE-ConnectionGUID: t4lWYXLCSpSRKcYlYY8ssA==
X-CSE-MsgGUID: v948fA7zTcq5hPFL1MLIWA==
X-IPAS-Result: =?us-ascii?q?A0BJAgC/Kexq/5T/Ja1aglmCV3VgQ0kDlkgDi2WSPIF+D?=
 =?us-ascii?q?wEBAQ9EDQQBAYQ/RgKOHQImNAkOAQIEAwIDAQEBAQEBAQEBAQEBCgEBBQEBA?=
 =?us-ascii?q?QIBBwWBDhOGTw2QEgECAQMnCwFGEBwDAQIvIAsjCBmDAgGCOgM3AxEGvDiBe?=
 =?us-ascii?q?TOBAYR+2EwNgloBCxQBgTiFQIJ/hSRdGAGEfScbG4FygRWDaYEFgRpCAQEBi?=
 =?us-ascii?q?CUEgiKBDIFaHoYihlgCgVKGcUiBHgNZLAFVEw0KCwcFgWgDNRIqFW4yHYEjP?=
 =?us-ascii?q?heBBxsGBYEdgR6BEoEHXYErKF0BIYEIgXYCglGCAAIBSUEOB0VTCSVDEkckI?=
 =?us-ascii?q?ggSCQETGiwKgRo1PAkmPxUMZAsaBWEIAg0McjkQMB4kLwUcJkAbChgYDUgRL?=
 =?us-ascii?q?DcVGQQ+bgeSL4J/Ei03FxMBEwgOAlaBBCMGKQUMCy+SdJI3oCBxCiiDeIwkj?=
 =?us-ascii?q?z6FfBozqnELmH2OCoQKkXpNhGmBaDyBWXAVgyIJCUEZD44uCwscg0SFE8lIJ?=
 =?us-ascii?q?jICCQMvAQEHAgcOAwuBaJF+AQE?=
IronPort-Data: A9a23:vkvZEa8ghwkJ/Mk5y72eDrUD1X+TJUtcMsCJ2f8bNWPcYEJGY0x3z
 jAfWmCEbKnfYjP9edBzYY+/o0lV65HTy94wQVFqrHhEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmB4E/rbei5xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4mtyyHjEAX9gWAtazpIs/jrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2kqYYkny9ZTKlpWz
 sY7IwEJXyHTnPmflefTpulE3qzPLeHxN48Z/3UlxjbDALN/GNbIQr7B4plT2zJYasJmRKmFI
 ZFGL2AyMVKZP00n1lQ/UPrSmM+khXT7ejxJoXqepLE85C7YywkZPL3FbYaOK4TaHZUJ9qqej
 nyXozT3K04ICNeGlDq93Fb1o8vuogquDer+E5X9rJaGmma712sYFBpTTVKnqvm0kWa6WslDM
 AoF/SEyqrAo806mRcW7WAe3yENopTYGUNZWVul/4waXx++NukCSB3MPSXhKb9lOWNIKeAHGH
 2Shx7vBbQGDepXMIZ5B3t94dQ+PBBU=
IronPort-HdrOrdr: A9a23:epfluKBNhnDyT0TlHemO55DYdb4zR+YMi2TDGXofdfUzSL3+qy
 nAppUmPHPP5Qr5HUtQ++xoW5PwJU80i6QU3WB5B97LN2PbUSmTXeRfBODZrQEIdReTygck79
 YCT4FOTPvtEFN9kcH2pCO8E9om3Z271ZrAv5a585+oJjsaE52JKGxCe3+mLnE=
X-Talos-CUID: =?us-ascii?q?9a23=3AqeW2mmn6Ryf4GeNiO07XblfUfLPXOWGByEjhE2u?=
 =?us-ascii?q?TMn5Scp6eeFuhyfN/iOM7zg=3D=3D?=
X-Talos-MUID: 9a23:t1w6qQRbkhSeqenvRXTy1W0yOu438ZilER0Nqbsi4uygFBNZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,196,1787011200"; 
   d="scan'208";a="543908084"
Received: from rcdn-l-core-11.cisco.com ([173.37.255.148])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 05 Nov 2026 07:06:19 +0000
Received: from sjc-ads-5675.cisco.com (sjc-ads-5675.cisco.com [10.28.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-11.cisco.com (Postfix) with ESMTPS id BAA2F18000140;
	Thu,  5 Nov 2026 07:06:19 +0000 (GMT)
Received: by sjc-ads-5675.cisco.com (Postfix, from userid 1887444)
	id 643A4CBF201; Wed,  4 Nov 2026 23:06:19 -0800 (PST)
From: "Darsh Kelaiya -X (dkelaiya - E INFOCHIPS PRIVATE LIMITED at Cisco)" <dkelaiya@cisco.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Darsh Kelaiya <dkelaiya@cisco.com>
Subject: [yocto-patches][meta-selinux][wrynose][PATCH 2/2] selinux-sandbox: fix CVE-2026-59677
Date: Wed,  4 Nov 2026 23:06:17 -0800
Message-Id: <20261105070617.839020-2-dkelaiya@cisco.com>
X-Mailer: git-send-email 2.35.6
In-Reply-To: <20261105070617.839020-1-dkelaiya@cisco.com>
References: <20261105070617.839020-1-dkelaiya@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: ANONYMOUS;sjc-ads-5675.cisco.com [10.28.88.189];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.28.88.189, sjc-ads-5675.cisco.com
X-Outbound-Node: rcdn-l-core-11.cisco.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 05 Nov 2026 07:06:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5240
Content-Type: text/plain; charset="utf-8"

From: Darsh Kelaiya <dkelaiya@cisco.com>

This patch applies the upstream fix as referenced in [2],
using the commit shown in [1].

Remove the 3.10 killall() helper and retain the upstream diagnostic
for --kill. seunshare no longer signals processes selected by a
caller-provided SELinux context. The embedded patch documents the
adaptation to the older helper implementation.

[1] https://github.com/SELinuxProject/selinux/commit/572db2fae9157ae620160e0d7b2c3f8b75fe6c1a
[2] https://security.opensuse.org/2026/07/15/selinux-seunshare.html

Signed-off-by: Darsh Kelaiya <dkelaiya@cisco.com>
---
 .../selinux-sandbox/CVE-2026-59677.patch      | 114 ++++++++++++++++++
 .../selinux/selinux-sandbox_3.10.bb           |   1 +
 2 files changed, 115 insertions(+)
 create mode 100644 recipes-security/selinux/selinux-sandbox/CVE-2026-59677.patch

diff --git a/recipes-security/selinux/selinux-sandbox/CVE-2026-59677.patch b/recipes-security/selinux/selinux-sandbox/CVE-2026-59677.patch
new file mode 100644
index 0000000..b4ab16f
--- /dev/null
+++ b/recipes-security/selinux/selinux-sandbox/CVE-2026-59677.patch
@@ -0,0 +1,114 @@
+From 572db2fae9157ae620160e0d7b2c3f8b75fe6c1a Mon Sep 17 00:00:00 2001
+From: Stephen Smalley <stephen.smalley.work@gmail.com>
+Date: Thu, 21 May 2026 11:54:44 -0400
+Subject: [PATCH] sandbox/seunshare: drop -k/--kill support
+
+Drop the -k/--kill support; it is fundamentally racy, redundant
+with killall -Z, and seemingly unused by sandbox itself.
+Provide an error message to the user telling them how to achieve
+the same effect via killall.
+
+CVE: CVE-2026-59677
+Upstream-Status: Backport [https://github.com/SELinuxProject/selinux/commit/572db2fae9157ae620160e0d7b2c3f8b75fe6c1a]
+
+Backport Changes:
+- Remove the older 3.10 killall() body, which predates the upstream
+  NULL-context checks, PID-table overflow checks, SELinux type
+  matching and conditional logging.
+
+Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
+(cherry picked from commit 572db2fae9157ae620160e0d7b2c3f8b75fe6c1a)
+Signed-off-by: Darsh Kelaiya <dkelaiya@cisco.com>
+---
+ sandbox/seunshare.c | 69 +----------------------------------------------------
+ 1 file changed, 1 insertion(+), 68 deletions(-)
+
+diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
+index 4e441b3c..02fdd599 100644
+--- a/sandbox/seunshare.c
++++ b/sandbox/seunshare.c
+@@ -656,73 +656,6 @@ good:
+ 	return tmpdir;
+ }
+ 
+-#define PROC_BASE "/proc"
+-
+-static int
+-killall (const char *execcon)
+-{
+-	DIR *dir;
+-	char *scon;
+-	struct dirent *de;
+-	pid_t *pid_table, pid, self;
+-	int i;
+-	int pids, max_pids;
+-	int running = 0;
+-	self = getpid();
+-	if (!(dir = opendir(PROC_BASE))) {
+-		return -1;
+-	}
+-	max_pids = 256;
+-	pid_table = malloc(max_pids * sizeof (pid_t));
+-	if (!pid_table) {
+-		(void)closedir(dir);
+-		return -1;
+-	}
+-	pids = 0;
+-	context_t con;
+-	con = context_new(execcon);
+-	const char *mcs = context_range_get(con);
+-	printf("mcs=%s\n", mcs);
+-	while ((de = readdir (dir)) != NULL) {
+-		if (!(pid = (pid_t)atoi(de->d_name)) || pid == self)
+-			continue;
+-
+-		if (pids == max_pids) {
+-			pid_t *new_pid_table = realloc(pid_table, 2*pids*sizeof(pid_t));
+-			if (!new_pid_table) {
+-				free(pid_table);
+-				(void)closedir(dir);
+-				return -1;
+-			}
+-			pid_table = new_pid_table;
+-			max_pids *= 2;
+-		}
+-		pid_table[pids++] = pid;
+-	}
+-
+-	(void)closedir(dir);
+-
+-	for (i = 0; i < pids; i++) {
+-		pid_t id = pid_table[i];
+-
+-		if (getpidcon(id, &scon) == 0) {
+-
+-			context_t pidcon = context_new(scon);
+-			/* Attempt to kill remaining processes */
+-			if (strcmp(context_range_get(pidcon), mcs) == 0)
+-				kill(id, SIGKILL);
+-
+-			context_free(pidcon);
+-			freecon(scon);
+-		}
+-		running++;
+-	}
+-
+-	context_free(con);
+-	free(pid_table);
+-	return running;
+-}
+-
+ int main(int argc, char **argv) {
+ 	int status = -1;
+ 	const char *execcon = NULL;
+@@ -1076,7 +1009,7 @@ childerr:
+ 	kill(-child,SIGTERM);
+ 
+ 	if (execcon && kill_all)
+-		killall(execcon);
++		fprintf(stderr, "-k/--kill no longer supported; run killall -Z %s\n", execcon);
+ 
+ 	if (tmpdir_r) cleanup_tmpdir(tmpdir_r, tmpdir_s, pwd, 1);
+ 
+-- 
+2.35.6
diff --git a/recipes-security/selinux/selinux-sandbox_3.10.bb b/recipes-security/selinux/selinux-sandbox_3.10.bb
index f8ffd36..6227daf 100644
--- a/recipes-security/selinux/selinux-sandbox_3.10.bb
+++ b/recipes-security/selinux/selinux-sandbox_3.10.bb
@@ -11,6 +11,7 @@ require selinux_common.inc
 
 SRC_URI += "file://sandbox-de-bashify.patch;patchdir=.. \
             file://CVE-2026-59676.patch;patchdir=.. \
+            file://CVE-2026-59677.patch;patchdir=.. \
            "
 
 S = "${UNPACKDIR}/${BP}/sandbox"
-- 
2.35.6
