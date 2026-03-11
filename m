Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D78FD062D
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:36:47 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14983.1773210997651246097
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:36:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=aA5/0OiZ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B5W5xp591950;
	Wed, 11 Mar 2026 06:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=eILXoJ5oAXJ2EqLklYO4M3UBYD/MRqpqAb/8zvYlrH4=; b=
	aA5/0OiZJODHsKHt9R5GEq9dqjdN/kc5/TNgljEwB7O0JyhglVHtFwNEyoCd0cDz
	sfnKtu2/APe9B1BYN9fTpx+2voSc0r5UKcprIvsLV+c72/SGCjEjyt7ZU1aiZcXC
	pIDhNVJU7AlPWQotgp6MfIRnpwdVK/kXdG8eXg4+anwpcMgAbYaVA6wlz7C3qPpM
	qJTCUM8SEpXV6LJualRq8KZlsDuwg4oJVvRZPkr///pqV4VF77tGPw1sWjG1sYAv
	P7R/imehYVuCWWvMqAemRTIyZkIXFdc1pMXrZfK7NZCmjag9a5YP+99a7aCjv1YZ
	fi/DYiqQjzQTiZGRXDg0bw==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty57871a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 06:36:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iN/4NHvX1hmRQ6AzkSRQhU+pgEe5rA/QJgZzOjf9/DuuRUkfEN4277gDHE/LVOwpRBfNBPdVF5ucntyGyuqAZImL2XokBBH10Jhhy4wfiNMFpyc7RYOptBR3MK92ffbq075fDZwiuURO30DpMU/CAwPYLTRj80255iOpoZ31kB97BVnRurpkm9WS9ch3n0OYAPpFIfW/gB9s+6oWujSuIjIVnqKMSqBEkQ/Hp5qK/W2+wZcj/NS37xyAcEVZZS70assuu7CLRV8HNkJxTy0JGk0wp0ar1NRrwCfMq3h3CikI/UmJEZfzYmvcF89tBRiubXEXiiZ8o3vL4J6/y0Rqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eILXoJ5oAXJ2EqLklYO4M3UBYD/MRqpqAb/8zvYlrH4=;
 b=tkD9N8Qu9PZcJVuYIBeWACkZwZJyWk9d+Lx+fdZs1KBnnvnsZ+vmocRtFNedJfKroYLCsAqGmd86hJsaST1/l/m/Wa8jzP29PuLI7LEAZRH/9DyWzh75Pf3L54rCIJCmwalX6Pwe/KMk1QigMmJVMozPDdGTRn9SEWcf6Dt7ue4DlCL07rQDfZLO3RcUGa40rmLDFApZgHa/FJuhqAw+M35hHa3yqo1Qgym5XHZe6HmBFyi10ioMNYPXzwTD10+jpJzuOlgMZsAh4bnO9FUwbVVz1EGkYEHmgqOaiOaKqfILFdsddx/CgmC7m1A2XkbNGJziQNoHkdgwDIPCHqwS2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB8787.namprd11.prod.outlook.com (2603:10b6:208:598::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 06:36:34 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:36:34 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH 11/11] upgrade-helper.py: add logging info about running bitbake-layers
Date: Wed, 11 Mar 2026 14:35:57 +0800
Message-Id: <20260311063557.229656-11-Qi.Chen@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 79a59941-d4ad-426d-43a1-08de7f3889b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	21BK77XXbMBUkZQt0d6DlogccsyNTNwPOXczqOsh846yXswVQQVffqGEkGdPvAuUjg2RZ77b0r7nunPbg9COk+bt5srNkdpIYr3ET92ZwlOG6Vyz0JfnRhyfwD616ZpjRmF2zBB1vJY/YvSgVnaRU2AzGu9nq+/awqLBUkVKYq/U9Cm5/Om+hLd2956SB6n7IPvwiocmxvqz7molAj19bSBsJPXZVX8dRg8LQ/JkPCwtxkFqu8A/aV9O+B7YmIY6CpVp2g6qZ2qx/+drCngwOoVVs+okPExG5VP35QP1/upeoCMTjMIQ0C6kp1odl82hhhRFxReBDWuamnAlUz06wFniPy228nHP+mg6uM1Yfbd4J4ligTyKX+eV/cVNNZ/qO1fziLoLoqOpbDqHjzSV6S3qWTaTCnQw/S1y9oNkiA1H3jY1q5iAnaF8CjUIH06UjiprrIqLueAcfEOtBQexDpYC2XtWBtUQn3VVDKYpthFdL23lF4XtBGxsNqhzrARhlzrsHXyakuFWJq+ImOsZeOs2u9XKR1YwLuZ3w+GCJPKDA7rvtu7+J0WBt92kNA6m20RtXiMJiTPZ5tJDq6jZIVASwFA1YmYG9PUez9rxA+qKF3h9invYtdQGqtk5wHYTghc1Zixg/41Qf1ylGp0fFf6z8bisdrG8DScb7L/VjP3QF/M4QlnMC92e7C/AEd0C5BCDLNW6BaYZWidhza8lEk0usZWHuBQJZEU4xHL4Wkk6bGd2v7VlI4U/TvKIWx4d1kej7Waj5WMHBzYdO1+7Ie5zQ5tDK+HeGDytDq/+Fx8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VWbULDHIdY2elmEX0S49ksiZx337i36wYtVXYgQpyNRqZ3VOMlizdQ0wrAKS?=
 =?us-ascii?Q?KffECb7nGfFiroD3KHA8voUBmencRBhGvxRB1Bw/K3p6pUBTpzNpp52l3M0L?=
 =?us-ascii?Q?JaiUEPqA1w31OYDP7gxn3pX9+ajfxRgaNp4Riib+PRE34n7aFpZmJvzJgyxF?=
 =?us-ascii?Q?GBHq3nnB0Q4Rj6FxgITH68HqOy8ehfTSK0Ay0rSBKrrolxJavWZMLxZrMgjB?=
 =?us-ascii?Q?Odlh0V0NindWjkqjH0iN72ANPghG9cpVv1rrNhl41CmK+0d5txFd6WdD5pp6?=
 =?us-ascii?Q?ZVkUE4mN+EltQyslW2Vs2c8kZS5z8QTNKn5MVqUvRajqnlycM0YZDd7i4NS+?=
 =?us-ascii?Q?cyc27S2JPSivgA6Rk2iUKdqh/nxdB7RWMXr2tpXfwhAQV3d8vapQt6uewG1j?=
 =?us-ascii?Q?dPCGCplGk/z82TrgAt20OtxsBp8yAoCwfOk+EcrhR11Yy9SYrGdQ++yw9BhE?=
 =?us-ascii?Q?jdbgtRFQRVF+tnuX5e5nOtNlViZ5kVHNv9O9vgbTvVFcIXSMngEJYYUrdFJS?=
 =?us-ascii?Q?J8fu9e5shSBNWIlwWjxCU9EmeIfUU4oiPcVROSvg5xJxfQBMBX5ioJsEl+Az?=
 =?us-ascii?Q?FKvvmrLjWwGh5wJSmAVp+Vqx5lZ4cueJITDdtTzlZ/ZHk7dw/F4x0YDkGAjS?=
 =?us-ascii?Q?zqaFqdOd/rLW2z1JX5n8YeToT55kINDxz3u+S5lcPh7IrzjmdUCA78/taj/k?=
 =?us-ascii?Q?6jYSOJhrEOqxgd9sKjoAoyfgYaqXBAMvW/508p4z5mKoW+NuQR19RCRx+LpR?=
 =?us-ascii?Q?/z0R3CSihd78qvkI2MOBdX3fApNwJDZwog6nOgkNdu2w/4c9tURsPgYDZyz4?=
 =?us-ascii?Q?H5CodultlJO5tOOAogNE7FilicYoIPcS4rK9a6Ow38Xy/MRLBJG3ap/XjmpW?=
 =?us-ascii?Q?zCMVW1x0IpnGEqhjQXeX6El4dgl4EEugviqB2ISYEIfHnEVafbn9a3WZnb2n?=
 =?us-ascii?Q?6bvx2bGf8yCEV9wSVBBULdP33p1yKB3MSWvranfmp+T1zBeXJ7K9dKAJVkht?=
 =?us-ascii?Q?cHJVPB+ggX9QT97JqHqnLR09+FwYeTyuPqgEiiAwqbmeaQmJ5+gjpTV6zN3n?=
 =?us-ascii?Q?bVCGE8mz3pY7NmgltES+vuIcIETBAYilNl9PHM2R86rXuKAA0dhiceT2bxy1?=
 =?us-ascii?Q?c8tLyBMIxPPDFZXY10BrFyQTtorJ2MQi1CJmqtVAo1WNHtm25IopFotZ5CfO?=
 =?us-ascii?Q?7TcPKOfUY/3+8q1JF737D4DMjmMG/CRpsGSefdRxZpAawvkZPP/iRS3w/XS5?=
 =?us-ascii?Q?PNYvd6SebX9tKtfphUMyYprET2OVh7ilKoayAZHaoznSx8VA3OX2vEr9nPLz?=
 =?us-ascii?Q?3mrg3YQhT9ESnXWq+2xm6d04W+83nj/VokfwCYbbTCRKNgp3UOU3UuVbtYNz?=
 =?us-ascii?Q?VDiV/yDBN8XjHqlaScFvLchaytZpJkZW4+bezcUh1y5zycpmsMJVD3PTuJAk?=
 =?us-ascii?Q?xMhRIyp/H6ozgECW1bzRwK8WSLZAR5/XKKgNNX8FAaUBqDTlEMjlf/dFBmyD?=
 =?us-ascii?Q?vYJGrDubZAc+PSp+CuWrmZElPL18qT2SDU0oMNadUz/f15XpMjJK1JKIzsAE?=
 =?us-ascii?Q?xr/+8xQm0wVz8HOY9kwbVCRbHaE0EnMWz/vWJpxS8Q7jQW1gwnTglxfdDdyg?=
 =?us-ascii?Q?cHxJQrxcPrvKceuVqDnq89kgGp9LEdtiP+gJz1qGYVOEXE8nUlfKCh+W510a?=
 =?us-ascii?Q?oPmDiab3z4vEy2tIqbisJS2guEgOD6A0rh4rYiTI4FwjnngwKkTWVDgj6aMJ?=
 =?us-ascii?Q?qzgIUZQJWg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	JzfBdK+Kvafez7eo5t+ve9Gngw2rAHG4NjPn/Eso86aey1JrN0LM2eOl6bgjOp28meEZh2erHGTMtOYJ3SXex+Z+wh3ozeB3BpRJaYgqXy+VTbVHcD7Qmnt8yiNpPBfV1CMToXjHjDvoOpQwaOXm679ThhzSkrFHils7Fxf44SR9DVRZU2xiQBs0yebeT6m8s1yz/xd08A7c89FB2aHriCGLKvmP3Qgm89ap62MmAuqM+BZUv8XuMVVTOgmXVcdUNFy1THW/couAe9PijZ4F+c5RL+do16CoUqQt1WiPvnSLJZJmD/BTUhU2ZfbAyHO7lZV3YZtHSYKnbrK1vXXplA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a59941-d4ad-426d-43a1-08de7f3889b5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:36:34.1212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2FoZ8i9O4abbORqwyVeOOA9SVAx2xORBDvWozvD/+KfOzdvnx8PapvuHKK7+6nRZ1BO9X4ymkpUtFsQTI2FHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8787
X-Proofpoint-ORIG-GUID: O2LHO-rDXCn0oA6WQT3tpIb267A9MPFO
X-Authority-Analysis: v=2.4 cv=fpnRpV4f c=1 sm=1 tr=0 ts=69b10d74 cx=c_pps
 a=8DpcgsHgAViCMqsLoRaOsQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=bmEcsPE48WtV85cMDF4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: O2LHO-rDXCn0oA6WQT3tpIb267A9MPFO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NCBTYWx0ZWRfXxzkvKvcu0WUZ
 0xcFugZkuG/KFPymgBufGowadaPEnAXb1xoOeCIOe3It/xfxgITARtD3KnWREN69M6iwlPr7hjv
 nhuytUdMaZZMg1HWxAmqPQn6fSeQJkf+GATFZ0RH8orGusGGjxqZF6tfVWUkKxbFkcoYnHmKM7B
 bjMnO+fDHcM0m49pFbkVVaCfyE6MS5zR0O5HSEC1ta7BKrP6SLYb3DyReD/MmXKc6OfZGgbbu9x
 d7OBk7ff6AKozatRJtxeZ4W8WFI5qFoFcsldPff5G0F1XQnisTG6K89Qx5dXiMkBVQT5fRW64dw
 OuvG8CqdJeMP51Gyrkj9wrKKl3GkkUJqffvgaguC7zML+m7M/PneSUUnIvwz+KsI3Hf1HMHcNe9
 fWEwljtlOV00okb4YtfgWDMKXp43WxWOkvzc8ou4A/1vfzJRSAse3OPR3miOSyv4jRWFKofFy2C
 e7lzDMZgxSOHPgMewiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110054
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:36:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3412

From: Chen Qi <Qi.Chen@windriver.com>

When layer mode is used, 'bitbake-layers show-recipes' will run.
This usually takes several minutes. If there's no output from
auh, what people see is that they invoke auh and it gives no output
for several minutes, making people wonder if things are stuck.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 upgrade-helper.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 8589f8d..7edb6da 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -619,6 +619,7 @@ class UniverseUpdater(Updater):
 
         name = ''
 
+        I("Running bitbake-layers show-recipes ... (this may take several minutes)")
         output = subprocess.check_output('bitbake-layers show-recipes',
                 shell=True)
         for line in output.decode("utf-8") .split('\n'):
-- 
2.34.1


