Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A691FF8868
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 17:56:58 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2116.1777312611172000411
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 10:56:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63RHugAf876837;
	Mon, 27 Apr 2026 12:56:43 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org, richard.purdie@linuxfoundation.org
Cc: dburgener@linux.microsoft.com, peter.kjellerstedt@axis.com
Subject: [pseudo][PATCH 02/11] linkat: Avoid a segmentation fault
Date: Mon, 27 Apr 2026 12:56:32 -0500
Message-Id: <1777312601-1393-3-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1777312601-1393-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1777312601-1393-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 17:56:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3849

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

This avoids the following segmentation fault (in useradd):

  Program terminated with signal SIGSEGV, Segmentation fault.
  #0  0x0000795b22562f49 in wrap_linkat (olddirfd=olddirfd@entry=-100,
      oldname=oldname@entry=0x6016835f1fb0 "/etc/group.3167327",
      newdirfd=newdirfd@entry=-100,
      newname=newname@entry=0x6016835f1fd0 "/etc/group.lock",
      flags=flags@entry=0) at ports/unix/guts/linkat.c:37
  37              oldpath = oldname;
  (gdb) bt
  #0  0x0000795b22562f49 in wrap_linkat (olddirfd=olddirfd@entry=-100,
      oldname=oldname@entry=0x6016835f1fb0 "/etc/group.3167327",
      newdirfd=newdirfd@entry=-100,
      newname=newname@entry=0x6016835f1fd0 "/etc/group.lock",
      flags=flags@entry=0) at ports/unix/guts/linkat.c:37
  #1  0x0000795b2257b95c in wrap_link (newname=0x6016835f1fd0 "/etc/group.lock",
      oldname=0x6016835f1fb0 "/etc/group.3167327") at ports/unix/guts/link.c:17
  #2  link (oldname=0x6016835f1fb0 "/etc/group.3167327",
      newname=0x6016835f1fd0 "/etc/group.lock") at pseudo_wrapfuncs.c:8968
  #3  0x00006016814d45dd in do_lock_file (file=file@entry=0x6016835f1fb0 "/etc/group.3167327",
      lock=lock@entry=0x6016835f1fd0 "/etc/group.lock", log=log@entry=true)
      at ../../sources/shadow-4.19.4/lib/commonio.c:167
  #4  0x00006016814d4e88 in commonio_lock_nowait (db=db@entry=0x6016814df9e0 <group_db>,
      log=log@entry=true) at ../../sources/shadow-4.19.4/lib/commonio.c:373
  #5  0x00006016814d4f09 in commonio_lock (db=db@entry=0x6016814df9e0 <group_db>)
      at ../../sources/shadow-4.19.4/lib/commonio.c:413
  #6  0x00006016814cfc9a in gr_lock () at ../../sources/shadow-4.19.4/lib/groupio.c:141
  #7  0x00006016814c981f in open_group_files (process_selinux=process_selinux@entry=false)
      at ../../sources/shadow-4.19.4/src/useradd.c:1797
  #8  0x00006016814cacdc in open_files (process_selinux=process_selinux@entry=false)
      at ../../sources/shadow-4.19.4/src/useradd.c:1759
  #9  0x00006016814cc388 in main (argc=<optimized out>, argv=<optimized out>)
      at ../../sources/shadow-4.19.4/src/useradd.c:2585
  (gdb) l
  32              if (olddirfd != AT_FDCWD || newdirfd != AT_FDCWD) {
  33                      errno = ENOSYS;
  34                      return -1;
  35              }
  36      #endif
  37              oldpath = oldname;
  38              if (pseudo_chroot_len && strncmp(oldpath, pseudo_chroot, pseudo_chroot_len) &&
  39                      oldpath[pseudo_chroot_len] == '/') {
  40                      oldpath += pseudo_chroot_len;
  41              }
  (gdb) p oldname
  $1 = 0x6016835f1fb0 "/etc/group.3167327"
  (gdb) p oldpath
  $2 = 0x6016835f1fb0 "/etc/group.3167327"
  (gdb) p pseudo_chroot_len
  $3 = 91

The above code (on line 38) is supposed to check if oldpath is prefixed
by pseudo_chroot, but instead it checks the opposite, and then the check
for the slash on the next line is made outside oldpath if it is shorter
than pseudo_chroot.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 ports/unix/guts/linkat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ports/unix/guts/linkat.c b/ports/unix/guts/linkat.c
index e1712a9..60fbf63 100644
--- a/ports/unix/guts/linkat.c
+++ b/ports/unix/guts/linkat.c
@@ -35,7 +35,7 @@
 	}
 #endif
 	oldpath = oldname;
-	if (pseudo_chroot_len && strncmp(oldpath, pseudo_chroot, pseudo_chroot_len) &&
+	if (pseudo_chroot_len && !strncmp(oldpath, pseudo_chroot, pseudo_chroot_len) &&
 		oldpath[pseudo_chroot_len] == '/') {
 		oldpath += pseudo_chroot_len;
 	}
-- 
1.8.3.1


