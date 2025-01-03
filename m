Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54877E77188
	for <webhook@archiver.kernel.org>; Fri,  3 Jan 2025 09:54:25 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.27368.1735898055409394085
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Jan 2025 01:54:15 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=30983b852f=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5038bQhL006790;
	Fri, 3 Jan 2025 01:54:14 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43tdg7cx1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 01:54:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQM363LfR2bDu35zC3Tke91YslUwdVxVD66GI57l6F/egm0JQQr69faQ74N3Dupzj8dwANF8rStzW0VFtcv3EQQ3+rjMm18RqDv9nxKBlW7X4uP7QTzSj8d4gUlwl+7uW8wWj+DSw+9NbzvoZ9zejN+CLNgO/cLdF2+M4Z3u5XKNT6BiJxGxc/MWw6hBfm0JAGsXrPfj9faGoLknU9aYtSC6CAFKlKPS3OM7A82mgAbfILpYNPcg3Vp3110oNe+bDmWlH69OGFjVUw8BE1gQhQa6Vsx0w4L5Aons3R+c4xrbJ54HE2ISkJKi8BAY+rv5N3EuZjK2WXkbEBWWDZ7aPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Rgvdsq2YOAmi2yPx+xoZDqIVGTY6KdXHHuAjtxPhSY=;
 b=j9gIvbznl/OciYLeXB5/gaSkUH2HnRgHVoMVwHiPeT9BppkCmYjajQAfI9uVrRVbc0rEZp/tW7G7qqmYvtDpYJABeupaRV9m1g8tXLwSza0vPbhV3SAaMtKw0Hn1f1owcwjWYLOEk0iSD7KZJ4aDs/zhAKCImxD1LPI1XWDyY4utq7TsBD0aGUQXxTshrpwK+xFaug/iXmbSJ6g1eiSWfto4hzyT+CnHCX666qWwJfbxZkcrykcWhgJlKO3WE/odlEC7NT7BQXDxzMoBohcqwL42wRw9WcpTim0l9AhoPezMFAs0dT/Du4r1w6XRNjI9EojAg4SuYCM+g+5b8ZZq4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SA1PR11MB6918.namprd11.prod.outlook.com (2603:10b6:806:2bf::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.12; Fri, 3 Jan 2025 09:54:07 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%7]) with mapi id 15.20.8314.011; Fri, 3 Jan 2025
 09:54:07 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, joe@deserted.net,
        joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH] setools: inherit cython class
Date: Fri,  3 Jan 2025 17:53:49 +0800
Message-Id: <20250103095349.593992-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:404:56::23) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SA1PR11MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: cd59ec26-bbab-447c-aecf-08dd2bdc9043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Wvvn8TXKvEZfI537d3plzp2YJwT1+2s1Be5nke1BVAxhDr6ugWBeoEws5XKb?=
 =?us-ascii?Q?sma1CJseJU/jkzyQViI1Z/MuUGdA/QWU6yY5RwPQbHIo9nuDKQ3Qsp+eUriZ?=
 =?us-ascii?Q?OopQBQYPEi5ZT6RYLWqu4hbBzoFKR6Bnu+kT4Pft+A7sOP+pBMdfWZmowhw3?=
 =?us-ascii?Q?UocXIqaTXs7sf6yX4WBhxPlBTmEZVCnRsohyEpsoSbUuz6U2XhAgA4rCx5QB?=
 =?us-ascii?Q?cyWKojnBCYZHq+Ebj3DatyJahYqh8BwI538V9/GA/TmAeCM7bhZLZO2TBK04?=
 =?us-ascii?Q?FuSAutCuDIRhEJ0uZfHRrG3JdqOv8DmXu4Y09SpGCFjfs5ERQ1DsKMzZeqgA?=
 =?us-ascii?Q?WTxA6H8obs5HJbaD4xVs0oM6EcvBp+GztDUrMWgNTL+ZeE7houCToNoAHHDq?=
 =?us-ascii?Q?MSWfsnVN8E7KP12xtu6yobWsBTItjDDNqjxXDIKj4XQ1Bm8K3/x63L3H+apc?=
 =?us-ascii?Q?cKe64ZBLCrfLXuHm57IbGXe9d8YohgOc9NLDt6gWnKEDWf+lXloOtrSWSo89?=
 =?us-ascii?Q?O6xJQAKpVhceTVhEsTamnIMg6vg0TyYH8ZZ0E55J4TBTVl/iMektA7/BjFoV?=
 =?us-ascii?Q?UBxBkBvkh64YB755KK+Hkay/HSNRQRHUx2iw79Rfk+1xaUnjOq0Z3ErL4Qum?=
 =?us-ascii?Q?rkd/hKqr705kX1FWx7it4wHFEFonTjnnTbqwiLaz2C0b8coxxPK22aZ1x7Ui?=
 =?us-ascii?Q?vQ6ArrsHE5V/3pN1l2azQHlT/iEnKhI1h023e8fcTBuB3x0eJ0t3OmHQuLhB?=
 =?us-ascii?Q?kUsgP0iwMzDl6r1638xAtb+0uZhgijsran7/UzFrPZNqLl1RHX21nc0gK7Ik?=
 =?us-ascii?Q?MkF+RtWRTptkPIOphurr62GOseCEOkn2/VBYzrDA2ryj9GTif1Di7bwRh1Dl?=
 =?us-ascii?Q?CFtXHeqI1zed6KfHEkezjNL9h0q4OB40f1mKpK94/GUSy95SSTNjFjDB83wt?=
 =?us-ascii?Q?p+OjRqpkJTE1kkXnfAAhC3UKBRav6MTuTnNqJMQyZR1BzRO7C4Ri+zY1/GWk?=
 =?us-ascii?Q?a2Q8ovjGRSuL2YpQpxhomFyO8NKRkckcAc6Y/5T25XXzlK1QhqSpl5PLTZTs?=
 =?us-ascii?Q?8Ag0HwRsELBhwSnokeHVjtOTVvzlXQNTYBq+bYWQkMGuIwB6JIBB/cQ6cVN9?=
 =?us-ascii?Q?rlSGcNNZhnNiVHrj3nuCVILNb5DBeQiKjUMJeb8zJ9OsEPmKk2A4If+bdY9U?=
 =?us-ascii?Q?yfDwmPJZ7Dk9Gdx0C3d/24xlNGn4DDAho+FE3HMasuARp6dsR2oRd7MBV76Y?=
 =?us-ascii?Q?M/VzVEKIZW+DGwcSWKvn5nIubKyZ3yOiH4+WviGL3CB8jcY7oRSSq+51wRBn?=
 =?us-ascii?Q?FKSCdNio7Y5tG6hwXhSRR1ZaAdIqvr6UK1oNvgI9XrhrdPezysJeP6BAW9nv?=
 =?us-ascii?Q?VX541LBWxFGGpT46xj1dv9KREM5clBV4PRm9MjHNo0Fvaz3QiCU+0iZqbyL/?=
 =?us-ascii?Q?uFw7YWPaWOddHB1n6mtzQYUpknhhScbx?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pazFLxZgBW9tG2/UaqrVBC4olB51IMfkN8kyJqBGmAElb6PPBQ09bVdCnO51?=
 =?us-ascii?Q?tkONA9l79WIXHH38TuFzkkk9MM5cCFNuX31x7izw73Ck5WY0gvCZ/fz+5EqJ?=
 =?us-ascii?Q?434TzQy/txFRXP6SZ59/ww+vKhrA5N0BYEqaGHZ/Clx7baHeJZeEp7S86N/r?=
 =?us-ascii?Q?cvR+pQxI0D4ekT78KLhmOT+aVf0tGhqaPk24WWX48rJZSSvt1xPQ6UK5q9mg?=
 =?us-ascii?Q?0k7K1w+WhW+pkTBjXm75wFQKQ3w5CNgD8EnAL5ysD6VXdOAb+q0vb7zdFQ0r?=
 =?us-ascii?Q?W5bS77XRXlUDGqbkut1WEfNle+Om55xb/QoB+Wi2M9DX/LjU2nD2tZHPG3UA?=
 =?us-ascii?Q?L7bfZev2BCX3Sezd84HbDfqkg76pQiHtinHWoPTfYdvsvHk7+fdUDWneHlhr?=
 =?us-ascii?Q?PCtm/9gC8csKopkyR2mmqw9z0pl2qGxBePvMSiosE75614tKNp9DT6daYIeg?=
 =?us-ascii?Q?37/F+s5i5aQu6TDt8AtvEc5d3uRwwOWRzyDFENuxyoB2ludedh3tgbJIbGV1?=
 =?us-ascii?Q?0+eZyY0SVnwKvelZDQ7GzVZumVwfRAnAnLQ6+iXlVFgmIP+vSbu98babUGUO?=
 =?us-ascii?Q?s4Z7596k1NjIq8/dt5aJfvm90yGTH9/B8PH4W6le23fGQx32/qIrPRTnRrDe?=
 =?us-ascii?Q?Q/JrA/XGjVcVEyqrDGJfVLnDc2rb+eca9Tq4aHmVkWGAeNSQLuYVIwuYDEaN?=
 =?us-ascii?Q?KEdp/Pqbpe6yJI5WwXERMqvsPShk1Zn1ZlIHUAmh7e9N2dAaGBdh624nGFI0?=
 =?us-ascii?Q?7ECtpiu1w1yG9rFOVdv+s589N3w/DoNSgEmhRIzt/AvAoWBiYQCDIwUnAtdP?=
 =?us-ascii?Q?AtJcOQhPQ7Jy0iQGSISXFgPQVE+53rdK4vFsvEpJS1f3nYvbVoUcpDReNl86?=
 =?us-ascii?Q?/Iyznab1LraEiHg+aH83xVzTGfEzTD8nYyUC7KogAEARQxtF+tnHbjYyBIqo?=
 =?us-ascii?Q?Nu6ZLM689WGcOnBCHvompB5ywjqzyeICBpaeg3/bILs+cwHatGjcpbOXofLp?=
 =?us-ascii?Q?t4lkAXfDMHFMhTWG4yiNFud3AsoDPn8OvhgPc3hdW4htv+umURCsLZXBWhLl?=
 =?us-ascii?Q?QyTnhUD1pnTxP74d4uknyjP/X+5iubgn15GCs7MlPOW/AOKiHWn7up7vXJm5?=
 =?us-ascii?Q?TgJsc0s7RbG+lztJvNHsIZsNkQrX4Jk8Ju/LZVzBnxFicdH3ym1U/COUi2OQ?=
 =?us-ascii?Q?tCaPwASsWICkkkp6yFFm4fABe4a4RKlv3YIMF+csGI6t+pY9stSGgiA/BJEP?=
 =?us-ascii?Q?e+8EhSOgTVZGglryGFOT1ZVEYse4GxRHPQvLcdSCxNO8pus1B8Ck52SUrl6z?=
 =?us-ascii?Q?lHjSii8C/61njFjLIuTpeX9m5fhB+iDCmm8p4GnCAsLdoibZCwYkoSWhEI/E?=
 =?us-ascii?Q?kuxWvq0+ImkLDNQAMu5e5e1EO/7gra40IBzSpaC+mB9a4cuCt0HywGcp8lMF?=
 =?us-ascii?Q?42FXw5+40BcPHueqlv+VYjwlCmfuJYtikKHNvIQhCHQFyrUe34zJwY5HgAXR?=
 =?us-ascii?Q?CBAQH412M8O3xVzLfV2xYlD9HHkuL+XFK7hAWBSraS81BkkdTYaR6nVVafx6?=
 =?us-ascii?Q?wJ8/i6ArL6pub1Yl5CWNb/tVocq+5N1xXiM4L3KC?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd59ec26-bbab-447c-aecf-08dd2bdc9043
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 09:54:07.2218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOB6yah6v77ROglmOvlJI9LFgC+vtwbiDdd4HvfkNlxWgCbyT9Rt3Ytrc010kwT8XIAQ3iqnr9NYFXzF5XpEjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6918
X-Proofpoint-ORIG-GUID: TCuG4Nc0AGImMOozTXGzlwEzbUxyiBUR
X-Authority-Analysis: v=2.4 cv=AokU3P9P c=1 sm=1 tr=0 ts=6777b3c5 cx=c_pps a=sGbpJkUcFVeWJOR+0qTsNQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10 a=bRTqI5nwn0kA:10 a=t7CeM3EgAAAA:8
 a=hTR_DVrNJsjELbYIYI4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: TCuG4Nc0AGImMOozTXGzlwEzbUxyiBUR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=666 suspectscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2411120000 definitions=main-2501030086
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jan 2025 09:54:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/964

Use the new cython class to avoid duplicated fixup code to remove build
paths.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-security/setools/setools_4.5.1.bb | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/recipes-security/setools/setools_4.5.1.bb b/recipes-security/setools/setools_4.5.1.bb
index 9b6745e..723eeb0 100644
--- a/recipes-security/setools/setools_4.5.1.bb
+++ b/recipes-security/setools/setools_4.5.1.bb
@@ -16,17 +16,13 @@ LIC_FILES_CHKSUM = "file://${S}/COPYING;md5=69a7b68f0a4a570d7c0c43465333ecbc \
 
 S = "${WORKDIR}/git"
 
-DEPENDS = "python3-cython-native libsepol libselinux"
+DEPENDS = "libsepol libselinux"
 
 RDEPENDS:${PN} = "python3-networkx python3-logging libselinux-python"
 
 RPROVIDES:${PN} = "${PN}-console"
 
-inherit python_setuptools_build_meta
-
-do_install:prepend() {
-    sed -i -e 's:${RECIPE_SYSROOT}::g' ${S}/setools/policyrep.c
-}
+inherit python_setuptools_build_meta cython
 
 do_install:append() {
     # Need PyQt6 support, disable gui tools
-- 
2.25.1


