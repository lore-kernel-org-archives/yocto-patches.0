Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10194.1792585594746797618
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Oct 2026 05:26:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=XksUJ5UG;
 spf=pass (domain: gmail.com, ip: 209.85.167.43, mailfrom: frezidok1@gmail.com)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5bcc6094d7fso494576e87.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Oct 2026 05:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585592; x=1793190392; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hT1hqDY0J0JR4EVv2n1xDjET9e2pOqw6shh74d4DXa4=;
        b=XksUJ5UGgVb164p0o/tWkYTLxfAP+9GtFVxJDM6bkjSxGQf5Ok119zip32nxMAXh1M
         8CTmK9FEiiQrGY2u94lhtBEIeXIEMHeopjK45sLjtZHe1OpbTQa5yk/L/4YI9SIJddOe
         dQVYq5Zop2Y7RT6JnfpDRsO7E6Yh85sv9hva4REmKz5of5oVJ7JQUyGxepLrRUdJBO4H
         eUGjOp2TT9mBqxOJ9eV3F2QxTxy7xqy2MGyznFF8icnAuF38nKfVqf6MjVBc+yklwn9B
         +FDjFmCtKdTBFA98w6aKV1TQalH1njnBmUu3CLHMkHm9lJgggxIwSuXLuj5oatwsXh/b
         RRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585592; x=1793190392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hT1hqDY0J0JR4EVv2n1xDjET9e2pOqw6shh74d4DXa4=;
        b=wTcHUdBBjUWe1+nOxHO4si7z0RvTcuc8yR8Y1/PQHs0SB0VDwLZ4hmkv7bWczuKp+F
         3JkmEXngDIi7pLT/SrilvVH3VicdyEV+aP0u5cwQJLoZRLxeyjaJ24adCgcwqIPXF4pN
         e9LosWaYJv0RXShU+O4ZLsxSh9nUiRJU+FXslARSlIKlK9lMshjnX9DUmcMTPkP2eHxy
         477T490YPvilOO1T2VcgwzUAt7OuC5NIBjk5pdM0vCsEnvxNNGRLegb5aioEWHYJjK5R
         FTnmeSHqXMsthhZnVUZvpTbu0Ipf+KlFUPwN3FNwOOq/SwpQx8Wg8P2OE1TKVqlKoCy1
         +Wqw==
X-Gm-Message-State: AFq9FYJro2sjIOGpkEtnes821KkQoC1EAQIvmscs/eDWfdkUM/1MAXJQ
	7pmCimhtzPjFPPi4N7RLDbk1g1Msrr2xK033ne7T0zdKz57BDqdRfZU1PacdDw==
X-Gm-Gg: AYBFou1BqAx2lV5lnG+6h86bNDgPrwtktao9KSIp8yJBZjbexaFYK14h2N5nHMIfDxu
	8oqbIf8GZlgU4ZPhc8pczihi8pu8/0T3fnKBw3ZKM/xeTff5GDI58jHG70Gch+E05noFNNmtWyd
	3b3EqeJACIoRRfNSffoqQHOTXurh998QjXQ6hfHHpXyuA2eHkhK49dbWmEnXVzi0HkLZSiixwGA
	9iBI/y6hLdzqtIt/6JN83A6/0Npe6R9ksMJHPrdd+OZuhaSYa4ojqK1lJ1TLEkRPjT8lxXWrPkv
	NfohtagDyCDtASPbvv1WMV2JT7wS/ZArExlzVPtn2tlumKMxfekWGdkXt2J+cX4uXz4iMoy+ha2
	ziyB4bM1pSJqqxN8H4ga8uJ1qvp/Bt+D4m8aNH9f8SmKGQ9qiWDNX6n4ObT2Ju/TncfsAmb5kxH
	+NimMOLMfis7soNDC8j3+TarYwd909/px/Wj2m2pmI9rfXxlZj+ZOVqHQtnW6qUoTYArWf+zXK5
	PKAmbDTsZvkBdeP9EoT7ZZKERyWbTtFzvCjt17ZYhkLap2XeC0MHH2kNK2FW52uIHnzjgelfpBn
	pFoQ3Q==
X-Received: by 2002:a05:6512:31c1:b0:5be:4323:3cf4 with SMTP id 2adb3069b0e04-5bfa1ccebb7mr819805e87.10.1792585592144;
        Wed, 21 Oct 2026 05:26:32 -0700 (PDT)
Return-Path: <frezidok1@gmail.com>
Received: from ubuntu1.. (ppp91-78-37-46.pppoe.mtu-net.ru. [91.78.37.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfa11aadcasm491451e87.1.2026.10.21.05.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:26:31 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH] ports/linux/guts: Fix uninitialized pseudo_path in open_tree wrappers
Date: Wed, 21 Oct 2026 15:26:14 +0300
Message-ID: <20261021122614.751395-1-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Oct 2026 12:26:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5125
Content-Type: text/plain; charset="utf-8"

From: Dmitry Sakhonchik <frezidok1@gmail.com>

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
---
 ports/linux/guts/open_tree.c      | 11 +++++++++--
 ports/linux/guts/open_tree_attr.c | 11 +++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/ports/linux/guts/open_tree.c b/ports/linux/guts/open_tree.c
index ca299a1..658b165 100644
--- a/ports/linux/guts/open_tree.c
+++ b/ports/linux/guts/open_tree.c
@@ -16,6 +16,15 @@
 		pseudo_diag("ERROR: OPEN_TREE_CLONE is not supported\n");
 	}
 
+	/* This wrapper is not called with modified paths, therefore we have to handle this ourselves.
+	   We can't use the standard mappings since the function needs relative paths to be preserved,
+	   they can't be our usual absolute paths. An example difference:
+	   open_tree(dirfd, "/dir1/dir2", 0) = -1 ENOENT (No such file or directory)
+	   vs.
+	   open_tree(dirfd, "dir1/dir2", 0) = 4
+	   FIXME - we don't handle chroot for relative paths
+	*/
+	pseudo_path = pseudo_root_path(__func__, __LINE__, dirfd, path, 0);
 	if (path && path[0] == '/') {
 		/* If the path is absolute, we should account for a potential chroot */
 		path = pseudo_path;
@@ -37,8 +46,6 @@
 		save_errno = errno;
 		int stat_rc;
 
-		pseudo_path = pseudo_root_path(__func__, __LINE__, dirfd, path, 0);
-
 		stat_rc = real___fxstatat64(_STAT_VER, dirfd, pseudo_path, &buf, (flags & AT_SYMLINK_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
 
 		pseudo_debug(PDBGF_FILE, "open_tree(path %s), flags %o, stat rc %d, stat mode %o\n",
diff --git a/ports/linux/guts/open_tree_attr.c b/ports/linux/guts/open_tree_attr.c
index 3cf8fc7..c2b1b0d 100644
--- a/ports/linux/guts/open_tree_attr.c
+++ b/ports/linux/guts/open_tree_attr.c
@@ -18,6 +18,15 @@
 		pseudo_diag("ERROR: OPEN_TREE_CLONE is not supported\n");
 	}
 
+	/* This wrapper is not called with modified paths, therefore we have to handle this ourselves.
+	   We can't use the standard mappings since the function needs relative paths to be preserved,
+	   they can't be our usual absolute paths. An example difference:
+	   open_tree_attr(dirfd, "/dir1/dir2", 0, NULL, 0) = -1 ENOENT (No such file or directory)
+	   vs.
+	   open_tree_attr(dirfd, "dir1/dir2", 0, NULL, 0) = 4
+	   FIXME - we don't handle chroot for relative paths
+	*/
+	pseudo_path = pseudo_root_path(__func__, __LINE__, dirfd, path, 0);
 	if (path && path[0] == '/') {
 		/* If the path is absolute, we should account for a potential chroot */
 		path = pseudo_path;
@@ -35,8 +44,6 @@
 		save_errno = errno;
 		int stat_rc;
 
-		pseudo_path = pseudo_root_path(__func__, __LINE__, dirfd, path, 0);
-
 		stat_rc = real___fxstatat64(_STAT_VER, dirfd, pseudo_path, &buf, (flags & AT_SYMLINK_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
 
 		pseudo_debug(PDBGF_FILE, "open_tree_attr(path %s), flags %o, stat rc %d, stat mode %o\n",
