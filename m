Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39810CFA466
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 13:19:18 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16510.1763990348963194367
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Nov 2025 05:19:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=fEgXCpgy;
 spf=pass (domain: cherry.de, ip: 52.101.65.48, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkJg8bzzKbIv4uAp1dZSxw8hFVM3lzbkUp9foIutDaSBgnj7aKOPAFxkTwWN5YyKgEfJGzqvGGn0fuUlF5BIotvuH1ZU4Q9y4DDPTApKEDJaxuKriTnqaA/kd/v4HSedpsMRIoWs11spm2ilT4a2VXY0D8MyZYFY7aM3nQkwsXvDLSuk/wQewyy3nHOE6FDMOpjS3yMjIc4iYvA4QYyKsO/jF7KDfvyV9XTfg0ZoHsGspKJAjDgZQ01z6FWh45Umw6XtM5P0cAW9ey+wq0dP6BPmg28h0uFkC2vOmgncQJXLjgfeim3EMr29CuasZZAft2XTddS4bm3I1+e8966BQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+1XkmjZVZVwCOe8qhAi965IwCMY2J+nt6EgavbHlO4=;
 b=dIzFXrOgciMpGTopkPO/+LwpgWFKpEZVB70ZOnD1iNZmgXrr9MlQZhXmSi7VRN03NNRhFQ4wwh3ABsygvNKZMQsJ/TrFW9wo5IPmrCPajA266o3rlF+FXIV06ruUibajM1tHBDzYy69GGdXqOSzb4Yn7Cug0zm7NnqGzGy6JmamqZ0+NOVUZU1i4xBE7vB/BVuGo3IfWIQZdZj6SUpNmTi7xZ02Znaf/0j7z6YzpPbIJ3TeVdNQa0oIfw6MtHqCdIwbJ8lBDbPHHJ0JGCQtBBjSMgFN1pyajGU2Z3NYwkCqqIBXkfZxc4KLP8YTo3U2UkdqAsuKCQbuLRCByfdA7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+1XkmjZVZVwCOe8qhAi965IwCMY2J+nt6EgavbHlO4=;
 b=fEgXCpgyN5JKBJhm/5NlWyKnXMhY3/JjtIQEi98BsUG3md8eCTUIqnFB2ivJF5a1CpCbuZdi9xRVx9h3RMk65E7L+Xh/ae3yMgCLeukyJPMB6v9HbVAkvbaIKKQqMvpwgov53lCzbWh5HBxCxLf02Haic70ryZnXKT/Kye+z2dY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM0PR04MB11880.eurprd04.prod.outlook.com (2603:10a6:20b:6fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 13:19:05 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 13:19:05 +0000
Message-ID: <925d8341-42b6-4fc9-98a1-23fe90b4b1d8@cherry.de>
Date: Mon, 24 Nov 2025 14:19:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH v3] rk3288: use u-boot.img
 as bootloader image
To: yocto-patches@lists.yoctoproject.org,
 Peter Shkenev <mustela@erminea.space>
References: <20251108225641.171832-1-mustela@erminea.space>
 <20251114145308.GA22027@localhost> <20251114150114.GA26364@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251114150114.GA26364@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::24) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM0PR04MB11880:EE_
X-MS-Office365-Filtering-Correlation-Id: c6048584-d479-4d39-2c7e-08de2b5c0a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WCtZelk3SzJkVWFCazBCaUhibVRldEQ4NjhFcHcrWVlndU1HcjhYdGZaOEFS?=
 =?utf-8?B?RGptZFVQQ2tic3BrOE03N0JYSU9LWlhtajU3c2tXaWRFV2xYQ25ZZldmSWZ3?=
 =?utf-8?B?WHhTU2licVd6amxaWXJCK3BpbUJpUWxHdXgydWJ3UlR4c1BRLzkrbitzTVhL?=
 =?utf-8?B?bGtTMG52QXNXaGRYUkR1cmp1eFYyVkM0cG5CcXM0TmpheW1PUnZGaVlocml5?=
 =?utf-8?B?anJVZ0JtYVo4VWY3cHF5NTR6cWZlVG40QVJmQnhGYmNRZ3EwdVhwUGtpU1k5?=
 =?utf-8?B?NE1tR0FEOHNhTTBEc1ovTEMxckJWdjZGRUx3bVNtdHNzcjBRbW1MTUt4Ly9r?=
 =?utf-8?B?SjZ4MGF4NFVzdFp1WFFkeVhHcnJHdCtyMkJoZ1d2UTBFNm5FNWZWTE9reTdK?=
 =?utf-8?B?cHNiaE8vQ1lpMHVDZGJiSitlSzFCQmNESDhHeXdWZHRiRTNzVnhtYlFkZEps?=
 =?utf-8?B?VTRzYXUxZmMydWhCaEx6L0VCYVR3eHBMck1NOUVyeCs4MXd3Z2JDMjk0WG1N?=
 =?utf-8?B?aHRUUGI3eVNYWkd1QVpHajB4dG9HY3dDK2NISlZBRld6SU9PdHJFWWd5cDFE?=
 =?utf-8?B?OE1Ta3VYUVpOdE5sYzFWaFN5WmJ5UCtOd2syOS9PaUVCcmtRU2REbUxkejJG?=
 =?utf-8?B?WGZseHVCbzlRS0NXSkJWR0s0OXlISEZVeDJyaUxyQUErbjJMSko5NnpYaXFa?=
 =?utf-8?B?bmRPZUFaeU0yaDJmZjJieEplUGpLd0tTSVlTb0ptb29td29MSmlVSUJUY0VZ?=
 =?utf-8?B?S3hkcW1meWp0dzFUeDYxRzB3SWF4K1NRNWpNVUVtZjRJT2FiMW1QZmYrK2RP?=
 =?utf-8?B?NFVNbmZ1WWoxS0U1ZThRM1ZERGErVEo1elJucU01ODlRejVvVVdaTFZFOHlS?=
 =?utf-8?B?OTR6alR3STVWOVlsM3VTQXpPNzlWTmRBb2NJNVNhbjBxemFVVEpaOGdnMjdQ?=
 =?utf-8?B?ZWF3OTZyNTk3TDRmTFlhUXB3akdnZVlLTmx3TVVEeExTbTZycWVsR1FHcnkx?=
 =?utf-8?B?MzNRUzJPOEJzREdYellPS0VOT1Zqdm02MFNJWFhEZVdTUnUwSmUvMWRDbHdV?=
 =?utf-8?B?WTF0ZlNzbCswcGpPWHd0czlsVEV6T2I1emJXUHJqaEorb1RZbGExWUlUSmdj?=
 =?utf-8?B?dy9mbS8wRGRKeXcvaWFHTTcvZWdCRVFzTXQ2UEY1QmhXR2IwU3dOd0ZWQkdi?=
 =?utf-8?B?UVFNNzhjdzI4anBERFFRU29HYmc1bDgva3dlVndEYjYzRTU5dFB3Q1U1L2Nk?=
 =?utf-8?B?UFgvMWx4LzhFVVhqMWNmQ216a254UWlwdVdsMHJnajlYMlJjUUpaS0wvWi9w?=
 =?utf-8?B?SUZwa1VsUUtkMkFYWWhXRVlwbFJyaWRtMVpSWkJyTm1EU3NIL0owOE9wTUpa?=
 =?utf-8?B?QmpYcDFiZ1VKSFV6WFhZRGxIaExNRDduRHlQbFJzaEMyaWZmYjh4MklKUTAw?=
 =?utf-8?B?Y3FQOGM5SEl6K1VnaHBVVEFZVEdyeXBVejNBaXAyR0dQRDlSYXEwVjhBcm1D?=
 =?utf-8?B?em5UdWJldUp3dzljd1pYOEh4WmQ1cUtzRVdRblhmTWtMMkd5SnRHVFNFYnRK?=
 =?utf-8?B?RS9qelp1WUJUTFNyaHExNmpjdm1LOGhpZjFsSmdxQTB1aStPVHYxVVR5WERQ?=
 =?utf-8?B?TG12WHdCYTVZWmpOdDZOWjVXRXlzVnVoaDFGNm5RNDZuR3JVYTRVNE1TVlZa?=
 =?utf-8?B?RzI4TlZZcFplbGlNc0pRQmQwd2lUeHdOSkdBVWgyeDFaVnV0YktxMys0Qlky?=
 =?utf-8?B?Vm52UEpyMXlNVktKUDNJK3FHN2lwZHNvcWVGNGpqTTlhT0VPajJESXUreWFM?=
 =?utf-8?B?Q25ieEhyandZdlEzZkVRcWtWYkYrN0lneHZLcXBFM01JSkdIL1VReHIydzcy?=
 =?utf-8?B?d1NDb3JFcHJNcWVuVFRlYUN5M2FrWE1wZ1NaTkJPWGltNGovMkpaUndtOEk1?=
 =?utf-8?Q?EjCaOhz2Mkjp3xcLp2iAwSjoehFqERbT?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WjF3aEs0L0ZTUndacXVialA0N0VnYlJwaTVLNEhnQUdrQmRPbmkyUmlKdU9r?=
 =?utf-8?B?QnhOUzc2YmV4RDlOV1puUHRhR0ZJK2Z3V0JiMWxYb290eUpPczFqMVprMURL?=
 =?utf-8?B?UHVTK3hxTTVxVWp1VEpnQ0NreFo3NUpjUVVGb29IcnVHcFpPYzZVeG5seFZy?=
 =?utf-8?B?MmVuSVBlUU1nMlNGejBpT0pBOVBCWEZiaWViV2dON3MwSFNCWERUcmNJak1m?=
 =?utf-8?B?c1VTeXlrZXlyenh2VlN5M2NIZkRnSnBsKzNwUExBZTNPYUh3dHU0NmxjbW1a?=
 =?utf-8?B?UGN3aHd2U0FQZnZKTnBGbk9BY2VTQ2wwcnlqOVRaQVRPR0g4aGxkTEtMaHRB?=
 =?utf-8?B?VFltdEVldlZSemUvdE1KaGt5cW55eXhDZ2NqOWl4SmJMWDEvS250M3dYeDJZ?=
 =?utf-8?B?c2RMektOREFLeVlqRDJkUXVGVXA4NDRkVHNoTzR1eTE4K2RUZ2tmTHRyc01K?=
 =?utf-8?B?eUlwTzlzcE5JcXBZaTYrVHh1RXVhd2dkUmxZeGdyT1hZalBKSUFLUG1WRU03?=
 =?utf-8?B?YVJIU0JyMklRK2hyTG8xM2pTNFFmMVhUZUxpWUF2TStPYkNsSGI0UEEvQUNE?=
 =?utf-8?B?TmdEbnI3K2xTUGF2M0V5cndvZTB0YW9KN1ArWWFsRG9rM3pJcGozUUp0VlFs?=
 =?utf-8?B?T1ltUElZdmxzSEh0OU9QMUpTbWVoa0tLU0dzaEh5VW9pajdjVm5TazU2cWtQ?=
 =?utf-8?B?RTNsdDZzUVQxMTBXRnVIS0xtdGdCVUpaNzNwRzRwWXpzVDljOG5FOGpGMEov?=
 =?utf-8?B?L0hXcGhzM21nbkh0VkxPb1AwaFNBTTZQQnBHV3IvdFo2L3VjT3pZRzBhU3d6?=
 =?utf-8?B?S0lKZ0dET0tiMldDUDJyVU0rdlhJc1RYdEdjdjN1Q1RpQzRqZy9SRTFkeVhL?=
 =?utf-8?B?aGNuZFVsRCtyeHMyLyt5ZWFPUlBKSnB5eFRHTkg5UmdxOE00WUZGZ0RQQnFD?=
 =?utf-8?B?aTVlYk44WnZhd21IMEIxWUdyclYzQzdaTDFxWC9Nalcwc0xud2lmZ3p6OE5X?=
 =?utf-8?B?VlI5cDJ0ekFXMDlkRlN4VW5PNlZieGNWdWVnNnJIU0tPVEpYSW1rTnRnSHNm?=
 =?utf-8?B?eExCcmsxWmxjNU1xbjRvNWh6ejloaVF4bGRHUkJndXJ0K3VIUDVZV0hxTlY0?=
 =?utf-8?B?SmcxdW5yQjVTQjVoTUVpcjdsY3ZUMFQ1QURhV0syK2V2ZVR2TUxqRHA4bzls?=
 =?utf-8?B?K1ZnUVJweXNSZlpUME5vaWVtb3IwZmErZ0M1cnRQQjVVSEYvQkdhcnFLbksv?=
 =?utf-8?B?cGVlVk1PS0l2UEp3U3BtNEkwZFZ5TytVMDJXcDRzTlJqclp2eXdsUk8ybWNp?=
 =?utf-8?B?bk5JMW5JTks4TVpZL2Z2ckF3Undtek1QbUlsMmdUdmRPOE9yZisyZEViUHZs?=
 =?utf-8?B?VGd5MWZ2QnBySGZMNXRRajlrdmowcUZld3dkeFl1L20rU29QM3c1MFBhMVBT?=
 =?utf-8?B?L2V4WDh5TGJEUGlSbWhaZW1JbkNyeXZTRTRMd3BVMjRiSjlmZFREZkVhQWdG?=
 =?utf-8?B?TnQ2dHFsdmxIa2p6SUNwUmNVMXdPRDg0UkRNbmNOV0t0cW5ZYUJ6cmM1bWpv?=
 =?utf-8?B?VW0xRlJFdHBVZis2SFVzQVRJYlpFaHN5K0tEMndOVVpOY1BISU5MUzcxVGxC?=
 =?utf-8?B?R1F4R1IxVEpHeFlveG5keDZCYW9RRWRTeDREUnZLUUl3U0pSZmtBZzlRRkF5?=
 =?utf-8?B?bGJaZTdKczFtNDlTYWpyV3dRVzlkNzdpK3V3SGkzZTM4b0YvVXNhTjJMbFNh?=
 =?utf-8?B?MTRmL2xoYWtpaWdCcHhPYlVLaWFVZGFpNnNYc1h4c0dPWSsyRFYrNGRUd2ll?=
 =?utf-8?B?VmVGTlBSTkZWa0ZqcFBhS1VMenNQL1NxRFZtbFVydjV6V3JQMC8rVCt6MStN?=
 =?utf-8?B?R0tFR05lWUR5OWRxb1RXN2VwL21KaDltSDJab3hGK1BWMGdiaG5hcDFsLzVD?=
 =?utf-8?B?TDdMcGdqSU5abmVzT3B3dmI0NHBVSE5YblYvditkNDhCbWVkcU4ya0sveGY0?=
 =?utf-8?B?N0srbGhRaTJZRm50UlFlMEc2S1NtM29WRHRKc1ltUVhSbEgxbW9xUHNjTnh5?=
 =?utf-8?B?OTJZYzYrNm52YTRVT2g5Y0JaK2F5d01iOUkxVGxlVVFGNXU2VWhSd2NEUEZl?=
 =?utf-8?B?VFVwVkg0YWFKZjZ0cmZxNE1Kd3N5QlB1VFdYbjdFeTZKL1FhVlFIUHlUV1l5?=
 =?utf-8?Q?lW5a4i8LNWQnAs42NWXg704=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c6048584-d479-4d39-2c7e-08de2b5c0a9e
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 13:19:04.9628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wd7e9KtP+hc6eVQQeyt71vcsHXdfCVUfSHg1FYViAqdDT5XiW+9LUKbzRPfBAcrBw2y5y3gBH/FriuhF/wpGYX0tDwsjRqA2VvZJDlsWvBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11880
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Nov 2025 13:19:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2692

Hi Trevor,

On 11/14/25 4:01 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> On Fri 2025-11-14 @ 09:53:08 AM, Trevor Woerner wrote:
>> My build testing shows that this patch fails for the rock2-square
>> MACHINE. Are others seeing this as well? In the v1 patch Quentin noticed
>> this and mentioned building for all rk3288 devices, was this tested?
> 
> Actually, never mind, the fix is so small and obvious, I'll just roll it
> into the patch and commit it.
> 

(Probably should have used ${UBOOT_SUFFIX} for the fixup :) )

Do you have a Rock2 Square by any chance? I'm wondering if we cannot 
migrate it to use wic instead of rockchip-gpt-img for generating the 
final flashable image? But I don't own the board so it makes it a bit 
hard to test patches.

Cheers,
Quentin

