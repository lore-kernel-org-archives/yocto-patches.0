Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0BDFED2D9
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 03:52:55 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14142.1773287567305396213
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Mar 2026 20:52:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=DHwYJ0Kx;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75310a015d=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C3obOU949469;
	Thu, 12 Mar 2026 03:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=W7PzvfpKV
	JTg13vUI/SvpUnyNoNw/BDIxVNKRNdIMU0=; b=DHwYJ0KxHKhq5ezwUCfqVuLBV
	GCa1jo3j5mwSeNpU/1KO8nXUmCFqvqE/VupJyMdRKKh3nCa892m4Ctx68cVNsBog
	mLfAAb7cKcYIEQ3HoUMwAK4VSjrpoLgOdFvBlj4SmYtNnt5sdVPQQCjYu7coXjbQ
	kAoYGOQFNddqYHh8pTCWiiGg7cYdzP4BzCMeAY6Ge7+kbRReik9g7lrI6cmZNbPb
	/ZD+ubNnRHeuj57vSdnwJhRX65JUnXG8ggr2iFlMhe5WH7Bwf5XHW6YZvskW9LZD
	cQwtnOgRfqoDXHAqfQ7zy2XNvFVBtejBy9yWdx4Z0Cb2y8LI3GyuNTXR8vNXg==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh6t879d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 03:52:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dc+zFJPZMZXjbvAt1skMsge3MOx5uO5j4rr61EhqY6Lr6mtyypY26xdZ3f5us2BvmLBdwT2Tvul0fC01F3wZhj42kb7EW4r3ORkjZpVnHMZjsTk3uvtJ9og+S/ztjBzGSXposmowIzktVOprVBZHZ1qmUs5+dVaVI8YaZeyj2UH9+DiHdxEsslZzCs0M/p7HFp1WyBCakbFHlk4lhoR2dZhO2LgfWwD20DOzDSiKVNH2YA2O/AXVEe5huhggTe4LmlavGD8TjqLzxbiAMAMQW0Smp8KuCv2tFAdla4MorDhtmArdxA5eMJIKyoEbVndkCddqtj9R4awLws5eV+mE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7PzvfpKVJTg13vUI/SvpUnyNoNw/BDIxVNKRNdIMU0=;
 b=PAAMX/RRAyEmm216UE+eTcNAgxgndvVn/H83MhRQozUA9Tf8mSRXTk2I5jclmsy4CCtarHOVL7l7xbmQj3UOtr6Ms3uJX5shZtKK4LWkx8wA0yoNsAxshvzOSmqPQkjIVmBjqLYOjITu7PSmI9ToxqhzGCtIfpXrSGQxKvB7clJ82bNbFhI2LkTJhiUl/hJyWbAzSauh7MR1i74jANKTqaqx9iahOMhyNMQaFzAUUMrpRrRCAEsp2NPB3S3DLsFmRxTYkHcbO2RqIQT97jiRfjvEKCHvfLixivfQ2ZepSspmiSz5bxiKNmijoyAFvdFkZAgq6e4b6yOqSbvyrPeIMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB7942.namprd11.prod.outlook.com (2603:10b6:208:3fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 03:52:30 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Thu, 12 Mar 2026
 03:52:29 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH V3 01/11] upgrade-helper.py: remove unused self.poky_git settings
Date: Thu, 12 Mar 2026 11:52:01 +0800
Message-Id: <20260312035211.745546-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0021.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::8) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|IA1PR11MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: b09a9962-121b-401f-a30e-08de7feac875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	yZcGREm55pjQvWH2r2dfCeTIQmbbjNTlAI5bRn9cI3tMlPSNI5iYDTczi1MAdSrPT0F1DfgPbvbv5+HTsqajv3Nw7TXaaYXND+h52q7yP1sXrVopVpElmS7IWTeBVmQI9BvOT3Lm107eCXIszUSmFwdfIN3nOaGmSMLAG4d1FOVa4zJ1FUqcxJ6JFpjuQW4aIL7L9iid7mhO4w8roD+ABPVZzHGzn1AoDWbW7ZmJV+k4XpSv4oqxK/UOcKXtdiICnORLE5ykBeUGOlv7MMG770VyL8IF2OiOZ+YFYvJ3dnOkSWQjFyFjCzOnhPy9Ozw6ffuXxECccyW8jVoMI3rExWcTMoHWNSVFtCLaAqNLKfdYcTpeKEdsviQ6GVZCsXsHb0eTBJEYSGJqCL+A3kTmsp9TZ9xHHVPqDESVnig6qpeihnI2itlWLP55oRRLvlVyO9ftP8bgO3okQD8sgQZKTRP/EDMcAAJhIaISZcl6KtUOWHuIiM4mP99CvHW79a9eJaUqoewL7etHnBEBr954B0poJkZCWzT429f6EKXs3zQQY85aZwUupTnb9mM8nVLemJJ9tsvh2Evyu/2H3iYx7NcSlv/doivEvGQx3J5l4sph4afCls59jf1yeijpDPMyIjUtdJvrlZOdXJ6J/T91rp2PoPA+Nx29vNig18U38UHBInU9X5eZqGsRArUDwJikaktYH1ELrkXMn+B+3rQCsqaWQFjCTbNLNJsYDdv+pqGw2wV+YPO9od7AxvYWc6DtlGKMG5BlK3mOTqRvtd04klt8V1pxnAGyYgv+yJwZwUo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9dtFMZLtFSI8OBUPwQgmIddCa0GponxpC7lmuGFiKD9EuZnBCKWxBfyu4udy?=
 =?us-ascii?Q?UPGstnfnKELpf6dAnSiZtJtAssT3h22nfRktnjKUnnl+qv89Qc1ME4RjouIK?=
 =?us-ascii?Q?RwrfShG+5SlcWzdoYkBemSkTRZGcboulpRvgxlmcUvI+3H4mrPR1tKVEqN7u?=
 =?us-ascii?Q?D8lbk7pC0ylr3MqaGesl3IkYG2tP4LwFgn0XfNtgD1uB2Fzq2WK0l6Hhqqm2?=
 =?us-ascii?Q?zpHs5aD2K94NfLuFlFUk9NbIzXscnm4gNZgVcFLdaL3tBFOyPrR0FqVPnDtj?=
 =?us-ascii?Q?nG1Jum0KfEOCw6DojXSd1O+HvoRE2sgFygjMzO1dW74ZEQTA+Qu2+G9MlaGh?=
 =?us-ascii?Q?dj+WUptx8Gs+kbHZ0lL3sY1CZbHvczAnpAv7995B0Bpug+gAGY/1CCyeobjz?=
 =?us-ascii?Q?nBV9pJiRMLApoftimo20xsGcQB6OES37HK+5Ao1lGrVMLafWs682A1099X4g?=
 =?us-ascii?Q?UWVnkzm3Ys+EIQ/zJnkYCiwiUMWIEwbcL+KZvambjb9AyvFqbZTCnzuz3Zui?=
 =?us-ascii?Q?dWTY4Fbgp8b7T1GFNUWANZqU8os/+khIPYnR1PD7LHkeAjVuV+qjGHnVnwS6?=
 =?us-ascii?Q?GqNGZCZNc/t4yP6VBjhbdNk+MZuh4SAxKaNz8yLj3IZ8YXg+4T+65gOQiV++?=
 =?us-ascii?Q?Ks0W0iyfzlO9lqQgJ+GyNP0UxZAoHTSIeToMrhIGjvBiZ6fFPjvy2vV2u97O?=
 =?us-ascii?Q?41vgVihIs1x5tpHWhOacL3lyn1I7uu8dpxXhjmO3ssx0JNg/9NYRrcNkbrmt?=
 =?us-ascii?Q?URdqY0jzj+QGF6iUQ5JOeYM/AK1bTvy5+1xv1ZkeEmha+x/P68aqF6sPHCV0?=
 =?us-ascii?Q?kZdz9FS89Rp+e/3HdhNG6RY4VszyBd/ipAI/K3qMIGxk5VKces2c1gHicG9C?=
 =?us-ascii?Q?4cv1+nMvol5K3us6Ilx3s6ZHcnyEb53InzLz50jlexWdBIyBOig+5y3mkZiW?=
 =?us-ascii?Q?oqsl18D2z/WLpmzqeoA7OhnvEG11DBfJh9jGeR0rgw2QcvbbafThOizbrX+w?=
 =?us-ascii?Q?iWHcNxWNxGWaTAgqCqXvdNPw3MO9V86Pm53vVSHf1lWgB35QcVNritUueUjj?=
 =?us-ascii?Q?WWq7Rsbr6PaTmC3SzQDe5JTK1LauGCOCmNV5sKkP6DRjJEfbzGNMMEjHF5JQ?=
 =?us-ascii?Q?kgS0uNCX4QAIucPoCIL6VoloWVYqhLfS6ueheDqv9G1lJssG4u9/Qi8HtCSp?=
 =?us-ascii?Q?rVvghZqJMoczciKEuTyp/75DYl3wE0ky/T8njZ/PeJvROBOQ0MJbqkDZmrbN?=
 =?us-ascii?Q?iwj0vU9vq/xFUDDl1bGV9mxiCpgXzLArip+HsuwbMMIHVvmmrSQXAxPAWt6R?=
 =?us-ascii?Q?NxOPUrI+62v2PLSj6MGoKcUnBoKbzESYOpiy3P/euSXZ+xsk9ogWEkRGIKLd?=
 =?us-ascii?Q?zno4pBO1M8RMRQT6O7WkFdXXiYILu7elFvKW2PTEUP+4ehPkDmp7qkW3HQqZ?=
 =?us-ascii?Q?vFRPMvLEopX91mGI/uegyUNEPNdXvFBUPaYizYWP8F+vQzzu/EOvZL9Cdxts?=
 =?us-ascii?Q?p1lCS0aHkb5iDDlRUqYlXfyJd4Ij1g65nbmvYBqey+cQexrn76izdbuqDF4Q?=
 =?us-ascii?Q?91jyj2PCcKwp601DqJGFznciPBRCO3KEGBGJf5x9uQKSYrLY0Y4bvKa6cMJ2?=
 =?us-ascii?Q?P4W9TuI+waQf8o8MTcXvFHZ2TLMASKRwmUSD+Z9XKAVjE51+MOiy1BR2ALx4?=
 =?us-ascii?Q?cjhQyT8gOuTMgQ3oc4pGr247xicPkeYQHRbLo2P5koX9NKIRoS5pRtYO33Yh?=
 =?us-ascii?Q?buKKmenN4A=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	bxFRdS6EgZ+tvGRhW7QRwhDgcHSRZsu5S/l4z8lUC3x7YlT2dug8zbFaUU0rPgrSI3QG6F8P1BMQAgRk3hkEkDRLld1Ec3Ea1GagZLR6rtja0igAInbqlMCeSVsKC7aJ1EzlhmRUnUr1khbLZwCjFkxPzM+bqSwpzk7M95C7GpdDNk5XJ8eJoofUjInQUTc14bzSHOloyK2UClvi/inI3hL1mh5MWVrZslqJykksXlzQTQHNQXKJKg3MTwIa3ubS1H/SUkx/pcW+xrpYFZ/FwJiSCCkf8jEukcdnTsOzUZ7xEI0V1iStD+UyggQhb7mYNHDc3Tutwp1q1qRo8zFR/Q==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09a9962-121b-401f-a30e-08de7feac875
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 03:52:29.7939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwyc8xttpaG4WNhGlQlvv+fUaZqPqOxQKdZgndvT2JemMYZKqmjD3Yqc8ot8Swcfwgb9u1i7yFUIAdwvdDwe5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7942
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDAyNyBTYWx0ZWRfXzwXOSid1jiTM
 /yUN7RiEytiFZxp6g6Fpky/cQ0Q3W1omuY2vIpxdjNdMNHX2KUV2e8vEMbpZXVEWV8TMDXKCaV0
 YeaMYRLvUvr2Qtt5JsTjuWT2xEtAnaZapKZfyff0hRs//6AICAckieHwe5h5KA6a6BDqGIc4AUq
 4k0aRWD59f/J1LW8i+PNkoBid3SEjrULE/y76Om2JsljOAyCXyLcdV30s8njg7Xfs0dyxYZnsJx
 zn9IsjSjsH2WHLbDSpZucRIS/DG8pBanjjYtEs3fwGxUyhet5BuQJ64N5vBLW580UxffCagaeyP
 WB4f0VHUg7+f1hNR+TNgfivKVWrwt18wXLu9EAB5+QIpK9F35gjepDQupdzqqKAAIGaGK9yl53I
 jx5nUtoeINMF4wJnUv3WNiIW83hd9q/zWe6qYVZ7eg09sigwtiHXZqdCtkDJSiMCUll6ZQbfv4L
 z1vvhehyzaf2avUdReg==
X-Authority-Analysis: v=2.4 cv=LYoxKzfi c=1 sm=1 tr=0 ts=69b2388d cx=c_pps
 a=yaJUXpcFNTkE3gTvo4ZtIQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=yuVxGOc7aRE3UmWQ7QUA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: NNH3a-btnywAA7JKB5_F2OmrkwV3uebZ
X-Proofpoint-GUID: NNH3a-btnywAA7JKB5_F2OmrkwV3uebZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120027
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Mar 2026 03:52:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3445

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


