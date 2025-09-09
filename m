Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0188ACAC589
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 06:59:22 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.6261.1757401156214151968
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 08 Sep 2025 23:59:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=j9E3Fx7p;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=1347b5a164=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5894wG1Y1544615;
	Tue, 9 Sep 2025 06:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=xPGMSdttc
	GhBn9+K49P+KhK5PpyrNSXX+S4j2C38JTk=; b=j9E3Fx7pQgZnikAcRylEpxh/L
	XrXW1g5v5vgGNWyP9opInxIp67FLhkCXDEfYh02OJjvty7oBG0cUMF7FSUm5U9v4
	MkEsG9iDf1g/hkukUKaoIYhzbsySJsoirsHS2SYUrguhzVV1J6qsinfkonyr6iyY
	E6ItO6orMZEvzDlZH/cdRD0TbSaZyeMsarpwyv1LUf3AlfPC5Srislo9XxFlFmNt
	r6ZSVcQz8hR2u+mw2ND95t2mWnVxlOM06UFJgJYJt6oINxxf5InG0vZql/c4L94Q
	nyQaKzpuydKQUvRWvkifGaFL3nO2OTfrKB775KuiIWlc8oKW/SoIzrPrhxbng==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 490a5w2qa4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 06:59:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0NH6IF5d8u8dN1kW8RoZIAzh9HtfF+tGjP3g5fcpXlI7gVeD/IOGVC6BeCnky5hPwqrPIr/d786AqMbiYf30MZoOlhTowsLnTWXRQjQUHpe7QrdZmpWBF9/qOyDZtc3I7grYxQ2H4/UJhgOWi7+qoS2PFrEcgr7Rk6UhZSKHxDFlcFQvqRP1D1fnK8yx+gF5Mf/GDJuu85al4daqUgHlS35glTXA4piThL8fp9aoSn9ODYY8ErhYhGSOXluOdEjv1vyJ4/JB0qalQibF7y+VejEgnHcXijbOt1QRgQiz2L/K0ynSDekRWCWZ2J61RIHO5HAmvw+kf3DFGpi0weMRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPGMSdttcGhBn9+K49P+KhK5PpyrNSXX+S4j2C38JTk=;
 b=XmZOlLfNkthuapNRf9WBd1zMQgEwMtBZcFrK7YRLfNNHK0fNlwrbL7Oum/nirhru5qw0a5XvD7l/MOGaJFvY3x0iuXYzU1a6imWB5MwrnUZzE7DpQiOwAtleWzLAAzVfePqJHDtSpCTmEn5dH1zLKa2qrcGNGbUIrExhQiU1ZwN2V246PrAIWMtz3b+tP0Qld8B2Gr5TnTSCP5APecyyit+BATEmXnC0q1DHea0mojK/1kU2A6Hdx/KYh2FVEfg8eT9zUnVyXJ+9WwGYqnvM1unlnGAmE+mTVVyJeoN07h8Hz/IQ/vIpV8WN6tF5/bvfNWNxvRZloaAjB3m8xFsAWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 DS0PR11MB9454.namprd11.prod.outlook.com (2603:10b6:8:28c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Tue, 9 Sep 2025 06:59:11 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 06:59:11 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com, rybczynska@gmail.com
Subject: [meta-security][scarthgap][PATCH] fail2ban: update to 1.1.0+
Date: Tue,  9 Sep 2025 14:58:53 +0800
Message-Id: <20250909065853.1959573-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0087.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::6) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|DS0PR11MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: cb839514-139d-4bb6-3741-08ddef6e6104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YyJ0yylwXSQzPOhr5qh6HJ3dIZfSntw7L4ucwVm0VUOOmWCeDnFKs1V6Ik/9?=
 =?us-ascii?Q?oRQuOih5WamWqQ0HXpajSwtZf5Ri2fnwus7Ps+RVQmnwUrQciJDjB87Q0y7f?=
 =?us-ascii?Q?iLPtYlnzjbcJBWeWYk/4VorW+6UFT+hjT7nyCtpVg+7XfH2YB6zpIbA8rjVo?=
 =?us-ascii?Q?xDupGAm3wGqM9R0WWzWpeGjULL2vkURiYIXr+QW3xbP8OesHkbJN3SXzZqzm?=
 =?us-ascii?Q?XhSRSqjBo6AGzJEZ+yPFOLwIwDav1LbpuAF5lb0FBP5YOC8DXhrB50qGkjgu?=
 =?us-ascii?Q?ZrekD8zFsnLPp0aSR3ozE4tECcLmvF/9gPTeRtmluKQHPpoedUVri/rWmBXr?=
 =?us-ascii?Q?7Nf3ZapbGPH78vfEPNTs1Tjj4BRmi1k4F6nqwLo25KZ+Ubu2GxjoiYIPM3Lt?=
 =?us-ascii?Q?pQC9tWgiJ7ZVJeKoa/lxcYXGg+fdVN2OWdAuKAfnbU2iIN8QcegBE7x6e68m?=
 =?us-ascii?Q?mRhNyRFPKEJH8mVLJAWJe698VP4B4VMSJKhrYHhdEIHnQ55hSaWVnakTS4R1?=
 =?us-ascii?Q?1fcjC4R5L7RPsrlPl3/nfcxMvEZtnOc2SLHyL9XSgtMJD/nL/K/Bh954eO2Y?=
 =?us-ascii?Q?T05euk+Wu0wkfawu6ZYG5kRcVm8nF6FHUPZgq+RoOZcFwdO8sXubU6D6ZvPM?=
 =?us-ascii?Q?R1B4Zubh6+scMQE+rLTrZCqoAl8s0GqIuL07xrFk9QJFRkESR6XDQwLDfg/6?=
 =?us-ascii?Q?sNBBkT/NlkvbcKgf7BFP9hdzn+BiTZoTu/TjEL+T4lCmqh5J01g/M+YPkc2a?=
 =?us-ascii?Q?clM7x6d9Wb9TCIbdg6qYqJEoH5peSzt2PrynLaw1ac+D4YZPrrIVdaXcH7B4?=
 =?us-ascii?Q?Yj1Aj9RHQepXOTh5nFbBt3DMykdfOv5LkP3cq1p06fj/jDhKYjsu55KNgxpM?=
 =?us-ascii?Q?AIqc7e9Nnb7V/e+EHRop4ZiXGOSh0/3Uc6+l4woYzPkiDElQFp7M54CSdnuJ?=
 =?us-ascii?Q?NcmYxTtIR0UDypzIB/yD2mH7whYul2ZmDoLltpzzRJp5UoE4VDnXPfyQwNgK?=
 =?us-ascii?Q?ThsUn2AkXLRx6GvkVt0Z1TFYP4SlD77nQZLXK9ENgtT7VH77oAcX2zBK4UEM?=
 =?us-ascii?Q?Pndk56DlHaACHalnggjEDBQwqkeY3OdFLoysUadHvlrGOBRJhePfeKffPWU8?=
 =?us-ascii?Q?st8E6GFJ9GAkvghqp3E1H7Ozl5YQ7J/esp2qCupol/HtOeWb7SUaOISpOmbw?=
 =?us-ascii?Q?ulC4QOgC5mqpwu7IVBWJXcUELXgovFCq7b3gl4Lts2FKsX9LwUzuKrwCADk4?=
 =?us-ascii?Q?e/h0PmZQFwBQSxjvXghipgAaA+wHwKoWNEVSOuThg9sLbe6Y4lyAwVhWozU3?=
 =?us-ascii?Q?JR4/reqyQCOh7QxYaAZE32lBhhUQGlZw25WTbyP6TZF0sEU2Y3b7Dy2kh46l?=
 =?us-ascii?Q?N2m9dJwUN7ZF5cMily1N7A76Fyun6EuQG+1KoeBDQ4Y4rT8q0czC+PLsFFY+?=
 =?us-ascii?Q?+rCDAw2tjzg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PQ2fzp625oynbBB9XyxgsUkTDc8R1C1qiZR9sbB8QUOOeXIWBxJ5jpdkyf1o?=
 =?us-ascii?Q?HBO9uCtz5mjq1UdS0pyla690RrkXBvg6EWiLWcwkE5cGzyf81NFpdrp7dTcS?=
 =?us-ascii?Q?EfWwc3tUZXi2/VNuc8A7jLFZ/ELLXixGEC2mUtfcy/BOgl+6/K1oSkwQohRV?=
 =?us-ascii?Q?xg1cW4CSb01BTFWU6K6QD55aU5jqiyADcOOpTFTA619OQ1/kyY4UktJEgkvs?=
 =?us-ascii?Q?jz/x7LQp24HbnXu1MHniMUNzn6bvDPAZjQ/lNw49Pw7/YNr3wU2/2BWB+Tzf?=
 =?us-ascii?Q?Cqx/SZnV5YBED2dQ+vKcT534sMuSBTA3FFmvaMQFTIV0WqFU6H90AnUbjkhb?=
 =?us-ascii?Q?sgoGIMNiQ6x4W0Gx7lJhk+4uZTtoDou8oF+Wl5XJoDA9yhVhiVbkQ2lBgyM3?=
 =?us-ascii?Q?FvVXvVkY/G3V4VJaJWGI8VeiGd2fU15ippENMbWvRRBqGuJIARrfbkD/cdH+?=
 =?us-ascii?Q?pNgsaluIDUkmEtERkpz1mBYJwtRvjPZstMX4Z/ffjFMIV+OYL19VrrsPrmMJ?=
 =?us-ascii?Q?jSyRySFmeXOlXiadnJqXeGjHnuRXu8ThqMDO15+Y1mxlpPfSp1iCQpdQhn5t?=
 =?us-ascii?Q?7Go8FOh6JfSs6n5jXUBQXMRQihLBkPbImETnkhfWjmsDlk7ltixNf0yk7dIA?=
 =?us-ascii?Q?waQK/NpxtoUvR0/rj4EDwnnsONDK24u2RQMebAiDD45M37s6UuwXz6PWvqTh?=
 =?us-ascii?Q?7Qq7yyvGNda7G2OLeGu6P5VtJqLkWXPgyPxEpZAn7cPzu6mfkYq7sAXh1qDG?=
 =?us-ascii?Q?IuhFe4AXJrIy1y+FEk6+EgDrFxtrTsgvs2zQH/mlGKtEeOEzYkm7hnHTHsuO?=
 =?us-ascii?Q?VnHq4jy3OC8XFR1MI+cOWtvGRGypRgLeTZwwp0PaM06f+ViiaZpK5ZKKU8+6?=
 =?us-ascii?Q?7H1Drr8IfdAiKcUuBXt7P+iGim72ClspAb9oyREqE0eFQOScVUoo4vElva0D?=
 =?us-ascii?Q?knb+9xd25ZihEfvHJMlyATS6bsarHA6Gb07gvb+5uMKFsW2oSuLaT2cDjpx9?=
 =?us-ascii?Q?uhVN6Uid5jF36uvqK8RI1FJulskVTkgneDr6V7j7u4dN3CGKRt6Iv3OUZMuM?=
 =?us-ascii?Q?IE3uhqn1Vqla/54DGCguQyG5vW0h/YZr2G0BTrROUy8q/Kk6fFS96pyz4KDv?=
 =?us-ascii?Q?bW3otfm5MM6Je27N3VU6QpgEWZBZpZ6ges9wNBfAUl32R47zERoDiKYAFtW6?=
 =?us-ascii?Q?ClFHoR1kb6JZfFewXe5+NX9yOQqJ2EXcOW0CevtEjS0jeueFN9vMnghKqWMh?=
 =?us-ascii?Q?F67dNUYoXE3d1lAAZ0NjuC+TZ0HOA0dADkrsNAIkMKYafnKNmS3t8IwMU7Vh?=
 =?us-ascii?Q?VWHZxIUyfGasOcnOJri7DULuAam1ucWCCZChyC7o1aB1cVQgaxsNCuzS0bwC?=
 =?us-ascii?Q?dmJz8LEclyXOJ9eRt5fqtaHTwNB8PCE+qfMbxyCAZfDjwcENtScaZokV8g4o?=
 =?us-ascii?Q?sRn0DbvRSO5biYqrWcQr2HkhfeC6PS0rUQiX/zYDG7v12k/XTmbD1bmThd7m?=
 =?us-ascii?Q?Ufw739h0JA/xrYW8ygLQ014yONttP5oQFG+EUg9aDXSBCqh0LD1w946xQXkX?=
 =?us-ascii?Q?Zaf++33VWNRt3z2SGSkwzsoBA9JY5DiRMpVmdmEW?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb839514-139d-4bb6-3741-08ddef6e6104
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 06:59:11.1311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/nEQkTMKORBzSvMhx0P3MOLCfvU9ppYYQ/RR+KvhMbLmh8PXTQqZqGs6atOzGRc/VGDcbqFl0ihCPp1pojCsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9454
X-Proofpoint-GUID: 6ams0eiaeoLcqneo1EPkz2ApgtrzL6Gk
X-Proofpoint-ORIG-GUID: 6ams0eiaeoLcqneo1EPkz2ApgtrzL6Gk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA5MDA2OCBTYWx0ZWRfX+voN/j1EVzyN
 Kg+bImmUNH6NJqIx3Xf5cMrNM6C1fYRdDtpdyUCDkZhzjkacElABRVikN9gB4IqVYK5+d8TAPc1
 sVPWsR/AvXyCYY3LK9vmRyU0ToiGHuh/TJo6KzEZj7o60RdK9H7WF0DNYui3y2z7+dehsdH/am+
 8QC2s/LsS9sqISQcSy119tjJgspfElM42+7eSna1JtlWlaGyQPIqfWuczMcel39JZVQuFKqJrrp
 C8EGH3hdRnvFJjuTWeZSFsJ/3+c2DEqXCh0+I7YsOWFJE/hLdAPrtAot1qYGDKNZtkdXQlc51W/
 t4/iiMIIccDND1kTt+P0j8eIfhA6fHXuVLXjbYcoGwt5UrYVKhBC5zEqSm7PXw=
X-Authority-Analysis: v=2.4 cv=AMtZH25w c=1 sm=1 tr=0 ts=68bfd041 cx=c_pps
 a=aLy/yOIiKxSZstcXcC3bSw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8
 a=NEAV23lmAAAA:8 a=DBFNHPHWd_k0W6Tq-SUA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2507300000 definitions=firstrun
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 06:59:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2148

From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Current 1.0.2 version does not work with scarthgap or later releases,
as the asynchat module has been removed (as scheduled) from python's
stdlib as of v3.12.

fail2ban 1.1.0 also does not work out-of-the-box, as the distutils
module which the pyinotify and systemd backends depend has also been
removed.

So update the recipe to point at commit ac62658c10f4, which fixes
those two backends to no longer depend on distutils.

Upstream's out-of-the-box ban action now uses the 'nft'
command. People can still override and customize that in
jail.conf/jail.local, but to make the recipe useful without
customizing things back to use iptables, change the dependency
iptables->nftables.

Since 1.1.0, fail2ban has been python3-only, so the recipe becomes
somewhat simpler since the whole do_compile preparation step can be
removed.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...fail2ban_1.0.2.bb => python3-fail2ban_git.bb} | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)
 rename dynamic-layers/meta-python/recipes-security/fail2ban/{python3-fail2ban_1.0.2.bb => python3-fail2ban_git.bb} (89%)

diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_1.0.2.bb b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
similarity index 89%
rename from dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_1.0.2.bb
rename to dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
index bf5f87d..1d0fb62 100644
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_1.0.2.bb
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
@@ -11,12 +11,14 @@ LIC_FILES_CHKSUM = "file://COPYING;md5=ecabc31e90311da843753ba772885d9f"
 
 DEPENDS = "python3-native"
 
-SRCREV = "e1d3006b0330e9777705a7baafe3989d442ed120"
+SRCREV = "ac62658c10f492911f8a0037a0bcf97c8521cd78"
 SRC_URI = "git://github.com/fail2ban/fail2ban.git;branch=master;protocol=https \
            file://initd \
            file://run-ptest \
            "
 
+PV = "1.1.0+git"
+
 UPSTREAM_CHECK_GITTAGREGEX = "(?P<pver>\d+(\.\d+)+)"
 
 inherit update-rc.d ptest setuptools3_legacy
@@ -26,16 +28,6 @@ SYSTEMD_SERVICE:${PN} = "fail2ban.service"
 
 S = "${WORKDIR}/git"
 
-do_compile () {
-    cd ${S}
-
-    #remove symlink to python3
-    # otherwise 2to3 is run against it
-    rm -f bin/fail2ban-python
-
-    ./fail2ban-2to3
-}
-
 do_install:append () {
     rm  -f ${D}/${bindir}/fail2ban-python
     install -d ${D}/${sysconfdir}/fail2ban
@@ -66,7 +58,7 @@ INITSCRIPT_PARAMS = "defaults 25"
 
 INSANE_SKIP:${PN}:append = "already-stripped"
 
-RDEPENDS:${PN} = "${VIRTUAL-RUNTIME_base-utils-syslog} iptables python3-core python3-pyinotify"
+RDEPENDS:${PN} = "${VIRTUAL-RUNTIME_base-utils-syslog} nftables python3-core python3-pyinotify"
 RDEPENDS:${PN} += "python3-sqlite3"
 RDEPENDS:${PN} += " python3-logging python3-fcntl python3-json"
 RDEPENDS:${PN}-ptest = "python3-core python3-io python3-modules python3-fail2ban"
-- 
2.34.1


