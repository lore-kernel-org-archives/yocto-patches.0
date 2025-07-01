Return-Path: <stephan.wurm@a-eberle.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F6FC7EE30
	for <webhook@archiver.kernel.org>; Tue,  1 Jul 2025 10:08:32 +0000 (UTC)
Received: from mx-relay22-hz2-if1.hornetsecurity.com (mx-relay22-hz2-if1.hornetsecurity.com [94.100.137.32])
 by mx.groups.io with SMTP id smtpd.web10.6706.1751364508572832321
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 01 Jul 2025 03:08:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: no key for signature: lookup selector1-aeberlede-onmicrosoft-com._domainkey.aeberlede.onmicrosoft.com on 100.100.100.100:53: no such host" header.i=@aeberlede.onmicrosoft.com header.s=selector1-aeberlede-onmicrosoft-com header.b=A9CeOcfR;
 dkim=pass header.i=@a-eberle.de header.s=hse1 header.b=dXPyCFsR;
 spf=pass (domain: a-eberle.de, ip: 94.100.137.32, mailfrom: prvs=02702087e9=stephan.wurm@a-eberle.de)
ARC-Authentication-Results: i=2; mx-gate22-hz2.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=52.101.69.122, headerfrom=a-eberle.de)
 smtp.mailfrom=a-eberle.de
 smtp.helo=am0pr83cu005.outbound.protection.outlook.com; dkim=permfail
 header.d=aeberlede.onmicrosoft.com; dmarc=fail header.from=a-eberle.de
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=ULL4Ev3fogrbmbxx9jfvThorbFIUrPC2qtbv/SrDykw=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1751364505;
 b=MqCr3anxWyxRbufa9Ch5BBXtPDxaMLHWjqzC7+oEtwp8/Wg2U8WC9AJkh0EhNaPwGSiMf1W7
 bdbnQcGSDr20haivkoXB7jpLU7lv8MX/AiQZnfJzhl4lKiLkR7GNLLNgAy9i9NnhCztaEG4Glfs
 rMWO3e8weFX6ULEVZQ+TW41f+65C8kpVyKAkrqSI5gxfwcncHYQMXxKFin+CQ77Jk/dyiTegnvF
 vVjFHHUpVT/EKhC8kXA3ZPkV41ZXT68GBN8MpBNrvWrUOgLkYnv98UlII8zelNZ3QQI4RAL4A6+
 6z9WawWBT2rdN39i7QnAmeFoA89B7kOFf4ruxpxgGr3IQ==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1751364505;
 b=moBiIy35vsZ8B9ltRkMLrGdtKBb93W5sk+cEYYg8gS1wGoglgVLGZTUARLEaode0KVutVQ60
 rdnyN/j/I+4+mYfEj0nDbotizSNWlU7i7Ix9GbTZMrxQjUAEXvnYIsIy4UdiEImOmpYJcHgMjw7
 OPaXbpodxR4VQqCTsax7q20i70M92bQE/W72m6hWFfWFlBnVoApGch4Tc2Qs94C4r2l8plZ0aJ3
 7Wo2lUP9jsOpjDwmgNGZk7rmAHAbGADRn5TCcV5QQ2ylRvYkpHmS27bhh0JkYRjALITbK6A8vEa
 Fb/VeDPff/Znc2nqjZJMFRS+8rzbfSN22zsdJ4M7+xcOQ==
Received: from mail-westeuropeazon11020122.outbound.protection.outlook.com ([52.101.69.122]) by mx-relay22-hz2.antispameurope.com;
 Tue, 01 Jul 2025 12:08:25 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqntv4RoNJKSJ24XaN+09hI1fPYtbtrc/Ksn3ZBDceALZZdSyXSYwtOWzrxXcKD+oXJUJfKY3Llv3ERKfJwcrWaJMAbO9CQVxiYaT21/kGykdU3NJw0FoD23ajgAUgFUWzKk8J/1nj8nAcfc/i71QJ5kGKgYzlK347WpLGlGqYuzmVnLCSmRkVEwiWyrEluM2qNEyCxDm2MGOS42pyFazlIkZJiMCYN73o6Pt8LvsLE0VrTqAmfpZfrICgKS8TeveYxcGE7wmzxzlcFv5KAkhwSQxFBupnJRtpfpL7P/QI73b8FaRy4MfFtZRX+Iw86ITC1VIKrSSImCWEbuxYsFgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULL4Ev3fogrbmbxx9jfvThorbFIUrPC2qtbv/SrDykw=;
 b=YeC2p3TXmk+lyqYc4AhZp6cmNMLIwqoXnE/Tk0KaXh6XDw2WfiN1DS77sMu78GW1LhoQUWS6OMDJsIMmjUZYbjeb1s0KQTbe8DBvO/OUauEzUVpdaxVkHRmofLfo4VZbOaUOuf66IJ8hxGBvJLgVEpDxn/lVlhKOFCe5hMKq5V1d1BQECgt/akA9+uEG9wlEM/8D/8f5ioDyXq5LrYj8O+weRstgve3I91jIIfMnUi//bxI5kj7wQ3joWsbfZ/ti9rL7J9zdfYTJhrojCGOVFWR27+oaxvQlQKVoFzLbWhvnF7kBG214L3n3RTa1SVbDbvLA3lPVUfNuLYvWL92JLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULL4Ev3fogrbmbxx9jfvThorbFIUrPC2qtbv/SrDykw=;
 b=A9CeOcfRYR/wHU+D8I+8p8poBaJYn1x+D/H7pn1Bx03l0qZxa3+3cNl6nIsle5Hn4BROEST8VJjwDLsKPq+SmoI1Q11OYlEaWgSlD2Z0JoxlLTOJlZF///IOlQHiL1N7z59iM32+EBNgxd7uU67uv/3GX/SQpG5UUu2Y9awtK4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
Received: from PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:204::16)
 by DB3PR10MB6761.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:43c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.28; Tue, 1 Jul
 2025 10:08:09 +0000
Received: from PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49c9:32c5:891b:30a9]) by PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49c9:32c5:891b:30a9%6]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 10:08:09 +0000
From: Stephan Wurm <stephan.wurm@a-eberle.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Stephan Wurm <stephan.wurm@a-eberle.de>
Subject: [meta-security][PATCH] dm-verity-img.bbclass: filter units from value part
Date: Tue,  1 Jul 2025 12:08:05 +0200
Message-ID: <20250701100805.667423-1-stephan.wurm@a-eberle.de>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0449.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::9) To PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:204::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4948:EE_|DB3PR10MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d47410-fecb-4a2e-ebcc-08ddb8872e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LspIn/HuV3U987FJrBspZxr4lzrEdOQstqIchYB96f/aznbpP72GYcM87xal?=
 =?us-ascii?Q?B5MC7oWIMfXlGyBTyhDn0m3+VQMnCHIafYdIsdjvTRUI4qf0fjAPef0lC9r/?=
 =?us-ascii?Q?oVHZxCKiQ+HcLv5snfSf7ii/Xhbu4zj/qrGlqZiMYZU6v46KSdMteWAMKVr8?=
 =?us-ascii?Q?UTkprt+HBlAcc+qAPloj14SLbr+a+oXNr2Mg55HZuNYet0T4aRAqqs8nv1jU?=
 =?us-ascii?Q?2KDWHhMFfJdzFQsUg1MUGHH0SUlQWVWpWRsqM09A9dw1Tjd17igVvX+yr41Q?=
 =?us-ascii?Q?hioHxooOalh/xE0tFAUN6KoNmkWZi7bDrHVxohw1EwGLzFUGpym/cCRaBatE?=
 =?us-ascii?Q?q2fsA5WWF3z6PEZ/EP6fagY1o/TFm6gqZ0sLwC/S77uepFmd12p5ot0AbHol?=
 =?us-ascii?Q?VwoSaIXZIxa3/GqxohiJkL5BnSLiTXJrWGekYSQWdmYEFfJdTKlaUA8h+Wyl?=
 =?us-ascii?Q?826HP+1w6Ew5QwGj/bSPG4E98BMHarONPga02seTsgw9SS2Yv8ZuEgLNJAd5?=
 =?us-ascii?Q?GtYIqqD4W4r7nFpmpwkO8LrsqJZwiSCsI1zBdoUeSagEKJ8vmaTB6WhcN91/?=
 =?us-ascii?Q?rWRi8QjaDLzCZRgEl9Mjty7DuZB8/txbeOPlh9NoOEo68Fm0JzZ0GEWX6lOo?=
 =?us-ascii?Q?sBJKh3L9HKajaT2aSSWxhi6/rbnu7CP99cE4z41TfvFOKdN5TMEChTb3w/bV?=
 =?us-ascii?Q?pMq+T8tI0apOTIwRofkmExcr94KL9ObIGhpgbDBcrCOONw7CxK28TJFWIuoZ?=
 =?us-ascii?Q?xOYMKIuorfSXAOpwGCLL1h2nfMSfxy7V2IOhZw+AQ1+IiEBMBp17Jc2oB4jt?=
 =?us-ascii?Q?pnNy/BpamuS7ZrpFzWjOTRp3kC1yIY0MCGmvK85GV2JusqZxs3opN76XImbp?=
 =?us-ascii?Q?tBQlpOYEHhdaYxHtftZz//4kY9ExQEoXjxMpKfTvJYOjqATK3lZTjnDE/Kwg?=
 =?us-ascii?Q?N3g00tmRTb2z3ykAS6tQDUWRw5/fkLX/++TeqBpoad3yCMWNVTjSBm5WRzq/?=
 =?us-ascii?Q?c/kpvmChB5CrASlVE7EXrDw0ghF/SzGVinHB9BBW34ZVvj7BUZe7gWNqbTPe?=
 =?us-ascii?Q?i4ty5zkOXRdrTavO4Yu1he6z571rwWmgKFCISey4eVYJAdnVHSOqejk0J8E8?=
 =?us-ascii?Q?pCHz17PBfLiICS5PLBG0lPTxGglqrYS9ky90P2Y0A9kFqRpnesJz3EYxkKTR?=
 =?us-ascii?Q?jCMaR7D91mx60t9M0Np5b4tfWdp0kM5WJfJID+E09/o+mATYLK78nmeyR++1?=
 =?us-ascii?Q?1NjEIkp52gHIEwDTCPiALKHoghmh3nCDYd27cMqR8Jyf8ewBKiXQAIU9mRxb?=
 =?us-ascii?Q?3e0huXIBgE0boZ3hKjTyEg97YPo8jMEKbaQeloByFpmcb4YQBxz3ZuMPPvAI?=
 =?us-ascii?Q?QEy16xVGemi9mlnZPlvYsqOgYul0n50ifJGrD/5nR3HfVSX9XVjUEEhmaZtn?=
 =?us-ascii?Q?6NQLrtuvk4U=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dtxvfUAfrJjrMDBZwTMVT7p7yooNUh1ah2DWgfBZtjhuhovrP5Z/TUVterc1?=
 =?us-ascii?Q?5EPJgqddlKrGibIQOhZ3J41MUeMkdaAM2Kbn0+aSgw6xkFtExQbA2jHa0FJq?=
 =?us-ascii?Q?A6ovfeHk6UfTTQzBbxkrC1gqWeI43yjOMZDeNLCC1K83u5eiHJx2gZg3wMhb?=
 =?us-ascii?Q?UrZy1/pY8CswVk2BB48obRvX9Id7Ys9dA5xXW9QHm/NWD9Y7Y2ofFgjOtKFY?=
 =?us-ascii?Q?lqOR6M+ORFFM9UAWQGyZNxMDMnJ//dYDGaq0TEaf6mcfhoYHr25RK+YE/KSG?=
 =?us-ascii?Q?qDYvbqUGlutHlzYTgURClrOzWRlGlxqihr2cxseWYTQRrAtS9UQxwGpffhaD?=
 =?us-ascii?Q?dQAPcsfNESVeoXgadIJCIbCRXWb8qYEjT+mysObA1JRFR8V5C/rOrlZPrp+P?=
 =?us-ascii?Q?srUQXrYc8UlreVWrKNqW54H0ej4VJpgk+6Ym7ygYlc3JvJj01Q9aUeJHvViq?=
 =?us-ascii?Q?IMYc1Jei+uCYauo4B9fvcySkRgyEXzr5vQeZHFCyhtSHXGWnLFItBhRK5JUQ?=
 =?us-ascii?Q?73tO58Qek3tMhYkLRD4Yj6CtkFu5tvfOLiWh6E5e2FFCGJAcQbqZRBkGuTKX?=
 =?us-ascii?Q?Z2M4XslCSCB6JwSkW/ZYC/hLenu2XNaQdefVpHyq+FeHRRtiGwRNINtArqvy?=
 =?us-ascii?Q?zSb+wa+FCjidQsr2maNmPinEjDlhyAtZqL821ojkBVwKYeUuwJBi51N2Pgk0?=
 =?us-ascii?Q?fb4raqLAa65HlIx7yx5EdDKYo5UP6fH8SrUM7tbXZIUsQAYSj0FE4QQTn/I9?=
 =?us-ascii?Q?VwzthG+C1jN0XZglAGJSVaEou7T28rydlpRihEWE0tZRPoWHd74EqrmPoj6P?=
 =?us-ascii?Q?fEFvQwtqz2oI/l6Ua4V9KtNHxzyspD8PM8mbhriEiY9wxkxF9efnQkEYcuCc?=
 =?us-ascii?Q?Zm88y/M4NZxhmmWwyHL0UJ5wik3VXXIHdnlT8PPduZ1ILHuOsBYJJdF7iMP5?=
 =?us-ascii?Q?lKa1m3voO7854j95Vsvv1AtiVKv7eFx8FK6vQZ0Zb2j4SFypJ1sk+87ej6fT?=
 =?us-ascii?Q?jGdU4YR4AOdQV1rPunWQof4iRXj/TVm0Tvsk9S8Rdu0MNQx39RA8Jccgz+UO?=
 =?us-ascii?Q?/UCa0A5XjKh40Fbmwd3zj28yJf9X9MuvEMT9gFGfLq7jQeKa2+PcREV5u1k/?=
 =?us-ascii?Q?auGHR4iZXuCpGQOlSwzxM4IuXjUqbydld6jWTRtnu6M58j4r+DBQi16pKk9a?=
 =?us-ascii?Q?61I6WbLl+/iJw8oe5/HXz+KZ0O/psX30ancgRsLnz565UvD+QP3G7zlG1MVh?=
 =?us-ascii?Q?gRWusd1bpoDaYJZnpyZ5WD1WpFR33IeEXsFP9e4wpSt4/Lz4aP2S/C0pRvm9?=
 =?us-ascii?Q?RtMxb1K8ElJgkC0H304qPi1LVZ/e0mQHrj2dbpE/CEjkhAcVwTF9BgywIQre?=
 =?us-ascii?Q?h2Xu6UMFDN42SfkWVTUueZw6a3EAdYQducUEfllTSFBd5+KOC5oWBMiraaOs?=
 =?us-ascii?Q?IhpYyPFsR1YClhC6ORb1cBbwn2cx859g6Imy+ockjtphFEgZhLUBWmYURjCb?=
 =?us-ascii?Q?0aarXaP90uQ5uVipY0M0MOVTus2+hWKbHhRB5SRXItgICBH6H0uC2RuTeWmG?=
 =?us-ascii?Q?DzCWoMuJBdFEt6NyDmljkY6yhqfi4Qk8h+OI1GY+3jGNHw0yZEDFxtZvEMoA?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d47410-fecb-4a2e-ebcc-08ddb8872e2e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 10:08:09.3591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /psMvhI2QAhChCmBBE1GG5gmZ0i8kW2KyF2QRB8QffC9A94+HLrC/TlTOzbjkQAEm4Lbjx0IaXBkGhnaEd6+3JJDW0HVYHVG/mfJNIhQ0Ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6761
X-cloud-security-sender: stephan.wurm@a-eberle.de
X-cloud-security-recipient: yocto-patches@lists.yoctoproject.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: stephan.wurm@a-eberle.de
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay22-hz2.antispameurope.com with 4bWdyN2RSBz3BM0S
X-cloud-security-connect: mail-westeuropeazon11020122.outbound.protection.outlook.com[52.101.69.122], TLS=1, IP=52.101.69.122
X-cloud-security-Digest: 4aeddc300c6203ca445a1570fd6daf5e
X-cloud-security: scantime:3.071
DKIM-Signature: a=rsa-sha256;
 bh=ULL4Ev3fogrbmbxx9jfvThorbFIUrPC2qtbv/SrDykw=; c=relaxed/relaxed;
 d=a-eberle.de; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1751364504; v=1;
 b=dXPyCFsRSlUY5HgZDFkUcToSqmKM0oha8L75v9NAtufGfG/t2D2FElKTGPMW7MUhzSAMpCIH
 3tJkaKsMjdM9Mi/qoc61Vz3bAIMT+SjUMkgQ0QuwvpTZKkJPlwYUpNGBJLBSdNIe1RfP8cEgTrg
 nyugLKGmfGrCwXHevlCQW50ACyxOevETERUHopt48YeorWTI7SX14JZ/TtADIy3P3K709ZLx5UK
 9ZMnrHNBUYzrHs5plY7JZmXTYYyQztrFwrltSQGlfh0Lm1QhUc7yGNFqs3gO9JZaLLaT8vvO/5P
 jwTkTMIsmhX9FlSgCJMatQh4OlejEQAKuf7NqMfKtTH5Q==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 01 Jul 2025 10:08:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1729

This is a preparation for cryptsetup v2.8 which introduces [units] in
its output breaking the parsing of veritysetup output.

VERITY header information for regdy-image-aeberle-tk102q-20250701085433.squashfs-zst.verity.
UUID:                   5dc16c55-79b8-4988-9d79-900f8e143f98
Hash type:              1
Data blocks:            40091
Data block size:        4096 [bytes]
Hash blocks:            318
Hash block size:        4096 [bytes]
Hash algorithm:         sha256
Salt:                   f670bf67a32f4f5a22e052d7bf84830f8d35ea24e2d52f585f6275207899153b
Root hash:              a7eab55b7933e347650671611e4b2a10571f2a28a1fb0fc8eae409f7a0d86693

Extended the value filter to remove the [units] from the .env file.

Signed-off-by: Stephan Wurm <stephan.wurm@a-eberle.de>
---
 classes/dm-verity-img.bbclass | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/classes/dm-verity-img.bbclass b/classes/dm-verity-img.bbclass
index 47f698c..48557e9 100644
--- a/classes/dm-verity-img.bbclass
+++ b/classes/dm-verity-img.bbclass
@@ -71,12 +71,12 @@ process_verity() {
     # two parts into separate variables and process them separately. For the
     # key part: convert the names to upper case and replace spaces with
     # underscores to create correct shell variable names. For the value part:
-    # just trim all white-spaces.
+    # just trim all white-spaces and remove units.
     IFS=":"
     while read KEY VAL; do
         printf '%s=%s\n' \
             "$(echo "$KEY" | tr '[:lower:]' '[:upper:]' | sed 's/ /_/g')" \
-            "$(echo "$VAL" | tr -d ' \t')" >> $ENV
+            "$(echo "$VAL" | tr -d ' \t' | sed 's/\[.*\]//')" >> $ENV
     done
 
     # Add partition size
-- 
2.43.0


