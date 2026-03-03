Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E9AEDA6B5
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 17:14:52 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.58])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23768.1772558090982031711
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Mar 2026 09:14:51 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=FVeE9QwB;
 spf=pass (domain: axis.com, ip: 52.101.84.58, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQZTvH4BjWKDjTt1Tnr3bMr1P0Tb54lC2Iegfrkr131OEkxJqLhC+70Eo0v6hUq01V/x2Oe/Ipcp28HREAo6JCVZ29IJ+1DmI0iaxJTV56zKK5BMBrFVHu8WXjaH8aszs7HOopamG7oKpA3TJjSdOL6s64ErCbAxfa/Gjb9QPW45Ufq9OLC2P3g6l172iZnYjdsm26h0HLD6134kWTf2k7i18xa5GEGGSSH1rS8cSDLkLOvFhRiQuDfdLIgo1/Xz3CLkOeb/2ERFeQAFhw18PRjKi9fiyclhIboOeCTy/oEWZi+QY/EiHnr/fWc4FCucFPR/tW2OJyqcEijYlDhA+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTxRnz2tBSNG0w8GedjRJnr/6iS7pwupo1Lt+7s0WnM=;
 b=B0Zo0myO/Vv/qtnrrnGe8Szt4sp0TDVz5EsCuJty2PpJBmibe0WY9sZxyJkieIS+Xi5ufxrLJKUX9bIOdK/bfThMZ/YEsU4R0CYl+K+a4n6xplievZkTeNpqcmsHr4KeUmdvIWhZYwzAaFf6q/mM5PNqvrY2m7rKYbxXwB5P1EQrV4Q6v1Hu1rAxvTSCqT/mfldps2OV+xcdQLEMoL3OwCwfwv7h4DyLOUfrL7BtJHzLkvejGTxk1iLvVg5QJTqd44A7Kk/CAX/CnABG1ioA2b0QxTigqO8GhG0QMcavBZNBRwSqnw7waazliCQGnIB2AmKQIROC4kjeeTo7L+4JYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTxRnz2tBSNG0w8GedjRJnr/6iS7pwupo1Lt+7s0WnM=;
 b=FVeE9QwBhzKusbHgb7b1f0PhQ/qdx8XvIEEdmJzRIjcjOJxlibAAJeV8bX0+lpANE9vP3Mxo7C+bDiAzPX94/Tj/dk34BaKi3jE0uqWnS2S6FWYEEU1AKVclgE39Wk0+p/9m8ELCy7DlQNxfl5Hyx5GPoXGr4hrVNXp6PE2tqes=
Received: from AM4PR0302CA0022.eurprd03.prod.outlook.com (2603:10a6:205:2::35)
 by DBAPR02MB6295.eurprd02.prod.outlook.com (2603:10a6:10:195::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 17:14:46 +0000
Received: from AM4PEPF00027A6C.eurprd04.prod.outlook.com
 (2603:10a6:205:2:cafe::8) by AM4PR0302CA0022.outlook.office365.com
 (2603:10a6:205:2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 17:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A6C.mail.protection.outlook.com (10.167.16.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 17:14:46 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 3 Mar
 2026 18:14:45 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 3 Mar 2026 18:14:45 +0100
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id CE84313A6
	for <yocto-patches@lists.yoctoproject.org>; Tue,  3 Mar 2026 18:14:45 +0100 (CET)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id B8C161205BB; Tue,  3 Mar 2026 18:14:45 +0100 (CET)
From: Peter Kjellerstedt <pkj@axis.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-security][PATCH 1/3] fscrypt: Correct the spelling of DESCRIPTION
Date: Tue, 3 Mar 2026 18:14:40 +0100
Message-ID: <20260303171443.2736418-1-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6C:EE_|DBAPR02MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b046c3-5829-4fea-7ffa-08de79485e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info: 
	xg89n5IxcyfBZIbbOgGgnM7oI/4no3/3brZsY7ott0VulVPSj3HAIR3ZeOrKdVf61ZmeTNwczWpYNMVVo9Y60kcGPIRqamk/J53T+FA9h7ecgTuxkLB/uXAI6nVVDFzIQpb+SakeeKBaJfYwarEeNeU0zyyERJQPZC3zaPnp23H0/w/rl5uVZlhmSLKlS9BIByLwL4kULvDKiZgbaMzfXvUUBOK9qTQbxJEMQp5HHWN1RI2q9RJSaQ7UOn61TW8wMXWuf/OfsabiTcJ3b442yy1FhLpJzdEysjitBnRf+74ZN/i0vBVHUa+NO1rzxdPHUi1BfcCW7rDOE6V96qJdz7Jj4ZlnwKks3HstN16wPkYeb1guBawbJJLbjcNQZSuSyw+KHOYKn1ncfFxcMDko4j/OBenJr19GUwXamU/j8TCm1l4F5cVouU3ztKE5G/1NWMCzHGuDCehBU8Sm8tG2fbEQ06k13qq0M9hFjjqBMKjB20SI4l1VYUL9T4wdkhEw+dSFbcXgJX4tzXpkyY2n0Hdw/sWQHpUXEZkoo9720T35PWwm2TJzsZmQnCmu++obwklRQCqDEeckfZSOfJKoeSfOdW9s8GCmr/Y+H7hajMuXi54txv8EX75E8ZJKu+4ldKTAo94QkEZgHqVzL/y/FQSJwA12RvUjrpIQFodYP+8ZCi6vYcP6I1Qg+u3ZDJVL7P1fv6Tiu3Dr8Sf77bAQUHJRm7qsmqEma/voJ8ppi27gNo6x5LSfEc0OtC8YgT3ZSxSGuM9kmmOkjLaX0m6lbKG1xtoXe0iZ7oJWytIbJ6ZiAHQyvgKY5ckCuoFVgawTP9GbveZlBeprnsooWfZhnQ==
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	d0J5oiR85lB5qRt4Ls3jVYVFS/7xlKG6+HyyluLvROnjxUy8IiyxZt1mqrOQJHcqYNYRTiidbWSNQ3eiMKEphMqaKJ6pKBmbR9HkYzDGudK9EwzuLmPcL1233zDtq/XX2isTLzcxBSbBJpC1j6BVbhZYzJZ2zeyfyhC8EhcDr4/CQN+a8hXHdOLp33JKuAmn3VFyOC+4+FBCB7ENOAeZ6HsOwZclydIc5Cu/C+XZ+yZ4XnS7Sm7kJZM59LMcEGDtQSUKh6J7OvAKZqduHfZT/jGUvbNF46a7x8TzZEmOryzYq/Sm1hbl04orQ4bllKBkk4fbZlyqN4UnT5E7WZaQSIr/+DNDNg8zqoOtOojZlJTvP0oqRAAXVBAoE1U1ZQeYOHJYKfhJySfCruM8t0w1dZyHf6qx7YwdpE8ingEltKLawxVZABGuhe/7Pmf3SRut
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 17:14:46.1844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b046c3-5829-4fea-7ffa-08de79485e70
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM4PEPF00027A6C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6295
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 03 Mar 2026 17:14:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3319

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 recipes-security/fscrypt/fscrypt_1.1.0.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/fscrypt/fscrypt_1.1.0.bb b/recipes-security/f=
scrypt/fscrypt_1.1.0.bb
index 6ccb8fe..665648c 100644
--- a/recipes-security/fscrypt/fscrypt_1.1.0.bb
+++ b/recipes-security/fscrypt/fscrypt_1.1.0.bb
@@ -1,5 +1,5 @@
 SUMMARY =3D "fscrypt is a high-level tool for the management of Linux file=
system encryption"
-DESCIPTION =3D "fscrypt manages metadata, key generation, key wrapping, PA=
M integration, \
+DESCRIPTION =3D "fscrypt manages metadata, key generation, key wrapping, P=
AM integration, \
 and provides a uniform interface for creating and modifying encrypted dire=
ctories. For \
 a small, low-level tool that directly sets policies, see fscryptctl \
 (https://github.com/google/fscryptcl)."

