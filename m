Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.26])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43277.1793022867673217322
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Oct 2026 06:54:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector2 header.b=TtQUfK52;
 spf=pass (domain: ericsson.com, ip: 52.101.72.26, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NE9Tol41HFL47JABudMV6ula9bwTKltuwyvydNmdeR3pAVYgHBVGlvcvAwi//VWkDV4G8aHE+P0OPaCbT+xdq1j7xfu0JainmOhag3gK+mH4cT1KQEHE0hmEQ7DsYpmsPhe4QLATABR6DmqD1GsGQvlC1w1zLOb7hC97p56gbt3O9WEls4wQnhbLDGrLaf82Ia62OhMlDUhl1aOYbKWqBXg90w73qFWrKkUyQcpXFsiUC4EPK7o7kz8fxuQTs2VhLsQgJoiyslXwQ8qIZTcAwm0Ain2B0CvqsLW58L8zorm38Z5zepU3HFtoVB6ZNMXpmZEyyCAbKA6oWKA0EqIH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iH/SqQjXmSFDM29F8uZD8vSYrUfmMwWET8HH9d3lZlo=;
 b=tPR2yCt7SmJjaJxM24NgdlR9/Pk3gQ9x/XgoBGbUW6oBQvij4cW2F7l3LfsA9W9lKqzQKdMCL6mtqZTbhmK2TivKWdMeecBsn7Ftjjzre9Rz+trgdLiNkTTCL5kFt6CEbQ+IkxYsJj48JKSYusQXLRx4AkTtrp1M9aFAj9nOMve9d0XuxAkQ+zS/y9yB/uWc/CM35kek/E2UpovPGnvAaLkCivkwNiDuD5teVPYmQQnblKQ9d9XQG1/hIY2XMOxMpTVelb2UeWvxQ+rchnbVhQpf0oBeaZm717zsWG1TZG9J9SolMvVXbPq7X3fw2szAlf11jY+IHfVw6kwHXpqK/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iH/SqQjXmSFDM29F8uZD8vSYrUfmMwWET8HH9d3lZlo=;
 b=TtQUfK52lfmf/S5mjORSRQKJc/5YHQwlnADsiukTC2Ewp/535HLfFBRX1Ma8U1JK9m1Dybqo024GCo+K+N07OK3oNsATu9bIBXWwiRIf7veml1I2gGXVgsUV2mdv4Ya1mEbDr9EPJdUVFj1y8idSDeNMXC2+sZBuJBpl7aZ1QsAJJjPkP+3iUwhxvAIwOdxrMOCexsD2cdnskEltzzBMGEdJwNePTkL7P3KSWRwEwVKZRCSIv8Q1twwM0WewISAxrHjz458fb7GrGGiq1k0qa2kOqnXBJdwSHF9GGwCkUIxV/4sYACTly9tAIYP6RIYdYiKPZ9JOFsjiXgMjOvjuEg==
Received: from DU6P191CA0072.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::25)
 by ZR6PR07MB997904.eurprd07.prod.outlook.com (2603:10a6:910:d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 13:54:23 +0000
Received: from DU2PEPF00028D03.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::54) by DU6P191CA0072.outlook.office365.com
 (2603:10a6:10:53e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 13:54:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74) smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU2PEPF00028D03.mail.protection.outlook.com (10.167.242.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 13:54:22 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 26 Oct 2026 14:54:22 +0100
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id 8889B4020B42;
	Mon, 26 Oct 2026 14:54:21 +0100 (CET)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 54171707242E; Mon, 26 Oct 2026 14:54:21 +0100 (CET)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [AUH][PATCH v3 2/2] steps: skip changelog in commit message when devtool flags it
Date: Mon, 26 Oct 2026 14:54:12 +0100
Message-ID: <20261026135414.3796371-2-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026135414.3796371-1-daniel.turull@ericsson.com>
References: <20261026135414.3796371-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: edaturu@ericsson.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D03:EE_|ZR6PR07MB997904:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ecb9948-5b27-4052-a142-08df3368a3e8
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|261009223027099003|261021121427099003|261022075727099003|261022105027099003|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: y98rjJOCFqwBGIkCs8v0SB7rF3zDLou0uAc98hBF5ULgcqDHk9PWotIQFUjdBZATGL0dNykaxOcvOu7jXfqwjGj0hGkVSpu4rhIwDwtlKKSYeg6A9xmeMdN2TNh7eiUnpnOtUASHVoEoWK2uZ/u+BsUlUZFInjOgO7FjKIc9PudSU5ItsSsYlmOABDn0iBi3phPdXLPi+UBuqA63SKA930XQypIP1xcgpXChJndtuWi/LquKoiep7+leABINwgCQmBsJEE5dHw7qs17GngA1HvwiSgaJ6Fl84yoBFGjIyoCsiTMiA9YBuzWJYMjiVJHo3e+/5XVE5fgxSaQcbp3ulgGb61YZO9bld+Bj0aC4Ikq4H0zqkc4O3fQ5Mues+XIB5LSgC94kUUKQihBlDlsT+sq/4IrotrbzCPrEiHlGc2qZPgi4OLBx8tBjka4ZWipZC6o8yDd9UGE2NWRyXJsQxVKWB4L47S/OIILTugmijrlW2Xsl14TCiEPq3fP/maDI4xhshGW9JItYmJ/IcFBheqD5QqjvDtFEyfp3TwILNm8S/sJmjg2+4kJquxI9qAE0c5AOpGVIbnehscyw421/gyu7dU9+shnrrElBcuAbC6Y6Bttps+UxLemWrlz26tNVF3eHLeqRzVRxdzKQ2LsOK5Qzd/6tsaTzlKCGX4hoNVU4+oZJCdmWNZT2c+YTY4qE4nn6DmZzk40qxQFBqb87Pw==
X-Forefront-Antispam-Report: CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(261009223027099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PEuaIT6Gbo31omJ25LVA4axRAsHe/R/LlT5wtoC9giVdArRvSBl0oieKms72nyfpK8E+YLK1OeR+urjCGOjSupRzYXitPJBsNZQsS0c/IXou3sduJ2OGbjjZrJrhGqrK2ntgBdEidzuTmm73lUctukTcOhMqMnvZsCdC6ZsIl79RXy62EW0OFq8vfdYsr8NQdXzaqLIqOHByF5FXq/r2jThJ9TVxeJbm3xUdDyt2mRyC2rWQFur6dMxpEux7XGeoWfNjo32dK22CQxeiNPxKivpRW0sR0xf29YW0/JTlaOr49fTntM6p0LD7yIMFMEFwLFOi1ikXxqNNrkv85ZbeEtnyefYmv6amRLJF76aLcdkhy/zmb0spXJQ6rQM5TPiefm8HvoNDXJQNZIanqyZe+dOzJxZzZsPOsVyaK52FLIk/yV1DpBK3u5GnzCOI6CZA
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 13:54:22.8647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ecb9948-5b27-4052-a142-08df3368a3e8
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR07MB997904
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Oct 2026 13:54:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5157
Content-Type: text/plain; charset="utf-8"

From: Daniel Turull <daniel.turull@ericsson.com>

Some upstream changelogs are badly formed for a commit message (e.g.
mesa, gstreamer release notes, raw git log dumps) and make the upgrade
commits hard to read. 'devtool upgrade' now flags these, driven by
RECIPE_UPGRADE_CHANGELOG_SKIP in OE-Core, so honour that and leave them
out of the commit message. The changelog is still attached to the AUH
email, so the information is not lost.

Older devtool does not write the flag, and treating it as absent keeps
the current behaviour there.

This depends on the OE-Core patch "devtool: upgrade: flag badly
formed changelogs in metadata".

Assisted-by: kiro:claude-sonnet-5.5
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
Changes in v3:
- Parse the devtool metadata JSON once and keep it in
  pkg_ctx['changelog_metadata'] instead of reading it in a separate
  _changelog_skip() helper (Alexander)
- Split the _get_changelog() refactor into a separate patch
---
 modules/steps.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/modules/steps.py b/modules/steps.py
index 0dc365c..4ab9272 100644
--- a/modules/steps.py
+++ b/modules/steps.py
@@ -19,6 +19,7 @@
 # Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-130=
1, USA.
 #
=20
+import json
 import os
 import shutil
 import re
@@ -80,6 +81,16 @@ def _make_commit_msg(group):
     versions =3D list(dict.fromkeys(_get_version(p) for p in group['pkgs']=
))
     return "{}: upgrade {}".format(pn, ",".join(versions))
=20
+def _get_changelog_metadata(metadata_path):
+    """Return the metadata devtool wrote next to the changelog, or an
+    empty dict if it is missing or unreadable (e.g. older devtool)."""
+    try:
+        with open(metadata_path, 'r', encoding=3D'utf-8') as f:
+            return json.load(f)
+    except (OSError, ValueError):
+        return {}
+
+
 def _get_changelog(pkg_ctx, workdir):
     """Copy the changelog generated by devtool upgrade to workdir and
     store the changelog data in pkg_ctx."""
@@ -97,6 +108,7 @@ def _get_changelog(pkg_ctx, workdir):
             return
         if text:
             pkg_ctx['changelog_text'] =3D text
+            pkg_ctx['changelog_metadata'] =3D _get_changelog_metadata(base=
_path + '.json')
=20
=20
 def _append_changelog_to_commit_msg(group, opts):
@@ -105,6 +117,10 @@ def _append_changelog_to_commit_msg(group, opts):
     for p in group['pkgs']:
         if 'changelog_text' not in p:
             continue
+        # Changelog stays attached to the email, only the commit message s=
kips it
+        if p['changelog_metadata'].get('changelog_skip'):
+            I(" %s: changelog not added to commit message (RECIPE_UPGRADE_=
CHANGELOG_SKIP)" % p['PN'])
+            continue
         text =3D p['changelog_text'].strip()
         # Group recipes may share a source and produce identical changelog=
s
         # (e.g. mesa, mesa-native); skip proven duplicates, keep the rest.
