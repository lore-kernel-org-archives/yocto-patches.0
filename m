Return-Path: <Yash.Shinde@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48690C83F1B
	for <webhook@archiver.kernel.org>; Thu, 10 Jul 2025 14:39:24 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.10430.1752158355053048186
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 10 Jul 2025 07:39:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=92864f0a6c=yash.shinde@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A5bers023700;
	Thu, 10 Jul 2025 07:39:14 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47pyb5nc5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 07:39:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VpaqrfmUlI97Q3mE0gLhX95cRro1oo0jaHAfQtsGexs1S6vPEJLeEXx2ffzLgBDoZIuGQjezWxljpQjWuYtm1s6Sdsv6gwpMyd+8HjezqKsJYNRmAy0mYZisp4uEDg+sTtBt4GJ+Mte2WyQuiHgsiUNjNE/Hz0W0sjEAcY8MrPbE3ebc6oagcI68XgTNgdPUFlv1JRrrWrxLUTV8KwfSxXoggTLPdGCt0rStlA1njqrbLJtE1csoTYv6tIvamos//MV/JAXFe7nnpYIgiIsd8Sfpp74uZf5YlKINPPu9Q3+BU7E4JqLfZy6LP36tGiFeBYLH5gTxEsSZoeLIDq1/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzfGRSHJFBoyRs+x6/9ZsIkrwKegqqVsDfLifl7akVc=;
 b=DZqjTiAppAjKZVk7j1yA+56LzmIQxYPEW4WVN9K4pEnQMqSpoQoFy1eg8yp4tVA3bUciROfqem3US+uf9ECffNfzF3EcEIvKeew2MnYfAeWEuBVNLPkY4hpS1cgKfWzt/KgJhjae4wa7d19MFv5/e6i87qpR8YfA03IbM6jnOAgzo7rF13ferA02E32PPQ7QzRoCIj/gj0z0bhJ79P6CqJ20n1WzfdUzwed+J5gwZNOs5QGqw4niKUrcJJ6QjTAqPPoQ1Sb/LzeLbOnussOlTzZBIEO1iCfiCxo/EyRo9VgPrr54DNoaIEq5CNeMPcAZZMvavCKtHXtPJD5lQLTFDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7593.namprd11.prod.outlook.com (2603:10b6:510:27f::9)
 by CY8PR11MB6913.namprd11.prod.outlook.com (2603:10b6:930:5b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 10 Jul
 2025 14:39:11 +0000
Received: from PH7PR11MB7593.namprd11.prod.outlook.com
 ([fe80::2688:e731:421b:5ebc]) by PH7PR11MB7593.namprd11.prod.outlook.com
 ([fe80::2688:e731:421b:5ebc%7]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 14:39:11 +0000
From: Yash.Shinde@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com, randy.macleod@windriver.com,
        Sundeep.Kokkonda@windriver.com, Yash.Shinde@windriver.com
Subject: [meta-lts-mixins][kirkstone/rust][PATCH] rust: Switch Cargo build to release mode to avoid DEBUG-mode stack overflow
Date: Thu, 10 Jul 2025 07:38:25 -0700
Message-ID: <20250710143825.3854693-1-Yash.Shinde@windriver.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::8) To PH7PR11MB7593.namprd11.prod.outlook.com
 (2603:10b6:510:27f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7593:EE_|CY8PR11MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dbce3f4-2528-4085-e7d7-08ddbfbf88be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?j3ZOjVQgjwDngqV6EVV1l0OBKJwm1aVnCgsbE4VNNZrL01RnPclV6TC92Bn9?=
 =?us-ascii?Q?wJW6Rq62jL7CTv51ENrzxYqZV0MRpU3w/B+I3Wyrb0jA1QJsUd6Y6tO28UTe?=
 =?us-ascii?Q?tbt3r4MNNTK0NeOXwrqxCcQA0rx6NregAXzApk/6v0KF7SiPCkouDUilZd+5?=
 =?us-ascii?Q?MtWizaynenxtJzuLU+gtGiRFEDF4Gh0ISM3hNJ4etx2F4DTFOb8H7qxxOh1p?=
 =?us-ascii?Q?nQT071FXN3h5hCbBmLv7/5pK9UPgpVm9jDsK7gRUts6zmtB7cRxL043sM1gi?=
 =?us-ascii?Q?FtKKQOSUN2EvO1rLmEK3VyuvmI7nyeAo9WfnoW9/et3dLcmWL7OahXbZc7kv?=
 =?us-ascii?Q?u4sEEFUVs+nKIrUb2UffLGGGbZmlv/wpxmlXzSkuBiQVO9E4PDzBmo5ekfSj?=
 =?us-ascii?Q?fhlEsCLs7lnsuraUJ63cVvgOYN8hV7CLKirVFvHfXqL9ShSnGTeaRih0ey/v?=
 =?us-ascii?Q?rRle4gRUQ6rWhYj8ZfnkQLM44RzLQ5LneOSGqgrgxJgW0O8CDNvYOhLf8CvI?=
 =?us-ascii?Q?W46F4xGX4lJGwr5Gcv/nmoTdJLfVIJsAqgB/YCOSsmdQh/y4YvhTTfCxv0Au?=
 =?us-ascii?Q?EjoHBg3GVFFuZualHB0zSuAOej2OdUC7RJk2WNJno9+75SsxgiIei0Itpc2d?=
 =?us-ascii?Q?IdY1qpaH/TikHyvI1rkHjipliZbV7DtdEPIm9QhIBstazi/CFVE6EAtmxL1w?=
 =?us-ascii?Q?caEGHP6aGCQohmvimG4sas85CCl3acp0shFJh4bInDUBeO7QwIK9rsMYUi+r?=
 =?us-ascii?Q?As+szZ0dmTXsYl0gpAGr75bM373WOf4DVqP91RDcv2+IyeFZrEiBz6W720B2?=
 =?us-ascii?Q?MapufZnaGwSfT02DAETpXsuXg7dVpBWam+N2J21x8fKaowJjOJIUb5Ge2uo1?=
 =?us-ascii?Q?K/ob60zDk7j7bQiR45kvXgdw5eGLPqygm+1WIGt1+lH64XJQ9OYjWEkJlMds?=
 =?us-ascii?Q?CRkBv1gjUCiu8AONFy5qhfOadCTAKXK9wEujTeK0tqhYrJciuUJh7QkG5IcY?=
 =?us-ascii?Q?JesHIA4A1XCnM7zVBeh7gU6JbLlw/BszxC3/+TmwXLTP1RQvQaTgBG9hqIIR?=
 =?us-ascii?Q?ZnCGATWssGx99qobZd5y6u0N2QHwCpO91nRjT+GfGC5tG31yv1o52pNJWEWs?=
 =?us-ascii?Q?RGRBK/iISdQgjdlyJ/05HuqW3EK7fHgZw70wV2CwyGfzK0CGujSY8wRLrGlz?=
 =?us-ascii?Q?KUiY+7A9l2LcV1yPKOdu6gym4mBUESR2DOfJZgKqjiLttvHdo8DgOh4wKoBz?=
 =?us-ascii?Q?+l3jXnoCtTquHRre3pDEveOcwnB3Ta1hV/P65X3mjUkT/IwVvr2duv+VEiUv?=
 =?us-ascii?Q?GAYMEOgHFEDbzms/shMnBOQKkv5x3mkz9lds/MmIgpqEfzVmgY9hI28Q4DD3?=
 =?us-ascii?Q?qiv4eZe6/9Jkrm5zwsbVV2qg3gHYETq6XOTirJSMx+hjnhr2vWuY2j6QZayX?=
 =?us-ascii?Q?XczOupXdW2gqspmwVn1P9MVaKTkjruZrtf0FnXKdzmMmJnJ9fFWp8cj0BA3o?=
 =?us-ascii?Q?4CFDyv7tYVw3yIo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7593.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DEO88tMRJf8J66h9YdL3aBNL7swFIlX4oEWP9c7FJMWzyoXoGQopL/Q58w0Z?=
 =?us-ascii?Q?fzgZEOl9M/4IrlX2zb+tk9K9ZMVphvaeU+5YvQvcrlFzY96gVNjplOwxhTBB?=
 =?us-ascii?Q?rM4L5HrvFWytbooV2WT6OXX7n3X0JBFF7HiEHZ5UQV14RrY2TxtoAjc95rKx?=
 =?us-ascii?Q?GF8g4gyzNMANMAk035/rp1r6QxjvUNe7znxqUsf2r7+4lp5GvU6BM/8+g/UW?=
 =?us-ascii?Q?kEduOXiLXgX6Hk0u5VcRj6Zre3LfM22Bt/lvpiYx0k3FCDmtmQDX5Catb7Wu?=
 =?us-ascii?Q?n6dGo+se8MzW8UU1UlkPhsfO3NA4rt+FZBaM2om0H4xdZCGh4YKxuup7Vtsy?=
 =?us-ascii?Q?v7OfhG9B4N1RKNy+95e/2uychSsDeS9cyKnLlYtYEa68yPp86cjqsd7xR03q?=
 =?us-ascii?Q?3TeNnTayCqXwJ/pc3MWktcJ+AkZPRqydIJEGbTRdFprY+hPE6jwRWCr1L2sv?=
 =?us-ascii?Q?P3PxrjQTu6FpZf2/YMkXdVOwEpGa+/DFev5iW1x9gTLXLkIO986sOAaWJ086?=
 =?us-ascii?Q?5TjbuR3/pNzXguhthGUuepJVDSE3aBGg651NeDYeIh0owdDwpvvJ2NU+1q4h?=
 =?us-ascii?Q?X8hKRe2UVYEE8xS7T0R1BzYEeAztQnNSzNxM0rgjRwg4pP/OJQL31KUiO4o7?=
 =?us-ascii?Q?+fwg1eiu5qH3hBVXOUzutTrfIPwVxP/gGVDVJ9nGjLO3Pv+O02yRy8EH6Tby?=
 =?us-ascii?Q?Qx91FCFq3py+glkknN1Nr+k+Z+1XGPvDOyg76u6LqpxUPVkU0kk4u1whTH7S?=
 =?us-ascii?Q?Jgzk4BKSMkX6toa6n0qPmrbRsj+s5ocq7jO67S82itugrgKr0OnZ3xd0/+Rd?=
 =?us-ascii?Q?uzpLrba0NQRW1aWaykkb/F+YX/iBjWSHfbcAoqHis0GvTZLJpCKRrcrSI6br?=
 =?us-ascii?Q?Tpu1xAMOiK+i/af1Wtq/QT06s4fshaBqtWGLFvpcltfvxvR7RAQ+37aJCR1h?=
 =?us-ascii?Q?PrIWn5qGRfzgQ6KYA6qDnPnmprpwH/VhGka6TUnD0BqTIu2np0GJXkuh+++Q?=
 =?us-ascii?Q?HdJfFmtlCtNE2eb0jFT6bcTYbnSt58+N/6UiRKpkMDXckWLvNWhGt7EB+rtV?=
 =?us-ascii?Q?2h7UhU9TiI6TMfPPNwUVV5Ta9m9Dp0TFbr9HE86vtOlDFssqAcTS4ABzCjUU?=
 =?us-ascii?Q?YwOAANDG956KCaJQqa+sym2cJv5A88Qn431BYQqb9x4hhIL8NV+PY95kCj2W?=
 =?us-ascii?Q?4ZsblcPoy6wuHO1THIKJkENVsQx1lXgxzkWkfyXuDhlopRfd21FTqvBrNzts?=
 =?us-ascii?Q?DHncsEMjMAhfxFmwj/Fo+5UuzGaOBWwTbs6af1KZoeRrG1+cYlze15YxQ7fo?=
 =?us-ascii?Q?Sn/iQr4hUSMxZGNY6x5Fh4ydz0MJhFyAr1FpT3Ht+DXmpl11NQPGzvGiiXOz?=
 =?us-ascii?Q?cryEEqkEGupJk4zf2X8M/wISfRF+wuXgmGULY2FsRm4YSJNPWMAzTzLeYPYh?=
 =?us-ascii?Q?zB/xwm6mMmnjBnV/saqp2jmyxrcRWTj9/l6kaVfJIgPnNo/h7NAqUaoEt1Q0?=
 =?us-ascii?Q?mCbdO0dZvv6WUl71BK4URLDA7Dp3H0k8D9DjAU1hBCq6aJfcASNtN2/kD3et?=
 =?us-ascii?Q?EAXYRbsVJvwQ4fum2dw2q1JlaCNBoLU5U7rpaWRC7MBp8i3vEf6BNbsMpymF?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbce3f4-2528-4085-e7d7-08ddbfbf88be
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7593.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 14:39:11.3144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4dZbCU/KRGzw15U42LTPkHyBdfEht0SvZ0lukOIVE2wT226QCeZx+gS6B4ZQimZisEksBBSnIZ07y74oXreLHFNjGamqoBHIq354jTQn8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6913
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE5OCBTYWx0ZWRfX+66a8xkrjFUP 2k9uZ28+4zpTBksEIqdzdhJTCfNbcpEMIvS5Se+F3svCYjWkXs5oaH5xEEkkrnDL7250a+vX2bv yk6qShW6kMOJCHxGNzsQHbsHVZY3mwzbrJZoCqJhF8R6C9ZmJBIel04VUyftB6h4B4s+NJp2DUh
 JMP2myY/vReA4HevezvcHsYhXCKjCUC+ezHt7cUA/2AgL7GQFn/JSJ/4ZLu34xhDxz0n0yg5JlD aDM88BJe+ZAvfg6RQxJ/Ezvf8RlbRZOvQNWih40CjikOd1TbprXq1e8TQSbZaOyKc4Vj4OJOvH4 /Y7yV+ZYSYdgk9wZC9djzrlx4Mwdqi6wTpwMpmVJbU468822X7or7yb/uHEYghalBx/VTPue54b oUx0KkUy
X-Authority-Analysis: v=2.4 cv=V5590fni c=1 sm=1 tr=0 ts=686fd091 cx=c_pps a=dGWAkuArVSoDeCUgnScviA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=KuCMGVAfJcUA:10 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8 a=Tw1lYoi2277rRrChRjUA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: GdWjaiu68C35FMeHryFtEhKv20IL9sgl
X-Proofpoint-GUID: GdWjaiu68C35FMeHryFtEhKv20IL9sgl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 suspectscore=0 adultscore=0 bulkscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2505280000 definitions=main-2507080198
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Jul 2025 14:39:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1799

From: Yash Shinde <Yash.Shinde@windriver.com>

DEBUG builds of Cargo (v1.85.1) result in a stack overflow during
compilation of the `p384` crate, causing a segmentation fault:

TOPDIR/tmp-glibc/work/cortexa15t2hf-neon-wrs-linux-gnueabi/cargo/1.85.1-r0/recipe-sysroot-native/usr/bin/../lib/librustc_driver-9603b88fd542d97b.so(+0x1f43519) [0x7f9749cf6519]

note: rustc unexpectedly overflowed its stack! this is a bug
note: maximum backtrace depth reached, frames may have been lost
note: we would appreciate a report at https://github.com/rust-lang/rust
    Building [=================>       ] 255/351: maybe-async, curl-sys(bui...
error: could not compile `p384` (lib)

This issue is resolved in Rust v1.86.0. As a temporary workaround,
this commit forces Cargo to be built in release mode to avoid the
bug until the toolchain is updated.

Fix in Rust v1.86.0:
https://github.com/RustCrypto/elliptic-curves/commit/7652c5842cde60acc1e739ebbba34614cb158f8b

Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
---
 recipes-devtools/rust/cargo_1.85.1.bb | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/recipes-devtools/rust/cargo_1.85.1.bb b/recipes-devtools/rust/cargo_1.85.1.bb
index a6d3f17..f88f960 100644
--- a/recipes-devtools/rust/cargo_1.85.1.bb
+++ b/recipes-devtools/rust/cargo_1.85.1.bb
@@ -19,6 +19,9 @@ CARGO_VENDORING_DIRECTORY = "${RUSTSRC}/vendor"
 
 inherit cargo pkgconfig
 
+CARGO_BUILD_FLAGS:append = "${@' --release' if d.getVar('DEBUG_BUILD') == '1' else ''}"
+BUILD_DIR = "release"
+
 DEBUG_PREFIX_MAP += "-fdebug-prefix-map=${RUSTSRC}/vendor=${TARGET_DBGSRC_DIR}"
 
 do_cargo_setup_snapshot () {
-- 
2.49.0


