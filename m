Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C73DFD062D
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:36:37 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14667.1773210993901897134
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:36:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=sjZpZcUr;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B5nvh1621223;
	Wed, 11 Mar 2026 06:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=wFtNsDXT1K24bs3pRfrSaayXlAaRyTMOoI2jebRkNVM=; b=
	sjZpZcUrJMmQRg4GXv4DwnogyX0Tqc42OO8r4RXqQC8gmNHSIS9Kfk9CxBF1i+O1
	CPZR54vLc1W7+3+hGsDQruJ3UCzLw+ECY8Ypfjtl3uMKRr/cgwScIW9vWUryr1BC
	jkFFNyBTgMN2Q6evpS0f2cYa4gGFF4qMq851xCZAvYa+GhYYMGyNSq4IIh24y+dY
	Z1XPd8LCVAG6bMOj5WAf8gjA8my2EYKY7xt5s1+9SQb52aST9vc4y2pDMih8NClk
	M9HwomDqCdkJMkh1PLGMk8txSQipq/2XpdNKf6qKpApQs3rkL56IB6BVs/NgnNAe
	r7CMuHqscUAIuu8vpktUfg==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty57870w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 06:36:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGYhh+h0FYqo+2wkin/jxsdCWEcJD55785rAo1TzH41NUlJxqrmFZ8jKUZIuCb2d01BI/2n3/ZVMtD3tql/QPskX6XMTPWcIclD0C1hpbLP+OdbE5jULdAdHjREtcj9rTuJiZ9PTZoBOzMCpK0+k8vopEqzCWbGjja3PWyAaPwjWzjlh41Y/GUV3ilYYv2WMlfnQ15T3tcOYlNozVH0ASg5NxivZCuLDItvRiBTh+CByNuFT3EKun66DYH4ApxyXt+or4DERyiBOLvoOOq7QeHYmteFy8t+FfokYEHqp7GfHzacMQGu7WRlFskKCmh/ySppUyUL6n1aTHHJ1H6aacg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFtNsDXT1K24bs3pRfrSaayXlAaRyTMOoI2jebRkNVM=;
 b=soZ/yaGQ/5sNoGJM2VX/YfS0iFXAajELzUUJYK909PcUDq1jVhqsCDSOPHyi4pT125lCWulO794vq4m9nQLXXiwrnMxNlSNXfjLahrKysTetazlUETDIYFzhTcuhqJqJkIWv8r4u/sR9kSMZwYJM4/3Pbl2Ld76Iv3JSPzj7+LEBr2EOvAslDrfAcGGKKpADW32A0v9WiIt4RYOj+l57I/6RZwIrtNi5uNkffISZxjrXU+1vw581o/zR2frE5M38qHd0H5Xh8ozdEvXhWpbv1ql4VLjTqINoe+bd7lg6hb+yVL/N4yfehLtoc9u7Lm8ULhT+dpPsxqB4gDE70gJbsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB8787.namprd11.prod.outlook.com (2603:10b6:208:598::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 06:36:30 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:36:30 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH 09/11] upgrade-helper.conf: remove layer_machines from reference config file
Date: Wed, 11 Mar 2026 14:35:55 +0800
Message-Id: <20260311063557.229656-9-Qi.Chen@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 71e1f7d0-5e1e-489d-90ae-08de7f388797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	0SMC/kO77eJHA6EHd+SX9I1CH8KifEiJcK5EV1YOGAAjGb5vKnX6UsM/mJ43buTyH3SAlkeOnaQLu3Q1i0xyx6+JzZnpUf+hJ9nUS7/Chx4mY4NvxObs7ExJSBIokEjA46rftjoGMwby5rTMQ3o1PkhwD7Y0S0v+LJziU4sFVJTbA3RF4Uv3DXbljhFJn+8VC1j1NmMF231DhehyMvQxCeygfYECMTFMY3iVSSjqcI5PL4PKdqblKBT5HSqYCDHeSZzGSgFEAUdoNCa1Nr8TsoU5sVW7ic2ckkVfJ0WUeGCp75rQQ3HmfpBXrd3hCrVki5MDWqie3e4OSS6PIjH5x/aDOcRilpKKvfkEG/QxXSvzbHx69zXYoM0xRcIsm7LT45qcUuGCWCex42fGkOJOZD9Dsv2CUxHOI+7M6tuX2UMeIaTbxtbDBQQSv02ZQm1hfwbneqzGC0qHb5Va9LafAesR3SMYTdBXOfEhxM+hjECobXJM7ncIVQui7DqEqDA7VO45LCLiFCO+5ihuh8H+/xlI+MsfrDrmverauNs1ph+1jWhg5tk3Rf/WskQBpTQ4+K+T1L4V7skb8Ct/CuO4wkFrzagGdPoVbdbinOEKAWUxCdW+i5OxWDS0ZxYwZWmMk3w4ZL5vpAKJi0ANY4kVp7xgiaJNhO3wRhKtcuqDSQpQvZA0674R+xyAnAe8u5YXsRaFXOqezuOKBa+NFfRdcVHmMAkz4CXZrlrUyu9bdTzdaKNKGcQ0EacC2aipsTVFZDeJStOmQgj4qf6KL/bHIFRKx1l/2bxUs9EHS2u1pWM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IAgr+4Fe7ZQS0ueI1iyEmTG/9OkgadOxspItMnt/rW89SHCwl07BetyxLQyE?=
 =?us-ascii?Q?Fcy3oRuWl7XNfV3014oVKfCT4ozI5s+eLhhw2JGJJhiZIdVrg87U08OtaK6S?=
 =?us-ascii?Q?Vl4l4S6TbVSVoPOalFncgHbMQ45PL+YexsZRcmLYx3rcfJW21X2zo33RYajW?=
 =?us-ascii?Q?7ObYDdPilxo/tUA2tc6VG8LGZ3LIUd13ORVStx9+2rx+XeJRj/vL8sV/TTDi?=
 =?us-ascii?Q?HHI3l/BFo2ughsUd0085Rqn4TV72LP3pQajEQTgNOD1mz2KyOMzFJGKmIUls?=
 =?us-ascii?Q?3q73ER6RAesD2eRL7h39jTsb1PVCWW/8oCzIegIHlNSo8TU/OtrIEHrLB3qE?=
 =?us-ascii?Q?eSGPXL7vD4qsSxduodVIdCNCXw9ZWwvRc9AOloLGW4mQ/RLjSO8UEvNxpOgf?=
 =?us-ascii?Q?3uRcMR6b8NKWhtckgZKPNpi+T/gheHJtAYDXDntUvDgDTFdjK9HpervDXm5B?=
 =?us-ascii?Q?AMBPDjddXRgY1CbZvokiwmscXOVufy+YKVyOWvT504QzOH42ouVedxW9H49q?=
 =?us-ascii?Q?EfLyiaJyRRr3WQiidG9xnYNCEE+Fl5Il5EF2DGJuX6j+5t8ls30blDz2AqFn?=
 =?us-ascii?Q?iDKOR6XoD1MhB9uCJ0x4IdppB35L7jvZ+X/fUBszkCdKHMuiFB8y7TU3qetJ?=
 =?us-ascii?Q?n3HYhDSlJz2OzIJprnYexC2oCYf8FyKhRquTmHlOOURhyrkIMJuYEXxQecHZ?=
 =?us-ascii?Q?ENq/vGV5jOq/Se5fpZzVFXnri7L4Mxe10l1dIEiOOcuIVCcRZeOx4IFnkKSc?=
 =?us-ascii?Q?LBS7naoBthiiks+dGUuMLxSc8QyC7wtxcz89o/I3m6rZUqyeK6+StiSFO1pU?=
 =?us-ascii?Q?caR9UCYDZSaDGT8kFObiQifBjbFP6oHYPCx36V4i91U9GjVyqqQ2cUFrhBcV?=
 =?us-ascii?Q?A69+sAf4wde3tcrzsvhYqyhhikmvLIaE9M+wa817WX/ItfA7ZzlRmJbrArKd?=
 =?us-ascii?Q?zFN/fpvG7PlVhw12YVJLvt0Wxddgp39/I+qvBpViKje50HEF5StC/IfGaYna?=
 =?us-ascii?Q?FNcdlDh+dobF6k5Q7swuNifbKodh6iGt4/rB5skHtrMQROFGb1+6DGJ7LXnX?=
 =?us-ascii?Q?KaYhKCPNsWgX8yM4SMzy6uqsvBLEvJ8SdZI/R3SGlTnowRUMuVmp7EeZ7MI2?=
 =?us-ascii?Q?tIs6CjZBi9tS4MIrfQssfGAi9/5z9eHjPdi3FTK/oUQcKWLnw+Ksz4qFHir+?=
 =?us-ascii?Q?1+4ZPTbbYX8vW1pmdM2nxGQwKIwYcNYi7iU0IiEVIZ1sm606K5t7n+Kh/czn?=
 =?us-ascii?Q?4y9HRW8n7vew0TDYz2bq4NQyrHjZ4GtbVIwc/kcXZq2sE/oqLGCCNnsnzJxv?=
 =?us-ascii?Q?9CHdKU2Pb0b/CTQ+fyBU3/nj5VvFiXVRRujE8VxOkLfnUe0JRrtePgp6SuQY?=
 =?us-ascii?Q?NlywIorI0n0TwhZNbN34YOgh8Irf1xWJ6+xkzRbgculE4BCI1HDvDrzqbeAI?=
 =?us-ascii?Q?uYR1PbyWlubrTIL1lv0TC6zVzR9G2tfkSenGOVEjTiy6wZYojvh4xBfHXRdr?=
 =?us-ascii?Q?lU9ARgjHcrGfeAsTICwZo99qUEv/G6+umyRHwvQIPbEzAyu+dS1Z1eaNXYad?=
 =?us-ascii?Q?UbSWfk6ajTWBc06ANiqgZzNLKahKNcsie2CIRkDySsRHLfKwaXqWMhrdps8+?=
 =?us-ascii?Q?qzGdIe/VCTi9y3YYa7p7bNKT2sEMVmp4JRAPOuiMKahyOY/+uJLOhyCf5Tno?=
 =?us-ascii?Q?ZlE8arDxKZ9UUnMBu5JW8/lj5NQQtHZhhDzJVaLXE7Z8oZi7ZowRoAcE350f?=
 =?us-ascii?Q?2EdI2ofscw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	OQJKQrmksgdpLp5WP//H+dxEGbW7IknQFFXZnCdKICYw8pDBZIlc7//TbeW9X03AqqfkTrDSTvymRO/s309sypAEBHuzslW8ZyGOGPupZ3PRn1QXPWhtyIpTQPJJ3HY7vNrIB80XWi8Y7qd9+znZ/DLAnT0JEO50VoIgKMFs3oirEOioIhtneGeo6mD0T+Fr+l87wu5JDEWnNgiGaskbcbRhHyardbPuxz0kaYzR3Kw0xgFZeYmVEg3H32/s9jP8wHZL8aI3ye5XtgykgLAOFgheFpv4sDDzSgYA6HtiYdwPmE4TLvYulKqJ75xUfAQDMxFEc7An85+eWlVnjES5Sw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e1f7d0-5e1e-489d-90ae-08de7f388797
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:36:30.5971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mzkt3aTRW0Qa7JKNeIZhBIUwwCRUXF3A2a1MhlCk+7RBxszPS/wcrh5bKe2wVhL/Bc1ic3Biekd35l78OeICuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8787
X-Proofpoint-ORIG-GUID: _ZZiAjO5AHr1htQqzYLGwmF_SgGVRCoL
X-Authority-Analysis: v=2.4 cv=fpnRpV4f c=1 sm=1 tr=0 ts=69b10d70 cx=c_pps
 a=0FlYyfQadWprtAtRvkXThA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=ieWZEeq6gUxmCoMFNBsA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: _ZZiAjO5AHr1htQqzYLGwmF_SgGVRCoL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NCBTYWx0ZWRfX7zAGHqNKjSyg
 dDEiu6QPyxv1mYnL6uGntVVuHB7a96uaC5WJVqnotCP8Dxau07j1XN57rIObTNpf0w1aHmcf1el
 4gN5rIbnKJsS1bq8DKUG3oza18dTb6mtWhZEg7KeDdQB0UTAGVVkgabZVfbtQdspBknUjwXSbaq
 FBey6Aw/kNed03phhg1o/LS3JocdA1F8lO+T+Ggd9PHAhtsk3wUPU5tv+et5zhGURWKYiEugmM+
 kIlK6Qf8J0dofGE+VR5EBCoXbI99fYI3l8WaiuMjx9JhmupKbbM08jqSV2XrGGlWyCCI2YWZx9+
 NOo2PsKY9Tebt+pGE3xCWJ/sad0QLjLQQbTClaVnt5gaaLUfCwBmKAdbY3Mx5ixhTzjDGR+A900
 8MVxCkIy8ZxbZBF3ZxcNUN8mxt+6ofakW/7aNGdKR+uXA8PJ/cC2oIN67fiK7dnwur3OKgbDC9n
 vzHgoobt/ZkP7kyksxg==
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3410

From: Chen Qi <Qi.Chen@windriver.com>

The layer_machines has been dropped by the following commit:
0ea93cb upgrade-helper: Drop layer_machines

Let's also remove it from the reference configuration file to
reflect the current status.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 upgrade-helper.conf | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/upgrade-helper.conf b/upgrade-helper.conf
index 251c36a..269bde3 100644
--- a/upgrade-helper.conf
+++ b/upgrade-helper.conf
@@ -116,9 +116,8 @@
 # This can be used to upgrade recipes in a specific layer,
 # for example meta-intel, instead of upgrading oe-core recipes.
 #
-# When layer_mode is enabled, layer_name, layer_dir and layer_machines are
+# When layer_mode is enabled, layer_name, layer_dir are
 # mandatory. 'blacklist' setting does not apply when in layer_mode.
 #layer_mode=no
 #layer_name=meta-intel
 #layer_dir=DIR/meta-intel
-#layer_machines=intel-core2-32 intel-corei7-64 intel-quark
-- 
2.34.1


