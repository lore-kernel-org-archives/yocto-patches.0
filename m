Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BD7C52D6F
	for <webhook@archiver.kernel.org>; Wed, 21 Aug 2024 08:18:02 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.85])
 by mx.groups.io with SMTP id smtpd.web10.15154.1724228280612104052
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Aug 2024 01:18:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=VusBjSwA;
 spf=pass (domain: cherry.de, ip: 40.107.20.85, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8+f1gdgO3b5/6Y67GR2mZYkn/0mdsjfzGpUb7ysmOAALv/HsoJCO5w14ZYic7q9hQhJuWeD8EoJRjRcIEx7cMA6dVThG7URiIGUFRtoRD1y2lbg5G01NDc8gTAOdrNV/rjG9pV1TPfEOpl9LbjCvYzLyDHmdDeB3bARA3hQsH3K6yVUhIKHd9RJsEI882SwBpes5HZXvx2DiJthfey5I9Q0RarWxC6tAnqnCpG2uLX83u/lIXobE5W5rOks+iRHqODoJdkJlNWzNVlhdUIGTqrofkvdJIThhWJdQ/ehdsX4Y8rxh/V++jj/LG8k5PfpTI3M6r1L7hgh8AMqeXfQLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyAi+d9LHvyUwOEjYi00cq6sNzr/uy+d9h3xWVuM6Xw=;
 b=Z9jUDsZSGtIQemsnX14kyKeQ78mlQ/5XvcVHRx9wyg0Nq1woJvudlzIfn0tODq0lT71xGi425MeI4BQR78lFui5ei5prelwOLMJEzrTlZvkaXI4zIsvoEvuO3iNR+g53TrdifAl4m8l1sV6mNN4EPHLq5idtm5g+h87Ds1Zebtd+pN7+nCE15Ss2hrHa3S6c7aK890NeNnkpHHln87x0lLlAq768PGDsRHr3PbmK/WiE54jbVoXtfmz0WIdm5YPBGINr8mPzaigejZ5w4Y7qneQwTYgeJkc6xH8cudaYi2QIuCVurZgRRHDP2+1Fox72g2AGcsIoJDw+ShXT6ContQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyAi+d9LHvyUwOEjYi00cq6sNzr/uy+d9h3xWVuM6Xw=;
 b=VusBjSwAgreEgLRuoEt5dsX9UcZkT4kM4rRbR1vHuUmprIn8nqWz3FfruwNNLfV4SpPBbFdIynK3BRvOEgU70hQZ86aB3LbskuQki+TS4ZG5iA8vDGb7aon3iU5BnfQXfV7Z+lneuYw56llmqDEwnAODNqfrWymRKM2Cw83ttSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB9901.eurprd04.prod.outlook.com (2603:10a6:150:113::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 08:17:54 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 08:17:54 +0000
Message-ID: <91225d4e-ba39-4775-a312-835c6cf39548@cherry.de>
Date: Wed, 21 Aug 2024 10:17:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip PATCH 3/9] rk3399: enable
 gstreamer v4l2codecs support
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <foss+yocto@0leil.net>
References: <20240820-gst-hantro-v1-0-335c4eaf8e8b@cherry.de>
 <20240820-gst-hantro-v1-3-335c4eaf8e8b@cherry.de>
 <b6d2f95b-ebb8-436a-8644-fb63f8126c56@cherry.de>
 <20240821044243.GA1194@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240821044243.GA1194@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB9901:EE_
X-MS-Office365-Filtering-Correlation-Id: e31bd226-31e1-46da-29ab-08dcc1b9c1ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VkhkVmo5VTZLOHdWb1pTL2RkbUcwQnJnaTZhM1RiOGFYazZ0NjdoWGcrUGRi?=
 =?utf-8?B?anNaYk5jK1V3b1I1SGVTdzgxa1RjSmxYNno1bGIyVUpJSktGSkhtRHFsMmhO?=
 =?utf-8?B?aUc3dWdNWXhwa3MvQmNkNWxUeE5uSXpUWGhtV0VNQXAyTkhtYXBadzM4TlJo?=
 =?utf-8?B?bWtPMDlYUTlpYnhjV3g4Qk9TSUZ3VlR0dklDclV1M28zaG1LMzhuQWZqZEtx?=
 =?utf-8?B?VHFKWWU1L05GM0l0Mzh0N1BkQmZKeUNPWEUrYU8rcExWQ1oyeW8xUlJNTUhD?=
 =?utf-8?B?WVBjNjRTN0xwd1pZVStiTnRyMzBGR01PT3RKZFpMdWkxRGlTQXZrL2ZEVmhJ?=
 =?utf-8?B?ci9ScWpla3RiSkR3eHA1cU95Wko1dWZQUFIxZ01ZYnRGbWg0Z1VTWlhrVFlu?=
 =?utf-8?B?eXowQzFGbkZZNEZMZFpnUVFRY3VLc3ZEZjdKVlpvODkySFpPOUF5RG11Ykgr?=
 =?utf-8?B?NVRYZDdBZm1TbDh1YTFqRVByR3pDVHRhcHJjQjNYZFMwaGI5ZUt1RURKMFRo?=
 =?utf-8?B?U2QxQUduUk9kOUQrdkRTeFVkcmw1OE5BSElYWWhpWUJ3ZDltampFK3pKSml6?=
 =?utf-8?B?Q3EvMy9PLytNejlkOUlVa2IzSVBUb1JIcTZaNWxWcHd3Y2RYYXFKb0JuRWo5?=
 =?utf-8?B?L0xKWENGUHFTaDVyUkd5UE5UczhPd0xnN3FLTy9nZmFHak1oL0owTUdRaDBH?=
 =?utf-8?B?RnZ4NGE1QjdzMEYvdzNuWFAraXRrQWNWMkZqRnZya2RIcHFmdjkyV2c4NXI2?=
 =?utf-8?B?THhYL1JhRmovQmNINlNvbkNMek05TEcvS0lRQUZCL2xPRUovNW9NZEZKYXJN?=
 =?utf-8?B?K0NPVFVOQjhBNTJldG1EenlVaVNmOGlJSlNXZ1hCaDhvQVJqOXdDbi9rWGsw?=
 =?utf-8?B?aW9BaVpwLytaY0hqQWpHbWtkbHluMHpZVTIrVjVvcmpYaUw4WHZTaHpiemlZ?=
 =?utf-8?B?TzRtT0c2TEhUQklqdExTdE1QNFdBZi9XR0FIRmVXbUxMbGQ5OVR1THA3ZWhV?=
 =?utf-8?B?Tnh6YXRqM0EvbldCV3Zja0VzbWIzd2cwRXVEc21Hd3lzRkFuajN0Q2NxRWhr?=
 =?utf-8?B?K2t5bjdiNnoybnJrbDAvVDNwaTQ3RHdOb1dtemRVdUNZSGU3eUFnWkNsTHYz?=
 =?utf-8?B?UlBoVXU0dmdibmUyZEwvSkZiMkZ5SkVFaXVBcGtkOFBPRC9JUytVSitiVERM?=
 =?utf-8?B?U2FWTFRtRDNrd2ZWWXlYcjI0VTlKTFZQNHRpNVpLdGpFUUxyMWJkbVlrK1pE?=
 =?utf-8?B?WmpkeEVKQU1zcmt1cnJGSjJvdjY4L0syYXUzYlgrZGdOTHhhV01zVnZvV3B5?=
 =?utf-8?B?Mzl5UFd3aWdZL0o0bnR0aE13TnRTck85SG9oanN6MzU2RnFWdStOYW9Xd2tt?=
 =?utf-8?B?R0tlM3c5TWphdm95T2V5dDNuMTFmVlRkaEhyVkx3Rmc3VGRCRUdnaDlrTDAr?=
 =?utf-8?B?WWJKTzFNVEEwbnpKbVVyTnlEdnFhdWJnK0ZlMUlCOUY4VkkxeTh4VEt2MTlH?=
 =?utf-8?B?OFlmZ0loUTNBLzZVUUk4QU9WS0NQajRPZUU2K1VNYWluVUFWWDgwUCtVVDlM?=
 =?utf-8?B?V2t2ZGdsZ2VZYjBYVnU4NHhaNDJtdnRNa2RzRFlBODJtbmVsdHk3UlE3QTg5?=
 =?utf-8?B?cTM5SFp3WjFVMU85dDFhNTUzRlV5Mkl6ODBYMVBiZlZpWFE2TkZ3M3ZOMmJR?=
 =?utf-8?B?aTQwd25IUUlnY1AreWpjeEY1ODNyVmZRODZkcGxlc0F4M1RPUUhVdXU2dnl6?=
 =?utf-8?B?cE56azhxYWdWckluVzBTaEROSllmV0RzWmM1YXVVR1VtTUxNc3hZL3pMbFN4?=
 =?utf-8?B?elVubmR1ZFRLY3hXc2ZMdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SVdwazVid2tFNS8wZmdTdXVhWUU1a1AxSnBvcFJYSnpnYnRxUE1FU1J6QkIz?=
 =?utf-8?B?N3ZVVjRoYmF6c1Q5Qjk3T1dVZENFOHl1QiswalJsc0czZklFOGJUcEg2bFNX?=
 =?utf-8?B?VmcyWHg4S1ZzQmQxd3ZGbDArVDREK3BHbE9KVXY4RzR3cWFBUDdEL1hNWXBo?=
 =?utf-8?B?STRacDY1N2NqQlZlZGNBbUZVa1JhVW9DQjFqVmtzL3dCa0F6cDY3ZGJLWWJK?=
 =?utf-8?B?K1pUcDZVMzZKWFZrbXoxdEEvS0d2NXdTa2xQL2xoUHpUa080TVc0LzFSY3c1?=
 =?utf-8?B?RXpQbnJlemZxSE5URmJIRXBJNW15ekdWemVTQS9HQ1Q1U2ErR1NucFFVSFdX?=
 =?utf-8?B?M3VuSnJTMzhiM0JhbzNTb24xOWRpVE5ybDFWOGpodnlYQ1RlWWRENzBEY2tk?=
 =?utf-8?B?Nm9yQ3dqbXpUdk0vRUIxalIwR2daeGRXaEtkMHQ2dldveUVkQlhnZzlZK2NG?=
 =?utf-8?B?ZHMrNFppM2VwZG9jb2taLzc5Zm1UUlQvVDNVdk1QYVFocVNmQlFjN0UxblM2?=
 =?utf-8?B?ZTN6dFFjVTViK1ZVcms2bHdETHhuQWJoM0ZFQlNqVDR0TUV2bERESmJXT2pw?=
 =?utf-8?B?SlhWQUVzK3dnRXVvUjNhNXFwTXlHcldIcnVnRmNyYTYydnJmVWlNUG1GUjl3?=
 =?utf-8?B?YkVKU0pwOGoxUDVHbFlsNStMdFAxckZoTmU3bmFhdzhGSURHUjdtQzhWV1J6?=
 =?utf-8?B?S1F3aElvT0NmZTgzOFRRcnlwREdZV05JbHYyQTVGMUtudWVGVWhRZTlOam9t?=
 =?utf-8?B?QkxZdEpDMmE5R1BvdEExOUoyejRrS0lrZ0pQclg4VmRCVFFVRCtheHlGQU93?=
 =?utf-8?B?R1FCR3JJYzg4Tk0wMVM4WnR3MG9mK2h2QVJOalgwckZTbDdWWXpFbitZWGcy?=
 =?utf-8?B?Mmw1NXJEQnlWOFZtQVhoRGt4ZXhhVmJBSTJPV0hpc0l0UjhtSE1uNU9iWHFl?=
 =?utf-8?B?aFFmUU5JTTJmcC9nSTFPZS82NHFaYXVWVngvYkJnYUpFdUU5bGl5QlRSMkFr?=
 =?utf-8?B?Wi8reGZ3NE1tU1hHajFZdjc1SkJjWG9zZG9CSkFjdjgraFY1NFRnOEpUTE5U?=
 =?utf-8?B?K2h4SVBEL2wyYXlJbXI1akZoOVZmbTI3S3I4N3MvMHA5RHdDN2Y1dHUvTENK?=
 =?utf-8?B?ODh3Q0RWUG8zV0c2Mmd4am5LYUtja2FYQ2lBbjRDTFFucDA4ejBOcHZOb1ZH?=
 =?utf-8?B?RFU4KzNGZHNlOFVLVWlrdEFPTHNpdUI0UVdiMlFGb0orS3BXZ0w3L2FPclhT?=
 =?utf-8?B?YlZrMDNvVnhIM1NHNG1hK0xEUlJhSzVzVGs0N1d2ZFJGczc4VE9pYllKOGlM?=
 =?utf-8?B?RitpTFRuNjhwSVBWSUNkSXRZVFUzN1lHUjl6TURoM2ZUd3ZjNjBtUlRyN3Zl?=
 =?utf-8?B?SVQxWkxtb21qbzNnYTJCVVpvemJIcE1ESWRhT29ReCtJSEFuaUV0c01tSWVn?=
 =?utf-8?B?M0FvYzlIZjdEQ2NyUUE0MnlVUCtTWVduek4rWTVnaWNtN0kwVHdJY01Hd1Ba?=
 =?utf-8?B?QnF2cnlnSVlVeTEzaXd3OXdMY3QxNC8yRENZK0dEMitVT0FNZ1RFMHZVM1Fn?=
 =?utf-8?B?ZDgreS8veUJ6eDFvbE92dkRzRjNmanhEOFI3T2pnN2tDbG1PZ1c4VVBqOTgw?=
 =?utf-8?B?cSsrU0tabk9wZU5WRzYwcGtaTzdkWWV4Y2VIN1NzOEYyb2RWUkZxYWwzM245?=
 =?utf-8?B?MUFKSklWcERWSjBnVVozYVJYeDJWQXFRVnFYaDNacHpNMUpreWREWldwM1Fj?=
 =?utf-8?B?aDdraXZ0SjJMeEhhRGVjN0hsQS9SZXo0aEQrakEyTGx4RklkR0tya2IwU0Jz?=
 =?utf-8?B?SjVBR1FqbzkvRUVLZ3hsdmxybXhOcFRGNnk0TUc5SGZNczB6bi9aYXlJRTA5?=
 =?utf-8?B?Z2V5enlOWnBOTVJzU0YwVTI0elhvUElmY3E2SDhwSUdaNXkwbGFqNzZlcHQ5?=
 =?utf-8?B?ZHRKMnNQa3IxL1FDN1lpUjZ3TVhFQktWV202QUU1alJSUU1pY2xDTlZRSUVG?=
 =?utf-8?B?eTFwbDQwQ1Y5Yzg5YXFiOEd0LzN2TWtlNGRzRU9XL3J1KzJLT3FuUFkyYWVk?=
 =?utf-8?B?REkvbkdKNFlQRkt1ajJ2dGtqa2JDS2xMTFZRa0R6d2V5dEFXTVdKR0VlSEFI?=
 =?utf-8?B?WEhCekdmL2RyZkRxSkhXUHkxZTJkby9QM3RDM050Vm5zOE81S1hoTmZvZExW?=
 =?utf-8?B?QWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e31bd226-31e1-46da-29ab-08dcc1b9c1ac
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 08:17:54.3283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Alu8P6usBCxXCivywV47YhajU7nnLJ4WndcvGMjjzhm2lav0bdcRCJUcqsa0cG5fx383Q0FwXM7v25e+9oVhrhPymMzeWGSC5Sv7674dC50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9901
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Aug 2024 08:18:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/538

Hi Trevor,

On 8/21/24 6:42 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> On Tue 2024-08-20 @ 03:48:16 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>>
>>
>> On 8/20/24 2:56 PM, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>
>>> RK3399 has a Hantro VPU, so let's set HAS_HANTRO so that gstreamer
>>> v4l2codecs plugin can be built.
>>>
>>
>> RK3399 actually also has an RKVDEC VPU which is used for decoding H.264, VP9
>> and H.265. Currently, rkvdec supports H.264 and VP9 decoding, while Hantro
>> supports VP8 and MPEG2 decoding as well as JPEG encoding. Therefore, I'm not
>> sure the naming of the variable is proper? Should we go for
>> HAS_STATELESS_VPU instead?
> 
> What about 2 knobs:
> 	1. HAS_HANTRO
> 	2. HAS_RKVDEC
> ?
> 
> Does gstreamer have knobs for both sets?
> 

They are both stateless VPUs, supported by the same kernel API I 
believe. So the same meson option is used, v4l2codecs, so I don't think 
we need to have two separate knobs for those? At least, I used the same 
gstreamer plugin for decoding h264 on PX30 and RK3399 and PX30 uses 
Hantro while RK3399 uses RKVDEC for that. Similarly, RK3562, RK356x and 
RK3588(s) all seems to have an RKVDECv2, which likely is also stateless?

Cheers,
Quentin

