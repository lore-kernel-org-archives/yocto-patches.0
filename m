Return-Path: <rong.fu.cn@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B8CCD6E64
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 08:21:03 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14969.1780474858042534795
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 03 Jun 2026 01:20:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Zpg7TKA7;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0614637d14=rong.fu.cn@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6537IkDQ3682112;
	Wed, 3 Jun 2026 01:20:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=3PpRjoZ2W
	8EyGavm5bRtCY78zMncl9S29ZqVcDA3E9M=; b=Zpg7TKA7nQOrVUqGaB0/Qcxu/
	s1LP6J1SSydIweS3SY1Z3D105RPYzM4iuSdvV/fN/T6kiLP+xIH6aQI+onfYwx6M
	poH6e61o554KJf1HHasfaj3nBJRSTaUlz4PJ1ZtNEhuAe+6WW7o0xok02Sot49ZW
	G16ypOb9GU34qo66WDT+Pi9xYUwcptKHFbRWDteIgmT0BCAp+okLxEsEtlxOiO46
	FCpnWRu2eeT+JcmtwtBrdqjVhQ6jMZYNGgPUdCySQTzjfc1fiEetwRxj4hwR/VY4
	UoWjyvtGUdGtYC9PI2ViWFBdiZg5QwPTHu+jGc63GVhOEdJovKeTdTh9S0zFg==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4efydee0d5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 01:20:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S38/yDErrUMnHLOAzK45IATLlUPIiIeV82adqI4h3HcB1qopqR7fHonB+tFFt1PhXeKFgsOxKtRaA0PVsxGweyxgCVMahZH2h52fZ6FQhXwzC6tgbBKnrrGm5loeyjv/K8SSzFuLeOuwF5h9+a6oJ2eBXakL3gajZhT8waFLcbcoio66fCySbBBZCvNSx3rRV9+MpyYyGOZwAqYYcufMcUvVchlt1cxslitca1BLeVXnYfdddgner/8Y+ruV0IAhG2hR96r3eQv7Eio1BpLTenlUqLNSeV0jE5Kt56z786UpEVix+6x0HVAuCN5zO18DuFs9/E5jClEQ+imH/XKNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PpRjoZ2W8EyGavm5bRtCY78zMncl9S29ZqVcDA3E9M=;
 b=Vr6Vtk/urfCCvBKcCnKP7RIY3WhZ+PI7H/o/KHu03SjSGBk+k+pfUnh9oruyxXQNvQfQ47fYJWTfr1atLvilg3EDdcjrb2NUDDjLLpIwpBF4Ay/q5NWbNEZ9RXquww+qGi51PL/yUdloFi8962nGZ/HrltiIj6YKZnqMZgkEVSUcZCyzaKVHlv79JSGw49T1acdC0xxNugHkHeAn9pWG+7/j5ZzKYp4CM7MK03wrMm5ZUPB9TP0GVMxitnU0wjMasULAq4csNdJTB6wGkOYWiuL3ZMcjfEanQpkKaJ3gIdtnfrcVHT9RAaL3OhIz51TbjTVCmUYC+U4bLrMy6NZyRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV2PR11MB6069.namprd11.prod.outlook.com (2603:10b6:408:17a::9)
 by CY8PR11MB7748.namprd11.prod.outlook.com (2603:10b6:930:87::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 08:20:55 +0000
Received: from LV2PR11MB6069.namprd11.prod.outlook.com
 ([fe80::d94b:502e:dc16:ad36]) by LV2PR11MB6069.namprd11.prod.outlook.com
 ([fe80::d94b:502e:dc16:ad36%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 08:20:55 +0000
From: rong.fu.cn@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw][wrynose][PATCH] libiconv: Upgrade 1.18 -> 1.19
Date: Wed,  3 Jun 2026 16:20:41 +0800
Message-ID: <20260603082041.2119621-1-rong.fu.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0015.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::17) To DS7PR11MB6061.namprd11.prod.outlook.com
 (2603:10b6:8:74::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB6069:EE_|CY8PR11MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: f234b003-2b3d-484f-9574-08dec14907c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|18002099003|11063799006|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: 
	yGN96OUqN+UchLccYz+P3dzeVjd19G+pNt7ZRzZXKhXAQLTWNjDOEWLsLtznzfoSMMej0JwTbb+HjzNTN58c6ZnPcYbuFcDKP3Q6w3+wdXBg/IjE+pOf1n2dXYBuOa8/U8/+R/fw2/CMt2n1ZyiMfH14xiE6kCbDz++gg/QW6TcYAkCf41foDDqkpz09xXB4Y3FWpFxShKKSqQFzBWzDvvIcC4TOh9WtjBtnsPPwbQ7iC1UdgfZrEeXnx4qH78fBJvOshYr43Be7tIPD9nKH/f6t84Ds1h7b5OfgN9fs9FC4OwcBp8pNmrrgdW5M2n+zUEd9gorNVLhjLfpll8CI/2OELdlxd27iG/WNMvADQLfUgDBmaB25nF7YESBe5lKrZAxeKyGO/B+DqXnfLBbp3r9PnAClIR/zDwzaU1IdhYss0sjvhQQ11w4qwWVFic0mGpigIkJmxA2afp3lnU89vKjXylKgLgESLnWiQAlv6kh9i5YSzItdKcET8oK8/kj3+/nyPWR83MgeuyKT7ge7MGMBlWvPSWi2+xTKhV/nI9o9x5Wnr5OrSICX8yfCTzVb5jz5pYw60YalXZCBLQ9f6zqQu3Mx7pmjiu9BAD4Hx066moqwN5eAApz9S0XcTi+R+vfkby6GvoSNQ/+S0xKYWDC9nqASGEb5iJTvKE7rc5dCp09IRjTmW/bF9W5F0HExVQ7MWImcKBbkpAzzCDD7a8SJg9K8EstuYmWWYZqjLFH3c0g4AIf40/TAT5AJidnC
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6069.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(18002099003)(11063799006)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nbLwhuJfNwsYgWZUlTEL1noAd+4WrYaklYIC8+h5fBb+5LWIfPEBPG6WrIZJ?=
 =?us-ascii?Q?GpKpE9qmnUxPGA2SnnY2CI51+nYrkNlxLXD2P1qdtx9Rsc+NPER0ivWLqt2W?=
 =?us-ascii?Q?s2kq2bWWxqiuOyT+Clhr1fMLGBlwlEyv7NMy3iF0CekodeZaTHk5kJPrFIQc?=
 =?us-ascii?Q?b4C0b4GQM7IkN4jFMmx7qA45f0as/5wCMEmqAkgMVTaS7Hw2Kp+mp3ICcgo8?=
 =?us-ascii?Q?oADN78a5sx4ov1LRnkzfavxs1fygT1V2W8BJVbgWt7p0HVfiVcGORN+8czHS?=
 =?us-ascii?Q?qcX0vsHWTEHek6aZyIGhty5b8Lv8P6pl/VAHrFol2QSYtdLqPEpbKMzBAMFW?=
 =?us-ascii?Q?0JYEe11WG7NapsIQcfcLWejgTaYIYOMoja1OC3y/EM9/CJ9+AOiM4fo1ZeDQ?=
 =?us-ascii?Q?tCi24aVCiiVhapS9j9uUgBTAKVoK0I5E+/gJBDb/zJJMAqr2FsDMXnbSC++x?=
 =?us-ascii?Q?7tnMDC3Zd2XsyzLrDcr7JnWG0c1lUluySV4Zej/WEfI+d5GL0kMRx8pDf8sK?=
 =?us-ascii?Q?1012gTc79sFK7Lirk1s7QEV1/GYXAv4SH/8gRJduXMFze470LYebZfXqHDqc?=
 =?us-ascii?Q?gCdlqYsqi59TIhAFFHtV7jTYi7t+nZsKZddZXJy8op/eqKqRprVxpPyv02k1?=
 =?us-ascii?Q?OSfBk850LDL2+Pdau93T9uE6DxXJ1W1wY6sfsY+ywFucdLx//1z5d3WMh6aO?=
 =?us-ascii?Q?+Qu9n19eEI7B0nCWbuFe/Asm0Jrsaawm/ZD0mJO6vfYqWwgWhcOLglxa5olt?=
 =?us-ascii?Q?1uKSTVsjcm8vmPm2TSDIS12vC+5ew/YQ4gBFin9eVjWeOvH6ru5h4ZK/asiG?=
 =?us-ascii?Q?rle+geHhxsLYLu7n6j+5RktEMpth3VEDYPJ3XaT6hM8YxmrZcclLRRflwf67?=
 =?us-ascii?Q?vxrEf2WlTCQlY3ASKO92JfqSe4ukgZglTyMteck2d5eCwgslptEJbmFOz81n?=
 =?us-ascii?Q?a8sPa/auAexOlnyJlKsjZ/oLLmnWXXa7ni45FtLL1UPSqKDv1GbDDf/wK9Mb?=
 =?us-ascii?Q?A9BjDaawU+8jMFFwVcj5So+Un2+p/gsabEjhZ0h+UekDVyVpkq+EgpVlBTfZ?=
 =?us-ascii?Q?gyEpxW+6iHlR6s81jBjb6O03tk5gXhfiEBftbw6ySDoZwmZi5VkYe/J9kCYe?=
 =?us-ascii?Q?ilzzsBtOm1Eqsjixm9HlqLDJtnVg2qzfE342Fvj1V9tZN4gAqKDJE4j2wmOC?=
 =?us-ascii?Q?5aCH9YY+kGQfwQ+79va3s7h8bUxJAyQdyudb3b6VGKdaA2gRj2/u9oBiPOuu?=
 =?us-ascii?Q?tnjDtYiSH/+cX153fUngsk5ZliNb8whwh0vwA3miCQEFlqdblWUhXwmnu7kq?=
 =?us-ascii?Q?D+p/SlcI2VQ7+0OaIizrQeanup0CWLF+oyW7gLaB4dNH0cbv+IngSUhiXrbp?=
 =?us-ascii?Q?tjnGITLMfmFWiRo/gPdSQsEJFgxXEC3KUOmQCAwi4xYH+i1CS60ZRUzVXtSb?=
 =?us-ascii?Q?ntyIx5v3WTkMCfq5gtVonHABP2Rxalom1cf9o6lb/FmN1HZIPX6V+uv9NL6g?=
 =?us-ascii?Q?niUZ8aJlLu6zTyiweI0lAhtC7FkHSh2p4r1CVgMNeNNcs17oV0rYJw8/ZlyF?=
 =?us-ascii?Q?dOGanGGdttNGFDhpuMTU616h2dL17bFAwwz98ZDE2+7jzPnRyQTrOpxV7n0t?=
 =?us-ascii?Q?huo0dHsxOuan/+u/n1CPiIOU+GfP2m3X5oDEC6NoQoqYlyqwI7EY+s7Esx2t?=
 =?us-ascii?Q?JKx1lY3eZE7GrMW5uMUwdMXrB+LP5pNuo1q4UN3vTObhnFVSavdAMz2sqnqM?=
 =?us-ascii?Q?AFUWLwGQGw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	bSQOZwQhARGKUIUVYzO2TBp+6mnQBUsibB5OSmHwLH+qV/bHUgIpyHndkTfS+ErMGPozSq5YlCPWQMeXCJEDcnTEo/9nULQkup3b3CVt5UU5ErHTuhLY6PMcmrWLkebU7ff/6wEH+S1JVVQOfpTxoj/1Ex6ICDLQsIHNX1mxSvNYogJweq00rf1HttW052Ca6S/fTiUMWkahoTzSVrcRWvXttd3C8tTWDyn4mwbDECVdWWo9cnW6Li2aoP1Wg5neImsRFR7tacNyUVw+L4PMDp2ic4EycB5D5mCVhpAmX39oPPbecxx4llpPFq9gs6ri+/DFFnhbeVME9kJL0eKHuQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f234b003-2b3d-484f-9574-08dec14907c5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6061.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 08:20:55.0722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrXfOStFhi2qRaofulVLyViSs8SoCMThLKUNhe+99toItTvPEG4nvHngynO36Vo+WhPep4T/CGL7kjmd6a/nj4xgHR9o3RNuE+OpwBy93DU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7748
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA3OSBTYWx0ZWRfX21qMMqmee8pb
 Hny0ECcXos+NwlcW4lZV5qrit2qu9o7j1Ag1eWBQQWr4QvCtnf0Z7tE6IeBxao6suwPq/N9fuiR
 NRMnOBFCPGNRs/fpQo5/R44iNT6g383bFf83yxnbu4Y0h/57a9a8xEJtktbigQBrFZXCb0/bAqO
 rTaEyXE60tRB4fXlQiNknMe1bgs3MXUogMKtpguHKFMnWuw+mr40IaEXVQfzDBZRNiR59xn42Hk
 Ju2K4tBvYQ25bfBY0E94tfV4xQ305Ht4KYEBE9pCnAXLJcCOdf2tJ+pYICCSHtZ1b8K+8/5SQ/A
 olU7Bs6OiJRF32DyibFowib93tuPFrrCzYkn96ABeMCmjmGIqYiNASPikW77q/nfE8uDObQ4Y9e
 kb2WFv9uteZE91qUxeeA8lYheT6eEB2ka99H3Hfzo83pK71Y4KTf6C82ngUwwwQrSMw/szJ/OI+
 VXhmBrH7IwfsRw9WgOg==
X-Proofpoint-GUID: 1KvmsAzb6dnbdZrSvXqUeAzUwWh_Cg3_
X-Authority-Analysis: v=2.4 cv=Iq0utr/g c=1 sm=1 tr=0 ts=6a1fe3e8 cx=c_pps
 a=aSTqfDprWv2neSIyXEkWYQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=WhDlaaaWvKwW_EmLukcA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 1KvmsAzb6dnbdZrSvXqUeAzUwWh_Cg3_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030079
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 03 Jun 2026 08:21:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4115

From: Rong Fu <rong.fu.cn@windriver.com>

Key changes in 1.19:
* Fixed a bug in the GB18030 converter.
* Special support for OS/2 encoding aliases.
* Fixed --enable-relocatable on native Windows.

Signed-off-by: Rong Fu <rong.fu.cn@windriver.com>
---
 recipes-support/libiconv/{libiconv_1.18.bb => libiconv_1.19.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-support/libiconv/{libiconv_1.18.bb => libiconv_1.19.bb} (95%)

diff --git a/recipes-support/libiconv/libiconv_1.18.bb b/recipes-support/libiconv/libiconv_1.19.bb
similarity index 95%
rename from recipes-support/libiconv/libiconv_1.18.bb
rename to recipes-support/libiconv/libiconv_1.19.bb
index e4e6a62..0c11518 100644
--- a/recipes-support/libiconv/libiconv_1.18.bb
+++ b/recipes-support/libiconv/libiconv_1.19.bb
@@ -13,7 +13,7 @@ LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504 \
 
 SRC_URI = "${GNU_MIRROR}/${BPN}/${BPN}-${PV}.tar.gz"
 
-SRC_URI[sha256sum] = "3b08f5f4f9b4eb82f151a7040bfd6fe6c6fb922efe4b1659c66ea933276965e8"
+SRC_URI[sha256sum] = "88dd96a8c0464eca144fc791ae60cd31cd8ee78321e67397e25fc095c4a19aa6"
 
 S = "${UNPACKDIR}/libiconv-${PV}"
 
-- 
2.43.0


