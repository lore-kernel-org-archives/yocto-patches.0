Received: from PH8PR06CU001.outbound.protection.outlook.com (PH8PR06CU001.outbound.protection.outlook.com [40.107.209.2])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15.1794524087263168300
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Nov 2026 14:54:47 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=Kpp4XsF2;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.209.2, mailfrom: mark.hatle@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYmlzl8Opc7kwe4tYq2sZWuq791hC1dDYnuvuQP2lk8FL7po6JOKWnHhjSBAGFvCMaC10qX3Lb0qyFD/uQhwWudi+GQUUOCZhuKly9sF9eLD+Y6/5emJA4DGjbJQ2C5IikQ3DaPrL1lxaP7rTVMFFGSvHc8Tqvf2ykiNPn+hlGsfSSwPq9Thw86zE+ERFClB7kAJ/2T2daH9Mguxzpy3ez4mVVb+vEL8BmM4ySIy9BTbPtMCdVEA+cDoq74xvRG+t9durPY0iMdPIBnC8xyZ4VQgNBP1ZEOpFtOzBTANtNvfV/G7z3xGnipNvTqpqDTSUA/bYKhWobRIds9UvHTepw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktuqdMWCbQmoWKsyp6SWg7CL/Fk63y9n5q9hrN0lLF4=;
 b=Msq5Q3YLPwWExv4GUAfhA6EYYe0ypqG+tYF9oNFITEk5aPSduDMUMvuicOPDObjpJkW+8UXXPmiz07uNQFOj0qpt/yjx90lgsMok0QY03DWWxv80r6xFBZYrW6CyaP4QjwlHUl0aOvau/EEc5mZEEp50s6DlLy2etwW2KACbcKKgZbwFT+tboaY3jLFAqlY5SWywcWsmm0J2PzwDtZx71/0MyYAFpvXY5GBx+cm3g+7MHYbRpEYxbrRsG96LWZKoLHmR1y1QEkM84cVg/Ncrf7+h8MJytTDY/1SyTa87nYJLhEYzUxgqllaTGH8Y+P215NEG3k+HM3yDvZVBBKnVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktuqdMWCbQmoWKsyp6SWg7CL/Fk63y9n5q9hrN0lLF4=;
 b=Kpp4XsF2rivJfMbVymFUedqvwnIVgfim22M9ykHkflLFbspbFd3mGVtjlhDFruKGc91PxJLCkZ3miDd/pxwmfzYLpEm+ktkVtmumEQefbUJhkgjFGZcSVoCKh0bh16w2sSiv+11aHcO1s7PgXGAFhB3nb2nsqYTnn+DkVx7xaoE=
Received: from BLAPR03CA0023.namprd03.prod.outlook.com (2603:10b6:208:32b::28)
 by CH3PR12MB9316.namprd12.prod.outlook.com (2603:10b6:610:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 22:51:31 +0000
Received: from CY8PEPF00000053.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::6d) by BLAPR03CA0023.outlook.office365.com
 (2603:10b6:208:32b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu,
 12 Nov 2026 22:51:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF00000053.mail.protection.outlook.com (10.167.247.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 22:50:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 12:47:10 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 12:47:10 -0600
Received: from xcolc230100.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 12:47:10 -0600
From: Mark Hatle <mark.hatle@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [pseudo][PATCH RFC 1/2] ports/linux: Pass an empty openat() path to the kernel
Date: Thu, 12 Nov 2026 11:47:09 -0700
Message-ID: <20261112184710.549482-2-mark.hatle@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261112184710.549482-1-mark.hatle@amd.com>
References: <20261112184710.549482-1-mark.hatle@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: mark.hatle@amd.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000053:EE_|CH3PR12MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6d262d-d8b9-4307-daea-08df410f6a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|18002099003|22082099003|6133799003|261009223027099003|11063799006|56012099006|261021135927099003|10067099003|261102123227099003|261022105027099003|261026121527099003|261022115727099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: IpoJf4siobdg91X9t75SFHkFbHZHXdzg9lRcfsKXee8mfI7DiwVlWOtxnow52CQ+GxZ9KpzgsVBqFisGJi46EI7h1NQbGzFeQPu5Q/wpUOTg4iVaV1IvyGKvvNlh7wHm7ZwsOcOMUtcqLipW/cJ4Z4cWRjt1sYJ/F1bissMEseYs+bKpyvpyu2sjI1u7FWfrznoboCsccp/RcTFDX/i1ALJJHIHezOdkD0wMlkljlg7hyHRZvjecdKR1G+E72B8IVTkSEGbpiYVNEPWYwhGEOm2hD0imkhoLUU0m2gMXu7onY/4Le7T8626EnLfPPkn0d3NZxgKFDGFZ1zgi20hj5xWZ4MRfcnYrvUhOkj4ehFsxAnmPEdq6GzbgOIiJGvemq97nB74Gbzr+l+8RGt38UpVIreYwEV8T8ipX0aPnj0ISU9pG3ESlWUCuXOKH4deVgYfrVOocHXm9jS2deGq926bTmAfomYeiEPr6gAjOijtGginikvCDvhqgn68TUGFsI0RdEsZdYZ4oCY8QGo6RJ9mCLJrcg6aZrujaAFaO9RTGvKot3FxKN78SvKuTDQJU3t3UuHqXnjNoI5ybWSoLAW8Wos89Gp2CkQW/ybCMFhWyxYJg3C0KY83BRx25x2rMfsS6Y6wpPF2H1ngVijdnrBGxpIghjjFGlQcicKvvV7BtQ4blsJ3W2pHApvlYHVAij+WC7mKJq5wfTNoNuTAHYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(261021135927099003)(10067099003)(261102123227099003)(261022105027099003)(261026121527099003)(261022115727099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lwxuu3EIQUXaV9PN00dt9g/me8jVMLnVfp8TZ5+UDaapYZf0A9t06/Qd/qKfJGSiuiLqmZa3Z4V35GcVpicEwUOsaHIoqoWs/nxDwRkslu98mSEoef6eng5pVuP120nHnTkfhtWak1VWX4VQvQcwi8KdyPzfLZlLX52IzNgNf+5lH9kuRDubLyx5feUjbrYkIW9avo1t+ZqwYCq8D3CUyfdn7L4hGId9yFf6QjVY5aivQDHUBlxrLzBtjQBU2cISu/o8uAo1uHXW8//ueQAUs7XuvE5hsMPeJwDZ+YIBgae2At4ltJFYhYOxXXj1uXtse2GS1P6dwyEEdobM0Jnsut/PDDf2WEvOCGkUbh7Yhlo/Cl1rRtghVxSjzwoXeVKVo/A0ELFk587GE8toGmKja35fo8FyrOroiBexA8NYPrnxrNrfjU9lh2EZ5/G8WmRg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 22:50:57.8234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6d262d-d8b9-4307-daea-08df410f6a9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF00000053.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9316
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 22:54:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5336
Content-Type: text/plain; charset="utf-8"

openat() wrappers resolved an empty path to dirfd's recorded path, so
openat(dirfd, "", ...) opened dirfd's path instead of failing with
ENOENT.

Linux 7.2 adds O_EMPTYPATH, with which an empty path reopens
dirfd itself, e.g. to turn an O_PATH descriptor into a usable one;
resolving it to a path opens the wrong file if dirfd's file was renamed
or removed.

Add a makewrappers option, keep_empty_path, to leave an empty path
unchanged, and use it for the openat() wrappers so the kernel decides
what an empty path means.  The guts look at dirfd with AT_EMPTY_PATH
and record dirfd's path for the new descriptor.

[YOCTO #16327]

Reported-by: Paul Barker <paul@pbarker.dev>
AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 makewrappers                  | 13 ++++--
 ports/linux/guts/openat.c     | 21 +++++++---
 ports/linux/wrapfuncs.in      |  8 ++--
 test/test-openat-emptypath.c  | 79 +++++++++++++++++++++++++++++++++++
 test/test-openat-emptypath.sh | 12 ++++++
 5 files changed, 121 insertions(+), 12 deletions(-)
 create mode 100644 test/test-openat-emptypath.c
 create mode 100755 test/test-openat-emptypath.sh

diff --git a/makewrappers b/makewrappers
index 303ae32..84dc563 100755
--- a/makewrappers
+++ b/makewrappers
@@ -262,6 +262,10 @@ class Function:
         # In those cases, use a suffix ('_int') for the path variable name=
s instead of
         # overwriting them. This means the wrapper needs to handle paths i=
tself.
         self.preserve_paths =3D False
+        # Leave an empty path unchanged instead of resolving it to dirfd's
+        # path, for functions where only a flag (e.g. O_EMPTYPATH) makes
+        # an empty path name dirfd.
+        self.keep_empty_path =3D False
    =20
         function, comments =3D line.split(';')
         comment =3D re.search(r'/\* *(.*) *\*/', comments)
@@ -427,9 +431,12 @@ class Function:
             if self.preserve_paths and self.noignore_path:
                 # path_int is only read by the ignore_paths() check
                 continue
-            fix_paths.append(
-                "%s =3D pseudo_root_path(__func__, __LINE__, %s%s, %s, %s)=
;" %
-                (pathvar, prefix, self.dirfd, path, self.flags))
+            munge =3D "%s =3D pseudo_root_path(__func__, __LINE__, %s%s, %=
s, %s);" % \
+                (pathvar, prefix, self.dirfd, path, self.flags)
+            if self.keep_empty_path:
+                # see above for the asm()
+                munge =3D "asm(\"\" : \"+r\"(%s));\n\t\tif (!%s || *%s)\n\=
t\t\t%s" % (path, path, path, munge)
+            fix_paths.append(munge)
         return "\n\t\t".join(fix_paths)
=20
     def ignore_paths(self):
diff --git a/ports/linux/guts/openat.c b/ports/linux/guts/openat.c
index 9d32283..e0075fe 100644
--- a/ports/linux/guts/openat.c
+++ b/ports/linux/guts/openat.c
@@ -13,6 +13,17 @@
 	int existed =3D 1;
 	int save_errno;
 	sigset_t local_saved_sigmask;
+	const char *record_path =3D path;
+	int stat_flags =3D (flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0;
+
+	/* An empty path is left for the kernel, which only accepts it with
+	 * O_EMPTYPATH, to reopen dirfd.  Look at and record dirfd instead.
+	 */
+	if (path && !*path) {
+		stat_flags |=3D AT_EMPTY_PATH;
+		record_path =3D pseudo_root_path(__func__, __LINE__, dirfd,
+			dirfd =3D=3D AT_FDCWD ? "." : "", 0);
+	}
=20
 	/* mask out mode bits appropriately */
 	mode =3D mode & ~pseudo_umask;
@@ -47,7 +58,7 @@
 	/* note "else" in #ifdef O_TMPFILE above */
 	if (flags & O_CREAT) {
 		save_errno =3D errno;
-		rc =3D base_fstatat(dirfd, path, &buf, (flags & O_NOFOLLOW) ? AT_SYMLINK=
_NOFOLLOW : 0);
+		rc =3D base_fstatat(dirfd, path, &buf, stat_flags);
 		existed =3D (rc !=3D -1);
 		if (!existed)
 			pseudo_debug(PDBGF_FILE, "openat_creat: %s -> 0%o\n", path, mode);
@@ -60,7 +71,7 @@
 	 */
 	if (!(flags & O_NONBLOCK) && ((flags & (O_WRONLY | O_RDONLY | O_RDWR)) !=
=3D O_RDWR)) {
 		save_errno =3D errno;
-		rc =3D base_fstatat(dirfd, path, &buf, (flags & O_NOFOLLOW) ? AT_SYMLINK=
_NOFOLLOW : 0);
+		rc =3D base_fstatat(dirfd, path, &buf, stat_flags);
 		if (rc !=3D -1 && S_ISFIFO(buf.st_mode)) {
 			overly_magic_nonblocking =3D 1;
 		}
@@ -105,7 +116,7 @@
 			return rc;
 		}
 #endif
-		stat_rc =3D base_fstatat(dirfd, path, &buf, (flags & O_NOFOLLOW) ? AT_SY=
MLINK_NOFOLLOW : 0);
+		stat_rc =3D base_fstatat(dirfd, path, &buf, stat_flags);
=20
 		pseudo_debug(PDBGF_FILE, "openat(path %s), flags %o, stat rc %d, stat mo=
de %o\n",
 			path, flags, stat_rc, buf.st_mode);
@@ -122,11 +133,11 @@
 				}
 				pseudo_client_path_unlock(path_lock_fd);
 			}
-				pseudo_client_op(OP_OPEN, PSEUDO_ACCESS(flags), rc, dirfd, path, &buf)=
;
+				pseudo_client_op(OP_OPEN, PSEUDO_ACCESS(flags), rc, dirfd, record_path=
, &buf);
 		} else {
 			pseudo_debug(PDBGF_FILE, "openat (fd %d, path %d/%s, flags %d) succeede=
d, but stat failed (%s).\n",
 				rc, dirfd, path, flags, strerror(errno));
-			pseudo_client_op(OP_OPEN, PSEUDO_ACCESS(flags), rc, dirfd, path, 0);
+			pseudo_client_op(OP_OPEN, PSEUDO_ACCESS(flags), rc, dirfd, record_path,=
 0);
 		}
 		errno =3D save_errno;
 	}
diff --git a/ports/linux/wrapfuncs.in b/ports/linux/wrapfuncs.in
index 1874b60..dbbf2f7 100644
--- a/ports/linux/wrapfuncs.in
+++ b/ports/linux/wrapfuncs.in
@@ -8,8 +8,8 @@ int __fxstat(int ver, int fd, struct stat *buf);
 int lchmod(const char *path, mode_t mode); /* flags=3DAT_SYMLINK_NOFOLLOW,=
 path_lock=3Dshared */
 int lchown(const char *path, uid_t owner, gid_t group); /* flags=3DAT_SYML=
INK_NOFOLLOW, path_lock=3Dshared */
 int __fxstatat(int ver, int dirfd, const char *path, struct stat *buf, int=
 flags); /* path_lock=3Dshared */
-int openat(int dirfd, const char *path, int flags, ...{mode_t mode}); /* f=
lags=3D((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))=3D=3D(O_CREAT|O_EXCL)=
)), noignore_path=3D1 */
-int __openat_2(int dirfd, const char *path, int flags); /* flags=3D((flags=
&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))=3D=3D(O_CREAT|O_EXCL))), noignore_p=
ath=3D1 */
+int openat(int dirfd, const char *path, int flags, ...{mode_t mode}); /* f=
lags=3D((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))=3D=3D(O_CREAT|O_EXCL)=
)), noignore_path=3D1, keep_empty_path=3D1 */
+int __openat_2(int dirfd, const char *path, int flags); /* flags=3D((flags=
&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))=3D=3D(O_CREAT|O_EXCL))), noignore_p=
ath=3D1, keep_empty_path=3D1 */
 int open_tree(int dirfd, const char *path, unsigned int flags); /* preserv=
e_paths=3D1, noignore_path=3D1 */
 int open_tree_attr(int dirfd, const char *path, unsigned int flags, struct=
 mount_attr *attr, size_t size); /* preserve_paths=3D1, noignore_path=3D1*/
 int name_to_handle_at(int dirfd, const char *name, struct file_handle *han=
dle, int *mount_id, int flags);
@@ -24,8 +24,8 @@ int fcntl64(int fd, int cmd, ...{struct flock *lock});  /=
* noignore_path=3D1 */
 char *canonicalize_file_name(const char *filename);
 int eaccess(const char *path, int mode);
 int open64(const char *path, int flags, ...{mode_t mode}); /* flags=3D((fl=
ags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))=3D=3D(O_CREAT|O_EXCL))), noignor=
e_path=3D1 */
-int openat64(int dirfd, const char *path, int flags, ...{mode_t mode}); /*=
 flags=3D((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))=3D=3D(O_CREAT|O_EXC=
L))), noignore_path=3D1 */
-int __openat64_2(int dirfd, const char *path, int flags); /* flags=3D((fla=
gs&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))=3D=3D(O_CREAT|O_EXCL))), noignore=
_path=3D1 */
+int openat64(int dirfd, const char *path, int flags, ...{mode_t mode}); /*=
 flags=3D((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))=3D=3D(O_CREAT|O_EXC=
L))), noignore_path=3D1, keep_empty_path=3D1 */
+int __openat64_2(int dirfd, const char *path, int flags); /* flags=3D((fla=
gs&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))=3D=3D(O_CREAT|O_EXCL))), noignore=
_path=3D1, keep_empty_path=3D1 */
 int creat64(const char *path, mode_t mode);
 int stat(const char *path, struct stat *buf); /* real_func=3Dpseudo_stat, =
path_lock=3Dshared */
 int lstat(const char *path, struct stat *buf); /* real_func=3Dpseudo_lstat=
, flags=3DAT_SYMLINK_NOFOLLOW, path_lock=3Dshared */
diff --git a/test/test-openat-emptypath.c b/test/test-openat-emptypath.c
new file mode 100644
index 0000000..076f1fd
--- /dev/null
+++ b/test/test-openat-emptypath.c
@@ -0,0 +1,79 @@
+/*
+ * Test opening an empty path, which only names dirfd with O_EMPTYPATH
+ * (Linux 7.2), the way the kernel does.
+ * SPDX-License-Identifier: LGPL-2.1-only
+ */
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#ifndef O_EMPTYPATH
+#define O_EMPTYPATH (1 << 26)
+#endif
+
+static int failed;
+
+#define FAIL(...) do { printf(__VA_ARGS__); failed =3D 1; } while (0)
+
+/* fd should be dir, with pseudo knowing its path */
+static void
+check_reopened(const char *how, int fd) {
+	struct stat st;
+
+	if (fd =3D=3D -1) {
+		if (errno =3D=3D ENOENT || errno =3D=3D EINVAL)
+			printf("%s: O_EMPTYPATH not supported by the kernel, skipping\n", how);
+		else
+			FAIL("%s: %s\n", how, strerror(errno));
+		return;
+	}
+	if (fstatat(fd, "file", &st, 0) =3D=3D -1)
+		FAIL("%s: fstatat: %s\n", how, strerror(errno));
+	else if (st.st_uid !=3D 123 || st.st_gid !=3D 456)
+		FAIL("%s: file owned by %d:%d, expected 123:456\n",
+			how, (int) st.st_uid, (int) st.st_gid);
+	close(fd);
+}
+
+int
+main(int argc, char *argv[]) {
+	char path[4096];
+	int dfd, pfd, fd;
+
+	if (argc !=3D 2) {
+		fprintf(stderr, "usage: %s <dir>\n", argv[0]);
+		return 2;
+	}
+	snprintf(path, sizeof(path), "%s/file", argv[1]);
+	if (chown(path, 123, 456) =3D=3D -1) {
+		perror("chown");
+		return 1;
+	}
+	dfd =3D open(argv[1], O_RDONLY | O_DIRECTORY);
+	pfd =3D open(argv[1], O_PATH | O_DIRECTORY);
+	if (dfd =3D=3D -1 || pfd =3D=3D -1) {
+		perror("open");
+		return 1;
+	}
+
+	fd =3D openat(dfd, "", O_RDONLY);
+	if (fd !=3D -1 || errno !=3D ENOENT)
+		FAIL("openat without O_EMPTYPATH: expected ENOENT, got %d (%s)\n",
+			fd, strerror(errno));
+	if (fd !=3D -1)
+		close(fd);
+
+	check_reopened("openat", openat(pfd, "", O_RDONLY | O_DIRECTORY | O_EMPTY=
PATH));
+	if (fchdir(dfd) =3D=3D -1) {
+		perror("fchdir");
+		return 1;
+	}
+	check_reopened("openat AT_FDCWD", openat(AT_FDCWD, "", O_RDONLY | O_DIREC=
TORY | O_EMPTYPATH));
+
+	return failed;
+}
diff --git a/test/test-openat-emptypath.sh b/test/test-openat-emptypath.sh
new file mode 100755
index 0000000..ead5191
--- /dev/null
+++ b/test/test-openat-emptypath.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+#
+# Test opening an empty path, with and without O_EMPTYPATH.
+# SPDX-License-Identifier: LGPL-2.1-only
+
+dir=3D$(pwd)/openat_emptypath_test
+trap 'rm -rf "$dir"' 0
+rm -rf "$dir"
+mkdir -p "$dir"
+touch "$dir/file"
+
+./test/test-openat-emptypath "$dir"
--=20
2.34.1

