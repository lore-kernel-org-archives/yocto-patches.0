Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9F7FED2C4
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 03:52:44 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13954.1773287563692958612
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Mar 2026 20:52:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=CgFNNyot;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75310a015d=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C3pA0h2877391;
	Thu, 12 Mar 2026 03:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=1OZmoIrr8mddurH6PN9sKyMqrFhJCFfrm7b+tWGVto4=; b=
	CgFNNyoto9vxOoOsFfL+72n9nrCWYXBonWo9KT+q1xLiWTbQicTAKF+0iVVkr1++
	JDcKZBBOOj5E6M8zsCqyQe9TAkgQf3/sCSTJ80QnPCXixvQWRiI3rzMBsBPC8Lsj
	9tR55C3Q8Pm4dfJcJtxM02Y8n5bcEYDZgcWzYDfX2u0h0okPv9EFZvUa5q85tcDm
	oQ0Uo+2eWKJLeoZXJW52rqIr0xnIXjgUivS327HPNFGMR9DdbslJWfaxnxVNJ9Om
	D1SUyoMKOb7K3vr0BG9yq+LQBY1fyAEXpA3CDjWDd0oHFj0/4HFjK2MDX3jrcfG8
	AismXuBjLg/F2yjOQ2+wsQ==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh78g75x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 03:52:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjCZypvNyoMz28ucNHrjf+jqMXjTtIhzYZePSUYcHfuea8gZqTw8gDYpTZAIKv5Y9qZlMogSgagrbLB8qzY+SGVBN2HX/58s1H9ZWU1qvH9W4Nf2XRdxqNLb13e2Qd74H61VpIoNazkZhSuvBj0hBkbQpuJiV3B9iDW0fV3fs0lCCui9+nmmmAyIgSsCVHOqNJV3d8AlQHp6MDroZBtL3yCDsng8sbb81ytCOwfl/8NUsFKLn9kKxm2cNFBSRvsWTTofEQ+BIgceToo4ONCWxV5lyNeSk2/BzIwc8tlEm0wXrf1l1JgriSrpSKa7dH7WuHLEDtsPzVS4zcfPILepmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OZmoIrr8mddurH6PN9sKyMqrFhJCFfrm7b+tWGVto4=;
 b=NCWvHVkB5HV7IwD+wvHj74jq6Ec9Psze2KoC8tWw/OGhv+2XWgVOxOcXuCb7EaC4l1BVHYdJLV1Uh8n9e6JW2jVDEZaEc/EbotBLOAbvarde8FEgOPgS5agm0s6a9KVVHEtdQtpzo0EYTh3ht1Qzgi9RuBwqr+56ShPYGxNxHSRz0t4ouHwgSvf7XA0WxLaT64FDtsGeuIjGyFANT7Kmtwso9lkT+F3YQUoMVt8rKF23+oim+YNEEM/Wc3cvJ4zsVuggWFlLjD8Yy+p85LWK48mbW7u8SAbuUrZ4M8PhR7iT9CZZhd1ZhGGejuMyWY7gzXDNUNF9DKciHnEpp55jFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB7942.namprd11.prod.outlook.com (2603:10b6:208:3fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 03:52:31 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Thu, 12 Mar 2026
 03:52:31 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH V3 02/11] upgrade-helper.py: use scripts path to locate oe-core directory
Date: Thu, 12 Mar 2026 11:52:02 +0800
Message-Id: <20260312035211.745546-2-Qi.Chen@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: f89479d1-0eb6-4157-856b-08de7feac961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	bKTbjnL08cGadG3+i4xwVoOd1J+crYAt6rfiFqpNC/3wJwu1WjPqKDUfqc2n/yTZwpTAPF8xX0AaUocGbWjFGyD58SY/Uad+G3SrlddEgRWbFXYCNWflgjo3U8oEcbOpsV91hl+VyY8M5opCMUoiDs/EfihCQRrJxpGqqSzGK0rh/dzi0OSmyaw+SL+qVstjCiaZ/Xar4/lqEPzCnDyMe9Nlx0bTKFErkMdCKYOWU+ErCxF2RJNS6h5FNon2f1DtemMhGwAZKmhmvWE9b0DsknFvNoMDpWn37BPJT9ZsfdEx6uvx1vzafFknQXcCedEa12HlTIAxaKKTzp5rWIwrS0Q11QZ5DLRMwAqz07yTYEKTczrBxJ/ijpJvAtCRVOuoa3uYis2Cvgz9u01u0q8Not5DaDnQLi3LGkrr1Pg88LkX25eZemd/0xhiwpgFnyf26ZJszcJvekhhEwFqRsv7P9s4spC5CBc9Clxf5w5nd5du5+XOKkzBzS+Wd7aKHlLsUkExPSm6KFgZFQfx0qTTyZTcBYzFvAtjon68PwRDO3lCa9Vvhub+WLRpLmmGT7rSUVooGK0amKCqxKB8u22scfDaDPybtXW/6ZPMDZgdWYtyDYCCIuUHuk2buuNV8F9aliyVlbhf8pfJNKqS7OQfOhL99ZSA8wJ/9oGPLarUq/GmZewdiRVdloM4fQT2ZA++dQ7RZa0SaZWy0r4BVjbz539DD04+O9xATsKnkdF0gd+nFrVcPz2biWrwepkoLURShX8bn4TFjL3vgfNu03YK3G79dSzf1Qk8SxSHE0rsZ7E=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vU/VFg0Z4Y220KdPP1dEWKsgnMw+4Xz2BdIA1aEbPeUEUYuMVDeA02mW/EPI?=
 =?us-ascii?Q?inpjZw47wPqkBMPgmzvMsPcNi5c8byLkviTv/JxXmRaqk22hAGMlZ76J32+1?=
 =?us-ascii?Q?AQ280SE1nfUZBOQ9jJxntRQhoxo1GkNQoEOTYv8bbPNx2pnVruwF9m31LLOv?=
 =?us-ascii?Q?elFwvxbcc7qy0gvZm5EGznUUNathJeiZaxLYnV4GEawd2c+IYlE67wsIMGiI?=
 =?us-ascii?Q?qGoTYCtPhLe+WSFXUnGsSox5J9t3DCxF0YUYOKkGiqSHAFzB37wmD2Xk/Qc6?=
 =?us-ascii?Q?crpWdOFLZSWiFHD6ALBXDvNMSpQNc1tC+bH8JCc1jfrs/lTiB6A9DxCv5oy4?=
 =?us-ascii?Q?BmzGnX2BFQ2b1hVG7j3D+7zjh7vVCRIS/QjbZ5XyAM+XEDxM8zwIEOHVBWaf?=
 =?us-ascii?Q?tgqXRz9ytS3o752NyeLfKv7a9kqw8F7cvfSMgOTPV6yFNZU/3bw2X67yqbC1?=
 =?us-ascii?Q?3IqL0R6zG2sQClY+OSL0MdEGQutXQ32IAVwJSfEwKKkJat7hsRixexlzajRN?=
 =?us-ascii?Q?DMSDfVHfhqx3GUCJHhqyQA8Q2RcPynMO1fE+jiZa0JJL0jcFS9Eb9rMCUjFc?=
 =?us-ascii?Q?tmHQDlEgWs9lrPtdwr1nt53g1CL71CbEvSAewV0Zh62S6oy/S+TpJi1DJt3l?=
 =?us-ascii?Q?7ulb+Lru3vF8Rx3Ak6QqU09UYM60tfekKf22kwB/IQXarPjdhu9hQSqJ4MZg?=
 =?us-ascii?Q?Fvv5nKujREHR5ECanhMVgTkoe79ypTB5cPEcpK1JFdPySVM9wKdn/M0KxjB0?=
 =?us-ascii?Q?X6X1dq37icwFa+NSjjsmwLjFif3XsnQQWDiuVrbkKn1ZXd/6BZ6QvdLp2dZQ?=
 =?us-ascii?Q?txYvX/DaFZBuJ7ZW18tywP3ofw8B4MR6epMwPBkEpc//WCM+cw5K7Pk9yJm1?=
 =?us-ascii?Q?X6Y1FdGZQ1E3gcmxI0wrPfgrZl9XV/EHRpH5RaFEPApLYmfv4knE6Wttqnqs?=
 =?us-ascii?Q?O0LKr+JHAhXNd2UmCdanu2h0Qeg5PThMytADq0TTyj1HfdNksV6WJigHiTFK?=
 =?us-ascii?Q?BiJA3FAZFtdRnzqn1UHC3MyK17VINm8TJQK0rWw4CmAr7DvcaLcaTwZPmaPj?=
 =?us-ascii?Q?AsAoaMyQ6tvSWjQlHfu+wd4DSMWkjONRdRQAH1HJOiybDap7WYJjUthOXKPe?=
 =?us-ascii?Q?2YNS3zfweOj6qUSG3fwjp5lI61+hErlG/JHFFiiPI30Rg7gdjD6HybtR/4YE?=
 =?us-ascii?Q?B6uk12JUX33zr1/ZVQv4Ki8/cJ//Fm1dJVcfbLbiXKoFLe3cLuRcZ78yCRKA?=
 =?us-ascii?Q?f68XCzRPskj1505NL9Rme4962K4i+XrFspRCAY1DIYUFI6/UKcd4XA09M7V3?=
 =?us-ascii?Q?d6dRFmX7hRD/EjsL2qPHpmDKQsn7fI3RY9CIF5mspipysKk9rUAnPvCO5VXj?=
 =?us-ascii?Q?AUgl2pgwMo3sG/qNWNi6Okih2VYyYbDdIprBz8ltbb49LTIr7DU7Ugb3dedc?=
 =?us-ascii?Q?4X40eYJDo7cBk9+1NKNY7JD//csjhXtREu9Doj5pXJ/6szmhWT2rT5udvzY4?=
 =?us-ascii?Q?epeTzmHRtmZxLx5KIuYdf5ItGJIpX25FUA5nMYSwwm/WSkx8rtPTXXMEd5o3?=
 =?us-ascii?Q?Cfd4aBqnGeL7Xe+vN99KeFKHAyeBTov3QtFyr3nTlMRA4k0tl5lOZeJoGGbk?=
 =?us-ascii?Q?+iM50OkS0VQX2XfTUH0rZn3wlPGvmnopSY+CSgkTm1GTdKC/w5aSYL9m2jyf?=
 =?us-ascii?Q?oyQotJSVQ1BP3JF3ZB7kCgnuHN4fTdEGYtV5diZLmJ8HI0DjG+sS3Ge3BmEe?=
 =?us-ascii?Q?fdGf4GYJyw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	i5iWJDIJaEr2pm8u8+AhRWu/+sly74TE79G6TKL0/MtPai4PDv0mN2jrB6IIIaMrDGXoFA0IO6Q57Hmrq52f+bwoQkRaGD7hOxRZO6GxctIflPHGhKeJpTmpLw1lG0y86san95V2nmpt+t+y1inM4sUCqJ0H2OMs9hxEIu+c1Jpoq8Xfww2Aua0dBfkKFu3TNMPamTW/SQZn3bZQVekmv6QRIbSwN7E4cn4+lm7hX6n5UKRiQdnezWlQrz9KeKWbVLnQ194/H2a6hY2pjdT7JF3I8RcJ12wUA7sxTQepra1OyL+Sv5drNy68RAr3NUkj8n2Nd8IWOhALC5w0F/VWyA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89479d1-0eb6-4157-856b-08de7feac961
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 03:52:31.2671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4oHQI0hQ4F1tW8aFtr4NTxWq1PaoNBfyk9cTUjpIpX94sjxILk8S2jkVoFR2x7AQJ2T2HGyx/tXCuykIj0OLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7942
X-Authority-Analysis: v=2.4 cv=ALvEU0hV c=1 sm=1 tr=0 ts=69b2388a cx=c_pps
 a=c7CpAOS9Jb82g9OYW51qCA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=lpC2OK7O1r6CxJ4ueCMA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDAyNyBTYWx0ZWRfX9ccUgicx0N4a
 E9D7o4SMpl4vdXclpzNFKhATw6nrnaX7zrb2HVE+sTJL2Pa8Pj/5j6Lqr36QlwXacL7S52Ub34a
 QOtJOtGUEjgWMckbiVkUE7ygAfneiTBqoVfCZ+JjiIFgzwhHTtCMW5pd/u+QSPRvFnjNOMfi9cI
 NPQpJHBrjszzCMdmRqUvb5GicFTBS/H9TmMERuqGqvbW9rEUGGr9JFPfgD77XVT2lszvPjdAEEp
 OKsToFoChUKR/m2QwwqDotYJQdXqeMt11K9DVvo1febHtkE8J4kOzMTmLYssgUW3MFekacrKGuy
 pDczrjnaQOJikFTthTW+/vbWyl01BHDmEyl06JOlrcm9xyF7+O0RAbZkAUkA2EfyoiSBzLRHqqy
 ioNjU9IsYBzG7z8qTjR6+vFEDgDt33SxbbwzfP3bZs7i74h6yvQyil9fw9uMslIEnWIXp77kzXj
 wzmR+t/x971unr9RX1Q==
X-Proofpoint-ORIG-GUID: 4tiX20afjMFp-5C_tHZU7svI6MwwWWfn
X-Proofpoint-GUID: 4tiX20afjMFp-5C_tHZU7svI6MwwWWfn
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
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Mar 2026 03:52:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3438

From: Chen Qi <Qi.Chen@windriver.com>

Using the first element in PATH is really awkward and prone to
errors. As we have already located the scripts directory by
using shutil.which('devtool'), we could well make use of it to
locate oe-core directory.

Note that the scripts could be a symbolic link to the real location
under oe-core. So we need to use os.path.realpath() to get its
real location.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 upgrade-helper.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 3b98f7c..27e1f48 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -67,7 +67,7 @@ if not os.getenv('BUILDDIR', False):
     exit(1)
 
 # Use the location of devtool to find scriptpath and hence bb/oe libs
-scripts_path = os.path.abspath(os.path.dirname(shutil.which("devtool")))
+scripts_path = os.path.realpath(os.path.abspath(os.path.dirname(shutil.which("devtool"))))
 sys.path = sys.path + [scripts_path + '/lib']
 import scriptpath
 scriptpath.add_bitbake_lib_path()
@@ -185,8 +185,8 @@ class Updater(object):
 
             self.git = Git(self.opts['layer_dir'])
         else:
-            # XXX: assume that the poky directory is the first entry in the PATH
-            self.git = Git(os.path.dirname(os.getenv('PATH', False).split(':')[0]))
+            # use scripts_path to get oe-core directory
+            self.git = Git(os.path.dirname(scripts_path))
         self.opts['machines'] = settings.get('machines', 'qemux86-64 qemuarm_musl').split()
 
         self.opts['send_email'] = self.args.send_emails
-- 
2.34.1


