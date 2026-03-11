Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE61FD062B
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:36:27 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14663.1773210983044024539
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:36:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=i6PMKFwj;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B53Y112763276;
	Tue, 10 Mar 2026 23:36:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=hQzkIjCgzkTVwKfm5g924gkn1Q2bpMAGA8/c2aoWNGY=; b=
	i6PMKFwjZpo+6s5toqc0PFeKDyFYdFI12gq1CvHkWrA6NuMbylJeExEj0XY5lXnu
	lCXNqRJwQA2DoQbqOFDFzNV7z4+arBin2rg0yz2vh5BDtJhSlTjYsJJLYNvvYsLz
	YVZsm1+OvFnxjJUDfeeIzclJ/eDapkw35KLtSHudPGT/ezGmWMdV7cqo2B3I76QD
	u5AkJZj0cKP9DFzyghVlXMSkJHXwJMf1wAGXaAayg47DlHHiENOn8FcP9L2RKnz9
	4EB3C7YwEKt3A5b97rJBn6czMhe6zo7g6CvC0lzFwGs4NcBBeNSz1+DQ5ODm+RNx
	QNj4bgi7S6D4+k61epgdGA==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011049.outbound.protection.outlook.com [52.101.57.49])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty3j075c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 23:36:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsTmXy+7EKtVDqLqFpmF4d2MNhLVkce2eRGIuHNp2NwSsnU6MwNULMPa8rsqFPUs3TjtslmfGe+3Wcw5UOY4ABexlKoNpQz3ac4cGajzI7JiVGbQk+mK9lXRt82sqzkmT4pCjjrTVBwhkgmykQo8N6dXxTeqIbKbrW8zU0nQzfSmYRpeEpPRfe6JuAPWUnjNx1FpJ80sqaTEhW63yKo8gtj27zp1f2nTrS3Ed2F2+eBCOr2qNi0I11dKfaT7+nhzALY2RhoF7h57SKA7J82UqGKYAZuOsd8XrpDT9YAkZ5FTPUsXTQCeUlucn+JDIc2H6dOh/2Ke85W8wnckF7imjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQzkIjCgzkTVwKfm5g924gkn1Q2bpMAGA8/c2aoWNGY=;
 b=QRPtvfXGe6FItoKs5sY5h+gkn3dSe3EgsyDLQUXkqVFsBWyHw7I9OiQoZ49e4+IaFnuvv0bksN2M0UrwU2WKX6T6mg+ZNiNGdxJGArTGNAiPVeiP9Mf3gKk6XtGJH/ZqwkacpIX63aMU3v0x0uv/epyPl+pZF5320ymRBGKwaCw3h5rPWgzLwWEmDB8OHP4LFW0RM2fEkc+c1+sOJMtw+CT8wJ2bAowliWe6RRnphfn0zcYqLR/MRBg8wZp8AxRA5hzqaVvbDBMgm1UbJ3i0UmRIQaT53UacmQ54LAmxqKPC8kxT1sG3IS9dSoGxHG/D+rpB3p7FfAoInQC6RVWkHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB8787.namprd11.prod.outlook.com (2603:10b6:208:598::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 06:36:19 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:36:19 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH 03/11] requirements.txt: remove as it makes no sense
Date: Wed, 11 Mar 2026 14:35:49 +0800
Message-Id: <20260311063557.229656-3-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311063557.229656-1-Qi.Chen@windriver.com>
References: <20260311063557.229656-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|IA1PR11MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: d5551a60-dc0d-4c4c-50f9-08de7f388119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	CI8t1HO5H8D4E0+gJSr5uvgZsgS3Slkc4+ZqvM0McLE4p1Py1qVbbN834oONtEB/VINpS8AEE1tgF8UUuNyEoOMC+z5Fl2jUOpxtvlOWBWt33H4DBQGIcuBfwSoag5LU7rl02qeHDYrSS3/+Ffuj6K1AitNkGBbvQvbpplGWL+OO6/2ChH24us9LGZtNSevv6KvGvHikMwpQ2tcTsCt+Do3qeYx3OlMNP1XVWBbrnWN4SSAIT/kIXdcsdOQGmJGxyRd576KiJjpQyZtO+UXh7mCDdbprKnH0a/QSjyQ/zk9jEpZMy4ox6F5p+F0dJjlb0vAiJjKULtWAoGb8uuM0qCoqGtY1o6s1sQlMNLhf1RCB5A3Sx2AKLzLTfDWEu3YWoa25JGrZozpDlXx56BTSMzOWvCHV5u7OCZ6tEx4+JdCyTqGXxuD5PXPGsUIqt2zj1o5BorWbcLKQLm6ZhYInOetxYAfQaPoXaR1XWFx1J4nyQe/suGlHxduMHHT64VvcmfOwFsKOZ1iPeayY7kSkCaYYuBD6DzFuvk6rgmC95xA/e87WbBLo0p7zxgguNyC3e8fS97PIGj6S6HpdGeRj3gzlxVKv7gaMJJECmdA9VpML1Je36y13CYbjri7x1nBARLnrPwwpW68mLs5lqpy3k8WIqXaA/TOrg69aFpb8VQ/+xJ1lWBzBs5DHYd0uFu1hKmHNat4rrs2ult/tVCfF4InzoQPmAhD1Q0cw+C3zHtPrHHGvfIlPC2zgIJBoQ8hoHk9DGMjDGHWbXRxmQLED+3NQpmhV7F7tnNAPubGXK9k=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TvJin9oEdox+xNU65ToYmGzPdnO3bUdL6nV+bQ2WQ8FP0Vp1NEvggo1bHf+3?=
 =?us-ascii?Q?kgWZiix7jD/XLRimwsUT+XKuqnTueDtzyYhk33mGASEhMQd8FxRHGIn8T1/a?=
 =?us-ascii?Q?VkmNxFVVESGz3cNR9t460Ripn7FuUeAT6WE7xtD4Y9F/o5Ilmwp2ELSGsXb+?=
 =?us-ascii?Q?GhSluGBxg+abcBd5XiGT/JY0xV6HavQw1hte0R0Jsv/Xy15eUwhQrLfEdoJe?=
 =?us-ascii?Q?n3u6jshK5X6ZQS0xSw78NEm/rdhBUoSoiqMWjZfD0lgHRcOQ0ez6w4umRcu9?=
 =?us-ascii?Q?Ct47V0sFtMWjNWSoDlaHcTyJyQvFQ/5hTL+hswwqZ2H2QuhR8Nw++ZkZ/F27?=
 =?us-ascii?Q?Q+ex4evPF2GsgOjdw2X44aYVmOXLHfnKs4IlfmUkgVFXvWcXixv6i/NxFlXb?=
 =?us-ascii?Q?GcX7VA7SgyCkY1tMERry/kYyKzsO9ung7x+pXyFbVRKJ9Z1mf07UxKGiAkab?=
 =?us-ascii?Q?+6Il2CaTlKGHmdlCcXxhP//pwam1i60RW/8bVbS2g1bk1qHSwd9tNif/IBUI?=
 =?us-ascii?Q?lypF07XCn8qVWfzb+2v2q/WtlpbNhM0XvhAudrjAaB9rpQr6Z9w3J+yOSdEZ?=
 =?us-ascii?Q?yhYyQNDd5XSy6xuFN1WICg7VCKb9eQuhAlxITJO/mKze0DbbzRWvfuG6W9tx?=
 =?us-ascii?Q?sraAHx+XI6fi5ub3ZAvfDBiIAoKSKMPG+rIi5duIGeSllKkjbERQZ4v15fFc?=
 =?us-ascii?Q?x05P3QO/CQecnXy3469PqiDjUq7qMUDlquaHkXi2x66IYdsT1+6P0pDVSFJu?=
 =?us-ascii?Q?wRRH7sHsbnCDVxu4a87xbuX8uu0Rlgzl1A36PTtFJUbZ1tT/Yn6wdvpxGtnQ?=
 =?us-ascii?Q?LZ+bro5e5EGDu6cr+kSmxXLdEe021JMsYkFqWi9Bwqsa78y3G9/Bvvc/He5u?=
 =?us-ascii?Q?rRxYEwei3uzVIJyN4IXEMb/h01GCHqCJEJ0nbQNgQq3VT0t965fTITkQQ/bd?=
 =?us-ascii?Q?qAFsHGlio1KfEETaOPM0DRTTRfdXhVWOeKtTOvnc7M/A2j1sVkIjYaw+wiaY?=
 =?us-ascii?Q?s6lMlSzuvVV+vCwd94drxiKlDBHFmXeBaBbOuZm7+ZwYOMvvxRWRxczFT+9w?=
 =?us-ascii?Q?jR7njT6ZULaWhBtmN/dtlVRwt4aS3Al8BaaVwGLB0lIzC7KGoumbVc6IPXw6?=
 =?us-ascii?Q?cH2BwBkWaAzHcq70GVzPiJCLZr+Os1+TGnvMrAvDfComRphSZlosZmvLsD+F?=
 =?us-ascii?Q?wukaDMF7XvWZ3f7Orivhnrxu1tUnp7Ttt8Dk42Ig6Q6gq3iBLis6GTf42Zyc?=
 =?us-ascii?Q?x3WkT/mcPurSQB4poONExuvQeQytDT02wQgstqJMymPXq86m16QxlEgF8T4a?=
 =?us-ascii?Q?QuCBpl61rAwTy+85p83LhokPJrYIxbLwoYAbLih7XPdZkmjDtlhCpkoVSNze?=
 =?us-ascii?Q?N0nPXRpCDyRWZ0mv5wetRk2y5X9X3f3H9Owm3WUi1ERU4QZKRKp9VSZEJbdH?=
 =?us-ascii?Q?+di9XRryeLjCv31U4vFxyfYWWEVArj6XVZkbRXIMidsoTM+teJVpMA7Q+BQw?=
 =?us-ascii?Q?6tAqetYGVEHqgQ8AjA7VuTNSsbzHTdFTv+y09SmDnqzUwJPOZBySPOs47Vqn?=
 =?us-ascii?Q?9AziNUi40UMATz1KYLFGT6mxbHdVyAlmRaTwkBPMMxNo9YlUyCApYuPNsq6o?=
 =?us-ascii?Q?0Y5tUDAUiiA17V490IEDfISyux9eRlCNNUHZ3QSaS98/aa1zNNqRfQWWmeUE?=
 =?us-ascii?Q?ig4OWSp5Tmxn8UPYnpTjrLWhUib/2RBDY4YkkEHnWk7yelWNEPCqmUB/hBfg?=
 =?us-ascii?Q?KiFnFoKF9Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	Avrkk6hLf1GNLF+Rhj3e3GXvUHhEHgGsDHCxTjtmSMlLpz1BwIZ4YJhjmNka40RdxIkiAGU2C6c/YqOcGSJB2uyv5bMZFkGqfd4rbatdWp1avcmCnEnGF7SnGzFqOCudBRhHOWwF2y/eQlK02xX5tBXC5p6ZsUTXi1yvW1mW6QtOYd7vBuZHLBEUexSykflFuCqIw25UopdC4yDTO6sIMir0EVRNEAxixfkPnE3BzTwNDtbVFLIMvDPO5+mHDcBhlo44M7MySDFZBsgKJ/HmWC3ur0edXz8aQWsVqqC6lKY/Wq9xvD8tGCiDjotj7KLA0+KwTYoH7qWXkHjnYL189g==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5551a60-dc0d-4c4c-50f9-08de7f388119
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:36:19.7096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVdA2uTllQald75DqhmZlYgn8MqT1pe8gKuBJIbDY8vLDqyQuzGBvhbZEKILAidMePBq2pJD+F4VtXTgukcN9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8787
X-Proofpoint-GUID: yRBz6ferb7B8MtJmFbw-gb7IU9TRMkNe
X-Proofpoint-ORIG-GUID: yRBz6ferb7B8MtJmFbw-gb7IU9TRMkNe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NCBTYWx0ZWRfXwHP9UInDZxNN
 mX1faB8NLXcg75yIApXTbIkVw0v40G9mi7rSgS9eU3RiLbDUP8UwSmNKufQIQ/pWZwA1E5VXPu8
 sL1fTnpnDsBUWMoT2fQ+OkvLXMUlsuB+znbskyd8M1RL1fWCoVWNP7kz1ZKV4p84qtH4uVFDD87
 YoOvI6I1MV9E5zEc+phioZPhVZJ6pNTPDH3Wbg2EpK/UeYbZYQuxqJgwxokF68YWmUIsmIhP5yN
 Ksd8TOjMcHZfqrMH+DBJrcUn7Cl5MymxTGnOFTVV/mK65hFgwAN59mTyJyieMH23pF4BliaEv/x
 sd1WgHFUaAuw+gqpL+jVePnRFqOKDeYz/MB58VS6C9yR5wsMttifJTZ1MnLn6LPQ527TSPDPRZg
 RiiOC2TDb2dnuUyln+BV2e1vqbIMLejwFW3X3Wsn6+gKg1gBDH8aWEBZId9j+ypY0q4j5nt0oMU
 g18jKptJPMuGd6ZC2WA==
X-Authority-Analysis: v=2.4 cv=Qr1THFyd c=1 sm=1 tr=0 ts=69b10d65 cx=c_pps
 a=DQgCSL4B2z8Pp8IQPtpfIw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=KdazThy4EY_gBvstyO4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110054
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:36:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3404

From: Chen Qi <Qi.Chen@windriver.com>

AUH is not using GitPython, it's using 'git' command directly.
This requirements.txt makes no sense.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 requirements.txt | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 requirements.txt

diff --git a/requirements.txt b/requirements.txt
deleted file mode 100644
index 64b1ada..0000000
--- a/requirements.txt
+++ /dev/null
@@ -1 +0,0 @@
-GitPython
-- 
2.34.1


