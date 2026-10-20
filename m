Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3294.1792487356736634852
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Oct 2026 02:09:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector2 header.b=MfU568GI;
 spf=pass (domain: ericsson.com, ip: 52.101.70.12, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwaV9Was0RVk4K+uhVs4JHP4Ccys5AFugYWsWQmDBhwMP6YhnBWg6pN6F/y9JN5SryKZv6+FUruiGS+uazln2VXBhQEo4HsqHpg1zoqR6c4WY/mmBd8PHX2IPsxSfnkWavQeWLzeTVhTXPKImEV5gODIagrpbRfu+a+6lv9I09ilsh1mkRO+0tqAZjpN3RkOuxhdhpRKER/NmK7DjItsTYpJQCZvPTvNzjzRzh1fcJerJeSpRCXYPP+OmCW50bJenV25cn7U9HhoLnq75dRiLtOSiXYECsDbvs8fBCi99qKPfMB3Mg4IVbI4JDxvCjsT0ZyVMfSnCZNNTxKHC6P6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ninWXbaf3+Cz7QrMh0drtjmIJzRRSofkyNy9YNQVdjA=;
 b=LNs1v1CkWHpTrUlM47mkMiynjsjrGxCfDmLPUfZPnqtVgkA6oYo3uuDXWK3RTigjAC81jJDgXsPE4wrU5KeJG8lqqd3LzsEZUayJuU5FJ8mROqxQMkZdlNAG6mAaj6nL9rHhHb7jskPMIbfWQvj/zJJ6MXQ8R5m8saI0qvoP3jjuXouAQr8MPLz//mu/VguPqL2eKw6uFI3WLbu1dTNrKci+lPblwVYiB+gqTuVqluy0wwfHOh/i/Q7lhRAM1abS+j03Fs8KUN4n5hen+rejStvrHrNIiRecr6rhUkG8LnRpsvNkzVEvn4QbKzgwUvEt89mLFXsUXgn92UqD/NSXAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ninWXbaf3+Cz7QrMh0drtjmIJzRRSofkyNy9YNQVdjA=;
 b=MfU568GI4kTDkpCiwiriEgwkF801GNNtp9/yWBpqg4B0atorgTjoCvkrL+RWfFZ0uyLpRqu24ZJ2lYX9mj1XZttGWWPSAEEd0F449/3rA+DYwD5kSMYhUMBuYFtuWvQ+PCYKrFiY1wO4amxaMRI3cGoedonLqpzuYIvsthyZF8j/Fx6qly58YX67lgdpXtXcWHqemb6BxwJzUjZaX1hanpbFS/yQbhO38y+5Ovnbg8DPDeMhC9KBRfuxETM3lvpgvwIhzc8yuzPYsjrcQopUqABEJPiQdR93DdGlocurSYVAeQ7n1U+El8WMdnCXhR308jCRNsAhtm72GMoHIz0ZFA==
Received: from LO4P265CA0163.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:312::7)
 by PAVPR07MB9213.eurprd07.prod.outlook.com (2603:10a6:102:319::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 09:09:11 +0000
Received: from AM2PEPF00070CF7.eurprd02.prod.outlook.com
 (2603:10a6:600:312:cafe::1d) by LO4P265CA0163.outlook.office365.com
 (2603:10a6:600:312::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.27 via Frontend Transport; Tue,
 20 Oct 2026 09:09:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74) smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM2PEPF00070CF7.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 20 Oct 2026 09:09:10 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 20 Oct 2026 11:09:09 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id B4B8B4020C02;
	Tue, 20 Oct 2026 11:09:07 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 795CE700CF34; Tue, 20 Oct 2026 11:09:07 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [AUH][PATCH] steps: add changelog_skip_recipes option
Date: Tue, 20 Oct 2026 11:08:31 +0200
Message-ID: <20261020090831.3132131-1-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: edaturu@ericsson.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF00070CF7:EE_|PAVPR07MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c243b2-acd8-4bca-baf6-08df2e89cdcd
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: HSSgoCrE+2v32/3ROWJUiCCpKdJO43e65pp6XIOIiW8QkwINxXkmM12Zgeyf5zojLdw6D1WPHzzSdUdH3R7qH0b7OdnoMpe8rkSsriKaLUC+S0KhBRV/ZkpF5vao/zmbkJOf/Z5UlJG4/LqRZfhDS9X32w/LVSAwcyTeutw09hlvCch2iRw/gnQhU7psoQpMBmrw8QAF4VjZeQLyf4tfD7qfVBkdASxEzVdmRGeyCz8jW5Ux7M7osTWNBhMBUvTo2KWJD4Yo+Vo5aAJWb/1Jh0UxDkskFsj7hSTyg/whZli2iuPTDgJLYW0+G4CchvURuy8zaY00/f76viaroYPDmwgsKbo0Fwez2ksPicptt/7AY1YQO1ujOCUlcZwjfUKQbRfNFbIUp52cQDjI4F6CpUOGhTEiKfcNaaS+0S5j60qmpbKTswid93bBjadEOEQM2M+tOfluKARDotJjN0SDVU1jEQdQSsAdO+ynuD4PWEpCAjYFvyxx81ijfGdgh3etwTnNfE9RH2fimQqNeKzHFdY7NEvq7/+LOSgYmFUSNBI06qeLYHd2TEbn3oaDcCnFh1fAUdJhQN5SHgdn8+jeF80p4y7ITDwODP7MMCGcEADkyupOMHTunFFF0gXIaLGEgSTgHaxKbAA1RpyDXB8qwQEl2I33VAF5sHJ2BrM2ad9UF0aMsJhurK2Nui0Ymu1UmCwHzxJDggFGWa7XivLB0Q==
X-Forefront-Antispam-Report: CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cpCgQgniiFSETGNOW+wjPkftihy+UOhR0MGYK2e5ZtEQw91cICgs6h5YKovJGbEeiWe6uyL2ca89XVzxCIbak74mMIKRhkIJNS1XS4GCZAFu2C32N5p4Z1XRbjiWhRNKdistqfYZRzgVI9FcWxQkF/S307unLcfnAwhgAAt8+u8TytSZ+9IAZfxb0n5BveuK+DZLOBfuY4YzzvGdnSsMGv6XOW7DSzzyXZ/TvhaG397eY0AoqQjnMMku2OedtuS0WFzh1keWgw26yVO7GhthL8+8qeSS5MIa9lXfXRmFAT2wPpazP51KCz01+qCL1RtPBuQ5gGrUFeGXQQaFeRGsqxjO2RHYXO2YXjpBdQ9h94V2K9VOk/Ca4euFe3OA2MB2+uEQ3ionQ7zmfUmvN5O9vJzq3RSuYwfNxHPIrAABOzW6NBYL4dhSdsvi4u6nyG8K
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 09:09:10.7306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c243b2-acd8-4bca-baf6-08df2e89cdcd
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF00070CF7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR07MB9213
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Oct 2026 09:09:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5107
Content-Type: text/plain; charset="utf-8"

From: Daniel Turull <daniel.turull@ericsson.com>

Some upstream changelogs are badly formed or too long for a commit
message (e.g. mesa, gstreamer release notes, raw git log dumps).
Add a changelog_skip_recipes setting: a space-separated list of
recipe names (shell globs allowed) whose changelog is not added to
the commit message. The changelog file is still attached to the AUH
email. Default is empty, so behaviour is unchanged.

Assisted-by: kiro:claude-opus-5.5
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 modules/steps.py    | 5 +++++
 upgrade-helper.conf | 5 +++++
 upgrade-helper.py   | 1 +
 3 files changed, 11 insertions(+)

diff --git a/modules/steps.py b/modules/steps.py
index e678a4b..7dcc614 100644
--- a/modules/steps.py
+++ b/modules/steps.py
@@ -19,6 +19,7 @@
 # Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-130=
1, USA.
 #
=20
+import fnmatch
 import os
 import shutil
 import re
@@ -102,6 +103,10 @@ def _append_changelog_to_commit_msg(group, opts):
     for p in group['pkgs']:
         if 'changelog_text' not in p:
             continue
+        # Changelog stays attached to the email, only the commit message s=
kips it
+        if any(fnmatch.fnmatchcase(p['PN'], pat) for pat in opts['changelo=
g_skip_recipes']):
+            I(" %s: changelog not added to commit message (changelog_skip_=
recipes)" % p['PN'])
+            continue
         text =3D p['changelog_text'].strip()
         # Group recipes may share a source and produce identical changelog=
s
         # (e.g. mesa, mesa-native); skip proven duplicates, keep the rest.
diff --git a/upgrade-helper.conf b/upgrade-helper.conf
index 26db0c5..d3f5eed 100644
--- a/upgrade-helper.conf
+++ b/upgrade-helper.conf
@@ -145,3 +145,8 @@
 # commit message. Longer changelogs are truncated. The full changelog
 # is always available as an attachment.
 #changelog_max_len=3D5000
+
+# Space separated list of recipes (shell globs allowed) whose changelog
+# is not included in the commit message. The changelog is still attached
+# to the AUH email.
+#changelog_skip_recipes=3Dmesa* gstreamer1.0* gst-* cmake*
diff --git a/upgrade-helper.py b/upgrade-helper.py
index 56b1f02..a6b2e29 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -220,6 +220,7 @@ class Updater(object):
         self.opts['buildhistory'] =3D self._buildhistory_is_enabled()
         self.opts['testimage'] =3D self._testimage_is_enabled()
         self.opts['changelog_max_len'] =3D settings.get('changelog_max_len=
', '5000')
+        self.opts['changelog_skip_recipes'] =3D settings.get('changelog_sk=
ip_recipes', '').split()
=20
     def _make_dirs(self, build_dir):
         self.uh_dir =3D os.path.join(build_dir, "upgrade-helper")
