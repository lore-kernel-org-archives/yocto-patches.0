Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26729C27C55
	for <webhook@archiver.kernel.org>; Thu,  6 Jun 2024 06:14:59 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.7754.1717654490271325219
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Jun 2024 23:14:50 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=6887b57725=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4565qlFw025930;
	Thu, 6 Jun 2024 06:14:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yftm7vspf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 06:14:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfHBOb3LWSNVgxPM2W1vtAxaEmKikj6yWLwjCwuJpDbtMYVSmHhKO+lChaSRGCpVNBwNYFo92RjR9ybXhhJ81Iu1+tW1JyWaT4pu90IA3ZYnmd/CJFEPM6ic91gjxDNxufDfNi9pkWCyLB93nWvM4Z+kdd8cYpCOVUBxHdDvvexNNbpPf/TmbqLvG4hSz5ErL/i5jLot7LK5evhjBFaNAHa6QQQNVjWrJi/U0AR0rrw9C1uymdC3L0d5qHqKJ39aqPPAmf0ldAMUJrPsWkSmgZZAX9I6s1oGhFETph+C3RdZH+oYJauLEATZBokiULMmk6fJ9UmL2QUXyTOqZYVKYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44hbhMa7GHCYQ2O9Gvq11FgsMT9a2YWK5rUUXbIsfV4=;
 b=bZRMObZmNZqyR6l954PzcYCb3lgftGMXwgsDf8yFSA9O4Y3KruBL6IYziJRxziYuQIaYhptxznVc7ws/jzQk8zk0e9woxHfuHLxVjyGKt9AbQgrThFzVGz5EFrCJDt8ZbhdPR517LojZqEJnN8FD9kfwgh9PBxpHPn4BgGhjmeQnyiMj0dfPlWdEYvU9eJkMzZ90lwtUvZcHc0Fi0F8qN7WaAUgCS3AAHWgzSxJZ/2Cc1QXiLd33YCwYhp+lJki89rzg9WNPLcPaPz3uO2EpfEB9qtt7tv7CfLIv7NZq+64cAt2Gk61fC8wUQ8Sw+XCcIjH/2xXCZ7nMhKkbeXBEnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 IA0PR11MB7307.namprd11.prod.outlook.com (2603:10b6:208:437::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 06:14:46 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%6]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 06:14:46 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, joe.macdonald@siemens.com,
        joe_macdonald@mentor.com, joe@deserted.net
Subject: [meta-selinux][master][scarthgap][PATCH 2/2] refpolicy: fixes for auditctl and rsyslog
Date: Thu,  6 Jun 2024 14:14:34 +0800
Message-Id: <20240606061434.2764343-2-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240606061434.2764343-1-yi.zhao@windriver.com>
References: <20240606061434.2764343-1-yi.zhao@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0017.jpnprd01.prod.outlook.com (2603:1096:405::29)
 To DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|IA0PR11MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 63159f14-dffb-414f-6746-08dc85eff6d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2kHqPqCjutSnpDaQRKi9veOen3Z9r9R97vnQ+s7qoTNiywt+NuxtrOABMuF4?=
 =?us-ascii?Q?jXcVCO57QAIGTsZJWT3VKiDxiefUpiop/cKUPDZ5Q/s0pMF1B9SkI6XdB3Er?=
 =?us-ascii?Q?BZEAbmE9ApjVTka5KcZAj0rj104NDYBKW4R9OU222LMHdj4NsDudP/UXcAoW?=
 =?us-ascii?Q?Zrz0cVBwaArOBtdzP7o5yGLijYOzOtbNK+xoRGp6PNW/TDUPiVMS7r6HwAfS?=
 =?us-ascii?Q?U0lb2ia8fH/lBHmw0jnP1gHY5eOad31olKiizooETjQeE2yd/9NJOoEgYLu0?=
 =?us-ascii?Q?NA7Z5/3d6DvKYvaPZURFaO3Uwuxj5zSA7ML+WCrlMtJkwlNaDZNoYTtTswSa?=
 =?us-ascii?Q?41yemgeiGydjzc1BHvLYh1U66RgFfRdv+mzCyC/h2FPc/TpzIEn7PlB6ugcc?=
 =?us-ascii?Q?M4R0Et0CRqErhbbrrsgXSVYdtIAXumpyYTEzQlIfSaimWVAyEgaCz4Sawa0O?=
 =?us-ascii?Q?XMWRctJe9mM2YVCWmidHq7oZ5jHXXFpVtdJ9s113Pf4lYQwF6FqfJrOqP4fv?=
 =?us-ascii?Q?u3sotTb0EruBSVHk12HuVCkuq0xp9mOONFdvaEvu8LqFus+I8HFkAAUjsxqu?=
 =?us-ascii?Q?C4x1zz83VbpIRffAWHq7XIXGsWSdf3CPVkOBLM4lTKZuhGXVAwcKP/9+7Y4t?=
 =?us-ascii?Q?jyryF7D26214BavESqNz69QHf4X3OSMzC8RoGa+iXtn3+IxdSJZ5+dIk9o6V?=
 =?us-ascii?Q?0ncdlq5F3ml8qRojp9n+BaFiIAl2OPoQjyjQr4GB74f76in2ktSiSkL0/7iD?=
 =?us-ascii?Q?odqFZA++8gSf/tU+E9C7XT59wzI4G75QasJSot7qOCuR5/QxxRO4OVEahWOU?=
 =?us-ascii?Q?rNIjC2cQ0h9kdHyntq8asRyl9lg2NScqzA1VTUASbHWQsz0pqQ5nmLB3l9fT?=
 =?us-ascii?Q?+CV0VLn8KngGNegT2efW1myRMAvjqZ/OffFnHz7XE4xZNw86U0p6DjN+2vjg?=
 =?us-ascii?Q?xIPgOkUGIpmGbyqUZ/OfV63TpoxxFOQP/R9HEbavm4sDOvAcpRW3OPiH97eV?=
 =?us-ascii?Q?KzuEhKRfocW0dEIejWa2NzUNj10KcrchyBemrcYkSK5Ga5ZUW9GDONxfBNE0?=
 =?us-ascii?Q?CGjWBVkuH0JTn8mJTYq4DfFFVUq5bRvGd/5CK53zgGpywkhc5xchaLtwEkIf?=
 =?us-ascii?Q?cjMiRT8+41ssjmmZ7lqwHPLXIbYt0GXDf+yYLtpfVCCZCDfHknhz8W5yiujc?=
 =?us-ascii?Q?t+EYcisFzfrW5yeUJ/E1rvi3vqIOvhHZm0cf+O1Ioy4lt5M/YiN2ZA6/0NlR?=
 =?us-ascii?Q?BHma1YtWTIql6bfTNaaW88dYGPS4IcROX5RO9fslmX7b+5Z8mugEgRmdnobP?=
 =?us-ascii?Q?lytECwzse6Zj0QjI+IKf6l/G/SiqYUKsybhQstJMV+l7/bEqdABrZ5HA3lhA?=
 =?us-ascii?Q?a7EpFLw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QG2eubY4t8JGeG4+QBnhrm60nbKV7lLp8KmJjS/KkUSD4C/13TowakS3JYhx?=
 =?us-ascii?Q?MbtXkhy9q+DHrVACD0RXUrMSJ6/wVjsPnViEt+A4SKp9bdtFXk83tKM+0CIB?=
 =?us-ascii?Q?J8xtQsyNgQlWyLDKk1FZj9nHhc6cW39174RkfDcU0O+aanOWYcoQOxyX2gr9?=
 =?us-ascii?Q?fVlHiZY29ktt8nvoPaf+HWQYEJUJf4FQaxpUpRRjsDdoll7EtI9r4ErlfQZa?=
 =?us-ascii?Q?RE7lclqn5kTnmSojpD4FKeS/oep1mvrLQsoE1BEJFKEBJRTGhJR7QNmwBpBP?=
 =?us-ascii?Q?CX3t/Utet19ZeI/WYQK2xEjm7YGlJP4Vr60lmWzT6w2IaZyNKXCc5fIpFGSu?=
 =?us-ascii?Q?7HIlAruYKjJ527NTXbtsojnmR45cRqXgQjyqPcHyPB+Vu6IdQiRYydMLoXbc?=
 =?us-ascii?Q?LYRErSdQ5yzW0SUxI44FvjV1HRNK+LMt66RyOmwSvZv5FQImqjgZFTNqho+S?=
 =?us-ascii?Q?/4CmyvhTOqiXulfUGZtJAIwt7EoK2obEKZFW7dcoMnxu0dICyiwUSLAdCrMk?=
 =?us-ascii?Q?Q0dTIAgjM1kGG/Q7C/eup2bQfmFJ8lCbMjqystUchkurxdFKjdZYpw0oHYBw?=
 =?us-ascii?Q?IEPv+DwNdEp+ztEr83KKmKp1JmIMgxxFr9xZRAgWjZ9xbqYMr9UiSiHpCfag?=
 =?us-ascii?Q?mTAAvNoBRL6nNR2Kn0QQlbyGL/IC6c8QVbl6FZDmuhQV67AlmKVf6HLfwGr4?=
 =?us-ascii?Q?81NECQ4sQbpSniIHYa1q4QFQXtNEjhwTftya1ST8vzKZ0THFM1aToYx8PUNJ?=
 =?us-ascii?Q?jgn5ier+rX5RCY1db6lwhW0FSQRK/uy+6EntZeySPawAo1WU4RK/8cmdhziD?=
 =?us-ascii?Q?v0caQHbwZLHpq6GMqwErVfesvEU2GD2l5bNl86qkq6Aj04lzcs8L8thJ0W3X?=
 =?us-ascii?Q?GQKzUAwmnkB31zDJC7lU5iQWQzm9HcRu5ZTxGoEi2hVxgySCZYo7rdLcxToI?=
 =?us-ascii?Q?TjnxSZ+toFq/bzj1gjqIoZMrDougZfxTyT1ZcmfTGJRUPAEomwTl2WBzkqNf?=
 =?us-ascii?Q?dKPb1unq8fAwQBPpmc8mflVpdHaQ+fcOXKX8tKsXINOQB1nN92DH9/uBvrcS?=
 =?us-ascii?Q?7KE5/iUhHQZepr+Dadon+PiSJplyAB9ocacAs2HP63rgCzy49Hg4EJUdNYrV?=
 =?us-ascii?Q?vyLYC819tybI3UZHDz/a7TxXFnqMTq2Off/n4psd1rQ1HGFk1VYavoZMxoZe?=
 =?us-ascii?Q?IAQ6ywsUCM39bcAcuA/5LsHFct8+NOcr9iWsEms4szEhD4XKP0BxGBfCyvHz?=
 =?us-ascii?Q?8XD4QDHy73nQIW132qRlLIQxdPu6ELwV6FL2qMgscZWj1aK1/6Pg9rQdLyW/?=
 =?us-ascii?Q?NphJNbRVHIcdZQ7D0VglgU0dnHbjE5SnnpoDzsTzSiGHZyxMoEyOL8kjP7dW?=
 =?us-ascii?Q?JxHG1xTgfrfP+FESM8aKWHEgRLDJmm+hAhgXyUieeB760uCAAebLDZukH9de?=
 =?us-ascii?Q?oRJJoCFWKzr1p/f1rTGmCfK0duBqHKCeuXJM7zncHyS/7L000FT/j5R4jdBQ?=
 =?us-ascii?Q?I7KFIQE4FKIZqmQA5MJEOTUnQ1en94SlD9xn+U2dnBbOgi/8Jw5gBdlT4Rmi?=
 =?us-ascii?Q?iN8GpV4lORVxz9csKcOOmEmhLDwaoDVaMvRviYZn?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63159f14-dffb-414f-6746-08dc85eff6d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 06:14:46.6541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6f6CicZWfHxa2ecxxjQ4dkTa5qt5bQUeuKyN9drPb93MuOVlhhvHW+wmNnk7cvsSYlGweROh654JRts/2pUXlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7307
X-Proofpoint-GUID: XBsg9L-E0-FPsIoQLwUK1VbPnoIrkIzJ
X-Proofpoint-ORIG-GUID: XBsg9L-E0-FPsIoQLwUK1VbPnoIrkIzJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2405170001 definitions=main-2406060044
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Jun 2024 06:14:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/278

* Allow auditctl to read symlink of var/log directory.
* Grant getpcap capability to syslogd_t.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...ystem-logging-fix-auditd-startup-fai.patch | 20 +++++++---
 ...ystem-logging-grant-getpcap-capabili.patch | 38 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 3 files changed, 53 insertions(+), 6 deletions(-)
 create mode 100644 recipes-security/refpolicy/refpolicy/0057-policy-modules-system-logging-grant-getpcap-capabili.patch

diff --git a/recipes-security/refpolicy/refpolicy/0031-policy-modules-system-logging-fix-auditd-startup-fai.patch b/recipes-security/refpolicy/refpolicy/0031-policy-modules-system-logging-fix-auditd-startup-fai.patch
index e9e717b..6ad2475 100644
--- a/recipes-security/refpolicy/refpolicy/0031-policy-modules-system-logging-fix-auditd-startup-fai.patch
+++ b/recipes-security/refpolicy/refpolicy/0031-policy-modules-system-logging-fix-auditd-startup-fai.patch
@@ -1,4 +1,4 @@
-From d7dfe01114f9a1449ce2efd792ddf4b18fe91a45 Mon Sep 17 00:00:00 2001
+From 5b33f07f60b20eb6e07ea3f517c43a539ee21332 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/system/logging: fix auditd startup failures
@@ -13,14 +13,22 @@ Upstream-Status: Inappropriate [embedded specific]
 Signed-off-by: Xin Ouyang <Xin.Ouyang@windriver.com>
 Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
 ---
- policy/modules/system/logging.te | 2 ++
- 1 file changed, 2 insertions(+)
+ policy/modules/system/logging.te | 3 +++
+ 1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 45584dba6..8bc70b81d 100644
+index 45584dba6..4fb2fb63c 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
-@@ -177,6 +177,7 @@ dontaudit auditd_t auditd_etc_t:file map;
+@@ -117,6 +117,7 @@ allow auditctl_t self:netlink_audit_socket nlmsg_readpriv;
+ 
+ read_files_pattern(auditctl_t, auditd_etc_t, auditd_etc_t)
+ allow auditctl_t auditd_etc_t:dir list_dir_perms;
++allow auditctl_t var_log_t:lnk_file read_lnk_file_perms;
+ dontaudit auditctl_t auditd_etc_t:file map;
+ 
+ corecmd_search_bin(auditctl_t)
+@@ -177,6 +178,7 @@ dontaudit auditd_t auditd_etc_t:file map;
  manage_files_pattern(auditd_t, auditd_log_t, auditd_log_t)
  allow auditd_t auditd_log_t:dir setattr;
  manage_lnk_files_pattern(auditd_t, auditd_log_t, auditd_log_t)
@@ -28,7 +36,7 @@ index 45584dba6..8bc70b81d 100644
  allow auditd_t var_log_t:dir search_dir_perms;
  
  manage_files_pattern(auditd_t, auditd_runtime_t, auditd_runtime_t)
-@@ -306,6 +307,7 @@ optional_policy(`
+@@ -306,6 +308,7 @@ optional_policy(`
  allow audisp_remote_t self:capability { setpcap setuid };
  allow audisp_remote_t self:process { getcap setcap };
  allow audisp_remote_t self:tcp_socket create_socket_perms;
diff --git a/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-logging-grant-getpcap-capabili.patch b/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-logging-grant-getpcap-capabili.patch
new file mode 100644
index 0000000..5c2e789
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-logging-grant-getpcap-capabili.patch
@@ -0,0 +1,38 @@
+From f48edb588d799a7aab9110e4f67468d8e5e41c10 Mon Sep 17 00:00:00 2001
+From: Yi Zhao <yi.zhao@windriver.com>
+Date: Tue, 28 May 2024 11:21:48 +0800
+Subject: [PATCH] policy/modules/system/logging: grant getpcap capability to
+ syslogd_t
+
+The rsyslog is configured with --enable-libpcap which requires getpcap
+capability.
+
+Fixes:
+avc: denied { setpcap } for pid=317 comm="rsyslogd" capability=8
+scontext=system_u:system_r:syslogd_t:s15:c0.c1023
+tcontext=system_u:system_r:syslogd_t:s15:c0.c1023 tclass=capability
+permissive=1
+
+Upstream-Status: Inappropriate [embedded specific]
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ policy/modules/system/logging.te | 2 ++
+ 1 file changed, 2 insertions(+)
+
+diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
+index 511604493..9c0a58aef 100644
+--- a/policy/modules/system/logging.te
++++ b/policy/modules/system/logging.te
+@@ -404,6 +404,8 @@ optional_policy(`
+ # sys_admin for the integrated klog of syslog-ng and metalog
+ # sys_nice for rsyslog
+ allow syslogd_t self:capability { chown dac_override fsetid setgid setuid sys_admin sys_nice sys_resource sys_tty_config };
++# Rsyslog configures with --enable-libcap-ng
++allow syslogd_t self:capability setpcap;
+ dontaudit syslogd_t self:capability { sys_ptrace };
+ dontaudit syslogd_t self:cap_userns { kill sys_ptrace };
+ # setpgid for metalog
+-- 
+2.25.1
+
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 6ea1fc2..2edcbcd 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -72,6 +72,7 @@ SRC_URI += " \
         file://0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
         file://0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
+        file://0057-policy-modules-system-logging-grant-getpcap-capabili.patch \
         "
 
 S = "${WORKDIR}/refpolicy"
-- 
2.25.1


