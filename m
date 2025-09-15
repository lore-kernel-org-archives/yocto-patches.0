Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D32CAC597
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 12:53:51 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.33])
 by mx.groups.io with SMTP id smtpd.web11.32539.1757940822591788253
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Sep 2025 05:53:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=bM4rraN0;
 spf=pass (domain: cherry.de, ip: 52.101.69.33, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWyArpauCiUXJdBgbq2plJE2dFFHA17DXzJ2pneypoNLYohDuNENNR+IiShlwdq8TdAPsv/1mEtPwTxhu619ilt/NudsKPHC1cmtGTpWEjONE/Y+h4KHHGpPjpK8RC1fD2Bqc7v7nAlfvR4z3yeyXVPC+8qfHyy8RQmOKTSG0x2azQVnvqgOvpLdI8ev0KcFd/fTEhD31zGrXzuYUWh02DDbXwY3eMADsmzkCDTSyndiwcMePuOVwY+Bzh1qHOcpvBBdcVKRyOmTHP5O6ZSlZ5NTegIr1jixNMfVVxTRJ7W65lNJrCvldmeBulSedc+hV1cjwPfFSxPWWHxJxs9W1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhV9Ht5+JI0yk9nLAgNsWPOGpT9JES3oARESsnMLzMk=;
 b=L/gSIJOTh4JduPHEryRfeK/rvTGdpcW/785G/ksl2UG5WpRpQ5qlnNoRi4Y+QuTDYlqyGyskYiuPauRlcRb/e1VLzhhypCsOQbF+4vIJ2DbhWgd+hre/Tc8bRKbQs4GTn71q/BaPkZdzJFd9AwR8lc1dFbwL+uXq/kYpJNMPsBoTNQ1AfO7wq5UkCrUPz54yHoyM34AuRmT026tWVmYmQHSW+X4D5RvBjcEvth7OPsVXZXL03eKMZGzvTIdQXzh3FAwiepOClZGI9Sv+eyEHGW2v27TpxnW0J1KzLft2Imfnlra5sxVZYJWhptwSYX7fCLfinCAQKmlJET1X/Fa+eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhV9Ht5+JI0yk9nLAgNsWPOGpT9JES3oARESsnMLzMk=;
 b=bM4rraN0zuRF0Czv0l0hGjEHQLhPd+b5LHl1VypqAvSMqRKCHixNuK6v7YHT8IjS1JZHAygrmFA4WBQB/6tu8gIOjeNZnugrvZfQDHRDZuvzFhumuePtjuwdUJoN3g5wVAJCq2nSe2DTmpEYZKx3bwHHatvy9vr20W0FPw7FWp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU0PR04MB9696.eurprd04.prod.outlook.com (2603:10a6:10:314::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Mon, 15 Sep
 2025 12:53:38 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 12:53:38 +0000
Message-ID: <4519bb54-eb26-44eb-a743-eed5b46e2bc9@cherry.de>
Date: Mon, 15 Sep 2025 14:53:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH 1/3]
 scripts/run-docs-build: cleanups and improvements
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Antonin Godard <antonin.godard@bootlin.com>
References: <20250915-pass-bitbake-active-releases-v1-0-a5530a97b9ef@bootlin.com>
 <20250915-pass-bitbake-active-releases-v1-1-a5530a97b9ef@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250915-pass-bitbake-active-releases-v1-1-a5530a97b9ef@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU0PR04MB9696:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f286bc-0924-41ba-3ef9-08ddf456e38f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SUsxeWhMWk5Ga0dzOFpZQ25sWEpPaEM5VE4yMlhEbHJ4bHBoMk9YQk1KOE9h?=
 =?utf-8?B?THJyejFOa0p5ZTB0Yy9lS1VKVzdiREprOFNmS0xGT2VWNFBjQkdJQVppZ1FY?=
 =?utf-8?B?NVF2TDVqWW1DSVF0YXBIWkVkcm9MdDl6R1NhOG1YbVVYSTFRS2ozYkZYZGdq?=
 =?utf-8?B?T1NPVzlLOW5nai9sdklzd2lUOVJ3NWY4L3NNemlxcUthUlNxNkYwS1c1WmNu?=
 =?utf-8?B?Q05teGdMYk01MzFmQ0tkUDBMaVU1U0FUODFpWXc3bU9vcG1McHBhYUgwT29p?=
 =?utf-8?B?N0pjTDNNeWlCMkFwbkFoaENJYTBVSEF4ZFdVM3FIWGdWWUhERlNsZDBjYXlT?=
 =?utf-8?B?QTQzdDRTN3FRZE5OMi9kQ3JQVnJIaGhvWHRBaE9NRi9MQzI1SjBONEcwSDRo?=
 =?utf-8?B?YjhINUI5NXphc3cyejVXUzlLR0pRUVczWFYzZ2pnSlJUaGZHaEdiQmxMQTVC?=
 =?utf-8?B?WSt4OTlEZTg1V1NTU3lrSDFESmloaEFNOWRkNWdUNTNOdHczR09HaW13a01E?=
 =?utf-8?B?UEhnV0NLRzN6cmNhRnJEQXdtOWFnMzArZ05BdVhXY0JkVUN6ckNLNXJrbFJh?=
 =?utf-8?B?OXlLZHA3UHJQTjZMRFlOOUE3c0k5c2o0MlIwaTNlL0NEMy9ZUmo3UFN2eEt1?=
 =?utf-8?B?WEQ0WG1oTU9Bd25tU1FQUGN0bzArSGdld1gwRG9YVkp6M1h6bTJ5cmV6N3JJ?=
 =?utf-8?B?TXpqdnRNb1JYZGpjSjhvUndIWkdZUUgxQXp3WStTZXNIOEhMek9ZdHUwL3F5?=
 =?utf-8?B?aVJkYWc2NzFWMnk2Q0RMQVlmQ1EyVGU4VWwrQkJkdS9wVmsvd1FaWjVKZTVL?=
 =?utf-8?B?RWlUaFBwWmFrTHBla0RhMmRQbzBtYmdRRWFmem00b0ZzbWNqVDQrVHBlYlBt?=
 =?utf-8?B?T2xraHZ6bG1qMlRGdzNlS0tDTkp5SU9WSDRaSCtucnFwVHhIYUYzRUhZcGVS?=
 =?utf-8?B?bkdDYm8vOHJoekhMM2dXUHczUlFQRWZRZHN6WndWc2Rzb0U3REM5UXRWM204?=
 =?utf-8?B?OEEvbXRNU05CQ3Q1bmZXRWVKazUxN0gvQ1NtTXlTSzVSc2cyNmJ3UjdFYm9i?=
 =?utf-8?B?MGM0bFU5bExLM1ZzUVQ1ZmwrSXcwWTdUeldZUHFwMlBrbjhUdGMrN3laUHBU?=
 =?utf-8?B?YmpWcklaV3ZLclNiRGluNkczb290SHEvWmdkckY1cG5iUkxTSlkvMmFMQmFL?=
 =?utf-8?B?MkYvL0ZJbFl3aUhweXU5ckEwODNFT0RyUmtTSVZ5aFU3WHFMRWluaUdtM29q?=
 =?utf-8?B?cnp0ODhPcHJhcWJSNEJ4SlpDQjk4NXlweXF2bXcwQWt0Um1oay9Zdm9KQ3gx?=
 =?utf-8?B?a2szNnZvL0NkOTkzSzF1ckJrazRPVEgyU1V4bmdxaUlUOVNKSWpTenlXUTNo?=
 =?utf-8?B?aGZhREJVb25aNTdYU3dKZWQyVyswMDkwQzNrbm5Kd2hacW9yZHdCZkFsakdh?=
 =?utf-8?B?K2NVQzJDVkhobUFkOHhCdnNReGFsZU1kRmErbEQ3Skg0QVUzQVNEa1BtVW13?=
 =?utf-8?B?Q0FxQkV5VXZzVExHRm5Zcm8vMC9oMVJENXJxYXp5d2tXUXFMR2pPdFFOVlVE?=
 =?utf-8?B?TVlreDAyZTFQS0ZlUFRTRmlzdW5Wcm5QNlo3NkxrRXRCTFNTMUNPMDUyWnYw?=
 =?utf-8?B?cWFtM3hJSTI0cUlXWjdCdFVmRE9RcXBFaUhYclR4blhSbTZ5aHZUYVdXUXdo?=
 =?utf-8?B?aXcxZ1BPaTl5QUlVcUhndEtJRGRCcWRSNFFZV0dVdFErYkYwREt1Z1hIUFZv?=
 =?utf-8?B?RHFCYVJPcDdLRmRJN1NwQ0E3RHo3dmhrMnFVaXp3ekNRQWloc1lUWjdrZzFQ?=
 =?utf-8?Q?RF/mBX/ESfB8FUA5k+2R81vMAnz4mK1btfnN4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZnB2QktEVWdpZzVSVjF5TEIzbjBJKzFXUGdlWFFYRGtDcHpUbllrWVJzaGM1?=
 =?utf-8?B?a3RZMjdXM2MyR1V6Nk14eWUrUE5TQkx5TFVWeXdIZElwRzRWRExZWk1TTXFx?=
 =?utf-8?B?ZXpwYmVlZE5kOGlyVVU0T29odmJoVm5wTGVxVXJnZXZsRllBMGZsbmdiV281?=
 =?utf-8?B?T2toVk1EMS9BcFQ1VEJrOHJtQXo0ZFNpLzVUaVQ5TmFwUlV4cGNVc0pVT1No?=
 =?utf-8?B?ekxDVExEMllNdzBIc2lhdDNmMXNJSWFQUGZtSHBITzgxVERBZ2ZFRmlMY1RM?=
 =?utf-8?B?K0FOMjdKaStORytQNUxGRzJjMnRnYXpYMjVBNFRJU2NDOW94WExyRGxKZlZS?=
 =?utf-8?B?WXkwYm9IaVYra3M1WktHTHNCQWFGWjZvc3g2QUZzSi9ucHBwMlhQSG14VnJ5?=
 =?utf-8?B?VUJHQUZIUzdELzUvczViRTZZaVdNdUVCQ3liUnRQRmorOHZEa1lycDkwZVEz?=
 =?utf-8?B?UXhmZ0tjTzJ3L3F4VGhFQm9OWjZvczNleE55UllBc0ZHRDdVVXN3aUNXRVVS?=
 =?utf-8?B?YW1SQUV1b1lacnhWS3Azd0x5YkFMWjFaWWxlN3VlR2NWUUtCM1ZMVW5Pbi9s?=
 =?utf-8?B?eTlVWldycFFJYWh5UUlWUko4aDZTNzVEYjhJTlZMenQ2N2V2QzFXWmVIaGFD?=
 =?utf-8?B?Uk93ZTV4cXBzYmIwbSt0amRhZm0wSFA1UTkyTFY5bmVkUE1RRXd1RE1XUit0?=
 =?utf-8?B?NXR1TFB5ZWRsYjlUcCtvRU5kb0ZZL3puSGkrYjdsUUlxTkp6MnBMOEpSa3Rp?=
 =?utf-8?B?WnhlSXBwekM1YnJWR2ZTVlljZHRPWnlSK29qZ0ZZbjJRb2VvU00yQWUxVU4x?=
 =?utf-8?B?S2tVUFhtYmRjSHcxSUdES1d5QUhRUXpESWorUVh3UVdNN3doMmtKWDh3ZzZD?=
 =?utf-8?B?aTRUdmo4ZmtpOHZUOFA2ejEzc1JMd0hQZXk0aVVZSEFyOVM4T0p3VlVCb2o4?=
 =?utf-8?B?clBTVWtiNjNGdndXeEplUWNJbzgzVXZtc08reEpjUTNLZFhMTTRBVzk4QXVO?=
 =?utf-8?B?ZVhEb1hOYlQvLys4MW00NjBKeHZwWlo5UW52dERsMVZIR3padklKVjJ1NXZL?=
 =?utf-8?B?SFFoNXRUUDhiL2xEV0Z1QWUzRGI0Ykdvd0lGUVEyUFlrdy82Q2c3OXYzZVNV?=
 =?utf-8?B?bFRkTFBjODFCVittcUl1UnBVS1NTTDZIcGd3cHNnSW5qTStEblJ4YlhWZVVt?=
 =?utf-8?B?ZGxtZkdScDR6Mm1ySTZSWUZCK3ZqQXd3c2xoL3ZCQXNSTjNaVTltTVZSVjlN?=
 =?utf-8?B?YWd2MlZGMFVBaVdudGNoQzNrTmxPVlN6ejNEMjlGdm5iY1RJbDZsRVpRQVZC?=
 =?utf-8?B?QWo2NkdLcVlUTEJhNktka0l0d3FlOGQ3V29tNUNabEFWQ0pjSmREcC9Xdlk2?=
 =?utf-8?B?eUNDZ2ZKSDhVcTFuaHlFTWkwZmlmdTlYS200QTNkSjRhbTQ5aXNNdytFbHVC?=
 =?utf-8?B?Umh5a0V5cTVCamZVYmYzTSswek5XQjFMcytNaGQ3Q1V1dS9ON3F3ditXSzN5?=
 =?utf-8?B?eUJWZHFwQWxNczN0cEhrSnpXQjVPSHJSWkVzREQyejJQcCtPcmlrQmNGRVJW?=
 =?utf-8?B?TDlKYTdqWDNxUFhnb2pkTGtCOW9JSHp3eEd5S05pamlxb0w0T2poRGp0c1Vq?=
 =?utf-8?B?OWMyYkdhclFSam14bHYxRFk5ejIvQ20xL3N2QVFKZXZFNVlPVHdlZ240NjFq?=
 =?utf-8?B?dGkwRkdBNG83Y0J1Zy9ITnFxb2xKYkdQZW5yMzlLZ29Pck1CMjM2UVNQVVVM?=
 =?utf-8?B?Q1lDREM5b2d5RHFaVnBsdGRrVG83Q1A4Q2tEdTVadGkxMlBBMDdLK1RkTUdM?=
 =?utf-8?B?ZFBjeDBwZzdVbkJaM1M5akNrU3ptNEczbEZSZG5RaUFCbFllRTRieHdBMTV6?=
 =?utf-8?B?dTMySm85dzVHbTd5TEtacHMvRkJ2TTBwd0k0VGN4a204TzVWRWJYclRKNEZU?=
 =?utf-8?B?S3lWd1lnOTQ2bDZ2U0czWi81clRWcjVnVHpJWitjZ2FOdEFuMUpIVmlMQVRw?=
 =?utf-8?B?WjFqL010bWx1WncyY0RqaXJMdVJ0SnZ5cGRDdGNnU3JlSXNZcGRyVUR3ZzdO?=
 =?utf-8?B?SzNRdzNqa2ZjaER6UXBpOFFpUURGbW50VDlrMnJEbVBKRnBDTEdkaS9OSkJt?=
 =?utf-8?B?VVBCNlZzb1k4MTV1dFdxSDJwZE1yK080OUV5UDVYNjg0eTVRTGdxRmRXU2Jv?=
 =?utf-8?B?UHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f286bc-0924-41ba-3ef9-08ddf456e38f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 12:53:38.0358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gV2ljddFrRy2uc/tbtm3NpckxJBpwrLZ7mhqemoAghOtEJ7Al0kIQuL6DykycSVLieO6skXuwZV8s9z7PJO9b6gwiexfR8CVCu7Y820j+XY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9696
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 12:53:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2191

Hi Antonin,

On 9/15/25 2:19 PM, Antonin Godard via lists.yoctoproject.org wrote:
> - Make it possible to override the shared directory to a local directory
>    from environment
> - Make variables that can be overridden from environment variables
>    uppercase, for clarity

If you want to keep exisiting users of this script working, you can keep 
reading the lowercase variant and assign it to the uppercase variant as 
default if it isn't already set for example.

buildtools_url=${buildtools_url:-https://downloads.yoctoproject.org/releases/yocto/yocto-4.1.2/buildtools/x86_64-buildtools-docs-nativesdk-standalone-5.1-modified.sh}
BUILDTOOLS_URL=${BUILDTOOLS_URL:-$buildtools_url}

> - Convert mkdir to mkdir -p when creating output directories

Why? mkdir -p silences some errors. I assume we want to make sure the 
directory doesn't exist already so we don't reuse some stale data.

> - Minor indent fixes and overall cleanups
> 

One commit per item in this list please, so it's easier to review :)

Cheers,
Quentin

