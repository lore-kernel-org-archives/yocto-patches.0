Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DEFCA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 13:47:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (NAM10-BN7-obe.outbound.protection.outlook.com [40.107.92.61])
 by mx.groups.io with SMTP id smtpd.web11.20308.1755697631285070233
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 20 Aug 2025 06:47:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=xA33aPkL;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.92.61, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcZheJlSjITNzNeVvQW03fT6NYLBKd09KyAR/qK1fOfoLqpL0QiWAQV5DgLbCWbJ2iYoVWrmYZ3hG+Bs5O0ObmlMxOTKjZ+ibg6TCdiGJ/BoisawSZ0O1S71DenXYM6GE/PGTU+JHCO+xrOBpXFtbkduVqkCzPRn7eNPCj7eAF/XokWlNTDZHJWxavaceFTTbn7NHTKVEi/MKU6J+7YEMqWz/l0Rq+VkCoBmG0K/CRwCKfWmEOvCO4nKilKfziwdVlkiqnesvd3cdUnK85qeIuk68ZSlE+w31KfbrGAqSNoH6zazVCJ/LFYzRVYi9D7eYwXjlYcqg5s9kt1ZT4TXow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lh2cHCcfNqu95aTwYB/kvr23k9PG6Etdu/bRtKmOYIM=;
 b=sqCdoKvmqxDmrVTl5UGqUt4FRPcQZndjboUYIh+sgqtHurTSyQTPeYEx3SlXHJdMQH0ky3JgVmc2Q0a47lhBt+7By6Wg7cCd+sMOW7vXGqI+jiQNXn8jnRWZS7PRkn68iBm46WhzeZMptus7eJyt8WHn2wN6Jcd/OAJYxpA6sKKVSHVfb3ValQqWZs8nJPkoSbTIgkzoY/bw74H8cgih0aaXCPf+VhVnNmDBkJmUOhiMsLK8qSSzEMBwcXPZG2mdwh3Rc7UCWnHOXZNFoKl1J+06Y2Oszgs79AhyMgsKs584g76PCtY0JAvoh175vtOx+6HsSlKy0tnFYQP/LgzzTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lh2cHCcfNqu95aTwYB/kvr23k9PG6Etdu/bRtKmOYIM=;
 b=xA33aPkLfSSQIqgB+Gjb+plcmrNqEiZcdoN9F47aFnsGf1Bw2D7Bhuj9579Iz6Usy0FBC0/rzTtor8AAKAVabrIggxTnAohaC4eG0oIqJzdupQZ0PeLFFXWaFTpKpOevwGzpzsy3OkvgWseEyTQ+AgW82z2GDmXbRmIopdfmOv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 13:47:08 +0000
Received: from SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7]) by SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 13:47:08 +0000
Message-ID: <4e4c9192-e629-4cc6-96ab-e05c1d5e3605@amd.com>
Date: Wed, 20 Aug 2025 07:47:06 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-zephyr][scarthgap][PATCH v6 10/11] zephyr-kernel: Add rpmsg
 multi services recipe
To: "Lee, Chee Yang" <chee.yang.lee@intel.com>,
 "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
References: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
 <20250818220304.2300436-11-sandeep.gundlupet-raju@amd.com>
 <BL4PR11MB879791DA10D548D88531B23DB933A@BL4PR11MB8797.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <BL4PR11MB879791DA10D548D88531B23DB933A@BL4PR11MB8797.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:610:4e::30) To SN7PR12MB8770.namprd12.prod.outlook.com
 (2603:10b6:806:34b::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8770:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: 910255e1-685c-46b7-7d76-08dddff00e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Ylp4aDlYTDcrZkRiblVaOXhmMnZyVFpubWNsYWJrSTA2c2JhbnZNaFVWcWxG?=
 =?utf-8?B?MjdxUFk5YVd6eDlVYmZ6U2MwUXJxbDQvcXROWUI4cEREREcxNmVIOXg3cjhv?=
 =?utf-8?B?VFZmSklSbGVmbDhXcDVwZFp6WHh0ZFJOd2h3R05oUWhVZ0xNbEUwQjNLeHJo?=
 =?utf-8?B?R1ZHMTlwR3VaZ0doRjZsVlBnRENGY1lINU10R1Nna2VIa3Eyc25ETzFmL1hy?=
 =?utf-8?B?cFhPUlc2bEtxbTRaZ3ZPelNkTWhsNFVzeVVjUEVRL21EZm9VSitrVFU0UzNX?=
 =?utf-8?B?ZHM0MmN1UXpHZzZ4VDJkMnA0RGxEOWhUMG1kQkpMS0pEeXFQMFJoVFFJQzFL?=
 =?utf-8?B?UFF5NFh5cjFTWXhOOXdnSFlrdnI5ZmFyUVBVZkNUcXFOOWloeVltYm1IaGNF?=
 =?utf-8?B?S25OZlpLK1lXS3VTS1RnY3hrdi9INmk4UXpENDVTL2hzenhjOTdQMG04cWRN?=
 =?utf-8?B?d1BXVjBRZXN0cHp1clVSancyOUJBcmtsU0U0WThHYWRuajRNMUtkaERmS1RR?=
 =?utf-8?B?WExNemNTKzlzRmgvWWoyTTBjODJwcnM2L2hhUnB3Ykt6NFgvWWhRbExjZWpo?=
 =?utf-8?B?ZXBIcForaVJsS1FBcVhnZ2VtTCtyajN4OEdWakoxVTZEZjBKR3NlUlR3MDA3?=
 =?utf-8?B?NDBxd1d6ZmZaYWNsV1ZuS0RWVFB1clV6YkZ1ZzBMaWJrd0VQdlFBQTVqSWpz?=
 =?utf-8?B?QVg2TTJQWHp6cnB6ZlBOVWljNDRLdUJobDlNdTkxaUoxTVNiMS9pUlhHVHdo?=
 =?utf-8?B?blYwWnBGUDFadnQ0Z0hBWXQ4bmNuMFdhUmRZR2FDaTUzWGlJNkZQRWlYSnBV?=
 =?utf-8?B?cXpxUWpEUDEvRU5jeEhNQVZ0NE45VXE4NW9jSWRjWEttNlI1blArNm5vUW5v?=
 =?utf-8?B?MkpKMnpURk1XQkRpdGJ4UGIwN2Y1R2Z3UVR1YlVuYzFxMVBCV1Uzdlp4Wkt6?=
 =?utf-8?B?UHRQMnRmc2xBWkZQZDJoYzJQWXJlbk5DK0hKQk5tWDFlSUlISmh6M0hFd3Zp?=
 =?utf-8?B?cjBGL2RQZVBad1llQWlnTXl4TGZEWXUyYXBDRXNMNGdHTm9LUHl1ZWxLbzJy?=
 =?utf-8?B?a3N3Wk1kb3o1TU9aTkdGTlo4ZTd1S1Z6eUo4MjRZNWQ4RlNRVFNtTU9XRGZy?=
 =?utf-8?B?UVNPYklqZ0diaEQ5R29MMHpsUFRWdTFpWFZNNFhIZzQ3UUtpY05CaS9XbjBK?=
 =?utf-8?B?Z3BJdmtmZlA3MXdJL0pXRVNWdGtCbEs4WDJGVmYxRHhxQ0NYNm5VeDhoN2pM?=
 =?utf-8?B?anQ2WldwdUpHZml0TXdsOXFlK3kwWWNWSTdTdkhnRmFyMnVIYnB6cHMzb3N5?=
 =?utf-8?B?S1ZCTFVOaWgyUUdDcDVlZGc4V2IwSkdxQ1FJU2pBVmx3NzVKSzJmZ1RrVFJp?=
 =?utf-8?B?aVJjVUtwQXdlcmIxQk1MME5zbU9YSlM3STZjd0R4WlJwcGZxVzN3dEc3M3g2?=
 =?utf-8?B?UzZ4UUxiNWlHL2pRdnc4MGlsNzBBV2tMVGRpN0hFZCtDOCtyanF4OUpRRHd5?=
 =?utf-8?B?Qmg4eHZUS2FaNlJrZ1pKa1FkUnUrVDZsc0FUMDZodVhCRHJhSVRDMklrclJn?=
 =?utf-8?B?Q0JCV0RPM3djZjdPTGdLSG5UNVVaMnNYYzBlMzFqSWp6VFhQTGZVazhDWXRp?=
 =?utf-8?B?RkdabW5vUnRPR1VLSVdCdURwamdBQlh2cWRuaUJNMUh1cGVWK1FCS2trVDFn?=
 =?utf-8?B?TThCdnNMRi85QWE1Nnh5S0lSRUk3Z2sveW5FYUpRMllESzBHM2JWYTg3L0pu?=
 =?utf-8?B?WW5VUTVySjVXazFPTWhwM1ZiT2o2Q1daaDdFOXc4NGpidENxVzBIODBuTlc5?=
 =?utf-8?Q?klDn9Cts4JPK/EOtvm5HEKlnNlFTTg+otVvMM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8770.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WkRkeUZwRkVjVDJUL0txTVcxZ2FydE9MQjhmOEN5eUF6NUVxUmJJM3BsaGdU?=
 =?utf-8?B?YlJ3ZXJDUjkrRG9WaisvNnV6REYyenZhWG5lS25SZGVpbDYyd05ucEM5OWNV?=
 =?utf-8?B?UW1JdUI1Qm1NT0FNaElYdDFqdnJJSkNqb0Y2bXAvVkk3a1NCTzVid2ROMWpT?=
 =?utf-8?B?cTg3bTUxbHdPOGNSdGl6NkxaNEdzWWN1cHk5eXRYYjJlNWpDY2lLUnZsWGJY?=
 =?utf-8?B?OGhMYlBPb1Y4ZmNJWHg4R29FTW4zYWUzS1Y4K3JVallxdWVGam1BUTB0d001?=
 =?utf-8?B?SEZUMllXL2RiWTVBRmNGYUpGcm5WM2NOaWk5WnI5T1k5b1FLTXFVbS9ySU03?=
 =?utf-8?B?MFJsY2VXNkxUMW81UDlhQ2IwL0luZWFKTjBqelUxckpVYlNTd1lzc2IrUEFK?=
 =?utf-8?B?RFVHVktoUzR5eDBmampWYUNyTXBrSjlOTVh2WThXRjZBcmtacGpqNjMycEV1?=
 =?utf-8?B?ZjRPOXN5NWVZUVFOL3greE9KdDBMemFjRE16Y2FETHNrYkV3Mk1wNFg1cU16?=
 =?utf-8?B?Ui9yb3J5djZaTjdQZDl3MDhTS0JBRXA3RzJSNEFZOXFRVGpFSWthTFhuYmo3?=
 =?utf-8?B?c2tpTVlsdmJhUXVQYjF6MFVrc3VrMUVrNm9uN2ZsYXJubGJ6Uk5sK1RXV0lC?=
 =?utf-8?B?SmE0UWwvS2Y5bllrNkoxM1hkdGdKdm5ZQWtSRCtWbXZDeGVtNWNCNmpwcjla?=
 =?utf-8?B?Q3NzTmdJS0JMZnV4amZmRVRkRzRtSTltME51M1Y4RjM1R0o0MjNhczlRaW5x?=
 =?utf-8?B?Rk9EWWFGcWUwZEI1Y2Vjdlh6SFUzSnR6QWxQZzNKMGw2cmNwdmE4NXFscUtP?=
 =?utf-8?B?ZXdOYTlpYjBLdUNBUkRieHNIYWV6U21WM0krSEVnaEp2Q2VyRElxTnI5SGVV?=
 =?utf-8?B?T3Fnd0xDUDErc2wvT2hUSGRBSGFpVm1HUnlzWDM3MTYydDNTL1VXcytLS2pa?=
 =?utf-8?B?Z2Z5QmwzOENvN3kwSi93WHBONUEwNVJVZjh3WHprbDY5U3pDYW90ZTk5SWVp?=
 =?utf-8?B?Z0dTNTF2YXpRNFFmNkx3VXlvT1drWk5GQWE3TllITUhPczlVMG9VcFl5Z3dw?=
 =?utf-8?B?UzNURXpzN0puaE04VUpJNDAzUi9OUDJYQ3hZd2JXZlhDdmZVVDFNL3RZaFNU?=
 =?utf-8?B?cFppZlRWRmdhdTl2RmZpZ3UxTXJhZHE4ajFNc05rK0Z4TzMzdTk2djZlN2Uv?=
 =?utf-8?B?QUtQbkY3a25qRzZIK0VzS0VaZXUrQm81R3E2UWtOZ2pYaDlpdXlrUEFRU2Yy?=
 =?utf-8?B?Y09DUVZERElHS3ZjQjZOdm9TQ1VndEEzQWhNOUtaeDFwKzNMTlpZaXR1NGhB?=
 =?utf-8?B?OU0xYXk5a3BhSFRHMnU2SjdrOXFpMHVQV2VxaEtGaVZ1VHBpSy9SZ1g3eFVk?=
 =?utf-8?B?NFAzY256U1FoV2lka1p1UkdFWUtPc3N6TC9Pano0bkJTS3ZYcFVxRVovWVQz?=
 =?utf-8?B?UzFCd1NoOWlNNENUbFlMKzZPYTNUYTZKajdKUXdCYk1CSmx2T1RRbGtMZHJq?=
 =?utf-8?B?eHBXMDNjRjVxL0dWQ2d4MFZjSHhzRFErVVNTaDZEcVFQVW5rbmVjdWpjc05T?=
 =?utf-8?B?NkdTMWNKVm5DQlJDdkZUZTZPRnJDZmo3RkZJQTVHU3J2YXp0bDl3d3RhcWU4?=
 =?utf-8?B?bVJvTk1RWW13SzduYjdhL1R2NUhpR3ZnREFBRmJIMWR2a0ZtZXpkMmJnZVdp?=
 =?utf-8?B?RU1BR3p1ZjZ5bTJwUVhrOThOc2g0NXRxMHA0dHZCT0ZIWmdQODdRSGJSRWNq?=
 =?utf-8?B?MFZ1UXBETm95ZytDR0dnd01vZjFOL3VhVUJGbDRTQ2JWWXZlSWxmRFBpaWd6?=
 =?utf-8?B?Q0xETlg5emZHWEprOGhPdGZkcnJ0WXY3NHQ1d1g2RVBFaUMweTBpK2VrNVY5?=
 =?utf-8?B?QUQ5a0kwNURQRHFURTFxNzFqdlkzT0JpQnZ6VXh5eElyNmpwYzlEalErT2JQ?=
 =?utf-8?B?REUvZU1QQ2M1T09hVUVXNzhFNlFGU01ObnhHRlpXWXQ3ZHI5SDJsOFl6ZHlW?=
 =?utf-8?B?c1Y1eGNlanpkLzNrQUtOaVFwbDg1OXdHeFA3czJaWTc2TnU0bzdJKzdqOFJj?=
 =?utf-8?B?bHA1YWFzY0FhZHMyMGIwdWtpVUx1TE1MQlVuR3ZjTGdvWlVrWVFSUHNmMUd0?=
 =?utf-8?Q?X3NowRPWvt8YMrreuQH9E5wLJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910255e1-685c-46b7-7d76-08dddff00e43
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 13:47:08.3341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnCUZo5VLRXbN4yr59BV1zg8ZKqIImswMtX4Lwta+cr+ijOzZNlYFaZFuq6E33ujxCo9ombAGZiNrfKmuehhrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 20 Aug 2025 13:47:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2070


On 8/20/2025 2:02 AM, Lee, Chee Yang wrote:
> I got this error while building the recipe
>
> | /data/scarthgap/poky/build-zephyr/tmp-newlib/work/cortexa9-vfp-yocto-eabi/zephyr-openamp-rpmsg-multi-srv/3.7.0+git/git/open-amp-sys-ref/examples/zephyr/rpmsg_multi_services/src/main_remote.c:26:2: error: #error "Sample requires definition of shared memory for rpmsg"
> |    26 | #error "Sample requires definition of shared memory for rpmsg"
> |       |  ^~~~~
> | In file included from /data/scarthgap/poky/build-zephyr/tmp-newlib/work/cortexa9-vfp-yocto-eabi/zephyr-openamp-rpmsg-multi-srv/3.7.0+git/git/zephyr/include/zephyr/toolchain/gcc.h:98,
> |                  from /data/scarthgap/poky/build-zephyr/tmp-newlib/work/cortexa9-vfp-yocto-eabi/zephyr-openamp-rpmsg-multi-srv/3.7.0+git/git/zephyr/include/zephyr/toolchain.h:50,
> |                  from /data/scarthgap/poky/build-zephyr/tmp-newlib/work/cortexa9-vfp-yocto-eabi/zephyr-openamp-rpmsg-multi-srv/3.7.0+git/git/zephyr/include/zephyr/kernel_includes.h:23,
> |                  from /data/scarthgap/poky/build-zephyr/tmp-newlib/work/cortexa9-vfp-yocto-eabi/zephyr-openamp-rpmsg-multi-srv/3.7.0+git/git/zephyr/include/zephyr/kernel.h:17,
> |                  from /data/scarthgap/poky/build-zephyr/tmp-newlib/work/cortexa9-vfp-yocto-eabi/zephyr-openamp-rpmsg-multi-srv/3.7.0+git/git/open-amp-sys-ref/examples/zephyr/rpmsg_multi_services/src/main_remote.c:7:
>
>
> Build With
>
> meta                 = "scarthgap:6f7e929ea6ea557f107c8ccffea69a7d73439591"
> meta-oe
> meta-python          = "scarthgap:c29a18fa39ede952f3f6108ec007c1906e2d9a0d"
[Sandeep]: Looks like you are building for cortex-a processor. rpmsg 
works for only these platforms 
https://github.com/OpenAMP/openamp-system-reference/blob/main/examples/zephyr/rpmsg_multi_services/sample.yaml#L8-L10 
I used "MACHINE=qemu-cortex-r5 bitbake zephyr-openamp-rpmsg-multi-srv" 
to test this recipe.,this way we can avoid the issues. I can add a 
machine compatible for only these available machines. I will send a v2 
patch.
>
>> -----Original Message-----
>> From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
>> Sent: Tuesday, 19 August, 2025 6:03 AM
>> To: yocto-patches@lists.yoctoproject.org; Lee, Chee Yang
>> <chee.yang.lee@intel.com>
>> Subject: [meta-zephyr][scarthgap][PATCH v6 10/11] zephyr-kernel: Add
>> rpmsg multi services recipe
>>
>> Add zephyr-openamp-rpmsg-mulit-services recipe to build out of tree
>> openamp-system-reference example applications.
>>
>> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-
>> raju@amd.com>
>> ---
>>   .../zephyr-openamp-rpmsg-multi-srv.bb         | 23 +++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>   create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-
>> openamp-rpmsg-multi-srv.bb
>>
>> diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-
>> rpmsg-multi-srv.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-
>> openamp-rpmsg-multi-srv.bb
>> new file mode 100644
>> index 0000000..222ed2b
>> --- /dev/null
>> +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-
>> rpmsg
>> +++ -multi-srv.bb
>> @@ -0,0 +1,23 @@
>> +SUMMARY = "Open AMP rpmsg multi services"
>> +DESCRIPTION = "Open AMP rpmsg multi services"
>> +
>> +inherit zephyr-sample
>> +
>> +SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF ?=
>> "git://github.com/OpenAMP/openamp-system-reference;protocol=https"
>> +
>> +BRANCH ?= "v2024.05"
>> +BRANCHARG = "${@['nobranch=1',
>> 'branch=${BRANCH}'][d.getVar('BRANCH', True) != '']}"
>> +
>> +SRC_URI:append = " \
>> +    ${SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF};name=open-amp-sys-
>> ref;${BRANCHARG};destsuffix=git/open-amp-sys-ref \
>> +    "
>> +
>> +SRCREV_open-amp-sys-ref =
>> "d78315763fbacba8a74552d0ad570bd01c42ccf9"
>> +
>> +ZEPHYR_SRC_DIR = "${ZEPHYR_BASE}/../open-amp-sys-
>> ref/examples/zephyr/rpmsg_multi_services"
>> +
>> +ZEPHYR_MAKE_OUTPUT = "rpmsg_multi_services.elf"
>> +
>> +EXTRA_OECMAKE += " \
>> +    -DCONF_FILE="prj.conf" \
>> +    "
>> --
>> 2.34.1

