Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002E6CAC5B5
	for <webhook@archiver.kernel.org>; Mon, 29 Sep 2025 11:54:54 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.49])
 by mx.groups.io with SMTP id smtpd.web10.51784.1759146887863432513
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Sep 2025 04:54:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=egS6dZsH;
 spf=pass (domain: axis.com, ip: 40.107.130.49, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubAkx8pbrzmWExsa/WfNMUFMB4jOownC2ISPxZ84T5WoHlwFRGynilAHqfLt/VDI94bzTbqT7DeuONJfrTbjsF4yOKPTEiXH/CasQ+vWgOAPeHpjUN3OLlHUus/pGOMtzjs1DhaCD5oBWwOI5yyy0pU4e7nKaDzukmgiyJFwmkzVKpTgZ5Oaf9RZBhANfHVffBuYuwieIpwv06syzjJ9s4iXoILoiEu2LOCfok5gXibzEd4L63s0YtxtXNRBOkPuGdnIbtZZTU9exHwiAPuJxE0Bn6nrwSHaYncqSyQOy9erAsojlkPBVBhACR10w1x4ye81kTs/cxBSnqexAJstMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwtqK4414G2CF6jdJ+g5cfYvb22GpV3/hw+l7Dmppao=;
 b=LqTB9LkCHEO8g/iKX/CmljGVYpz25ODv7zSIoX3bqmzdPQJ/TlEzNEc6ggRDGS7sgum9xUo224mOCOfx74VXuyOJ0opk/sxZnfcw6uduVlN3wGLv1Y1OUKrhdWOtr4BfJp5G1jGk1E+PWcjpzEyYjBLorDpmMBqt+gjVYH+/GrM43BtFd39PU6ImwVR79zA1qKTnQ8Dy4ed6/oQ3OyoSMNLcl8vHG8M9r4fSx9sK9ap+UfgbBUhwSp7VAjvyFhNcIFWzYELn+Ww/I8sC5oaJuapEm4wmXaqrqoQQVXYyRFHIdGsHVm6+fYrOLDIJjTqbUutAPKsR4lkZcVujp+/Bwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwtqK4414G2CF6jdJ+g5cfYvb22GpV3/hw+l7Dmppao=;
 b=egS6dZsHaBGFQZnNELQZH4ELtKsxgyG1G/7gZ8RAxeaNbaeCtBy7ujNMr2pKuSMxuMrLAIf9FvBKbq7JKHZsnE5Ugi1/ZfbD0Ir9D5dKEOrJbAzXwgNXy5TFTVaw2luU8MhwQYbWIAWtSLTccaeKnJbt7nVtK/papCPrsbIQQkU=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by AS4PR02MB7902.eurprd02.prod.outlook.com (2603:10a6:20b:4b2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 11:54:44 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%7]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 11:54:43 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
	=?utf-8?B?Sm/Do28gTWFyY29zIENvc3Rh?= <joaomarcos.costa@bootlin.com>
Subject: RE: [yocto-patches] [meta-selinux][PATCH] initscripts: fix
 incompatibility with read-only-rootfs
Thread-Topic: [yocto-patches] [meta-selinux][PATCH] initscripts: fix
 incompatibility with read-only-rootfs
Thread-Index: AQHcMR/yzhOCE7NtXESApttZesuAibSqC4Bw
Date: Mon, 29 Sep 2025 11:54:43 +0000
Message-ID: 
 <DB5PR02MB10213866E719707D003050219EF1BA@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20250929084201.15383-1-joaomarcos.costa@bootlin.com>
In-Reply-To: <20250929084201.15383-1-joaomarcos.costa@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|AS4PR02MB7902:EE_
x-ms-office365-filtering-correlation-id: 80aca645-8c76-4933-c930-08ddff4efaf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: 
 =?utf-8?B?R3NiT084MGpuWlByRmdLdG5pUk5NNGR5ODliN01DYTNKYjBmVnJ3enYwcVR4?=
 =?utf-8?B?YngvTDJWWjNla1BuUkhNOVh5RERmcWV6QzFkWGJoYTRIYWJnUFdWaDMzdjdY?=
 =?utf-8?B?NnM2S25hbFlCUDloa2FpTS84TGxvYXI5WEY1blhJUGtoRElhWHZVN0VqaCtN?=
 =?utf-8?B?UWtFMGtNTnNpRjlzK1hCOTVsU2c0OGp0QnNiK083ejBQY0NBbzUwRTdCSGF4?=
 =?utf-8?B?L1A2Ukc2Wkl3VlNpVUhORi95MWtuemZOT011VEFiNEpNZWlUNUI1dXR0aVE1?=
 =?utf-8?B?WXI4MTd5OVNoaS9oejA4N2Z6Qzk5NHVadWZUWnBuUzJ5WjVYelgyQWxWb1N2?=
 =?utf-8?B?Zkhtclc5ZUo4TGlEWWVSVVM5eDV5NGVYYTZkT0JXUExJNWVPZVpiNlRLQjRM?=
 =?utf-8?B?WDgvZnJ3VFZweHhKcGxTTWFmd1U5MjUxY1oyWDBmM1h2SzdOOXB5NEwwSmNr?=
 =?utf-8?B?VVdQTUIzYkl3WXF3U1pxa1NPTllkNkhqbUJweDNjdVJtbTVZTE5tYVEwbmtL?=
 =?utf-8?B?M205dGdaN2djZXNVQWZQTlJ2RkJDUlYwQUpkUU9MQ1RRSlI1aUJSem1IVkJs?=
 =?utf-8?B?NzZqbmdKdUhKY3VXQmlDY1hRKzdWSUltNm1FWFpUMmxUVEROODNMQmlFNGxy?=
 =?utf-8?B?TFJaM2FNQUIvRXVlVU5OV2l1Uk96dmdPWCtZZHV0dEhhemJlbCsvcExPeWk2?=
 =?utf-8?B?L0RCRXJUOHU5RkZMMm94aWFpUzhCRDBtM0hxMXJRNnRWZEQvQzYvUTByWUJY?=
 =?utf-8?B?R1hEMHVrZFpVa05Vc2IzclUvWU1mNFA4Y2pKdEFXay85bm1BYXdtVUM0eEhr?=
 =?utf-8?B?d0Zvdzd3cWx4SW9zM1ZxS0FIekZpanJpQUpoTFhOSXEwVEYzdFdBRVFGaXZS?=
 =?utf-8?B?TmpaR1FWU2l4V2hPN09nWHcrSUIrNktDSHkzQUliT0dCeStBbUpDRk9hV2sv?=
 =?utf-8?B?YVpVVEpPanBqbTRwUnA4QVUxT0xSRkFiMGY1dGxkSWxXU0Z2Z2FxeWRWRHVm?=
 =?utf-8?B?aHViY1NicittbFFHV3MyS0RQT2RlNTB1dTkrSG9GN3RnclZmeXRZSjY2YlZL?=
 =?utf-8?B?N0hGSkJxY0FYY3U3ajFnd1dwenFTcGQzcjY3ZnNleG9FUHgzNWxBRUZVY1ZG?=
 =?utf-8?B?STRnUGFqUVppTG9KUGVNbk8rNzdTczIzcjNsOHovZ0VTMmZMQTB1NVhyaWFo?=
 =?utf-8?B?MUNHeCtaTGV1Wi9qak1nQ2tZZUFwdHlCdS9xZ1BPNDZ3dFVXNFM2SDNSVXYz?=
 =?utf-8?B?TkRJMkI0ZDl2bUYxbGR1M01EM2NNWGVoQzhjcWpHc0p2OTJwMkRqZFBaMmVI?=
 =?utf-8?B?b093N3J4c05CZHF4aHZJSjV4b1QxRFFHc09EaXVqclgzMFY0SFh0VFIwQk5C?=
 =?utf-8?B?THBQTUhoMk1vOGJSWEhxRzdCTEtubTBpZXUxc0p0YVhJQUg2K2N2OW14VUtl?=
 =?utf-8?B?VXhYdnlsaldQbk0zelBHWEpEOFlidDNoOEs4eWJSaEJUbURGbHBVNWpDc29K?=
 =?utf-8?B?YWh4ZzhocWYrZWk4OE9vQmdXMFpucWlJZ093ZjlvenRYQ3kvd0ZzWFNuYndm?=
 =?utf-8?B?MUdrWlVTU3kvS0xXMnhOK3d4ZlkrY2lQM1RxS0VYZ3hGby9XZmFBODJ1Z3Ew?=
 =?utf-8?B?RmlWS0RrVUJENFhFWmcxNFFiVTlLYVkvdTVyek5vd0s0aEZLc0xzNWVZdW04?=
 =?utf-8?B?ZS9EQ2MvYUZKd0J1ZkdDNE5pb2J6U2VJeUJWNU14R01OeXhQMWFSQVk2MFo1?=
 =?utf-8?B?ZThhZ0dwNVdhY2pLYzQvTmM3OGNSb214Umd2dnJpSmdFeDN1c0dzNWxQM1Fz?=
 =?utf-8?B?OUplT1Q3bmNZNGJJbHdKOWNKVGlYam5PeE5salNsNkFPYk0wVXFpbDlITDRY?=
 =?utf-8?B?a3BtU1BJUVgwTWM0WFA2NStjOGlQcXd5OWtIVjVpOUd5VnlESWJpaEpjaXpu?=
 =?utf-8?B?WUQ5elN0R1g0OTByeDRzZTk4OWErR1pSaWhMQWNiMHZqdlpGTlNHb2sxcUFh?=
 =?utf-8?B?eDNIU0ZvaXRQTmZyUkR0emV3bGFpdDdaNlBBU1RlOFFaVUw3Nkx2ZStvQklR?=
 =?utf-8?Q?GTqWj2?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?M0ViUXZ1WmRvekJQNXU2RjNVbTNNMHU4bzlNOGtIWTVXWVllQmgzdkxJWHlr?=
 =?utf-8?B?cklUSVdDR1R2MHB1eDJ5RFIrQ2pUZk5TbW9pN3BqNGYvOW0zVUd6ZFJCN2Q2?=
 =?utf-8?B?MXBhdWNDMWd4N3hUd0xUNlVzcU9jU215MDh1YmhUN1NhbDdZYlRGVnJQcHJp?=
 =?utf-8?B?ZmxtTU10TDVEVDlpbjg3Zld4UDlYY2hNcTAwdVlvY2N1OGkxZWZSU1dVcHlS?=
 =?utf-8?B?djRzRkVzdE9yRWYwcjBKdjZDZUhSQ1MwUnZqSi9xeVpTaGYvYzhOdStFeWU4?=
 =?utf-8?B?OWZMYm9OYitEaTAxK3dNQ1RMWndCelpPSmlUWEJHQk1ENnBTSzdrd0pRTHJt?=
 =?utf-8?B?QzRLTVZoQXd4UzdVYm9FSmUwUmVGQ0hOeXNnV2VQcGFDbjJFRC93anNhQ1NS?=
 =?utf-8?B?V0ZTMGMxUExxNmpCRFNvbkxyRXA4QmZieHFnQWJnT1huQ3VZelliWU1pZDRF?=
 =?utf-8?B?VGxIVkJ1MjB3NTIwcnBQampCQThJWEJvc1NIVUZibENqUVZoalhnRFZPWFRG?=
 =?utf-8?B?VnlxSUJiN2RMYXFqaEQrNUNFdVFlZ2tRWnNHQWdZRVhIR0RrbnBxa21QQUoy?=
 =?utf-8?B?WVlFdzhwbTVsRWpZdW9oc1Nvb05jeWJ2MEs3b0dlWnF2YXlXTks3ZG8wSXA3?=
 =?utf-8?B?akV5VFpBRXBsdVRQZmJCeXJTUWczd3czMGZTUGRzcEt3cFR2NWpSaDVBOE9w?=
 =?utf-8?B?MHh6bzZXUXpyV245TWJyVnpjUFNxblRvRUliTlNUTVpCc3ZPWmpXTzFEcDlJ?=
 =?utf-8?B?cm1pY0NWYzZYdG1mQllRUXZvZS95MTFiMlFnOU9GT2NmN2g0Q1pQVkJMdDRu?=
 =?utf-8?B?L3ZEWXFlWU9FYnJtNm96WkdycUh1N1NvcmFoL2ZGSUFrL2JBVUtXWDNlZ1FK?=
 =?utf-8?B?Q0I1V2g1K1dQMm5vNnBZekZuaEUvUVNsN3dVYjI0YUkrY0VSOHBwbmhQMmw3?=
 =?utf-8?B?dmNzWWVGNUtJcjNkWWlaNUdGOHVYKzlRVTNqb0JLZ1VkamV6MVBOUndZYjVs?=
 =?utf-8?B?end0M241ek9sdktFVjNLMW1nMktBTldsVUVFaC85V1RKV05SUFNxTklXNmFU?=
 =?utf-8?B?eTBLT0dRU3lLQnZnQ09RTVpEV00vbXVRV28rQWZzQUNkeGRZR3FyVWhoZ0Rq?=
 =?utf-8?B?WUMwMUNtZnhrWWRaNjg0VCtnWkxoK2NQQWxibWJTU2JrTG05RHBSUmZGcGhQ?=
 =?utf-8?B?UGwyRk50VkxFOVVRQ1d5blFITGhTcUFiZ0ltNHpKNUhnZDh0cVZhNTRjNnQw?=
 =?utf-8?B?YWM1SmR4U2YvZUhqTHgyb3I5YlhaOWNDNmpnZHphaFZXWHcyS2F4OG5qTkhN?=
 =?utf-8?B?YkR1YWJXTlBxVGtNVDNIUlNveFNUdEx1R0xKOVFTN1pGZHR1SDBrN0l6QUJH?=
 =?utf-8?B?a0haQkIxK3htdjdtdjNyS25IUFJaVzg1cVc0TmZnOFg4R1dyd3FYMGt6MGV6?=
 =?utf-8?B?OVdPTXI2TWZ3bmZzYlhDMmh1TE1QSXFXZWpSNVRBY2ZNUW1UL3VLemdvZ1Ro?=
 =?utf-8?B?b0VudXNkTWZpbkRSZVFKNkRTV2RxQ3RLQlRRbXY5ZDVwbkVYbUVrdEkwQUZG?=
 =?utf-8?B?d09PSVJVekhuMFdmanphZFJkNTRXU1lIM2VXVDNZUkFVY1NUeVBJdlBVWkxU?=
 =?utf-8?B?WkdicTdtczNrdTJzMGhoait6Vkt5MHNsRDBHcHMybXRkcFlLYno1WStSSnNQ?=
 =?utf-8?B?SVc0RlcrTEg4cVhtaU12K24ydHF1ajFHN0xEYmhBdk5XVkU2YW5ObEllYXNH?=
 =?utf-8?B?cWhmaEtEd0VmZy9UNDRleTBtM0d6QVM4aDJWZUUwYkxUbDFyVjBiQ2FFQ1NS?=
 =?utf-8?B?TFRPdGNzWlZrU0tyVEExVTMvdkczQmNpQlV4YjVZM2hIWEZWV21BTmpwRno2?=
 =?utf-8?B?by9ZaWdkdVlGNzQxV1VFVXdVRGNOcXFQM2UwbFdxRlhDdm45ZFF3czMvWGpm?=
 =?utf-8?B?amtIRUZzc1dkT2l5ZlROTDNrLzFseEFPQVlscWIrSXR5Z3lzZU12OXFPTDZQ?=
 =?utf-8?B?eVVTZ3VhVHZlUThpam5YSEFJcUsyWkJyTnAwTC9DRW5KSVArSnp3SzZOSWZS?=
 =?utf-8?B?R3dGQXB1azJiSG4wWDN2VC91TVhjYTNJQm1lQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80aca645-8c76-4933-c930-08ddff4efaf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 11:54:43.9123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NAHt28/gnhxT3LDEjGCknjJP9Ir4kxQA0F3WPp1lJVQl8YDUilTM5MUgp6SWg79x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB7902
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Sep 2025 11:54:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2250

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiB5b2N0by1wYXRjaGVzQGxpc3Rz
LnlvY3RvcHJvamVjdC5vcmcgPHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZz4g
T24gQmVoYWxmIE9mIEpvYW8gTWFyY29zIENvc3RhIHZpYSBsaXN0cy55b2N0b3Byb2plY3Qub3Jn
DQo+IFNlbnQ6IGRlbiAyOSBzZXB0ZW1iZXIgMjAyNSAxMDo0Mg0KPiBUbzogeW9jdG8tcGF0Y2hl
c0BsaXN0cy55b2N0b3Byb2plY3Qub3JnDQo+IENjOiB0aG9tYXMucGV0YXp6b25pQGJvb3RsaW4u
Y29tOyBKb8OjbyBNYXJjb3MgQ29zdGEgPGpvYW9tYXJjb3MuY29zdGFAYm9vdGxpbi5jb20+DQo+
IFN1YmplY3Q6IFt5b2N0by1wYXRjaGVzXSBbbWV0YS1zZWxpbnV4XVtQQVRDSF0gaW5pdHNjcmlw
dHM6IGZpeCBpbmNvbXBhdGliaWxpdHkgd2l0aCByZWFkLW9ubHktcm9vdGZzDQo+IA0KPiBXaGVu
IHRoZSByZWFkLW9ubHktcm9vdGZzIGZlYXR1cmUgKGluIElNQUdFX0ZFQVRVUkVTKSBpcyBlbmFi
bGVkLCB0aGUNCj4gcG9wdWxhdGUtdm9sYXRpbGUuc2ggc2NyaXB0IHJ1bnMgYXQgYnVpbGQgdGlt
ZS4gVGhpcyBjb21wZW5zYXRlcyBmb3IgdGhlDQo+IGZhY3QgdGhhdCBjZXJ0YWluIGVzc2VudGlh
bCBkaXJlY3RvcmllcyBhbmQgZmlsZXMgY2Fubm90IGJlIGNyZWF0ZWQgYXQNCj4gcnVudGltZSwg
c2luY2UgdGhlIHJvb3QgZmlsZXN5c3RlbSBpcyByZWFkLW9ubHkuIFRoaXMgaXMgaGFuZGxlZCBp
bg0KPiBvZS1jb3JlJ3Mgcm9vdGZzLXBvc3Rjb21tYW5kcy5iYmNsYXNzLCBpbiByZWFkX29ubHlf
cm9vdGZzX2hvb2suDQo+IA0KPiBIb3dldmVyLCBpbml0c2NyaXB0cy0xLjBfc2VsaW51eC5pbmMg
YXBwZW5kcyBzb21lIHNoZWxsIGNvZGUgdG8NCj4gcG9wdWxhdGUtdm9sYXRpbGUuc2ggY29uc2lk
ZXJpbmcgaXQgd2lsbCBiZSBydW4gaW4gdGhlIHRhcmdldCwgbm90IG9uDQo+IHRoZSBob3N0IG1h
Y2hpbmUuIFNvLCBpZiBvbmUgdXNlcyBib3RoIHJlYWQtb25seS1yb290ZnMgYW5kIHNlbGludXgg
KGluDQo+IERJU1RST19GRUFUVVJFUyksIHRoZSByZWN1cnNpdmUgY2FsbCB0byByZXN0b3JlY29u
IGlzIHJ1biBpbiB0aGUgaG9zdA0KPiBtYWNoaW5lLCBzaW5jZSBwb3B1bGF0ZS12b2xhdGlsZS5z
aCBpcyBjYWxsZWQgaW4gYnVpbGQgdGltZS4gVGhpcyBsZWFkcw0KPiB0byBlcnJvcnMgc3VjaCBh
czoNCj4gDQo+IHwgTk9URTogRXhlY3V0aW5nIHJlYWRfb25seV9yb290ZnNfaG9vayAuLi4NCj4g
fCBERUJVRzogRXhlY3V0aW5nIHNoZWxsIGZ1bmN0aW9uIHJlYWRfb25seV9yb290ZnNfaG9vaw0K
PiB8IC9zYmluL3Jlc3RvcmVjb246IENvdWxkIG5vdCByZWFkIC92YXIvbGliL0FjY291bnRzU2Vy
dmljZS91c2VyczogUGVybWlzc2lvbiBkZW5pZWQuDQo+IHwgL3NiaW4vcmVzdG9yZWNvbjogQ291
bGQgbm90IHJlYWQgL3Zhci9saWIvTmV0d29ya01hbmFnZXI6IFBlcm1pc3Npb24gZGVuaWVkLg0K
PiB8IC9zYmluL3Jlc3RvcmVjb246IENvdWxkIG5vdCByZWFkIC92YXIvbGliL2JsdWV0b290aDog
UGVybWlzc2lvbiBkZW5pZWQuDQo+IHwgL3NiaW4vcmVzdG9yZWNvbjogQ291bGQgbm90IHJlYWQg
L3Zhci9saWIvY2hyb255OiBQZXJtaXNzaW9uIGRlbmllZC4NCj4gDQo+IEFzIGEgbWF0dGVyIG9m
IGZhY3QsIHRoaXMgc2NlbmFyaW8gaXMgYSBmYWlyIHJlbWluZGVyIG5vdCB0byBjYWxsDQo+IGJp
dGJha2Ugd2l0aCBzdWRvLg0KPiANCj4gVGhpcyBjaGFuZ2UgbWFrZXMgc3VyZSB0aGUgYXBwZW5k
IGlzIG9ubHkgcGVyZm9ybWVkIGlmIHRoZQ0KPiByZWFkLW9ubHktcm9vdGZzIGZlYXR1cmUgaXMg
bm90IHVzZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb8OjbyBNYXJjb3MgQ29zdGEgPGpvYW9t
YXJjb3MuY29zdGFAYm9vdGxpbi5jb20+DQo+IC0tLQ0KPiAgcmVjaXBlcy1jb3JlL2luaXRzY3Jp
cHRzL2luaXRzY3JpcHRzLTEuMF9zZWxpbnV4LmluYyB8IDcgKysrKysrLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L3JlY2lwZXMtY29yZS9pbml0c2NyaXB0cy9pbml0c2NyaXB0cy0xLjBfc2VsaW51eC5pbmMgYi9y
ZWNpcGVzLWNvcmUvaW5pdHNjcmlwdHMvaW5pdHNjcmlwdHMtMS4wX3NlbGludXguaW5jDQo+IGlu
ZGV4IDY1MzBhODcuLmI0NTlkNDggMTAwNjQ0DQo+IC0tLSBhL3JlY2lwZXMtY29yZS9pbml0c2Ny
aXB0cy9pbml0c2NyaXB0cy0xLjBfc2VsaW51eC5pbmMNCj4gKysrIGIvcmVjaXBlcy1jb3JlL2lu
aXRzY3JpcHRzL2luaXRzY3JpcHRzLTEuMF9zZWxpbnV4LmluYw0KPiBAQCAtMSw2ICsxLDYgQEAN
Cj4gIEZJTEVTRVhUUkFQQVRIUzpwcmVwZW5kIDo9ICIke1RISVNESVJ9L2ZpbGVzOiINCj4gDQo+
IC1kb19pbnN0YWxsOmFwcGVuZCAoKSB7DQo+ICtkb19yZXN0b3JlX2NvbnRleHQoKSB7DQo+ICAJ
Y2F0IDw8LUVPRiA+PiAke0R9JHtzeXNjb25mZGlyfS9pbml0LmQvcG9wdWxhdGUtdm9sYXRpbGUu
c2gNCj4gIHRvdWNoIC92YXIvbG9nL2xhc3Rsb2cNCj4gIHRlc3QgISAteCAvc2Jpbi9yZXN0b3Jl
Y29uIHx8IC9zYmluL3Jlc3RvcmVjb24gLWlSRiAvdmFyL3ZvbGF0aWxlLyAvdmFyL2xpYiAvcnVu
IFwNCj4gQEAgLTksMyArOSw4IEBAIEVPRg0KPiAgCXNlZCAtaSAnL21vdW50IC1uIC1vIHJlbW91
bnQsJHJvb3Rtb2RlL2lcdGVzdCAhIC14IC9zYmluL3Jlc3RvcmVjb24gfHwgL3NiaW4vcmVzdG9y
ZWNvbiAtaVJGIC9ydW4nIFwNCj4gIAkgICAgJHtEfSR7c3lzY29uZmRpcn0vaW5pdC5kL2NoZWNr
cm9vdC5zaA0KPiAgfQ0KPiArDQo+ICtweXRob24gX19hbm9ueW1vdXMoKSB7DQo+ICsgICAgaWYg
J3JlYWQtb25seS1yb290ZnMnIG5vdCBpbiBkLmdldFZhcignSU1BR0VfRkVBVFVSRVMnKToNCj4g
KyAgICAgICAgZC5hcHBlbmRWYXIoJ2RvX2luc3RhbGwnLCAnIGRvX3Jlc3RvcmVfY29udGV4dDsn
KQ0KPiArfQ0KPiAtLQ0KPiAyLjQ3LjANCg0KUmF0aGVyIHRoYW4gYXMgYW5vbnltb3VzIFB5dGhv
biwgeW91IGNvdWxkIGRvIHRoaXMgdXNpbmcgYSBwb3N0ZnVuYzoNCg0KZG9faW5zdGFsbFtwb3N0
ZnVuY3NdICs9ICIke0AnJyBpZiAncmVhZC1vbmx5LXJvb3RmcycgaW4gZC5nZXRWYXIoJ0lNQUdF
X0ZFQVRVUkVTJykgZWxzZSAnZG9fcmVzdG9yZV9jb250ZXh0J30iDQoNCkkgYWxzbyBzdWdnZXN0
IHJlbW92aW5nIHRoZSBgZG9fYCBwcmVmaXggZnJvbSBgZG9fcmVzdG9yZV9jb250ZXh0YCBhcyB0
aGF0IA0KaXMgdHlwaWNhbGx5IHVzZWQgZm9yIHRhc2sgZnVuY3Rpb25zLCB3aGljaCB0aGlzIGlz
bid0Lg0KDQovL1BldGVyDQoNCg==

