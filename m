Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FBECCF9F8
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 10:28:05 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.70])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6272.1762338478822911687
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Nov 2025 02:28:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=h2SVxym4;
 spf=pass (domain: cherry.de, ip: 52.101.65.70, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syMzTP6cDPFDvhdO+firZv1beePIFd9CvUqg9XkBi3z+0HqqwcAWcUx+WgKr/KD6Q29MtnR86q/967Y6T9UDo/I2X78bTtyc0w7rJyX1nFbq+obylOGMkvS/VUIk9WwKeeaFwV5UsL6nSm/8IO99qTT4Zd5KUGTFPTRqj3PULdokl+3JHSPGLW6xzCMnRMzishXQIlkTBe7xEu9k3xisA8VSxNX+mKuIkxaF1FoNoA5VXT6f2NW5HcRGFHd2WhJ8TeEJYDUvpVLt1z0/efaPOFjXnBf0ZxEtPF8eEQFxD69eYIlYZW3cllHjMpBK5e7P7rSD6W3q6K7Zy4WdkvNGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mCv4FPLAjKrqFMXKzt+d9Bc8InrjeUebWM0NurTiFk=;
 b=PplZVMoIuvluMg9C3adHbv1zXBK3RkWV/cCaIqUAdPONZ0UM1x8hLx+j035W3LT1BlWdgVyWEbgvbffG6sMiukOAELePRTyOy4a2rIh/7O7+UsylvnKLUetgzKlDsLi3VL49IwOrDl/8Kcq82vasdjkT23/EpPqylYB2Joi0PWU6JeLKcRdfZV3cIVwQT6+dexW+HcDiNT9QUnRI8ddw7Vv7lfRAMu8Io5ZT383VZYGZnZA14FzclbcmT/OJ/prls/+uMYloDYAJCodB0/3wqw1DWOZ3FpZk+yQKe0a+Xx0C6coI7daTgRpqBjAopw60qEVj4XCpYmbIGX2nwYYGqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mCv4FPLAjKrqFMXKzt+d9Bc8InrjeUebWM0NurTiFk=;
 b=h2SVxym41lIH9we/YBxVFXqSE6YzuhJ8P7c+4mEjewMeTJVCDBwGsBICYKP1/R8wJUbGafdwgV3rT/yhogBksXln0SVMvEQFTA97v5zPSGVTmfO2Ga35/RZJR0MZMJHz3G3t/iYx6zg0TwsheruK0n2Bm9rI5J60tchD8DCUqaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 10:27:54 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9275.013; Wed, 5 Nov 2025
 10:27:54 +0000
Message-ID: <19df06a3-d582-4b25-8d51-9116018277e3@cherry.de>
Date: Wed, 5 Nov 2025 11:27:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH v2] rk3288: use u-boot.img
 as bootloader image
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com, Peter Shkenev <mustela@erminea.space>
References: <20251104141935.2011578-1-mustela@erminea.space>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251104141935.2011578-1-mustela@erminea.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS1PR04MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b267f73-4bd5-4004-c08f-08de1c55fb30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MlZ3VWU5KzBlT0p4U1ZqMjNKTnBmWHFkeXdaVU85czNXZ0hYZnBPMkR5VUR1?=
 =?utf-8?B?by9lTlBIdzU2cEVaUW9xRVczOGJ5OCtXRDdOUnVjMnhBNXhsMWJxMGg4UURr?=
 =?utf-8?B?akRRb1ZmYzkwS0FpZDFjeW9nZ2RDUHhMWDlWZzNLUTB1Z0ZnT282SVgrMFBu?=
 =?utf-8?B?QTllcEhJKzduWGRxWE96Smd1Q3VsdUdFUmF4V2syS0ZkakpUWk92RVRuY0h6?=
 =?utf-8?B?cEJCcHNkc2wzdmNoVlhHaGE1RVBXQklhenBrYUJzN2Z3SGdSZ25qKzhRS21D?=
 =?utf-8?B?SHJ1WjJIeDJYdjdpdkhHeS92UklhQzdrT28vYVphNlREWW5qSk1KUjZHNmNy?=
 =?utf-8?B?UTV5K25FM2JWcjV4OFFtbGtiNVBpWjRtL1pjUWZocVBmZmlnUXh3Z0lvYkFt?=
 =?utf-8?B?Tnk1SmdFS0tMRG5EZERxWElrSzlpLzZnaGdxQ1JCRklEdEJ3V3pYUUdLVjZM?=
 =?utf-8?B?QlI0ejZEcVhZS3M2VERuYnlYOFJ1N0tlK1B2RzBEQnR4bTRjb1NSWXVyOVQx?=
 =?utf-8?B?SStOeUZJMi9nTmJFQnUwdkp6dERYcFd5dFhQdTRCZ0VXZkNIeDhSNjg2UDhr?=
 =?utf-8?B?Si9tSERWNnBvY216ejVmUDJlSTRZd1RFSTF1ZWlwQ3Y5SkQwaWRJd0JUTDRK?=
 =?utf-8?B?OHJkY1N5K0IwWTFZYm9Mc2I2ZUF1Q21qbjdLQnpqS1hpaUNEMHNHNEtBOGRi?=
 =?utf-8?B?Mnlyc1daSkVVZXhvVWJFOC9WanhxV3FscFgxcXF5cjZrOEJxYURhdENTc01t?=
 =?utf-8?B?YUF6QlJqWlpERUJ6UlZTQm1hcGJNM2gwL3Z3cThFRUpkcU1uTkN2QWY4NS9C?=
 =?utf-8?B?UC9sZFlPdzh4L0gyb01XQ29wOURmdmVCUWExOVdzV25Vb285VVBOWmpJTXVB?=
 =?utf-8?B?eW5xaHROaU50Qko3Nm1yeUZ4aWlINzFkVlQ4Y2JaU1p5dUxBdHRIenNqV2J3?=
 =?utf-8?B?T05YdDlHMU1jS25wUEpYRkI3MHYvQzZiSDYxTkZIcFE1WStnZ2pQbTRpN1k2?=
 =?utf-8?B?OVdYdlJJSy8vUG92bDdUYjVEV3lDZ0ZtMG10NWlWZnhpcnFiSlZ1Z0p5L0xN?=
 =?utf-8?B?V2hoWlFLVlh3MnU2Mi9YUTFVaVpodm9FalA0aEFTT3Z4RVdTOVRSdWRhaG5r?=
 =?utf-8?B?MHJUTEI0OXQrei85R1lCV1RWczk3WWFjVU5jRk5ucGFLZkpuNTZSQ1lLM2kr?=
 =?utf-8?B?QnZqTzdkOEdHUjJhMHRxN0dIMDA3YXBOVVJteEQzZFBjb1FXMDdvK0t1WWR2?=
 =?utf-8?B?NU04cmM3RDFFSHM4Rk1LR0JvNUpoS0VHTkxEbkZQams5SWZSZDhXOXBVNzE0?=
 =?utf-8?B?Z0NCVi9LSXZCbGg3Q0NiSERsTHQxU2c0OWlGcEtPTWVhMWxaVDFZODQwTlRC?=
 =?utf-8?B?L0I1R1AvUEFFd2ZQbFF6Q2lySVNLTk4wVk1QZzZiczlpYUlDaVBzZXVpT295?=
 =?utf-8?B?UFZtR1VQNjA3L0NUTGhkQlM4SFJ5a0NBaDVROWRmMW5HMWhkNlRRZTlDMC9M?=
 =?utf-8?B?T1BkNnZTMTVhNTJ6U2RLZnRJL1BzUUtmSnkzSmp3cnI5U01LTEc3RUdUZlA4?=
 =?utf-8?B?QTVSK2srd1JJY2JrUkFobWJQdkpGU0swWTNOd0hyYTY5bkJaQy9ieFhaMVVi?=
 =?utf-8?B?cWI3MHU3emdPSGxJS3pmNWN6bGZPakJlb1RUNFdHZzkzMC96Z0tGOFhCMW9S?=
 =?utf-8?B?S0lmRm8zU25KTUpWMXptWDFvRU1NOTRWTDJiMmx4ampkSEk1Nkw2U3RmVk9Z?=
 =?utf-8?B?dFhCeFBTWGp6TzdXL1ZHcmVQVUVVcTdqcit4clJraHRkMk5jOXNYazdibytK?=
 =?utf-8?B?OUZBUmpnV3QxcHFXRm9SUWYzcXhKdUZrUWdHK2U0ZTJtWkdINFFBamZLa0tH?=
 =?utf-8?B?THRrQ0ZVSmJxay9uTkduQVZLTzZYRnBSazcrVk1IV0N2QXhiTzRMUmNLSy92?=
 =?utf-8?Q?Xyo6eNd0F8ASjLtFhr2vXBz1aFdE547f?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WE13ZkdROUtDa2haODJESzlOMHRZU3NhZmllK1VGY3l6V212Z1doODl2Szdx?=
 =?utf-8?B?WFAxeWdUZDFJNW1vSFYrK3libDg4WGRxTnRnTGcxRm41RUZlQWFYZGZhWlVT?=
 =?utf-8?B?TFhCSExxZXBmWTFzSlM0NGNrNHB2emVNaXF5MkRQRTdZbTJlTTVSTy9Hc3ZQ?=
 =?utf-8?B?eEFQWHVPUWFQNXQrV01JZFh3SVpzWUp1YzZXcTVjYmo0Vi9KeDBDRitPUXox?=
 =?utf-8?B?WDNDRStaeG9iaUpETzVtZ3VKNXYyVFVxbyt5ZElnd3IrRy90ZXRqeUlTR3l5?=
 =?utf-8?B?VWdBSC9adUlRdDhESUpFY3d0d3NZVnY4d0UwQi9rOWhBb05pcW9xRWhJRHBk?=
 =?utf-8?B?d2ZqNEhpb1FUbEVPWkZpZDFGZ2JuMVNqNjQwSjZ3SmtpcEVab1dnY05tR056?=
 =?utf-8?B?SWUyTEdRaFltT1p1NUFIaFBvZG1udU5QbHA5M3hUTU04NDcxSW1kajFsK0ls?=
 =?utf-8?B?eldDeXRGem92SGwrbUxxS1doWWJLMzFmalJuRVZ2MUZHQWhuV1ZmZFFNa21R?=
 =?utf-8?B?V2Z0RnhMbE1TMEJQck02bkVDcWxlWHU2K2YvY0NIWlpVUmZ1MXNwUUdCTmVW?=
 =?utf-8?B?S1JiYTkyU0hCcmRoNWgwVDdEVGp5OTh1aklFQmk2K0MzOWcvNWdOeU94RGdF?=
 =?utf-8?B?cXNwUkZwV2orcTBEU0o1bURTWjJhLzNTUmFITkpOU3dKc1l5SVZqOUYrOVRM?=
 =?utf-8?B?MEJPZlFGQnRxOEFKUzh3V0R1QUVVczVsK0puWDd1Z0NFWExmaDdtSW5TTWZR?=
 =?utf-8?B?WjcvVzBLbURkVzcyY2YvNGxGQVJUQUNVNUZnMkRxT3RSQXRCVlMyKzdFT2VU?=
 =?utf-8?B?MXV0Kzd0eGhOKzhZOFpWMXg1SVlnMngwZHBNNFFDQTNRTkdQbDRKUFVpSXhU?=
 =?utf-8?B?SVcrR1VwRWFIeEM5SHg2NHo3R0FUU3Uwa0lHNVBzaCtkbUdWMnRlS2hjOEpp?=
 =?utf-8?B?blB4dFVMdXNvMFpFVHZXMm1FOHJESElQbi9kdTlzU1JNeFpGYmRsa0R4UDhk?=
 =?utf-8?B?V3NqbktmT09UNlBhekNKeGpUNFdpM2JnQlhXOVE0K2lBWnRuSHZGWEFxd0tB?=
 =?utf-8?B?eXR3Q0MyVDZvMU16WHpyamdSWXp6WUd2Zkl1ZjYyVnJ4aGFwcGN1U3U0Y0RT?=
 =?utf-8?B?UXo3VzN0VldTZ3lhTDg3dGVhSzBzS0xwZVVIR2NIYlRpOXRjWGJQVzdZWTdu?=
 =?utf-8?B?UktxRDJwMTM0Q0lVcTBpWWI3VkYwZnlNaHAyWkxIb1VBMlUwUzIybFBrc3FC?=
 =?utf-8?B?Y3QxSWFlQTYxaEtBRDV4NGRrM3NnN0ZKUDF6WTFoME9HRG1RNmdteXcwd2JS?=
 =?utf-8?B?M3JmbW85eUlxc1Q5WjVpTGpGZW9LdCtYT0VQUS84R1gzUGNDaWVnbjJwTklr?=
 =?utf-8?B?U1NWSE91TmZGU1N0aS9nNHVTTkNGdmNpenRhM3UzSHp3SGZyai9DSEpjWjdM?=
 =?utf-8?B?eHlTZ0Zvd0pENzdqKzlXeitFTEM2THB4Uy9TNlRkdjlWWjJoazE3N1ZKdmkw?=
 =?utf-8?B?NHVwNUJHa0hjZ3NVcGxhaXU2RE02ZmtNdzhBdFBpVUlKV3dUZjFrT1VEUXky?=
 =?utf-8?B?ZW10dnp2bDNtOXZUQTVoQm91eHk2TmVPK3RybGE3dHA5bUFtVXJYUXFoYk04?=
 =?utf-8?B?MUdXUnA2NmZPZWM1R3F4VjEwclNQSVVNVktPc3ViR3pRRkdMdTBtMlZOczVQ?=
 =?utf-8?B?aXJGeGlGOUMwdlNOR0JqMmkwNXEwS0RaL0FiTTlFdHQ2dElrdGJURXNDS0lV?=
 =?utf-8?B?Mm1qOWJqa2JEWGpkWWNabmZvWm5KZGdZa0NyZFRDSUxMSHUrNW1KMk1RMzlM?=
 =?utf-8?B?aFJnSXl2UFVWWW9IVUxOd2IrdnBERU9PbXVCZG9qNlY2alJVVzV2NGVkQ0RR?=
 =?utf-8?B?bGwwZFBHOWtldmgrQ1MvUDNPQi9BeFpqRHRiMERlenZiY09IR1ROTGxJeC81?=
 =?utf-8?B?dU1Dcy9GUjRwdDBLSHFyQjFEQ3E5c1lVUE43ZFB1bUE4TmVnUGgzYzBORkdm?=
 =?utf-8?B?K0IxNWMvUVlCVXBJYWhkVUswLzUxemhpMmRvOGszK2VQNHJMcmtFbnNqM2lu?=
 =?utf-8?B?VGpZcmY4ejlQSDVKdFdGME5iTEpkUGl5S1hmazJOS1FBRTUrQ3l6cUdyRndC?=
 =?utf-8?Q?jbbaM6tIjRkFF8b2UWwpr+zKU?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b267f73-4bd5-4004-c08f-08de1c55fb30
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 10:27:54.6404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZnAcD9f0LzYZfoclzWn2WHs2sfcCObMfPm/O9XN9yGhisTcFOl5X2N/fJUnl7Yq4rLYmValqIFlWj9xHtu9cI6nvjiKoRVb3pvvSWpzwFPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9287
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Nov 2025 10:28:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2422

Hi Peter,

On 11/4/25 3:19 PM, Peter Shkenev via lists.yoctoproject.org wrote:
> [You don't often get email from mustela=erminea.space@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Currently, u-boot.bin is used for supported rk3288-based boards. But, as
> U-Boot for those boards gets built without OP-TEE, u-boot.bin is a raw
> image, and, since raw images support for those boards is disabled as
> well, u-boot will fail to boot.
> 

I assume you meant CONFIG_SPL_RAW_IMAGE_SUPPORT may not be enabled in 
which case u-boot.bin cannot be loaded?

The mention of OP-TEE here is quite confusing as it's not the direct 
reason why u-boot.bin is a raw image. It always is a raw image for 
Rockchip as far as I could tell. You may not be able to boot it if 
SPL_RAW_IMAGE_SUPPORT=n.

u-boot.img can be either a FIT image (if CONFIG_SPL_LOAD_FIT is 
enabled), or a raw image if it isn't (c.f. Makefile 
MKIMAGEFLAGS_u-boot.img being different when that symbol is enabled).

> Fix this by using u-boot.img for supported rk3288 boards, which is a FIT
> image.
> 

It is a FIT image only if CONFIG_SPL_LOAD_FIT is enabled, otherwise it's 
a raw image. Which means it's an ideal value regardless of the state of 
the SPL_LOAD_FIT symbol.

We should also add a comment in the rk3288.inc file stating that if one 
wants to use OP-TEE, one needs to set UBOOT_SUFFIX to itb instead, and 
have SPL_OPTEE_IMAGE and SPL_FIT selected in the defconfig in order for 
this to work.

The change itself is fine, I would just like the commit log to be 
reworded to be less confusing (and ideally a comment added in rk3288 
hinting that it may need to be changed to itb if one wants to use OP-TEE).

Cheers,
Quentin

