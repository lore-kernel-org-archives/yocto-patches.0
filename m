Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FF7E9DE76
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 09:08:44 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.20])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.127867.1775725717043017081
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Apr 2026 02:08:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=mU5GhVjP;
 spf=pass (domain: ericsson.com, ip: 40.107.159.20, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiWnZfyZ1jC90jTloqjeTDhBRwylkDjgKXAfcxrYsfSVm+YaqCiRrQyQdwi13qIWBKszNplPz7bTp7xjPKDo0gDVgmDyMzTTDvH8XTteFauZ0Du0IIhfhuPiIqHNWS7WOspmfNmxG+DagcQz0kwhjlw0xPW9FswbQfmJIJWO45iXdzTHVq9XUI3OXraGNVE9GEf6VEktTDJ20NfWILf+aCAOvXghoiW0TmxsFfxehbcRrb5tqCsQh3t6+yXnPRxA2ktJkiaWf4hCd+pPhf+lLGFdqFBlTDcuQ3ZAbclnQIkMXC39OrQ9R9YoZQQkJRVDabUwnNegtlsU1ULiakbKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCxHrNV82YBK02wk4VklnU42lwbG7TRJDRKN5TcqxqY=;
 b=GPkR6Xl0Jd+d/nf4JUC3l1DBBMT6p9lRWzUiUxSmEvClthMJlaVqI1CcynDPCZ84jTPKDMK/Y/S2dzcfDPYcjFFo56BMH0VdPnWSkE9eSHhGIbFIz/8fY4CcvxLgH+ni+U1w5QUcR8QCPZl3NHwIlUnHFQMQLcQKrRozdXK7l6/DcV+AA53ZuJ/JMFkLG/04PWP3NXTPYd74vsmP5vCoPXtsPKkkNzC2f66wXZGYckrTQkx0/sj4edDCsc01ycH3e86jpTqBQVOPIku7oZ0JnYf61qysyFaB7c1/Ccd50aTZo9st/yPZkGLcOgCaKbW0X800G08KDUwO+dYJpzYTgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=arm.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCxHrNV82YBK02wk4VklnU42lwbG7TRJDRKN5TcqxqY=;
 b=mU5GhVjPBSRM02dYG+Ezf89dnmjYwPojlEE3XYIGbK1yhAOFQo/Iwy+HYMd+LjjxR6KDMTLcriB+tGRoDcN5ajuBXPkJvRvbLWC2MGk464VMiDy1u/nQ1AbdsJ1xa/14OIsKoc5quNQnsOYhzKeUZKW4J5IgRIq2LjI7OwzvyC6XVDsbfjkZxqDwqb9zmirDOnbSQbcwXY53PI+vQ2V3cEyzbRajFMlsRkQuq4hHJJqKcJrPzR93Q47Nomiqg09eg5ZjT0/q2gQZkiFxIq7V9HQsd494t2VBbKbEWoEdd5YLePf1FgRcYr2IZB0ryAaIysPFQW0Iutm/RmRtaDCZcw==
Received: from DU7P194CA0011.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::17)
 by AS1PR07MB8664.eurprd07.prod.outlook.com (2603:10a6:20b:478::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 09:08:29 +0000
Received: from DU6PEPF0000B61C.eurprd02.prod.outlook.com
 (2603:10a6:10:553:cafe::4d) by DU7P194CA0011.outlook.office365.com
 (2603:10a6:10:553::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Thu,
 9 Apr 2026 09:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU6PEPF0000B61C.mail.protection.outlook.com (10.167.8.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 09:08:29 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 9 Apr 2026 11:08:28 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id 68A5B4020AA4;
	Thu,  9 Apr 2026 11:08:28 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 20A69700DBB4; Thu,  9 Apr 2026 11:08:28 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <daniel.turull@ericsson.com>, <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <paul@pbarker.dev>, <ross.burton@arm.com>
Subject: [AUH] PATCH 6/6] upgrade-helper.py: Add resume option to skip already attempted recipes
Date: Thu, 9 Apr 2026 11:08:15 +0200
Message-ID: <20260409090815.1731294-7-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409090815.1731294-1-daniel.turull@ericsson.com>
References: <20260409090815.1731294-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61C:EE_|AS1PR07MB8664:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e35b94-8203-4c6c-3944-08de96179125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	byQH27xupvSERYQNl83iiFn0abwXiSk57gozpNGthg4fCbRh495XU3oSMXnepnNHxoS53Bpd+3ZgnsEAKMwtyTNT8shcg39qOibDFYP+xYmxH3qH3VJBchMOO2pOLustOYln1qofQgnCeOBY6FlFg1CBoJGqHWtkfAzWeLbtQ1ucNBCTbl8qP3QrQXWb9eg2yziH19VgY80vNUrQETsJ/WObJVr4dbBHvb1kR40jb+qCkeyzUiZdzZFr+s3yi2MPl6KV+iO29R1WQ2OgV+VtAHC6OTzBDGpzVzaOiCfdshLd9CkGIHwoRd1s0vuOcmveVSp9rWN3i1+y2e/nH2qCEuZV+PfLXsf1YpzYVxiaQp7I3i3xo0x4F/qw+N3o7XDuS6+zH97AORL4kV+FUh9xlS3T4LS5ZiB542p3P83eg1ahhn+dpEm6ZfHPJaTy5RFQirtEfW5a7GmC1yDwX/2cMlGDR2qhRGUJZYImI3s2dE6/fzm46ES0QLdG6FFOeNwCRTz/RONxsvZihkbEDa3hqSwgacLlLxjouzPgqEVWeXe0utdHQWpQ01+16VLlZYhNeYte01TUR+KjUaFPBUtfMaldwSrQlmsDMirDeJyesSk+4GBLdJlHuNxBkPfgoQLWF9lolhRgSKgo3hB58V7nCohpQL0Q3qsyHs+yZj9KVb6uJB+4AZ68M1KlbPUfEfjUXOJ/VALvHHAro52/43Inos8D38MR6O96S7ohsDTQO4o1/VIeiWnzpzjIlCfk0lq9aVwvAOadjwLwuA3YokUDmQ==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	MW6MoLOa9x2VBp5V4lO4aw3gq65k7ScUGBkk6quH8AJGiT1UwnUkiuN5Lppt2lwW36T/9Q6mQGKJz6jD0ZNSE5fhAPwMGFBWo1lvXRn8i7xN6u65aH8h94bzxgak4zNncl/JTCBRexw4hLxau/aT2f7QqVxBQKB3Xsa5YyGQsgq4mWrju1UKV5MCFeaN3GzvVrQI/8aQ78H/yBEmv/yOMuS2Ng5HNuLdb9/AKRCmtVDLIL5RNtHY0twbETr4BxMdcS8Rua3ZK/SyAcHpt4JlX6Nh5PuoQu8mw4AtoKINkIeKX+e8UkhEhmKxZykQvkWKqdVTxpNmJ41nEvtIPS7cmg+pYLSullvOpDGy+lLls3DdWBJPSTcriURUov6Cubh0+8+pIfiaAeUXYsEnMw9oufGvubpl3r/rNLvcV/p6M1uPyQW3IXq3DTrgUnz9o2Jc
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 09:08:29.5944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e35b94-8203-4c6c-3944-08de96179125
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB8664
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Apr 2026 09:08:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3672

From: Daniel Turull <daniel.turull@ericsson.com>

Add --resume option that reads the most recent run's log and skips
recipes that were already attempted (either upgraded or failed pre-build).

This allows restarting an interrupted run without re-processing recipes
that have already been handled, saving significant time on large runs
(e.g. 12h for 135 recipes).

The skip set is built by parsing 'Upgrading to' and 'Pre-build FAILED'
lines from the previous run's upgrade-helper.log.

Assisted-by: Claude, Anthropic
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 upgrade-helper.py | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 945c4fc..c552379 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -108,6 +108,9 @@ def parse_cmdline():
     parser.add_argument("--prebuild", action=3D"store_true", default=3DFal=
se,
                         help=3D"build each recipe at its current version b=
efore attempting upgrade")
=20
+    parser.add_argument("--resume", action=3D"store_true", default=3DFalse=
,
+                        help=3D"skip recipes already attempted in the last=
 run")
+
     parser.add_argument("-d", "--debug-level", type=3Dint, default=3D4, ch=
oices=3Drange(1, 6),
                         help=3D"set the debug level: CRITICAL=3D1, ERROR=
=3D2, WARNING=3D3, INFO=3D4, DEBUG=3D5")
     parser.add_argument("-e", "--send-emails", action=3D"store_true", defa=
ult=3DFalse,
@@ -515,9 +518,33 @@ class Updater(object):
         succeeded_pkggroups_ctx =3D []
         failed_pkggroups_ctx =3D []
         attempted_pkggroups =3D 0
+
+        # --resume: skip recipes already attempted in the most recent run
+        resume_skip =3D set()
+        if self.args.resume:
+            import glob as _glob
+            prev_runs =3D sorted(_glob.glob(os.path.join(self.uh_dir, "20*=
")))
+            # skip the current run dir (last entry) if it exists
+            prev_runs =3D [r for r in prev_runs if r !=3D self.uh_work_dir=
]
+            if prev_runs:
+                prev_log =3D os.path.join(prev_runs[-1], "upgrade-helper.l=
og")
+                if os.path.isfile(prev_log):
+                    with open(prev_log) as f:
+                        for line in f:
+                            m =3D re.match(r'\s+(\S+): (?:Upgrading to|Pre=
-build FAILED)', line)
+                            if m:
+                                resume_skip.add(m.group(1))
+                    I(" --resume: skipping %d recipes from %s" %
+                      (len(resume_skip), prev_runs[-1]))
         for g in pkggroups_ctx:
             attempted_pkggroups +=3D 1
             pkggroup_name =3D g["name"]
+
+            if pkggroup_name in resume_skip:
+                I(" SKIP PACKAGE GROUP %d/%d (already attempted): %s" %
+                  (attempted_pkggroups, total_pkggroups, pkggroup_name))
+                continue
+
             I(" ATTEMPT PACKAGE GROUP %d/%d" % (attempted_pkggroups, total=
_pkggroups))
=20
             # Build current version first to verify it builds and seed ABI=
 reference

