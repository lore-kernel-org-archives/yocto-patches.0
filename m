Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12D5C27C4F
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 12:59:29 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.25908.1719406760527630292
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Jun 2024 05:59:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=6907bc8ff1=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QCRnx9029972
	for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Jun 2024 12:59:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ywnk5uuvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Jun 2024 12:59:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HX2LqSFynSlGe4zbaAzin1Ke3RKLRTjYh+P6ALfekIWXefVdFqB3jqO0h8Bhk335nK7EA7/0PMutrvSgg8FFJJ07ABXLCebolc72q4DEFoHdGUcJFxL/xtPbdr0ySu620WRXW33fc+tBCDNJ/0RefdX/E1igWqOe0Vq5KdXIHYkZ5oroksJ82vcMucONIt0NcoXtI1jKQ8xliHFLrmfpVI1m9GTfyb5cHBeUgRig8741bSQq/QvaTMd4UwRw2nFLubotnoALEkm72lW87GvZKXcfSzMHzVSFQruTqk70l7KJcPyovjZNfJSzfUfIWOBaA/iD1s1dNmWVg8PnyMI/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTbcuu8IRc1E/OtD8MYzy+LqdlxgdaCyD+kINKguc58=;
 b=iWGD2lbl3mIMD7sgw9EAc4Wr7c/M2M/sYW1/KmuK8RHQnCu+1+T/14Hn2+eK6HcQaK9oTy57RavBtiVDw6bPF3oETnCXMl7WBKBhM+uHOZR18j6AiAn42SDBdJe8Pthb+qD4m9BZOEXKkS6wABLFYEBcddlwFx6H3qB6f2wkQHM45aP4YVBC0GiaXJ4jL4p64RxfC4nqX+3Cx7llq8eoOPhJ/ZuDAahUWTNbaJfr0+tQs0S66fyYzj1eiqiO8+9i8fssuvYochm88/xuXa8+DzAwgKU3J878PTXAEbJjn7hHub71Yoo7Cfy6mRx1LVgyfYqOHGUwZib9x4+WxajSoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SN7PR11MB7438.namprd11.prod.outlook.com (2603:10b6:806:32b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 12:59:16 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 12:59:16 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] openscap: fix PACKAGECONFIG[remediate_service]
Date: Wed, 26 Jun 2024 20:59:06 +0800
Message-Id: <20240626125906.2931268-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0019.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::6) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SN7PR11MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 875f6c8f-2b6e-481f-c180-08dc95dfc906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230038|366014|52116012|376012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?CwdSDiNfttdNo/Pv6pEP+yi9Mris9x0WPtepQF3LvpldZ0cxWu02KsovOjit?=
 =?us-ascii?Q?tD4w/qqz7sHJGQGY5sLu6yT8jVWnRpVDI08+Agu3lzLauB6CXRdgCUj/LHl+?=
 =?us-ascii?Q?YPs/DV4+BIm7MUOsiLFmDQqftaLoaHEWBN8zLUkKwgxgFFaJi5yoHOjvcEMi?=
 =?us-ascii?Q?4QKGLwpTgFCoSWRfqdvHpzrUAJax0SXePu8Dm80xhj51NTlYI7TakYaYP9oV?=
 =?us-ascii?Q?eeP7IYSCP03UusjeSCmgzJWkwnrdCPrcvN9alUOulI56Y89+bYjSwaHZN32L?=
 =?us-ascii?Q?p1ZWYb3zKMxQBUEODw1jNdMjJ0+fWpFRKU2FRFy8/7g0dht9SaQnqeCGw88t?=
 =?us-ascii?Q?zi5fkJ1F2iNljvFfOb6vhsU0TSSEDheFEbioIlN2AjMpmK4EotdgXq5XKc1Y?=
 =?us-ascii?Q?ehGSMnRuiZKL1LylemfJrb/G4itnKKaYA+Wl/mkzo29G+8DLSrldGq3cGbM4?=
 =?us-ascii?Q?Q23PUKI8fMK6sLeEbdNOaxiOdQJEdIzNggsFeglrGLHAleTt60LkvP63yF65?=
 =?us-ascii?Q?A8VZTCGiQlHKTNaRQom7cjvDDrSCQfcFoD8ntwii0kLSnCrKiPddQvKYZ4u3?=
 =?us-ascii?Q?elMoMjv0k6HtlpW174euDnn+FZKtGtAqZceyK6W7xMWmndoRYCfwMFL+ErKP?=
 =?us-ascii?Q?cK7aV/Yz7zpEYoYxkqgSpTQ6GqpP4sspSFnTQ82c0J1W8EDbSM2UicCHik98?=
 =?us-ascii?Q?LjYQPFoneXicIhino83YUCCAa44lPy8WNZsKpVRaYYX5mR6O/xKBpGNkUHm7?=
 =?us-ascii?Q?/HnTm93WcBYb48mqp61TmpicrE4gpkOMCT5j7LaQWWx8tqpmDNFc2wWp5Itj?=
 =?us-ascii?Q?QGjAk0xCxbyxcTlW2yUDGHNB7QVGTTwEn/RYQoe3Wca3hBKctH3jq54VQfUz?=
 =?us-ascii?Q?bK1iRYO+ICcMXw2Q2QOR/yv3WQnyJ5PoBD3k+yRwcgXP8B0vFFwLZT9Qj1ME?=
 =?us-ascii?Q?YKDQbZUDRnYZHGCyD03saXKr27mKnsO+dhS/h+yQWeTo3+PZBMVH9vfkgQJh?=
 =?us-ascii?Q?Bo1VS3q9uhCy1HIueXuzhsFaYQyL1/M08erDYEUkIiS69HrNFqBqmT6k9wiU?=
 =?us-ascii?Q?+icBYEqAHJ3U+/gOAv08oRzf9GKELEvyQBZhPY+zXxa35zkrYNPNc3F0wFv1?=
 =?us-ascii?Q?K1gv9fq56MPUJw//sLgVhg2a6xKySZ9/seCVTTjFcthL2ZY3RBQm6qwz8n35?=
 =?us-ascii?Q?CiiQsiMEgAP227mqe2xWoqhXNHz3xisgNLYrj8DBgF3gHeJ8K1/AGXn/V9Mn?=
 =?us-ascii?Q?L35MdUejsbLsvM8bY5hl9UVB4YiE+Ny56kADA9gNhQ1L8KcJQYhgoViKQdiL?=
 =?us-ascii?Q?gKx51WN0SFMdL5NFe1scVja/LTmTHpLu10VZdedlCf/4uVcbkodJvZxXWrmh?=
 =?us-ascii?Q?JLdIGir9hBcuJVyBrBjxRBxGcTggTbdde/PFhC/4FfiKeTVIiQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022)(38350700012);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7BLkjnyYZQT92Y18p2AfGCvZdVbEn/qUVWsQ/SlJiQexf4IZI0Oc4YR28dym?=
 =?us-ascii?Q?Yr009AQzo5oJJTSrMMu3thvFCFiE0wM3wwcXG2Yfr3XReM2S8j3Rb6qk3v63?=
 =?us-ascii?Q?SaBNv+vElRIN2VB1P5ZU8umHJfRypmnd4DkDo7i7iCUxt4eCH/bNpGV30avJ?=
 =?us-ascii?Q?u7S3qQdA2AoMq/LpynY9WF+QOSU7AIz9dXbYq5RMZt7SmJE8GA4cA5vqHedJ?=
 =?us-ascii?Q?/hlRg/SiYRnEjThUpP39sSqTdvPD9k8tqWawtSSdj+imru9E38L36bvb2o+b?=
 =?us-ascii?Q?2R8a/B4C9hhVrf9mTKws0GC/16MScNHBPSMJXGKBsyMFUGplu6gAJE8YJbA3?=
 =?us-ascii?Q?b6izv1FIfamXHxFS4ZYIyM/UsGVlE3+MXg3use5x0ydWIgfW8QOBX8Nof1VX?=
 =?us-ascii?Q?rHfuSv/Hw+Pm9xyi727/EKkTAy63c2s+LOCFFXey2VdolduK0jwplvOHM0/O?=
 =?us-ascii?Q?92BjIYHNfG0IVtIPsPMnqJraxdMikgKgRN3RbWyOvFY9HY+cyntNuNxT6wCl?=
 =?us-ascii?Q?93Q/2Nret3EsJbjEU3ssuRzbowu8tq/DTwacjO01mSsZ9CEdt+eUzW8iKe/W?=
 =?us-ascii?Q?GzXu1I/bqAXF6lJo/T30drD+0vgYcr8zt4LmYf7FUHJRB52u0vhMfJiyUHgW?=
 =?us-ascii?Q?pvdW8cOmMYPZU9mwES+KOIVio+h6UuxokW2UBXONby6awJ5CMhNlwKeAtoPN?=
 =?us-ascii?Q?O1YBf40f0EGmu5jKRK0f3RpDcv4mhr6g5Gz4fK1wL4xefPT0EozcUgxBe+a4?=
 =?us-ascii?Q?nMhoWwHVZurktYTcU9Nn6cnLb/IkKyu4xmSWix/Udo5rn9SgkXKVFCZv9C2/?=
 =?us-ascii?Q?9gF4N3pWyqbMq+YE03X5cjN1LPXlla7bQJhHYbfFc3Hzghj20qm9j7eEqqTU?=
 =?us-ascii?Q?hRT/J4M8ssv7yFaqW7qeiJpIRCpM7duFzUD+SFahljiMScizKZHyi9DUFzn7?=
 =?us-ascii?Q?0NnBVh1e3JGuvMMXFcdJWb94BkJdqAnUBeh7idXO5F5NxQaMMXlRRV4TMba6?=
 =?us-ascii?Q?MyIfYkloDG4/3Q28S0fU+zzDsXtwYHdVUjdwsBaJaHgydk/3W3qhEpDP5N52?=
 =?us-ascii?Q?FYMVohBPamRCmVgBgcteCdBGMa71JeUG6vvNEmq98lIL6R3KkFgm77TwdBHU?=
 =?us-ascii?Q?a0YnM/YEgv2dTMDlVJcHlPusnMenUCTGDl3N1sdtnWg+PvbeS3rL7R/koKo+?=
 =?us-ascii?Q?dWurhbav+kH0wapPd2IE/rDXAPzFvidZzpQ0EM9O7faPR6SMAv4BbME5h14h?=
 =?us-ascii?Q?23rt+lRaD/GhSI0/dp3fDP0YS6qzSifwWc8I9iI7IeoU6WqBMRuRlpu7OllR?=
 =?us-ascii?Q?QzNGAS2v5rgB1lIx7Ex5UE315EFpBTnOOfPbsoetfYrEJ/WbtRVsz6A0DTBn?=
 =?us-ascii?Q?URJaxQLLvKGAq8ZsJWsj1cRkYkbjUiCse0vg2hXOw4uoMiBoX6yNVpFyF9Vl?=
 =?us-ascii?Q?Y0mOFG3rJcO6mQL9rN7QixdiPnNTebBjsQQ/qBnooJlRWvQnSA6amVqVBNRP?=
 =?us-ascii?Q?7nI8xy7zPaekBN2xPBF3xorC8jTIw7OY9+y31uyIUzFr0WEbhcEh2FneYKbm?=
 =?us-ascii?Q?uMWJgDpoR0M7aAhhkIvPdS4yRrQ666WEQDcdhm/K?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 875f6c8f-2b6e-481f-c180-08dc95dfc906
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 12:59:16.4243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yKq2AhQtjQdhF6gDk/eoJ0EPoIMMXtMzaEmsD3G0zlIlHv+9+57ELDobnkp9UH9sI0OaTCRCAeQFN6w5WNRIdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7438
X-Proofpoint-ORIG-GUID: S0BBBcmd8iRLNpqXBRknyKHzq-zf7BA_
X-Proofpoint-GUID: S0BBBcmd8iRLNpqXBRknyKHzq-zf7BA_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2406140001
 definitions=main-2406260097
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Jun 2024 12:59:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/373

* Fix typo: remdediate_service -> remediate_service
* No need to manually install oscap-remediate.service, as it is already
  installed when ENABLE_OSCAP_REMEDIATE_SERVICE=ON is set.
* Add a patch to fix installation directory for systemd service file.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...ix-installation-directory-for-system.patch | 29 +++++++++++++++++++
 .../openscap/openscap_1.3.10.bb               | 16 ++++------
 2 files changed, 34 insertions(+), 11 deletions(-)
 create mode 100644 recipes-compliance/openscap/files/0001-CMakeLists.txt-fix-installation-directory-for-system.patch

diff --git a/recipes-compliance/openscap/files/0001-CMakeLists.txt-fix-installation-directory-for-system.patch b/recipes-compliance/openscap/files/0001-CMakeLists.txt-fix-installation-directory-for-system.patch
new file mode 100644
index 0000000..87dd00b
--- /dev/null
+++ b/recipes-compliance/openscap/files/0001-CMakeLists.txt-fix-installation-directory-for-system.patch
@@ -0,0 +1,29 @@
+From 887bd1b60720f02e937c57568d7ef4d3df4b00e8 Mon Sep 17 00:00:00 2001
+From: Yi Zhao <yi.zhao@windriver.com>
+Date: Mon, 24 Jun 2024 11:27:30 +0800
+Subject: [PATCH] CMakeLists.txt: fix installation directory for systemd unit
+ file
+
+Upstream-Status: Inappropriate [oe specific]
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ CMakeLists.txt | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/CMakeLists.txt b/CMakeLists.txt
+index fdeda6eb4..77645ecd4 100644
+--- a/CMakeLists.txt
++++ b/CMakeLists.txt
+@@ -637,7 +637,7 @@ if(NOT WIN32)
+ 			configure_file("oscap-remediate.service.in" "oscap-remediate.service" @ONLY)
+ 			install(FILES
+ 				${CMAKE_CURRENT_BINARY_DIR}/oscap-remediate.service
+-				DESTINATION ${CMAKE_INSTALL_PREFIX}/${SYSTEMD_UNITDIR}
++				DESTINATION ${SYSTEMD_UNITDIR}
+ 			)
+ 		endif()
+ 	endif()
+-- 
+2.25.1
+
diff --git a/recipes-compliance/openscap/openscap_1.3.10.bb b/recipes-compliance/openscap/openscap_1.3.10.bb
index d3e44a8..c439d71 100644
--- a/recipes-compliance/openscap/openscap_1.3.10.bb
+++ b/recipes-compliance/openscap/openscap_1.3.10.bb
@@ -11,7 +11,9 @@ DEPENDS:class-native = "pkgconfig-native swig-native curl-native libxml2-native
 
 #March 18th, 2024
 SRCREV = "6d008616978306ce5e68997dce554a1683064f8f"
-SRC_URI = "git://github.com/OpenSCAP/openscap.git;branch=maint-1.3;protocol=https "
+SRC_URI = "git://github.com/OpenSCAP/openscap.git;branch=maint-1.3;protocol=https \
+           file://0001-CMakeLists.txt-fix-installation-directory-for-system.patch \
+          "
 
 S = "${WORKDIR}/git"
 
@@ -24,7 +26,7 @@ PACKAGECONFIG[rpm] = "-DENABLE_OSCAP_UTIL_AS_RPM=ON, ,rpm, rpm"
 PACKAGECONFIG[gcrypt] = "-DWITH_CRYPTO=gcrypt, ,libgcrypt"
 PACKAGECONFIG[nss3] = "-DWITH_CRYPTO=nss3, ,nss"
 PACKAGECONFIG[selinux] = ", ,libselinux"
-PACKAGECONFIG[remdediate_service] = "-DENABLE_OSCAP_REMEDIATE_SERVICE=ON,-DENABLE_OSCAP_REMEDIATE_SERVICE=NO,"
+PACKAGECONFIG[remediate_service] = "-DENABLE_OSCAP_REMEDIATE_SERVICE=ON,-DENABLE_OSCAP_REMEDIATE_SERVICE=OFF,"
 
 EXTRA_OECMAKE += "-DENABLE_PROBES_LINUX=ON -DENABLE_PROBES_UNIX=ON \
                   -DENABLE_PROBES_SOLARIS=OFF -DENABLE_PROBES_INDEPENDENT=ON \
@@ -47,14 +49,6 @@ do_configure:append:class-native () {
     sed -i 's:OSCAP_DEFAULT_XSLT_PATH.*$:OSCAP_DEFAULT_XSLT_PATH "${STAGING_OSCAP_BUILDDIR}${datadir_native}/openscap/xsl":' ${B}/config.h
 }
 
-do_install:append () {
-    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
-        if ${@bb.utils.contains('PACKAGECONFIG','remdediate_service','true','false',d)}; then
-            install -D -m 0644 ${B}/oscap-remediate.service ${D}${systemd_system_unitdir}/oscap-remediate.service
-        fi
-    fi
-}
-
 do_install:class-native[cleandirs] += " ${STAGING_OSCAP_BUILDDIR}"
 do_install:append:class-native () {
     oscapdir=${STAGING_OSCAP_BUILDDIR}/${datadir_native}
@@ -64,7 +58,7 @@ do_install:append:class-native () {
 
 
 SYSTEMD_PACKAGES = "${PN}"
-SYSTEMD_SERVICE:${PN} = "${@bb.utils.contains('PACKAGECONFIG','remdediate_service', 'oscap-remediate.service', '',d)}"
+SYSTEMD_SERVICE:${PN} = "${@bb.utils.contains('PACKAGECONFIG','remediate_service', 'oscap-remediate.service', '',d)}"
 SYSTEMD_AUTO_ENABLE = "disable"
 
 
-- 
2.25.1


