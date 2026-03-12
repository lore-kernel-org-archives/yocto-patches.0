Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0760FED2CD
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 03:52:54 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13956.1773287565121575874
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Mar 2026 20:52:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=q0mHYWj5;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75310a015d=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C3pA0k2877391;
	Thu, 12 Mar 2026 03:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=DcfiLOptd3kEz6V9Uww4jczT1eLIOrvxiygD0kkxfDk=; b=
	q0mHYWj5qiYMFXDDelf064cFUXpztClRVLqKWrS921/jbvUOiWDFdoC/NwaLBLoy
	s6ZTzQ/cc2w7d/KQ49ce/9kk8hQSRE8P9GinkGpgdN9HM7+sCgjtgYWPVM2j4iAn
	qZFiWH0Ut6IZfPnw0XCkRAO0kFMeQHfaUNiL4Wwkk/kejTMtXWoZPtOQEjui/hm1
	VVfUrkbL6zshXpcsWM5OM7nLxxMrwZodXglIyHxbaqKWx9gIqBL728iWVT+Abavy
	wSxhVucb3R5QgmBPrlAnylEmb645Qo0MOdgEE9ZPK7Zr6FD4+MQOzWlRkpveUA8i
	zYacHn8q1m2b8d8XvAM15A==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh78g75x-4
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 03:52:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJLshBWrIEbq0fKJ+nSInm2f8vyVspphWCviKQMwkYGspqnEuNePB9e6P3uVH6jFzLL7R0VaXEAsHURS1/VHHng2TfaXG3t8gtTmUKMDwO/zxPsvjplG/pALN1QiOy4yw8rarbT+1ybvdJKwbLBnG788jOE3H/uAvI6V31NJM0RZiHZzmG7Vrq7kej5qAGfJgk7YnahbKYrnSfDZpo8hg8Wh461MhZxaf1l0bE5NVkalWJ+keD+m+k5RpPpHED8SDC0eQKCzZ0Q2bhJ+MDqUMt2+5QkGWvpjzZ20FjjT1LIFJ9OKs4v7Ts9Nqm0odrFCUInBg2RQMExuOTzuKIqAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcfiLOptd3kEz6V9Uww4jczT1eLIOrvxiygD0kkxfDk=;
 b=gLNuebfZHvluswWljMTPiBh2jBBX3WRE9OUPheOLRYZJAPuoHgONckhNZVhQZoFsr8KxRlGa+5/g0D8ZYrpE0Ly8Wxjn2d7E52eK+tu7jDpVa8+chLqe0zFqwe3w4RGbiN8S04NMF1jzhl7JFa7ALbm4AfPf7VSHSi3AIpCpAf1mP0Ucc6Rf8aC4H2aw9ci+K/LhHaeGCyFuh/k61S3UZwXpfkHQAAq+4DweXw3GvdqEvgCTFVGDFcxidu3eMqq/XU8SZbt2JK3nbTrPBIfaSbFHpz8M84XdjQI/TYRFtRZitVzBvC3b7f8U9L2UA7pctVbvBHRwkCmQD2pjo58F2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB7942.namprd11.prod.outlook.com (2603:10b6:208:3fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 03:52:36 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Thu, 12 Mar 2026
 03:52:35 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH V3 05/11] modules/utils/git.py: cleanup the __init__ function
Date: Thu, 12 Mar 2026 11:52:05 +0800
Message-Id: <20260312035211.745546-5-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312035211.745546-1-Qi.Chen@windriver.com>
References: <20260312035211.745546-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0021.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::8) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|IA1PR11MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: b68f57c1-de3c-48b6-328f-08de7feacc20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	QDAsr9KrMtYYiRjbpKzOwOBHm4cz3CuW4q30m1sclOeLN6Av3LUiFskW8q6RkHgskev6PiLIRoxS/e1cr9stqMBscjCq6FC22i/ze/wbHcsrttiJpkfgP7vkIMWM6MUfodLFNdMZu49fei1PB3hJ2a4opd+gKqMRlyo2GIFxIuW5zCjTFw+OzX7JJF6Ex+g5QRjY2G67AMk5vbVmlcV9LxnxUaVFr5GkjKMm/4re3mnwAVQrzakgiiITYeutHHNmPWACouB4NZ72NhHQRaosyJPDzSrsN7CwfjMVtTrBIIWA7Kse+o7n8eO/tlJcgv2VNe6UZemvmr5jEml1wCVBNEanzVHW6MtKFOc7IpldW5i9lPwbc8Ah8IcXKgIY30pz+50qL7MR+Fn/s34bk2nKio3ltYFbcjgGfZCgyCThoa+8PjUzhZCzq++H4a+VeN6Kc0KRn3xBkBI0ovSeq4yvLPVgWHvXAVpHaOV7GhJaSPvSuqgszEk4jqLZ4DIu4VVoHxZBEavfOA7EgaMfbZVL4sU9BN9SQFnP8jruwKTykBq12i0j/XO7fRL5T+7OzgaNGFs6HLgXGT7rI/+QIUzwniErhVjKQJkQLFczSg4Z8QZI0d7IRHaInIMHS0T4Wq9XNrEfM2ndMODeDWhNnTLrhWF1F+MmhjsCIaRKFC9QFlvDg0OnYIjFPjIqdEgAdQAeFhB7KOGHTxCVGxaGzjs2H2TrSKagpZm1v+EFye333b1Gd08imslCueiMZWcG6WQRd2iDE52DsslPtjLPAC6sbJ7I8qWy7OBCEeuGtersgj0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?buiPiQahEZYk8AxL7PcOlGOnfqTu4x1b4dziARlIeK5SDz1Gd+dzYc5I+Z4w?=
 =?us-ascii?Q?vEmgEBxmMyM7aLq0hBPMDZ7uGi2BV08yjttF3il3IKmcfm8Cok53p3yDGCy+?=
 =?us-ascii?Q?ngxBhuVl5K3HTm/LpI/JocbAQHipEEj1Z2jQU3377sxT5QajyDpgYKXoejG6?=
 =?us-ascii?Q?rGhQU3DJ8i65KIZyCLO7CQ/iARJIlM0lmHGAmG7dO2+Z4uPvUGSpzOav7e7i?=
 =?us-ascii?Q?EqSIbqdxgEs9pv+I34hi3YQKfc1/ACPKQRg+I8ktQF5IZ4hnKcgEpWK6QaNj?=
 =?us-ascii?Q?soVLlxZvofu6wFU1VDKsnOwqDuWVhEQm/KJcPNTYj+O1lQgoUHU08yE3U83B?=
 =?us-ascii?Q?RmHtm9vEMN0Vxf2Fco7GsnJSDzUjvvCnBkqvfajydcO+feEdzA1QuP6flgnZ?=
 =?us-ascii?Q?jDQa8wgzgdU+V6EQmD90QXIadFcgB0CENfIrjOeRXlS0SiEAsfMfc5vRqOrZ?=
 =?us-ascii?Q?pazunvlosvHoQOlSyZl8/PeA8trf/NA3/+/kNittx5v80T7s8nF6LlLYLCjx?=
 =?us-ascii?Q?XePhTDrSFNuJ5kcdVx3dDArrZz64Hg6RU6nzrAA/GJtTs4IQyIJ/Xhy0SuYS?=
 =?us-ascii?Q?nYSQGwNi8iFVtI8oypn8yLjZcGoytSFaE2NDe9vR2cHp6IacrVllqABt6FZ/?=
 =?us-ascii?Q?sZUi/xmbfKaz6EoIi00G9MGy3DO+GZ9MPo253Tlqy8/mskaeCxFf09plkYjs?=
 =?us-ascii?Q?B5f3NFhmsfrEupWtj0tKR8dyDxtikpprFQcit4RTLiRSAQoV+G/ji0pZpgNB?=
 =?us-ascii?Q?0ddUEkEPLOZBAn9TwY9gsniiJ4CxEGSKApgMsGtgyBSkazlvXUW7m9QgWXa/?=
 =?us-ascii?Q?tqbElERu75MTkVm7fAUFHh5mTJe8srBgHAe4D/sh7STn1h9vGR86QdOO/Urk?=
 =?us-ascii?Q?Ly5A+axD/+7BUU8+Y3vunyS8iPZ0k7BHVpCcAQ5EPaKlsKAdVxeTf3N6B8/T?=
 =?us-ascii?Q?ldUZtW5LKiQ65gO7rd13ig9LBdcQl6n+EyuOwwhCZpV4nrTkAHkMtHEvrCTD?=
 =?us-ascii?Q?ktGvqzVzxaqYwR9JkGsx/78mMNi/6mDqJSLre84z2kwAcQ/X6Z/pYnrUveXx?=
 =?us-ascii?Q?cY4NZ8a0N8U8Kk3BmFHhxWgA5dHYmWvTVQeRfAmQaAI4OMBVm4CoUN8gEN3R?=
 =?us-ascii?Q?NLAXsQviDIPqkqoFDXFEXryiALmEJ6XnBlfw8hQzNllMuy7aNS74vPUCtKK+?=
 =?us-ascii?Q?d7LIK11dN3i7LzXaDiBVyu4EEgLPJmiD4BQQRr8DoSeQBurxFvSs+KfdKQIV?=
 =?us-ascii?Q?yoCpLEHBiTr/cQVvLg+dBYyXoAAZNoDADsupU15DTylwHazLLnzykdYpYdNz?=
 =?us-ascii?Q?8pxmKpvyE0gxvieR9FOHLtkw49Qb3IMgaFzrwPNafgVEuAeC1cOSlwwfZT0M?=
 =?us-ascii?Q?agUMTcwkDyjbAtABGvUZlZ+3VL23bFH789VxtEvzHnolQL4plEPCuercxkku?=
 =?us-ascii?Q?I4PdI4BIPux599PwKTyPEYbKXe0yqTMs8uYmsZ4QnBVZiKaBMG6Z1nClfE45?=
 =?us-ascii?Q?U+HaUKwicJFMTrdp9beeRsPrbhx6FeZ6zXmL4d88p3+pukbEyej5QsOoingn?=
 =?us-ascii?Q?GTvX/PMBqsHLotxK6VYlcsRPqzdpFIQFRMpGK5rSjk9W2CsI80WqmkSiDxsV?=
 =?us-ascii?Q?kpP7lSkvjipktTuxiTaHizJ3oK7SnaV0RSLMRCnym5VCgEEyiVVYl8cAc4p0?=
 =?us-ascii?Q?8D07U1Ilf4MDkHC8iF+3xmbYKLgptWthxdJPEMT7l64j3A5aNZN6/bxcxCs8?=
 =?us-ascii?Q?Fm7OZ/n7aw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	i5p76O6pYAnpSi8y1gpCZw0i1hgZO75IsYOioZV/pXWRPiLEj6JgA1kqliXkPBhdKQnrJEkfU5NyhOJI0i5ohq1qcgefiT3f2NWaAWZHyhP8StQiHbFXwisgWmNSkGmnQXM3invIHWJIsfRfdCvjl0r58KFLREYE5rmoRbe3Izp6kqbZWrCnghU4kKcAVCuIuO7bw422j/Bu25egvIApM3SM3pb9mFHigTEQiseJ9UlIqvAZpK1bKcNDaRTETZKkN2CnWMksOvDr3grKy0EJVOHedYLbsZ/LcRFS06psfcxOHmfua4AYYcZExEMr6Er223N+aGNQn0tQ2czv9oSjpQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68f57c1-de3c-48b6-328f-08de7feacc20
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 03:52:35.9289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWMO+NU/qv1BfbBiGwYsUkFayrZ26EPkc/Y+Q5ArWF1QgtOrTRRS43GAdOdT+LCnNcRyxJMESmunibzqbr/oZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7942
X-Authority-Analysis: v=2.4 cv=ALvEU0hV c=1 sm=1 tr=0 ts=69b2388b cx=c_pps
 a=c7CpAOS9Jb82g9OYW51qCA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=llld9UTGmMUyhnCEcBEA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDAyNyBTYWx0ZWRfX50qbH/MapoV0
 uXZMD97qEcVrp657BAvq7WBnTFNSbu4Ab6EaO2EZYhofHyiDcEsSthBrBrGuFQDIgL3FJu18BW4
 S9x5NSPf3FZa2gQRlM0hB/8oNKhqQntRiuq1TrYsMv72eGs2gxsb/jDY477HFyXQUXwKThTEvuv
 l1Ffua86cRRTRdwCpq95xAdO+tRDqVL0InmUXqAJPprFcSveKA/2WFriAhrCIqYdnvyImHdGK6G
 QjNBsHqea9fDOvk3pct1GioYUrA01TI9qHGh0QCEOFswQMBxFySDBHzqoztLnGAyqsR2tft0qvU
 BJDkr0tGOMQK4VUQRf3vHI7pQag4JzGHX0YZxraew0HRDDaAwBIZ/ErOLSL1I/hs80EnB0kahco
 vCkhr+CF7MsBOaloPgAu/jcfHymKYgV0NE6X6EBqlmXxFJ/dOiOMQmiHj9AKZ3eKs/bcBRgat+i
 5Oe/lF4MnPOS/FDIx3g==
X-Proofpoint-ORIG-GUID: _J7E68OnSN6tlTKMl0Ofuc_ooclnaz1y
X-Proofpoint-GUID: _J7E68OnSN6tlTKMl0Ofuc_ooclnaz1y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120027
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Mar 2026 03:52:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3440

From: Chen Qi <Qi.Chen@windriver.com>

The "dir" is not a good parameter name as "dir" is a built-in function
of python. Use repodir instead.

Besides, the super() call is not needed as Git inherits object
directly.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 modules/utils/git.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/modules/utils/git.py b/modules/utils/git.py
index 9a71a3c..b383049 100644
--- a/modules/utils/git.py
+++ b/modules/utils/git.py
@@ -29,9 +29,8 @@ from utils.bitbake import bb
 from errors import Error
 
 class Git(object):
-    def __init__(self, dir):
-        self.repo_dir = dir
-        super(Git, self).__init__()
+    def __init__(self, repodir):
+        self.repo_dir = repodir
 
     def _cmd(self, operation):
         os.chdir(self.repo_dir)
-- 
2.34.1


