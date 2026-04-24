Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9495BFE5211
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 11:46:24 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.23])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19021.1777031176774580837
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 04:46:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=it3uF/3a;
 spf=pass (domain: ericsson.com, ip: 40.107.130.23, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JY48y5rEVPnHAbmkdmPUcOEpymZys8aVM9JCZiYQPkKO5mLgBSh84vUPLbRMR4MuekoW//lk8EFKYYcV/ra6KSJxxHcAZWKO3GxB2WQsiz/4WfFvVHVsQuHYK/vxHfPDwCG35ZB6394+sr7nW4AJRp5Y/sqigRU/Y7ROExogEKDqZbTCqSMy+A10e9RtZ3/Lohw/YnzxlWngnYgoJ/F2GvfvuwqHj3A3k7F88bf/Ir68fqEECoLIE4n5VOgL6YVT+c+3XBJSRoJiXY8TxjgTczwWKXqcVfhWUxXgwzFX5YYF+RFpl3XUP4Gbu8hPpGxyBaNAKI05K6/1JhMzjv/qOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cNmn91x2R5sIBlD780C6jYjWPC3jDK6GwPBFNMI+Ow=;
 b=avc1hd5C40pOzCs3OVJhn2DnS4LphSTf3xKr36lXvxCCbSIcRTZAzBEpugnNnmeO+0dUMINjzBz0+BsMb0hnENxooN5ofEaC3/YuzO3iFyFanTUJIo2+IE8TfUMm5mxQwB+s8nIfi3mtxBl4HRmu0/jeul+QDNPtAM6s4bgFeiMJaNZUszTHBzJ1pWnJsQ3n+zLTuLNpLqQQI7KjdMC8a/4l9U+pAdKJ9Mvf/VIHCwxq1bfNddnqUb7CbtC0OSvw3e0ZAce0XmSTg8AgeeBtdKRrmvkHIXxVlqu/tZv0MMc1zC+8R9t5+qPoW9YaOL6fohsFbgbVwH4lM+QOzuxRVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=arm.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cNmn91x2R5sIBlD780C6jYjWPC3jDK6GwPBFNMI+Ow=;
 b=it3uF/3aOyCTNjfQQJS6n+nkhZDLaVS4wk/IPUOWdLAf7gqrKqVbQqw4Umyh9/jQFH/DJiqZ+1e8bNXPFQGYhgRJigzSX9WNfooA28bYfesot6gkdAfOzU/5bTjXb3qbvYXD2cnKcFJXJV3NtwTtUogEoi8Y/RZUDlG0hE9VaIm4EH48vhATYDATaoJbeCjPHQJbXoPzcV3rt2Ad9gMmBbrrGAM9UwMKd9DBl4EEDV4OVU4WHUJt1RedXuGwgk4+AX8Ws9SJLjLkDXactyOTxETkhkOIoVlKojYRzHZdQpYz451ZlumGBXOS0DLDX1dRun6GHtjcpPde9bdEwAdZAQ==
Received: from CWLP265CA0453.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b7::22)
 by MRWPR07MB11824.eurprd07.prod.outlook.com (2603:10a6:501:8b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 11:46:11 +0000
Received: from AMS0EPF000001A3.eurprd05.prod.outlook.com
 (2603:10a6:400:1b7:cafe::5e) by CWLP265CA0453.outlook.office365.com
 (2603:10a6:400:1b7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 11:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AMS0EPF000001A3.mail.protection.outlook.com (10.167.16.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 11:46:10 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 24 Apr 2026 13:46:10 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id E7CC94020663;
	Fri, 24 Apr 2026 13:46:09 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id D3F26700DB92; Fri, 24 Apr 2026 13:46:09 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <paul@pbarker.dev>, <ross.burton@arm.com>,
	<yoann.congal@smile.fr>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [AUH][PATCH v2 1/9] upgrade-helper.py: Add compatibility with Yocto scarthgap
Date: Fri, 24 Apr 2026 13:45:55 +0200
Message-ID: <20260424114603.2444938-2-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424114603.2444938-1-daniel.turull@ericsson.com>
References: <20260424114603.2444938-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A3:EE_|MRWPR07MB11824:EE_
X-MS-Office365-Filtering-Correlation-Id: 15fec10e-a644-4bbd-62da-08dea1f714c3
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	vauywhRmelElBFUU6OGiovgn59WhZFQJWqB2FadRorPw/C5rDWQnvAhzFl+NR0YFj6XUhx7nfwtSlfcynKZjvQLDFrcXx1cdqvwWVHPJ3faD/gPkM+534aCT57WNxbAmhap9t9HsgAO94dJATkPpTaPKca8F41UfDSfwH2EAvJe2izYnljcbSlqUyP5g1y/63t0ysthi2192xI3eeDupsgjxpohqb8QuEKEwwbI1H4ybsrIO6VIGfPKG0YNTbRFyNop8E37ZJKtz/v2HoEkHJlgdva4m1ogKd2fh6a1RwqTtvZOgynspr7eg0ZDHTOpxk30xR51QCFu2j8HHAfkB0SqPw9Jk4XWGYfsr1zoN+n9x/ZNSGVDWOs6+5r4vRR4doUkmD0KeY+m6FXdObSjPe5zFZrjDA3iWWaiEOKRHE+nHaeOYUqtPgrUWHv/+VP21Q1f/aZbboVUZyOYFFjGhongohCqBl6geQk1cYKqoAzcbSuduBbb+5lUYc5cQckOQXclFp/JJz8T69j3CTKueBqMyNSCwAtz2QVT90gi/yrEa9ezx/UlA+MOoBTpIhoxqGQKAD56qasad0O0jQLeufHGmMwfmZYr9/E0GWZDRNKlBT0JtJ8d7AGbEjuUZxoQZNoFcPN+sjIaKIVSN9Fxw/l8a2sgQYexSEAIyFLGMJN8nOOuGIGBhnvWeRQapM532rYFcOvVKoTxHwH2bpePWevid0u+xkDo7dD1uAXODyKiaxV0abtLmwuyP8DkMb/+Apq+dui2S2zzqvMTcWaaHtg==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	oN2TUv3otPWTBEQinNLAvzGHVlyXCSt5WPt8hijhbbD1eCsvc0kAyfsfLVtiRwul3f6ZzMEFx2mMmiLFIJylTqUrB9z4/5sLeNW11/xr2SKHh80zfVYGOWHW5t0pRySXdES8PjrpAp7VsG2ZAytVawzC9U5NFa0zIPZGSzizNta8b+EOO6g7p4+b4edqXHXpJj0Ctl+dU3Qatrtw/FBmRrWRPNvrGNqZgYlyau83O9psAjJU1WQG9a9r9uET1XCW2+g/3dOry7vUJc3u89IyK7zZmrZsluABGg2MBLq3gHpMXRogqDAGIWw5h9OwkwQu0224dvyinlvDm2E/amFT+HwxgdqurFb3IGv5tTCNjhCLqqbqoNBJQaF8DVXQn+WAVoh7VXqjxJpZEN37ngg0UtwuA78D2fXN2i/zRCkfIl+MbsVzYH8HpQsu8tE40EBJ
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 11:46:10.9890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fec10e-a644-4bbd-62da-08dea1f714c3
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF000001A3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR07MB11824
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 11:46:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3796

From: Daniel Turull <daniel.turull@ericsson.com>

- Handle flat tuple format from get_recipe_upgrade_status (scarthgap)
  in addition to the list-of-dicts format (master)
- Fallback to MACHINE env var when bitbake-config-build is not available
- Resolve symlinks in recipe_dir with os.path.realpath()

Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
Assisted-by: Claude, Anthropic
---
 modules/steps.py         | 2 +-
 modules/utils/bitbake.py | 8 ++++++--
 upgrade-helper.py        | 9 +++++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/modules/steps.py b/modules/steps.py
index a6ec341..b3ec61c 100644
--- a/modules/steps.py
+++ b/modules/steps.py
@@ -36,7 +36,7 @@ def load_env(devtool, bb, git, opts, group):
     os.mkdir(group['workdir'])
     for pkg_ctx in group['pkgs']:
         pkg_ctx['env'] =3D bb.env(pkg_ctx['PN'])
-        pkg_ctx['recipe_dir'] =3D os.path.dirname(pkg_ctx['env']['FILE'])
+        pkg_ctx['recipe_dir'] =3D os.path.realpath(os.path.dirname(pkg_ctx=
['env']['FILE']))
=20
 def buildhistory_init(devtool, bb, git, opts, group):
     if not opts['buildhistory']:
diff --git a/modules/utils/bitbake.py b/modules/utils/bitbake.py
index 5514c98..f6821bc 100644
--- a/modules/utils/bitbake.py
+++ b/modules/utils/bitbake.py
@@ -123,8 +123,12 @@ class Bitbake(object):
             env =3D "TCLIBC=3D{}".format(libc)
         else:
             env =3D ""
-        bb.process.run("bitbake-config-build enable-fragment machine/{}".f=
ormat(machine))
-        return self._cmd(recipe, env_var=3Denv)
+        try:
+            bb.process.run("bitbake-config-build enable-fragment machine/{=
}".format(machine))
+        except bb.process.ExecutionError:
+            # bitbake-config-build not available (e.g. scarthgap), use MAC=
HINE env var
+            env =3D "MACHINE=3D{} {}".format(machine, env).strip()
+        return self._cmd(recipe, env_var=3Denv if env else None)
=20
     def dependency_graph(self, package_list):
         return self._cmd(package_list, "-g")
diff --git a/upgrade-helper.py b/upgrade-helper.py
index 40f31c4..aef7ed1 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -714,6 +714,15 @@ class UniverseUpdater(Updater):
             pkggroups =3D oe.recipeutils.get_recipe_upgrade_status(layer_r=
ecipes)
=20
             for group in pkggroups:
+
+                # Scarthgap returns flat tuples; normalize to list-of-dict=
s
+                # so the existing loop handles both formats.
+                if not isinstance(group, (list, tuple)) or not group or no=
t isinstance(group[0], dict):
+                    pn, status, cur_ver, next_ver, maintainer, revision, n=
o_upgrade_reason =3D group
+                    group =3D [{'pn': pn, 'status': status, 'cur_ver': cur=
_ver,
+                              'next_ver': next_ver, 'maintainer': maintain=
er,
+                              'revision': revision, 'no_upgrade_reason': n=
o_upgrade_reason}]
+
                 upgrade_group =3D []
                 for pkg in group:
                     maintainer =3D pkg['maintainer']
--=20
2.34.1


