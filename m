Received: from CO1PR03CU002.outbound.protection.outlook.com (CO1PR03CU002.outbound.protection.outlook.com [52.101.46.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.567.1794855829177344781
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 11:03:49 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=yk4dRZ2E;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.46.49, mailfrom: mark.hatle@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oW6ic1yIwCWksfZV0MW/ClP8obmRobINfCeONFtKsSFEPWZ8L4kS3hetztz41eOXpKlIY21vkDwOl9dk6XxhOOUm2fQRek1s23kcj8Jv5TOS3Qt9OXWdjbfJJcZ6LBIBGdEb8hp0N5xPlU/3LlkYplmcN+W/FA4j+J51BCfjhfi7obk7QsHnmNXLlkASU6WVOw8DZ8E8KKccA1c0M9IM9oqoHIT2xhgBEv9gxQEOEb9oKqWc4zHX16aUF1MTyveZWxUGw5/yGUPPx7eKJhsYJpNdMQoGqesFH2it+Qy3d4ioWdybKgwxup8k0EypWWjgZ3ezGtw3R5+gzqV36hH5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4tukbZdGeMNNb68rTCIzOdnMLFudk/nGLv43+sakYo=;
 b=V7Wi27l5KgedKYtv0swqooLIymCOaF0sq73HeOpqoHG7b5GnKSThoaK0s71vsjS73GGW1xs1HaDNyaXUIwgw1jSrICBWt2+StN2Z3gHoJP9dfeD+12apB1Sk9Ns5iaRj7Ds5Nqs3EgRURJyITGvWuM3bEWkHTGtOVoQ8sHWSwLaKV5e36P5VPZjYOaAPPIldHtNEHz6ACr/iffxKn45463xPtGPsOXTkZcqzCx84BAfh4nwrqDyGmUj84GMWCh6HxFg4ySIRikb3vz28wF0jPe36501JR8WWOfYFX53w66Q7U/STOWPgO52xHOHha53uuxw0WtemWWMJnmc8fM8AKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4tukbZdGeMNNb68rTCIzOdnMLFudk/nGLv43+sakYo=;
 b=yk4dRZ2EEL/opkICuKg1E4NUO9mdbA1YojnunrFk0JlWHbD7YYe3OdLYnqRH8h1LSD6KBhc47Z4X1QsNC6qyc01+lZCRTzXdmsjy7dGBfsU1cWMPLBtC0Rn0kjp2kvdfuZ6hKlqZyQGyCx9oi9PaEHWxim8o3/SQRCM6tf9glDA=
Received: from MW4PR03CA0272.namprd03.prod.outlook.com (2603:10b6:303:b5::7)
 by PH9PR12MB135921.namprd12.prod.outlook.com (2603:10b6:510:412::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 19:02:46 +0000
Received: from CO1PEPF00018867.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::62) by MW4PR03CA0272.outlook.office365.com
 (2603:10b6:303:b5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 19:02:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00018867.mail.protection.outlook.com (10.167.249.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 19:02:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 13:02:45 -0600
Received: from xcolc230100.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 16 Nov 2026 13:02:44 -0600
From: Mark Hatle <mark.hatle@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [pseudo][PATCH 2/2] pseudo_server: Log when running in a confined SELinux domain
Date: Mon, 16 Nov 2026 12:02:44 -0700
Message-ID: <20261116190244.2205781-3-mark.hatle@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261116190244.2205781-1-mark.hatle@amd.com>
References: <20261116190244.2205781-1-mark.hatle@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: mark.hatle@amd.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018867:EE_|PH9PR12MB135921:EE_
X-MS-Office365-Filtering-Correlation-Id: 8334db7f-b214-42a7-cc93-08df441432ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|56012099006|11063799006|261026121527099003|261026140227099003|261028144727099003|261022115727099003|261022075727099003|261022105027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: thKRdvE8eetV+CLOgxzmAYv9GsbOG8R8NkbLkM34++P86h/loeiztWeMqObceWj8Dmw+CHHVtCgvYoPI0S7/p1Db5kgW6KsDZgO+6GVq6/ewEAolBMVm3EiX8+XtmUJ9OnwhWFQngdTQ186pF2mRLrFL87/M02GxNwrulI45oSvXzMhOp1woKhwN1zbmFztR8SNrIv5cLC3GwceWYdnw+HOpWIjo7JUFG2w5v5CRbEm+6BFqbBg+I8S3NCmPUy1k08zQ0HZH9luitHQF6ORHHChFEmD3vuG5K4RNPy13g6LGksAI97bnWctBQfgHDIat3xHfWJ5zZIwsfLh3JZM0sZqN2WIDhy8ZNDqFr03QpCsH//dikvVzY2vtmXwCkSf25aLJ3fnEZUW2zb1BlnwOMAqBeCeA/l0Uz68+yLEv7dgN1NiHEpoPJ2YQm3c6mJb8Ibi3aE6hRyaDtOt2fHXnH4sJfxmOq7M/r889kWvBpbFXBXpfPtF8Ab4PZornMRDxzkaxY7dAG7QoXVdi+bIfmfYf+3dPDyXsiC3Qp2SEUniScnqgxSvAhlfzTzcR1g3kYYHk5TgFAqXFrt6qqpZFG3WV0RSZsm/CxR5/0kvB5JoLMJY/h4MyARDSAdWPcZolhTsQYDEeUTB+yBJsMPxVWXEqKJYEgl/5+skMhlPaM0Aa+jwH/hwkJe+x48vjQWTBi8iVzFTTsAVI9x43AZHQTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261022115727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ItTQH6ZxWvuP0oh/LFrxy7T7/Djxi/jFB4x0ANTOnyvj7dGa6xjekcvTQk7IXRONB4skeyCQhlUmlwXmE0AZJT5IMMJtP9EX/rvB48zWxt3aTp3Pwpn3Y+Zu7Y0iyEBlRpegNjGdsgK4DWEIi5z+KcEyelWquh3CInqguE8wdkBvSX3j8x29sj1BGNwwYijLMGQEoPl68BxZsNw8Ezi8Nj1XCDn2eU75p15zN6fqSsB2HCnfYYrst6tQ1Z8cWlEsObnzT8dnSIQzWDp/c6OX7qudYRGt8sTqHWvfLjxymkrF4qztxM+JLw/USNGv0KNlI6NigypcQmCaBqwUMdqCaaIOfsVSRatI16o8kEoyCqslw/96fYpwADHwts/hs3wia6Rjewu2+0evQUt7H0fLDs37DjKl3kKnFMj5i75EdyDgOzyKQgsb5pMhZicKiRls
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 19:02:45.3287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8334db7f-b214-42a7-cc93-08df441432ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00018867.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB135921
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 19:03:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5417
Content-Type: text/plain; charset="utf-8"

SELinux-aware programs are now told SELinux is disabled, but the kernel
still enforces the host's policy on what pseudo does for real.  A build
running in a confined SELinux domain, such as user_t, can have file
operations refused that an unconfined user is allowed, which isn't a
supported environment.

When the server starts with SELinux enforcing in a domain other than
unconfined_t or unconfined_service_t, log a warning saying so, so that
failures caused by the policy can be recognized.  The server runs in
the domain of the build that started it, and reads
/sys/fs/selinux/enforce and /proc/self/attr/current directly, as pseudo
doesn't use libselinux.  Document both this and SELinux being reported
as disabled in README.security.

Tested with the two files replaced by test copies, as this host doesn't
use SELinux.

[YOCTO #6580]

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 README.security | 20 +++++++++++++++++
 pseudo_server.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/README.security b/README.security
index 496524f..4067f96 100644
--- a/README.security
+++ b/README.security
@@ -169,6 +169,25 @@ to programs pseudo does not intercept (see section 1),=
 and the Landlock
 calls reach the kernel while PSEUDO_DISABLED is set.
=20
=20
+8. SELINUX IS REPORTED AS DISABLED
+
+SELinux-aware programs, such as install, label the files they create
+from the host's policy.  Under pseudo the label is only recorded, which
+is wrong for target files, and a program that hands a recorded label
+back to the kernel, as sed -i does through /proc/self/attr/fscreate, can
+be refused (YOCTO #6580).  So under pseudo, is_selinux_enabled() and
+is_selinux_mls_enabled() report SELinux as disabled, and these programs
+behave as on a host without SELinux.  Labels set explicitly, for
+example by setfiles when labelling an image, are still recorded.  The
+host's answer is only given while PSEUDO_DISABLED is set.
+
+The kernel still enforces the host's policy on everything pseudo does
+for real.  A build running in a confined SELinux domain, such as
+user_t, can have file operations refused that an unconfined user is
+allowed, and is not supported.  When the server starts with SELinux
+enforcing in a confined domain, it says so in its log.
+
+
 RECOMMENDATIONS:
=20
 * Run pseudo only on build output that is private to the build and is
@@ -183,3 +202,4 @@ RECOMMENDATIONS:
   security relevant files in the final image.
 * Where pseudo cannot install its io_uring filter, disable io_uring on
   the build host with the kernel.io_uring_disabled sysctl.
+* On a host with SELinux enforcing, run builds in an unconfined domain.
diff --git a/pseudo_server.c b/pseudo_server.c
index abe8897..0a30b27 100644
--- a/pseudo_server.c
+++ b/pseudo_server.c
@@ -143,6 +143,65 @@ handle_sigalrm(int sig) {
 	got_sigalrm =3D 1;
 }
=20
+/* Read a small file into buf as a string, without a trailing newline or
+ * NUL.  Returns the length, or -1.
+ */
+static ssize_t
+pseudo_read_small_file(const char *path, char *buf, size_t size) {
+	ssize_t len;
+	int fd;
+
+	fd =3D open(path, O_RDONLY | O_CLOEXEC);
+	if (fd =3D=3D -1)
+		return -1;
+	len =3D read(fd, buf, size - 1);
+	close(fd);
+	if (len < 0)
+		return -1;
+	while (len > 0 && (buf[len - 1] =3D=3D '\n' || buf[len - 1] =3D=3D '\0'))
+		--len;
+	buf[len] =3D '\0';
+	return len;
+}
+
+/* SELinux-aware programs are told SELinux is disabled (YOCTO #6580), but
+ * the kernel still enforces the policy on what pseudo does for real, and =
a
+ * confined domain can refuse operations an unconfined user is allowed.  T=
hat
+ * is not a supported environment, so say so in the log.  The server runs =
in
+ * the domain of the build that started it.
+ */
+static void
+pseudo_server_check_selinux(void) {
+	static const char *const unconfined[] =3D {
+		"unconfined_t", "unconfined_service_t", NULL
+	};
+	char enforce[8], context[256];
+	char *type, *end;
+	size_t len;
+	int i;
+
+	if (pseudo_read_small_file("/sys/fs/selinux/enforce", enforce, sizeof(enf=
orce)) <=3D 0 ||
+	    strcmp(enforce, "1"))
+		return;
+	if (pseudo_read_small_file("/proc/self/attr/current", context, sizeof(con=
text)) <=3D 0)
+		return;
+	/* user:role:type:level */
+	type =3D strchr(context, ':');
+	if (type)
+		type =3D strchr(type + 1, ':');
+	if (!type)
+		return;
+	++type;
+	end =3D strchr(type, ':');
+	len =3D end ? (size_t) (end - type) : strlen(type);
+	for (i =3D 0; unconfined[i]; ++i) {
+		if (len =3D=3D strlen(unconfined[i]) && !strncmp(type, unconfined[i], le=
n))
+			return;
+	}
+	pseudo_warning("SELinux is enforcing and pseudo is running in the confine=
d domain '%s'.  This is not a supported environment: the policy can refuse =
file operations pseudo performs, and builds may fail.  See README.security.=
\n",
+		context);
+}
+
 #define PSEUDO_CHILD_PROCESS_TIMEOUT 2
 int
 pseudo_server_start(int daemonize) {
@@ -244,6 +303,7 @@ pseudo_server_start(int daemonize) {
=20
 	pseudo_info("pid %d [parent %d], doing new pid setup and server start\n",=
 getpid(), getppid());
 	pseudo_new_pid();
+	pseudo_server_check_selinux();
=20
 	pseudo_debug(PDBGF_SERVER, "opening lock.\n");
 	lockpath =3D pseudo_localstatedir_path(NULL);
--=20
2.34.1

