Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879C3C36010
	for <webhook@archiver.kernel.org>; Thu, 27 Mar 2025 13:23:59 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.49724.1743081831548500915
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Mar 2025 06:23:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=5181a5ef2b=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RBcHI5031145
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Mar 2025 13:23:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hm68nxb2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Mar 2025 13:23:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDsT5B/Htx4YD2ha6AkQcOJyV8vnzNOos1Z6cJUgycVzopr7KuOwYHEKSzR1mBetZjW+kwSDU+JB6xr8X4HhhjE4oDf/XNd44a8m4dXD54MeMP42owhlkQEzet5qsjJuT5wXhyDjIIW0t07faPNg5Vvdll1tWmWUi641rJ72DPMlYi/fQogLmhsRdMdLyXKQ7Mc6d56pUf7sfZ6g9B9WmesXrnk5qGhBDJxfPryvLOw7VJuy6M82cSFXfiWyyNwz2XhY3MFlk575Yx3fZ7uQANdDiPoPkohRGkNOlZc6rV9YL1NEWMReQKibB8hTxN/2lnlpEzVdqpBwLsICDq+mcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZ4sFJsC0lqqfH4btLZ5O1AuRQb+cHct5JVeXp/EaFg=;
 b=PfBAW3u8J+q7ujw8c7jXYKIrDy7xl5XLLRSFAjViwKy2Hzs5HsB8eSSquRwUKUPGDMjIlCfIn//xGaBE/eBkFfFdFj85WZ6YzpRoNYxjpzE5jyVhatKXRP3NrfMGbXo7yW1Zp84T/3Hw6nt05lwbivRsz0eEnPpwfJUMBh5vfq0mkxX0lQRrW3rDkl0KLAcXFCBtLjCoCWlP+fLSuNr/M8YpkgTGEGdfnZ6k5grCDxutdjWXqz45+OmfL8lwjkMP6cCavFoCyJV9jhHZIQcVQTly+MisVu31miR0ZYvX6IdhAyL3lD8PkXOt9MleXJoCBypT9PhOQV48uK3VKmkmbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 MW4PR11MB5773.namprd11.prod.outlook.com (2603:10b6:303:180::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 13:23:49 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 13:23:48 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 5/5] sssd: enable unprivileged service user feature
Date: Thu, 27 Mar 2025 21:23:27 +0800
Message-Id: <20250327132327.3477926-5-yi.zhao@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: f6287994-bb50-4ebc-e09a-08dd6d329bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4Scqgr3v4AHDJFFQuQwGxoj//1U46vCPJLGufGjT24f6p/PNeCoE/DqjP59A?=
 =?us-ascii?Q?C/psC2bG62oYD2hKNihd0/XHFNnVsSPgGwfrqETe5VywJhSwSygoAmfTchCY?=
 =?us-ascii?Q?SNfvzgdqLJBXEOLuN5hWw5cDy8huEQFfAKHVFwapzL2RMXAA/dG4Zo4VYSB2?=
 =?us-ascii?Q?wIC+ukBtaN3Frk1Av4nEBwYBm4S12iC1201NroVfHjYP81f9dJmN1OMDU3m8?=
 =?us-ascii?Q?t2IAhbZBeo/wXhkYQ4aXfJZviGU2/SD2LOVX9MzhDBVRYqTfWj+TWNm/UDqM?=
 =?us-ascii?Q?v4b0gIOKdBMhBvvH24jiyPtoSXXeufpxCT5fuCpJgYVtdhukh0qvriVdTAQy?=
 =?us-ascii?Q?mIMqVd97YF1suFZ8gN5ab8yF55vg1AECOPtkeEqj18UXTHW7ztLK9CuOdgnj?=
 =?us-ascii?Q?dVv9m4AXmKDxaUqKAcLCXmvTG0GZHN7MlFKFH+vT7EECo73/3vnc9SorGbtw?=
 =?us-ascii?Q?ySOdp8Q44qn0Aai6YMpfTlk47xGe6gT0HG63/fx7E1xdGQEgEADu2S3l28Cz?=
 =?us-ascii?Q?oOQhcfbCXTy6TI5nioH3KtNPSbahj2MJrX+pdJiMpwhzaXRsm2D4Lyb24jay?=
 =?us-ascii?Q?y1hK87xkWsxnDCtc2lvjPCEnnx2HabIMnoKerkNugtI8JvK7AzgSNYLbx0VC?=
 =?us-ascii?Q?mOBmpBpGnxq7MhdKw9ErOWLeNpWoKrfKtWxYpMtMVK4qhDWlWCtLwH2AMFZK?=
 =?us-ascii?Q?sC+wLiGHRijX9JdERlnTOjJApOsCe77qy0fcS+9POxMKzK+G2PJhKHMc1S/T?=
 =?us-ascii?Q?umB4XbUd/JwS352g+GlWxSirb6klStJ47zM5NgqHPOiuQDe7r6OEs5YGv7jK?=
 =?us-ascii?Q?/zvzloS6L+fsM5jgviPRIInJ9kATQeWX5/AVp4ZjTBaE0k7TQmUHSz50bOru?=
 =?us-ascii?Q?kMlfA6kxHEPyeU9HyVUxIOhwhfiMZ11/EfldtSb5v1dleCXTExgJ4fzGJpwF?=
 =?us-ascii?Q?n1cVowTct/+KL6RVw5XvSd6t3OQSA3W4mi0nnWI87FbRZ1gUimR4cRDUSNpJ?=
 =?us-ascii?Q?d48t1Ef6SBs/rRVqvkYAwvhf8+IzVRVgURLRWgPy9Rrt2EoJKmVwMR8x8mK8?=
 =?us-ascii?Q?hHgIC/gH0c9KrJ8nUgqawjVsb1IwbaieqrKKnE+9WLoXQSsc8bt3B0uSb+vY?=
 =?us-ascii?Q?faywDXrijuTEg3/k6pVBfZc6Whz39aAQXOdskhi1eFG1s8xKaEmU+AteBLOT?=
 =?us-ascii?Q?i7YEn7lqYoEueisSDlKm5u7+FUw7crTBspLpurYVsawuPO82tZQ4c+rjKmzr?=
 =?us-ascii?Q?klFB7Kzb4+OsTuYchKQ0irKKXSISy1khPkttQimgRT8Sa7J7HgwdEDSIFvyl?=
 =?us-ascii?Q?i2MPYrfUt3xyOxwUjA4yPA/+ktXwiHuVkNz6d8OFmTGrsMF1aVZMqOT7R3Be?=
 =?us-ascii?Q?E5FENKDAY8SAFQ9lDitpR8vTqQoCjskaKNRfkNvPXZ+qpNx9ycNgGFfoel26?=
 =?us-ascii?Q?CJ0cmxrn/8LxPlbsKii7Bj9g29ei7GQa?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?f0YeO5mm/Wllv8aT3FqrAauvNywo3xcV1u1C3ZUG3X137g7/w+G3QyrtEYfh?=
 =?us-ascii?Q?3z8X9TYrpHzRRw4fs+Gfx0unU3wUE06ongx+qJDkCQM7RGGXFM0ApMRfZxzA?=
 =?us-ascii?Q?gQmTD8pSC3/3XJqPAoRJqq/lkcnRMGRJGb6d3z19vXn6Lbf5KmUHO6vlDh2x?=
 =?us-ascii?Q?5jJi/rscmORMNeypdiYWMgeUSktGqy2hWS7E1u7t8zNbxgA7ITK9zO6WQj/P?=
 =?us-ascii?Q?FN5Sd1qJdKRXRUuECtSLdVz4E6jjTflmlXb1iLcJA36BEiQYiHCmC7BePvPi?=
 =?us-ascii?Q?jI9fgAzpCF5d525d+ham8vqURxKwG62rYF8ZxntZw88nsRWrAEfcoc6Knie7?=
 =?us-ascii?Q?nBpRqYMS5tD8HsuvzVvqNo5Zp2wn10mEYgdYPMj2MZ7BzzPr/6jKrgHZTHRp?=
 =?us-ascii?Q?0d5F2aBTVzpFNSUPrOe1fYE3VkDkaFSV4Vy6og7KhrdXhieNdxkOfgRkemea?=
 =?us-ascii?Q?Ee2VDzFB8zBmVLK9xMZyVrE/8bDzO6j/uD0em3MJv6gr9ZsCyvR9S9Y8hDlH?=
 =?us-ascii?Q?OiwCPByEzro7l5nStqC/tWmROS/+zU8nYI8RCSHcbZczoJKQX+Jp25CHZNDk?=
 =?us-ascii?Q?QEwahXFvEOtD+2UKyNaMOtK11InksnYzZrDZNAFqarf3pOzMLYjWBHqsHmis?=
 =?us-ascii?Q?ApvExw30anN1xDBFyXCo/0GnegoNjUDcK/sZ53x+gMIdTbzSP4YFNrBa7Qyi?=
 =?us-ascii?Q?NP0wWntSWp9I5i9t4i5JsgYJ1pZqwS83gLeCm/gMUPs1eSrhIfcMV+1t3aZK?=
 =?us-ascii?Q?JNYnKnH4eul7Brk+F/1Tfap8c0lkE+LWS0zEvVDuubxuHrHLWnYEbz0fK1Um?=
 =?us-ascii?Q?EGY/Y9pKMW8MFjovDi8DPE8NdnU3NTssoxQ8yhVo3veN9+9yu0F67Fs15RcP?=
 =?us-ascii?Q?czZk6nHqf5XXLGtVCQCjY3hmzlfylL1TN8la+w1bIed4MFGa3MZ1qVatzvmn?=
 =?us-ascii?Q?/IFAI90jtpeCoq1UAwhL8Lukhp3lFLuUaLvGP50zoNVoeGp4Bpo6HxxAxfkw?=
 =?us-ascii?Q?wPgUi0EXwGnGUXP7VjcWfm++k4RrWquEk5TcxUOIKRfBzqP/lMX/5fUfynA0?=
 =?us-ascii?Q?WxkxGfLdllfegWG2bxycKN0VdxZrMJwNGsJ+cOnBGJrDojuA4j7DH9c6ByPc?=
 =?us-ascii?Q?+/NdAXKnI7u0shj+HXBcG+AsNG0WF7U+jf8lMro9Mjt9AxdFAGslXz7uxzPq?=
 =?us-ascii?Q?5NWOqpkloGhAfgbUCKoQlclR8inPOdM3mccu6p99eOiogSTTm7rNS3F7DwVJ?=
 =?us-ascii?Q?MTBVANN0pGAekNTBjktSX+/T5tqcdaqAW+5cz6n4AsqEaWpytdxQK8QfW2e0?=
 =?us-ascii?Q?bgji+9njPHAyfwxMDPCZr6hP1G7UcQEBVvteeAxlgoet0IlcsyMdGH65ruta?=
 =?us-ascii?Q?R5lxq0LJQiLjYBlJElCW0nK+/5FUdbVQPDNtkdAYH49uYvVdVDFkunwGpr65?=
 =?us-ascii?Q?J2q1GWNc9FN5816CRuimoBumD6u1m1G6mibawxfd/Kz4JfmJ3+luBbnf3qY5?=
 =?us-ascii?Q?4XDxPj9bwGjR1cykCV5h/nQicrMXT747aJtx6JGhfdqX31zYJTzHgpL6Xp/j?=
 =?us-ascii?Q?fSkEJKb8hhyX58034h0cOalPB0rprhTR0Sswe26z?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6287994-bb50-4ebc-e09a-08dd6d329bdc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 13:23:48.9065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Bs9OJLSJQizdtF8kzZFXAMr4i0vX6aDRJV//9FH9+aYJbRQAU6bdSFM+yn52Fz9vFWo5wBQ+8dku7s/Q+F7DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5773
X-Proofpoint-ORIG-GUID: nma4fSNxOM7nV58uhmuKz9909Il5MoQE
X-Authority-Analysis: v=2.4 cv=etjfzppX c=1 sm=1 tr=0 ts=67e55166 cx=c_pps a=IwUfk5KXFkOzJxXNjnChew==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8 a=YqaM2oRP_DgEIVZAgjEA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: nma4fSNxOM7nV58uhmuKz9909Il5MoQE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503270093
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Mar 2025 13:23:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1270

The unprivileged service user feature has been improved in 2.10 to allow
running the sssd service as an unprivileged user [1]. So enable this
feature, and then we can run the service as the unprivileged user sssd.

[1] https://github.com/SSSD/sssd/releases/tag/2.10.0

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../recipes-security/sssd/sssd_2.10.2.bb           | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.10.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.10.2.bb
index 0ed62b8..b02710e 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.10.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.10.2.bb
@@ -28,12 +28,16 @@ SRC_URI[sha256sum] = "e8aa5e6b48ae465bea7064048715ce7e9c53b50ec6a9c69304f59e0d35
 
 UPSTREAM_CHECK_URI = "https://github.com/SSSD/${BPN}/releases"
 
-inherit autotools pkgconfig gettext python3native features_check systemd
+inherit autotools pkgconfig gettext python3native features_check systemd useradd
 
 REQUIRED_DISTRO_FEATURES = "pam"
 
-SSSD_UID ?= "root"
-SSSD_GID ?= "root"
+SSSD_UID ?= "sssd"
+SSSD_GID ?= "sssd"
+
+USERADD_PACKAGES = "${PN}"
+GROUPADD_PARAM:${PN} = "--system sssd"
+USERADD_PARAM:${PN} = "--system --home /run/sssd --no-create-home -g sssd --shell /sbin/nologin sssd"
 
 CACHED_CONFIGUREVARS = "ac_cv_member_struct_ldap_conncb_lc_arg=no \
     ac_cv_prog_HAVE_PYTHON3=yes \
@@ -66,6 +70,7 @@ EXTRA_OECONF += " \
     --with-xml-catalog-path=${STAGING_ETCDIR_NATIVE}/xml/catalog \
     --with-pid-path=/run/sssd \
     --with-os=fedora \
+    --with-sssd-user=sssd \
 "
 
 do_configure:prepend () {
@@ -87,6 +92,7 @@ do_install () {
 
     install -d ${D}/${sysconfdir}/${BPN}
     install -m 600 ${UNPACKDIR}/${BPN}.conf ${D}/${sysconfdir}/${BPN}
+    chown -R root:${SSSD_GID} ${D}/${sysconfdir}/${BPN}
 
     # /var/log/sssd needs to be created in runtime. Use rmdir to catch if
     # upstream stops creating /var/log/sssd, or adds something else in
@@ -118,7 +124,6 @@ pkg_postinst_ontarget:${PN} () {
     if [ -e /etc/init.d/populate-volatile.sh ] ; then
         ${sysconfdir}/init.d/populate-volatile.sh update
     fi
-    chown ${SSSD_UID}:${SSSD_GID} ${sysconfdir}/${BPN}/${BPN}.conf
 }
 
 CONFFILES:${PN} = "${sysconfdir}/${BPN}/${BPN}.conf"
@@ -146,6 +151,7 @@ FILES:${PN} += "${base_libdir}/security/pam_sss*.so  \
                 ${nonarch_libdir}/tmpfiles.d \
                 ${datadir}/dbus-1/system.d/*.conf \
                 ${datadir}/dbus-1/system-services/*.service \
+                ${datadir}/polkit-1/* \
                 ${libdir}/krb5/* \
                 ${libdir}/ldb/* \
                 ${PYTHON_SITEPACKAGES_DIR}/sssd \
-- 
2.34.1


