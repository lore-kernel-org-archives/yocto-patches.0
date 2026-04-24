Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CE6FE5213
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 11:46:24 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.58])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19020.1777031175964861904
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 04:46:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=rp09l2yD;
 spf=pass (domain: ericsson.com, ip: 40.107.162.58, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Waea+o2BUQ0L8juvYOB/taGs2onCRXP4KjGcirwTo+9nRLDiH1G49RFyvBxmaudG5FRHsq2KkUg/oyEhB/AbaTN9nFftvtCcx9NfyV/eKxvbB8252P/VDgATyCiT8/dr7kyyYXoa3jPnGpFpHB979SYJlKI5sw43jLgjd4pJmgcCuRnermUA7O4OxulisPEH77lK/A4IkWk+lJkrK0XfjCPyjyl3vzCQrNKs2nsxaLtnRjIvO/pKw2IUlAFB5c5Zd7ChD/B+bC81fmvldO6Xis/2yBGuVzSVtlXP+T+0vP70vgFxAGqQEgvofX2WKZ7JC3BFd9o5RzRb1G1oiW+IwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eCPw5bcmjGwT94EaDKbTMYTwSLJgOKTQdVyzw6kZUI=;
 b=PtIvAVWjH/nh4JWq8h9Yr5u4FI/S9nuW1VMw3bpCBMV6d460hg/cQy/+VQ5dgO5Eu0JjSrDm0nOGTTNa+PlOmFhlMsPx6rfGEXSoLKD6lveL1Fa1cWpR7q+vwg0LpxDRKFFZDsBrjGNeiLWfVIhfKJLd6p0/eP8SXWrpQCPKEi47gWzKLairojK7W2e2Lk5kLnNd/cEr53+eY8FMLbtFbcvlbxq3iK0510mTEoWqQRfQXlIRde0WGL+Fa5ayvVh7v7PpoLAOzeFFS2vT5S5M6e/Y0hBFeUoorWoFAlhXLSGynGp7qD9/6cPA77AUYsVQK3hw/OOdkfm6FdXm1jU6Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=arm.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eCPw5bcmjGwT94EaDKbTMYTwSLJgOKTQdVyzw6kZUI=;
 b=rp09l2yDKBkAF6DsXB59ogdpbwtVp2sfzx9MJuMEUbU4Y9o1mTQyiS2TGVdrLHZBiZ3mSdzFGfKdSY4lX9BjIe0WTrhWj8DnkwevDeCdHcsYx3v1eD/uBK6pUyCKwTCgo9rhzGlManEBN1+Wqa80RXzze5g2vTwls7j8yyAcfAT9PMJPNvthk/+OOOePts0yHZ37814K8cN3XBfPvIzincC7Dg45h/38j/AhvTJ1QdV7Gtz5cG8mE/m6/qsxuTxSuXckRTM1nRwJk+u4+pKgcleTVn3lLwAmAafAeGlHEo0QqnlEUHzjSuEUcTQOzlp4F82IMWTI6wLl8teTvU2kxw==
Received: from AS4P192CA0002.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::9)
 by PR3PR07MB8209.eurprd07.prod.outlook.com (2603:10a6:102:174::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 11:46:12 +0000
Received: from AM4PEPF00027A68.eurprd04.prod.outlook.com
 (2603:10a6:20b:5da:cafe::25) by AS4P192CA0002.outlook.office365.com
 (2603:10a6:20b:5da::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 11:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM4PEPF00027A68.mail.protection.outlook.com (10.167.16.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 11:46:11 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 24 Apr 2026 13:46:10 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id 00B344020B71;
	Fri, 24 Apr 2026 13:46:09 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id DC943700DB94; Fri, 24 Apr 2026 13:46:09 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <paul@pbarker.dev>, <ross.burton@arm.com>,
	<yoann.congal@smile.fr>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [AUH][PATCH v2 3/9] upgrade-helper.py: allow to set the git directory from layer-dir
Date: Fri, 24 Apr 2026 13:45:57 +0200
Message-ID: <20260424114603.2444938-4-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424114603.2444938-1-daniel.turull@ericsson.com>
References: <20260424114603.2444938-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A68:EE_|PR3PR07MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c8fac0-36d9-4ad7-9955-08dea1f71551
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	zSjDG1JZYo3qiEoW8bSJAOpGNVtwbYsk10Ky2oxk0hiVqqyapCmaWeHorc9+FBzBlITyqKVH+z5fqoYOGsiBEsK9dqYz5waOn7JrawxLlulMW8Kf4qajlwvxGDa376RpAmI/JHPmPIKfg69HRm9A+3go8l3cEtgzdomV9pbp83/F/BqSA38Pvp++PswvuoPjlicW9/sLnIEW2hHXCVnvMPGKcDcbjivzk1s4WPtWnCqm4jTWY8qeM8bthaliiKlbJh+jFcDjmwM7j0jv5jf1yk35OYATSB3K6u431JsfbjsTDjkvHmDdvimtOhXTphHNp/aprsXaXqE5zHsmLMNuF1eWLxIgvwzxeui5n0QdpyDplqHlUJoUTZHvV/mYMSe8OTO32HeI0GJO9dEFCWSlv0QSOZezRV9s4KbOyqajOmnma5Pchqp9Je6MvoKgtIRNW92RSfTb5yjqL7lLNlfbV4y8hElJn3/3hlfgzmiDpzllbyCM+a9zbsjGBemikmmISdpWkvehnwIUPnmrc8ayM8XDKpC7lvxIEAQ7+b0TwlF6ytnpMrq8LsJZn1b0P2/xZ3OKsfl6BCcwVy07fpyXAkOzEVF+VPmifX65iAGaLuZ0euHS9koF77nqIABkUIcqIJg5HrYB7Z+fLpHZ4CXGUqW2NcLeQOIFG9lgXxkTtN17m81kPxrZW26Mkyzs1r7Yk1ZnZv3x4xrniXTGmGS901oGrBARozDLOHstYoAutlhDooiztAeYO2I4Yb49sNzWe58v9PoiMpdbB7+DNVvR6Q==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	ss8PIvImIIWNXdE+RuE1rIG89Mo6hWdKMl2vwa91gVcMplYbPNABhBW0OABXz0Z+FvvqFbXTI4AiIvG1ATUsTii+115POYGDkpmqMlJ3MSyw/nfj86XI6HAQuDXFh6mNhBalEe1tmZhryhzdFkekLXAF60nFXyMAPn3dPXaGht1IdmPyvNRIhlzV4ZTTP/qsdV1YBVC71A0uLb6NYxIrbbSktYnezz9R+zUC96InbjN/wzOlKKYqRYfcF0bQJb3IYxJ36F6XhS8+UG/MnI7+F3OntScOvVZOQUkE0otu5RnuA3o2xo2rXLu/O5FMHbEnGDXwTHRH5J75NRJK+FpK36k1769iRQgVrKxSTKPKE2HBTmYfrFTHH3OZaHIdOzQRwGOhTfWFxAXPeJdzPsaxv7Pbyy2xK6N7zi37741xEsnkb+q/O+PO4gO+JZhqeswA
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 11:46:11.9219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c8fac0-36d9-4ad7-9955-08dea1f71551
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM4PEPF00027A68.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8209
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 11:46:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3791

From: Daniel Turull <daniel.turull@ericsson.com>

Replace the assumption that the poky directory is the first PATH entry
and reuse --layer-dir to setup directory for git repo.

This is useful when not using poky and each meta-layer is its own git.
Without this fix, commit_changes fails in non-poky layouts:

  git add .../openembedded-core/meta/recipes-support/gnupg
  fatal: '.../openembedded-core/meta/recipes-support/gnupg'
  is outside repository at '.../yocto-scarthgap'

Assisted-by: Claude, Anthropic
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 upgrade-helper.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 98391f3..df927d1 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -184,6 +184,9 @@ class Updater(object):
                     _layer_settings_error(s)
=20
             self.git =3D Git(self.opts['layer_dir'])
+        elif settings.get('layer_dir'):
+            # allow to set the git repo directory without enabling layer_m=
ode
+            self.git =3D Git(settings.get('layer_dir'))
         else:
             # use scripts_path to get oe-core directory
             self.git =3D Git(os.path.dirname(scripts_path))
--=20
2.34.1


