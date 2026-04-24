Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEABFE51FF
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 10:27:14 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17924.1777026428712545641
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 03:27:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=nnBpMReN;
 spf=pass (domain: cherry.de, ip: 40.107.130.43, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fa/OMFe0F/IgRd3tSvdQVYMHCVbK6kxYrsBdDhN7HK3n9AGXp1Nk4LK4vbXU4W3TWsxm+YMlutiKvi2gwRwvhjAQzvfy9oTph82eCRhBw3h8/pYjlpGZ5votnhW3HOsa7RsNptLC42fT1AIHRy5YawWm6XJ0Bj4hzDRtB0Bw7hL5DkFIWyCcjp5X3rBaTp4fut/qiEyLhQ+Xjxijmr4vOULw2apIY2yc/pQ6hy0Ows3AXuNCRJT3ZviB2NMrl0Z/NE7JMFEAc/y7oyA5PwcTeZjLsnR7pMVFXZoT4jsbxH6a+D1bDfllg2NqA4LeJymKUa+7HTc44Br5AcBQ/nXApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=St8yKRCcGBJayIb+IcqCdqxTeeKl33AW5lv/LMUvTOg=;
 b=Eomp0+rWR+qHb6gpH/oP+sxnZhMAFpZb4aUV0K65jHEKqP8AnWJvV6HPUsYVTSpIrrCU3SnWCQ+2POro0TbCxk4xDmtNZ/R+yzAQbUvnPX72RnZnUUMEy7l6MUP+r1eMDbRmwDlTDdyv1ck9v2tkOplMb6Eh/P3TBWOKJfXt2SEvJzxYIz1lawrPUEE2W8cR5t1JatC/NAu1iGRsF14xRIjJrYGtFWEh6cjlBdoQS5kMUcEI3BqVx1T8HV6XCMKobRIG/RJugt7F3FUy3cXzrTspHieq1rCtoXoFXBF7iMy5uCfmxqndpR6DL1WiFcBP9RUVTiCKSUlbRpgVH+wLlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=St8yKRCcGBJayIb+IcqCdqxTeeKl33AW5lv/LMUvTOg=;
 b=nnBpMReNlvHE4WHdmxiynPQTfr37X/eM/yvyETZCGBcBohy85AmWOQ1Wr1r2qCwUMrzX9RYzIp1bbGCtcXl2mGGCXfSbOZWh7lwFnqA9AM5LfYbXAjjA03z+XTKZeGMKK8TnWRiidjNF6D73SJZhBG4DPSwQYG+JE+vjNSjAmT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV1PR04MB10426.eurprd04.prod.outlook.com (2603:10a6:150:1cc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 10:27:02 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9846.017; Fri, 24 Apr 2026
 10:27:00 +0000
Message-ID: <6976ce0c-ce97-4adf-bb6c-c75c89a7e674@cherry.de>
Date: Fri, 24 Apr 2026 12:26:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wic] add basic b4 config file
To: Quentin Schulz <foss+yocto@0leil.net>,
 yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com
References: <20260424-b4-v1-1-04ede4cc261f@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260424-b4-v1-1-04ede4cc261f@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI1P195CA0055.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::44) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV1PR04MB10426:EE_
X-MS-Office365-Filtering-Correlation-Id: 086b05bc-b208-4460-75f0-08dea1ec052a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	Dv/5MSBIyBniMZcHp2vL6U/vZ6H6furhNT7T80AcovQeNdcBfIZX19OoHfUTY77G5NfgMUqXS0sFsrgxMVNasP+kR9g9p66NPpYWxVCcyj58ZxqriRAcC/yEt/uc5Aia9HozH9eDWCjf3Wgvxfi6QZe38YzsbXwU9Q13WZ9Nsca+KHiqGAYsgRDmwd8FMn+kzlyFDp7Ks/LtLi/m21847nalOEUcPJ0zG4IHV6KT+3IAsTQVLdHdnBgVHlZyTwYedkLY7aoOo9ef1NRvgyVSTYlrrNKefosA2hSrPmVyZuXL8pIBrVGQG9vWpSpCAtF3+JU330AkzFvnWA/CpcwLd26AdjSjOv4u73WMhOGj1tOYGo6XviZCtZpshevnpI6jroLAPcwpr9Kn56uxR9bfX+Mr/0KLqwUudYp5VtXO81uxSiiq5pZz2SH42mNWRw87xQm4TLqzeMIzX8NjIciDMpglk3Tz+YVZ94lB+zmv3hbQCeIXTJTFqigaBlRYIzUs/uHtQZJFsjDEw1JgpfzQmCKe9LWXdRWR0u2sx7iPDDyS/RX/AA/aH07w05BoI8jefytg/Wn+hrKaqmfsvbE7pu+hUWAPglkGa+5hinSSRseqskJqdv1lA4kY4McCsJgWVEcHzbEvHrWXpDTNKNQF81tUGjx7sbatD71tVrQxS9EsafRWl7tmo/4//I71DqiG
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NFdhYmo2amdEQmxRaEs0SDhOYVBBeUZjOXhCV0E5RUs2YXdDcE9MdTRXbVJh?=
 =?utf-8?B?MlZUZzdRalFzcWZuYVJwajk3cUlpT0pzcVE5a09FcUZURW5qbzNOM2pEVnc1?=
 =?utf-8?B?ajVoeElUZnlEWjRXRmFrZ0EyazV2ZzFyU1lyd2tsem9GUEpRcExGajVMYisw?=
 =?utf-8?B?dlh1V1QxUW9XcW5QRmhoOWwxdlU4TDRDelovNEhad0cySVhHa0k4RHlGYnZC?=
 =?utf-8?B?dnhmMXJKL1FRMlJzbXpmQXBWL1lYMmVCcEJyRGVkZWJoUmFTN29tVnBXTTNW?=
 =?utf-8?B?eGdsYThXM3pIa05nWGZQNzNzNWRNK0huYmQ5WHRWY0t5Y3F4ckhTaGx0SlNj?=
 =?utf-8?B?R0FOUUdnSXVRWWdRNFBHYnJWQzdPdHNaQ25QejZzNGRMeFZZSmxkNk40Z2VH?=
 =?utf-8?B?U25PLzNUaVhaWnJKWmhMWG84ditLMnMxc01vYzhUclVnbEhLK21pOXJhQ3Iz?=
 =?utf-8?B?dklLYmJSbTV0RFhWQUJsVHhwUG9MWlUwT1dVWTRmSGxld1FnSlJFUGpsN011?=
 =?utf-8?B?M3NrME5sSGJ0RGRxMlU5cklTMG5DcTljajMwS0t0UkQ5VElsL1pJZDl3Vkpr?=
 =?utf-8?B?QkR1ZmpuM3F4cHdCTzYrSXBTMGNVWUp4cUZLaGsyN0tIenFFQ0pUNk1pNDZI?=
 =?utf-8?B?Y2xPMTh1T05nazVXcUlNanF2NGNtci9sWndjMXk5TjFIeE4xdUVpQTBoYmRN?=
 =?utf-8?B?UE42a3QrNjhESEdKd25WYVpHSXdUNTV1V0VHNm5GUUN4SDJYMW5yMEVBVi9C?=
 =?utf-8?B?b2Y1VXR1Q3hjLzdtbWEyb0tkWktOQlA5bko0TGd3aW5zYXVsOWJGMU9yeE5I?=
 =?utf-8?B?VlJpb014b2RBUm8vRmtEUTdMNk9BdUppVllJTFpjeUxTQkNyWHBKUDlXVmow?=
 =?utf-8?B?blRHT0FZWWdHaHpTeDRWY2lieGNKbjZKbi9pOXFNczE4dEtaaG43VGxTSEp4?=
 =?utf-8?B?eFdiYnZZOUYrM1U2Tk5jeC9GdXF5WDFsQ1ZIZTdTVmdmV0hvNXljeTdVYis2?=
 =?utf-8?B?RGZ0aXJPZjVLa04rT2VnNm15NTNncGZZaUs3TVdIWU12TEtJNm9NV0NPclRC?=
 =?utf-8?B?UHJqeUxicTVvQU1mWjZCbjZkWmhKTDlVSW10cmZiajIrMUxGZG9XOFVlSmU3?=
 =?utf-8?B?OGRlOC9BaWVvZlArZEJrYlNoWDFvb2dNcjlUblpHOHJWbVFRczh6MEhOTzZI?=
 =?utf-8?B?Wk5mTHlmVlQ4cGFjRWowTUhod0NmblYydHM3dG55NEVTNEJNWkxiNGFZM3h2?=
 =?utf-8?B?OEt1K091NDBDQ1FGWGUzcFdTUEVmOHlVN2NSWWMwaGs2eGFJay8ycjVzc091?=
 =?utf-8?B?MC93bWlNcENya29wMjlxS2E2bkxjVVBSbE01T1hTaUZyUGF0azhTNXlMam1U?=
 =?utf-8?B?SjRnQUlaVUtscDVaYWJLZTR5aXBjdForMG5hWVVqa0w2Q0RZRG1qZE04VjRM?=
 =?utf-8?B?V3k0dWhzQU1KNWlSMWxiTTdoNW5VeU03MGJQZWpqNk5sNytVbUdGNEp5Y2Zt?=
 =?utf-8?B?VVo5b0dOOHBMNDJKVHBtUStHREpkZFBGUE1ySmlRc2VMQ0w2cHBiZUIybThZ?=
 =?utf-8?B?OUlJeXlkWGJjTVFjNDJHR3R3bEZnZmN3RGRCems1UWhjUGxaNVU0Ym1ORGJ6?=
 =?utf-8?B?cGp4UUxKR0hoTWdXVHAyZkY1RnFPT3FCakduOEhXZXNiY0ZTY1Z1Rk9xZ1RQ?=
 =?utf-8?B?SHh5VEpHbFloZngyR0txTmduRC9tbDE4L2NybFZnOXpzdFJSa3RWd2Z5SzRp?=
 =?utf-8?B?Rk5ubEx6clIxdFJCQ2hBUDZpOXdmemdpSzlWR0d5UzMxS3NaalN0c3k2V1U4?=
 =?utf-8?B?Y1BnR3BhMVFUOGhqVCsxVkRmSW51M21vMW1UMWhGZDZVSHFzcDVyb1NNV0FQ?=
 =?utf-8?B?SFBZaW96MUpDMllsUEFMNEU5YTFaVGhrQ2t4UGpzdXJFZ0lYSVEzU0VjYkZM?=
 =?utf-8?B?NGJldU1tV0xKSGlLc3hRa1Y2My9WZFNQVXp5TVMvYXVHcWpNN2FHSlpuNHlx?=
 =?utf-8?B?NlRDV2lWa05BSjU4L0w5Tjh1dDU2UTZIWVNYbkFRY1h3ZVFuODVrUTlwcHRK?=
 =?utf-8?B?dzlSdy8vUDAxKzBTa0Fwd2JwampXazR3UkdCZUpBSGhTbzBmUzV2akFzdUVE?=
 =?utf-8?B?YjdzWTNlUHVmeVVCMHRZQ21LcHo3OU1jRitYM0tCZHdFMzl2RzhjNGhFeXdx?=
 =?utf-8?B?WVlwYkJ1NUVXZjdPcUtOdlYrZHQrdE1PNWVHK2RyVWhiV3BJYmkxYmxVMkNM?=
 =?utf-8?B?K2dzNk5CdWgwcWhHd3VvT3IxZWRFa0JsZU1mNXVSSjBaeE1VZEdrWlJsU1JY?=
 =?utf-8?B?M29sdURJRzhIY09hV0pQWnlUeE1BckczREFCQVNJYmlnRUY1Sk1majc0QkNJ?=
 =?utf-8?Q?bHGZiifHSUKe/pSm8SvbxZ8fuug33QhoVD+ld?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 086b05bc-b208-4460-75f0-08dea1ec052a
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 10:27:00.5791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MaO9fSA7l1r712w5oi12fbgs9c3MMKmH6Z+WaqnUALJ0fVjBue96lUssvtniy0ml/Qtxfjr6gsqvQRAtPdPCJCGDnMybLiLlDBFhZlwpx24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10426
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 10:27:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3788

OK so this is very confusing. The default branch in cgit is 
origin/feature/no-create and I got my info from the README.md there, 
which differs from the README.md from instructions in the README.md in 
the master branch where it isn't requested to Cc Trevor.

On 4/24/26 12:18 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> b4[1] is a very nice tool for mail-based contribution. A config[2] file
> exists to set up a few defaults. We can use it to set the To recipients
> to always add, in our case the mailing list, and the Cc recipients, in
> our case, Trevor's address.
> 
> Additionally, automatically provide a default prefix so that one doesn't
> need to not forget to run `b4 prep --set-prefixes wic` for each series.
> 
> [1] https://pypi.org/project/b4/
> [2] https://b4.docs.kernel.org/en/latest/config.html
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   .b4-config | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/.b4-config b/.b4-config
> new file mode 100644
> index 0000000..dc2b2ab
> --- /dev/null
> +++ b/.b4-config
> @@ -0,0 +1,4 @@
> +[b4]
> +  send-series-to = yocto-patches@lists.yoctoproject.org
> +  send-series-cc = twoerner@gmail.com
> +  send-prefixes = wic
> 
> ---
> base-commit: 5974ade11032f218841d9f449ef0efeee3f9a2ca
> change-id: 20260424-b4-0ee9ab75fa75
> 
> Best regards,
> --
> Quentin Schulz <quentin.schulz@cherry.de>
> 


