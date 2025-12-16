Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D87DD5B87C
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 07:37:03 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17064.1765870615106905642
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Dec 2025 23:36:55 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=e2i/dDmE;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=4445c36162=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG5egQR1665174
	for <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 07:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PPS06212021; bh=5wNiRnU0aM14WOMrQZsj9X
	JANZMiyraEeCV/u5KioBI=; b=e2i/dDmEu2S2aLTIKlYCrPWdy6om/MwCOaXNHH
	w0ZFAjumdqT+DirVzJnibRa2d8DME1Ud01nHIZAAH5ZRBxO7mZF08Dul78vEQG/y
	3QC4QnAp2VZM3Axmgxe1+bgbxts5jlMUZPX2ZTPJojHHL75T0R/OKIandLVcq5fZ
	63WGISj0IwhjRXP4e3khuDKUlvQ7dQq97I8GiiSyzB6VsKuTkmvltGdMO2g4blo5
	945XW+QVl/XtL1NGEU8YCp6zH2QEgkqQIbdpwwda1+YSOywC4XJlC/sDfFsZDxtW
	LULss4zKBJEidw4qBNhUXySQosrtygn2TOKF6TwvshA2GVew==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012054.outbound.protection.outlook.com [52.101.43.54])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4b0wc0jtaj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 07:36:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDB/N/bPD4XMvOsVGWyhUOrgN42wKIAQk8m6wF1rNbhD8o4uubxbZrFcIeTBw288cKSsg7G9UgfVWqInkoSg65ckMhL3hO5NhujdLaSlu9k/cPWocHMpol/7BAasQ5XefQK7g5E+a8KEgcfJ/SKnd5F3m0cgjsjNkmn64g4tmzSPRS5Rv/XcTRic94lm6b666b4UT3Nk2enLAYpRH5YAYnmxnpMg+mWeeSldIJmSIxToyQh2F8a7qiBH/IpxrQPdczTAWf6yYd9QDp2T/etfOtbPfpHC+0UJtjSPvAkss/Las33sMHUb9DNtzqQrY5zcQRaBvNLW+iwwd3DyJbpFgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wNiRnU0aM14WOMrQZsj9XJANZMiyraEeCV/u5KioBI=;
 b=qdzsBQYtwtk/kEW7qB4iLGfppf17n2p+TUXSvQPdzZcWBCnD4pxL7mgYqW865/JdAjexgYqaEkZ+UYu9ueJTYPswyIAk2jP+HXCpq/qL9FDFbuXWHrT5GgB1u5Fu2a8m1+OMZkAA9ZiVtxHf2/XbzhHlIpxrYu3GgjmkM9xXQYeGB3by/ZHQgRn71v9GzELJAfLyDVz72rbFiGZwpYBaIvCZfInSjbXu9IRpLpnR28EJS5jRMKg4zM8A1npOhuRgCH51pl9GQ6uaeJ8PKVGn6x7APluq0lO2ijZDXtq4r1rFxlrzEKgOlsKh/OX2LNRK4W6p2fwADfm73lVuUNHwrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 DS7PR11MB6222.namprd11.prod.outlook.com (2603:10b6:8:99::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Tue, 16 Dec 2025 07:36:49 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 07:36:49 +0000
Content-Type: multipart/alternative;
 boundary="------------yp95A0RrLlxouMV4WLZhA5Hd"
Message-ID: <971ec490-dd6c-4392-8662-bbfeabf18846@windriver.com>
Date: Tue, 16 Dec 2025 15:36:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH/V2] refpolicy: Add support
 for custom policy store
To: yocto-patches@lists.yoctoproject.org
References: <20251215135126.1605250-1-quic_sasikuma@quicinc.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <20251215135126.1605250-1-quic_sasikuma@quicinc.com>
X-ClientProxiedBy: TYCP286CA0102.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::9) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|DS7PR11MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c85f3d6-48e5-484a-9704-08de3c75df48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZGR4RzQyS1BqSkNJTXM3QUsraUZxanRlSUxpZEFkaGtTUTRvQVNEcDM1TnRM?=
 =?utf-8?B?eS9qS0s5VUJvcEk5V1hnVGNyN0FhdWVaSy9TSGtPUldlUDV5TGh2bHppSkJ0?=
 =?utf-8?B?RFVNbStGVERaQ1l0NVVwNy9DYVZ0OTFqUVVKQTAva1ZVTW8zSTEweFAySkMw?=
 =?utf-8?B?ajA2L2txbkx2QVl0ZHMzNTB3MjROUnBERnJGdHFpTVM3YzRVVVdnb0wrQVpB?=
 =?utf-8?B?MDFDcjluS1RZekh3TkFUbDFQR0w1NzMwWUxWVGFWLzl4L0l4RHJMRXkxaFpB?=
 =?utf-8?B?TjkzZmhrMWp4dTF5bEthckQ1UzRJWmhGQVd0Q1dNUFFMN25IalAwdUh0SEVy?=
 =?utf-8?B?VkRGUHdPaU5McTJNQWRJVTBLYmRjNitWbGFDcFdpWmRYYjBONmlEeFo5cUpF?=
 =?utf-8?B?dDJ3M0ZITFJtcTh4bzFoY2hxTldnY0Q5NWRGdnFmR21QT3Nsak1GWGhjaER2?=
 =?utf-8?B?WC9ZMzdCSjhyVUwyMWVkYkhTR0hwSmRybDA4QlNyOFVKNXRUM2hheUxYRlE1?=
 =?utf-8?B?S3VieWdpQ3ZoZi92RFVkdUdZS1YyOENGaUt1Mkl5RFpQQW5IKzNHMDZ6Y1ln?=
 =?utf-8?B?ditNdlFHc1VCcVRLM2tQMmhTdWtmRS8yWDhnbWdNTUkzUGFNV2sxS01CbXZ3?=
 =?utf-8?B?MlFocGZHRzhOakM0aWJGT1lxa3duMUtjZmFRZDRnQmhYcmJLOEJyZW85U1VP?=
 =?utf-8?B?NXR2ODBoL1R6NTdUTFVBSTdRakNZeUE3YkRQemFPNVhLblBTNm9iUVZWM1lQ?=
 =?utf-8?B?ejM1S3kvNjcrUUNhbWtSTlFzTElYZTk5UjlNNVgrNE85OTlZQ2h5cXB3TFNh?=
 =?utf-8?B?K2JhSDR4ZXhFVFMxMDAvaWpTRkwrYnhSQUVUYVRLSFV6djM4VkZpR1JSdzdu?=
 =?utf-8?B?WnVTb09IYTdUckVxNm9RVzVIYUtzRm9OTmkxVWxld0laaHd4Ry9ZNEhpT3BN?=
 =?utf-8?B?YklnS24xOE1LRzZmWkovK1c2MnpkcUhGRUVSM2hKRXVaZ3VDUlJTUWsrd3Fv?=
 =?utf-8?B?UFlvTytsakxGQ0ZIUVJwZWJZMFBmUGNwWlBaUjFZaDBoL1VWWjVkelRMbjFl?=
 =?utf-8?B?a0R0QUhKbEFBZ0k2amVvc1RjWlYwWmtpT1RRcVRkTlFXK1diWFMrb3JZNWdk?=
 =?utf-8?B?TzQ5TzRDRlVyV3ZUR0dCc01FWlQ4TldpRGcxbHNlNmxjYzVWL2xkZ3Yxd1g3?=
 =?utf-8?B?VzdvNkROU2xMTEJvVlR5eDM2aVorR09vRFg3bHRDOTdMS0dnQWJvRmU4NUlt?=
 =?utf-8?B?cklXT1R2RTVMLyt6VWMwWmtjdkdNZ2srNjlERmF3b1F4WStLbG1nb3FVaTA2?=
 =?utf-8?B?ckNGT2xCeitWWEUvZXBMUWFQTFJlVkpLQW5uN2lxb2MyT0FEM2JxdXVVSVYz?=
 =?utf-8?B?R29OcHJJN25CcWxSWnpkQWNvNFVXQ1gvaDZONW9kZVdwU1BsR0NyMWs5WWdF?=
 =?utf-8?B?MHlvOXBzVXN1MGFDbjNIbGJYNm5EQVlmOWxFVlFOTXozUlVSWU5nMGVYREpI?=
 =?utf-8?B?cGY2S29LRlJjUDFpSW9hQS9TMEZsTm9HNGVzemNWWDdBMjI2T0VZWWhhVWZR?=
 =?utf-8?B?Yk9XMXRkVU4xZEdHSUFBMk81K0xpbXoyS3MvbjdLUVVwdzFuT1JRT1FibW1H?=
 =?utf-8?B?bDJMTEJmQ0FHRGFZMEp1c0pXc2tJb25GdndpMzFCYnZsa3o2SkJFa21IUG4x?=
 =?utf-8?B?TmZJZ2YyNmxkSUdQZGdjaFNiN0hyUzVQOTJOaFFoVWsxZHZuNUhlWm4yQTRH?=
 =?utf-8?B?UWk3bTd3QWt4cSsvQVBTNGE0SVdrZnUzcDl6VzVPRXMwQzAwT3NNQlRNd2t6?=
 =?utf-8?B?M2QzWDRVMW1jSHVTZ1B2RHVmWmxrajF0NS8vbSt3Q3REa0pIcjVuc202OXo5?=
 =?utf-8?B?Z0lqMHRURUpXUmhrN2svUVhVWWthd3NZTzFXM0tyak9oTDdUWHlONUp1cCtk?=
 =?utf-8?Q?n9ANNYhejLwt4SHskN07JKiuhDLePVLi?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aTF5Qitub3hVcnFjWnhzcWErYjJmUnp6VjByN3dadFVQMDJvczJxRGl0ZUNU?=
 =?utf-8?B?OWVXR3lTL1laTlVQdVMxRFFlWHhpRmxzaCs1VXh5R1dVc2M4eGc3cThVa1VM?=
 =?utf-8?B?bWg5ek1PbC9xOVh0a1YvSUZqQVpGUDNSaGJMTE8rbzg0SVVEb1FKckluNzQ0?=
 =?utf-8?B?ZHJXNmwyMmZUR2hhWGZaZ29UZzJWVUk5YjFmelp6OWJUclYxYmYreWZBRWtm?=
 =?utf-8?B?djU0cWI0cTlxN3RhN0sxUWhORDEzWVhzS2FSdkRiMEFGcThzQUNDbEtVLzdq?=
 =?utf-8?B?M1pjRC9YclJWWmFGOU9RM1JSM3pSdDRWWHcwMGV1ZjdiL0hTTjJYcGQ2dkdT?=
 =?utf-8?B?TCtGQ2FQcFFEL2ZwZ0dieEt2U3ZVemdsY3J4WEFmMTZ2cUlDeXNqSEZFMjFa?=
 =?utf-8?B?UmUvOU90ZTFEUlpYN2oxN01PYWhrVjdTaWtpMHpsaWtpMTJMTUpEK21CalJZ?=
 =?utf-8?B?aUs1TEVaK2VzVkR2MitCcU4rQmdzV3htNWlsZWtzSGdvVnQ0RVdCOVpyM1dx?=
 =?utf-8?B?SVhsbzhLWFhISWJRM1dZMkpUaVh0UHJrZnBGeTVRdjc4YjFpSjJ4WGtlM3lz?=
 =?utf-8?B?V0dJMzM4bWhNS3ZwbVNRQTBveWN6SStkcGkzQ0RYNVd4cng2dG9WNVNST0Z3?=
 =?utf-8?B?YU9jMHFTZ2I5eStGWFNaVFZDVjRKNjVrUE5Qc2M4dkJ1aCtvN09sYW1Kdk1h?=
 =?utf-8?B?UlR0N2g5ZDBqUkJ6OXVIYlFLZDRUVmtTTDIwd0J2ZzlHWHR2SzRDUjk2Y2Ro?=
 =?utf-8?B?MzJFSWdMbGsveHl4MmZ6VFJMWnN0S2JKWXdncmJ5UDBTQVltbVlRRnV0amRk?=
 =?utf-8?B?Yi9CZG1RZE9iL2hQKzRTNjBSTGd1YTlmbVRXNHVIQXVuTlcxUy9UOVFQd3k0?=
 =?utf-8?B?bjVYcC9Qang2SU0xYk5FUjFsUFVnL0FuVExDU1pKcit0WTJqRytOUC9qeW80?=
 =?utf-8?B?cWhJd2lrOXdaUnVodTFWRVBsSlhOSDdTMWl2WUxOOWRjbXVyK1BnWk41Z094?=
 =?utf-8?B?Ri9oZU5EbndqbVFwcEN4bGQ1TkxFK1RZcUZPR01NK3haNnpMb0diRXdSblc4?=
 =?utf-8?B?SWUwcXdYR1p5L3lxdGJoYzFWSFpmbG9teTh5K1pCWFNoK3ljemk2dC9HUWxx?=
 =?utf-8?B?NjZ1V1pwenBrUEZqOVF1eE5VeGY5TEhwK3I3MHJVNmdHLy8weFlRQWlPMnd1?=
 =?utf-8?B?U3N2QTZYdnp4UzFxbzM0QmZPK1hXNmZ5aGhGWVVVbTJmR1JVeE14YXhUemJL?=
 =?utf-8?B?UkQwVEQ4L0JSamtMT1RCNk5qd2F2c0tsdFdNc05RaVUvZ1g0cXlHU1hYZnQ5?=
 =?utf-8?B?VEt6a3V2YUh2T0lrY0ZpNkIreklpY3hneDJiNmY3ZG5uMHVpUjlTZWZWMktw?=
 =?utf-8?B?U2dwRmRNVzZoZG1PUXkyQWd3TFBzNllPUUtCclBZdTZqdGlLK3dPRkcxMXFo?=
 =?utf-8?B?VWVGRHJVeU5JcFhLcTg2Y3RTNFBzUW9hZDMzb0Q3TEVNcTcvd29pNkIzYVcx?=
 =?utf-8?B?em1sdHNLS0RBeTF1d1ZRUnZZM0tNNFZpcHNJM0tlUXM3aEM2ZWVBa1MwSzNR?=
 =?utf-8?B?ckxDVFhTaHJIaERxMnN1UkN0bUVxTUNFYk5NWHoyN0JoWk05TEphWEJVNEN0?=
 =?utf-8?B?Z0ZQZGF1TVFzMFYxdHpaSi9PY20vV1hhcGUvdURJSkt0SFBmY3llN2xpVTA4?=
 =?utf-8?B?MGQySmhvS0tJZnVUWjlsbE5GU1FKMHBQQXpJNXlvc2wyOWpIbnZnTURjeG9i?=
 =?utf-8?B?aGtxY0RCTGVNV210S2ttNGFLU1Y3WEJYQytQdDJaUEVpeG5HWlpTaWtYSDhY?=
 =?utf-8?B?aHYrNWEvcXhvSE8xc1VHMVc2VHk5U2pweUhEZ3FDMmxEMHlUTWtBL1ltSTBL?=
 =?utf-8?B?R2dtbWF2bS9Vajl0d3ZsRURaMEZCcStLenhqWjUvK0Zmc0VlVWRRYS9NVEZI?=
 =?utf-8?B?TGF5RmVqOHhUWkdmbjFuY1hydytIMmVuRGlHMDB3TUYydjJrT3FiSWdLeFZC?=
 =?utf-8?B?MUF5TWl1TThVNDFGRUs5TW1IeTVOTWtGL0NtVDFiN1NFK3pJcHg5cFhqVXlt?=
 =?utf-8?B?M1lGNWFVczRaNDlxVnJvdGdNNUVqL0dnZ0JTZzVsSkRCOUlNWm56SEZNSllr?=
 =?utf-8?Q?PoCo68JKlw5bpuaTC0pihZcTL?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c85f3d6-48e5-484a-9704-08de3c75df48
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 07:36:49.0117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/u/8ZjrDf/x/QRDLBP2GhF6CtBCdnmEz/Cc1eNUgpmm8eBhLkl3PGox3VFsD1881ADYWQEkZj0HCbGieQrzFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6222
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA2MSBTYWx0ZWRfXysYS50A54EiJ
 VrGjFHpFBs/uXhSQPiOLa9vqY6XeogMWhVEtDamplBor26NJk1NFq8KUQNKGZgSX7EwvEA5PUuX
 H+TjYKff13RB+JfBGYTFFLhtoOR0+GWs9Al6YJLwCLNqfh9mdg3PMuwDmYy9cWRA9fSvlcHG5W0
 MmXYa55siphbt3L9xutoxsruIIMAEQ1M3QnOg6Ue1n6uDkYDnsG1eb6qupsSOxpahF9J0Uu4KpQ
 QTJQK9lIGT9aLVmny+G16Qdojz8lZCYO1/Gx7I3wJFC0B9yvNLeBAFHHBBcBJtZvhoV9M4IfS9G
 NIv40tro2WAEkaTQRWWa4LzejeSb/FcUVhqp/A37IPmEvHM2SXZmKMflOcBy4EowRIWbIBVus+X
 tkXZfC0RXlx5CyggakcumQVQ4O79Yg==
X-Proofpoint-GUID: 9PAh42Ix02CAoa1m-bq_YK3QQl8O8C9J
X-Proofpoint-ORIG-GUID: 9PAh42Ix02CAoa1m-bq_YK3QQl8O8C9J
X-Authority-Analysis: v=2.4 cv=B/60EetM c=1 sm=1 tr=0 ts=69410c15 cx=c_pps
 a=8Mab7lbrFfecTh0PXXvUKw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iGHA9ds3AAAA:8 a=COk6AnOGAAAA:8 a=zdeCQEUv-cenZ4bfbSQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=I8g-lVKgVl53kmlvlZgA:9 a=yDoNXAcBNRh_FPG_:21
 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160061
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 07:37:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2797

--------------yp95A0RrLlxouMV4WLZhA5Hd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5BG5egQR1665174


On 12/15/25 21:51, Sasi Kumar Maddineni (QUIC) via=20
lists.yoctoproject.org wrote:
> By default, policy modules(*.pp) are stored in /var directory.
> Features like: ostree remove files in folders like /var
> variable data directory while build time.
>
> Added support for custom policy store. We can now configure
> path to custom policy store to variable `POLICY_CUSTOM_STORE`.
>
> Signed-off-by: Sasi Kumar Maddineni<quic_sasikuma@quicinc.com>
> ---
>   .../refpolicy/refpolicy_common.inc            |  9 ++++++---
>   recipes-security/selinux/libsemanage_3.9.bb   | 20 ++++++++++++++++--=
-
>   2 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-=
security/refpolicy/refpolicy_common.inc
> index 964906b..5a4b500 100644
> --- a/recipes-security/refpolicy/refpolicy_common.inc
> +++ b/recipes-security/refpolicy/refpolicy_common.inc
> @@ -77,10 +77,12 @@ SRC_URI +=3D " \
>   S =3D "${UNPACKDIR}/refpolicy"
>  =20
>   CONFFILES:${PN} =3D "${sysconfdir}/selinux/config"
> +
> +POLICY_CUSTOM_STORE ?=3D "${localstatedir}/lib/selinux/"

I have some reservations=C2=A0about the variable name `POLICY_CUSTOM_STOR=
E`.

By default, it's assigned to the system's default path, not a=20
"customer-defined" path.

Therefore, I think a variable name like `POLICY_STORE_ROOT` would be=20
more appropriate.


//Yi

>   FILES:${PN} +=3D " \
>       ${sysconfdir}/selinux/${POLICY_NAME}/ \
>       ${datadir}/selinux/${POLICY_NAME}/*.pp \
> -    ${localstatedir}/lib/selinux/${POLICY_NAME}/ \
> +    ${POLICY_CUSTOM_STORE}/${POLICY_NAME}/ \
>       "
>   FILES:${PN}-dev =3D+ " \
>       ${datadir}/selinux/${POLICY_NAME}/include/ \
> @@ -165,7 +167,7 @@ prepare_policy_store() {
>       oe_runmake 'DESTDIR=3D${D}' 'prefix=3D${D}${prefix}' install
>       POL_PRIORITY=3D100
>       POL_SRC=3D${D}${datadir}/selinux/${POLICY_NAME}
> -    POL_STORE=3D${D}${localstatedir}/lib/selinux/${POLICY_NAME}
> +    POL_STORE=3D${D}${POLICY_CUSTOM_STORE}/${POLICY_NAME}
>       POL_ACTIVE_MODS=3D${POL_STORE}/active/modules/${POL_PRIORITY}
>  =20
>       # Prepare to create policy store
> @@ -207,13 +209,14 @@ args =3D \$@
>   [end]
>  =20
>   policy-version =3D 35
> +store-root =3D "${POLICY_CUSTOM_STORE}"
>   EOF
>  =20
>       # Create policy store and build the policy
>       semodule -p ${D} -s ${POLICY_NAME} -n -B
>       rm -f ${D}${sysconfdir}/selinux/semanage.conf
>       # No need to leave final dir created by semanage laying around
> -    rm -rf ${D}${localstatedir}/lib/selinux/final
> +    rm -rf ${D}${POLICY_CUSTOM_STORE}/final
>   }
>  =20
>   install_misc_files() {
> diff --git a/recipes-security/selinux/libsemanage_3.9.bb b/recipes-secu=
rity/selinux/libsemanage_3.9.bb
> index 2425a2e..98ff73d 100644
> --- a/recipes-security/selinux/libsemanage_3.9.bb
> +++ b/recipes-security/selinux/libsemanage_3.9.bb
> @@ -32,6 +32,8 @@ FILES:${PN}-python =3D "${PYTHON_SITEPACKAGES_DIR}/* =
\
>   FILES:${PN}-dbg +=3D "${PYTHON_SITEPACKAGES_DIR}/.debug/*"
>   FILES:${PN} +=3D "${libexecdir}"
>  =20
> +POLICY_CUSTOM_STORE ?=3D "${localstatedir}/lib/selinux/"
> +
>   do_compile:append() {
>       oe_runmake pywrap \
>           PYLIBVER=3D'python${PYTHON_BASEVERSION}' \
> @@ -46,9 +48,21 @@ do_install:append() {
>           PYLIBVER=3D'python${PYTHON_BASEVERSION}' \
>           PYTHONLIBDIR=3D'${PYTHON_SITEPACKAGES_DIR}'
>  =20
> -    # Update "policy-version" for semanage.conf
> -    sed -i 's/^#\s*\(policy-version\s*=3D\).*$/\1 35/' \
> -        ${D}/etc/selinux/semanage.conf
> +    conf_file=3D"${D}/etc/selinux/semanage.conf"
> +
> +    if [ -f "${conf_file}" ]; then
> +        # Update "policy-version" for semanage.conf
> +        sed -i 's/^#\s*\(policy-version\s*=3D\).*$/\1 35/' \
> +            ${D}/etc/selinux/semanage.conf
> +
> +        # Update "store-root" for semanage.conf
> +        if grep -q '^store-root=3D' "${conf_file}"; then
> +            sed -i "s|^store-root=3D.*$|store-root=3D${POLICY_CUSTOM_S=
TORE}|" "${conf_file}"
> +        else
> +            printf 'store-root=3D%s\n' "${POLICY_CUSTOM_STORE}" >> "${=
conf_file}"
> +        fi
> +    fi
> +
>   }
>  =20
>   BBCLASSEXTEND =3D "native"
--------------yp95A0RrLlxouMV4WLZhA5Hd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 12/15/25 21:51, Sasi Kumar Maddineni
      (QUIC) via lists.yoctoproject.org wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20251215135126.1605250-1-quic_sasikuma@quicinc.com">
      <pre wrap="" class="moz-quote-pre">By default, policy modules(*.pp) are stored in /var directory.
Features like: ostree remove files in folders like /var
variable data directory while build time.

Added support for custom policy store. We can now configure
path to custom policy store to variable `POLICY_CUSTOM_STORE`.

Signed-off-by: Sasi Kumar Maddineni <a class="moz-txt-link-rfc2396E" href="mailto:quic_sasikuma@quicinc.com">&lt;quic_sasikuma@quicinc.com&gt;</a>
---
 .../refpolicy/refpolicy_common.inc            |  9 ++++++---
 recipes-security/selinux/libsemanage_3.9.bb   | 20 ++++++++++++++++---
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 964906b..5a4b500 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -77,10 +77,12 @@ SRC_URI += &quot; \
 S = &quot;${UNPACKDIR}/refpolicy&quot;
 
 CONFFILES:${PN} = &quot;${sysconfdir}/selinux/config&quot;
+
+POLICY_CUSTOM_STORE ?= &quot;${localstatedir}/lib/selinux/&quot;</pre>
    </blockquote>
    <p><span class="HwtZe" lang="en"><span class="jCAhz ChMk0b"><span class="ryNqvb">I have some&nbsp;</span></span></span><span class="HwtZe" lang="en"><span class="jCAhz ChMk0b"><span class="ryNqvb">reservations</span></span></span><span class="HwtZe" lang="en"><span class="jCAhz ChMk0b"><span class="ryNqvb">&nbsp;about the variable name
            `POLICY_CUSTOM_STORE`.</span></span></span></p>
    <p><span class="HwtZe" lang="en"><span class="jCAhz ChMk0b"><span class="ryNqvb">By default, it's assigned to the system's
            default path, not a &quot;customer-defined&quot; path.</span></span>&nbsp;<span class="jCAhz ChMk0b"><span class="ryNqvb"><br>
          </span></span></span></p>
    <p><span class="HwtZe" lang="en"><span class="jCAhz ChMk0b"><span class="ryNqvb">Therefore, I think a variable name like
            `POLICY_STORE_ROOT` would be more appropriate.</span></span></span></p>
    <p><span class="HwtZe" lang="en"><span class="jCAhz ChMk0b"><span class="ryNqvb"><br>
          </span></span></span></p>
    <p><span class="HwtZe" lang="en"><span class="jCAhz ChMk0b"><span class="ryNqvb">//Yi</span></span></span></p>
    <blockquote type="cite" cite="mid:20251215135126.1605250-1-quic_sasikuma@quicinc.com">
      <pre wrap="" class="moz-quote-pre">
 FILES:${PN} += &quot; \
     ${sysconfdir}/selinux/${POLICY_NAME}/ \
     ${datadir}/selinux/${POLICY_NAME}/*.pp \
-    ${localstatedir}/lib/selinux/${POLICY_NAME}/ \
+    ${POLICY_CUSTOM_STORE}/${POLICY_NAME}/ \
     &quot;
 FILES:${PN}-dev =+ &quot; \
     ${datadir}/selinux/${POLICY_NAME}/include/ \
@@ -165,7 +167,7 @@ prepare_policy_store() {
     oe_runmake 'DESTDIR=${D}' 'prefix=${D}${prefix}' install
     POL_PRIORITY=100
     POL_SRC=${D}${datadir}/selinux/${POLICY_NAME}
-    POL_STORE=${D}${localstatedir}/lib/selinux/${POLICY_NAME}
+    POL_STORE=${D}${POLICY_CUSTOM_STORE}/${POLICY_NAME}
     POL_ACTIVE_MODS=${POL_STORE}/active/modules/${POL_PRIORITY}
 
     # Prepare to create policy store
@@ -207,13 +209,14 @@ args = \$@
 [end]
 
 policy-version = 35
+store-root = &quot;${POLICY_CUSTOM_STORE}&quot;
 EOF
 
     # Create policy store and build the policy
     semodule -p ${D} -s ${POLICY_NAME} -n -B
     rm -f ${D}${sysconfdir}/selinux/semanage.conf
     # No need to leave final dir created by semanage laying around
-    rm -rf ${D}${localstatedir}/lib/selinux/final
+    rm -rf ${D}${POLICY_CUSTOM_STORE}/final
 }
 
 install_misc_files() {
diff --git a/recipes-security/selinux/libsemanage_3.9.bb b/recipes-security/selinux/libsemanage_3.9.bb
index 2425a2e..98ff73d 100644
--- a/recipes-security/selinux/libsemanage_3.9.bb
+++ b/recipes-security/selinux/libsemanage_3.9.bb
@@ -32,6 +32,8 @@ FILES:${PN}-python = &quot;${PYTHON_SITEPACKAGES_DIR}/* \
 FILES:${PN}-dbg += &quot;${PYTHON_SITEPACKAGES_DIR}/.debug/*&quot;
 FILES:${PN} += &quot;${libexecdir}&quot;
 
+POLICY_CUSTOM_STORE ?= &quot;${localstatedir}/lib/selinux/&quot;
+
 do_compile:append() {
     oe_runmake pywrap \
         PYLIBVER='python${PYTHON_BASEVERSION}' \
@@ -46,9 +48,21 @@ do_install:append() {
         PYLIBVER='python${PYTHON_BASEVERSION}' \
         PYTHONLIBDIR='${PYTHON_SITEPACKAGES_DIR}'
 
-    # Update &quot;policy-version&quot; for semanage.conf
-    sed -i 's/^#\s*\(policy-version\s*=\).*$/\1 35/' \
-        ${D}/etc/selinux/semanage.conf
+    conf_file=&quot;${D}/etc/selinux/semanage.conf&quot;
+
+    if [ -f &quot;${conf_file}&quot; ]; then
+        # Update &quot;policy-version&quot; for semanage.conf
+        sed -i 's/^#\s*\(policy-version\s*=\).*$/\1 35/' \
+            ${D}/etc/selinux/semanage.conf
+
+        # Update &quot;store-root&quot; for semanage.conf
+        if grep -q '^store-root=' &quot;${conf_file}&quot;; then
+            sed -i &quot;s|^store-root=.*$|store-root=${POLICY_CUSTOM_STORE}|&quot; &quot;${conf_file}&quot;
+        else
+            printf 'store-root=%s\n' &quot;${POLICY_CUSTOM_STORE}&quot; &gt;&gt; &quot;${conf_file}&quot;
+        fi
+    fi
+
 }
 
 BBCLASSEXTEND = &quot;native&quot;
</pre>
    </blockquote>
  </body>
</html>

--------------yp95A0RrLlxouMV4WLZhA5Hd--

