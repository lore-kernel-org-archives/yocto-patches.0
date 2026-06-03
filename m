Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2F0CD6E69
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 17:45:08 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.25929.1780508700025528632
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 03 Jun 2026 10:45:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=chZj0XQw;
 spf=pass (domain: ericsson.com, ip: 52.101.72.39, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1RrVHixRTkZMt4H77Ulv+7odPsf4CNBrQfesVp+/aM7BuuQOMQ4NR8rdGP/i+iSiMVTLNZXNCFtxNmv4UAt2oHtrenb3IWhz4Lv6Lyhs3hIVl2gbty3ma/B+Q+2F6VLyQ0+Y0dCv/jEkHI3mYjH2Cqx3FRN7GZTLtAXRqU/hTvRKeQKb2ei0KWLyU/ZccwhYvfadwD5Ad6f/sXcfxTAi3JEXnPbRIqZNRjK3iPI9te4pn9Gx2TfiEVpG/dzmLfRYuVbUCc47vfE9ldm3oU9dbZUT2iz6mG120fuxMIj2NIquEQ8wErT0OFL7ug5Hy9fEKFU0xNDsC+GdhcfuGTx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLG6ShM4JQ8xhBnUOvGl+RUGuHy771BkRi57olPWNaU=;
 b=XhpRE2rL/Y//Rg7AjM1bPzQR5o3sDFA+w1vIzYZPwsaf44smYie2YpeiaPDXGZb7mmwcBXzFGBnu1x70Ya+LHThFs+xkPMiI85U2dBglMrNGn0i700AYiFfud4xup7s03KhWHqg8yM3ovxe4MUQVVtmXqf40wIhekR2QK+WHrXDdDLohHhq8Ifb5yI6QHTEzlZUMxjBADYZkX7EgyJEq3io/9O1S+qYz6YY1e7I/tgVD2o3105+rpYimQIhysfAwPuXQjKADaGJy4BcqtabJGoyLmnHq7y0UmCx3HPoC+Sy8RcjFo/BNNesTcOI/ZCWkXT87iGB+tJwLdxTY7ArYmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLG6ShM4JQ8xhBnUOvGl+RUGuHy771BkRi57olPWNaU=;
 b=chZj0XQwcXEQK71bY4h0a60rvLviSwNrEvnCeyi/qne82YkjGoeQlU+v6AkKtgD7kEzHMrJnKD3vLGZNi9WjOAmFv9UwA3j6qpf9D3uU5LCMKY/yBG7alArNFlUQjRMevvGa0t6TSldfDTvnlEOl267B+44HrmiANwlWDYJt6dQFtyZKaO4uGj93UtolaLsJ0YzNH2rOkJxVyUiOUDg8ff3MKhMrSEVb+ME0+d5hbG+ctI/5lNwYwnScpvWxEORZaxHx8HgsrdQFeWl0VLw2vC8HUGp2nECHJ15iOrSAIhjJtPzxU6fsG/sJt2Vsbz0dXuu/2ZjGPTPzCussdQgqEg==
Received: from AS9PR06CA0620.eurprd06.prod.outlook.com (2603:10a6:20b:46e::18)
 by AM7PR07MB6263.eurprd07.prod.outlook.com (2603:10a6:20b:138::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 17:44:55 +0000
Received: from AM1PEPF000252E1.eurprd07.prod.outlook.com
 (2603:10a6:20b:46e:cafe::4e) by AS9PR06CA0620.outlook.office365.com
 (2603:10a6:20b:46e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 17:44:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM1PEPF000252E1.mail.protection.outlook.com (10.167.16.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 17:44:54 +0000
Received: from seroius18813.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 19:44:54 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18813.sero.gic.ericsson.se (Postfix) with ESMTP id 2D76D9569E;
	Wed,  3 Jun 2026 19:44:54 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 168787003739; Wed,  3 Jun 2026 19:44:54 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <daniel.turull@ericsson.com>, <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>
Subject: [AUH] [PATCH v2 2/2] upgrade-helper: remove unused UpgradeNotNeededError
Date: Wed, 3 Jun 2026 19:44:48 +0200
Message-ID: <20260603174448.3479497-1-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252E1:EE_|AM7PR07MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a7f9f9-2839-4998-f3e8-08dec197d271
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|56012099006|11063799006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: 
	6McDMnvafDNw1BWDSSVe7pdr7SwOhELxJTzB5RvnZRnnATUaYqKV23Bob6GqIqZsEde7dtjdFshh5CMoLEec6PkhmOYd1+fYDk8XEOefEz0RJ048eHezAI1nEgBP9HNV29odtSXCoAbX2qcK3EQ4ScCku+ge2PI+bqOYyN1v7SLulKGTMIdVSttyLT/JJpLmA6PUhxaAE9ZotdCnT2XcXGecUeIsOglatot5sc4FD2/2gUUcrO3SnXDoYAev5hE/oT/uFXKvseT2wnWwvT3VimytlEWtsXU2UA6ErSt3GEetdMeHboZ/xC//xKDGBDoqFrQmoi8GqKAB6CFqVftYn6P7STOV3ToxIlpEvzX1U4pjeFImH5rXK/HHPU7eLVcQnS6r8p9/FdvYt1FJM4k7J7WCSNyZmlqT81wXxVNO9YxFqRPonJtKUJLnzeqtbNd8LLTNdLqtqt9hh4X27sDSP+Y42m7o0Ieh6HtIQ00Qovpgiw3MGd21Us5bSCEmQMtCBPiFfSiRS6axGx7X4OLt+WolrC+WCvfa7fTffDX9v66XdgewuMR/3aKtvQ22aA0cuDXyKHI4U2z4tQE38D/EIl0HtA68oAobObvj4Uib+c4QcBQt8PZWxlrKPgBiYebdiWcfWPCO0Ul46MMt7x0KSNRtNVInKa9sM++hcv5MrNuldzObTw/aKLsRs2J3dvwJ381kzsHr/qIJ9V0O9FRvqJVo0A/SgVKVW4SKBJ8ax+k=
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	21x9kcdiVLtlwgsJQeVsgxLBE6Nxxy123gXNV0x0CyXeX0wzYWjPFA68oXtAI/XkRMB6KjlABWQBSMxbehJlDDfvVQ094NURJJzNTsUbDVH634dFDBH5uSboH3HMdzqd9v8eCEchyR4mcD0iwK30IclT7pihNIadpsdZilJDZcx7PtT1kKIH51Z+IGF6YyMnmMQ4RscninzBJbrr7+25xwTVOA9IWeJOGHEckwT9NJgd7GFJhBfmACS7vwaqILy2zieB0LOoQ9fMX8B839/c/ghDqDeEDZg/4Xj5Av54WA9ZpLmgBCHoUZgGREhS0YBjaT6rrLlXxBVXMyvgONhIF+t32rkimGDEdp2A92Ysb2pbL3cDLeFjVZhKG9jc65Z0xu7GuVrwXVk1xvWRkk5m0ILFmVugFJY6h+5A83FjWZNohaCV9tMe2s+g+GFqtg10
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 17:44:54.7524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a7f9f9-2839-4998-f3e8-08dec197d271
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM1PEPF000252E1.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6263
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 03 Jun 2026 17:45:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4123

From: Daniel Turull <daniel.turull@ericsson.com>

UpgradeNotNeededError is never raised anywhere in the codebase.
Remove the class definition and all references to it.

Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 modules/errors.py     | 7 -------
 modules/statistics.py | 4 +---
 upgrade-helper.py     | 6 ++----
 3 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/modules/errors.py b/modules/errors.py
index 7adb103..9e8e6c9 100644
--- a/modules/errors.py
+++ b/modules/errors.py
@@ -89,13 +89,6 @@ class UnsupportedProtocolError(Error):
     def __str__(self):
         return "Failed(Unsupported protocol)"
=20
-class UpgradeNotNeededError(Error):
-    def __init__(self):
-        super(UpgradeNotNeededError, self).__init__("Recipe already up to =
date")
-
-    def __str__(self):
-        return "Failed(up to date)"
-
 class EmptyEnvError(Error):
     def __init__(self, stdout):
         super(EmptyEnvError, self).__init__("Empty environment returned", =
stdout)
diff --git a/modules/statistics.py b/modules/statistics.py
index 864cce8..227f0be 100644
--- a/modules/statistics.py
+++ b/modules/statistics.py
@@ -34,9 +34,7 @@ class Statistics(object):
         self.total_attempted =3D 0
=20
     def _update(self, pn, new_ver, maintainer, error):
-        if type(error).__name__ =3D=3D "UpgradeNotNeededError":
-            return
-        elif error is None:
+        if error is None:
             status =3D "Succeeded"
         else:
             status =3D str(error)
diff --git a/upgrade-helper.py b/upgrade-helper.py
index 46311f0..913bd87 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -49,7 +49,7 @@ import shutil
 sys.path.insert(1, os.path.join(os.path.abspath(
     os.path.dirname(__file__)), 'modules'))
=20
-from errors import Error, EmptyEnvError, UpgradeNotNeededError, Unsupporte=
dProtocolError
+from errors import Error, EmptyEnvError, UnsupportedProtocolError
=20
 from utils.git import Git
 from utils.devtool import Devtool
@@ -527,9 +527,7 @@ class Updater(object):
=20
                 I(" %s: Upgrade SUCCESSFUL! Please test!" % pkggroup_name)
             except Exception as e:
-                if isinstance(e, UpgradeNotNeededError):
-                    I(" %s: %s" % (pkggroup_name, e.message))
-                elif isinstance(e, UnsupportedProtocolError):
+                if isinstance(e, UnsupportedProtocolError):
                     I(" %s: %s" % (pkggroup_name, e.message))
                 else:
                     if not isinstance(e, Error):
--=20
2.51.0


