Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79234FD0640
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:48:48 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15107.1773211720723022797
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:48:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=szhEEtH7;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B2sum22674919;
	Tue, 10 Mar 2026 23:48:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=cxJ9oxqnior0K1cEt83LNPz4J4BVTNJFPZiyFgkp/CQ=; b=
	szhEEtH7qySWzTx2hDeKKs7vc0a3hNZLHGP+cj8QKScMQyl/ZfE93WfzWjfnn9QF
	bEkZDt7XNf2AwTa7NEkWv5f3NKz/zMonmsjGJjIhHwNo5YA8A+dZQxwpBK9K/iuz
	M8v9CTpAzftm9FBfsrOi4bmHLCMB+sP04HCDHk5XLeBtRqgi7Aqw/Wj8I0S+n7G/
	0zDr6z+aljS/k4raEqkdkqQdmrHmx0krhpoK2IpfmpyFGmsVUmmI1TdmZ9XucjQq
	laMxhtcS6M0aeKU5CE0uBnW24Y7+DxAFA3LjFk6T/NiN1fDRbcr/zrJHJjxFSmM/
	qqqZ6oUaDPV28kl/wI3+dQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty53075v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 23:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZhgTh3LHDX6hZfKaRjW3VtfLsGtvvwb/vgyspupiasn/B9x5Pt21mXw92l1twTX7WOafGOE3zPg8wLU4peOxSMoW0Nycm1vmGEmRaT+HrnLmuAhm0cTKX+r2cUYoEZ4iS8PqS90yo87OEmzpcXmLi9OdI6ey9pnskE0/vMMqIz1norahwiWyYoMEgHXhbD4+V/ceMdrh7YyKpBv1kbpJbd+lfQVbXOgB2rkcgUT+Pd2yGTbjlJgAJ+8lce56tHN5KleBlG28Y+bRE+ptLumEK2t4/Vb0II1qIUxaRYwacqOOezOIdm9VnE/rIHu9aHKCQPZSDYdduxKHpwfSiKheQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxJ9oxqnior0K1cEt83LNPz4J4BVTNJFPZiyFgkp/CQ=;
 b=XPWwDn6tTGxsHi122D9jFDZDeFD7vz1gtRoPD58j3e3w2xa6mwYhfr3GHh5fZn81WjSaRfnhzgSjtFa/417/HiYvUKbzHiGZAjoJxVf3msZPibLrEQ8PdbxHBfUQlwGcWVJ6qQdOQMSWOTHZp15hNna2S5JT/1CMjn038SHB39b7g+VkIqzsRHDQ9ElZPI3Mq4DCGL1dxVhbum3AxrGQqMl4p6DEC6NWqcpclkpZOqoAu31NVHuLs6AM30KOpSpRMLHLrJ+dk6in2DVYAhW0+uWvFfUHIoFnCfBvLrosG3J/qZLCJ2+OGfFYkT7lrVY+b1p2hUq3qIyEVK17cE3cGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SJ0PR11MB4974.namprd11.prod.outlook.com (2603:10b6:a03:2d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 06:48:37 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:48:37 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH V2 07/12] upgrade-helper.py: fix exception handling for commit_changes
Date: Wed, 11 Mar 2026 14:48:08 +0800
Message-Id: <20260311064813.619683-7-Qi.Chen@windriver.com>
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
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|SJ0PR11MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed8bf0b-9444-404b-34a6-08de7f3a3900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	QXGoeJb6cvzYp0dmFeeAcdr3t10f6wKAzItq8T3pfjeTss50ztTCeV4d8wFq2Fe2LyNQJhARHaSSEf1Pk7WAXDgKHzaG0Jb5j2Tr3CcgWnZzYd4tlhu73p6IxUoAa1jqJA8lSSUln4qbSoQ7Sm/K6LROiOVXEXfK8zC3v0zYdk9jXf5fcIMcJkV+HML/wZ6+Qk76SYKl/i/a+aPbO0JddVGThzWFugicox6u6HKCFVo8tm7c2i/chfPac3VueyYksovfJ/gF8DuMIovfQngoRBxcZv033a0TFSvvf7UfCrY3QePfMWJFBov6dz3lQndiAoXeVu1x+03WwyDdn0fan2zM2Rtx6nD9OTl5CZ36OyHTsWDyXE+5z8RPpTh57M/BDMY8PUG7crRO3hHXIA4jJeohIuAqVA9sKjKd5m+nM8T4sf4Awylz2Xu4GpJGEch1ddD61ghFhH9tNERfvvORPNksQbYMjH+F+JjysQ6J8NjipVuuplshW/tg3jHaey2uZAa3o19DPsVv0vsW3IQVK2pbjr9SApRGfIDN8VupiCSEm+x5Amj0PDr9GbAJkvou3/JxxwHdc/7A7vydj+xZ3+gOY/QQVrojTmGzIw4X7Ir4sPJtXfRc9hzq4NJdv5VNQmU9u9CLjUfFu7Vf1NJw3gfewRBw5zARmtmxzjm3E9EatNONnLdwz2TYkppwCQoyyiUYTB3Ap87maMtTyQSdtW4Cg87wZFO/RqZoEv+FAjDa5gvipcRncpNzmkXy4nYmGCeNuuQq3T4hru+z+L5zsGZBhtUl3v2n2gi7ujNiqx8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?P1v6f4fPf84FBylEwmXMw+8lXAjfKDYrhzNgvq5JztkrzSbWWe39rrix1im3?=
 =?us-ascii?Q?GotvJqls8Ba4o58WI4kvQcFSkfSI/qzzwbMjIConXUpUVpY4KzME7AJhliu4?=
 =?us-ascii?Q?shSmW7IUe0wQQ5aIzXGOnRRaFtD2jJunKaw5uQUH2QneRrNAWiGuPExZPG07?=
 =?us-ascii?Q?OX5uS02baTdDs3V8BjO2G0uulOlsGDyaGpwwOYp37xfvxxrlhZ7aOLMZxFLf?=
 =?us-ascii?Q?6+X1j0Gy96JmKYuqHOYfNUPBErBrYWJq2F5OQpVbK0zMh3GEFSld2kY3Aije?=
 =?us-ascii?Q?rQRzsdFwmwl1kaJ1Y3MwxkaCau7GbCvMFQb4fGS6nLzM7pycWOeLNML/dWUL?=
 =?us-ascii?Q?sfDueLTcHVHJjiHUIfPamNJ7YMQcdGNrNnGtrxRY568HBoW8pZT0fwMTKTtK?=
 =?us-ascii?Q?i1/945yjLVlo4cZmZQOsN/C+d+9ouB9PkmO+iavDRXCR8iyc0CBuxAZlWeSu?=
 =?us-ascii?Q?2aMHr0rf11reDIFvTlxv29qciV11k42Imt+dhGYg2kvteEdVnYIiljnevjB3?=
 =?us-ascii?Q?RcN3oVckazs3y1jJs86ys0e/rV8VhnOzASgi0m/MVbW4G8doS+PBeMKuEYUZ?=
 =?us-ascii?Q?sD6Mgb8OBBpU60GVcyUeX7JA1vGTqqdiYlZDWmcaQwS6fVsvv5QDxP0HJ2qc?=
 =?us-ascii?Q?ju64tkHBIXBIHWqYIC35cZWPbfphJGASc52pLUcKYgQh5oSLs1XpYMXHEu4s?=
 =?us-ascii?Q?Jappe7Xui+Q3EAb8PK+N39/jMR2+X6Yiy9BHjGo9lNMUK/atMcjgyNch2s47?=
 =?us-ascii?Q?7uArch1erE1qyP6DsxvHcuzBd+PCVpsr+iGr1h4o35ZpFIXBBnyC2ZWkxnfI?=
 =?us-ascii?Q?EIq3y4tEY+6vB43k3ZXgn5loFKNxnagrdXS3MI1a2GD2ahiMGSqsQn7ZgL2L?=
 =?us-ascii?Q?sZv0yAp4viI+PBEvKlQk6uYozmTzGeaDaowr1mUib1TeoZn6FAtE8UQ3rYp1?=
 =?us-ascii?Q?WM40CKnnn9M/5LCvLVLs+BTtkVDJxo4T3EiKa6j7IUo75oAW9XHhyPOe3nl0?=
 =?us-ascii?Q?P+3UU5xMES1LW6ftuET3x88XxAn0v5pg2dGEqrv7fJkg+kmb6NbevHqMJFx+?=
 =?us-ascii?Q?h3q+8kBBDEca3CQX1kH/ZeOedRgGM1aRAZsPKiMBtMzC43Vp49u2JHKAdarH?=
 =?us-ascii?Q?NS336W9fYdL/z1KKN1fHQL87JBIxmOVvrXZmY3cS3s5TSs3Pc5iErQ/zwL1I?=
 =?us-ascii?Q?+NdxSKka/PQi1PfVxpudpSV5JEoYcKk2nbRvFL3RKwPrzcjMUcn4Zbm6Q5iQ?=
 =?us-ascii?Q?tdOb8+6G96qPQGfZG6HZvio3qHtP9EgovHTSGfH1eryCrg3M7NDzU0QHhEnD?=
 =?us-ascii?Q?DikqatvxFPpIgBeWvXseNQP7VDzCDgVVQW26Y683AbxuBcbW+fjIaop6AeWN?=
 =?us-ascii?Q?EagPTIUY2R4/68yHMxHQN99yC1g1DX6q4ffr2lhkSRFFr1AKBZkz/353jMTs?=
 =?us-ascii?Q?ORP07bTIjzXcrv7vyatCDX6V+7uaXeiF2po1/gQojgIZj+JxBfY+N6khuUv3?=
 =?us-ascii?Q?gOg5VL/mCQbKJgYaSx630FNPy1uleNLJwsWen8fVJ0/S9d7Q1haeMaHcdQTa?=
 =?us-ascii?Q?e4IB5nR/PE3rEdOUZNq7gkYrom1aaEFe1Rx4lYEqajuhFZk0OSF4eLfovZcY?=
 =?us-ascii?Q?M1Hipbj84DZj7Jo+LCxoKUOXr5+Lina3abZZmDiFNaiLQ8Z2lUfzlPES1pTe?=
 =?us-ascii?Q?VVPWdczkna6bDgOAu48eCwxItiNR1jEf9fAOtoePi8bptAWMYK+oiGRVD8D6?=
 =?us-ascii?Q?SdPsZmFk6g=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	Jxsi1dFVBRHBSquimPIZcW/gn7N440qkKAX4GamIxEEIG94eQ3CFwHjRe9guS7fsJmjdSu3ariiGZusKycRZirKaj02ApS6ztca2Zjn8K7Wo/BL6DuAdkvwCJj2Ffb8SA5y54+4+XAOSw/VlHl6V2VXH5gsJtFcd6yYLmYVw33MniDDw9rCs6mGMfGY3Bnwdxwu84GfEYsxP9eB6kS4liVIaBpwN8jSZaWyLHaLejgizuAZau8VgXLNEqiC4p1E6Z6Tlr1R//tPx1gTWDTV9iw3YekFTo3oEBFbs8yGUQ6Ga+NNkhVFlFWo3IeYkaq+CetfWuhO5mn5NwXVqwxyGTQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed8bf0b-9444-404b-34a6-08de7f3a3900
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:48:37.6244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNvIZkORbj8qWpK1fDlRqWklAouudM50T6zhA0eb1x3tCj1HFoY6n1nwjgsxU/1eaVeT4K/S+FBBLWzsN1Sypw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4974
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NiBTYWx0ZWRfX1ann8VNPOh3z
 VxJJp0WqwZ+bwuX7cH2EpRmujWZpCOqAjokBHQXH9XmtZbMrevrDdLaGd60gjpdVFp/XOlOMGBY
 5UTaHyCD8ft9TOFvt9qKMXQ1pnd06+caFdHWXU/ONKUOJ96hACI3G4LIG14j5FssfT4xtXbr5wp
 kViPtb6+U8m3roJleMMOu3w47a4HKPSXq79SeVoNo/TInXFPHq9n2IBqHqT+bz9W60iujNXrX2X
 pFetwGMFwZcS30bvmWyv9omaikYMrtMK/Aye3gLFb8KC9SQ6FdHelsFve9laTYs3DpMjT2jgjs4
 W6cBqTB90K6cTRjtHHXgUW0Cm8tAUEOMWY+2U+MwRpUoUpubPXP0D5M9KN3kpRIMfwjJ6dp6v7Z
 dsIe3d/hrzEiDOAh4b/Doo/csBQwDUXWfPpjOwWwXxrzbFH6tKy+BZ7DKiJyXMMRJLCt3cey+kB
 H/38S4487czqsneRl1w==
X-Authority-Analysis: v=2.4 cv=PvWergM3 c=1 sm=1 tr=0 ts=69b11047 cx=c_pps
 a=0/xasGIuH+87ciDr1HSmcQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=XtcnuV78pZwgIC8ia4QA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Uj9rt7BDFeVaij3mJt-luTwRxjNEC7mi
X-Proofpoint-ORIG-GUID: Uj9rt7BDFeVaij3mJt-luTwRxjNEC7mi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110056
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:48:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3420

From: Chen Qi <Qi.Chen@windriver.com>

The previous exception handling is basically self-contradictory.
It has g['error'] = e below, so it thinks e is of type Error.
But it does not make use of Error's message, stdout and stderr.
And the e could well not be of type Error.

Fix the logic by checking the type of e and handles it differently.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 upgrade-helper.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 27e1f48..428d66f 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -523,8 +523,11 @@ class Updater(object):
             try:
                 self.commit_changes(g)
             except Exception as e:
-                import traceback
-                E(" Couldn't commit changes to %s:\n%s" % (pkggroup_name, traceback.format_exc()))
+                if not isinstance(e, Error):
+                    import traceback
+                    msg = "Failed(unknown error)\n" + traceback.format_exc()
+                    e = Error(message=msg)
+                E(" Couldn't commit changes to %s:\nmessage: %s\nstdout: %s\nstderr: %s" % (pkggroup_name, e.message, e.stdout, e.stderr))
                 # Ensure commit failures are recorded as group errors
                 g['error'] = e
                 if g in succeeded_pkggroups_ctx:
-- 
2.34.1


