Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922BEFED2CC
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 03:52:54 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13955.1773287564566502871
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Mar 2026 20:52:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=j8GtRnjz;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75310a015d=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C3pA0j2877391;
	Thu, 12 Mar 2026 03:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=kiHNMj0qFsDZJ91xFWHRJ/FrEOROM1AmSTENUu6Q1U0=; b=
	j8GtRnjzFi7DF9xaEk9qKrGCT6XSSWpWfGz5KOtyVH19/Mj3ULDPPmtLZ3YWqDH8
	wLbLpPTvUtp7E6Fg2UMtkRFZqQOtbZRH8J1uAMnwhjuDFtW3dOPmrDH1qCTavXB+
	sqn6lNbKIUIs6HsiB98oHgHh8qU0E/lKl4y4/X7c7wzb+MkrraYFsP8/wjVzU/sN
	rp8mtjELD+dKOinIess+wosRJWgargajOpc3NQp6tWwZ255wFT4HQbqbDwt0qR2I
	fkMUT+9+lWvolamZmLDDL72phYddXtl9TswQOF9F5cworefCJmzi1PopD3ggRsGi
	E2eTG/rmCLwHZjMsGd/9uw==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh78g75x-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 03:52:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/9S+R0oB38Q2iSm6DRV+pvEyz4l3tauP985PkNwkx2eCuweMKmuNFBo8hX7FqVTeOKfsthTFkDssYA81wAK2gqU/U5TygIT7+e5v5y8LqaJjyPkT5CBLHq+B/usyGzHZ2oZ6KtcD1AqN3rrKoOBVGnLv0CVDF0+2JeO1zSDniHisFLk6MNwTtH7wzgKjEIv/LU7M6FgTNKWnPUfiz06wmprCMFANMUlAqgXSYmbh0RZZsjYj7a1cEyHZA5eYtYaODuMniydRuhVhciUQhOPpZCTV8BnGWCFfy3HmqWhKL2iDvOsFVL2GsQGgW5x5bkWD1O21vj7RntJhlq11lSKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiHNMj0qFsDZJ91xFWHRJ/FrEOROM1AmSTENUu6Q1U0=;
 b=L/UM5CtCCdyEjT66ON2gZe8+cKBhOOuDLA7I11wtpskme1Bnh7Za+J+Gh6VeELhasHYCEd7EYuDGujDDkniV2Zybu5J0C3ifb3y8/HQAXWmVEBNF4KFUmJDdvGOzVu40UYtzCtxutzaTfrvWYUtqduMJE9Pnq7Xk5ejq2E/Jj7Jd5AyqIE2tnnVUIFXkQHZY/JdNjA/egLMz1huh+BbryZBLddg09TXg6x/JYnkrcpCzxabDSwcXNWeJVTvqL7TiV4AIexRm+hTpvw21P0p04Gl+Xhcd1UGGbnOvTQfm7PFjCqKQXLcOoj2mHxKitMPV91hEXoO5MaTBDYiRxB5qVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB7942.namprd11.prod.outlook.com (2603:10b6:208:3fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 03:52:34 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Thu, 12 Mar 2026
 03:52:34 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH V3 04/11] modules/utils/git.py: include repo_dir in exception and unneeded debug
Date: Thu, 12 Mar 2026 11:52:04 +0800
Message-Id: <20260312035211.745546-4-Qi.Chen@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: d2371f74-8f27-44da-d06e-08de7feacb33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	iJQ4qaWUyVFFii64O41yuZOIfJVyuY8d2Q/+/W9Y06a/5KNRWY2UhZL7ngxUXQYWYmm5H/lxsLgnH42pYy69plYz8Ki3Em3mZYkdRr5tHOgEoOZihMDs5gMWw8Y0tk1XlnpUSEICmpVz9u3BXovnKtoJ5TOj/fL1G7+oIVbgmwJ3ER7NvxgsUkJhZ7G/gGDow9sikZrC0v/OsP/vNGZCAtX9Cfi8qcqstLU3kwFVx1il2hy46N/+yBZdV7hhboJjYDVKAIY0WbxcmWUreXM2NFG74fOmTo56Jp+sqX2BVL8ao7Kjv8I75+DF6pXX5NV9jfAgbGjxkRuRCvFSPKGmluQ9Oum8K50D5GVP3S9JZmbbhJ37fnICvsvPPEMrb0+tH6BWyp+D4ZGDHWaQa3a7MpTUlR8h1dlcyfCOBMAFGN0gIrSdaWdPSfQoxfm104Q+TFEwte/aNxgwW+ppk0LRlgjXeXS+fLN016fCcEKkjx5hsvn5+/QVbNIX8Xt9/8Cw9eZOexCduYFeHV8/gKXTDNZZrYUXqvcEsbCzXffd0RY8G9V4r3j0Xb8xQW+O4wGVoloJwbvr/oN5sDDVTI3s3Tast0krAM+kRUCfry3ioF0WSDOOsrSyG9tH/Z/352ABHXf5lc2KkXR1AWgI4285rD/5DvF6j95Zb3bKmwbaQIXaYuPx4YS0VSFhn8GeUIryCUBEDOXwMW5GENdLfxsFBaJ7gR51moN1+ujfUjtstaqHX88tdbZN/lg4QnlzA9VwH+j1yFU4Yvy3cfAufW6gMoImqstR8lpo0PVw4fks+oM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FYdPhXdoLIMPp6khHwSQBrP7AQDajWTkBKWYPfjLakLqVZfLEiAg1frPR6j7?=
 =?us-ascii?Q?fKzIpRP762ulS3oAY1FihOvdnx4S4v2t8Zuky2LMaA7lkLDP7ZPmm53+ZpC3?=
 =?us-ascii?Q?oHgGmyIuvNaYpPmSTEBjMeX9dkmPDtgJAuxHF/tjmsjuKZoLoiryGU3PSwIy?=
 =?us-ascii?Q?zbQBvAurPTRm/wbqWP+kFtdwdPVPYHVtssMrO2HucwtmCbrLA4KGTrFtyHBU?=
 =?us-ascii?Q?BCOIP7HzpkxwKg0K+nYihDeV5rLljh0sLWVokRwaA4wmAoZbtwhRplHKRz71?=
 =?us-ascii?Q?ypuEOjkjDzplAaBaolpxn9V9RADQPXUscIq1FdWUBnyeB7ciCGtjlBuHdad4?=
 =?us-ascii?Q?MwAWTG66x13OxryTFIRgEEwkglkkv+uhKGybnav/f2CxWwbo0l13z0qvb+oX?=
 =?us-ascii?Q?wlf8CYYot+JRtgrQD496xY8P8RP+IUqEkalj8uqLnNvSr+o87revkyGkw5j8?=
 =?us-ascii?Q?DAoyilKQsZuVkE+gOTl+y3kGQ7XaCKV76YrSTa4fg8M3mGhJrAmNIIgABhYp?=
 =?us-ascii?Q?ry8A8gLBUhA922bCgWHO4FbFe/BEYolbxHSOgZFt/uc+hsoXTfpMr+Kp3lic?=
 =?us-ascii?Q?nIuRMeCE9U9u5ZY2TE+HlIvI7XkAOvCQUogpr4ed03r0KfgnJi8VoewcUEDs?=
 =?us-ascii?Q?QKl4owsvRIJZnEEktIbKL3EIbM0u3ev+yO6dWp1WjsfmXFTtPLuRPgcJqYoI?=
 =?us-ascii?Q?RaUAQ7HkrzN0tq8jlZO9uig6IYctsxixg2UfVsoAEMESn6JeATozDcnovwco?=
 =?us-ascii?Q?IhXJ/8ZrccORXLqUMu68lwu+jJwjdXrMDAQGaf88FW+j7ech0SIvr2fW1Qys?=
 =?us-ascii?Q?Ms37Jqk784pbhSF/8HbfREGZHmMJHWwpdD0di2up0WRSLFHk7NRVrh3sjfhX?=
 =?us-ascii?Q?DAajf3DY/vv1jRMA878uVL8JoLCsjwK1D2j5S75Zb7xHjfaMCM4hHOKRC1rc?=
 =?us-ascii?Q?XxJ2qexaMP7OkaHHd+YatZMfuZ7OjH6adw7yvGiwPm96x0fD1jiAeAg0aZZo?=
 =?us-ascii?Q?/gBzsaJRHzHN26/uYUmxzt+kn5w2HbQ6He9I9qEjkU++d2EL6ySY8G9Vfrq2?=
 =?us-ascii?Q?dQc25iNtQ9PYUo5esrRUa1nEYJnOZl1Um11yHMcP4uYP6LIAiYEztt/phbif?=
 =?us-ascii?Q?QV14M+WO+rNhXiY97CZsEkCrcn9hCP/EM2n5xRHuPa1GNXS2PFXtH2xL4EWR?=
 =?us-ascii?Q?H9/JUVRNU+91v4OjYxt79SvlophVfdFaLM5qHCDYWDYLRZYHKFa/2wnSXlOK?=
 =?us-ascii?Q?OSghuhWj4JAsFZZEmEJQq6B6U/MhP/DdhyRVaXE9j264aq2OfDCp+A3xCLe3?=
 =?us-ascii?Q?agmNhWwB+rKkBc799VQnlWvA8KN4hZOpwRCJse+xXnQgBeszuoVB/w20n60b?=
 =?us-ascii?Q?DVzU2mxQuD5gAJAeSH/ihbhHTDKfBWtvwNfxlMb7IxKT3e80Fic/qnFiSa/4?=
 =?us-ascii?Q?Ii/FLaxQs1bcdyDlSn/r9Htq6TKK2ZUrW6oxu+TfCtZnWoR3VzUJ5n6gNxje?=
 =?us-ascii?Q?4uq1cmWwsIkNH1PVNO3aEDALbByoSF1JcrmBLJZkW1iDQ5mI0vqVnDDXSGLL?=
 =?us-ascii?Q?XDAviydCxJm3ac6Gobgl7i5WiGA4BvayMjHkCvFX359QlKBHt/Fqz4KP6vXr?=
 =?us-ascii?Q?RMe+xcXC0ylH6ajMo61UJAWiOT2sm+XsAzvobLdj4wuKCFuFHlOVeWomec2A?=
 =?us-ascii?Q?/3QSgSxeBXRTVbis2DEtoUrBLjO872H4TQECSuP8Ig/cT2gp01SJtmrtLIkS?=
 =?us-ascii?Q?c6kzRsxkdw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	TlcGMKwWKc+hGuD//LEWUJnAbn5pmKUxHCFcx6hpUdz7lmXhoVajJ0HeQk8bAYc4RMdjl40dSLEZQaNPupYbgUYihms+L6hPyIB4zZGkPlbQ+XIJhbza3QX25B+pDUCVFyda2EGxIwOqAoLcEPw3Iz0BTeADiUBdbjaOVcxxOBKN+XJHp7JmVDWSDSDcXsLd7PtxNRwS5pQPkMdFgenJP9dXkOiD+6bDqJKWkEV5wF4Dv+PhTV95hPa++MCPFAyCKX4xbzpY/aa7PsDoYQjXp2HzyZyYDif1evKHJIjlXUcJKECXtIzuXh9FijDzaLbfTaOdu7En6Sx7HrAB3+6ppQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2371f74-8f27-44da-d06e-08de7feacb33
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 03:52:34.3905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTWI6wUwhWNDd1DnJjLrUMV1ifF0hnA1P5XO9nM3lD0kigw+0LiEUcnuuoi5jGToV0UQoDTxvgK6MiosF/pGsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7942
X-Authority-Analysis: v=2.4 cv=ALvEU0hV c=1 sm=1 tr=0 ts=69b2388b cx=c_pps
 a=c7CpAOS9Jb82g9OYW51qCA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=-AFZrJhNkWtAt0HyI_kA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDAyNyBTYWx0ZWRfX30LxYIaLyqai
 fiLBEzsAi5/gZHKjZaJmLyLcFRvcO8fxPGUSNo7fHq2q7KklpBLMxGUljb1zBX2fL8AzvuHDoOx
 MhRpdbdFoR/7XG9d6AI9hvpy6oj8geF19V4dl3l+bSYyfPgnymkdeBAHWgwYZvT3a7/Ms5qrP/g
 e7obnjq0QbCKKKKa0+VXxtSsPnvnGBlaPfHV142X3WUYAbAwAjW/nGLBwg3SZO3SXuWelLQK3ud
 7tDLBGzSUFwrX5Zn+NhlBo1G8FF7BGTBdYNPGdcFwHxpdTbO6tJe9KatS5H217K6j+GW+hMmfQq
 mm5wnejdUCDbzyM3KFobPQiOQMhKNEDF6ZRNGnY6VIyVv731q4d751ZFfrrhLU/L5NTBGDyMkYk
 ciUWqdibL62rlLl78QSa8vu3EhEXmMptIupuxwCsbYEu6mC0yLtQwJH+IKsPkIG1RsIlfL6Crv8
 vttYHzYWCG11rEAT9kg==
X-Proofpoint-ORIG-GUID: lLSWGwmp8oOOj_gF54EElaW9dkjKOILe
X-Proofpoint-GUID: lLSWGwmp8oOOj_gF54EElaW9dkjKOILe
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3439

From: Chen Qi <Qi.Chen@windriver.com>

Including the repo_dir in exception helps people know where the git
command is actually executed.

There's no need for the debug output here, because all the information
has already been in the exception.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 modules/utils/git.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/modules/utils/git.py b/modules/utils/git.py
index 3be75bf..9a71a3c 100644
--- a/modules/utils/git.py
+++ b/modules/utils/git.py
@@ -24,7 +24,6 @@
 #
 
 import os
-from logging import debug as D
 
 from utils.bitbake import bb
 from errors import Error
@@ -41,8 +40,7 @@ class Git(object):
         try:
             stdout, stderr = bb.process.run(cmd)
         except bb.process.ExecutionError as e:
-            D("%s executed from %s returned:\n%s" % (cmd, self.repo_dir, e.__str__()))
-            raise Error("The following git command failed: " + operation,
+            raise Error("The following git command failed in %s: %s" % (self.repo_dir, operation),
                         e.stdout, e.stderr)
 
         return stdout
-- 
2.34.1


