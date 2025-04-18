Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A4BC369CF
	for <webhook@archiver.kernel.org>; Fri, 18 Apr 2025 13:12:27 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.11286.1744981941298771499
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 18 Apr 2025 06:12:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=6203b7563d=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53IAdPGh025280
	for <yocto-patches@lists.yoctoproject.org>; Fri, 18 Apr 2025 06:12:20 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45yqpkqfc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 18 Apr 2025 06:12:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7fdULjbqFAV5ukSMjcvUxPu3xKKsc7oyKjTIXOavky2i+TrOisFczACKaEZbj48xIpgOI+0hsscPdafee73RkwKlRzceZXNLSLz4wvHyvKgx4HuZ3Hag81ftZ/D7Mezif/cDQ9Zf9/cjOdYUZprCRM3Kuay6GgpyNigp2+2/+kfPRryNIBrgu+kcD8zLGcD49jcfpNsiYicWJe24TxH3d0OTN9RI2dPjKMwnL5ft47YvwgB4JFh3+CskNS/RkmUYxTqXi+ypEke+y8Y9BHYQgZxZa3rfCyrm9QRkaQBmPq6E9zSJGevysJywfY4i4apyK68jP4CB48AkB9CCt9g+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kjt28icJ05Z3MXQdBv4lhyQPEe331e5XUSNWGBVo+0=;
 b=dz/WMVbpFQUKz7Qh1wOOstsgpjfsIzW5xzm1EFcUv/f7/iYInCViZu5mNiil9O7JLBG5XNbMDIhI3YTIcIGVtz9O9tUlYzmuECJ9OTsHKH8x/a4ILzGuqS+KJYfvhhQgy+YCgPAu9dUOVqZogM/efAbEX5upMoqZ9yFm3iBkgu5UH5nMTKGLWoHNgPzsYLg7Cvm30axrK0nX/gkTdD6Trlw2ziJ84XjzZlPth+YFYe9ToA88Vs+nEYKQY1SPpBf7OJRTeViJjRA6jRUKxUkc14B8vpRmKI5N7iP20nkjzKSdI/4KA5/94FoLP75NnMbtIuqOfAM/cPQdqKpxvc+J9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.32; Fri, 18 Apr 2025 13:12:17 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%4]) with mapi id 15.20.8655.025; Fri, 18 Apr 2025
 13:12:17 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH v2] scap-security-guide: disable ptest by default
Date: Fri, 18 Apr 2025 21:12:03 +0800
Message-Id: <20250418131203.838267-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0202.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::15) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SJ0PR11MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e4e5f5-0985-4f32-2f92-08dd7e7aa50f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YDgV+wwI4WOYwIkj0YzMdDFtWs+fjbZ30fbuvHM1jkJqGkdFlTbAoehdwgA6?=
 =?us-ascii?Q?AdmODGLrFmRKInfXANA4M3CjUKuv3il6fZh/iJpPUJEjPniJ7bHliEWidY0k?=
 =?us-ascii?Q?NXvGYr6EOfi1nrTsv7GnIF47XSl2o2sm/BdFD4K7HVFyqOdb3g+40zUvnPJH?=
 =?us-ascii?Q?XoBpKzx7EVtXfTnUTRJoz/qJutq5TQ3wmKguD0C4Wq51P6z4l4zZYFUFA8rT?=
 =?us-ascii?Q?rGA9pu2Wjus/5hk9X14O+tjMQG//FWw72hZo9zkU3w7yetlFj3bzH7haxrJN?=
 =?us-ascii?Q?KRqnzjgPkmUyh6ObdUVZIsOv8teiG5+YU1akBbCFJCmcFgIRrPBNFlX8kqBc?=
 =?us-ascii?Q?hFXVYsrwJcLPJ1Cx+y5VO73uJ8K4fNpYOL0MCqTTUSImS6MAHC375lByz5Pw?=
 =?us-ascii?Q?tTE/rQLpY61IRBqbUcH0am34mdPxFdgPdwqI4O5aZ+e0HKXSJ1zKjysLc5+x?=
 =?us-ascii?Q?WQrk9YrKxCXqCd2oEj0fyU4y8rodCy8v36zGOTmy+7qREYKSPtBDalrhuJ58?=
 =?us-ascii?Q?yEvq7FAuQslFwjYYdTZckVBKFjRvbUw1EoYTOJ/NGPSVWZDNta6HdvOn2XZ4?=
 =?us-ascii?Q?s8B0LgfjOiWDaTDjeL4Qx2lplCYAetPyYr4B/bn59tA9hc5Kqk2T1yI7D2uW?=
 =?us-ascii?Q?K3dflMt6jgMHVVdF/ZzEgUT7j+AxDpPGT8KAzwX0Nr/0u3z642FrqW4Vere1?=
 =?us-ascii?Q?2qg9vJyU6vNsBrw6JfDyV9oeDFNgEVoUmZXgbBvJwSLQ04yMGobI7kYT8jJK?=
 =?us-ascii?Q?ZaTjHo7spS93VhsNdn/cPq+CHfjMn4PoOPrlf0xE3ROukl1EPp4AeMSLFECQ?=
 =?us-ascii?Q?AsGR8eZ3Xl42osunsht1EknF+9g23L1sUseK9xw3vwYGjrw3UT+AtsTR/2+J?=
 =?us-ascii?Q?IioltDXk8CJEHG1XwmTIG7149qo8DDqPpKez2KOKu0b9rcsPUi0cxwr2U0YH?=
 =?us-ascii?Q?TOLgDfww2TDpPWSvK8nvbvXhIGiGdWuYPfSzbQM+e4arlkQ9oWiXNqxvUydb?=
 =?us-ascii?Q?YnB+q+U+rKUCLVyPSVgNEqQHeTND8a0OYsPAXOYnIpTdk76EBl5Ieh4HHjAF?=
 =?us-ascii?Q?pWpSi5dJQdvZi6RH0jHV31oRlxpYEqwbaaPVZge/p1ifg7rIhGv0ZSpiyoUQ?=
 =?us-ascii?Q?dzd6JLTV4lebHJQ9aT50MTH/QgzZlOo7RFZ8DKnMyq5PA7Afry3VJb0RlEJN?=
 =?us-ascii?Q?9SZJbPvI/MD5EsSD5BD+P00rXWUtPrsxq5RG0EcflI7rKH5meKQWY3g2KhaO?=
 =?us-ascii?Q?HMvFkvaIT05/xEaLEPqTX1vyHH8h4WwYxem7QM97bIMMqCddjq1/JTpwkzvV?=
 =?us-ascii?Q?sVcuFjJzk8OzEB8V8ubJdR2LH7lPJpSOq2WcaY2Tq/1VzPBEVJZL5OXG8LyR?=
 =?us-ascii?Q?UatugliVvd13Jf45AxmBoE4J/h9AF2GMMd+IB1/PHWb6oLaBXQEuNrN+9ZPh?=
 =?us-ascii?Q?7C82GSnF0HlRBrw6IWvtmNiOE3A5naUL0DwrTQERa2D2unrxTe5Pxw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wnGtpY6kTK8JkMWDU0sJ3GskLvUXNmG9pdqOp7rNZBtVm1Dobz+3lB6yyBQ9?=
 =?us-ascii?Q?HfbB6MFbTjVhVLhulOXTSRhMm+ZKnIg7wIhxbGmYbFRY4cplydyNaJwm+0Tq?=
 =?us-ascii?Q?VOBIl7e7sN2iAfLtlMMxi2+LS2FxRS3LMf8k0gkIersnio5MUM0ugraISA5I?=
 =?us-ascii?Q?FdxRf+3Dp9ldFIxJAA075tdVS+XuAAhIchr17Nt7ofMNq8uBjMnNU0DOZXIQ?=
 =?us-ascii?Q?dQVvq8zxHdO66myz64EB8/znkGWXj0Wli4rLWwuNKclchIEcZBsjwJeqArxZ?=
 =?us-ascii?Q?Tq4uWGPqyxxEZ5ptgpXKGT1KbkhshAtUE3WcqjdNX89uct95Fox8VHAfa64l?=
 =?us-ascii?Q?1HCjUdrwHV/7FUrT8BQOIH1pNC8NZ7YjpwqbK3kO+/xiE+rel3hlP08J97Uq?=
 =?us-ascii?Q?lN0AY926z7u4Hh7Ox1Lj/Z/oklYWyuG0JoCh3PEblIrbZbFXCQYeufYoZnDq?=
 =?us-ascii?Q?GRqjMMVXlwgTHmC6nQD4kTCue3Dug725qlmw21b38VZwxaPrJnG9eqDbyMEl?=
 =?us-ascii?Q?yyAh8k+vVFuWvWNplNYUPG7NbBgk42k7Fk/uM/eYoxtaUKMif0BuRNF1PZ36?=
 =?us-ascii?Q?KLnrqlAHaisQke+uqE/KLMoLYZjimJBls6zOBoO5NWqd0PmBG1025HAkeCw9?=
 =?us-ascii?Q?eVXHZueeupCX6nTOl+V3pCxo7QL1Oh7BwMl9keAWsmsl9FIv7WDZWJ2U471i?=
 =?us-ascii?Q?vdDIOmuCpJTWErck/akALHi8BwaI3iRP+EIUD8g/snOV+QVGzxsT+MI1tUf2?=
 =?us-ascii?Q?yxVtO8E6uCX/nlhzRqhx7nqgZjBuyzADKR3r6JGaB+B1bIYVcFpeXhvpjVkV?=
 =?us-ascii?Q?fon5ZdRWZDUuDlSoZgyxcEfyFLIkt3+7mU5gTq88B097REjhYUF0UtEhZh0H?=
 =?us-ascii?Q?PiDA/Ox/vd1KOXKut1opscNtjoiPQn73CTqJ9PPB7cyDQpF8KxCr97vp0qi8?=
 =?us-ascii?Q?FyH6O49ZWIivVlw6nJzSyjUQxueSMd2cvUYwTiyy1W47+xBC68CXXiVFqt0k?=
 =?us-ascii?Q?zo6LMRjc8N2Uff9GHVEavPQVQhv0VgDbWLxUGS6casWPcHybcG4tkmul8vgf?=
 =?us-ascii?Q?kbVN0TGqOkiFKoIRWFFrtrCdFGJ0IkW1WMa8j6VXpUVigjxkaDY+ZJNzEETR?=
 =?us-ascii?Q?eBYqX5YhLCSMjlJfTvUBIo4rfZ3cTW2NYeS59tKQwEeqFBvj9S6Nq4RCT8zj?=
 =?us-ascii?Q?4A5Uu8GIp16FbbzBGuS3erVk6P/hLsVnFUeb6p8Z/5SWgR7xHM29Ha3WszMn?=
 =?us-ascii?Q?6nrRo04ezapwf9/Q/jLYJVDphCruI6Av4G2axnLidw9Ak2/8UpSWvD6APu49?=
 =?us-ascii?Q?kKMy3OzvgeE7gENiGlyDcliHmimJqKO5Ta7+D0tKj/2FT4W6YrhLBRdV7OWf?=
 =?us-ascii?Q?KPMeB0gfJspL2YgRNE9dBPuMr6qf5QqQvFWx5SORy1Ughkpd2/HwyeMRWMkF?=
 =?us-ascii?Q?HmjEo/NGHCXfbZlR1DYkJU6OchC2zVNTHYsY+P3bwT616bZG3JsmRJIohFe/?=
 =?us-ascii?Q?W1PL0QLQydp2RGsctpcTqXXusfpQ92C4ZPzuaKOLFus8GCKmAN9mCGwas+Hu?=
 =?us-ascii?Q?GGyLsE6Bs2abMrbJsf28kEDFuLV1jgcd5mdDCpNA?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e4e5f5-0985-4f32-2f92-08dd7e7aa50f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 13:12:17.8785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFB7xMuJcrQtAYldVyz6M7PbrQnLzryUeoQxJrlTqGnfvde40/4GtlWBnoi97twqTUr4gCDR/xwLaknfMmoFng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7704
X-Proofpoint-ORIG-GUID: i0huJ_tFozxyCeiaf4Q6O08TKQDaDTFB
X-Proofpoint-GUID: i0huJ_tFozxyCeiaf4Q6O08TKQDaDTFB
X-Authority-Analysis: v=2.4 cv=UZBRSLSN c=1 sm=1 tr=0 ts=68024fb4 cx=c_pps a=F+2k2gSOfOtDHduSTNWrfg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=t7CeM3EgAAAA:8 a=9EVpTSRJU6vyofUetV8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=893 lowpriorityscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504180097
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 18 Apr 2025 13:12:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1385

Enabling ptest will significantly increase build time. Additionally,
since the ptest distro_feature is enabled by default in poky distro,
build time can be very long, which is annoying.

On my build server:
Enable ptest:
$ time build scap-security-guide
real    266m41.257s
user    1m16.895s
sys     0m1.553s

Disable ptest:
$ time build scap-security-guide
real    1m29.228s
user    0m4.604s
sys     0m0.175s

Add a switch SSG_PTEST_ENABLED and set it to 0 to disable ptest by
default.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../scap-security-guide/scap-security-guide_0.1.76.bb         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
index 73bd576..c91a5f9 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
@@ -18,7 +18,9 @@ DEPENDS = "openscap-native python3-pyyaml-native python3-jinja2-native libxml2-n
 S = "${UNPACKDIR}/git"
 B = "${S}/build"
 
-inherit cmake pkgconfig python3native python3targetconfig ptest
+SSG_PTEST_ENABLED ?= "0"
+
+inherit cmake pkgconfig python3native python3targetconfig ${@bb.utils.contains('SSG_PTEST_ENABLED', '1', 'ptest', '', d)}
 
 STAGING_OSCAP_BUILDDIR = "${TMPDIR}/work-shared/openscap/oscap-build-artifacts"
 export OSCAP_CPE_PATH="${STAGING_OSCAP_BUILDDIR}${datadir_native}/openscap/cpe"
-- 
2.34.1


