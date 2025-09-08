Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B6FCAC581
	for <webhook@archiver.kernel.org>; Mon,  8 Sep 2025 10:46:33 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.22])
 by mx.groups.io with SMTP id smtpd.web10.10212.1757328386857349753
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 08 Sep 2025 03:46:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=ew1y8LpO;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=ew1y8LpO;
 spf=pass (domain: arm.com, ip: 52.101.69.22, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=kECyrlIQvoOQLa9+pv5jc0PmW+nLPlrg7aQMJDC3CngHQRAWsfCbJldzjEekQDIfXd1Y52rEuPNSsyExdJ95T0RoXjXnTxZz7iex254FjktWnWmmIiAwUNq+Z/vU2d/UngDskf/8LeKOVsJDkf0lPMLoGBbDZeqlQPxyH8ym80CQQttu+S5MWRxDTXDKrWRok22WxF4oJC0QK5t9+OYcrKvXPChVqesvLJ/S9uOPLra1aCSj3oVC6XS3HLuJ2ketTZTGR9g6d3HmOrJyWzpPkKE1LT/UBo6ed5G5+UPBWr/QXJkahKBeDNHZEOCvCmG3rOw6ms4uvrHCcxQVmNQQNA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGsPRxdIBHWax7Xn7zU4+YH4O99CsbkCv5NVLfOENXs=;
 b=r3+BboB5delXxEp3T7NgqvNqcc7i42MxhyqdGlPX23kUUpYedOFPogU0USkB+f8XciYUukF61S2js4nReH8o8cGPYcrCs7+8LASYa0EduKfVd7S65wOS1wF9vD/oDEoA5bfdFzZxnc+uRKjmhLux4AwrMwJbyo5l/6l2tTbK7x4hTmwG1Yn+FqqqqFfFpe6GInbJWyPKARQFuA0sNAyOmV2uvPJNlerXHl6TesvhSCBmUTUkxRH5tjiXl7w4ggBdcTUvhXcQVyNKNuV2hYKHCgp22lL5pAF71mA031GTxcGk/NQYfV9WVLInG5ScaWprCQF/uuzREOZ0qLAHLnTyCw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGsPRxdIBHWax7Xn7zU4+YH4O99CsbkCv5NVLfOENXs=;
 b=ew1y8LpOvxcOsxqHmIeTQ/nsKM14qnNM0jiiDjTizab1gm1ZJb01Ko5UvupofZ0GhRnhFeveIKZWa83B1Wqd1OBSHXP/OQ6OhKIuLvjGTD6Ei3HR7q90W/PLt49Htol6dgixpdTsOR/D7mV1g4WvX+YSeEtyK9djaV+jHgS5gGY=
Received: from AS4PR09CA0001.eurprd09.prod.outlook.com (2603:10a6:20b:5e0::7)
 by DB9PR08MB9705.eurprd08.prod.outlook.com (2603:10a6:10:45c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 10:46:21 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e0:cafe::d7) by AS4PR09CA0001.outlook.office365.com
 (2603:10a6:20b:5e0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 10:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Mon, 8 Sep 2025 10:46:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJ9qOQ0top1seN+Uu6uKbgtX7MbF+z3JapnmBxu0WNGD07TthZTAzL3u9wus4ndlNU2+wcOYAzEf20n6zexM+cXAQze4IpomYOTpcNG5OJSgukvpbpuPeXRH7Ni98zLAqPUEYzS4Iei0AphsbMqd7iNT9Os8f4XZKhARaCdXSf+CZaNPjo85kI6Z/bLKTmips42EnMAcEpkueVmRiFsYmuspyjVkz2rDLlZAs8mp5vnT+gWX5Ll4VqbCbYTaqhYE0d2ebvpJWhEl4ZfHe95s2lO5DoMOads0bDIkSR1c9O5graJqXGRKX3BXN5Br5Evvf2B/0S1s+zbiskzzpmIJ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGsPRxdIBHWax7Xn7zU4+YH4O99CsbkCv5NVLfOENXs=;
 b=ozOOHayESZhdmUYZqCBmreVrknzjWXJgWz7XlGD9H58CrgpHhKics4SSimVX49aYFpbLm4bWew4Ww0Etw0Ui32etNjOpKPYGUeVCskEza3qxt6S3CgBu53WQ+R/gP33t+JtbLA+xxQ9w3QyyAHJg2uwPX8q7twNTpT5k8dV2JtcviQnHv7A/kKtv8DZpYsb9nsckq1NimeaBVnFcn6Sw1M6ZNpob+TML6XoHgTj2wCrJiuX9NG1+ndrenky3+KKYXr/miraWIQTGdzxAnyCMwUkLuYXwKuhAW8bQ82uxWwxWRZ72Q7eZoozR6hlHxi1Bump+wJ9ht65UPnlfVTsbTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGsPRxdIBHWax7Xn7zU4+YH4O99CsbkCv5NVLfOENXs=;
 b=ew1y8LpOvxcOsxqHmIeTQ/nsKM14qnNM0jiiDjTizab1gm1ZJb01Ko5UvupofZ0GhRnhFeveIKZWa83B1Wqd1OBSHXP/OQ6OhKIuLvjGTD6Ei3HR7q90W/PLt49Htol6dgixpdTsOR/D7mV1g4WvX+YSeEtyK9djaV+jHgS5gGY=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by AS2PR08MB9319.eurprd08.prod.outlook.com (2603:10a6:20b:599::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 10:45:47 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7f73:806a:3493:7d50]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7f73:806a:3493:7d50%4]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 10:45:47 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: Dixit Parmar <dixitparmar19@gmail.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [PATCH v6] [matchbox-panel-2] panel: added sysfs
 support
Thread-Topic: [yocto-patches] [PATCH v6] [matchbox-panel-2] panel: added sysfs
 support
Thread-Index: AQHcDfD7g2LCA4CFRU6pCaF7oGo++bSARPsAgAW4MQCAA0JcAA==
Date: Mon, 8 Sep 2025 10:45:46 +0000
Message-ID: <3DBD0F96-5DC2-4510-82D9-3C62A8AADC6F@arm.com>
References: <20250815142901.1742993-1-dixitparmar19@gmail.com>
 <89C14622-E2D8-4A08-8D22-5C612FEE6283@arm.com>
 <CAFmh=S2qWeBJ2w_FG4UZWaaAq4iNVxLbuO=qF-zHv_J8yXYt+Q@mail.gmail.com>
In-Reply-To: 
 <CAFmh=S2qWeBJ2w_FG4UZWaaAq4iNVxLbuO=qF-zHv_J8yXYt+Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|AS2PR08MB9319:EE_|AMS0EPF0000019B:EE_|DB9PR08MB9705:EE_
X-MS-Office365-Filtering-Correlation-Id: bcce1577-f4d4-48e5-fed5-08ddeec4f2b9
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?Y0ljUmtYUVFHaGhvaVpHM0lSTFpwSkkweGJrNGV2dHVZMmtKVUJhTzlnQmEw?=
 =?utf-8?B?ZmNsQXBYeG1VOUdkemtxU2hiWUtxMkhrSnA3L05lMFFtQ1FwanVub2VUem9s?=
 =?utf-8?B?Qk1SSkhPdDJvV21ySlZiV01YNlpRNDdXTSt5T29pU05FRkNYM2RVTmlUQ0FM?=
 =?utf-8?B?Y3RhVUJucHNrVEZ0NkZwak5ueThOdG5FZGxvNG9ralhYOWhFVWN0TjUycXB2?=
 =?utf-8?B?V052c0syb2xKd1ZvYmNoWGxDVTA0a3lnd0pVSk1jak9pNEVDTHRWSTlDT3do?=
 =?utf-8?B?SWQ2aW93NTdxdi82cVdBQ2VOUkRoditTckYxS0c0NThobmxqSVBpajFwNzFW?=
 =?utf-8?B?WThiWklYUG0xM0Y4YW8zM3NRVkhuU0pOS0JZVjY2YVpobDhlOEdIRXdtbVNR?=
 =?utf-8?B?Vmdxa2hRRkNCTVhJQTlwckhCU1dkWVFXZml4UGR6cERVdnhJU2NYUVJpcHB3?=
 =?utf-8?B?VDVTdXJBYWNKMWlpbEdGOGdrYXM4Y3NMZGRDeGhyNmpHM3k4dDAwdkRBQkdU?=
 =?utf-8?B?VEZuUjEybmtiSVJ4YUF1S1Y2NlNNa0QwQTVObWcyRU9mQnhDTWlNc1BLanE1?=
 =?utf-8?B?MGMxZ05GNTRxWXNyL2M3U000VkczcytxZmRVcWZCMkZMbjdJOFVwRmpHRlpG?=
 =?utf-8?B?YkpyMFFqK3ZYRU43RkV0bkFFZVVEN0Q4Y1hqSU05ZTUrU3JDa0ZDbDZ3ako5?=
 =?utf-8?B?SC9ZaHNtQ29wTlBoWUlNWmhOKzcwdmdhaFBVMS9xUVczYzREYlZFQXVPWnR6?=
 =?utf-8?B?Ukx6MGpPN0lmcTZYTlBGZlMyVEtyaFdsM0lnR0N3T1c1SGROSWU5N1czZXVE?=
 =?utf-8?B?c0ZCMmhVVkZKSmZBUmR5RHNacVlHNVhmVnJTbmVvTnlidWFlL3d3NXMvTzcz?=
 =?utf-8?B?ek1iaThSYjVSN3RrQVRvREhuNnU1MS83WDRhdXhVV1JPU29Zb3RZQVZNcU5m?=
 =?utf-8?B?Y3poVUtRQUZXTXhpNFEzN25tdTRoKzVkeG1JVTRBbHJLai91WFBYUVF4SXJT?=
 =?utf-8?B?OEJhQmdhSlVFcVJMaUY3UitsRXNOaWJqdHo1b2xXK2dkVWMyK1pIL0twK08y?=
 =?utf-8?B?VkwyRExMM0dSNVNQYk44bExvbzJTa0dWamFvcTVqelgzc2hnZ0ZKUjlmVEFF?=
 =?utf-8?B?b0dZZzFTNlk1QS9NL0VtQjdTSjNYY0N5Qnp6SzhGTktwRFJ0dzRrK0VSSmVY?=
 =?utf-8?B?eXJIaFZ1bFpGK3BNekwyMEd4ZzJZcmJrNTREMDBvVUgwa3JyU1pMajFjb3Nn?=
 =?utf-8?B?Rmh6QWZ3VCtWV0paU2syWkNRL2VzUjhEY1g5WWVrWnJBd3pIN0t6OWxnUWxo?=
 =?utf-8?B?VFRocGhpYkR6aG1rMzA4R3FnYkZDb0srSmVFbUFsQmlEeDhMTlNSWjAwbVNk?=
 =?utf-8?B?WDIvd0NDUnp0bTQvMWpBcVlOS0JHNU9TY3RIWkZxbDd0aVh5eVpQb2Nmcm9N?=
 =?utf-8?B?NFdRSG9uSXErZW5PdlZUdGtlMDloY2Q4Z3RnK0s2R3psSjkrRUNZTDVJYWJl?=
 =?utf-8?B?dkNDK2lENktKb05FZkh6RGQ1OUJybEk4M1c5TFNLKzF6b3licndWVUlsMkU4?=
 =?utf-8?B?RmNMQ090UVl3VDVRcmpmNEhmbUsvL21GRDd3OW15MFdCTnFjRWJYVDNjajVJ?=
 =?utf-8?B?ZVkwOUJEMWF2SFQrRFVCNkthT3RBa1ZGQlY1TnJ4QnJEY0ppcVYzaVNvdGhN?=
 =?utf-8?B?dzQzdkxsV21iMzZYeDFyVXFDdVhEYldOMk5BWFk3YzhCZWZNdTY3T3RDLzJz?=
 =?utf-8?B?OEdneHhseEpELzhLQVF3V3BjcVF2R1pJdGt1VmtNMG9rcjI2U2RzcGRNa3Q4?=
 =?utf-8?B?RnhDWERYRThUZlllSkdvemhWNkQwczV6M0RFVGtMemg5SWdneTFhQ3psSEpT?=
 =?utf-8?B?TC90N1RENjluRmwyV0E2SGVPaThhd01nNEFkd1l1eEo1bGJGQk5uVEFLL2Fv?=
 =?utf-8?B?NVhab3NqM0E1WXFSa0tXME9ZazdsS1ZmRlBHTkExZEVjaStrd1JaN1QxRmpH?=
 =?utf-8?B?dGQ3V2daTnJnPT0=?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <6422FAFD585A454BA87C25EBD95BB1D8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9319
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	05cd6b89-0edf-4a39-9876-08ddeec4de7c
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|35042699022|82310400026|1800799024|14060799003|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dXp2RWNuUDRLTjZRUjhFSGwxbkY5VjB2bXFPenB0TXJlVmNoSDdJbFQ5Vkdo?=
 =?utf-8?B?c05vanlCdHRPbFYwZENpUWdIdG5CRTFCbldVbkdLaWpvSVovWUc5aHowa1J5?=
 =?utf-8?B?RHNTcGRTNko0L2hTd2cxVCtMelYxaWVpN3puQVlUcGlsL2JlMlRZTWZPWkpo?=
 =?utf-8?B?NkJDWXphODZ1UWpPVW9HcE45dkEzekMwTWtHUEVBWi93VUo3c3U5bVlvMXFL?=
 =?utf-8?B?LzBGYkd0VUIrd1doMUxObkswTEdQTUhKSDJKZ1duTmFNcWxkVko3anBNaEZL?=
 =?utf-8?B?L3dOVUJSY1JhRjVGd0FZaFZWcjFBTVoyY3BraDVFQitTVzNXZ3BIQ3JNQlVK?=
 =?utf-8?B?OVB3V3MwSHJINUdyRHY5OUpyWFNZekRVMUUzM3JHQndicHZmc0Z2aDNpWUVU?=
 =?utf-8?B?Y1FJRWY3bTQrNEM0QXdaYWtReWR0UmZnVlJTak1JeWV5L3pKZ1RQVVVXYmRy?=
 =?utf-8?B?Z3EzYnlwOUhFbVo3bm5IYnZFNjZDbWo5TkJlRXdxMVZZZGhSeFo0ZnVwcmhN?=
 =?utf-8?B?MzI1OTJxR203azZtVU82UTd2STN1WGt0SGsxOUJOeVhKdDJGZFVId2hLa2E3?=
 =?utf-8?B?SkQxY2FIZk1hM0gzYmZhK0NNajV1ZjZtaENsbmRhc2MzRFRINFhhSUMxbklD?=
 =?utf-8?B?b1FRRWpsSkFSbnRlUktaTTBBTlBWQzF1SkdDeGdvd3VRSUFrQmtacUh5ZjBs?=
 =?utf-8?B?WWRoUTRpSjdMWG5RSytTOGljSTZHdHJ1ZmhyUnBWSlVrdlhYUWFkM1Q0YnYy?=
 =?utf-8?B?aTZiaGlYREdianQ1TzVnUEQ1a2NCRmdtakx0clg4SFRINUJ2VDNUeVRKU0py?=
 =?utf-8?B?VW13QkxxejNVR3NmZ05wd2ZUTXYzOHVyRUF2RXpKVlllS0hVT29UM0ozSDFS?=
 =?utf-8?B?OEt4VFJFNk5UV3BaaUlYdGV0QUt0VU56TGtXTGgrY3hlWHZFRDB2S2pLbmll?=
 =?utf-8?B?Znk4RnAydGFXYnJ4TlpvRE0yTjBVYnEzK1RoZkF4K2dNUnpBaVB2aHBYYXlq?=
 =?utf-8?B?bytmNjdkeWdtZGlBbUtONmtNTXEwVXhycDlqMHhkTkp6RlFOR250Q1JTU1A1?=
 =?utf-8?B?R3lDN2U5QUh2ZXh2VnZ4b2Y4UzJtR25LaWIyMHdhM1FFcXRNWlRyeHYzSDg1?=
 =?utf-8?B?eFM3NmltZHM0YldJNHBEanJOZ0UyTk1ZSS90R3oyNFQ1SjVlZWxzdTRwUWU2?=
 =?utf-8?B?bks5YzQ3UCtGb3FLYUFIaW5DNzV0SVBGa09BZ1R4UzBhUGhueUlzRXZBWWZm?=
 =?utf-8?B?Mkg1MExhRnhFSGJaMEdmcC9mYlBQOXF5ZTgreGV0MTQyWXlBeFRNWE4wZ1F4?=
 =?utf-8?B?ZUs5aXJuUlZTK0VYR0pxYTh3R1pUbDV3S25ackJqWldaY0IzNUYzc01KOUFK?=
 =?utf-8?B?bEtHbUlaRFdlSHF1TVZCUFFYaFhRdE9mc0h3U1dQQ3orc2ZGd2JSVURDS2tt?=
 =?utf-8?B?WndMTHVmcUlRTHZLTFl2a25POVg4ekVDSjNoSEN6YkZjRHJ0aFdmbzNCdWhX?=
 =?utf-8?B?MkI1b212OVZUY2tRVENCSjBZdE9oMkl4c2l6ZFRHVDg2cW16VDZsT3Z6cjYy?=
 =?utf-8?B?UFlHamtXaXdNNnRncFYrcnQ1VmdpRlF2SncxaWRidXVYaDhqZ0tDaVdDR1RG?=
 =?utf-8?B?ZXh2aUhnQ3Npd1BhWlpoQ2pGTHJObVYxZ3BIS2QvTURUbEEyQVVSWndMcXc0?=
 =?utf-8?B?bUk5WS8zU002aXd4QmVDRmZweTFLbGw0ZEdUcUI3QkwyUmVxUm94Z21uZkxv?=
 =?utf-8?B?Z0crbzBGRXpKWVk5TkM4MEo4VkUxQm9mYW5sbTdLcko1N2NNWUNPVzJWbGFV?=
 =?utf-8?B?eStSSy9WdDNzQjRxbDhXeWdQNE9rMnRtdUdsVHZMT3BTYkZRYjdsS0hOd0ZU?=
 =?utf-8?B?VVZVMlFGV0pabTQ0R0x0bWtuaS9VREFSTVdZcFgzMlNXd3NUNXo2N3RJQU0w?=
 =?utf-8?B?eXVqeGxvZzVKeHhlcUtJRzd6Q011UXo4SkYvVVV1L0dZOEtLbTVHZUh2VXBF?=
 =?utf-8?B?WVpCa2p3cFRnamhxOUxEb3pSbXZ3aHdYSVJ4TStQUTk5Y1MvaFh5VmZzVG83?=
 =?utf-8?Q?3iYCYl?=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(1800799024)(14060799003)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 10:46:20.9287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcce1577-f4d4-48e5-fed5-08ddeec4f2b9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9705
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 08 Sep 2025 10:46:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2145

SGkgRGl4aXQsDQoNCk9uIDYgU2VwIDIwMjUsIGF0IDA5OjU5LCBEaXhpdCBQYXJtYXIgPGRpeGl0
cGFybWFyMTlAZ21haWwuY29tPiB3cm90ZToNCj4NCj4+IFRoZXJl4oCZcyBhbHNvIGEgZmV3IHBs
YWNlcyB3aGVyZSB0YWJzIGFyZSB1c2VkIGZvciBpbmRlbnRhdGlvbiwgc28gcGxlYXNlIHJlZm9y
bWF0IGNvbnNpc3RlbnRseSBhcyBpdCBpcyBtZXNzaW5nIHVwIHRoZSBmb3JtYXR0aW5nLg0KPiBD
YW4geW91IHBsZWFzZSBoZWxwIG1lIHdoaWNoIHBsYWNlIGlzIG1lc3NlZCB1cCwgSSBjYW4gY2hl
Y2sgYW5kDQo+IGNvcnJlY3QgaXQuDQoNCnBtX2NsZWFudXAoKSBpcyBpbmRlbnRlZCB3aXRoIGVp
Z2h0IHNwYWNlcywgd2hlcmVhcyBwbV9zdXBwb3J0IHVzZXMgdGFicy4NCg0KT3IgZWcgdGhlc2Ug
bGluZXM6DQoNCisgc3RybmNweShiYXR0X2Rldiwgc3ViZGlyX25hbWUsIHN0cmxlbihzdWJkaXJf
bmFtZSkpOw0KKyBiYXR0X2V4aXN0ID0gVFJVRTsNCg0KVGhlIGZpcnN0IHVzZXMgc3BhY2VzLCB0
aGUgc2Vjb25kIHVzZXMgdGFicy4NCg0KQXMgdGFicyBhcmUgb2YgYW4gdW5kZWZpbmVkIHNpemUs
IGl0IGxvb2tzIHdyb25nIG9uIG15IGVkaXRvci4NCg0KPiBBbHNvLCB3aGF0IGlzIHRoZSBzdGFu
ZGFyZCB3YXkgdG8gY2hlY2sgaXQgc28gSSBjYW4gZm9sbG93DQo+IHRoYXQgZXZlcnl0aW1lPw0K
DQpPdGhlciBjb2RlIHVzZXMgdGFicyBmb3IgaW5kZW50YXRpb24sIHNvIHlvdSBjYW4gc2ltcGx5
IGNvbmZpZ3VyZSB5b3VyIGVkaXRvciB0byBkbyB0aGUgc2FtZSBhbmQgdGhlbiByZWZvcm1hdCB0
aGUgZW50aXJlIGJhdHRlcnktc3lzZnMuYy4NCg0KQ2hlZXJzLA0KUm9zcw0KSU1QT1JUQU5UIE5P
VElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUg
Y29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0
aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRl
bHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwg
dXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3JtYXRpb24g
aW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K

