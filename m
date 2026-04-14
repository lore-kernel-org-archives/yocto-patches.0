Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E81F531F0
	for <webhook@archiver.kernel.org>; Tue, 14 Apr 2026 05:32:21 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12277.1776144735025923867
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 Apr 2026 22:32:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=hG6zlsys;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=85642e362d=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DNiTW51269595;
	Tue, 14 Apr 2026 05:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=eTTGIpIZJkhbTVmSQ/bC9GdQK74nLoa8QGNyuOhCmpw=; b=
	hG6zlsysll2bY7aTPnggwNIq957luo0OuHsWWfiswkHmZJiXHfctRhJGwpJg566U
	yMqdsK0yTg/zo1ge+jy0Q/hZbaZkNJelg9bJV+jFqpmL2cVjPoVrgB9YzMTCSZsf
	4zbyvTY4352N9gOibF0g5t4Ttv56LfK8prsFXaMbChPIN+xR1FA4NEkKIwsSxPG2
	nH4IFMZKYsCOaiSF1Y5lVfVvnIP/SFnhOwgyJhgbjk2fQo3FnSy4R8T5VWnyzyMr
	aoYKw8NncGkSyLn9rYnXoUZVFq6qXmpREMxAm6Al91dGcG1QUJHeBFqRTo+ONAtR
	Cyufg3l7Zrp/1aI/jxpLKg==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dh877gatx-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 05:32:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwQu7LlGepEEbwZAGN34Kkm+fK1nkxFo3mlgoYwCyZat7ozxRZAIbqW8n45ZI4nL/MFHwBdDwO0UTHLBJ3HrhmN12VDZkFSsyCMVOYf6QeTaGjr5joCKT/Y+GXp8vQK47SlhrnhRFXKWrcDoWd6kGV5j8E0+uEAMupU8OBnbknIr//1BGUxWLPffeQUFWkSGvvhVHOxkHKt4VYT1Aue2cw93gpDlDsNROFg4LEyiGSg3wNwFh/JmnFjidnPcaXaTVV8zrZOpMTpaq303XWVQ6za/G6fx9wlOXm+u8QPO+nFIpLa3Xs5U2ZDDHiOD478EPZHyhrPf/85aMUXG2dsCjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTTGIpIZJkhbTVmSQ/bC9GdQK74nLoa8QGNyuOhCmpw=;
 b=Wn4xTraI++4nlJIIKUvAtspWiC/y8O1wbBRrlQgBWykRdotNkqJuWuJn99lBCXdXm8sH1DC6ZA8bTkGTsdwEHSAnqosd9z+q8tIenBs1XR0VUNgcqAKJIY6vPvjPYI9OIO0Sf9Vqb8Tdpqm0UlegnqLQs7w7m8YbEMrAniv8KIDN/X5hKZQPH+9uksKcrLgBrU+5pbPUdBNR8xOtEJlcHjVSRBcXompj5Yfwlvk+DlQZ5n9mEjc4YXVOW7bsIPFMePa9KufezqPxRdmV97h9Y2Hv0vTHJimCyGcdVL/jBnKFQjqh6FAG/yBxMg0udvEfzK5XBSdAqFevKIBud/UvUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by CH3PR11MB7916.namprd11.prod.outlook.com (2603:10b6:610:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 05:32:11 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::ecf9:dbb:16bf:5b2d]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::ecf9:dbb:16bf:5b2d%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 05:32:11 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH 3/3] upgrade-helper.py: use more combinations for default machines setting
Date: Mon, 13 Apr 2026 22:32:02 -0700
Message-ID: <20260414053202.3869771-3-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260414053202.3869771-1-Qi.Chen@windriver.com>
References: <20260414053202.3869771-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:217::33) To PH0PR11MB5611.namprd11.prod.outlook.com
 (2603:10b6:510:ed::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5611:EE_|CH3PR11MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ea776d-8928-4444-ffac-08de99e72d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	DrmHXW+wSQ73x0bT575dUI2KwmEldbHrtnDcJa0DSIVunBG0rkj3qn63CI6j3Rsc3cxNJIKkixMNwAUlllqh3Y5teloCBbY6l5YNAiZV2cvoNlc642ptfhg/U4mMlV//aJuxEwt9YWUhfzzXLMOgaj23n8IpzQHYsL/Vn4kDxkceCH0XzzIJUdLiPsIgcuELH52DjTl4+mliETc2vzOSTXnJMxViMSvLP975S8vVSvg0GlcCNyRQ33Egwgtqa+9abokFxQutIeyZDFSWv42ccD+J4dQE1x1PDE9F8a+rJAc5dCpwRL0wgyeAHHOGrgkaDgpS61XdUXh5Dd9WnwUKt/UF5IEdpwzG9knBTWp9PAwIhd1UG6CElsmpTSRVyfveyN5ZABP7qy267nyelsCG6sZPgHSdRg12oQekd+6jbdJQ66ULCdD4R8gzEHsYxmAyJN6FrdJDDLBFt9z6wRk+DSlZZmyVwVQTuVwaiuCrnTwOs++n64TU7cqTdNnaOv42WljmpyPH7OjV3cFmjfs8oAGxlHvvwTPHE+U8/XQJGCcYK+K43p44hOmsAS5q9ITdR8PtCdqiKP3CtFAMfDyhMe9rdVt7XpEf8X7LNENm0MH52dqytJ69BBCek3FIrfRzxO09HDhm6lV1mHbmXILJv9Go1svbaGRNmitoRCKz6MnLUGpebBeZlkWjlnqjFWuIdTtJZ1n07UHMSIP35xb7+I/gsYwy5a7vwF8yy8rXFQG6iZhgFYEHzSIOh6VdwJoesKYesJzCtKza/LkLlMd/ncPUiG6A9RnleNqCZoG4Ab4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IAUWgnkinIqs3PBM/C7+wW2oZrEBeOWzc8YiODmZqmWSMV0pM8JBy5Js/NF4?=
 =?us-ascii?Q?f+JntjoAuL4wBc8qaSvPdaT6lPC6VcgNDpNo5I9IhFxQnmOiHhpD3ZWwSntB?=
 =?us-ascii?Q?sCKDFnJ1IwvLCcQT0X9kuIwa4md3u30RQeNTrKWfyqxAniXDKNk7L0YS/9zk?=
 =?us-ascii?Q?u12N05jNBHBVL95ZEMBaCu5ef71VFcLJl6FrwsSHxsX8mEgoEjJt/ybG3jqr?=
 =?us-ascii?Q?cEUK589rJO8ybQScqgfpSQuAuXaMZPJPcik1qCRQ63d3jXhNsh/V9hd3Ammu?=
 =?us-ascii?Q?X5rqf8J9JJOEQwL1NQgKP4j48C1VBB9laGlXv/PsSHwsRxWC5hSY264+8wbF?=
 =?us-ascii?Q?XslI5R1tlG4GwDNs43hAqpqo1mzBdYHMM7qnoPqC+V9oA2DIkvCuvUgEE/SH?=
 =?us-ascii?Q?jKdo8GGBkrcWacmVtDDV3TrOXUL9HzzGRGVI7ctwkgAXZKK1qyqs183Kx75/?=
 =?us-ascii?Q?6Eo+gwSLRYjB7E9Kar6dkwS/7+3JlhPoUxv3TC8i9zYdsQwjpw3iRSM5kYBP?=
 =?us-ascii?Q?Ivr5eLFLnTfoJlHu3Y4EVBUsx9SACHCfEy6puvIjIl0/ulYemlwJXDylvHR/?=
 =?us-ascii?Q?4vqn0Y6anIRguWrsq6PsbLZGGIRXdxINJGpEy+6UIVGJD50HtB8jI1MIyyJ7?=
 =?us-ascii?Q?debQdk507sUd5y5FzudSfE/NSKqTXEkHhiHgHvwaaK9Y3w86STgwh8YcZKYf?=
 =?us-ascii?Q?IkHLma3Ft988ZbJuGspgWwjzAJlD/5AdQPQG55GtDyVOPuWeK+3/hb7DZWly?=
 =?us-ascii?Q?DCbVwh193FHDVPP9I302FducfAsqG4C/3KiN5TvuuDTAL8LtEPrBJ/HScd2O?=
 =?us-ascii?Q?LM6HC3p9JCSSIXUbn3890BEAr+TK7Px3nF5bM8/EOXFh3M/m9+SpnZw73Hga?=
 =?us-ascii?Q?+G0C76NUF/r0xkTDWZhhVY/St5o00zX/pkxv+Wq3zHythflOeXgdpbxq5lW2?=
 =?us-ascii?Q?04CLuup865AU/ZpsLLrmQu0ZWtO3ILoASwV9XuPCXaVEaPvkwyFNABA5e/Fc?=
 =?us-ascii?Q?39wMLSpwoeBG78aKTdEFjDDImbuCAicJ41p2BNalk7ziiG3DbKE1YOA/cIco?=
 =?us-ascii?Q?6cQ7nqZKEESDbJj11h1dpo8+wwAX8a9izxd5nW3lsf57iWopaPNlrDT9jAVd?=
 =?us-ascii?Q?u9cA5/HVM8tJiaF5DBokMvnUd1Mc4v3KeoJYL7lu60jUHnDwW0KRljhifSJT?=
 =?us-ascii?Q?XFCdc49YUrCO1JXROiw2TXuON6BGhPgVzoFobAZE7xgM1cWc4dPCP1HqDWRv?=
 =?us-ascii?Q?YE7tMin4BCkWlMBfPPyQmG0TrBZTk/XJcnwW4rYNL0EdMjfisjYbBxn2obK2?=
 =?us-ascii?Q?qkstsa6uW0tB4PxTt5+QvyfqA98tA9k6SN2SfYCelhQr1PWWPgQ4OLBD1d2s?=
 =?us-ascii?Q?QdQLYIYVUDSjmb+LJglcK25ag0FOufQJtA6O++1VJT72p0755mfSZbfm/H82?=
 =?us-ascii?Q?/S2tWf8o+alIUsigo/yVDnHyJN1+ZDTRrMYE4idv03kEwbLrzH+LeLdJdyF5?=
 =?us-ascii?Q?9Cy/DaY5a8hChj5AmYlwT4siuI7zyOsz4S7CIFqVaNSVFjE2rT3i+DqStNbn?=
 =?us-ascii?Q?mr5fZ7E/VUih5vay/vJPhY8xbuiqzUE7q7PVDNWCBuTm8uoe2pLYhoeiuPMg?=
 =?us-ascii?Q?fmkzB9OauTwyqB7zq/nY4ivgwxPQUGWAf4cbRCjICeK1U7oFdQzIDA9dpdjp?=
 =?us-ascii?Q?hycpnsrCBPBxPQ7VKbkm96FX2O7g83uKoKMunvOMxCj62Curf5gMtkyXMIoW?=
 =?us-ascii?Q?Ah2HUjjrjA=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	l3CQthziaRP856Tn1+rJkfJ5nmVockPMUBMDMdjJidzqf/Fw3wzQoqojJoPIkLsNK5aZV8844wdCYZatgeQpA4M+f5BY6/HYwpYr8OXvylvcEy1PXkS/hxIA0dzzbLvPCNWayKQJBqfpBJnawLM75uEzwWOr5R/dO+pv2LDVceva/HflqKKwxqWrSiG7Jasw8s3Zn5uoxlubB3QQ2d7AJPgUt28gUAFYlzitg6lN4ZM2J7P3HfpbTQ2Q30R6Zu+p6nYb43VS761iXtRWIImY1dVEAdiqRm0HqHzavybfQ5cINFrYEG9SRM99o4OKmllfu4lWd5JWSNuClJj+bsorLQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ea776d-8928-4444-ffac-08de99e72d54
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 05:32:11.2501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3D3IDHEftpfLU+Tu5rRmeJ3Ty2qOgF9NOJT7AUYx0G6bwUvaSClNe4/wGPrg8OdiMFIZJyJ9brkDr/BmHq3R2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7916
X-Proofpoint-ORIG-GUID: Sfvcv9W1bf-SmlWCvjqSM6Hb8b9wyDnB
X-Authority-Analysis: v=2.4 cv=ZtHd7d7G c=1 sm=1 tr=0 ts=69ddd15d cx=c_pps
 a=Bsy78vmKOeQIAJqgrxlU3A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=Z_CKyMobp_yLbMhdY8kA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Sfvcv9W1bf-SmlWCvjqSM6Hb8b9wyDnB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA1MCBTYWx0ZWRfX8vIwt9VcuJro
 c0dSWLfXGMLgOMfQ+fIw546iFHALucbH/VgexqpUgetz+VUcOtD9h/xzROL0UxH5SErIvWM2iLu
 fHMlxPYKzXNxAE7nKJNcaCU/CUNAoiiRsdwTpiW4Ml/xZKqEHaIQOXkuLKexaW2duGIFMvpva1L
 iYiAgSgAMQ9JT1OukPlkfPhdIYPcx8eiMA74khOjhyYE7upLDZ55n9UWc0+fwGmZ1HgHwQoHq7V
 vi2g2CFRaxAeuYLh0VqgpNSK2f5rnAokDL685NeNY1mIZ9RZXeuVIrNZ9oj0KEQ51qBE7o6mn+/
 rFMbZVYwxTzDjeoKDAKZOurcDQCHB7/RdK0898cvCs0WSMx2oIIR/2C6drW8A+pu1vEn8PSPGGO
 XHV2yxEF7mcf2Ivm0NTVNnjfHggAUUgfQGGk6Nj6aNNKNaaj1jn2p3wZPuBUvWNsKzevbeciHIZ
 3C3QkRHECj+INfPnejA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140050
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Apr 2026 05:32:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3697

From: Chen Qi <Qi.Chen@windriver.com>

Now that we've changed to use parallel build for machines, we can
change the default machines setting to cover more cases. This is
because such change will not result in significant build time increase,
and maintainers can have more data.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 upgrade-helper.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 1c05333..59af392 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -189,7 +189,7 @@ class Updater(object):
         else:
             # use scripts_path to get oe-core directory
             self.git = Git(os.path.dirname(scripts_path))
-        self.opts['machines'] = settings.get('machines', 'qemux86-64 qemuarm_musl').split()
+        self.opts['machines'] = settings.get('machines', 'qemux86-64 qemux86 qemuarm64_musl qemuarm_musl').split()
 
         self.opts['send_email'] = self.args.send_emails
         self.opts['author'] = "Upgrade Helper <%s>" % \
-- 
2.49.0


