Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EE0CD98C7
	for <webhook@archiver.kernel.org>; Tue,  9 Jun 2026 16:40:24 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com (CY3PR05CU001.outbound.protection.outlook.com [40.93.201.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37.1781023223044743489
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Jun 2026 09:40:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=fhdhJWZW;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.93.201.34, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtH0tWyXX+k6Vqp3h407vWhlulpLzm8zqmVMMNv34gzHP1il1Au9afYcIwWvxizE7PYIx2driRSihC3jbBNLjhmIXPVsf1DCPlN1a6SXSvZ7Hly4Y5ck6tTDMIGWidqd8IsdyWL9ugwQdaH04BBBaSHSbh8GlOqmNQzklugZEzn1hYw4eBWNzyydqUNpQhCSQHXAlVHIPiquLm1nSPfO/pGWakufJgsosSPAqvtn6nLq4MOb7xdeXs155Qfu2Mq0/a15rukTDSf3T9NmXvWpgGT6lRbBl8JB3nlfhhhFcdqOFBwzzpzcLqBKbVQMYyrxBH+X8NXSO879hrY06lNrow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJbH+pLtmYEPBmgOvQe7yPGMiv4MFEhY91CSZX92G48=;
 b=kXy9oPDia/LKR/KTxmSALMrcSR0yk7C/JKHOI8+iLRcfWMf/rfkQSYfdaLkmWOIJMVCTcG//RqwMh1A5bDBaOmDNu/zyi+BBjXGRHtQrz/tVQFZEW0rT+Rr1FV0SHK1f6licemmD/HGhktdlXxZASqEOOrAcxOCiJgT7K6nA/sjJiWNeraKY3pzGe/C6uhKpMcY6ZyWdUVopGTg4jmMy74xBhRiEvf7jmjngCp7LH2LyBrzI8QhWY2PTxyqeUFAfIU7XKKhzqpjW6LKNbjhEr3U3+DOrXCAI6TITQId8Tq2/V4Pe81aaKm8G613pLA3qVxiMc65webyfXFniOajXDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJbH+pLtmYEPBmgOvQe7yPGMiv4MFEhY91CSZX92G48=;
 b=fhdhJWZW5sdx6ADshCcEDAdeUzi+hduetkHK44kMgywzfdGvYiRB+KscuPCMAR5Plz8xjwZlrRaC0tuepZ3tveWwLshEHoErTT/+M3CVhWCbMN0jR/2PFl1e0MbDbdpj3RMdIgqh7O8BPMpIyO5ncYa64xOOfj0t8Y10yhwJ1Ks=
Received: from MW3PR05CA0006.namprd05.prod.outlook.com (2603:10b6:303:2b::11)
 by IA0PPF0A63E7557.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 16:40:19 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:303:2b:cafe::31) by MW3PR05CA0006.outlook.office365.com
 (2603:10b6:303:2b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 16:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 16:40:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 11:40:18 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 11:40:18 -0500
Received: from xcosantraju40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 9 Jun 2026 11:40:18 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <tim.orling@konsulko.com>
CC: <mark.hatle@kernel.crashing.org>, <piotr@qbee.io>
Subject: [yocto-patches] [layerindex-web][PATCH v3 0/4] Add app dir support
Date: Tue, 9 Jun 2026 10:40:28 -0600
Message-ID: <20260609164032.1415124-1-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|IA0PPF0A63E7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 918c6079-5c14-42bf-dc74-08dec645cae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	ZmCDNuApH1nSo6yMzo37NyuIUx0QpIjvxjuew9LQ4ICNcIk3yr0JNKlNdE6jPzJP5kEr3Wzylr/gOEELgYthM+ppQdInNps3DS2uHls9hI3V6LCw/VlvGMyVYgZ/AQ5kiIR7lW3Fov1khmNVtAjUX1zvGeOVfQIshdIsXAe94GoXYYGw54oSfxntvMWvMXRr2YU80ytJlMxDyv/Qk+sAn0L2UayxD3+prgFIQ9XYmiVLbl3aZvfd9jGYZMintWRjXneHQRGTQfcU7MBgRlVUKdj1DeqXbqGFOmr2hfEdDrW4dsEeboAfSuQ3l+MzTBkB3/iLWLWxviwgxVxLQhqTveN8RUTgsYQz4Fo292HDtI5/IcQFal24KH8Pyd/CLIZrbl2e0Joh0i2RoWbFpi5XtM5btngNTS21t+6UTYXceKCmhXIc4leqT6fNm836MfsFz7BQEgVcuR8cmmSq+EOPaqNG4xtkbuQui4jCsNFbBqvJBez8WQzRd59bOjGIkvt0dqnMiuIPWQkNWzX4QcrCYbxP5L2HBHkbh8gmQmY6AuMV7FLusjxiGtiLcS0tYG85AKTeJ+g1VO97K94VfCuxqh2QFR1sFFNpnHQnzgDY4SqHtwQXnaKPZeHZuu2Hc6fuh/NeQAmZKONQ3uvd5mn27oQZHkNSEmAeiBeidpn+3GS2jDvIH+WLPHVBez7Ma49M8htNshw7A7xzp4n+UTLUkgaf8RNb8qCbVNg/DXSrMkE=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	tpUYGA4SgXg0CB1bnfThSS+kKr+piqhdblv5/Ld0DTaHis2ZL2qZldw/vzgCgKgdEzJvrE5IgtiRxEaozcOeRA3njeg3TFdVXh6YxwkVqC10/zjKLCZwdLI8JpKSQAi1/MYOQuvvXhaBwLC8eictxZM1LFleqvmn5iBZC/+bmwBHvdAWElK84IN+nlQKLvsrCkx6JPBj85M8EQWsd4K0qK89zlKk1wLEu3xplcFLn0WL2Bl9lSLM01eZ4+38FvApQrsu4u+RF0A3wNWOZEdxlbeUaWEsydHP8WbEDdAS569Nghfq2mK2RfanDiSrCShCTqk6TyenO+VC8vmW9Zkj2kYgUEfs7TRZuhkEx2YD0E38HBMRMILDCVv+LXu/YHlkxja3xXcB9QY0OCTdFTj+mrlfrvbwjU/xvW6FOJWWzfi4WCQbyCQ74V2jHuVKscs0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 16:40:19.1265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 918c6079-5c14-42bf-dc74-08dec645cae2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0A63E7557
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Jun 2026 16:40:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4186

Changes in v3:
   - Rebase with master. No code changes.

Changes in v2:
   - In "[PATCH v2 1/4] layerindex: Add app dir support for configurable co=
ntainer":
     Pass app_dir to edit_settings_py() and replace the hardcoded
     LAYER_FETCH_DIR =3D "/opt/workdir" with app_dir + "/workdir", so
     the fetch directory respects the --app-dir option.

Description of change:
1. Add app dir support for configurable container as default
   installed directory is /opt.
2. Use yoctoproject.org for HTTPS check google.com may be blocked or
   considered unsafe on some Linux host environments, while
   yoctoproject.org is a more appropriate and reliable choice for a
   Yocto/OE layer index deployment.
3. Replace deprecated libmariadb-* package in README.devel.
4. Document --app-dir option usage with dockersetup script.

Sandeep Gundlupet Raju (4):
  layerindex: Add app dir support for configurable container
  connectivity_check.sh: Use yoctoproject.org for HTTPS check
  README.devel: Replace deprecated libmariadb package
  README: Document --app-dir option usage

 Dockerfile                   | 24 +++++-----
 README                       | 39 ++++++++++++----
 README.devel                 |  2 +-
 docker/connectivity_check.sh |  2 +-
 docker/migrate.sh            |  2 +-
 docker/refreshlayers.sh      |  2 +-
 docker/updatelayers.sh       |  2 +-
 dockersetup.py               | 86 +++++++++++++++++++++++++++++-------
 8 files changed, 118 insertions(+), 41 deletions(-)

--=20
2.43.0


