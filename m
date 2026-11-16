Received: from CH4PR04CU002.outbound.protection.outlook.com (CH4PR04CU002.outbound.protection.outlook.com [40.107.201.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.334.1794855249439803135
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 10:54:09 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=o5CJ2KQB;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.201.46, mailfrom: mark.hatle@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgs8cI3AZoJDleNT6p73k2thuRSVMGyTILUKM7+r/JToMqLTMR/Y6qDQDEVPyoNz92j6qZMC8CYBK570DtihC+MS8J8B53VUYnrehsU9x+HpGpVs2/ooSQHXxamyGpfiahKowyKsKLeCmuu/eYwgFI9+KeIVYjaFoJoEFPAN++xBk/KlI+7YRNTP5kFE+P3IdEE6Odbd9kKE5QZjTxa5jxa+pSYCRyf7MPqBHbAp2bJjyebjLH8M0vOFnjW2uPVaXtfU8USdB62b/KCNgC1Uld16z98ZWd3eg1wfaFgd17KiWQgPFxGWCxTLmixp0E9FIobHxvCosfia/lh93WO60g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSLCjr67VibF36Ss85ITBtgNdoY7bsKM19hMYI/v4kM=;
 b=jWSg+CS5RPkGVGiCaFKrWP4Lr4jmi9+ChuPBCjxkxtVYpWelV+hwvuumPsD6xEk/1PdQKH8EY1eaM67scCOX/+n+GMUR1temRXkQBj9v4w94KZhtLCqAk8mTX4ogpoIsl+hAanyp5N+HuStY7Z+TZiAEUGYNeo5sIhapQVbE5aw8R+lcqZk0qqCOgVCprHFevQsaQNvNL9xqpY49TeBHd7bi7Tu4N70evi2G4i23zsmmH/NwIBzTjQ4e9R/xehZ34Aoag3vTQQNilevTlmPlwVwu5JeTuJ12Y6XcYn4vXVE88Mr32LSCSDp5siHC2FqaIfX29GAU4MVtPUTV2T0HrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSLCjr67VibF36Ss85ITBtgNdoY7bsKM19hMYI/v4kM=;
 b=o5CJ2KQBX8lX4IYFxcRXw/lZkteJfKOFCW4kRoWxpi7RCKlcKT1Jy9AkvGKQcIF+S7BMV3mbc04l8+UNL7m8nFbgiXnrdw5Z6kpUZPktFgDTF14DVO32aLE3MMXR8EFF17iZM9gijz1LYnP0d13AeDpWv2ioRfLTm1bnxqw2BqQ=
Received: from CH0PR03CA0381.namprd03.prod.outlook.com (2603:10b6:610:119::16)
 by DS0PR12MB677406.namprd12.prod.outlook.com (2603:10b6:8:4ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 18:54:01 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::15) by CH0PR03CA0381.outlook.office365.com
 (2603:10b6:610:119::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 18:54:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 18:54:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 12:54:01 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 12:54:00 -0600
Received: from xcolc230100.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 16 Nov 2026 12:54:00 -0600
From: Mark Hatle <mark.hatle@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [pseudo][PATCH 2/3] ports/linux: Refuse io_uring in the kernel rather than be bypassed by it
Date: Mon, 16 Nov 2026 11:53:59 -0700
Message-ID: <20261116185400.2205466-3-mark.hatle@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261116185400.2205466-1-mark.hatle@amd.com>
References: <20261116185400.2205466-1-mark.hatle@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-Path: mark.hatle@amd.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|DS0PR12MB677406:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c8d1e3-f256-4edb-3c3e-08df4412faa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|22082099003|18002099003|6133799003|261009223027099003|3023799007|56012099006|5023799004|11063799006|261102123227099003|261102130727099003|261028144727099003|261026121527099003|261026135527099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|261022115727099003|10067099003;
X-Microsoft-Antispam-Message-Info: SLwpmim/nUpXheb6z2w9HEWYIR7AgrH8vFIAobBpQUi8dyL7EgW1udh11Q9AoQfAtHXuXbfjdQQvdwYpeeXm30m8IJA4rlY7QddDLRVQ7pqEPD+JdlMTCASL152rLofJ7iyS/azGe/CvIQNq3yugqnxs2hlHKafK0JjjT+egPt5X22eP8li9oprZBgavVvKv+C+MeW5E+MQjvXtPqGTuU2EwnlBv/oUYmUKKNL/e5nncBUyMpw5EhfthivsTyBP9gaIn0PaeSLx4lcpVf45DS4Lwzj3kXRRfa180+bHUy94WYuO2IUWbXiz2e/xADd6QoEvI1ehD2YdkX+03bqhEn14jtaFg0UritXyLb+rZ8MsUXp0uhvYN3xeRPSSiH885UFywI47JU6aGYoeLznRSQfHa5pkD5Rs9yNQtvwKlu/FAojhmvh22FMz/7khaixtJTvQOoP2e4S/COr63BrClnb/pqbY6InRbHmwrcgFxgHHOPbBpB6yN2NVmpymBau3JknW8/UQBllsNgi9BTB6N4JkpeUM+x1iZdgcuFwc8KLi71OxdPG1IJLb5hdrYUvp+5BTgOisA/+2CfnEZ+uu4QjT2cXH5tJsha+ULjwQ5X2w866QbrNLzu2l+AUD+2Ln/jrrtXVt+dFzAnE8yLvpbKJaUm94s/gGjAft2p7ejxfBbxPns/mmN9RXEmam4xOCcfQsqMtqbipHIPWAVBQp+Dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(56012099006)(5023799004)(11063799006)(261102123227099003)(261102130727099003)(261028144727099003)(261026121527099003)(261026135527099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261022115727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wE4M452ab3Eu1Qz77ETFxvJoi251aE84LvGPe240d2QXGds1wAbNPoAVT1In9sucRIKbdc/QO4BCqIkY4k59/X2KNBxV3Xd7CJmBIcbQ7fyZn7WJbBmB1Yn8ueus+1o0Yn/lNxuO6Un1SzDNW/nMJwaZGEGTdBSoxQ7fYOxMBgMXnFEYnS5zZp5xONVz34zKUMTBDZ+PGFZ/6av0zSsOS/BI/Tfb2dniGIfqZ8dWAD2oMYOaqE1g9/sifp4qj9jCZl/PTPYVSqx/YhV2x8sy60XzmvmdIyD4m8p84+ZZNVDcbYqNsJzB4ghsIpujJr5qupAesnY/wMdLLEG3OJZAGaRP3Eu5ojU+KG7FqrvoVEWVCYbP4NU16d5Hhb3SM4jcmonIt9pPS2xZS7oIKB18TWORyAeFzMPhBKq/9zw32e2BZCGo1vtLM72440tE+EY6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 18:54:01.4246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c8d1e3-f256-4edb-3c3e-08df4412faa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB677406
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 18:54:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5413

From: David Nystr=C3=B6m <david.nystrom@est.tech>

An LD_PRELOAD wrapper only sees callers which go through libc, and the two
most common io_uring users do not.  liburing is normally built with
CONFIG_NOLIBC and emits syscall instructions of its own; fio inlines one on
its submission path.  Those callers reach the kernel directly, which means
they hold a real ring and can create, rename or unlink files with pseudo
recording none of it - and wrong ownership baked into an image is far harde=
r
to notice than a failure would have been.

There is also nothing to wrap: libc exports no io_uring entry point at all,
so the kernel is the only place the question can be answered.  A seccomp
filter marks io_uring_setup(), io_uring_enter() and io_uring_register() and
answers them with ENOSYS, which is what a kernel built without io_uring say=
s
and what every caller worth worrying about already has a fallback for.  A
build does not need io_uring; it needs pseudo to see the file operations.
The filter is inherited across fork() and execve(), so one installation
covers an entire build, including the processes libpseudo cannot be loaded
into at all - a statically linked program which uses io_uring gets the same
clean ENOSYS rather than slipping past unseen.

The mode is chosen by environment variable and logged at every start:

  PSEUDO_IO_URING_SECCOMP=3D0   passthrough, as pseudo behaved before any o=
f
                              this existed: nothing installed, nothing
                              checked, io_uring works and pseudo does not
                              see what it does.
  PSEUDO_IO_URING_SECCOMP=3D1   deny, and the default if the variable is no=
t
                              set.

The values are the numbers the variable is set to, so that a further mode c=
an
be added later without renumbering the ones already documented.  A value
which is neither is warned about and treated as the default, since an
unreadable setting is no reason to stop recording ownership.

no_new_privs is a precondition, never something this sets.  Installing a
filter requires either privilege or no_new_privs, and setting the latter
suppresses setuid and file capabilities for the process and everything it
execs, which in a build stops a sysroot's own setuid helpers working.  That
is not pseudo's decision to make on an application's behalf, so where it is
unset and pseudo is unprivileged no filter can be installed, deny cannot be
enforced, and pseudo falls back to passthrough.  That fallback is warned
about, because a build which quietly stops recording ownership is the failu=
re
which surfaces latest.

The warning costs one line for a build rather than one per process: pseudo =
is
preloaded everywhere, and an unconditional line goes down the stderr of
whatever is running - "echo test | cat 2>&1" came back as "io_uring: deny
test" - so it goes to pseudo's log when there is one and is otherwise said
once behind a marker which children inherit.  Whether a filter is already i=
n
force travels the same way, because asking the kernel would mean issuing an
io_uring syscall, which is fatal under an unrelated filter whose action is
SECCOMP_RET_KILL.  That marker also stops the thousands of processes in a
build each stacking another copy, since every filter in the chain is
evaluated on every syscall a process makes.

The filter is asked for with TSYNC and with LOG, and without whichever of t=
hem
the kernel rejects.  TSYNC applies it to every thread, which is what the ma=
rker
recording that a filter is in force claims; LOG has the kernel record each
refused call, in the audit log or in the ring buffer where nothing listens =
to
audit, so that the programs in a build which reach for io_uring can be name=
d
rather than guessed at.  Neither is worth failing the installation over, si=
nce
gVisor answers EINVAL to LOG with or without TSYNC beside it, as does a ker=
nel
older than 4.14 - dropping a rejected flag keeps io_uring refused where
insisting on it would hand io_uring back.

The AUDIT_ARCH value is spelled out rather than taken from <linux/audit.h>,
which is not always present in a cross sysroot; an architecture missing fro=
m
that list installs no filter and io_uring reaches the kernel on it
unexamined.  The syscall numbers come from the sysroot where it has them an=
d
from a table of known ABI assignments where it does not, because a native o=
r
nativesdk pseudo may run on an architecture other than the one it was built
against.

The test asks the only question that matters - whether the three calls real=
ly
do answer ENOSYS - and it has to set no_new_privs and re-execute itself to =
ask
it, since pseudo will not set it and a filter cannot be installed without i=
t.
Arranging the precondition is what makes the answer the same everywhere
instead of only on a machine which happened to have it already, which is no=
t
most of them.

Everything which is not pseudo's doing is a skip rather than a failure: a
kernel with no seccomp to install a filter into, an architecture with no au=
dit
value, an io_uring which has been switched off and answers EPERM rather tha=
n
the ENOSYS deny gives.  The one thing reported as a failure is a filter bei=
ng
in force and io_uring working anyway, because that is pseudo not keeping it=
s
word.  Passthrough is checked as well, and can only fail the test rather th=
an
skip it: a filter installed by an ancestor cannot be removed, so where
something upstream has already denied io_uring passthrough is simply not
reachable.

AI-Generated: Uses Claude (claude-opus-5)
Signed-off-by: David Nystr=C3=B6m <david.nystrom@est.tech>

[YOCTO #15244]

Rebased onto master.

PSEUDO_IO_URING_SECCOMP only decides whether the filter is installed.

pseudo's syscall() wrapper refuses io_uring for callers which go through
libc whatever it is set to.

The comment saying syscall() doesn't handle io_uring was dropped and the
warning, log message, comments and pseudo.1 describe passthrough as no
filter, with only direct callers getting through.

The test makes  the system calls directly, as liburing does, since
syscall() is always  refused.

The mode and any problem installing the filter are reported only in the
debug output (PSEUDO_DEBUG=3Dc), never to standard error, so the logging
helpers and the PSEUDO_IO_URING_WARNED marker were dropped.

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 Makefile.in                           |   1 +
 ports/linux/io_uring_syscalls.h       |  72 +++++
 ports/linux/portdefs.h                |   2 +
 ports/linux/pseudo_io_uring_seccomp.c | 363 ++++++++++++++++++++++++++
 ports/linux/pseudo_wrappers.c         |   4 +
 pseudo.1                              |  79 ++++++
 pseudo_util.c                         |   2 +
 pseudo_wrappers.c                     |  11 +
 test/test-io-uring-deny.c             | 267 +++++++++++++++++++
 test/test-io-uring-deny.sh            |  16 ++
 10 files changed, 817 insertions(+)
 create mode 100644 ports/linux/io_uring_syscalls.h
 create mode 100644 ports/linux/pseudo_io_uring_seccomp.c
 create mode 100644 test/test-io-uring-deny.c
 create mode 100755 test/test-io-uring-deny.sh

diff --git a/Makefile.in b/Makefile.in
index 84e3ee8..4c873d6 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -135,6 +135,7 @@ $(LIBPSEUDO): $(WRAPOBJS) pseudo_client.o pseudo_client=
_scanf.o pseudo_ipc.o $(S
 $(OBJS): pseudo_tables.h
=20
 pseudo_client.o pseudo_server.o pseudo_ipc.o: pseudo_ipc.h
+pseudo_wrappers.o: ports/linux/pseudo_io_uring_seccomp.c ports/linux/io_ur=
ing_syscalls.h
=20
 pseudo_client.o: pseudo_client.h
=20
diff --git a/ports/linux/io_uring_syscalls.h b/ports/linux/io_uring_syscall=
s.h
new file mode 100644
index 0000000..9282bd6
--- /dev/null
+++ b/ports/linux/io_uring_syscalls.h
@@ -0,0 +1,72 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * io_uring syscall numbers.  Prefer the host/SDK sysroot definitions: pse=
udo
+ * native and nativesdk builds may execute on different architectures.
+ */
+#ifndef PSEUDO_IO_URING_SYSCALLS_H
+#define PSEUDO_IO_URING_SYSCALLS_H
+
+#include <sys/syscall.h>
+
+#ifndef SYS_io_uring_setup
+# ifdef __NR_io_uring_setup
+#  define SYS_io_uring_setup __NR_io_uring_setup
+# endif
+#endif
+#ifndef SYS_io_uring_enter
+# ifdef __NR_io_uring_enter
+#  define SYS_io_uring_enter __NR_io_uring_enter
+# endif
+#endif
+#ifndef SYS_io_uring_register
+# ifdef __NR_io_uring_register
+#  define SYS_io_uring_register __NR_io_uring_register
+# endif
+#endif
+
+/* Linux headers older than 5.1 do not define the io_uring calls.  Supply
+ * fallbacks only for ABIs whose assignments are known.  In particular, Al=
pha
+ * has its own numbers, MIPS adds its ABI base, and x32 adds its syscall b=
it.
+ */
+#if !defined(SYS_io_uring_setup) || !defined(SYS_io_uring_enter) ||     !d=
efined(SYS_io_uring_register)
+# if defined(__alpha__)
+#  define PSEUDO_NR_io_uring_setup 535
+#  define PSEUDO_NR_io_uring_enter 536
+#  define PSEUDO_NR_io_uring_register 537
+# elif defined(__mips__) && defined(__NR_Linux)
+#  define PSEUDO_NR_io_uring_setup (__NR_Linux + 425)
+#  define PSEUDO_NR_io_uring_enter (__NR_Linux + 426)
+#  define PSEUDO_NR_io_uring_register (__NR_Linux + 427)
+# elif defined(__x86_64__) && defined(__ILP32__) &&        defined(__X32_S=
YSCALL_BIT)
+#  define PSEUDO_NR_io_uring_setup (__X32_SYSCALL_BIT + 425)
+#  define PSEUDO_NR_io_uring_enter (__X32_SYSCALL_BIT + 426)
+#  define PSEUDO_NR_io_uring_register (__X32_SYSCALL_BIT + 427)
+# elif defined(__i386__) ||        (defined(__x86_64__) && !defined(__ILP3=
2__)) ||        defined(__arm__) || defined(__aarch64__) || defined(__riscv=
) ||        defined(__powerpc__) || defined(__s390__) || defined(__sparc__)=
 ||        defined(__m68k__) || defined(__hppa__) || defined(__sh__) ||    =
    defined(__loongarch__) || defined(__arc__) || defined(__csky__) ||     =
   defined(__hexagon__) || defined(__microblaze__) ||        defined(__nios=
2__) || defined(__or1k__) || defined(__xtensa__)
+#  define PSEUDO_NR_io_uring_setup 425
+#  define PSEUDO_NR_io_uring_enter 426
+#  define PSEUDO_NR_io_uring_register 427
+# endif
+#endif
+
+#ifndef SYS_io_uring_setup
+# ifdef PSEUDO_NR_io_uring_setup
+#  define SYS_io_uring_setup PSEUDO_NR_io_uring_setup
+# endif
+#endif
+#ifndef SYS_io_uring_enter
+# ifdef PSEUDO_NR_io_uring_enter
+#  define SYS_io_uring_enter PSEUDO_NR_io_uring_enter
+# endif
+#endif
+#ifndef SYS_io_uring_register
+# ifdef PSEUDO_NR_io_uring_register
+#  define SYS_io_uring_register PSEUDO_NR_io_uring_register
+# endif
+#endif
+
+#if defined(SYS_io_uring_setup) && defined(SYS_io_uring_enter) &&     defi=
ned(SYS_io_uring_register)
+#define PSEUDO_HAVE_IO_URING_SYSCALLS 1
+#endif
+
+#endif
diff --git a/ports/linux/portdefs.h b/ports/linux/portdefs.h
index 255b2ec..e0addcf 100644
--- a/ports/linux/portdefs.h
+++ b/ports/linux/portdefs.h
@@ -110,3 +110,5 @@ struct mount_attr;
=20
 #define SYS_open_tree_attr __NR_open_tree_attr
 #endif
+
+#include "io_uring_syscalls.h"
diff --git a/ports/linux/pseudo_io_uring_seccomp.c b/ports/linux/pseudo_io_=
uring_seccomp.c
new file mode 100644
index 0000000..bbee73d
--- /dev/null
+++ b/ports/linux/pseudo_io_uring_seccomp.c
@@ -0,0 +1,363 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * Kernel-enforced io_uring refusal for pseudo.
+ *
+ * An LD_PRELOAD wrapper can only see callers which go through libc.  The =
two
+ * most common io_uring users do not: liburing is normally built with
+ * CONFIG_NOLIBC and emits syscall instructions of its own, and fio inline=
s a
+ * syscall instruction on its submission path.  Those callers reach the ke=
rnel
+ * directly, which means they hold a real ring and can create, rename or
+ * unlink files without pseudo recording any of it - and wrong ownership b=
aked
+ * into an image is far harder to notice than a failure would have been.
+ *
+ * There is nothing to wrap, either: glibc exports no io_uring entry point=
 at
+ * all, so the kernel is the only place the question can be answered.  A
+ * seccomp filter marks io_uring_setup(), io_uring_enter() and
+ * io_uring_register() and answers them with ENOSYS, which is what a kerne=
l
+ * built without io_uring says and what every caller worth worrying about
+ * already has a fallback for.  The filter is inherited across fork() and
+ * execve(), so one installation covers an entire build, including the
+ * processes libpseudo cannot be loaded into.
+ *
+ * Two modes, chosen by environment variable: deny (the default) and
+ * passthrough.  See the mode enum below.  The mode only
+ * decides whether the filter is installed; pseudo's syscall() wrapper ref=
uses
+ * io_uring for callers which go through libc either way.
+ *
+ * no_new_privs is a precondition for installing a filter without privileg=
e,
+ * and this never sets it: doing so would suppress setuid and file
+ * capabilities for the process and everything it execs, which in a build
+ * stops a sysroot's own setuid helpers working, and that is not a decisio=
n
+ * pseudo should make on an application's behalf.  Where it is unset and
+ * pseudo is unprivileged, no filter can be installed, and callers which m=
ake
+ * the system call themselves are not refused.
+ *
+ * The mode in force, and anything which went wrong installing the filter,
+ * are reported only in the debug output (PSEUDO_DEBUG=3Dc).  pseudo is pr=
eloaded
+ * into every process a build runs, and none of this stops pseudo working,=
 so
+ * it must not end up in the output of programs whose output is captured.
+ */
+
+#include <stddef.h>
+#include <sys/prctl.h>
+#include <linux/filter.h>
+#include <linux/seccomp.h>
+
+#ifndef SECCOMP_MODE_FILTER
+#define SECCOMP_MODE_FILTER 2
+#endif
+#ifndef SECCOMP_SET_MODE_FILTER
+#define SECCOMP_SET_MODE_FILTER 1
+#endif
+#ifndef SECCOMP_FILTER_FLAG_TSYNC
+#define SECCOMP_FILTER_FLAG_TSYNC (1UL << 0)
+#endif
+#ifndef SECCOMP_FILTER_FLAG_LOG
+#define SECCOMP_FILTER_FLAG_LOG (1UL << 1)
+#endif
+#ifndef SECCOMP_RET_ALLOW
+#define SECCOMP_RET_ALLOW 0x7fff0000U
+#endif
+#ifndef SECCOMP_RET_ERRNO
+#define SECCOMP_RET_ERRNO 0x00050000U
+#endif
+#ifndef SECCOMP_RET_DATA
+#define SECCOMP_RET_DATA 0x0000ffffU
+#endif
+#ifndef PR_GET_NO_NEW_PRIVS
+#define PR_GET_NO_NEW_PRIVS 39
+#endif
+
+/* AUDIT_ARCH_* for the ABI this copy of libpseudo was built for.  There i=
s no
+ * value meaning "whatever this is", so the ABI still has to be named, but=
 the
+ * number behind the name comes from the sysroot: one table fewer to keep
+ * right, and a new architecture is two lines rather than a constant to lo=
ok
+ * up and get wrong.
+ *
+ * A sysroot without <linux/audit.h>, or with one too old to name this ABI=
,
+ * leaves PSEUDO_SECCOMP_AUDIT_ARCH undefined - as does an architecture mi=
ssing
+ * below - and then no filter is installed and io_uring reaches the kernel=
 on
+ * it unexamined.
+ *
+ * Endianness does not come into it, which is worth saying because the
+ * constants suggest it should.  <linux/audit.h> defines AUDIT_ARCH_ARMEB
+ * beside AUDIT_ARCH_ARM, but nothing in the kernel ever answers with it:
+ * arch/arm's syscall_get_arch() returns AUDIT_ARCH_ARM for every arm task=
 -
+ * "ARM tasks don't change audit architectures on the fly" - and its
+ * SECCOMP_ARCH_NATIVE is that same value, while an arm task under an aarc=
h64
+ * kernel is reported as AUDIT_ARCH_ARM as well.  aarch64 has the one valu=
e
+ * for both endiannesses too.  So a big-endian build matches on the same
+ * constant as a little-endian one, and there is nothing to exclude.
+ */
+#if !defined(__has_include) || __has_include(<linux/audit.h>)
+#include <linux/audit.h>
+#endif
+
+#if defined(__x86_64__) && !defined(__ILP32__) && defined(AUDIT_ARCH_X86_6=
4)
+#define PSEUDO_SECCOMP_AUDIT_ARCH AUDIT_ARCH_X86_64
+#elif defined(__i386__) && defined(AUDIT_ARCH_I386)
+#define PSEUDO_SECCOMP_AUDIT_ARCH AUDIT_ARCH_I386
+#elif defined(__aarch64__) && defined(AUDIT_ARCH_AARCH64)
+#define PSEUDO_SECCOMP_AUDIT_ARCH AUDIT_ARCH_AARCH64
+#elif defined(__arm__) && defined(AUDIT_ARCH_ARM)
+#define PSEUDO_SECCOMP_AUDIT_ARCH AUDIT_ARCH_ARM
+#elif defined(__riscv) && __riscv_xlen =3D=3D 64 && defined(AUDIT_ARCH_RIS=
CV64)
+#define PSEUDO_SECCOMP_AUDIT_ARCH AUDIT_ARCH_RISCV64
+#endif
+
+/* The variable which picks the mode, and the marker pseudo carries in its
+ * own environment.  The marker stops the thousands of processes in
+ * a build each stacking another copy, since every filter in the chain is
+ * evaluated on every syscall the process makes.  pseudo re-exports its ow=
n
+ * variables across exec, including for callers that build their own
+ * environment, so these survive where a plain setenv() would not.
+ */
+#define PSEUDO_IO_URING_MODE_VAR "PSEUDO_IO_URING_SECCOMP"
+#define PSEUDO_IO_URING_FILTER_MARKER "PSEUDO_IO_URING_FILTER"
+
+/* How this process treats io_uring.
+ *
+ * Deny is the default.  A build does not need io_uring; it needs pseudo t=
o see
+ * the file operations.  Refusing the syscalls outright costs a caller the
+ * fallback path it already has, and costs pseudo nothing.
+ *
+ *   PSEUDO_IO_URING_SECCOMP=3D0   passthrough: no filter is installed, so
+ *                               callers which make the system call
+ *                               themselves get a working io_uring, and
+ *                               pseudo does not see what they do with it.
+ *   PSEUDO_IO_URING_SECCOMP=3D1   deny, and the default: io_uring_setup()
+ *                               answers ENOSYS and callers take the fallb=
ack
+ *                               they already have.
+ *
+ * The values are the numbers the variable is set to, so that a mode can b=
e
+ * added without renumbering the ones already documented.
+ */
+enum pseudo_io_uring_mode {
+	PSEUDO_IO_URING_MODE_PASSTHROUGH =3D 0,
+	PSEUDO_IO_URING_MODE_DENY =3D 1,
+	PSEUDO_IO_URING_MODE_LAST =3D PSEUDO_IO_URING_MODE_DENY
+};
+
+#ifdef PSEUDO_SECCOMP_AUDIT_ARCH
+static const char *
+pseudo_io_uring_mode_name(enum pseudo_io_uring_mode mode)
+{
+	switch (mode) {
+	case PSEUDO_IO_URING_MODE_PASSTHROUGH:
+		return "passthrough";
+	default:
+		return "deny";
+	}
+}
+
+/* The mode asked for by the environment, or by the value pseudo carried
+ * across an exec for a caller which built its own environment.
+ */
+static enum pseudo_io_uring_mode
+pseudo_io_uring_wanted_mode(void)
+{
+	enum pseudo_io_uring_mode mode =3D PSEUDO_IO_URING_MODE_DENY;
+	char *env =3D getenv(PSEUDO_IO_URING_MODE_VAR);
+	char *owned =3D NULL;
+	char *end;
+	long value;
+
+	if (env)
+		pseudo_set_value(PSEUDO_IO_URING_MODE_VAR, env);
+	else
+		env =3D owned =3D pseudo_get_value(PSEUDO_IO_URING_MODE_VAR);
+	if (!env)
+		return mode;
+
+	value =3D strtol(env, &end, 10);
+	if (end !=3D env && !*end && value >=3D 0 &&
+	    value <=3D PSEUDO_IO_URING_MODE_LAST) {
+		mode =3D (enum pseudo_io_uring_mode) value;
+	} else {
+		/* Worth saying, because the mode which was asked for is not
+		 * the mode which is in force. */
+		pseudo_debug(PDBGF_CLIENT, "io_uring: %s=3D%s is not a mode; using %s\n"=
,
+			PSEUDO_IO_URING_MODE_VAR, env,
+			pseudo_io_uring_mode_name(mode));
+	}
+	free(owned);
+	return mode;
+}
+
+/* Has some ancestor already installed the filter?  Asking the kernel woul=
d
+ * mean issuing an io_uring syscall, which is fatal under an unrelated fil=
ter
+ * whose action is SECCOMP_RET_KILL, so the answer is carried in pseudo's =
own
+ * environment instead.
+ */
+static int
+pseudo_io_uring_filter_present(void)
+{
+	char *env =3D getenv(PSEUDO_IO_URING_FILTER_MARKER);
+	int present;
+
+	if (env) {
+		pseudo_set_value(PSEUDO_IO_URING_FILTER_MARKER, env);
+		return 1;
+	}
+	env =3D pseudo_get_value(PSEUDO_IO_URING_FILTER_MARKER);
+	present =3D env !=3D NULL;
+	free(env);
+	return present;
+}
+
+/* Why a filter could not be installed, almost always.
+ *
+ * Installing one requires either privilege or no_new_privs, and this neve=
r
+ * sets the latter: it suppresses setuid and file capabilities for the pro=
cess
+ * and everything it execs, which in a build stops a sysroot's own setuid
+ * helpers working, and that is not a decision pseudo should make on an
+ * application's behalf.  So where it is unset and pseudo is unprivileged,
+ * deny cannot be enforced and says so. */
+static int
+pseudo_io_uring_no_new_privs(void)
+{
+	return real_prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0) =3D=3D 1;
+}
+
+/* The three syscalls, answered with ENOSYS in the kernel, so nothing abou=
t
+ * io_uring reaches this process at all: io_uring_setup() fails the way it=
 does
+ * on a kernel built without it.
+ */
+static int
+pseudo_io_uring_install_filter(void)
+{
+	struct sock_filter filter[] =3D {
+		/* Only the native ABI is decoded below, so anything else is
+		 * left to the kernel. */
+		BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
+			offsetof(struct seccomp_data, arch)),
+		BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, PSEUDO_SECCOMP_AUDIT_ARCH, 0, 4),
+		BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
+			offsetof(struct seccomp_data, nr)),
+		BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, SYS_io_uring_setup, 3, 0),
+		BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, SYS_io_uring_enter, 2, 0),
+		BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, SYS_io_uring_register, 1, 0),
+		BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
+		BPF_STMT(BPF_RET | BPF_K,
+			SECCOMP_RET_ERRNO | (ENOSYS & SECCOMP_RET_DATA)),
+	};
+	struct sock_fprog prog =3D {
+		.len =3D (unsigned short) (sizeof(filter) / sizeof(filter[0])),
+		.filter =3D filter,
+	};
+
+	/* real_syscall, because pseudo's own wrappers answer seccomp requests
+	 * with a polite lie so that applications cannot sandbox away the
+	 * wrappers they are supposed to be using. */
+#ifdef SYS_seccomp
+	/* What to ask for, in descending order of preference.
+	 *
+	 * TSYNC applies the filter to every thread in the process, which is
+	 * what the marker recorded on success is a claim about.  LOG has the
+	 * kernel record each refusal where an operator can find it - the audit
+	 * log, or the kernel ring buffer where nothing is listening to audit -
+	 * and changes nothing about what the filter does.
+	 *
+	 * Neither is insisted on, because a sandbox can implement seccomp
+	 * without implementing every flag of it: gVisor answers EINVAL to LOG,
+	 * with or without TSYNC beside it, as does a kernel older than 4.14.
+	 * Refusing to install over that would trade the thing which denies
+	 * io_uring for a flag which only describes it, so a rejected flag is
+	 * dropped and the filter goes in anyway.  TSYNC is given up last of
+	 * the two, being a property of the filter rather than of the record of
+	 * it.
+	 *
+	 * Where TSYNC is given up, the call can also fail by answering with a
+	 * sibling thread's id rather than -1, which is why only zero is taken
+	 * for success.  What is installed then covers this thread and whatever
+	 * it goes on to create, and not that sibling or the children the
+	 * sibling execs - which will find the marker and decide they need no
+	 * filter of their own.  Partial coverage recorded as whole-process
+	 * coverage, in other words, and it is left that way because the path
+	 * is not reachable the way pseudo is loaded: the constructor runs
+	 * before main() in the single thread a process starts with, so there
+	 * is no sibling to disagree.  Getting there takes libpseudo dlopen'd
+	 * into a running process whose threads have sandboxed themselves
+	 * apart, and the thread which asked is still better off filtered than
+	 * not.
+	 */
+	static const unsigned long flag_sets[] =3D {
+		SECCOMP_FILTER_FLAG_TSYNC | SECCOMP_FILTER_FLAG_LOG,
+		SECCOMP_FILTER_FLAG_TSYNC,
+		SECCOMP_FILTER_FLAG_LOG,
+		0
+	};
+	unsigned int i;
+
+	for (i =3D 0; i < sizeof(flag_sets) / sizeof(flag_sets[0]); ++i) {
+		if (real_syscall(SYS_seccomp, SECCOMP_SET_MODE_FILTER,
+		    flag_sets[i], &prog) =3D=3D 0)
+			return 0;
+	}
+#endif
+	/* Kernels without seccomp(2) have no flags to ask for at all, so this
+	 * one is per-thread and unlogged whatever the circumstances. */
+	return real_prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog, 0, 0);
+}
+#endif /* PSEUDO_SECCOMP_AUDIT_ARCH */
+
+/* Called from _libpseudo_init(), so: once per process, after the real_*
+ * pointers and the client are set up, and again in every process that exe=
cs.
+ */
+static void
+pseudo_io_uring_init(void)
+{
+#ifdef PSEUDO_SECCOMP_AUDIT_ARCH
+	static int done =3D 0;
+	enum pseudo_io_uring_mode mode;
+
+	if (done)
+		return;
+	done =3D 1;
+
+	/* PSEUDO_DISABLED means "stay out of the way", which is the same
+	 * answer as asking for passthrough. */
+	if (pseudo_disabled)
+		return;
+
+	mode =3D pseudo_io_uring_wanted_mode();
+
+	if (mode =3D=3D PSEUDO_IO_URING_MODE_PASSTHROUGH) {
+		/* Nothing installed and nothing asked of the kernel, so there
+		 * is nothing to report but the choice itself. */
+		if (pseudo_io_uring_filter_present())
+			/* An ancestor's filter cannot be removed, so the
+			 * request cannot be honoured: io_uring stays refused.
+			 * Worth saying, because the caller asked for one thing
+			 * and is getting another. */
+			pseudo_debug(PDBGF_CLIENT, "io_uring: passthrough requested but a filte=
r is inherited; io_uring calls will fail with ENOSYS\n");
+		else
+			pseudo_debug(PDBGF_CLIENT, "io_uring: passthrough (io_uring calls made =
without syscall() are not refused)\n");
+		return;
+	}
+
+	/* Already in force for this whole process tree, and a second copy
+	 * would only cost every syscall the process makes. */
+	if (pseudo_io_uring_filter_present()) {
+		pseudo_debug(PDBGF_CLIENT, "io_uring: deny (filter inherited)\n");
+		return;
+	}
+
+	if (pseudo_io_uring_install_filter() < 0) {
+		int save_errno =3D errno;
+
+		/* Nearly always the precondition rather than anything
+		 * exotic, so it is named: a filter can be installed either
+		 * with privilege or with no_new_privs, and pseudo has neither
+		 * to offer. */
+		pseudo_debug(PDBGF_CLIENT, "io_uring: deny requested but no filter could=
 be installed (%s%s); io_uring calls made without syscall() will go unrecor=
ded\n",
+			strerror(save_errno),
+			pseudo_io_uring_no_new_privs() ? "" :
+				"; no_new_privs is unset");
+		return;
+	}
+	pseudo_set_value(PSEUDO_IO_URING_FILTER_MARKER, "1");
+	pseudo_debug(PDBGF_CLIENT, "io_uring: deny\n");
+#endif
+}
diff --git a/ports/linux/pseudo_wrappers.c b/ports/linux/pseudo_wrappers.c
index f24bb3a..bba1577 100644
--- a/ports/linux/pseudo_wrappers.c
+++ b/ports/linux/pseudo_wrappers.c
@@ -169,6 +169,10 @@ out:
 	return fd;
 }
=20
+#ifdef PSEUDO_HAVE_IO_URING_SYSCALLS
+#include "pseudo_io_uring_seccomp.c"
+#endif
+
 long
 syscall(long number, ...) {
 	long rc =3D -1;
diff --git a/pseudo.1 b/pseudo.1
index b3a5089..1b5c537 100644
--- a/pseudo.1
+++ b/pseudo.1
@@ -624,6 +624,85 @@ discarded silently, even when
 .B PSEUDO_DISABLED
 is set. The value specified doesn't matter.
 .TP 8
+.B PSEUDO_IO_URING_SECCOMP
+Selects whether
+.I pseudo
+installs a seccomp filter refusing
+.IR io_uring (7).
+.I pseudo
+cannot intercept the file operations done through io_uring, so it always
+answers
+.IR io_uring_setup (2),
+.IR io_uring_enter (2)
+and
+.IR io_uring_register (2)
+made through
+.IR syscall (3)
+with
+.BR ENOSYS ,
+whatever this variable is set to.  But it is an
+.I LD_PRELOAD
+library, and the common io_uring users do not go through libc - liburing i=
s
+normally built with
+.I CONFIG_NOLIBC
+and issues the system calls itself, and
+.IR fio (1)
+inlines one on its submission path. Such a caller reaches the kernel direc=
tly
+and can create, rename or unlink files without
+.I pseudo
+recording any of it. There is also nothing to wrap, since libc exports no
+io_uring entry point, so a seccomp filter is used instead. The filter is
+inherited across
+.IR fork (2)
+and
+.IR execve (2),
+so one process tree needs it installed only once, including for the proces=
ses
+.I pseudo
+cannot be loaded into at all.
+.IP
+.I 0
+means passthrough: no filter is installed, so callers which make the syste=
m
+calls themselves get a working io_uring, and
+.I pseudo
+does not see the file operations they perform through it.
+.IP
+.I 1
+means deny, and is the default. The filter answers
+.IR io_uring_setup (2),
+.IR io_uring_enter (2)
+and
+.IR io_uring_register (2)
+with
+.BR ENOSYS ,
+which is what a kernel built without io_uring support answers, so callers =
take
+the fallback they already have for that case. Where the kernel supports
+.BR SECCOMP_FILTER_FLAG_LOG ,
+each refused call is also recorded by the kernel, in the audit log or in t=
he
+kernel ring buffer where nothing is listening to audit. A kernel or sandbo=
x
+which rejects that flag still gets the filter, without the records.
+.IP
+Installing a filter requires either privilege or
+.BR PR_SET_NO_NEW_PRIVS ,
+which suppresses setuid binaries and file capabilities for the process and
+everything it executes.
+.I pseudo
+never sets it, since that is not its decision to make on an application's
+behalf: where it is unset and
+.I pseudo
+is unprivileged, no filter can be installed, and callers which make the
+system call directly, rather than through
+.IR syscall (3),
+are not refused.
+.IP
+The mode, and any problem installing the filter, are reported only in the
+debug output selected by the
+.B c
+flag of
+.BR PSEUDO_DEBUG ,
+since none of them stops
+.I pseudo
+from working.
+.TP 8
 .B PSEUDO_ENOSYS_ABORT
 If this variable is set, the
 .I pseudo
diff --git a/pseudo_util.c b/pseudo_util.c
index d9312d0..5899a4f 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -58,6 +58,8 @@ static struct pseudo_variables pseudo_env[] =3D {
 	{ "PSEUDO_DISABLED", 15, NULL },
 	{ "PSEUDO_UNLOAD", 13, NULL },
 	{ "PSEUDO_ALLOW_FSYNC", 18, NULL },
+	{ "PSEUDO_IO_URING_SECCOMP", 23, NULL },
+	{ "PSEUDO_IO_URING_FILTER", 22, NULL },
 #ifdef PSEUDO_PROFILING
 	{ "PSEUDO_PROFILE_PATH", 19, NULL },
 #endif
diff --git a/pseudo_wrappers.c b/pseudo_wrappers.c
index 13d7ede..5e0bacf 100644
--- a/pseudo_wrappers.c
+++ b/pseudo_wrappers.c
@@ -65,6 +65,12 @@ static void pseudo_sigblock(sigset_t *);
 extern char *program_invocation_short_name;
 static sigset_t pseudo_saved_sigmask;
=20
+#if PSEUDO_PORT_LINUX && defined(PSEUDO_HAVE_IO_URING_SYSCALLS)
+/* Defined in ports/linux/pseudo_io_uring_seccomp.c, which is pulled in wi=
th
+ * the rest of the port's wrappers at the bottom of this file. */
+static void pseudo_io_uring_init(void);
+#endif
+
 /* Constructor only exists in libpseudo */
 static void _libpseudo_init(void) __attribute__ ((constructor));
=20
@@ -115,6 +121,11 @@ _libpseudo_init(void) {
 	pseudo_init_wrappers();
 	pseudo_init_client();
=20
+#if PSEUDO_PORT_LINUX && defined(PSEUDO_HAVE_IO_URING_SYSCALLS)
+	/* Needs the real_* pointers and pseudo_disabled, so it goes last. */
+	pseudo_io_uring_init();
+#endif
+
 	pseudo_magic();
 	pseudo_droplock();
 }
diff --git a/test/test-io-uring-deny.c b/test/test-io-uring-deny.c
new file mode 100644
index 0000000..c6cdd0d
--- /dev/null
+++ b/test/test-io-uring-deny.c
@@ -0,0 +1,267 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * Does deny deny, and does passthrough stay out of the way?
+ *
+ * Deny needs a filter, a filter needs no_new_privs, and pseudo will not s=
et
+ * it on an application's behalf - so the test sets it and re-executes its=
elf.
+ * The copy which comes back has libpseudo loaded afresh with the precondi=
tion
+ * met, and it is that copy which asks the kernel for a ring.  Without tha=
t the
+ * test would only ever see the fallback on a machine where no_new_privs i=
s
+ * unset, which is most of them.
+ *
+ * Everything which is not pseudo's doing is a skip rather than a failure:=
 a
+ * kernel with no seccomp to install a filter into, an architecture pseudo=
 has
+ * no audit value for, an io_uring which has been switched off.  The one t=
hing
+ * reported as a failure is a filter being in force and io_uring working
+ * anyway, because that is pseudo not keeping its word.
+ *
+ * pseudo's syscall() wrapper refuses io_uring in both modes, so both are
+ * checked with the system call made directly, as liburing does, which onl=
y
+ * the filter can see.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/prctl.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "../ports/linux/io_uring_syscalls.h"
+
+#define SKIP 77
+
+#ifndef PSEUDO_HAVE_IO_URING_SYSCALLS
+int
+main(void)
+{
+	return SKIP;
+}
+#else
+
+/* Old sysroots may not have them, and they are part of the kernel ABI. */
+#ifndef PR_SET_NO_NEW_PRIVS
+#define PR_SET_NO_NEW_PRIVS 38
+#endif
+#ifndef PR_GET_SECCOMP
+#define PR_GET_SECCOMP 21
+#endif
+
+/* io_uring_setup() needs somewhere to put what it negotiated, and the
+ * argument is rejected before it is written when the call is refused, so =
the
+ * size is all that has to be right. */
+struct params {
+	unsigned char opaque[120];
+};
+
+/* Make the system call without libc, so pseudo's syscall() wrapper can't
+ * answer it.  Returns -1 and sets errno on failure, as syscall() does.
+ */
+#if defined(__x86_64__) && !defined(__ILP32__)
+#define HAVE_RAW_SYSCALL 1
+static long
+raw_syscall(long n, long a, long b, long c, long d, long e, long f)
+{
+	register long r10 __asm__("r10") =3D d;
+	register long r8 __asm__("r8") =3D e;
+	register long r9 __asm__("r9") =3D f;
+	long ret;
+
+	__asm__ volatile ("syscall"
+		: "=3Da"(ret)
+		: "a"(n), "D"(a), "S"(b), "d"(c), "r"(r10), "r"(r8), "r"(r9)
+		: "rcx", "r11", "memory");
+	if (ret < 0 && ret > -4096) {
+		errno =3D -ret;
+		return -1;
+	}
+	return ret;
+}
+#elif defined(__aarch64__)
+#define HAVE_RAW_SYSCALL 1
+static long
+raw_syscall(long n, long a, long b, long c, long d, long e, long f)
+{
+	register long x8 __asm__("x8") =3D n;
+	register long x0 __asm__("x0") =3D a;
+	register long x1 __asm__("x1") =3D b;
+	register long x2 __asm__("x2") =3D c;
+	register long x3 __asm__("x3") =3D d;
+	register long x4 __asm__("x4") =3D e;
+	register long x5 __asm__("x5") =3D f;
+
+	__asm__ volatile ("svc 0"
+		: "+r"(x0)
+		: "r"(x8), "r"(x1), "r"(x2), "r"(x3), "r"(x4), "r"(x5)
+		: "memory");
+	if (x0 < 0 && x0 > -4096) {
+		errno =3D -x0;
+		return -1;
+	}
+	return x0;
+}
+#elif defined(__riscv) && __riscv_xlen =3D=3D 64
+#define HAVE_RAW_SYSCALL 1
+static long
+raw_syscall(long n, long a, long b, long c, long d, long e, long f)
+{
+	register long a7 __asm__("a7") =3D n;
+	register long a0 __asm__("a0") =3D a;
+	register long a1 __asm__("a1") =3D b;
+	register long a2 __asm__("a2") =3D c;
+	register long a3 __asm__("a3") =3D d;
+	register long a4 __asm__("a4") =3D e;
+	register long a5 __asm__("a5") =3D f;
+
+	__asm__ volatile ("ecall"
+		: "+r"(a0)
+		: "r"(a7), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5)
+		: "memory");
+	if (a0 < 0 && a0 > -4096) {
+		errno =3D -a0;
+		return -1;
+	}
+	return a0;
+}
+#endif
+
+#ifdef HAVE_RAW_SYSCALL
+/* The two calls which need no ring, asked for with a descriptor which is =
not
+ * one.  A refusal is decided from the syscall number alone, so the argume=
nts
+ * only have to be ones the kernel would not fault on. */
+static long
+io_uring_other(int which)
+{
+	if (which =3D=3D 0)
+		return raw_syscall(SYS_io_uring_enter, -1, 0, 0, 0, 0, 0);
+	return raw_syscall(SYS_io_uring_register, -1, 0, 0, 0, 0, 0);
+}
+
+static const char *const other_name[] =3D {
+	"io_uring_enter", "io_uring_register"
+};
+
+static int
+check_deny(void)
+{
+	struct params p;
+	long rc;
+	int which;
+
+	/* io_uring_setup() first, because its answer is what says whether the
+	 * filter is in force at all. */
+	memset(&p, 0, sizeof(p));
+	errno =3D 0;
+	rc =3D raw_syscall(SYS_io_uring_setup, 8, (long) &p, 0, 0, 0, 0);
+	if (rc >=3D 0) {
+		close((int) rc);
+		if (prctl(PR_GET_SECCOMP, 0, 0, 0, 0) !=3D 2) {
+			/* No filter is in force, so this kernel or this
+			 * architecture could not have one installed and there
+			 * is nothing here to test. */
+			fprintf(stderr,
+				"test-io-uring-deny: no seccomp filter in force, skipping\n");
+			return SKIP;
+		}
+		fprintf(stderr,
+			"test-io-uring-deny: io_uring_setup was not denied\n");
+		return 1;
+	}
+	if (errno !=3D ENOSYS) {
+		/* Refused, but not by pseudo: a kernel which never had
+		 * io_uring, or one with it switched off.  Deny's promise is
+		 * kept either way and there is nothing to tell apart. */
+		fprintf(stderr,
+			"test-io-uring-deny: io_uring unavailable (errno %d), skipping\n",
+			errno);
+		return SKIP;
+	}
+
+	/* The filter is in force, so the other two have to answer the same
+	 * way; anything else is pseudo covering only part of what it said. */
+	for (which =3D 0; which < 2; ++which) {
+		errno =3D 0;
+		rc =3D io_uring_other(which);
+		if (rc < 0 && errno =3D=3D ENOSYS)
+			continue;
+		fprintf(stderr,
+			"test-io-uring-deny: %s was not denied (rc %ld, errno %d)\n",
+			other_name[which], rc, rc < 0 ? errno : 0);
+		return 1;
+	}
+	return 0;
+}
+
+static int
+check_passthrough(void)
+{
+	struct params p;
+	long rc;
+
+	memset(&p, 0, sizeof(p));
+	errno =3D 0;
+	rc =3D raw_syscall(SYS_io_uring_setup, 8, (long) &p, 0, 0, 0, 0);
+	if (rc >=3D 0) {
+		close((int) rc);
+		return 0;
+	}
+	/* ENOSYS from a filter an ancestor installed, which cannot be removed,
+	 * or from a kernel which never had io_uring; EPERM or EACCES where it
+	 * has been switched off.  None of them is pseudo letting io_uring
+	 * through, and none can be told from the others here. */
+	fprintf(stderr,
+		"test-io-uring-deny: io_uring unavailable (errno %d), skipping\n",
+		errno);
+	return SKIP;
+}
+#endif /* HAVE_RAW_SYSCALL */
+
+int
+main(int argc, char **argv)
+{
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s deny|passthrough\n", argv[0]);
+		return 1;
+	}
+	if (strcmp(argv[1], "passthrough") && strcmp(argv[1], "deny")) {
+		fprintf(stderr, "usage: %s deny|passthrough\n", argv[0]);
+		return 1;
+	}
+
+#ifndef HAVE_RAW_SYSCALL
+	fprintf(stderr,
+		"test-io-uring-deny: no direct system call for this architecture, skippi=
ng\n");
+	return SKIP;
+#else
+	if (!strcmp(argv[1], "passthrough"))
+		return check_passthrough();
+
+	/* Deny, and this is the first of the two passes: arrange the
+	 * precondition and come back through libpseudo's constructor with it
+	 * in place. */
+	if (argc < 3) {
+		char *args[4];
+
+		if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) !=3D 0) {
+			fprintf(stderr,
+				"test-io-uring-deny: no_new_privs unavailable (errno %d), skipping\n",
+				errno);
+			return SKIP;
+		}
+		args[0] =3D argv[0];
+		args[1] =3D argv[1];
+		args[2] =3D (char *) "installed";
+		args[3] =3D NULL;
+		execv(argv[0], args);
+		fprintf(stderr,
+			"test-io-uring-deny: cannot re-execute %s (errno %d), skipping\n",
+			argv[0], errno);
+		return SKIP;
+	}
+
+	return check_deny();
+#endif
+}
+#endif /* PSEUDO_HAVE_IO_URING_SYSCALLS */
diff --git a/test/test-io-uring-deny.sh b/test/test-io-uring-deny.sh
new file mode 100755
index 0000000..6c09ee6
--- /dev/null
+++ b/test/test-io-uring-deny.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+# Deny is the default, so the first run says nothing about the mode.  It s=
ets
+# no_new_privs itself, so it is checked whatever the machine does about th=
at,
+# and it decides the result: a skip here means this kernel or architecture=
 has
+# no filter to put in force.
+./test/test-io-uring-deny deny
+case $? in 0);; 77) exit 255;; *) exit 1;; esac
+# Passthrough can only fail the test, not skip it.  A filter installed by =
an
+# ancestor cannot be removed, so where something upstream of the test has
+# already denied io_uring - including pseudo itself, when it was started
+# somewhere no_new_privs was already set - passthrough is not reachable, a=
nd
+# the run above is what there was to check.
+PSEUDO_IO_URING_SECCOMP=3D0 ./test/test-io-uring-deny passthrough
+case $? in 0 | 77);; *) exit 1;; esac
--=20
2.34.1

