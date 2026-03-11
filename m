Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750C1FD0633
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:36:37 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14666.1773210990620792255
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:36:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=AQSIgRIA;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B6Dnbx662911;
	Wed, 11 Mar 2026 06:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=cxJ9oxqnior0K1cEt83LNPz4J4BVTNJFPZiyFgkp/CQ=; b=
	AQSIgRIAYZG+S2DSteAajVvV430DVlKnvt6wwEf3IerVe17CFI20CLv+eGl4QvFD
	bCnHJAwrBb521SAol8EXIMzKGxbOamnPxm6kVz82oPJoSRTPp1qS9j/NBN8HCYHx
	0lVmkqsJzEZ/wWRQFsQQeHqg/ZS6T+9J3u0Hin5EtFPXHAZ6HlzLnwXy9IfBMqY2
	tQ+YB4vINyd+kLzIONaygzXRcHy1zBKYiXljbwxouB5YWi6GAwLH8QYTNXmRs5oZ
	r0M1gMOoOKh8FPZxMprDalmGIeJtvtLDdBtrLXRB4PSPZbR0/J0DDn6Q8wSTXr4Y
	px9WKtN+d99Otv90vIz33g==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty57870n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 06:36:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuwbEC0VAHYK5+TQMHSzI+/+lE/FccNOY1JZRve2NMZjSUb3mmvFWb7hl0LAi2cLjav5+0vaxP0VYxBHLw0bDI5G32GVWRzwIzGKG3nwGbCzp8PWqpIgsKazReURtfQB3+AgnU76gtBuXO7Yk7OFnshWXpjfmIKnrartzYWrBYTzUR2aWMeJI19RE8qtOg8qVdPpxJ/Pm9VKUmAU/YAGX8vxu2uoED49uqtibjyF5rcYmOkGJnlIBgX4mAJbvr0CfLkCmwpEmzfjnxiWk0cIgWLBD9PEKgfcexeDopoPXW4zwOMXNB0qBiA1vtCFaOq2T0/3tFXPG2kVj6/vSg9qjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxJ9oxqnior0K1cEt83LNPz4J4BVTNJFPZiyFgkp/CQ=;
 b=upnFNcjoLHHEYagdBLMMlkHllamVZsYUh8yG9Q/+bKDoJRD1sJaC8cYemQwgZqG5cuX+BPB1aK8kGgDuOh+z4hHSe7AIcPLpUPqnq8tpciATENCewshgISgYqqXpkyMlnVRGlDcmyqFudBvyJfaLotta3fmx5zTk2I2w/JZ1ik1NanD8K5FD7Cs6yVZCiofLDBWod6nPUVBo7hjyYvphEFnnI2IQLBdOdk7ABwnFphwobnjoGIGDIRFQ3Zh/Ty2EIeuhgw6drYlPr8wnfzfwyH2tKmCgysWuquJbJ8btA8volnnLFOnCedzUGgV1Nxxyw0S6I9g+S1rgcvQKHs+bhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB8787.namprd11.prod.outlook.com (2603:10b6:208:598::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 06:36:27 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:36:27 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH 07/11] upgrade-helper.py: fix exception handling for commit_changes
Date: Wed, 11 Mar 2026 14:35:53 +0800
Message-Id: <20260311063557.229656-7-Qi.Chen@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: d9ab2e2f-3083-41cc-7a6a-08de7f38858e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	Ba8pfshadNh/m5WhxhTF7wj/H38M9tqFtReo0TPeH1mY3OHYHSZB2YhAGu+6XLiA/MroQNsRehE+Hsc8f0hI332cgbK3aJAYsPBoIK8To03uZ/d3cRKzyDQHXZGQbazWxPNEdDG6p7qjIOU8OvHhv2mrW68PrVaCoUdIybAACwVcsiSM5Fu2tulmbwxHkiWdiOmEXanf/ZL2RiTM0iTEGNYFPW6wrJBUHJ47JLTs1aRyFhrrRjWqm24+ajRC/N2LWhnA482ZnwsFjfR+noRUMi1KS3HmtcbzVois+FTPbgcWDrF57ddlvkpAegb+FdCewcn9t6XiLtqYu//eU8qDtLwwx8Fc9jYsVvS+Es2yaoMBkuPLw83sv6rwAaK/WJkpBxQv9R1ekO/X9vtcvQkZrBltpMeV6J5mwt6OxfeJ/AQ255mESGS+ckGVd9kbQrjhWQ1NIt+8ZeRV3ZIY4J3HMUExS/L5TVanInzi6mulEkhJ1ZRrEM5fLC3fc3HxjaHk3Fk3m+PFw+wsYHCxCO4dZMLy03ufAxLns+LHiO479/rXhCBkizj9JhgSatGwuSJHSpvfAaPSYYKNko4yaGiV5e/A1qvkQxWf6Tu+6nGyY2ixg9DgPReMNBl0iVN9zHNhOz1SjMeg8AJP9PCUU4bHCnQv3Y5Qa3pKibRi6jpcCEdBF13iRFXo5wtkfhboLP8LBefrODM+gZtkKYfTZC75FmC6rW7H2a3JAer8kBYKin1N71KDuauEzUt60KQ+VJVRdiawNBO650z/2vjvZZymE0OfedkHZFTKIHo2vBzmgVY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BBZ/RrJsoLsC+nLmzFmdS0DDhC+ZbOl6ftgQN0SIgDdTWaP4d4td9NltXh+3?=
 =?us-ascii?Q?bGPicBBisa3LbduYRpt3XnnWYAcYLX43R86hwkqWJSxApRmpa14uUYtFQl4e?=
 =?us-ascii?Q?5nFKfDtsV7gGdOnyA2lZAqd0xjWqkeYgKk946leLoYGkhreUiZSNdLMqjKMv?=
 =?us-ascii?Q?TDHAznqEUVfYmnhlRnVcKoSFwPEHOLJu2iGjT5TFZMvenPKkbf6/dv2LVy6+?=
 =?us-ascii?Q?cK9QJr+2iwjPwiKjMFQLIqB4N854jb5D0kTW+bC2qB4p5O348kb/yqoSvs9C?=
 =?us-ascii?Q?eVQSedTYKpfZKXRP7swHut5HnBuujG9UrJOCYZ3J7dX8BNziBcao6YLRY9ZF?=
 =?us-ascii?Q?FUbOACDEECQpEQVjQ+1G9LO3guXlvuM+BSm5Xx+NoFuFC6rGZ9/A5PShqoil?=
 =?us-ascii?Q?pdZco4vIkhffopxIsIc2ZYJecPUtD6Wsx7S6oRdOt6uealAhlq5RTV8KtoVJ?=
 =?us-ascii?Q?+V+PFFv+9TuXBcJCidxU2H9W07S/df66vYhABYWmwKgsl7Gr2mIecr7MizQl?=
 =?us-ascii?Q?ihTAiUwd30ovA4pG0ZpgTKMzvY1m4STKWs7M0iMmaO1ISWAuM2NJIqtty9Rz?=
 =?us-ascii?Q?aiVXvRDNecJkRexly5eXZDNGyS1QqQom+Y8vNAB+z2Uxf1UGmyoUIn1uh1qv?=
 =?us-ascii?Q?afQG1MJaB/Uh2jQXfSRofkgr6dSVVToCKDecmG8MxOnLlrkcwKARqwsPhU7v?=
 =?us-ascii?Q?b+CcQsUNxej4oKHwlD3gWQcojCpzH/zrTQ2FJ0BjJnfCy0lAg1/iwNC48x5E?=
 =?us-ascii?Q?Z3SfAJBqSMzE3NQMNyCyOUwEW7sTecxfL+3dCKmurQBU1NhlzXYReODVguSa?=
 =?us-ascii?Q?GWotm3thCcCXruyZe4K9W+zuAZy8N/bLngMrKwcmJLf+MxowRuCKFjLRZI/6?=
 =?us-ascii?Q?2GgkBRnFas/doyyDyKVH2VuN1MnPBtr3H1iXBvNSQm0Ao1E0Q3R7UUmMXjzg?=
 =?us-ascii?Q?PeV9D+DaXIAzIQgdCH0YYb5eQyXsvF+ix1vwD1nmuYNQKO0UMQqCuzGMLKLA?=
 =?us-ascii?Q?qGfASu8OzyQbXinHSPMMiutONs/G6jNd+cNZDrfCPZ82hrld3VxPVKT29duW?=
 =?us-ascii?Q?HkifqwbdaRSlDvKKbPpDdEYyolRUL02nkNekO4nntI3ABJOhxC2AhTEYQo6m?=
 =?us-ascii?Q?VeJqiDt2w7KWMeiyv/nVeilCrO1XcmMWy+ElN1Ux8tKFzFPsVhlSxNpt5e5N?=
 =?us-ascii?Q?qLwGtpgjOyIbM2VmI3oJUMtGmSCVMP47yJkiRga0k4sboemNVuu4tY4MtZzb?=
 =?us-ascii?Q?ahd+IItBfDI7T+FYypXEiWDzvGBqIkRn8tWnSlWmrPnsBA8zjAllviuVuDMu?=
 =?us-ascii?Q?7CJIVACkFDgGASY5JbtauDulbm6SGd8n//k03nbjxgZewkFKwD+n4Qy4ipQZ?=
 =?us-ascii?Q?BT970OTRz4CghF0zbSnU5LIhTRdjansMDssvePzkCbfdvAE0tDya3wJ6E4tX?=
 =?us-ascii?Q?1un6SfRLYUzWUgPiQX5+eDaEwBdccVthvMcDKH/glfczFcsrc9AHyysgdzj4?=
 =?us-ascii?Q?L5e61WlhmH/q601mk+Hzd/pzxOOYKaXxowjcRh8xy6Tb9M95lwp7k+U1+kvK?=
 =?us-ascii?Q?Ox5VTwbIlTZ0rUggHqB4SBpI2UA3Q5Gk9aNwKo0N3Rc7nCxJiqdlcJGQFu1B?=
 =?us-ascii?Q?2up5bM2bzEe4ARSIh+ZPf09jJM967ZiO+ofBYMiZI3bFFeP8mWat23Ew6zyw?=
 =?us-ascii?Q?zs+RTPEtF0n5U2hp4x+18ptx6QpybjLmoQC8GapdFYk6Abm/LIe78HxE+iLj?=
 =?us-ascii?Q?16yqFFFCwg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	QyL6C4t8vPkkIyB8yD/D5fodyyf12iG3zSCySrUjir4dCOnLpAWFPJ5gTYJY9kd/2n2ZoZ1yTzVBFmbXbyTifg/MUtk28kgORaz64O07bQ0gI51WTn4PN4hQ4uZb612mOoXutJyNxeNCq4+fjMHXKQOPuCBVz1wza1EBaj23LGO0klWJuQkZyYfKkXoGYGMhSU4Aqr+P3ic5hY8l/qX80FwJvlRUL3d3NoVFOpWGl7Etby3+SrdhGJgH5iGBqwmjnC1e1GGQ7NlC4QIYZkIeq6q8l/4xDDkav5eXhaRkEI3gXzgoBSbXlsGNtd0l+dKcXOW52wdM9cf5Ff0yiNQVKQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ab2e2f-3083-41cc-7a6a-08de7f38858e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:36:27.0502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sn/oCDWXUBoNS37+fxBPecWmjH8SycVUYkyUl9JOkgio9n6EsXrjnKufJyDd3gkLcD1NGxhrAlyQRvqFFzRxeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8787
X-Proofpoint-ORIG-GUID: o49kVhS49EIQqPMf2rlbp-4449xSxGAh
X-Authority-Analysis: v=2.4 cv=fpnRpV4f c=1 sm=1 tr=0 ts=69b10d6d cx=c_pps
 a=J0oTDZHsw5jmD/+vARdUUA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=XtcnuV78pZwgIC8ia4QA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: o49kVhS49EIQqPMf2rlbp-4449xSxGAh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NCBTYWx0ZWRfX54PK43kqq2Yv
 BmKynLOP0FmLoF0CaPMrcCwv3XNMvqCrfZJyomAmd0hztnP7jjjqmjTmxo5GBd9eIBKFZen8jly
 EUflxAEiPzrFr75XZ758sQPXT0Nw0chnaIk5KYukOp/uKPSAIY7Tx/DLiDFLOHYF1KklzcCHO9m
 e3YEMN9KVN47kfATrn3xqOPLFXUZQBG5L4ldnGuSPJkBPKb7JqTNgC6za2tYMM5LI8GuXGkTq8g
 y7o5MeAS3R21Q7VtskvmXH+sienKpkmUa92E61vwtLsz0clku00r1H+3vdBX4oNdikBONP7J4qs
 6dcPbDkWW2pr1hnqlPs4RkI3KbFBk8eeWhFM/enJjvWBdIS6nia3bBar4SES4wOYi/H0zJwrV+W
 kaykcWpWhQ/eSR7kXzrla09tPvpD61ZosV6tB+eOdPWeZDd2smMaZvDDMybL1EqxoiQ3arMgJ/I
 rp0H6jqfKJcT4c4DMIg==
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
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:36:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3408

From: Chen Qi <Qi.Chen@windriver.com>

The previous exception handling is basically self-contradictory.
It has g['error'] = e below, so it thinks e is of type Error.
But it does not make use of Error's message, stdout and stderr.
And the e could well not be of type Error.

Fix the logic by checking the type of e and handles it differently.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 upgrade-helper.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 27e1f48..428d66f 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -523,8 +523,11 @@ class Updater(object):
             try:
                 self.commit_changes(g)
             except Exception as e:
-                import traceback
-                E(" Couldn't commit changes to %s:\n%s" % (pkggroup_name, traceback.format_exc()))
+                if not isinstance(e, Error):
+                    import traceback
+                    msg = "Failed(unknown error)\n" + traceback.format_exc()
+                    e = Error(message=msg)
+                E(" Couldn't commit changes to %s:\nmessage: %s\nstdout: %s\nstderr: %s" % (pkggroup_name, e.message, e.stdout, e.stderr))
                 # Ensure commit failures are recorded as group errors
                 g['error'] = e
                 if g in succeeded_pkggroups_ctx:
-- 
2.34.1


