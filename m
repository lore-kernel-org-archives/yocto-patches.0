Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42627.1793193176988791321
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Oct 2026 06:12:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=mFhPsvXi;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=mFhPsvXi;
 spf=pass (domain: arm.com, ip: 40.107.159.21, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ms12Nu7I+dMsZIsf0Zbzb2G/1+iM8YnFjmzXZPt+rejg9ZUlTiQ1Gm7/uexfrk6ajJs6l4pg0LSsgmS6VR9T0aMVT0MuVNY9NDafcjQbA6HqgJKx824h5rSIv+Iud/5CySxQhn8jHpKc/zYuDBJGm5XiOUkojUWIPWf20JbmENIm7QElfl9eWMH4cQE1wIStJMQMEe4LZn0opor7D6oZbeEQe6A11wkAUCjvkkEzFOVnQy8fbFWYEIR6RHBaoAUE8h+gSa2yPCsg5KaxIoeKT80yHHVJi3IMKjV+k8LdEyPgVBqLkQM0UkCs8bIUYshASDWQC0m1O+8HjyhsOd8Xug==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8vlUKsE/q1v0IjyzngDe4EGNsPCQWbsYdQCqWH0dwI=;
 b=Qt+5jWPx1tG8YthjXhPuRwJR08bSVAOmhRCPdDB2eCY0Yhk0GIQ5pBo5cfBWHHWTLo5YV/jeG07yxJGJdTrYURomnDL2ccRAcEhostHaoB4dX9AJmqGXSiwSNev/o0LITEhhym/47EJS2jMzzqpJZzKsvSKPPtIinAcu7KLcKXdcNS7IpM0TId8mJJhp3pTsCLXezZhi4G/TARcO452680nMY5VtZ5l8LHRmGNmzJW2B2MhLZ695Y+p8FIRrU+kMMGDuws/X6rGYRsKe6x9772kGY4fiGoiJZR2axrncT2vzpn+4G0eO/zCAGOaLzuSb8mCi0A7Ny7fjnNS4ZDqLgw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.yoctoproject.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8vlUKsE/q1v0IjyzngDe4EGNsPCQWbsYdQCqWH0dwI=;
 b=mFhPsvXicvKs5BOVV0Aj+zP93QDeHccFsavbEjeGUUJT41bsKin2Q2aNuR828HASOT9QaCVyWBwN9lRFdVhFDY5gry7OzdkYhHQ6dYkOJZwyJSAKDELobsLr0WxVoscepASHE+Xh3UZaGeXy2+6BS9ZnEt4C6e+tkzHUVNMsIBU=
Received: from OS6P279CA0125.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3b::20)
 by VI1PR08MB10006.eurprd08.prod.outlook.com (2603:10a6:800:1cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 13:12:48 +0000
Received: from WA1PEPF00009B3E.eurprd05.prod.outlook.com
 (2603:10a6:e10:3b:cafe::a) by OS6P279CA0125.outlook.office365.com
 (2603:10a6:e10:3b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 13:12:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 WA1PEPF00009B3E.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Wed, 28 Oct 2026 13:12:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygch+Jo+8g+y3jlVX5qWsT2Ju/HvkWPwTauj3BPl1SqBDGbs461Z9eDGWa5wFXSftDqOQJ/21+lW2hEO147UNTEOUr2VtTe6OrB6JAJEHR4vuGHuDsgx2w/AYuzwtO6TdID6xHdmCX526szs8PZ0NufukAtW/HX2szmnCjqlWmtlFn8QYBWeVOuL9MYAVPnDZnUhLGZC0CLQocVYOT2yrZnUYucKtsRqV9yunRrNov6VGc6PmmBOGuk1Ta8PhoBMimmEqR6Z60/lNsNqgxuFCWSvyWPhzR1E8FFlhK+8EzY+GVP5DS2OnTLxKOTk+RvCqZzfgmA0sxRzZ5tfwe0aQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8vlUKsE/q1v0IjyzngDe4EGNsPCQWbsYdQCqWH0dwI=;
 b=PqCyPeRCQejs3SA5tw73fiu5JqaqOjPJ0AAVVAgDWtBzZ/YtzKx/b17fHNf1r19c1llSFOnkb8VijTGFkq7z33+LhNdfNryUNvUFM0SQTHGAh4s2hoo3bw1jIzzSbrODSY04bsVL/hQPd4Hsalov+qu3SmRF8Zgj1C4+/r/BsI3j5BtYsz6x/bKGiZJscqky0eb+2U5ucJWAxF5ourJ4VWEmXDVh8Jr7EIF9FUevHDBxfSRmEf1RhaiWt8Q6wfq3za12ULg+QyKKxCuzreLcwxY3UbIwLc9g+wdrJCcF3gNhnpG7E05P+0qudhkA2a7X/fSJJ6MQ1mB2UYcc33LEIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8vlUKsE/q1v0IjyzngDe4EGNsPCQWbsYdQCqWH0dwI=;
 b=mFhPsvXicvKs5BOVV0Aj+zP93QDeHccFsavbEjeGUUJT41bsKin2Q2aNuR828HASOT9QaCVyWBwN9lRFdVhFDY5gry7OzdkYhHQ6dYkOJZwyJSAKDELobsLr0WxVoscepASHE+Xh3UZaGeXy2+6BS9ZnEt4C6e+tkzHUVNMsIBU=
Received: from AS8PR08MB9410.eurprd08.prod.outlook.com (2603:10a6:20b:5a9::13)
 by CPH1PF94BBF0423.eurprd08.prod.outlook.com (2603:10a6:388::50e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.20; Wed, 28 Oct
 2026 13:12:14 +0000
Received: from AS8PR08MB9410.eurprd08.prod.outlook.com
 ([fe80::1f2c:bae7:a4d3:fefb]) by AS8PR08MB9410.eurprd08.prod.outlook.com
 ([fe80::1f2c:bae7:a4d3:fefb%5]) with mapi id 15.21.0546.012; Wed, 28 Oct 2026
 13:12:14 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "twoerner@gmail.com" <twoerner@gmail.com>, Gourav Singh
	<gouravsingh@siemens.com>
Subject: Re: [yocto-patches] [wic][PATCH] wic-plugins: use iso-level 3 in
 isohybrid plugins for >4GB files
Thread-Topic: [yocto-patches] [wic][PATCH] wic-plugins: use iso-level 3 in
 isohybrid plugins for >4GB files
Thread-Index: AQHdZr9anlxiMxRGlUG/+tQWXUmg3LcS7lmA
Date: Wed, 28 Oct 2026 13:12:13 +0000
Message-ID: <B49AD943-F7D4-479C-805B-B3EC5907E91D@arm.com>
References: <20261028093240.614428-1-gouravsingh@siemens.com>
In-Reply-To: <20261028093240.614428-1-gouravsingh@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.700.51.1.3)
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: AS8PR08MB9410:EE_|CPH1PF94BBF0423:EE_|WA1PEPF00009B3E:EE_|VI1PR08MB10006:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a234e9-2fc8-481d-1e9c-08df34f528b6
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|261021121427099003|38070700021|261026140227099003|260925021311599003|260925021911599003|260925022911599003|11063799006|261022075727099003|261022115727099003|261022105027099003|10067099003|22082099003|261026121527099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: pm8gTWQ+CCndoKcRLcGcxRWnWEZPYwaxziiq1XH2gJ0STojXEowuNSheuZbWmDG8Zccyvj7mdHz9jjmb+L4uzH1+byldnmXUJsGrt7zxCDu/g3f9z3vMuAGRH1AobABmAvXG0q7aifVGMSqrtmJTk83g3CPEYkJ1FUUF+xKLNHJe+pGsFeAS+qSVdTk0pmRwfVjg+ZQlu+w333qIQLmgCWp354HHURTegB+P35GYvYQhdrH5HxPQfaNVrKq2yjVF87D+KCvRwP3AeqpgUKNjDcty7Kvl2C0Mq7fCwKMzC7I1oOU+6LYctvgXkKd2vjZLRzLA+0e3lzemV3fmsEK858BeHInUpOcwe6kmDfP6ZW7nSFJV0CXU6C80+Gk1i9f93QdLbcvBk1mBD4RsIabWdg7AAbQpLrneOCnWTu7nf7NzhVcne8sky8HJQLWL52lGSZEF8fGqxm7c+d6u1YAX9NbCtqes+RMnWh/vXNHV2r+gao0wlwczdnSx7Qiw7oRnDLeKLmeKZcQkOHxWHsz8l71Ntdd17jUZJem0PfuoXfJuYb0WZfvAY/FnOub5s5GQaubqfPmZc3cyl5y9UWlOXKa8oUofdZoRx92YHdQ1mToTeqsigvOi5olEl3Qof9ktTqINbVZOGT2Zi3un5Z2lcr2RNAxpz49y5wFKeIv0RAG+KFKbK03I3IYZJVpdKOwhCFs8ea4vDLZoSjc9moD3vOZOYURNi9q4PhkbKtw67ks=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB9410.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(261021121427099003)(38070700021)(261026140227099003)(260925021311599003)(260925021911599003)(260925022911599003)(11063799006)(261022075727099003)(261022115727099003)(261022105027099003)(10067099003)(22082099003)(261026121527099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <D873836C0A140149993D7C46E99F82CF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OqzNWsxeA0i25FqO4G84dH2JJwK/RMw0zXoa1nkJux0t9XehtFK62wWqeJ1t6Ls8lnJsVZAZyK1wFqIOWoS24OjpMIuW/OCFWUQ/RKPKJLqwZu8TCGWmrTomxYxS2uMc14z+MHXfFGH6hNWgQUr+cGdRgSNq4QR7W/AEh++lQ3RwGlJac45G99HCxBivp/p4UkDJctbFC4QBkBkV+MCtOf5G56Z6d0Wb6oVKo7MmktTpTaiyYxb16ODBnEpb+pMhdm3tU5eSzByArtKSrtaeXOeESeLSNVMW5kOU1TvS4GWy6xLtFR7xGuWb4BReYZtafupJChlneriwe7frKIkM9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPH1PF94BBF0423
Return-Path: Ross.Burton@arm.com
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: WA1PEPF00009B3E.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 29a64dad-5a18-4bea-71b6-08df34f5155f
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|35042699022|36860700016|82310400026|1800799024|14060799003|23010399003|6133799003|18002099003|22082099003|11063799006|56012099006|261026140227099003|261026121527099003|261021121427099003|10067099003|261022105027099003|261022115727099003|261022075727099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info: P1RV+OTFzvH259XkG+YhnBbz7K3EF3fDX5kRc55Ohj/FHi8a1OdI1k4pWB5KU6dKXN2p5bKCP/iQyEAFt7nrdRSR5v12poXn3etudliY6SOUZ/9o2kd5GewnavCLKYijxTcldQdUfhFuUScM4Bms4WhRbxpOiHFiMsTMezDou5rjRbt88MdLBIXa3AWW2tnNxPcJx7L9Lnn11TXVcGQdLI/yLRo8lXR7NXzI5qaRED6gKItUXba3A5lk1TcDJx8bcXKyoB7lMv1/lNM0NUYCAMdU7OeOgHxI5PBKt9dD29AtrMytvDaIgtbUjeORm2EFGjSbKz+Eh90V9WF5cEgPa8QkPe0ZRUcbYyaKdrOk3uH9teUTyMJxt+dWtj8nuafwy71qKCkVkAxiK7AUpMRknzSDVZnk6Rg/i1QoSKJ+77ivHGAPNOcfpax1NJnNqrcbYF6263yWXGrrc/3FlPnl9eFS7iOGJHdOQS9cSKs+zMzgnC1D8RTnDm8oJS8H259ANLRvEsd4cBdI0PbIsALpYxoG7Wnr1dpEE8ofPu9HDSWBNx2/rzuSjNr3cuUdmIlY2sWNQ49daoqB4Zi3myrIsm0Y2Oh4ZY4Cyku6HGHhjMEOOxCeH3TYqrBOcA6Yif3hrdCuSNYdzWL6lN1K7cHmy/yK/t9+5UdGBrxqzGu+/Pv7yYEkrXx0X7EWvIKQP7wRUVvJUcuwd8zfijOnsXB/Hg==
X-Forefront-Antispam-Report: CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(35042699022)(36860700016)(82310400026)(1800799024)(14060799003)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261021121427099003)(10067099003)(261022105027099003)(261022115727099003)(261022075727099003)(260925021311599003)(260925021911599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gFoqxXQGd1scefxlsQUs+slKnENzERXHq6xznzz/p6LW2mEAdFItdX0MGadCtuU2uEUITaCmZOO11GQCuKWayV/kQ0GAI1a5CLLLIJ2bsrtSeOHYWybFeE5Is4FasS+6s1pfcJVR2CwvMAQCA5jjiBdC6s3QraNpZ+TTmmV/KofVUJLqEuUU432TWs/AjYY3Cx3rUxsoyTHvilD75qShUE8lfhOlyxnThCghUq++tNvosjC09b2tBJbjdT05mOTLGAivJuqKFpvOmKUeKlQeidmDustu9hhcZ+i0XiPlvvXRJ6+TebkLQuZl4R5BcKx+vr1TgQmKmaRXNuRNecFVHBaIg3EjAFDXwD7wf/CS0KG7fAkLT4N8gXSlhD1cRc+fJqNFYWmPKrrlA/5B51aBZaoeiliReTKSruZx0bXLRxfp9iGMXp/PemqR4QQnd92n
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 13:12:46.2759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a234e9-2fc8-481d-1e9c-08df34f528b6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF00009B3E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10006
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Oct 2026 13:13:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5172

T24gMjggT2N0IDIwMjYsIGF0IDA5OjMyLCBHb3VyYXYgU2luZ2ggdmlhIGxpc3RzLnlvY3RvcHJv
amVjdC5vcmcgPGdvdXJhdnNpbmdoPXNpZW1lbnMuY29tQGxpc3RzLnlvY3RvcHJvamVjdC5vcmc+
IHdyb3RlOg0KPg0KPiBXaGVuIGNyZWF0aW5nIGFuIElTTyBpbWFnZSBjb250YWluaW5nIGZpbGVz
IGxhcmdlciB0aGFuIDQgR2lCLA0KPiB4b3JyaXNvIGZhaWxzIHdpdGg6DQo+ICB4b3JyaXNvIDog
RkFJTFVSRSA6IEZpbGUgZXhjZWVkcyBzaXplIGxpbWl0IG9mIDQyOTQ5NjcyOTUgYnl0ZXMNCj4g
SVNPLTk2NjAgTGV2ZWwgMiBlbmZvcmNlcyBhIHN0cmljdCA0IEdpQiBzaW5nbGUtZmlsZSBsaW1p
dC4gQnVtcA0KPiBpc28tbGV2ZWwgZnJvbSAyIHRvIDMgaW4gYm90aCBpc29pbWFnZS1pc29oeWJy
aWQgcGx1Z2lucy4gTGV2ZWwgMw0KPiBlbmFibGVzIG11bHRpLWV4dGVudCBmaWxlcywgYWxsb3dp
bmcgaW5kaXZpZHVhbCBmaWxlcyBncmVhdGVyIHRoYW4NCj4gNCBHaUIgd2hpbGUgbWFpbnRhaW5p
bmcgZnVsbCBjb21wYXRpYmlsaXR5IHdpdGggbW9kZXJuIHN5c3RlbXMuDQo+DQoNCkRvZXMgdGhp
cyB3b3JrIHdpdGggY2RydG9vbHMgdG9vPyAgSeKAmXZlIGxvbmcgYmVlbiBtZWFuaW5nIHRvIHJl
cGxhY2UgY2RydG9vbCB3aXRoIHhvcnJpc28gaW4gY29yZSwgYnV0IHdl4oCZdmUgbm90IGRvbmUg
dGhpcyB5ZXQsIHNvIGJ5IGRlZmF1bHQgd2ljIHdpbGwgYmUgY2FsbGluZyBjZHJ0b29s4oCZcyBt
a2lzb2ZzLg0KDQpSb3NzDQoNCklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlz
IGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28g
YmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxl
YXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhl
IGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9y
IHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4N
Cg==
