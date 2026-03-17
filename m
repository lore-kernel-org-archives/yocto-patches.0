Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12A2F33803
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 14:33:10 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.77418.1773757982742982603
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Mar 2026 07:33:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=iKiBTDKQ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7536f4cc45=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H7HQds1484614;
	Tue, 17 Mar 2026 07:33:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=V16ZwI93ooTC9IPuPjKe5slRU4eqKTeKd312/rSVuNc=; b=iKiBTDKQw7xb
	6NHIeKm1KRT5HsawMmt3tgPIzK4l8zsCsUv7Zy51JRnwQVksBK4ObzFH2UYvyPuh
	ZI61ROABjs58avUWVJXJq8/xH3pHaYJ4C+qPfp3Q92koXJ9JfSIG0v5+w76IRG8o
	6hScN53OhxAIzXzDXEkAW2XoT4AOO3hV+uSDwJLfe970a2wxE/NrWNSWIRcPBsIQ
	a7XvoXpIXeqFqHxUbO++8d01Yo9C4c3iAWx1c2RgO9syHB6uPj8mPVVWEe3cS2k+
	IPETkmIqaHQBt6TcZsdaoy7WGpO0kHOpj2ZKZOp36DZzSYBXDuv3PEaSFDmDceVo
	th0/cyCKhg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012061.outbound.protection.outlook.com [40.93.195.61])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cw2y139wp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 07:33:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRrJqsbA7i6OG3Ksjd87F9NCaTHGmcs8hi29kHjnbmGeucqVlQLub26tpbi1/PSHKCDnAhxc5zlgleKClP8Ic2rCogsRSNRzvASJ4UkqCX7o7n6tuUI/W/kgFCn9MzVQ/8O9jb7dGqoBUf2ETqJfQlwQoGBm/CRGbWwsWDCGkgRrbAJYIgdQOEfw3L5EWwb1k/IBxz/0z89QUMts7svga0zt/DFmaAuADAsHKPzsqVcX3KEyUUBKTOINugVNPZyRIjBCWRFfnV69RVRFmkh2L187uyBbwpqVBzV8yFKDO/8dkhXWx1O8s+Anf++IyYnp3ud8jL2PLGEF7Q8/4GFwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V16ZwI93ooTC9IPuPjKe5slRU4eqKTeKd312/rSVuNc=;
 b=WXvP4RpgrmZ+m7LKzeTt5Nn9V2c5PJhoRlBNuSoZT0A/yK2paz6xS2GcCm57rFJW06l+tGD1UHe54rhFSZr/9mIdkzd7iysEnnV7WjOKylWJ25iB1Y/1Plb+Rz/oE1xVs2HEFEboswAJCizY7jM9pM7qIyVb2oFtZaMGUx9iNFzJzdNdR44BaxRxL7IacY2VlWUOgQBjTOO9HISE1Uw/sSHfTO8//oXIKZfyv3vLLHky6/4B9ZnJ+KvC31g7nfHLlrZUth/PjIypn8rgjLOv4qNMg7LPILPlj+lUcAhRzX1md5xFOyJlIr14zgFiJ99p8tU41IYNKdusjH4xXZfMzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 PH8PR11MB6660.namprd11.prod.outlook.com (2603:10b6:510:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 14:32:59 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 14:32:59 +0000
Message-ID: <112cd65d-287c-4235-96b8-1e14605cbb1c@windriver.com>
Date: Tue, 17 Mar 2026 22:32:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-selinux][PATCH] refpolicy: backport systemd user runtime
 userdb fix
To: Jaihind Yadav <jaihindy@qti.qualcomm.com>,
        "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
References: <20260316093619.3748852-1-jaihindy@qti.qualcomm.com>
 <CH0PR02MB8120CE9C958FCE8CF563E542E241A@CH0PR02MB8120.namprd02.prod.outlook.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <CH0PR02MB8120CE9C958FCE8CF563E542E241A@CH0PR02MB8120.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SE2P216CA0153.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c1::9) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|PH8PR11MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: d6faa743-9717-47a0-9e61-08de8432160f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|17002099007|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: 
	wPtMj35Kg5H0ec7zEk3KMTjtqnIXKR0U5B4pTEwIxvMu+vzDHpUYZHIdE/sl8rgG5Ge7+EG1kULxAFXgVT06G+EyBZkeSLbV8RLX/eTiAFQqsgCeDk0SxoxMt5eVuamk6g2e+8L30MxRJDOmtD+C4gybg+rl5nMaO01LorMm6TqeF9ZZQprZt2QpyrDapkEWgfLvlHj8ZuDOv8l8nZu5V8W1DNbIly9sTzBULvLRxLM94E9g3KVRT4GzkvYGrR2snuTZUNo5rRb0VJnv+MvxwH+vPowxhEsSqmYderspbKLZY+Rmg+P/d/Il3C/T8x6ZozgYrx4g2f5W0MU4dMQF1LxLc5PxUKz1ix1mngsFPACUjo8yzHefl8zi3Tn5jhxBfWrQEEWRWSE8Lfm0izzF7MfxxwOrwmHs6n0jaN8E9uz2TKD1Namttq4vAmzxS85LGwFB/fE0tQUalIAgEN5ccYdY7Mp01D4TN6TeGihkJkR/fShCzlklyIP0DY5ptSxKdzaTwIhLtLsI31Y0YABLyBFtgzsipDQXc/P9mZPEfchhGwYXoeSFF93D8Mllkxric8KZARAmG9MJ7drV30oCH3jmIb/bTtimkrRp728VsmjQneoXDxvS7PdS8imuihMJ9Hux0Zfcd9AxpPFCCwnXYepzt7CPCpKCIvIisT91L1kXsaj8R94ePZb98N+7wcJRIaorx3xujyNc1PivXg3L+mZFvhQN8EgiW2zFyUDPUNM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(17002099007)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eVZhb1g1QnRyM3JOZmR3eHVKcXNOdjNSSmFYMTgvKzVNVlhSVTNobmRRZ3J5?=
 =?utf-8?B?anI2TlBEUmxjUi9BNjVTY2VGQk9yWEdmeGVva2JNUW9tKzFtRm45a3ZualUz?=
 =?utf-8?B?M2w4RXFWQ1cwUGdUNDA3WjVucE1jWDBnb3ArSHcvSGZmYkkxWjFjT2J6THVh?=
 =?utf-8?B?OWxiT1BtZkJWT0hIL2ZDaS9oTnAxU25oSTdMejBnTS92S2x4em52ZThKYWRx?=
 =?utf-8?B?c0M5NG9RWk0vSVkyM1JnOUN5TXNZTitoY3JFNHowQU9BOU5Xc000L2pqSlcx?=
 =?utf-8?B?TFhicWVCS091TE0zVGdTR21TLzRjYU85U0VpZmFwQzZ4bXNCMnZiMXBOa2Q0?=
 =?utf-8?B?TDN0VlNSL1hJNVd1RGRwYVhObmhxeWpYb2dzVHJFdDV0ZVNDd0FPRHhzMTlk?=
 =?utf-8?B?dVBRQlB0bUwveThYZHRHYW0yTVA5dWtyU0pmUnpHcHMwb2VZajVFdVQ0T3pF?=
 =?utf-8?B?K3YzUWNyNkMxalNIdHN6RWMwbnYzaDN3NUljWkErd2lVdFRkcXpSV1YrOTZK?=
 =?utf-8?B?aGJtbUtEZWpEYnpacW9ZMVR0bmJlYndWK2RiMG1Zcks3d1NweUNKWXpadmJ0?=
 =?utf-8?B?ZStoT1NyZnVlOFdwbTV5Ly9TNnBTUEVmWGZ0UGdwZVM3bUFIeDZiQkRHR1o1?=
 =?utf-8?B?ZkEzVFZOTWRIbjZGck9yM2FUV3VCbDkwanJDQm5GSTkvUk5XODl3STR1V2tO?=
 =?utf-8?B?U1puUjJia21ubVhCRGFMazBPSGF4NHlFODh4d3B4NjN2N1g2RnhOZlk4Z211?=
 =?utf-8?B?WkdTS0ZueElqRmFCaUJVR2cyeGFJN21CSk8zL2U5MENRVnBBQkhaNDREakRZ?=
 =?utf-8?B?QW4wakNKR25xRkxGenM0K2dZMkpiYndqVjFRZHBTUVFmWlFhR0x1V1ZRR0pB?=
 =?utf-8?B?U3cwMjB2YThOd0NnTzk0S25yYmRrT0J4Kyt0eWtnZGt1MEV1RFZ2cUxMcXI5?=
 =?utf-8?B?bDlLZ1ZLZFdEMVNRZWd3WG5IU1EydXFCYjZJbTVKL2pKcFVwMWpzUGZVRy9k?=
 =?utf-8?B?THVja2EvRlBWZXFqU1NsN01YTHE2N0lZM3A1aGRYNE1wQjY1UXpJeHZFVS9N?=
 =?utf-8?B?T2FXTTE2c215Z1RYdUF3WnR1WlI0NnFCUHVVSjNZNTA5eWs5ZWRaU24rRUlQ?=
 =?utf-8?B?VWNROEYyK0p6OU1XVkN5Nys5RG52QzF6VHN3ZG10ak1oRkVIeFV4Y3MweDNS?=
 =?utf-8?B?T0JPQURBbnduVE1nb3pVN3Q1TUswMFdiL2E5aWR6bWh4TTk0M1Eya21tZm1Z?=
 =?utf-8?B?Z2V6ZzFVa1Zwak85N3gweHk2V0JINHovT29HSFZLQU5GTGYwY2duQ2RuWW84?=
 =?utf-8?B?eklacU1IcmtFZml0VXlWdmhYV1N4c0hRTFFQR1JaNUVMNFRveHRQZ3NFaWVz?=
 =?utf-8?B?MFJPaXMzUURtSWZjTm12MEdvRjVmMjBIUFV3d2d5TmJURWdMZ01jRi9jUkFu?=
 =?utf-8?B?dzdQT3o5ZFpLRHhCMlN6bVUwSldiOTBhay9BM2VmZ0c4MndoWjVKNDgxdzgx?=
 =?utf-8?B?VmMvbGhtVjNwK0IxNFI2ZHp6UjFNMXdJd3hETzA3eW4wT0ZwVmJYR0I4c2Za?=
 =?utf-8?B?K0p3czJtcTJkZ1EyUVFuSlJ3RFpVVnUycS9tdXBpWEo3aGNPUms4SDdycFF0?=
 =?utf-8?B?UTFWa1Y3bEJmeTgxWXRXWlhNcWdQR1MwbkhteFBab2NYcGZiZEJiQkNQQjlR?=
 =?utf-8?B?RFFYRGRnVEQ1U3JpYk56dkdsM1VnUlE4dDRTRU9DSjFCQkJPd2dMSWlmWWdN?=
 =?utf-8?B?NDFLNmdpNmF6eTZNNjc5M0RGdXBveXpHUERub2xTby8vS0tNMnZKR2NrTU1s?=
 =?utf-8?B?czZJa0hpZG1senBQQVZNWGY5aDhocEI5V01JK3JCbFZFUEVQUS9kU0lGSTZm?=
 =?utf-8?B?WnQ2bE0xMTFpZHBCMmVhTlVBMkFteW10bXRYR0dnMFp2eDhVaFJId2FwZms3?=
 =?utf-8?B?UTRDSDFJYzJOamY2QXA4TVNJeDFxVEZzNERRWk5WSVFRdXFDS0JPTnJlM2Zj?=
 =?utf-8?B?TEw5OVBONCtzTHdIbzhMTGpUbG0wRkRZcWM2bGUzNWVpckhWMXJIYXl0cDFz?=
 =?utf-8?B?aHRKNkp3QlFscWtMUm5TR3BIZGk4QTRSZFRtWHhncWRlWGpCa05OQVhON0pV?=
 =?utf-8?B?RDdzVlU3NG9MRHE1K2NnelFIZW5ZWFVsMHVuZVI2RTlic3Y1Z3U1aXBKekRR?=
 =?utf-8?B?c3hlTHVOdUYvOWhHNWovVkcxdmJjanJVWkhaYStTVmpTWWxhV09XKzJUM2VG?=
 =?utf-8?B?WHk4UzhidENKdTJDOGtLM3hGbFk2Mk9hT1gwSGdkWTU5Nkg0N0cxMEFCVzkr?=
 =?utf-8?B?amhiSFRaWjRpaUdYT1pON0FkQVc2Zzh3UEpGc0hMb2tyd1JOdTlPUT09?=
X-Exchange-RoutingPolicyChecked: 
	UUoUusZh4Guy9BRXcItuRZn0k8kPAgIqqxeh7DwHNpY2Uar2+0QQX4NEv5L+VDdxqHAhwOqWXenu7WKhwDhphqwJ2dEkSm3DRt1ITOyiRd35Sug+KeYd4no1TLJakxj92KIeJAXJcGT/LYM8izYuwGpro60ynTGGQtIGAbcTI0DJbg4u5bVgLPhBYZ9HFEpJNIOIlprG0Aw5v6fnBjriw4sh2QS08TDSkefi+TbZVMJTKsOpY5T1niqaxdjly5zhsnxXZd/QzsWttl6/2pcn0hsgzCAOEW38eNhMX6As9vo5onFFOhTvLR1KUeOvny1zZuY7ViTM75jhuxXGZ3ECOg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6faa743-9717-47a0-9e61-08de8432160f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 14:32:58.9588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQ+rryzQHt+E95PpUea9kDs/kOctdPWtETEn25RKypBfS06wL7vwIUvVYVCGc5f6AhA2vXMkWtsNYkKbJtXcfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6660
X-Authority-Analysis: v=2.4 cv=CekFJbrl c=1 sm=1 tr=0 ts=69b9661e cx=c_pps
 a=N7UEZcGu6nKKiVkixTDHSg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=iGHA9ds3AAAA:8 a=MbRlEZ1XVp_VAlbNVB4A:9
 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEyOSBTYWx0ZWRfX7tqDma99kTSG
 fe2bEfRxlTlYpgt6V7abcYM2UWMYHrUMc322DFs8HsERLMjNA5HCGtl9R2CIxB5RrBPjch++adI
 AMYDKsQH9aCKKEJgEfoxUtFu17Ako24qpkuMTunL5h3pKZPGvqa1x7yVfgcd99MLbsIh9HB4oOj
 OIxbnPHTAEsrxwK5IuNFNfZY3WIavLAP4qE/cxa2RaWApgIGtKxmMufC+3zeRw7OpjR2u6HHSF2
 CVl2Sthc5KzpsCdBDeNs53euTxTyma2GM527EWTOwBWP3ikB2jezhxm3gEwYxHaF1bvVE/4CojB
 YwcevezB/nxB7x/CiUSNJYjX3dsDqhAffOiADZrJTu7G9YmPcTo4xD+kDuIfRkldX7XaMyB0cnd
 kZEPlIGJldAssrnmwWGTfZEtKkRYdrOp0dT/IfoutGLgb4ukTILxZxUkHi43SD3GC+MkMsireGa
 MAmZw/0ZCLa95tEkSrw==
X-Proofpoint-GUID: eGjJF0IWwyYcdT_oGj6HVp5ksabYc6jS
X-Proofpoint-ORIG-GUID: eGjJF0IWwyYcdT_oGj6HVp5ksabYc6jS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170129
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 14:33:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3490

Hi Jaihind,

On 3/17/26 20:34, Jaihind Yadav wrote:
> Hi Yi Zhao /Maintainer,
>
> Gentle ping on this patch.
>
> This change updates meta-selinux to align with the upstream refpolicy
> commit that switches to systemd_stream_connect_userdb() for user runtime
> clients.
>
> The patch has been pending for a while without review.
> Could you please take a look and let me know if any changes are required?

Thanks for your patch. I have just sent a patch to upgrade refpolicy. 
This backport patch is included.

//Yi

>
> Thanks,
> Jaihind Yadav
>
>
> -----Original Message-----
> From: Jaihind Yadav <jaihindy@qti.qualcomm.com>
> Sent: Monday, March 16, 2026 3:06 PM
> To: yocto-patches@lists.yoctoproject.org
> Cc: Jaihind Yadav <jaihindy@qti.qualcomm.com>
> Subject: [meta-selinux][PATCH] refpolicy: backport systemd user runtime userdb fix
>
> Backport upstream refpolicy change that switches systemd user runtime client to use systemd_stream_connect_userdb().
>
> This fixes AVC denials for connectto and sock_file write on io.systemd.Multiplexer when systemd-userdbd is enabled.
>
> Upstream-Commit: b3060023318b474d0112fbe70cdbbf6dbb1f37ab
> Link: https://github.com/SELinuxProject/refpolicy/pull/1092
>
> Signed-off-by: Jaihind Yadav <jaihindy@qti.qualcomm.com>
> ---
>   ...d-fix-user-runtime-userdb-connection.patch | 34 +++++++++++++++++++
>   .../refpolicy/refpolicy_common.inc            |  1 +
>   2 files changed, 35 insertions(+)
>   create mode 100644 recipes-security/refpolicy/refpolicy/0059-policy-modules-systemd-fix-user-runtime-userdb-connection.patch
>
> diff --git a/recipes-security/refpolicy/refpolicy/0059-policy-modules-systemd-fix-user-runtime-userdb-connection.patch b/recipes-security/refpolicy/refpolicy/0059-policy-modules-systemd-fix-user-runtime-userdb-connection.patch
> new file mode 100644
> index 0000000..0b15d9b
> --- /dev/null
> +++ b/recipes-security/refpolicy/refpolicy/0059-policy-modules-systemd-f
> +++ ix-user-runtime-userdb-connection.patch
> @@ -0,0 +1,34 @@
> +From b3060023318b474d0112fbe70cdbbf6dbb1f37ab Mon Sep 17 00:00:00 2001
> +From: Jaihind Yadav <jaihindy@qti.qualcomm.com>
> +Date: Thu, 5 Mar 2026 11:59:31 +0530
> +Subject: [PATCH] systemd: use systemd_stream_connect_userdb() for user
> +runtime  client
> +
> +Replace a direct stream_connect_pattern() usage with the existing
> +systemd_stream_connect_userdb() interface. This allows systemd user
> +runtime helper to connect to systemd-userdbd and access the related
> +runtime socket/link objects under /run/systemd/userdb.
> +
> +Fixes AVCs for connectto and sock_file write on io.systemd.Multiplexer.
> +
> +Upstream-Status: Backport [b3060023318b474d0112fbe70cdbbf6dbb1f37ab]
> +Link: https://github.com/SELinuxProject/refpolicy/pull/1092
> +
> +Signed-off-by: Jaihind Yadav <jaihindy@qti.qualcomm.com>
> +---
> + policy/modules/system/systemd.te | 2 +-
> + 1 file changed, 1 insertion(+), 1 deletion(-)
> +
> +diff --git a/policy/modules/system/systemd.te
> +b/policy/modules/system/systemd.te
> +index 4c81584706..d8a62eb882 100644
> +--- a/policy/modules/system/systemd.te
> ++++ b/policy/modules/system/systemd.te
> +@@ -2443,7 +2443,7 @@ allow systemd_user_runtime_dir_t
> +systemd_user_runtime_notify_t:sock_file delete_
> +
> + allow systemd_user_runtime_dir_t systemd_userdbd_runtime_t:dir
> + list_dir_perms;
> +
> +-stream_connect_pattern(systemd_user_runtime_dir_t,
> +systemd_userdbd_runtime_t, systemd_userdbd_runtime_t,
> +systemd_userdbd_t)
> ++systemd_stream_connect_userdb(systemd_user_runtime_dir_t)
> +
> + files_read_etc_files(systemd_user_runtime_dir_t)
> + # read /etc/machine-id
> diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
> index 2e1a929..998be7c 100644
> --- a/recipes-security/refpolicy/refpolicy_common.inc
> +++ b/recipes-security/refpolicy/refpolicy_common.inc
> @@ -74,6 +74,7 @@ SRC_URI += " \
>           file://0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
>           file://0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
>           file://0058-policy-modules-system-logging-make-syslogd_runtime_t.patch \
> +
> + file://0059-policy-modules-systemd-fix-user-runtime-userdb-connection.
> + patch \
>           "
>   
>   S = "${UNPACKDIR}/refpolicy"

