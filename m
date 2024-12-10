Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F36E77183
	for <webhook@archiver.kernel.org>; Tue, 10 Dec 2024 13:13:29 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.9950.1733836405568368164
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Dec 2024 05:13:25 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=20745f6cf3=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAAAEmo003066;
	Tue, 10 Dec 2024 13:13:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cx4xaqpg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 13:13:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7oRQgvIGCwuah2zFt6U5rhqxJ2tdPkl/pYRivG3r5xWdK91ZGOdTbIN8ECQnSeLqsjcFBjrfw5BXL2ZLFtBOjgSM52e+n7nKsp6v1i/sBrZcTAdiGXpH0XD/y4hHYRBD+K0axnz8A3tetY3SN+isizqQHWrZFa+ing1ifwwkDUtGasq7pSuTxC1Q9QGPmxbXRgVrVG5d83Jo56nMCAuspn/f+1ai6tibAgFiKWc6nMlNXy4yxNbHPachHqtvfS1eZv8ZvpTd7Eyg36u+k4BrrQImtrBm1BSJtYs2S8kxB8mLwCs8nB3ho9VFK6iDKFsHcJT5x/W/MQQ2Hww1lQCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nR2wCpekwqxGyJwyhjQ1yTY22NDvdYwTz1F3+iODqYU=;
 b=mqY+b2ch24PRsoxVB4uwlWcU4aCsB6U714zmrmiCduvWz6sBM3uvFLwlsN+xiojmcHomhAhGDjYjOqM4+Pox9DV5hE3kipFyEdVA2BEe6Wbu0HZ9n9fGUwgvDQTpOQjZK53ff84hJfndRYKdJdDmq1T7+YwIfX7A56LDW0783Bm1wgQMg99DivKVTMKjnKRXShhjC1vWWJ6Lm/NLi28Wmjhffbd0EuQ+kpUDShMCLBFfcStgAjS6CsHrZYpv+56lqFxFMEvyJ2ciTswHWoLW5qsIZJKORFuvKAT4bq7BWdOuLlVVClUs5bu1EYfiW2e+Enm201vZa4qnknrb6eDwsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SJ2PR11MB8403.namprd11.prod.outlook.com (2603:10b6:a03:53c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15; Tue, 10 Dec 2024 13:13:19 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%7]) with mapi id 15.20.8207.017; Tue, 10 Dec 2024
 13:13:18 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, joe@deserted.net,
        joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH 3/4] libsemanage: fix build with swig 4.3
Date: Tue, 10 Dec 2024 21:12:55 +0800
Message-Id: <20241210131256.2393366-3-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241210131256.2393366-1-yi.zhao@windriver.com>
References: <20241210131256.2393366-1-yi.zhao@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::18)
 To DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SJ2PR11MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 01843d4a-36e1-4b7c-5ae8-08dd191c69e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/SF5TzPDHai/TcudUhfKpW58b0vzTc52OtYjbQO1IXWgDDdQUIJgA4BwEDCq?=
 =?us-ascii?Q?Zv4gq8mU1sMJhdUElStXCQQuunsUVARddj5R/o9N86RF6d8uLb2IMkJyu5M9?=
 =?us-ascii?Q?GuFVvr4E4V85noy9DG0Z2c4HwCGTEu4U2njeQ02gFmOmI6a1pLa8XnSOjN7w?=
 =?us-ascii?Q?S8JOxArSq6KN2/x0V3p9iXfUaGm8/mpTKr7pRo0tyV1bl9aYQnYgE46luczi?=
 =?us-ascii?Q?r+uET0i5dRG3/vMQYons830A75SfajihrZcoBIgGM0HFfgRI7NPAhBlZAtxA?=
 =?us-ascii?Q?2j4z/rXQ1ZDtlUkSFMUOJcflSdEP8Bi6XsA5DUSOUKmoWZ/ieKRJG6/MY5QP?=
 =?us-ascii?Q?+0hHJhZMOkLpildgK//C/TdonWm0+kS7nQQoEQBVRxcgHo7gzz5QA+slAE09?=
 =?us-ascii?Q?z/fVnV168u9IYwD55qltDaAEr8ldsJaNvXvTlEkz0higr7IgvTKN6Lv41nRA?=
 =?us-ascii?Q?tOGESxMfUq57wQNxQhDaoS575ScdSHqBej8m8tAlqolr13entFSagrgOnPhS?=
 =?us-ascii?Q?6CjhHRAuTzKOyQntdBEvc2zGGGYziEwav3Fm/ZhNLjNJ+zcK+DwxtKz7JaKQ?=
 =?us-ascii?Q?xnLShCbjO/5MDm2MBeJJ5bozuM1GJTsqp0ieVBzIqCcjxmpCPKqwayUnQw+c?=
 =?us-ascii?Q?eRm4Tf1yTpiSbUZWnr8oe1Aa40R/k4JjoBeL53op0rX5Ko4AB4GWXhI8TgIR?=
 =?us-ascii?Q?8Kw1qRMSUh8McIdEtV4da9kzyFeVCHI2q5kV+zS3tAmd8kkVV3dF7iTnEf51?=
 =?us-ascii?Q?qNM/T4D181++l+AG1R/G69XHLjgvl8IrNHs/g1mCfXMOu5W8kPK8RekZ9M0+?=
 =?us-ascii?Q?4yczjDODiKwlejoQ7E6E9qq9WKwNhdOlsPH2Tbw1EIqWA4xrkftdWLuwe5Ay?=
 =?us-ascii?Q?kR52nzxRB4ifJ/jfzBwLZr3sN0Oh2gHAAev2sRpWTeOjzerYtQ/WOjN45fPJ?=
 =?us-ascii?Q?6yVpEKntHIXcEqqNz1DZbnoY9dAg7C7ycpmMTQrL8CRRI3a4S9dzaRi6GaUO?=
 =?us-ascii?Q?QFbWugn492vm6SamqTHjxijnMLjwrwDDT0n5ZqAshvw45E/HIXjGPDRSHJ61?=
 =?us-ascii?Q?NIiMnziEo4k3zMfbfT8C1V82Y34nnA4OFWPKMlGN9P63KLJp8yl8wb9+j/ot?=
 =?us-ascii?Q?lVRBpIipGr8M2BnLKGpr4pECcpl83+SyEb2TNpvgzE205gaUBePtNal+ADnR?=
 =?us-ascii?Q?py+ibAGp+FzRDGt8Jr05/5kxiAGFTtbfHSRJksePQRitHUVPoW8LZlLxkMgT?=
 =?us-ascii?Q?XLwCzY7fqnerhCUzp1bVpFxcztS8L2cH63y/RuPqShBKbIdOJCNKcW9zIKdJ?=
 =?us-ascii?Q?tnh2SsCxGW3b1C4ltW3vH/layPggXgQFw1Rrg0Spqd30LNY/0WgdFMaJiJqe?=
 =?us-ascii?Q?70quG16kSVOipU/KZrzYgWMFC1BoFZD0TABJRKtDth/19AFVxHvUIUzYFT6g?=
 =?us-ascii?Q?oUI9dsjKFTQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aCaxy3woWcoxvuZGTCIoDTk6J6074RHdx0pGadm0egmBlJ9Qd1zUfdsQbNVF?=
 =?us-ascii?Q?kyi+hRm8eRMtG+5RSfiFq9pENXIqrWbOudD5ddNgnk7TfdHptcVBcbTZelMZ?=
 =?us-ascii?Q?Y9GXMosUM9u7seWbLWwBv1t4LOVd2cZ5y8Mz8v3acHbWUJt49TvB0iO0vr1m?=
 =?us-ascii?Q?yv3ZthGLO1An4kB+STyP/l5LFGcW4GDCZpwKGxuTbJvhvjuHnDbE43iIHFMG?=
 =?us-ascii?Q?KIk3osr0+rpk+OrbFXoTfsitBA5wIOnn+92WjkzSAwaO6WkNMBOHZrejIiaL?=
 =?us-ascii?Q?VLOVorhMWoumHy8vkRT7qy9igO/eVTMSnzgiLSbxctkVx3zo8LF10KvONtQm?=
 =?us-ascii?Q?w/QufET6bbhZaKYw/W+wKWMWagdWd2iOf7ZcWR2f5F3gWdhzSlM45dqmM6ti?=
 =?us-ascii?Q?yaIgbzeAo14Ii48RzMjR6GpBypkZ9CG46YMlPHr40QXjaBj0yhNx1LyLGV3h?=
 =?us-ascii?Q?+n70dsEkEi9tD5zrkLIYxH0Vf1aqZIEUXMVT7ZFbJebFfYHDxDADGID6C7ZG?=
 =?us-ascii?Q?M8aDTPryl8Qgi7U9i5J/U/j4wmXJ2wgZLh3CzWGdi+OFa8PLGIwy6tTbGO+K?=
 =?us-ascii?Q?PohmbmldNmAA4fu/ucWud/fjXZMGuvDP/H/o3Ley4fMvDECsMhHRZy+EKri0?=
 =?us-ascii?Q?5r8yYkm9tcAgUP5eVTkWnTp+XB6oHZFs5WhUQFHIoC2URJiS+NLICfF1aK2B?=
 =?us-ascii?Q?u/g1TLa7BAmnGA4CVEAyG5DrNTxhw3URWDVy9jIUPcH7Ij7chvskQT98jXLG?=
 =?us-ascii?Q?rU+4q3lKEwB+0TJx97JQxmAQTKFs8DNbr7CZlx2LG1i1A4oAwwZsVETBIqN9?=
 =?us-ascii?Q?Pi8H6LeL22vFqYmkUeGY01hshp+jiaOxSUQwz9Wk0fqCbspXEbf6vm6LunLG?=
 =?us-ascii?Q?Fw0STpWsG8oOjxxesaFoF/ElQVDfmuxxDS8sBE6u2nmIN8s2NK/Znd4tZXgI?=
 =?us-ascii?Q?bhYllisOEr2IjTN9OdmZEcQCpGxFZPgsecn5hfVlBeNSQovVXSasFTS1YOml?=
 =?us-ascii?Q?ii/BfIhj7BxO3g43mgsx6C+c5hxgWXGAMSztw0oI82XKOWUxpNwRILeAcCDz?=
 =?us-ascii?Q?8jqfB4O8fJvalvgMrysibZTeyYWY9OpsG+WKru367kpf25c2+rjFl/BSyf7a?=
 =?us-ascii?Q?1BaYboyftbilL/6m1mKDSuqjLeXc8avMoThHIBQT2NYC+VJJp2zgb9yk9GVy?=
 =?us-ascii?Q?VRT1VYQ7LL2DeRjY2nlZKCBlFh0WKhN9Qmtcn4WjmQCLBsTLkPDcWy2UEdxu?=
 =?us-ascii?Q?C+1XGT5Sypb2BhmNOvjrG073N2J7jFzhaR4pSG2f3FQPfm6zrnzYa1Ebq1zP?=
 =?us-ascii?Q?7QFT7+VXBx9GvRs/rHLYlFj8EyHYXFGcN4vHLBJZBpzC9BwOYx6kDHkdA4Ct?=
 =?us-ascii?Q?lys3izEdZbzB6CgnF76X1gv93VVeFFoAItjB9+eGYkizrj9J4ynK3lf6ayZS?=
 =?us-ascii?Q?3DXasNHAIJChfzFhedWKkZUAHwudbqaYEado+CmXqjyYxgTvBDSr3hExg86a?=
 =?us-ascii?Q?5VVVYPfPsu7+bICPkqFyGUkHj3t34QRc1rHQiuWRuxukezf6IvmDV/2klc61?=
 =?us-ascii?Q?Rm+F72wrdfFrTAfFIVjC9GCRX8OgwUHSzkXaBK85?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01843d4a-36e1-4b7c-5ae8-08dd191c69e4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 13:13:18.4857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9nvIHzdcuEmiC6PmhdKtQuUxuCOHWj7S4NL35Pc/0elE+tlmQ1Nejbv1OJ11+m04eH1I3CCKXdJiA8FfkF/4aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8403
X-Proofpoint-GUID: YkM9OAJvQz3Lwk1jAnKqZcpzUd-Q3Uzb
X-Proofpoint-ORIG-GUID: YkM9OAJvQz3Lwk1jAnKqZcpzUd-Q3Uzb
X-Authority-Analysis: v=2.4 cv=Y/UCsgeN c=1 sm=1 tr=0 ts=67583e73 cx=c_pps a=98TgpmV4a5moxWevO5qy4g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10 a=NEAV23lmAAAA:8
 a=t7CeM3EgAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=_a8wGqok5QfCM0N-IlwA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_06,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2411120000 definitions=main-2412100098
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Dec 2024 13:13:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/880

Backport a patch to fix build with swig 4.3[1].

[1] https://github.com/SELinuxProject/selinux/issues/447

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...semanage-fix-swig-bindings-for-4.3.0.patch | 422 ++++++++++++++++++
 recipes-security/selinux/libsemanage_3.7.bb   |   1 +
 2 files changed, 423 insertions(+)
 create mode 100644 recipes-security/selinux/libsemanage/0001-libsemanage-fix-swig-bindings-for-4.3.0.patch

diff --git a/recipes-security/selinux/libsemanage/0001-libsemanage-fix-swig-bindings-for-4.3.0.patch b/recipes-security/selinux/libsemanage/0001-libsemanage-fix-swig-bindings-for-4.3.0.patch
new file mode 100644
index 0000000..cba77c9
--- /dev/null
+++ b/recipes-security/selinux/libsemanage/0001-libsemanage-fix-swig-bindings-for-4.3.0.patch
@@ -0,0 +1,422 @@
+From e38815d7b44cac435195c82a54d2bf2517bc4b1a Mon Sep 17 00:00:00 2001
+From: Petr Lautrbach <lautrbach@redhat.com>
+Date: Wed, 16 Oct 2024 20:48:12 +0200
+Subject: [PATCH] libsemanage: fix swig bindings for 4.3.0
+
+https://github.com/swig/swig/blob/master/CHANGES.current
+
+"[Python] #2907 Fix returning null from functions with output
+parameters.  Ensures OUTPUT and INOUT typemaps are handled
+consistently wrt return type.
+
+New declaration of SWIG_Python_AppendOutput is now:
+
+  SWIG_Python_AppendOutput(PyObject* result, PyObject* obj, int is_void);
+
+The 3rd parameter is new and the new $isvoid special variable
+should be passed to it, indicating whether or not the wrapped
+function returns void.
+
+Also consider replacing with:
+
+  SWIG_AppendOutput(PyObject* result, PyObject* obj);
+
+which calls SWIG_Python_AppendOutput with same parameters but adding $isvoid
+for final parameter."
+
+Fixes: https://github.com/SELinuxProject/selinux/issues/447
+
+Suggested-by: Jitka Plesnikova <jplesnik@redhat.com>
+Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
+Acked-by: James Carter <jwcart2@gmail.com>
+
+Upstream-Status: Backport
+[https://github.com/SELinuxProject/selinux/commit/e38815d7b44cac435195c82a54d2bf2517bc4b1a]
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ src/semanageswig_python.i | 64 +++++++++++++--------------
+ src/semanageswig_ruby.i   | 32 +++++++-------
+ 2 files changed, 48 insertions(+), 48 deletions(-)
+
+diff --git a/src/semanageswig_python.i b/src/semanageswig_python.i
+index 5f011396..0e27424f 100644
+--- a/src/semanageswig_python.i
++++ b/src/semanageswig_python.i
+@@ -111,7 +111,7 @@
+ }
+ 
+ %typemap(argout) char** {
+-	$result = SWIG_Python_AppendOutput($result, SWIG_FromCharPtr(*$1));
++	$result = SWIG_AppendOutput($result, SWIG_FromCharPtr(*$1));
+ 	free(*$1);
+ }
+ 
+@@ -134,7 +134,7 @@
+                         	NULL, NULL, &plist) < 0)
+ 				$result = SWIG_From_int(STATUS_ERR);
+ 			else
+-				$result = SWIG_Python_AppendOutput($result, plist);
++				$result = SWIG_AppendOutput($result, plist);
+ 		}
+ 	}
+ }
+@@ -148,7 +148,7 @@
+ }
+ 
+ %typemap(argout) semanage_module_info_t ** {
+-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ /** module key typemaps **/
+@@ -160,7 +160,7 @@
+ }
+ 
+ %typemap(argout) semanage_module_key_t ** {
+-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ /** context typemaps **/
+@@ -172,7 +172,7 @@
+ }
+ 
+ %typemap(argout) semanage_context_t** {
+-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ /** boolean typemaps **/
+@@ -197,7 +197,7 @@
+ 				(void (*) (void*)) &semanage_bool_free, &plist) < 0)
+ 				$result = SWIG_From_int(STATUS_ERR);
+ 			else
+-		   	        $result = SWIG_Python_AppendOutput($result, plist);
++				$result = SWIG_AppendOutput($result, plist);
+ 		}
+ 	}
+ }
+@@ -207,11 +207,11 @@
+ }
+ 
+ %typemap(argout) semanage_bool_t ** {
+-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(argout) semanage_bool_key_t ** {
+-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(in, numinputs=0) semanage_bool_key_t **(semanage_bool_key_t *temp=NULL) {
+@@ -240,7 +240,7 @@
+ 				(void (*) (void*)) &semanage_fcontext_free, &plist) < 0)
+ 				$result = SWIG_From_int(STATUS_ERR);
+ 			else
+-				$result = SWIG_Python_AppendOutput($result, plist);
++				$result = SWIG_AppendOutput($result, plist);
+ 		}
+ 	}
+ }
+@@ -250,11 +250,11 @@
+ }
+ 
+ %typemap(argout) semanage_fcontext_t ** {
+-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(argout) semanage_fcontext_key_t ** {
+-        $result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(in, numinputs=0) semanage_fcontext_key_t **(semanage_fcontext_key_t *temp=NULL) {
+@@ -284,7 +284,7 @@
+ 				(void (*) (void*)) &semanage_iface_free, &plist) < 0)
+ 				$result = SWIG_From_int(STATUS_ERR);
+ 			else
+-				$result = SWIG_Python_AppendOutput($result, plist);
++				$result = SWIG_AppendOutput($result, plist);
+ 		}
+ 	}
+ }
+@@ -294,11 +294,11 @@
+ }
+ 
+ %typemap(argout) semanage_iface_t ** {
+-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(argout) semanage_iface_key_t ** {
+-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(in, numinputs=0) semanage_iface_key_t **(semanage_iface_key_t *temp=NULL) {
+@@ -328,7 +328,7 @@
+ 				(void (*) (void*)) &semanage_seuser_free, &plist) < 0)
+ 				$result = SWIG_From_int(STATUS_ERR);
+ 			else
+-				$result = SWIG_Python_AppendOutput($result, plist);
++				$result = SWIG_AppendOutput($result, plist);
+ 		}
+ 	}
+ }
+@@ -338,11 +338,11 @@
+ }
+ 
+ %typemap(argout) semanage_seuser_t ** {
+-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(argout) semanage_seuser_key_t ** {
+-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(in, numinputs=0) semanage_seuser_key_t **(semanage_seuser_key_t *temp=NULL) {
+@@ -371,7 +371,7 @@
+ 				(void (*) (void*)) &semanage_user_free, &plist) < 0)
+ 				$result = SWIG_From_int(STATUS_ERR);
+ 			else
+-				$result = SWIG_Python_AppendOutput($result, plist);
++				$result = SWIG_AppendOutput($result, plist);
+ 		}
+ 	}
+ }
+@@ -381,11 +381,11 @@
+ }
+ 
+ %typemap(argout) semanage_user_t ** {
+-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(argout) semanage_user_key_t ** {
+-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(in, numinputs=0) semanage_user_key_t **(semanage_user_key_t *temp=NULL) {
+@@ -414,7 +414,7 @@
+ 				(void (*) (void*)) &semanage_port_free, &plist) < 0)
+ 				$result = SWIG_From_int(STATUS_ERR);
+ 			else
+-				$result = SWIG_Python_AppendOutput($result, plist);
++				$result = SWIG_AppendOutput($result, plist);
+ 		}
+ 	}
+ }
+@@ -424,11 +424,11 @@
+ }
+ 
+ %typemap(argout) semanage_port_t ** {
+-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(argout) semanage_port_key_t ** {
+-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(in, numinputs=0) semanage_port_key_t **(semanage_port_key_t *temp=NULL) {
+@@ -457,7 +457,7 @@
+ 				(void (*) (void*)) &semanage_ibpkey_free, &plist) < 0)
+ 				$result = SWIG_From_int(STATUS_ERR);
+ 			else
+-				$result = SWIG_Python_AppendOutput($result, plist);
++				$result = SWIG_AppendOutput($result, plist);
+ 		}
+ 	}
+ }
+@@ -467,11 +467,11 @@
+ }
+ 
+ %typemap(argout) semanage_ibpkey_t ** {
+-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(argout) semanage_ibpkey_key_t ** {
+-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(in, numinputs=0) semanage_ibpkey_key_t **(semanage_ibpkey_key_t *temp=NULL) {
+@@ -500,7 +500,7 @@
+ 				(void (*) (void*)) &semanage_ibendport_free, &plist) < 0)
+ 				$result = SWIG_From_int(STATUS_ERR);
+ 			else
+-				$result = SWIG_Python_AppendOutput($result, plist);
++				$result = SWIG_AppendOutput($result, plist);
+ 		}
+ 	}
+ }
+@@ -510,11 +510,11 @@
+ }
+ 
+ %typemap(argout) semanage_ibendport_t ** {
+-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(argout) semanage_ibendport_key_t ** {
+-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(in, numinputs=0) semanage_ibendport_key_t **(semanage_ibendport_key_t *temp=NULL) {
+@@ -543,7 +543,7 @@
+ 				(void (*) (void*)) &semanage_node_free, &plist) < 0)
+ 				$result = SWIG_From_int(STATUS_ERR);
+ 			else
+-				$result = SWIG_Python_AppendOutput($result, plist);
++				$result = SWIG_AppendOutput($result, plist);
+ 		}
+ 	}
+ }
+@@ -553,12 +553,12 @@
+ }
+ 
+ %typemap(argout) semanage_node_t ** {
+-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ 
+ %typemap(argout) semanage_node_key_t ** {
+-	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++	$result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(in, numinputs=0) semanage_node_key_t **(semanage_node_key_t *temp=NULL) {
+diff --git a/src/semanageswig_ruby.i b/src/semanageswig_ruby.i
+index e030e4ae..9010b545 100644
+--- a/src/semanageswig_ruby.i
++++ b/src/semanageswig_ruby.i
+@@ -38,7 +38,7 @@
+ }
+ 
+ %typemap(argout) semanage_module_info_t ** {
+-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ /** context typemaps **/
+@@ -50,7 +50,7 @@
+ }
+ 
+ %typemap(argout) semanage_context_t** {
+-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ /** boolean typemaps **/
+@@ -66,11 +66,11 @@
+ }
+ 
+ %typemap(argout) semanage_bool_t ** {
+-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(argout) semanage_bool_key_t ** {
+-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(in, numinputs=0) semanage_bool_key_t **(semanage_bool_key_t *temp=NULL) {
+@@ -90,11 +90,11 @@
+ }
+ 
+ %typemap(argout) semanage_fcontext_t ** {
+-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(argout) semanage_fcontext_key_t ** {
+-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(in, numinputs=0) semanage_fcontext_key_t **(semanage_fcontext_key_t *temp=NULL) {
+@@ -114,11 +114,11 @@
+ }
+ 
+ %typemap(argout) semanage_iface_t ** {
+-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(argout) semanage_iface_key_t ** {
+-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(in, numinputs=0) semanage_iface_key_t **(semanage_iface_key_t *temp=NULL) {
+@@ -138,11 +138,11 @@
+ }
+ 
+ %typemap(argout) semanage_seuser_t ** {
+-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(argout) semanage_seuser_key_t ** {
+-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(in, numinputs=0) semanage_seuser_key_t **(semanage_seuser_key_t *temp=NULL) {
+@@ -162,11 +162,11 @@
+ }
+ 
+ %typemap(argout) semanage_user_t ** {
+-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(argout) semanage_user_key_t ** {
+-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(in, numinputs=0) semanage_user_key_t **(semanage_user_key_t *temp=NULL) {
+@@ -186,11 +186,11 @@
+ }
+ 
+ %typemap(argout) semanage_port_t ** {
+-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(argout) semanage_port_key_t ** {
+-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(in, numinputs=0) semanage_port_key_t **(semanage_port_key_t *temp=NULL) {
+@@ -210,12 +210,12 @@
+ }
+ 
+ %typemap(argout) semanage_node_t ** {
+-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ 
+ %typemap(argout) semanage_node_key_t ** {
+-        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
++        $result = SWIG_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+ }
+ 
+ %typemap(in, numinputs=0) semanage_node_key_t **(semanage_node_key_t *temp=NULL) {
+-- 
+2.25.1
+
diff --git a/recipes-security/selinux/libsemanage_3.7.bb b/recipes-security/selinux/libsemanage_3.7.bb
index 93eb870..7e6c91f 100644
--- a/recipes-security/selinux/libsemanage_3.7.bb
+++ b/recipes-security/selinux/libsemanage_3.7.bb
@@ -14,6 +14,7 @@ inherit lib_package python3native
 SRC_URI += "file://libsemanage-Fix-execve-segfaults-on-Ubuntu.patch \
             file://libsemanage-allow-to-disable-audit-support.patch \
             file://libsemanage-disable-expand-check-on-policy-load.patch \
+            file://0001-libsemanage-fix-swig-bindings-for-4.3.0.patch \
            "
 
 DEPENDS = "libsepol libselinux python3 bison-native swig-native"
-- 
2.25.1


