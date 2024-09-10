Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9EAECE58B
	for <webhook@archiver.kernel.org>; Tue, 10 Sep 2024 09:12:23 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.42])
 by mx.groups.io with SMTP id smtpd.web10.18706.1725959536254454415
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Sep 2024 02:12:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=bm1TFsGZ;
 spf=pass (domain: cherry.de, ip: 52.101.66.42, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKDbHQ1U7M6BYtSUJypy0VlO1l8q6AgLA8INPur+KtKhzjEtmVSOXgYLcA1F8GuExBD8yfXJ+Uvfp5wNVgsEXXnrttJCLYnHJNkny9ABzLA1kbyMRH1FGMJxkFCukce8SveX+p4ulN1OMwETKrNDhepTMirB08gaG+sBo3zXvJryzr6fuaNbeWmYGFx4pKQf2cW7vurjoiUUnfmwGWqkVK7fo6Jn2HRJ/gCclcbl9R7aEZAPtUj+PtWTEibvJf6x9EKf5tS0KVyDI0kRoaKrFPlD0sVjLyszdIq+r7Yoa1gDhV9l3qAqcUBkU6oKnGpGtH8ZX7GrjOQLj411rC594w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlSC3OObd9mNSlyhtFKrLG3zYR+6l/rTbkReswnIIg0=;
 b=KCxy+bbz/91afM1Jv9/1iAfpuoUf012TPXEDixBjBUOLDKI7vO7IME/o7bEcA9dipxln5XIV+RVcoUK3+qzxXsTgW1iyJ5qyfQq15Ktq3cRA5BbKQ1ilSfEsMrO3H7LfrdBqxcmLAAPdynRjmeEgjo050UgrcAhyuUm0wsnxYIgx8PTER/iyRuIq527oIdUlRFLI/y6Swgt/5tAyX8LRN0LUgkSiiPlOQeeXt0rdJV7dEJAl4TvVKKbLkYaEQJ0F0/Wc3T1Lrp/lVPdHj2si9Cvp0PJ1pj6tXyOE0JPa/yIu92mgNaDCbxv+NLpHetKh1JxvCJfDSWvCFfssmhveWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlSC3OObd9mNSlyhtFKrLG3zYR+6l/rTbkReswnIIg0=;
 b=bm1TFsGZUyBx5qOw3cOmRl1S6KdO/mIkV2mcU9Bv8yYrHhLLbiyQRmDOf/3uUGmsTIfr8+yGcTEzFcrjUtpCkqZAOh/4mYl4ihF5hStgMouhw4o8GTS2RPRh9dnJJfq974Ts8Z2GW5FWrAf5nXHGG23DFYO4yGKeKxnqsSewzFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by DB8PR04MB6857.eurprd04.prod.outlook.com (2603:10a6:10:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 09:12:11 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 09:12:11 +0000
Message-ID: <8cc9cdf0-051d-4b13-87e3-52aec50942ab@cherry.de>
Date: Tue, 10 Sep 2024 11:12:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][scarthgap][PATCH 09/10] enable HW
 VPU decoding for SoCs that have stateless VPUs
To: yocto-patches@lists.yoctoproject.org
References: <20240909145530.25301-1-twoerner@gmail.com>
 <20240909145530.25301-10-twoerner@gmail.com>
 <f900b17c-8b9b-454d-9339-25886e30f269@cherry.de>
 <20240910045214.GA32228@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240910045214.GA32228@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: WA0P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::13) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|DB8PR04MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: aa31cd99-690a-4684-561a-08dcd178a74e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YnMyVG9hYkRIeTJ6MVJpN2lkNmtYQUZXU25Zc3Ztdk8wOXlZOFM5OXFMSlB2?=
 =?utf-8?B?V0wvN0ZVVGFMbjVtU3Qvcy9aS3ZRcy9RSERPRDNUT0VVd2tmVFJic3dTSE1w?=
 =?utf-8?B?SmxIVTVKeXZYM3FzVkZyTEpuT2lhSGgvTnBIUmt2NkZucURvWE93a1U4ek02?=
 =?utf-8?B?a2xRUnRIaWY5TGJ2RDhhNUFrZE9JMDBUdlU3QlpQTFNJY2VzQ3g2cTRScS85?=
 =?utf-8?B?T0tYYVVMSUhybGlieThuaVg0RGp2dVRtd0lOQUF6a01TRkRmdnp4eStST2Za?=
 =?utf-8?B?RnBGVHVtc1hPNEUxTGNHMzVhN0lnVS9IL1RrTFdvQ1YwemsxdXcyanNhek9t?=
 =?utf-8?B?dE1IbmUzWUowKy9pT2EwM0JWaHkwdjV4U0ZBYmRqVUdKbGszL3ppSXhCQlpj?=
 =?utf-8?B?akJ4aENNU3gwVXJzb0Z4V2NQWGNWSlBTNFZCSUl1ZklueG5mZkFodXNKUzcz?=
 =?utf-8?B?MmdDTkhVQmJTaXBPelZCRnhsMUkvSTVTOGJBRzlLMitpZHRZN1FsamVYREhF?=
 =?utf-8?B?L08wQWExR2FmZzltOVJ5NklKTTZ0bk9UMEJnd2JoK0x3ekxid3JFNHdBQjM1?=
 =?utf-8?B?MURnbGFvU1lvQUttWGNQWUxlWUVCbXo0WDhRZGk3OGJFb2pBN0liVVBGQUV4?=
 =?utf-8?B?enlBbDFtejdIN3VJL2Q3bmQ4VGRqUWV1MWwrc1E0c21oREduREhBeVJVSnBr?=
 =?utf-8?B?M3JiUHJKQzJiZ2tORWducTlJMVNObElwSDE4dEtuUFN4Z1dveTdGQjJqTGpa?=
 =?utf-8?B?RFUyNW5kcUw4Si9adlM2dWJvdno4VmhncnhaZkxkb0JqK0NoSXYxd2hJczlR?=
 =?utf-8?B?NkIyMlRqYjJWeE5JWitURGNIMlVNcjNiMlIydlhJekhmWWdWRmZQdkU5NVBX?=
 =?utf-8?B?TzMzcldQcXhrMzNxeHpNTXQvV3llZTdZQmhhbnN3V2JVQ1c4SVJ1cmo4bldt?=
 =?utf-8?B?UFFzbGRYY0Z6cGNkVHIvWExmYlVIQUlGQXJmMEFIOGNDNGI0R2Z5cStxeWZx?=
 =?utf-8?B?MldvelIwWTJaRi92OStCTmF5K1IzaW5mZGFTcEFuNE9FSDNhSVJTOXQweWlo?=
 =?utf-8?B?VCtlZFkxWDJESzdYa3FLd2IzRCtCTTNwSGc3eStsU3pPM1FJUW5vVDhCUnlD?=
 =?utf-8?B?d29jaGJ2U3dXWnU0VW1HdVhFRjVkUnVEanNCWDk2RkVDaFVGbVdTdWt4Q0Zz?=
 =?utf-8?B?NmVndE1sbkpUbzBFbTlmQUI1UzRqeDlpeUFFVGxVSmRDVyt2VDlpUit6di9Y?=
 =?utf-8?B?bnp4eWVnWjY1emhXNXVlc3BNTzNjbW84aFVjUHhQK1RmNUdqNFFPWk9vVElk?=
 =?utf-8?B?SFIrb1VNU2V6dVFUL0Q0aXdFRlNxbk5TQWluOVNmWXFvVHdNSy9QcEkwa0Mv?=
 =?utf-8?B?Y3RRZ1VJbjByYmNMVTBYcngyVUNKbUQ1UXA4SHlDQU5ib1hGakkzeTV4WXlH?=
 =?utf-8?B?NllBWXJRRk9JQnR6WVpQd0JNQTlqbXEvQ0FSaTNDSmljN0FuRTYwMkwxNzcx?=
 =?utf-8?B?dm9WRUgvVllwak1FVXJyUUhqd3ZDRFB5aEQwUkFWaCtDOW5GbzQrSFdlRVBC?=
 =?utf-8?B?cnB0aDduY3BJdVRNR0ViMXZraWgxT2VhbXBVY0YrTXhUbVBlclc5S3JLZWhy?=
 =?utf-8?B?alFsbWlQU1A4SnIyOXE2bGhhemhaZGRFaml0NFpQY2VtdThZOGZGWnNzNUM3?=
 =?utf-8?B?UlhTZTdDM1VpMFo2clBQZm9IVldtYnRGalB6UVpxWU81bHZBcVlmKytmMjNn?=
 =?utf-8?Q?+IQ3qJ/f8V7RWGOKtM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OUdaK3g0c05qRzVaRFNWTDJERHIveC82ZE81c1JlNE5rVEs3dEJHZzhwbU9n?=
 =?utf-8?B?bHlSK1pRMUxaYTF3a2dWeVZVMk9BRU1XNjBNRkE5TG1xVm9IS3N2SEZ4L3lh?=
 =?utf-8?B?STNoUWFlR0lnMUJaWFAxNS9VVWhkbVNzbGVEWmEwN2xBM0lNdXdNU2lvK2lo?=
 =?utf-8?B?SEdmMmNtRGF4cFJhRkYrWDMyWXlkLzY0ZFlndVAveG9qTHhyaWNscXhhc0o4?=
 =?utf-8?B?S0lESHk3U3BCak9kQXpEcEFudnZ3anhHYllTN09NOXltblo2ZUhLRktjMHox?=
 =?utf-8?B?WW5ma0V3djJHNFJvSmppdy9iaWFGdVJNTklVUTExS2NtU2VIN3ZGVGJFTmdq?=
 =?utf-8?B?VThCWTdHMEV2bXpyZnIrbUFFV2RwanZlbWRkdk83R3BIak5qSmRhRmtnaXlm?=
 =?utf-8?B?MFMwcDdDMkdzOXRVR0g5aDlJS1BEK3RDdkUvRGZlcTA3dDhQcEUreC9scXc2?=
 =?utf-8?B?ZHl5bitId3dIc1dhRjNhR0NNTlgrS2U2Z0x6Z0hqZ1JGNmpYKzhKeUhRQUhl?=
 =?utf-8?B?clVKU1BpZXI1SnI4R3FETVB2aEdSZzlWVWtETFVMSWxRYTZuQ2h4T3JVQ2ha?=
 =?utf-8?B?SEV3My9oMlJyVllnQ01xbFhYNnNMUU1zbmQwUjhPdkREY2tab0ZBU1ZmcTNC?=
 =?utf-8?B?aFNRbGF4OXM1UVB2by9OdnZmZzJ1YWhkamw1dnhRMEJpa2JNZUFhNzNXK2hF?=
 =?utf-8?B?NGhqeWhER3BYY2FwQjlQMTljN0RtMW9udEFSRnY3ckE1aXN3NUl6YnltUm0z?=
 =?utf-8?B?TW9zMjBuMWd1NDFKQkJwcWlDVEFuNEE0SGZQbDdxMVJrWDRCeGFzVXBNQitN?=
 =?utf-8?B?WWJYWEF5UWZPSVNWVmxMQVN3WUhoWW1FNUUvM0sxYUs4VHAza2NQMEpINnNC?=
 =?utf-8?B?NUZRTFNTbjdRNjcxcWNOaHd6c0Uzb3Rwcy9GemZVTFk3ZGM0NEt5bDUxbE5E?=
 =?utf-8?B?Q043NGlVeklnVnBnZTc0aUpTdk8yU25NY2NYanVrdHhlMW5mellOeXJ2aE54?=
 =?utf-8?B?WTZqcDRIVTR1NUozUjhnQWFXRjBvMXptcU5HWHdBQ1hJVllmL0p0aWxwWVVW?=
 =?utf-8?B?bWV1b3doOEI2eXhkVGg0VTRZb1M4MDZadlJ2UUF4d3hBS1RSbGJlaW9RbTlm?=
 =?utf-8?B?K2d3NkNzWTVlNjladVNWR2lkZGhseC9oN2MzWHFCS20vMXZRUVY4OG9aUjJQ?=
 =?utf-8?B?ekY0YTFWMHF4cjlicUo0ZU5EbnpOb21ETnF6eFV4SFd5NjMzZm51TDd1OUU2?=
 =?utf-8?B?N1VoaFhxZDA3NGNQNWdrZ2ZQd1pDbUQwZ0pjMjg1L0duamNyNXNxVTZWNkxw?=
 =?utf-8?B?Y1RpcHpCdHRtWldmZWluKzVNNzA1SEZ1SWFiVUNCUEI1TE1Oc1lpR2dubVk5?=
 =?utf-8?B?TFRwK0NpejNkcTRyQUd3UWN0REN6K2toeWNaYUdJSlJlK29rdENJMUdsOFQx?=
 =?utf-8?B?TzJwbWdoc01FOGFlOGF2S3IzV0NaT3pUNWpSanlJZU1FQVVVa0o5eENocjh1?=
 =?utf-8?B?cEtvdVU0OTlkTE1VNjlnWCtudC9UaXR3WXM5TlFwa0k3MXpUS0xFQUVHNjVU?=
 =?utf-8?B?YXF5Nm13NjJrNnRmYkxkZ2J5TjRjQkdlamZLc3BHNUZWQkVmajlVNnF3Nk5r?=
 =?utf-8?B?MVZmc3UzcFZ3blBNcDYzQXQ4TFoxSjZIcXc5MEJrc1p6bEpqKzF1QkJabW16?=
 =?utf-8?B?YzY4RDJLYWozOS9MU00ySkhoMWlvdzViNnF1MGJwZS9OTm9PVVI5anZyWW5I?=
 =?utf-8?B?R1JoTlp4aEU0aUhjT2ovT05wcUpFejVXMmxlRmtrZk0wcTF2VTdmWTRlV0Rz?=
 =?utf-8?B?Sjg5dS9VR3JrWnduN1g2bExUb1B2MUtObmo4QlA1MzA4eEM3aS8rMGVQOHND?=
 =?utf-8?B?UGdORVhFbU5MOFdEUjQwMXdrY3ZmRGNuelEyQlB4YXRsR1FaT0R3ZXZVMi9B?=
 =?utf-8?B?aDl1ZTRFWGVqNmkyZHdBOVRRelVQbm1zZ1ljWFNtcUo3RGVYWE1Jamt1dWRI?=
 =?utf-8?B?cU5DKzVvYWZKOVpMNDVwR3RwWkpIZDVSTkRBOURhaUlzdU9iRnFlcFRRbEZr?=
 =?utf-8?B?Wk1nbWJ2cHh0N2F6THBKNGdSZFJvUkc4QUxXckhoQkJmUCtLZ2tmT0s5ZkMx?=
 =?utf-8?B?ejdHSGJCczJnKzBSa0pRdSs4azJPVDRLWDBvNmxJYSt1WFV5QXdERG9VeTBX?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: aa31cd99-690a-4684-561a-08dcd178a74e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 09:12:11.5050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yX8uEtaEj2oDZtJB/7PpbZ65o0rD2IUKNHLzfk1B9oLm8swptzmy2oxrXL+07pC/Rtzmdf5X7cBP4KGlhjx4qR5X2UEQ3F6hXv/j/Opw8B0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6857
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Sep 2024 09:12:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/642

Hi Trevor,

On 9/10/24 6:52 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> On Mon 2024-09-09 @ 06:01:30 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>> Hi Trevor,
>>
>> On 9/9/24 4:55 PM, Trevor Woerner via lists.yoctoproject.org wrote:
>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>
>>> v4l2codecs is the gstreamer plugin for V4L2 stateless video hardware
>>> decoding. The Rockchip SoCs that have a VPU all seems to be based on
>>> Hantro, RKVDEC or RKVDECv2, all stateless encoding/decoding VPUs.
>>>
>>> Therefore, let's enable VPU decoding in Gstreamer whenever possible,
>>> when the SoC supports it.
>>>
>>> PX30, RK3066, RK3188, RK3288, RK3328, RK3399, RK356x and RK3588(s) all
>>> have at least one Hantro VPU.
>>>
>>> RK3328, RK3399, RK356x and RK3588(s) all have at least one
>>> RKVDEC/RKVDECv2 VPU (though not necessarily supported in the upstream
>>> kernel just yet).
>>>
>>> === PX30
>>> Tested on PX30 Ringneck with with Haikou+Haikou Video Demo adapter:
>>>
>>> $ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slh264dec ! waylandsink
>>>
>>> with FILE storing the path to any h264 file, e.g.
>>> https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_720p_h264.mov
>>> https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_1080p_h264.mov
>>>
>>> Needed packages are:
>>> - weston
>>> - gstreamer1.0-plugins-bad (for waylandsink and v4l2slh264dec)
>>> - gstreamer1.0-plugins-base (for parsebin)
>>>
>>
>> Weston output is broken on Scarthgap. c.f.
>> https://lore.kernel.org/all/1f84dd9c-bdef-4099-9dba-04b445a7ee0a@cherry.de/
>>
>>> A few frames are dropped every other second for 1080p but otherwise
>>> smooth.
>>>
>>> === RK3399
>>> Tested on RK3399 Puma with Haikou:
>>>
>>> $ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slh264dec ! waylandsink
>>>
>>> with FILE storing the path to any h264 file, e.g.
>>> https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_1080p_h264.mov
>>> https://download.blender.org/demo/movies/BBB/bbb_sunflower_2160p_30fps_normal.mp4.zip
>>>
>>> Needed packages are:
>>> - weston
>>> - gstreamer1.0-plugins-bad (for waylandsink and v4l2codecs)
>>> - gstreamer1.0-plugins-base (for parsebin)
>>>
>>
>> Weston output is broken on Scarthgap. c.f.
>> https://lore.kernel.org/all/1f84dd9c-bdef-4099-9dba-04b445a7ee0a@cherry.de/
>>
>>> === RK3588
>>>
>>> Tested on a RK3588 Tiger with Haikou+Haikou Video Demo adapter - on a
>>> downstream v6.6 (upstream-based, not Rockchip BSP-based) with DSI
>>> patches - :
>>>
>>> $ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slav1dec ! fakesink
>>>
>>> with FILE storing the path to any AV1 file, e.g.
>>> http://download.opencontent.netflix.com.s3.amazonaws.com/AV1/cmaf/spark-8b-59.94fps/spark_606kbps_432p.mp4
>>> https://woolyss.com/f/av1-nosound-chimera.mp4
>>> https://woolyss.com/f/av1-opus-sita.webm
>>>
>>> Needed packages are:
>>> - gstreamer1.0-plugins-bad (for fakesink and v4l2slav1dec)
>>> - gstreamer1.0-plugins-base (for parsebin)
>>>
>>
>> Stateless AV1 decoding is not available in the mesa release used on
>> Scarthgap.
>>
>> So...
>>
>> RK3588 seems to have gained upstream support for VDPU121 which should allow
>> h264, mpeg2 and vp8 decoding. Building a linux-next kernel after tag
>> next-20240829 should have the support AFAICT.
>>
>> So, I would retest RK3588 support for those video formats and drop the AV1
>> mention from the commit log as it for sure doesn't work because of the
>> version of mesa in Scarthgap. We could backport later releases into
>> meta-rockchip to gain support for it. I think this **may** be an idea once
>> there's support for 24.1 and later merged into OE-Core because it brings
>> Panthor (open-source GPU drivers) support to RK3588 which would be a shame
>> not to have in an LTS. But let's see when that happens.
>>
>>
>>
>> As for the issues with display on PX30 and RK3399, it seems those are
>> supposed to be patched in newer releases of gstreamer, c.f.
>> https://gitlab.freedesktop.org/wayland/weston/-/issues/839. Note that
>> Robert said it would be fixed in gstreamer 1.22 but the linked patch
>> only made it to 1.23 (Scarthgap has 1.22, Styhead 1.24).
>>
>> Considering what Robert said in the link above, I assume people using
>> another compositor than weston may be fine on Scarthgap, so I would suggest
>> to backport the patches I submitted in this series to scarthgap anyway? One
>> is not forced to use weston to do VPU decoding.
>> FYI, I gave ~30min at backporting the gstreamer patches to 1.22.11 but this
>> is above my skill set today.
>>
>> For those, I would just mention the issue in the README and commit log and
>> maybe switch to fakesink in the commit log instead of waylandsink (and drop
>> weston from the needed packages).
>>
>> What do you think?
> 
> To be clear, when I say I've run-tested this build I'm not implying I've
> tested every aspect, feature, and functionality of each chip. I've simply
> flashed an SD card, applied power, watched it boot to a prompt, log in, and
> run something simple like "uname -a" to verify it's using the scarthgap kernel
> and not the latest master. I'm not really in a position to test stateless VPU
> decoding or anything fancy like that :-)
> 
> If there aren't any issues or objections, perhaps I could start by applying
> the other patches in this series while considering what to do about this one?

I haven't had the time to look at the other patches in depth just yet. 
But I agree with the suggestion of putting this one patch on hold.

I currently have this enabled in our vendor layer:
https://git.embedded.cherry.de/yocto-layers/meta-cherry-es.git/commit/?id=37422a2f8d2553701dfa80de2bde5537ffffa770
https://git.embedded.cherry.de/yocto-layers/meta-cherry-es.git/commit/?id=a72a8bbabd5721f25ccef369ac470ea5d27b864c
https://git.embedded.cherry.de/yocto-layers/meta-cherry-es.git/commit/?id=7c575990a66490e8907376a75c784b15c484b0c7

So I clearly am interested in having this work with meta-rockchip in the 
Scarthgap branch. It's on my TODO list. I also would like to test h264, 
mpeg2 and vp8 on RK3588 on Scarthgap too :)

So basically, I'm volunteering for this as I have professional interest 
in this, but if someone does this before I have time to handle it, I'll 
just review it whenever I have time :)

> Maybe after the others are applied you'd like to have a go at making a
> scarthgap version of this patch (with all the proper commit messages etc)?
> 

Sounds good to me.

I'll try to find time to review the other backports ASAP.

Cheers,
Quentin

