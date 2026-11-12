Received: from SN4PR2101CU001.outbound.protection.outlook.com (SN4PR2101CU001.outbound.protection.outlook.com [40.93.195.17])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.992.1794502061038918510
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Nov 2026 08:47:41 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=zXkK/6c1;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.93.195.17, mailfrom: mark.hatle@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+E1/1kfCEoQ7I+PMPeZ2bihmJmbs56+d8TtuphEBaSMnRT2rtLSqAFLPKUo7s8hDhrkLZCC8qNFPHfyjIo38df+MbhFlnbjwEyaG8XAzRnAJMoOAb7JW+cOUz1ZmqgVGtsDflLuE1n/1v2aAgTsrC8bJbAlLdbxzn80nQNQan+05KXhqbs6UCu1irchj7xFp0DPuFbW8NIX0raN+ZpuQwjszKyVqChStdyTfL6nLSeMom2ELa3B1gOB/fEDEiKQMnZwAiDEEKz4z8GK/Pi1P9cVXcUVfj0rRrZg0GttpTy2ZroBittsBEuV/xWm5fybqQZOY/+t6inMmzXRiFwwLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UO5kCsAHCn8OFllNrZUiXYHbctZ7RO4avjnH1bNnmq8=;
 b=Ls6f5gsJ7bUjwYGwu7Oi7KVT6KCPX6pcwRfwCHTVcPEJpviWqnIFoAZRpwjBR/3zRv0jCrjRJVmZdBe06czfIQRUMUCSuFWQlN1NcbNRUReBKxecrxwR6Rn2/GIoc5M/DZcBChC64oPebs2lhgVM0rTO5KYpHDBfX7Srv35WVqbqdarrgFHDxRvlEhghQaA1396iSHxIH2UPJlx1dJLyjJ8/g2/h4LUVSmwLBv3CsyQsT0eD15o+YcidbNdcK9NJUS0VV+q8qETSRZK6d4yS9H7/S1fvHtiZKANc4Ce25bcYXoekl/UOIwYxtI/7/attCUoY5hLYIe5BZfssy3WBfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UO5kCsAHCn8OFllNrZUiXYHbctZ7RO4avjnH1bNnmq8=;
 b=zXkK/6c1mF28PSlKevTefLM+/V8oGGlmDnc7E3x9I4LfH27e/OIGwhurmSFg/ws12L+PjlzUhIa/xVzzZy8jqCM6G+BabTkGyvt1d5K3LmoEWyTaZ4ERhRBI1HgWGyGYWJVmMb3bwOhQPsXWtK5whdaM5R4KKwpzLRP3E6NkNpw=
Received: from MN2PR14CA0028.namprd14.prod.outlook.com (2603:10b6:208:23e::33)
 by SJ0PR12MB7473.namprd12.prod.outlook.com (2603:10b6:a03:48d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 16:47:36 +0000
Received: from BN3PEPF00022BBB.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::3) by MN2PR14CA0028.outlook.office365.com
 (2603:10b6:208:23e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 16:47:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BBB.mail.protection.outlook.com (10.167.248.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 16:47:36 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 10:47:34 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 10:47:34 -0600
Received: from xcolc230100.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 10:47:34 -0600
From: Mark Hatle <mark.hatle@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [pseudo][PATCH] pseudo_client: Fail when the local state directory isn't writable
Date: Thu, 12 Nov 2026 09:47:34 -0700
Message-ID: <20261112164734.488457-1-mark.hatle@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: mark.hatle@amd.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBB:EE_|SJ0PR12MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 96fb95b4-ec70-46b3-3145-08df40dca7bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|261009223027099003|10067099003|11063799006|56012099006|261021121427099003|261022105027099003|261102123227099003|261026140227099003|261028144727099003|261026121527099003|18002099003;
X-Microsoft-Antispam-Message-Info: rzBJ67OIeGIkFFVODCrWLWtsJx6UmstGE2BAXFpYlVFMdFDkxOix5fob76WQMaXkXN5roLmjgIaSbc6wBGH+83bF/Rm3T7msFvL5ud8HcX1nX9LRKgKHApjTvKeBCxwqiM1iSL29r2oOpwaHL6TTfkeTBefaA6dNjdD22jRmc0VHS94MalXCWxULhCnr0EfQ1/40zhVW9ng+S/+HOoaGA/IstJZogx3kGffmAITEdHCry+Hq2UH8cpdQx3k7xMk8+6X6eWQzH6j1d7eJ4IczxKZTCVgWWHiV7/qeE1SBNNeLCmnTZhhmCSmXHcsk+awHIozh99NQ9Vv079qgkE1IKolztE8+OZW0mYvk0/qi7z8PNPUQn+rDiYV3Rne/d0SNS/03mhqgyYrpt8c53UDKmklrow3/JR5nmpo17z0I9PqXAZJl9gcrtTeMT34KeZ0MsM1lMrzO0/7MFazs1mSNI7Dv5Gqsi0CemNKlSf8fgqy2rulTnYv74MvJFi1yAwiCvBbLHLlQZCdUZkc2adUPbp3n4353xdqyAijJ4ZQL6P1mkNRtPM61nLUSQB5pwC2jchEVxW8f0b++GKkWFgZzM1uBLXgZPK2PpnBIUZ3/9wPFA/22djJpiL+dqNXBUWtyZvJnQEa65zsrqExY5f2BcBS1i1WShNbbCN3nUlr1aXxR3S1rJozb5reQMzlvH73y9dT5CKtHcY46FjbAa1OJQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(261009223027099003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vPAK9D9IziMe2a+tN9vzG0yVFbtkmtR8o1VbPtyIA6pLk1IzFAYSkQyYJ4k+4wDD3abw8Nua51XiQ4ziQShm+Xk4G5tIconRyQv+s9/McucT2bqM+Rsaj/LNbA0kHPzrt/+5FkjEa3p4ookirgcO3T4kb6WLJEqT0bm7UBKvT+yRVWtZ5vlL1GlU4zfCTPiGTZLUURv/AWhHsUhVCWjq4DOoVJL5Gpah0IJcQ7SAXXoqco63A0CRLi61xfN6L0n7+aEfb/4cQqsxe5KUdeURW7+voqY5bBhKovfNm8z0w90m32CiOrOiE+cqC5hkLspJDk89Fyj94xYJITNW5qfHZ/NMVPtPPFKxPZS103SHhOy4fpCE3O/KLDIM0padGKUr/car0W8QacVyEKINSFvKUvFVK3wX822MYY3uPrWmKie7/ZMcvZEaB6qhRdn4//iV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 16:47:36.0768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96fb95b4-ec70-46b3-3145-08df40dca7bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7473
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 16:47:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5332
Content-Type: text/plain; charset="utf-8"

A read-only PSEUDO_LOCALSTATEDIR was only opened for reading, so clients
kept spawning a server that couldn't create its lock file, up to
PSEUDO_RETRIES times with an error each time, before aborting.

Check the directory is writable when the client starts, and fail as for
a missing directory.  The server makes the same check before creating
its lock file.  The client also aborts at once if the server exits with
a status retrying can't fix; lock_failed is still retried, as running
out of file descriptors can cause it.

Tested with a chmod 555 directory, a read-only bind mount, and by
starting the server directly.

[YOCTO #15497]

Reported-by: milahu <milahu@gmail.com>
AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 pseudo.1        |  3 +++
 pseudo_client.c | 26 ++++++++++++++++++++++++++
 pseudo_server.c |  5 +++++
 3 files changed, 34 insertions(+)

diff --git a/pseudo.1 b/pseudo.1
index 2475631..be0827f 100644
--- a/pseudo.1
+++ b/pseudo.1
@@ -703,6 +703,9 @@ database files and log files; by default, it is the
 .I var/pseudo
 directory under
 .BR PSEUDO_PREFIX .
+It must be writable; if it is not,
+.I pseudo
+fails at startup rather than trying to start the server.
 .TP 8
 .B PSEUDO_NOSYMLINKEXP
 By default, when chrooted,
diff --git a/pseudo_client.c b/pseudo_client.c
index efb5662..44a6b88 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -608,6 +608,16 @@ pseudo_init_client(void) {
 					strerror(errno));
 				exit(1);
 			}
+			/* the server can't run without creating its lock,
+			 * socket, pid and database files here, so fail now
+			 * instead of repeatedly trying to start it
+			 */
+			if (faccessat(pseudo_localstate_dir_fd, ".", W_OK | X_OK, 0) =3D=3D -1)=
 {
+				pseudo_error("Local state path '%s' is not writable: %s\n",
+					pseudo_path,
+					strerror(errno));
+				exit(1);
+			}
 		}
 		free(pseudo_path);
=20
@@ -1028,6 +1038,22 @@ client_spawn_server(void) {
 		} else {
 			pseudo_evlog(PDBGF_CLIENT, "server startup apparently unsuccessful.  se=
tting server pid to -1.\n");
 			server_pid =3D -1;
+			/* Retrying can't fix these, so stop instead of
+			 * respawning the server PSEUDO_RETRIES times.
+			 */
+			if (WIFEXITED(status)) {
+				switch (WEXITSTATUS(status)) {
+				case PSEUDO_EXIT_LOCK_PATH:
+				case PSEUDO_EXIT_PSEUDO_LOADED:
+				case PSEUDO_EXIT_PSEUDO_PREFIX:
+				case PSEUDO_EXIT_PSEUDO_INVOCATION:
+					pseudo_critical("server failed to start: %s\n",
+						pseudo_exit_status_name(WEXITSTATUS(status)));
+					break;
+				default:
+					break;
+				}
+			}
 			return 1;
 		}
 	} else {
diff --git a/pseudo_server.c b/pseudo_server.c
index 7016adc..79365e6 100644
--- a/pseudo_server.c
+++ b/pseudo_server.c
@@ -266,6 +266,11 @@ pseudo_server_start(int daemonize) {
 		exit(PSEUDO_EXIT_LOCK_PATH);
 	}
 	mkdir_p(lockpath);
+	if (access(lockpath, W_OK | X_OK) =3D=3D -1) {
+		pseudo_error("Local state directory '%s' is not writable, unable to crea=
te lockfile: %s\n",
+			lockpath, strerror(errno));
+		exit(PSEUDO_EXIT_LOCK_FAILED);
+	}
 	lockname =3D pseudo_localstatedir_path(PSEUDO_LOCKFILE);
 	if (!lockname) {
 		pseudo_error("Couldn't allocate a file path.\n");
--=20
2.34.1

