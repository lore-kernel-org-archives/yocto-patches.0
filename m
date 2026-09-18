Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E82CC982E1
	for <webhook@archiver.kernel.org>; Fri, 18 Sep 2026 12:05:41 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.63])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9555.1789733135164042180
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 18 Sep 2026 05:05:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector2 header.b=WYNKE7ds;
 spf=pass (domain: ericsson.com, ip: 52.101.66.63, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7m4awaQ/+ia5H6IU6H9GC5CyvGI1vJHR3L70fF4wmlzrbs8G4iENA23+TjaFa05vfzsRHQkBWnSbLQjMon9w1WJL5Yo2EYmnMi/Ru4fbkbCTHtVuGVpJIv685Z0pu9gmi+IelSfRTsO1WTwdHD09t8BSqx3i+5rEpnN+MlKoMnxNrlLQwAfUFDmb2IE23+HfTVZoJSo+hJ5MjgOsngpd75M7zjgzNqhLc9lGZJMBmlMOg8919WzXkmLiCgUzcfPlAok0w52W/afe5rHEIUlIUU5Y8N2s6e588SrRwYiQz5Qe5msYh/384alACMvj6wIssniEVXGFPrYVA8Qfc6Ltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pY6KtY0E/eA5NOjq4/q8cd+GOPt+EEX5OeukRKf/Wu4=;
 b=uWrOgkKlwBiQD9lcjruR0oUROiT3OtKqupmgazxn3eEGn2K+Tv5B78VDCe5B2P9vHO5G5/6t5RkXhoQ2I432wLxaYvm30JBi48THtrNumEG3UHdaBMJHRngUvO2NjrDV6ckSbU055BtVOAcnOEe5fvU7sA4sp6mN1vypFz+UADZqJefXxiw3fKqxwqw+65jJXa2RWOwsEPF55x63MxWGlaHg6uJJbgEMiMW22qaZB/1LisCZkjwVjHbgeLzbxD0US7xd+XRKVcuHQ30yRejXQYiRQzA/gD6I5/XNVPenhszEXj5O+0QmGaLFTjJ2npG7RrpzDaZykaiMLgWpGghIyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pY6KtY0E/eA5NOjq4/q8cd+GOPt+EEX5OeukRKf/Wu4=;
 b=WYNKE7dsSkK08gNLzU0/AiiBLBmq21nL3aEc0eLGLjet/nSGdgpRFl1nWxmKAgdwFl/GXQ9EFzWeDfTtzfOff3qkW4NMwv0TKbavSbvHdRh55iuc835pDpiI0ryaBHCoKXOFw+l6tHwiYaX1eaZcoG7OfMg+W/kk+bQW3bUMzQdMEvnJFvD/D0DdMbmlkBzmXZC/8nznQMbtwHKdIxhFes9uMh6mKnAylRkEQw67vX7yOQXtGyGo3b4x6LSV1+I3FTffkjo8bCAQktoP3A0e0fn+n+6mk+37kdSOnrVZbcmeQ0nPiMuO0WD2ueRzojrzXJCNIXHZkiMNxt0N6H83EA==
Received: from DU2PR04CA0180.eurprd04.prod.outlook.com (2603:10a6:10:2b0::35)
 by AM7PR07MB6659.eurprd07.prod.outlook.com (2603:10a6:20b:1ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 12:05:13 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:2b0:cafe::44) by DU2PR04CA0180.outlook.office365.com
 (2603:10a6:10:2b0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 12:04:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Fri, 18 Sep 2026 12:04:01 +0000
Received: from seroius18813.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 18 Sep 2026 14:03:50 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18813.sero.gic.ericsson.se (Postfix) with ESMTP id C15F195816;
	Fri, 18 Sep 2026 14:03:47 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 97C3C700CF28; Fri, 18 Sep 2026 14:03:47 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [auh][PATCH 3/4] upgrade-helper: increase changelog truncation to 5000 charaters
Date: Fri, 18 Sep 2026 14:03:35 +0200
Message-ID: <20260918120342.772566-3-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918120342.772566-1-daniel.turull@ericsson.com>
References: <20260918120342.772566-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|AM7PR07MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c09965f-1209-41f5-6959-08df157ced50
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|22082099003|18002099003|13003099007|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	8jvob/XfVdRJwMFYOgrtpfq9fyBPb+ICQiVsWnVZcOjUmaFNPUrJ5ipd+swTbFVc6azI8UikBasMrzHzRWpGoZM90VRgQ6P7Lsz/ErAbeohznUInzkwzZYI3ONvn8wG3PAprCZN+zbAxtE3s6Sa0/7Y2kAGkgpmkU2SW+DB5BM41bZ0mbnEkwYkNoq11ThCIVNOtNjDsVzyBBlEzOphHkcYdIK9nzhu7s4xZoTRZ9SQ41s6UMLJrGPrIORNkGRyMEO+Ro92wTe8JQmdQ3rclfi45y+7X9oCE84DwKMvk18Vlak6M5ngDhPGooRzT2sYXrkWkgZh4d247qsmL3yvh6hws0OQwpQLQNXRlI1MNHsYXaDedBFpiEm0I6PmMO79Urb9irIEI+Fgw1wzKMpd2Tn0+566gPJK1eAza/Zo2nn2UEgrulcBX0hrR/hosw1OgrSBtgcrlEcDGd2EDMsTiS3s50xZEA09x2K+/u9p2Y/YB/JJtWvzEIcm/Nmp6YhFvf1IBFniSajcXIjgDjdwBOj+a7Q2//NCG6rkNgH0AQUTrIPA4+weBb6pjkQbhuaHfxorArXhHhbswlNQblTwkWjhQYIEcm94X1bzqau/LVJuta0RTlp0bDN5yNVlmN9gL85/oGkiUxAofOEwT+x56TnN8wBRGmdXbiHtuSlSrMVoOUA6ECI32sbi6QaNejQ9xxSbqJcRVogNizijdT1AmHQ==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(22082099003)(18002099003)(13003099007)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	9QWByCF7RS9wB7qoQUaSVbAK+TSuvwpURFLfPlfLlsKyXDV1LoO+9aIlmo/eHXQdkI9MSs4ZKdJGDOzZGHnZZOTVd6gOyQKXMFLRG2GYgO4pSuuhIfG2sFrWgX/6q3+kIsLzwrMyMZuaOyHN7d03aFvFBdO9/coSKGFTo7z5Bm0w0TBXLMuPkUAERJZ2vaT1fWiS/xDwmgnEqEosBWiFgzPoSmfzWYVCgSiUYWgDsVRuSkeR5pZQ4iLtJbm8kqSbw73Ofinp2qz+3cg1aRLumjYHOK5MRUupLOwmvW1/H74DcU/dFjQVkcEI4e9Tgt1xvN6v4QoJIku1zJbSF1gEs4emTwtrFKRJl5tajB9NB3gVF9V4/q26INYK4tO/XnZ/4HKakPmqVwBSdPd6x02rXLxtR0VpbhpSNPmHTmrETqp1kxGtqqXHObfxn7mwWbNb
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 12:04:01.0648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c09965f-1209-41f5-6959-08df157ced50
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6659
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 18 Sep 2026 12:05:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4907

From: Daniel Turull <daniel.turull@ericsson.com>

Increase to include more text in the commit message.

It has been requested by Richard Purdie in
https://lore.kernel.org/all/e13a77790d4c9bb55bd61aa59ff433c703b6f3d8.camel@=
linuxfoundation.org/

Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 upgrade-helper.conf | 2 +-
 upgrade-helper.py   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/upgrade-helper.conf b/upgrade-helper.conf
index 3cd990d..26db0c5 100644
--- a/upgrade-helper.conf
+++ b/upgrade-helper.conf
@@ -144,4 +144,4 @@
 # Maximum number of characters from the changelog to include in the
 # commit message. Longer changelogs are truncated. The full changelog
 # is always available as an attachment.
-#changelog_max_len=3D3000
+#changelog_max_len=3D5000
diff --git a/upgrade-helper.py b/upgrade-helper.py
index c3b37e8..86e1a93 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -219,7 +219,7 @@ class Updater(object):
         self.opts['skip_compilation'] =3D self.args.skip_compilation
         self.opts['buildhistory'] =3D self._buildhistory_is_enabled()
         self.opts['testimage'] =3D self._testimage_is_enabled()
-        self.opts['changelog_max_len'] =3D settings.get('changelog_max_len=
', '3000')
+        self.opts['changelog_max_len'] =3D settings.get('changelog_max_len=
', '5000')
=20
     def _make_dirs(self, build_dir):
         self.uh_dir =3D os.path.join(build_dir, "upgrade-helper")

