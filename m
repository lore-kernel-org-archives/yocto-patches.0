Received: from CO1PR03CU002.outbound.protection.outlook.com (CO1PR03CU002.outbound.protection.outlook.com [52.101.46.69])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2482.1794506074275168396
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Nov 2026 09:54:34 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=wtnXpRVx;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.46.69, mailfrom: mark.hatle@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sliUkWGKW1EqahCeoOBLpeNMdORDdHxKgXcCUNu1+eUtLO3i1Lr5UF6CPRS/eBwggO+z1yjeDGntxoIC5ELH44tfnhrB3NTvUSXtW/GedcV8nUw9mi/Gmi6vR9yD1phhVx1nVdfXiQhwcwWK5VEh1TMH/Bxwfq4zEHMGOYAxgZHdZ2kRH2hT8n1rqgJYnw42SUwLec27XzmouBlrnYN1Y8QPboz+dEtfgeh9vQ8eSykXyIDFp86pYwr9ittU8r+FABnprsbjOmLFci2MHeG0VHHtZ5X9eJPLK5l5w1qewwwvp0FMUF1Tdu3HpejnvcCMm18H9D3cprSiip9rfFY63g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feksLbEKXp5la2jMVTgDzYOm6iqqNmDZGWh/dt3Px2s=;
 b=uV/oX8iaaMqBjhm8yiDn3WfTdazH2EpRocCBfDQJDiOg5igivFAOncDAthTNiZTlG0s3L4OWNN/XtecVPF5A2AWFAOMzuTjevty87KX42dlciTfhbbsVSQyfd3aBru+TJsH7tHB5mh38zpeaH16Q/BP0j0wO18fSlhIgMOm6vpBKP8qUSIpdI7FleuT/UGnDxsw8f4ZmALhrNlFkNpIOUOXK+V5aLHE8MAanbfBlqC3+jkcyid0QVER54/FHZMJjb2TCQh63c65ZkHDQDM9v71ai5Giq0Ed9SohHBEKmwlHTXfrlul42pBBXH/tnL5m6eicDEZI7cS3ldk180T3zKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feksLbEKXp5la2jMVTgDzYOm6iqqNmDZGWh/dt3Px2s=;
 b=wtnXpRVxJy0hpPQcA5qGu7srd+htT5I+yZHb+Eh7eQ5ymYL2dIvvkAw+/VdQ+c9S2oLjWc71Ld3SfWpi3VvcMxJ7gIZH3kts5yflueKm2jg/TunFDqJ5ONelBtzQKX3EX2Lt1QK4zM5M3X2CqqaY/xwAJEKLL6MXyBvg+mgfgOs=
Received: from CYZPR19CA0023.namprd19.prod.outlook.com (2603:10b6:930:8e::29)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 17:53:06 +0000
Received: from MW3PEPF00001655.namprd21.prod.outlook.com
 (2603:10b6:930:8e:cafe::26) by CYZPR19CA0023.outlook.office365.com
 (2603:10b6:930:8e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 17:53:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW3PEPF00001655.mail.protection.outlook.com (10.167.249.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Thu, 12 Nov 2026 17:53:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 11:52:34 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 11:52:34 -0600
Received: from xcolc230100.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 11:52:34 -0600
From: Mark Hatle <mark.hatle@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [pseudo][PATCH RFC] ports/linux: Wrap name_to_handle_at() and open_by_handle_at()
Date: Thu, 12 Nov 2026 10:52:34 -0700
Message-ID: <20261112175234.523998-1-mark.hatle@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: mark.hatle@amd.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PEPF00001655:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: b1ebfdd7-9c5a-49b4-a5f7-08df40e5cdfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|18002099003|261009223027099003|11063799006|56012099006|10067099003|261102130727099003|261102123227099003|261028144727099003|261022105027099003|261022075727099003|261026140227099003|261026121527099003|261021135927099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 7L2HZqt9WwAPMh8cexYqcwKgsvoR5yBQm4zpSOjfl+FYuJpLubU+a+p8iFnBVE4N++/ejJrcXfmz31T6Jus+Zy25UNSImI0mtApEhNvMjIZcEvgcFKS4LQcqbjxsiAUE1WnKPXt99R+jgnDloiCZZuhVbgOVDUWg9qZbwwrZSwDvKuy+zFaH8ycBkJh55d6h6cfhSEn3w+HyBbhmvZ1X9HrIZnEoGu+MHoyYNjPZE3n76iutjpo3Yo/Us3Brkl78ZVUggum0zUZ6uBo2Vb6/IVcenQ2wQqQfLYx9TCIYGtjmDw9Gtr+LyJnUdnKM1TNa/bXrVFyOIaV9+sXf2BrpAPzy6peysw3V/L0quv07avmCoruMeT8sbvFvUV8HwBIdzbAw81gJ57Qa8BH0Dx2EDZtHczLzWshiOwepAMyBu80yth3zbnboS9T6Dd42MIjEjAQENvcVKpEUqTCbsrZhV7n2zo+fUokxxDJ2M9s8L6cXTPjbcbktEENOiF+y9/5JecbsYFac5RJkoomecy+rJOPfynAeTkEE3BBAOlcAjyOyZ2yey2sTdmscQG03i4wKFbNA+g0p8A6h+OdlMnOpO2hvHQRQreTvaV1qV1Ec2k5TMaeEywfPLQ9SsC3/tVOMKAWHQfNvcdexSMU1cgl1V/vkbNPZJaJK0KoXvgZXhAYGaYGHmjI61OfrTEzWywT/z3EuBc7YNMFJUdXDTpnrFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102130727099003)(261102123227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261021135927099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iaFHRZboN67K81QPTLb9CbgVP/kcUsT9cYEFJjbR9qRdE9pjqIBy8dll7buKXyFK+k71LJ7pa+c8t1hPK9ok8x10c2NSDTefLPP49cqrZPkgQ70TYH8ixsi0wdTGp/jiPve9sZdlvl/hpVNc7lWkn2bbq95CSR0Ayy5rcDOaRoubaOOwzjKAjH2jGK4M+MRxADD0ZUw4jJAMIMjnCa99EWllyRb/PhgCF4WWNPDD9rXjsFxjdW6yvvtw7p/vlrXJOw6Ko5QnpKIQOOG7zlby8CuI0qtrme0EqZeuvrYj8THWTCA6e3fpngKrHZs2ZJ3/z3FDxM9sxBRGHomE3Mm/jJxGcqzucht7eGSvy88Y+Qmlcs9GVqyDxKXU+BvA5mGvO3pyq9Ry1JqJtvJ3RG+wG/Aj3wAqT2fujATBoPKiJPszkW4nIddR5pOneZTdvZ9U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 17:53:05.6277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ebfdd7-9c5a-49b4-a5f7-08df40e5cdfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW3PEPF00001655.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 17:54:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5333
Content-Type: text/plain; charset="utf-8"

open_by_handle_at() was not wrapped, so pseudo never learned the path of
the descriptor it returns, and *at() calls relative to it failed.  It
also needs CAP_DAC_READ_SEARCH, so under pseudo it failed with EPERM
anyway.

Always emulate it: check the arguments as the kernel does, then search
below mount_fd with nftw() for a file that name_to_handle_at(), which
needs no privilege, encodes to the same handle, and open it.  A symlink
is only opened with O_PATH, and a handle that isn't found gives ESTALE,
as with the kernel.  The descriptor's path is then recorded.

name_to_handle_at() is wrapped to resolve its path like other wrappers,
so it works in a chroot.  It only follows a final symlink with
AT_SYMLINK_FOLLOW.  Both are also handled when called through syscall().

[YOCTO #16380]

Reported-by: Richard Purdie <richard.purdie@linuxfoundation.org>
AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
This is sent as an RFC for review.  I don't understand this workflow
enough to know what the LLM helped me implement is actualy correct or
not.  I do know it matches the behavior and man pages as I understand
them, but I don't know of any real-world test cases I can use to verify
the behavior.

Any comments would be appreciated!

 ports/linux/guts/name_to_handle_at.c |  32 +++++
 ports/linux/guts/open_by_handle_at.c |  59 +++++++++
 ports/linux/pseudo_wrappers.c        | 145 ++++++++++++++++++++++
 ports/linux/wrapfuncs.in             |   2 +
 test/test-name_to_handle_at.c        | 107 ++++++++++++++++
 test/test-name_to_handle_at.sh       |  21 ++++
 test/test-open_by_handle_at.c        | 174 +++++++++++++++++++++++++++
 test/test-open_by_handle_at.sh       |  22 ++++
 8 files changed, 562 insertions(+)
 create mode 100644 ports/linux/guts/name_to_handle_at.c
 create mode 100644 ports/linux/guts/open_by_handle_at.c
 create mode 100644 test/test-name_to_handle_at.c
 create mode 100755 test/test-name_to_handle_at.sh
 create mode 100644 test/test-open_by_handle_at.c
 create mode 100755 test/test-open_by_handle_at.sh

diff --git a/ports/linux/guts/name_to_handle_at.c b/ports/linux/guts/name_t=
o_handle_at.c
new file mode 100644
index 0000000..1d600ff
--- /dev/null
+++ b/ports/linux/guts/name_to_handle_at.c
@@ -0,0 +1,32 @@
+/*
+ * Copyright (c) 2026 Yocto Project
+ * guts/COPYRIGHT for information.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * int name_to_handle_at(int dirfd, const char *name, struct file_handle *=
handle, int *mount_id, int flags)
+ *	int rc =3D -1;
+ */
+
+	const char *path;
+
+	/* Encoding a handle needs no privilege, so the real call does it;
+	 * pseudo only has to resolve the path (chroot, dirfd).  Real handles
+	 * also let open_by_handle_at() find the file by encoding candidates
+	 * and comparing.
+	 *
+	 * name isn't canonicalized by the wrapper, as name_to_handle_at()
+	 * only follows a final symlink with AT_SYMLINK_FOLLOW, and rejects
+	 * the AT_SYMLINK_NOFOLLOW the generated code adds for an empty path.
+	 */
+	if (name && !*name && (flags & AT_EMPTY_PATH)) {
+		rc =3D real_name_to_handle_at(dirfd, name, handle, mount_id, flags);
+	} else {
+		path =3D pseudo_root_path(__func__, __LINE__, dirfd, name,
+			(flags & AT_SYMLINK_FOLLOW) ? 0 : AT_SYMLINK_NOFOLLOW);
+		rc =3D real_name_to_handle_at(AT_FDCWD, path, handle, mount_id, flags);
+	}
+
+/*	return rc;
+ * }
+ */
diff --git a/ports/linux/guts/open_by_handle_at.c b/ports/linux/guts/open_b=
y_handle_at.c
new file mode 100644
index 0000000..08b77fa
--- /dev/null
+++ b/ports/linux/guts/open_by_handle_at.c
@@ -0,0 +1,59 @@
+/*
+ * Copyright (c) 2026 Yocto Project
+ * guts/COPYRIGHT for information.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * int open_by_handle_at(int mount_fd, struct file_handle *handle, int fla=
gs)
+ *	int rc =3D -1;
+ */
+
+	PSEUDO_STATBUF buf;
+	char procpath[32];
+	char *path;
+	ssize_t len;
+	int save_errno;
+
+	/* always emulated, as decoding a handle needs privilege */
+	rc =3D pseudo_open_by_handle(mount_fd, handle, flags);
+	if (rc =3D=3D -1)
+		return rc;
+	save_errno =3D errno;
+
+	/* A handle names an inode, not a path.  Record the path the kernel
+	 * reports for the descriptor, if it still names the same file, so
+	 * that calls using the descriptor, including *at() calls relative
+	 * to it, can be resolved.
+	 */
+	snprintf(procpath, sizeof(procpath), "/proc/self/fd/%d", rc);
+	path =3D malloc(pseudo_path_max());
+	if (path) {
+		len =3D real_readlink(procpath, path, pseudo_path_max() - 1);
+		if (len > 0 && path[0] =3D=3D '/') {
+			path[len] =3D '\0';
+			if (!pseudo_client_path_matches_fd(path, rc, 1)) {
+				free(path);
+				path =3D NULL;
+			}
+		} else {
+			free(path);
+			path =3D NULL;
+		}
+	}
+
+	if (path) {
+		if (base_fstat(rc, &buf) !=3D -1)
+			pseudo_client_op(OP_OPEN, 0, rc, -1, path, &buf);
+		else
+			pseudo_client_op(OP_OPEN, 0, rc, -1, path, 0);
+		free(path);
+	} else {
+		pseudo_debug(PDBGF_FILE, "open_by_handle_at: no path for fd %d\n", rc);
+		/* drop any path left over from a close pseudo didn't see */
+		pseudo_client_op(OP_CLOSE, 0, rc, -1, 0, 0);
+	}
+	errno =3D save_errno;
+
+/*	return rc;
+ * }
+ */
diff --git a/ports/linux/pseudo_wrappers.c b/ports/linux/pseudo_wrappers.c
index e8a2780..a573abb 100644
--- a/ports/linux/pseudo_wrappers.c
+++ b/ports/linux/pseudo_wrappers.c
@@ -54,6 +54,121 @@ int pseudo_capset(cap_user_header_t hdrp, const cap_use=
r_data_t datap) {
 	return 0;
 }
=20
+/* open_by_handle_at() emulation.
+ *
+ * The kernel only decodes a file handle for a caller with
+ * CAP_DAC_READ_SEARCH, which a pseudo "root" doesn't have, so search
+ * below mount_fd for the file instead.  name_to_handle_at() needs no
+ * privilege, so a file matches if it encodes to the same handle.
+ */
+/* include/linux/exportfs.h */
+#define PSEUDO_FILEID_USER_FLAGS 0xffff0000U
+#define PSEUDO_FILEID_IS_CONNECTABLE 0x10000
+#define PSEUDO_FILEID_IS_DIR 0x20000
+#define PSEUDO_FILEID_VALID_USER_FLAGS (PSEUDO_FILEID_IS_CONNECTABLE | PSE=
UDO_FILEID_IS_DIR)
+#ifndef AT_HANDLE_CONNECTABLE
+#define AT_HANDLE_CONNECTABLE 0x002
+#endif
+
+/* nftw() has no context argument */
+static struct {
+	const struct file_handle *handle;
+	int encode_flags;
+	char *path;
+	PSEUDO_STATBUF st;
+} pseudo_handle_search;
+
+static int
+pseudo_handle_search_visit(const char *path, const struct stat64 *sb, int =
typeflag, struct FTW *ftw) {
+	union {
+		struct file_handle fh;
+		char space[sizeof(struct file_handle) + MAX_HANDLE_SZ];
+	} h;
+	int mount_id;
+
+	(void) ftw;
+	if (typeflag =3D=3D FTW_NS)
+		return 0;
+	h.fh.handle_bytes =3D MAX_HANDLE_SZ;
+	if (real_name_to_handle_at(AT_FDCWD, path, &h.fh, &mount_id, pseudo_handl=
e_search.encode_flags) =3D=3D -1 ||
+	    h.fh.handle_type !=3D pseudo_handle_search.handle->handle_type ||
+	    h.fh.handle_bytes !=3D pseudo_handle_search.handle->handle_bytes ||
+	    memcmp(h.fh.f_handle, pseudo_handle_search.handle->f_handle, h.fh.han=
dle_bytes))
+		return 0;
+	pseudo_handle_search.path =3D strdup(path);
+	pseudo_handle_search.st =3D *sb;
+	return 1;
+}
+
+/* Check the arguments as the kernel does (fs/fhandle.c), then find and
+ * open the file.
+ */
+static int
+pseudo_open_by_handle(int mount_fd, const struct file_handle *handle, int =
flags) {
+	char *root =3D NULL;
+	char procpath[32];
+	PSEUDO_STATBUF st;
+	ssize_t len;
+	int fd =3D -1;
+
+	if (!handle) {
+		errno =3D EFAULT;
+		return -1;
+	}
+	if (handle->handle_bytes =3D=3D 0 || handle->handle_bytes > MAX_HANDLE_SZ=
 ||
+	    handle->handle_type < 0 ||
+	    ((unsigned int) handle->handle_type & PSEUDO_FILEID_USER_FLAGS & ~PSE=
UDO_FILEID_VALID_USER_FLAGS)) {
+		errno =3D EINVAL;
+		return -1;
+	}
+	if (mount_fd < 0 && mount_fd !=3D AT_FDCWD) {
+		errno =3D EBADF;
+		return -1;
+	}
+	if (base_fstatat(mount_fd, "", &st, AT_EMPTY_PATH) =3D=3D -1)
+		return -1;
+
+	root =3D malloc(pseudo_path_max());
+	if (!root)
+		return -1;
+	if (mount_fd =3D=3D AT_FDCWD) {
+		if (!real_getcwd(root, pseudo_path_max()))
+			goto out;
+	} else {
+		snprintf(procpath, sizeof(procpath), "/proc/self/fd/%d", mount_fd);
+		len =3D real_readlink(procpath, root, pseudo_path_max() - 1);
+		if (len <=3D 0 || root[0] !=3D '/') {
+			errno =3D ESTALE;
+			goto out;
+		}
+		root[len] =3D '\0';
+	}
+
+	memset(&pseudo_handle_search, 0, sizeof(pseudo_handle_search));
+	pseudo_handle_search.handle =3D handle;
+	pseudo_handle_search.encode_flags =3D (handle->handle_type & PSEUDO_FILEI=
D_IS_CONNECTABLE) ? AT_HANDLE_CONNECTABLE : 0;
+	real_nftw64(root, pseudo_handle_search_visit, 16, FTW_PHYS | FTW_MOUNT);
+	if (!pseudo_handle_search.path) {
+		errno =3D ESTALE;
+		goto out;
+	}
+
+	/* as the kernel, a symlink is only opened with O_PATH */
+	fd =3D real_openat(AT_FDCWD, pseudo_handle_search.path, (flags & ~(O_CREA=
T | O_EXCL)) | O_NOFOLLOW);
+	/* the path could have been replaced since it was checked */
+	if (fd !=3D -1 && (base_fstat(fd, &st) =3D=3D -1 ||
+	    st.st_dev !=3D pseudo_handle_search.st.st_dev || st.st_ino !=3D pseud=
o_handle_search.st.st_ino)) {
+		real_close(fd);
+		fd =3D -1;
+		errno =3D ESTALE;
+	}
+	free(pseudo_handle_search.path);
+	pseudo_handle_search.path =3D NULL;
+out:
+	free(root);
+	return fd;
+}
+
 long
 syscall(long number, ...) {
 	long rc =3D -1;
@@ -175,6 +290,36 @@ syscall(long number, ...) {
 #error SYS_open_tree_attr not defined
 #endif
=20
+#ifdef SYS_name_to_handle_at
+	if (number =3D=3D SYS_name_to_handle_at) {
+		pseudo_debug(PDBGF_SYSCALL, "syscall, faking name_to_handle_at.\n");
+		va_start(ap, number);
+		int dirfd =3D va_arg(ap, int);
+		const char *name =3D va_arg(ap, const char *);
+		struct file_handle *handle =3D va_arg(ap, struct file_handle *);
+		int *mount_id =3D va_arg(ap, int *);
+		int flags =3D va_arg(ap, int);
+
+		return wrap_name_to_handle_at(dirfd, name, handle, mount_id, flags);
+	}
+#else
+#error SYS_name_to_handle_at not defined
+#endif
+
+#ifdef SYS_open_by_handle_at
+	if (number =3D=3D SYS_open_by_handle_at) {
+		pseudo_debug(PDBGF_SYSCALL, "syscall, faking open_by_handle_at.\n");
+		va_start(ap, number);
+		int mount_fd =3D va_arg(ap, int);
+		struct file_handle *handle =3D va_arg(ap, struct file_handle *);
+		int flags =3D va_arg(ap, int);
+
+		return wrap_open_by_handle_at(mount_fd, handle, flags);
+	}
+#else
+#error SYS_open_by_handle_at not defined
+#endif
+
 #ifdef SYS_renameat2
         /* Call out wrapper, expanding the variable arguments first */
 	if (number =3D=3D SYS_renameat2) {
diff --git a/ports/linux/wrapfuncs.in b/ports/linux/wrapfuncs.in
index a682383..1874b60 100644
--- a/ports/linux/wrapfuncs.in
+++ b/ports/linux/wrapfuncs.in
@@ -12,6 +12,8 @@ int openat(int dirfd, const char *path, int flags, ...{mo=
de_t mode}); /* flags=3D(
 int __openat_2(int dirfd, const char *path, int flags); /* flags=3D((flags=
&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))=3D=3D(O_CREAT|O_EXCL))), noignore_p=
ath=3D1 */
 int open_tree(int dirfd, const char *path, unsigned int flags); /* preserv=
e_paths=3D1, noignore_path=3D1 */
 int open_tree_attr(int dirfd, const char *path, unsigned int flags, struct=
 mount_attr *attr, size_t size); /* preserve_paths=3D1, noignore_path=3D1*/
+int name_to_handle_at(int dirfd, const char *name, struct file_handle *han=
dle, int *mount_id, int flags);
+int open_by_handle_at(int mount_fd, struct file_handle *handle, int flags)=
;
 int mknod(const char *path, mode_t mode, dev_t dev); /* real_func=3Dpseudo=
_mknod, path_lock=3D1 */
 int mknodat(int dirfd, const char *path, mode_t mode, dev_t dev); /* real_=
func=3Dpseudo_mknodat, path_lock=3D1 */
 int __xmknod(int ver, const char *path, mode_t mode, dev_t *dev); /* flags=
=3DAT_SYMLINK_NOFOLLOW, path_lock=3D1 */
diff --git a/test/test-name_to_handle_at.c b/test/test-name_to_handle_at.c
new file mode 100644
index 0000000..0f9e2e7
--- /dev/null
+++ b/test/test-name_to_handle_at.c
@@ -0,0 +1,107 @@
+/*
+ * Test that name_to_handle_at() resolves paths the way pseudo does,
+ * including inside a chroot, and only follows a final symlink with
+ * AT_SYMLINK_FOLLOW.
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * Returns 77 if the filesystem doesn't support file handles.
+ */
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+static struct file_handle *
+get_handle(int dirfd, const char *name, int flags, int use_syscall) {
+	struct file_handle *fh =3D malloc(sizeof(*fh) + MAX_HANDLE_SZ);
+	int mount_id, rc;
+
+	if (!fh)
+		return NULL;
+	fh->handle_bytes =3D MAX_HANDLE_SZ;
+	if (use_syscall)
+		rc =3D syscall(SYS_name_to_handle_at, dirfd, name, fh, &mount_id, flags)=
;
+	else
+		rc =3D name_to_handle_at(dirfd, name, fh, &mount_id, flags);
+	if (rc =3D=3D -1) {
+		if (errno =3D=3D EOPNOTSUPP || errno =3D=3D ENOSYS) {
+			printf("name_to_handle_at not supported: %s\n", strerror(errno));
+			exit(77);
+		}
+		printf("name_to_handle_at(%d, '%s', %#x): %s\n", dirfd, name, flags, str=
error(errno));
+		free(fh);
+		return NULL;
+	}
+	return fh;
+}
+
+static int
+same(const struct file_handle *a, const struct file_handle *b) {
+	return a && b && a->handle_bytes =3D=3D b->handle_bytes &&
+		a->handle_type =3D=3D b->handle_type &&
+		!memcmp(a->f_handle, b->f_handle, a->handle_bytes);
+}
+
+int
+main(int argc, char *argv[]) {
+	struct file_handle *file, *link, *h;
+	char path[4096];
+	int fd, rc =3D 0;
+
+	if (argc !=3D 2) {
+		fprintf(stderr, "usage: %s <chrootdir>\n", argv[0]);
+		return 2;
+	}
+
+	snprintf(path, sizeof(path), "%s/file", argv[1]);
+	file =3D get_handle(AT_FDCWD, path, 0, 0);
+	snprintf(path, sizeof(path), "%s/link", argv[1]);
+	link =3D get_handle(AT_FDCWD, path, 0, 0);
+	if (!file || !link)
+		return 1;
+	if (same(file, link)) {
+		printf("handle for a symlink matches its target\n");
+		return 1;
+	}
+
+	if (chroot(argv[1]) =3D=3D -1 || chdir("/") =3D=3D -1) {
+		perror("chroot");
+		return 1;
+	}
+
+	if (!same(get_handle(AT_FDCWD, "/file", 0, 0), file)) {
+		printf("/file inside the chroot has the wrong handle\n");
+		rc =3D 1;
+	}
+	if (!same(get_handle(AT_FDCWD, "/link", 0, 0), link)) {
+		printf("/link without AT_SYMLINK_FOLLOW has the wrong handle\n");
+		rc =3D 1;
+	}
+	if (!same(get_handle(AT_FDCWD, "/link", AT_SYMLINK_FOLLOW, 0), file)) {
+		printf("/link with AT_SYMLINK_FOLLOW has the wrong handle\n");
+		rc =3D 1;
+	}
+	if (!same(get_handle(AT_FDCWD, "/file", 0, 1), file)) {
+		printf("/file through syscall() has the wrong handle\n");
+		rc =3D 1;
+	}
+
+	fd =3D open("/file", O_RDONLY);
+	if (fd =3D=3D -1) {
+		perror("open /file");
+		return 1;
+	}
+	h =3D get_handle(fd, "", AT_EMPTY_PATH, 0);
+	if (!same(h, file)) {
+		printf("AT_EMPTY_PATH has the wrong handle\n");
+		rc =3D 1;
+	}
+	close(fd);
+
+	return rc;
+}
diff --git a/test/test-name_to_handle_at.sh b/test/test-name_to_handle_at.s=
h
new file mode 100755
index 0000000..351b0cb
--- /dev/null
+++ b/test/test-name_to_handle_at.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+#
+# Test name_to_handle_at() path resolution, including inside a chroot.
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+# rc 77 indicates the filesystem doesn't support file handles, so report
+# skipped (255).
+
+dir=3D$(pwd)/name_to_handle_at_test
+trap 'rm -rf "$dir"' 0
+rm -rf "$dir"
+mkdir -p "$dir"
+touch "$dir/file"
+ln -s file "$dir/link"
+
+./test/test-name_to_handle_at "$dir"
+rc=3D$?
+if [ "$rc" -eq 77 ]; then
+	exit 255
+fi
+exit $rc
diff --git a/test/test-open_by_handle_at.c b/test/test-open_by_handle_at.c
new file mode 100644
index 0000000..a05b9d7
--- /dev/null
+++ b/test/test-open_by_handle_at.c
@@ -0,0 +1,174 @@
+/*
+ * Test open_by_handle_at() under pseudo.  The kernel needs privilege to
+ * decode a file handle, so pseudo finds and opens the file itself.
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * Returns 77 if the filesystem doesn't support file handles.
+ */
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+static int failed;
+
+#define FAIL(...) do { printf(__VA_ARGS__); failed =3D 1; } while (0)
+
+static struct file_handle *
+handle_for(const char *path, int flags) {
+	struct file_handle *fh =3D malloc(sizeof(*fh) + MAX_HANDLE_SZ);
+	int mount_id;
+
+	if (!fh)
+		exit(1);
+	fh->handle_bytes =3D MAX_HANDLE_SZ;
+	if (name_to_handle_at(AT_FDCWD, path, fh, &mount_id, flags) =3D=3D -1) {
+		if (errno =3D=3D EOPNOTSUPP || errno =3D=3D ENOSYS) {
+			printf("name_to_handle_at not supported: %s\n", strerror(errno));
+			exit(77);
+		}
+		printf("name_to_handle_at(%s): %s\n", path, strerror(errno));
+		exit(1);
+	}
+	return fh;
+}
+
+/* Make the handle in another process, so this one can't have
+ * remembered where it came from.
+ */
+static struct file_handle *
+handle_from_child(const char *path) {
+	struct file_handle *fh =3D malloc(sizeof(*fh) + MAX_HANDLE_SZ);
+	int pipefd[2], status;
+	pid_t pid;
+
+	if (!fh || pipe(pipefd) =3D=3D -1)
+		exit(1);
+	pid =3D fork();
+	if (pid =3D=3D -1)
+		exit(1);
+	if (pid =3D=3D 0) {
+		struct file_handle *child =3D handle_for(path, 0);
+		ssize_t len =3D sizeof(*child) + child->handle_bytes;
+		_exit(write(pipefd[1], child, len) =3D=3D len ? 0 : 1);
+	}
+	close(pipefd[1]);
+	if (read(pipefd[0], fh, sizeof(*fh) + MAX_HANDLE_SZ) < (ssize_t) sizeof(*=
fh))
+		exit(1);
+	close(pipefd[0]);
+	if (waitpid(pid, &status, 0) =3D=3D -1 || !WIFEXITED(status) || WEXITSTAT=
US(status))
+		exit(WIFEXITED(status) ? WEXITSTATUS(status) : 1);
+	return fh;
+}
+
+static void
+check_dirfd(const char *how, int dirfd) {
+	struct stat st;
+
+	if (dirfd =3D=3D -1) {
+		FAIL("%s: open_by_handle_at: %s\n", how, strerror(errno));
+		return;
+	}
+	if (fstatat(dirfd, "file", &st, 0) =3D=3D -1)
+		FAIL("%s: fstatat: %s\n", how, strerror(errno));
+	else if (st.st_uid !=3D 123 || st.st_gid !=3D 456)
+		FAIL("%s: file owned by %d:%d, expected 123:456\n",
+			how, (int) st.st_uid, (int) st.st_gid);
+	close(dirfd);
+}
+
+int
+main(int argc, char *argv[]) {
+	struct file_handle *fh;
+	char path[4096], buf[16];
+	struct stat st;
+	int mount_fd, fd;
+	ssize_t len;
+
+	if (argc !=3D 2) {
+		fprintf(stderr, "usage: %s <dir>\n", argv[0]);
+		return 2;
+	}
+	mount_fd =3D open(argv[1], O_RDONLY | O_DIRECTORY);
+	if (mount_fd =3D=3D -1) {
+		perror("open");
+		return 1;
+	}
+
+	/* a directory handle, used for *at() calls */
+	snprintf(path, sizeof(path), "%s/dir/file", argv[1]);
+	if (chown(path, 123, 456) =3D=3D -1) {
+		perror("chown");
+		return 1;
+	}
+	snprintf(path, sizeof(path), "%s/dir", argv[1]);
+	fh =3D handle_for(path, 0);
+	check_dirfd("function", open_by_handle_at(mount_fd, fh, O_RDONLY | O_DIRE=
CTORY));
+	check_dirfd("syscall", syscall(SYS_open_by_handle_at, mount_fd, fh, O_RDO=
NLY | O_DIRECTORY));
+	free(fh);
+
+	/* a file below mount_fd that this process never named */
+	snprintf(path, sizeof(path), "%s/dir/sub/data", argv[1]);
+	fh =3D handle_from_child(path);
+	fd =3D open_by_handle_at(mount_fd, fh, O_RDONLY);
+	if (fd =3D=3D -1) {
+		FAIL("data: open_by_handle_at: %s\n", strerror(errno));
+	} else {
+		len =3D read(fd, buf, sizeof(buf) - 1);
+		buf[len > 0 ? len : 0] =3D '\0';
+		if (strcmp(buf, "hello\n"))
+			FAIL("data: read '%s'\n", buf);
+		close(fd);
+	}
+	free(fh);
+
+	/* mount_fd itself */
+	fh =3D handle_from_child(argv[1]);
+	fd =3D open_by_handle_at(mount_fd, fh, O_RDONLY | O_DIRECTORY);
+	if (fd =3D=3D -1)
+		FAIL("mount_fd: open_by_handle_at: %s\n", strerror(errno));
+	else
+		close(fd);
+	free(fh);
+
+	/* a symlink only opens with O_PATH, as the link itself */
+	snprintf(path, sizeof(path), "%s/dir/link", argv[1]);
+	fh =3D handle_from_child(path);
+	fd =3D open_by_handle_at(mount_fd, fh, O_RDONLY);
+	if (fd !=3D -1 || errno !=3D ELOOP)
+		FAIL("link: expected ELOOP, got %d (%s)\n", fd, strerror(errno));
+	fd =3D open_by_handle_at(mount_fd, fh, O_PATH);
+	if (fd =3D=3D -1)
+		FAIL("link: O_PATH: %s\n", strerror(errno));
+	else if (fstat(fd, &st) =3D=3D -1 || !S_ISLNK(st.st_mode))
+		FAIL("link: O_PATH didn't open the symlink\n");
+	if (fd !=3D -1)
+		close(fd);
+	free(fh);
+
+	/* a deleted file */
+	snprintf(path, sizeof(path), "%s/gone", argv[1]);
+	fh =3D handle_from_child(path);
+	unlink(path);
+	fd =3D open_by_handle_at(mount_fd, fh, O_RDONLY);
+	if (fd !=3D -1 || errno !=3D ESTALE)
+		FAIL("gone: expected ESTALE, got %d (%s)\n", fd, strerror(errno));
+	if (fd !=3D -1)
+		close(fd);
+
+	/* the kernel's own argument checks still apply */
+	fh->handle_bytes =3D 0;
+	fd =3D open_by_handle_at(mount_fd, fh, O_RDONLY);
+	if (fd !=3D -1 || errno !=3D EINVAL)
+		FAIL("empty handle: expected EINVAL, got %d (%s)\n", fd, strerror(errno)=
);
+	free(fh);
+
+	return failed;
+}
diff --git a/test/test-open_by_handle_at.sh b/test/test-open_by_handle_at.s=
h
new file mode 100755
index 0000000..ef4a9f7
--- /dev/null
+++ b/test/test-open_by_handle_at.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+#
+# Test open_by_handle_at() under pseudo.
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+# rc 77 indicates the filesystem doesn't support file handles, so report
+# skipped (255).
+
+dir=3D$(pwd)/open_by_handle_at_test
+trap 'rm -rf "$dir"' 0
+rm -rf "$dir"
+mkdir -p "$dir/dir/sub"
+touch "$dir/dir/file" "$dir/gone"
+echo hello > "$dir/dir/sub/data"
+ln -s file "$dir/dir/link"
+
+./test/test-open_by_handle_at "$dir"
+rc=3D$?
+if [ "$rc" -eq 77 ]; then
+	exit 255
+fi
+exit $rc
--=20
2.34.1

