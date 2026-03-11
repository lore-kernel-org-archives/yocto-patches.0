Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC53FD063B
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:48:39 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15106.1773211717648501063
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:48:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=HZyPbkpX;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B4wC062885945;
	Tue, 10 Mar 2026 23:48:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=VfZB1YEW3TN3HS+PPRuJJpL+corUGKZ44A3sCqsGQWI=; b=
	HZyPbkpX6H8cq5wVJ/Cj4fHokBv11iS87HuYRTNe1TvOMOd7hAIexNFcL8OWm/pr
	NpPl9en7kADzTp3h/5nFl1b4PI9CtsOWE6drle9NMZ8D/A/FjroXo/X6NO8CAITe
	PJGHBUPFM8Bbx7HSwdFSJ+sGOuS//2am7DJL48sqGmXNdIWKOm+q/90NCl+zzOoo
	qh/5XiTQLAgGSxN41xixq1m3bkOzwPxo7y+weoCGAhBLvN6b2C3fWf6t9oJAHd7l
	rHH7WxE/zGqYoVFybf3h7cSwBvqfgyQ0iB6CkNeBUOTXfg6sl806wt5lR39Iz57a
	1ZBafr7og1XLxGf17rwTDw==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty53075q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 23:48:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfsL7iIEQztTSN/l/rav5DwkXW8MNu5ACe0AWFX8W/wao3Grbl7tGg5kjKTcvNNXJEYYTGzt17Huvc6QzK/kOrt/wzm1v4/kFlXIQlKergcd2boACtUProJ8XbYeLqXu6BhHLVaB+FZcJc3zjMF7qNiNZxrcDSRa3fyt7gyEQxiKhdMPF8Kof/HkXZwd189NIQ1Sm0TUgoOh3ol/t0eKc4+Ax9gRji06jRinZDwYr4r+myutVF87fuZ3v+WjW3RK1MQRZ2fjQyWIWukoDb9Aua/dTezg4X5jl7DLfjGV/Fc383l2iu04PEnm/mos/pV4kQX7XqBdVC3hNdswMdWvVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfZB1YEW3TN3HS+PPRuJJpL+corUGKZ44A3sCqsGQWI=;
 b=bb2R52+Fescto49h0Eed7MoDvhSMMtSMtkfols2kU8xipPfmJQSlIFwkLyZFcDuQHhoBSvDN3XBAvlqIX1mn8106sD0BKLWL9hk0ZbErZDXU5ZqGL8lzh83TAX2ftJD+vbpqSagOYqLktDrOlaK0uWyTWdAp8XB+Wp7TS0LKHN5OqIR5YQ4U9g+1WclQOmNccG2cA41SwzovmGq/0sLS3+snxjVEYkjdJ8MlaUtn5ggsurtz2DE5hxfPnLzLIJtvjbBbX5EKsAGDF+LlcKMlNlo/iYFTs2J6w3X0HaxPYVdHkCWjJ7k16Iy3rdHEfzq6JzuStN+0fnqUNuqv7R2BQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SJ0PR11MB4974.namprd11.prod.outlook.com (2603:10b6:a03:2d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 06:48:34 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:48:34 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH V2 05/12] modules/utils/git.py: cleanup the __init__ function
Date: Wed, 11 Mar 2026 14:48:06 +0800
Message-Id: <20260311064813.619683-5-Qi.Chen@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 66181327-a090-41e6-26ce-08de7f3a371f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	WeXrOGosmh7mQBctI4Pw9vc5IpoI8mjPxwrtoOUggLZ+oSVB634A4Mc0ggOH29JTYWLQRTl0sSW78kp42K636zk+BBLWj/NRVz98ruBx4FASzgrfJ+8Dh5/mG6nKdypsRJuJAzk1GQoFppJDcYRsRS+XN/KfoJgc5kh4sdbRwXwUlk9dH+D9wkfVSjRcI23IOjP66rlnUzstyT5jEkEczowPP1enSayjytvlqJiIRU0WvaHLSXC2GKZG2oncBcFasSrtglF7AL85+PTglhE8XJPGstzfFAsInNcxqJ8PouZVJJVUmBkK+8yJj/rJtmC8fA9jE/Z8Gg2CZ7S8eijXIH8WxxvsQCvaVfAsQxi+zsf8lxPxcsqlb7QTwZO0JHfA3k9ktCA4Nr/vZK7x1KD/SFNkDgLJ8LRIN41HIHcGvXPzOytyJ14yuTdsElQ66J17/Xj2HXhLC5YY7+dhNoPL9Rz0jIg3ylz1VQmbecNzivlihmXHR9Ix+4JkXlJNmu3hjf00nyjYfKMWcG5JRvIxOgcU7FBsx2KyOEPIgbk7zDSFYPl9tRSEaXKjvkHWTZPQSwELqiriP6DRjq58wYJnPZAfDDlR5VgEssEVFHPO7LOFDjOHhVWOU6Pi2vsDYrcROnB28wGKRSRKfhpL5qMMHv7f66QrUBkMIR6+tyceAJDeM695VkxVi/yFxOpRwJ4JGz2NZkcWdiA4MNUWBUJHVZ+EokHfyCprCNGqVaD05Vq/d9ogh3/tD8W1vdtWpuFq0p0UpML5NBbXenFNkHdKYzJ6rp9PORLvTaOaNci0d18=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LOtH4Z3opJnu0HXyGKKhb6VNSAXo7O/uBSpnoMNnycRECxEiwTmVoS7KnAJh?=
 =?us-ascii?Q?yIbz3AIkzvZ6UUm2CqAjhel9dPlNGLCLmkbMIOSlgoLtGTvbMr+qI+rKogjT?=
 =?us-ascii?Q?/jDe/wKPNmdUjVv1Z8GHXwP0zDNDplNWis9j0oyj4DwTy+5c6qO+p0LsOtLO?=
 =?us-ascii?Q?OFe2dRaDxsKuE/R/agSBTjqrFa7sZj6m4qdmzYPneHtK5M3CIPSTADMDXqYe?=
 =?us-ascii?Q?5ir3oq2joh9MI/DQfkf0agJqMIxm4mlD2WsRMZsAbZjcXLf5oj9TEGDjU5Mw?=
 =?us-ascii?Q?+KcXdEOsk6lYgR3hnf3fQimUcv1FiJHty/CY2NUlrEGMOvmJi/xGcxASRGuq?=
 =?us-ascii?Q?nz5XPz9OjIgcoqh5IJlZIa0hDp5KwhVbqDbUOz5ZvRluBHpgxdBxw5kHI+08?=
 =?us-ascii?Q?YjJ15aiTz4RSOvYw0lFUB15MxBnW6OY5GFcxczkvd1MGbru9NYbTf2Q0KKL5?=
 =?us-ascii?Q?CeMPB8T0nH2y8We6y1KUoZcwPNMjFqOYNbthLkbUzQHAVnCtfBLWJ2nXzZxo?=
 =?us-ascii?Q?aPRqH2ahOpzXNkIkvP6jegcnhUOhztvmg/1tLjIbkkaC8fmPGxhk5FlaGB89?=
 =?us-ascii?Q?K8IVRqWxutN6PETEuDfYaEoK6Uh3XOMyDpig/10LMhewNzYqFMbX9S75g26k?=
 =?us-ascii?Q?EG58LKNtz+8Fpgu1/n/OdQnKZfSbPPKu/IYYPFpd/jod6TGpXT0u0mYbD+GZ?=
 =?us-ascii?Q?Rj3gzCld+3cjc46Rh4GAyzFZQlNdKQj84Xy4ayuc4d41BZ0xBrpOb9+eU5up?=
 =?us-ascii?Q?dHDgvpPB7yDkhNsZt8GR5MIfK3uKq5zMITo2yWbVpPKia1HcHtdaAM9Gn3Pq?=
 =?us-ascii?Q?oM8j5f/1+2jH0TFCufhRQpmjLa4aiHTzk3RK4iiZwOjY+H4FB2cl9yJwDnkB?=
 =?us-ascii?Q?L1rfAwXNvDCdYS+yYHeewfs7gKpqMEJrBXQucUHoxkOf1ga+/IXlNhLjg0eU?=
 =?us-ascii?Q?AmkVQulHKfreptFnbCzA3vP6HNp7Q9U6vXziOZqraLKY97eh4f1ytgQnepDo?=
 =?us-ascii?Q?E6sP1ZJm/OOCJ9Ebl08Kz/QLJFsye3PujTOYHfPvMnkB35RPTuSJIf/6qR0g?=
 =?us-ascii?Q?O4kbTS2eq/wXr4GY7SIIEYiHkQSE/bqaUoRUUdnCi8spRYZOfqZLDDftz+gT?=
 =?us-ascii?Q?UBaftAnh8MzuWek8Du7aYlFv6nAqh5JeuGthsnh7++FppBxK1R+c0BxH4NUd?=
 =?us-ascii?Q?+2Jo5fRwlwCn1xX/FVbkeuPhBDGqJEtU85bTvShrRmF1xYBeUOH2jvWtLNSA?=
 =?us-ascii?Q?M6yI+HH7WBr+H+mhWXMjVH/x1qRG2csw5HTFRy/F5NOrGvjC5opp2lKHcOlq?=
 =?us-ascii?Q?/YOJQPqL7weHooF3t/2svIN+BGCYm4xKFws1wM3EAXWZI1Kr2YL/9/k5ysTL?=
 =?us-ascii?Q?qTZKr5B2pm72eGvuajjFtWgxsVV+tYcOxhhaWrquNgT1mvr4bC+RDrMUIisv?=
 =?us-ascii?Q?bUwFojvyyM/MDc5yieOUCpC7B5ZpFX0mByyLCHuIiZguPuL80IPe2/plvMSP?=
 =?us-ascii?Q?R0ElmSz+YlQN/Lc6kBz1OXNF1n9YeAP1kJ8zpBXm63mr979JttZHqOxVzGl7?=
 =?us-ascii?Q?GiOtGKJKcuANuLWTzY8wt6+260cBbZulXYc0s8PMpRNa40UTls//YNeBN1XM?=
 =?us-ascii?Q?SqTxkMP64YEZ1ynAiwZBZTpuD9Ia+kA2bsgIHL5Qj7KukKzEI8Vrk7qUD7YI?=
 =?us-ascii?Q?D9a+Bf1oRfUqh5vHT6iG0P8VhWNYFduZF8IO4wdAk4KUJRXrSvzGNtW04GI0?=
 =?us-ascii?Q?zwuthRqPzA=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	eTQFdeiE62fd/Wn04Di3eniZ01hhkxlFQzRmKrqre6qdYkQVruk03Ti6YUgJnSaIYwgAxkX3yrc612VPAVZJE9CjNP5FzKDu1vvPjiCML4o2Y5BYmt75J+tctbbqIWC0N3C6l2WTcZk/tCMPBEkThHsWtw7I7JfrzB2x5bgmppDISba/EdDvTN8Kl/xI+vJXQw8Md0xJ0Yv+CDvo43fMsfP+H8YN/9QttpUff+mRYUuwJdLNLeJmdNyJgSP9/KASJPzGW0CFcJahHJJE+4xhemeNIp2Vhwf18/FuEcHwp+pkO3GmkUArynujoUWPDbQnyyC0r2N99n3xA4hIABvWgg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66181327-a090-41e6-26ce-08de7f3a371f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:48:34.5610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RX2BqoqRBXvUeWvYD/1/h3CR5RSnAxt+db49bOpeRz9j1Ig204SJ8CeOxLEKRYxKDIahcLa9CAINBm6WMqGQNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4974
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NiBTYWx0ZWRfXz9ibdSNuERxN
 obzCMUIDtz3AJmB8LaMRNiT7f5BhHspNieDFjm5zwoJF0qRP5xzYjk9tQah111yYVsLyOAYyRmD
 pQVVTMpUt6MGBOIV88ywSKYADlEpGKtmTUvDdx8w31yHqN/mpqU29447iNG2Kx0Ol7BAjeqxtTK
 SZOb8IwcPxUQVsKAPYukabd8+9Yk+fkgboe7ZshCKUu4tVAkCWLksPVAHOZtV+EtBRKt34IbbFI
 j4guBdreXXhhD8C5Qyux83q/cYj00jvkXyYE57fnqKqzJknNlSq8BwKjSuXITbNnLX9Zf0QUYXF
 xOXzpgBZt3kBS57bKbUWlbjm1wepKUr3kItVoSqe9I9tD3+mFNKZywM3kB05yhHD+0z3ut5q0sj
 YCcXX2kIvgnVsE4PT5jvvW5qVAPFG2ntow1jSPuEctoCszjOiOe9rfOW296Ge2wbTQTqt2USAeG
 krYwnDBIJhEqeuphvpA==
X-Authority-Analysis: v=2.4 cv=PvWergM3 c=1 sm=1 tr=0 ts=69b11044 cx=c_pps
 a=vMZ8N8iCC09X6dpNzQs02g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=llld9UTGmMUyhnCEcBEA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: e1u5wLgJsYtIctfFnYVKkcRB3dokarQK
X-Proofpoint-ORIG-GUID: e1u5wLgJsYtIctfFnYVKkcRB3dokarQK
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
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:48:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3418

From: Chen Qi <Qi.Chen@windriver.com>

The "dir" is not a good parameter name as "dir" is a built-in function
of python. Use repodir instead.

Besides, the super() call is not needed as Git inherits object
directly.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 modules/utils/git.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/modules/utils/git.py b/modules/utils/git.py
index 0482d26..b504ab0 100644
--- a/modules/utils/git.py
+++ b/modules/utils/git.py
@@ -30,9 +30,8 @@ from utils.bitbake import bb
 from errors import Error
 
 class Git(object):
-    def __init__(self, dir):
-        self.repo_dir = dir
-        super(Git, self).__init__()
+    def __init__(self, repodir):
+        self.repo_dir = repodir
 
     def _cmd(self, operation):
         os.chdir(self.repo_dir)
-- 
2.34.1


