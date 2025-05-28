Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20C1C5AE59
	for <webhook@archiver.kernel.org>; Wed, 28 May 2025 05:54:35 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.9431.1748411674784247916
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 27 May 2025 22:54:34 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7243f5ddcc=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S5H2rp002836;
	Wed, 28 May 2025 05:54:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46u3b13qmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 05:54:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+Utck0QFx8YOHJUG2pXUAEUF33VPlRrIBNIDI1t3pPwq+p4GV8Y8TR5G4RzP2xMUMMzIVWZtejcIhXIilDL7LOgcuOjfz0EKO5xjRQ0oc8L0VQZo5heOTgO9LsDhX/bKnpI56eD1dqutn1c1LRWbDoy85AAbcjoG3CRuBTZ86x9R/cnG1w7HZ1cD9nLAN0cHSYTDicitawsm73NXHe13pSWJ9Gt+wVEbB8Y1ljADBhhUWr2/sJSI1ZpcLQ7bLekTKdmOLIVu4Td/5DUeWT4wO/IyDtDKfJKVwI+TWudLmsDKIi0aos61dBiPPqCq66NCSIUrn1IFu1o0e5wVfmJyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kjt28icJ05Z3MXQdBv4lhyQPEe331e5XUSNWGBVo+0=;
 b=IFEmEsmqnzAA3BZsV1xv6Ugr4jTPZpU+qVIUZ64nMh1kBCYHHGOhOfeqaQvQgWAn95elKVqZ9T/a3rMS/fwiyJk22YGgTBisNcuhH9y4ZK1G9IbTTPA2klQZZ4gBdFY5ntdPwBu63Az6kMoqUMfyifsOGzchOp5VxYHp2+m/U+VvZHoqWlhLRPigwqVZ1/kxudDEo802xCCbnmvQvkbF5Yk+ZehtQ+o3ZeUu47oAxYURHNCJFHzuQspOF92Lt5iwtHD5KAXj2FroapUo+f/oT/N/hznS9kcWFj0ci6brlVzL/hCzODRSrJDKxnyk+Ug3RwbdnoVEoOIw0VR3AQI6gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 CH3PR11MB8186.namprd11.prod.outlook.com (2603:10b6:610:15a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Wed, 28 May
 2025 05:54:31 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%4]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 05:54:31 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Cc: akuster808@gmail.com
Subject: [meta-security][PATCH] scap-security-guide: disable ptest by default
Date: Wed, 28 May 2025 13:54:17 +0800
Message-Id: <20250528055417.2527453-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::28) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|CH3PR11MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f8e628-202b-4878-fe19-08dd9dac1d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Aaw9uBNsnaSjvQ/gOE/6M0ttve6y6g7rrmKQ+VUgP49fOehSpm4chbL/1LHO?=
 =?us-ascii?Q?AGfux0GUOw/W38LoBgxAD4saXj0eaE2FKTVK3/12crylLSzgVCH4vJOAASTi?=
 =?us-ascii?Q?ZXQ9uvM7sDT3g2EgfqamdFPp9GPQcb4E9I4BvF2dRmMliAEW8dROkgnCZvps?=
 =?us-ascii?Q?Hu1Rc8BedNKb4VublnZKBtxgpfpJnnV3nZJ9oYXH9h90SUHcU4/qKbc41dGk?=
 =?us-ascii?Q?xuNjO+/Ioah/0iRlywKfdBW0GbvkW02ZyQ7ec021sye6NbQcDaUPo0ygxXlR?=
 =?us-ascii?Q?7DuOGukwIb1p4hjDVauBA2220MjOnp7Z8mvfscUj31JNBS7Vf9dM0AjnViw6?=
 =?us-ascii?Q?jqmqilmY+IQVekHJfHu5qRRhqzf0dD27oJ6FFYIcU9rGiS8F92Jy9eRFdzBV?=
 =?us-ascii?Q?HykMun3LbRorPu1Bqd8CHFAKacnI8JgnHfKnRwVpsUkE8j5lK+1yyg2sxzAE?=
 =?us-ascii?Q?m9tD2Cf2Ak5yQD2J/L24j4KvnEPUQj50a5BpJAL0bAWu22tVeIpfAkAGQQeR?=
 =?us-ascii?Q?2SsVoJV5thZr7ezptDJH7EuC6EupdHI3TAEF5lZFoJ1k/t3ulmemZJ3+xGRr?=
 =?us-ascii?Q?evARWI7hfd8h4KOb5v03eO+yD3dnnbyz9sOxR3CdN9oPxPWIkv6DKaJvI6ji?=
 =?us-ascii?Q?Halwp9Fy9jfi7mVZgMVHcvaUsPB6Y4hQZwUvOQ9En0PO7HKrJzOe6xhR5kbN?=
 =?us-ascii?Q?4fioRAqVJ+iYwHleuSQHw6R2lG8UAPvhfgPBMR+qo1AERdHkfNKwjoyAK9wT?=
 =?us-ascii?Q?9eoNkx4ThxJVF6GOK51ZnRTQ4ybvvdtF0mA9OHI9ZUqbnGfOi9Tmmp2wQRiv?=
 =?us-ascii?Q?0gR9Izh/NnpDJ42iwgO3b8/3XyP5ZGjD9rDhustIdH2l3o3HYY6XQWrR6LE6?=
 =?us-ascii?Q?4AStY7A5RG7ws2UTU90JS667y10rD052Ros4nUHEsWEYP2YV66PTOiSAmh2M?=
 =?us-ascii?Q?3C5jjTeti4Y697AhzOEBfxiXRpn7xxAKt21a3//YMBsyefj+/tqJ6NtJmWzK?=
 =?us-ascii?Q?IhBcWAR2xSSbAMKhDzlYz47keljgiVbUlse1XU7z96Wk1lsRncbr1E8dcK2/?=
 =?us-ascii?Q?PhLr7aZx//yhGJ5WeSX+bfRON0YJpgeHhOGXP7fptnGe3FxZ2XKxpjGcXGbZ?=
 =?us-ascii?Q?rji9+/EYdGBeQL0UQRHZEboMpgg2OpUcFfyVLDUZ2NVLMdWJuKn2uBcDiRiJ?=
 =?us-ascii?Q?BEJm7Q6qYa7RwEdTTkQW54xFDlaDkLhhZAxzm9XmbaCP1GHuDrWgO6+KyHOq?=
 =?us-ascii?Q?2XPmTBGYrQ4r3IDyHQctuBg8rou9wDLfyXKjBsxD03EWQPvqUyE5vwhBmVdH?=
 =?us-ascii?Q?lScsTgVQUdwckDTSzIXo9lCEPGKCLQYs7so9E07fUxI6oZIAMIybLuhSM49V?=
 =?us-ascii?Q?rKFw7T97x09MbKG7P44ai4jy/T+zAEhVeyzHX1NkxbP1D0u9XS3dmO7I1QZO?=
 =?us-ascii?Q?GIiZiidlcLLPjxe2DHsKjMgGteSQ1/7AZEaQymy7Amgb6cWsZ7sI3g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Lkx/9OlqYIni0flkKy+WfWeLQf8ibThTwc+IsY9MgB01HNajWy3TmatH/eAj?=
 =?us-ascii?Q?aQMGCx6TCg9U7PlnQqynCfL0/HF9qikywl/qvns6I9SuOui5w+XbnI9ltNac?=
 =?us-ascii?Q?nv4HYFzn9FagyiXKhLY/b9mRVljfcuxG9J989QlT1QwBE7OY46KJ5DHvgzW8?=
 =?us-ascii?Q?lcTYTv4DbyhzGodojT9p3JK5l35xcJZBGLRAG18nLXZa43UXuO3oJeuIMitS?=
 =?us-ascii?Q?QvWMRWItKf4/Zy5RIIYWW9DXr5Zbi5hNgctzL2Uanf5OnV4oUjdKRp1hO5iC?=
 =?us-ascii?Q?Ls26uQJHcz+Uy3G208aLIF1JLHkNI/drHx64M0tyrUAgLyAv9TMGOCdwJYRR?=
 =?us-ascii?Q?ZZQnp3tCTOwPH7mWOX3v7lr3HewERBEbvjlGvgzUkb2QimbyCOVCbRrGS0SZ?=
 =?us-ascii?Q?Vtml7TKc2yaBHgyn3slV6VCgmcRhuAL5+wDY1GsBpGrqLyz405T9Q2zB4Xg1?=
 =?us-ascii?Q?23dp8rj3ywDixyNWmOUt4STZou0WO0yFZQ+AcYXFeRabdy58c8UMEQXD0g4i?=
 =?us-ascii?Q?kNSC4US9j8JdyvQVQPCKXHFHvCIniznGa4jY1VZ7dzx1/Pk3RBndAEY31tWa?=
 =?us-ascii?Q?dZCj6PTW3zhU9y5LxZsXpKfHb71n+CmfTw7mg4SGjc2M2zM/9asr2ojMSz8R?=
 =?us-ascii?Q?0pLZLdQ+9MP+dOPtJgBbNcfVkTm3LPflI/qIskmUW2ychwYN6akHz6o6SHpm?=
 =?us-ascii?Q?0CsTvXwqTTaxZjX7VOZFVYEw/8V+/vjqzYYRdFMIW2oFVrCVfoN0N1nrTVs8?=
 =?us-ascii?Q?YZSpCD3qaxhPYDf1T2vSWX1qOOgqvdfINaG3TT4fcAjzl9pYwpI8vDXSo9DK?=
 =?us-ascii?Q?mtN3xqLYK1qpY/yrgrPoNnMMqMw9smC7iw2N0aPuMUyvCvOqEI4z0g9mWZ+7?=
 =?us-ascii?Q?1KcJ8L+kG19x0t32JzmJFi2GSVLJ5uGq8/E+/EeChEo11Nuh0+J8IBPWRXw+?=
 =?us-ascii?Q?pPyP5vf75iUFmPkQ/o92F2pmnrqe+2jx6PkGw6RVqjj2OPlkf5wqV7gX4bAb?=
 =?us-ascii?Q?4WcHJvZsm3i9sjpFvwPgZ9+Bt7XblnjWlOwCjttY9tdqKaicRo6lZFF+ewv0?=
 =?us-ascii?Q?xqtE1wMol4rSVQq452asC83ceMD+VLYRtVu5eNfzGAJkNBjWlWdPeF34nlrG?=
 =?us-ascii?Q?PN3/FaVTvlQj8IR1j2iNI5QF5/7A/6ARThTx7oWETySYk0LxboH0Gms8tPMR?=
 =?us-ascii?Q?+a89rwCMjmsAx9n+V6tdhcWFaPOwel/gB3w9MZfJxbjk/rVLiDWp9IJ0YCgn?=
 =?us-ascii?Q?TM9u5tukeDx+XLP+iCelFM3WJM8qM6BgUpHD94+lf5RBdqHPJtKynLK9ZYbe?=
 =?us-ascii?Q?VeXgUW///rKAZPAXJejX0ybI+HbHnCqmznnzMjAVEnQbxjUbJ0ij4UgJ3Mgh?=
 =?us-ascii?Q?cyT9kIZbYoeJizMK9X/SC8UGcpqgo7L4yg/5BNvq/eIh07epY41oRoBWRPov?=
 =?us-ascii?Q?jWNKm6r+UJ3fvDQd/oapbM5Ap1KsTE6Hsh5Bc1wRvPiHUg8toVFwwIzWnHyO?=
 =?us-ascii?Q?l2C6fEJVJ68OuDhedA21cHhXl5hJXsuwhNdy4Ap6vgVVSTXISeZXZYpExra/?=
 =?us-ascii?Q?TJb3G2MWPAwoiNJURRF9x/EFVoVZRod5c6sfABdc?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f8e628-202b-4878-fe19-08dd9dac1d93
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 05:54:31.5466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p98q5V63xz7mqSIgFhnQE3LY7/YD45hgn2vRFc5ukT9yZQgrqYKbHYG/hHfraOpfohAQlq1eVZP4zgPfvvH73w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8186
X-Proofpoint-ORIG-GUID: 9T1Sww_1eUVi0bNAMOTSi-Wbg-mcvSRa
X-Authority-Analysis: v=2.4 cv=VpYjA/2n c=1 sm=1 tr=0 ts=6836a519 cx=c_pps a=O4E2hSStesN9zpsRCyjChg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=t7CeM3EgAAAA:8 a=9EVpTSRJU6vyofUetV8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 9T1Sww_1eUVi0bNAMOTSi-Wbg-mcvSRa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA1MCBTYWx0ZWRfX9QVBz12HSvpr P9LdtpUgHAQhInnlxXLFyOS4w4IisEDHslsjomwk9qSroGUfsREKrRBGuNQfj3kzKT28v3Jd+Pz bAZDf1HpLWZDLlM1KpfxNhQO5FUcX2XeFQvrQcDV9OcyCzawQBVKoT0XUlt8/icbPHBchTFlVUD
 ZrB3gcFD7aS4EK9H5Ejv43XRKKLWIXsBwLGbd7hs/tWJ7CVhixCfu4F0wabPjHQi3F3gfqT0Xds F3LcSWd6SKnmBOt+mTCH5a8VuDxj6trUXyyCN/087byljyM6W9SUjrGX3cru9yn08gzr97mYwmD nHZuWJUo3u7fTlR70zg9rsjyChQVFzkAkoGI6lKtqLFo0orF5lAdqN1eQOoAtJ/qrzXhf63tkXQ
 86F6RW56U+L5QMC0AT7U7k7U8ARtjzosXbGdL5xsjWRszHqlJ9Eh4ZXzO0BxWQbAx1X9SHOE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_03,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=940 malwarescore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1011
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2505160000
 definitions=main-2505280050
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 May 2025 05:54:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1582

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


