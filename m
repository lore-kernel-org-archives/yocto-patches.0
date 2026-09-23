Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650C8C982EA
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 08:55:43 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.32])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2658.1790153740832005323
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Sep 2026 01:55:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector2 header.b=B3Z2t8lE;
 spf=pass (domain: ericsson.com, ip: 52.101.83.32, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTkIIr6M7hpXe/uWcB29k7mVxALZjWapuvwcozHlhx/P/qSkPKRWMz2ga7ka4vE7Obeint/hwptIvxKx6EZOPu41wiKy1bcRjhMVNIctgjM54Fksv85PsQ+REgu3fJrILrYu7iZ9O0RZWnk7VMPG9FKzHrc29pfI+Tmo7pSVawfos9tgZjcpss5HTjs2b7Paa3V9BxHkS43Jj2NsIBETzZLNJnwQ9wXMzlAqoApLVFSwsBaPdhehB5ekH/XLAm4hV9r5ELPtVQiCaL45i5WCWPoyJneM5PuZTdRLw9bKQo6uooEuMAv/OPSvLqKlqsmjXPmsP2Z4pq19cioS8apxEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoycvrjfR0LKRwYGmqeG2v9LI1A8yAVpHML92B0g6Ng=;
 b=l2ZaYPwHJIYitN6WC5s8LJ15NgIritCcKI4ZcPdF6x7ypRt6WRtDpCIwFU6UE2uW5L+crG5Re+E18ixUEYfjRMMZTz+apfzvv7MO89tT2r77QV507GUpNAfcSFy70n2ZRIEMMXz5KKPsdcLm0XxL6pkzKZtjLKwnGHkOs0rarcKleKO/OEmcdiav/pjpCuok0xJV/+/+oGIQaE7ng/H7UYjlSqpS+Hi7yoIXlRHYnK+bG9hZLpik8L9fxZyyPq/jXWN4ZJ3ms9yJZV1HMTcYfUJ0tl4UbeG3p1ye4NZGWnRP/kt9lv+DIPKFU+BU0HRKG42Iry3cXdqkmhze6ZVfsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoycvrjfR0LKRwYGmqeG2v9LI1A8yAVpHML92B0g6Ng=;
 b=B3Z2t8lEb+ZsJwDRoTfmQwGUNAYyRVc9pjWoiJPJQUMO4TncWeIneWtHzUfJWXsx1IKVDnuYMlKKUPLVQO500qH2nzioUL97ppWUXxThJMX3CtsGcVpfTes2AdqajbN5bGW33zgqCkKK11RBSfkruqPv/TuPMtvfAEFlUbwegfDuXy2cq5SbBwmh+C0bepu2A2P7J32f7IV9GXkNpIjt/h1ihCJvnpANMJeYx/qliSQOYK/bOZPHEGZtlN6gT64PjsiKi7x0tzimMBnQREnCIX2utprzueemoNC8+7PWO90P3qrk1EyqdBBEP0KRjbrLttToBAcBbPnldlf5CXtZZg==
Received: from PAZP264CA0095.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fb::19)
 by AM0PR07MB11585.eurprd07.prod.outlook.com (2603:10a6:20b:6f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 08:55:36 +0000
Received: from MAD0EPF000008C5.eurprd05.prod.outlook.com
 (2603:10a6:102:1fb:cafe::66) by PAZP264CA0095.outlook.office365.com
 (2603:10a6:102:1fb::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 08:55:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 MAD0EPF000008C5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 08:55:35 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 23 Sep 2026 10:55:35 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id BD9C74020B42;
	Wed, 23 Sep 2026 10:55:34 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 95245700CF25; Wed, 23 Sep 2026 10:55:34 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [auh][PATCH v2 2/2] upgrade-helper: deduplicate identical versions in email subject
Date: Wed, 23 Sep 2026 10:55:28 +0200
Message-ID: <20260923085528.88881-2-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923085528.88881-1-daniel.turull@ericsson.com>
References: <20260923085528.88881-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008C5:EE_|AM0PR07MB11585:EE_
X-MS-Office365-Filtering-Correlation-Id: d41ac2be-b700-4630-0355-08df19506ee5
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	GDYr99KGiOQp8EXR23Lr+SYVOYiLWIhhD0iFEkzgnUPKEpBj0NNawdW5ZYvKIXnluN1lk+3VYzrfH8OlBGopqd7fU6lTCojN1Uk/dC1lkodNIrdlHV7ggvu0g5lT2bKvSPVmUkHaIJgSkR26Qug9ZgZnMxg2raYNak1GrjmbLMXbT8os8J9os/T27LlAB1/2Qfg7iYEBkfzrA3E6w7UUku7w3d/2LIIglNd1TkozzdeM7axpxKVWAFmuwPvObg7s6+oNslZjvexg8u7sncFAiQJIyjxdfnuIWN8EDG9GSdef/xLCpvakC1DqMXlwxmcCx/CHZE74u2gZAuV3DWgCPmHWVoaMnbTIzcExRRfTo4n5kQSFR/gg6nhxI8VwfpEcfPZ/xbK5uMKgRjZZQb1owHOYF8ijPv6y79p2GEyUtR9rb6HA+jYTeV80eZxKdmT/Tcbbp19yZ/KHx5Xxyq8+Fv/ZofY9DsPT2LfeZwHZb4kdnWN8XbrasXTJP4MaxyyhvvZDsQEAHJS/eUv0/fu1Of4PeMatkYpDGnF3tWpjV8OqCdkMH3lMkkHAoJU/ML1KCeMo8t+b1f302O0ZJG4tdbGkcQ+2u7/5W4S+r3uh5BIKQ9hMhIFtFYVpTW7tLK20RFUNjHy0bE/5T3sFL9PvO4lwNTNQNvLD/3qGyjaqdqjmpWCxPsKtTasGZ60xMxj7TODfCW1xEOZyoSkuhF8y7A==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	SaBSfAu0zA0MiQCHycB1lqbyfbZu9RhiEz6oM6LAmlW6vy52BNjKK8l5jQXDrnynpQR3y1ybPsrh43d6DCw2D3PAbUqy9t3PgH+iw31ZiwuUOdrHLNRcP1z2UE/gc8uu04tLFQaDHZ8Ey9NAQ8lZFvmjIzhfbn/85f2j7yooGEzZAqBcqI6CV91w5qkY/NdzRfIhYTxRbKVzDwd5maRYJUqh/PW5fxoI5zbqMXL3w6+fw0tiv1PlV4+tJx8acW6OWkzzKvuKCE4kKXmAUEP8zT7KjYzrCkwIjwyZxp1iPKimGW0fsLVRxITg36776/UKPKjQrIOiN0FOVf+pUYqfCvo50O2M48ybLQyjAbf5a5ZPaBqorV4VHm7FrmvoFHfxJX3I8IOMnvQz+tK81X+Gj0LhWI1VCKpMV783nRwWa9z3FQRAeolmK/1oecmphbt2
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 08:55:35.7342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d41ac2be-b700-4630-0355-08df19506ee5
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MAD0EPF000008C5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB11585
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 08:55:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4936

From: Daniel Turull <daniel.turull@ericsson.com>

Recipe groups where every recipe upgrades to the same version (e.g.
systemd, systemd-tools-native, systemd-boot, systemd-boot-native all
to 262) produced a repeated version list in the notification email
subject and body, e.g. 'upgrading to 262,262,262,262'. Deduplicate
identical versions, same as _make_commit_msg() already does for the
commit message subject.

Assisted-by: kiro:claude-sonnet-5
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 upgrade-helper.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 86e1a93..56b1f02 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -353,7 +353,9 @@ class Updater(object):
             else:
                 cc_addr =3D settings["cc_recipients"].split()
=20
-        newversions =3D ",".join([pkg_ctx['NPV'] if not pkg_ctx['NPV'].end=
swith("new-commits-available") else pkg_ctx['NSRCREV'] for pkg_ctx in g['pk=
gs']])
+        newversions =3D ",".join(dict.fromkeys(
+                pkg_ctx['NPV'] if not pkg_ctx['NPV'].endswith("new-commits=
-available") else pkg_ctx['NSRCREV']
+                for pkg_ctx in g['pkgs']))
         pns =3D ",".join([pkg_ctx['PN'] for pkg_ctx in g['pkgs']])
         subject =3D "[AUH] " + pns + ": upgrading to " + newversions
         if not g['error']:

