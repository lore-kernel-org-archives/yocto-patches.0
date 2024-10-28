Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40918D33989
	for <webhook@archiver.kernel.org>; Mon, 28 Oct 2024 14:10:41 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.88])
 by mx.groups.io with SMTP id smtpd.web10.52769.1730124633717978949
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 28 Oct 2024 07:10:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=b1iwez/f;
 spf=pass (domain: cherry.de, ip: 40.107.105.88, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0ja3UBzHaBtSQK13VOIDLpOmXrl4KurJwUrEwDuj8gbVqSTkK7fohU8NbzNMtl396tfbjAyX60e+9b895wov2wkZNF+SBVX760YF57cuBDjAmO0jlLwWJT42VO6ljxHcHZXw+txSvJt0HM2yxXcHDJtm+LrnO3mDIpw2AivI7cjR75vd5NkrCWv7CZs4pwOKLfiwbSKEKP0I6VKL96muwWtVcBpaFnwbVbE6rgiEqcxhUyPyMtqS1fC7U9mKeKyfUCl4nGoJMm9J4bqzUP5IE8Az+kwcaqJNG9774EaKUiwHnokD0RhY4z03wxnzjZftitnrIPBhPRpsEjTCg4+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8eeWTCFc+ogN91jXWcGxxCL1dnKbeO6lRaEa2L8HHc=;
 b=m4U7fFbmJldnZYKPZGqpHWTVJAYy4cICgBZOaj//59fR30WbNNgOjUvsRNX55Zq9QK4pskGcuv7XML1b+SoT8egGauQiFqzT12z6PUIVNR81LpBeJEGUawto3/c1EsyuGogIIJQobHVhaR2XOQfvHpoxkPDmG5WG2/VhhQxZ/OERQmjJ3xpuph356g7J4YOGbGGyueaErEvHzUu2VJ4fKDGs3f0zyBLAzPH1Xor6tOBIaYuxQX+2Tv0M6IbJFjep5CUhz0CtMmvcnifJOUoYyQNJtAs9wBeRzfCj3bqsWSvm+PA7/LWSnIWpxC6JRuODe2LrjWDhVSGEKF5OS7o15Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8eeWTCFc+ogN91jXWcGxxCL1dnKbeO6lRaEa2L8HHc=;
 b=b1iwez/f8X2YT+9c7bQr6AuHHVjOHJiB77FVzLn77CDgQpvF2KAsNnc5dkzBAX5DFAR7XQE5ziyJ0YV0Wu7AXqulair5cp/61ZbWLWLDURyvR4nMoPl7afCIIpiBffQNdMObLp7Ru1kHSN6I7P3E7aM/2kui1p6OOSCEEXB+gDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB9235.eurprd04.prod.outlook.com (2603:10a6:10:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Mon, 28 Oct
 2024 14:10:29 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8093.025; Mon, 28 Oct 2024
 14:10:29 +0000
Message-ID: <2c055b48-6dc4-40b9-a269-7353963b3f70@cherry.de>
Date: Mon, 28 Oct 2024 15:10:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-rockchip PATCH 0/2] rk35xx: add support for upstream TF-A
To: Quentin Schulz <foss+yocto@0leil.net>,
 yocto-patches@lists.yoctoproject.org
References: <20240927-rk35-upstream-tf-a-v1-0-e3911342113f@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240927-rk35-upstream-tf-a-v1-0-e3911342113f@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB9235:EE_
X-MS-Office365-Filtering-Correlation-Id: cc663d2d-7771-4d04-ef80-08dcf75a471c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cGtqa0x2cllzUHdoUjJ4aVF1V3Z6eXhCaXBHYmxNc0FweVYzY1dzZXQyanh4?=
 =?utf-8?B?S2cyRUZwTndhQmtGN01aUURxSFA1YlNHQ1BoN1lWeHVOODNRcGhHVGFyVXVS?=
 =?utf-8?B?MnhoR2pHbVZqSlJRa3VSSGFCUVl3bGhOOU8xbC82VTdNdUJOM3UvcWJaYkd2?=
 =?utf-8?B?UjVQRXA5NmtpOVlFdkp2V1IzdUhLcDR2NWtqY2FHK3VsRG0wU0QzWHpla3I1?=
 =?utf-8?B?OWhWVHc0NFY0RTFuTG9hTWswOGZsRmVid0VxbGFzK2F5R1BkODNhSDNWNk5t?=
 =?utf-8?B?b01qZmpGM2Q3dWlXYnFwK253Z3d5SnRCZDNqUFJFMzZESHJrQXAyb2FIN2tL?=
 =?utf-8?B?cUYySk9jRE5wRDlyZU9hclh0WklmOTNpaDF2MVhPdk1CTjFwQjJoRzE5Y2lX?=
 =?utf-8?B?ekE0NktvWHNQNzVLc3pyTHNTWDdFb2ZrdEt4VWM5RGk3NFZicEZTWFNXRDdl?=
 =?utf-8?B?bGk0SHA2Mm50QVk5WThyQm9SWEYvZ0sxMjRLbjBRMFA3aWFRRkQxczAyQ3hC?=
 =?utf-8?B?bEZJWmdFZjZSSkxHMFh0OVJIaFNtRUJ4ek1WVkU0MDI5MmdmdHdGR0M4WUJu?=
 =?utf-8?B?TWZGZE1JcHdhcTc4UE1adG12enlncmpFMHdobGM1WVpLcXFhNTF3WmVMcnRw?=
 =?utf-8?B?dTJIWDNMaWZBYmhNQ3lyaGJ6a0t3YkdaOFdDek5weEJQL0daTSs1Unp4RlJI?=
 =?utf-8?B?cWJ4QzBjMm5VL3F5TGVEY3FzNkV3V2ZNc3VKYzhrQnNnL2Foc1daZU4zVzBy?=
 =?utf-8?B?NXRsdDd4ZHFyOWszYlIwaHVwZnEvK1ZmVWR1Z1lqcHo3VzhuK3JyUGtXVXNn?=
 =?utf-8?B?Ly9JNm00UEZpUG5tWi9ZM0F0V1JrZjhzNm43aDA1Z2orYjlCVk1yVU90RUNi?=
 =?utf-8?B?czFNZmk1QXdaM0grWnVKVGg0MjNGY2tpZ2M5Sy9uMFdWb3BqUFk5cUM0ejgy?=
 =?utf-8?B?T3R1eTloVTdPL3FUNlBFSlgwbE9IVmVqRGZiR1dtZU1hMFRESTVnME1ESEhC?=
 =?utf-8?B?ODdoRzJibVllWVcyWCtTMzBxTUtRNkcvWkUvazM1R3FLOWlZTTZDdTZ3LzhM?=
 =?utf-8?B?VEM5SzJOTFBzV1g3OUIzZHJxWkp1dFcvQStFNUpxdzAyYml3eGpMV2M0dWhC?=
 =?utf-8?B?WkEzelVjdUR0aFZxdUY5dkx1eWg0ditOUTdDL3NyWnlYcXJ2RE5mY3Zmb0Zo?=
 =?utf-8?B?aE15WmlpZlNOUHU5dDFFcGRpbk1Fd2FiaWtHTkUyNisxVFUwblByMEg3Y2FP?=
 =?utf-8?B?dWlJWjFtdkdnTHdzdzBhNUlvTzF6S2JiZEt3UUl2T2FVOEU5eDFENkNkQnpx?=
 =?utf-8?B?eG5yQW1paWRWWERSMys1clQ0cDJuTSsvR0ZKU2hqUVQrTDlPL1VVSnViNkkv?=
 =?utf-8?B?Vyt0Q3FMcndDUHdWVFJVRFNBaTN4ME5RbW0rV0c4c0pBY3BhQXlxZGkvS1oy?=
 =?utf-8?B?dTJBZS9sTEtVczBEWm5ra2VHTkYyZ1V4S0cweGVveHdtczlRaUQ2TE1iQk5h?=
 =?utf-8?B?SG04Yy9jWDRENkMxOWdIdUNvK1FsQkNDb3BINVlzb1QwSjArQUdjaVB6LzFE?=
 =?utf-8?B?ZjV6RTIwK1FLOWNtVVVZcms0RXV3SkVLSWJBcHk2N3VmZTJ3NkxFNjhjYVZk?=
 =?utf-8?B?bExKdjV5VzFONkgrOFZHTHBUV2hwV3lEb1BqWnF6bGZZdFU0aWIwblljUW5y?=
 =?utf-8?B?TDdsNnhYc0ZJWlRCa21HN0FOT3BRaVc5LzU1SFNDVzVMS2pvdFMrb2NyTy8y?=
 =?utf-8?Q?/VWJPCF8jhT+gEfl8ki439G5OQDs+F33JskZz5m?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M29IeHUzVGN4bHJpNVdDc0wyTnBudStEMDNTM09abmpqeFREVlc0dmt5VVgy?=
 =?utf-8?B?N3IyRmw4eFJEZWZIOCtiZGRYNHhGOGJjRDZVK21uWUVtK3JhcWVrckZVRU1a?=
 =?utf-8?B?ZEhuYkN2TWs2OEdHSUluZTRoOS9nL09qclFiTUw5VDNDZkw5Wm9CZDZMUTV3?=
 =?utf-8?B?dDlkNElENmdmVksrSkNJUi9vWUJxYnF1NmkxKzBuZ2hNTHpZQXFtUjU4TkhJ?=
 =?utf-8?B?TDdBRUhubC9QQW5ZTnE0L2FOa0ZhZ3BUM1RFVExNcUg3ZzcrQnRCY0dpNFFD?=
 =?utf-8?B?clMwTEVLanc5MUlSa2l3c2tSOWl1cUFNM3NuOUNFd3hsY1h1aU9EakQ4cFp2?=
 =?utf-8?B?eTZsS1lMQ0hBSGtDeUxhTXZublI4eWZleDdQckttS1pZeDRtbmpvUHhvckJU?=
 =?utf-8?B?NXNFeGErWGNFeTNtNEE0ZDRleTdVU2Q1dlBON3BUbyt0N1VobzVtck1yUVhZ?=
 =?utf-8?B?ODU3ckhmd0ZZdE54M1VnZlh5YzBBVTFzK0l1a3ZNWkZQVDRBVWFsU042VTJ2?=
 =?utf-8?B?N2pjSFdFR1pCZnRsbTQrWE9PN3c2RVVoRUNGNGZaZDY5R3JkZENYdGF5NFZY?=
 =?utf-8?B?b0R3dUl4V2JoVXNldkk3eXR0dUl0NHRMTVo3SllaQXdUdUtzVnA2dWQ3aUEv?=
 =?utf-8?B?S25vYzRUUFJIOTA4akpHMkNrU1owaERDZVdJK2NkRDAwZ3JzejVKTmlaWGVE?=
 =?utf-8?B?OW1yaVFIUDFabFFicHBEeVR1UkZ6d3o4czFRdGdqT0lEdFU2b3F6NzlxNm1a?=
 =?utf-8?B?N0VsSytjSEpoOVZMU2RLTXk2eWJhWkF4UjhJRDNnVzZSTC83WDBnalhURktW?=
 =?utf-8?B?VG9FRGtsZkZKSEx2QlRvQkVFMkFRN21QRGp3bytJd2t2aTRkOVZrQ1NpYnVX?=
 =?utf-8?B?Q041b21WWDY4T1E3SDdHQXpIeXhCelVNRjdqdjVwcFdIcjQ2QXVyR0ZGbWFU?=
 =?utf-8?B?RzBndWFxRExiSUJvSFB6SDBOektnRFdvUlBHWWduazk5OGJpT1FRbzZGMVpJ?=
 =?utf-8?B?aHpoU3V5Z0ZGK2pkOXVtZWRwNHlWOHdNWlBXVTdTVFBkd3BmRmkrK1dYOTdG?=
 =?utf-8?B?TDRCRVh5SUlvL3c3ditKVWoxcFd1YlYxbnNUc2EyZ0dpeUdzOHYwQndQYVRO?=
 =?utf-8?B?SzlyWnpuS2cyUDBieEJxa0NQeGs0TGh1bERtdkNLQUdvYk9NUitJWFdFT0NY?=
 =?utf-8?B?ditacERLU1FsVGFIcVBuWW1POEg3dWtDOEIxV1BFMEhqaWNWVzZYSXNDNUpD?=
 =?utf-8?B?VDVxbnhuU3M1d1JGREtJc3ZoeHgrZGhoQTQ2ckNvbzhYWE1EK2U2b3QxM2pq?=
 =?utf-8?B?dmpiak1vRTdGcHRXemxyRk5kSk8rdDgwalZWSm1ZWnMzbC9YMU9SblZnNUNt?=
 =?utf-8?B?TjBMLy91STlrZ0U2RUU0dFN5SVJpd083V1Z4T2ZzQTh6YVk5VXlINVYvUGlR?=
 =?utf-8?B?VlMyY2xCeDkrbUZtUVVkSFdlTGV1akhhOHdlMDltM2hGRWZjdFRoc3IrOXBz?=
 =?utf-8?B?YTlKNnRCQ1BPL0RFZzcrbStQSDNWY2JEV2dSck1oamJCOStoL2dNbUdSajBa?=
 =?utf-8?B?NmFQbktiSEFJdVVOVG0rSGZHQ0Y5dlVVVjFORnRCTWxOcndtVk1Wd1dyV3Z0?=
 =?utf-8?B?aUNuZzlGbklJanVzTXowSk5FS0JRcHdpcDl0N2l1TU1RSDVFcFU4YXcwNzdx?=
 =?utf-8?B?RlpPQWxzdzkyMVUzbHp5TU96NlRGOFpPam81UFBEYzV1SVpRc1B3NHMzNCth?=
 =?utf-8?B?aFY5SnFYeVhxbFRTM1c1SkkxNW9GT2tIeWFKbTR1SEprNDl3V0dGcmVubEJr?=
 =?utf-8?B?Y0hKUTBZdGZhWWdCNGdnMm12RkRoeGkrRzZKVTc4RFZMaGUzakZWMTByem9D?=
 =?utf-8?B?bnBLV2RXTFpKUjkzQWgrTjZ1UXd2NnN6Zy9hZ1V2Mkg0dXc5QVk4OFkvNyt0?=
 =?utf-8?B?MnZKRm1uaVZhRk9TbUtibFkxb2lmT1ArSjdReGJybDlIazNLcHFYYm9jYjdT?=
 =?utf-8?B?L2xwcGpGQUhDTzdXblUyUGVTLzNUN2JzbWo1cWFBV2VXWHJSVGlncnE1VU9D?=
 =?utf-8?B?WSszS3J1SGZDYmd6UlRlbEFNVWhaRDF2eVpYYWl5aWp4ckVYSkJhNTBQSkdT?=
 =?utf-8?B?NlIwbkdPdXNYeTRUVlFKYTdQVnI1S0pvWTNOTlRmSWVXRzdXcHNhSkVkNlVO?=
 =?utf-8?B?Znc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cc663d2d-7771-4d04-ef80-08dcf75a471c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:10:29.3313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnZXdueakkuwjOAxsx1PfVM9pWnPqTuDLGQSrZjI3aAZ7KZ+pxgE/F1mi/F1raEO9Pa5hrz/p2tI9ouPEFbtIOqcQ5S04ABIBAI/Qw3njMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9235
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 28 Oct 2024 14:10:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/766

Hi Trevor,

Gentle ping to make sure this does get forgotten :)

Anything I can do to make the review easier for you?

Cheers,
Quentin

On 9/27/24 2:59 PM, Quentin Schulz wrote:
> Upstream TF-A (> 2.11; no release yet) has gained initial support for
> the RK356x and RK3588 so one may be interested in using it.
> 
> The default still is to use the downstream blob but the option is now
> given to the user who can simply change the value of
> PREFERRED_PROVIDER_trusted-firmware-a in their own configuration file in
> order to use upstream TF-A.
> 
> This depends on two different patch series that have yet to be merged:
> - https://lore.kernel.org/yocto-patches/20240927-rkbin-split-recipes-v1-0-0f4a9b0cbf56@cherry.de/
>    for meta-rockchip
> - https://lore.kernel.org/yocto-meta-arm/20240927-tf-a-master-v1-1-733c925c80e4@cherry.de/
>    for meta-arm
> 
> Only the RK3588 support was build and boot tested as I don't own any
> RK356x board.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Quentin Schulz (2):
>        rk356x: add support for upstream TF-A
>        rk3588(s): add support for upstream TF-A
> 
>   conf/machine/include/rk3566.inc                    |  3 +++
>   conf/machine/include/rk3568.inc                    |  3 +++
>   conf/machine/include/rk3588s.inc                   |  3 +++
>   .../trusted-firmware-a_%.bbappend                  | 23 ++++++++++++++++++++++
>   4 files changed, 32 insertions(+)
> ---
> base-commit: 24a411a17f389650c4cea38bef1f9279117fab8e
> change-id: 20240927-rk35-upstream-tf-a-356760495fc1
> prerequisite-change-id: 20240927-rkbin-split-recipes-61503f078ab6:v1
> prerequisite-patch-id: 852459a4ef85dcfa74407f5455af93ac5e2ab3ee
> prerequisite-patch-id: 0ed848000063d5b8b9dbc02f63e09a199e90bd64
> prerequisite-patch-id: f665b620ee911de701142439dd00566dd12131d2
> 
> Best regards,


