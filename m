Return-Path: <Haixiao.Yan.CN@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E7ECCD1A5
	for <webhook@archiver.kernel.org>; Wed, 22 Oct 2025 02:06:19 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.4554.1761098774047871428
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Oct 2025 19:06:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=cvflZ3zk;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=2390f65e28=haixiao.yan.cn@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59M0U2q02155246
	for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Oct 2025 02:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=xTESVZGD+o8mgMO5v0FRpzIJZcmXxNcHxRVQMnQ6Hm0=; b=cvflZ3zkymRI
	ScDrLjQv5Bwf4NvnYlzwzcRcW87ZEbmcaIXTxrKpdEZQJQRYWicn0S88/eOyizk2
	76aM4teOq9m2r3XQfoMoE7QC/vIiWKkoA3yDuuEL6bktySQxSeXM9wjYYTLBb47u
	AZ1JZlhY9sv5A7h+dmEUFSzIDpARP4ljp+X53L3okAknZb8b5FA9VeeYWma+oiCS
	fpAvIGhcRiKvgeaw1x9j06X6hTecvK4xAlIcx6Clw9jW9eOB1tQfI3iZ2kCoxpUE
	/ElCcWAQWz69Ulun2whnv0lEV1mU5XAhxgibr/6t0x0s4fzTpt3ieMfthd9tKSeX
	NXDHySjiyw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010031.outbound.protection.outlook.com [52.101.193.31])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49wrpx9wka-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Oct 2025 02:06:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kidZ63vbiriktu2VTbsr0wAAzdwV96e6h8iw2I+hfCoX/329VsYxA/VAxznh1NjGQoml+KdAMKuKSTAlMpfUAT+65rdDVzMZLi2/rpB3fNlGk7ZdN5XybdydgD4gDjZkVptLi9gWmwu9fa26Jl05YMdXxmvpJ/jgSEAJt5qt1ifi0OGixPLtQ5IGZi+SdMBfMiQmLbjuvIeqokB7SwuHm98MNL7wW1SxkffxUtvQlr9dHE6lr1EEtCNRHc8Q8jcK8ed6qnBGoxRGL+oZ/iWV2Ytl8rpQPZIsgqUvAPkoYtx3wpb5g7XIMlFczBZfvynsKclUenywl9IFu5yAhVRXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTESVZGD+o8mgMO5v0FRpzIJZcmXxNcHxRVQMnQ6Hm0=;
 b=vqdpjknxGjITtqnWYLHIja3xLT0THpNQGXta9PLY2NrTy3X58SVb8VnJMV2RzvQnPhdSCwtG2jV/qFcu5FbRD97C57+3tEthDrvaaAVvinj9fBksyaqlzy1zNWdRqbLDB/0CrB2be1l+Zvkf80rwP9Xs/0M3XLPJpImbWX3yljAUuiolF2bzL1olmY9bx3HBTkzV2wh2q+y+JKKGs6zQHxaXdqb9dtZjF7yNWmOG+UJOHqK6nx6IlueYEawET7jWJiP+rLz25g8oUSY2HiqvQvz8XyKkY5hkybtEkqHHOc+hi/wrOQmkqbE0EMroJGuEzVqPqreb1rONusTLleMF5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB8200.namprd11.prod.outlook.com (2603:10b6:208:454::6)
 by DS7PR11MB5967.namprd11.prod.outlook.com (2603:10b6:8:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 02:06:11 +0000
Received: from IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::b6d:5228:91bf:469e]) by IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::b6d:5228:91bf:469e%4]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 02:06:11 +0000
From: haixiao.yan.cn@windriver.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][walnascar][PATCH 2/3] python3-fail2ban: update to latest git rev
Date: Wed, 22 Oct 2025 10:05:47 +0800
Message-Id: <20251022020548.3644179-2-haixiao.yan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251022020548.3644179-1-haixiao.yan.cn@windriver.com>
References: <20251022020548.3644179-1-haixiao.yan.cn@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0135.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::19) To IA1PR11MB8200.namprd11.prod.outlook.com
 (2603:10b6:208:454::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB8200:EE_|DS7PR11MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 81caec29-257d-4ff9-9626-08de110f925c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Gk59rtBLrqLsXtF/EWQDN9IsDvRPO3BOo6RMcB3Rin7N2GWcCMpzw3YLYUdT?=
 =?us-ascii?Q?OqEzFt6KTZWX4Lefola06TcyMs0sAd4N9HPCuS3WMnL5V2DyHKWOoG7+b9i1?=
 =?us-ascii?Q?ZyUEjIuDa4356JOIyQShsR/Gaax1DoLMmHLvWArld5CZyD3X/Pe/VpyQCTnz?=
 =?us-ascii?Q?Ts604HF0hBge3DjnW7YECyqfqF3ObKcygBIbstldaCQs+/m+gLd0JKyR8DkN?=
 =?us-ascii?Q?rzsiO2OwUukpXtVeGfJWE5AXh0E6903CcSzLyoSSXvCbQ9deK2mbckgn1yQU?=
 =?us-ascii?Q?U2XTXL59Fnq/8BwiKIAN8pz+vMhd9MJ7oebrfCk0a3iHaglcGyamXHjbt8zP?=
 =?us-ascii?Q?WD91GnhCsow24M6nUFkewr3d7p00yuYU2OinL+qzuNmQk2OTbphkw6sMzp+c?=
 =?us-ascii?Q?5/kEAmO8ISzGlMB2Q+sy0vjbLCWVXIUeW1BBEpXGUGw5tUw2rk5N67W0ijxA?=
 =?us-ascii?Q?ddwp2Rbw0r0iM8Cx1/7C7842gYCVxC/BtS1q1wCsbQvDqGnga4LuQ38jV1w6?=
 =?us-ascii?Q?zRJgeJq8dt3HwJplgVk3G/NZ+AXRHTCBXOsgKu19NLBvWv+0Q/ia8vTASldF?=
 =?us-ascii?Q?3uqyNSJSHUfo8slTyRZSYj54WfGNoucKAgAeRNyjqs0FMxmIobYxcqjrpsGg?=
 =?us-ascii?Q?PDPN9e+kUIviKPu1qahAMmQfYZddr3QihfBOhlFj3vJps9wCajSTx7lns+mU?=
 =?us-ascii?Q?FOIIvGs9COlhzwDLjbqpRqGG7V0kGeohbsQUDdq/hBBhDA7ZslzaTjnsAhFL?=
 =?us-ascii?Q?dsleJaIwoFqRnQWzUkGUDpnk6lFAqTLPjK/hutj4GFnCF2uaMdaCY7pyehsS?=
 =?us-ascii?Q?KkQmNahLEUZFADaHXJMUJkdrRmETtwvU+1LKXeGYb/rfbvfILZteMW8zEHYV?=
 =?us-ascii?Q?P29fwMp0/yiPZB+ZOkE228zCD0dhPhZCxax4gWW3q/0RoE7KN2ldlla4Sc0q?=
 =?us-ascii?Q?hwDIlOqv5jC8d+k8iC3SCpNjAeKJ5zgnedfUaHGfiPum/nmAqZ8Al08q3LF/?=
 =?us-ascii?Q?5GWQu/zMvE8VDCojVfVFpjofq7YzumD4wizS75K/13WTQ3E8A6lr3ADrlRYN?=
 =?us-ascii?Q?VQ58eqVw+SiteRyb+6aRJ9snlEng0hzyS5PBIxD1n9F02GXscEECVQFdJInT?=
 =?us-ascii?Q?bmFSV9J2GF6nTZ0LdPlOIhshRHKOQMizGV4L+4kliDYc6huWdxLJHvUgsq2r?=
 =?us-ascii?Q?tWTUlWwrX615C9u2IgBo6EFCfNJq6+C59yxnZqRaFYvKwMccg0GGZbVwgvap?=
 =?us-ascii?Q?YmYvFmUUMJLzqaWF+4icPYg+qtJLjtOsm6kDgMjYtNAhGTofsff45VmXuQHq?=
 =?us-ascii?Q?rllOzTlwXSx+UbOeXzaOpaRMXf7kB5TDh3hsyi/wTUFtX2+rq4FWZf/iAJeS?=
 =?us-ascii?Q?0qx7cjEohQN48kex8ntuu5KriDMKg1tfjvZ5RhLTkrJ8COceJKkGrLhaSgtl?=
 =?us-ascii?Q?ZnJWTKtDdWgJ2w77spmbz9lMsXO1m79iAvK+n7Su3GoF7FwYw+dqCA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB8200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(13003099007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nh0fAEF9pvHrZPg08EAxKpZlHFNr6jC2Ik4EL6FbZy8jbwjbHSd+SLyCrqJg?=
 =?us-ascii?Q?wIQavjHSmALfH23BfCQLucHt2xV8imIKjBXrcN05tlFoibauCHXmhEn0bWB4?=
 =?us-ascii?Q?GF3RwNh0Rzbz2uYM0dv81/aolMpmKSXoBZGlfypNh6qIq/1ryvRgQpc9QCH5?=
 =?us-ascii?Q?nJJkaoaPq7MkOSJjby8MJEDMwp+ScWSA9vVuwMzDF2YMAUrYkMzrMN+zgf3/?=
 =?us-ascii?Q?q2OZsjVcSTI8NAwSN9FVp+TQHwi1Kae+ZyGpGWT7RUJFeE0nKfzTvm2o1BiG?=
 =?us-ascii?Q?y1z/KvP1uGJW+o9GI5/hrxVwQCzOU6mVf8vvS0zgoWS5jJSGqZE/WhL6c+MV?=
 =?us-ascii?Q?uAFrrt4G4mCLwzKb62WO0SCsw4RRhsOFgmfRlLftbk+rBcMk/HtmJJr4LzoL?=
 =?us-ascii?Q?aPj3ERujWjPP5EbURXKAllVcTnNkOvu6obPAHY+P3+jDy7LXQnRh/yoWaso8?=
 =?us-ascii?Q?9u3crvDs1mGzvbT12mHiQ2nGELoTIBnEUcBd3toqwurn5A3SDObZb/h2Dq7n?=
 =?us-ascii?Q?IireLVHrYotEjM1//EURA5rKiFSuyiRPSJUyPV7YAE4ezN35E0snzEMJu5mX?=
 =?us-ascii?Q?38J+ln7Pb4Gb1NQxNNmF/+CdMowZ36JJujEicYiEoXh3/kE/qWsieGt5nHMP?=
 =?us-ascii?Q?+DiHj8AhIbyjypqMGt4Ej2Quskoa+p5gJUacdZWjE+SSlP7g+LnJlqnXb2zT?=
 =?us-ascii?Q?5HpmvQlICY7bR7XsNhV3KJX43/HORVKleROCcVR99nOYdCf08DVogdWrN7hY?=
 =?us-ascii?Q?sJeTTayBblFj1YTWcPl7RTbDKMyplxCgT19VmUOsglitRA32peASVVolWGZr?=
 =?us-ascii?Q?//efOQ76ocf5fq3sgDPN/MjiN2nGVd9AB9kZYrVFW3hdhyOsyX67paVsYgq6?=
 =?us-ascii?Q?WHYZzK41ubpbyyEQAMdJIcSe9q+IJMsMuh1uKAni5Y3A44Wmh2eD95MTegK1?=
 =?us-ascii?Q?oV0V7vQkjrmzEdmvsC3eUZunW6tAgXavBkFN5dZnBQ72622dqaYG3jquI8Jc?=
 =?us-ascii?Q?5KG9Mssc5bQRPy9oBqZ1L/aptgWAGQdNFWC21ZVFRzfXVccJOFljfiygwJjZ?=
 =?us-ascii?Q?7VQiBijSc00kBQxIGgeQYxWBNDtB4CXXyhOmyU9uPTsDIrnowdsjylenSJZA?=
 =?us-ascii?Q?FjgGvVjbDyRSix1oUMrhAv7aTwfFbLOQA5pN8FZSx8JXPT1sE5upbaGdKH9q?=
 =?us-ascii?Q?e8shSFyM3GKPF8o4HX4xTa8ExNPee1uT5w8eMH0rrfbxlPG6lfd3Rud7gdi8?=
 =?us-ascii?Q?6vVBNfJggBibRLbRqjU5QKDCxSckjQv7EqnU2W24FQW1XK77vhqiRq/V6XKa?=
 =?us-ascii?Q?l6oLpDE25Hpjfg6B2xMlNh7gDC7YqySx262aDFilWNQEq2gWsFUVIUj5MR+h?=
 =?us-ascii?Q?yvXDek8eReTE76O2LKZNjT41yAKmiVtYdjr6ZD+CYTSVagG1hnxhb3zU4VVg?=
 =?us-ascii?Q?MQLWLpK8J+0/rCdhgeRaPxBwl1e7Q25OaU7grLk1A65Y/XWKWZAS/6691+O6?=
 =?us-ascii?Q?rvHDsTT6hxz5wUFIVsbbqRx85u1l0KWBnSMqS2dxrNZ5WOnoaTyMJ1S1Acnh?=
 =?us-ascii?Q?ei1lWPTWZfrnVRujdlinybwFHiigypWP9UHpvlB29gtchH2v4xdAaLvqiZnr?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81caec29-257d-4ff9-9626-08de110f925c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB8200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 02:06:11.2145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktaqLc6q/we96CaLy3H/oU33R94YigHxaiYZ/gAGib3F5fEShWXr4kKNxHfQj192hq556pn43mmOX9J+OrVtDDku6rfo1XusSk25xwIxzo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5967
X-Authority-Analysis: v=2.4 cv=b9O/I9Gx c=1 sm=1 tr=0 ts=68f83c15 cx=c_pps
 a=JYb6bdnaVjS17BdPGRuFtw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=1XWaLZrsAAAA:8 a=t7CeM3EgAAAA:8 a=A1X0JdhQAAAA:8
 a=ktNasmvQAAAA:8 a=xqzR1eaSAAAA:8 a=DT1NhrL8wyKqG5jDLEEA:9 a=2WnUeqSxssMA:10
 a=FdTzh2GWekK77mhwV6Dw:22 a=e0GJpZYNDejI1RnTdwpm:22 a=dV6nhpJrT-yxOfsl7Uss:22
X-Proofpoint-GUID: -ZaSWqH6HTT8xzoAEGFeaUaRvlwZTlgd
X-Proofpoint-ORIG-GUID: -ZaSWqH6HTT8xzoAEGFeaUaRvlwZTlgd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDAxNiBTYWx0ZWRfXxErLKZLGA5fU
 4ZW6hDMNRiTGDF+wgQ8sEshRPhOFfJEoslXibzgzxk0QYFAxP2YD7i2IS7SSH1S5h3y7ZUGaOP8
 A5VIr2MCLoH3TWAHJWlpbe1eu3m5OreGqkC1QVwUlaosXMOIALza6eiwMYO8srqBBu/59DtB9rQ
 GQznGim1tXvu5vpazAcmc/sIBZezw1Jbwx1CJu5FRjgp84bUF9hAqtR+hmYRoP4Lsmd+AqdUula
 1Xi2bb1QQPeD+lv7eVASVAbiIQXL2aZ1LraXDPyJLRwQecWJE1b5OKGTRAwmaHhWaUyiiJ/IVJd
 /CmpPX83n9FWdLbOUKeY89loggEsQ5tw5O7ZYBCEnUl37vyNQefseScxLyiTS6fd7GuRgTJ6IjK
 RS2iVfS6Au8FJvLov1I5tUewI4P0OQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510220016
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 22 Oct 2025 02:06:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2380

From: Yi Zhao <yi.zhao@windriver.com>

Update to latest git rev as the current version doesn't work with
OpenSSH 9.8+[1].

Ptest result:
$ ptest-runner python3-fail2ban
START: ptest-runner
2025-09-21T12:45
BEGIN: /usr/lib64/python3-fail2ban/ptest

Ran 538 tests in 13.045s
OK (skipped=3)
DURATION: 14
END: /usr/lib64/python3-fail2ban/ptest
2025-09-21T12:46
STOP: ptest-runner
TOTAL: 1 FAIL: 0

[1] https://github.com/fail2ban/fail2ban/commit/2fed408c05ac5206b490368d94599869bd6a056d

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
---
 ...ges-the-IPs-again.-additionally-it-g.patch | 210 ------------------
 ...case.py-set-correct-config-dir-for-t.patch |  35 ---
 .../fail2ban/python3-fail2ban_git.bb          |   4 +-
 3 files changed, 1 insertion(+), 248 deletions(-)
 delete mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch
 delete mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch

diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch
deleted file mode 100644
index 73014ab96a15..000000000000
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch
+++ /dev/null
@@ -1,210 +0,0 @@
-From 5b6c13f0aae79a23d94570bacd1b5796e57f088d Mon Sep 17 00:00:00 2001
-From: sebres <info@sebres.de>
-Date: Thu, 30 Jan 2025 01:05:30 +0100
-Subject: [PATCH] example.com changes the IPs, again... additionally it got
- more IPs, which look unstable now (depends on resolver), so replaced with
- fail2ban.org, that seems to resolve to single IPv4 and IPv6 (can be adjusted
- later for something more persistent)
-
-
-Upstream-Status: Backport
-[https://github.com/fail2ban/fail2ban/commit/5b6c13f0aae79a23d94570bacd1b5796e57f088d]
-
-Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
----
- .../tests/files/logs/apache-fakegooglebot     |  6 +-
- fail2ban/tests/files/testcase-usedns.log      |  4 +-
- fail2ban/tests/filtertestcase.py              | 58 +++++++++----------
- fail2ban/tests/utils.py                       |  4 +-
- 4 files changed, 36 insertions(+), 36 deletions(-)
-
-diff --git a/fail2ban/tests/files/logs/apache-fakegooglebot b/fail2ban/tests/files/logs/apache-fakegooglebot
-index b77a1a6b..024842fd 100644
---- a/fail2ban/tests/files/logs/apache-fakegooglebot
-+++ b/fail2ban/tests/files/logs/apache-fakegooglebot
-@@ -1,5 +1,5 @@
- # Apache 2.2
- # failJSON: { "time": "2015-01-31T14:29:44", "match": true, "host": "66.249.66.1" }
--66.249.66.1 - - - [31/Jan/2015:14:29:44 ] example.com "GET / HTTP/1.1" 200 814 "-" "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)" + 293 1149 546
--# failJSON: { "time": "2015-01-31T14:29:44", "match": false, "host": "93.184.215.14" }
--93.184.215.14 - - - [31/Jan/2015:14:29:44 ] example.com "GET / HTTP/1.1" 200 814 "-" "NOT A __GOOGLE_BOT__" + 293 1149 546
-+66.249.66.1 - - - [31/Jan/2015:14:29:44 ] fail2ban.org "GET / HTTP/1.1" 200 814 "-" "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)" + 293 1149 546
-+# failJSON: { "time": "2015-01-31T14:29:44", "match": false, "host": "51.159.55.100" }
-+51.159.55.100 - - - [31/Jan/2015:14:29:44 ] fail2ban.org "GET / HTTP/1.1" 200 814 "-" "NOT A __GOOGLE_BOT__" + 293 1149 546
-diff --git a/fail2ban/tests/files/testcase-usedns.log b/fail2ban/tests/files/testcase-usedns.log
-index eea6eb44..3e7b36bb 100644
---- a/fail2ban/tests/files/testcase-usedns.log
-+++ b/fail2ban/tests/files/testcase-usedns.log
-@@ -1,2 +1,2 @@
--Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from example.com port 51332 ssh2
--Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:93.184.215.14 port 51332 ssh2
-+Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from fail2ban.org port 51332 ssh2
-+Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:51.159.55.100 port 51332 ssh2
-diff --git a/fail2ban/tests/filtertestcase.py b/fail2ban/tests/filtertestcase.py
-index 20945b78..26961a1b 100644
---- a/fail2ban/tests/filtertestcase.py
-+++ b/fail2ban/tests/filtertestcase.py
-@@ -587,14 +587,14 @@ class IgnoreIP(LogCaptureTestCase):
- 				self.assertNotLogged("returned successfully")
- 
- 	def testIgnoreCauseOK(self):
--		ip = "93.184.215.14"
-+		ip = "51.159.55.100"
- 		for ignore_source in ["dns", "ip", "command"]:
- 			self.filter.logIgnoreIp(ip, True, ignore_source=ignore_source)
- 			self.assertLogged("[%s] Ignore %s by %s" % (self.jail.name, ip, ignore_source))
- 
- 	def testIgnoreCauseNOK(self):
--		self.filter.logIgnoreIp("example.com", False, ignore_source="NOT_LOGGED")
--		self.assertNotLogged("[%s] Ignore %s by %s" % (self.jail.name, "example.com", "NOT_LOGGED"))
-+		self.filter.logIgnoreIp("fail2ban.org", False, ignore_source="NOT_LOGGED")
-+		self.assertNotLogged("[%s] Ignore %s by %s" % (self.jail.name, "fail2ban.org", "NOT_LOGGED"))
- 
- 
- class IgnoreIPDNS(LogCaptureTestCase):
-@@ -607,7 +607,7 @@ class IgnoreIPDNS(LogCaptureTestCase):
- 		self.filter = FileFilter(self.jail)
- 
- 	def testIgnoreIPDNS(self):
--		for dns in ("www.epfl.ch", "example.com"):
-+		for dns in ("www.epfl.ch", "fail2ban.org"):
- 			self.filter.addIgnoreIP(dns)
- 			ips = DNSUtils.dnsToIp(dns)
- 			self.assertTrue(len(ips) > 0)
-@@ -1892,22 +1892,22 @@ class GetFailures(LogCaptureTestCase):
- 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
- 		# We should still catch failures with usedns = no ;-)
- 		output_yes = (
--			('93.184.215.14', 1, 1124013299.0,
--			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from example.com port 51332 ssh2']
-+			('51.159.55.100', 1, 1124013299.0,
-+			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from fail2ban.org port 51332 ssh2']
- 			),
--			('93.184.215.14', 1, 1124013539.0,
--			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:93.184.215.14 port 51332 ssh2']
-+			('51.159.55.100', 1, 1124013539.0,
-+			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:51.159.55.100 port 51332 ssh2']
- 			),
--			('2606:2800:21f:cb07:6820:80da:af6b:8b2c', 1, 1124013299.0,
--			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from example.com port 51332 ssh2']
-+			('2001:bc8:1200:6:208:a2ff:fe0c:61f8', 1, 1124013299.0,
-+			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from fail2ban.org port 51332 ssh2']
- 			),
- 		)
- 		if not unittest.F2B.no_network and not DNSUtils.IPv6IsAllowed():
- 			output_yes = output_yes[0:2]
- 
- 		output_no = (
--			('93.184.215.14', 1, 1124013539.0,
--			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:93.184.215.14 port 51332 ssh2']
-+			('51.159.55.100', 1, 1124013539.0,
-+			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:51.159.55.100 port 51332 ssh2']
- 			)
- 		)
- 
-@@ -2098,10 +2098,10 @@ class DNSUtilsNetworkTests(unittest.TestCase):
- 		super(DNSUtilsNetworkTests, self).setUp()
- 		#unittest.F2B.SkipIfNoNetwork()
- 
--	## example.com IPs considering IPv6 support (without network it is simulated via cache in utils).
-+	## fail2ban.org IPs considering IPv6 support (without network it is simulated via cache in utils).
- 	EXAMPLE_ADDRS = (
--		['93.184.215.14', '2606:2800:21f:cb07:6820:80da:af6b:8b2c'] if unittest.F2B.no_network or DNSUtils.IPv6IsAllowed() else \
--		['93.184.215.14']
-+		['51.159.55.100', '2001:bc8:1200:6:208:a2ff:fe0c:61f8'] if unittest.F2B.no_network or DNSUtils.IPv6IsAllowed() else \
-+		['51.159.55.100']
- 	)
- 
- 	def test_IPAddr(self):
-@@ -2163,13 +2163,13 @@ class DNSUtilsNetworkTests(unittest.TestCase):
- 		self.assertTrue(r < ip6)
- 
- 	def testUseDns(self):
--		res = DNSUtils.textToIp('www.example.com', 'no')
-+		res = DNSUtils.textToIp('www.fail2ban.org', 'no')
- 		self.assertSortedEqual(res, [])
- 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
--		res = DNSUtils.textToIp('www.example.com', 'warn')
-+		res = DNSUtils.textToIp('www.fail2ban.org', 'warn')
- 		# sort ipaddr, IPv4 is always smaller as IPv6
- 		self.assertSortedEqual(res, self.EXAMPLE_ADDRS)
--		res = DNSUtils.textToIp('www.example.com', 'yes')
-+		res = DNSUtils.textToIp('www.fail2ban.org', 'yes')
- 		# sort ipaddr, IPv4 is always smaller as IPv6
- 		self.assertSortedEqual(res, self.EXAMPLE_ADDRS)
- 
-@@ -2177,13 +2177,13 @@ class DNSUtilsNetworkTests(unittest.TestCase):
- 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
- 		# Test hostnames
- 		hostnames = [
--			'www.example.com',
-+			'www.fail2ban.org',
- 			'doh1.2.3.4.buga.xxxxx.yyy.invalid',
- 			'1.2.3.4.buga.xxxxx.yyy.invalid',
- 			]
- 		for s in hostnames:
- 			res = DNSUtils.textToIp(s, 'yes')
--			if s == 'www.example.com':
-+			if s == 'www.fail2ban.org':
- 				# sort ipaddr, IPv4 is always smaller as IPv6
- 				self.assertSortedEqual(res, self.EXAMPLE_ADDRS)
- 			else:
-@@ -2234,8 +2234,8 @@ class DNSUtilsNetworkTests(unittest.TestCase):
- 
- 		self.assertEqual(IPAddr('192.0.2.0').getPTR(), '0.2.0.192.in-addr.arpa.')
- 		self.assertEqual(IPAddr('192.0.2.1').getPTR(), '1.2.0.192.in-addr.arpa.')
--		self.assertEqual(IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c').getPTR(), 
--			'c.2.b.8.b.6.f.a.a.d.0.8.0.2.8.6.7.0.b.c.f.1.2.0.0.0.8.2.6.0.6.2.ip6.arpa.')
-+		self.assertEqual(IPAddr('2001:db8::1').getPTR(), 
-+			'1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.8.b.d.0.1.0.0.2.ip6.arpa.')
- 
- 	def testIPAddr_Equal6(self):
- 		self.assertEqual(
-@@ -2365,10 +2365,10 @@ class DNSUtilsNetworkTests(unittest.TestCase):
- 
- 	def testIPAddr_CompareDNS(self):
- 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
--		ips = IPAddr('example.com')
--		self.assertTrue(IPAddr("93.184.215.14").isInNet(ips))
--		self.assertEqual(IPAddr("2606:2800:21f:cb07:6820:80da:af6b:8b2c").isInNet(ips),
--		                        "2606:2800:21f:cb07:6820:80da:af6b:8b2c" in self.EXAMPLE_ADDRS)
-+		ips = IPAddr('fail2ban.org')
-+		self.assertTrue(IPAddr("51.159.55.100").isInNet(ips))
-+		self.assertEqual(IPAddr("2001:bc8:1200:6:208:a2ff:fe0c:61f8").isInNet(ips),
-+		                        "2001:bc8:1200:6:208:a2ff:fe0c:61f8" in self.EXAMPLE_ADDRS)
- 
- 	def testIPAddr_wrongDNS_IP(self):
- 		unittest.F2B.SkipIfNoNetwork()
-@@ -2376,11 +2376,11 @@ class DNSUtilsNetworkTests(unittest.TestCase):
- 		DNSUtils.ipToName('*')
- 
- 	def testIPAddr_Cached(self):
--		ips = [DNSUtils.dnsToIp('example.com'), DNSUtils.dnsToIp('example.com')]
-+		ips = [DNSUtils.dnsToIp('fail2ban.org'), DNSUtils.dnsToIp('fail2ban.org')]
- 		for ip1, ip2 in zip(ips, ips):
- 			self.assertEqual(id(ip1), id(ip2))
--		ip1 = IPAddr('93.184.215.14'); ip2 = IPAddr('93.184.215.14'); self.assertEqual(id(ip1), id(ip2))
--		ip1 = IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'); ip2 = IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'); self.assertEqual(id(ip1), id(ip2))
-+		ip1 = IPAddr('51.159.55.100'); ip2 = IPAddr('51.159.55.100'); self.assertEqual(id(ip1), id(ip2))
-+		ip1 = IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'); ip2 = IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'); self.assertEqual(id(ip1), id(ip2))
- 
- 	def test_NetworkInterfacesAddrs(self):
- 		for withMask in (False, True):
-diff --git a/fail2ban/tests/utils.py b/fail2ban/tests/utils.py
-index f71ba60a..e6ef54f3 100644
---- a/fail2ban/tests/utils.py
-+++ b/fail2ban/tests/utils.py
-@@ -326,8 +326,8 @@ def initTests(opts):
- 			('failed.dns.ch', set()),
- 			('doh1.2.3.4.buga.xxxxx.yyy.invalid', set()),
- 			('1.2.3.4.buga.xxxxx.yyy.invalid', set()),
--			('example.com', set([IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'), IPAddr('93.184.215.14')])),
--			('www.example.com', set([IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'), IPAddr('93.184.215.14')])),
-+			('fail2ban.org', set([IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'), IPAddr('51.159.55.100')])),
-+			('www.fail2ban.org', set([IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'), IPAddr('51.159.55.100')])),
- 		):
- 			c.set(*i)
- 		# if fast - precache all host names as localhost addresses (speed-up getSelfIPs/ignoreself):
--- 
-2.34.1
-
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch
deleted file mode 100644
index a60b0fda80cb..000000000000
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch
+++ /dev/null
@@ -1,35 +0,0 @@
-From 9f26da3cf854e48b7939c2a9baa0cb3ffbee5994 Mon Sep 17 00:00:00 2001
-From: Yi Zhao <yi.zhao@windriver.com>
-Date: Thu, 11 Sep 2025 22:36:07 +0800
-Subject: [PATCH] clientreadertestcase.py: set correct config dir for
- testReadStockJailFilterComplete
-
-In test case testReadStockJailFilterComplete, set configuration
-directory to CONFIG_DIR (/etc/fail2ban/filter.d on the target) instead
-of the hardcoded "config" directory. Otherwise, the config files will
-not be found during runtime testing.
-
-Upstream-Status: Backport
-[https://github.com/fail2ban/fail2ban/commit/9f26da3cf854e48b7939c2a9baa0cb3ffbee5994]
-
-Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
----
- fail2ban/tests/clientreadertestcase.py | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/fail2ban/tests/clientreadertestcase.py b/fail2ban/tests/clientreadertestcase.py
-index e6a2806c..b8ebbbc7 100644
---- a/fail2ban/tests/clientreadertestcase.py
-+++ b/fail2ban/tests/clientreadertestcase.py
-@@ -878,7 +878,7 @@ class JailsReaderTest(LogCaptureTestCase):
- 		self.assertTrue(jails.getOptions())       # reads fine
- 		# grab all filter names
- 		filters = set(os.path.splitext(os.path.split(a)[1])[0]
--			for a in glob.glob(os.path.join('config', 'filter.d', '*.conf'))
-+			for a in glob.glob(os.path.join(CONFIG_DIR, 'filter.d', '*.conf'))
- 				if not (a.endswith('common.conf') or a.endswith('-aggressive.conf')))
- 		# get filters of all jails (filter names without options inside filter[...])
- 		filters_jail = set(
--- 
-2.34.1
-
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
index 4d67f85c23f6..98f581ba8074 100644
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
@@ -11,10 +11,8 @@ LIC_FILES_CHKSUM = "file://COPYING;md5=ecabc31e90311da843753ba772885d9f"
 
 DEPENDS = "python3-native"
 
-SRCREV = "ac62658c10f492911f8a0037a0bcf97c8521cd78"
+SRCREV = "2856092709470250dc299931bc748f112590059f"
 SRC_URI = "git://github.com/fail2ban/fail2ban.git;branch=master;protocol=https \
-           file://0001-example.com-changes-the-IPs-again.-additionally-it-g.patch \
-           file://0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch \
            file://initd \
            file://run-ptest \
            "
-- 
2.34.1


