Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2389C531DC
	for <webhook@archiver.kernel.org>; Tue, 20 Aug 2024 13:48:31 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.43])
 by mx.groups.io with SMTP id smtpd.web10.19773.1724161709710417013
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Aug 2024 06:48:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=iiDzDet2;
 spf=pass (domain: cherry.de, ip: 40.107.105.43, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGVTAgDD9/P7auL5SzgC1qmMzRzCAfGtvBOvIMEs7aXt8L/Zn7gpRAOMPbsm6vY8JujdWmQ7+mgtACU+dHlI76JvXrMOSvOOrWYwAXa6ac6GKL3X0zFU/TLRhKIspNy72dblUjMvmh21YajXwsqVKQzzAbHUvCMnix619/WNBHuv9sl0fJO/huDsyyTI+Sz4EGOZsKifgV2N3aSLoM7+Vw5y7NJ/HEdlXwLU34YCr0ywfqcsEbABtJD0DXsH/LEZvJK1FDeKyxZiqWfq7z3QnSJl64/a91huJnWbF1Q0ZVAoLimbDoXbi1/zN3GI/AZbQh0/FnTWulAwijti6kyBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvGKUcwYrfVGuu8+R30knIpaRx+0T06zXine0vugNh8=;
 b=LnNM36ffzAmcnspWE0mlTS+qtCKA+XBH01AePjWd9JiZbR0JMF0+jxuSxWLM4Sn6aQ+RZU3/xRMqIXPLNyUTlIqNx6S2MVNivxT+e2JWuIradhFfInVNackDx8rB51yTrnxedtYQEcQQo6r14TJuW+lZq02iVHCmqqC1H4t2iMulZMHOXexeJyWe2MMzeh9E5msuCFubUh8AS8q9gpFslbgARPofShXnzDP3tieL0INlTOdgSZ4cg1eSJFCGJ2d67X6kWM6284cJlmSU940GXZePm02vjdp8bW1fp8QgLwxU6bYpBxm9zDurnppdH7FMjRq8pntBDd+nQgJtWUOhZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvGKUcwYrfVGuu8+R30knIpaRx+0T06zXine0vugNh8=;
 b=iiDzDet2kThU5MBFRn3VeYwteSFma5YFPrvmUKNj9zjVyWReUzr6HCq4g6heSP/yqpg2mfhjN5A6o3tstbbJaHBiX0/fwMrUkeZftqYQOaz+Ss0YJyPEQx9+fgaqDLWjq62T2kPG+tfoUo/vztjInBFB0Wfb6+SNxuQZJhpq/vE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DUZPR04MB9900.eurprd04.prod.outlook.com (2603:10a6:10:4da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 13:48:18 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 13:48:18 +0000
Message-ID: <b6d2f95b-ebb8-436a-8644-fb63f8126c56@cherry.de>
Date: Tue, 20 Aug 2024 15:48:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-rockchip PATCH 3/9] rk3399: enable gstreamer v4l2codecs
 support
To: Quentin Schulz <foss+yocto@0leil.net>,
 yocto-patches@lists.yoctoproject.org
References: <20240820-gst-hantro-v1-0-335c4eaf8e8b@cherry.de>
 <20240820-gst-hantro-v1-3-335c4eaf8e8b@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240820-gst-hantro-v1-3-335c4eaf8e8b@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DUZPR04MB9900:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f87a291-8d14-4b6f-9d3e-08dcc11ebee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?alI2Rmg2aWRvNjltV05pQlpPY3BjeFFtRFpMNGU1NkxTdmFXMWJPcjJBb0tB?=
 =?utf-8?B?Ry81NmM1THFFRldsamkxKzNVbDFSWUpxdGloMmRvUnRPdlZqZjFPWFBXWXFt?=
 =?utf-8?B?czAzNUVMMnNhSkx4ci82S2JpR0E0aE1hSERtU1IzaWZyUHZkZVUvRW9mam5J?=
 =?utf-8?B?SllGU2V3L3ladFd2K0dKbWloMERMNWxGSCszeGRucUZJeG41SkpqODJ0MXNF?=
 =?utf-8?B?b1dJcVYwdjhHUEF1NU4wSUdNWXJBKzYzaFRuVGNTZEMvVVdXVlMwTmpaZVpE?=
 =?utf-8?B?OG5ZSTBvQUFLSVEzWDZNc3Fmay9lWDBwUTRFUnQ1WlhTVjlHUDUrd0w2QkZ5?=
 =?utf-8?B?QXoxYzBxcVBXSkZTak9ETGQ2dktoQm8xcDJZcVRSaXhLS3BGQ2pRcVUzVXRY?=
 =?utf-8?B?MnNHbDJvNEtFNTVDWGhDa0JRQzJaMzNuNE9WYXkzc3RKV1A4Tlhpd0l0NEp2?=
 =?utf-8?B?bldadnRGbEVVbVJoMWhUMzQrdVhmTmVRRUUrMzg1ZzZyOFJyOXZCZ1JCaDUz?=
 =?utf-8?B?SlZ1d1F6dzFsTEtWanY2cnJOVmQ1eWdpRCtLb3IrUU96SHRReHdEMVJrSzcz?=
 =?utf-8?B?eUhyajlVaTdPcVNUNVIzRytEM1dEeWhXTCs5WWNwUWNaQ2dMdiswZG5iQm5M?=
 =?utf-8?B?QzdXQkRLWmhUUEJpaDFLNWVBTGNWUHVac282VVkvTEMvdmNGaTlQRUtQL0tN?=
 =?utf-8?B?RXRoTmRqbTRBMjhOWGt6aDhLbnhGa2V1V1lmQUJwQURwV2ZIeFpCcXVBdHpk?=
 =?utf-8?B?cUFUUFc1Qlk0ejBETVpKZzNwMHd1MWlwYTUzNG9IMVhmTW5Kb2FJbHBSeHFF?=
 =?utf-8?B?M3pWV2FLME5SZlRXSkdiSmx5TFEyQnV3a2dTV1hHS3N6azNQanRhOWhhU2dH?=
 =?utf-8?B?a1NSank0L1d2STNLMzh2clBWbmttUktEaUhzbTVVbWVyOUpoNGx0RmV0VjhP?=
 =?utf-8?B?aXpVV2ZlalkrdVAwTm1GT0RSTHJON2FjbXpleFd4dzg3MlpTSjlZSVI1SmJE?=
 =?utf-8?B?eFJ1d1ZNdDJqeXlvcGM0SDZFdFdWN2o2aWRKWVpPSCs3OCtSZHJlc2M0Rng2?=
 =?utf-8?B?anhRbkcrYSt1UkdrS3Ywc0x4cUpPUFlGejAzVHRoV3h2bzhPUEg4YmZWTGFE?=
 =?utf-8?B?MzErbzlqQmU5WDZtOHJpcEppWjR5OXRLa1Rwd0dGVWZTZjl0UitqdDJpUVJX?=
 =?utf-8?B?WFBDNmprcW9LV0ZONnoxcDdOcnI1U0dYbjV1SFBGbTlOZFBEY1FWTkI1d2NP?=
 =?utf-8?B?cFBWdkhORlNnbURBQzJ0dVdIR2NsN0VVbk05SVdJaTBjcmc4QjR6M2N4VWZM?=
 =?utf-8?B?Ny8rL0tLdXBkNCtTOTNqd1ZuYWlnV0x1S0FMSWdxdmlFdlA4Zmp6M0xaczBh?=
 =?utf-8?B?Z2E2bHBMdUh0UFRWQjcxMUZ3a1E1cVcveFc1RjBCWEdxTjllNFFCU3NxSFB5?=
 =?utf-8?B?ZXloSlpCNTZJbWJiYmZvaVA1emNvRXJhQVV0T3BMRm1EdDI5cGovRjJjSWJv?=
 =?utf-8?B?eHVnOWkyaVcwOHFLZWUwSng1anZNKzIwMjR1QXUxUGpqaTFsTnkzam50Z0hp?=
 =?utf-8?B?TE02cVkvK1llU3U3RDkycUs2cjNiN1czZ0xXcGRKdnROWEc1TzNCRXJpcERj?=
 =?utf-8?B?QTJjUUZDbXo2VVpySFRjaGZ1MWZqdWYyNUNiTUdiU2wxbzJNQllmdFFnb1NN?=
 =?utf-8?B?WEZac1NWaWhNczQ2d2I5NEppcFdrNlJrbFh2ZnY3MGhZSG1LdlBwbHMvUkt1?=
 =?utf-8?B?Rk5KNDVPSWFwUTY4RVBmMEhmT29hL1VtRm5BMFlvd2xnbnNlakFpL28xY1U5?=
 =?utf-8?B?MUdobDR0R0U1MXJieVZOdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TU1OMzQrOFgxWDBCbkxCMHpGclVZMFA1Vm1BaXAxYTE4K1BPVXRZYytpdzdI?=
 =?utf-8?B?Z1Q1dEMzZFJXbDd6dWVFVktKS1FoR3ZTQkV6d2lGYWdGMnRNai9EMzhVR2k1?=
 =?utf-8?B?SXhUWHE3WXpsUnRPbm1yWGNwNVUvUjcrWDdaK0R4UnAvU1JJekMyQzFEVFhw?=
 =?utf-8?B?QXd6a2xZL2JoWm5rcHFsWjBjNzVTdTdlUkc4cFpNcnRUcm9yejh0M3ptS1Q2?=
 =?utf-8?B?b1E3VEc3SDBnMVNiTjdUYUdjQVcwSzBqYWNINWRBVU16RnM5YkZCWlJvaDJu?=
 =?utf-8?B?K2NLdTRQTDJ6TXZvVXdWMi9DbmRtMm1UK2s5Z1cxVE5NOG1saHBkTGoyaGpK?=
 =?utf-8?B?MXBaV0Z6c0JRdTlzYVN2Y1lTZGp6bXFkTDBZMHpGMEtrZ09ROW5DTitHcjEy?=
 =?utf-8?B?WFIxdFordzF6cmJWV3dzVk5ScXJXRld0QlFSR0lzVUpYSGNVTlFUd1I5cURZ?=
 =?utf-8?B?aFcrOTAwNUpQcU1uNFpnQ0ZSc0VnV3NGQzcyc1lmbGI2NG80S0xsanRQVDZ0?=
 =?utf-8?B?Y0tqUzVqanhjODlLbWtGMGU5dUJqOEM1bXUxZjY5ZXB5emxRZDdOa0d2bTJo?=
 =?utf-8?B?YU43aGRIdnVETGV4K3lTcGMyVmpMWGR3RUUxM2ZwRFlsV0NEVGN3cTFXMzJQ?=
 =?utf-8?B?MHFBU0kycTZPWitXUXFjdS8wYUZaR29RTVZuNnQyU1dTZXFDWWhBSmNFSjhC?=
 =?utf-8?B?K29zNDJoZnhla0pwd1FqcHhhWnRLZ0NqdHlwZFl4bU13TGIzMTUxd3Q2bk9L?=
 =?utf-8?B?S2Y4S1FndFIycXF2bXY0OEcyOXVmS1NkUXNmUEptczhQRUdUZ2xnd0xSTVhH?=
 =?utf-8?B?bSsyaXJhLzZHNDl2eDZQb2Z3dG5oYXBUa256N2NqS2EyRkdhTUptS1dmdFZ6?=
 =?utf-8?B?TVJpOVpjZmx6Y3o1dWptN1pyWXRRbVFPTXZ2Qnp0NnU4UFRQTTEybktJUUtZ?=
 =?utf-8?B?UXBlVEtSVTQzQzVBbmV2dkVtZUNwUjJ0TTUxVFh4VVNkeXdZdlI1aGwwRytZ?=
 =?utf-8?B?b3M4RW56elUwMTVnRHgrRUxBbzIxTEJDS3NPTk80aDJ5ejlwV0pOVUtyYW9Z?=
 =?utf-8?B?VGMvQnNRYTF4bmkvMkNrbWZUNUNuaDN3WTBDZG1lOFpEeE95ZVRSZHlEMXhn?=
 =?utf-8?B?c1FWS0VEZE8wblRyd2hPUTBJZkFZYmVFeENhdTMwQkhicjJUSXlBSDhHNFJQ?=
 =?utf-8?B?RGxPZFpRSjlWT2t2dzI4eGtXTEhHbURnZHVrakpsS2xpdkFWWkYxWFA2K0FL?=
 =?utf-8?B?ODJQQUJkOGkwOFVvZzhRcFF2NWdRcGE2UUJLb1lyam1FaFRXS1cxdS8vNnhO?=
 =?utf-8?B?VHRyU1J3YzlrcTdrd04xV01KLzJkWktDajFOMElPZ0ZUMDZEaTFtanREL3F3?=
 =?utf-8?B?ejFvaUE5K2hSbVpERTE5ait4MWZWRDd5WnZVK0RXejl3bHllRmhmY3hEc0tR?=
 =?utf-8?B?dnBuY29uKzFmS284bWhLVFpLOWtEZVVnMWxLcjU3WlNUNVhzR0NjTjhUZHVQ?=
 =?utf-8?B?UzNUNERsNUZCajh3RHdOUXdTaWYrUUt6RmoxdC9tbGZWN3lHNlVjK3drMVZC?=
 =?utf-8?B?TzVWdTF6K2c1cWlSUFM1aUtkMWhyM3IvTk01M1BYOUpwMzQ3K2FzYXVTNDBC?=
 =?utf-8?B?ZzZlK3dzenVRcXJUUk8rTmNtcit2ZUJXbFpkMWlzZnNqUjQyRVJFR2QrdVla?=
 =?utf-8?B?VUF3S2ZQQmJyalY1b1A2cFhZRkgxTG5nVEliRzNvWkRFMEQ0TkJpQ2JLaHJk?=
 =?utf-8?B?cWVOZzBCN1pYZmtjQUljWXhkYzRtNDJlOXh2bTFvaVRUUzlBNjlEUnpGQTQw?=
 =?utf-8?B?RGpSQVJxS1dGbDVJRHQvZ0QwVjlrTTdIdmIva3BCbXZwamR6Mk5aeFRTYWFL?=
 =?utf-8?B?MzdCVmRpemlRcWgwNkNHQ3gvY0w3ditZOEt2Sk5kcVdxUWExd3FhLzREdEp4?=
 =?utf-8?B?ZzQwZ1UxMUoxSHZLeHMvNmxkeGNGMVhLRnpWR05XakRZREUwZGJKeVBmRlY3?=
 =?utf-8?B?YmxCWk1YZDZGNHB6Y3VnQmh3UHBsNHVVY1JUdmRwMnZEaDMwdTVYaHd3cG80?=
 =?utf-8?B?ZDFacGtLTmc2ZXZ1TmRKOW9KMHBCQmsvdCsveFgzWGJydGNkUEtqZVE1V3l0?=
 =?utf-8?B?dENuNTcwa3FoMnl2WldnR1VuQkJqZGp3anhXN3pRbHhqenlHRzJUT1ZGTk16?=
 =?utf-8?B?WkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f87a291-8d14-4b6f-9d3e-08dcc11ebee1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 13:48:18.0748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FViI4Ux2LN8mDJWSoHnTKYSnISXWs2baW6R0opQ7+i1Ct+doSWtuW0EqRa+Z0x872JdAuBr5t41RuPZLc/TPjEaYbUdAXopSxv67fJjReh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9900
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 20 Aug 2024 13:48:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/535



On 8/20/24 2:56 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> RK3399 has a Hantro VPU, so let's set HAS_HANTRO so that gstreamer
> v4l2codecs plugin can be built.
> 

RK3399 actually also has an RKVDEC VPU which is used for decoding H.264, 
VP9 and H.265. Currently, rkvdec supports H.264 and VP9 decoding, while 
Hantro supports VP8 and MPEG2 decoding as well as JPEG encoding. 
Therefore, I'm not sure the naming of the variable is proper? Should we 
go for HAS_STATELESS_VPU instead?

Cheers,
Quentin

