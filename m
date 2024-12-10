Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700DEE7717F
	for <webhook@archiver.kernel.org>; Tue, 10 Dec 2024 13:13:29 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.10060.1733836404718499343
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Dec 2024 05:13:24 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=20745f6cf3=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAAAEmn003066;
	Tue, 10 Dec 2024 13:13:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cx4xaqpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 13:13:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7Y/r9/3SpixgUoxmUW9zsQAJv916yBpqZ5APHzwUQFwV3BWehXPy7c143HDA8D3PBKuMEC4Cf2u8jZt4eGtDLcessY/Rs3XkaNzjkpHzUJ1uoCKkNm6Le8360X/6+jVVkHOW6JNGb5qLFehxdV0D97Rsmu8XcTMIZhx8jh+RCdy0UDGXzn8GDOQbkjOc7UzBJ2RwXHXCLjDsZBUmzlpCfhZWL+EeqXD7iXKvHU2CNPbQb4zw3miSNh28pFtuULf0A+ToTbiMjbHEuvsFetbONcM1csab5rbPJIDlwTWtVUpNSbwPh0C1ywhidk/+RrupgWwtOYlwYFvanMCtntDwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qfE2G+RISYsahYFHxOrRrHyoPFLOUnUZsc/mtKPAsE=;
 b=nzgNgWjO5OOx/71xkHInqacJABvHYLcyO0bFXqqqmEPxtR9PYIDjt4DLCXhA/lkdh3BIUl+O3ZkLXkm4dqzhaS755WU1EXIla3//l23eihIYIn0BKLvz4ebjSxDRwHN2/DpBMaJOirNDKI/zdMVyU1L2L4F7bS+EQRandtMiJLHvA0sjcWBqx/ajvnWZOai/HtBafl/nHXPJTMr6XBEUhUAohax83/iyQtENrRGA6lzBLB9Bq10CpdfbMar8Y3Kc/QuiR9OzN/AlDo2a1HhSAfiz4QJvhTaV6elZ6VN+HhbJzvMQIEBqRVJ4FkSsgfjCcrp+V0nxrptiP8P78bElxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SJ2PR11MB8403.namprd11.prod.outlook.com (2603:10b6:a03:53c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15; Tue, 10 Dec 2024 13:13:20 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%7]) with mapi id 15.20.8207.017; Tue, 10 Dec 2024
 13:13:20 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, joe@deserted.net,
        joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH 4/4] SELinux-FAQ: drop debug-tweaks
Date: Tue, 10 Dec 2024 21:12:56 +0800
Message-Id: <20241210131256.2393366-4-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241210131256.2393366-1-yi.zhao@windriver.com>
References: <20241210131256.2393366-1-yi.zhao@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::18)
 To DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SJ2PR11MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc4fa53-11b0-4d64-9a28-08dd191c6b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gX1t9jk7JScrrSqfaZQPfUlHj0q5XgPH5Gjg3zrz2ToPXLV2yiNrY+F3ZmID?=
 =?us-ascii?Q?DQH0vaLsEuXfTcGHQQoyp5j6LPYdfGmd/T++QM+JzSL5TrlAG2rhfw9sihFf?=
 =?us-ascii?Q?Zaz9cTmaGCT0VwlxTAn3gNcjDPDJpz1Asd0KeTTQkd3SIOBJY5B5rWK4mDct?=
 =?us-ascii?Q?9oO+o4ermBlNaSxm76q0kPLRmdQedUMhoccDc9Lg+ghjNFRbCGicQfAy0Cd6?=
 =?us-ascii?Q?bTDEcVWetuEH4xZMDU6ljHc7B2b4AMZHmPZnBiZqde1t2V43L5CqqA7Nh5eJ?=
 =?us-ascii?Q?ETDdVoIkMTS8FCb+3Vfu81QyCjNWYkB4qGDrgkQZqPRaqgP7gzF1K+FF3f5k?=
 =?us-ascii?Q?rhn+dKh+2eboqYeYPegS/tn9kYygGN2zNgRbBV7ZUJliB0BA6VRzZlC/3gTA?=
 =?us-ascii?Q?C9ZS+SWXJ5XB7C/CkivVEohklfqkNzlTHHPuWae4l5d1Rlukz9EI4h3wE9n9?=
 =?us-ascii?Q?tsXxG1z5haewbGscRJWMEYL81lnYXb4DHV4zsrxy/iSmeDVl7cjV3s0PBSqK?=
 =?us-ascii?Q?WzHMTUZh+QtzHs26NOuaZ8It6UUamiPCuBnGJeDEbI+iYeCaNU/W5ZmrjMai?=
 =?us-ascii?Q?IZ4ljIEN8worLsYW2aMAoG0rt1BA0MBjxR2/K7ZpXgy3cJLWryz77cnKV6UK?=
 =?us-ascii?Q?EX61Clh0XoOre91RIpJ1pDjvDryGzNzZ8u1chRdardqwMbTMMRfmFeq56SVc?=
 =?us-ascii?Q?tgsoTnOpXvp0nVJ9yMT0K7OfcMKUydmP6/rRRXcuporjn3tQQ63arwPkIU+Q?=
 =?us-ascii?Q?babxhTIp9jXvenpBQkCHqiXbBEqqqRsssHv2cgGS4Q6PPCzyxtXeDc5XmzCI?=
 =?us-ascii?Q?+3qFwFslVBo8uzR6yCibwqx6sMK9tRUA8Z9W8K2ZvVKKLF4r8a1y1aza3/vi?=
 =?us-ascii?Q?Dvr18WR/2ZLn98CMzAtpGLpItwfa56GbLn0VTCEgpzeX5phVJkGlNb8bD795?=
 =?us-ascii?Q?PLR6HhtTZDAloWUQk2GkAmh+bJwPZy1iFn2C5aFLDJTA250iUj6ulzNAFOPe?=
 =?us-ascii?Q?PnnWw20E4vNHTrfZM1bBE+wAX1yMEwnqPAiENqqI7zzoddwGTKL2tu90d/RP?=
 =?us-ascii?Q?li46/nESYKBkP7tNPSpNSo71ixzX/CVuofDS4lGFZQ3FWki0AEuJwpwvysov?=
 =?us-ascii?Q?+BveaevY4E3LJrF64qI7hKeAVS68QxY/XSKiVdQI5FL49MEzi07lW5NfO6ba?=
 =?us-ascii?Q?b9UYxSLNtt9uMnmE3L2wYroCE2Any0ipT4xPwp+ljj7F7iRn65zvJD2xv/wX?=
 =?us-ascii?Q?xgQv2c1Q3W3k1uRfK29KIuQxTRXf6z99JbA1diKAeZ4cHd0zyvQs2MIssUQw?=
 =?us-ascii?Q?DDNsMQlrk7SHy8IUh3sJWBSyEeMvgk8/aIFsL9H2KLGNfEbc0/9xz4AaHRPO?=
 =?us-ascii?Q?IVGzW0zjFpmRs0LE1+6U4KTdw4b9GMCPXMVCDoLJh+qjfNT4ew=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?S/y8zrCHv2//ljQf55zDv3j0hC+hDy6/xTAY4VnaoFk1dYrr/jbR1mQH4Dvh?=
 =?us-ascii?Q?bfltzfKFwOOVEwm2VDinKYGRXxyRctqRjQxYAkxh8E2afQfmfHs6eYalOMLq?=
 =?us-ascii?Q?u0Ij3JSoMgH6SLnbLIJ4cryvs1I6LkV6U1tSFcFyDRuHbdaQEeeuAZ2OLBsr?=
 =?us-ascii?Q?65qx3911v6Ca1nt434DGzfDlnYkI6yjVuqe9MMa89eq6ddgdIWjYDyjZJ4Bd?=
 =?us-ascii?Q?TUUcetWQzyhFRTxv4YoOvg6bUr1Hkd4FNHcIyvfXXC8nGLcfCnjd1kpzQKzt?=
 =?us-ascii?Q?atbhpSQF82OrO7qs2pUmQ4X+hSk/rm99f5Y6Rjvg/XLkLgguiEL+f9e0pTqZ?=
 =?us-ascii?Q?jjXS6YQfvUDIsQOqazOGpTPXVNEOw+QxkiUS6K3bWK65lCa0XF7nnjRrI4eo?=
 =?us-ascii?Q?M+vRrEC8C3cNKmiTEQnIjkmzuDb+SireAJuUQEFtVvjY1Iaqqzn7IqyCA1xO?=
 =?us-ascii?Q?7p/WHf8BRRejP9whu5qwJ4xXNwmpdgBlQf1GDILqs1oe2d8C7fma/8qrHQWY?=
 =?us-ascii?Q?cHGzZXe8DfFAiGroj2Ak9DZmNT5sVQxWGRguvuPxDGkWIDWyi4/n7p9Vhj7i?=
 =?us-ascii?Q?7blJw0K2OlQXzFPtKzSzCRmEGQgUdAS4dYi4W8wtqEN/yrevUgDOBAaHHFTY?=
 =?us-ascii?Q?HEYE4HWGltVn73sVKdDn3vH+j0nUGz/T8UVXEhrKJWlTyObU1n5QhQh5y4xj?=
 =?us-ascii?Q?6ERf3WH+G6XS9F9muqjVgzLlVrveL3DPJZbo9XZkuXQ+f/ltBenQj5klfhRh?=
 =?us-ascii?Q?Q3lCa6d/lZl/UrLjvFhag7GdhH42yURantO6cREEafwocKJoYLpqx+NBl9xZ?=
 =?us-ascii?Q?+6og0/Zq3E62YrZXDdrDEQ0OvKLcZSwOgP9n+2cAAMQfeaG6VHMyE2rc945r?=
 =?us-ascii?Q?UxrvP3AyDptiPCMGDJO61iNIuPpGcpNR7tt9u5S3KhE8QfLJBRdxWv0z/Ux5?=
 =?us-ascii?Q?uyQhEGO1/co3v1uno16NA14CPqqWVzBCF/wl/rNEVpayyZcBeSTB1FqPvnuF?=
 =?us-ascii?Q?VXV+83BPjuUbI7zb4BKrvAw8FpLyWzDr90sliOVhxoz/vuMwPXrLSHQonv1W?=
 =?us-ascii?Q?VF6e5n2Njff/ERS0jV5PcdCzva+REhA+KZGMlVzYZ3yunDPFy+qUVJzcKimE?=
 =?us-ascii?Q?0wwy92pIlqLL/mRUh8GOjkO+l619T1Cv2zndESITJitVMw4zITvZxYm+5sK5?=
 =?us-ascii?Q?1tIshz8RZHui2iAuzCpQUQusiMwc6HVakBFLud7EPf+O1Xh4tGmp7jInYVRv?=
 =?us-ascii?Q?h68rJK7og5/DpvtuYBWsG+imrVoMGaT9xs+crSumeZp6mtlgQaDvljlaW55N?=
 =?us-ascii?Q?7Chv3g6f/Wclr+aB1M6/IArJ6TDEetsfPlg82ik17iisveyoz4h+XgXEbi/u?=
 =?us-ascii?Q?/R7ukgA426s4GIIjpyYvXQ+VWmAuvDsG4dLdc9+C+pqgZwFZk+xV3lxW1Nsz?=
 =?us-ascii?Q?gKwPjSvbGF/FMmz6VaD7DqrNaaI1Qc/FeZeG55distsDgAIiW++HVKctKzmg?=
 =?us-ascii?Q?0cx0hiVhdjwa3oPZXKRXkQkzPXCZXEX8e5dgBO5SnCRD8VtDBexdlIpKZvMM?=
 =?us-ascii?Q?qfMlvLyESV+QBtBkvtOuK7jH5CZCWSB8IhSMEF70?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc4fa53-11b0-4d64-9a28-08dd191c6b02
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 13:13:20.5533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLG7HMpohJJUQ4v6578KpGMXpdrL8DMC+bCcf3Rqbid8A4jCguhAEV26oN4uLOFleqyj4tU6Y0sZOpudqD9Ntw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8403
X-Proofpoint-GUID: JcOciisHlnPa8JJOw6VbA1fm-CoAOzH4
X-Proofpoint-ORIG-GUID: JcOciisHlnPa8JJOw6VbA1fm-CoAOzH4
X-Authority-Analysis: v=2.4 cv=Y/UCsgeN c=1 sm=1 tr=0 ts=67583e73 cx=c_pps a=98TgpmV4a5moxWevO5qy4g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10 a=t7CeM3EgAAAA:8
 a=_Nka1VkREi1miMkW4ZsA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_06,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2411120000 definitions=main-2412100098
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Dec 2024 13:13:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/879

The debug-tweaks IMAGE_FEATURE has been removed in oe-core. Replace it
with allow-empty-password.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 SELinux-FAQ | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/SELinux-FAQ b/SELinux-FAQ
index 2ae6649..21387a1 100644
--- a/SELinux-FAQ
+++ b/SELinux-FAQ
@@ -146,7 +146,7 @@ Please check "PermitEmptyPasswords" in /etc/ssh/sshd_config. If it is set to
 "yes", set to "no" then restart sshd. That's because pam_selinux module does 
 not allow sshd to set PermitEmptyPasswords to "yes".
 
-Note: If both IMAGE_FEATURES debug-tweaks ssh-server-openssh are enabled, this 
+Note: If both IMAGE_FEATURES allow-empty-password and ssh-server-openssh are enabled, this
 "PermitEmptyPasswords" will be set to "yes" by default for Poky images.
 
 
-- 
2.25.1


