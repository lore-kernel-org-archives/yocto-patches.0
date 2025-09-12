Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FD6CAC58E
	for <webhook@archiver.kernel.org>; Fri, 12 Sep 2025 01:59:02 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.5211.1757642333508746767
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 11 Sep 2025 18:58:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=no6Q0Ftj;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=1350451926=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58C1ZdHF1181280;
	Thu, 11 Sep 2025 18:58:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=BpYOtwQMS
	UGWX+h/aFdJ/H9KQKyZzJrmr123aBxiix0=; b=no6Q0FtjprMYvI5or70v/6dor
	XldtO53f6JIy4OE0N2yNpgdolB92zbMSUDinyipHk4As9HkJb/4vna2Pd9xkwBqF
	3bCssE9BHwvQgFph3HovFyfreqdGm7DK+OUa0p3/jgS4Ojsxt4o3JqhvDXipDO1U
	9e1mIgMxS9K1iGtPcHam0STHpb8H4cvJcgFM2sk3VLQU7SS2PZKUYlWOgiyA/dAM
	rmjpT8R1p+JMCSLICTMXRfpy8Gx4kRrbYGF081paO2E+RIJpevop/0aF9VzClh0o
	GhBHljOA7S8dN03JD1nIDDzft1CoSTyrFCxHZ5vfHs2OxGwtUH38HZFPYR75w==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 490g80epxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 18:58:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lA2cpJxCX/Mo0nmzrNdn9V9ACXdnLmizJFoVgiCqiEgycpCHgUKGNxIIg61g89GilCeJyIP7NqVZIlIj7Nd52Kvd35jf6Tof/UO7tr94/mRjLbmF/PpEz/mnNUwP10lTj1qg4H1gs/aH2cGYekStRGT7CZMbN6YvDP3l3UahrDdSX1qrWCkLQyFOxig7nFyA74UHx/f/7Cm5Ogr3m6T7QElkBiOyoV+O62dUJjG1IHZTnzfvhI53OmBHcREBeLFmQz9UMIC2nu3L3gK6XA1FjI/FhlRTOfllsFR5BPFON/d7ZTWI4L7xZHmtez2VtYftJTQ66F1CQskQynGVjVH6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpYOtwQMSUGWX+h/aFdJ/H9KQKyZzJrmr123aBxiix0=;
 b=nWXQLCAeABa8SFIhhGOi/jd2C9GRJUcXYdXgadYVzka58r8KcVjbUqdfsVqXhUJ9Xk/uiW+cG9Ywy0vdJqkMNuJHgGnz4cEyJrV46NBADq/fmpM1qq2hTcLJJYi8ShPdm9GmlW4HTZTe7/j6MMMfrdn3YD1/1xbuq65N3WYOW8kOsWyFTwo3rhQzMj/xBaLrZOIzfHagC7pn5WEdjkfDbUiFtJq/mLzFa3+xhE1BvB09giG7MApVqihESjiFNv2mCF8OEPRMShLOyYS49FMyW3yJWYPLBHxXtYrwn5E32T0bfMBkJWVYBqUUK2TYsb1oUDdrsiThD2hqs1+UAK2r4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SJ2PR11MB7646.namprd11.prod.outlook.com (2603:10b6:a03:4c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 01:58:46 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 01:58:45 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com, rybczynska@gmail.com
Subject: [meta-security][scarthgap][PATCH] python3-fail2ban: fix ptest failures
Date: Fri, 12 Sep 2025 09:58:25 +0800
Message-Id: <20250912015825.4163290-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0371.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::7) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SJ2PR11MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7eb6d1-3cdc-482b-ed14-08ddf19fe857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?3MryA5H7VfS/jlnWoGYwWnJnkLL16MOYmEIy4nJlFjTMVGFZyzBQtxyAdaeb?=
 =?us-ascii?Q?Jblu+U5+4kddNsRoDyyzpVtlshszK291X8zTfY0cCPU9EhYa/r3lFUT7rQfP?=
 =?us-ascii?Q?zB6rcHrECadu81E2c3l3bi2YsOw4BjL3sV5kEAaGrSKmerMGATb3S+feNLFh?=
 =?us-ascii?Q?HjjSvupHh9yED8aIwPuYWeNfx+PNVAFWIi2RPOUO81cWOPyM+617NydKsBfv?=
 =?us-ascii?Q?ZsIizFBuSzDyyl9lRZKWn67nKsXnEQSC66QpHada2heEzzDSHcq2nyB4XgUy?=
 =?us-ascii?Q?tpGEQpPUNje9yZ+ADWpAPQpg1mAL++zlWjJteoRdNCIF4FN96P2lcG2tG8G3?=
 =?us-ascii?Q?Yl0mZJLY9NFyKX/cOj5FbHYu16wOJQny0/ItVylv64KeXUPYLkzHWV9YVz5M?=
 =?us-ascii?Q?xNs0b96bTYoYj4uJX7CnncJ2Btgo5a7apD5WkOn6C8orPmW9OY8Nb8mj6Vh7?=
 =?us-ascii?Q?5LVlpZrFYi9fCC/Wi85/pWYtV2s/dR48/aWcOyrlG1ecoXE9GnzlZh2nx5rT?=
 =?us-ascii?Q?pkqt018IEti9A+/DMUrUVd/bKGVuu86K/QHqXHPQcZSugvJ0I/jdBmt9xppw?=
 =?us-ascii?Q?vaY9xmhpv9t/sFa0kaELL5beNSgcl3YM4QSLek4V36ZK0AFgriWnO9v7G3hF?=
 =?us-ascii?Q?dGgOZbeet1aOtp4weusIHxuSUCO2qin3TzKbR++1VUCcZvdCJbLX/lIfZxKb?=
 =?us-ascii?Q?Aah2ozfAjcZtWRL2kLoDS+I9HwrIn5FQAiqNPIwXhOAZBNwS9t0mKHJgJLPX?=
 =?us-ascii?Q?nTukCobAxO1OEZvqvpr0SPAhnP+dr45qRfp6S74aiFmCW51ANbeNP1q78gEj?=
 =?us-ascii?Q?Jrlt2H61k4E2/xWcZpKk+NXSnfF0xIypV3Fytbny8S7Hw3S8Cl1fGLNC241B?=
 =?us-ascii?Q?0Zi8o6dTncW1GIj2H9iAbzNHYEQBWo+r7neMYJLQGCYVBmaR2x0kafNxiLf2?=
 =?us-ascii?Q?VNKgY8o5EYOEDAOT3YSGhtL0aM+37GbF0u3b7WQ4cdtQ30xmeiuE4j4p8JgL?=
 =?us-ascii?Q?pu/Yf4g+J8fGXuvk0DuVSYdWy7lM+X/EiwzepLewbDGXDdSJATSdMU7J/EvS?=
 =?us-ascii?Q?0tTofK+cruz5mz0D+Ie5/tSNWQAaLa92n1pv+NBDG15ZmIZeytVVM0Cetooh?=
 =?us-ascii?Q?klpfUsxj/igNtIy8n6JFGyHdosKcVyvyVH2gXlo0iAU+nvKYkcc9/Jz53P0S?=
 =?us-ascii?Q?ObuiqINKnHw0vFDYNUTmY6jHzSoSjmSd0qAPON9sYPV3G8AJIPiPUZTAZcpK?=
 =?us-ascii?Q?gxxZm1FK4gASMU7wLLIf/3C6c8MiL/WcsRuz7EhbhC3yXP6DzI9gFYSkaLKE?=
 =?us-ascii?Q?LH8VVJ/eHV2CtrB1Q2FTuVjDTQdz8AXfUsUhD0LbRmz0X7aCAKbYLXKDDgX4?=
 =?us-ascii?Q?EgcBXvt0y9wWGgpzGy/LsdJWYORRJhWInUU3eQXu5nJXUkT1acoDYN4qGbc/?=
 =?us-ascii?Q?r0BRF3mZil0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(13003099007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HMivA08rXUcL5uABRupNDpd6VqD0uQ/Umym0vkIBgutXiOtMjt2Jfo2nCqiR?=
 =?us-ascii?Q?U46R+Kob/vYAOBQEckiQkofTJe0yviazGdsY5d5Od6M6EcsnQISmHf8L/Xv3?=
 =?us-ascii?Q?3Uo+3bi3aOWS3QsHTF11Sm/A0CfoehlqtITf0dEYnMPlFbjXV5P/TzBuHZvO?=
 =?us-ascii?Q?5ddAuQYdTYuaXYu3cawvZZMiAk895O4P02kPesRVzHvrC+kET7V67AVtm4AS?=
 =?us-ascii?Q?cBv7mFqepR0p2AinU7IdWKA/3Kzt06yaTCcO4sqf71rXD0rOZi/YMJLgNat8?=
 =?us-ascii?Q?Dj5w/SElOH25XaJbLdUBG4cCgirBy6luGDwLgcHVoTtWetoFz31X2UKAyc8C?=
 =?us-ascii?Q?ZAAy1rjnPioEpPlSUYHoGnZlncgJDd5WQuIpyREh98xA3DP843on/k45JB7R?=
 =?us-ascii?Q?RDHtPWuLTuQ12vD6v8ehjTQvnCbtRAfj0163HB7PZW78ZNoQyTLq7uMG0qvE?=
 =?us-ascii?Q?834xpW8OTm0sRW/HIF9XFpnd4KNnS6cRI2/T/GyvOw2t+Mgnj4kqTG5MwReb?=
 =?us-ascii?Q?tZBm6tIeFjGrVLjX0N46Ic94pcuoveBzxGEXyyBPslA2se+aXvOR/VvIqDpa?=
 =?us-ascii?Q?12SVKDynt3PRtf5UB2qlZoNOVOAd5WoIIejEXu3ezg+aFQZWk7HSGRxZjyMZ?=
 =?us-ascii?Q?iV0P9TzF43xt7bb9oJacSpdx8zvOY8hMTbqhIwwxAN3njOWa7OeH2llz7/WH?=
 =?us-ascii?Q?ZYnajQh++WTuKTCKC92EAQD7r7ggqyFNUj30K/Xwgs3iC6D0jtDuEyATCflg?=
 =?us-ascii?Q?tDEn2KJV6ayEKZ4ot7h6BeNhRCzxg1HCsdZQU47r+RKVNMGWB4rzXFMM6gis?=
 =?us-ascii?Q?4wxNiwZ9fUYeu1NKBLGT2gWh1E172A/r/FQapQIrrWawVB/o+A+BavfKuMg0?=
 =?us-ascii?Q?JTgqsrxtHisIuII0y9jNKQLhN76byl+gp6sLCItBfMgnDytWZenNoEn2QYoQ?=
 =?us-ascii?Q?pfZNB87Nsm/AsmPp/sPE1d6W0f/ddFlkqu6VyDscEZF6LGfTBeEtK/HtV/jh?=
 =?us-ascii?Q?c+vVTsQbBNFjmnCHHs5N9vFOOeWJd4p7mpUKvianvD4uQoh5lEkYS91JAYB1?=
 =?us-ascii?Q?LiLgNSy2PbwFFHuWB85m5iA4otGBqSEvpGTDZLF8SHA4tZyHaSZqGYZL4lIq?=
 =?us-ascii?Q?fpYNyPHyCNChGQw0d87CbZfsl4Ty8yJN/r+863gu64kusSVMzKgnMoQ1XcPV?=
 =?us-ascii?Q?XNxmxLhlWNl/yZWLHD5ReElRpk8ocxLAcDjrKpgPrkUlyuGUyYuTqr5jd26X?=
 =?us-ascii?Q?lzXP4BiRLMNiVXoHb/wjApiezFW8LS+arP6Grg9yhFeYSO9A62Zbc/rBx00Y?=
 =?us-ascii?Q?g2vYKr/R5r86zpEsskSgwsQhR899+r7qWh/9ynz+6qUcj7wzbrM9SjDkcXf8?=
 =?us-ascii?Q?Zm+P8T9gYjrA/4gHKtBfoCUcOZl1TUyv05pVXsdvTtjgHFbLjQLnGsz2rwDZ?=
 =?us-ascii?Q?Cq68nb93qHwRWetiQR+zdXIynIfNDJgzi1vdMV1LVCvxbNFpitlIgv4UZv3M?=
 =?us-ascii?Q?WnT+H4qSlwdmy2LrnC4sJmHZa4azuxGlhy7149LLDpPfb/KorZsKpyg5cb2p?=
 =?us-ascii?Q?u8Q3/uXc7NKnmuxMnWdFz7ZPRTd0ppulnYfc7An9?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7eb6d1-3cdc-482b-ed14-08ddf19fe857
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 01:58:45.9149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xStQJu2Wq9o0zzlGAxr3AH1RmmzpDqe8Ew/Icq3zw996svIS5JZyGTOI/w4XG/U9oZLJlJriCDFbYOEJZwwBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7646
X-Proofpoint-ORIG-GUID: H8-BHO59XiTGvtA6J5wETVCgPUcUFWeQ
X-Authority-Analysis: v=2.4 cv=RaOQC0tv c=1 sm=1 tr=0 ts=68c37e5a cx=c_pps
 a=DAnEN4zbyIEUnuRlQkh4pQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8
 a=A1X0JdhQAAAA:8 a=ktNasmvQAAAA:8 a=1XWaLZrsAAAA:8 a=xqzR1eaSAAAA:8
 a=_XDxjdB5o6fYZ9oTqksA:9 a=2WnUeqSxssMA:10 a=FdTzh2GWekK77mhwV6Dw:22
 a=e0GJpZYNDejI1RnTdwpm:22 a=dV6nhpJrT-yxOfsl7Uss:22
X-Proofpoint-GUID: H8-BHO59XiTGvtA6J5wETVCgPUcUFWeQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEyMDAxNyBTYWx0ZWRfX24EbTud1Kqw1
 lQ+Q2L0O/dY1bffKoyKcPqdj5ykPBL8I7hinGrjOgoodt0hCHMxyqWLYSqv/OuqoU2/JYKAPHwo
 PqP1/HaBZVUCgrNiv9Kag9dLhD3JQpfDpjt8AsMMnzts6IdiWszbJ2s8WyoKXBO6bafEchJptnC
 0lrnNH4OzfcJViAJK9Zfvm3YmK/fM/SUzqb9QwqsjyGjkNm/TR1GQCvB+WG33BR3Rc9TNnMR8Ru
 jEYjV/SXmYe3hf/MtDX03ewyy2jgzPQpCPBR4bjQchDg/571ZUBRdGg5V0fCu0pix8mIIBAZIbk
 H3HL/H+2zTCuouZHehyQpXHNFh/qJdipUEcO/4Hto8aCSnBUERkJpWz8d2uzQ4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 12 Sep 2025 01:59:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2183

Fix ptest failures by backporting patch and updating test case config
files.

Before the patch:
  $ ptest-runner python3-fail2ban
  START: ptest-runner
  2025-09-11T15:42
  BEGIN: /usr/lib64/python3-fail2ban/ptest
  <snip>
  Ran 524 tests in 23.023s

  FAILED (failures=5, errors=7, skipped=3)
  DURATION: 24
  END: /usr/lib64/python3-fail2ban/ptest
  2025-09-11T15:42
  STOP: ptest-runner
  TOTAL: 1 FAIL: 1

After the patch:
  $ ptest-runner python3-fail2ban
  START: ptest-runner
  2025-09-11T15:59
  BEGIN: /usr/lib64/python3-fail2ban/ptest
  <snip>
  Ran 524 tests in 25.982s

  OK (skipped=3)
  DURATION: 27
  END: /usr/lib64/python3-fail2ban/ptest
  2025-09-11T15:59
  STOP: ptest-runner
  TOTAL: 1 FAIL: 0

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...ges-the-IPs-again.-additionally-it-g.patch | 210 ++++++++++++++++++
 ...case.py-set-correct-config-dir-for-t.patch |  34 +++
 .../fail2ban/python3-fail2ban_git.bb          |  12 +-
 3 files changed, 255 insertions(+), 1 deletion(-)
 create mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch
 create mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch

diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch
new file mode 100644
index 0000000..73014ab
--- /dev/null
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch
@@ -0,0 +1,210 @@
+From 5b6c13f0aae79a23d94570bacd1b5796e57f088d Mon Sep 17 00:00:00 2001
+From: sebres <info@sebres.de>
+Date: Thu, 30 Jan 2025 01:05:30 +0100
+Subject: [PATCH] example.com changes the IPs, again... additionally it got
+ more IPs, which look unstable now (depends on resolver), so replaced with
+ fail2ban.org, that seems to resolve to single IPv4 and IPv6 (can be adjusted
+ later for something more persistent)
+
+
+Upstream-Status: Backport
+[https://github.com/fail2ban/fail2ban/commit/5b6c13f0aae79a23d94570bacd1b5796e57f088d]
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ .../tests/files/logs/apache-fakegooglebot     |  6 +-
+ fail2ban/tests/files/testcase-usedns.log      |  4 +-
+ fail2ban/tests/filtertestcase.py              | 58 +++++++++----------
+ fail2ban/tests/utils.py                       |  4 +-
+ 4 files changed, 36 insertions(+), 36 deletions(-)
+
+diff --git a/fail2ban/tests/files/logs/apache-fakegooglebot b/fail2ban/tests/files/logs/apache-fakegooglebot
+index b77a1a6b..024842fd 100644
+--- a/fail2ban/tests/files/logs/apache-fakegooglebot
++++ b/fail2ban/tests/files/logs/apache-fakegooglebot
+@@ -1,5 +1,5 @@
+ # Apache 2.2
+ # failJSON: { "time": "2015-01-31T14:29:44", "match": true, "host": "66.249.66.1" }
+-66.249.66.1 - - - [31/Jan/2015:14:29:44 ] example.com "GET / HTTP/1.1" 200 814 "-" "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)" + 293 1149 546
+-# failJSON: { "time": "2015-01-31T14:29:44", "match": false, "host": "93.184.215.14" }
+-93.184.215.14 - - - [31/Jan/2015:14:29:44 ] example.com "GET / HTTP/1.1" 200 814 "-" "NOT A __GOOGLE_BOT__" + 293 1149 546
++66.249.66.1 - - - [31/Jan/2015:14:29:44 ] fail2ban.org "GET / HTTP/1.1" 200 814 "-" "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)" + 293 1149 546
++# failJSON: { "time": "2015-01-31T14:29:44", "match": false, "host": "51.159.55.100" }
++51.159.55.100 - - - [31/Jan/2015:14:29:44 ] fail2ban.org "GET / HTTP/1.1" 200 814 "-" "NOT A __GOOGLE_BOT__" + 293 1149 546
+diff --git a/fail2ban/tests/files/testcase-usedns.log b/fail2ban/tests/files/testcase-usedns.log
+index eea6eb44..3e7b36bb 100644
+--- a/fail2ban/tests/files/testcase-usedns.log
++++ b/fail2ban/tests/files/testcase-usedns.log
+@@ -1,2 +1,2 @@
+-Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from example.com port 51332 ssh2
+-Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:93.184.215.14 port 51332 ssh2
++Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from fail2ban.org port 51332 ssh2
++Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:51.159.55.100 port 51332 ssh2
+diff --git a/fail2ban/tests/filtertestcase.py b/fail2ban/tests/filtertestcase.py
+index 20945b78..26961a1b 100644
+--- a/fail2ban/tests/filtertestcase.py
++++ b/fail2ban/tests/filtertestcase.py
+@@ -587,14 +587,14 @@ class IgnoreIP(LogCaptureTestCase):
+ 				self.assertNotLogged("returned successfully")
+ 
+ 	def testIgnoreCauseOK(self):
+-		ip = "93.184.215.14"
++		ip = "51.159.55.100"
+ 		for ignore_source in ["dns", "ip", "command"]:
+ 			self.filter.logIgnoreIp(ip, True, ignore_source=ignore_source)
+ 			self.assertLogged("[%s] Ignore %s by %s" % (self.jail.name, ip, ignore_source))
+ 
+ 	def testIgnoreCauseNOK(self):
+-		self.filter.logIgnoreIp("example.com", False, ignore_source="NOT_LOGGED")
+-		self.assertNotLogged("[%s] Ignore %s by %s" % (self.jail.name, "example.com", "NOT_LOGGED"))
++		self.filter.logIgnoreIp("fail2ban.org", False, ignore_source="NOT_LOGGED")
++		self.assertNotLogged("[%s] Ignore %s by %s" % (self.jail.name, "fail2ban.org", "NOT_LOGGED"))
+ 
+ 
+ class IgnoreIPDNS(LogCaptureTestCase):
+@@ -607,7 +607,7 @@ class IgnoreIPDNS(LogCaptureTestCase):
+ 		self.filter = FileFilter(self.jail)
+ 
+ 	def testIgnoreIPDNS(self):
+-		for dns in ("www.epfl.ch", "example.com"):
++		for dns in ("www.epfl.ch", "fail2ban.org"):
+ 			self.filter.addIgnoreIP(dns)
+ 			ips = DNSUtils.dnsToIp(dns)
+ 			self.assertTrue(len(ips) > 0)
+@@ -1892,22 +1892,22 @@ class GetFailures(LogCaptureTestCase):
+ 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
+ 		# We should still catch failures with usedns = no ;-)
+ 		output_yes = (
+-			('93.184.215.14', 1, 1124013299.0,
+-			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from example.com port 51332 ssh2']
++			('51.159.55.100', 1, 1124013299.0,
++			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from fail2ban.org port 51332 ssh2']
+ 			),
+-			('93.184.215.14', 1, 1124013539.0,
+-			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:93.184.215.14 port 51332 ssh2']
++			('51.159.55.100', 1, 1124013539.0,
++			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:51.159.55.100 port 51332 ssh2']
+ 			),
+-			('2606:2800:21f:cb07:6820:80da:af6b:8b2c', 1, 1124013299.0,
+-			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from example.com port 51332 ssh2']
++			('2001:bc8:1200:6:208:a2ff:fe0c:61f8', 1, 1124013299.0,
++			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from fail2ban.org port 51332 ssh2']
+ 			),
+ 		)
+ 		if not unittest.F2B.no_network and not DNSUtils.IPv6IsAllowed():
+ 			output_yes = output_yes[0:2]
+ 
+ 		output_no = (
+-			('93.184.215.14', 1, 1124013539.0,
+-			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:93.184.215.14 port 51332 ssh2']
++			('51.159.55.100', 1, 1124013539.0,
++			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:51.159.55.100 port 51332 ssh2']
+ 			)
+ 		)
+ 
+@@ -2098,10 +2098,10 @@ class DNSUtilsNetworkTests(unittest.TestCase):
+ 		super(DNSUtilsNetworkTests, self).setUp()
+ 		#unittest.F2B.SkipIfNoNetwork()
+ 
+-	## example.com IPs considering IPv6 support (without network it is simulated via cache in utils).
++	## fail2ban.org IPs considering IPv6 support (without network it is simulated via cache in utils).
+ 	EXAMPLE_ADDRS = (
+-		['93.184.215.14', '2606:2800:21f:cb07:6820:80da:af6b:8b2c'] if unittest.F2B.no_network or DNSUtils.IPv6IsAllowed() else \
+-		['93.184.215.14']
++		['51.159.55.100', '2001:bc8:1200:6:208:a2ff:fe0c:61f8'] if unittest.F2B.no_network or DNSUtils.IPv6IsAllowed() else \
++		['51.159.55.100']
+ 	)
+ 
+ 	def test_IPAddr(self):
+@@ -2163,13 +2163,13 @@ class DNSUtilsNetworkTests(unittest.TestCase):
+ 		self.assertTrue(r < ip6)
+ 
+ 	def testUseDns(self):
+-		res = DNSUtils.textToIp('www.example.com', 'no')
++		res = DNSUtils.textToIp('www.fail2ban.org', 'no')
+ 		self.assertSortedEqual(res, [])
+ 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
+-		res = DNSUtils.textToIp('www.example.com', 'warn')
++		res = DNSUtils.textToIp('www.fail2ban.org', 'warn')
+ 		# sort ipaddr, IPv4 is always smaller as IPv6
+ 		self.assertSortedEqual(res, self.EXAMPLE_ADDRS)
+-		res = DNSUtils.textToIp('www.example.com', 'yes')
++		res = DNSUtils.textToIp('www.fail2ban.org', 'yes')
+ 		# sort ipaddr, IPv4 is always smaller as IPv6
+ 		self.assertSortedEqual(res, self.EXAMPLE_ADDRS)
+ 
+@@ -2177,13 +2177,13 @@ class DNSUtilsNetworkTests(unittest.TestCase):
+ 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
+ 		# Test hostnames
+ 		hostnames = [
+-			'www.example.com',
++			'www.fail2ban.org',
+ 			'doh1.2.3.4.buga.xxxxx.yyy.invalid',
+ 			'1.2.3.4.buga.xxxxx.yyy.invalid',
+ 			]
+ 		for s in hostnames:
+ 			res = DNSUtils.textToIp(s, 'yes')
+-			if s == 'www.example.com':
++			if s == 'www.fail2ban.org':
+ 				# sort ipaddr, IPv4 is always smaller as IPv6
+ 				self.assertSortedEqual(res, self.EXAMPLE_ADDRS)
+ 			else:
+@@ -2234,8 +2234,8 @@ class DNSUtilsNetworkTests(unittest.TestCase):
+ 
+ 		self.assertEqual(IPAddr('192.0.2.0').getPTR(), '0.2.0.192.in-addr.arpa.')
+ 		self.assertEqual(IPAddr('192.0.2.1').getPTR(), '1.2.0.192.in-addr.arpa.')
+-		self.assertEqual(IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c').getPTR(), 
+-			'c.2.b.8.b.6.f.a.a.d.0.8.0.2.8.6.7.0.b.c.f.1.2.0.0.0.8.2.6.0.6.2.ip6.arpa.')
++		self.assertEqual(IPAddr('2001:db8::1').getPTR(), 
++			'1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.8.b.d.0.1.0.0.2.ip6.arpa.')
+ 
+ 	def testIPAddr_Equal6(self):
+ 		self.assertEqual(
+@@ -2365,10 +2365,10 @@ class DNSUtilsNetworkTests(unittest.TestCase):
+ 
+ 	def testIPAddr_CompareDNS(self):
+ 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
+-		ips = IPAddr('example.com')
+-		self.assertTrue(IPAddr("93.184.215.14").isInNet(ips))
+-		self.assertEqual(IPAddr("2606:2800:21f:cb07:6820:80da:af6b:8b2c").isInNet(ips),
+-		                        "2606:2800:21f:cb07:6820:80da:af6b:8b2c" in self.EXAMPLE_ADDRS)
++		ips = IPAddr('fail2ban.org')
++		self.assertTrue(IPAddr("51.159.55.100").isInNet(ips))
++		self.assertEqual(IPAddr("2001:bc8:1200:6:208:a2ff:fe0c:61f8").isInNet(ips),
++		                        "2001:bc8:1200:6:208:a2ff:fe0c:61f8" in self.EXAMPLE_ADDRS)
+ 
+ 	def testIPAddr_wrongDNS_IP(self):
+ 		unittest.F2B.SkipIfNoNetwork()
+@@ -2376,11 +2376,11 @@ class DNSUtilsNetworkTests(unittest.TestCase):
+ 		DNSUtils.ipToName('*')
+ 
+ 	def testIPAddr_Cached(self):
+-		ips = [DNSUtils.dnsToIp('example.com'), DNSUtils.dnsToIp('example.com')]
++		ips = [DNSUtils.dnsToIp('fail2ban.org'), DNSUtils.dnsToIp('fail2ban.org')]
+ 		for ip1, ip2 in zip(ips, ips):
+ 			self.assertEqual(id(ip1), id(ip2))
+-		ip1 = IPAddr('93.184.215.14'); ip2 = IPAddr('93.184.215.14'); self.assertEqual(id(ip1), id(ip2))
+-		ip1 = IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'); ip2 = IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'); self.assertEqual(id(ip1), id(ip2))
++		ip1 = IPAddr('51.159.55.100'); ip2 = IPAddr('51.159.55.100'); self.assertEqual(id(ip1), id(ip2))
++		ip1 = IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'); ip2 = IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'); self.assertEqual(id(ip1), id(ip2))
+ 
+ 	def test_NetworkInterfacesAddrs(self):
+ 		for withMask in (False, True):
+diff --git a/fail2ban/tests/utils.py b/fail2ban/tests/utils.py
+index f71ba60a..e6ef54f3 100644
+--- a/fail2ban/tests/utils.py
++++ b/fail2ban/tests/utils.py
+@@ -326,8 +326,8 @@ def initTests(opts):
+ 			('failed.dns.ch', set()),
+ 			('doh1.2.3.4.buga.xxxxx.yyy.invalid', set()),
+ 			('1.2.3.4.buga.xxxxx.yyy.invalid', set()),
+-			('example.com', set([IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'), IPAddr('93.184.215.14')])),
+-			('www.example.com', set([IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'), IPAddr('93.184.215.14')])),
++			('fail2ban.org', set([IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'), IPAddr('51.159.55.100')])),
++			('www.fail2ban.org', set([IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'), IPAddr('51.159.55.100')])),
+ 		):
+ 			c.set(*i)
+ 		# if fast - precache all host names as localhost addresses (speed-up getSelfIPs/ignoreself):
+-- 
+2.34.1
+
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch
new file mode 100644
index 0000000..ab957da
--- /dev/null
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch
@@ -0,0 +1,34 @@
+From 9137d3f47a9e0c0e1aad11a71bb8ac8d0ba21b4e Mon Sep 17 00:00:00 2001
+From: Yi Zhao <yi.zhao@windriver.com>
+Date: Thu, 11 Sep 2025 22:36:07 +0800
+Subject: [PATCH] clientreadertestcase.py: set correct config dir for
+ testReadStockJailFilterComplete
+
+In test case testReadStockJailFilterComplete, set configuration
+directory to CONFIG_DIR (/etc/fail2ban/filter.d on the target) instead
+of the hardcoded "config" directory. Otherwise, the config files will
+not be found during runtime testing.
+
+Upstream-Status: Pending
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ fail2ban/tests/clientreadertestcase.py | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/fail2ban/tests/clientreadertestcase.py b/fail2ban/tests/clientreadertestcase.py
+index 0388fd3d..670e5b76 100644
+--- a/fail2ban/tests/clientreadertestcase.py
++++ b/fail2ban/tests/clientreadertestcase.py
+@@ -861,7 +861,7 @@ class JailsReaderTest(LogCaptureTestCase):
+ 		self.assertTrue(jails.getOptions())       # reads fine
+ 		# grab all filter names
+ 		filters = set(os.path.splitext(os.path.split(a)[1])[0]
+-			for a in glob.glob(os.path.join('config', 'filter.d', '*.conf'))
++			for a in glob.glob(os.path.join(CONFIG_DIR, 'filter.d', '*.conf'))
+ 				if not (a.endswith('common.conf') or a.endswith('-aggressive.conf')))
+ 		# get filters of all jails (filter names without options inside filter[...])
+ 		filters_jail = set(
+-- 
+2.34.1
+
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
index 1d0fb62..762ae8f 100644
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
@@ -13,6 +13,8 @@ DEPENDS = "python3-native"
 
 SRCREV = "ac62658c10f492911f8a0037a0bcf97c8521cd78"
 SRC_URI = "git://github.com/fail2ban/fail2ban.git;branch=master;protocol=https \
+           file://0001-example.com-changes-the-IPs-again.-additionally-it-g.patch \
+           file://0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch \
            file://initd \
            file://run-ptest \
            "
@@ -49,8 +51,16 @@ do_install_ptest:append () {
     sed -i -e 's/##PYTHON##/python3/g' ${D}${PTEST_PATH}/run-ptest
     install -D ${S}/bin/* ${D}${PTEST_PATH}/bin
     rm -f ${D}${PTEST_PATH}/bin/fail2ban-python
-}
 
+    for i in checklogtype.conf zzz-generic-example.conf zzz-sshd-obsolete-multiline.conf; do
+        sed -i -e 's|^before =.*|before = ${sysconfdir}/fail2ban/filter.d/common.conf|g' \
+            ${D}${PYTHON_SITEPACKAGES_DIR}/fail2ban/tests/config/filter.d/${i}
+    done
+
+    install -m 0644 ${S}/README.md ${D}${PTEST_PATH}
+    sed -i -e 's|^logpath = README.md|logpath = ${PTEST_PATH}/README.md|g' \
+            ${D}${PYTHON_SITEPACKAGES_DIR}/fail2ban/tests/config/jail.conf
+}
 
 INITSCRIPT_PACKAGES = "${PN}"
 INITSCRIPT_NAME = "fail2ban-server"
-- 
2.34.1


