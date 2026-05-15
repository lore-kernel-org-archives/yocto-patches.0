Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661C1CD4F48
	for <webhook@archiver.kernel.org>; Fri, 15 May 2026 08:39:07 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30851.1778834338190036957
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 15 May 2026 01:38:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=kpBOjLSw;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=95954df25a=changqing.li@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F8Cjxw1506579
	for <yocto-patches@lists.yoctoproject.org>; Fri, 15 May 2026 08:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=wdGav9HToLF83KCwu2A4
	wyr0Oj+AIb7/2VHW98vnxIo=; b=kpBOjLSw4nPbNPtI9x0HpsjJyhnJpHavVvtf
	8mgqeyPwNECkEnQIgvvMdsLoXCEPO0iYO/mJSL+bJG85Czq94g2OnqepTncMytyt
	YBSLKmaPSIZ1Mn++K9TS7dYNHAdgsa2ZjKd/RBrYJGgvrhnA5l1yYEHCZ0kD0GHz
	3CW/9vIUjlTAovcSYRkwS34ASc2K7R9L+zwOs9fkWRWZfVEtXu21DQOqcFUUWMx0
	n2j7wrljm6OfsWH7oxO9Q4iDQzhvVgVgV7o5IxEKERqtJqA6nSxVrq5g+olW9GIp
	TTbdezj19VQQJsL8ikBIIORKmnHtlPNBMf4lR3HvJcbeR0xnbA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e5m6b0nd7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 15 May 2026 08:38:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKE4BJt99Wcquw5l+puzNjCWWBP5X9VLiG7FuwhGKBBuwm/aea4SbcZ/dd3OCRuWsRj+NN4LfXdtU7+GZ/FF9ceUu3s5I72CC6LQZQdehjQnXT/ymc3QmIgclBbz8kR/zQWKUOhTJe2fT8xn3cu7HUGiWUO/OqHekELLruHv4HLs4FwVeY57op0j6WrbT9bZRvNHhz69elU2ieaRom1Jaspqf8wHtdIR0ejxQNZ16gnJGKq9vdhubYteJLY2M6R6xGSTJdXMlJFyenwHcJG+EAXT+P2IsBQ0iIp21+7zQaUx//7vSh3gu0aIAvJSkEdgWSk7DctiUWSs1g8kKQxKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdGav9HToLF83KCwu2A4wyr0Oj+AIb7/2VHW98vnxIo=;
 b=E4oxTPBlN3Xm366ns14bnP/IGEbMMOytLBObYm3/jGeze+OBT9NjEpmjL2S6cfDToy6COYemQfhxW3o/noqYGQ/VDJb8P1d+wz3RP1dhnFCFODlRLTAsBN8M/2tEHs7751VWygXAInH6xxZ03d8XEz37dvAb6PqCx9bnz3tSFvuCw/9VjajfE6U21a7ErPQ/MWxgI4c2khcUh0n73lsaNnw0kZ906ELqeKT6JxktD/gAfNDk7l+rlv+CiU5VIZ+3ahCKR+qyv0eRRZ+7Vm36RxMZbJ896//Eqf1gyjEA6qwt/astDQ5Z2QR14bjoyQKNSok3qPb2m0NUT/yEyXPj8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by PH0PR11MB4822.namprd11.prod.outlook.com (2603:10b6:510:39::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 08:38:54 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::531e:6ef5:812b:48f6]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::531e:6ef5:812b:48f6%5]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 08:38:54 +0000
From: Changqing Li <changqing.li@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [error-report-web][PATCH] Add configuations as error details
Date: Fri, 15 May 2026 16:38:31 +0800
Message-Id: <20260515083831.2891826-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0202.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c3::15) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|PH0PR11MB4822:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9ed9ba-7245-4826-ed04-08deb25d658d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|56012099003|18002099003|11063799003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	fH2JP089O/vam0Sf0J+6Ryh2yM4ZSEIP9dcM2fWH5XvDbPF+awynsDJUTImriXxjFBItDAYplAuCuFbWRrb33g0CLPlS5RlYMQvnwC23GC2IcT0jZW/IPLagxbGYjPaLTK4lHHItj3CySHrRKT/Nhis4q1F+hdBep37eeqACH4ZBXjt6NsH/NQI7gxD4XTzNQgjcsdXK/4wpAcztBXImv3jmckt4uLDYVYL/JqaBZhu0b5rcY4UjFqAVwtYl+WKLi9LirQvwqssZFj+huPmCmr1t0P5AHXkETk6TML9cCi3LLNo4/lhL5xP4Rt1AyamUPpYxPG+55IUQyU9tmkSFHuZ4OMEtvRHP66sVP0RvVqAJ0O94E0c2wOG9WDsLn3QfG7+i/zlpQeCFJXkxI67KlYJApeAarP8Jbvydo7FVjOu0Xx/1cvlZZtwmXroDYWZBM5S1pbkXGxRnuhhQ7i5TNGRcxMnKKZtPccfhx/rAXPWoy3BUlYINpucmgJy2WK834/iiOuKqXBvp+rtF/MBvFqwi1/+IMF9Tc29ZCtx3beioFZnRn6O6SVjXzJ0pIVNmvi+R+XI1Tc69MyUe1zQsVZiFKR/g2pTes3w7epI0hjd7suCiVpOsGVoWESCpZCSD8I8PKm0GSuEMN07MEPzbBBH+geEh0+Q23YKBSQYXb0Iwwm4Rho+KvdDn83O+84PKZvD8DGkQOgnANSkKBuSezg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(56012099003)(18002099003)(11063799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lapdAduT55hxNqIPxAAtcjW6Eua5AJH34ztxIN9abuWcg71TabIHgsQYLJMe?=
 =?us-ascii?Q?MsAj/B8MPPNpYroklaCBKw5MkJC7JmpCZGhtbwQ+vvDwnwit+kw30SXILSYq?=
 =?us-ascii?Q?rz81nw/2gVtqSTDYL5kl7F+bgJivIl4aXlzgz4GKFoIm/EhgTLWzR8HPBeKa?=
 =?us-ascii?Q?FIcutY/61+fFCf+QGpgLpXgWd3zxZBZM37Z+uDC9sMt+OP00ebpEzf8eCYQQ?=
 =?us-ascii?Q?me0VEp5J3Gatzbw7olF6GH/JQjbdszXLjLGpZJvAvg/wbu3xI/StEqT2O/YA?=
 =?us-ascii?Q?AmkD5Bii5jjZQHohIFHxiB3DcUevcwpqgXROOAo9uvVfXnQDQu+M8I5kuxoe?=
 =?us-ascii?Q?Ki1yJQLzFuxSuJJkOLPtD8kTLHhDPhQMKIHNtZ0zE2agRo495uV3T0BPXZcq?=
 =?us-ascii?Q?0Xbu8Vky5Z2ZI6jcR2QmJjjqnhMJRAMXkD9pqbpazj0uMKOrtVYuyPNwLECS?=
 =?us-ascii?Q?dnPhuOTa+qzsQHmhhBUQXP8qioLOKpdqLOYLEz+dD0lgGXD0iLBY/W9mEp2q?=
 =?us-ascii?Q?C+SBGAdipw7ifrx2JDYJQGI6FbMHtLOy6Oc8rFc8QxTIANyx1tMTjr9OQUzH?=
 =?us-ascii?Q?BYE2L7xNDDekmpdMLaehxu6AXYFxsOq048L0IK2dPQxvBN4n9QiXikkIrjMK?=
 =?us-ascii?Q?KbgUAHFdvjMljlXSkFF309uQbwRCdj16Ok/cNytE9P0nYry0nLMVIMZd2ujy?=
 =?us-ascii?Q?zHtTUP6d9mBPrf2KAllyBi3eNT/0nYi8vlLQvwD748x957yvt+L/6jOUB0hb?=
 =?us-ascii?Q?bIrPLNJBij8Rzu4XUe5OkKlkPpuM3FNObbTz583pVoAdXbdu1f9NZd9Cn1R0?=
 =?us-ascii?Q?kluXNiH5O62M/QgqqAcYMFsMCS+YwJqtBqX6v09T/HcIVACJSX+vVgZW/kmc?=
 =?us-ascii?Q?oUae5L/YCu1SuP79AZFyiD6y4FzH8rHzLVnKdirqBupqPN1/SlA3lDURJOpV?=
 =?us-ascii?Q?YPGC0ZZufj+1AwD1/kJ2fjpRZ7fFbQ4gGGV46iAFV+EYK6f2G06Otv/f4JGK?=
 =?us-ascii?Q?iw1Bi4eaqtCFGQ0KVw7y2ov/J1mcCX+yvTHWREMGBgQ1OCWCOxvVG8J+0Z1h?=
 =?us-ascii?Q?W/knR6rZkwlG6YXXgVYm/xKgQg31boppOb04ZkQ+CFKtKfjhAKvrJaG9tnmq?=
 =?us-ascii?Q?UUDSUWBWUMM+FaBobrDp7zaMMalztaAwUAZwAL3x1VZP4Z/kRd2AzowjIagK?=
 =?us-ascii?Q?ZwnidnDlLVxFAH4A5mZ7NZMIp9YweWlA0itoXOg6WWbg2cDhcBs9Tz/EQ+tp?=
 =?us-ascii?Q?Lg6/eItMx9oRSVr9wnBc4wfHi7arRRWnnboaZRky2Txd0+JKhtujK4Drn1nf?=
 =?us-ascii?Q?IkYz2o+C6k0RlL2tEv5iipDYdKhzzY7QV0foXdiTaCDQmphpEIwltgO0LjZN?=
 =?us-ascii?Q?UoQrbz3Jn99Mdi3o3STfaVwvge5ion0af7nEiQtgeNQhN/4F4cNE+i6SiaYM?=
 =?us-ascii?Q?ub8ej1dtp+hwCLGQXwB8LoG074sa5oexXOKmwHRS+7boxdHBGn/gXQmX4mIE?=
 =?us-ascii?Q?mNJZYA0W7NalO0qzN/Km/7F4rtyH1Kn+nuW7yyGZ4C2T+cp6BTBr8Ofa8WTX?=
 =?us-ascii?Q?NLZiDEfQQTp27Jrr19jBlgJxN1UAGcIfoz6Aep+Rn+JQD/UKNh3xavd1rB0Y?=
 =?us-ascii?Q?li/jQoi0E/b0YVIBszQyeZ2nC070zGo+qOXZUHYi0y1gs1zbURgsZdOrsHCK?=
 =?us-ascii?Q?f7Rib3uKnnj+dZ/uueLoYele1AbBMgqfsCm5woLWj+GCedfoAv9fBmwUnqW2?=
 =?us-ascii?Q?CzxJMZMusEsaC+dLF78fpNfOIH73oV8=3D?=
X-Exchange-RoutingPolicyChecked: 
	rfOGdM99czOv0C/aSAFJIEVWvAUlt2/oXQV/z945rnq2UaW83QDMba1uyKfpihid/yfUWsNP0smO/Pf0Y0C03OyDlh5U5TJhJtVDCva+Uwnl84zHC1+dqYBVpyLR8CfP4x9dslVQzBXMR/nII0G/l4Zmjiw2iLUioj7rJerO4Stq7Av3DKyIhTC+vKOXGsTd/1ExfKeGzls10F4Vcc/AWLoVWOGB4FfWsG4GL5lnB5v9vj6Vh6J5RgoVSQFwckzn6IsqtlV7wKO/yrKjecgHPkBkUrgehH88jktr9sozultuIy2HNVvJyzjfP7nGPYcB81nE8DH5fPTYPXWqzE2lWg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9ed9ba-7245-4826-ed04-08deb25d658d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 08:38:54.0642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AZLHAgsFeW4QExyCqDMreKPS5cC7iYQHa+lbiPy2hr8cKlo+Rh2rEWjOT7NZ09zYb/Ua8bo7GrCSXZrDPXe/E03FhB9u1kQx8AnHt8DDhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4822
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA4NiBTYWx0ZWRfX0rRO0R02JT9f
 Eh4yjc80YDFoZhavog83vzKcHsAb36/GD7SeTnt7Y0DyHAZd6G99hRsY/YAbx46iELM4zizPHSJ
 p5fd7PZkQP9xFfuVDN9EJ+lV33H5QVJxCf6meWCFxEfCUi0dtSa6Ky05kC0K2/zgNmanoYkIRZ/
 iwA3C2Y4MZyvpbVRb7iml2VCXs+BUHMfpOo/MwgZzok2mLm13dde83B3YvFHuWU4U3LjvI50Z1v
 6x3Ah58aTpS1QuKCe7GgspoAvl6YOLvYaFF96+8UM4u51K9LstHj1uvAf+GZiLLgNwEwKifSY+q
 qQxfJMPuqAGbWz5LM1apdkmV7tpIzwFnXJ+oRt5SMN+nJA6Ay/ZX2kfufyu/Y0pl6G7dWEeHKhR
 sLQeb8dq9PiD8Qmeou7SmvqjvOdup1fdqdV+O6Z0kbtRkBDKJBPbtCTgUdH5r1rJktN/358cn/f
 d7YTe/gFZHjevraDlvA==
X-Proofpoint-GUID: 8d9rCxEVwLOiPV0MRj_irEkt-00eLrNg
X-Proofpoint-ORIG-GUID: 8d9rCxEVwLOiPV0MRj_irEkt-00eLrNg
X-Authority-Analysis: v=2.4 cv=PN0/P/qC c=1 sm=1 tr=0 ts=6a06dba0 cx=c_pps
 a=AqWYtYKdvuqIQX7AE/aD9Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=Zd-0kLBvwK3jQgj3KVEA:9 a=BAfDBREGeGVk2RqI:21 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150086
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 15 May 2026 08:39:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3995

Support to display local.conf,auto.conf,site.conf, toolcfg.conf on error
report web, if the genreated error report not contains these
configuations, set them to "" by default, and nothing will displayed.
if they are set, configurations will be displayed like:

Similar errors:
    1
Local Conf:
    INHERIT += "report-error"
Site Conf:
    DL_DIR ?= "/bitbake-setup/bitbake-builds/.bitbake-setup-downloads"
    SSTATE_DIR ?= "/bitbake-setup/bitbake-builds/.sstate-cache"
    BB_HASHSERVE_DB_DIR ?= "${SSTATE_DIR}"
Toolcfg Conf:
    OE_FRAGMENTS += "distro/poky machine/qemux86-64"

Releted oe commits:
7adf9707c0 report-error.bbclass: add local.conf/auto.conf into error report [master]
e3342d6d73 report-error.bbclass: add site.conf/toolcfg.conf into error report [maillist]

[YOCTO #13252]

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 ...ild_local_conf_build_site_conf_and_more.py | 33 +++++++++++++++++++
 Post/models.py                                |  4 +++
 Post/parser.py                                |  7 +++-
 Post/test.py                                  |  4 +++
 templates/error-details.html                  | 20 +++++++++++
 test-data/test-payload.json                   |  8 +++--
 6 files changed, 73 insertions(+), 3 deletions(-)
 create mode 100644 Post/migrations/0010_build_auto_conf_build_local_conf_build_site_conf_and_more.py

diff --git a/Post/migrations/0010_build_auto_conf_build_local_conf_build_site_conf_and_more.py b/Post/migrations/0010_build_auto_conf_build_local_conf_build_site_conf_and_more.py
new file mode 100644
index 0000000..f2ddfb8
--- /dev/null
+++ b/Post/migrations/0010_build_auto_conf_build_local_conf_build_site_conf_and_more.py
@@ -0,0 +1,33 @@
+# Generated by Django 4.2.30 on 2026-05-15 07:47
+
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('Post', '0009_build_idx_date'),
+    ]
+
+    operations = [
+        migrations.AddField(
+            model_name='build',
+            name='AUTO_CONF',
+            field=models.TextField(default='', max_length=5242880),
+        ),
+        migrations.AddField(
+            model_name='build',
+            name='LOCAL_CONF',
+            field=models.TextField(default='', max_length=5242880),
+        ),
+        migrations.AddField(
+            model_name='build',
+            name='SITE_CONF',
+            field=models.TextField(default='', max_length=5242880),
+        ),
+        migrations.AddField(
+            model_name='build',
+            name='TOOLCFG_CONF',
+            field=models.TextField(default='', max_length=5242880),
+        ),
+    ]
diff --git a/Post/models.py b/Post/models.py
index 541f394..01c5271 100644
--- a/Post/models.py
+++ b/Post/models.py
@@ -47,6 +47,10 @@ class Build(models.Model):
     LINK_BACK = models.TextField(max_length=300, blank=True, null=True)
     ERROR_TYPE = models.CharField(max_length=20, choices=ERROR_TYPE_CHOICES,
                                   default=ErrorType.RECIPE)
+    LOCAL_CONF = models.TextField(max_length=int(settings.MAX_UPLOAD_SIZE), default="")
+    AUTO_CONF = models.TextField(max_length=int(settings.MAX_UPLOAD_SIZE), default="")
+    SITE_CONF = models.TextField(max_length=int(settings.MAX_UPLOAD_SIZE), default="")
+    TOOLCFG_CONF = models.TextField(max_length=int(settings.MAX_UPLOAD_SIZE), default="")
 
     class Meta:
         indexes = [
diff --git a/Post/parser.py b/Post/parser.py
index 08f471d..7b6df06 100644
--- a/Post/parser.py
+++ b/Post/parser.py
@@ -50,7 +50,12 @@ class Parser:
             b.EMAIL = str(jsondata['email'])
             b.LINK_BACK = jsondata.get("link_back", None)
             b.ERROR_TYPE = jsondata.get("error_type", ErrorType.RECIPE)
-
+            
+            b.LOCAL_CONF = str(jsondata.get('local_conf', ""))
+            b.AUTO_CONF = str(jsondata.get('auto_conf', ""))
+            b.SITE_CONF = str(jsondata.get('site_conf', ""))
+            b.TOOLCFG_CONF = str(jsondata.get('toolcfg_conf', ""))
+            
             # Extract the branch and commit
             g = re.match(r'(.*): (.*)', jsondata['branch_commit'])
 
diff --git a/Post/test.py b/Post/test.py
index 5acb68e..82316ff 100755
--- a/Post/test.py
+++ b/Post/test.py
@@ -46,6 +46,10 @@ def compare_db_obj_with_payload(self, bf_object):
     self.assertEqual(bf_object.BUILD.NAME == str(payload['username']), True)
     self.assertEqual(bf_object.BUILD.EMAIL == str(payload['email']), True)
     self.assertEqual(bf_object.BUILD.LINK_BACK == payload.get("link_back", None), True)
+    self.assertEqual(bf_object.BUILD.LOCAL_CONF == payload.get("local_conf", None), True)
+    self.assertEqual(bf_object.BUILD.AUTO_CONF == payload.get("auto_conf", None), True)
+    self.assertEqual(bf_object.BUILD.SITE_CONF == payload.get("site_conf", None), True)
+    self.assertEqual(bf_object.BUILD.TOOLCFG_CONF == payload.get("toolcfg_conf", None), True)
 
     g = re.match(r'(.*): (.*)', payload['branch_commit'])
 
diff --git a/templates/error-details.html b/templates/error-details.html
index 35bf0aa..7f8bda2 100644
--- a/templates/error-details.html
+++ b/templates/error-details.html
@@ -81,6 +81,26 @@
           {% endwith %}
         </dd>
 
+        {% if detail.BUILD.LOCAL_CONF != "" %}
+        <dt></a>Local Conf:</dt>
+        <dd style="white-space: pre-wrap;">{{ detail.BUILD.LOCAL_CONF }}</dd>
+        {% endif %}
+
+        {% if detail.BUILD.AUTO_CONF != "" %}
+        <dt></a>Auto Conf:</dt>
+        <dd style="white-space: pre-wrap;">{{ detail.BUILD.AUTO_CONF }}</dd>
+        {% endif %}
+
+        {% if detail.BUILD.SITE_CONF != "" %}
+        <dt></a>Site Conf:</dt>
+        <dd style="white-space: pre-wrap;">{{ detail.BUILD.SITE_CONF }}</dd>
+        {% endif %}
+
+        {% if detail.BUILD.TOOLCFG_CONF != "" %}
+        <dt></a>Toolcfg Conf:</dt>
+        <dd style="white-space: pre-wrap;">{{ detail.BUILD.TOOLCFG_CONF }}</dd>
+        {% endif %}
+
       </dl>
       <div>
         <a class="btn btn-block" target="_blank" href="{{bugzilla_url}}/enter_bug.cgi?classification=__all" >Open a bug</a>
diff --git a/test-data/test-payload.json b/test-data/test-payload.json
index 0428a16..c712d20 100644
--- a/test-data/test-payload.json
+++ b/test-data/test-payload.json
@@ -1,4 +1,5 @@
 {
+    "auto_conf": "",
     "branch_commit": "(master-test): 736b49449233c936e3099b314a58e91ad17f9774", 
     "build_sys": "x86_64-linux", 
     "component": "base-passwd", 
@@ -11,8 +12,11 @@
             "package": "base-passwd-3.5.29-r0", 
             "task": "do_install"
         }
-    ], 
+    ],
+    "local_conf": "",
     "machine": "qemux86", 
     "nativelsb": "Ubuntu-14.04", 
-    "target_sys": "i586-poky-linux"
+    "site_conf": "",
+    "target_sys": "i586-poky-linux",
+    "toolcfg_conf":""
 }
-- 
2.34.1


