Return-Path: <liuyd.fnst@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C23C83013
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 09:18:33 +0000 (UTC)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
 by mx.groups.io with SMTP id smtpd.web10.19260.1751447905286657606
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 02 Jul 2025 02:18:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj1 header.b=PAMzWq7/;
 spf=neutral (domain: fujitsu.com, ip: 68.232.159.83, mailfrom: liuyd.fnst@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1751447906; x=1782983906;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vlz4QKOKPitvw0ZLxqvK2vHSyyaeKlVTAxxNnAeE/tQ=;
  b=PAMzWq7/rx8J6ceEsmqQ3MQAOyNVQPsb1W1TXfykky41ecKvjWIx1w0Q
   5KKghosklV6L4fs7z79/AXtQQFvQsg6XnuHyH7eGe1AAL+c3okBYjZQTE
   OYp/jQqp8kzp/7ltS1ffTbjrqn5ea+C5JqD6CfVZyRZB1w+rjhaTUMsaP
   w1EBnAjKBMi/eVnwd2PqK4UfEoUj9rddktMkVbaeuImfQpbkNQMR8I+dA
   9abeMfFvrz9f8J0arT04T/owW5ejkUOZJP9R/G4mrunNR4tBWeo6LfBAC
   v7/v/GnXcEzudZbDvPMfqZTYRaWgwzDzlh4BiYMc5qDiwzr7AHNEquBs/
   g==;
X-CSE-ConnectionGUID: jI62FgZvSEO57m5ZkAYQig==
X-CSE-MsgGUID: rzlA4nOvTOq94P364WW+Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="160332413"
X-IronPort-AV: E=Sophos;i="6.16,281,1744038000"; 
   d="scan'208";a="160332413"
Received: from mail-japaneastazon11010039.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.39])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 18:18:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPBHbB8BAH9Xp+CBU5lgBwMNbFNdfXtC8Bo+jt7FHN95xl6FjmTIGoKq+crQ4RrwwNittxwElZvmmeOxjAmYVIY8SMk+OMjStftzptbr9smvRnosua2jpCMldDoVnBS6yX02NgPIjP2R1k+0g5r4D21MHwsMf56oH60TftwMDf51YlUQ0FUK6C2kCQnEvGyQEDJoKzJueiKS1rUBtzT25NqvvgE/zZX8dnjyFcieRbcgXlRti/C1w0Zk58JdxvbBChdj+rglWhxoA0utX40IFKupF/SsFYudb+3PWzG79IxbbvXwrwBkb10zKMq879yWyV76fRmOED5+ep6YgWsDxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vlz4QKOKPitvw0ZLxqvK2vHSyyaeKlVTAxxNnAeE/tQ=;
 b=WDr9lRTNMhC/LGaXFNeSkS6U/GeXGo19FMg47ouu9JFBAiq1/FTEmv4/GpUWQ/LaAbZ/tGHlPMj0d267g6PDrtTleu12mDdAaPvc/uIIIJWklbPdvbzaGwBbs7k2OFKVHkN6DS4OQgVPSNUdlW20RQMJeH7V+AY2PhndeZT6v2s5j5ZvlU6Ye97lr59Ps1CK7h/+1IjWLsNvJmGhs41jqEROaimIrvD9VubShgmiV5bPvvIj4tcYAXguzhPigNQy4l8olSbvlhpOPABVqG3Rezq/JlsjJv2uuiHS1tbTHGyyCwAA6zDmzntB5lDUme1atR8GglVgCV3R9hIU76/j9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSRPR01MB11597.jpnprd01.prod.outlook.com
 (2603:1096:604:22f::12) by TYWPR01MB12127.jpnprd01.prod.outlook.com
 (2603:1096:400:43f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Wed, 2 Jul
 2025 09:18:19 +0000
Received: from OSRPR01MB11597.jpnprd01.prod.outlook.com
 ([fe80::cb27:d71e:9f8a:8014]) by OSRPR01MB11597.jpnprd01.prod.outlook.com
 ([fe80::cb27:d71e:9f8a:8014%4]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 09:18:19 +0000
From: "Yiding Liu (Fujitsu)" <liuyd.fnst@fujitsu.com>
To: Gyorgy Sarvari <skandigraun@gmail.com>,
	"yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
CC: "Xinjian Ma (Fujitsu)" <maxj.fnst@fujitsu.com>
Subject: 
 =?utf-8?B?5Zue5aSNOiBbeW9jdG8tcGF0Y2hlc10gW21ldGEtc2VjdXJpdHldW1BBVENI?=
 =?utf-8?Q?_1/2]_layer:_drop_styhead,_add_whinlatter?=
Thread-Topic: [yocto-patches] [meta-security][PATCH 1/2] layer: drop styhead,
 add whinlatter
Thread-Index: AQHb6m70tsZ1PvbN50Gp2IypncZ7yrQegHWAgAAMfaA=
Date: Wed, 2 Jul 2025 09:18:19 +0000
Message-ID: 
 <OSRPR01MB11597653BE0E2BCC218C1FEEB9B40A@OSRPR01MB11597.jpnprd01.prod.outlook.com>
References: <20250701100013.826-1-liuyd.fnst@fujitsu.com>
 <12b9c28d-4432-46bb-ac7f-5edda2b481c4@gmail.com>
In-Reply-To: <12b9c28d-4432-46bb-ac7f-5edda2b481c4@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9MDI1ZDI3M2ItMjM3Mi00NjJiLWEzODktYTU0YTRkM2Ix?=
 =?utf-8?B?YWQwO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI1LTA3LTAyVDA5OjA4OjQ5WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?B?ODFlMS00ODU4LWE5ZDgtNzM2ZTI2N2ZkNGM3O01TSVBfTGFiZWxfMWU5MmVm?=
 =?utf-8?B?NzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX1RhZz0xMCwgMCwgMSwg?=
 =?utf-8?Q?1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSRPR01MB11597:EE_|TYWPR01MB12127:EE_
x-ms-office365-filtering-correlation-id: d844aac9-da5a-49fd-a931-08ddb949626a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|1580799027;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TXYvOVdxcVEySHdiSmhpUFBWUE12ZTVwaHpiOFZTVGljZHJYVFdJbklkTkJp?=
 =?utf-8?B?OG9WR1B0b3A3WEpydUs1SWFvT3UzMEZkSC9UcmdhMHc5Zk5YNWdwem96WDZ6?=
 =?utf-8?B?ciszdytUS3p3RDRVNTR4UUphVk00eG00NXFzYmZ3RjcxVit4OUlvWXFsTU5q?=
 =?utf-8?B?TmFjQjc2dDFrR096N1BvVVFJUDRIZjhqYXFqZWlzSU9kZ2VXZVQ1U2w5NlEw?=
 =?utf-8?B?K04wckN0TitZbWNtTkU0NG1yRS9OcGM3amdXRFR5empQcDlOTThHeHBGTk1R?=
 =?utf-8?B?Q2tlczhDNm5WMll5THJ2V1RCcE01Q0R4Nnlwcm1sbDkwdUpWQ2Z6RUdlNHJv?=
 =?utf-8?B?eEQ0Y3pneERGbjFZRjRYQTdNMGdqSmVkb0hBYTllaGd0aGxwQm5hajVGcGg3?=
 =?utf-8?B?NkUvaGNaMEFLQStkNmN4NjBhei9oR1JRRjFOWWNtR1BsRUF0ajhtWGROY2VU?=
 =?utf-8?B?bHdXenpzcVhZS1oxb2dKaStkVTZucWRJdXFZU2psK25yQ1ZYaW1ueHlOdE1I?=
 =?utf-8?B?T0djNXQyL0R3MzMwUFplTjhMd2txTnlFUTFtRHRib0kwNW5UYVEzTjUwT1Bh?=
 =?utf-8?B?Y2NkN2JWRnpaeUIrckFFWnk1Q0lvSHFpQXI3Y3ZWbllhcmt0UVR5MEFGRUhR?=
 =?utf-8?B?bWl2ZTNKRmx1SUhuYlJPNEV1aXN3OGRqeVVIdkdvbTZVSU5pd3NJdlA0WXRS?=
 =?utf-8?B?UExEbVJuOWZyWW9ZUmZ4aE9uRmhxQm1EMmUzcjBuaDJJTlVPVXdkQm9Iamtk?=
 =?utf-8?B?a1BLOUYzbWtPQTUwZm80clVjVDI5eC81OEpZTzFQdTlWK28vL3VSd3ZXWVlP?=
 =?utf-8?B?RDF6SzgxRnZYUVdTMDlyY3hHd0YxN2RrcjEvU29TRHVFamhkRUFrRWk1c0J4?=
 =?utf-8?B?bkhVZ3JENm9NQnk4VE5ieDkzbmpYWEFIQzVvWVQ2UFpSeDNrT1pyb2ZCOFpq?=
 =?utf-8?B?RjN0NkhaeE9mSGFPbTBOMHNkdGE1M0h0OVJGVW1pbjY5czNPbE5QcVhCMTFt?=
 =?utf-8?B?UVQxNUZFb2daVjNqdGF6bUhOMVAzUzVYZ2tGdGN0WFMrOG81LzJvWlc5K3NK?=
 =?utf-8?B?WFloL0NMYlB6cks4VmNuSnZqYktGS0dVZjZ6dTgwQTBGMmM0aWlIN2UrTXBQ?=
 =?utf-8?B?ekNwRzRvblEvT1I1ZExZR3MvUlpHQTBoMU0vd1lmeVdpNjBxSS92RFFBTUEx?=
 =?utf-8?B?cWdiMXBXVzlkaCsvOElhQTkyOUI5SEdpVUJ3VGhTbFFrakFGbkswblNDWElw?=
 =?utf-8?B?bXVpcnJYN3FvbGVxZDd1L3VLY2JiWW9ML2ZORXl6YU9QUGpoc0JqbHBlRUtQ?=
 =?utf-8?B?blN3U05tckE0ZGxQOGdPekNVR3k3czkzYjBIeEVLbWF5UWRWZGRPU1V5cDJO?=
 =?utf-8?B?eUNSR3d6RWFvOFlXZWxvTmh0cktDQ0h4RXZaUVlZN0lKaGxUUFMyNWVkeUdz?=
 =?utf-8?B?NUw2Y0g4dEtJOHo1eEF2d0FOa25hQjMxRUh0TUMySm5kZEN3VHVrc2VNUjc1?=
 =?utf-8?B?by9QdHFOOEsySy9kemIreXdvS1lFVCtqN3VUMDllakk2Z2ZwNzVzOEZiN1VN?=
 =?utf-8?B?RlV5L1ZDdmYrSTJ0a0Nka1hiY3Z2ejhINkRnRHloU1NsZGRIM2RnZWNLTUdY?=
 =?utf-8?B?NWpUYm9TaDJjTW53TkwvMHA2YlloNE1KVFNvRVVKYnFUUm9BYXdrZTMyTVhS?=
 =?utf-8?B?TE1QQTRtTGdtUHkzeWlwUGF4OEdwckJGUmpQOGpvNUptVHB6WGw5cmhhRFdF?=
 =?utf-8?B?S3c5QThQdHhVTU1ja01wUUZSelFVM2hvc1I5RzVKdURaVWwrYkZyVlE2NnhI?=
 =?utf-8?B?bndlT3prbXhkOVhGcGxiS3Q0QWw0cWFTNWpQTWpGRlljb3NvL1d2VThuMjlU?=
 =?utf-8?B?aEE5Nm44cXpyRmV0YWVKb1E3MzAzTGx6c2grcm9MSWNoYlNNZXJhQWt1RXV6?=
 =?utf-8?B?ZU1HdGp3b3FLdHdHcGJleFhzWVJMTUdSbjJYUUV4bXJIM3JsUVp3cFdjNkpF?=
 =?utf-8?B?WDJNajdWR3JnOFNaRjhXbDdQdjRHNWRYTGtzWG8vUUVPcXlWalhma0trM05a?=
 =?utf-8?Q?OmBsxH?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSRPR01MB11597.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ODZ5VENQRjdmcFo0QjdhSmJNTlFJMEZWWTVhTERwVlpjUm1PVXI3alV1aksw?=
 =?utf-8?B?K3lzQjVMMmwvYjNWU1A5Y2hickpRVHdieFZKZlduZlp6TSsrNDVBWStOa2xR?=
 =?utf-8?B?MnBkMG00MGMwWmRSZFZvamhmbStBaFErYmUzWFF1OVhNbGw3WkhabExOdktu?=
 =?utf-8?B?T2RzWkpBMHo1eWpSSllOYnJSWnR5NW5lMVUzTndmQ1NVbTlveFNFSkY2czBN?=
 =?utf-8?B?MGUvR0Z2OUxCRnVEb0RuR0xTcW9FQit2ZjAybmNNSUs5OERpUm8zekIzTXlz?=
 =?utf-8?B?dnhOTG9IeXYrZm9RVHFtc09KeDU5NTcwdUU2N0xaVTVXS1QvK3YvTzhxOGxu?=
 =?utf-8?B?S3JsRzhTUlE4VWdEdGJ3VmNUKzRNMlMzNStzcFdVaGR6dEFZbHIyTUQ5YWd3?=
 =?utf-8?B?OUNYeWpuLzBiaWNIejBNd0EvTDRGUVJRQ0lqTU5FQ080dzNzMzZiVHJyWmVK?=
 =?utf-8?B?dUZRYlVSNG50ekVhL0NkNjVQaTdhb3VJNTFtVHVVdk5DUnZLLy8zMUg1aUUz?=
 =?utf-8?B?eHBNbVRha0xSUE41K3hqREtuSGUzQy8rY2owUmN5TmdzaG1zNjdQR3QxZEFV?=
 =?utf-8?B?azRKZ3l1WHRrMkRoMnJuZVQ1S1JvS05VUFo4aDdhUG9STHpkOC9ZVmJhdEQw?=
 =?utf-8?B?akRiaTdQekxnWGUva1N2QjMzV1p4Q3ZwUEhwZU1rN1NvWmliNHFRemdTcXJN?=
 =?utf-8?B?dVA1UDdKdmEwRzZJcWh2L0k5SGZIVmFnc2RNZlNVcy9PSFdtcDk5VUhqVU9y?=
 =?utf-8?B?M1hBcU5pZUhTZ1RjcHVBOTNJVTNtSUVIbzVsTCtRY3gwUC8vYXgxY2ttaEkz?=
 =?utf-8?B?OWxKVitLQ0xmc1h3TU1lYTlXRnFCeUE5YUE5RXo0YnBGTHZDS3pvT3JvaU5C?=
 =?utf-8?B?ViszMlphK2h1cnRIeEI2MTBzWGhKWlhKYWlhem5zVXZkZmtiNnlDbGJWaGNY?=
 =?utf-8?B?Y1Vab1VBNFo4RDF3V3cvTld5eklERGN5NXJGWCtnWjJJbDVjNnI1dTZlMDFi?=
 =?utf-8?B?VVlySDdIa0R3OEd2QWxzMEJYWTNaSUp1N25ac09kamtneWw4bHJJTVZxTzlp?=
 =?utf-8?B?bk8xczI0SW5zbXdpYldHT2NCVFhIZlFEVDhWUWhtbFozU0lSZFVsazNMcjZQ?=
 =?utf-8?B?dTNvMkRETFAvMXFDZGNOTEcyNnBqd3JwQ2ZjYVREVDd4MWVremlmWVRSYWFF?=
 =?utf-8?B?aFd2YjE5UDVyTVVEdzhsZ21ncXdrcWRmdHVXbHVOZk1rVDJGUnpkblFVdzFP?=
 =?utf-8?B?ei9WSjVDbXhMb3BNTkRFemM4cUVuYlBWeTN0ME1vZ0syNmZZV1gwUklqVVRt?=
 =?utf-8?B?WTNSeU1rWEgvdEoyOEpVWEFXQXVZK1JFU2VJTHdvSklpaUhHSnhqQzd4L1dP?=
 =?utf-8?B?NFlUcFRza3J1VVVYRjRXT0tQbEFuclRHRmJWT08xay9SMXRGVTFHdnZwMWZ2?=
 =?utf-8?B?WmV0WnlNazRoUkJPL3V4NklDWXcyaU9XVEJuN2dUSUFBdVpqZWlTR1REQkJW?=
 =?utf-8?B?cVN1WENTclFSUVQ2VlU3OUlKQ0V3cVRqS0ZNZUd4VjJqakV2TUhJbEQ5TjV6?=
 =?utf-8?B?b29Cd2xDbkFiMTBXcDFlN2M2VEFBcGY5ajBaWjJKVEpydUJoMWxlQUo3eFI4?=
 =?utf-8?B?NmxYTUZhcisrSEhIQmdheWdqMXRMbkdYZFEzc0h5YjhmVlgwRDhyVjZCYU83?=
 =?utf-8?B?aXhNZkxxZk1SaER6dXFnbEZ6cmFtVEZVc3dLUVJZZyt5dEk1YkFMdUpiVmNp?=
 =?utf-8?B?U0xGTUIwNEdxbHRMU3RaWE1PSlE3aFU1ejROenduNVFBUkowOHF6RndPQWRu?=
 =?utf-8?B?azMvbHhhYmtmVXBXcFhSWnV2Uy9RVkVRVklsa2xqMjlVbTh3ZE9ZcUk3cWlq?=
 =?utf-8?B?VG54d040WXZBdHN6ZCtjU0p1OUlUdC9WWmtLaHVNUUdEOTIyN3ZBMTJsaXV4?=
 =?utf-8?B?VVRvbm5ocWZVNU5QbFpMK0lEbHZuM1ZTU0dLdk9DT3lkcGZGdmx2cGFna0Vo?=
 =?utf-8?B?R2tLQXJkeDdlYzV0MVVvOGFPd2N2bUlSUVY1akcvdGFxY3plVXc5blVHOW44?=
 =?utf-8?B?SVNWVkd1THN2b1ZFaFFSaFBJRnRmbEYrVExobDFKOVFldTdCMGhzU25GbXNa?=
 =?utf-8?Q?3pCYNabWUehHxbzvkV4Ylhu1V?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wxWSbnXDVui3b9GpIss6aO48MNsYVwQb/8CTgBeaCrMXUUgXSn3mrH0Gfgw936cg7ns2s5AfZ889jXBmIE0ChOAwoCp37GUSU5rQDgICbzDhztS6SXHYIdn8ShtnpO1x99NZjKs+Bpgv5KxrWrsvgBE3PpyQcB1wS/t1rvO63U1/+40raTZMp3xVBwHSKuqYEbuWJguHmsAcvoRFyAb7O9bGU21IB8vT0Izh+3tFvvYaHYSfg0Yb8iTXHQMlTVDSlEE4dVV38z+ZmP5rCXlbmjl4Oe1i/nq+ypSCw+2XfbpO4rXPUkGvAUnIviSB2TMXcZm/hwkp23ZGuYYsIN7m7qZQza93IHIA7KWV9kwHeoXefYsyEte2rZ9PGXMvToLEDlhHUY3e+U75GI+ZFkBa+8Gkg9fLccI3YuD3UH96flaUQn/dBt6WcXOWZB8iXiPcNA4ckaCgSawZadgpnhc0ujDfgkLY6+sJC68vvvKxmgAfl1PhOALKW9wx4rP/pBgv+jEXhSjmqa8XPFM4z+Q6la8YFVAUB49BjOHERNBnsqTsY8aB2rij8fnw7kNGopF/0BsIpVGPkfvXKggwvdKz5lhAjvkM8vmlCO64VW/GLosqhDC4BGTHXeIAYovb6THD
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSRPR01MB11597.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d844aac9-da5a-49fd-a931-08ddb949626a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 09:18:19.1035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nW5zD1dO0qjU7kVw3UnjhBsyb9ct0zKTJkqtdXTeO6r2/3JsroMswixFg9A30pDkY+a/GlEvlpOdc1/Zl8y7iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB12127
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 02 Jul 2025 09:18:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1734

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEd5b3JneSBTYXJ2YXJp
IDxza2FuZGlncmF1bkBnbWFpbC5jb20+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDfmnIgy5pel
IDE2OjI0DQo+IOaUtuS7tuS6ujogeW9jdG8tcGF0Y2hlc0BsaXN0cy55b2N0b3Byb2plY3Qub3Jn
DQo+IOaKhOmAgTogTWEsIFhpbmppYW4v6amsIOaWsOW7uiA8bWF4ai5mbnN0QGZ1aml0c3UuY29t
PjsgTGl1LCBZaWRpbmcv5YiYIOS5meS4gQ0KPiA8bGl1eWQuZm5zdEBmdWppdHN1LmNvbT4NCj4g
5Li76aKYOiBSZTogW3lvY3RvLXBhdGNoZXNdIFttZXRhLXNlY3VyaXR5XVtQQVRDSCAxLzJdIGxh
eWVyOiBkcm9wIHN0eWhlYWQsIGFkZA0KPiB3aGlubGF0dGVyDQo+IA0KPiBPbiA3LzEvMjUgMTI6
MDAsIFlpZGluZyBMaXUgKEZ1aml0c3UpIHZpYSBsaXN0cy55b2N0b3Byb2plY3Qub3JnIHdyb3Rl
Og0KPiA+IGZpeCB0aGUgaXNzdWU6DQo+ID4gRVJST1I6IExheWVyIHNlY3VyaXR5IGlzIG5vdCBj
b21wYXRpYmxlIHdpdGggdGhlIGNvcmUgbGF5ZXIgd2hpY2ggb25seQ0KPiA+IHN1cHBvcnRzIHRo
ZXNlIHNlcmllczogd2hpbmxhdHRlciAobGF5ZXIgaXMgY29tcGF0aWJsZSB3aXRoIHN0eWhlYWQN
Cj4gPiB3YWxuYXNjYXIpDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMaXUgWWlkaW5nIDxsaXV5
ZC5mbnN0QGZ1aml0c3UuY29tPg0KPiA+IC0tLQ0KPiA+ICBjb25mL2xheWVyLmNvbmYgICAgICAg
ICAgICAgICAgfCAyICstDQo+ID4gIG1ldGEtaGFyZGVuaW5nL2NvbmYvbGF5ZXIuY29uZiB8IDIg
Ky0gIG1ldGEtaW50ZWdyaXR5L2NvbmYvbGF5ZXIuY29uZg0KPiA+IHwgMiArLQ0KPiA+ICBtZXRh
LXBhcnNlYy9jb25mL2xheWVyLmNvbmYgICAgfCAyICstDQo+ID4gIG1ldGEtdHBtL2NvbmYvbGF5
ZXIuY29uZiAgICAgICB8IDIgKy0NCj4gPiAgNSBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvY29uZi9sYXllci5jb25m
IGIvY29uZi9sYXllci5jb25mIGluZGV4IDg0ZDQwYTEuLjdjOGU0MDMNCj4gPiAxMDA2NDQNCj4g
PiAtLS0gYS9jb25mL2xheWVyLmNvbmYNCj4gPiArKysgYi9jb25mL2xheWVyLmNvbmYNCj4gPiBA
QCAtOSw3ICs5LDcgQEAgQkJGSUxFX0NPTExFQ1RJT05TICs9ICJzZWN1cml0eSINCj4gPiAgQkJG
SUxFX1BBVFRFUk5fc2VjdXJpdHkgPSAiXiR7TEFZRVJESVJ9LyINCj4gPiAgQkJGSUxFX1BSSU9S
SVRZX3NlY3VyaXR5ID0gIjgiDQo+ID4NCj4gPiAtTEFZRVJTRVJJRVNfQ09NUEFUX3NlY3VyaXR5
ID0gInN0eWhlYWQgd2FsbmFzY2FyIg0KPiA+ICtMQVlFUlNFUklFU19DT01QQVRfc2VjdXJpdHkg
PSAid2hpbmxhdHRlciB3YWxuYXNjYXIiDQo+IA0KPiBJJ20gbm90IHN1cmUgaWYgdGhpcyBjb21i
aW5hdGlvbiBpcyB2YWxpZCwgaW4gY2FzZSB0aGUgbGF5ZXIgZmV0Y2hlcyBhbnkgc291cmNlIGZy
b20NCj4gZ2l0IC0gSSBiZWxpZXZlIGl0IGNhbiBiZSBjb21wYXRpYmxlIHdpdGggd2hpbmxhdHRl
ciwgb3Igd2l0aCBvdGhlcnMuDQoNCg0KVGhhbmsgeW91Lg0KQnV0IEkgZG9uJ3Qga25vdyBob3cg
dG8gdGVzdCBpdC4NCkFkZCBuZXcgdmVyc2lvbiBhbmQgcmVtb3ZlIG9sZCB2ZXJzaW9uIGxpa2Ug
b3RoZXJzIGRvLg0KDQpUaGVuIEkgd2lsbCBsZWF2ZSB0aGlzIHBhdGNoIGFzIGl0IGlzIGZvciBu
b3csIGFuZCBzZW5kIGEgcGF0Y2ggVjIgZm9yIGFub3RoZXIgMi8yIHBhdGNoLiBTaW5jZSBXZSBu
ZWVkIGl0IHVyZ2VudGx5DQoNCg0KWWlkaW5nDQo=

