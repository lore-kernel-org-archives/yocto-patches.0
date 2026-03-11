Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B90FD0637
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:48:48 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14799.1773211727054706480
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:48:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=KkwL9ktX;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B5kVO5616543;
	Wed, 11 Mar 2026 06:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=eILXoJ5oAXJ2EqLklYO4M3UBYD/MRqpqAb/8zvYlrH4=; b=
	KkwL9ktX6uIJsUxNOYCa/xqTXa6rBjxGkrVSmX5VDY3Tw97Q3DJjeps4z1zruLUi
	9plt4qEpGw4HGJmberGBI1fekW+ZfTIGh8hn/LZqGi7NtbBt1pkdmJEujiZVldrD
	YhpdBSfnWRoWDvurzeHwNdi2/wMh3tca9mCy2qBVLPV6tkQU7Ec6zHyNfgedrZLR
	zDqnnl7Y+mx7MnEFOlo0/kGO9vcvD29ULRfXiexl7OEFyANQJyd8tM5M632ChokW
	sxV8oPxEarXRuCLXYQ0cLYQdTCO5J41NFGWbRmW9iO8bwSn9EzD2TgUztdshaa7d
	rY5qmttF8Yuc8pL1a5WQDg==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013062.outbound.protection.outlook.com [40.107.201.62])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty5787bu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 06:48:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIIkDAoRUSfXpOYpBfJAmjZ87oUgQF6PtYSqaGnZHVBec6JNo4vSp8XlG3CDnY5RMPY6o4ECw4NW7Ar86IbM4xQJ+Jm8eEZcqZrzGvD0WajBQBlJ3PGdfOCXbnaBFo5YpCgEjDxqvl8JtdTtR1CN1UOcnIQCMGCgRMrzHEwwk/IhQEsTb2GYggM/iC1LUEO03r2x0Wt2yfgcXy/fejcTU2qnyQCerSf1Su4JiALkssr3Sm+VLVCGEudtRBUwAR8u677w0PVN/xJgh0OHPFZOTybXkGWyOgmIbEvIN3VxzBF5IRsjQThGaosEwzy44UrxJ7Q1wZcTPDarMb4k/vWIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eILXoJ5oAXJ2EqLklYO4M3UBYD/MRqpqAb/8zvYlrH4=;
 b=RLDStzUHqeaxe4XZOOAD4sbos8Ahh/83aJHELhnNltTOS0AOMMRaNAuuANCprQJalF5lsfIF/pmcxq+Ecjf/Aw/4egcGXGXylPsPb31oaj9ZEzBqJcQsrXJWIXAoJ+lVWllDiFGdM6pcjQvzyIIavv58/7ZFSwUa0w8Wz/dnixhFMGLgMcmlF35iWWzNgVoXhGaXlfbh6jkQvTuQPIyhOoDpJ0kXzILtFdvJ/IpYgCQCQrnvO4ZUljTjK80SbQEbeOZMUewj3BphSS7l1F12iuSacUeZuw98XbJ7Q+gEMXnHa8sFTyFWxSMFZvuTQJx1GhIXwBAUs/S2huW++MYyyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH3PPFD01EAC3BA.namprd11.prod.outlook.com (2603:10b6:518:1::d4f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 06:48:44 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:48:44 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH V2 11/12] upgrade-helper.py: add logging info about running bitbake-layers
Date: Wed, 11 Mar 2026 14:48:12 +0800
Message-Id: <20260311064813.619683-11-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311064813.619683-1-Qi.Chen@windriver.com>
References: <20260311064813.619683-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0181.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::7) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|PH3PPFD01EAC3BA:EE_
X-MS-Office365-Filtering-Correlation-Id: 355b0fbe-60d0-4023-ce2f-08de7f3a3ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	L9u3JJnZ36EnrPwWfz9UnnSoMzDMePy8a0IUtqPcDaD7CUjVqgEZM6qiT+Epx0yHxLEGW6aZFiKkctwEsZMQubwo/Hs8XMS1qdzJYHCPx5lextrkaYq5JwUs/Ehaoa6kVboNVMwSB9CNhlfo3koTF5XZkZq5+DHU6IA67lnWuIJKgBRzcuwZPVACzDk6d1vBAMfjusF9Kgq8LcA2mhdZ5N/z8k99zZ8ppPgolbpjqyGRjqFiiri6MHaz8r1TezMNFjv3vJ6q6jLCmtF9j/UCjnzoY8JE4h2HiACa41w17GAd9IJqFwx6nup7k/S4n3Tlzr61Fq5fGL6RksRq8nCRJVJ2DPDwpTYtjKPODJwHtXTRkQx3SvYjA8A133rovN2eaO9tFaigsvZFiAz+FT1u5g2WK+j+cbTcp6p0y2h2hPGK/29PJvZUE28TwD/R5CbWQsrs6e8DVbgdCvhFpAEc2qUElDexq8Agp7nJGz7fjj0/vUaxlcDdhpMQ75UKpxGweYEHd1shS2DecLs2MjYSkf/AsEMff+O6pPb9Hfn4p9VafY4Ch08JI9AhPWZzxnDcycNJrV4uw0UF6W2vfdQ7Ud0GABtM0ZPe/39e08+Uur5sUYQireOIpvPrs/8i9eA64mJQm7feSpDveJw7xs+yHgn3C2siu/Ba7fc9QbGxpeToNzQvtLt+HNSWFOHMguAg3iUqfUaaZNiEmFun2AuwRcMz/SFwXiPTo24+tmsNFq2yJWFXZP4VuTJ3xK8UT8GYkO2yEWdD2HrPH8xUpDqVvnZGzhGH9wQHw93Zui50ETI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eQlTTRiOgh11P9e3jebGzT92cBE/Rh6oecLopUt5KU17qhA0PdK4XEJh5aI8?=
 =?us-ascii?Q?LGEfEe282hOhL41b8hZaehUu0vXHehoA4Z191g3qO15hFEEWT/kO1nK2/pV7?=
 =?us-ascii?Q?/Spol8AN0iDawUolxXhGKcEfTHsLeojdjog32PdFzn2wp/y3DVohv2PaZ8di?=
 =?us-ascii?Q?c2kIl4tbod5DW9lJcnCKRsLcD75WCUW7VYnkPE6M+opbJl8tjg1+lkwx4AIs?=
 =?us-ascii?Q?5Wt9RH1TOWfkTJTq3mJ1cQe5U8WjFMDUV1k7gpa/NkWm0rg+X6CZwPWJLon0?=
 =?us-ascii?Q?XgPQUWOMPIvUxLfuEnViN55IEvx2wgxjCDYRosZYWCaRJ9nMum6JJjTzNMqB?=
 =?us-ascii?Q?UvyLhsvBNT8Ld8j7+mCQ5eAclKlydNYrNqPucQ32hCDqCQyo/B4muTHOTVI8?=
 =?us-ascii?Q?qfzdF4qYHLV7Sk515BTZEvbkU7JPJUQSRlG6D0X5lLWUOVPz7rSuliG5WAJM?=
 =?us-ascii?Q?z8Q08fGdg+VaG+TH9FBx9Cb/rZO1PuhBNTe2UZ5BIFlt8hv8jRjOeTMXUa8+?=
 =?us-ascii?Q?Ygw3Rz1OgNZoK27Rb9n+peq9HdhSTFzPeWb23EbDneuiefQxiXz1VAB/9gEu?=
 =?us-ascii?Q?CZW+44nCOYxUzkHYCfAonTRGeaO7YlUpMukks0JafFZ2dmF+/H4Y62afYYMf?=
 =?us-ascii?Q?26f4v31O33/JngZKfNjxoCFS2mh+zmdwEbkHi1P2P4uota3eoYgU0J29LF5/?=
 =?us-ascii?Q?j/Sj5sNBRl7esuowewWrruJjeiyxXLyY+5borPSyFKfDskqvOzY5E2nqKjLV?=
 =?us-ascii?Q?SWM54B3xPq9rZxA+orNcZlQG0q8rdCyb0Z8WI9z8xcN3bsVON+Dba3Um7JDe?=
 =?us-ascii?Q?6ZGyP3Rt9VL9Mj9rKgWY/VCbagyUafI2tGU1q5nimZRzWE/BP4qfIm5yjlYN?=
 =?us-ascii?Q?2A4JnAVI4wpKmFX81yXVavwgbdubCvaJFnpuGHo+4OYr9sVrP0E4LLDxu5GP?=
 =?us-ascii?Q?HGnB7oxPzbLfsutL0+ceQeuYYT5v37QHGGpCUoTCrQF7ocLFIN53T46bEAc/?=
 =?us-ascii?Q?NyHDDGxAOo1cQp1oUv2WAzfqLmW30igHqBaNuXJkgvkhXL6ut54XICOpVQaZ?=
 =?us-ascii?Q?2v+lqKBpGVN5pfrHbjL851/ZcjqQddaAFxfeXeqKKvuYtxqv+CezgmeX25X3?=
 =?us-ascii?Q?IBGOqlNoOX2FHKSg4jCl4ApPLXxgKmSPT0A72SVmcFHHO0nPvkWQKBa8TVYP?=
 =?us-ascii?Q?HrYri4WRjFrH0e0x/FIkn5M2feheEs7TiGJ9tI5JSLpLOEa4+3TRHl/Bz2vo?=
 =?us-ascii?Q?5j3L9xiqV7N6la8ZkHnDZRy674Yelxu2ZcSeMPYLJeJItlkGnNQuryHffTR1?=
 =?us-ascii?Q?NbPe0QBjoh7ZZJvXGs5w4tw2BOUklFURaDuxdrEqKwtZju5MZ4ojb/zfQ7h/?=
 =?us-ascii?Q?oPEin1qYvUZZhpldoq5OqU7wv6leDAau+aOCHs2XL9iOnTQa78Lhd/eNc74p?=
 =?us-ascii?Q?0g+QKMRa7VsJC9zFrsbvS1q55ziw5LmQfVvOT94iKbWVKdFGt+2EYAuiVKBh?=
 =?us-ascii?Q?Y6aGW3kyUUnxQHCyG2uQdy8cB92+N+yt+FFKa23zpGW25H9S2kfrFuaJTWRy?=
 =?us-ascii?Q?hVJPTk3kgOxCsBes0DuR0E+bb7cmf8Bu/8oOa4LbBWJfNj78ahfd4FUU84Rs?=
 =?us-ascii?Q?wyXQaQCBKRScs2+bWc01nzYBsxn7XFhjyUQpQ5ssABAOZ5xQLxMMGoy1o5Ev?=
 =?us-ascii?Q?qc82pFIvt9NKLQe6phzlCTD1/SmJcbfevf6IxBTprN26aHqlKCDxLX7nUqk4?=
 =?us-ascii?Q?6Yi8LnlNzw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	gfmfhbb5kC3124DTUWhKr/rAFv1PLU970/1SSIt9h8gEKdN2iQNirjQ23aDaHNrH6MSCdqRkFH76yG0qImNbiK+3YX4M0Uw8MTiIjqLXMZslKt6u6FtrEeMG6CVy5IBHpnOrg2OZ+pYQS2AHGbGE4d3ulNQRPQtF+6wlmvjONJUPGVT1V0YBSTKJQ8O3hWwKP9vQOVv1mL1VgZtOxWD/LO7VuqEG60UjFrCbcIfUUtFSQkaPW5hJSOrVUB+3cT/4eT50YyoE5WWK9bM+FS6Zz2OUHPuTG8u0YLQTFr+82Wi67EZvUo2PbMlhWt6Dy5Lh1P5qJPfze0aWnADlxAqSuQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 355b0fbe-60d0-4023-ce2f-08de7f3a3ce4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:48:44.2447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfGQEceN4kxOlsix4kTqItZn4cb0xBuKZSrCodifPw2yRa33tw+rAIIMXJ94a2IXMmdRi0BcETGvTONx/HNtsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD01EAC3BA
X-Proofpoint-ORIG-GUID: oEvBLVoSUi_Kw7ch4oniJ5YmyCHs99QP
X-Authority-Analysis: v=2.4 cv=fpnRpV4f c=1 sm=1 tr=0 ts=69b1104d cx=c_pps
 a=2HCcruDS7e3rZRcUQV6B1Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=bmEcsPE48WtV85cMDF4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: oEvBLVoSUi_Kw7ch4oniJ5YmyCHs99QP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NiBTYWx0ZWRfXzwDfy5FSmXbS
 aoJc+Ypx1b0wmdbuuXx2MtfEBxdUptKaJXgrUjxT1noN9aeOlqHVVwiJsvIYJIiDSfWxOVyGQ3L
 18c21E72TSlN1EexQ719uvJgHcDz1xSLl9ylCCWk/5dUlTZxfpu2iiFeEUL5wOXFeUIrneNyzXy
 7OwVtZUVqw4yi21bfGqYLK9w889gYPcHoGVuji4PX3zI+Q82Td2CxTjUl0Hf8G+EPIZW8wSKd02
 qeL5qulSl+PPZJGR6XDagx5ObobVaPEUC0i+/nO18YngkL2zsSXiGlt2SYGb+GZJ5EbblWPhDM1
 AKiPS81/uZP0G7VZKkuX/Cvl3/9ZUAaGoC5F5sBHV1quVsfspro3ITMfixU0kMa4yoyePc3h9t4
 +pX+hfnQnka+xpwtRMHHuwNq3HlZbYAIWrJMM81PEhkS7s7c7LcEzXdXI0EsUCrXAJJj9u3I+iS
 j/rIf7z+FvN/tlAhSrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110056
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:48:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3424

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


