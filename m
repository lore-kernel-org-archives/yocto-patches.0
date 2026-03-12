Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02626FED2D2
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 03:52:55 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14139.1773287564002910933
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Mar 2026 20:52:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=sY2YMvZW;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75310a015d=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C3pA0i2877391;
	Thu, 12 Mar 2026 03:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=hQzkIjCgzkTVwKfm5g924gkn1Q2bpMAGA8/c2aoWNGY=; b=
	sY2YMvZWdksiZhuUpR41h/QEwL5QI+rAwO0w4somo8tzR4cWPB9kX2BqT4u+0FsC
	cC/dthTBxoeca55H2+hJtjrzjAFsXPHZtpA44ejIei4syZxnv6HBrr4NaNakFZ3B
	PFMcaMO1JGIUPA5kj+ko4TRKQMiJArudtF2sHKJvR1dijXJ2ZMD9lDUGcU8DOaiD
	E8XEOtfAk10kD91MA5E31fEvP+kSZdYZkL3DYlh0oBuYylNT0o+rDYMZfrVNTBX3
	QtLUHIHxvUWsw4tYw9hilx3Q5HO99zPhdF6Knt3n3i9U7xDG0BtEfe6OMBjjj3DX
	pUfAKiX9On19ornFuNB9Mg==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh78g75x-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 03:52:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyIDPIkmaNxHcR9whVJMrr8ns3L5DdxLel16shGiqTqJiHcyWAAp6rj0MSIwnQ+VNKwkEuggGUS4Gzltk4zRDkWCZMlzFcFopkPQPY0djfEn3gdnm21ZntTP0+8KJNgwgHRBzZciiZs2J15KqfrbA+Z/DMOicm+o/NVgofhD/1aXp9MfcDu/CWNJhJsclHP2dQp8Y+GunGI/vv6hg6+dgCK8YoCHWdeeMhHkPTZVMFpFoJjY9Xa8lL7l6GYAqTe0w3N/c3hMMmmL1zbvd453WABmDDmHudERdTs8EJ4zsn9PCkzacNN6pMSkHYQviLjHZk+iicoiAmr6eXFQ9LGREg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQzkIjCgzkTVwKfm5g924gkn1Q2bpMAGA8/c2aoWNGY=;
 b=P9umbFd33XiVCwoz+Tflq93sAcQmE5FPi5a90fdGDnNvwwT8RND2e8FpvrlK4RS58d8Sr4FKJVEuK/iLXAGgjWtjO6PLfrKpqi6/6l0icy/Stw3CgX63KoC79yknmzQLna7IH06QuVvmwIW36NDCr4xnPmHDtMi2r8Jt5vmMMQVrGOswArLdWsRKBYPkgq4NKdPz1WecttN/ZA4otn955xnXQ8KpWnycqDAKT4bWxL9z4OZmjGWw03/BoOYOPuvD6grZiBUJq1kO1TelpWO+MFkdevOXwL+OEiIBCwdfrqEfMQAR9F+KnAM9gLXsuD8LyGEni8Udc3Z/8mIy/z/0qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB7942.namprd11.prod.outlook.com (2603:10b6:208:3fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 03:52:32 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Thu, 12 Mar 2026
 03:52:32 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH V3 03/11] requirements.txt: remove as it makes no sense
Date: Thu, 12 Mar 2026 11:52:03 +0800
Message-Id: <20260312035211.745546-3-Qi.Chen@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: f4a31374-ce6f-40b2-9697-08de7feaca44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	p+ipHsJqEDbL6/NpkTAIMID2mNyAu5HMchkJ0qbTI6SuTjVEKWkJym3sS85QlEbHMDtf+7W39NeKM0SnjAmtkKb+UQ/lMY1xvquR9Lw+YIAv7n/hZPCzA3GcsMXKnVkpkO2U1Ln/J21qm9vzymY5vxa6KwkjaNDyjFjbXr9srkcbv6ILr4BFQfW5kOxZ3kUx9HB5RdggJhB55YqVteHkf7y8CJH2PAr0Gmw9NlZMgRn5dmCLmPFtuG13n0f+WgNgiUaQBXoFTXHYg9DUGYUUgzxJ5Q7/3QUSjeE2Dr0GPWWVsJPr7qSM3UxoqmMDVyU0x1WVXoRxWdIyhiU/JM/s0nmv2G/jRNPWhmj+LBkUu4bqxmuSU4Gf4tLMK5t/GDX0G19MMsWoiY2nkRw9nh0cubTR2iTikmptU9yR/4O1rPvABEy5inqFt5VCmHYllQZ2RBKVg5TuGuxt1ooCOvBma6JNVdMJZAGIdl3CUJYagLta/wKKMh9sZkYwc7V6IuoaVXhabNN8zgpt92m8FELe3k2LxPQnNPp+5t4fgN3UxlmWJypW8GQxlBUmptPl1VOvUqB91f0t3/0yO8Eh/K0xhrE054MD1pwYFpGDvwF7hH4KHIC9DAA9ct9Q22e26nK+KI82gz1hp7ChtIC+ByOrzLfGl63xWHsKT3SFuJ8wEEAEztu8k7yWpWDeTzqdFgyAI5El0PteHE1jYYOBSK1TUixVqO68f+BevrU5rj4C16Kdx2SJhfNCnN91xPhqJdE2wrAzXtNmCynf5JU5U8jZL9eRvgcHEbsYvlWVr6xkPvY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QekkyCS6QLyIfuP2ZgltOaohWxVdrPFX8VjXSfRR5vc1c1lSrzbbOr7FZtjw?=
 =?us-ascii?Q?0E7ylbRQOroNrByCcDLJPqw14hrk8cHumS7vxDAK77c83dS0POdMAErYJYOQ?=
 =?us-ascii?Q?Zu6sioMoWn0YDX+E4w1rrTqYPxobMA1pSYTlOCd/lQkPHwXbQwdIyntmp88N?=
 =?us-ascii?Q?Ee7y83DqEG87/Plc1htYeqre/P+p5lcrKE96U0xdn+u2ZNON5EKfY+g8O8Ws?=
 =?us-ascii?Q?ofvPzWA3F953X9DBv65ubo/tbVPBS6huFWTyvFdAe3hp0lIpYWcHm2v4VSZ0?=
 =?us-ascii?Q?NrBekVkk5vC5Gu/HsVtxjkUZilA0rEGqKoLy0UtqXE7pS+7qLv+XmOcvDKMr?=
 =?us-ascii?Q?QdkQUwG37j5TKBpqOQGAkMVMQipP7rFwn2HHOv7xY3nyuQnzVQA6hARVALUw?=
 =?us-ascii?Q?EtApPf9Rb+5jCzmkuS+0cpDZH8agpq2mK5D8vUrHQAmVH+n+oDOs1tq7fDMr?=
 =?us-ascii?Q?b6ArNMPIGp4Qviho+SqJVrzXdrMCneWXUhy57uyvS0il7A3nfV0NSBaJ/Ti8?=
 =?us-ascii?Q?rRj0pc8yZ03YaM9qvwkD0W7HnJA29d1HfTKCwb2YPrObG6139FyLmVZUrpT5?=
 =?us-ascii?Q?nODl6YtQfawyJq2rd9furxLhw5i+0BBoBXXzR6WfS0rv/55vt8Hxrsnp3jCI?=
 =?us-ascii?Q?SLcCOVtMi1WWPHHbyvB6VGsNqTIIPv34kHW0aQ+bXnByvnGwHMcrr4Bfdtsb?=
 =?us-ascii?Q?lRelj2vY3cj6Eo09Vtj2L/WMQrTx0D5KQZP3dhl3+xErH0DkynLwzPiyDn6T?=
 =?us-ascii?Q?SIPOZte5FYjs7Q/EKcCL0U847KWyMyXol2tsd/8EgsisdV/1bRnhkinOw2dk?=
 =?us-ascii?Q?mlo7EkWf7mjiU5IuYV48TmpTNFy/KJL+WeNa0178t57XaavzlJWJZLZTuHfX?=
 =?us-ascii?Q?nNiLMphcVuQegM7nbjp4TzaZhfwfnQlyRN3+x/hT0xeq8onB/rEHgwvVkjqJ?=
 =?us-ascii?Q?IbtyvMA92X1jvOQU0eT5DLGy7ZcFlFhGtY1EKaQ/RPgRXjvBqGhBNsv6stC7?=
 =?us-ascii?Q?HQ7RlUBDFlJ3JYg6/O035xBHtItLzbB4MIHI+zrXzZP5p2lNyD2heaiKXsnE?=
 =?us-ascii?Q?/FWrVlCx73QbEBbJs30/TBWHkcOcUc/TLEASyfKyN0ttJLc2wZY93zjX/YHI?=
 =?us-ascii?Q?Wogkg8c8KJ7hwdsLytcYka5vBuza63MWTzTCJF93upCNs8wc/5cQ2zQpZrn8?=
 =?us-ascii?Q?dJir0FkE5vPNIKyqbyBNHHNkBpRe+q7pVdD/CkMnPDDbahS45xiSdhObJ5tO?=
 =?us-ascii?Q?Q9CkNFvW7hpkMCQ3RUiRtNQVIW/TLyAIw/++lOmCvntep/EWEq8TgZFEzCHW?=
 =?us-ascii?Q?WV1naABnvPdNGo7FAdEyjYh2ZOfRXvFiPa3+XVLqSSBkCEj4JIiOCErh9yD/?=
 =?us-ascii?Q?2Zgr+KplUgjXqbA7Fy5mFa23f/OxvdcRsXVFEDZw7VVVhnfRQ05xn/ke0Aw1?=
 =?us-ascii?Q?xYwKPfODAcL5gDS9XVURU2poWwe6ua7iQ1BpAXCzwsv7b2LLVxe3BF85g/pS?=
 =?us-ascii?Q?sVRo/0yRBOTOPW2kpP/qaNX6yK4rtgPkcmvwNdixcjpLwXGH1BqMpE9d7W33?=
 =?us-ascii?Q?J80qHVU2mmFdPXazUeQaltY+H2VWE77QnI0CetYuoneSgFNO8g8h1U4HRY1S?=
 =?us-ascii?Q?0w74+8NNvPefl0oIle7x5sNOHCArWf2aRYhFeFCkShkY9zHcOIH41YbRDOog?=
 =?us-ascii?Q?s8XIR/omNBOYGa9ByxS7nfR/tldWEvTYkJzaBi55u1tKxjxEyp1SHoh7SMXU?=
 =?us-ascii?Q?GWPpLtOMuA=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	JamNk7D/F4CqXjCytfiiW1H5wNybW5LlOwDxzvVjK/xDQFp7r7i+xh5ZkRuQm6/bhrAtalBXbgNa+GwtAXl9GXF5dYVQ/DL5FnnDTbx2GpIeGu1GpreSBMa4hXOodpSI6kWxW/iXCuRlaj6gbdvvAKtoEBKDVPHE3lL2WhL43yCM543Nv99OVaRFzAaIHJyybiEH7JjntBbIf/Ktgd7Cc3ECcT6b0lq6Vk9DddRdvD3enM9FHjshW5yI/tMVKOlwVKL7IXy+uzSyWcqknzJs/zSxAJG4QNOK7sB0PuQrSvoQXWzp7he+dRJ75EdBZj3Jr7LQTdIpnoWz0VUY/PSb9w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a31374-ce6f-40b2-9697-08de7feaca44
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 03:52:32.8239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DvBYKdsZ1Qa41XTMxRHNkj4kHrEjl6fCJ5nuvF2Z4UneguTmCyIaU9jWDMPnHyZ5IExXJ5W+6M7XzJeMkDNINQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7942
X-Authority-Analysis: v=2.4 cv=ALvEU0hV c=1 sm=1 tr=0 ts=69b2388a cx=c_pps
 a=c7CpAOS9Jb82g9OYW51qCA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=KdazThy4EY_gBvstyO4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDAyNyBTYWx0ZWRfXzIGJ0vVvAuLc
 HB6HB4uB0mqIhcaeBGFFMT12t2uU9wyVjRcqRx1HqUJUxygcD8OmXdbCp0AUp4ZpIYgr6hh00aW
 Cf64GxVuQ70/oeWDaJ2wS89Y4FCQA12zMGZfwfE4W4oUFoQrmKmvbtaIwilysNaeWd1/WQ6uKQF
 mZ0yFnD2Zh7A4VEKm6iYCa9Pe1IoduweRqzw1tz9Ffsqdr2AJkEOWOM4s3sEjgSJJEiNJBDr1W2
 itBo8LbJwVTfLwTNv7dpvvhZ/y6j4SY1/ub6jvffd9wVqVixrL4JDhkKAu6O0qNXINHEcMsW4BG
 jfWgEMIL6B0NGS1zdjzAcEp/N/Js4lpQX4FK5MEDT7usJtSTGRH19ZOqnvypRRXOo0uLd1SKUS5
 iHplampcXXV5CjAFADETjZJl/apHE7Eyjjr3ZH86H8FOS1mBmCwxpIxRlwBhz2Y4CKVVNAzFsPY
 6KrG0xLguSMi2zu39GQ==
X-Proofpoint-ORIG-GUID: escp3Ci12e8y_OMVhpyC3cBjKC3QOhBF
X-Proofpoint-GUID: escp3Ci12e8y_OMVhpyC3cBjKC3QOhBF
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3442

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


