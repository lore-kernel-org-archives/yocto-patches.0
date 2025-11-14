Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1BFCE7AF8
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 11:55:39 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.18])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16184.1763121330955915021
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Nov 2025 03:55:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Gv1SKycC;
 spf=pass (domain: siemens.com, ip: 52.101.69.18, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Exwlpf7vv//G4/r9s8kOT6nUG0paMVVhTCOavKGFPBqZ1K2o034ze9NRE6+L1Wx4lfVaaEtYKperrJC/woz1xzAgoIBvc/ycJ3iwu1i/umrKFxO5J87EVLuj5BEHZ7TsGbc/2ouKVNflqjNiLkkQs+S12xCayay9uyUDbeZls3XxbrMNcMLiI1lfnxMtCiir6vB+UtoXKxMKt/SWu/FKR07QXxm8fHXv+2UDioYS1f4OhLWVltQZFC7bUBFr+gp/qpS4SyXynQYh6ttBrVSMHc7CuuGkdADoIwav4d6A0ThOz2wE/bG9C6ra9AgR+z/nbxNPOxa1JWmYFSczqLLlUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHGgW7bTAPg+2WuuMZHbJ/d5cTpTp+kShJFNqNCyQWo=;
 b=B3pfzgdmHEd0zIJKuQV4CZ8cZuqr7SDiB8N6WvFFH6OT580tRu6uGZNCbKSD7PvqPSRilJ+o7BOptLk7cRZrHizxTOTbLPD2Z063py9qp6cwNa5Rd12UYWNdLj8/bgEKKMAKBAJOn0QOYYu+bo48/dQmotYArE9q/ddjjiirzcRe2bMYhNNqzMgVR6i2NkwbzzmlZBFbXajCy7NJtAAsSvyXAFWV4Z92WuLd5Hja0882Chui4gRaGL6usmRo7zJtBVGn+V87vxP5M8t+RYB3KnVE9Mt7vETNNLcebM+Vc8h282ckHDW1c9usAHSb7G1FQ3W14uqj9kHFfmh4A32p4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHGgW7bTAPg+2WuuMZHbJ/d5cTpTp+kShJFNqNCyQWo=;
 b=Gv1SKycCZNB79uIvihRlK1h+PbUqRD5QjaWEkBMpBCrHTGiOl2dqsCuT+5x1QQCeVq46tdHzI9YYAPHuFcoBdxHNzKmH81YIga51esCXNJefBRAbid/rhPCUrc5izq7cgmZUqoU9LGxZBd0rHe4fcgiQQ7cYZsmuSksgvk6wUv1v5KoLQtE0N9NEtzh4h6/eTdWD0zooNed69xaCpF3C6BP21GKPeZw6MNKHwA8Xg+O6gx81eRV2Qz/IKRNhZlezjn0zx9OsXydvVRCpHWGmuZ79ZsWjCpt/qYPIPmG/YJIEpRZcjHj2UJOzPAGbKVmawKGGzqqPP5s/lw/w43H8jg==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by AM0PR10MB3539.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:152::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 11:55:27 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2%6]) with mapi id 15.20.9298.015; Fri, 14 Nov 2025
 11:55:27 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: Jose Quaresma <quaresma.jose@gmail.com>,
	"yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
CC: "jose.quaresma@foundries.io" <jose.quaresma@foundries.io>
Subject: RE: [yocto-patches] [meta-lts-mixins][scarthgap/go][RFC PATCH 34/34]
 readme: add QA chapter
Thread-Topic: [yocto-patches] [meta-lts-mixins][scarthgap/go][RFC PATCH 34/34]
 readme: add QA chapter
Thread-Index: AQHcVJ0MXQ5CFabkZU6BYw3t6qKIaLTyDMaAgAAEM3A=
Date: Fri, 14 Nov 2025 11:55:27 +0000
Message-ID: 
 <AS1PR10MB569760D671AF59BD1DFF2746FDCAA@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20251113125712.18914-1-peter.marko@siemens.com>
 <20251113125712.18914-35-peter.marko@siemens.com>
 <CANPvuR=GwC6m1XXTMnLPu4j_ysZu2sdkWGEoeic5vHKaGUoDUQ@mail.gmail.com>
In-Reply-To: 
 <CANPvuR=GwC6m1XXTMnLPu4j_ysZu2sdkWGEoeic5vHKaGUoDUQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=f7c2a1c6-b1c1-4a7e-8ad8-82d2e7ba7ddc;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-11-14T11:52:07Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|AM0PR10MB3539:EE_
x-ms-office365-filtering-correlation-id: 8f0414f7-0476-46dc-9c9c-08de2374b3d7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|4022899009|38070700021|13003099007;
x-microsoft-antispam-message-info: 
 =?utf-8?B?M045VmZqUWVRVXQrZTRUQUZ3Q2N3Y3BmcTkzb1Ztakd4amk3eTVOLzBoVWlO?=
 =?utf-8?B?LzA4UEdNdExTR2VybUlkWG53L1MrQzk3RnN0ZGY4NzI4bC9YTFpUQ1lpOVpq?=
 =?utf-8?B?UUFGQVRMZ0RoZjdBNWZmZlI4eFBkQXNKbDByR0xlUmovQjRRa2NzNFVXelJ1?=
 =?utf-8?B?b0dXK1pHdElOSlArOWtzSU9udEwrU0pKTWp4Q1hZRUQ3NWVhM2tYVlNDWEZM?=
 =?utf-8?B?TlprZkkvUElwaEl6dGZ1aFA5R0FCNzU2Rzk1VHhqMmJYZk91d1VzYVpCUG1v?=
 =?utf-8?B?T0VPU2tYMytjOUFZY2tvTHpTSmFpaGxyZDk3ajBRVkp1UHMwZnFiZktMRE11?=
 =?utf-8?B?U1FhdXFPOFBYNTZqaHZZL0xBQlhLL0JSYTB3Um0rUk4yWnBlUnZRZnNkUDRN?=
 =?utf-8?B?V28ydkJSVVJIcHk4VjN0R0hJWDRHNUFsbkNmYVFhaGdqQmF2a1pOeWhGRXVC?=
 =?utf-8?B?ek1sTHhPNDgxNE42NXJPRGxZRE5TSzc4dkpEUFFMaGVuMndCajBkZGI4d2xH?=
 =?utf-8?B?ZVV6R3lmaW4xS3RRMGpuRUVEaktZWUdET0RxRk92ZytnclVsaXpROCtqTjNH?=
 =?utf-8?B?M2EzN1daQWN1TFN3alQ1blR3N09TQVFqTUJHNWRVaTgzdDg4YVVVRWJYMng4?=
 =?utf-8?B?UTd3cGQxbUlJQnpzZmwrcDhvMUVqdlFGN1hPWFJUbU85QlExdlJCS1UzUHdn?=
 =?utf-8?B?aDlIV3BCM0hoNC96Si83SUVIcHRremRmZVoyRHpSelhsOUhNR3Nva29Fa1Z3?=
 =?utf-8?B?Y0xpOFF5NVI0M1ZTckxlZnJ6U1J1S2RTYng0Mnp1aytpZys1K2xOWEtqREN0?=
 =?utf-8?B?VU03R2taMXVicGxCWnF2aXV3Mm40TGRJNjlFYTQ0S0RoV3NvQjhscHAyYy84?=
 =?utf-8?B?cmlqM2ZadUlFQ0dyVUVtMzhCekMxRXRSMzM5RGg0SHV1cmF5ZHJtdkNPVmxk?=
 =?utf-8?B?TlNuazRvL25Cd0tXaVJEMVR6dE4wMWcwL2FpTWJHbWJuNG9zWmtIRUVSNFBh?=
 =?utf-8?B?YXh5TjNUT1NxdHpmQlRVajRwUFVObVZ3SHkyK24zeDYvMFFTbytuUk44MlFP?=
 =?utf-8?B?aVFhRXYxU0ZVUlI5N1ZFZ21INXhYTnMrUTZ0aUhCbnJ0Q2NZMTUxbVkxOHZp?=
 =?utf-8?B?eXdWRXBBY2J1eWtTT1lLOXkrM2lhTDM4WHZ0Q1ZIbHBMekxTSyt4SDVHenVW?=
 =?utf-8?B?UVUrMisyL1BtRGNxNXFhMW0zNDZwdGx2Y1lHVDA1cUFoZkVQd3NwYnIzaDcr?=
 =?utf-8?B?djZhMzZxUE5hbS9MeWRoMk1jOTJkVUZwSVNISGJ6ZVFoeXZGWnZJejNHbVJM?=
 =?utf-8?B?NlBRb0FDNVp6SGhtRE9ld3N5TnVYN3FnSTdSS1ZDSDR6ODl0WHFLcUh5dzdv?=
 =?utf-8?B?a2lhdGIyRmc2SEZRWWlrZGt2UkpvQmdkb0QyMmFwTGhEZTFqM1hYYXNTc2di?=
 =?utf-8?B?UkNsV21aLzBlY25kZ2hmYVA4aW90MzNMeVpJN1d4elVFQnd3NDQwRXo5MXhz?=
 =?utf-8?B?Tzg0MXUvVWZpVk5VZzNlNmhyOUpuclJlS29CQVFJY2FValdPZ1FEd3huVC9I?=
 =?utf-8?B?WmFPcFF6dmUrQThaYTFGeWViUGlWTmdDT0NTa1hXaHNTcFFUZmRPakUrQ1NV?=
 =?utf-8?B?enkxeU92QWwyR0JLLzY4dHJKaCtOQ080K09KVHVvYUhDQmUrbThMVit4TWZU?=
 =?utf-8?B?dVk4L3hBK3AwcEV3OXVUYmU1c0twVk9HcTR6QWM1SDhuUWlaUmhTeENuZTRO?=
 =?utf-8?B?T3Q2Q1duMnB3R1RyZE9UKzhSZ3psbDBEM29ndDhIeW9xa3FXY1U0ZTg1ZVRD?=
 =?utf-8?B?Mzh4L05DRzhVTDJ4YXFsMndmWnFOSE5hZytpZ1NkS2hlVnVHaFB2L3FvWU5r?=
 =?utf-8?B?eEc1Zk13WDVROTZublY0cnNNN0Y1WjdmcVE5V05rMVlKQ0hpNTdhMVRXWG9M?=
 =?utf-8?Q?Gc4xyyFu4bBpmkgz6zkSVc0x1Gr5K380?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4022899009)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ckplTWE4RWxsQWh0WmpkZUc2ekFqVzI0b2lIbzRxS3FHOUVmYmRycTlXV25t?=
 =?utf-8?B?cXhHd0dpNk5HN0tIRHRraGJXRGFCU0tRY25TKzc2RTMyUmZrNmpKRGFYNnA3?=
 =?utf-8?B?NFlnOUd5R2Z0QUlqb25KMmRFMlJCM2lCQVpkNGpFYUQ1aTMycXlQVFEvcGpo?=
 =?utf-8?B?L1JNWTdGUXZGdnpobU00L3JUNmlCd3ovYVdzdEI3UkFRQVY4bmt4VklMWkhz?=
 =?utf-8?B?MXlpRXpjbzJERkF6SFQxbUw4MjM4SVZnd2JqSWNxKzNjRFVHZjc4VDVzZnA2?=
 =?utf-8?B?UHJHTFhKc2NPc0MzVHY3b1FZVjFnN0ZyVEgwM0pwWHZsVTFXV2t3U0h3K3kw?=
 =?utf-8?B?Sk1HY2g2Y3I3QXhheXhZdHRkaS91SW8wSXhYdW1qOUVxY1J5V1VJekQ4c2xZ?=
 =?utf-8?B?ZnBlTG1NT1owcWRzYStTN21UMlFPS1R1cEprSkY1SjZxc1g5cktSRTFzak5z?=
 =?utf-8?B?bU4zWWFLYXQ1VGJCNHdEazBDbThlUlIwZVByLy8yOGdUUlhXL0ZlMXpPVVMr?=
 =?utf-8?B?VjBZdG9JZUtDVlRxc1NaQkgySVFWb0c1RVdvaEdYLzNZSldQMlNtVkZ3NHMx?=
 =?utf-8?B?QVNFdkZIbFcrcTdhQkFvUm45NmJtaGx1LzBJV3VSRzF3VFRSOXBsU0ZUeG1u?=
 =?utf-8?B?T3Q0WkxvYUUvN1FFakIwUG1zK0toUlJub0pxRTd2VUVjOFVtQ0EyTjNmV2Vy?=
 =?utf-8?B?YW1LemQwdFhieVZmeDdqUFZmSzU1ZGVmQW1XY0ppY05qc0VZWGNycytlTXYr?=
 =?utf-8?B?b0kzK2cyNE9udGN4bzI5eTB0YXlHOFZadkhXL05RZDBTNWVzaVdVSWpEN3R4?=
 =?utf-8?B?cEJxMWg3RzlNTWtXY2NnUDY4cHEyTkgwZEFMMjJWenQ4T1k0a0VBcytUOHhT?=
 =?utf-8?B?L0NlVjJ0STA5YmNGL2RVWGhTSTduVkpNcy94RFFUeEdCUGMwbjk3RnJMUVRz?=
 =?utf-8?B?dUZ5NDdXWFE5VVpNUGREMThCRjcvdE9ubUx4bFNjaU9TSmpBYTU2WlhPUWxk?=
 =?utf-8?B?Tk0yb0RJL1FuUWxWTSs2aVI2ZmN3OGpCVHJHc2s5aUtsRSt4bGdnN0U1cDlU?=
 =?utf-8?B?VzlmTnl0dE5GMDRoYVpJN0pSRkxJWG5qYU12amFKYVltU2R6ZGU0R3FDd0Fm?=
 =?utf-8?B?b05STm1PamVZVlJhc1BjNFdWOWw4cWFudmh2TVRJRWlJNnV1dFRCNTZLelFJ?=
 =?utf-8?B?L0N4THJ3bDBlNWVpeld4amdLYWJHNW9aUG95bmVNRDlIZ2hzbEN0eXZpSlFB?=
 =?utf-8?B?SmI1MmtBQmFhQWRYbzM2Si9NR3E3ZitWNEdVRytFL1Vld3duZE1veXpuQlNR?=
 =?utf-8?B?L2wxMWNoNWQvZmVuRW11bU01OC9WRFdyQkRGamtkY25ReWxzM2hIWXRPVGdJ?=
 =?utf-8?B?MWRLZlpFakt1cU82UlVGNldCcDVYa1hkSWNMcXJzVURoVHAwYjdibXk1MTFX?=
 =?utf-8?B?by9tTXVMQlMxUG1TYjRyckFMWVNoS0E3djRpaVYxVUc5NkhIM3N1VFk0ajg5?=
 =?utf-8?B?YUhDYko4Rjkra291R3NmUFBJTnBreklOMkQ5eUc2cTFyYTNCU3kwL3ZJS0sx?=
 =?utf-8?B?aXRIaTJkSHUvYkF5SGdPYjFuVjhxeExrSGtHS2w5Ulg5blBQSkhobEZnTHJl?=
 =?utf-8?B?bUJSbHhnNE5RbXgrWVNjMXgyVFVHU0FlaTlvaTFYcGVJM0N4Y0xPT0FGNCtp?=
 =?utf-8?B?eElyaGlOZ2pqWGdwc2xQWWdNdmczQ2FKWlhocUN1NmJ0ejh0VXdqT2RDckxh?=
 =?utf-8?B?WmZmc3hnRVRRQ1RDOHBxV2lpQ0Z3RzhVazlGYXN0VlBuVElRS2c1R3UrY3Uz?=
 =?utf-8?B?RXB2TjVJNVdwOXNIZE9tWmk1aWlSbkpkT21EYW95QWsrQXYwNzE5MDVYSlVT?=
 =?utf-8?B?WXhGd3d2ZkxOcCtzNjVWZWk1aFZGZGdqdE9uMFFmb1IvZ2VpdjV4WE8wU21X?=
 =?utf-8?B?SElaTEdhbGxGbUNVdVZkRVFRUUhEWUU3WnQ1UHdwTjVPOHdMOHVJZVVhbDNM?=
 =?utf-8?B?YU9raGhKM2lhQm9pWG8wbFJZbmdpbUZHRXdYdEkzTDJReWVPd1kzMkh4YVZB?=
 =?utf-8?B?bDd2TWVVR0tpNGZUaGo0aEFIQ1ZUWGRFQVpOc0t1cFRYblVJQUxsV3ZDWndJ?=
 =?utf-8?Q?wv4HB0eYIbEWSg+Umay5nDGuX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0414f7-0476-46dc-9c9c-08de2374b3d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 11:55:27.3386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EvWSVhII3FNJe1Uj9VmOkXa4hJZqRhkaU5ZorFIx563YM4F3gJG2cGFMH22VhJk5kSkWCJ3l8DlU6WS0GlewEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3539
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 11:55:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2563

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9zZSBRdWFyZXNtYSA8
cXVhcmVzbWEuam9zZUBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMTQsIDIw
MjUgMTI6MzcNCj4gVG86IHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZw0KPiBD
YzogTWFya28sIFBldGVyIChGVCBEIEVVIFNLIEJGUzEpIDxQZXRlci5NYXJrb0BzaWVtZW5zLmNv
bT47DQo+IGpvc2UucXVhcmVzbWFAZm91bmRyaWVzLmlvDQo+IFN1YmplY3Q6IFJlOiBbeW9jdG8t
cGF0Y2hlc10gW21ldGEtbHRzLW1peGluc11bc2NhcnRoZ2FwL2dvXVtSRkMgUEFUQ0ggMzQvMzRd
DQo+IHJlYWRtZTogYWRkIFFBIGNoYXB0ZXINCj4gDQo+IA0KPiANCj4gUGV0ZXIgTWFya28gdmlh
IGxpc3RzLnlvY3RvcHJvamVjdC5vcmcgPGh0dHA6Ly9saXN0cy55b2N0b3Byb2plY3Qub3JnPg0K
PiA8cGV0ZXIubWFya289c2llbWVucy5jb21AbGlzdHMueW9jdG9wcm9qZWN0Lm9yZw0KPiA8bWFp
bHRvOnNpZW1lbnMuY29tQGxpc3RzLnlvY3RvcHJvamVjdC5vcmc+ID4gZXNjcmV2ZXUgKHF1aW50
YSwgMTMvMTEvMjAyNSDDoChzKQ0KPiAxMjo1Nyk6DQo+IA0KPiANCj4gCURlc2NyaWJlIFFBIGRv
bmUgd2hlbiBhY2NlcHRpbmcgcGF0Y2hlcy4NCj4gDQo+IAlOb3RlIHRoYXQgb2Utc2VsZnRlc3Qg
ZmFpbCB3aGVuIGFkZGl0aW9uYWwgcGFyYW1ldGVycyAobGlrZSAtaikgaXMgbm90DQo+IAlwcmVz
ZW50LiBXaGVuIHRoYXQgaXMgZml4ZWQsIHdlIGNhbiBzaW1wbGlmeSB0aGUgb2Utc2VsZnRlc3Qg
UUEgZXhhbXBsZS4NCj4gDQo+IAlFeHBlY3RlZCByZXN1bHRzOg0KPiAJKiBydW50aW1lDQo+IAlS
RVNVTFRTIC0gZ28uR29Db21waWxlVGVzdC50ZXN0X2dvX2NvbXBpbGU6IFBBU1NFRCAoNjcuODdz
KQ0KPiAJUkVTVUxUUyAtIGdvLkdvQ29tcGlsZVRlc3QudGVzdF9nb19tb2R1bGU6IFBBU1NFRCAo
Ni4xN3MpDQo+IAlSRVNVTFRTIC0gZ28uR29IZWxsb3dvcmxkVGVzdC50ZXN0X2dvaGVsbG93b3Js
ZDogUEFTU0VEICgxLjI0cykNCj4gCVJFU1VMVFMgLSBwaW5nLlBpbmdUZXN0LnRlc3RfcGluZzog
UEFTU0VEICgwLjAycykNCj4gCVJFU1VMVFMgLSBzc2guU1NIVGVzdC50ZXN0X3NzaDogUEFTU0VE
ICgwLjY3cykNCj4gCSogc2RrDQo+IAlSRVNVTFRTIC0gZ28uR29Db21waWxlVGVzdC50ZXN0X2dv
X2J1aWxkOiBQQVNTRUQgKDAuMzVzKQ0KPiAJUkVTVUxUUyAtIGdvLkdvQ29tcGlsZVRlc3QudGVz
dF9nb19tb2R1bGU6IFBBU1NFRCAoMC4zM3MpDQo+IAlSRVNVTFRTIC0gZ28uR29Ib3N0Q29tcGls
ZVRlc3QudGVzdF9nb19jcm9zc19jb21waWxlOiBQQVNTRUQNCj4gKDAuMjJzKQ0KPiAJUkVTVUxU
UyAtIGdvLkdvSG9zdENvbXBpbGVUZXN0LnRlc3RfZ29fbW9kdWxlX2Nyb3NzX2NvbXBpbGU6DQo+
IFBBU1NFRCAoMC4zN3MpDQo+IAkqIG9lLXNlbGZ0ZXN0DQo+IAkyMDI1LTExLTEzIDExOjU1OjIz
LDQ4NSAtIG9lLXNlbGZ0ZXN0IC0gSU5GTyAtDQo+IGdvdG9vbGNoYWluLm9lR29Ub29sY2hhaW5T
ZWxmVGVzdC50ZXN0X2dvX2RlcF9idWlsZA0KPiAoc3VidW5pdC5SZW1vdGVkVGVzdENhc2UpDQo+
IAkyMDI1LTExLTEzIDExOjU1OjIzLDQ4NSAtIG9lLXNlbGZ0ZXN0IC0gSU5GTyAtICAuLi4gb2sN
Cj4gCTIwMjUtMTEtMTMgMTE6NTU6MjMsNDg1IC0gb2Utc2VsZnRlc3QgLSBJTkZPIC0gMDogMS8x
IDEvMSAoMy4xN3MpICgwIGZhaWxlZCkNCj4gKGdvdG9vbGNoYWluLm9lR29Ub29sY2hhaW5TZWxm
VGVzdC50ZXN0X2dvX2RlcF9idWlsZCkNCj4gDQo+IAlTaWduZWQtb2ZmLWJ5OiBQZXRlciBNYXJr
byA8cGV0ZXIubWFya29Ac2llbWVucy5jb20NCj4gPG1haWx0bzpwZXRlci5tYXJrb0BzaWVtZW5z
LmNvbT4gPg0KPiAJLS0tDQo+IAkgUkVBRE1FLm1kIHwgNDQNCj4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gCSAxIGZpbGUgY2hhbmdlZCwgNDQgaW5zZXJ0
aW9ucygrKQ0KPiANCj4gCWRpZmYgLS1naXQgYS9SRUFETUUubWQgYi9SRUFETUUubWQNCj4gCWlu
ZGV4IGUzMTZmYzYuLjA2YTk0OGQgMTAwNjQ0DQo+IAktLS0gYS9SRUFETUUubWQNCj4gCSsrKyBi
L1JFQURNRS5tZA0KPiAJQEAgLTQxLDMgKzQxLDQ3IEBAIE1haW50ZW5hbmNlDQo+IAkgTGF5ZXIg
bWFpbnRhaW5lcnM6DQo+IAkgKiBKb3NlIFF1YXJlc21hIDxqb3NlLnF1YXJlc21hQGZvdW5kcmll
cy5pbw0KPiA8bWFpbHRvOmpvc2UucXVhcmVzbWFAZm91bmRyaWVzLmlvPiA+DQo+IAkgKiBQZXRl
ciBNYXJrbyA8cGV0ZXIubWFya29Ac2llbWVucy5jb20NCj4gPG1haWx0bzpwZXRlci5tYXJrb0Bz
aWVtZW5zLmNvbT4gPg0KPiAJKw0KPiAJK1F1YWxpdHkgQXNzdXJhbmNlDQo+IAkrLS0tLS0tLS0t
LS0tLS0tLS0NCj4gCSsNCj4gCStRQSB0ZXN0cyBhcmUgdXNpbmcgb3JpZ2luYWwgb3BlbmVtYmVk
ZGVkLWNvcmUgdGVzdHN1aXRlcy4NCj4gCStDdXJyZW50IHBsYW4gaXMgdG8gYmFja3BvcnQgUUEg
dGVzdCBjaGFuZ2VzIHRvIG9wZW5lbWJlZGRlZC1jb3JlDQo+IHNjYXJ0aGdhcCBicmFuY2guDQo+
IAkrV2hlbiB0aGF0IGlzIG5vIGxvbmdlciBwb3NzaWJsZSwgY2hhbmdlcyB3aWxsIHBpY2tlZCBo
ZXJlLg0KPiAJKw0KPiAJK0F1dG9tYXRlZCB0ZXN0cyB0byB2ZXJpZnkgZ28gdG9vbGNoYWluIGZ1
bmN0aW9uYWxpdHkgYXJlIGJlaW5nIGV4ZWN1dGVkDQo+IHdpdGggZm9sbG93aW5nIGNvbmZpZ3Vy
YXRpb25zIGFuZCBjb21tYW5kczoNCj4gCSsNCj4gCSsqIE9FUUEgcnVudGltZQ0KPiAJKw0KPiAJ
KyAgICBgYGANCj4gCSsgICAgSU1BR0VfSU5TVEFMTDphcHBlbmQgPSAiIHBhY2thZ2Vncm91cC1j
b3JlLXNzaC1kcm9wYmVhciBnby0NCj4gaGVsbG93b3JsZCBwYWNrYWdlZ3JvdXAtZ28tc2RrLXRh
cmdldCINCj4gDQo+IA0KPiANCj4gSXMgdGhlIGdvLWhlbGxvd29ybGQgcnVubmluZyBhdXRvbWF0
aWNhbGx5IG9yIGRvZXMgaXQgbmVlZCB0byBiZSBsYXVuY2hlZA0KPiBtYW51YWxseT8NCg0KZ28u
R29IZWxsb3dvcmxkVGVzdC50ZXN0X2dvaGVsbG93b3JsZCBleGVjdXRlcyBpdCBpbiBxZW11IGFu
ZCBjaGVja3MgYm90aCBleGl0IGNvZGUgYW5kIHByaW50ZWQgbWVzc2FnZS4NClNlZSBodHRwczov
L2dpdC5vcGVuZW1iZWRkZWQub3JnL29wZW5lbWJlZGRlZC1jb3JlL3RyZWUvbWV0YS9saWIvb2Vx
YS9ydW50aW1lL2Nhc2VzL2dvLnB5P2g9c2NhcnRoZ2FwDQoNClBldGVyDQoNCj4gDQo+IEpvc2UN
Cj4gDQo+IA0KPiAJKyAgICBJTUFHRV9DTEFTU0VTICs9ICJ0ZXN0aW1hZ2UiDQo+IAkrICAgIFRF
U1RfU1VJVEVTID0gInBpbmcgc3NoIGdvIg0KPiAJKyAgICBRQl9NRU0gPSAiLW0gMjA0OCINCj4g
CSsgICAgYGBgDQo+IAkrDQo+IAkrICAgIGBgYA0KPiAJKyAgICBiaXRiYWtlIGNvcmUtaW1hZ2Ut
bWluaW1hbCAmJiBiaXRiYWtlIGNvcmUtaW1hZ2UtDQo+IG1pbmltYWw6ZG9fdGVzdGltYWdlDQo+
IAkrICAgIGBgYA0KPiAJKw0KPiAJKyogT0VRQSBTREsNCj4gCSsNCj4gCSsgICAgYGBgDQo+IAkr
ICAgIElNQUdFX0NMQVNTRVMgKz0gInRlc3RpbWFnZSINCj4gCSsgICAgU0RLX1RPT0xDSEFJTl9M
QU5HUyA9ICJnbyINCj4gCSsgICAgVEVTVFNES19TVUlURVMgPSAiZ28iDQo+IAkrICAgIGBgYA0K
PiAJKw0KPiAJKyAgICBgYGANCj4gCSsgICAgYml0YmFrZSBjb3JlLWltYWdlLW1pbmltYWw6ZG9f
cG9wdWxhdGVfc2RrICYmIGJpdGJha2UgY29yZS1pbWFnZS0NCj4gbWluaW1hbDpkb190ZXN0c2Rr
DQo+IAkrICAgIGBgYA0KPiAJKw0KPiAJKyogT0VRQSBzZWxmdGVzdA0KPiAJKw0KPiAJKyAgICBg
YGANCj4gCSsgICAgU0FOSVRZX1RFU1RFRF9ESVNUUk9TID0gIiINCj4gCSsgICAgYGBgDQo+IAkr
DQo+IAkrICAgIGBgYA0KPiAJKyAgICBvZS1zZWxmdGVzdCAtciBnb3Rvb2xjaGFpbiAtaiAkKGdy
ZXAgLWMgXnByb2Nlc3NvciAvcHJvYy9jcHVpbmZvKQ0KPiAJKyAgICBgYGANCj4gDQo+IA0KPiAJ
LT0tPS09LT0tPS09LT0tPS09LT0tPS0NCj4gCUxpbmtzOiBZb3UgcmVjZWl2ZSBhbGwgbWVzc2Fn
ZXMgc2VudCB0byB0aGlzIGdyb3VwLg0KPiAJVmlldy9SZXBseSBPbmxpbmUgKCMyNTMzKTogaHR0
cHM6Ly9saXN0cy55b2N0b3Byb2plY3Qub3JnL2cveW9jdG8tDQo+IHBhdGNoZXMvbWVzc2FnZS8y
NTMzDQo+IAlNdXRlIFRoaXMgVG9waWM6IGh0dHBzOi8vbGlzdHMueW9jdG9wcm9qZWN0Lm9yZy9t
dC8xMTYyNzM0MjAvNTA1MjYxMg0KPiAJR3JvdXAgT3duZXI6IHlvY3RvLXBhdGNoZXMrb3duZXJA
bGlzdHMueW9jdG9wcm9qZWN0Lm9yZyA8bWFpbHRvOnlvY3RvLQ0KPiBwYXRjaGVzJTJCb3duZXJA
bGlzdHMueW9jdG9wcm9qZWN0Lm9yZz4NCj4gCVVuc3Vic2NyaWJlOiBodHRwczovL2xpc3RzLnlv
Y3RvcHJvamVjdC5vcmcvZy95b2N0by0NCj4gcGF0Y2hlcy9sZWF2ZS8xMzE3MDcwOC81MDUyNjEy
LzE1MDQzMzgyNDIveHl6enkgW3F1YXJlc21hLmpvc2VAZ21haWwuY29tDQo+IDxtYWlsdG86cXVh
cmVzbWEuam9zZUBnbWFpbC5jb20+IF0NCj4gCS09LT0tPS09LT0tPS09LT0tPS09LT0tDQo+IA0K
PiANCj4gDQo+IA0KPiANCj4gDQo+IC0tDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IA0KPiBKb3PD
qSBRdWFyZXNtYQ0K

