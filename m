Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A87CEDA6B7
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 17:15:02 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.23])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23776.1772558095817843290
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Mar 2026 09:14:56 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=NqMIiy/y;
 spf=pass (domain: axis.com, ip: 52.101.83.23, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bj+QdLT3hi4rHYTSfpTzalVZQ4AJaeuTty0SSYRDUAHISV5gqEUEtvhGa7UjPBIIrKE8K/yCqIcd5Yx+CPpZmf1gOjt9jPD8x7yas9Vc4yPgw+DsZe7hxvRV+qtTcFYfCBrTZ95pu34DyGe0zo6xjH8Mcergu0BVA7LQuTVZG/YFrXSe3ooaXPaiL8+ar/WdrzKM2abmSbkJnmfwae3NpRNcqQmxONzPTSgJTM4XDDbfJtSjZHB01Y43w7HcPRZNDdIxnfVBBFuGULM3U3a0xUNo4JaIewsevFzRn/YSqEKxni4ZkElmh9jfbfTSO3bCTJRUoqiNwefMWqsQXfZXQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nf/ZyKoZliaIRhZQQkHbYsqJVpoG+LOHnE15J3WVZhc=;
 b=tQ9TK0RPDHxNEJLHtGd2WMxUNV6vtZqB1zWm0S0CHJINgHGKVaclsjbObP9E5WtzWxnO59Z4JLb0JInNK4v8knpYf6cg02k/PJ4R6n9BK08xXBkOnxdyUuqvnAp3qUnb7JPGno0K+0x2hQMsqI1C+Vr/cPD4o4neyBLknoQ6pcpdyfKj2qN+7E9olazDascQdm283on7sM6+KgAlhT3MP9DE/w2cUGT72mEfKZGQ9Pkn5TiUvU73KRflC9G43gxH37d16bHsju8WZGgdK8vVunkDkuQS+FBmEfw0az9mP62zM/dZmfcphxQP4hMwBw4N10k2YKQqtjajN/nY83z/hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nf/ZyKoZliaIRhZQQkHbYsqJVpoG+LOHnE15J3WVZhc=;
 b=NqMIiy/y6rR+TETb8wY2sAcOfTWx9Q2Z1kmaW4Z5lJ51pYW78RLCgMfumLkxo4NRVjUI/FAkbTgWV58zBmbe4x0lP8N3toXWC8hUwxI7nkaZPoDujfVBX6dUzbYkT85D//X5OlI2oPr+pC0uGvW0+AYzbF86C24mkfVt22u7B1g=
Received: from AM0PR02CA0180.eurprd02.prod.outlook.com (2603:10a6:20b:28e::17)
 by GV2PR02MB8821.eurprd02.prod.outlook.com (2603:10a6:150:b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 17:14:47 +0000
Received: from AMS0EPF00000194.eurprd05.prod.outlook.com
 (2603:10a6:20b:28e:cafe::b8) by AM0PR02CA0180.outlook.office365.com
 (2603:10a6:20b:28e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.19 via Frontend Transport; Tue,
 3 Mar 2026 17:14:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000194.mail.protection.outlook.com (10.167.16.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 17:14:46 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Tue, 3 Mar
 2026 18:14:45 +0100
Received: from se-mail10w.axis.com (10.20.40.10) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 3 Mar
 2026 18:14:45 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 3 Mar 2026 18:14:45 +0100
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id CEE7B2926
	for <yocto-patches@lists.yoctoproject.org>; Tue,  3 Mar 2026 18:14:45 +0100 (CET)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id BB5651200CF; Tue,  3 Mar 2026 18:14:45 +0100 (CET)
From: Peter Kjellerstedt <pkj@axis.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-security][PATCH 2/3] fscryptctl: Correct the spelling of DESCRIPTION
Date: Tue, 3 Mar 2026 18:14:41 +0100
Message-ID: <20260303171443.2736418-2-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303171443.2736418-1-pkj@axis.com>
References: <20260303171443.2736418-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000194:EE_|GV2PR02MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: d3316f53-d2be-4908-7432-08de79485edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info: 
	3JYqfNJnvKlCjKpOazSVEsfy9xKJHa6nbRxVRGGgzzFApD1R70CJaTjCv3ZOLbE2a4L9TX2Vmq+TRfJCTAym+1yJEMAWb386PMIdhQ6Il/vDSUJjhjhcKUtbWaKxArSjtXkZkbvauEjxKM8rJ9FjlqET0qDOrwj25aIrBYAWtPfEoJUBfhhsd+B6OnYhwmxyRUYHgFU+vuWsPaEyehSE7Og3ZjHbj7KngUKsOSJEqBZkXGqdAX27bJ5nyIsctP5w/V84RWhcNgB6NukQ5wk7XMwe6GQCXT9WA3XAcvgk+xs7cl9Gehrd7fODVmFGeoFaHj8nTLJJNWHlMdS1GQp4sZQnRLYfOJeO+Gf7Y+sL8e4547jJC8w5p6YD19scFCqk9JikMOzmPGcnF84rqXiKOCxdiltgpcJ9yiPsvYMyBFGxEJC+3EsYI5NxA2lENW2XQdTLbdG9yc5x6EyO5qfBTAM1L2taoeJ7aSIFbL8G6AGe9Sy+wQxUvDtM/XQe8QtKz1Gv9ZnPKKXJ9U/h+N3ju39+AEjk+rtwzL35PBn2/CcOOvTE2bqxHU8rmPPvkQaZwJWQCgh89pBIl3sYMzHwYgzvkXvAp6x6v8Nu/qp82NbdnQTZplTJy3uo+M5gMZoIlrywd5J/sFJ3r8jwf3OzUdBATiaYNQG/Oazt7SIEnBhR5e448gUjNVpk+cMhrc3RE/ezlR4910oPUHq9ypsATV2li3GMldSSRCb2RLYZlL+LQaecVTQ2AFT12qoGnnQ89Ffkw6iHaq8pNlCgyqZboPjnG83LnlihK9gxdPi30Nv8x0WjAXH91J4FmimZKt6optyxBa3Qz72DJ5dD9ZbKzA==
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	9HTFBUH0qM8XQ54qyWH+YvpaBKRzP1nbaqI7CwnkytPDYrxmdtNvNg0rNojlofeVTr7IeEpzNWwknRNkczdiaa+o7SiwhXaCOA2ddJkLjnOgWZBwSEK0kIPOE/vHU9Kb5FcrEG9WMnUvEBTJU2HF+pEyGhdY09dWVGyZE8Z7DClu6+3p76BGuiR6kZV8nFSnO27Ytg1yzwVcqA3SjQWeQXWcZ9fj21aQVTd7ozCikmObd4w0WFdiUff9dJrClyp3S58BtYlonau/7eR0GCNoOriMeAtruIkrZFs36WaMqg0uODAisTdxRNduiXgtBgBZuBJxlcK73PnD2Hjigj0rM+kv7zdptw7LtwtX9Pz1xE7dJgxmDk2lhw/bqntbXB7x2p+A9ntCtlcmpr3adSZHD0K4vJKXrDwVlCos0UHf/MP2h0hdPkHxIdRQ3odgRng5
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 17:14:46.9115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3316f53-d2be-4908-7432-08de79485edf
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF00000194.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8821
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 03 Mar 2026 17:15:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3321

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 recipes-security/fscryptctl/fscryptctl_1.1.0.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/fscryptctl/fscryptctl_1.1.0.bb b/recipes-secu=
rity/fscryptctl/fscryptctl_1.1.0.bb
index edd6943..918e747 100644
--- a/recipes-security/fscryptctl/fscryptctl_1.1.0.bb
+++ b/recipes-security/fscryptctl/fscryptctl_1.1.0.bb
@@ -1,5 +1,5 @@
 SUMMARY =3D "low-level tool handling Linux filesystem encryption"
-DESCIPTION =3D "fscryptctl is a low-level tool written in C that handles r=
aw keys and manages \
+DESCRIPTION =3D "fscryptctl is a low-level tool written in C that handles =
raw keys and manages \
 policies for Linux filesystem encryption (https://lwn.net/Articles/639427)=
. \
 For a tool that presents a higher level interface and manages metadata, ke=
y \
 generation, key wrapping, PAM integration, and passphrase hashing, see \

