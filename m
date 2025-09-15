Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AA9CAC597
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 14:14:22 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.14])
 by mx.groups.io with SMTP id smtpd.web11.34819.1757945654598391825
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Sep 2025 07:14:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=EIy5SD5S;
 spf=pass (domain: cherry.de, ip: 52.101.83.14, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqPodbliJDAiHtZbLV9Msb7GeLUDVM6gGAd4EvWh4qQfq/2B6Dmp3XkGNf9+O+YHGrgadY467hC3FT8fUWQjUBq9b8RPPrlmizIwR+as+94CSt+TK0VdqpHKofYXOnjvPbufqprF1e7GcAt2NLme5ZD0UiAuTCN4V3L2AULz3Hx2b9ibhRXj5NKif8uxZONsfdInDBUmaBDGwwCaZBFUrTJfvpGa9j1XlQB66odsNuoudMDTia5IVzvgIXByYGRNFQNP4CE+ggGtqRs1M07TDy/phnAEddKznsCic6EYkPLGpJACiz8COoGzJlvE5NVv5Z2jmzM4BQ0i6KFwHqnm/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1XvcPX3UUqT6poIz0g2TbPy+4kZYX/7tkFBgMGo3Lo=;
 b=XG1ShkPGiNyMkS2jlswtaqmA2Vwkw+Y9vhMx/bW2RWyaMa7GqL24s78PiF8Hszhb5NQLVtYo9Pfkba7e0gVjzt6otPy3HOzgy8qqir7Ybu1pF2VpDYiqFrr7Tlr68O9Zf0P6xP1lUPLz0+KoJdczFrmy2Sb8JYXvmG2kzFOI580pYlpbtDP610KAGSifpJbPLPtGBM26L6ivKSbRQx2mSKzpgx0+F1G2dpyelrvXPIxmVCvayTSJSRuACATGsbb/WT9XhXWo5mSA7lhYG/Bc7mRR+wkKzdNMSsxFfAXbPB+UTQKNiAUZiZCsADmc+z1xWouMj6OXg9eWFbtmBh0YlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1XvcPX3UUqT6poIz0g2TbPy+4kZYX/7tkFBgMGo3Lo=;
 b=EIy5SD5SPAHs/UpZqpFw43qdIVPkMkip+xSGPQvoNVCYK3GtEN88tAIR7TbWUcfVMz5Ke3fLuarm58DbiezmrblsT21l+I/ENXk3oVFgs2eWo/VWXHyz9RN1hCNYzkGJfRxuAWT6MaVRIKqmjSg7s9zVO6o1yaZ6vx+ckGZwIeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB11499.eurprd04.prod.outlook.com (2603:10a6:150:288::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Mon, 15 Sep
 2025 14:14:07 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 14:14:07 +0000
Message-ID: <855eed1d-569e-414c-a557-b53d733e70a9@cherry.de>
Date: Mon, 15 Sep 2025 16:14:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH 3/3]
 scripts/run-docs-build: pass version to bitbake docs build
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20250915-pass-bitbake-active-releases-v1-0-a5530a97b9ef@bootlin.com>
 <20250915-pass-bitbake-active-releases-v1-3-a5530a97b9ef@bootlin.com>
 <880f00bc-7c10-4721-9091-22d9f046d304@cherry.de>
 <DCTFJ4BFB3AB.O63TQ09DHXVW@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <DCTFJ4BFB3AB.O63TQ09DHXVW@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB11499:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fbd226f-ceb4-4030-a549-08ddf462220e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cXRzYVB4OWZLTWZmeEE3UHRtc2NMZTlTa01WL015SFFQSEVxTklLK1czdXZ2?=
 =?utf-8?B?cFRRU3dOWG9BSTdrd3VKN3Y0WFFnekc1aERVU1VTS041WXd6dFFOazVhYzRl?=
 =?utf-8?B?dDVPdnd2M2lDMFJLaHF6Z1dOMUd3N1A3anhKTmZqcnBoQVhGQXhCVGNzUEtW?=
 =?utf-8?B?R2RJaElreld2ZHFPMGdGSVUyVXdnRU1TM21DT3Zoc0FvQ3dmbjIzSFFkckFn?=
 =?utf-8?B?bXFTSnF2TDgzQUJsNTBzZE9zVXBVSnBhVHpHL0NJSG5hMC9qQUdEUFBPeUxu?=
 =?utf-8?B?N1QxTjZNRnp1TzZoUmtBcE16di90c2tEN05KVzY3MFFKSFNXMCttL3VzWE9D?=
 =?utf-8?B?OG1mdGN5RnJNRG13RWNtZ0pCaGZ2eWhVK2g3MU5TU2c2dUlkK0pXWVEyMUN6?=
 =?utf-8?B?TTc4VWtKelcrR04vTEpuNVhYc0Z3ZzZROGlVeGZQazVrUGpiL2g0UGRzRC9C?=
 =?utf-8?B?K0ZlRXFqUy92Z21GLzJwOVRhaUdDeml3OWtSeHNqQS90UDVOYVZNeFJndHV5?=
 =?utf-8?B?WSsrTEpHN2tsNmhwMEhIRzhiT09HM1g2TW5JWTBvQ2pTRWUzaDd6ZUFxTllF?=
 =?utf-8?B?cVRsRzJ5aTdPY0FtbkdvRk5udm9CZkx4VU55WmN3RHlPN2k3MllaTGxWdVJM?=
 =?utf-8?B?ejYreXpHRVFMQmozbWZJNzZpSFBkVGtXNTMranpsTXJXVFdDcjBPTjhRL3Q1?=
 =?utf-8?B?VTNHK2VxV0tqTEd4QVo0QndVUXZ2TUp2RkNiQkNUdGFOR2EwQU9jNzYrNTVj?=
 =?utf-8?B?b3I3dXZmWldvM1hINlBoNjkvZmhhSEFNMndyczh1WENTS2ZGRWowckUwTS9i?=
 =?utf-8?B?aDZMRlE4RlN0SUppeGpjVG8zQVNicXR6MW82OFBQVm9vQkZuVFdYN1VpbFFz?=
 =?utf-8?B?cUpFR0NHTzhWb3BqQUgzTG5hWVJISkVQNEMvcEhvVU9WTXNsVmVSRG4vRms2?=
 =?utf-8?B?dGpwV3BWUDBkeDlKV2JjVnRCZHFPWDRmUnFYajQ2eHZOY084SkU4ZVdZL0g0?=
 =?utf-8?B?MDZxNnRHVWFBUjFxT2RlUTNGZ3M4YmlJbEpaODFJQ0c0czdFZDdNVUlVWXFW?=
 =?utf-8?B?YmxzOGQ1R21oclZuWmZXS1piTHh1ME9uYXcwT2ROYW0wUk5nMDJUOGV6TzRa?=
 =?utf-8?B?NFNpTDFneVJpNllQRExXMWNUMnA2Nm9mbWJXSzFIeVd4Z0hMbXl2M0NtRWVa?=
 =?utf-8?B?a1hXNG9nNC9GWFczT2VSemxkdkRXSm1MVjlWenBaelk4R0F2bjIwejZocXd5?=
 =?utf-8?B?UldXUkl6TWpTWWxaaEdqWC9ueTBIWDhvbHZBVnk1R2NCZ3FwRjRyVzlmb3Qv?=
 =?utf-8?B?OUxtQ0xrdENkWE9aN1grYlJxVDVhdS9XSTI4ZmxHbG5rZDA0MW1pMGQ4azhB?=
 =?utf-8?B?L2V5dEFmMEpmR1pqbjBtY2dMVzFIOVBUSjdkcHFlM3dkTU9sUHNDQ3M3Q0Vi?=
 =?utf-8?B?N3ZOSHZHMGliV3ZWTnhrOWxGUzRJN0FxUXRWYVFMMnoybG5tSWhQUU9zRDFZ?=
 =?utf-8?B?Zm9ocHVPdVFyNk0xdWd2ZWhjcWFlOEJlRk5WK2U3UWRZaWFTT1l3dTMvUXF2?=
 =?utf-8?B?RnlKbGx2T1Y5TTBEQS9BQ1RIMTNlN056SklLNU1lRTAyMGovL0Frdmo1aWpJ?=
 =?utf-8?B?SG5SWTJEZno5dEZLaGExb01ZMHcrRXowZy94cGR4bThIdURiaVNlTUlSNEds?=
 =?utf-8?B?dkZicGVVN0xtYkNhV1JkQUZpVEczcEY4WXRPaDZlQW5WVTg0N0U1L2d3SThI?=
 =?utf-8?B?b0ROWGwzUDROT21vd3Q5ZGZmT0NBSzRpZVFpZHMvVDh3WGlzak9yVXM5bTM0?=
 =?utf-8?B?N2tSYmt6S2tPanlCZHVZZVh2NlFBUEFpa2dwUkVzSTBMNmd4dEJUSkpoeEhk?=
 =?utf-8?B?Q2dBSHFHbEtHYUpXZzh3OUZzeEJENWQ1WTFKWmc5OG1aV3o5c2JxamF6b3RH?=
 =?utf-8?Q?44nBZhCXbxQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MThKeUpLdEdMZENkR0xGeEdzSjhINkFaUStJeWxJZEM3bDl0cTZlbzlEbjZn?=
 =?utf-8?B?SzN1OUJ2Z2RUYVExd2FqYVhEWTJSSlJ0eUtreGUrNG5wRENPRkF6OWY3M1dH?=
 =?utf-8?B?REdXYW1IRG02TnRMdW5adHUrVVBMK0R4QllIdHBNaGZ6ZlM5alZyRzMrelpF?=
 =?utf-8?B?WTZ6RngrY0RtN3dUeVdCa2haL0NMZFNlUUxTZmJ1YWUvS2hTOWp4YmRWeHlB?=
 =?utf-8?B?V21YbTVGZW5CUWQ5bGdGSC9QcU5LcE1HRWZjMEUzK2lPcXhjVExCdkgzZjkr?=
 =?utf-8?B?WEtzNU5CeFVxd2lZQ25zdTBYbU1uRTZCaGFLWUh0VFh1UDMrYTFQVXBqY2k0?=
 =?utf-8?B?eE05eHhROS8wSjJzVWxaeFpJUFczMGsrcm43VTJsd1BOL1YwS1dYSDR5WFo4?=
 =?utf-8?B?V2pLSnlzaUVyZlhVd1lJRlNIajBpaGpXeStpK2lyVGVuaFZyeW9zMmlTaUti?=
 =?utf-8?B?UHN3czgyNU1iTUMxUWxaZWpMZTM2OEtDQkQzUXUvVUtidXRhM2FBWEx0VUI0?=
 =?utf-8?B?Q2NXNm9UYldCd1p4cVkyVFZYeDBFd3lnK1ZNcWhLNHJUbFlJTWRpS2FZK0tL?=
 =?utf-8?B?TDB0L1lBSE0rTGIvL2RhNCtrNi90eHdsRUdxcEFJTHZLNlhHaHd4L1JrRHgx?=
 =?utf-8?B?b3NwRWVic0ZvQ2VoMHgrTUtSYkZLdHROakZyc2tuakpjK20yTEpsdUE3R1Rj?=
 =?utf-8?B?dHNSTnVmRklNMDNyUFVXYkNaWk9kQnVyU0ovbTZrR0JRV3RyK2hQMFRNSTZu?=
 =?utf-8?B?SzZzRnMwckhQVVhMYTJzSUpuMHM1U3lHa1huNGo5Ky9iN1N2TTRJU3p4SXVz?=
 =?utf-8?B?SmpYcW9zQ2VmRFY4SytoZE55eEtNWWFPVFNyUkpveE9nVjJHQjlNUnEwa0t2?=
 =?utf-8?B?eWN2ZGNSODN6OGxKT3RHdTdZSkdyNHRNenBZQlN1dGRnclNsM2xBRWp2NVo3?=
 =?utf-8?B?WnR3d1k0aTlMWUtRdUlFSGpHVjVseCtUREd0dmZ4R1FTbXBpSmRRcUhZalRN?=
 =?utf-8?B?TWlxSUpieVZFam9scWwvSko5bFdIbDZ4d0pSSGJZQlJGU2dQUFR6cFVYa0pW?=
 =?utf-8?B?VGEvTUZDYXZVZlNnelJNaUtzdFNweTBLVkpBb0ZsS1dlYVVoUlpLZkl2d1Uy?=
 =?utf-8?B?ekFCMU5aZE1oRXJEN3ozbXpuNm1xZFRIU0Y5VDVjSVJYakcrRUdhVUV3R3lo?=
 =?utf-8?B?bzRDSTQ2LzNkT1g0ZFp1RnRTNVhuUFU1T2RYQ3pLZlpUNHRNbDJlR0lpUmNv?=
 =?utf-8?B?ODlmRlFReG5kTDRpbWVyYnlJYkNuQm5odDM4UzJOc3ZkTEJsblFuSkJSeVRJ?=
 =?utf-8?B?OFVIakE1aU5WUU1weUtqeGh2SDl5OTJYRDA3WEpTZitzbEZITUVyYWlwbkdE?=
 =?utf-8?B?aGsza2lJSWFrKzFLdWZvUHBZaExGelJ0OTJMYVJraWdHMTdpcDJpdGN4U1Vs?=
 =?utf-8?B?aE9RVnlSMTVvR3VvdThaSnhUMHBKYmljSE4rL2xFNXRydEI3N1RVdGhXUHBx?=
 =?utf-8?B?Rnh6Y3ZMRWVFNzRrSDZneHJpelR1TllpT1d6cThuaVpDa0xObkRYZll5S0JI?=
 =?utf-8?B?d1YrTVE1NFJEVDZHejNkRXFPNHRUNlpaVmljOG1TRGVZQTBpRWYyZGZRZndO?=
 =?utf-8?B?eGM0Z3RDenh6OGJGc0FiZmlZd0ZUaFlHWXp1OVg4akw5eDFMZG9jSWN3TlFy?=
 =?utf-8?B?TUUxSG43T3RJS2F0b01FOHlQRzg4ZXBOdDJLb1pOT0hMcThJNFdjdTd6YkVG?=
 =?utf-8?B?aUhTeFJ4ZXZ0SXRIWUVqM3ZXZXpnbS8yUWxCWCtwcm5vb2pkRS93L3hZcVd0?=
 =?utf-8?B?bWFpS29LTmV6aGRXczNTWXIvUzA4OFB2UGxNRm9XaU1TenlVTGxrdFdqY0pN?=
 =?utf-8?B?YVFPSXYycURRREtqOU54TVk3cjBBRldiY2Q5U0dmbzBpOEpQNWVwTVJNK01F?=
 =?utf-8?B?M2FOTWdCekdlMTRHcUc3QWpwdTdXY0N3MGtxNkRIamZrc1Y4bm5lVXk4ZFk5?=
 =?utf-8?B?NVBDOTJRMExhRUR1QUNZUFJwQkVJcHA1WDZVbTZkV1JRUWZCY2tlenlOcW9w?=
 =?utf-8?B?MmJaSlpMOFhsQ2h6MG4raFpRS0FOTXRqczluYVFxOXhML1RIK3lmc1VFZmVZ?=
 =?utf-8?B?cTBpSkZTcjgydHdpVmJQUmUrUW9PT1ZYaGtDeVlSQlk5blE3R2VOQnM4VjZD?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbd226f-ceb4-4030-a549-08ddf462220e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:14:07.3970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kJMKx7RkPAW/H3+8ki0tQ5mCSZrcwdmTgLF+iNh0zoD/ZPVho5khWnlZLyzloWOHLMvN8WN2cZILe3IGfDQ7eP31G5TGXGie/GgRgBoAho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11499
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 14:14:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2200

On 9/15/25 4:05 PM, Antonin Godard via lists.yoctoproject.org wrote:
> On Mon Sep 15, 2025 at 3:30 PM CEST, Quentin Schulz via lists.yoctoproject.org wrote:
>> Hi Antonin,
>>
>> On 9/15/25 2:19 PM, Antonin Godard via lists.yoctoproject.org wrote:
>>> Bitbake's conf does is not aware of the current version it is building.
>>> Pass the information, which is read from bitbake/doc/conf.py. We have to
>>> checkout conf.py from master in additions to this, so this change
>>> applied on all branches.
>>>
>>> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
>>> ---
>>>    scripts/run-docs-build | 8 ++++++--
>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/scripts/run-docs-build b/scripts/run-docs-build
>>> index 549032f..654b401 100755
>>> --- a/scripts/run-docs-build
>>> +++ b/scripts/run-docs-build
>>> @@ -138,7 +138,11 @@ for branch in 1.46 $(git branch --remote --contains "$first_sphinx_commit" --for
>>>        git checkout $branch
>>>        git reset --hard
>>>        git clean -ffdx
>>> -    git checkout origin/master releases.rst set_versions.py sphinx-static/switchers.js.in Makefile
>>> +    git checkout origin/master releases.rst set_versions.py sphinx-static/switchers.js.in Makefile conf.py
>>
>> I don't think that's a good idea.
>>
>> This forces us to never update any plugin conf.py uses otherwise we may
>> not be able to build earlier versions of the docs.
>>
>> I would suggest to follow what we've done for yocto-docs which is to
>> have conf.py read an autogenerated poky.yaml (we can call it
>> bitbake.yaml if we want) which sets the version of the docs to build.
> 
> I don't really understand the advantage of having a yaml file for reading a
> version value, instead of reading it from the environment. I asked the question
> in another thread though so you answer here or in the other thread, up to you :)
> 

Being as close as possible to yocto-docs's makes it that easier to patch 
and maintain whenever you need to.

Ideally, we could even just copy paste the whole script and it would 
work on both repos without changes.

It also means that if we autogenerate it the user doesn't need to think 
about anything, they get the docs, they build it, they get something as 
close as possible to what we generate without having to have to look at 
the yocto-autobuilder-helper does.

TL;DR: for consistency sake.

