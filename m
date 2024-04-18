Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3ACC4345F
	for <webhook@archiver.kernel.org>; Thu, 18 Apr 2024 13:04:45 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.12205.1713445478627812182
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Apr 2024 06:04:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=OWPTTXzF;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=483838f49d=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43I7xJbH028597
	for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Apr 2024 13:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=2cq8HpT4blHYbK19mS
	jacYDFtxnq0V2En2R33l3il/k=; b=OWPTTXzFiloF4HCJmTBcbUsL1gYnQwVOFb
	ADr5B2C/6IETheewGaoaOtZ2rabingcT1nuj0GHzr3jGRPidreOQOO+D9l4gHQVk
	pr0dhn85yNR3B6yif7nIMOG/BZxaySR0hX6Yak2o2U71fRtQm0EKER4qmq2v8tFJ
	GfBpJnLoRnmNN7Yu1zWo3ISgu+D5mODMmTZWBFQKuedG/Mn4YRgaGdbTPWnBBPD0
	FR/w3W90BQCZxGIxv0VzfIl2YVbZIikDNER1//TCt0BhYixxojRynP0QUnRLhtkG
	CxbiRMeK0UUNLtW4QbgXvQ7SPAIMKULoYcssVc6PAvybyTbDv9uA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xfh16n0dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Apr 2024 13:04:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwsv8fZ8pizWnMARKsXt6/D9DAy+EO6xHip7/NO1Il7Dg5QD+Xq5W694Lz9g+vyYXZvpCQefLoCwsvNIMLhza0G/3LIBGgqwl6xMwsIF7tYQqx0GE28mJbMp5RZxA6Xln9DEk5La50xea9BNWfn9B+eDYheIxmcckPuwb3eIaHVMc3H7y/UTV+B5mZqbtPM96bAqqRVFt6tLEk5qBiLxaOHvt1tq8Hos7TyOIU7MUSsPkap4b1RjsOOiSoJJgu1mF2euokw01BNPkUFUbOvT+YThsd6IE0ZzO4u8pOov1aerErMzxh/wOw3lfoyNi41Hea16xB3Vz3DdMAMkNmR7Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cq8HpT4blHYbK19mSjacYDFtxnq0V2En2R33l3il/k=;
 b=CJAyulhRmqJgs3bGB8X1Ilkc5Dudk5u9Rk0D7mZIqFHRaNJmhS8SrsmBJCAI7mPidPWYewaGWUIDEM1stwUBiYFW7O961+JDGgU5eMrD1U++IUnMi7PBHQCuGqeHRpRrp1iV3DjU1fwQg4NyWvbgf5kKpN8uwvSchyxjZUHLX67GF6mps1Q1zCA4x7nmkAnAgLVmVqS6cMY8xZTZ0l306D80lEBwRf7JBvBCG3+4srX1p1UyytH29DlZtcyJJcga5wa1ZR3OdqNzZHCt2KjxuGrS5wG0jak5mcYRcBwo5b8prWj0Foz9zbA2gSbkoM8MqrDGHTgXUdB3Kezd6OsKBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7484.namprd11.prod.outlook.com (2603:10b6:8:14c::10)
 by IA1PR11MB6073.namprd11.prod.outlook.com (2603:10b6:208:3d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 13:04:36 +0000
Received: from DS0PR11MB7484.namprd11.prod.outlook.com
 ([fe80::97da:833f:8511:a558]) by DS0PR11MB7484.namprd11.prod.outlook.com
 ([fe80::97da:833f:8511:a558%6]) with mapi id 15.20.7519.010; Thu, 18 Apr 2024
 13:04:35 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] ibmtpm2tss: upgrade 1661 -> 2.2.0
Date: Thu, 18 Apr 2024 21:04:26 +0800
Message-ID: <20240418130426.2030252-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::7) To DS0PR11MB7484.namprd11.prod.outlook.com
 (2603:10b6:8:14c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7484:EE_|IA1PR11MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 28fc3978-3dee-4c39-d265-08dc5fa818e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aTjjzSiqU/4sskthCNN/oIscSzeWB0GUJtnvybySJHjAW4YDkg9dIE9IXIMUhNb3yPXw8Op3yd6eP89TjejQfQ1Kov5Rp+kO0S20AxsZohKTiiJNLZIl8DkVPm9/i+E+f9yOfhjQ0JokT2/ZL9tM9MhGNFnRxibjXTo4z7CZeNrNrRyPMBPpkRsAyLMhiTg6GarHVuVqMFCM3XrKjhEP8wRke/edyJ21QVjBWv7ErIUf5Trb+SeqIynxf5vkimd5k2oYKP2m0c0yxu8eY79rHzoLh6uUSxMKasAofgyPIWfAxwAAqpO4XMZCyZNmf8trXboQ549mTAEGLzW/tdLnTzoYZ6Eswy8Ke5kdUGmbBiO9WgSiVfPzIT1uzA57Dc7WesygTvc0so1l8v7m9UgplZobvQYXUZxgO03Sso0ivih8xJsEHTUn5c81Cj9jmdozri11KSpzEpZaXBJGUwabeE3pVcj66PvJZEanlGXVC1S3qznNk/P2MGzdUb0/bnnrlEoFyq4E3+Ht/7k35C8x5HSZ7he13EII3135+Ciz7H2IG+XtI9PiHiYLRWFoUk6RDL1sV3ge5lnqUdO9rudueJ6R6q3eOfsh+M4sbVUj8kl8sSHEmXrdEQeQxxzLRBw399a4TJ2JkIxbUzwdZ17FMqWifr4U0KEJtx6H90SyWME=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZXzZjquTJc9qyytl76S4T/B0glg19ABsKtw27SEZukMGlsr7W4FAxproNWeW?=
 =?us-ascii?Q?yvPbZTV568qzSQUjzXGkKp1GXaqGqtYoZlDG4ILZiFyQMkQutVckCLs7tKvR?=
 =?us-ascii?Q?yW62aN1X9q2RVHCGKpENHx6ckGMCsTc4/LeCzxUM39uixr7oRGDwJSprmOv9?=
 =?us-ascii?Q?6YzJ5mI4nuA2OcgAZEzKFsWwlmfYPVMKv/T3PsqY+03VsjQSVBHtWEtm6Zj5?=
 =?us-ascii?Q?H710C5WKORXrIk3vYif5FZU7G80aU2dAxdNvVE3AQAIhtITcGlZhHq7wC/60?=
 =?us-ascii?Q?7AaE0kxiYdFyIkuKIXEC8/wijlp+dwmLSbOPmwZfAjTrXqWgSPN4I5oVf/NV?=
 =?us-ascii?Q?IQa0YJQ0NrATiGn7nJs5lpYS1WbfmN9fbA/RZcUwzlf9gfPB65+hQgL5jVMZ?=
 =?us-ascii?Q?LWrBX4XXQKeH+/NtPBA57IIwSz3jPGvFbrL6CNmhqTZ3lxPtMUJLWoy84Qrg?=
 =?us-ascii?Q?2qx/meXpGMjKtCwlQv3jPVI5Yh23XBC5yKp04MuzrMN1iw6JIT1RDbdL60kf?=
 =?us-ascii?Q?0nRD92jtQR95Mf8H13n+X0JJ8wNY84oK7znsWhx8/fh2GA9NXZOiu253aSHv?=
 =?us-ascii?Q?HXUwWNRva1yEj+n1s7s/+dtUL43zOr6+QMFtHoaJsNQJJFfH25A9Kf8RyBdB?=
 =?us-ascii?Q?93jz6qSTn7xm6yQltDTsUy/dYr3B5Ut9cHT4U2myxOdeMDZ4LBvyxmwYBA7U?=
 =?us-ascii?Q?fD0LQrEUXkoiqtRiX58r0MO7C0ShCWk9SZlnL0rpJnA8TlNggWYBLdDQdEX8?=
 =?us-ascii?Q?nyyduva9nRlsUW13mG1Rfo22NHTVTnkPuHwLbIQk9Z1Dj8+8Kvw030Ln3EL7?=
 =?us-ascii?Q?7bONjBQFVwNWi+hllZ39XjG8oQC0/sFTYSG5X3l7qO+Vt4HwRXCpa81mls8k?=
 =?us-ascii?Q?XryPrD57Go8SVfVAQw0dJk/vBkUOjEOrRyl+0jr33Zj+b2P/k27ABQyY/vCN?=
 =?us-ascii?Q?XHbT5r2Oqq0UTJ4MninLqWXoO2NPGEuFRV35qwqtxeEtp2G3kihUXX7TYCtv?=
 =?us-ascii?Q?RSz/+Iny0uI8FKWPG+ih9YwdalFCpuvRD547jj0Rn+8NtsJEhRBD6u99qsdJ?=
 =?us-ascii?Q?C0bJ7EYdxXhIHs4kYVL2pshhRPW03F4J+Jr+222ZdJnBIsCtBdoJ9e0iidsQ?=
 =?us-ascii?Q?QcoLoEsTvN+zCM2g8JsjTpMPfKV+jrpvnbk1tGu6wi7TqF0XZAoGdAaYAQSK?=
 =?us-ascii?Q?h74rswpaMJb44B5AcW+E+HDjqwQUgvIj58SLHSPQz4A4jtrX2DS708IInho0?=
 =?us-ascii?Q?2WXLdtaxQm4FNHsfuS/8RZj+Aip7f7J2VG7AHKkpsBBfgkpZLHFwzbkIfFmp?=
 =?us-ascii?Q?crs5/hRva0IjhJxSKa4Ip4LZ64gho7ltJT0C60hhgLsPayc9FPJ2ifegwV1m?=
 =?us-ascii?Q?zlakmoVdxzrm2UsG7+GQwoXoFxRc73p6UECLf1IVn7nS5z74yLXD/byJ+pMU?=
 =?us-ascii?Q?3JMnoFUb9I83O/ni/AeMYpiHZJyTC1WhqoCuztPV7HZo8cuq6i7Ya/ASdfkt?=
 =?us-ascii?Q?gyjU9X7wtq/1w1IuSdxXzKFsIIDVFrGikSAV3NNVG8F1BCJgWyejOoOJ4Hkv?=
 =?us-ascii?Q?A9DYUQfbhaSp3joi1WTaum+flpsD92z3sQiHPRJj?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fc3978-3dee-4c39-d265-08dc5fa818e0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 13:04:35.9028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EClRZzLdpqEqu3Ry6I9cyA/IaiSB0F/GFmlCBpJL58Zw6FjSE7Ltppj6etosb725s79JFTr+yZBm+r7VFx44Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6073
X-Proofpoint-ORIG-GUID: MjFxwaiPBjz5-x4b190CC049Do5sQhji
X-Proofpoint-GUID: MjFxwaiPBjz5-x4b190CC049Do5sQhji
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_11,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404180091
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 18 Apr 2024 13:04:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/46
Message-ID: <20240418130426.oUgtKKBScDNRFBbJXw_OEUdXvzL8g8fKzNCY8_S5BNs@z>

* Refresh patch
* Fix UPSTREAM_CHECK_GITTAGREGEX

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...efile.am-expand-wildcards-in-prereqs.patch | 32 +++++++++++--------
 ...ibmtpm2tss_1661.bb => ibmtpm2tss_2.2.0.bb} |  8 ++---
 2 files changed, 21 insertions(+), 19 deletions(-)
 rename meta-tpm/recipes-tpm2/ibmtpm2tss/{ibmtpm2tss_1661.bb => ibmtpm2tss_2.2.0.bb} (84%)

diff --git a/meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss/0001-utils-12-Makefile.am-expand-wildcards-in-prereqs.patch b/meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss/0001-utils-12-Makefile.am-expand-wildcards-in-prereqs.patch
index cfda80f..46af137 100644
--- a/meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss/0001-utils-12-Makefile.am-expand-wildcards-in-prereqs.patch
+++ b/meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss/0001-utils-12-Makefile.am-expand-wildcards-in-prereqs.patch
@@ -1,4 +1,4 @@
-From 26091b7830d84a12308442b238652ee9475d407b Mon Sep 17 00:00:00 2001
+From 68fafb3516b6004d27f882273f934bda3f4714b4 Mon Sep 17 00:00:00 2001
 From: Jens Rehsack <sno@netbsd.org>
 Date: Fri, 11 Sep 2020 07:46:41 +0200
 Subject: [PATCH] utils{,12}/Makefile.am: expand wildcards in prereqs
@@ -15,15 +15,17 @@ Signed-off-by: Jens Rehsack <sno@netbsd.org>
  utils12/Makefile.am |  8 ++++-
  2 files changed, 79 insertions(+), 4 deletions(-)
 
-Index: git/utils/Makefile.am
-===================================================================
---- git.orig/utils/Makefile.am
-+++ git/utils/Makefile.am
-@@ -85,9 +85,78 @@ libibmtssutils_la_LIBADD = libibmtss.la
+diff --git a/utils/Makefile.am b/utils/Makefile.am
+index 7457269..14689c0 100755
+--- a/utils/Makefile.am
++++ b/utils/Makefile.am
+@@ -93,9 +93,78 @@ libibmtssutils_la_LIBADD = libibmtss.la $(LIBCRYPTO_LIBS) $(EFIBOOT_LIBS)
  
  noinst_HEADERS = CommandAttributes.h imalib.h tssdev.h ntc2lib.h tssntc.h Commands_fp.h objecttemplates.h tssproperties.h cryptoutils.h Platform.h tssauth.h tsssocket.h ekutils.h eventlib.h efilib.h tssccattributes.h
  # install every header in ibmtss
 -nobase_include_HEADERS = ibmtss/*.h
+-
+-notrans_man_MANS = man/man1/*.1
 +nobase_include_HEADERS = ibmtss/ActivateCredential_fp.h ibmtss/ActivateIdentity_fp.h ibmtss/BaseTypes.h \
 +	ibmtss/CertifyCreation_fp.h ibmtss/Certify_fp.h ibmtss/CertifyX509_fp.h ibmtss/ChangeEPS_fp.h \
 +	ibmtss/ChangePPS_fp.h ibmtss/ClearControl_fp.h ibmtss/Clear_fp.h ibmtss/ClockRateAdjust_fp.h \
@@ -63,8 +65,7 @@ Index: git/utils/Makefile.am
 +	ibmtss/tssmarshal.h ibmtss/tssprintcmd.h ibmtss/tssprint.h ibmtss/tssresponsecode.h ibmtss/tsstransmit.h \
 +	ibmtss/tssutils.h ibmtss/Unmarshal12_fp.h ibmtss/Unmarshal_fp.h ibmtss/Unseal_fp.h ibmtss/VerifySignature_fp.h \
 +	ibmtss/ZGen_2Phase_fp.h
- 
--notrans_man_MANS = man/man1/*.1
++
 +notrans_man_MANS = man/man1/tssactivatecredential.1 man/man1/tsscertify.1 man/man1/tsscertifycreation.1 \
 +	man/man1/tsscertifyx509.1 man/man1/tsschangeeps.1 man/man1/tsschangepps.1 man/man1/tssclear.1 \
 +	man/man1/tssclearcontrol.1 man/man1/tssclockrateadjust.1 man/man1/tssclockset.1 man/man1/tsscommit.1 \
@@ -100,11 +101,11 @@ Index: git/utils/Makefile.am
  
  if CONFIG_TPM20
  noinst_HEADERS += tss20.h tssauth20.h ibmtss/tssprintcmd.h
-Index: git/utils12/Makefile.am
-===================================================================
---- git.orig/utils12/Makefile.am
-+++ git/utils12/Makefile.am
-@@ -9,7 +9,13 @@ libibmtssutils12_la_CFLAGS = -I$(top_src
+diff --git a/utils12/Makefile.am b/utils12/Makefile.am
+index 031d0de..02f4e21 100644
+--- a/utils12/Makefile.am
++++ b/utils12/Makefile.am
+@@ -9,7 +9,13 @@ libibmtssutils12_la_CFLAGS = -I$(top_srcdir)/utils
  # result: [current-age].age.revision
  libibmtssutils12_la_LDFLAGS = -version-info @TSSLIB_VERSION_INFO@ ../utils/libibmtss.la
  
@@ -118,4 +119,7 @@ Index: git/utils12/Makefile.am
 +	man/man1/tss1sign.1 man/man1/tss1startup.1 man/man1/tss1takeownership.1 man/man1/tss1tpminit.1
  noinst_HEADERS = ekutils12.h
  
- bin_PROGRAMS = activateidentity createendorsementkeypair createwrapkey extend flushspecific getcapability loadkey2 makeidentity nvdefinespace nvreadvalueauth nvreadvalue nvwritevalueauth nvwritevalue oiap osap ownerreadinternalpub ownersetdisable pcrread quote2 sign startup takeownership tpminit createekcert makeekblob eventextend imaextend
+ if !CONFIG_TSS_NOPRINT
+-- 
+2.25.1
+
diff --git a/meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss_1661.bb b/meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss_2.2.0.bb
similarity index 84%
rename from meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss_1661.bb
rename to meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss_2.2.0.bb
index 2daca5a..8e941d1 100644
--- a/meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss_1661.bb
+++ b/meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss_2.2.0.bb
@@ -17,14 +17,12 @@ DEPENDS = "openssl ibmswtpm2"
 
 inherit autotools pkgconfig
 
-SRCREV = "c4e131e34ec0ed09411aa3bc76f76129ef881573"
 SRC_URI = "git://git.code.sf.net/p/ibmtpm20tss/tss;protocol=https;branch=master \
            file://0001-utils-12-Makefile.am-expand-wildcards-in-prereqs.patch \
-           "
+          "
+SRCREV = "0b9d77e304f68228b13b20ff0d72b0c16ffd2651"
 
-UPSTREAM_CHECK_COMMITS = "1"
-UPSTREAM_CHECK_URI = "https://git.code.sf.net/p/ibmswtpm2/tpm2"
-UPSTREAM_CHECK_GITTAGREGEX = "rev.*)"
+UPSTREAM_CHECK_GITTAGREGEX = "v(?P<pver>\d+(\.\d+)+)"
 
 EXTRA_OECONF = "--disable-tpm-1.2"
 
-- 
2.25.1


