Received: from PH0PR06CU001.outbound.protection.outlook.com (PH0PR06CU001.outbound.protection.outlook.com [40.107.208.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.596.1794855781515395947
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 11:03:01 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=PVxzKOdU;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.208.4, mailfrom: mark.hatle@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMfOdN5y93G4j9RqLxp0kiOkYCfZT8zg/5Xq5e/N4A2qQyL3Ik0uAuDXt0jPZf4wBRIRwT342tfOTgK+zlY8t/o9GdflAjcOdfcU7/SMn8R8FVqeNLAnyQ4NhDORh1SW+E2xN472N4WKZ0LtnxAIziDmR/mFQh1wTFQmtSpCjdMmUTdlVWdMruEup1CgKssshHMf9K/+E0bTx+sgG4tidO+rmjzbb7nuGCWE65j097Z31MQW+aDTcfvLLGU6KiZ93MoXOYh9SiAojS0GGyl6AQb22bic3C7UCmF2jr9709z6tC26r2+pRgbMDB74OqUCDykfabtm47xj3BrRMhPOxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMi/6BGJzHRsvELtf9QJaFm71hO3zT8eUdR2kQ4tNt4=;
 b=D+gF9dom1JSgW78IJDSoUZCLvzwFHC6ECR9wXlqoQyc5SqrB8V1JKCf3u/yXfq34+qdMN4+iQELP2LVJxv2i8AIUe5/U1Ub9kd5ic20tsHeZ1Wbc7JicUFglfvbI9j+OWnqVrHnTeF7hSt1fkysCTqQ3ObCtDfJM+ti/29TiTnIuGJ3mcSgJrlpGiSga26a27nv/OOh6gFwj+C4a+q6GYAdED/OcXTYI94U7DY/bw6IehTvjuQzjEI9MDXb3t4QYVChpbfOXmgynAlNzM6WVu9MLI30j6tDvwgWeTD6pOwrr6zwXfuqm1uCrLk90xZTTEE/dxhhudAM8Yul14vqzKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMi/6BGJzHRsvELtf9QJaFm71hO3zT8eUdR2kQ4tNt4=;
 b=PVxzKOdUBzhGQNENqLvzAUtI2PKVEEMfgGhgQMJVwy35qfFkoh2YhTL15/ka7tKzBOIKzVc9T5yBBU/wlSeRhzIJBwG2GYV2xvzFCYr774vBuFNhUsN+g29xCDt1IPac1rzkB6RkTo41+29CKk5JSjSp4WdqcOFiN37Zs16ljuk=
Received: from BY1P220CA0042.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::17)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Mon, 16 Nov
 2026 19:02:48 +0000
Received: from CO1PEPF00018869.namprd03.prod.outlook.com
 (2603:10b6:a03:59e:cafe::55) by BY1P220CA0042.outlook.office365.com
 (2603:10b6:a03:59e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Mon,
 16 Nov 2026 19:02:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00018869.mail.protection.outlook.com (10.167.249.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 19:02:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 13:02:44 -0600
Received: from xcolc230100.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 16 Nov 2026 13:02:44 -0600
From: Mark Hatle <mark.hatle@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [pseudo][PATCH 1/2] ports/linux: Report SELinux as disabled under pseudo
Date: Mon, 16 Nov 2026 12:02:43 -0700
Message-ID: <20261116190244.2205781-2-mark.hatle@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261116190244.2205781-1-mark.hatle@amd.com>
References: <20261116190244.2205781-1-mark.hatle@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: mark.hatle@amd.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018869:EE_|MN0PR12MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: df7bbb04-e28a-46bd-573a-08df441432d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261022115727099003|261022075727099003|261022105027099003|261102123227099003|56012099006|11063799006|10067099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: qtaUSfTqws2JDlOTAdZ80DetvzuORLeJWe2M2Qp4+DxKDDhpfkFFERSFOxq9yIxvBs4SOzY9TrYuCwCaXb9+5sbLJ2RTHId0Tb24NsZol/2vAqPSeqGZEDuieHjfK/NoFgwxCXyyH/mYpnbobQaEkB/uGiEj0zLuJTJ+qbzftP20cMiqSyqXzl71FmVfpukoip0N/AT6cNLOS7hRZohkH2HqKrDMJvx2MK4ggt04iRbCo1msr8xczuOcwZLUy9vtOJdrMVEOtZM/R496bpYDivuC4PPZgcjaOUzO36E90JrQ6TLC5rn1T8qLQ2BWcjEq7WWTPU581EfDXZ0r7cwW8Fz5ZMKj4mdNCaYEChiH9vtEmTR0l2z9fDgfnUN7hHJVbOtYN43n9ofDfZdJ4TP/ziLpxGan07A3i2IoI0VwDyTVhWIYo0477STR8utXAIXY0ZMUrrGXAWvi9elkVKbwfmWJXQuyNeHOOFPkj0qxtnq+XeW//2ID3t+kuOfXyjYJVAV1RNwTHOKxu1a2wSW80J3o3tNY3EoaOs9GFVY8AeBZN4lCxyMqmyCXVdxeHx4IgU55KPU04xyEIcwo19yfKKENm+5ozWf7liW3WIAfxfS0u81PEj8KHfF1tGZc/vesB7kZgGekXBz04L9WBpB2eYp8UQd2+iLjFlA2dturfmPkwdsH9SzEohaM1GaPem19Y/GLjHhTnTpuotHBcDrfxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022115727099003)(261022075727099003)(261022105027099003)(261102123227099003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MCmbBAvdyg54dvC0mtyal1WBvcOE8D9stLBcvNahOKJmi1FVrTV0IO/oy6ucAzjIheGsAfZQLhVvKw7ydxq42kQRPEspSPTvm9vIriz1LiMmH+wM4JvwBTl9vNHOwQfwGjCXfHJj0Oj8l04yr/HGpDBU3eylsdOxML9jy7E+36RE0Mi2MgbIRKS8z+xduxaf0OAUwR5AHp2+H2aaEPTYuuBbD6yiMFcHmny60naQpnHS4mVOyQeO0VM5ZfI5oBY2GVlS8xlpzCsgqcbx9Hoyc8OQgyWjMxyJokmXxgBV4A4xP0R88akjI91UjY1orlpr7BSlqtZ9LoBd3+lrmWyv9fg+8on44StfFmgOwyg0XCYJnNJQ+DRKjCG5NH4I4nduepkaimmj73Cj8RJjAr2v+xjv3SuiISm1a4T0jfuv3xAOBsy5ui42OwlL/MKqA9JY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 19:02:45.1455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df7bbb04-e28a-46bd-573a-08df441432d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00018869.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 19:03:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5416
Content-Type: text/plain; charset="utf-8"

SELinux-aware programs such as install label the files they create from
the host's policy.  pseudo only records the label, which is wrong for
target files and lets the host's policy leak into the build.  Programs
which then pass a recorded label to the kernel through
/proc/self/attr/fscreate, as sed -i does, can be refused when the build
runs in a confined SELinux domain, and fail.

Wrap is_selinux_enabled() and is_selinux_mls_enabled() to report SELinux
as disabled, so these programs behave as on a host without SELinux.
Labels set explicitly, e.g. by setfiles when labelling an image, are
still recorded.  The host's answer is only given while pseudo is
disabled; libselinux may not be loaded then, so it is looked up when
needed, and SELinux is reported as disabled without it.

test-selinux-disabled checks both answers with the host's libselinux,
and with a stand-in reporting SELinux as enabled, to emulate a host
where it is.  It is skipped if the host has no libselinux.

Based on a patch by Enrico Scholz attached to the bug.

[YOCTO #6580]

Reported-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 .gitignore                                |  1 +
 Makefile.in                               | 10 ++++-
 ports/linux/guts/is_selinux_enabled.c     | 24 +++++++++++
 ports/linux/guts/is_selinux_mls_enabled.c | 16 ++++++++
 ports/linux/pseudo_wrappers.c             | 23 +++++++++++
 ports/linux/wrapfuncs.in                  |  2 +
 test/fake-selinux.c                       | 15 +++++++
 test/test-selinux-disabled.c              | 49 +++++++++++++++++++++++
 test/test-selinux-disabled.sh             | 20 +++++++++
 9 files changed, 159 insertions(+), 1 deletion(-)
 create mode 100644 ports/linux/guts/is_selinux_enabled.c
 create mode 100644 ports/linux/guts/is_selinux_mls_enabled.c
 create mode 100644 test/fake-selinux.c
 create mode 100644 test/test-selinux-disabled.c
 create mode 100755 test/test-selinux-disabled.sh

diff --git a/.gitignore b/.gitignore
index bc4cbe8..79c0328 100644
--- a/.gitignore
+++ b/.gitignore
@@ -17,3 +17,4 @@ func_deps.mk
 port_deps.mk
 test/test-*
 !test/test-*.*
+test/*.so
diff --git a/Makefile.in b/Makefile.in
index 4c873d6..38ec23f 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -84,6 +84,14 @@ test-verbose: all $(TESTS) | $(BIN) $(LIB)
 test/test-%: test/test-%.c
 	$(CC) $(CFLAGS) $(CFLAGS_PSEUDO) -o $@ $<
=20
+# test-selinux-disabled loads libselinux, or a stand-in reporting SELinux =
as
+# enabled, at run time.
+test/libfake-selinux.so: test/fake-selinux.c
+	$(CC) $(CFLAGS) $(CFLAGS_PSEUDO) -shared -o $@ $<
+
+test/test-selinux-disabled: test/test-selinux-disabled.c test/libfake-seli=
nux.so
+	$(CC) $(CFLAGS) $(CFLAGS_PSEUDO) -o $@ $< -ldl
+
 install-lib: $(LIBPSEUDO)
 	mkdir -p $(DESTDIR)$(LIBDIR)
 	cp $(LIBPSEUDO) $(DESTDIR)$(LIBDIR)
@@ -176,7 +184,7 @@ pseudo_profile: Makefile pseudo_profile.c tables wrappe=
rs
=20
 clean:
 	rm -f *.o $(LIBPSEUDO) $(PSEUDO) $(PSEUDODB) $(PSEUDOLOG) \
-		$(TESTS) \
+		$(TESTS) test/libfake-selinux.so \
 		pseudo_wrapfuncs.h pseudo_wrapfuncs.c \
 		pseudo_wrapper_table.c \
 		pseudo_tables.c pseudo_tables.h \
diff --git a/ports/linux/guts/is_selinux_enabled.c b/ports/linux/guts/is_se=
linux_enabled.c
new file mode 100644
index 0000000..de96da2
--- /dev/null
+++ b/ports/linux/guts/is_selinux_enabled.c
@@ -0,0 +1,24 @@
+/*
+ * Copyright (c) 2026 Yocto Project
+ * guts/COPYRIGHT for information.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * int is_selinux_enabled(void)
+ *	int rc =3D -1;
+ */
+
+	/* SELinux-aware programs label the files they create or install
+	 * using the host's policy.  pseudo only records the label, which is
+	 * wrong for target files and leaks the host policy into the build,
+	 * and programs which then hand it back to the kernel, e.g. through
+	 * /proc/self/attr/fscreate, can be refused (YOCTO #6580).  So report
+	 * SELinux as disabled, as on a host without it.  Labels set
+	 * explicitly, e.g. by setfiles, are still recorded.  The host's
+	 * answer is only given while pseudo is disabled.
+	 */
+	rc =3D 0;
+
+/*	return rc;
+ * }
+ */
diff --git a/ports/linux/guts/is_selinux_mls_enabled.c b/ports/linux/guts/i=
s_selinux_mls_enabled.c
new file mode 100644
index 0000000..fff934f
--- /dev/null
+++ b/ports/linux/guts/is_selinux_mls_enabled.c
@@ -0,0 +1,16 @@
+/*
+ * Copyright (c) 2026 Yocto Project
+ * guts/COPYRIGHT for information.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * int is_selinux_mls_enabled(void)
+ *	int rc =3D -1;
+ */
+
+	/* see is_selinux_enabled() */
+	rc =3D 0;
+
+/*	return rc;
+ * }
+ */
diff --git a/ports/linux/pseudo_wrappers.c b/ports/linux/pseudo_wrappers.c
index bba1577..ebf73b3 100644
--- a/ports/linux/pseudo_wrappers.c
+++ b/ports/linux/pseudo_wrappers.c
@@ -47,6 +47,29 @@ pseudo_mknodat(int dirfd, const char *path, mode_t mode,=
 dev_t dev) {
 	return real___xmknodat(_MKNOD_VER, dirfd, path, mode, &dev);
 }
=20
+/* The host's is_selinux_enabled() and is_selinux_mls_enabled(), used only
+ * while pseudo is disabled.  They are in libselinux, which may not be loa=
ded
+ * when the wrappers are set up, or at all, so look them up when they are
+ * needed.  Without libselinux, SELinux isn't in use.
+ */
+int
+pseudo_is_selinux_enabled(void) {
+	static int (*f)(void) =3D NULL;
+
+	if (!f)
+		f =3D (int (*)(void)) dlsym(RTLD_NEXT, "is_selinux_enabled");
+	return f ? f() : 0;
+}
+
+int
+pseudo_is_selinux_mls_enabled(void) {
+	static int (*f)(void) =3D NULL;
+
+	if (!f)
+		f =3D (int (*)(void)) dlsym(RTLD_NEXT, "is_selinux_mls_enabled");
+	return f ? f() : 0;
+}
+
 int pseudo_capset(cap_user_header_t hdrp, const cap_user_data_t datap) {
 	(void)hdrp;
 	(void)datap;
diff --git a/ports/linux/wrapfuncs.in b/ports/linux/wrapfuncs.in
index dbbf2f7..9f1e013 100644
--- a/ports/linux/wrapfuncs.in
+++ b/ports/linux/wrapfuncs.in
@@ -14,6 +14,8 @@ int open_tree(int dirfd, const char *path, unsigned int f=
lags); /* preserve_path
 int open_tree_attr(int dirfd, const char *path, unsigned int flags, struct=
 mount_attr *attr, size_t size); /* preserve_paths=3D1, noignore_path=3D1*/
 int name_to_handle_at(int dirfd, const char *name, struct file_handle *han=
dle, int *mount_id, int flags);
 int open_by_handle_at(int mount_fd, struct file_handle *handle, int flags)=
;
+int is_selinux_enabled(void); /* real_func=3Dpseudo_is_selinux_enabled */
+int is_selinux_mls_enabled(void); /* real_func=3Dpseudo_is_selinux_mls_ena=
bled */
 int mknod(const char *path, mode_t mode, dev_t dev); /* real_func=3Dpseudo=
_mknod, path_lock=3D1 */
 int mknodat(int dirfd, const char *path, mode_t mode, dev_t dev); /* real_=
func=3Dpseudo_mknodat, path_lock=3D1 */
 int __xmknod(int ver, const char *path, mode_t mode, dev_t *dev); /* flags=
=3DAT_SYMLINK_NOFOLLOW, path_lock=3D1 */
diff --git a/test/fake-selinux.c b/test/fake-selinux.c
new file mode 100644
index 0000000..8f3253d
--- /dev/null
+++ b/test/fake-selinux.c
@@ -0,0 +1,15 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * A stand-in for libselinux which reports SELinux as enabled, so that
+ * test-selinux-disabled can emulate a host where it is.
+ */
+int
+is_selinux_enabled(void) {
+	return 1;
+}
+
+int
+is_selinux_mls_enabled(void) {
+	return 1;
+}
diff --git a/test/test-selinux-disabled.c b/test/test-selinux-disabled.c
new file mode 100644
index 0000000..b8486ca
--- /dev/null
+++ b/test/test-selinux-disabled.c
@@ -0,0 +1,49 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * Under pseudo, SELinux-aware programs are told SELinux is disabled
+ * (YOCTO #6580), and only get the host's answer while pseudo is disabled.
+ *
+ * Usage: test-selinux-disabled <libselinux> <expected>|print
+ *
+ * Loads <libselinux> the way a program using it would, then calls
+ * is_selinux_enabled() and is_selinux_mls_enabled() through the normal
+ * symbol lookup, so pseudo's wrappers are used when pseudo is loaded.  Th=
e
+ * answers are compared with <expected>, given as "enabled,mls", or printe=
d.
+ * Returns 77 if <libselinux> can't be loaded.
+ */
+#define _GNU_SOURCE
+#include <dlfcn.h>
+#include <stdio.h>
+#include <string.h>
+
+int
+main(int argc, char *argv[]) {
+	int (*enabled)(void), (*mls)(void);
+	char result[32];
+
+	if (argc !=3D 3) {
+		fprintf(stderr, "usage: %s <libselinux> <expected>|print\n", argv[0]);
+		return 2;
+	}
+	if (!dlopen(argv[1], RTLD_NOW | RTLD_GLOBAL)) {
+		printf("can't load %s, skipping\n", argv[1]);
+		return 77;
+	}
+	enabled =3D (int (*)(void)) dlsym(RTLD_DEFAULT, "is_selinux_enabled");
+	mls =3D (int (*)(void)) dlsym(RTLD_DEFAULT, "is_selinux_mls_enabled");
+	if (!enabled || !mls) {
+		printf("%s doesn't provide is_selinux_enabled()\n", argv[1]);
+		return 1;
+	}
+	snprintf(result, sizeof(result), "%d,%d", enabled(), mls());
+	if (!strcmp(argv[2], "print")) {
+		printf("%s\n", result);
+		return 0;
+	}
+	if (strcmp(result, argv[2])) {
+		printf("%s: got %s, expected %s\n", argv[1], result, argv[2]);
+		return 1;
+	}
+	return 0;
+}
diff --git a/test/test-selinux-disabled.sh b/test/test-selinux-disabled.sh
new file mode 100755
index 0000000..fdace34
--- /dev/null
+++ b/test/test-selinux-disabled.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+#
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+# SELinux is reported as disabled under pseudo, and the host's answer is
+# given while PSEUDO_DISABLED is set.  Skipped without libselinux.
+
+t=3D./test/test-selinux-disabled
+lib=3Dlibselinux.so.1
+
+# The host's libselinux: pseudo reports SELinux as disabled, and with
+# PSEUDO_DISABLED gives the same answer as without pseudo at all.
+$t $lib 0,0
+case $? in 0) ;; 77) exit 255 ;; *) exit 1 ;; esac
+host=3D$(PSEUDO_UNLOAD=3D1 $t $lib print) || exit 1
+PSEUDO_DISABLED=3D1 $t $lib "$host" || exit 1
+
+# Emulate a host with SELinux enabled, whatever this one does.
+$t ./test/libfake-selinux.so 0,0 || exit 1
+PSEUDO_DISABLED=3D1 $t ./test/libfake-selinux.so 1,1 || exit 1
--=20
2.34.1

