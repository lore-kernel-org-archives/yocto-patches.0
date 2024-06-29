Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C3CC30659
	for <webhook@archiver.kernel.org>; Sat, 29 Jun 2024 13:37:00 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.6021.1719668215297982318
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 29 Jun 2024 06:36:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=791001afd4=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45TDP163012571;
	Sat, 29 Jun 2024 13:36:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4029868apk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 13:36:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTWAbKyayk6ceSpvTgR9kfXO9jnM4Nd/yl/fJC9ZU2fqDkVdMWQGlm4Df2pgZnsD7IrDaj8iGPbTdRTYBI7YPvrv69r+kPY6c7ovb/ttnnjBXFg48Ozl/A3A1tz4odRrmdzeKO3IWFGGuiZ+HsvV4wrYTfQoYi4tCWWauwfcHckE45HWnNSiukb544xBdu+AmIkQK6AlhPZ0EDS7fpqMyHw0BFbgaz6QdbVAvRHtcpmjFxeVAOiB5ioUKUx+AV0DzzTWxrLQOXydGYYrZBWChRa9Ww1QBmqxuX5cT1DB+rVoj/PU7fuFMiSWY25YldpaUsUnBatl592wnS7x+Rp9YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7ENA5ieBULbrnT9mWxIK+x2EFSbzYYsUZlMjLZHnrY=;
 b=ayzQVZwK4piUAa7/GJO/FYRK4es0QOUEfKIg9ZX5RmU9TFql6py10R6xolJ6SSC/6kjhQu0OQs5am9Jfywop4V+sJWWzwODG6NgB470b4mp7E6BrPlSWtCJjVEegyyLVDy9mXcRnacsYYprEukEf8PWUdnwLWFdnRb0STIceOfKolzClCFaRLcoSZW0Lh/HpQ5DAMNhtFMVHTUkfICZAq8CgbF6lHbyHTyZONopwAFJde0XOvoaYnJ1zIlUqSGd3VvD63SpY8PSdyuvYN6tJi6ICmJL6fRwGOslcna9o3vCuUl673sKFvTjj1v1E8ErItiDXuI1XJP2MufpEv04/Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 DM4PR11MB7207.namprd11.prod.outlook.com (2603:10b6:8:111::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.26; Sat, 29 Jun 2024 13:36:51 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.7698.033; Sat, 29 Jun 2024
 13:36:51 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, joe@deserted.net
Subject: [meta-selinux][PATCH 1/2] selinux: upgrade 3.6 -> 3.7
Date: Sat, 29 Jun 2024 21:36:39 +0800
Message-Id: <20240629133640.2377943-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|DM4PR11MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d0c7ce-3e5c-4c04-657f-08dc98408886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?cQe+r2qaebHQjmAed4zKLsC2nijQWWj2Bk0/rDQnGJN0AyGYbHo6kx0LkTQ9?=
 =?us-ascii?Q?IfbPZ6zTw8cry38pcda8aaUOB0ry8D79hGS6Rf8kNqioQqhNW46AbpYo+lcd?=
 =?us-ascii?Q?Uqm+WVgD4b086SbgXsIsdJrC/hhrCYlVJnoq34wPeoJvShJbcwvr9W59hEuQ?=
 =?us-ascii?Q?cbSrcOgRGXedl1wdoGKzZpjKhmz5SkbbZZnQx31Ubw7DVfMu1VVufY7ckuA8?=
 =?us-ascii?Q?OWKazxElh/BiuM1wROewvH6lzv5r9kEKuRGYLVmVE5lwNU8AwDXplD8R/OtV?=
 =?us-ascii?Q?cdPeh3fAH5Xep1UWxB5iEpt1fiM852cxGq7LgSPqVGzWiQaPjW38juwA7oLe?=
 =?us-ascii?Q?7bGwZG00fbFXoaKzSGdESf2VNxo1HUqSp8aosXry/BfnsmOA4ZBXTA45oVTX?=
 =?us-ascii?Q?3Yux6EGtnQvNYNtds0Rbv6/G6LwwOWq1sVz2SDSCNDLKMrcSjHZHJ4jqsWl3?=
 =?us-ascii?Q?qjeBaaaGfePXhaP+77ZplkR1ps1MOADyhXUuXO4+dYC66NpvRNEmf2gG9cQg?=
 =?us-ascii?Q?QVgpw1zMYmQxs7ONMfuTyPdjfF4IeNYsEzrBNDjv3HjqA22KoBywXRuJTFOl?=
 =?us-ascii?Q?pLlDMsoj5R9BxQ7yj9hjrc1LKpWtRfLY+qy7fczeWBObS2s0UnCDRZPJTrfE?=
 =?us-ascii?Q?w0N4ohHg7FDPg5Wjk2anqRvOvhmCh2oM9pNFWcghkI8NMXCSdNeDow4AHQqG?=
 =?us-ascii?Q?vXaePB0jlt33uPBF74CQDlZorp5HmSJe6T8ABmEnsaoLgptNCOQocLCuZyC1?=
 =?us-ascii?Q?R8fc/9dm8RurqmmKYqQCrWIHUXeultHYHnYGeaHi08AEttMUYH7PpskdnozW?=
 =?us-ascii?Q?PkLAVhJP3fh0VqZOtsYMo/AbjiwuN2wFqTH0CmLhDy4BnRD6AhN+TYuiHuLv?=
 =?us-ascii?Q?DzTeSLdNzW+Gx+zEq7tzLuYT/o/z6KK/8deeeFvR82nrJytWlHO5aBFO7Jnm?=
 =?us-ascii?Q?RMJ7JwDd650WGxoJA4XMQwYnqaMzob7NlowlrA8BYSO+khbZaIDxkrPUmLET?=
 =?us-ascii?Q?mf4Nzj0GQIx5FhdwMTGF/Xl+npQXjfFqMNRDdD6Zp/+rBamSbk+IJYKvX5Ah?=
 =?us-ascii?Q?FMj/CuypzhoU7971rsIa5ojv3QTRgpxblz4mvArSmrpQ2JX2IrcIM5zlRWuf?=
 =?us-ascii?Q?Nsy42e0np1AyvMM4rGTu0YCMWaKq/gLEI5Dk4lU7B5yG/fBlD19H1Pwlj8MD?=
 =?us-ascii?Q?ygQ6s63a3fJaH2hpxD9+gzsK3+vDwt/iDvrD2Rtz8+kVDD4iv7uemDZnXkmc?=
 =?us-ascii?Q?RYNzkrc1prnSiOt/hSHz2JEVgEGClF14+l/ZgdDOz2qHaIj81CiffmLzvQ1d?=
 =?us-ascii?Q?B/EaYYixx5vIE4dgMPwu/ztUew069br3m6gn1FjRBXBuy5ZKuVsT5dPavaNY?=
 =?us-ascii?Q?TLi1io4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uJ2sgTRwwS8IfsqCpbL+iHcCFmR6genbfxqu6fXPhPQk/C1skAX6BMp+Pujc?=
 =?us-ascii?Q?qYuwEfzly70k4uVhVbdd6OGz8lFYrCXA/lK/fS8nk3DVwqd8GbNPUVY/HR3R?=
 =?us-ascii?Q?MVAl2G7yrZkMqgO0uRbnDE05Aj6QYcQfN/EL2gIZTH0fj9D4jU92nO6EUDq+?=
 =?us-ascii?Q?dJmxXNX3JAqBtKJI9LjYZpNpnElZUmxSntkQ9MJqjYu6Swe4wBHlL0e45ZDl?=
 =?us-ascii?Q?myDJKZaYzVfnyYObZFeo0kM1lgwMkAjnUpx8+lHhsU47UwcItX4tvqyiCmkR?=
 =?us-ascii?Q?Uc1WuoJqQL6QvkVHxdmxP0gb/P1KTtBHD2M+zqSbb27ApDMR8MaExAhkUfs2?=
 =?us-ascii?Q?J/+zsNWIWnV99KZs0FgHZmIeCGfUQ6I/in9jfk89U5ErQ0PJl0WboFRJJ39Y?=
 =?us-ascii?Q?VGM90CuNzhaytnviHMCnH3R7+wUsHoIDnG0BpPKlEvJXN8KcS0Y4bjAsmcrd?=
 =?us-ascii?Q?8Rxi71gG/3Vdq6gFAZvbVFU+t06cRV1xd9QqwkeoHMIeRoQ6eiqlcDla+m5e?=
 =?us-ascii?Q?udEtSd3cLmcvU6/9gcAqWGDgtHnFDk7FWu1pvnKGUB3/IiRt5yJodhqK7kfy?=
 =?us-ascii?Q?85fk2p7s4rIjymtvHPDNJrS5O7vHSjFfwUS6RktW8nXlsEnlAejgD1R2o6BP?=
 =?us-ascii?Q?vUK+3Nizx72AsAu1lQ8QJefBfW9tAJeARlm7g0niNDlnyKZdAHVLsmqLxZ7z?=
 =?us-ascii?Q?22hR8kETR9/IFfdd+ZjapLuYAmVIdZ9QgQgZWutswvQDM/FS9fSICiKa818Z?=
 =?us-ascii?Q?m1MDqmBKaBVf4FOyc1NRO7eU4pq9BdkaYdmEBplq5NkhkQrBjJFZomWMysgY?=
 =?us-ascii?Q?qZy00R2XtEQlPsXgRi+c9eje5yIaFSgZU6WKP3tNg9DKbCBOFlfzqLQ10pQc?=
 =?us-ascii?Q?QF1oUHB+3rPMXQJsUN6qI0W2+dqok2kycDMy037VAemW4C3sE1W43yanvqME?=
 =?us-ascii?Q?lwwrvLlHVIb1XkZkpK+qU8nBoB/7asOwi8KEBMCumGS7B1VH0AcV6Okr+EgB?=
 =?us-ascii?Q?tL64EQi4Mf1vu38iXgRx01Cf2R/rzT0tvqCgh98Y9WviTzJdDeE2H5tFHkRG?=
 =?us-ascii?Q?MYWgN6M+1INFPqTadm8jX2+zaMwkTj//eNDsstzai/h5ZcL54ZPVTtH3njAO?=
 =?us-ascii?Q?JoyXmGM8AqHGQf4ZqSGx8fjvLKrGHti/5kJwTymwypgLlGeMakPYW4mf2R8J?=
 =?us-ascii?Q?zP+bVg8fq2C0M5fjauSNKpUIFEB884ni57RaOJCdaufdimUdtO9XEVZlpvoD?=
 =?us-ascii?Q?qUGo9ijUp5RRdnF/3CDEQR6xYN8cyA+9iHRtD+cmygSnJFVebF+AYhnE3q9o?=
 =?us-ascii?Q?nHSD7MFiHWw09LmBHd2UYSW19HsG0te4fALmAAwb8xbWTsgOzaNjnnCes1kA?=
 =?us-ascii?Q?oK9KDar+zmG9bKI7Sb3BWQo9mzHNusywiQWoo4Ew5O+qy03IR5bCSoS4Oanz?=
 =?us-ascii?Q?k/1qAKSzyUGbzO8pC/gyVXVwYhzFJ4JOZE0t+8UFEnT8n9qf8p2Oyg9lnjik?=
 =?us-ascii?Q?ivXEOU8+u1VfgwK1SDeNGOPFdOQGZrMeaaDy89/z82J7Kvnn+TTcarXi/ur9?=
 =?us-ascii?Q?/nH97APXkxpJZbe1ZeXfTp6AxnKW3LgpC0yCio/u?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d0c7ce-3e5c-4c04-657f-08dc98408886
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 13:36:51.7290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fr/rhfwyYL0JRKqnXJ/wb83exnyvdqHSEfzhBRbDhuJkbg2Ydq69n4EukuLgs4N6HpZbFOnh7oyOp84V64pyUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7207
X-Proofpoint-GUID: 8yQcOmR3dFSgd7YZ7OuFKJUw4u_8FfLB
X-Proofpoint-ORIG-GUID: 8yQcOmR3dFSgd7YZ7OuFKJUw4u_8FfLB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-29_04,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2406140001 definitions=main-2406290095
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 29 Jun 2024 13:37:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/392

ChangeLog:
https://github.com/SELinuxProject/selinux/releases/tag/3.7

* audit2allow -C for CIL output mode
* sepolgen: adjust parse for refpolicy
* semanage: Allow modifying records on "add"
* semanage: Do not sort local fcontext definitions
* Improved man pages
* checkpolicy: support CIDR notation for nodecon statements
* sandbox: Add support for Wayland
* Code improvements and bug fixes

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../selinux/{checkpolicy_3.6.bb => checkpolicy_3.7.bb}          | 0
 .../{libselinux-python_3.6.bb => libselinux-python_3.7.bb}      | 0
 .../selinux/{libselinux_3.6.bb => libselinux_3.7.bb}            | 0
 .../selinux/{libsemanage_3.6.bb => libsemanage_3.7.bb}          | 0
 recipes-security/selinux/{libsepol_3.6.bb => libsepol_3.7.bb}   | 0
 recipes-security/selinux/{mcstrans_3.6.bb => mcstrans_3.7.bb}   | 0
 .../selinux/{policycoreutils_3.6.bb => policycoreutils_3.7.bb}  | 0
 .../selinux/{restorecond_3.6.bb => restorecond_3.7.bb}          | 0
 recipes-security/selinux/{secilc_3.6.bb => secilc_3.7.bb}       | 0
 .../selinux/{selinux-dbus_3.6.bb => selinux-dbus_3.7.bb}        | 0
 .../selinux/{selinux-gui_3.6.bb => selinux-gui_3.7.bb}          | 0
 .../selinux/{selinux-python_3.6.bb => selinux-python_3.7.bb}    | 0
 .../selinux/{selinux-sandbox_3.6.bb => selinux-sandbox_3.7.bb}  | 0
 recipes-security/selinux/selinux_common.inc                     | 2 +-
 .../selinux/{semodule-utils_3.6.bb => semodule-utils_3.7.bb}    | 0
 15 files changed, 1 insertion(+), 1 deletion(-)
 rename recipes-security/selinux/{checkpolicy_3.6.bb => checkpolicy_3.7.bb} (100%)
 rename recipes-security/selinux/{libselinux-python_3.6.bb => libselinux-python_3.7.bb} (100%)
 rename recipes-security/selinux/{libselinux_3.6.bb => libselinux_3.7.bb} (100%)
 rename recipes-security/selinux/{libsemanage_3.6.bb => libsemanage_3.7.bb} (100%)
 rename recipes-security/selinux/{libsepol_3.6.bb => libsepol_3.7.bb} (100%)
 rename recipes-security/selinux/{mcstrans_3.6.bb => mcstrans_3.7.bb} (100%)
 rename recipes-security/selinux/{policycoreutils_3.6.bb => policycoreutils_3.7.bb} (100%)
 rename recipes-security/selinux/{restorecond_3.6.bb => restorecond_3.7.bb} (100%)
 rename recipes-security/selinux/{secilc_3.6.bb => secilc_3.7.bb} (100%)
 rename recipes-security/selinux/{selinux-dbus_3.6.bb => selinux-dbus_3.7.bb} (100%)
 rename recipes-security/selinux/{selinux-gui_3.6.bb => selinux-gui_3.7.bb} (100%)
 rename recipes-security/selinux/{selinux-python_3.6.bb => selinux-python_3.7.bb} (100%)
 rename recipes-security/selinux/{selinux-sandbox_3.6.bb => selinux-sandbox_3.7.bb} (100%)
 rename recipes-security/selinux/{semodule-utils_3.6.bb => semodule-utils_3.7.bb} (100%)

diff --git a/recipes-security/selinux/checkpolicy_3.6.bb b/recipes-security/selinux/checkpolicy_3.7.bb
similarity index 100%
rename from recipes-security/selinux/checkpolicy_3.6.bb
rename to recipes-security/selinux/checkpolicy_3.7.bb
diff --git a/recipes-security/selinux/libselinux-python_3.6.bb b/recipes-security/selinux/libselinux-python_3.7.bb
similarity index 100%
rename from recipes-security/selinux/libselinux-python_3.6.bb
rename to recipes-security/selinux/libselinux-python_3.7.bb
diff --git a/recipes-security/selinux/libselinux_3.6.bb b/recipes-security/selinux/libselinux_3.7.bb
similarity index 100%
rename from recipes-security/selinux/libselinux_3.6.bb
rename to recipes-security/selinux/libselinux_3.7.bb
diff --git a/recipes-security/selinux/libsemanage_3.6.bb b/recipes-security/selinux/libsemanage_3.7.bb
similarity index 100%
rename from recipes-security/selinux/libsemanage_3.6.bb
rename to recipes-security/selinux/libsemanage_3.7.bb
diff --git a/recipes-security/selinux/libsepol_3.6.bb b/recipes-security/selinux/libsepol_3.7.bb
similarity index 100%
rename from recipes-security/selinux/libsepol_3.6.bb
rename to recipes-security/selinux/libsepol_3.7.bb
diff --git a/recipes-security/selinux/mcstrans_3.6.bb b/recipes-security/selinux/mcstrans_3.7.bb
similarity index 100%
rename from recipes-security/selinux/mcstrans_3.6.bb
rename to recipes-security/selinux/mcstrans_3.7.bb
diff --git a/recipes-security/selinux/policycoreutils_3.6.bb b/recipes-security/selinux/policycoreutils_3.7.bb
similarity index 100%
rename from recipes-security/selinux/policycoreutils_3.6.bb
rename to recipes-security/selinux/policycoreutils_3.7.bb
diff --git a/recipes-security/selinux/restorecond_3.6.bb b/recipes-security/selinux/restorecond_3.7.bb
similarity index 100%
rename from recipes-security/selinux/restorecond_3.6.bb
rename to recipes-security/selinux/restorecond_3.7.bb
diff --git a/recipes-security/selinux/secilc_3.6.bb b/recipes-security/selinux/secilc_3.7.bb
similarity index 100%
rename from recipes-security/selinux/secilc_3.6.bb
rename to recipes-security/selinux/secilc_3.7.bb
diff --git a/recipes-security/selinux/selinux-dbus_3.6.bb b/recipes-security/selinux/selinux-dbus_3.7.bb
similarity index 100%
rename from recipes-security/selinux/selinux-dbus_3.6.bb
rename to recipes-security/selinux/selinux-dbus_3.7.bb
diff --git a/recipes-security/selinux/selinux-gui_3.6.bb b/recipes-security/selinux/selinux-gui_3.7.bb
similarity index 100%
rename from recipes-security/selinux/selinux-gui_3.6.bb
rename to recipes-security/selinux/selinux-gui_3.7.bb
diff --git a/recipes-security/selinux/selinux-python_3.6.bb b/recipes-security/selinux/selinux-python_3.7.bb
similarity index 100%
rename from recipes-security/selinux/selinux-python_3.6.bb
rename to recipes-security/selinux/selinux-python_3.7.bb
diff --git a/recipes-security/selinux/selinux-sandbox_3.6.bb b/recipes-security/selinux/selinux-sandbox_3.7.bb
similarity index 100%
rename from recipes-security/selinux/selinux-sandbox_3.6.bb
rename to recipes-security/selinux/selinux-sandbox_3.7.bb
diff --git a/recipes-security/selinux/selinux_common.inc b/recipes-security/selinux/selinux_common.inc
index cecb0b5..8dd6c2e 100644
--- a/recipes-security/selinux/selinux_common.inc
+++ b/recipes-security/selinux/selinux_common.inc
@@ -1,7 +1,7 @@
 HOMEPAGE = "https://github.com/SELinuxProject"
 
 SRC_URI = "git://github.com/SELinuxProject/selinux.git;branch=main;protocol=https"
-SRCREV = "97fa708d867ecb26e8d1c766760947f8e3b9e59a"
+SRCREV = "2eb286bc0841791043567437ba5413f3014fb94e"
 
 UPSTREAM_CHECK_GITTAGREGEX = "(?P<pver>\d+(\.\d+)+)"
 
diff --git a/recipes-security/selinux/semodule-utils_3.6.bb b/recipes-security/selinux/semodule-utils_3.7.bb
similarity index 100%
rename from recipes-security/selinux/semodule-utils_3.6.bb
rename to recipes-security/selinux/semodule-utils_3.7.bb
-- 
2.25.1


