Return-Path: <florian.schmaus@codasip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0F1FD5337
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 10:10:00 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.100])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.92369.1772186996567361447
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Feb 2026 02:09:57 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@codasip.com header.s=selector1 header.b=3UVar7nk;
 spf=pass (domain: codasip.com, ip: 52.101.83.100, mailfrom: florian.schmaus@codasip.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+0YCiK3YIimMf+2wjwQPaP/x5Ne/pYodREqA+RIZuWjM8VmglkN/fooevc189qhrN2EnHIVWNEfOEQR6UdhVepZd8HgIGEtamx8XEvf3JbNt1LcuLuwCo3ZMXppyElsURuIfmymDzx7qDigf23yG7WpKz8z2gdF9sM/9L55kdsfaX3Oa47cq2ZwrCNPHjnDNe9KzXdJQqbz6+4sMIRa4+vNzqmXDoMZhJJvW5z2bzGEEXzdJ1XcJSRto3jHn7w3E7oeYt1FrZi6PnbzNVxOSmSdheGd8ldo+HZU162m7FQkBH9Rc93LJ2AJ/67nepeHm8nWzRbcFi5tCI475G5huA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K31CCL7kB9xl0JViS5xyeeriYLUAfaGVT5+uWvFBRQ8=;
 b=ypFyMANBcJ/pFi4CxYdUgbID0UgGeTGVvfrhkjNuSFjTvCW1UrQxwdKQwf5ABnawgGRMALEseZ+tU9925fMwVCSEQbcZIiUhbPpvKEZgZHsm32bND4fBTVcmPr83CidB/gAjgMDJZmO5AbvPSth9UMoSKSZF8ydEnTSUm4f3YLALJBwib9Z9A/HeVyrztxl8z6SJsut1zx70mJfpZrzLbQUEVWGMN1ry0jMwjFvHhBlqIEUzNSaUcbhwyAdTCGD0NMwFhaNREpRrK2O99yXB72O6ROeQUYnYoJ58rzt9/GOzchYMYmnVLhSP2hzUs9YqC91vFcn31A2gKBA7fzyaQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K31CCL7kB9xl0JViS5xyeeriYLUAfaGVT5+uWvFBRQ8=;
 b=3UVar7nk0K89MEu32rWPIbaynpKW+aV4s8Kt7U2wQ2AUbX8uCd/sMIBxBXBR+MylQb5wtdgb0wajtZ/k0vVp4cMs/0T/YDkteq7g7so+j7G7Gm+7SgEAZGvvdxmbm+BD2mbYkCn6czcimUQgFrWHdu5xNsDnfg9AEQO27ehvp9QpBQvfSCjFZVVYzcVQrJpxDrEleoRrRaiowWTngawzvDG+5Sm+j7/o8YeGaeMBtP5OMUejCxuxo6uW6UaJ+xNNMlMmbHTVMyJmNJlqKcgPPSjAyj4sc/pMcuKtrosgUnfds54e3VsnLlRu7ZcPGh0v0ounBWO5pl6nBB1BmCHGQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
 by PAXP192MB1605.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:277::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 10:09:50 +0000
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::f0e5:8465:302:9a9c]) by AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::f0e5:8465:302:9a9c%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 10:09:50 +0000
From: Florian Schmaus <florian.schmaus@codasip.com>
To: yocto-patches@lists.yoctoproject.org
CC: anibal@limonsoftware.com,
	Florian Schmaus <florian.schmaus@codasip.com>
Subject: [PATCH] Fix dirname() handling in run_ptests()
Date: Fri, 27 Feb 2026 11:09:43 +0100
Message-ID: <20260227100943.284203-1-florian.schmaus@codasip.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0233.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::15) To AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB0983:EE_|PAXP192MB1605:EE_
X-MS-Office365-Filtering-Correlation-Id: d01eb45a-672e-49bd-312c-08de75e85807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	f6MU5iRrq0WoPILkISJp8p2JwFWrt4EUIb0bXmoJWkMATTBBeoBEe1a1xKYSKuF75n0AABep3RAo7nSpMJcSQXhnWUAlr5SGsyr44JHzgYm7ywguyvCF0uC34wbaWGjfq58IwprpV5Lh/bwN1vwii3BkcUH8HRzAe/LjlDhKMhhrn6QX1IJA9rNChGKbE719zkHTCRGtwMas8Ymsu/7vmraM9UQxDMZkcbR7qE/7LI9i3Vlm/jLelg5YAsCdGZDbGNVBVahZbZtVrfztrZFBpQaRRnKzcjkNB2Q3diOhzEEPSenWi3xZXSpLj4qti+Y5E/53aFQOyDNJ+voSzUNU2NDgic75EED2dJIWMeuIavaaW2YYuTFX0RDh2IhegTv+FRz3nM3lcygvx/fnqUT1+bCJfAve1F+Qxajth/PKMiAEs2z0sW5NqeHED1SbnaxigESZ96lq1L+Yr69/f5FMdJpAzvzwj7Ku9EcMtj+HXg5sQSM3s5dzAEgs1TMXGANHR+4i0NqLCYfjMmHTQN5kknFVfLuw545bERaIxc/WP6GGBrCGzQed/IALfRX/WhDQANmAWEk8ES7E3qeNGv+Ui57XYNJsDqamUylhOcU3ncXWVdJjH83wNa8YMAO5J4vZyhvvduNT/HDGQKhRTeVF8qfJ8ki4QSg43z0q3iH9MZmA3rdW3WVUzPcQ6TsuM7niEB7mEY4ZNSY088TI4ccZkfASgiga2YFCWEiAHQ/VWR8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB0983.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Upq4+RlsuvNNaJDo6Gwr+0vKqIBl5m4nmVgkmtC0FSd6g06A0K+EDVPGlGXb?=
 =?us-ascii?Q?fCWLB86nNMDidjHT5Np0axttskLp3fQqPCj6VFPIq4Iei5BNb8hhPSrhnSqh?=
 =?us-ascii?Q?tT+UhG4zFqlHHFkWurY4awgLbFdgKXsPD6pHFYuPPiqvDsNmqnoDnBTIxby7?=
 =?us-ascii?Q?i6b5yTzY4OW2jwXgV3YzTVKRcOA184ECUjpEKcxnC4A4WDSTFl2QDddlCH4l?=
 =?us-ascii?Q?jV4PrZJGV3kAQKBoOvH3OuM0+GOs1/XUNcb3y/QbKjCCPZXe7eXfcXRisAKP?=
 =?us-ascii?Q?ID2dqJtJ7EHOI4hrKU+ZF802gZTN6Qq3lW4YVYVKz+5iaF2xLTiXFRhOTkmD?=
 =?us-ascii?Q?ZZS9M5ahzuiNwB0NAj8QFM6DRKSD6F03ZZpGFKJZ2oyX1bqIVs7Pl5XEkjem?=
 =?us-ascii?Q?z3qoI9+otPbZTHmUxlSWcIYzzyyYj2WENTGf7IbGMceeTuJnPmvC+YdIbxdi?=
 =?us-ascii?Q?vg4d/iYSKpJgPscxF7/QsRSvRKAmODiiq1JPkTRonTSMfvU7lF6hMvseaHRM?=
 =?us-ascii?Q?cgWNr1BCrG6pXFRY/+cvLEFweYux1sP/kOKNuqOEpXaU6/r+2AQkABo4RtZm?=
 =?us-ascii?Q?/JQii1zIDM52DE/pk0t2BqsSvyJn31zSv8wZTDbw9tTWpsMMgzhjgC18Z184?=
 =?us-ascii?Q?wjqzYIy3D4uNFWWu7jmLCgFQ+1Blmm2uU4hs1kDj0S91VMltzh/lVis3VTPV?=
 =?us-ascii?Q?15WBulyxBpDqtjnlFp8HdQZdyCo/+zccRlDkOkQFiYtsPicfhAohA3eUt1HO?=
 =?us-ascii?Q?bYHG/JCvdm55xqaNE3m8ngPRsCs6pQjQiNZTxv9/RjRlS1mghE3mjlWtgyks?=
 =?us-ascii?Q?C0jD7UWAu6h40KwNFQVVMGhid6vZTU14hV5isKhEp/4KIabHG54BAYeXOvyf?=
 =?us-ascii?Q?Vh5cAGKXqahTYbIksg2ZBOmuY4P2gYOnZWN8K9cVWtLdznEJKz0IVLFRr6+E?=
 =?us-ascii?Q?wv7h8FvxLhVASan+GdmspXETaDWs/cpEdBT1Tz/DSPpPSVdGnQfZLDJWGUIf?=
 =?us-ascii?Q?miucj1bw3ZTUTsuhaeZTQcBm2iXWi16IBhKCV2vqtW81JpJz2zgSudhgimHP?=
 =?us-ascii?Q?pzs3lx9SAHscNikwULqPLbOEYyku51I+7JAtem8ZT9S/wN61fmgxcvJdKAJ+?=
 =?us-ascii?Q?XEegFeHGpTdJwczOVyta9RbBtWGt6q8YjLGS54YrA00y+B1lbb9cotzEX+I1?=
 =?us-ascii?Q?Yj5r+eYX4KfAiqZW8DMGxtyS6uCc3O+oQ3ywN+ttLyBQkdYeverbCidBnx/G?=
 =?us-ascii?Q?9vfKzXHuzE0wIwef7LTVDGruBKBaxzrlg3yKAzH3QumHYQybNXod/N8HH2D9?=
 =?us-ascii?Q?hCgICfArN4Dr4HGVC4Z3FibEuP9QnhCeU8v0Fmktx2gZjz4R8b1NDpPs42Ir?=
 =?us-ascii?Q?2nnKcCGB1hn8GUSanvPWltORy6Tsv3hwX36qhQq/XxPBGyOQorn4ze0YjXVR?=
 =?us-ascii?Q?/OPMCQCke0CYv/WSo659NoDiceJfKXlvfJIM19h0upO1fH0Kg7L804TG4U79?=
 =?us-ascii?Q?tqoyK5bMdgAVs/83E1sZGMFK5g9l9LkEtdU+i+7i5PSRo7ltiSmdsQC5Iaye?=
 =?us-ascii?Q?OauI0J/rFZzKIeJajoGEVzTyavcN8hPF4hs/aBlPpGFJwZjg1swtmoOMGJWA?=
 =?us-ascii?Q?ILHtw8Eu73mYpuhodq25wGXsYHT3UqSzAJMIGsVVwoPOi+al2dnqfV++luO9?=
 =?us-ascii?Q?glM4YvoPN+pOqFInbDo+LbVQLsX0t/5sYpBbRaXcfo5uOAohwmzs3RGHKh5N?=
 =?us-ascii?Q?IH/ZdaiBsQWaZ/NMex1CCeW735eTlk6J5U93aJlk4SzuooAHVTWLU7CZnWEu?=
X-MS-Exchange-AntiSpam-MessageData-1: 5/cw7iH1PaNb+pzA2QIO4LsiZ+3ZtoVwKI0=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d01eb45a-672e-49bd-312c-08de75e85807
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 10:09:50.3762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbXv+9pFpyEo2a7OJdOiaD65Z90ZhiR+hkgda5wwOV+p7AZ4TELAvuUa5faH9OCjzJ1cOk23ExmwRbrX83ra3U1hYmjR7eJ0dVVdgzpkr2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP192MB1605
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Feb 2026 10:10:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3298

It is required to use the return value of dirname() instead of
assuming that dirname() modifies the input string. While certain
implementations of dirname(), for example glibc, *may* modify the
input string, this is not guaranteed behavior. Musl, on the other
hand, does not modify the input string but instead returns a pointer
to a statically allocated string.

Previously, ptest-runner would fail on musl systems:

$ ptest-runner busybox
START: ptest-runner
2026-02-27T09:21
BEGIN: /usr/lib/busybox/ptest/run-ptest
ERROR: Unable to chdir(/usr/lib/busybox/ptest/run-ptest), Not a directory

ERROR: Exited from signal Killed (9)
DURATION: 0
END: /usr/lib/busybox/ptest/run-ptest
2026-02-27T09:21
STOP: ptest-runner
TOTAL: 1 FAIL: 1

Signed-off-by: Florian Schmaus <florian.schmaus@codasip.com>
---
 utils.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/utils.c b/utils.c
index 6cf7705586bc..7614dce99bd8 100644
--- a/utils.c
+++ b/utils.c
@@ -361,13 +361,19 @@ run_ptests(struct ptest_list *head, const struct ptes=
t_options opts,
=20
 		fprintf(fp, "START: %s\n", progname);
 		PTEST_LIST_ITERATE_START(head, p)
-			char ptest_dir[PATH_MAX] =3D {'\0'};
+			char *ptest_dir;
+			char run_ptest[PATH_MAX] =3D {'\0'};
 			int pipefd_stdout[2] =3D {-1, -1};
 			int pipefd_stderr[2] =3D {-1, -1};
 			int pty[2] =3D {-1, -1};
=20
-			strcpy(ptest_dir, p->run_ptest);
-			dirname(ptest_dir);
+			/* Copy, since dirname() may modify its input buffer */
+			if (strlcpy(run_ptest, p->run_ptest, sizeof(run_ptest)) >=3D sizeof(run=
_ptest)) {
+				fprintf(fp, "ERROR: %s exceeds PATH_MAX\n", p->run_ptest);
+				rc =3D -1;
+				goto ptest_list_fail1;
+			}
+			ptest_dir =3D dirname(run_ptest);
=20
 			if (pipe2(pipefd_stdout, 0) =3D=3D -1) {
 				fprintf(fp, "ERROR: pipe2() failed with: %s.\n", strerror(errno));
--=20
2.52.0


