Received: from BYAPR05CU005.outbound.protection.outlook.com (BYAPR05CU005.outbound.protection.outlook.com [52.101.85.71])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.355.1794855247609967514
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 10:54:07 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=ckIShWOV;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.85.71, mailfrom: mark.hatle@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sl4NNtNOju7HLlz3Zol42fZnjHMWMmPH4BeEvz6m9kffkZzmDyrPCUBB1Qn1xZR3H8jcpPPPF/icB2slvTs8BRYEwv25UzE5PnF6UKzsI1Rgrwa7nrg3Otpc4g0FVg92QttsFdIbZjbZqC1D3qEvHmuBz8XkrAzixsYVUVFsn8AkAd54jIlSdat1N0YOHg2Rj6Smkr84K7Pmnpf5jvl36jc73qVF0Kf+FjUBYw2nOkA2sifjFr1vHVT8ad2oVjHE86ykNVnd5FMbI1M2NqfXsNTheY2RyF4wkLGxE+qYPQUQ/IdvVCaCr+W4gy4kSU4TIOqiP+A+hSewjoF/jPp7HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSzsllXMUz+bWl6t1amisEsSvIZZmHI4TlhHJgYU8SI=;
 b=Pmdxyzh0B1TkH9SSH4WoJK5yR9Gvc9s1JtqshwhqmCFfeW3xfuhMcDqUmP3/GM/OwHhKMrwa7Q5PVyAboe0JtIQP5Y78IoUe/wLvpARdZWnkCf+K4i39I4mE2xNRA1R1bs16jHIRkofXNR+XMCcdIq+uObDIt4LiXSMn2CRf/DScqfy6BlqA6ma9yShXBX5ybBiXS8kIiX/mFLmvQspHxZhckVmn6ST0XNY9TAdz6H6AB9OzqHetApGVOA3VJFSoAjc1QCGCEOU8NtHsVsRoC7/ykKzSZpXXTF8E7i4CuzoUPglOwZ4KeH58f/ETeNQ4Jlerr9ua/9YaYYNvNQRXvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSzsllXMUz+bWl6t1amisEsSvIZZmHI4TlhHJgYU8SI=;
 b=ckIShWOVux12oRGm1XjSNw1r/a9Lh1ilXREk7gvTAH0qn1KSDcOuvRu1Z0TB+7ip5Fg0jvRw2tHniIo5W/DhDitF1NBEOZfADVeAntIbkl0kC9QchH9npPQ5MGhjfxu1BRn1CDW0iGdO7RcqE4ehhYSDwpQ0BguXYSmWiZvlu2k=
Received: from BN0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:408:e6::34)
 by CY8PR12MB8216.namprd12.prod.outlook.com (2603:10b6:930:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 18:54:01 +0000
Received: from BL6PEPF0006C3DD.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::49) by BN0PR03CA0029.outlook.office365.com
 (2603:10b6:408:e6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Mon, 16
 Nov 2026 18:54:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0006C3DD.mail.protection.outlook.com (10.167.249.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 16 Nov 2026 18:54:01 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 12:54:00 -0600
Received: from xcolc230100.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 16 Nov 2026 12:54:00 -0600
From: Mark Hatle <mark.hatle@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [pseudo][PATCH 1/3] ports/linux/pseudo_wrappers: Report io_uring as unsupported in syscall()
Date: Mon, 16 Nov 2026 11:53:58 -0700
Message-ID: <20261116185400.2205466-2-mark.hatle@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261116185400.2205466-1-mark.hatle@amd.com>
References: <20261116185400.2205466-1-mark.hatle@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: mark.hatle@amd.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DD:EE_|CY8PR12MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: 652f4a4d-ccb9-4d61-bc48-08df4412fa7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|56012099006|11063799006|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261022105027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BpC/4yzRcVdCjWnhSoKHNnTjMwqf1uQA1KZWABGPu5KI2Of/TMdWD5vL1f7Z0YqTGX39oWEQLp7uPp7xWVQS82Tfzyxu+V3wc0Rtc0Qz2WBUNKDFRoTvsxbnDp5dU75d7Ori9bBTYHHRk4Qu/ikDA+33ff+B/lJWyDylE0lbdutP/XC6zaRA9zknjV0ZzWie+reiSn/WawWsaMS8KOxjOeIQmCRAQzanL2wEuFzoOz0PV2z4ZJGvfZA76sApZvIiefY6l0n553cpJm45MpcnBd/YEHQoYF9DNVUNmsHsTDyYcHpceq2rr4/7vEMjuKRM0WxMUXRNJs34UWjasNkbpc2DFdXFmErXrNIi210g4tGFk/oUYbUtKMfRKIuOlUEPW/qxMaAR1OlkE+aURyiFnJiTkSlXd8rqJHZ0nED94VGL6EUR2bLG9kldYxTzdVwuBlgrXsZXNYcqs6ptfvFXg2d7qsXVWt0p9ZYHCQv8hs/zZjVdLQwbFFihbLc7OCqApBKeafzf8QwMrYCl/MEuqb9OjvUG7uhum2O2MaEoNBv6OaCMdjHJxGJgscg2XdsMvisC5s3PqTO3WxrDNvFXTSlH4QIdsKYjDkX4WKmdzAUvVi23k7H0vZx5/p1Fu33YABRXg7K3u/Jd+NlJL7bTXFKnmeSX64cy6AgZdCxDRbAjSaORIOZRtb0a3K9flaTAOb0WMvKBPjc8DCpwcS1DEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3fx6CCVMVbYJJcFfTH9KNFM4TJ9Rvnrut5+fRmfXI/W5scDwB6eHoXQntIYQmUHfawYsZtFluR1ZcpOLPy18Nepb7/lIlbbmP7Cm7nJU344uoz4lm3Q2ix5WfqBGyR/R7My5GnaqCYMxpaa0c3gqz5+EdLVxWvgU9MuQTT475ORR1a0qMzCkSgSD1l9OyPmuwTpqXNWn7bw8xfdnuU6BDB08uSNT/qHraxFvVyYEX7tWrp15dHDpyeXDCrnfPuFIXoivIaQ2J4aZeDEA0cexKiH5bTbnbWpdHRGD8Ex1e452FuNN6j/gDSaNzQU6rjJPA4ch68HmglLCT0qbPPbLUMo/3L5/NzwQeQTFyK7pMdbOxBZOguIGj90gPiVleOZGNXdlLuFCjHa0MrQpDcTBD24UnBWmyL4GygNoupjPWXKZEvSFDXqL8mbwTuoE+gtP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 18:54:01.2177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 652f4a4d-ccb9-4d61-bc48-08df4412fa7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0006C3DD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8216
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 18:54:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5412
Content-Type: text/plain; charset="utf-8"

Operations submitted through an io_uring are carried out by the kernel
without passing through libpseudo, so files they create or change are
not tracked, and end up with the build user's ownership.  libuv, used by
nodejs, and the meta-selftest reproducer set up a ring with syscall().

Refuse io_uring_setup(), io_uring_enter() and io_uring_register() with
ENOSYS, as a kernel without io_uring does, so callers fall back to the
ordinary calls pseudo can see.  This doesn't cover callers that make the
system call themselves, such as liburing.

test-io-uring-syscall checks that all three fail with ENOSYS under
pseudo.

[YOCTO #15244]

Reported-by: Martin Jansa <Martin.Jansa@gmail.com>
AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 ports/linux/pseudo_wrappers.c | 20 +++++++++++++++
 test/test-io-uring-syscall.c  | 47 +++++++++++++++++++++++++++++++++++
 test/test-io-uring-syscall.sh |  7 ++++++
 3 files changed, 74 insertions(+)
 create mode 100644 test/test-io-uring-syscall.c
 create mode 100755 test/test-io-uring-syscall.sh

diff --git a/ports/linux/pseudo_wrappers.c b/ports/linux/pseudo_wrappers.c
index a573abb..f24bb3a 100644
--- a/ports/linux/pseudo_wrappers.c
+++ b/ports/linux/pseudo_wrappers.c
@@ -196,6 +196,11 @@ syscall(long number, ...) {
 	    && number !=3D SYS_landlock_create_ruleset
 	    && number !=3D SYS_landlock_add_rule
 	    && number !=3D SYS_landlock_restrict_self
+#endif
+#ifdef SYS_io_uring_setup
+	    && number !=3D SYS_io_uring_setup
+	    && number !=3D SYS_io_uring_enter
+	    && number !=3D SYS_io_uring_register
 #endif
 	    ) {
 		if (!real_syscall)
@@ -242,6 +247,21 @@ syscall(long number, ...) {
 	}
 #endif
=20
+#ifdef SYS_io_uring_setup
+	/* Operations submitted through an io_uring never pass through
+	 * libpseudo, so files they create or change aren't tracked
+	 * (YOCTO #15244).  Report io_uring as unsupported, as a kernel
+	 * without it does, so callers fall back to ordinary calls.
+	 */
+	if (number =3D=3D SYS_io_uring_setup ||
+	    number =3D=3D SYS_io_uring_enter ||
+	    number =3D=3D SYS_io_uring_register) {
+		pseudo_debug(PDBGF_SYSCALL, "syscall, refusing io_uring.\n");
+		errno =3D ENOSYS;
+		return -1;
+	}
+#endif
+
 #ifdef SYS_openat2
 	/* There is a CVE patch (CVE-2025-45582) to tar 1.34 in Centos Stream whi=
ch
 	 * uses syscall to access openat2() and breaks builds if we don't redirec=
t.
diff --git a/test/test-io-uring-syscall.c b/test/test-io-uring-syscall.c
new file mode 100644
index 0000000..bff9765
--- /dev/null
+++ b/test/test-io-uring-syscall.c
@@ -0,0 +1,47 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * Operations submitted through an io_uring bypass libpseudo, so pseudo
+ * reports io_uring as unsupported to callers using syscall(), such as
+ * libuv, which then fall back to ordinary calls.
+ */
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+/* The numbers are the same on every architecture using the common table. =
*/
+#ifndef __NR_io_uring_setup
+#define __NR_io_uring_setup 425
+#endif
+#ifndef __NR_io_uring_enter
+#define __NR_io_uring_enter 426
+#endif
+#ifndef __NR_io_uring_register
+#define __NR_io_uring_register 427
+#endif
+
+static int
+check(const char *name, long rc) {
+	if (rc !=3D -1 || errno !=3D ENOSYS) {
+		printf("%s: expected ENOSYS, got %ld (%s)\n", name, rc, strerror(errno))=
;
+		if (rc >=3D 0)
+			close(rc);
+		return 1;
+	}
+	return 0;
+}
+
+int
+main(void) {
+	char params[120] =3D { 0 };	/* struct io_uring_params */
+	int rc =3D 0;
+
+	rc |=3D check("io_uring_setup", syscall(__NR_io_uring_setup, 1, params));
+	rc |=3D check("io_uring_enter", syscall(__NR_io_uring_enter, -1, 0, 0, 0,=
 NULL, 0));
+	rc |=3D check("io_uring_register", syscall(__NR_io_uring_register, -1, 0,=
 NULL, 0));
+	return rc;
+}
diff --git a/test/test-io-uring-syscall.sh b/test/test-io-uring-syscall.sh
new file mode 100755
index 0000000..74a06d9
--- /dev/null
+++ b/test/test-io-uring-syscall.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+#
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+# io_uring through syscall() is reported as unsupported under pseudo.
+
+./test/test-io-uring-syscall
--=20
2.34.1

