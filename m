Received: from MW6PR02CU001.outbound.protection.outlook.com (MW6PR02CU001.outbound.protection.outlook.com [52.101.48.68])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3540.1794509284394130964
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Nov 2026 10:48:04 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=V+pzGfO6;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.48.68, mailfrom: mark.hatle@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEPrKRCKbByx9ty2N1SZiJ88ZFcw8pOK4+iSLkRpByPLMoeuPC9iQSpGuHBNtrZ8NXpVG8q07YVH53xyuIyuYE5lWR1Wx/LgCIwek7E3LjF+zBy3vVyT24VGVx7smpDBGBHwDYVqXgTUuGiWXfgGvV7PpAvaUy5JR2J5FQg5fEHmLtvqjmcBl8thdM4dRyy09SN0ii3KImzcI2vN7GFTYM0Piw/TuCHbmBmPKJwdgMOdquUwo1oo4o+BloVFib87uDhIgH2vGS2XCdUS519J2yIjh7x70B8OHZW8TFC/C7P/4VtywOFqhV7SEgBUheHeJAuHtgyX93BT1XtTGRh8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fxfjVG2pM4N6sbxFXR17hlBQT1s5SDMA0K153KeHWE=;
 b=C34IBbfwoLYfjtPB47Fg4BKRvrCC/OkxFpJ3sPozOEZNDt8Sr6vWN9kwtJMhUBeF2Z5jxDuKzYCRuPSmFmVBEeUUfpydRRMOiuOe3+gNx2G8WJGCdV6v1qiL0SisiUd6XFqSQRRy4aDrY06DCvMlnLRS1XRXc8YlkTFcwJEKdhOpCCn9ALHWg4klwnt/XHReNL7Nu0oY7plZ9eUFgwsXkKVmwdDQ7yXqk70gtWhTptPhFevOQd/DnSNuZiPeoo8nFbGasif5bgE9BZC0ShhnpvU0+y8kiXFKMd5ZUV+zT4bRxVV/fMAWiPd7WK3/42xViN8ua5Q3uXWLfBuBnqobTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fxfjVG2pM4N6sbxFXR17hlBQT1s5SDMA0K153KeHWE=;
 b=V+pzGfO6QctwwqzlzkvH578xjFrPdQW3nNmPUOaAoKL59VDE20hPnn77o8XYHqTGPyzDY+L3/Z4yPZb4O0iM2futfbEKySQJm2VkSiQz8R+IZNB2bajdGw7+TL0Nbl0snewMJNJb4YzJdJC3/WEHP0EbC+/Rvu0OaXXU8DTnFb4=
Received: from BN9PR03CA0527.namprd03.prod.outlook.com (2603:10b6:408:131::22)
 by PH9PR12MB409658.namprd12.prod.outlook.com (2603:10b6:510:412::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 18:47:57 +0000
Received: from BL6PEPF0006C3E1.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::29) by BN9PR03CA0527.outlook.office365.com
 (2603:10b6:408:131::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 18:47:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0006C3E1.mail.protection.outlook.com (10.167.249.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 18:47:40 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 12:47:10 -0600
Received: from xcolc230100.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 12:47:10 -0600
From: Mark Hatle <mark.hatle@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [pseudo][PATCH RFC 2/2] openat2: Look at dirfd for an empty path
Date: Thu, 12 Nov 2026 11:47:10 -0700
Message-ID: <20261112184710.549482-3-mark.hatle@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261112184710.549482-1-mark.hatle@amd.com>
References: <20261112184710.549482-1-mark.hatle@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: mark.hatle@amd.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3E1:EE_|PH9PR12MB409658:EE_
X-MS-Office365-Filtering-Correlation-Id: 3612aea4-44ad-45d7-9938-08df40ed6dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|22082099003|18002099003|3023799007|261026135527099003|11063799006|261026140227099003|261021123027099003|261028144727099003|261026130827099003|261026121527099003|261021130227099003|261021133027099003|261021135927099003|261021121427099003|56012099006|261022105027099003|261009223027099003|261022113327099003|261022115727099003|261102123227099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: vX6NQuXzcHaJmxSTRzRLXkbEXdUed784XFFCNQtC7NdDsKjS4l4xffQiqKboZuE+IfecHY7D3kEN0rRlDbtHa59c26fC4TdyONnIcN8LJdsOr6I4HOFBNZHrzd7Sc/XURxZHAgeBFktbfyF74ocHq5FgI21mvn6fiDj0HFs3TuO3aYy6Kql0bO9/EplpAcCu8NW9t6t/NUEskiJydZh2tDFolw9fp0ptGWBeSM19FpvoodOgJnDZIY6+xSCwp41QvGscKgAktY3//oeVQ+pLMqpt4aiJjozgEB3FW3OHYWa5skTUGBbtp20iYCADSK2At6A4mbVxdpmq/CO1VksU1ODn8nazUeI98bdQUJl8CwQ2hBgKneVvwz0N+JZxlBxWnjeSCizsHxM5h3isQzQeq8Wqfflmp4Y/LY9HiDyAvlQqvSo0rglLCEMr0GwSgaSQhwR8c+fH5wQraQyuxkXaUtQ2FJcrfRKNTBRGz30wCQAcFJvacYy1QCzA+0KcL3hdqKC7An56FYa3brAd6y6d0MkKnrWxdg/bU6hLXsPHwkVqP6Jpk1OTS9S0x/RY3Wrdr49Uc3vwm5XWU3Zq3MYT0LiGxvFyZuHTsc+CxVZpS2jRKoRaIxaA4qf0DaP2R8Q8lRcfUd6Uy3d+Obeq34sCfdWchJJ7ZfaMiolZy0kltXAsZ4QhaaydvgDLlEHRLhbNIji8nFFs9HPLh2Hz7oRd+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(3023799007)(261026135527099003)(11063799006)(261026140227099003)(261021123027099003)(261028144727099003)(261026130827099003)(261026121527099003)(261021130227099003)(261021133027099003)(261021135927099003)(261021121427099003)(56012099006)(261022105027099003)(261009223027099003)(261022113327099003)(261022115727099003)(261102123227099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Pb6kUiuUmX1mrla4rRZBmAmLKeDZRX06GDGU5rMk3fv1VDfRV2WWv+IJWeSgw0jp25gibi8QeKneUfJkQA8p49AC7kq7T+CJ2DcEZMwapcssVKwCQ6KnwqBQnMFmD3CeatN01hhDNdIqrW0BP2dygBwc14vpcVRuzZ354rWU/teDOVaO8m/g1G8Oa9QNIjtCGVrCN4BldD8QY98p/CBnFxZ09wDRsTgwFbi0WtL8X87jg3QVRPGDE+rN44Yw9qCA9ceZYUeUZpm/sCYOxBRvktG5GIC6z9NjLOvjyZZNtkro29b4qHC305QYK21I+K4NNekV5yOQz6SfrPqpQMlPwi7RgxwCyW58cBl8bNrKjEoBxfJnKDTL5+iAbIBZth4gbhEyjPI2gjyEj/sWyIFOokQACeEQSteH7VnfQDUgh1Du4/S01WUj3C2BDhU234+z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 18:47:40.6173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3612aea4-44ad-45d7-9938-08df40ed6dfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0006C3E1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB409658
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 18:48:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5334
Content-Type: text/plain; charset="utf-8"

openat2() passes an empty path to the kernel, which with Linux 7.2's
O_EMPTYPATH reopens dirfd, but pseudo then looked at and recorded
dirfd's recorded path.  With AT_FDCWD that path is empty, so *at() calls
relative to the new descriptor failed, and for a descriptor on a symlink
it described the target instead.

Look at dirfd itself with AT_EMPTY_PATH, as openat() now does, and record
dirfd's path, or the working directory's for AT_FDCWD.

[YOCTO #16327]

Reported-by: Paul Barker <paul@pbarker.dev>
AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 ports/linux/openat2/guts/openat2.c | 24 +++++++++++++++++++-----
 test/test-openat-emptypath.c       | 30 ++++++++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/ports/linux/openat2/guts/openat2.c b/ports/linux/openat2/guts/=
openat2.c
index bb4a125..30a51ab 100644
--- a/ports/linux/openat2/guts/openat2.c
+++ b/ports/linux/openat2/guts/openat2.c
@@ -15,6 +15,8 @@
 	sigset_t local_saved_sigmask;
 	struct open_how my_how;
 	char *pseudo_path;
+	const char *stat_path, *record_path;
+	int stat_flags;
=20
 	/* Validate parameters */
 	if (!how || size < sizeof(struct open_how)) {
@@ -41,6 +43,18 @@
=20
 	memcpy(&my_how, how, size);
=20
+	stat_path =3D record_path =3D pseudo_path;
+	stat_flags =3D (my_how.flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0;
+	/* An empty path is passed to the kernel, which only accepts it with
+	 * O_EMPTYPATH, to reopen dirfd.  Look at and record dirfd instead.
+	 */
+	if (path && !*path) {
+		stat_path =3D "";
+		stat_flags |=3D AT_EMPTY_PATH;
+		record_path =3D pseudo_root_path(__func__, __LINE__, dirfd,
+			dirfd =3D=3D AT_FDCWD ? "." : "", 0);
+	}
+
 	/* mask out mode bits appropriately */
 	my_how.mode =3D my_how.mode & ~pseudo_umask;
=20
@@ -81,7 +95,7 @@
 	/* note "else" in #ifdef O_TMPFILE above */
 	if (my_how.flags & O_CREAT) {
 		save_errno =3D errno;
-		rc =3D base_fstatat(dirfd, pseudo_path, &buf, (my_how.flags & O_NOFOLLOW=
) ? AT_SYMLINK_NOFOLLOW : 0);
+		rc =3D base_fstatat(dirfd, stat_path, &buf, stat_flags);
 		existed =3D (rc !=3D -1);
 		if (!existed)
 			pseudo_debug(PDBGF_FILE, "openat2_creat: %s -> 0%lld\n", pseudo_path, m=
y_how.mode);
@@ -94,7 +108,7 @@
 	 */
 	if (!(my_how.flags & O_NONBLOCK) && ((my_how.flags & (O_WRONLY | O_RDONLY=
 | O_RDWR)) !=3D O_RDWR)) {
 		save_errno =3D errno;
-		rc =3D base_fstatat(dirfd, pseudo_path, &buf, (my_how.flags & O_NOFOLLOW=
) ? AT_SYMLINK_NOFOLLOW : 0);
+		rc =3D base_fstatat(dirfd, stat_path, &buf, stat_flags);
 		if (rc !=3D -1 && S_ISFIFO(buf.st_mode)) {
 			overly_magic_nonblocking =3D 1;
 		}
@@ -151,7 +165,7 @@
 			return rc;
 		}
 #endif
-		stat_rc =3D base_fstatat(dirfd, pseudo_path, &buf, (my_how.flags & O_NOF=
OLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
+		stat_rc =3D base_fstatat(dirfd, stat_path, &buf, stat_flags);
=20
 		pseudo_debug(PDBGF_FILE, "openat2(path %s), flags %lld, stat rc %d, stat=
 mode %o\n",
 			pseudo_path, my_how.flags, stat_rc, buf.st_mode);
@@ -168,11 +182,11 @@
 				}
 				pseudo_client_path_unlock(path_lock_fd);
 			}
-				pseudo_client_op(OP_OPEN, PSEUDO_ACCESS(my_how.flags), rc, dirfd, pseu=
do_path, &buf);
+				pseudo_client_op(OP_OPEN, PSEUDO_ACCESS(my_how.flags), rc, dirfd, reco=
rd_path, &buf);
 		} else {
 			pseudo_debug(PDBGF_FILE, "openat2 (fd %d, path %d/%s, flags %lld) succe=
eded, but stat failed (%s).\n",
 				rc, dirfd, pseudo_path, my_how.flags, strerror(errno));
-			pseudo_client_op(OP_OPEN, PSEUDO_ACCESS(my_how.flags), rc, dirfd, pseud=
o_path, 0);
+			pseudo_client_op(OP_OPEN, PSEUDO_ACCESS(my_how.flags), rc, dirfd, recor=
d_path, 0);
 		}
 		errno =3D save_errno;
 	}
diff --git a/test/test-openat-emptypath.c b/test/test-openat-emptypath.c
index 076f1fd..7ebec12 100644
--- a/test/test-openat-emptypath.c
+++ b/test/test-openat-emptypath.c
@@ -1,6 +1,6 @@
 /*
- * Test opening an empty path, which only names dirfd with O_EMPTYPATH
- * (Linux 7.2), the way the kernel does.
+ * Test opening an empty path with openat() and openat2(), which only
+ * names dirfd with O_EMPTYPATH (Linux 7.2), the way the kernel does.
  * SPDX-License-Identifier: LGPL-2.1-only
  */
 #define _GNU_SOURCE
@@ -10,8 +10,19 @@
 #include <stdio.h>
 #include <string.h>
 #include <sys/stat.h>
+#include <sys/syscall.h>
 #include <unistd.h>
=20
+#if __has_include (<linux/openat2.h>)
+# include <linux/openat2.h>
+#else
+struct open_how {
+	unsigned long long flags;
+	unsigned long long mode;
+	unsigned long long resolve;
+};
+#endif
+
 #ifndef O_EMPTYPATH
 #define O_EMPTYPATH (1 << 26)
 #endif
@@ -20,6 +31,13 @@ static int failed;
=20
 #define FAIL(...) do { printf(__VA_ARGS__); failed =3D 1; } while (0)
=20
+static int
+do_openat2(int dirfd, const char *path, unsigned long long flags) {
+	struct open_how how =3D { .flags =3D flags };
+
+	return syscall(SYS_openat2, dirfd, path, &how, sizeof(how));
+}
+
 /* fd should be dir, with pseudo knowing its path */
 static void
 check_reopened(const char *how, int fd) {
@@ -67,13 +85,21 @@ main(int argc, char *argv[]) {
 			fd, strerror(errno));
 	if (fd !=3D -1)
 		close(fd);
+	fd =3D do_openat2(dfd, "", O_RDONLY);
+	if (fd !=3D -1 || errno !=3D ENOENT)
+		FAIL("openat2 without O_EMPTYPATH: expected ENOENT, got %d (%s)\n",
+			fd, strerror(errno));
+	if (fd !=3D -1)
+		close(fd);
=20
 	check_reopened("openat", openat(pfd, "", O_RDONLY | O_DIRECTORY | O_EMPTY=
PATH));
+	check_reopened("openat2", do_openat2(pfd, "", O_RDONLY | O_DIRECTORY | O_=
EMPTYPATH));
 	if (fchdir(dfd) =3D=3D -1) {
 		perror("fchdir");
 		return 1;
 	}
 	check_reopened("openat AT_FDCWD", openat(AT_FDCWD, "", O_RDONLY | O_DIREC=
TORY | O_EMPTYPATH));
+	check_reopened("openat2 AT_FDCWD", do_openat2(AT_FDCWD, "", O_RDONLY | O_=
DIRECTORY | O_EMPTYPATH));
=20
 	return failed;
 }
--=20
2.34.1

