Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7210C3600B
	for <webhook@archiver.kernel.org>; Thu, 27 Mar 2025 13:23:49 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.49721.1743081828074291197
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Mar 2025 06:23:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5181a5ef2b=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R8knIu025090
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Mar 2025 06:23:47 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hvqkdn2w-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Mar 2025 06:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGRbvUusPpiz6kmKQnlnMW3axwuHIA8WnFpIve27/OtH+cG9KitUgpzTz3nYo6X+nNPyUivcQz/h5lnkM3rtbf8vAtRSDcM2ceCtRbr11ve6InnO+JmLMt1Kp1yTYqMixuj5Zojw92Hq7y6YrFpEpbjZ6nU0vw2lS9E11bA4UuSy8I26Qyx7cBdVdxvitN7LZSKLSPlahhasrJ6kgDr4G37WOtnuFpRp12yCecHnmTBC07tgbQbXb8XMxulF1EZvx/JeJeYQJqr5z4ZoQruTz7OkUQ9B/G5ty3dziV/D/46SvNjaEl5dnTJ+sBtGTZoVVHLc4dfdcQk7ljQcHGjSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7w3/TzkvaV2pd/wnbLjyOrerxXEf01I8JlEW7xpmSsY=;
 b=sCSb/dNZTsO6tHlReY2aOXuYM9RGx2kJKURUlC7KP0W242lbwVu1RAx/ytbarOX7bSNrKv9FMXmi16Qg4qVD8xgQ8sheUWktmjEExZG7iVsLrk6iLGEsXuEdsGOV7kgS97GZF68H+tDjYp9BetrmdG0Hy5nfHlwmjkCS86FW40P5R//2LIjNHGBtrZ2WxOZEvxtHDi/ugHfwlpjkF6wnGjvMGIjz/PDp4P9XN1JFAuXNkmh5flOhkGa7RgeqZLDMv4HYdeWBF1BCqD9siDt9LEUuZocKjlck/KbrqfGYCFxQTWuvsCi7QHK2XuLzGs2FR2iHwvyCa4FzUF8brluPnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 MW4PR11MB5773.namprd11.prod.outlook.com (2603:10b6:303:180::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 13:23:46 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 13:23:46 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 3/5] libgssglue: add ptest
Date: Thu, 27 Mar 2025 21:23:25 +0800
Message-Id: <20250327132327.3477926-3-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327132327.3477926-1-yi.zhao@windriver.com>
References: <20250327132327.3477926-1-yi.zhao@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|MW4PR11MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: 22704364-7fb6-4300-2704-08dd6d329a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?oDPLsW/SZ2AECND28397A0Lc8CL645lOx9kexhKxBEJkn3huM6TkRUkikxzR?=
 =?us-ascii?Q?GgDy6DMcwdOJKO5renGdGrfNlp3EJpxi3A0iEJweIbqqBZRdjOVlYZ/4ft1A?=
 =?us-ascii?Q?wYCs9W7JmW/LnkdzMt32dAoPF6DANAu4mhlndIZoSCiddTeugpc/aPZtJamc?=
 =?us-ascii?Q?bNR/1TkM9XqGNN2+QRxlL++GnHDuzITAVrkdB/tUY3XCDXSr8XUmsI4e9gIz?=
 =?us-ascii?Q?no75z7r+9i7Fxsjoroko+8cDdXZn5YoZgKW5FPjy42az6OnZcQu2tKfCIujN?=
 =?us-ascii?Q?NLgA0/e+GI+Lon3YWXPW0qVHovtHMjIQS5U2c4983+1wIIwJ+NlD6aQhq/ZI?=
 =?us-ascii?Q?4J6zFMBXCuWowboJjt8c9Ujdle1oo4+0shGb9dgA45BUpjgJyyUdhSFJcXYN?=
 =?us-ascii?Q?8dpdXFAUf8e1kOmfTGa0oLH+s/a8s9k6HWZfc1PeFBDvXHGwW0F6RvV9UQU8?=
 =?us-ascii?Q?OPCXOblcAxeT6nJiyxon3iCCmDZIbwWC5cR6htrREfyTeGiBC49hFOudhLxc?=
 =?us-ascii?Q?VuDzE7xLZvzRQqeyREvuk5Pd3tZ3wUCwchO1jNm8fYA6aeOgj2p+ingN/MW0?=
 =?us-ascii?Q?qJuzo6FA+SpsMc+Liq+FUoittZ6Sr5R8dNWAli1ZdNL6zBzG1WpezLJO4r0R?=
 =?us-ascii?Q?QLMieN5HuBw7o+mWSXqwraYs2Yw6oqfvpJ5gydmxr0URx/jhC6hub8D6p4d5?=
 =?us-ascii?Q?OQYxJD4jINgT/D2p7ilsRNY9RFppjMKogwIuaskjhxCP/tkgE6A7WnjPbHBO?=
 =?us-ascii?Q?5QLvYs8y05lMO2mzinsCxttmkAkXfMkEQs5TN8Y+Jg0IycdA1zhpayPTqwR4?=
 =?us-ascii?Q?88FmFE1kwo51IY8ZM3YcFUksdFgZgmhDUQfoTgDO5Xyll6/p6B3emHEyJOwM?=
 =?us-ascii?Q?0wOZxC8I0y0dx2iwqRGcGC4HpBUsOniOX7ULBNXDdMcYLuaybjUL/YKK0LV5?=
 =?us-ascii?Q?GtlxnDKshXWof4QC2czD7IaQ4J7mm+mT4cK9GLToDMF+IKXvedST3L2Z2d6J?=
 =?us-ascii?Q?T5r3rZfXbewqO7/CtS5zC6i4RpnfuIZpdJ5honIJYqOru7tC/wUE6QHLyigi?=
 =?us-ascii?Q?94+UPX6zwLz+re+Gq1SkRexT4y2lWbT1n+UPiUko2xdgexlvbJ8Tmsl6XAhA?=
 =?us-ascii?Q?4TJph6Fz2LB/8TaL1po6Vp0CgpZLc+Hx5KKUIR9Qlz4GgKZWBJuEvmhFZ9zg?=
 =?us-ascii?Q?kSCSwjpTz5Xw3TrWbG3FRlxc+gyu6a6zKdabQSR4V+Ffe0bnR8xolg6mb4iT?=
 =?us-ascii?Q?QD5muVnjLD3LnK0/BKb9jg7V1ng56RJM++Kjf0drtiMkmkbcsQujFdSLAn0f?=
 =?us-ascii?Q?5r7mW4iF52XfpZe1C226e9E8duN+gbMri25eNAg9Mb76Q7y0p1hHE+PwnUZ/?=
 =?us-ascii?Q?PclJtfgPPr3fXBBTPw4WCtFnwbgwQoVOykXjg7x0N53vD2Mk5jNrzJ749t2Q?=
 =?us-ascii?Q?YwnQkWm++Qj0PwTrKSAaexJva1OCA52U?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?32HtcNl6GCwrR3FbugY//B63xnnCiMqFCYiM5UP7JxR1zqKsQzvZAGb0oO8v?=
 =?us-ascii?Q?vJFgWnYpxglARfySHXAGlwqRQO3HDSGewrE1EOLPp36zwGa9pY7zR1Ba5R+Q?=
 =?us-ascii?Q?AvdQAQKJ9WxE7kABZuZ4gtjBV5EBThuZEoxue+qtghVl99l8skei0woefEGF?=
 =?us-ascii?Q?JiswBY35F67XY7sSJd96CzgrrFZWEL10A1r8zvUxEkWrWF6GYd4VIkWoFow0?=
 =?us-ascii?Q?PmX7eUUIsWI0rfpG4J0m34tHcuL3B5eCsQZ0WOBtfhc4qwc8A54RgbvTovZC?=
 =?us-ascii?Q?uTJQtrCnKqqq4TkE5CcBe3QjxukdX6vlEVIgJS992fl8jDRWjAoebobtq839?=
 =?us-ascii?Q?kF/nDVGJ5hBVy1rCu7ydUBWI5ZJ/QTQEZChiM1FTv9fNXXrbYD8flyOnP5Fg?=
 =?us-ascii?Q?icCNuWOBlNOImYJG5XVuPWjuFuCmMlPe26a4HjqHZvpabASY70OVocFNqx0H?=
 =?us-ascii?Q?XT7iNAyB5PqydKJsW/o5S9B5EMz4+3CdUOqdXxBE7Kxu2zcOsoXXyGvAxS0s?=
 =?us-ascii?Q?jTdSV9vcSiI3gBzebFJgfwWf2b+n1y+p6Yam1BG4EHVgulMKYiiPJniA47ZF?=
 =?us-ascii?Q?sQ8XnQ2cJDiyRMwcwuRGTKrk741zUUq/Bjk7+bGKrC/wdhezqm7zMIEg9z9n?=
 =?us-ascii?Q?4HZPiN6FuAFiz5N5EUpJzIRQssFuh9zGOZ2g4hGeGzmMRfUypWYXz27on4aJ?=
 =?us-ascii?Q?DLBl/GYXjkGb3dS6KtSFRwKDSNqpMjXFZtlIm9DntnQlZqGxeHyA1ceHdoMw?=
 =?us-ascii?Q?AuRVuOAO83KlNC6ytScpPN39K0Vj+XwpB7kFg3jErg8bCKmrdTX05IvabREJ?=
 =?us-ascii?Q?7XrnbACoPSdhKWiOpgcGAiUKs8mWBRO4p5YteW8hNdurHpJIzjPw7FOUGj3e?=
 =?us-ascii?Q?OTYunqCG1WDctTLPuhH0UphHfnW1ZGT7lW9mZz4eTw/hUPG+Hv1XKYscMteT?=
 =?us-ascii?Q?tL5VpwtWnCWlsG2YiWHJJDLueDnT8TvxvfbqCXtdtL/P4jYC1D5S0Z3lTdWK?=
 =?us-ascii?Q?7BTTcwS82KBKnr1MW6at2u2aGTeGSZOYrcVVlpZgijo/xWxqSXvqAaiUZv32?=
 =?us-ascii?Q?mwwPB0lOUjmOgMGjrSpK/w6F5LMSZ8gM1jjCQOIq1dGK1bsv4V1snzNaplX7?=
 =?us-ascii?Q?yeb8BIzi+jOIyt7Wnj7+jtdjB/yOUYjSq7uGP9aJDd1/Dgjhc6mvJLT1EK0q?=
 =?us-ascii?Q?cgmpRWunnXTOfG892PvdX2dNTsQA+1c3/lzrNbCIMp9QYgjDk+2LlrXWuC0x?=
 =?us-ascii?Q?G7yxHKCxRpEtAAuRl+RfO2uit1X6XgnPGeNISy909ORxuCW/pPtND46bELhd?=
 =?us-ascii?Q?fhGSuhLL9kuzFkIWQtLB/nv3dkwR7VUBKlKRc9NOJTdEYFSqYcDkRrwXogXh?=
 =?us-ascii?Q?PIAtjaCSXmZDOgV8jAzOokpErzTXDGtDx6CH1STm3mjcgFdbVTXly45d8QkJ?=
 =?us-ascii?Q?4xtVwUVzdaX5tfICZbEaPZbLxZXBVI/h1tYI2XQLzr7LlXfOkqz6MjlckrCd?=
 =?us-ascii?Q?kvjsGV+yhiq0NAPIyKUgICBWqECGU8Y0hvrWumRAH43mcMlP3wyRS60nWBYM?=
 =?us-ascii?Q?pw/sqg1Ye9UM9h19ypzop+ZkyyquPhpx9Ux7wfgC?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22704364-7fb6-4300-2704-08dd6d329a2a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 13:23:46.0677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEvMR2HU4LGyrX4j8i/axU4IcP61KdVS1sV0YJjOCuToebqVdsPIY4Q8YULTxqvM1h2Qto6dQwoE7JaEYS8uOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5773
X-Authority-Analysis: v=2.4 cv=XNkwSRhE c=1 sm=1 tr=0 ts=67e55163 cx=c_pps a=S2IcI55zTQM2EKrhu3zyRw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=QIhr-27iAAAA:8 a=t7CeM3EgAAAA:8 a=p0WdMEafAAAA:8 a=87fI6rSnTKLdA_fLSToA:9 a=cgaYBWEFosGJW4rWv5Lf:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: mMSIrJTIvi4r5SBlnJi14NWNjBsHTuUw
X-Proofpoint-ORIG-GUID: mMSIrJTIvi4r5SBlnJi14NWNjBsHTuUw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=884 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503270093
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Mar 2025 13:23:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1268

Ptest result:
ptest-runner libgssglue
START: ptest-runner
2025-03-27T13:15
BEGIN: /usr/lib64/libgssglue/ptest
PASS: gss_create_empty_oid_set
PASS: gss_test_oid_set_member
PASS: gss_test_oid_set_member n==0
PASS: gss_add_oid_set_member() OK
PASS: gss_test_oid_set_member() OK
    OID present in set with the OID added to it => 1
PASS: gss_test_oid_set_member() OK
PASS: gss_test_oid_set_member() OK
    Another OID present in set without the OID => 0
PASS: gss_test_oid_set_member() OK
PASS: gss_add_oid_set_member() OK
PASS: gss_test_oid_set_member() OK
    Another OID present in set with it added => 1
PASS: gss_test_oid_set_member() OK
PASS: gss_test_oid_set_member() OK
    First OID present in set => 1
PASS: gss_test_oid_set_member() OK
PASS: gss_release_oid_set() OK
PASS: gss_indicate_mechs() OK
PASS: gss_release_oid_set() OK
PASS: gss_import_name() OK
PASS: gss_display_name() OK
    display_name() => 27: imap@server.example.org@FOO
PASS: gss_release_buffer() OK
PASS: gss_release_name() OK
Basic self tests done with 0 errors
DURATION: 0
END: /usr/lib64/libgssglue/ptest
2025-03-27T13:15
STOP: ptest-runner
TOTAL: 1 FAIL: 0

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-security/libgssglue/files/run-ptest   |  4 ++++
 recipes-security/libgssglue/libgssglue_0.9.bb | 15 +++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 recipes-security/libgssglue/files/run-ptest

diff --git a/recipes-security/libgssglue/files/run-ptest b/recipes-security/libgssglue/files/run-ptest
new file mode 100644
index 0000000..04d492c
--- /dev/null
+++ b/recipes-security/libgssglue/files/run-ptest
@@ -0,0 +1,4 @@
+#! /bin/sh
+
+current_dir=$(dirname $(readlink -f $0))
+$current_dir/generic
diff --git a/recipes-security/libgssglue/libgssglue_0.9.bb b/recipes-security/libgssglue/libgssglue_0.9.bb
index 7e24450..73e6dec 100644
--- a/recipes-security/libgssglue/libgssglue_0.9.bb
+++ b/recipes-security/libgssglue/libgssglue_0.9.bb
@@ -21,12 +21,14 @@ LIC_FILES_CHKSUM = "file://COPYING;md5=56871e72a5c475289c0d5e4ba3f2ee3a \
                     file://src/oid_ops.c;beginline=378;endline=398;md5=72457a5cdc0354cb5c25c8b150326364\
 "
 
-SRC_URI = "git://gitlab.com/gsasl/libgssglue.git;protocol=https;branch=master"
+SRC_URI = "git://gitlab.com/gsasl/libgssglue.git;protocol=https;branch=master \
+           file://run-ptest \
+          "
 SRCREV = "ada76bdaec665f70505f0b3aefe871b873e7c4b6"
 
 S = "${WORKDIR}/git"
 
-inherit autotools-brokensep
+inherit autotools-brokensep ptest
 
 do_configure:prepend() {
     cd ${S}
@@ -46,5 +48,14 @@ do_install:append() {
     sed -i -e "s:/usr/lib/libgssapi_krb5.so:libgssapi_krb5.so.2:" ${D}${sysconfdir}/gssapi_mech.conf
 }
 
+do_compile_ptest() {
+    echo 'buildtest-TESTS: $(check_PROGRAMS)' >> ${S}/tests/Makefile
+    oe_runmake -C ${S}/tests buildtest-TESTS
+}
+
+do_install_ptest() {
+    install -m 755 ${S}/tests/generic ${D}/${PTEST_PATH}
+}
+
 # gssglue can use krb5, spkm3... as gssapi library, configurable
 RRECOMMENDS:${PN} += "krb5"
-- 
2.34.1


