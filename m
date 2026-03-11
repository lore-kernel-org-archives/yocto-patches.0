Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E223FD0627
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:36:27 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14977.1773210980839023048
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:36:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=kOH8Bhc4;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B3lOY42674556;
	Wed, 11 Mar 2026 06:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=W7PzvfpKV
	JTg13vUI/SvpUnyNoNw/BDIxVNKRNdIMU0=; b=kOH8Bhc49uqINnaA3vafy7Haj
	X3FylpoKu3dUuEjfZwuoGBwUqHZelBkLjSVc+sM55XNP5VPIdmNHHeERuCrD0tKw
	F3hiSGFM882g6TggSSQqTG0gQSIKfsPZF9/SRBgIZtWRS+JrSIynwNBhNXdTAUrQ
	LxtRbBMxIVbsb5ldEqdVHB2xjqgJ94hsNVYqo9iP3J5sunre/hiRAPU6X66rAY9k
	74+CF28CGieSTkGfAikD3MXCM9UGStOJK0ubqWzlDZ7hg9F+ZuLHexs1DmxKllrm
	2RequuQs8HWvXaj0B0+I2AzbnFhgfQmkamEhGu1+EFBwYCtCDmogEEiFs/GbA==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty22r76h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 06:36:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTydYSvrn/vaCQWaB2JAd+4rpvFtAMLc6whjfIrOxsjbbSZdsTnjl5vU+yE45ZNV4BFGwhFxbGd6UP1LyG77nOzdABHFO9LbWv9KmCUboUrNF9FEFkGV+Ge9XJUnKOzpZfkpzsOFz/rhoqbd32fESYbO7I87SsW91yrccOI8QwU76KwPXbhjkgXXLhkrfKVcKlw2hyuWXURdms+qMOOrGo2Le6MosRyBNMuBmge9Dnh5G9Jbv/mIfl/GbPGwIsXg+30FtAJIiv7Sm3F73uooSG3UiQZCh1un8Xh3+ae0iQqNQois+EL6xHFkVVEhhzv9eI434vBGMAeW6Tsr7RewBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7PzvfpKVJTg13vUI/SvpUnyNoNw/BDIxVNKRNdIMU0=;
 b=wIK/jJ8RV1LvnXeqlIv/Y7Qnkb0df0n7/VU3QFnOYUfMSjF4tJji4cpl7jPISncxX6G0QLF4NwttYw+Ptp+/wCQ/1YBc/neGIYFWxcY0vAdIY9yXtJyCYoSiEs1JpXEb7YRkK2UZhkkY52A9NSQUWkCn1UeDF4G51hg9K+Lp0ouwmdbSxJmrxR3E9H/pIlXZmh1WlfXl4s8pYF1xWsaGlxs4+o/q+0AlSVPjkQ/7CuIfNXVBkkmqZyf9m1LupQ0xd5Ecks5hT67efFqufHjx/ubn76j/X6FemXx32arFiMYY2cwew9Xk9EWRcNQk76usNZvqnUEWS6xGfwz0HAsr+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB8787.namprd11.prod.outlook.com (2603:10b6:208:598::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 06:36:16 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:36:15 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH 01/11] upgrade-helper.py: remove unused self.poky_git settings
Date: Wed, 11 Mar 2026 14:35:47 +0800
Message-Id: <20260311063557.229656-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|IA1PR11MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c79a6b-e84d-4446-eeee-08de7f387ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	uRHioM58NA5ALBRXDoNjcD2g5y+W/FIi49Si+cO1KSvnX+HgjlqAchYeHS46hJwT6g/4+JUX31Ryhku5mRZQkhj9S4pdcaqhZjws/I9LLUhEIlRHUBbQjE+O/x63imIpSbR4/KNlAqx2eWswpxhQUk7GRslnGgmB7eXYjmemRYdgehx4/KetzqcP6OFWxgddUqtRoUVgjxlntf/JS3bObLBBbuPGVJBXyBAP1pW7DqTiJx2HmWj9V/s5cy2DUjob+p+FehEl9kH6gh4OLsVtP4tT3kZoHSS4WfiLcLQJJUFvxu2Skdt44feklggyTVakOLJdq/DT2/2V3J75kH98yJIy9haBJaXnsvU1yxErIm7Beu+A3Y/xL82a3XyajFY2wuojkUlYOsC9mctQnsjXRP4tz9eCiHq2VBDaIHByj9CXcfNqOKZwuG390UjipG79v4GoUrUHRUGPXeAJ9BB2CBgRhAzl8LnY/FqSec8TQr2fZpJpPCi4DE4HRr0LHjVUHrwo4LSCkXTj8dnf8gThsAU/dmbnp1/KafYJH8auOtUDokiSpr3OfoYPErBZFijAd/0hEnkj7Dk5jUXgu8hXwgGK3PAPzi3Bxn30RQX5XRN3nsUyuw7EN9d32DhzLWUkiJMvGoXZukmYqeaZxW7p+ouGyrOmQA4q4n5JTGeEWsAuSuBgjCUj88kZSObip9g9mww0MG/EiXQ1OkyOXwMadSHBqbq6VM7DFK6COZJ4qoyQBGCyq+chkPR8cKk1sOnlMeUOreNMCE6e0UBYJwAKQxTl2BNKSCpZzNzErgwYae8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?x66pHTwPQLt2tw3RHoAs22a5G+ao2LnES7ahkvSrIFD5ZuWIlOMKuY2U/IGz?=
 =?us-ascii?Q?wXELu2NPvPFIuRfmTWuL8LMYaMSF6mRTfj9qkRohEmXvr/6M68b4jWsEsy+c?=
 =?us-ascii?Q?DGiMRe8praXw+S4ewjCZuJbXye1aZk6+I5x/g/qK/FW/YaSpY6eMkzDO7BMG?=
 =?us-ascii?Q?VuV96Vg1phOkTU+86F/uHuAnN1d+172jIen6eNlVwIbVavlwMUETi1TECpDo?=
 =?us-ascii?Q?/vqwwg6YoVaCUO5MHZmlg5vD5zZ0yKsMsEuAcyV7u5Tjz3DMNJCh/3Qk/Lpy?=
 =?us-ascii?Q?x/sPJZ+Ob0V4dBL9IgwsohbdI7plJWSJFpP7E+VecC9zNjfECpa4LorAdQTJ?=
 =?us-ascii?Q?CNkF9grYeiqkD7/nubpg2gDR7RYSYN50awE+1MseIAZzth5RwKAjCuwRlsLb?=
 =?us-ascii?Q?zxJ/EsAsI1mymOUbarzDpGutom9mKjKt54MfPFrnkuWg1baFJ8eieRQEbS+b?=
 =?us-ascii?Q?0zzcl/wa8gm5GeyHJnCKyHhr/BkHmPZhx8ozywiJk1E+fV8qgWuhaiV8pYVQ?=
 =?us-ascii?Q?vOTnbwZeT4Mu63Q82sqDmu2ZiZPHO+Q+B7e3qyJNO7M+VhQLSE++Y3hUQ2dc?=
 =?us-ascii?Q?D3cFGQXbDSoZsSUmvAnHQldSSKeq6bEQSUb85qnJu5k0+P7CQtzqyB09SAC0?=
 =?us-ascii?Q?xfGURYZReRsJ7++dOH9x4eCmf3NWGlyLxpHEW5xkmNoKfv9YEtmRWoZyhW75?=
 =?us-ascii?Q?JTK4BXaKCCzkfiY2SegS0b4V7rgWwqJQGeHicr6oXOoUDqgJQK8Q/G5u9FCF?=
 =?us-ascii?Q?do+y4W2FFqhF26MUKDzOi2oC29mBVySqqQ1knbDGWaqEdaocWgp+AdOV9ybB?=
 =?us-ascii?Q?hEL6kG0LzoCbPs7UmnPqe1q19i1HcBle+6J6NGraG+Q4+nJjKl1PIh0epFH0?=
 =?us-ascii?Q?zbYpHMyMlsmiolSHCzLCFO4PI73IYqCtd9XIO75qrLzv8o9ACnBBhpoOkdN3?=
 =?us-ascii?Q?Bzevp1USjygwWUZjQeIL+gPuLbH+KH8zAJE45hlJ7ZFHDf7cp9hTFm6Bb/yk?=
 =?us-ascii?Q?xo6B8uChkKOsxEms/E/cCNH8obcDwfUspP3PWpWJex/dIHn55HPks1OCyv57?=
 =?us-ascii?Q?9KBaC2bZDRrJRKo0qdtcCtAYVfOTwsRJZM4p4V1Dj+35cxxCXldvCMwE2aRh?=
 =?us-ascii?Q?pJS+Ddo5yvJ42gDE2z9HDDzQpcVq80A5sZv18aT95mbTxpQsfW3CH6pZ2CJE?=
 =?us-ascii?Q?ymYqRXikO2WihoNWugZOXPWvJSCnO5Y+xk1gCqBD/WH+3XeW/HxVKHHnG0fw?=
 =?us-ascii?Q?eYn/o2FKK5d0BYxulfrGys+oQ4OZovH0GDT1J2Ol4+38/zfYh0YDvQ8Y8wo1?=
 =?us-ascii?Q?XJTEYWHJn2BNv74VaLPYiIGxG0x092egw5s79vZrQtIQWH5Fz9OeTpW+4Y60?=
 =?us-ascii?Q?LrlppQ/q2JTeSJmUNx1V91OFOVpTpgSUo24t7G+0wvGIbpmhXyX5FuuPAgO+?=
 =?us-ascii?Q?Iwh4Ue0hhKSKrfJ2+NwN8HxDSo0nzLbIaVBLzHK6Drz4uOFbjrUolycUMUE2?=
 =?us-ascii?Q?CailUTI8jynbfBsMpEzOh6OxTkb56geebaPoTM7IxDgg/ohJRbRGDq1AT1Ac?=
 =?us-ascii?Q?w7TxWzcfKVTXWc9SP98P3LjKlC7qZGjfhYknIGjjxufhpSsmb8j9xVMqgan4?=
 =?us-ascii?Q?lzlcv3zzXvmu0wkh0IGoyW/Xim1NjH5/N6RtSCNyBF0FBy0uH5HqvErxWyoD?=
 =?us-ascii?Q?/peyQBMEZzOrFbTYnFdXEWkNVis4qnmReUTo3rdrCmDr09nb1cGDCp9EbVLK?=
 =?us-ascii?Q?+/IWoIykvg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	cgZwBwDUJP4sxLAeDzEconfWx9E2zwfKbV02kkpm1qG/smT3VbGouji72yi6ne/7+vRsIRDUub8qPL7XsSXehgdodtMA/94mvunB7c3OlFtUsZsJSG+mjkKIJOaeyNd8A5NvySIxVVtVWtyXO7jYizG9rEPhGjePzT8azEJCBloAOOtcQBb8lnOPIeovDxu7RX1tWD3xTN6jqv/OsBPw6z9QeD4U8TjBppPQgkYDfHtkUhZAbA+T+2KAATjth7gzvvxzIbH7d/PBeYX216giq48meAVUo0d3CsPB+vMng2GfGCiIRKfeNThwLYvkjbToHzBat85Rh+FMyXc8RI0Kyg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c79a6b-e84d-4446-eeee-08de7f387ec9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:36:15.8529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/ex2Eeln0K+SzfulKeefLfeeTVcRGVFiw2apK9Dl+kqyzeBHG4gVMI/Z8vQdpY2GECg4ECuR3UuLcWNyL29AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8787
X-Authority-Analysis: v=2.4 cv=LqOfC3dc c=1 sm=1 tr=0 ts=69b10d63 cx=c_pps
 a=J5CYyyHZZtesdUd/yj239g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=yuVxGOc7aRE3UmWQ7QUA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: NtaZMs0QRISAMpCmiUzSzsnb3NGvdt2K
X-Proofpoint-GUID: NtaZMs0QRISAMpCmiUzSzsnb3NGvdt2K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NCBTYWx0ZWRfX577iJDyJYv3J
 RIRreCQX7lvPsGhpBth3SZGJxH2QtklHZKKx8v7r3mQHCdcWzpXHhMXaV4y82ISEO8c/tWN0fcm
 JgJ0i9vZUtcafKtC5jjK6J9S+f3eUmPkTMXLZ5Wrsbd9aAKImEsOMhySVGsjQG6hBOdHULjuxOC
 a3tDNnL6H7ukj02ZGbqecccO2oLCw6vjvkchD04f3jlcsORf8ALCRZ9oYYT7Sv7iTFTiXGD63wc
 mj30ei1OeomFE0Gzi/wP+AAOKquG5066M5x0sfo5/aKSOrz1wabNbUAl2/ee4R8oA1kA73k1WDq
 vaJWuynpCJFf+i+H76KcawcXIiOKYgDU6kLRGWmHpOGpsSMnfgYLi7tq4OtPVr/fhaTqwR4H5BB
 arSiQ4gOTSW5SnwyL5W7grT8AL8hxrUye8fJ6U8IFKIOyPtolTscKkLDxxlbFEn1guJYD5RHRi8
 w7wXXHkBnIYs36SmL0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110054
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:36:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3402

From: Chen Qi <Qi.Chen@windriver.com>

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 upgrade-helper.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 2f38e0a..3b98f7c 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -184,11 +184,9 @@ class Updater(object):
                     _layer_settings_error(s)
 
             self.git = Git(self.opts['layer_dir'])
-            self.poky_git = Git(os.path.dirname(os.getenv('PATH', False).split(':')[0]))
         else:
             # XXX: assume that the poky directory is the first entry in the PATH
             self.git = Git(os.path.dirname(os.getenv('PATH', False).split(':')[0]))
-            self.poky_git = None
         self.opts['machines'] = settings.get('machines', 'qemux86-64 qemuarm_musl').split()
 
         self.opts['send_email'] = self.args.send_emails
-- 
2.34.1


