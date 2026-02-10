Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C368E7E0D9
	for <webhook@archiver.kernel.org>; Tue, 10 Feb 2026 03:34:31 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12442.1770694469161838453
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Feb 2026 19:34:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=r1t4v56S;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=650104c873=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A3KXKj1514475
	for <yocto-patches@lists.yoctoproject.org>; Mon, 9 Feb 2026 19:34:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=0fnSMDVAStIBWa3xq6QL
	8OsBpGwosnZ5nPKm+s6uWBs=; b=r1t4v56Sou90DwA0fjMLH//KidjBXPjcE9T6
	XNBD4wnguxg8ndUgddxOKHzRpTbK0bMyHDs2C7u6b2OVdjdjtz+2s2MPQ+wZhfMi
	GpdECTXqOYkTdqnLgQihZb6RUJX1VlASCzw9gzwPwzaubUa0BhsEQBVkArCLo1oW
	gzROmN6MzB2aa42fnncyG3UsWE/HMujbi9GNYJ8/c7Vo0QlKGwJGnQuiJM6Zuf5V
	D7Ubc9Jty9SHXBiXCUbJ92CnEW9tSCj5c8M7O0exJMtEcqqrQf3D8BaImuvgBRqS
	SRLtc286IZPiBxC66wqbCOrOwNEfgd2WPo9rA2BBtULYVz8kDQ==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c61j4tm29-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Feb 2026 19:34:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJSJ8Y1HNdflfDNzqyk6Nj+CaqSKdQOhO5Jnd7tk5R7hajwhPzFwUhnU6YUuCSplY8Ohp9fS22BNkHVZWIbxPkPnjc1cLMjJ/m3I8S2D4/htPMDkRtgaHrRr3EDZc6KX9S+BoRgBiBYf3a1Ez9jIxpPqLitS9236F1WPj50VLVdvEKSdZXEiFlkdJMDbjcSOjfWwI3ZPpZLaqVMKJ4H6ObPbzqm2ylFzI2Od6ehSsJBlPQwmRxFHjbMbsS9GL/nOrnrcizz7J/jSHvtQhNpqoUfl+evxXeYo3qUK763WmqfD9ymqwJxOnok8x/GYnGnfJJML+7KdLirYFi8aNRXqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fnSMDVAStIBWa3xq6QL8OsBpGwosnZ5nPKm+s6uWBs=;
 b=cVeSCTJRZ3kdopCAoKu9PL6xlfj2S8CslOOBIROleuAvatY2UDmURAtht0zDYgVDGntRxF1/9Ab0K4+CupRvvOfMkNlT1d0KR0u9+KK8xC64CshvDHY0kSaTQtOZVtNoe6qBX1lBWlG4obEdeTt5eC0fchRDGq1bbCuI5VWKHPgG2z7WV7nA9M0Eqv3vGfQGk1QfA8yeLxsP4X91dbHGDac/L4q+zbfZ+/Hu6okUsZNO+TS0nqRSy+UruP9hrfSSQ37aBR6UpU4Zw3B7FYcOod21rJOge0klpNh5KKaWh+0YjxybT1x3rX7YfDghwKgzwwpmqWbre9domjSMiegicg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 PH7PR11MB6005.namprd11.prod.outlook.com (2603:10b6:510:1e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 10 Feb
 2026 03:34:25 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 03:34:25 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] refpolicy: update to latest git rev
Date: Tue, 10 Feb 2026 11:34:11 +0800
Message-Id: <20260210033411.1867881-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0078.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::14) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|PH7PR11MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8109f7-b14c-47fa-9548-08de685549cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014|7142099003;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?AOigLiD1NK1sJFRnp82CUO+IU9hk1vEP4CjkTP4l+uhMPOzjXvrURAMlO8Yl?=
 =?us-ascii?Q?CKxmDEKOgu4t2Qu+lBVxTVa/bu/X6j6jsp50tRGZFqSqaYPjHD+kBQD6TFJT?=
 =?us-ascii?Q?BX1pG5Smu45rQf2r1w92jJaNE8nbfyILu6LeDiqF2mWDJYwaK9SH7z61ulZz?=
 =?us-ascii?Q?d2wIiBCLxorUj/Ayn/qs/lMAwA77yTxEC6a6dBsbQc8Hgl2qV3Xc2APJQjd5?=
 =?us-ascii?Q?A/UrlYPBzZS57AqX8BTGWMpEqivOsXhimlXDVvAhT9jakE0oh1yGsDUE+Ote?=
 =?us-ascii?Q?5juW3DloxhkW44JDfhRfPMFzYJVwFlG6cInseTMOuRy8hqYpMSpObNYqpWrk?=
 =?us-ascii?Q?8Nrbhk8iImv/bsooQ242rTdy04ceFgwGYg7+QYYY3JUwwCtWl9N/EV7nrHGq?=
 =?us-ascii?Q?2QglylzzcrxyQhtfAyRksNdu4B+n9UnJr9XBgAHK0UeawTCTWuYy1giSeggP?=
 =?us-ascii?Q?djeYMFS819Vx2mGNsk68fSnE5Z/gmFV0sMy260TA9n9ackT4u6amZ7FfXpxb?=
 =?us-ascii?Q?JtG6D0rhyJnHbSuCn7iEsUSszQiBAEdDTntywsn+ce4JEbNKeguEUvVOoTzn?=
 =?us-ascii?Q?gKcYwmBESufwTxZp3TEQB4w6kQ2UwedY5rbgVqqaJmq+65GwwzDVnHp0WZVO?=
 =?us-ascii?Q?GlMagflJka+UZVzUHW+0cJDXJPGzlgVVCv0Mq59vzld97qbUSlNuxNkS6ncH?=
 =?us-ascii?Q?8SQU+bK77r/vkH9Ak0Mfuu/oCkSEq+160hnw8uhHcF9e+plQy+Q0LxwYVKd/?=
 =?us-ascii?Q?jCDsL4qI9D1Y4Ty+gzJSpyQ2yrWFIGZjzrXrevJrykHcn+zVpzpdjzhn+/SU?=
 =?us-ascii?Q?RFfIP1MzYj6TaQwYeMFG+IW9dQULk1ArqKHbY5FYJOJqtc43gUUCB0U5xbB1?=
 =?us-ascii?Q?gUoHVb85FkMMEz3k77+SBHmMv1fCZvPIz6b57HlkaOIQpcHrZ6DHQq7Jty70?=
 =?us-ascii?Q?w61sSyYuZTVVQdbzCes1eCBnRjJ5nu9s2Jd+4xJ5BRNknby80/LVlGcyvJDK?=
 =?us-ascii?Q?MOQchoB5f11Am/1gbx/ich2kdTykKvTejZyndP8bFudmSCoUQ4196tABH8//?=
 =?us-ascii?Q?ZdfbOP4j8GBQfInOcCZCb/jVYtom+GtZ1FR6lhcHozwvEndepYuFjINhNOHV?=
 =?us-ascii?Q?hyE5OLXQHtpZeYACuHUtoComO+aCpNl5RWJUuon8xsoErTz8NffSI84ZPKxC?=
 =?us-ascii?Q?ZIDSag+CMTlb5jjdHaPUzTJFrldUuqxdmCj04DKeTB8RiepQVXBAk6ODOQgd?=
 =?us-ascii?Q?S50C70tgqrr7y/uTpmfnR7pP3Abn7YoZC/+DCRewobmKjUrXyjKH3FJfVD4m?=
 =?us-ascii?Q?iL3SYgxNdYFmWXpUtROyFnwFt//Jpih2BXWt5tmur6L3bxKxgkJ3l2WcKTUt?=
 =?us-ascii?Q?9jjJB6TWiATWv5M+S0i8h/2i2XY7QYXzlAYoUHmoNNkCq4rjA5OxM83Jjb5E?=
 =?us-ascii?Q?yD68Adg/U0tzt6XZFzV1n0SrJoHmp+5VEuXPKaSA1BIQ3++QnELQBM/rhsIs?=
 =?us-ascii?Q?4P3Hqs/5GOMTUFEbJ4XR1Mptc4S8v92zns6yRDxFM5fUn/M6qiUvUyHcLZ3X?=
 =?us-ascii?Q?M4eHySERtrfwllTaDajcoLNhXndFb3/3Lr5whjEgESyKPVo7xfL3D7vPLiGd?=
 =?us-ascii?Q?eIz5uGYaP7IieTfsBb2BmDI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gua6GiqeYDUZUTX6N6OVRWnmvHp1MGnbPThPrtUzgig3ZJggkc0Iy0DTuTj2?=
 =?us-ascii?Q?Fs7VSSvcVvpuC9vixQ+bZ7gk6UqJp1INnz9AEKd7vshjusMS2xRCVBdPjk2j?=
 =?us-ascii?Q?Jx9NZcg9J3Sf2Ro1eXg9BGGe9wDEaMWSWPpQQueuPu+8i6czyPpoZUBgI+tX?=
 =?us-ascii?Q?7WPcTlP8Dida9wPwc6lxjlvK58sxBs/UGddQqsoJ+btbxkQb+aRo5gYcuOcb?=
 =?us-ascii?Q?mh0yp5akT0MbcIWM4C/g+C94tXxqC0v2gEM8/U8R43Jdxclzhy68vcP+QWkq?=
 =?us-ascii?Q?3TL6CWwyUiN0NxfBCNdjPmNFoDYdCBGdSKs5ca3OrQlrOQPsNVjyGRQEPatG?=
 =?us-ascii?Q?M4WRYuWsIlAQWweCisY4/fDL+xr9SJyp3ORsmV55xtTZ+cuU61MffKuiGTaw?=
 =?us-ascii?Q?19W99dbb22r58Pi/9/iyk+o5UiM5rA9Q0BnPVfP3cGRuYDQKyfL1+Dg3OU+N?=
 =?us-ascii?Q?RVwZjLC3AbLlyUW7YmSaIrOgMFqZaupU8YHq2jSUjKocIN4nFtQwGaWUVp+w?=
 =?us-ascii?Q?dBXCJ8jbP1VvEmT7jnLhcWzjN8INvtSHP6nTIReDe2W4wcvKBvMA109Y6A5L?=
 =?us-ascii?Q?qUPOjScUIVi8m8DI1K+0tSKjs8gpUDOQYv1Lg5S4jGyPSt2lVLipLytaTz32?=
 =?us-ascii?Q?mqjCQew2D01GWSu2MH4vR5YgWuOsDGS9O5YsujnzFINfiUd7XKE/CE9ZPu4R?=
 =?us-ascii?Q?NyRE3+AzzhCXhoFtLevLP3TT7ndmNeWzIeg8wNKtw/C7p1apItVlSGTJoLH6?=
 =?us-ascii?Q?7R5SykXxOFSAZRGADg9M0ceoQbnB2ar4SLvCbJ4BM+AYhilUuH/Bx3fY9tGx?=
 =?us-ascii?Q?TOIAoygK1rIiSmJSNsK0SkHaxySkLtcJVRGOWr+svOn4oXiw15djsDj4c/fF?=
 =?us-ascii?Q?8zeT2AXnlzGMSiW2ZHM/ePU61tgc9FpJSPRHiFzs6beigDElSJHfPtwWpB84?=
 =?us-ascii?Q?1wz469d0O/g+sJspTG5x9jE5AFzYbNOU0r2adglnW7BhCO1uYoXJuQP7g+bm?=
 =?us-ascii?Q?tFOxe/MhH9Z++HTIQ4pI9wDTsTYS6ZpHKv7l9oYGiT+ZRDptyfFqQl72WnpY?=
 =?us-ascii?Q?Il7V//njGuZWW2rSIK9Fh/rQlbCvfJbW3TVHTN1rY+vrvVbZHPuFQzWuzZL/?=
 =?us-ascii?Q?dzRzUQscwLs3Az4GhkmxnwQkDwZimiJM3X+6jMgavDQyf5RhRowXSmY1BNFI?=
 =?us-ascii?Q?xLX+GnJFpdn6fmI3VAsxdq2vpSRkjpRwVtHsppiq+HVb41TsPfYrx+vo+ME0?=
 =?us-ascii?Q?epEce2kufMUQfDkrGKDMF0JBFhslc8W1YBMHOwZALfPUrcGVBXd0JAW9k98u?=
 =?us-ascii?Q?aERwR+rLeox0KybSCWMFrmWLOTAu4jshAlejDS/atzbHPMDuAmf/foTIiXHZ?=
 =?us-ascii?Q?fTxVpUdLDlTzKtcRamlxdXpuOh4LQeo5ssLnn21k5pRuhxRYibXklcoqcsly?=
 =?us-ascii?Q?v4WHOqQDVKGbixo2lh5B7VAglTgd3vGvQrEX/kjhtQUdfcgcuYKP++B6t00N?=
 =?us-ascii?Q?NrLHX77TFgalJzZD4AtBTHmDmwsdrJ3pr+hitp0UF6ICxCnmdLhFrbSvgGA+?=
 =?us-ascii?Q?Ik6z/zZh11aQjRiyD0kT4/HpbSNuDfg5hqMWHe6loqlW7DgSR5u8lHuGZeJx?=
 =?us-ascii?Q?CHCqw+j8NCiDkajZMGtX12aEPpxp7qoV+1PqDtha0Cbh9k+x3yyBEFzMDo5h?=
 =?us-ascii?Q?5juliXnH32zz79tNBkQhsWA5K2FSSOMW4dy2/lKH3IucuB7nFOWOPsVngXrF?=
 =?us-ascii?Q?PbNFMaGF/Q=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8109f7-b14c-47fa-9548-08de685549cb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 03:34:25.7244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Es34kxZuO4dJ77a3sZbilMKHCAjF5PGMrsIsiQfZVe/OrMh/v/PqctvWL6Q7DZjAlrwZFcNtiKHk63OYoL3J5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6005
X-Authority-Analysis: v=2.4 cv=Wb0BqkhX c=1 sm=1 tr=0 ts=698aa744 cx=c_pps
 a=+v7uXpzEFv5PX1YPhMLqHw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=t7CeM3EgAAAA:8
 a=9Wbp7B8dAAAA:8 a=NEAV23lmAAAA:8 a=KhrQjK9j8YOzXaBYAbUA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=BESxJfN36ujmTJQqZ0Zq:22
X-Proofpoint-ORIG-GUID: EyMO1i--WEEtp_0axa9vL1B9M7XuL30d
X-Proofpoint-GUID: EyMO1i--WEEtp_0axa9vL1B9M7XuL30d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDAyOCBTYWx0ZWRfX6R2bVV/lvUOi
 m2ujYdPKd39/sidwF5sTOO7VxR7xUixpkoBpSMa1iBucamE3mxGb0dbuG0VpdDBSwd2O9cbm/0c
 O/xo02Pf5/bgr55hJlv8w3jdbYMdb0nsHsDb4ogJX3wZcwGPbmqQw0o0xNlAn6ySpoxHhr5LBku
 z54mdpmMvUOgfaxHRhJeWAt5+CWduJy02PP5Jg53m3j7x3mhKXhaMighasJAwCHF81f8xTfXvTV
 Q6gF6YJEjeAi7UanoRtNBLaKYdelvZMOVKyuzOAI6DJM24WGFUNRcA55ZdAYY4AXWr24lom84X1
 ZB+Q3pmol0Nmqmrz676ZkrMUa7IAFVSRJRPEVqMJ3SY9uZYYdMxGT8kVfDkDk2MLswsxho2vKQk
 jOOuQx/slMsOmoDJ8WfzCfi/0BO66pZq8jihbWmMiCjTp0AGsQs4wZwa+99CY+BYx8tQtVZnbXA
 /4cpmHtjFF4JU4CUKXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100028
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Feb 2026 03:34:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3206

* 249573c16 systemd: set label for /run/userdb
* 2b296cfd5 Add policy support for Qualcomm FastRPC devices
* ff5bd4b6e sepolicy: Add sepolicy rules for bluetooth Notify failures
* 8bd8bcce0 systemd: fixes for systemd-user-runtime-dir
* 93533d690 ofono: allow ofonod to read localization file
* 0636c25d0 Add local policy comment for pd_mapper_t
* c8aef7c55 pd-mapper: Introduce SELinux domain for pd-mapper
* 0b6686d45 file_contexts.subs: Improve comment grammar
* 1783c0c4e ofono: introduce dedicated SELinux domain ofono_t
* 4a507774a dbus: Remove permissions from unprivileged user
* 4a1caa541 systemd: systemd-pcrphase read /etc/crypto-policies
* 62df0656a userdomain: Remove permissions from unprivileged user
* b91cef911 obexctl: Add sepolicy for obexctl to work in ssh
* 43ef3db9b Sepolicy changes for brctl to access devpts
* dc09a7554 crio: various fixes
* c09e51c2e init: allow using system container BPF programs
* 209a6c32f podman: allow watching systemd-resolved runtime
* e9721fb96 container: allow execute_no_trans on container_tmpfs_t files
* 3137f0388 netutils: allow network access in a user namespace
* 0ffef59b3 systemd: dontaudit user session getattr generic blk devices
* 22bb0f57a systemd: allow socket activation for systemd-resolved
* d70476c36 tuned: various fixes
* 1ed2834f0 kanidm: hookup systemd unit dir management
* 16022b3a3 init, systemd: add interfaces for systemd managed unit dirs
* 5f4841dea systemd: allow journalctl to search log directory
* 8df481716 build-policy: Add temp backwards compatibility
* e02eed27f validate/diff-policy.yml: Fix library usage.
* d978a9512 ci: add module storage test
* 7ef63156c ci: Create artifact of the workdir if the build fails.
* b63504dfc build-userspace/setools.yml: Add commit hash to cache ID.
* 14233d24a tests.yml: Increase userspace to v3.9.
* 93a6a5339 locallogin: allow local_login_t lastlog_t create,delete
* 1f0dbdbef authlogin: add auth_create_lastlog and auth_delete_lastlog
* 6aa166162 authlogin: label /var/lib/lastlog (lastlog2)
* 4b01becb5 snmpd doesn't seem to need sys_ptrace capability
* 41ebe4a52 init: Fix typo in init.if comment
* 47c348f5a Suppressing denial for systemd login to read process init
            scripts
* 5cd787409 logging: allow miscfiles_read_generic_certs(syslogd_t)
* 7c0a3dff6 logging: allow syslogd_t syslog_tls_port_t name_connect
* b0be996ea Adding rules for virt module
* bed6cef8d Adding rules for mount to search configfs
* f1fef8e23 Add sepolicy for bootloader to create directory in dosfs
* 1e55618a2 gcc_config_t: allow reading cgroup files for cpu.max
* 1ea2d3de5 firewalld: Allow firewall-cmd to be called from systemd
* 1b0172c86 Wireshark patch to allow execmem (which it unfortunately
            needs), allow (#1039)
* cdaa2e506 games (#1026)
* d68c6b921 Label ~/.cache/gstreamer-[0-9\.]+(/.*)? files (#1042)
* a6b9cf804 fapolicyd: support for new
            /usr/sbin/fapolicyd-rpm-loader
* 49e00dc0f chromium: drop the chromium_render_t domain

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../refpolicy/refpolicy-minimum_git.bb        |   1 +
 ...tile-alias-common-var-volatile-paths.patch |   4 +-
 ...inimum-make-sysadmin-module-optional.patch |  10 +-
 ...e-unconfined_u-definition-to-unconfi.patch |   6 +-
 ...box-set-aliases-for-bin-sbin-and-usr.patch |   4 +-
 ...m-allow-systemd-networkd-to-accept-a.patch |   6 +-
 ...ed-make-unconfined_u-the-default-sel.patch |   4 +-
 ...y-policy-to-common-yocto-hostname-al.patch |   2 +-
 ...efpolicy-minimum-enable-nscd_use_shm.patch |  35 ++++
 ...sr-bin-bash-context-to-bin-bash.bash.patch |   2 +-
 ...abel-resolv.conf-in-var-run-properly.patch |   2 +-
 ...-apply-login-context-to-login.shadow.patch |   4 +-
 ...-fc-hwclock-add-hwclock-alternatives.patch |   2 +-
 ...g-apply-policy-to-dmesg-alternatives.patch |   2 +-
 ...ssh-apply-policy-to-ssh-alternatives.patch |   4 +-
 ...ply-policy-to-network-commands-alter.patch |   2 +-
 ...ply-rpm_exec-policy-to-cpio-binaries.patch |   2 +-
 ...c-su-apply-policy-to-su-alternatives.patch |   2 +-
 ...fc-fstools-fix-real-path-for-fstools.patch |   2 +-
 ...fix-update-alternatives-for-sysvinit.patch |   2 +-
 ...l-apply-policy-to-brctl-alternatives.patch |   2 +-
 ...apply-policy-to-nologin-alternatives.patch |   2 +-
 ...apply-policy-to-sulogin-alternatives.patch |   2 +-
 ...tp-apply-policy-to-ntpd-alternatives.patch |   2 +-
 ...pply-policy-to-kerberos-alternatives.patch |   2 +-
 ...ap-apply-policy-to-ldap-alternatives.patch |   2 +-
 ...ply-policy-to-postgresql-alternative.patch |   2 +-
 ...ply-policy-to-usermanage-alternative.patch |   2 +-
 ...etty-add-file-context-to-start_getty.patch |   2 +-
 ...k-apply-policy-to-vlock-alternatives.patch |   2 +-
 ...for-init-scripts-and-systemd-service.patch |   2 +-
 ...bs_dist-set-aliase-for-root-director.patch |   4 +-
 ...ystem-logging-add-rules-for-the-syml.patch |   2 +-
 ...ystem-logging-add-rules-for-syslogd-.patch |   4 +-
 ...ernel-files-add-rules-for-the-symlin.patch |   2 +-
 ...ystem-logging-fix-auditd-startup-fai.patch |   4 +-
 ...ernel-terminal-don-t-audit-tty_devic.patch |   2 +-
 ...ystem-systemd-enable-support-for-sys.patch |   4 +-
 ...ystem-logging-allow-systemd-tmpfiles.patch |   4 +-
 ...es-system-systemd-systemd-user-fixes.patch |   8 +-
 ...ystem-logging-grant-getpcap-capabili.patch |   4 +-
 ...ystem-allow-services-to-read-tmpfs-u.patch |   8 +-
 ...ernel-domain-allow-all-domains-to-co.patch |   2 +-
 ...-allow-systemd-logind-to-inherit-fds.patch |   6 +-
 ...stemd-tmpfiles-to-read-bin_t-symlink.patch |   8 +-
 ...-systemd-networkd-and-systemd-rfkill.patch |  10 +-
 ...main-used-for-login-program-to-conne.patch |  84 ++++++++++
 ...temd-add-rules-for-systemd-ssh-issue.patch | 154 ++++++++++++++++++
 ...oadkeys-to-read-and-write-tmpfs-file.patch |  44 +++++
 ...stem-mount-make-mount_t-domain-MLS-.patch} |   6 +-
 ...les-sysadm-MLS-sysadm-rw-to-clearan.patch} |   2 +-
 ...rvices-rpc-make-nfsd_t-domain-MLS-t.patch} |   2 +-
 ...min-dmesg-make-dmesg_t-MLS-trusted-.patch} |   2 +-
 ...rnel-kernel-make-kernel_t-MLS-trust.patch} |   2 +-
 ...stem-init-make-init_t-MLS-trusted-f.patch} |   4 +-
 ...stem-systemd-make-systemd-tmpfiles_.patch} |   6 +-
 ...stem-systemd-systemd-make-systemd_-.patch} |  12 +-
 ...stem-logging-add-the-syslogd_t-to-t.patch} |   4 +-
 ...stem-init-make-init_t-MLS-trusted-f.patch} |   4 +-
 ...stem-init-all-init_t-to-read-any-le.patch} |   4 +-
 ...stem-logging-allow-auditd_t-to-writ.patch} |   4 +-
 ...rnel-kernel-make-kernel_t-MLS-trust.patch} |   2 +-
 ...stem-setrans-allow-setrans_t-use-fd.patch} |   2 +-
 ...stem-systemd-make-_systemd_t-MLS-tr.patch} |   4 +-
 ...stem-logging-make-syslogd_runtime_t.patch} |   4 +-
 .../refpolicy/refpolicy_common.inc            |  35 ++--
 recipes-security/refpolicy/refpolicy_git.inc  |   2 +-
 67 files changed, 448 insertions(+), 127 deletions(-)
 create mode 100644 recipes-security/refpolicy/refpolicy/0003-refpolicy-minimum-enable-nscd_use_shm.patch
 create mode 100644 recipes-security/refpolicy/refpolicy/0041-systemd-allow-domain-used-for-login-program-to-conne.patch
 create mode 100644 recipes-security/refpolicy/refpolicy/0042-systemd-add-rules-for-systemd-ssh-issue.patch
 create mode 100644 recipes-security/refpolicy/refpolicy/0043-loadkeys-allow-loadkeys-to-read-and-write-tmpfs-file.patch
 rename recipes-security/refpolicy/refpolicy/{0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch => 0044-policy-modules-system-mount-make-mount_t-domain-MLS-.patch} (85%)
 rename recipes-security/refpolicy/refpolicy/{0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch => 0045-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch} (95%)
 rename recipes-security/refpolicy/refpolicy/{0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch => 0046-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch} (96%)
 rename recipes-security/refpolicy/refpolicy/{0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch => 0047-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch} (94%)
 rename recipes-security/refpolicy/refpolicy/{0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch => 0048-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch} (97%)
 rename recipes-security/refpolicy/refpolicy/{0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch => 0049-policy-modules-system-init-make-init_t-MLS-trusted-f.patch} (93%)
 rename recipes-security/refpolicy/refpolicy/{0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch => 0050-policy-modules-system-systemd-make-systemd-tmpfiles_.patch} (92%)
 rename recipes-security/refpolicy/refpolicy/{0048-policy-modules-system-systemd-systemd-make-systemd_-.patch => 0051-policy-modules-system-systemd-systemd-make-systemd_-.patch} (90%)
 rename recipes-security/refpolicy/refpolicy/{0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch => 0052-policy-modules-system-logging-add-the-syslogd_t-to-t.patch} (92%)
 rename recipes-security/refpolicy/refpolicy/{0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch => 0053-policy-modules-system-init-make-init_t-MLS-trusted-f.patch} (91%)
 rename recipes-security/refpolicy/refpolicy/{0051-policy-modules-system-init-all-init_t-to-read-any-le.patch => 0054-policy-modules-system-init-all-init_t-to-read-any-le.patch} (92%)
 rename recipes-security/refpolicy/refpolicy/{0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch => 0055-policy-modules-system-logging-allow-auditd_t-to-writ.patch} (92%)
 rename recipes-security/refpolicy/refpolicy/{0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch => 0056-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch} (93%)
 rename recipes-security/refpolicy/refpolicy/{0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch => 0057-policy-modules-system-setrans-allow-setrans_t-use-fd.patch} (93%)
 rename recipes-security/refpolicy/refpolicy/{0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch => 0058-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch} (92%)
 rename recipes-security/refpolicy/refpolicy/{0056-policy-modules-system-logging-make-syslogd_runtime_t.patch => 0059-policy-modules-system-logging-make-syslogd_runtime_t.patch} (94%)

diff --git a/recipes-security/refpolicy/refpolicy-minimum_git.bb b/recipes-security/refpolicy/refpolicy-minimum_git.bb
index 011c153..9e9d1b6 100644
--- a/recipes-security/refpolicy/refpolicy-minimum_git.bb
+++ b/recipes-security/refpolicy/refpolicy-minimum_git.bb
@@ -14,6 +14,7 @@ domains are unconfined. \
 SRC_URI += " \
         file://0001-refpolicy-minimum-make-sysadmin-module-optional.patch \
         file://0002-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch \
+        file://0003-refpolicy-minimum-enable-nscd_use_shm.patch \
         "
 
 POLICY_NAME = "minimum"
diff --git a/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch b/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
index 3d84620..e25bcfb 100644
--- a/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
+++ b/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
@@ -1,4 +1,4 @@
-From e27062c7d2845b421374b390bb300f60793316b5 Mon Sep 17 00:00:00 2001
+From a39de9c57a9c36208c339bee84f95fec66f05a56 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 16:14:09 -0400
 Subject: [PATCH] fc/subs/volatile: alias common /var/volatile paths
@@ -15,7 +15,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 6 insertions(+)
 
 diff --git a/config/file_contexts.subs_dist b/config/file_contexts.subs_dist
-index ba22ce7e7..23d4328f7 100644
+index ea643ddbb..6c5aa4b91 100644
 --- a/config/file_contexts.subs_dist
 +++ b/config/file_contexts.subs_dist
 @@ -33,3 +33,9 @@
diff --git a/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch b/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch
index 4a9e963..479e946 100644
--- a/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch
+++ b/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch
@@ -1,4 +1,4 @@
-From c2203debb7315bdbb0262a29e00477f8acc4e0d1 Mon Sep 17 00:00:00 2001
+From ac2169a0b84326fe8a949c267b64decfae5734f9 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 5 Apr 2019 11:53:28 -0400
 Subject: [PATCH] refpolicy-minimum: make sysadmin module optional
@@ -22,10 +22,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 11 insertions(+), 7 deletions(-)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index c4c1a5323..956c5679d 100644
+index 15bffd9cf..9b20ff8d4 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
-@@ -677,13 +677,15 @@ ifdef(`init_systemd',`
+@@ -680,13 +680,15 @@ ifdef(`init_systemd',`
  		unconfined_write_keys(init_t)
  	')
  ',`
@@ -48,10 +48,10 @@ index c4c1a5323..956c5679d 100644
  	')
  ')
 diff --git a/policy/modules/system/locallogin.te b/policy/modules/system/locallogin.te
-index 75ee52efd..74593c55b 100644
+index 5840ad5a9..02b75e657 100644
 --- a/policy/modules/system/locallogin.te
 +++ b/policy/modules/system/locallogin.te
-@@ -285,7 +285,9 @@ userdom_use_unpriv_users_fds(sulogin_t)
+@@ -287,7 +287,9 @@ userdom_use_unpriv_users_fds(sulogin_t)
  userdom_search_user_home_dirs(sulogin_t)
  userdom_use_user_terminals(sulogin_t)
  
diff --git a/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch b/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch
index 6bcf6e0..80e8825 100644
--- a/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch
+++ b/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch
@@ -1,4 +1,4 @@
-From cc5872b91123b4bd66a906bb9f46be5410669634 Mon Sep 17 00:00:00 2001
+From 29f8b8624f931ca7366c4e0fc8bbcfb51f3fbdb1 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Wed, 19 Feb 2025 21:35:02 +0800
 Subject: [PATCH] Revert "users: Move unconfined_u definition to unconfined
@@ -32,7 +32,7 @@ index 7ec2aa471..8f0f6ac2e 100644
  	role secadm_r;
  	role auditadm_r;
 diff --git a/policy/modules/system/unconfined.te b/policy/modules/system/unconfined.te
-index 71e1b15ae..940c98ce6 100644
+index 1c98f5e85..4ef723b85 100644
 --- a/policy/modules/system/unconfined.te
 +++ b/policy/modules/system/unconfined.te
 @@ -8,9 +8,6 @@ policy_module(unconfined)
@@ -45,7 +45,7 @@ index 71e1b15ae..940c98ce6 100644
  userdom_base_user_template(unconfined)
  userdom_manage_home_role(unconfined_r, unconfined_t)
  userdom_manage_tmp_role(unconfined_r, unconfined_t)
-@@ -273,14 +270,3 @@ unconfined_domain_noaudit(unconfined_execmem_t)
+@@ -277,14 +274,3 @@ unconfined_domain_noaudit(unconfined_execmem_t)
  optional_policy(`
  	unconfined_dbus_chat(unconfined_execmem_t)
  ')
diff --git a/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch b/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
index 674f394..6374d90 100644
--- a/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
+++ b/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
@@ -1,4 +1,4 @@
-From b99da006e440106534655b2fabfa414dc4fbc899 Mon Sep 17 00:00:00 2001
+From 14fa1a78f189d092661ea78f784d032e7e517a9d Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 20:48:10 -0400
 Subject: [PATCH] fc/subs/busybox: set aliases for bin, sbin and usr
@@ -15,7 +15,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 6 insertions(+)
 
 diff --git a/config/file_contexts.subs_dist b/config/file_contexts.subs_dist
-index 23d4328f7..690007f22 100644
+index 6c5aa4b91..e782151ef 100644
 --- a/config/file_contexts.subs_dist
 +++ b/config/file_contexts.subs_dist
 @@ -39,3 +39,9 @@
diff --git a/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch b/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch
index 1dade31..807d9c5 100644
--- a/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch
+++ b/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch
@@ -1,4 +1,4 @@
-From 0a0de54c7a95e959bcf9c34dffc1fc21291d994b Mon Sep 17 00:00:00 2001
+From 326ec2353ca9e9c6c19fce4470ea8f4ff9358689 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 26 Feb 2021 09:13:23 +0800
 Subject: [PATCH] refpolicy-minimum: allow systemd-networkd to accept and
@@ -31,10 +31,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index e4f53fe66..19f8368a8 100644
+index 5649f79af..d6757ce56 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -1439,6 +1439,7 @@ allow systemd_networkd_t self:rawip_socket create_socket_perms;
+@@ -1451,6 +1451,7 @@ allow systemd_networkd_t self:rawip_socket create_socket_perms;
  allow systemd_networkd_t self:tun_socket { create_socket_perms relabelfrom relabelto };
  allow systemd_networkd_t self:udp_socket create_socket_perms;
  allow systemd_networkd_t self:unix_dgram_socket create_socket_perms;
diff --git a/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch b/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch
index fc8e0e3..68701e2 100644
--- a/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch
+++ b/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch
@@ -1,4 +1,4 @@
-From 275d9a2e0d59f27797d74e4a9b39ad8e1041b7d0 Mon Sep 17 00:00:00 2001
+From b8f6f67ea0f84d82afc1cbba5fea8388379d49db Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Mon, 20 Apr 2020 11:50:03 +0800
 Subject: [PATCH] refpolicy-targeted: make unconfined_u the default selinux
@@ -38,7 +38,7 @@ index ce614b41b..c0903d98b 100644
 +root:unconfined_u:s0-mcs_systemhigh
 +__default__:unconfined_u:s0
 diff --git a/policy/modules/system/unconfined.te b/policy/modules/system/unconfined.te
-index 940c98ce6..c8f3f9c3b 100644
+index 4ef723b85..671d38664 100644
 --- a/policy/modules/system/unconfined.te
 +++ b/policy/modules/system/unconfined.te
 @@ -20,6 +20,11 @@ type unconfined_execmem_t alias ada_t;
diff --git a/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch b/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch
index 65c7b2a..ed9bc9a 100644
--- a/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch
+++ b/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch
@@ -1,4 +1,4 @@
-From 2febe93c54945827d753bb2df9e85341d2086a36 Mon Sep 17 00:00:00 2001
+From 4f4f3ff9a92f9bd28c1894da162f852c0f2115d7 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] fc/hostname: apply policy to common yocto hostname
diff --git a/recipes-security/refpolicy/refpolicy/0003-refpolicy-minimum-enable-nscd_use_shm.patch b/recipes-security/refpolicy/refpolicy/0003-refpolicy-minimum-enable-nscd_use_shm.patch
new file mode 100644
index 0000000..3891c48
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0003-refpolicy-minimum-enable-nscd_use_shm.patch
@@ -0,0 +1,35 @@
+From ffa743901e474cf0bee243eb98701e992c278691 Mon Sep 17 00:00:00 2001
+From: Yi Zhao <yi.zhao@windriver.com>
+Date: Fri, 26 Feb 2021 09:13:23 +0800
+Subject: [PATCH] refpolicy-minimum: enable nscd_use_shm
+
+Fixes:
+avc: denied { accept } for pid=336 comm="systemd-logind"
+path="/run/systemd/io.systemd.Login"
+scontext=system_u:system_r:systemd_logind_t:s0
+tcontext=system_u:system_r:systemd_logind_t:s0 tclass=unix_stream_socket
+permissive=0
+
+Upstream-Status: Inappropriate [embedded specific]
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ policy/modules/services/nscd.te | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/policy/modules/services/nscd.te b/policy/modules/services/nscd.te
+index ffc60497c..d226f1145 100644
+--- a/policy/modules/services/nscd.te
++++ b/policy/modules/services/nscd.te
+@@ -15,7 +15,7 @@ gen_require(`
+ ##	can use nscd shared memory.
+ ##	</p>
+ ## </desc>
+-gen_tunable(nscd_use_shm, false)
++gen_tunable(nscd_use_shm, true)
+ 
+ attribute_role nscd_roles;
+ 
+-- 
+2.34.1
+
diff --git a/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch b/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch
index 2763cb0..229f088 100644
--- a/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch
+++ b/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch
@@ -1,4 +1,4 @@
-From c66bca3019b40cd6d626ec62331cc85fa459f253 Mon Sep 17 00:00:00 2001
+From 7232e98895652b4868b01298818f731108e9312d Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 21:37:32 -0400
 Subject: [PATCH] fc/bash: apply /usr/bin/bash context to /bin/bash.bash
diff --git a/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch b/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch
index 01c6801..98f6009 100644
--- a/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch
+++ b/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch
@@ -1,4 +1,4 @@
-From 62f52190b1ff3beac1b48e657484f6307b70b238 Mon Sep 17 00:00:00 2001
+From 5d6a4098da3429d5342dfcad459352778528ded2 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 4 Apr 2019 10:45:03 -0400
 Subject: [PATCH] fc/resolv.conf: label resolv.conf in var/run/ properly
diff --git a/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch b/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch
index 506055d..d4098d6 100644
--- a/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch
+++ b/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch
@@ -1,4 +1,4 @@
-From d26183bfc1fa9b9e93ac22707ef7b9b2f7df3238 Mon Sep 17 00:00:00 2001
+From bed5c307f70cc9ffb894740c19b85c8a5f36f82f Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 21:43:53 -0400
 Subject: [PATCH] fc/login: apply login context to login.shadow
@@ -12,7 +12,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/authlogin.fc b/policy/modules/system/authlogin.fc
-index 9712f0f87..b3c2f56b4 100644
+index 3f13fa9fc..6dbb7a499 100644
 --- a/policy/modules/system/authlogin.fc
 +++ b/policy/modules/system/authlogin.fc
 @@ -8,6 +8,7 @@
diff --git a/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch b/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch
index 7fef05d..6285f59 100644
--- a/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch
@@ -1,4 +1,4 @@
-From b01a876ff4dd5c8030e8239cff5278753de824a4 Mon Sep 17 00:00:00 2001
+From c701910ba2150a92c6106830ec0bc32f1b6b4fcc Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 21:59:18 -0400
 Subject: [PATCH] fc/hwclock: add hwclock alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch b/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch
index 5e384b9..fd832d7 100644
--- a/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch
@@ -1,4 +1,4 @@
-From 8f867445e1e81f99a45f2791cfee6d197e4209e1 Mon Sep 17 00:00:00 2001
+From f46f3f54f593d48d5aa8ca0162a946c181fb3f21 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 08:26:55 -0400
 Subject: [PATCH] fc/dmesg: apply policy to dmesg alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch b/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch
index 9ca2d7b..3d70b9f 100644
--- a/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch
@@ -1,4 +1,4 @@
-From e8176157e818d2afda0c92933c089616f39799c6 Mon Sep 17 00:00:00 2001
+From b2cd12e9a1fb7198234e9c2b484b6bc8fbfba603 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 09:20:58 -0400
 Subject: [PATCH] fc/ssh: apply policy to ssh alternatives
@@ -12,7 +12,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/services/ssh.fc b/policy/modules/services/ssh.fc
-index bf47884f5..8fb419ee6 100644
+index c36f27498..81314fd16 100644
 --- a/policy/modules/services/ssh.fc
 +++ b/policy/modules/services/ssh.fc
 @@ -4,6 +4,7 @@ HOME_DIR/\.ssh(/.*)?			gen_context(system_u:object_r:ssh_home_t,s0)
diff --git a/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch b/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch
index 8b55a7a..0c75537 100644
--- a/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch
+++ b/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch
@@ -1,4 +1,4 @@
-From f66c77baa8d7cae2e71421554ce9fec52a666c3a Mon Sep 17 00:00:00 2001
+From 0edf4034b28c8a0f3df743a1de9ac3bc35bc75d0 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Tue, 9 Jun 2015 21:22:52 +0530
 Subject: [PATCH] fc/sysnetwork: apply policy to network commands alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch b/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch
index 69eac13..b855dd8 100644
--- a/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch
+++ b/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch
@@ -1,4 +1,4 @@
-From 05cfce6462a9b669d0e9c19e5054eed6eaee929b Mon Sep 17 00:00:00 2001
+From 79e6c2ca52a962599490e02e1f76e6a59261e333 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 09:54:07 -0400
 Subject: [PATCH] fc/rpm: apply rpm_exec policy to cpio binaries
diff --git a/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch b/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch
index 268d066..798b2b0 100644
--- a/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch
@@ -1,4 +1,4 @@
-From ade8050fdc8c309f8b92d118687bd97f5ca794f3 Mon Sep 17 00:00:00 2001
+From 83172e73f585bbf42266026108e848753e0485e1 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 13 Feb 2014 00:33:07 -0500
 Subject: [PATCH] fc/su: apply policy to su alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch b/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
index 5cde88d..59d9aa9 100644
--- a/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
+++ b/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
@@ -1,4 +1,4 @@
-From 284638aff460da4730009afe994175ce2f4d184f Mon Sep 17 00:00:00 2001
+From 05548ffcab6580f0cae075f727cbd2c25021a338 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Mon, 27 Jan 2014 03:54:01 -0500
 Subject: [PATCH] fc/fstools: fix real path for fstools
diff --git a/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch b/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
index bc66308..de37239 100644
--- a/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
+++ b/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
@@ -1,4 +1,4 @@
-From 1e014179592a6987c0a122ab4a6ee9aa61c7fbd7 Mon Sep 17 00:00:00 2001
+From de479ed6649499a4285ed16d42597d2b9bd4c298 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] fc/init: fix update-alternatives for sysvinit
diff --git a/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch b/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch
index e059828..3cecb5f 100644
--- a/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch
@@ -1,4 +1,4 @@
-From d19a7e3c74f84b482612fc523eeea0d9d9263594 Mon Sep 17 00:00:00 2001
+From a51673edefc54d7cb3777775b524e1c3d6431929 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:19:54 +0800
 Subject: [PATCH] fc/brctl: apply policy to brctl alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch b/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch
index 972f0c1..eb75c2b 100644
--- a/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch
@@ -1,4 +1,4 @@
-From b378cd35ee983e30074f4cef81e512adc1ba8d14 Mon Sep 17 00:00:00 2001
+From 926d171dac59521991748eb2851e075e8358fd8f Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:21:51 +0800
 Subject: [PATCH] fc/corecommands: apply policy to nologin alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch b/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch
index 917dcc4..e7b6e7b 100644
--- a/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch
@@ -1,4 +1,4 @@
-From fac8b484bd3b5cd3d1283a2ae04317f6e6d89bac Mon Sep 17 00:00:00 2001
+From 312ddcf6bb20184a7447370caa53c0f4e255449e Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:43:28 +0800
 Subject: [PATCH] fc/locallogin: apply policy to sulogin alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch b/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch
index 4143b49..fa5e135 100644
--- a/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch
@@ -1,4 +1,4 @@
-From 25ede8d1c8ac8618d10130957bfd9ca7029f7f88 Mon Sep 17 00:00:00 2001
+From 8930c1ed42ab41a0912597afa9058d7936524de1 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:45:23 +0800
 Subject: [PATCH] fc/ntp: apply policy to ntpd alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch b/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
index 9e88c22..9ae8e7a 100644
--- a/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
@@ -1,4 +1,4 @@
-From 0707b5c142915d994b8cbc08d4d9659697c40ed7 Mon Sep 17 00:00:00 2001
+From d7c1c2da20cb461f020a3776bea4a452c72438c0 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:55:05 +0800
 Subject: [PATCH] fc/kerberos: apply policy to kerberos alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch b/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch
index 5c62515..03006a6 100644
--- a/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch
@@ -1,4 +1,4 @@
-From adec1632a9c7d8f80d2f353c5d69cfba429d5e2e Mon Sep 17 00:00:00 2001
+From 48d2ceb21e16c58a2cdb1df256afee24b3de3704 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 11:06:13 +0800
 Subject: [PATCH] fc/ldap: apply policy to ldap alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch b/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch
index 1408ab4..8c342d8 100644
--- a/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch
+++ b/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch
@@ -1,4 +1,4 @@
-From a6057afaeedbc4ed148f3554746aeecc6ee31e3a Mon Sep 17 00:00:00 2001
+From 0f9dd967bb5ce4386a05dcecc0f13f3e1d5fdff4 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 11:13:16 +0800
 Subject: [PATCH] fc/postgresql: apply policy to postgresql alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0022-fc-usermanage-apply-policy-to-usermanage-alternative.patch b/recipes-security/refpolicy/refpolicy/0022-fc-usermanage-apply-policy-to-usermanage-alternative.patch
index 8c2b6da..fbe8af3 100644
--- a/recipes-security/refpolicy/refpolicy/0022-fc-usermanage-apply-policy-to-usermanage-alternative.patch
+++ b/recipes-security/refpolicy/refpolicy/0022-fc-usermanage-apply-policy-to-usermanage-alternative.patch
@@ -1,4 +1,4 @@
-From 94b6c8baa19eb3ac8eda4a9b4151dc3c69e432fc Mon Sep 17 00:00:00 2001
+From c1f003d0f2e2c8e47a1fcba20dd43ccfe7454d62 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 11:25:34 +0800
 Subject: [PATCH] fc/usermanage: apply policy to usermanage alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch b/recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch
index e1a0eac..2ae4f3e 100644
--- a/recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch
+++ b/recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch
@@ -1,4 +1,4 @@
-From f112cd85a2121fe84a4ace6b781dad5dc77ba5fe Mon Sep 17 00:00:00 2001
+From cb5ddf5aabd5dc922535fc18f653a19f4ae9072e Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 16:07:30 +0800
 Subject: [PATCH] fc/getty: add file context to start_getty
diff --git a/recipes-security/refpolicy/refpolicy/0024-fc-vlock-apply-policy-to-vlock-alternatives.patch b/recipes-security/refpolicy/refpolicy/0024-fc-vlock-apply-policy-to-vlock-alternatives.patch
index 3239ce8..cf61944 100644
--- a/recipes-security/refpolicy/refpolicy/0024-fc-vlock-apply-policy-to-vlock-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0024-fc-vlock-apply-policy-to-vlock-alternatives.patch
@@ -1,4 +1,4 @@
-From 677a140a33f4abc1ef7a2baef768d50485180595 Mon Sep 17 00:00:00 2001
+From 17cd37d1b009440f5385e1f726feaf2f674a2948 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Wed, 18 Dec 2019 15:04:41 +0800
 Subject: [PATCH] fc/vlock: apply policy to vlock alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0025-fc-add-fcontext-for-init-scripts-and-systemd-service.patch b/recipes-security/refpolicy/refpolicy/0025-fc-add-fcontext-for-init-scripts-and-systemd-service.patch
index 3c0b031..d383a8c 100644
--- a/recipes-security/refpolicy/refpolicy/0025-fc-add-fcontext-for-init-scripts-and-systemd-service.patch
+++ b/recipes-security/refpolicy/refpolicy/0025-fc-add-fcontext-for-init-scripts-and-systemd-service.patch
@@ -1,4 +1,4 @@
-From 4a1c5f7649d960a1a5456f84da1fcc88d992b155 Mon Sep 17 00:00:00 2001
+From a6fe56e388b96cfb80a2ad3123943a97c98a803b Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 30 Jun 2020 10:45:57 +0800
 Subject: [PATCH] fc: add fcontext for init scripts and systemd service files
diff --git a/recipes-security/refpolicy/refpolicy/0026-file_contexts.subs_dist-set-aliase-for-root-director.patch b/recipes-security/refpolicy/refpolicy/0026-file_contexts.subs_dist-set-aliase-for-root-director.patch
index 8c785e0..bb569d3 100644
--- a/recipes-security/refpolicy/refpolicy/0026-file_contexts.subs_dist-set-aliase-for-root-director.patch
+++ b/recipes-security/refpolicy/refpolicy/0026-file_contexts.subs_dist-set-aliase-for-root-director.patch
@@ -1,4 +1,4 @@
-From 709df66b11b654fd15fcaa6c0ac5e39bedadde51 Mon Sep 17 00:00:00 2001
+From 381f265836e71cba20399a049145a29f7fa24cbf Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Sun, 5 Apr 2020 22:03:45 +0800
 Subject: [PATCH] file_contexts.subs_dist: set aliase for /root directory
@@ -14,7 +14,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 4 insertions(+)
 
 diff --git a/config/file_contexts.subs_dist b/config/file_contexts.subs_dist
-index 690007f22..f80499ebf 100644
+index e782151ef..8aaf36858 100644
 --- a/config/file_contexts.subs_dist
 +++ b/config/file_contexts.subs_dist
 @@ -45,3 +45,7 @@
diff --git a/recipes-security/refpolicy/refpolicy/0027-policy-modules-system-logging-add-rules-for-the-syml.patch b/recipes-security/refpolicy/refpolicy/0027-policy-modules-system-logging-add-rules-for-the-syml.patch
index 7d3b042..b6dde9f 100644
--- a/recipes-security/refpolicy/refpolicy/0027-policy-modules-system-logging-add-rules-for-the-syml.patch
+++ b/recipes-security/refpolicy/refpolicy/0027-policy-modules-system-logging-add-rules-for-the-syml.patch
@@ -1,4 +1,4 @@
-From 17aa22ea4681d38fe7a90c0a3a0a9b2181bd7f0b Mon Sep 17 00:00:00 2001
+From d8507fdc01e182a99daf7dcfecf76214d3bc427a Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/system/logging: add rules for the symlink of
diff --git a/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-syslogd-.patch b/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-syslogd-.patch
index 90b95d4..74c8192 100644
--- a/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-syslogd-.patch
+++ b/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-syslogd-.patch
@@ -1,4 +1,4 @@
-From bd0c6361b144e638039830a3a2eff4b05c36add6 Mon Sep 17 00:00:00 2001
+From 008e62832b0d0934dc1cc1f92c67af113670fd6e Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 10:33:18 -0400
 Subject: [PATCH] policy/modules/system/logging: add rules for syslogd symlink
@@ -18,7 +18,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index a2f35f278..11a0fad46 100644
+index 0ba5d3d8b..d8621f9e1 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -429,6 +429,7 @@ files_search_spool(syslogd_t)
diff --git a/recipes-security/refpolicy/refpolicy/0029-policy-modules-kernel-files-add-rules-for-the-symlin.patch b/recipes-security/refpolicy/refpolicy/0029-policy-modules-kernel-files-add-rules-for-the-symlin.patch
index 7570ed8..29ed8e9 100644
--- a/recipes-security/refpolicy/refpolicy/0029-policy-modules-kernel-files-add-rules-for-the-symlin.patch
+++ b/recipes-security/refpolicy/refpolicy/0029-policy-modules-kernel-files-add-rules-for-the-symlin.patch
@@ -1,4 +1,4 @@
-From 87b66b35c6bebc4fe807f7d4020519df10af483f Mon Sep 17 00:00:00 2001
+From be837d1c31af1d5ca86388309fe2b1e831ab2bcd Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/kernel/files: add rules for the symlink of
diff --git a/recipes-security/refpolicy/refpolicy/0030-policy-modules-system-logging-fix-auditd-startup-fai.patch b/recipes-security/refpolicy/refpolicy/0030-policy-modules-system-logging-fix-auditd-startup-fai.patch
index 34e224e..461eab3 100644
--- a/recipes-security/refpolicy/refpolicy/0030-policy-modules-system-logging-fix-auditd-startup-fai.patch
+++ b/recipes-security/refpolicy/refpolicy/0030-policy-modules-system-logging-fix-auditd-startup-fai.patch
@@ -1,4 +1,4 @@
-From a6cffb4673b5ea372f7aa0679e8d89cd97018d85 Mon Sep 17 00:00:00 2001
+From e7712a6ce377702e74e43ea65e0bcbb542e6d2d7 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/system/logging: fix auditd startup failures
@@ -17,7 +17,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 11a0fad46..a1e4a5b8d 100644
+index d8621f9e1..cbef358c2 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -120,6 +120,7 @@ allow auditctl_t auditd_log_t:file read_file_perms;
diff --git a/recipes-security/refpolicy/refpolicy/0031-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch b/recipes-security/refpolicy/refpolicy/0031-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch
index da62522..426dbdd 100644
--- a/recipes-security/refpolicy/refpolicy/0031-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch
+++ b/recipes-security/refpolicy/refpolicy/0031-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch
@@ -1,4 +1,4 @@
-From fc37036aa30e58b4d9c75cbb412d6371212765b3 Mon Sep 17 00:00:00 2001
+From 093bca5e24d0ffb9af76ac20bcbb990a1ca3396f Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/kernel/terminal: don't audit tty_device_t in
diff --git a/recipes-security/refpolicy/refpolicy/0032-policy-modules-system-systemd-enable-support-for-sys.patch b/recipes-security/refpolicy/refpolicy/0032-policy-modules-system-systemd-enable-support-for-sys.patch
index cbbe755..0aa68e5 100644
--- a/recipes-security/refpolicy/refpolicy/0032-policy-modules-system-systemd-enable-support-for-sys.patch
+++ b/recipes-security/refpolicy/refpolicy/0032-policy-modules-system-systemd-enable-support-for-sys.patch
@@ -1,4 +1,4 @@
-From cbf27ba4d70fdb9c4877929789311d3b25d7837f Mon Sep 17 00:00:00 2001
+From 5469b578bb206e87b47018b83d6edccfa4c9ae74 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 4 Feb 2016 06:03:19 -0500
 Subject: [PATCH] policy/modules/system/systemd: enable support for
@@ -29,7 +29,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index 4188c9547..cbc72d6a9 100644
+index 4c8158470..255b8a3f0 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
 @@ -10,7 +10,7 @@ policy_module(systemd)
diff --git a/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-logging-allow-systemd-tmpfiles.patch b/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-logging-allow-systemd-tmpfiles.patch
index aba8479..b5c9a26 100644
--- a/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-logging-allow-systemd-tmpfiles.patch
+++ b/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-logging-allow-systemd-tmpfiles.patch
@@ -1,4 +1,4 @@
-From 70e8a8c6468a279b8ae38ff4a681255d05439c0a Mon Sep 17 00:00:00 2001
+From 35ebaa07e3f3753f2241bed429619171250cf3cb Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Sat, 30 Sep 2023 17:20:29 +0800
 Subject: [PATCH] policy/modules/system/logging: allow systemd-tmpfiles to
@@ -24,7 +24,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 4 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index a1e4a5b8d..97b86b2a7 100644
+index cbef358c2..d22a3207c 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -27,6 +27,10 @@ type auditd_log_t;
diff --git a/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-systemd-systemd-user-fixes.patch b/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-systemd-systemd-user-fixes.patch
index bd88d11..6dc728b 100644
--- a/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-systemd-systemd-user-fixes.patch
+++ b/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-systemd-systemd-user-fixes.patch
@@ -1,4 +1,4 @@
-From 39b06488ae85aba2442f3eac2eb42b91edf5f285 Mon Sep 17 00:00:00 2001
+From b4ecc51a6137596917a82cec694d09f19c637279 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 4 Feb 2021 10:48:54 +0800
 Subject: [PATCH] policy/modules/system/systemd: systemd --user fixes
@@ -31,7 +31,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 35 insertions(+)
 
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index db6bd9752..64d83367d 100644
+index 809fde402..1955f5409 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
 @@ -267,6 +267,37 @@ template(`systemd_role_template',`
@@ -73,10 +73,10 @@ index db6bd9752..64d83367d 100644
  ## <summary>
  ##   Allow the specified domain to be started as a daemon by the
 diff --git a/policy/modules/system/userdomain.if b/policy/modules/system/userdomain.if
-index 0be775e9e..efa65779a 100644
+index 10b085d41..b751f7de0 100644
 --- a/policy/modules/system/userdomain.if
 +++ b/policy/modules/system/userdomain.if
-@@ -1480,6 +1480,10 @@ template(`userdom_admin_user_template',`
+@@ -1479,6 +1479,10 @@ template(`userdom_admin_user_template',`
  	optional_policy(`
  		userhelper_exec($1_t)
  	')
diff --git a/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-logging-grant-getpcap-capabili.patch b/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-logging-grant-getpcap-capabili.patch
index 496010b..a75c484 100644
--- a/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-logging-grant-getpcap-capabili.patch
+++ b/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-logging-grant-getpcap-capabili.patch
@@ -1,4 +1,4 @@
-From d167a78e361bfd81bdda18692ef0e66a3921cc74 Mon Sep 17 00:00:00 2001
+From 2bc30a7c5b62e3f28fe5315ccad684a7e06901d8 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 28 May 2024 11:21:48 +0800
 Subject: [PATCH] policy/modules/system/logging: grant getpcap capability to
@@ -21,7 +21,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 97b86b2a7..45ed81867 100644
+index d22a3207c..b1d9c20d2 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -406,6 +406,8 @@ optional_policy(`
diff --git a/recipes-security/refpolicy/refpolicy/0036-policy-modules-system-allow-services-to-read-tmpfs-u.patch b/recipes-security/refpolicy/refpolicy/0036-policy-modules-system-allow-services-to-read-tmpfs-u.patch
index bab51dd..0e0572c 100644
--- a/recipes-security/refpolicy/refpolicy/0036-policy-modules-system-allow-services-to-read-tmpfs-u.patch
+++ b/recipes-security/refpolicy/refpolicy/0036-policy-modules-system-allow-services-to-read-tmpfs-u.patch
@@ -1,4 +1,4 @@
-From ea19bb6f4c7d130f0b2d2c025b6359a5a7f82c83 Mon Sep 17 00:00:00 2001
+From cb4227b896ad8b0b09f95fbfc6600316d787f975 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 30 Aug 2024 12:39:48 +0800
 Subject: [PATCH] policy/modules/system: allow services to read tmpfs under
@@ -67,7 +67,7 @@ index a900226bf..75b94785b 100644
  mcs_process_set_categories(getty_t)
  
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 45ed81867..a3afe5525 100644
+index b1d9c20d2..69b3405b3 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -495,6 +495,7 @@ files_read_kernel_symbol_table(syslogd_t)
@@ -79,10 +79,10 @@ index 45ed81867..a3afe5525 100644
  
  mls_file_write_all_levels(syslogd_t) # Need to be able to write to /var/run/ and /var/log directories
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index cbc72d6a9..cbae29894 100644
+index 255b8a3f0..b9af00ec8 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -1467,6 +1467,7 @@ files_watch_root_dirs(systemd_networkd_t)
+@@ -1471,6 +1471,7 @@ files_watch_root_dirs(systemd_networkd_t)
  files_list_runtime(systemd_networkd_t)
  
  fs_getattr_all_fs(systemd_networkd_t)
diff --git a/recipes-security/refpolicy/refpolicy/0037-policy-modules-kernel-domain-allow-all-domains-to-co.patch b/recipes-security/refpolicy/refpolicy/0037-policy-modules-kernel-domain-allow-all-domains-to-co.patch
index 605ed6c..5f41215 100644
--- a/recipes-security/refpolicy/refpolicy/0037-policy-modules-kernel-domain-allow-all-domains-to-co.patch
+++ b/recipes-security/refpolicy/refpolicy/0037-policy-modules-kernel-domain-allow-all-domains-to-co.patch
@@ -1,4 +1,4 @@
-From 003ae9b4e2e4049a62745634a83ad3f95d2a7e9e Mon Sep 17 00:00:00 2001
+From 7cc66d57b1898201881a997be036148e02ec85d4 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 3 Oct 2024 21:12:33 +0800
 Subject: [PATCH] policy/modules/kernel/domain: allow all domains to connect to
diff --git a/recipes-security/refpolicy/refpolicy/0038-systemd-allow-systemd-logind-to-inherit-fds.patch b/recipes-security/refpolicy/refpolicy/0038-systemd-allow-systemd-logind-to-inherit-fds.patch
index 7661870..dac7e23 100644
--- a/recipes-security/refpolicy/refpolicy/0038-systemd-allow-systemd-logind-to-inherit-fds.patch
+++ b/recipes-security/refpolicy/refpolicy/0038-systemd-allow-systemd-logind-to-inherit-fds.patch
@@ -1,4 +1,4 @@
-From ec677f6cd1fd050e5f558aec6101296769d6bcee Mon Sep 17 00:00:00 2001
+From 452bdb9814a17292e134a52cffde82c6498e5ce9 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 18 Feb 2025 09:54:06 +0800
 Subject: [PATCH] systemd: allow systemd-logind to inherit fds
@@ -35,10 +35,10 @@ index ebb7ef0e0..0398ce6fd 100644
  		allow $3 $1_su_t:process signal;
  
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index 64d83367d..e6aa112c0 100644
+index 1955f5409..0d9ff59e2 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
-@@ -1501,6 +1501,24 @@ interface(`systemd_use_logind_fds',`
+@@ -1581,6 +1581,24 @@ interface(`systemd_use_logind_fds',`
  	allow $1 systemd_logind_t:fd use;
  ')
  
diff --git a/recipes-security/refpolicy/refpolicy/0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch b/recipes-security/refpolicy/refpolicy/0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
index c615c81..c5056dc 100644
--- a/recipes-security/refpolicy/refpolicy/0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
+++ b/recipes-security/refpolicy/refpolicy/0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
@@ -1,4 +1,4 @@
-From ed34e4e062a23f11708c023b2daba4b83b74e23e Mon Sep 17 00:00:00 2001
+From 9b66066808cd5ad944b835429109ca121e4b1ba9 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 18 Feb 2025 15:26:19 +0800
 Subject: [PATCH] systemd: allow systemd-tmpfiles to read bin_t symlink
@@ -61,7 +61,7 @@ index 08ed91f19..0fa4cbf7d 100644
 +	read_lnk_files_pattern($1, bin_t, bin_t)
 +')
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index e6aa112c0..3f3426ebd 100644
+index 0d9ff59e2..da6a30470 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
 @@ -155,6 +155,7 @@ template(`systemd_role_template',`
@@ -73,10 +73,10 @@ index e6aa112c0..3f3426ebd 100644
  	domtrans_pattern($1_systemd_t, systemd_tmpfiles_exec_t, $1_systemd_tmpfiles_t)
  	read_files_pattern($1_systemd_t, $1_systemd_tmpfiles_t, $1_systemd_tmpfiles_t)
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index cbae29894..7e39556b7 100644
+index b9af00ec8..e79dec101 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -2142,6 +2142,9 @@ kernel_getattr_proc(systemd_tmpfiles_t)
+@@ -2148,6 +2148,9 @@ kernel_getattr_proc(systemd_tmpfiles_t)
  kernel_read_kernel_sysctls(systemd_tmpfiles_t)
  kernel_read_network_state(systemd_tmpfiles_t)
  
diff --git a/recipes-security/refpolicy/refpolicy/0040-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch b/recipes-security/refpolicy/refpolicy/0040-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch
index 6113588..cab8a59 100644
--- a/recipes-security/refpolicy/refpolicy/0040-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch
+++ b/recipes-security/refpolicy/refpolicy/0040-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch
@@ -1,4 +1,4 @@
-From 7049caea5b0a37084d144c37212f6da57b16e7df Mon Sep 17 00:00:00 2001
+From df0dbe05f43c56eaaebb36a013eef15987f3f6f0 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 26 Sep 2025 15:15:44 +0800
 Subject: [PATCH] systemd: fix for systemd-networkd and systemd-rfkill
@@ -35,10 +35,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 5 insertions(+), 1 deletion(-)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index 7e39556b7..adcd931b7 100644
+index e79dec101..b4afcab57 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -1419,7 +1419,7 @@ systemd_log_parse_environment(systemd_modules_load_t)
+@@ -1423,7 +1423,7 @@ systemd_log_parse_environment(systemd_modules_load_t)
  # networkd local policy
  #
  
@@ -47,7 +47,7 @@ index 7e39556b7..adcd931b7 100644
  allow systemd_networkd_t self:netlink_generic_socket create_socket_perms;
  allow systemd_networkd_t self:netlink_kobject_uevent_socket create_socket_perms;
  allow systemd_networkd_t self:netlink_netfilter_socket create_socket_perms;
-@@ -1459,12 +1459,15 @@ corenet_udp_bind_generic_node(systemd_networkd_t)
+@@ -1463,12 +1463,15 @@ corenet_udp_bind_generic_node(systemd_networkd_t)
  dev_read_urand(systemd_networkd_t)
  dev_read_sysfs(systemd_networkd_t)
  dev_write_kmsg(systemd_networkd_t)
@@ -63,7 +63,7 @@ index 7e39556b7..adcd931b7 100644
  
  fs_getattr_all_fs(systemd_networkd_t)
  fs_list_tmpfs(systemd_networkd_t)
-@@ -1893,6 +1896,7 @@ logging_send_syslog_msg(systemd_pstore_t)
+@@ -1899,6 +1902,7 @@ logging_send_syslog_msg(systemd_pstore_t)
  # Rfkill local policy
  #
  
diff --git a/recipes-security/refpolicy/refpolicy/0041-systemd-allow-domain-used-for-login-program-to-conne.patch b/recipes-security/refpolicy/refpolicy/0041-systemd-allow-domain-used-for-login-program-to-conne.patch
new file mode 100644
index 0000000..ebcd94b
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0041-systemd-allow-domain-used-for-login-program-to-conne.patch
@@ -0,0 +1,84 @@
+From c6aff0f0faef36db16e0a8543fe290f6c3a04ec0 Mon Sep 17 00:00:00 2001
+From: Yi Zhao <yi.zhao@windriver.com>
+Date: Fri, 6 Feb 2026 22:13:03 +0800
+Subject: [PATCH] systemd: allow domain used for login program to connect to
+ systemd-logind over unix socket
+
+Fix the following AVC denials:
+avc: denied { write } for pid=392 comm="login" name="io.systemd.Login"
+dev="tmpfs" ino=849 scontext=system_u:system_r:local_login_t
+tcontext=system_u:object_r:init_runtime_t tclass=sock_file permissive=1
+
+avc: denied  { connectto } for pid=392 comm="login"
+path="/run/systemd/io.systemd.Login"
+scontext=system_u:system_r:local_login_t
+tcontext=system_u:system_r:systemd_logind_t tclass=unix_stream_socket
+permissive=1
+
+Upstream-Status: Pending
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ policy/modules/system/authlogin.if |  1 +
+ policy/modules/system/systemd.fc   |  1 +
+ policy/modules/system/systemd.if   | 20 ++++++++++++++++++++
+ 3 files changed, 22 insertions(+)
+
+diff --git a/policy/modules/system/authlogin.if b/policy/modules/system/authlogin.if
+index bb282024c..db8fd8e39 100644
+--- a/policy/modules/system/authlogin.if
++++ b/policy/modules/system/authlogin.if
+@@ -227,6 +227,7 @@ interface(`auth_login_pgm_domain',`
+ 		systemd_read_logind_state($1)
+ 		systemd_write_inherited_logind_sessions_pipes($1)
+ 		systemd_use_passwd_agent_fds($1)
++		systemd_connectto_logind_sockets($1)
+ 	')
+ ')
+ 
+diff --git a/policy/modules/system/systemd.fc b/policy/modules/system/systemd.fc
+index 505a054ff..e44d82a88 100644
+--- a/policy/modules/system/systemd.fc
++++ b/policy/modules/system/systemd.fc
+@@ -127,6 +127,7 @@ HOME_ROOT/.+\.home	--	gen_context(system_u:object_r:systemd_homed_storage_t,s0)
+ /run/systemd/netif(/.*)?	gen_context(system_u:object_r:systemd_networkd_runtime_t,s0)
+ /run/systemd/nsresource(/.*)?	gen_context(system_u:object_r:systemd_nsresourced_runtime_t,s0)
+ /run/systemd/io\.systemd\.NamespaceResource	-s	gen_context(system_u:object_r:systemd_nsresourced_runtime_t,s0)
++/run/systemd/io\.systemd\.Login	-s	gen_context(system_u:object_r:systemd_logind_runtime_t,s0)
+ 
+ /run/tmpfiles\.d	-d	gen_context(system_u:object_r:systemd_tmpfiles_conf_t,s0)
+ /run/tmpfiles\.d/.*		<<none>>
+diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
+index da6a30470..e184b1d77 100644
+--- a/policy/modules/system/systemd.if
++++ b/policy/modules/system/systemd.if
+@@ -1600,6 +1600,26 @@ interface(`systemd_inherit_logind_fds',`
+ 	allow systemd_logind_t $1:fd use;
+ ')
+ 
++######################################
++## <summary>
++##  Allow domain to connect to systemd
++##  logind sockets.
++## </summary>
++## <param name="domain">
++##	<summary>
++##	Domain allowed access.
++##	</summary>
++## </param>
++#
++interface(`systemd_connectto_logind_sockets',`
++	gen_require(`
++		type systemd_logind_runtime_t, systemd_logind_t;
++	')
++
++	allow $1 systemd_logind_runtime_t:sock_file write;
++	allow $1 systemd_logind_t:unix_stream_socket connectto;
++')
++
+ ######################################
+ ## <summary>
+ ##      Watch logind sessions dirs.
+-- 
+2.34.1
+
diff --git a/recipes-security/refpolicy/refpolicy/0042-systemd-add-rules-for-systemd-ssh-issue.patch b/recipes-security/refpolicy/refpolicy/0042-systemd-add-rules-for-systemd-ssh-issue.patch
new file mode 100644
index 0000000..2219370
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0042-systemd-add-rules-for-systemd-ssh-issue.patch
@@ -0,0 +1,154 @@
+From a3d7fd9877c235c6a9e06187a48bcb9a1376b20e Mon Sep 17 00:00:00 2001
+From: Yi Zhao <yi.zhao@windriver.com>
+Date: Mon, 9 Feb 2026 15:42:19 +0800
+Subject: [PATCH] systemd: add rules for systemd-ssh-issue
+
+systemd-ssh-issue was added in systemd v258. It is a small tool that
+generates a /run/issue.d/50-ssh-vsock.issue drop-in file in case
+AF_VSOCK support is available in the kernel and the VM environment.
+
+Add rules for it and allow getty to read files in /run/issue.d.
+
+Fixes:
+avc: denied { getattr } for pid=391 comm="agetty" path="/run/issue.d"
+dev="tmpfs" ino=846 scontext=system_u:system_r:getty_t
+tcontext=system_u:object_r:initrc_runtime_t tclass=dir permissive=1
+
+avc: denied { read } for pid=391 comm="agetty" name="issue.d"
+dev="tmpfs" ino=846 scontext=system_u:system_r:getty_t
+tcontext=system_u:object_r:initrc_runtime_t tclass=dir permissive=1
+
+avc: denied { open } for pid=391 comm="agetty" path="/run/issue.d"
+dev="tmpfs" ino=846 scontext=system_u:system_r:getty_t
+tcontext=system_u:object_r:initrc_runtime_t tclass=dir permissive=1
+
+Upstream-Status: Pending
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ policy/modules/system/getty.te   |  5 +++++
+ policy/modules/system/systemd.fc |  3 +++
+ policy/modules/system/systemd.if | 19 +++++++++++++++++
+ policy/modules/system/systemd.te | 35 ++++++++++++++++++++++++++++++++
+ 4 files changed, 62 insertions(+)
+
+diff --git a/policy/modules/system/getty.te b/policy/modules/system/getty.te
+index 75b94785b..48a29461a 100644
+--- a/policy/modules/system/getty.te
++++ b/policy/modules/system/getty.te
+@@ -100,6 +100,11 @@ logging_send_syslog_msg(getty_t)
+ 
+ miscfiles_read_localization(getty_t)
+ 
++ifdef(`init_systemd',`
++	# access to /run/issue.d/50-ssh-vsock.issue
++	systemd_read_ssh_issue_runtime(getty_t)
++')
++
+ ifdef(`distro_gentoo',`
+ 	# Gentoo default /etc/issue makes agetty
+ 	# do a DNS lookup for the hostname
+diff --git a/policy/modules/system/systemd.fc b/policy/modules/system/systemd.fc
+index e44d82a88..130c62370 100644
+--- a/policy/modules/system/systemd.fc
++++ b/policy/modules/system/systemd.fc
+@@ -49,6 +49,7 @@
+ /usr/lib/systemd/systemd-resolved	--	gen_context(system_u:object_r:systemd_resolved_exec_t,s0)
+ /usr/lib/systemd/systemd-rfkill		--	gen_context(system_u:object_r:systemd_rfkill_exec_t,s0)
+ /usr/lib/systemd/systemd-socket-proxyd	--	gen_context(system_u:object_r:systemd_socket_proxyd_exec_t,s0)
++/usr/lib/systemd/systemd-ssh-issue --  gen_context(system_u:object_r:systemd_ssh_issue_exec_t,s0)
+ /usr/lib/systemd/systemd-sysctl		--	gen_context(system_u:object_r:systemd_sysctl_exec_t,s0)
+ /usr/lib/systemd/systemd-tpm2-setup		--	gen_context(system_u:object_r:systemd_pcrphase_exec_t,s0)
+ /usr/lib/systemd/systemd-update-done	--	gen_context(system_u:object_r:systemd_update_done_exec_t,s0)
+@@ -99,6 +100,8 @@ HOME_ROOT/.+\.home	--	gen_context(system_u:object_r:systemd_homed_storage_t,s0)
+ /var/lib/systemd/pstore(/.*)?	gen_context(system_u:object_r:systemd_pstore_var_lib_t,s0)
+ /var/lib/systemd/rfkill(/.*)?	gen_context(system_u:object_r:systemd_rfkill_var_lib_t,s0)
+ 
++/run/issue.d(/.*)? gen_context(system_u:object_r:systemd_ssh_issue_runtime_t,s0)
++
+ /run/\.nologin[^/]*	--	gen_context(system_u:object_r:systemd_sessions_runtime_t,s0)
+ /run/nologin	--	gen_context(system_u:object_r:systemd_sessions_runtime_t,s0)
+ 
+diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
+index e184b1d77..c9c841a2a 100644
+--- a/policy/modules/system/systemd.if
++++ b/policy/modules/system/systemd.if
+@@ -3211,3 +3211,22 @@ interface(`systemd_use_inherited_machined_ptys', `
+ 	allow $1 systemd_machined_t:fd use;
+ 	allow $1 systemd_machined_devpts_t:chr_file rw_inherited_term_perms;
+ ')
++
++########################################
++## <summary>
++##  Allow domain to read files in /run/issue.d
++## </summary>
++## <param name="domain">
++##  <summary>
++##  Domain allowed access.
++##  </summary>
++## </param>
++#
++interface(`systemd_read_ssh_issue_runtime',`
++	gen_require(`
++		type systemd_ssh_issue_runtime_t;
++	')
++
++	list_dirs_pattern($1, systemd_ssh_issue_runtime_t, systemd_ssh_issue_runtime_t)
++	read_files_pattern($1, systemd_ssh_issue_runtime_t, systemd_ssh_issue_runtime_t)
++')
+diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
+index b4afcab57..11a206fd0 100644
+--- a/policy/modules/system/systemd.te
++++ b/policy/modules/system/systemd.te
+@@ -306,6 +306,14 @@ corenet_port(systemd_socket_proxyd_port_t)
+ type systemd_socket_proxyd_unit_file_t;
+ init_unit_file(systemd_socket_proxyd_unit_file_t)
+ 
++type systemd_ssh_issue_t;
++type systemd_ssh_issue_exec_t;
++init_daemon_domain(systemd_ssh_issue_t, systemd_ssh_issue_exec_t)
++
++type systemd_ssh_issue_runtime_t;
++files_runtime_file(systemd_ssh_issue_runtime_t)
++init_daemon_runtime_file(systemd_ssh_issue_runtime_t, dir, "issue.d")
++
+ type systemd_sysctl_t;
+ type systemd_sysctl_exec_t;
+ init_daemon_domain(systemd_sysctl_t, systemd_sysctl_exec_t)
+@@ -2071,6 +2079,33 @@ fs_getattr_nsfs_files(systemd_sysctl_t)
+ 
+ systemd_log_parse_environment(systemd_sysctl_t)
+ 
++
++#########################################
++#
++# systemd-ssh-issue local policy
++#
++
++allow systemd_ssh_issue_t self:capability net_admin;
++allow systemd_ssh_issue_t self:unix_dgram_socket { connect create getopt setopt };
++allow systemd_ssh_issue_t self:vsock_socket create_socket_perms;
++
++dev_read_sysfs(systemd_ssh_issue_t)
++dev_read_vsock(systemd_ssh_issue_t)
++
++fs_getattr_nsfs_files(systemd_ssh_issue_t)
++
++init_read_state(systemd_ssh_issue_t)
++
++kernel_getattr_proc(systemd_ssh_issue_t)
++kernel_read_kernel_sysctls(systemd_ssh_issue_t)
++kernel_read_system_state(systemd_ssh_issue_t)
++
++logging_send_syslog_msg(systemd_ssh_issue_t)
++
++manage_dirs_pattern(systemd_ssh_issue_t, systemd_ssh_issue_runtime_t, systemd_ssh_issue_runtime_t)
++manage_files_pattern(systemd_ssh_issue_t, systemd_ssh_issue_runtime_t, systemd_ssh_issue_runtime_t)
++files_runtime_filetrans(systemd_ssh_issue_t, systemd_ssh_issue_runtime_t, { dir file })
++
+ #########################################
+ #
+ # Sysusers local policy
+-- 
+2.34.1
+
diff --git a/recipes-security/refpolicy/refpolicy/0043-loadkeys-allow-loadkeys-to-read-and-write-tmpfs-file.patch b/recipes-security/refpolicy/refpolicy/0043-loadkeys-allow-loadkeys-to-read-and-write-tmpfs-file.patch
new file mode 100644
index 0000000..196d207
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0043-loadkeys-allow-loadkeys-to-read-and-write-tmpfs-file.patch
@@ -0,0 +1,44 @@
+From 21701211712c9cc68ec78e11e65584dff00810ac Mon Sep 17 00:00:00 2001
+From: Yi Zhao <yi.zhao@windriver.com>
+Date: Mon, 9 Feb 2026 16:20:57 +0800
+Subject: [PATCH] loadkeys: allow loadkeys to read and write tmpfs files
+
+Fixes:
+avc: denied { write } for pid=270 comm="loadkeys"
+path=2F6D656D66643A2F7573722F73686172652F6B65796D6170732F693338362F7177657274792F75732E6D61702E677A202864656C6574656429
+dev="tmpfs" ino=5 scontext=system_u:system_r:loadkeys_t
+tcontext=system_u:object_r:tmpfs_t tclass=file permissive=1
+
+avc: denied { getattr } for pid=270 comm="loadkeys"
+path=2F6D656D66643A2F7573722F73686172652F6B65796D6170732F693338362F7177657274792F75732E6D61702E677A202864656C6574656429
+dev="tmpfs" ino=5 scontext=system_u:system_r:loadkeys_t
+tcontext=system_u:object_r:tmpfs_t tclass=file permissive=1
+
+avc: denied { read } for pid=270 comm="loadkeys"
+path=2F6D656D66643A2F7573722F73686172652F6B65796D6170732F693338362F7177657274792F75732E6D61702E677A202864656C6574656429
+dev="tmpfs" ino=5 scontext=system_u:system_r:loadkeys_t
+tcontext=system_u:object_r:tmpfs_t tclass=file permissive=1
+
+Upstream-Status: Pending
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ policy/modules/apps/loadkeys.te | 2 ++
+ 1 file changed, 2 insertions(+)
+
+diff --git a/policy/modules/apps/loadkeys.te b/policy/modules/apps/loadkeys.te
+index 56fb45114..c205ba47c 100644
+--- a/policy/modules/apps/loadkeys.te
++++ b/policy/modules/apps/loadkeys.te
+@@ -37,6 +37,8 @@ files_search_src(loadkeys_t)
+ files_search_tmp(loadkeys_t)
+ files_dontaudit_getattr_all_dirs(loadkeys_t)
+ 
++fs_rw_tmpfs_files(loadkeys_t)
++
+ term_dontaudit_use_console(loadkeys_t)
+ term_use_unallocated_ttys(loadkeys_t)
+ 
+-- 
+2.34.1
+
diff --git a/recipes-security/refpolicy/refpolicy/0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch b/recipes-security/refpolicy/refpolicy/0044-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
similarity index 85%
rename from recipes-security/refpolicy/refpolicy/0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
rename to recipes-security/refpolicy/refpolicy/0044-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
index 8c0bc8d..4b25b78 100644
--- a/recipes-security/refpolicy/refpolicy/0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
+++ b/recipes-security/refpolicy/refpolicy/0044-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
@@ -1,4 +1,4 @@
-From 2460a7db017d5bcbf53d1e2419ee9422f8de7271 Mon Sep 17 00:00:00 2001
+From 72700229fabf1db62cffd63180d2b155aa7c82f0 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Sat, 15 Feb 2014 04:22:47 -0500
 Subject: [PATCH] policy/modules/system/mount: make mount_t domain MLS trusted
@@ -19,10 +19,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/mount.te b/policy/modules/system/mount.te
-index 1417bcb27..f0a826a76 100644
+index 687c532e1..319ddd2bb 100644
 --- a/policy/modules/system/mount.te
 +++ b/policy/modules/system/mount.te
-@@ -120,6 +120,7 @@ fs_dontaudit_write_all_image_files(mount_t)
+@@ -121,6 +121,7 @@ fs_dontaudit_write_all_image_files(mount_t)
  
  mls_file_read_all_levels(mount_t)
  mls_file_write_all_levels(mount_t)
diff --git a/recipes-security/refpolicy/refpolicy/0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch b/recipes-security/refpolicy/refpolicy/0045-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
similarity index 95%
rename from recipes-security/refpolicy/refpolicy/0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
rename to recipes-security/refpolicy/refpolicy/0045-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
index 5afa497..4a51411 100644
--- a/recipes-security/refpolicy/refpolicy/0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
+++ b/recipes-security/refpolicy/refpolicy/0045-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
@@ -1,4 +1,4 @@
-From f86a3f306eaa24038f9090e4f99b4f46914735d9 Mon Sep 17 00:00:00 2001
+From 89d558cb5ab3114d050b5c410396b1fbc8c246c8 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Mon, 28 Jan 2019 14:05:18 +0800
 Subject: [PATCH] policy/modules/roles/sysadm: MLS - sysadm rw to clearance
diff --git a/recipes-security/refpolicy/refpolicy/0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch b/recipes-security/refpolicy/refpolicy/0046-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
similarity index 96%
rename from recipes-security/refpolicy/refpolicy/0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
rename to recipes-security/refpolicy/refpolicy/0046-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
index dce8f1e..ed4ec8d 100644
--- a/recipes-security/refpolicy/refpolicy/0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
+++ b/recipes-security/refpolicy/refpolicy/0046-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
@@ -1,4 +1,4 @@
-From adfe3ab856fa6a1650a47d5450080307aaf19e97 Mon Sep 17 00:00:00 2001
+From b2cc428afc6b7ddc44c65075ee9de2493cd0d5b9 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Fri, 23 Aug 2013 12:01:53 +0800
 Subject: [PATCH] policy/modules/services/rpc: make nfsd_t domain MLS trusted
diff --git a/recipes-security/refpolicy/refpolicy/0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch b/recipes-security/refpolicy/refpolicy/0047-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
similarity index 94%
rename from recipes-security/refpolicy/refpolicy/0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
rename to recipes-security/refpolicy/refpolicy/0047-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
index a3b36a0..41e053b 100644
--- a/recipes-security/refpolicy/refpolicy/0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
+++ b/recipes-security/refpolicy/refpolicy/0047-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
@@ -1,4 +1,4 @@
-From 00e1288cb8bd975c9252fd3eda97cbc3bb705de6 Mon Sep 17 00:00:00 2001
+From fd7327d0a30cba8963f1b9808c8975de83c9329e Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 30 Jun 2020 10:18:20 +0800
 Subject: [PATCH] policy/modules/admin/dmesg: make dmesg_t MLS trusted reading
diff --git a/recipes-security/refpolicy/refpolicy/0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch b/recipes-security/refpolicy/refpolicy/0048-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
similarity index 97%
rename from recipes-security/refpolicy/refpolicy/0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
rename to recipes-security/refpolicy/refpolicy/0048-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
index df316ce..4f71a80 100644
--- a/recipes-security/refpolicy/refpolicy/0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
+++ b/recipes-security/refpolicy/refpolicy/0048-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
@@ -1,4 +1,4 @@
-From 42dbcc5513da2e2f63ddc9af7b551b01244bdce5 Mon Sep 17 00:00:00 2001
+From e57d5b29eeb81f75242c470f7102731438173b63 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Fri, 13 Oct 2017 07:20:40 +0000
 Subject: [PATCH] policy/modules/kernel/kernel: make kernel_t MLS trusted for
diff --git a/recipes-security/refpolicy/refpolicy/0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch b/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
similarity index 93%
rename from recipes-security/refpolicy/refpolicy/0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
rename to recipes-security/refpolicy/refpolicy/0049-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
index 147ca29..a8aebe3 100644
--- a/recipes-security/refpolicy/refpolicy/0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
+++ b/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
@@ -1,4 +1,4 @@
-From ccd95772201397f33dc4aa585d253a010a713d5f Mon Sep 17 00:00:00 2001
+From cad7636b64e21e6a338683ce76b52ebac662d73b Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Fri, 15 Jan 2016 03:47:05 -0500
 Subject: [PATCH] policy/modules/system/init: make init_t MLS trusted for
@@ -27,7 +27,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 4 insertions(+)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index 0772961ab..ad51a24ab 100644
+index cb9c3d97a..43b4789f7 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
 @@ -256,6 +256,10 @@ mls_process_write_all_levels(init_t)
diff --git a/recipes-security/refpolicy/refpolicy/0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch b/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
similarity index 92%
rename from recipes-security/refpolicy/refpolicy/0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
rename to recipes-security/refpolicy/refpolicy/0050-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
index 2e1c99f..07a1835 100644
--- a/recipes-security/refpolicy/refpolicy/0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
+++ b/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
@@ -1,4 +1,4 @@
-From 86bb36e5b6dc2c1c20c30b569f7c2e8c1f680015 Mon Sep 17 00:00:00 2001
+From a47614a37d0c2676db4b3604e258ebde59223a2d Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 4 Feb 2016 06:03:19 -0500
 Subject: [PATCH] policy/modules/system/systemd: make systemd-tmpfiles_t domain
@@ -43,10 +43,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 5 insertions(+)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index adcd931b7..2595abc8b 100644
+index 11a206fd0..5aa424e5f 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -2241,6 +2241,11 @@ sysnet_relabel_config(systemd_tmpfiles_t)
+@@ -2282,6 +2282,11 @@ sysnet_relabel_config(systemd_tmpfiles_t)
  
  systemd_log_parse_environment(systemd_tmpfiles_t)
  
diff --git a/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-systemd-make-systemd_-.patch b/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-systemd-systemd-make-systemd_-.patch
similarity index 90%
rename from recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-systemd-make-systemd_-.patch
rename to recipes-security/refpolicy/refpolicy/0051-policy-modules-system-systemd-systemd-make-systemd_-.patch
index 560bc2d..aebb924 100644
--- a/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-systemd-make-systemd_-.patch
+++ b/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-systemd-systemd-make-systemd_-.patch
@@ -1,4 +1,4 @@
-From d0a659f27ef2877a3d282fc90fe2e8035efa7d92 Mon Sep 17 00:00:00 2001
+From 8bd6e0df24e157f55b242bf9ccb72efeaa4a563e Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 18 Jun 2020 09:59:58 +0800
 Subject: [PATCH] policy/modules/system/systemd: systemd-*: make systemd_*_t
@@ -43,10 +43,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 12 insertions(+)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index 2595abc8b..e4f53fe66 100644
+index 5aa424e5f..5649f79af 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -463,6 +463,9 @@ optional_policy(`
+@@ -473,6 +473,9 @@ optional_policy(`
  	unconfined_dbus_send(systemd_backlight_t)
  ')
  
@@ -56,7 +56,7 @@ index 2595abc8b..e4f53fe66 100644
  #######################################
  #
  # Binfmt local policy
-@@ -676,6 +679,9 @@ udev_read_runtime_files(systemd_generator_t)
+@@ -686,6 +689,9 @@ udev_read_runtime_files(systemd_generator_t)
  # for systemd-getty-generator
  userdom_use_user_ttys(systemd_generator_t)
  
@@ -66,7 +66,7 @@ index 2595abc8b..e4f53fe66 100644
  ifdef(`distro_gentoo',`
  	corecmd_shell_entry_type(systemd_generator_t)
  ')
-@@ -1196,6 +1202,9 @@ userdom_relabelto_user_runtime_dirs(systemd_logind_t)
+@@ -1208,6 +1214,9 @@ userdom_relabelto_user_runtime_dirs(systemd_logind_t)
  userdom_setattr_user_ttys(systemd_logind_t)
  userdom_use_user_terminals(systemd_logind_t)
  
@@ -76,7 +76,7 @@ index 2595abc8b..e4f53fe66 100644
  # Needed to work around patch not yet merged into the systemd-logind supported on RHEL 7.x
  # The change in systemd by Nicolas Iooss on 02-Feb-2016 with hash 4b51966cf6c06250036e428608da92f8640beb96
  # should fix the problem where user directories in /run/user/$UID/ are not getting the proper context
-@@ -1920,6 +1929,9 @@ udev_read_runtime_files(systemd_rfkill_t)
+@@ -1934,6 +1943,9 @@ udev_read_runtime_files(systemd_rfkill_t)
  
  systemd_log_parse_environment(systemd_rfkill_t)
  
diff --git a/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch b/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
similarity index 92%
rename from recipes-security/refpolicy/refpolicy/0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
rename to recipes-security/refpolicy/refpolicy/0052-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
index a96d5e3..2170359 100644
--- a/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
+++ b/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
@@ -1,4 +1,4 @@
-From 49eac86160aa1b5e587a62441b22a8c2fccab2af Mon Sep 17 00:00:00 2001
+From 02049a79a81c441c1ec79c522706006b6eafcc7f Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/system/logging: add the syslogd_t to trusted
@@ -18,7 +18,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index a3afe5525..a2df275eb 100644
+index 69b3405b3..63405a193 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -499,6 +499,9 @@ fs_list_tmpfs(syslogd_t)
diff --git a/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch b/recipes-security/refpolicy/refpolicy/0053-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
similarity index 91%
rename from recipes-security/refpolicy/refpolicy/0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
rename to recipes-security/refpolicy/refpolicy/0053-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
index afced9e..85eb97a 100644
--- a/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
+++ b/recipes-security/refpolicy/refpolicy/0053-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
@@ -1,4 +1,4 @@
-From b9be2d9790614d313fdf46d9e7cabaa47d7d3ea1 Mon Sep 17 00:00:00 2001
+From d6ab5ed464252761b4f931c26525e977e516360d Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 28 May 2019 16:41:37 +0800
 Subject: [PATCH] policy/modules/system/init: make init_t MLS trusted for
@@ -17,7 +17,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index ad51a24ab..cd0e3171c 100644
+index 43b4789f7..a66b8731b 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
 @@ -255,6 +255,7 @@ mls_file_write_all_levels(init_t)
diff --git a/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-all-init_t-to-read-any-le.patch b/recipes-security/refpolicy/refpolicy/0054-policy-modules-system-init-all-init_t-to-read-any-le.patch
similarity index 92%
rename from recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-all-init_t-to-read-any-le.patch
rename to recipes-security/refpolicy/refpolicy/0054-policy-modules-system-init-all-init_t-to-read-any-le.patch
index 973c0f0..339e18f 100644
--- a/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-all-init_t-to-read-any-le.patch
+++ b/recipes-security/refpolicy/refpolicy/0054-policy-modules-system-init-all-init_t-to-read-any-le.patch
@@ -1,4 +1,4 @@
-From 3bca256a6b97562f9c75e03dd7e8e62077bc71e9 Mon Sep 17 00:00:00 2001
+From bf00541ee77d1d57ee3ad3ef39d5ced6ac6e7836 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Wed, 3 Feb 2016 04:16:06 -0500
 Subject: [PATCH] policy/modules/system/init: all init_t to read any level
@@ -22,7 +22,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index cd0e3171c..c4c1a5323 100644
+index a66b8731b..15bffd9cf 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
 @@ -261,6 +261,9 @@ mls_key_write_all_levels(init_t)
diff --git a/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch b/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-logging-allow-auditd_t-to-writ.patch
similarity index 92%
rename from recipes-security/refpolicy/refpolicy/0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch
rename to recipes-security/refpolicy/refpolicy/0055-policy-modules-system-logging-allow-auditd_t-to-writ.patch
index 9b1762c..45aaf84 100644
--- a/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch
+++ b/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-logging-allow-auditd_t-to-writ.patch
@@ -1,4 +1,4 @@
-From 50037f06b0fecd6f8d0416832d18bbf8821a55dd Mon Sep 17 00:00:00 2001
+From 3b1171e3500cbb385a9ef697285f29d04e800e2e Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 25 Feb 2016 04:25:08 -0500
 Subject: [PATCH] policy/modules/system/logging: allow auditd_t to write socket
@@ -22,7 +22,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index a2df275eb..daaeefb64 100644
+index 63405a193..7ef69524c 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -240,6 +240,8 @@ miscfiles_read_localization(auditd_t)
diff --git a/recipes-security/refpolicy/refpolicy/0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch b/recipes-security/refpolicy/refpolicy/0056-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
similarity index 93%
rename from recipes-security/refpolicy/refpolicy/0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
rename to recipes-security/refpolicy/refpolicy/0056-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
index 0a24032..366efc1 100644
--- a/recipes-security/refpolicy/refpolicy/0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
+++ b/recipes-security/refpolicy/refpolicy/0056-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
@@ -1,4 +1,4 @@
-From 2def1a0849bcef3099f50c99c12eb60974dc9c28 Mon Sep 17 00:00:00 2001
+From e0aa3ca69ce86a8063c655e4ecfc3d0781b04ecc Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 31 Oct 2019 17:35:59 +0800
 Subject: [PATCH] policy/modules/kernel/kernel: make kernel_t MLS trusted for
diff --git a/recipes-security/refpolicy/refpolicy/0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch b/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
similarity index 93%
rename from recipes-security/refpolicy/refpolicy/0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
rename to recipes-security/refpolicy/refpolicy/0057-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
index 1bbeeb2..6f83223 100644
--- a/recipes-security/refpolicy/refpolicy/0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
+++ b/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
@@ -1,4 +1,4 @@
-From 66402eb7ea25179ba0e21267f0dea1b506a6ab26 Mon Sep 17 00:00:00 2001
+From a566e6940963d6173c47edf52e5794c450613939 Mon Sep 17 00:00:00 2001
 From: Roy Li <rongqing.li@windriver.com>
 Date: Sat, 22 Feb 2014 13:35:38 +0800
 Subject: [PATCH] policy/modules/system/setrans: allow setrans_t use fd at any
diff --git a/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch b/recipes-security/refpolicy/refpolicy/0058-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
similarity index 92%
rename from recipes-security/refpolicy/refpolicy/0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
rename to recipes-security/refpolicy/refpolicy/0058-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
index f7d13e1..ec8b3d0 100644
--- a/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
+++ b/recipes-security/refpolicy/refpolicy/0058-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
@@ -1,4 +1,4 @@
-From 2a968f30e93462c5555277442b04f4abce3637ce Mon Sep 17 00:00:00 2001
+From d1bf786cbf516025c0139debe55d6f6e8340bfc7 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Mon, 22 Feb 2021 11:28:12 +0800
 Subject: [PATCH] policy/modules/system/systemd: make *_systemd_t MLS trusted
@@ -24,7 +24,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index 3f3426ebd..bb32d1981 100644
+index c9c841a2a..36cba9a19 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
 @@ -266,6 +266,9 @@ template(`systemd_role_template',`
diff --git a/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-logging-make-syslogd_runtime_t.patch b/recipes-security/refpolicy/refpolicy/0059-policy-modules-system-logging-make-syslogd_runtime_t.patch
similarity index 94%
rename from recipes-security/refpolicy/refpolicy/0056-policy-modules-system-logging-make-syslogd_runtime_t.patch
rename to recipes-security/refpolicy/refpolicy/0059-policy-modules-system-logging-make-syslogd_runtime_t.patch
index 8a2cfef..929c46c 100644
--- a/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-logging-make-syslogd_runtime_t.patch
+++ b/recipes-security/refpolicy/refpolicy/0059-policy-modules-system-logging-make-syslogd_runtime_t.patch
@@ -1,4 +1,4 @@
-From 71542a544be671d68d9041aa84282f53cae5d05d Mon Sep 17 00:00:00 2001
+From 6763106807b84f0ce9ca53ca0915f2e2069035bc Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Sat, 18 Dec 2021 17:31:45 +0800
 Subject: [PATCH] policy/modules/system/logging: make syslogd_runtime_t MLS
@@ -31,7 +31,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index daaeefb64..4de798007 100644
+index 7ef69524c..87b4779ff 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -463,6 +463,8 @@ allow syslogd_t syslogd_runtime_t:file map;
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 59dfecd..097f3f0 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -56,22 +56,25 @@ SRC_URI += " \
         file://0038-systemd-allow-systemd-logind-to-inherit-fds.patch \
         file://0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch \
         file://0040-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch \
-        file://0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch \
-        file://0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch \
-        file://0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch \
-        file://0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch \
-        file://0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch \
-        file://0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch \
-        file://0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch \
-        file://0048-policy-modules-system-systemd-systemd-make-systemd_-.patch \
-        file://0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch \
-        file://0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch \
-        file://0051-policy-modules-system-init-all-init_t-to-read-any-le.patch \
-        file://0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch \
-        file://0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch \
-        file://0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
-        file://0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
-        file://0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
+        file://0041-systemd-allow-domain-used-for-login-program-to-conne.patch \
+        file://0042-systemd-add-rules-for-systemd-ssh-issue.patch \
+        file://0043-loadkeys-allow-loadkeys-to-read-and-write-tmpfs-file.patch \
+        file://0044-policy-modules-system-mount-make-mount_t-domain-MLS-.patch \
+        file://0045-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch \
+        file://0046-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch \
+        file://0047-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch \
+        file://0048-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch \
+        file://0049-policy-modules-system-init-make-init_t-MLS-trusted-f.patch \
+        file://0050-policy-modules-system-systemd-make-systemd-tmpfiles_.patch \
+        file://0051-policy-modules-system-systemd-systemd-make-systemd_-.patch \
+        file://0052-policy-modules-system-logging-add-the-syslogd_t-to-t.patch \
+        file://0053-policy-modules-system-init-make-init_t-MLS-trusted-f.patch \
+        file://0054-policy-modules-system-init-all-init_t-to-read-any-le.patch \
+        file://0055-policy-modules-system-logging-allow-auditd_t-to-writ.patch \
+        file://0056-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch \
+        file://0057-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
+        file://0058-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
+        file://0059-policy-modules-system-logging-make-syslogd_runtime_t.patch \
         "
 
 S = "${UNPACKDIR}/refpolicy"
diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
index c5f9ae1..fc5a335 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -2,7 +2,7 @@ PV = "2.20250923+git"
 
 SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
 
-SRCREV_refpolicy = "0deb7170f8e5466a39c95468959321c2c28a5f33"
+SRCREV_refpolicy = "9ada10471cd0755a196834c86af5f188f1c595ff"
 
 UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
 
-- 
2.34.1


