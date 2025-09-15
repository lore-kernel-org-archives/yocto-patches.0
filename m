Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD2DCAC597
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 13:32:02 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.61])
 by mx.groups.io with SMTP id smtpd.web10.33464.1757943115866307050
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Sep 2025 06:31:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=e/snemdA;
 spf=pass (domain: cherry.de, ip: 52.101.70.61, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHPEDz8HNL97TA5j11/0L5G6vBlNwNY6PhxZVup3gAwrCIoEHWEhWKwndRI59dDvnhf+A10j0eyBDnC33ZrsWSQyOtn+iVPlFtr+lnGrzfJyhhFvbasstyd8Ru4V3VMRnNN4sttD5OhMwqY/JLhbAfj7KFYApij/0iBHevvJ54274AYvmkkrMP68He+Z39bmcJEDT7DWBH7r2SNiprBp1Nnu3PAYSYD/Vbk6vOmWvWDdTbWvsb9orZUybuJ8aM2fPKEd32eZ0RikKi07UuEHZ9mLFfFmt+7Ia7PxjNGTaMOyMy0YMkTmmBp60tUoXBtzkJg5dFE8aJgAccwHmxYGZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0ADE/ULVYGGM6T/RekgRPP9C5PArjZq3v2iXc62pFg=;
 b=Cdw1+IYYvy0pdoqVhJTuU7lzLoj6x7Rc6dGluhiFdzXXIMvdyibPJ8uAhzB2N4HULXTzM3VfybVwgg7RhqDxK8AwHTBrp0YhMQq0N9nw3A8dTHxGoWXXvC017qZWGJYSdIODIFZpC0+0yUOVwdiZsvnisnmCV2k+lQkUG6NHAleupNr7krXL8rZQLMFcJupfDmJIEfS2UkYHMgMry1i2q5EJrvTxeofZ86ujuFAfhekn3CBDEGTa6dz4G9JjJEduib/D6uvsQUCK53s0ekKk6AqfraWM3Fw5i5krirahmCVA27qmc8UKjs0eUkWIaZswSySqgHy+tvVjOJSkS3hzXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0ADE/ULVYGGM6T/RekgRPP9C5PArjZq3v2iXc62pFg=;
 b=e/snemdAKoU9WkT2+a+EJOrea7d51vAhZeQKPtKptmIu4SifVABuxAUB8SyQ/0L5zmyfwNlP2Xp0Dt47IIfY08s/rd4HFq/zoccv3BsbYhPM5r988BJBZcasDQgx2k/VAFHJJmjTNJQhZTCvhJjp6L08iIWsNA9kpHBl50tIHDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9230.eurprd04.prod.outlook.com (2603:10a6:102:2bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Mon, 15 Sep
 2025 13:31:52 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 13:31:51 +0000
Message-ID: <4d2ad38d-230c-4719-b517-db79bdc6725d@cherry.de>
Date: Mon, 15 Sep 2025 15:31:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH 2/3]
 scripts/run-docs-build: pass active releases to bitbake
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Antonin Godard <antonin.godard@bootlin.com>
References: <20250915-pass-bitbake-active-releases-v1-0-a5530a97b9ef@bootlin.com>
 <20250915-pass-bitbake-active-releases-v1-2-a5530a97b9ef@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250915-pass-bitbake-active-releases-v1-2-a5530a97b9ef@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0402.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: f738b96a-b771-41d9-fba7-08ddf45c3adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?L09VMUtvZW02SlBiVThQWTdpaFp3NlpzeHNyMGNqQmJINERaOFRJZlkra0Q4?=
 =?utf-8?B?QlF0dVZBVm5FRU5hR0ROZU5pVEtMVnV6WFBRaUVUOTc3Q3dxelpaemw4dU0z?=
 =?utf-8?B?MTdaN2dpU0VET3BZajFHM2ZzMmphODlOQmkzVisrYTI3eWhVM3N4R2l0NGtH?=
 =?utf-8?B?R0RhSkF4d25oWmUvbkVySFFYRm1kT1l6SDArTEJaL2hqa0RPNjhvaTJmQ0Uz?=
 =?utf-8?B?dVIya242L2VhbmQvamVBMFROemhEOThSdUFSemJxd3hJalBGNUJiQ1JCSUVM?=
 =?utf-8?B?aUlzM1ZqZWdVckdhb3NjN1RBOG1GNDE5bmhubjhaMzZQNVlCMFBQZ29lMEE3?=
 =?utf-8?B?bm9pMmU4cGJEOVlFVFBFKzBHb2xGZkU1aHljVGNQeVk3MDJuS2VBaXdSdDBi?=
 =?utf-8?B?OEFGanA5alhQMDEwVkdhQjh3ZzNRNDlFOWhmM3pNOGg1VlE3bUcySXJJWHpo?=
 =?utf-8?B?YnF3MlE2UktGT25sY1NWZXJCTnBKZlRic1JDbFMwdW9GNTRQbWRHbHhDcUdG?=
 =?utf-8?B?cExtV0J1R3ZrU1VHTXdQUnhCMzB2VHFmbTdFU2pUUVR3ZERrRHhMRDkreldH?=
 =?utf-8?B?YU5ET0ZwRGVIRFc3T3M3RXFEUytJbWJXQU9HWGhjazU3TWpxZURhOHhmQ2lU?=
 =?utf-8?B?RnBQZ0EveHh3NXRUYUd6UW5mc3JWSERabHN6aEFDOEg0aHhIaHRKNmdSaDZQ?=
 =?utf-8?B?UFBmZkhJSEF2UVJOWE9TRmJzU2RDajg5Tmx6U2VOdGtMa01kYTA0akxzeE9O?=
 =?utf-8?B?Y1RVVExCZ2U1cXJDeFVkTW00TjNpVzFoR0ZuVWJyWkU4aE55WnZXNVl4Q2tG?=
 =?utf-8?B?ckd3UzRLZWx4My9FbUpmUC9WUldBUkJSMGRsaTBLMXAzRUdaNnprckE5M3Rx?=
 =?utf-8?B?dW9yaVBndmo4Qk1vc1Z5SjFPZmJ6TUpCeEJyZ2JzckQ5ZEdmWlNGS001L2dt?=
 =?utf-8?B?VytYaVI0R1lmMmZZWSt2OEIvWGhlV0tLZk16S3E1eHZzbGNmd3dJanVwMnpp?=
 =?utf-8?B?ejBTYzhFd3YvZFF0UDRjbzk4SEJlbXM5aVlMd1RBRVBFUXhKbXJBTEMxRlAv?=
 =?utf-8?B?L3gzMWdzZzZTaWRZYzBGczl0T2JNVjBPc08zcENTeVNzd3cwOXNhOXZtSkJJ?=
 =?utf-8?B?eUZwZjYxY2tpUFhaTTlTRWd5NzVkUG1RbWJoMGZjeVdncVRpSnd5T3hIZ1Ar?=
 =?utf-8?B?cG9KaGtWbmg5RlVpVU5rZXJ2RVoxNlhKUE9SUW85WXVKd3hZTWE0dVNzaEVv?=
 =?utf-8?B?OEFYU0YyV3ZvdFdyclZPY3c4eGsxK0o4aUdRQXcrL0NOSEpMUExhTDk0WnB5?=
 =?utf-8?B?MllMRG1EeXZkKzdPY0NiSjdJQnJLbG5TWVRUQkFyTlZVdDV1SXlIakYrczVQ?=
 =?utf-8?B?ZC9FUE9TUjRkTFRMbGp6OTh2empmbFVJcmtscllveno3a25JYm9JUFhLZFEx?=
 =?utf-8?B?NUVRMmNEM2g2aVdWUXF5K2pTbU9FYm1pVzZvL2N2dzgwTi9xZTZic3NNM3hI?=
 =?utf-8?B?RXNsWkl2bDZMc1d5djQyejVUTGhneWJSUVRxaFhOdERNTGpYSmhyMysycjRV?=
 =?utf-8?B?ck5yRy95RHhDSXlZUS9pUVJES3VDT0J3UVc4QXVNMm5GMSs3N3VLdC9Fcmlt?=
 =?utf-8?B?SWkwY0dqNkJJd1RWc0VUeXhXK2JKV0xXOWp4V3lKdUJZeXpKMkhHMlFiQlZM?=
 =?utf-8?B?WVR6Q0EzUlNJY2gxcnY3UXRub0ZXTE8xUUpobHNWaWZ1QmgxdWIyV21adWRV?=
 =?utf-8?B?ckdqUXhlbTgxRDZzbGRlODErYTBPUDY1S1VGRzc0SGRiTSs2Y2ZDNEtLN2Nl?=
 =?utf-8?B?ZjNVenNmT3FIeEhYNVY0ZFJFR29NN01ZdXBybXEzeFI0encxZmg0UThCZTFK?=
 =?utf-8?B?ZzQ1c21vTloyN25tZ0Fad1hiMUZIZ0VQQTV4N20rQzk4Znk2b0IzYnJQTjVW?=
 =?utf-8?Q?M+39XOpybWE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZWZYNmN2M1lKZk1uM3lKR3lHOXJUUmpMTlB1VGNmeWtsbU0xaWFTUTJUUStn?=
 =?utf-8?B?THlrSDFVTFg1eG1YSXZzdEYxbGtyMUg4V00rVVJqY1lqQkFldnNwQ3FYUXcw?=
 =?utf-8?B?VGNtZXo0RGZPZndHL0kzRlpyOHNUdjNJcmtSdVFZTE5PUll6S2N0a2NmbkJ3?=
 =?utf-8?B?NjB2WUQzZTYrNnovSHMyWUNFRWEvMnFXL3A4bnlid2lSbUhjVEhKZUxhUlUv?=
 =?utf-8?B?L3VsaGYySmMrUTduMjZVWXg5V3dXV0F5VHVaZVBTaFYzRVVabm5TSitaTnlN?=
 =?utf-8?B?VFZINkl2SGxIL0xBUU51dlowMVNqQ3IrbHlWbU5IU0NROHFWZFVFOEsvOS9a?=
 =?utf-8?B?NThLWlNWcmErTTF3bU5SejBkanNldFhvSVNwVW5TMjBiYlBibmp6OG1FbkFo?=
 =?utf-8?B?THhSeXdKdmE1cGpPelZReEVPUnkzRTkxSTNBQVV6ZS90NkJaYmhSOWxKcC94?=
 =?utf-8?B?c202WWhIcVJudnFjQWI3N01qOENXczV1ajFNL2pWOW51ZjRZTkhaS0lpRzhp?=
 =?utf-8?B?QzdGUTd6cE80L25qVi9ZbVZubE9jUDU1OGZ5S2tyMTRHRDFNNmRmR1A3VFJK?=
 =?utf-8?B?bjhBdXUvTHA2U0hBTXl0YVJ1bXppcjBpT29pUm9rMTh1c004c0VJZmlWNWRQ?=
 =?utf-8?B?cUppU2xqSWxYUHpvT2YxajJ6UFBXdFFzdjRydUxFOXFObkVjd080bVdYbU8v?=
 =?utf-8?B?bFRVa05wRW84K3duMU1peGNWZjNlSUZNYm5BZTdjdzJoRVpjRVBVL2poL3FY?=
 =?utf-8?B?UmRnb3FvNE9obmpueElXcEx0YjZQWGc3Ulc0eXRTYWk2V0ljWXdlM1pMZ2FV?=
 =?utf-8?B?YmxxaFhwR2NLWEMrRmZ3TnBsVWdmeVZwNzlVYm1vYVowZFN2NDZUVjdTbmJR?=
 =?utf-8?B?ak40ZzRsckJKcW1keGRSZ3JOVXJHdTBjNUtYZFRrOUh3czNFcXFod3orSE96?=
 =?utf-8?B?cVV1Ky94L3VGREU1SGVqUjJQb1YvZGV2bW92UGNWaUdnMHhURmlVZTNZbzVD?=
 =?utf-8?B?ZFo3UENNYXZMbmJIWVE4bVpHUHBYYlUvTk1IWGVGRnk0UVFUZ0FiMFlKKzBU?=
 =?utf-8?B?U2kyQ0ZaZSs3QkVwUnBNU0FZMEdBOVJoNWVsK2ZKdExSa1loWVJKY2FYdEk4?=
 =?utf-8?B?UHdDWmN0STVNemRIMHdRYmU1eFpka05EeDFmV3BGMVpQSWw5UEg0NXdzcEkv?=
 =?utf-8?B?WmlXMEdNVmt5eTNGYmI3Rm5vTld1UTZZekYrQjNCS2JVY2k4ck1sd3pld3Iz?=
 =?utf-8?B?Wk9QcFBBc1p0QXFERUlSRi95a1FiK3pBT2VOZmg1TjdUWW1mTk1VMGwzRGM0?=
 =?utf-8?B?aVFhbXFMTGJvZW45VG1mWGpJT0dWNi9HV25BZWZJMWMrUyswUGovVHhlSFRn?=
 =?utf-8?B?bktvL2thZDJqMFlYRXFkZkN1aVp4K2VMRXhPeHVoZnYvbnRSV21oUGtIK3NZ?=
 =?utf-8?B?T3V1S2w1dTlRVEx1azM1YTNPdjZQNTl1VUpXM3l4V1BVNDh2Sy9ZOWYzd2gx?=
 =?utf-8?B?SzZVcGp4bVZzSFozRlFod3ZXaFR4NE1IUmNmNFVnLzJYYkVpNHcrM3FJMGJ2?=
 =?utf-8?B?aEVxeUxIbHRqQm5kczJ0c3VRL0F0aHNTcWsrQ3l3RGpUQ2NlT3dlUHV5MFNK?=
 =?utf-8?B?OHVoZWtWdW1kdFAwQnhPMm5Kd2xndWExOHhCOHNDQUNUcUVUU1JiU0R2QlFX?=
 =?utf-8?B?cWxqTjRsenFTRSsvSXBDWUpVSWJhODM4TCtJTGFMV0R2em0vOTRYRmFPV0s2?=
 =?utf-8?B?VzcxSGNKcjBvZU9scmtOYXEzSHB2SmZzZGVTdWtpMGtTR0ROTG1CRzlOZ1Bk?=
 =?utf-8?B?VUM1akhURHgyMWdXMXlQc1VBUUtnQURjdlJSeStDSThXb2xMb3p2R1BsdkQr?=
 =?utf-8?B?NjZOQzQwRG1ibmFPekRIOUU0QVBwQXF1a3lna2w3cG8vQlZwdDBRU01WdTNM?=
 =?utf-8?B?S2x1SlB4SnVaZStoRUErYWpLWkQ1MGhSOFBBZ3h0Y2o2a2FJUks3czZQb291?=
 =?utf-8?B?eTFiM2Y3T2NEWDlzeW1wYVBlRk01SEhJMWxrS2ZoNHhnZVNBL1duci9tV3F4?=
 =?utf-8?B?NDh2b3BqZXI1R2pLYnZFNmgxbndPWm90TDEwN21nOHlhdjZMdTNtdUpCczl1?=
 =?utf-8?B?VVZKZXB0UEIxVEY4T2VLNmRBVFN1S1M1bkk1UndmUHR4QmhPKzBzc0NyTytI?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f738b96a-b771-41d9-fba7-08ddf45c3adb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:31:51.9062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2SUIUgmDcnjrTWWOhOfxgeboSYHgb287dkB503wan+DJyDB+WA+KexR0EQZLP3YZAi8pHO9QNGCz9d7eJSvF2DrZRPyJ0i+Sl4sYLNy6k4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9230
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 13:32:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2195

Hi Antonin,

On 9/15/25 2:19 PM, Antonin Godard via lists.yoctoproject.org wrote:
> BitBake's doc now supports setting the active releases in the switchers
> menu from an environment variable. Pass the active releases from the
> list in yocto-docs/documentation/set_versions.py. This way we only have
> to maintain active releases from the yocto-docs location.
> 
> The latest_branch information is retrieved from it, otherwise we land on
> the in-development branch (2.14) instead of the latest stable one
> (2.12) - at the time of writing this commit message.
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>   scripts/run-docs-build | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/run-docs-build b/scripts/run-docs-build
> index aa1847d..549032f 100755
> --- a/scripts/run-docs-build
> +++ b/scripts/run-docs-build
> @@ -111,6 +111,11 @@ tar --exclude=eclipse -xJf ${docbookarchive_localpath}
>   
>   $scriptdir/docs_add_banner.py
>   
> +# Retrieve the active bitbake releases from the yocto active releases, by using
> +# set_versions.py from yocto-docs
> +BITBAKE_ACTIVE_RELEASES=$("$ypdocs"/set_versions.py bitbake-active-releases)
> +export BITBAKE_ACTIVE_RELEASES
> +
>   cd $bbdocs
>   mkdir -p $outputdir/bitbake
>   
> @@ -121,7 +126,8 @@ mkdir -p $outputdir/bitbake
>   # see the latest releases.
>   first_sphinx_commit=84ccba0f4aff91528f764523fe1205a354c889ed
>   
> -latest_branch=$(git branch --remote --contains "$first_sphinx_commit" --format '%(refname:lstrip=3)' --sort='-version:refname' | grep --max-count=1 "[0-9]*\.[0-9]*")
> +# Get the latest branch from the active releases in BITBAKE_ACTIVE_RELEASES
> +latest_branch="$(echo "$BITBAKE_ACTIVE_RELEASES" | cut -d',' -f1 | sort -V | tail -n 1)"
>   
>   for branch in 1.46 $(git branch --remote --contains "$first_sphinx_commit" --format '%(refname:lstrip=3)'); do
>       if [ "$branch" = "HEAD" ]; then
> @@ -132,7 +138,7 @@ for branch in 1.46 $(git branch --remote --contains "$first_sphinx_commit" --for
>       git checkout $branch
>       git reset --hard
>       git clean -ffdx
> -    git checkout origin/master releases.rst
> +    git checkout origin/master releases.rst set_versions.py sphinx-static/switchers.js.in Makefile

I don't think we should be checking out Makefile from master, we would 
have to keep in mind that the Makefile needs to be backwards compatible 
forever. This is a big burden to carry IMO.

If we really need something from the current Makefile, we can always 
patch the bitbake docs the same way we patch the yocto-docs on the fly.

Cheers,
Quentin

