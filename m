Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38A81090229
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 13:45:10 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11372.1773927906172407735
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 19 Mar 2026 06:45:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=TusPN1oB;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75382be33f=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JBDXOb161393
	for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Mar 2026 13:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=hAcTM9IbwdYMZ5TXIhF6
	eKHL5PhM+3qa7h1XtrLpmLo=; b=TusPN1oBnAV2ZZIRu3AzMeBCOlEwF5WTeqSN
	KFY0s7pGJLU5QS+8lFtw+Meh+CCAczLsfbFfIywInbNvKReX8sVYeP3HKyJ1swue
	QU+T+tn+JWlHeUZGSMMcOvR4ULOXcdSRpXjpcNz+qUidiMrTkwXSrn/FYfZqGAG6
	aa5fEmZh2wudTi+HHpocOyCXJkJ+oGZWw/3puAkvXpxopaPTV0OQWmg0hgI6bPZt
	R0Z0SMX3b4gFYzz5ToOZYpolrsHPLBXorzx8ZugTwCXM43+ImP32NqptU8kAxJcl
	0AkuVo8Ae2fLQ9JaRaHg3HIdIPxsgKROboXlrt/r55uXgGxMNw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cxm66cd33-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Mar 2026 13:45:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3EyyA83K8nfCnwgsJ3cXX78FL6BjR8FXmvUOl5YYChzPxYGpav5g4+7UeQ8fNPX9Uc4/MeeOMUgxiecYeQwMh6xC10XvFG0Zej4vML+rR3KUXp3blDPgFtJCeIjn2nXQ4h1ON65Lbt9sMjIMSr4756Es231GX1EanO/lD/sOqJh4Bp4ZhEPXWVoitC8sXrrwfqVnqF9+E/+jvCgCbEMWBCWau8zSOrVE0aAy3cx5URViIwurbhSkMiMQhH8nn+L4iyKperA7ZCxm3vxgTARuPpw61L20gdSTO4eBjwRQAgCWIrkFaB8epCWcZ/YtQFZc/5ifBrKEUXyYY/pTAW5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAcTM9IbwdYMZ5TXIhF6eKHL5PhM+3qa7h1XtrLpmLo=;
 b=XAHlySbbpsMESTjviDQXpwXElxPkDgnkznHyB708K9KpZPhkWhLctyHSxEGBD2Ml5WPddhuI16ceNsx22vf4eKi37ybJzXHjl7MVQNHcPfIfCV0uQF1UqRcSVZR/w04j64DjmgQpXm0hohagJ7PYmga8xBWRsKuGVP8x2QdZXFtT5JI3LH0njvfYdI6Y9WwHpxJEBE+1EB+tS+F9fA7p5QIqSPJ6/9WgJ5SYYsGd2jb35OPsCO/JSrnJpEv305r0L7Og7XKTc76T+ioX4PFiSFHrWEf8Qq/vJ9eMi/BW+RGuDQ5rxfaWS/qfBZNtE3+wbhmWLlBwuBErFctO8Ib9xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 PH8PR11MB6829.namprd11.prod.outlook.com (2603:10b6:510:22f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.9; Thu, 19 Mar 2026 13:45:00 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 13:45:00 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] layer.conf: update to wrynose release series
Date: Thu, 19 Mar 2026 21:44:41 +0800
Message-Id: <20260319134441.1619544-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0092.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c2::9) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|PH8PR11MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: 064e12a0-8ce4-4461-b173-08de85bdb74b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	0PxGQbfF5DXtAjosuEfFH5VNTniK72io0+0NMUInwOZQmBgRWteFFIJMSv66iGD0IalBbvv+oQBQtXNZyO8rLRJQ90BdqiRU/qi4HqzhfG/hc69rzdaBDmeUebmcezNiWktWLL06CDnlkEYFut0BSXF1ubPfDiWo5pmr8VXFCJJ3MB1K2urStX/e8M/1RRcM6eRM0p/fTPyxkrQXwGLUfSxLlLVW1fPzYL2VfUmWAWiawIbU++ukKVsTGapO2B6IuNZWy/vIRhCsTHp/w64RZD2g3CyUvAMHXMuBNCmUgBdQkMWqzj+iNiXR+fWs1htbwvGrP0cneoFqNpERSihHk+gsCbB4bE5xChi4aGmM0eUFTNuZb7/rrTGI3wVtRa20N6alx3kSlgX8xLvKJHgmhfY5f/8oBvAZsYmiddrx5eh0eEpqDj4QMXhMFUO0zxHmaUwkd1fLoiM+BJQ4jpE90ageBfcZKbO/EvG8Y2bXdn/uiXeEJM1/1YTZF/DWIkQUvyIerv6ukk6TSdy7k02L2p42IhJ79Mfe4OeeNDSOtSTJMT+JusvAn2/5Hlog93J28lI+3//USpJDRkfAA2/ko0gN3MskmeQ3zhRIx0jrZXTPxXQzDrPW0ydSVJbOUDoBk8llSXvTJTc7/pVrEz8OQ+vFyP2RW0lEOoHQ01HEXluFERNblaol9073pez1dwHIqbNQtCWVh6hWm+Jmf9PT95lfKAAaEA+iJ6gfOT88dfoOskVU0bp2n39+vBu8fdDcpdo31W1xkSFrvffA9Uo3326BRIzFe+WZQSmBXzKmg7E=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ffNG0uQ8HRAT/lC5s1NPPbWadPAGkgGSYwjdggD7R0Rjt/mk8t2GdVmfgj4l?=
 =?us-ascii?Q?0C0dcOES1sROQKDe9xGBnWA2z55SIvTc2eHKbToXAo5+2C4HZJSWsmmcxBre?=
 =?us-ascii?Q?VwcfGLqgXq3kICDJ6dB3YIwkzzWt/6vHCSrfnx4YmjVYuekTW31AJftSOqnp?=
 =?us-ascii?Q?btyGrt/7SMSoxX+PBh5W54S4i2URl7nASpm8V1Fnta0N08YBCX0V1gbBGSMz?=
 =?us-ascii?Q?hj6VshqLT+kn3qn6uqyndZpVgYjBF0dHESOdDQGZUF4iYoP+o0Gssj9GbjTZ?=
 =?us-ascii?Q?V/i4nYYHjWvN/gv1JvcagjwDxcFGXDnubAS5mH8+MGBs9cpS6AixK0DqMCiq?=
 =?us-ascii?Q?RuK/Ryvc2QnEQhnGtDLI4Jj3METkOajcPJMGWbN0JylG6O3ifMtifBlErS6+?=
 =?us-ascii?Q?zFLdQpa0YFbikL3vYKS7axeguSS5IPW3RUKhxwTEat6sS51Ywj0LPVGjbdA6?=
 =?us-ascii?Q?SYoZMKj2ypuDGAgSx5uGxe4nhb30jDjmJtkhCX/9nLR+J5zZBoep+cBpMFUj?=
 =?us-ascii?Q?v31vAMyw8pFmcdVVc/9Y0n6++/KcCUj3qsuapA4Tz8+t/SXzy9YAyy6fXtIF?=
 =?us-ascii?Q?JF/Kc+injq9dKZKXh+m5eXn01SoeyQawSZ+d8aac62p7b1R7kJQMuMXbbl3y?=
 =?us-ascii?Q?52YIK2a/yzo3OP0MWNgCpCDAs0HDMEJm+d1sl+wsHIFY1PCyF3kW0V09njRB?=
 =?us-ascii?Q?cgvsqHqEaD4XwtxD1KqYxv3BYCNl5sJgpdciyi1IdQ8Z2ijsN84mMeySm9La?=
 =?us-ascii?Q?vagu+SM8fhQYhXPxag/LfdljVUhrLrJ9B/ELGbps0Y1o7jtoekyTe7M2pHyI?=
 =?us-ascii?Q?lxWEUDMgwSCwwO8Jo7K0lSO7lNP7Gz0cCbNwzwybjy8yPQATDhl9W3hdGRdJ?=
 =?us-ascii?Q?9p1S5/iZXT4YBTkE4MU5t/BUvdV7T7nLzYv1x0/m//nLPL2dvc9K2sTvuUkK?=
 =?us-ascii?Q?wyspYK8gyRor/nkOmjD9Ja/lZkeLLDtmdyFAA80TtHpC5/z4cNzOdbX3a/xg?=
 =?us-ascii?Q?j8+7Hiw6CzZvlJsHoLhDYBQAXTOTOs1Q7Ow28aRMppaVhXLCSC8qRV5XYQA2?=
 =?us-ascii?Q?hcEwUIgGvNViX6DxK2ilhAB1w50hgZiWxqqE7kDTpueq2TFB7EKSyxgYNXsg?=
 =?us-ascii?Q?3fBQzfF7D99BZ7mkzgvO48JJwLh5cVgvF3dyMy0Ja5uCusbjQW+0AtUwADMZ?=
 =?us-ascii?Q?v8D0/c7MGHXCGfqw7ZKtCWtp6XfNUlHab7wis+T/f9UnukJ6L9eSLPvmn7RU?=
 =?us-ascii?Q?lRJKR/wuH5YnDQAEGaFzdfBLdy2vo+5G+0qo5jnnwH+V3IY71U4+smC1nYBd?=
 =?us-ascii?Q?pk+OGK2j8TN5L6G72vmcM3PjSqqNF21LoM/5uQd6lOmMujoA6EYKnw262stG?=
 =?us-ascii?Q?18q+VphvNNQiR8p1K183NGH/ZiLBogyiaKcHa5QMvBf+PO7yKZxAP2nHmdfH?=
 =?us-ascii?Q?bV6mf1xJh/26VQlgoDqTxx65ezADJu3TwudyDcrBkXO5mBpNIScs9bGbIHrh?=
 =?us-ascii?Q?8G+9euOxUbWWOEgqW6jKhYLBKm8JdFzUgY1gUsFfosPXyffrVtmnT8oWWrxJ?=
 =?us-ascii?Q?Uw3pVbUn6LghVLX/EZcIQJb1KuxIk4KmOQhrQEwS9QCtJoTNY96QzkxEUbeP?=
 =?us-ascii?Q?KnxImePEFVpw6Igp4O3HRPK8bhlP4q/InCBEiQbk7ECaSQlFo0qN1HvKodwl?=
 =?us-ascii?Q?Sfw6iA5aAfxRdsK7zyJnlYH64enuqVmicycZwngMm87/wAtoP68R3oywLkNq?=
 =?us-ascii?Q?9nWqIm+q9A=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	vkK4chs1CoR0dHee5OFwStDxhsG6jEQ+mG/LcYq3K63T8TVBjrkyRrbf9W9cNz8E57RX0SZs3U3d2OoIyPQ1OMbDv5OGeZS0DBlDxNcGtLBxC6t1BARC85E9OjNR9/+KQywngLlYK/GhIonFLbPIx9J+zhqybNQKJgIEGB3wPG4rtCrCKCCo1eRA7vY2iIj6l03ZUwoTYx0zC6aLsOx8yS24zjryR6kB2K0kp36w1D1W+Ht+hq+9OVvF0fugxJv4osZhLCDV5hH36YAwFmx/vHh9OQftWZcwBBCJepUvuCE77r8gNzNKKHVbWV3M93q9ObXtMb5dkJJ38PbYjUb/ww==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 064e12a0-8ce4-4461-b173-08de85bdb74b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 13:45:00.6669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofY7C8e4Pf6y8zMBYHbOHYEW/zvhst72+dYKSvTC6fGyO7x0tQicmgw11Fh9TmJXbQWm/eHPCuVV/Tc1Hs8O5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6829
X-Proofpoint-ORIG-GUID: RQLl3y0MNlGJqVeB2lnGtHE-ZDpMg5K0
X-Proofpoint-GUID: RQLl3y0MNlGJqVeB2lnGtHE-ZDpMg5K0
X-Authority-Analysis: v=2.4 cv=fLk0HJae c=1 sm=1 tr=0 ts=69bbfde0 cx=c_pps
 a=kwi3Ow37oS+QRMqxGNLpqg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=w01sZ8NriVyBFjpAcuEA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEwOSBTYWx0ZWRfXzXUl4XBiTjss
 o/D2BEo0k0DwbQeqnCNj5fKCpCDNL4yrl6li1pdNnfJEQE0+LriOYD5x1Be0Aqm8OVMuA7tIP84
 sPZp6tNR3cHQnPhi3BINVkhpIhSnEMKlXsgOlFmNI+4edJQccSx1EUcNvoBv5YXdK8spumof97m
 7EFbYvV3HJXean8+8RCSMUD4T88T8FAJCncFIVoeHV6cFVy0Bb0yIGttmBeeFKQ5pHHgfdTP6x9
 SO+Q0tx3iZiAfKBMsBJ3DhJjmrihWelGruyn4b2qOi8yx3JkPWuTy8F3gRFfnSMDE1mc8V0fwzY
 ccryM+S6O3n2fhHPo91bIAgRHMkJlpMCvmG+X3D4l7cHbtOpR0t4V2g/EYZImBMTlEXcRUmY7nP
 d1nyU28Fj5ogXflojqYD3IDX1nGS1Zt1Q0HrJbdh4nmnvYjnteSL0jSdum88ZJ2pN82zkyGiNRg
 T6e9DbIslXIKLj5dWVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190109
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 19 Mar 2026 13:45:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3523

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 6ec4380..245b4ef 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -17,7 +17,7 @@ BBFILE_PRIORITY_selinux = "5"
 # cause compatibility issues with other layers
 LAYERVERSION_selinux = "1"
 
-LAYERSERIES_COMPAT_selinux = "whinlatter"
+LAYERSERIES_COMPAT_selinux = "wrynose"
 
 LAYERDEPENDS_selinux = " \
     core \
-- 
2.34.1


