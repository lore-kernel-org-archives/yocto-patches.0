Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04425F3C997
	for <webhook@archiver.kernel.org>; Tue, 24 Feb 2026 15:12:44 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22416.1771945953889933975
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Feb 2026 07:12:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=CRfnJHDz;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=CRfnJHDz;
 spf=pass (domain: arm.com, ip: 52.101.65.54, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=lnK6qU33Fvg7R9KnHoNV7bQ3nvPpbnJjjj2X1JVVWqE6WOyIY9lewpKnvZMTu9HqOpgwp950p8Zti8KYs6Jr4gSXhH4JYF+PFUmCxWldIVk9f4MDk3J3YaN7NJMTpn04nOCFWUGctAUYJ8frRqtSCbH4+wfHDvrszVGX15BgsQ64assaRcCIhVYKUoE9maHaLkY5YMK9ZS28n4o6SYPRax2ZMizsmpb0AZ1JIcprWiJ36gUw18gy5QRb9jN2YlGlNp9sHhIN4LJ/f6a+NryoncsAGRz9iDFUDNSwOo9m01fQypWT5yncakWtqaVSvirb4frESaizkxO73Bh4rB4EFQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvwbZkLwBSFR43qQqxJr1noI/WODUQrhA4nlA3FiSjA=;
 b=BSo81d/zTI0UJvDjk48NL2T7GkjmmII2JfqKplALqD3DatAL2mBNguF5XU6nABLVRu5upOBl3c8mc3dZE4oJG7p4Tf1NDmQBm8CuqLZGm21XS5/VCg+fi3TSzmgm7J+0mXubud+WvPB9i1XEVfkaWRznKYMqvznXF3mqCsJqyP8vKGRJB0d8+a2If73/gU++U2k4Rm7t5OfY0dQiPzoA7vr+cm/SHXCB1Bl8t1xvdw4nD08jJyR0C3OP7C/WgI10PXzeOZBkXbxNgbxyXHd51hTu/n4qe3inMsq5bnjvb2ZnZh1T/7X5e1ANp0XrZJVFCtkGCWhRvtSUG7lBxXJ6Fw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=siemens.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvwbZkLwBSFR43qQqxJr1noI/WODUQrhA4nlA3FiSjA=;
 b=CRfnJHDz5mMSh6tc+qw0J38a/XQ2Ot+0AT2+TIciTxpYxL+db0/P7aAnAizSGSIjfc6u5MS68I4qckFrkG2564nH2W+sHI6VITFXWYx18869nfyMJ/P3utxqC2QJBikMnFfA8tIVI3k0LZRsi9ksQcdQdk9Pikg0UWN/DhusgM8=
Received: from AS4P195CA0021.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::9)
 by PAWPR08MB9966.eurprd08.prod.outlook.com (2603:10a6:102:35e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 15:12:29 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d6:cafe::74) by AS4P195CA0021.outlook.office365.com
 (2603:10a6:20b:5d6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 15:12:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Tue, 24 Feb 2026 15:12:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyhEMdSOoJvTt0+OxlGG/jcle+AK4d+Pjcf5kLIu//w6z8jD7yZvBXuMlJs+NgQfGWETDYNhlqPgXIjFw+6HTar73385a4+NLJlpM/R2tXglwgmNyOXuScej/02DJ2vEnbQcn+2Et1BuHCPx9oDD7SNrZ+kkp7RWhHeZa4SIicAIktk0/z8oYCM6gLXA+uMEt6tz3qznLff3M5stiLhjKlzOKQk5x4OLMSXSXQjWxlymSqhLtNa3lt9KBE8eBA2t//PIZyQzDghc5/8sjveKRSCQ90AGe5nDx11Y7eYa74eFi0V2aQ3q9tKUvI/fza1en9AK45d/gATukCrgg1Oe3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvwbZkLwBSFR43qQqxJr1noI/WODUQrhA4nlA3FiSjA=;
 b=H4B6/HGp6HEG9Axq3nxJOTaD02JAYNIs/9ICrh2nvMv+YZL6p/KhR4EIxy9zDyuAo7BvsxHA6HX1ksz2Nz87zqQ2aZtvf2q3XR+cqdV2pnqJLFo9raPQVGU9T0XeQEC8swIr1TfmuggyXPOxjzzIIKu77twHN7SCuqSrTsPsG9qPEo4KzL+GOAbxMFQvOQ5cm1TkFWQCFYM1DDb42dEDaY8kpIql6mHlp0qYCbDxVRTe5vxSHrH1VQZCunFSaPajTUdgJKixpkP4zJRhvOdFOm6EvKiRIlmrY+xc+WpXjh6JcHjhtUGp7rfHhaiNJZmtula8sQNenjPy2iBKEMNd8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvwbZkLwBSFR43qQqxJr1noI/WODUQrhA4nlA3FiSjA=;
 b=CRfnJHDz5mMSh6tc+qw0J38a/XQ2Ot+0AT2+TIciTxpYxL+db0/P7aAnAizSGSIjfc6u5MS68I4qckFrkG2564nH2W+sHI6VITFXWYx18869nfyMJ/P3utxqC2QJBikMnFfA8tIVI3k0LZRsi9ksQcdQdk9Pikg0UWN/DhusgM8=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by AM8PR08MB6386.eurprd08.prod.outlook.com (2603:10a6:20b:362::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 15:11:26 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7f73:806a:3493:7d50]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7f73:806a:3493:7d50%6]) with mapi id 15.20.9632.010; Tue, 24 Feb 2026
 15:11:26 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "Marko, Peter" <Peter.Marko@siemens.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [yocto-metrics][PATCH] patch-status: add
 whinlatter
Thread-Topic: [yocto-patches] [yocto-metrics][PATCH] patch-status: add
 whinlatter
Thread-Index: AQHcjWuJMqLPjUq70Ei46CgC2WIC97VkSsyAgAh36ICAIo5sAIABe/OAgAFXugA=
Date: Tue, 24 Feb 2026 15:11:26 +0000
Message-ID: <020577AB-8BE2-4CE2-A4DE-7033A1A9FFC7@arm.com>
References: <20260124195614.1874743-1-peter.marko@siemens.com>
 <F7383EE9-2EE0-44C5-91CC-AF540D574E5C@arm.com>
 <AS1PR10MB569754E2254D487C56FCE53DFD9CA@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
 <AS1PR10MB569788AB28F1B97586FEE355FD76A@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
 <AS1PR10MB5697DFE8B76706E8B0444865FD77A@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: 
 <AS1PR10MB5697DFE8B76706E8B0444865FD77A@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81.1.4)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|AM8PR08MB6386:EE_|AM2PEPF0001C714:EE_|PAWPR08MB9966:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8fda74-9a05-4c64-2dc4-08de73b7203c
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|7053199007;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?dUxiejRNQlZSSEtWRkFxNFJBNFA3ZG53T3RjeE1WcHgxK0VVWkNzbEwzWjh5?=
 =?utf-8?B?d2Y4YVpmUUN5bXpEVVZ1RUViSWEwL3pjcnh6QUFvNENwWCtVKzk2TFBuQW9k?=
 =?utf-8?B?UUNHTGgzNEZNaGhFQXo4MEN5RitkQ3plVGEyUXp3cDBZd3g2L0pPa096WEhv?=
 =?utf-8?B?K3VoNWVXRWw2eU9Ld0gxSTlldjJEdUtYaDdoTjgzRDBPQTBLUDR6dFhuZHVU?=
 =?utf-8?B?RnRMYjJ4TnpxZjkzb2N5MUc4ZVpMcHB1R3lkKzhyV0N0STN4TUVGU0RUNkhM?=
 =?utf-8?B?SUtEaEhKcVVrdHlORnorVERRcHd4TnVnTGRGT0JlSEVpRUFKbG9URVlHZ3ND?=
 =?utf-8?B?WWp2c28zK2hDUHhuK0VGQjhvTHBDWHpNeWhsbTBEbUk4MHBvcmEzMVFXVmpr?=
 =?utf-8?B?YlplcWlSVVhOL044dEQ4TTZrVnlwVzBGRC9XZXZ2ZyszUzdXUUc4WGpIdldB?=
 =?utf-8?B?WW9pV1dQbWo5SE0zbDhkc0xKVDdLT3hicHNiaTRvVG9Cd2NpZENYR3F1MXdy?=
 =?utf-8?B?WlBuLzJGa2hPNzZjNHpYVFZMQitTSHVXWjNaMUVidUNSRzhXQnpOWXB5R3dC?=
 =?utf-8?B?SUNQNUF5Q0pxSGRlSERyS1dnVmhwKzZueFRWQ3NqanJaRnVqZHVsdkNVbTR5?=
 =?utf-8?B?Z29kK0tFQ0VKTGJWT2tvTVhnSFVXVkZSMmJETnJGNDJLRUNLdjJULzhQMUhr?=
 =?utf-8?B?eVhKeW5zTU45NlRZMU5GYWlMeE1GZEpDdVh2S0JjMjBaZEV3MmdHSW1CQTc2?=
 =?utf-8?B?QnMwTHlmeXBkdzNxeXhuRTg5Sm5HRFBXYytkNjZidTd2RXBJUkUxWnM0Q3JI?=
 =?utf-8?B?NGQwR3FQaFdxNjRwMGlhMmsyUlFCRTM3RC9GUklCK3J5WFpzcjNraXdKUFVm?=
 =?utf-8?B?bG81dGoweGRNbTF5TlREU0w5SFhHcldBRkpyN0RQUFBRVjVldmJWTzdWVlYw?=
 =?utf-8?B?RDZGYWU0L2pmT0t1K0oxVTFtYmhVR0ZMS2dKdExuOS85NG1FNC8xTjFMTHhV?=
 =?utf-8?B?VlRvKzRjU1lOYi96c3E2OEpPZVk4SlRacXlYK20wU0hVWUxnb2VIZnc2SFZG?=
 =?utf-8?B?MWFoeTE1U0w4enEwZlpnYkgwR1U4NHdPUEh0OUhtK0Z3czZWUmkzWHJYZkFz?=
 =?utf-8?B?SkNheWhHZDNBektKQTVEUWdNa05ZNUFyUGhkU3FRSzcveHR5MmZ2T3JZQ3lG?=
 =?utf-8?B?aHUwS3d1aGpuK1dpN2plWi8xd3gxalFpWlVIWnJBN202U1F4UlNnOHRMRngz?=
 =?utf-8?B?SFZRd0tGRWdXckRLZVZXeWdvbzdZa2FBNUpUYlVaUVhTbldOajNGUTYvV1BS?=
 =?utf-8?B?SThIU0k5OXY4TTZNTzIxanRBck5QREFPLzQ0anBiZFB0Z1VkdjhPcGZqLzRy?=
 =?utf-8?B?akZrQUtNaFVMVXdwT3Awa2w5ZWJmU1ZsZTQ1V0thOU1rZTloNlFGNWZFQkgr?=
 =?utf-8?B?MVNCRkhKbzJFY2h6OUMvcWhpSW9GNEF4SU50c0VEa0E2N0N6SXJ2UlJSRzJ3?=
 =?utf-8?B?d1AyZWlPamFDRDEwVVJUYUJNS0RQNG8vQmt1TTZlbnNWcm9nKzgxanU0cmJP?=
 =?utf-8?B?OWNqSC9UWnZvcTJianlrdWpLeWpidjJZK3lQczdHYlRBclZMWVUvS0IrL3RP?=
 =?utf-8?B?K0gxWEs4WStNODVBVXRHWUwzRmsydmcxb25hVlc2UU1NSEd1blR0QVFhZXZW?=
 =?utf-8?B?Znh4alQ1UXVqdzdYbkt0OERNYzM5VWhtSzRtWWtnWEdHVEttYUVmV0xDUlBI?=
 =?utf-8?B?SU9hYlBHdkVvSG9TQXpRZWplVmhwRjMyb3kzNjVGYWYwdm9yQjYvQWY3ZmRY?=
 =?utf-8?B?YmJoV0dUdFdpaUlWT2pCR3kvdThDU0c3Q3RZRUx5UmpFQ0x0Y0lPY04zSUkz?=
 =?utf-8?B?VHY2VDdmSktLTllobmtjZGZIMXBJOWRYbmFta3RNSkVjWk5lMWFEYVJzN1pz?=
 =?utf-8?B?QjJxdWt6eW1FN1Iya3R6dzlqQUdhQmtKYTRRd1FGc2RzSkJTcTQvNmRicHJT?=
 =?utf-8?B?SWF4VUFYL0hTcjlldG4zejQxUU5TNE44K2dCQzZ6S2tZcFhsQ0IwYjlGRG9l?=
 =?utf-8?B?aGZ2L1VBM09DNWVJYmc2MHdRcFRZVzZDT3NtdmJ2VTN3Ky8yS1kvUm9ucFZn?=
 =?utf-8?B?OEFJOVVqa3BpUnl5YTNROExBdkhvdU1qNUo1ekN0NWF2UmhiMFlDNjFXU0Zl?=
 =?utf-8?Q?ex6mUgLyZykqzXB78IMNd74=3D?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD06F2960AD8B24BA8392C9954F86616@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6386
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	5bc24694-05eb-48d0-3c3c-08de73b6fb19
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|14060799003|82310400026|376014|35042699022|36860700013|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N2hoKzZOMXFvbWxYVlVacmdINEw2K3YxYU9CdkF0MC9ud0ZQTVVPOVFsZkRC?=
 =?utf-8?B?WDRUcXNEQWwyaklUMWNFRXB0MWl6UStTbmpjWHZVRzNmZENrU0dsNUJLc0M0?=
 =?utf-8?B?cWpGV3pmeWgvek5sSXZ5bGt4a3M5NnhrOU42empKdHlxdUYrQzRsclBzMEl1?=
 =?utf-8?B?U1ZtR1lvdXlCazZTM3JlN3VMMHVSeFpmS2V2MWNuZFU3UjJwUDIyakkwS3cz?=
 =?utf-8?B?QzdPQUw2Q1BpRmZjNEl3SWNjdTBGNEtoZE4vVENPVGVrZmlZZ3Q2Y2FkbVdx?=
 =?utf-8?B?WFM2dmRZUG1jNjlSTjBQUDNCWVQ3cEw4RmE4SzNnZ3pLdGdiNkt1bjVSU1Vr?=
 =?utf-8?B?eVdCdHZsanpSY29rUktSa0k0QTAxay9jZGZlR2d1ZlFUK0JlcFF3S2ltWXF2?=
 =?utf-8?B?TWsvOWVLVUJscDBnOUpRL0hDb2hEbm1VNlM2aEw0VDJISkpCd1NjbkxqMDdj?=
 =?utf-8?B?cHlNbUVGeVBmM290ODlTclU4SGt5d3pLRFQ4OTBCRlZQNFlhdjZnc0I1bUcw?=
 =?utf-8?B?a0FOUFlVM1ljMFA4QVlzN1N5d2lRdjg1VlBnbi9WcjlWNjVYRHhOdlVkZlVE?=
 =?utf-8?B?b1dPSXFrSHdaRGIxS09jNHlsRktKMEtOcllORDFIamtEelA0b3dkd2ZFTjFz?=
 =?utf-8?B?QjJtUlkvemFGTDcrYXNhU0hWZlJ6azBzZlNaVTB0eVhJaE1zV21TcEZrdUE5?=
 =?utf-8?B?NythRXFGa0ZhUzFRRXFYN0hxNzduTmUrSXBKQ2t3QkN4aWVZT1dzVFdxQnMw?=
 =?utf-8?B?Q294Q3FTQjBkY1Avazd0SlVoNGsyeSt2Y1JvblV1Qk9VWk9XNEZ0ZXc5QTN0?=
 =?utf-8?B?SzhWemZTRWJ3UkVBeFJMamloK2VVZjY3NStaRTE3bjc1amRlUVgranJEWmVk?=
 =?utf-8?B?VGtkWHJjK3d4cGlrQW1hYUVmUDZEbXZoVVhRVFhqM0JsUXUycDQ4b1kvNWN6?=
 =?utf-8?B?aHdMcUY3YVNoUTliYUVSZkQ1UlZDa01hUkxtbGIyRWlCM25ObFBjajJwMitS?=
 =?utf-8?B?NFk3VE8wWTdkc1l1anpoVU84dVk1cDI0ZDY5ZjJHQnZSeTRQZWt3U3hjTFc2?=
 =?utf-8?B?UDFTZFNVUGlwNitNK2VDTDVmaFZHY1RMK0tncGI0ejcwMWVFMGQzbjBpenlm?=
 =?utf-8?B?bEpYd2tNUjkrb3UvWEo0MkZLZmNmRWVWZDZDcnJvMEM4cnFLdHQ5d1REalNh?=
 =?utf-8?B?bEJrMmpuMEpORmF0YmphMEU3MUF3K0Y4eGo2OFg1M0hZODFaQm1aTit2b1lN?=
 =?utf-8?B?Qkw1NFlMbXNvT3A1eWNrUGtmVldxVitybmdlQWhmaFZPOVdheUJwcldSYUhQ?=
 =?utf-8?B?Y2lLYU9icDQzdFh0RGU2N2pFSXZUMzI1Rkh4RzkxVU1iRDNSS0NVMUt5TUph?=
 =?utf-8?B?bXU4Q242OWl0T2d5bU1JbGp1MHpRSkZ1aUFTeUJ1MTZUVzFlZ0tMTUpvSDVj?=
 =?utf-8?B?L2swVDV2cU0rYlk1bm1jN3ZxUEtZcnR2S2xmeU5ubFQvRzI4U0xScUUzbHh3?=
 =?utf-8?B?NlJxK2plM3hlcDFEbVVDbHRKVUN0cjJubU40d2hUUEU4MEdyQ3o5R0lyMEJO?=
 =?utf-8?B?ZGsxL2Y3ZHdQN2FMcldKUGFuWHFrSkVDMkFBTGROYlYyMUMzUmIvdHEvcFIr?=
 =?utf-8?B?NDhYN3NncXNaRGJsS2kyV3c0b1FOUEprOTJXWXFHN3hNcFdEOFVJQnlNMGdq?=
 =?utf-8?B?MXgzRVl6ak8zamtyTmNidGNpbWYzcUkxbWRXcjBFdWIrY2hLMCs5aTBuaVFW?=
 =?utf-8?B?TUdkWlN6dlF3aFNGcFZkMzBDMUt5Ujh4SzMyaXpoZEk4a2t4K1RXN3dRVUlu?=
 =?utf-8?B?VVdaMUpESWM2aG9wVER1Wk5qOUZHWm9zMW5aNy9Nd2RMQjJOYlFXK2ViVDl2?=
 =?utf-8?B?ZnN2ZXRhd3FhWlNuZDZqbVM3eTNvSlFOR1FhMlFldEFvNndlaHlnVHFVNDBT?=
 =?utf-8?B?WU53WFY2NXB4N1ZuQVN2UEh0U1V6Y0RLL1ZSL202cnprbE83MWlqSW03MlVs?=
 =?utf-8?B?WHBpNWxuS2sxWVl2OUtRUWR3MnZmMi9lZEp5eDFlS1pRY3lWeENTRUpZYlQ4?=
 =?utf-8?B?VU9WdVpVYW9yVUpUa2NCUXpYTWZlVTFNTlpMdm1tN2JzZzFoK1BFSHlOMWEx?=
 =?utf-8?B?YmpwTmNlQUwrZjUxeHFIcU5yWHhYdmlKOHpBVDJtTGpyS0gzYkh1dlRPWDRh?=
 =?utf-8?B?dUdjejMzMTkrWEdGd1RQS2lrUDV2akZqU2NlUWVJYWt0M1M5cUFENUhNdGRj?=
 =?utf-8?B?YzFNTFl3QmRwQVYvSmxvM1llUnFRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(376014)(35042699022)(36860700013)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	hYon/S07nrRwPlugGfwFb6b60OHyEcAmlUbvsRlcm9jMqLDy7ITBquSQwxMMJPG+59JhTQzm8tjjXNFVhorvq8S8JJNjQKqIdC2M3cG/xVse4mVF3aB9jhK2fB4QhADUjOEMJe8aZ1sxXolrAh72Pu8bkbyzIJco/6HiRmu3pu/HFZO1JwWdIwkztfnYIzF3y0YsVXSAOyGmwDFfaJZSgzgYbl5AnjMwk3Id1WzGv1JfuzvjjOqhehbUzgaR3J3gpwk1943ISBo/0hC3DJNpDw0NJVctts3YJz/bmeUl6RjPRxPzcVc45xwQy4E8jX9YhZuGKMVTcm9aG3VLW1+oKEzvkopZMLoCXQzdzxj2xX7RQ4qG/eHZ/ywznh/Z+WWAFGS2AkFzo/5s06gbStk3O2Ibswg4t4++6XCiGApS1ca8fHYVNHkPaooH8QZPRj3H
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 15:12:28.9817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8fda74-9a05-4c64-2dc4-08de73b7203c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9966
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 24 Feb 2026 15:12:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3274

T24gMjMgRmViIDIwMjYsIGF0IDE4OjQxLCBNYXJrbywgUGV0ZXIgPFBldGVyLk1hcmtvQHNpZW1l
bnMuY29tPiB3cm90ZToNCj4gVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgbWVyZ2luZy4NCj4gQ291
bGQgeW91IHBsZWFzZSBhbHNvIG1lcmdlIHRoZSBtZXRhLW9lIHBhdGNoZXM/DQo+DQo+IGh0dHBz
Oi8vcGF0Y2h3b3JrLnlvY3RvcHJvamVjdC5vcmcvcHJvamVjdC95b2N0by9wYXRjaC8yMDI2MDEy
NDE5NTYyNS4xODc0NzY1LTEtcGV0ZXIubWFya29Ac2llbWVucy5jb20vDQo+IGh0dHBzOi8vcGF0
Y2h3b3JrLnlvY3RvcHJvamVjdC5vcmcvcHJvamVjdC95b2N0by9wYXRjaC8yMDI2MDEyNDE5NTYy
NS4xODc0NzY1LTItcGV0ZXIubWFya29Ac2llbWVucy5jb20vDQoNCkRvbmUsIHRoYW5rcyBmb3Ig
dGhlIG51ZGdlLCBJIGZvcmdvdCB0aG9zZSB3ZXJlIHVubWVyZ2VkIHRvby4NCg0KQ2xlYXJseSB3
ZSBuZWVkIHRvIG1vdmUgdGhlIGh0bWwvbG9naWMgZnJvbSB0aGUgbWV0cmljcyByZXBvc2l0b3Jp
ZXMgYnV0IHRoYXTigJlzIHNvbWV0aGluZyBmb3IgYW5vdGhlciBkYXnigKYNCg0KUm9zcw0KSU1Q
T1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2ht
ZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3Ug
YXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIg
aW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVy
IHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5m
b3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K

