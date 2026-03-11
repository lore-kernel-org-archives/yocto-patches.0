Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFA1FD0625
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:36:26 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14664.1773210984662638257
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:36:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=M6PCvHij;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B5W5xk591950;
	Wed, 11 Mar 2026 06:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=HSdBEaLMuZxEimeuPZyTMklM4Rx9REu278g/fVOyl+4=; b=
	M6PCvHijksygnJMjGjuVG9OSrxLdGDD362vecYZNqktbqaUE0ADIVIKJOx5eFRgY
	i1MgTmjjNZRVrUwi4fCYfJn9Ogt14L/WmEET4KPCJ+RAZy373DyWbOhRIsU61uhi
	ZXIHdlm2uwoEXr/RfB9m7hlzcG1Nim4prz/Vkf/WI9jZXUpE0ANbFaowGj+8cZUY
	F33FWB7LxDlB3qvWA6skhFcLZCKtNtbyVYqzEUbfr1maerCK88qEikI62FIeT2z3
	5klkjCxJqyIirGEfyscgd4+kjAEOeCKf6jzlFCDksS46Vkq2Put6rluiKxCItVtg
	v0SImVo8Z/c9xiY09ejTOw==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011064.outbound.protection.outlook.com [52.101.57.64])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty578708-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 06:36:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxKfBAtBsnQJ0lq9JwIGoNY3KLdp8HF/XvEsx9WMxD7PC3IHOuqV0ZVvx6KA9Vhtv/nZwXstr0cQ83dndBFZNf+ifmL8F+l8re66EM/4mUO8MmlRTNTKMTjkvj5Fih/wTp7JFOzj4W6gnE5rRV7YLnJHz/OB4JI3991d0I2Yf+N7FgPumchZcqU280GZdgTUynzZ8inPNHC5xdlJ3nrord2UbK/c8nuyyhD36v3Eur52s3Fs5lloI35qKOtoTZsmb4wKQB6nqG4KuPkH6qI6HNZnHgnIM0v0cM2HkS/lq4+Pt5QCo/oGtZgzFaNrEVAD+BXF+1UKSBy94A4coqgQiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSdBEaLMuZxEimeuPZyTMklM4Rx9REu278g/fVOyl+4=;
 b=shNg50EclXtbycAyiKQl1vW4o/2+n5qQvHNQ3mT35KFNsmlf0bn23O7XRJio5yn3HEWZ5+2iiiVNLxWexZhhr2hyx5zAdICvzSz5WW88D+t9jfSy5oSMOB3sd+d//JKOFGqvn3IbDgLIEQryo3w/8CQ5ID/2yA0aLqzLbui7DgCQKVldbceuuF7pQISKWzk3aHTCHBnJJA2dgPBW6NtAihkZqG+ccYhJ6zuBRwujfiJckBY02325j5jlBJiAGTPFlbxiPaRcrOLbQHEnk3YXA48KkPY0gCHGKe0RcHGNX8WSpHSMjRjz9cIvEySjhGy21Dkbp2WxU2xGwwWLNY8mNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB8787.namprd11.prod.outlook.com (2603:10b6:208:598::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 06:36:21 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:36:21 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH 04/11] modules/utils/git.py: use warning instead of debugging logging for git command error
Date: Wed, 11 Mar 2026 14:35:50 +0800
Message-Id: <20260311063557.229656-4-Qi.Chen@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 36204109-223f-4882-d3f9-08de7f388243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	sM6fmwbU50Qsw0p/tCjHFdVGcbdM1IvMEDBOE05XR+F0w/EwccjoP6WJj7p0FSHG0iKxMtYm4+OoAx/GVrOD6jLRQQwpf9qisHqSRW/tvj98PRLK6tMXVeo94c9s6SvD1X55L+pAsjZB3srZPRDOZORpOO73ZhdVH1KRtOhZDH/6johuYsWy5suV0doTwdrZb4hZShymD91fjTMI88CDtHF25iNpKibgmlWVF7bpGBLsD1P0+eL6YSYPE2P8M5HwbRi4hpPTlnXq7t7VIqP+5eLMWX9PpPIROY3il+gF83342P0oCdf2SPfvN3qFv37aVjJncawg4HnEy8bwzQA7nt1FKBmDZ2ij3ycQL/75uQT/ECJrSTvvJ/GHSLsiVzrfC/HFGvQXM+kW6WQs6GPUdLrYAChZSoh2wiJgJGALvspO8wzVQyS/Jwuk7gagVtk6pur4IvvAYgMoBMLkj6v75TgyqjgpzznbeBOhJIUE5Ym6SoT4ImFs7hoPY1bFVIZbZJT4YVmrxcdfIQc+Dxx+TloXu6+cLYBDKkopAr4GfbdcyF3ojdU2VXUAfvkIWgMc24lglE1UAAt9HqxfW547bDoO9VXh9J6yz1dLWteDE1Y2caZlq8ywQTvsvJEc67sFLYsc9cDnjoaTsLkaEa5s6r2bDJ91r66WQ7LuDpPNOY9UbT/MFlyp1BT9tzkQA3a4xx1LvJhe5c2P3T0S+9zSTwiBdUC1GWcWzP3jGYq2xZqJO+TXynYnTQ7Cbe8UAvYvqAODXLP13PzEM3A2OV+f7hFCeCPjXKYpdVAL5U2blgg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?H6fNFpByjgd48CvnWE7vZigA8g2mmXG8eW62O85xV+BtA8ktiLhvlzbIBDnK?=
 =?us-ascii?Q?C7XB7VPRf61j67HNfA5GgPwsvqc4T8LOi646v2ygzYk+fozVPmco+h2DRxKz?=
 =?us-ascii?Q?CBOCfP9ESJ0z0401F6YoGCWw8nWWpUIs2ovZkJANGExr40i8a2riwmfnB2ol?=
 =?us-ascii?Q?QVwdiwm+X2Yh6WORLxaHz5xXA4NhaskksGfIDWvgXWZ7hIkBdf9TMZZAEPip?=
 =?us-ascii?Q?zNskWa/fk+BfmnijAkBfDGAxK0xXKyTlAxMM8V/IOaP/99fhXytk0iI3yg/H?=
 =?us-ascii?Q?icXEGKUvRIkCo4md/5LshsXpKBCIj6SeZGXCIlwFAxibQ6NTbMtedW/VMBFa?=
 =?us-ascii?Q?FpOwJDhtKFQgencY++ptiTQwZYa4lXVa/o4Ve1YugeohuNTuYgGK+s3ADo/J?=
 =?us-ascii?Q?WECR3/XLNmeTz6LmMC1B9yQ9UIEAJBC38vu2QHpVUs22vVAYa/nYXwAcJVNy?=
 =?us-ascii?Q?qTzjN+cudrIj5DhyvDXaLnO03tP6SqbbYjfAXmO/g96JspqzgzDrP/pJmjb/?=
 =?us-ascii?Q?+sQqv3QiPqcXfI1MRQsR66h8uxfKhcVeijiOURt2LPMluCmxymoTVsYG5QkK?=
 =?us-ascii?Q?mg1Pyvo3Jynkm9WFeAX5mfkNIhH8g4w77J91D0xPYH9dK3lcPU5zZG8AvbcY?=
 =?us-ascii?Q?all/VOt14BLK5nxhXulLYpLq1eBxxzSdIqhq4ORquw474MH8Tq/3mGbuNw/J?=
 =?us-ascii?Q?59GQKWY6200cjK6COYjJbR6eecSb7NboEmt0OAhg/nfRM6SW2wQGmwL0+bwQ?=
 =?us-ascii?Q?QLyhnszuJgZuqnI2Gz3NiypdVY2l6lYZsiMOAN3PXK7Wl53xDfeccXtQnt02?=
 =?us-ascii?Q?6Rl3Ira6SaFkN3JYQ7Pq5x7ZBd6l1PDBEEM3F/UMCljOaVOZ1bOP0Odf8DMe?=
 =?us-ascii?Q?i4cfczvZ2MpZtK8QIQe16abEFkN1Gn4LbQnDWUEGbzMcmxuau63jnwZDm6jX?=
 =?us-ascii?Q?rxzDwiE001QLSYm92hhtth4aiU+SOHlPevzhNAdCuBdQLB99CX1f7wO5kS6p?=
 =?us-ascii?Q?uoxnd1dQecgRCxYNhgQ8z92dS+NDkdr9OGRIQQRKIKpr+kIkm1KdO91nTUr8?=
 =?us-ascii?Q?vAVR4oyLA/LhjR4mrWTeomtZDGpZyGXjAaBqykgr3prxVmoCjifQJZ7zSOrz?=
 =?us-ascii?Q?/mt+oMwrceVUqwZw3C87eb9jj+maCqVhUWDAJwl/8MrUQGi3+KqTgo/hSJKK?=
 =?us-ascii?Q?F0I2K2X7XHq8VGBZchZJfFcJnJY1L+r0MMW+wjo2fcvTkhTcaTF6WOCb/Uie?=
 =?us-ascii?Q?QMt8k3TRvLZW1SxopiTYxO4pjiC7sknG3dl8jyviSrQEN4rTNwXqkZzU9+KE?=
 =?us-ascii?Q?7LcjzI823BOYo4/XYbdcM81X9vPCft99WQvA+wYhy5sy/nKsUM/a4IWbR50a?=
 =?us-ascii?Q?hsrFdlvZY/+9zcDWMj3VrajouDd4fkqgEfKvv1PujCS/eYFjOpaNbEvhrNIN?=
 =?us-ascii?Q?3woztaCTsZS1EXV5F8SKs+tHy42VtpL+vYkCmBKmtVnIjLmydYcwKKRDtw2d?=
 =?us-ascii?Q?ChhuflGAKaRmuE0pGAAepzJWf9c6YkOY/UlqfG2p6gjPpLE1wCXJH4Rctpd2?=
 =?us-ascii?Q?iwsRw5e9leY+H7DHD0X6aQCsoKQIKy3o6WNJAZMH7zOnCf224M0swxC7k2SM?=
 =?us-ascii?Q?+ISvdzoUet3rQfBhrGCbh940ozUcEa9UTnbgQsAAIxa2R3NO++IooxWCteag?=
 =?us-ascii?Q?UhBizYNKv+vRfGlgSf+k8NLCOoxu042lODViiuG4LOfUK3OusJPDv2iN6HZ7?=
 =?us-ascii?Q?gtjW40N/dg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	O4glQcxJfsUAM4EZy2hlFdKua/vjVT+kYBhxFFo/X9jjpKfM6Gba5m0OSGhQEBg7OLNEIiD0jnZssNzqwwEu/bE8w95Ygyhzo8r3b86PrTqmt0Z2SwgWG0vBXWrzSOyfQgOO1pT9tUGG2vsFPsdvaPrCs6mr9kpDZipTwJMns7ERLbUSHdT2kKQb+Icjtwk1Poecu6e5MLy11YjerG+yG7R1nn3byOXC99JC8bjyS3N3b20niiWwnfskSRB6oW/CE17wzxerfyu10kepjB81917YmhVsxLYl8t1JyLo4kW6/Akz4bS/XIKESY7+tNlI8psPhbdfA6IsqGISg7wOd/A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36204109-223f-4882-d3f9-08de7f388243
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:36:21.6443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8uvSQbYlH22HGG3OM72h0X9K4+Wf6f6VO7IqKamRZUmqEsSnuuZTUwj1x125dWIhqQBQCK0ea4WveS4RYlvJ2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8787
X-Proofpoint-ORIG-GUID: tL5YnUtAh_2fUQc3C-glg2IhWZkHZo2-
X-Authority-Analysis: v=2.4 cv=fpnRpV4f c=1 sm=1 tr=0 ts=69b10d67 cx=c_pps
 a=pvXDubuVmAGz8fO+OL2vfg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=vHUYwgvStcVnrVGJbo8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: tL5YnUtAh_2fUQc3C-glg2IhWZkHZo2-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NCBTYWx0ZWRfXzFGRRVJltL8Q
 GoWSlx/l2tkzln8tR2DWMZ4kcQ1e7HqvNEGvyt4dVkNZE9aWh310TAdOPcxtfR2Q5XuPmqSogLw
 fI6FHtjbp10LMwe5QEGW5G/b7b6/U9Rnv6bK8Y3PciVVnUqYs4cvo9ZSCDgWkBC7hvgqTKETmmC
 nfmCibFMcdq3mUMLYb5s+b8Z/WVhzuZa19KZJbPYwL+TanG2yUCXZp0sjQL46aK/EQ39DzqUQDh
 kQlxDqiINSNORq+7VHrRDmVz6bUHlOtTB5LGV/xuAaK5E5TbR+RBvnQQDVnuZpZmrWQbyp1V/SH
 zTDk2IJS8761iitizcWOayvsxfFb0c+CTapmmlNMxjKYxCqLhGy2lWgsN39fSvh9cEjjhLv2ght
 /oCFyU/2CIRJCHefDWoX+lgP/Pk7IdMnbD+7m39Lo7s1c3C9NXni6DuKTCDCRfK1Dous/z+0W76
 UDGVe3fpOL10+9GSknQ==
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
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:36:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3405

From: Chen Qi <Qi.Chen@windriver.com>

git command error is obviously critical and should be presented to
user more clearly.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 modules/utils/git.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/modules/utils/git.py b/modules/utils/git.py
index 3be75bf..0482d26 100644
--- a/modules/utils/git.py
+++ b/modules/utils/git.py
@@ -24,7 +24,7 @@
 #
 
 import os
-from logging import debug as D
+from logging import warning as W
 
 from utils.bitbake import bb
 from errors import Error
@@ -41,7 +41,7 @@ class Git(object):
         try:
             stdout, stderr = bb.process.run(cmd)
         except bb.process.ExecutionError as e:
-            D("%s executed from %s returned:\n%s" % (cmd, self.repo_dir, e.__str__()))
+            W("%s executed from %s returned:\n%s" % (cmd, self.repo_dir, e.__str__()))
             raise Error("The following git command failed: " + operation,
                         e.stdout, e.stderr)
 
-- 
2.34.1


