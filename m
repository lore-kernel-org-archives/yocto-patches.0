Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808BBD39404
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 09:25:21 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11680.1775121913182852109
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Apr 2026 02:25:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=f5xYkeFG;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8552396193=changqing.li@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6326PhMi3916485;
	Thu, 2 Apr 2026 02:25:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=b4S0VvVtb
	b+eccfmSpTTZe+6H38M4oFNtDZ0cX9/CQQ=; b=f5xYkeFGeXD+VXq+eefq6wm3s
	TmNe0Fcxr8PoSYHTlWCTePCwcVpkhFdbr88kyT/WLWvKbC9nqSnidzFQ6y/FQp+v
	hBd8qvF9wDHP2js8Y9icDn4ufy9pRS1CrLikFT0HvX5hWgsaXaqjUI7jIKZQCC71
	aLbRM6K/RmMreCqsL3Mi3Mghqybmrv/O/UAdeED5HpnR8U6iR0CMg4aOjGJIRPRd
	35ik+rY4o44PEi1lPZFYNVbQc6uDKLSvPyKeYLVV6QNVet65jHjLud1s1j/PoRvq
	k4c5AwZLmvXnTbHucag07I/uSMvE36vcbkLBIu/RI71irZNBGmtRawuwNLSeA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d6a8vfcwj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 02:25:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pf4MGyJRFh6N6qdcl7phFhGj2auh63sOCv9DpqDrxWeESQoTl9cE1shsp043C/lljYb6V7Hss6Bd0GTnxD749qmczUCMpLxoBnu3N+Shz4oh74e7udOBJNhV9X5DSf11Hc8qWkecR7Ew299V8XFN38AFFnZCzrUhzrVWtxZR6etMFqhvZwFkYJN5GF91FdZ+R3SmxIZmyWbrj8laSpLJk5ENCkPD2GL1My90+eufL3nawCm7q5++mdnaZPhbz4ZVyFyHkf90Cq/O3qAaHfqBstPFQVewi3DbzUc+mBEk4MyQOGQ6QiMOfa9dl5QpEakwR6ci5XYRDjz/4a/qfS+5fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4S0VvVtbb+eccfmSpTTZe+6H38M4oFNtDZ0cX9/CQQ=;
 b=KqpgBzuTLXA/Lx7JxteQdlK459BazQnW5idbmCyXxuxtGIkUiWM8DwakSeHkLGPptuyH5kkd/W9gU6zA/2B2kX3VlH9GWpj/l7L3PDUMCKx9kb4InANuVZxO1HfNrfHZVCK3E5naQz1J6D2gwI0cqI8tRHRLzyXavXzOzkT96qE7/qwqE3icDmr/3pc94vZSl1yG4KPVVgzYMG09WcbBcZzlbxerXHTJRt2aPkq3glDRmCP1xgcs4bwBrHznGhuGVY0xe75q3GlRIaDKqvfImQgp324dFOwk0BuL/UzWogepcJXC2a9X7jxTTVijJmbqEKfztPa6nlFclGO5d41WVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by SJ2PR11MB7456.namprd11.prod.outlook.com (2603:10b6:a03:4cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 09:25:08 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::531e:6ef5:812b:48f6]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::531e:6ef5:812b:48f6%5]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 09:25:08 +0000
From: Changqing Li <changqing.li@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [V2][meta-mingw][PATCH] mingw-libgnurx: fix do_configure failure
Date: Thu,  2 Apr 2026 17:23:57 +0800
Message-Id: <20260402092357.895867-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0019.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::13) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|SJ2PR11MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: d75848b8-6b65-42ab-4463-08de9099bb38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	zm1QOidS8wB1p1F1+/Fzf/N82hJ7Z3yH34Wf9UsDaK51FdaMVcov4T8sjRwcK0RD172UHDgYfj7xvE1wsxnjeWiHjTjyU2sNnxHg6hrVL1YDac3PVjCgTLr8GUcMUUeZf/OlFmS4zXlFUE52hLL/MBSeQ85v0ln+5RkFIMakBbZp4wQJRpObxSM2g+b67JY1tBkVI0Trq8SpVVzoL9kziMFAABQsxgojbkrtqCc+zJanYRAxqHF/Z1idSamXDfMp8MYqDPUim5i7reRWAZHcrDbpC6bGItS4/rOwCJecixYGOvTuFaHWjMFTvltJ/hZWnGa3oqmFKp2hVKzxBauHTi0ect1yEvCKysUB2LkslbA6fC2YZWa5D2Rs9oJV41KcZqHSyLikuiBATmXeesZmHOMluW1yZiPafHAT1yJ0mdyo4efZYjJwfvRml2hxA2Hq5GmeG1fKdv/q/3i+QlHqLrMToVh96dX79MmeoZtB5Rb10akpTUW7bB8c/EzSPmHDAaJqPes2vbNnBnT8PJXYHaiElNHc71W+nrhL5NMiDqMwt62FeB7z+zALtZ+ngM0/CrKkcMp+WxtIcXRgDDiEGobR28TLGFpTPmIEAqI7O4GI1LN6xtfswBZIoNQNyxiw+Ih9hpVpM6GVy9Jv+eThP8uHwUXrJitROxKXdRk/EzIaCVFulgaBgvmGZCRyk4Kjj5fb59/wgZAVJ0xLaxZZjimoAzmKQRl/uDUf/ygP8fi/77Wkpf6yw31DiweLpyUz2rcCGihPX8FAG3gm+sAf2A5J8wwjtsq60dulRpl1NwY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?F/aRy3jxbbpvHET9V18LuFgJQTRxvlTPZm+Ti2mXirGqVovw86btz1+EjKYh?=
 =?us-ascii?Q?Zqom/tK/5G7bqdsWqXSVSw8OkoLgwObB/VnrHUztJBcr6VOpvbAey5SxoNUi?=
 =?us-ascii?Q?Syy8Xc9XUc48jgWTl9LWbo8pLr1S/4+sOg9L7VUBzYkKI9sISp/cvxZwTIv7?=
 =?us-ascii?Q?5sNk96jhhgJkXjaqp1Xd2OSQQcbe/o/s0KjXTNg9hCQy0rFBNLtYHV8M4WyD?=
 =?us-ascii?Q?zXdYBrkVvveOaKKPpPcJ+QCgENx3nv8GdFbE30TXt3XQ/sYYa0SWsmyPdeZT?=
 =?us-ascii?Q?qSR8VTs9FeWiOWfOeU7PksD5+yj3qD9mm0dJ71bCfsjWPWCiGUM0JFA4ouCE?=
 =?us-ascii?Q?Z3Kt8yWN/Y03m6vqo7f240pY5ZmFJepy6h1m1Qh6t0TTEh52qeIi5aeqsFDI?=
 =?us-ascii?Q?BkIuFHRATwql10fblZULHeWBgSt35QAvgA6ahHhT0XtWtuqBBhZ0bndV7SaZ?=
 =?us-ascii?Q?0GIX/luqAa3TbmqOXItj7AFzNIo2KnOryUgBjgPVFTLfazD3v2pNnwW/+qeZ?=
 =?us-ascii?Q?gMGmjhjsJeH3nNmMzPEju1bl+w/LF494dQdH37nQpnJpQP1Wy26ToodvL16R?=
 =?us-ascii?Q?EROvBjHrjglWI0JRmqxItlx3EG86kyoLtqp0NbsLZNjRF6OjVYISlnAIjT/0?=
 =?us-ascii?Q?myIj+OmsJOBBRDotmmyjl2tbXygcosh8o6fZP8F4AZIAjpA8kczjN1Yny5h3?=
 =?us-ascii?Q?jd81h0EwfDrWlnQb1Oik3PSq+8XYiPQ2sgQ5+qBOuoBXHdxyWHZG+yqHzsH6?=
 =?us-ascii?Q?NG+70AjDsKwjCpXf9JLit2htAa5UNkbVOuuFqKaWJCNtCxSz1rsycqiY0tN9?=
 =?us-ascii?Q?nAe+2raHJ6ryJtOZpi5mbJOqdizZpkwgwxXBfa38i7YY47gagrdIempft+GX?=
 =?us-ascii?Q?KH5wkrJ24JoKb4+zLs4SZdrmBXHwJ5hasn633O4aZ82ybM7j+Rw5Qa2mZVn/?=
 =?us-ascii?Q?KvUcRCmYJ8CVQPTlrzhhaPzJA2OdlJhKQlfZLLpdNIe26jNGIt/+lmQjy3j7?=
 =?us-ascii?Q?4kstz6yHXFGUfHvFnHZHyU+tRXoTUds2i7duvw6ZtZdxw2KwVY5lkMaHTkFS?=
 =?us-ascii?Q?Ep5NAtvAfYhnI+mEwyMfixZMkCqb9R/z5dsA+9n7vtiLmyLCU+g0UBct5FeQ?=
 =?us-ascii?Q?kymU10sis66Ln0U3alwz5It8RVzHrkvkqaODWL461FdCNdEDeTMRzxD8FsFA?=
 =?us-ascii?Q?UrAzLkayxo9wfkdG1nMFrWtCwA9KPNIc1gVXCllAs9H5LFAEhA3K8xbYlXMP?=
 =?us-ascii?Q?jEtDd/j5nI11MZzW+pcbiL7KDy+LhqpcqAYIlgcx15ZNS2oz6E5lZCUgoD7R?=
 =?us-ascii?Q?ICaCckzby6Ulol/zC56nnhOtxaTIkVZKjiuU9dCX00y63LmRNFzMMPVRC5PX?=
 =?us-ascii?Q?57EHK7KpY38wQpAnvxsoBgREUKiD9Myo3u3ULQaxq9JcNXNhmFV3F6bmbkVl?=
 =?us-ascii?Q?Jg+XDmhMY9aPfMkGrqPGlXNHxSWgg1ud8/WPNHeJS+WbBeiUYqt8oG6UoWBU?=
 =?us-ascii?Q?n/uBgPyGNkTiIC6Zqnfqtdd2oRE8LmidcQAI66rgjHTfRtYj43LzAkyeWt/p?=
 =?us-ascii?Q?RNe5EwcsfmHaAzOL48RWoSSqAZQVvy/sa5TFOxfirGgOciFwlepW1twX69WE?=
 =?us-ascii?Q?fHr2ULVOINE9gMdsFPlqOPZ7cntKfXRV2H5HYgX5hTqYGLyyBuEVUGe55JZa?=
 =?us-ascii?Q?pZvj8R7MrDulorZL8x0p8n7zeoXlz5XdsVFl6U5fCHW8LdiJM0omt52cGiCo?=
 =?us-ascii?Q?88KY7CWN6PozFQdCLukc+vxIbm7YOLg=3D?=
X-Exchange-RoutingPolicyChecked: 
	i0ywF2qa2ydTFkW4LFvET1/wyi/ioGj6F89MbG6diW82QGfAn5JX7cYD5sSQ3MP+4tWh1vGHDGVzP8NzXpeCHn/dgONG2I8BouRhxKRJX02GBTo4q0p082QyRNu3yfokwlPwcBqJwiqiXkxESmiqiVdp4gg6xhxFkJcHbmwnk4r33ldmKLXodloVNtZOtH3rh/B6klz4Kao8Mu9PB5bohcqdo4r+8/o2ptrnc5vaJfYS8n70bBs2/jLS2LSWXnVRsw2IqnoXiwXvEGeoaBXQ6CyB0oTZkYJLHY4f+Kotihta+Mp+vL1AjMIUZybg4wpkVEuts3xmbNc3NexLUtRK7w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75848b8-6b65-42ab-4463-08de9099bb38
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:25:08.1315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdcSqtjpRH8mWO5lAJu1qK16jmAqlkC3iDTAUBrhQpnd0Wi9Bs10ANE3u/bKePIRNS3HMmpxbZ3/msTpjLlqBe4ThPGxgokaVkRnVbJ65cA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7456
X-Proofpoint-GUID: -xq1CrqA5vN2wvD7Pq6zNLvgzLvkAQVM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA4MyBTYWx0ZWRfX/x44WZNKub4M
 SkKtOx7mdpChza4/VZ7OdrrZ3mj7+4EFe3fDrrv+QSHTHGWLNeQRuZzAweRiVnMZAUQHVBIKGSR
 9rDisnyEtD6AE/6FO/ask8hVCfX+G2g7J6ITTzSXc4amXYY1Mex6aQYnhRy5gf1y0HACvxcAI21
 iB9IbJMVw1nKeuy0oxpwnUYX8wPE07dpK80tuo0oMJfEtdQU7+pSDiMYq1UO8vjl1OolJR46zyf
 ppqof/FFp9JXTH1ab+u+Ebt7VTdaGwgW96fGwVBvx6t0/FhOwwIKVj5oSKJOtTHDI8cF9WySdNi
 PE80thPllrWE0R0Xwx0cPC1R7YbUlhzezaIlOibkklsRYcO9OmiZ6QdtTpmmxEGS910W6U4uwE9
 0+flouQqVx5WNWDFdtRp8ODEyl1475SwtI+x99AD47Jfljlw5PLasGZA4S0lUPpFiyq3oduGFwR
 O20BrcwvkNilGgqZjCw==
X-Proofpoint-ORIG-GUID: -xq1CrqA5vN2wvD7Pq6zNLvgzLvkAQVM
X-Authority-Analysis: v=2.4 cv=ZKHaWH7b c=1 sm=1 tr=0 ts=69ce35f7 cx=c_pps
 a=Z+ESqgFbrcYkgT1kPBc/rQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=T24DDs6eBq6Sz3G6-0gA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020083
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 09:25:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3615

Fix do_configure failure:
| NOTE: Executing ACLOCAL="aclocal --aclocal-path=/tmp/work/x86-64-v3-wrs-linux/mingw-libgnurx/2.5.1/recipe-sysroot/usr/share/aclocal/" autoreconf -Wcross --verbose --install --force --exclude=autopoint
| autoreconf: export WARNINGS=cross,no-obsolete
| autoreconf: Entering directory '.'
| autoreconf: configure.ac: not using Gettext
| autoreconf: configure.ac: not using aclocal
| autoreconf: configure.ac: tracing
| autoreconf: configure.ac: not using Libtool
| autoreconf: configure.ac: not using Intltool
| autoreconf: configure.ac: not using Gtkdoc
| autoreconf: running: /tmp/work/x86-64-v3-wrs-linux/mingw-libgnurx/2.5.1/recipe-sysroot-native/usr/bin/autoconf --force
| configure.ac:5: error: possibly undefined macro: AM_INIT_AUTOMAKE
|       If this token and others are legitimate, please use m4_pattern_allow.
|       See the Autoconf documentation.
| configure.ac:7: error: possibly undefined macro: AC_LIBTOOL_DLOPEN
| configure.ac:8: error: possibly undefined macro: AC_LIBTOOL_WIN32_DLL
| configure.ac:9: error: possibly undefined macro: AC_PROG_LIBTOOL

Autotools.bbclass don't remove aclocal.m4 after commit:
oe-core: [7da2290a46 autotools: remove deletion of aclocal.m4]

Usually, autoreconf will always run aclocal, except when the current
aclocal.m4 is not generated by aclocal, see snip of autoreconf
[snip of autoreconf]
  if (-f 'aclocal.m4')
    {
      my $aclocal_m4 = new Autom4te::XFile 'aclocal.m4';
      $_ = $aclocal_m4->getline;
      $uses_aclocal = 0
    unless defined ($_) && /generated.*by aclocal/;
    }
[snip of autoreconf]

For mingw-libgnurx, the exist aclocal.m4 is not generated by aclocal,
so aclocal is not rerun, and configure.ac is updated by patch
0002-Add-autotool-files.patch, so configure failed, fixed by remove it
before do_configure

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb b/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb
index 5318ca4..47252b0 100644
--- a/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb
+++ b/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb
@@ -17,4 +17,10 @@ inherit autotools
 # Specify any options you want to pass to the configure script using EXTRA_OECONF:
 EXTRA_OECONF = ""
 
+do_configure:prepend() {
+    if ! echo ${EXTRA_AUTORECONF} | grep -q "aclocal"; then
+        rm -f ${S}/aclocal.m4
+    fi
+}
+
 BBCLASSEXTEND = "nativesdk"
-- 
2.34.1


