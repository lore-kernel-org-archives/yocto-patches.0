Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEB3CD6E60
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 15:50:31 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23419.1780501826831772798
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 03 Jun 2026 08:50:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=kyrOFoOe;
 spf=pass (domain: ericsson.com, ip: 52.101.83.55, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hy79APsewybkGA82gHMB9mHdoN6R1Z33MGUY9zOcGbXbnDJ2BDaoCXIKHkz8nmF1ZHxIyG5h1tkv6ERZjHqIyretbihuT8N/ggDJZXW43Sll1aUxwS8R5epcksBSCLWGaDOUcZBa01xDPuw9GdCBytc0I5+/R3OGXDJyUE0SqnpaTSa0iTx57TZBp7As39oMHAzmkkjYlQ1NIoXZYtiKW2Nhf8A1cMhrc/I8kMBVN54l4780qOCBgg/dCCk0w2kEbNctyLSfrZT1W5vBdV1zCBRMoZzecW/moAqJb8JBDR3WQua+oYM8R3de0JnONq8PqRrT3UtMBxc60ZFeO9Zlhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hf9aTICH2DltyvFE2ycQqKfSIxuqQN4i0sYpY2nLg18=;
 b=XU3PJVcye1bluanXAW7RkgVQ3HV8M5Otpyb1w4Cb8MB6tnV+S4JwiSi5zT17Do7y95XyZUdlOoYHmgE1fRI11VcSND2iy7gaenEgSRL2PGIFGFJckYpAt8n6FA/M3k4gSHxvsBhe4hBHm+Sv+T55hsSDRGaf1kgOu4r5hiWDBSTbv9zsKnIRYVHP6JRvkqVoWaCulZw4zgLE7ndcY8SRd9HOhbnpTSIGHxeorSsqZ53ikIIH+oO+oE5OXmH6AeS3aC/1JoHqH77RHW9pbYpkHdJpwC687JSSxY2NawkhH0mzAYD1ANvPhiPPxNVkbmY3T/y/n2jTPQsUMTz5A5J3Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hf9aTICH2DltyvFE2ycQqKfSIxuqQN4i0sYpY2nLg18=;
 b=kyrOFoOeH0e4Bv94aT+Uk4JaoTOn6zVmPJJykcPLimGbTKm0FP1oMyHKsWXwizuw8glMXlcEmnwC3HSIsiR82QzIBOoqU8mI62Uv8Eux13BN+v2Cfzx1taH4UG864UzPSq7ijiYndgGdq095tW6LlM1iV/8qdlRUmoibKh56XgcvYN8XzQ871Vz23wU5HZ1XxW5+uosEzjVu8X9YMSFi7QL70qec8OR72FCOc4EfhPre2ly72w5gekavkUvit2LGbmSMT6qO3jqfaseW1uI23TTEqRttKCKZTGAPztzYjLwAPqtGcbqOYzrpoOvPxTXrdM9h163bE8D1GH6ZnF0u5g==
Received: from AS8PR04CA0134.eurprd04.prod.outlook.com (2603:10a6:20b:127::19)
 by VI1PR07MB6510.eurprd07.prod.outlook.com (2603:10a6:800:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Wed, 3 Jun 2026
 15:50:21 +0000
Received: from AMS0EPF00000199.eurprd05.prod.outlook.com
 (2603:10a6:20b:127:cafe::9c) by AS8PR04CA0134.outlook.office365.com
 (2603:10a6:20b:127::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 15:50:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AMS0EPF00000199.mail.protection.outlook.com (10.167.16.245) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 15:50:20 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 17:50:04 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id C1E7E42150A1;
	Wed,  3 Jun 2026 15:41:00 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id AD03C7003739; Wed,  3 Jun 2026 15:41:00 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <daniel.turull@ericsson.com>, <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, Alex Kiernan <alex.kiernan@gmail.com>
Subject: [AUH] [PATCH v2 2/2] upgrade-helper: remove unused UpgradeNotNeededError
Date: Wed, 3 Jun 2026 15:40:44 +0200
Message-ID: <20260603134044.3377639-2-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603134044.3377639-1-daniel.turull@ericsson.com>
References: <20260603134044.3377639-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000199:EE_|VI1PR07MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b36a4f-cc42-4ec2-9b06-08dec187d155
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	A1unR4uuUOLy0r2UhBQX9Pb5T/D9IqymuyFJmOm5WlnDqToVopp+L2f4tNE2m/7Cr7vPU7eixjKq1LMLIX8Re8Qj4jbFDM2ky9+2wHlrBsnTVgd4Ac/OmN0NcUrPocz4XBMSlEug1A5RQJPw5aM1VN/j1EiLQOZoa5Y/Ha16mn8waf9j47h8avOxcJ0/fsTSK8fOffr2eRXaiVt3jaEtI1KUcxoJ1Xj/mC9Mclojff/7In+DUC/a8BlJ6/Qh8gHion/9cO9bRSmMVcG7Ekiffei/i05aQkPBysD8+Lx+/rG/jjnjrYVGV7aCS3DqXvfd4YJGZRW9/C7JUDNkkE96UwY4IO3Wqpasl21Rs4GsZiIfSxZMF5LBtAoAdsoQYBFbUUDdn7JXC0mhAvOCPEs3NpP0k+hJTORQb30kfupZb+Kg2kcH39kxKnZPMYetNZ6uQ3l6dJbxGfWed6SRmHYEOK64T0M6riHEiefftBad6RRAKKKMJu+XYmMULy9fFqA7wUN2dn2frJDFLzbVwFwhE2qCskk8mrVwKjW0eFbqIAqhubebh1ErmKIQVgpKDOtfEsg/784sOjAOSDCDmrilCrhEbNGr3dMa8ygiLl1K0of5gSsUeDU4H3gzSutCqO/uynhpjZ4V+Y51UsmSd+xcBIdO5N82u9/QAToqOorqKcCkVlwFtPHeY6DEk3eJcwyj4E1XfER1WYsEgNYSH1GggqKgbdNq8QRZa/bjyHMKLWQ=
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Iws2yivQxBtjGcoPNvPOw/goRwFeFGQ3E2Z49hcl11tsTxHYimLnHdxjLVU52ne8GWlR84DPuDgJUTFEClG155PVYL12ZbHpZ9z7MkBHPPdh1WV36nDh4fNdocYFf9iGdvS9izPfYRmYLXrWqxUsdRDw6Ys76fK5l5bLzs0v5kpz42OzkkHte3f1U2iwLSOlJA4Y+n1VbEuQm1PpDAiNEa2fW3bcI6O6xLoELTzYLhugAlYMlpPRB3QY2a7aVKgZORvCw3x8ndqFVmMYC7t3O1aV9JHdXkXVOkef+9QclT26e0/TgdFXwqKvsWzB9Iv8b87ttHC/2si2Rsowksfg+qHJT//52hOBX5EW3d8EWIjlf8zX5clI3WwNKKvbXqolzTmLUot5dqY+evdA4Zfb8nbztgUxsyokZ4SXPFNWEO5o1EIZObQgy8IKahxImxD2
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 15:50:20.9310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b36a4f-cc42-4ec2-9b06-08dec187d155
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6510
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 03 Jun 2026 15:50:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4122

From: Daniel Turull <daniel.turull@ericsson.com>

UpgradeNotNeededError is never raised anywhere in the codebase.
Remove the class definition and all references to it.

Suggested-by: Alex Kiernan <alex.kiernan@gmail.com>
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


