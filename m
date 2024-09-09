Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBB5ECE579
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 16:01:45 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.67])
 by mx.groups.io with SMTP id smtpd.web11.57046.1725897697616513235
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Sep 2024 09:01:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=KZ5B4kY8;
 spf=pass (domain: cherry.de, ip: 40.107.247.67, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=likxGu5K/WT4dVnPlKK1m5+bDUOWg3PMxY+/jG7Gg7VtWGBDGe9DD+NcrIp3O26zC6+f1vdR26ErMrYAlBQLMrD38ShPl4X1SnkO1Z43SXZuUrP3a7anASSzM5bvcPRJaNl5O/tpPbKzOgRfL/i6M+vWMT3B4U97kgEWXqbfGK+nyoMJSQ7aeRu9N1H21ylGzxSeMgxaD8+ate7GZMvDyeNhmbw/QZ1WNdp++wiR7hmTx9RvrCo9GF46zvyeX3JpiXIDxTfwjqlQYoFEe7VzwsyhSdeIm4wXYGWks5Z9AKhby83lLadozyfOiOEGElN3UwcSU2FFgd+9dj9teAdHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeaEHDqdQEBeRiGYPZe+XdTn/fycBAUMs6CPqTSjAY4=;
 b=dDWWIBf6vYqne0IdW3+n7be/bMqmPWvAPNxgprdMGf/See6LLY9+i5t7I1zjRHVK5epdpQ0SQKt2k6nX6oEzZEdEbLCZrUTPThJZlWGXWHrbr89ytTaNM6hVvHnddn70q5z7m4Drgrxq/nu1Xc7k7EUgutHlis0Qwf72YCFZxaK3IW9nSEkv9t0Kyt3Eh5/xm05Nbicjd4aGZqs6IOe/eYgwqA/qxj3mOSNuWWR88MFNx1eMz/CaIDbab+C7k/EeJKEeLupjOkExMcBlLyZfJB5UaZMi10aj2T6eq7mrIOEeLC5yZoBrZ64n9g1juo95ENHyzk0Uy1RyWxSF9daXaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeaEHDqdQEBeRiGYPZe+XdTn/fycBAUMs6CPqTSjAY4=;
 b=KZ5B4kY8jNbduwfiAcITgt6O3npA77aoizCmfe9I60nU9UGdBPgVF0SUE4P5ueNS7h7wB5c/k+vWTjSL93Z810q1J1nfgmy0NIVQlz+9EqP8ObB1voBrjoKQmLHgLZcCJj0qnKe+LOdzFc4YfttY2FLbTP0vfhNhDOSpZHHk/Mg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by DBAPR04MB7382.eurprd04.prod.outlook.com (2603:10a6:10:1ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 16:01:32 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 16:01:32 +0000
Message-ID: <f900b17c-8b9b-454d-9339-25886e30f269@cherry.de>
Date: Mon, 9 Sep 2024 18:01:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][scarthgap][PATCH 09/10] enable HW
 VPU decoding for SoCs that have stateless VPUs
To: yocto-patches@lists.yoctoproject.org
References: <20240909145530.25301-1-twoerner@gmail.com>
 <20240909145530.25301-10-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240909145530.25301-10-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::28) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|DBAPR04MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: 535a73b1-79d7-45f2-b05e-08dcd0e8ac73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?T3JScnFXaFNuNTdMOVhISkQ4VFdaM1RHMU9UL25yc01xNGZIa0dqMWFlOVEv?=
 =?utf-8?B?RkFxZFdpUzhwbFRDZk1ERTUwMlRLVVJGTEZSajN0Zmx0YzlCYVBZMThYa0xw?=
 =?utf-8?B?dDJNQjNvMkpTTTROTDNDYzUzYkUyb0t2M0VzRjZTUTA2bVNScC9ENE5rOE84?=
 =?utf-8?B?bmRYQW9ZcTdIOVRKZ1dHTEhDTEZGdi80L2VEQVV4STlwUFhaNmpsZklSbDUv?=
 =?utf-8?B?eHlmdHJNTTBwVEVFZzRoeWlUT2VGSmk3Vlh4TUlVZytPZkVqZVFZUmNJWk9Q?=
 =?utf-8?B?bGp3d01GdWlWMmdYQkVtamFyNkJ4T3doUVptVUhic1hyYVhYa2JkV2RldGNs?=
 =?utf-8?B?eTdPaFVobGxHU3diWk5GaGI2Ym9Oa2ZmNHVBbkRsOXJzdzdTbUhzWUJRRE9D?=
 =?utf-8?B?a2ZlTzZOOUl6MzYzRDNoWXFYQm9UK2dmWTBLaElpUFYwcXlBRWpPWjJTZFJM?=
 =?utf-8?B?aStnby9kb2hHOWhiMFRRUWl2SGJuNEs5YWhsZFFTVlZQQXFQOWFxeTBFZVNV?=
 =?utf-8?B?VTNXVEZCOElRQ1B0MFhwd3NFQzRnUXEydWU1SHNSWCtRZ1E3UTY3YWQxRzhK?=
 =?utf-8?B?Z0w2eDJkbEtDcmt1YzY2anJFaXNzbVZPOXVGY1B5NkpVZmt3TmpXOHNBZEhG?=
 =?utf-8?B?THYvMjJWMGF5UU4rOTBvTlp1Ykh0L3Vhakk0Nmg1bG1kc3FoeG9Bc2Voa1lV?=
 =?utf-8?B?Nk91c3BHWXN0WEFYemFYbmhWd0tFQUhVYmhMWkFuSnlSbHVORG9pTHVvOVd4?=
 =?utf-8?B?amJtTVNIYWxPZEFEeldiRStRQVVsSDJZb29RdnE2UklNZHJEOEtjdmxnODBj?=
 =?utf-8?B?STc1ODllR0lyRCtmMWNmNG9DNTZCd3hVRDBmM0grTUxlZk4zMGFnV09rcDBi?=
 =?utf-8?B?NDl4YzBibjFEbmdkT2hBWTNCS2JMbW9CekJMYmcxcUZrRWNmdlpSdC9rS2c2?=
 =?utf-8?B?MlRXTkZrUWNXT0djdUlyeWxNMnlZVTE1SDZZY1pwM3JHWE9adFZmVDlQck1J?=
 =?utf-8?B?RjQ2QkFJN2llK2xHTkg4L3UzczZZb1RNSGJtRW0wSVlWVFAwSXkzaFExdDlh?=
 =?utf-8?B?dysyOE5nN3IxRVNxckhFT1RGVTVlV1JXL1h5YTdENjM5ZGx0djA5cFJJMVkw?=
 =?utf-8?B?ZVJUZ3Z4UDhyQkpLQ3JxKzNhekd2ZDVCOWJkVHphKy9rUkNYVDhZQm1lMGFr?=
 =?utf-8?B?eXlhUXFrY3ZHeWhrMzNVcmI0UUw0RFo2am1VS1ZTNno1TWluUTRPSVpxcVE2?=
 =?utf-8?B?NGlVdEpkY1ZBOU5odVoxbkVkY3p5SERHeHp3K29YdThPUGxFZFpIWXF0SVNt?=
 =?utf-8?B?TlE0d2hFNTViQTYxV09XS2J4QUo0cFpRbDR3NVFYUU1VeE91SW10c3hSZzY3?=
 =?utf-8?B?WHQvS3pXSml4YVJsOHVRd25WcnloME91Q2E0QmJSUVFQdmtwUGY4QlN0dHF5?=
 =?utf-8?B?VWxCbTYvc1NKWW5XQjJIRFlNNTBqUnlXVEM0UVBwU0M3RHFPSDhjZld1ek9m?=
 =?utf-8?B?VnpPaDQwVXhjMldJWW5XOGM3TXpqM0hLTkVlWWhzWUFPZnRGOSsvS05Najht?=
 =?utf-8?B?ZzBGcm5rVURCN2JkaTBxclY4Y0ZHYk8vcDA0K2pIRVR6alBKSHBZWkFYajZu?=
 =?utf-8?B?bDRTOGNUY0tFWnJBL0N0cHdZRi8yTEVrZWV4YjJwZUt0MEZ6RWxJNjF6SEZ4?=
 =?utf-8?B?VDZOVytFUG41RHp0Q09nSVo2UDNMK0ZaSkhlVVhYaW9oMVVVV0dRZG5MUWx1?=
 =?utf-8?Q?8hj2Fs2BSSiYunT/qc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b2tuWWFNY0lJVFZVUUdjYlhJQkNNSE5ZS0xKVXNDMnpobWtHenlwdE4ySDho?=
 =?utf-8?B?NkVxbVdyd1FyYnIxUVBqNFFIMVUrRDBvSXV2TkhrYU5aWC8yV0JPRFFzYXZ0?=
 =?utf-8?B?eXkwSEliYU1vL2w3bjVmSTA0K0ZXall6MTViVFFWRFZQZ3RmVitsRFF1L3po?=
 =?utf-8?B?blMzdUlhN1ZsN0I3NWRzV3JtZW1uQ1k5TkJoazhwOHFBNk1mekNpZmNTemds?=
 =?utf-8?B?YnJwRElPVWtQNStSNVZmdnhselhRRlNpamJVamVxVU4zRlhReXE0dTRUTjZC?=
 =?utf-8?B?RGJ0NzR1QjVMLzFHUWE1d3NrdVB2bG9VQWdyZXJGMzc1SEUvVExpam9BRTB5?=
 =?utf-8?B?K2Fnd2hqbnIwQjBndGZUYUFIdERWL09acmx0Yk43Mkc4Z1AzT0tkRFNad3dD?=
 =?utf-8?B?dXNBdG5IRjA1SmdhSjVQOStaaFFWQlFsZFFtS2QvSHBQVVNQSGZPMWtiZHF6?=
 =?utf-8?B?aXd1Q1ZTS2NPZGs0enh0enZ1UXcwRlRFZVg2RFZvc1VzZHZNMnZTSDduSVdk?=
 =?utf-8?B?Qm5UQ2Vnb1hwcXZQSlVSWGRVYXBrM0hnMlJZSFN0Mld3QVQ0QVEwK0ZnbTY5?=
 =?utf-8?B?cG55OWhScENlNHBscHA2UDk5QUhPbUJoK3lmZ1BPWS9QbnRtb0RZbUVXMUJF?=
 =?utf-8?B?VytlNmg0V1lwMG1xSGRTd0J1Q29kYjRsQ2xuL2Q4T25mczFkdmFnQ24zL1BT?=
 =?utf-8?B?TXRsYXJKWHVPQWVEaDlCRzJHUG9aaHV4VHBPZUJ0ZUVxTjE3Zmo3SWRRMWVW?=
 =?utf-8?B?NjNTTm9GaVRTdCt2RnUyNVJnNG1MUTIwVmRkcVYyV0RJcmdydXo3Ry9FZDZE?=
 =?utf-8?B?S3BWWFZaOGF1MFBONUxrYVJQbkMvQVFqMjZkc0VwaklxelZscFFWaStCS2h6?=
 =?utf-8?B?eFpqYk5DZWM4V0F5VTZmNERLMWFNMnFuYzREYSt5bUp3L0gwNHU0ZGVOWmZD?=
 =?utf-8?B?Ri9FSC9vZFZDWENGMXVaMUZERlo2MWFCQmtxeHdRSEhqS1VLRnBWMlRQWE1F?=
 =?utf-8?B?L1M5ZmpMcXFOSy9hR2d6bkJuSEp5RGMyK2JYaDVsb2swSkdGMHY1QWlxVjJ5?=
 =?utf-8?B?RGpkNjZNNUgwbEVTNzJic0lqMXdHN1JhN2NEckcvdTJNb0ZlbzNWQ2N3VmNm?=
 =?utf-8?B?dmdYQUtQSUxDbXhFODVGMWU2OFJscWhqU3FzYVhOcVhDczc5Sk5FNVpnR3JN?=
 =?utf-8?B?UEdiMld5dHJwQ1NGbFlBSjF4QXRKZmhGa1IwSkxaU0l3dTFGTXlFR1E1VFc0?=
 =?utf-8?B?d1drMkVnQTNKVFl3Z1V3emQwbEkxTWNSaXdTNUdrRTRVblVNOTUwMGc3VkYv?=
 =?utf-8?B?VTdPcU8xUVBsQS9qZHc0NUlzZ3FKdWRrTmo3b1FaSXp4SEVSVE1BcWZUOGs1?=
 =?utf-8?B?c3hraCtwRzE3MlRVZGhjNUtwRmJOK2VkSVRLK3ZIUG5XLzdJaUhaUE9jZjB6?=
 =?utf-8?B?QWNwOHlZZ2NKN2FaWG9wc1JUbDdIREZRS3pSYlNxU1N3MVI5NDBMZHk1T1Ja?=
 =?utf-8?B?dHRnS3g5VFhIMU1VcDhwaDNOUmVGaHFMdzVCTzl3WDFrRTVKL1BnZ0hMc2Vn?=
 =?utf-8?B?WFNISHdNT0RlVFF6RHhwZ04rRFJEYU13OXFib2d2NkZLN1pGYnJkdVU0eWZP?=
 =?utf-8?B?V0FSaUFiTC8wL3lxalB1VUJzcksySW1RUzFqREhmM1grZTJNanJveElLOE1x?=
 =?utf-8?B?S2lDcHkzcTNhcWE5dy9NU09EYzJHd084RFhBNVdlUWF1eUlhcHlndkNtNWtP?=
 =?utf-8?B?Sk9EdWhOeklNN002ODZBQjVFUitLQmw3NUhqUmZSb3BuTFY2WFpLTUpaRW4z?=
 =?utf-8?B?WTJBVWNZK3AxSHZkQ2dOaUIvaGI5OFlYazA1U3l5NWp5UDZoU29XVFRzUnBW?=
 =?utf-8?B?UUJXY2VNTk5lODRNVWtzUUxNMzVLc1RGVmpzREcwdm1uc2RQRmNWSXY0YS9a?=
 =?utf-8?B?YUx3YWZLc3Y3UEJ0VWRnTk44ZGNVZ0ppa05yNGJnTDN2ZUZkeG52VU5ZQVRw?=
 =?utf-8?B?d1dHUEM1YVNwbHBzQmFqOWZpUzlrdGJ6d0xySFhlekkvZzNwLy9aV01uUWkx?=
 =?utf-8?B?bXNobGF3a1VFMExnbkZhUGRaUVpzRlV6bjR2S1R5bWxBb0xHZlBia0JMQmRj?=
 =?utf-8?B?QmJlY0NXbjNlY0tucHVhRlJ6Qk84S2hDWDNac1d3WUY1VlFVZUZjVjkzeGRO?=
 =?utf-8?B?alE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 535a73b1-79d7-45f2-b05e-08dcd0e8ac73
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 16:01:32.5706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UwxQGj6mFcFFAkS6BUuEbUMz+vshElKI+hdhw3O11PxtbJamO1Xlw0sJRsHqSMRCogEEDg3xP9r/nAbiVmPgjxzgY6jlZtb9t1FpKJT5Yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7382
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 16:01:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/637

Hi Trevor,

On 9/9/24 4:55 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> v4l2codecs is the gstreamer plugin for V4L2 stateless video hardware
> decoding. The Rockchip SoCs that have a VPU all seems to be based on
> Hantro, RKVDEC or RKVDECv2, all stateless encoding/decoding VPUs.
> 
> Therefore, let's enable VPU decoding in Gstreamer whenever possible,
> when the SoC supports it.
> 
> PX30, RK3066, RK3188, RK3288, RK3328, RK3399, RK356x and RK3588(s) all
> have at least one Hantro VPU.
> 
> RK3328, RK3399, RK356x and RK3588(s) all have at least one
> RKVDEC/RKVDECv2 VPU (though not necessarily supported in the upstream
> kernel just yet).
> 
> === PX30
> Tested on PX30 Ringneck with with Haikou+Haikou Video Demo adapter:
> 
> $ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slh264dec ! waylandsink
> 
> with FILE storing the path to any h264 file, e.g.
> https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_720p_h264.mov
> https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_1080p_h264.mov
> 
> Needed packages are:
> - weston
> - gstreamer1.0-plugins-bad (for waylandsink and v4l2slh264dec)
> - gstreamer1.0-plugins-base (for parsebin)
> 

Weston output is broken on Scarthgap. c.f. 
https://lore.kernel.org/all/1f84dd9c-bdef-4099-9dba-04b445a7ee0a@cherry.de/

> A few frames are dropped every other second for 1080p but otherwise
> smooth.
> 
> === RK3399
> Tested on RK3399 Puma with Haikou:
> 
> $ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slh264dec ! waylandsink
> 
> with FILE storing the path to any h264 file, e.g.
> https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_1080p_h264.mov
> https://download.blender.org/demo/movies/BBB/bbb_sunflower_2160p_30fps_normal.mp4.zip
> 
> Needed packages are:
> - weston
> - gstreamer1.0-plugins-bad (for waylandsink and v4l2codecs)
> - gstreamer1.0-plugins-base (for parsebin)
> 

Weston output is broken on Scarthgap. c.f. 
https://lore.kernel.org/all/1f84dd9c-bdef-4099-9dba-04b445a7ee0a@cherry.de/

> === RK3588
> 
> Tested on a RK3588 Tiger with Haikou+Haikou Video Demo adapter - on a
> downstream v6.6 (upstream-based, not Rockchip BSP-based) with DSI
> patches - :
> 
> $ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slav1dec ! fakesink
> 
> with FILE storing the path to any AV1 file, e.g.
> http://download.opencontent.netflix.com.s3.amazonaws.com/AV1/cmaf/spark-8b-59.94fps/spark_606kbps_432p.mp4
> https://woolyss.com/f/av1-nosound-chimera.mp4
> https://woolyss.com/f/av1-opus-sita.webm
> 
> Needed packages are:
> - gstreamer1.0-plugins-bad (for fakesink and v4l2slav1dec)
> - gstreamer1.0-plugins-base (for parsebin)
> 

Stateless AV1 decoding is not available in the mesa release used on 
Scarthgap.

So...

RK3588 seems to have gained upstream support for VDPU121 which should 
allow h264, mpeg2 and vp8 decoding. Building a linux-next kernel after 
tag next-20240829 should have the support AFAICT.

So, I would retest RK3588 support for those video formats and drop the 
AV1 mention from the commit log as it for sure doesn't work because of 
the version of mesa in Scarthgap. We could backport later releases into 
meta-rockchip to gain support for it. I think this **may** be an idea 
once there's support for 24.1 and later merged into OE-Core because it 
brings Panthor (open-source GPU drivers) support to RK3588 which would 
be a shame not to have in an LTS. But let's see when that happens.



As for the issues with display on PX30 and RK3399, it seems those are 
supposed to be patched in newer releases of gstreamer, c.f. 
https://gitlab.freedesktop.org/wayland/weston/-/issues/839. Note that
Robert said it would be fixed in gstreamer 1.22 but the linked patch
only made it to 1.23 (Scarthgap has 1.22, Styhead 1.24).

Considering what Robert said in the link above, I assume people using 
another compositor than weston may be fine on Scarthgap, so I would 
suggest to backport the patches I submitted in this series to scarthgap 
anyway? One is not forced to use weston to do VPU decoding.
FYI, I gave ~30min at backporting the gstreamer patches to 1.22.11 but 
this is above my skill set today.

For those, I would just mention the issue in the README and commit log 
and maybe switch to fakesink in the commit log instead of waylandsink 
(and drop weston from the needed packages).

What do you think?

Cheers,
Quentin

