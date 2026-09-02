Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89C3C624D0
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 10:18:07 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.25])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9546.1788344274015746184
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 02 Sep 2026 03:17:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=UdrN0NBT;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=UdrN0NBT;
 spf=pass (domain: arm.com, ip: 52.101.70.25, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hiFsYULjVtKdfvvWiO8f2bxcFivRx+KD2HCj3BLABbGQXA29TeOsq/PYycnkgn7kC9kBrMrT2Auwx2w2Ydw9FGIkCYyyQira7W6iC6/SfyZtEuu0/W7dXALlAVJAFWMb7btoaPcC8xtjQmSng3WkyW1djWSb22bSifYjofTQejkZE/CSRr4OGlfszTKfBaFDrK9UgibyHzUAXSMBpg6wcTYZ/FlbM7lYzbd9KpyV1aliu49JBAZ4tWwU1Px7D+9BXh7Z9v9qOq9LbDWSspMgPzUeMLQY4jOnPL8ZYpXDOnX5g0nOHelrczStPmE35jsVpbMURd+ldRcmaL4bJF619g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9pmY+vhNEyKZ78gSFuMy/VCkMiSNiIRVvHAPHrUbn4=;
 b=W+YYNRnSiLzaHKbggM6a8s83cpgnCx85n0ImqkZUmgOoF2Qv+7Met2jmaZc6UIDrHX3+27L08lYjho+sjlf3wQqjagBLj4gZqCV3Ds89aM6AkQSjwjROwn+6UCKvLoTMsR5HUrlSWdPnQBmcYvRsxApzSOVVD5qrV+VBIJUHvcwvZdoV9sMeqdBLomEYLITSFGEz88WyaNdzyqZKc2zK+YYr6MGivhvekBDDGLrno4WVTJ/Np50YnX1jJsYfZyMuyVo3u7C91xuEyIZ/fNMvV+rZsdCyt6AhMBrdAVd57IFM32IF5mxSwRw7G/zp6VHEuQnDSFkKG/F2qO2+5gxmog==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.yoctoproject.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9pmY+vhNEyKZ78gSFuMy/VCkMiSNiIRVvHAPHrUbn4=;
 b=UdrN0NBTDSH0kZzBdC5wxKRBNzmdc+txgdky51bmKhd4ZFuhpu8kQTobLxxxU6PrQm8onNOCl9pJqladEFFOEeMXy65JhO/dgjq152PSzZjlwD/yzK1SSP3fnTUE0cuW2bEWW3NvOrk1wysQCQ+Smb/LzT9oe0KthUCBGsrHYZg=
Received: from AM9P192CA0021.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::26)
 by PA4PR08MB7433.eurprd08.prod.outlook.com (2603:10a6:102:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 10:17:46 +0000
Received: from AM4PEPF00027A68.eurprd04.prod.outlook.com
 (2603:10a6:20b:21d:cafe::af) by AM9P192CA0021.outlook.office365.com
 (2603:10a6:20b:21d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 10:17:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A68.mail.protection.outlook.com (10.167.16.85) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 10:17:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnjsKl/mvh0zAZvAlOajiQmQU8gsgcYlfWzRoGAhyZ6Hj8zGHvUxSGDnOHybgdqsiG0MTn7tnE+9iyZci3vF9EsCy+1xyf3mxrj6Jw004I1FNvrv4UK04MSnNxRezyZlWhwvgckMi3lrmEwnQTisXwA8platfGt+s1+piKE4HVxsOfBbSa7+6xr06vshLyD7/tLiLUQ3TYnB2U5e2tIHHrw0Fxwflaqq5r4nEXceCVIsGp12qjIc1JMvXLElwg++TkWFe2V+b0un5wZXe9I/cRjDQjlaXXamrOGem2RNDMwoeOtvDpUIeQ1jTbnxKti99TvO4zt8hwchB1TdadpYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9pmY+vhNEyKZ78gSFuMy/VCkMiSNiIRVvHAPHrUbn4=;
 b=hLqHC7WUC79nZVS6zXrKtdFU9hOxerSmdM1m7jqToOabpxvMf7j6BR0Sh5vqdH5yDfPt8yVYE1UWOLN03sF+MhLuqFQ0buoSZAusQwmytsBt7HK1rPN/sYad+kvENqWeIYkWnBUt2gTLRQs57REhYE7wus1d2ZDtdgCOroJBzwnAF1q3o5WfWWJ4IdMSFPhZL5O3fI7EWxOImQIMWlAtr/dHxk4DFL4vtvrHCwCkS97QbONM9QYrtvoS3nZcyGFdLu9YCUVq9RyThacAzGRX8yM1vSDnUdzTol6wttpQxkpzK5OHz9wJeZWvu/pU/kKckiLa780f2wZmODQyct0S0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9pmY+vhNEyKZ78gSFuMy/VCkMiSNiIRVvHAPHrUbn4=;
 b=UdrN0NBTDSH0kZzBdC5wxKRBNzmdc+txgdky51bmKhd4ZFuhpu8kQTobLxxxU6PrQm8onNOCl9pJqladEFFOEeMXy65JhO/dgjq152PSzZjlwD/yzK1SSP3fnTUE0cuW2bEWW3NvOrk1wysQCQ+Smb/LzT9oe0KthUCBGsrHYZg=
Received: from AS8PR08MB6262.eurprd08.prod.outlook.com (2603:10a6:20b:23e::21)
 by AS8PR08MB6725.eurprd08.prod.outlook.com (2603:10a6:20b:394::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 10:17:07 +0000
Received: from AS8PR08MB6262.eurprd08.prod.outlook.com
 ([fe80::857d:b99e:a0e7:73d1]) by AS8PR08MB6262.eurprd08.prod.outlook.com
 ([fe80::857d:b99e:a0e7:73d1%5]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 10:17:07 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, Adam Duskett
	<adam.duskett@amarulasolutions.com>
Subject: Re: [yocto-patches] meta-openjdk: A modern replacement for meta-java
Thread-Topic: [yocto-patches] meta-openjdk: A modern replacement for meta-java
Thread-Index: AQHdOfVU9GhQPfCtNkKHKA3ubw3Ll7a7FHGA
Date: Wed, 2 Sep 2026 10:17:07 +0000
Message-ID: <FD587585-1CB7-461C-904E-9EC2399BD624@arm.com>
References: <xBB4.1788187111192557019.ULaN@lists.yoctoproject.org>
In-Reply-To: <xBB4.1788187111192557019.ULaN@lists.yoctoproject.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.700.51.1.1)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	AS8PR08MB6262:EE_|AS8PR08MB6725:EE_|AM4PEPF00027A68:EE_|PA4PR08MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aef5d98-8a4c-4cd6-2281-08df08db6e6e
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|10067099003|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: 
 jkUAAYMrJqRT/ev/vD8TgoEfqAfnEc3zATmb+XUBKtHmB3cDs6V8aYMJBNJdTsluv0D3LoYntEgx6kXBQFQeoZjxCytAjIyek+NgDg69/9eGc+rS2bsSO+gPBGLWeBIYLgMUKCyeuZCm5L+kwtnRgqpMKHFwfRua4LnqYRZMeYz6ed0WznMpyewqq3wal5k8woK/kefEQfj4+ABZwZ5FdXqnF6Y5t+vIEQD1b1HDiTqWAKoVq0heXJcEvyhBBbhR4+Kl272UVJ68xyAG9ub1zYgJIMUnuIwPA0S1n2Gxwb4JtKD5YeQANpYEdSmAYf8Z9PigAz90Vf3VHY0Y5O1hmz5nW+8FlXHwgFc/ESZOMiDggY7x9ZSJRaQAjVROKtxzA+n/AvZxeFD4NcqgTrFSyIZ8Wq4qgvBWVnVzbMKwnBfuLX5F8hm0oHNybbWGjfbyJfG9ksWDyfcIEq9r+JplPhheLRc0V0B4BcCCZeWnaCD1sRLe2iEz501LN2zZcdKduZn+9jlTZHc4DKo6EAOvDEsL4N4fzzItP64sFEfQUYngHm4Mom+ERQ6QcsgPPqgyiI+WbHaQ9JD4mfGRqUEo+JDhvedMCRRagSynrpwcXwFwrER8Xd60iBvDBKmrNnop5I2gfn4+Yf5ta0iJm/ZzokoLNIc/pBXtixeI2dppnH6r4LRxNKuJSTveYQfbpVZm1aMkuxwjK0W7n68qbVMLmT3AfX7Nzdba4uCeumyEHAs=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6262.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <70319B06178D3F459CBE312A366CCFFC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
 C7V4sR4avAGZSrOAD8wkTeAAScng5NiasyhLDoL8HdmW5H4qYKzLlaaaLGoVANbm3noEmamyvkrrp5JywuVwj7no1MxTs+aiBtYGPZb3JQJXKi0kV5cwv688SLbUri/LIxeMFGqJE/7E6TEg24o76ZoL1lTkRyf7hYwuKs8c3RjLI2z9z9NJ8MRMDRKh6xVpjF9VhkdcjeIW78WLsawAqWmd8OoMtjBLvtGGJE+aZFJbmyiPKZcNXdMKmUmRZu1p6Mv/mBTndIMiUH4RghpCN8iTW2J+6jQhVMFOa1yQ8WXu+uWwWGOuQFqb9f8cjJQ1PWTFoPzRQ8mXOdw3HHOTsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6725
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM4PEPF00027A68.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	493f1016-f87c-4e6d-c6b8-08df08db57bc
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|35042699022|23010399003|14060799003|36860700016|82310400026|1800799024|11063799006|6133799003|10067099003|18002099003|22082099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: 
	5+PtgbUT2EnNzfr8EX+m+ezeEmsRCaBCFjWOM3MhaH0EsvfTKxAw5rU3D4y2ocL6nyen1N8/+/Z+CqjvCeycUmzeOii6WdLPyuCEbVO+VsZVSO8AZBPKWcg4RVZOdMoF5KLOy2CRuYE5X4Drg9E4Kc6Snm8deMVFXHm63l1TvqB+JM9LL9VUUIGg56LRx4vQ7/I39SXdfn9YfzhBEXnIngZZ8Q7mm67Py1yZDbL8xSaW65fdQzRXGRijmLrgQMTOhOqJfZxf4dXAIAEg4nMGi5GK3YJfGak2d05sNfWITfXO2+S+tIUS88SE+CIuO5LRRoCOL10PON8D+jFoC68tqWf3sh/bReVI0OcFF7njUemzE5PeGrBXnyui/jfYo5T2dlI+Rxg9Mgt6g+QFzy00nHM23z/HCL4sNClyXsDR4QYQZJ4uzTo9XLb+BLGLX7uvXAzl1Q+b5aGNhPuNr+8snUEysRYQyQkvrzRxMEjpJ7O8sw1LzyTMXnYoLAoo4NKsahDvvtUEF+6u2j1dBmKk3KVTllrNa0UwLmSliwtBfeSjuLBR5Q+rXB44nLyRxKhZRgAmvw/cIMaFO19x/+RprxcPTlfkSoJJR+NtooWC6XlKh5LrVNAGlyw+wDf/UaI3TIZuuH0Y83ohsiZV+/OwAtuzvBCa9gWIRHL1LrfSjkljthgv/WAu/fJE++LDTkOeRheGDUHg3RqB/TelPRkTrA==
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(35042699022)(23010399003)(14060799003)(36860700016)(82310400026)(1800799024)(11063799006)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	zbuMMyAj/4MtBS1zF7ovSHW7RATjgmugZpiUKK5PX+XrUkqhzC6p3ATw1N9QNu5jBC+Dp6MAUKD20EHw4CAC2DmLWA8KIw2F8OABlvmvdtQ1CtXwdRVl7GW+gMm/C0X9rsfeioDAxI42C+bmrbjpxffSww8pmDJbOvM5pPUtpflx3ZHVLpaKh3uNp03OOwn9kcVCdL0HjwftDjflrMWEe/2kZvfL85bFYXdsEvvRLaOw9+tQX6XHFwQ6eQy0gf8hMfSv1KeFrpuv0+oqDsJhm+UJUfGinbOHAXq4F7YrQsesxXV4jozfCe8eqcPVtT3Ntb2j9xGYrXYXaUWXMUxrxyInPe79JmvSSIEQmGT/7YYlTzRbGOm16he6mhoshFNup9hPHd7ezBvsgs0Tgu05TxsF7wgA78SwosTqH3IEqSBBTMjgck8nQZtwXAC/8Ap7
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:17:45.3098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aef5d98-8a4c-4cd6-2281-08df08db6e6e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM4PEPF00027A68.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7433
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 02 Sep 2026 10:18:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4724

T24gMzEgQXVnIDIwMjYsIGF0IDE1OjM4LCBBZGFtIER1c2tldHQgdmlhIGxpc3RzLnlvY3RvcHJv
amVjdC5vcmcgPGFkYW0uZHVza2V0dD1hbWFydWxhc29sdXRpb25zLmNvbUBsaXN0cy55b2N0b3By
b2plY3Qub3JnPiB3cm90ZToNCj4gICBJbiBhbiBlZmZvcnQgdG8gcHJvdmlkZSByZWNpcGVzIHRo
YXQgYWxsb3cgZm9yIG1vZGVybiBPcGVuSkRLIGJ1aWx0IGZyb20gc291cmNlLA0KPiBJIGhhdmUg
Y3JlYXRlZCBtZXRhLW9wZW5qZGs6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbWFydWxhL21ldGEtb3Bl
bmpkaw0KPiAgIG1ldGEtb3BlbmpkayBmZWF0dXJlcyBzdXBwb3J0Og0KPiAgIC0gU3VwcG9ydCBm
b3IgYnVpbGRpbmcgT3BlbkpESyAxNywgMjEsIDI1LCBhbmQgMjYgZnJvbSBzb3VyY2UNCj4gICAt
IGNyb3NzLWNvbXBpbGVzIE9wZW5KREsgZnJvbSBzb3VyY2UNCj4gICAtIFRhcmdldCBidWlsZHMg
YXJlIGJvb3RzdHJhcHBlZCBmcm9tIG9wZW5qZGstYmluLW5hdGl2ZQ0KPiAgIC0gUGFzc2VzIG9l
bGludC1hZHYgYW5kIHlvY3RvLWNoZWNrLWxheWVyDQo+ICAgLSBTdXBwb3J0cyBTY2FydGhnYXAg
YW5kIFdyeW5vc2UgKGFuZCBtYXN0ZXIgb2YgY291cnNlKQ0KDQpUaGlzIGlzIGF3ZXNvbWUsIHRo
YW5rcyBBZGFtIQ0KDQpJZiB5b3XigJlyZSBhdCBPU1MtRVUgbmV4dCBtb250aCB0aGVuIHRoZXJl
IG1pZ2h0IGJlIGEgZ29vZCBvcHBvcnR1bml0eSB0byBmaW5kIHBvdGVudGlhbCB1c2VycyBhbmQg
c3ByZWFkIHRoZSB3b3JkLg0KDQpSb3NzDQpJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMg
b2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1h
eSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGll
bnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Ns
b3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJw
b3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFu
ayB5b3UuDQo=

