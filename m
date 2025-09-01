Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE62ECA0FF0
	for <webhook@archiver.kernel.org>; Mon,  1 Sep 2025 11:56:49 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.21])
 by mx.groups.io with SMTP id smtpd.web10.49415.1756727808373743667
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Sep 2025 04:56:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=ATKfEfSm;
 spf=pass (domain: cherry.de, ip: 40.107.130.21, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RozGgbgEe9qMMjMzoAsiy48yPf8uws60VFIt+dEp+WvpOXc4GrRudPmg3XZB1bVE/2EG4lE8VkYCDC7Y/L8RLoK85VYbfLAFSv0eDAQLjc3Fj4Bgub81jW4r/058HIoxnbQlnFvKpmjsFUSuAeEm2jZsLQqrHS8ucb2jHRS91SfEC8Hu8Y40dYcswgRvHHSnxSM2wNIOS+4CrPdaFcDvfWOOQBkmHeLFfc7+WpBVziQoUaPRahcAasCmVZHnii5JgpefB+YQ7+2wJdB8yUeqsI9s2xmiSxtFBjOsMrz9lzYrkTzu4mSUdBuxiCuQWlay4WIifX7Xw1o414BOX7B6iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xkMS0sOQJXHlrMZGyGvuRMIcVzqpDeeIy9yQod3fWE=;
 b=zFHjNOrf9z0zcQ2Ygt5Gp08P8By15m8sCZwIof2B7lS6oA9CaE9yyK+9rPeYXfVtUux/m4+k0qR8fbQCTkpV3LnuT0d8Al6otkP3VUhHPbzhNCa018UTg/LUMn3UOdeMmds6dLa2wycy1WsHyRCKSxOSHe9hMq0RJDUrS3BqfxCEp0GH5AyQf13pRSReU7EGujPr2GSCcm3Nn2xbYah+N9q93kamXXNlikTjFwbFI1L6+dlqrF07p4JcAi0uoDh+g/bNbTVfv7/1IaDSKZvfTiZJkHTXSxdlM9EI5EeOWfJvjaJF12f0PUGFy6xnwROqh73nmAAdO6aAtSAvsv5TaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xkMS0sOQJXHlrMZGyGvuRMIcVzqpDeeIy9yQod3fWE=;
 b=ATKfEfSmb+VurqYvYisHJ59RMYNAL5T/X+GnvSyHy0gabQ/HiMs6bbNH8Di6IOgIkijATna3OlKJ+xX8yzursgpjzZoORIkScqxE89mRahyXibwXz5NNaj1uD/oWHyLtCHzDtxODWCLRP6qwBVo/PreCF/GpDvipQbdAgdlPmLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10912.eurprd04.prod.outlook.com (2603:10a6:10:58a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 11:56:44 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%5]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 11:56:43 +0000
Message-ID: <baf5b631-7da2-42b3-b9ce-383c30c27fb8@cherry.de>
Date: Mon, 1 Sep 2025 13:56:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 2/4] radxa-zero-3: use non
 -dev kernel
To: yocto-patches@lists.yoctoproject.org
References: <20250831114105.27494-1-twoerner@gmail.com>
 <20250831114105.27494-2-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250831114105.27494-2-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10912:EE_
X-MS-Office365-Filtering-Correlation-Id: 063674de-0499-4c52-9659-08dde94e9eb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U0JGa3FXRGFSRzc3d1p5Q2NJR0JON212aXovUDBiVWQvUGdncE9SaDh4WXhO?=
 =?utf-8?B?NXloSnJOQUdGSk4xdlJUUXpDaHpqZG1wUC83UWdGTC9OdlM1Q3V6MXc4bEJ5?=
 =?utf-8?B?K1Q4T3ZDcjRQOU13K3N2K0ZRcVJYNmU5RkFLUU9CL0NKR1RFS1BSWFpoUHdr?=
 =?utf-8?B?RDRVbHptOWxqTldyRFJ4djRUM29QVXorcEhmdDhmRGlvTWUyaVNGc1RQZjRp?=
 =?utf-8?B?dXRveUwza2d1MjI4ZmtibDljR3VDYW81bWNyTVU3dmFrY016OHpLUE5sN3Zq?=
 =?utf-8?B?K3JuYWsrTjJiVkZPaUhtcnNaekhYTzMwTlRuOFlodFV0WmhhUkJHMUwySGQ0?=
 =?utf-8?B?a2x4MmUzYUY4UjZ4VHY4TGU3QWlONUZVaU5wb0FYNW9mYUNoSVU2cWxaQ0k1?=
 =?utf-8?B?OTJGMnY0YTNBcEJVYXVKYTgzM2hLdTlmemgycmJvMTJPUDYrTXdDQS9GMkpQ?=
 =?utf-8?B?a0JCV2l4OVorMGpQSjh0V2lPWVdQbzZBM2RRZWExeWw4QkZMUEZ6cTNLYlBB?=
 =?utf-8?B?QlowN1FuV1RpM0pzRmUrT3Jlc082SHp2UHgxdS9SUDJPeWRmWmJkcmNWNUJi?=
 =?utf-8?B?SVg5cGNPemdJeXBPM1ExYWV5T2tkZVE2RFJrbUxPLzBXWGNkNXQzRjd0L2V0?=
 =?utf-8?B?N3pnMGs5OG55ay85Y0RSazdqdkdCc2JlYXVSOHFFVXVFbG4xelhpd2JIQ1VK?=
 =?utf-8?B?ZDMwM1dtUDZWdHMyeGFqOGVUZWFJbUVkNGVKS2ltZHp5dnk3cVQ2QXQrS0ds?=
 =?utf-8?B?SXAxNDUxVGFvdHo2UldnK2thNEFQdGdITTNCNU4zemlPeHlWT2E2UHpEUXd4?=
 =?utf-8?B?WEZZMWw5cGJ1VzN4djY4aWczYkcwRDFIVXNtRGlUQVMrSnFCd1l3Qk16Q1U0?=
 =?utf-8?B?dm5hWE1acVdpSDg0RmlBT2FqZmFWeVBOVFVkZEVXc2N5Nmo1Y0l5N3d2SCtE?=
 =?utf-8?B?TzJtZ0txa0xKejNhUWYxVGppREtvS2ppZkFzdzRheWZHbmJDeEJ2Tm0wZWYz?=
 =?utf-8?B?QnNQajZGT3pOdGp3VUZhNVpSZnNNMmMraDVNMXZ6NmFydWhuWWo1SFFXc1NS?=
 =?utf-8?B?OHlsaE42TUpEa0pvcWt1Vks0Y29kTEc3M3JIYkpLSG5oT0dLTmFtQzIxUmNT?=
 =?utf-8?B?NzlNY0JVS3k3VWFUL1pJMW5wRVZ2WUh2L2pWdzhuamZmRUIrc05jbFlLVWV4?=
 =?utf-8?B?SERHbXNORWZ0NHVXZmlySzhMTDRJeTVKMzNvMzFGeGQxdk1hS3NIdHB2UjVk?=
 =?utf-8?B?dUd0dE5iNExjeEhIa2hoQWdGMmg4OWcyUEN5b056SkNRNWJqaEZXOE4yTlha?=
 =?utf-8?B?Ty9wMi9tZklodjRHUXdlTVlza05ETW56dUZJdFgwU2drMm1WNzFZclhzaDlT?=
 =?utf-8?B?T2lyR1pBY1NTdlk2RXpPR1BYWFJmWW15SEkwZzlHMGxiWkJ2cWxDRDJIcmRV?=
 =?utf-8?B?cnJBNUFnd2NzcmpIZTdEUnNHVkRWYzhBcnErQytIdkxCaU1TeDA4dHR1OHF5?=
 =?utf-8?B?UE1OUVlodnZXU1g3VFpiWFVmQU50VEpyZDBHZnJLYVFmOVhQWHkzay9UZUZz?=
 =?utf-8?B?NU4wQmVOQlpaWHFnNWNuMmRKOFgxbU5aQmpBZU1GK2d1Ym1oaE1kNnFYR0ov?=
 =?utf-8?B?MDNNQzNZTllHSXVmUys2cE1PRjRpTUVrNjJXTUUrbjJWMXBPcTZYTUlaS0ZB?=
 =?utf-8?B?VW5PWGlvMW9pQ1h5aXAweS8yVElqbG5iWll6a1JmejR6U0lMOFFNRmNLcjZa?=
 =?utf-8?B?TjFDUUFiSmx4OEc1VGRzTTBRK2YvcnBlQ1BNcEZLRDRQUVBpRHh6UEQrQ3Vk?=
 =?utf-8?B?bGZJMGhuc1phNVBGR0dzbHArV0FjM013Mzh5OURRYWFuc1BvZ1E4UjdQZzAw?=
 =?utf-8?B?eUxvRi9QZmc2TjhGZXBBNldCR0psZmJGWXBUU1lsamovbEE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?enlRRUtMNldTYXM0eXFoWlUwdkdabVpQMGIyaGszSEZ3S1ZYem50M2o1dEVS?=
 =?utf-8?B?RDExT25vaHo1aE1DdXpkSE1OU3F0ZGZXRzJWY0lEcHcvbWl2enAveFRzc2g3?=
 =?utf-8?B?RDlROUtFNmQrakdFUVZBME9ISzdrMlRVeWVxZDNGL2RSbUlsT0JLc1gvbkNO?=
 =?utf-8?B?amFORmZIbTFJam5kVDdTOXNrSk5lZTNramVSODd6SnVOS05xUjAvZEtHOXdv?=
 =?utf-8?B?YlZldUd3SVhVSnZpRnQrTlZLZVRrNndRVlo2QTcxSWVLaFFjdXhhSzFrdkN5?=
 =?utf-8?B?U1RvQ2Q3MWY2K0ltWkxpSExPUUJxd01KL1I3dTNVNzBjc1BGZWxEWTJxZjZr?=
 =?utf-8?B?bkg1LzRNUksyTzl0YjRvL0txdmZSODJ4MlN0SVdSRjVZelMyeGF4aTFtL1M2?=
 =?utf-8?B?OVNwL2R4YTFnYzhxT2ZOKzJDK1g0alBiZzZXOFdwR3RJL0h2eGRteXdnYlFY?=
 =?utf-8?B?d2RKNWFJT0wyTTRpRUsxSUFwQ3c0d0wyazVXY0R1YkdyUk5kTmFWVjBzUFlX?=
 =?utf-8?B?M2hiUjhFVmJTZU5Ed3BBNXNLU3I3b2tqOERDM0tGTUdVYUhQR0grWlQzWXJa?=
 =?utf-8?B?UVEwbHAzU09lU1NvRldzZ3lFTUNwRWlHeGkrUWk0RHNvSVRDMmFHaCtHbTRm?=
 =?utf-8?B?RnREYmpyUW9UNTRhR2JQZ0cyeWQwZXFxdllYaVhkWE8zQ1BoN2ZaTmMyakRX?=
 =?utf-8?B?ajR0OTRaOEsvWWdDN3dhcFpoMnB2SnhwL1pVU2htTzd5L1ZsZlZ2MVZwc1FF?=
 =?utf-8?B?ME8wVk1oVmsrRFM5bzdCcU9VZUhxZWJVYmhiYlJoQ08zcEtYWmRGemV1Nk9W?=
 =?utf-8?B?cDh1R2lEUDIwdW1Gb0Z3L2JLS01aNE5UWFRmdUF3YUJmOTczVkJ2M016ajZZ?=
 =?utf-8?B?NmgvNWhVZldWc3lIT2lnTzIyMUt3cG5NQlFnVVBmWSs3dmJYSEpFNHVLNjJD?=
 =?utf-8?B?U2hYN0F1bmFsNjVaOE9ZZmZJS0RTaU01Q01lRDNFTTJqblhWelo0RDFQcHFJ?=
 =?utf-8?B?UVZFQnR1c2h1L2RjTHV4SnA0K0l1THJLVExxb0hIcWhPSEptTUdnUEFFL2RW?=
 =?utf-8?B?U2JBMXhYQTNFWHExa0ZUYStMVDVMMkN6UmlKclhrQmxBbkJGS25vQktxOU5s?=
 =?utf-8?B?M0ZneDNTRkdKRklXSkgxQXdiaStobzJ3MzRZWDhJeVN5bjVYdzg5aEM3N3FK?=
 =?utf-8?B?cUJKVStoUVJUTUpDbDg5ZDh3M0diTllhY1A4Y01DR3pyS0x4Y1VZTmZHemFT?=
 =?utf-8?B?S050MzhucmNqTXE2RWc3ZU5pYXB1VWM0T0tPSXU3ZElOYUZQdjlsZjhUVnhi?=
 =?utf-8?B?UnU0QURBZ0JVN3daMnlLVzlST1BUVUFNZzZlajdZamJ6NkhmNzJkMi8wNFRC?=
 =?utf-8?B?UjRhcGdPcnZKVHVPeVV1L1lXNlROb3dTZmdaRHNOb095Ukl4Ukx5M0piMUU0?=
 =?utf-8?B?NHJjSzdJRXV2Nk5jaUlGL3laVTdUVEd3OXlpYU5nekJsSHpmbXZmOWRnQ1Aw?=
 =?utf-8?B?amRGQXh2S0hwQWlWTTNPVmFhZkpXeDNRaUw1ZU5SVU41K3dwNFFlMCtlVVE2?=
 =?utf-8?B?NjB2cm5rcU9iU3ZoUDFBTy8yVDlzWE5wVFJldkpoUzdJYVZlWS9McWxKOHNs?=
 =?utf-8?B?T3JxRTdnL3NONUZzU1lwdXRkcGhsMm1NaWJVamd6b3RkdDlOUTJmYmE0VExS?=
 =?utf-8?B?R2lqcExLMTVDNVNTSzVoelNqcXlUZ3djdVFzWmw0MUdadjN3eHhibVVOMDY2?=
 =?utf-8?B?K1prMmJiTFltV3NaSWZFL0swaC9lUTdhUWJPbUJndjE1bXJtQnZncEg4L1V1?=
 =?utf-8?B?R1AvWjFjdFozL0VGWCsrUDVaNmx3L1MyZTRXRE1ETlBhMEZXTzFVQjF1MUVU?=
 =?utf-8?B?Syt3U3YvTG4rUit3Q3VUTGZ5elhQQ2lJL3hIV0NSNjdoZlZuTmNSMi9NQTUx?=
 =?utf-8?B?MVB1SHNQUTlWOXk1UFlnNWlUM2NoU0Z0VHNZdk9TWDgwdU1vTkNIOHJhMGk3?=
 =?utf-8?B?SVRsaWFJMC9DTVpGeUQxTEdjYUM4TEVwTWRMRnVtUFRWWWcwZ3hjdDZEcTRN?=
 =?utf-8?B?YUV6cUZQdTR5MWQ2b3lMOVc1VEZIR3VsS2FIT0VuN3JsUm5YV3ZwclpETDJJ?=
 =?utf-8?B?bVNGK2J0MllwUEQ2NE44bEdYSUZ3WmlTejVtQ3FPMzl5b25YbHRqOG85MGhR?=
 =?utf-8?B?K1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 063674de-0499-4c52-9659-08dde94e9eb1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 11:56:43.8029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0PA5sdTBG76HdQUqLdEfg5qugvnGXcTanppQDWI6jRXZ8QN4prsjMBPTNHm6b/lJfHhxB40tm/m1pIEf2evMHzYilNPWyN4srCKsAvs6BE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10912
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Sep 2025 11:56:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2103

Hi Trevor,

On 8/31/25 1:41 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Now that 6.16.y is the preferred version of the linux-yocto kernel, the
> radxa-zero-3 machine that had been using the linux-yocto-dev kernel can be
> switched to using the linux-yocto kernel instead.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

