Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8A6C282DE
	for <webhook@archiver.kernel.org>; Mon, 10 Mar 2025 05:52:35 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.31059.1741585947661154485
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 09 Mar 2025 22:52:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=5164a3b284=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A4qSB2000674;
	Mon, 10 Mar 2025 05:52:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 458cv8sntd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 05:52:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5YI1CcyMa82YYakM876G9tSgNTAxfLqik1AfpVLE+gNVTAo6cqQptemZIM6uS4bUnWsEJsWahOkhSb6Ic8JR9P0Q20dPdZJZBFAaXM1EyxawfgwR3rgcj3EYgPY5y0Rcbx7sax0cBzkFu8LKbExfeXhoH8xUp9HrDzq10EyEhv9Z8ZpLDB6KWzQUl59ajZPqsBn07ljz3rhDexHQp/EZbLjiu6n2N2njdOSNRFoUSKtiJbKR8AfdS3/Jozh7IXN0pFs9JIsPZ1BHLiqJy44UcSklYGKLil8ye8YI5m98p8RiHipnz5uYhx4up9u5zXPpcix5ZES1d3GyT9WuAEhRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vt7s6OzLKUEyDnOmaXW2WcM/8rKYD5wbRLG4zJyRlMI=;
 b=M4uxK0giH7470yB63M8AHoJxJ/vzd7RN9kPMHk+uSXo8OTwHzjkK2XNf0Dw50zYcjowHfzD9wGfEmTqp33/qxhsou1ypypUUYlhGMBGv4NAFEqJ2nVX/jpnqN+tzEvzajlXZFBdi+T13kTaG0xSbXcgod7E7qsn+ZA3f5nZzGaX4nKJsK122bnOmcz2MdocdOVk+nJvjTQpDuUd/MRTRltj/AgT+uMuO3k53ABEunwgPOrmMl49cmGLHtFuU5kZ6bZEtF5SkQQsfE0Wfv0uFwVsf4df9B1bvcEPKzmtLjyYYeB+mfZ4ety2kr2eSoZV/oyDRt5YhHcLT0F7lhYdF5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 BL4PR11MB8869.namprd11.prod.outlook.com (2603:10b6:208:5a8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 05:52:24 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%5]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 05:52:24 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, joe@deserted.net,
        joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH] selinux: upgrade 3.8 -> 3.8.1
Date: Mon, 10 Mar 2025 13:52:02 +0800
Message-Id: <20250310055202.3156487-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|BL4PR11MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a2e9c2-a339-4944-0085-08dd5f97bb35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+7HSXVP7RZuNqzh+SFh8QSRZrwcx8rXy6l0qPNhcUwfC4XEzrisbVnwcXTV0?=
 =?us-ascii?Q?FBnpQ4HPjQVAfTFjBssO6EQyB/kGEKnKoQB3keaD9SkNQXEw8zvz2sUX8CCE?=
 =?us-ascii?Q?5Dl7Bm4S8Z47eEXEhXVgB9SR6uZ7dDv4qDeYraw4ntEtBIJ7PdG1NQtnZV2r?=
 =?us-ascii?Q?mblVgV4HA8iQWLCV3r03EVlm2pBepD3efgaNo1aXJu3MMKzOK7g1M301L6IR?=
 =?us-ascii?Q?OAs2n2W93rveBz7uHrtYe/j28BbeoUPe32dRyzKcTqTaJbUD+g9Rg1naDQNa?=
 =?us-ascii?Q?n9MZQhPsuA1Pva0dTk5uWE1bYzNnv6zE4rVuDHIhgkuB3N2dEfzoN7ABe1DO?=
 =?us-ascii?Q?IpkmfSta+oXuqt6X3ANGS2f/vyEL4nwULvo6R8q44EV6M0XDi9zjE+VaGbwa?=
 =?us-ascii?Q?29DAnZrikpGJb5wAkeXB3vO3kO3o5HKCPzjwcz4Uv3UdgD6Cj8m6+bxLesHW?=
 =?us-ascii?Q?vImUBwp8PDpeSS1rLxGQpschFbrWGQoozG3EO1NLSwIm5FNhaepQc+RdGXwk?=
 =?us-ascii?Q?QZK/PIa6KmST3JB2jr5dtlJdqY0gZEIb+8yIcRmf4o8KBT2MxEbpkMKYJFn5?=
 =?us-ascii?Q?kAT5p2moLyH+yMa+d6L8p77a+lAyNiptNiwCU5L0TIzSN3fwCF0dlHq8pb+J?=
 =?us-ascii?Q?mxUCUCkSy/LCiR4y9UJW7j3/vp2kvLAYmEIMLaA6i9mzFAz8TsOmY1r03qCm?=
 =?us-ascii?Q?NWlVGZxPWXfaAj4T839w9YgNulUcaMeMPZiBGoUkO2H0r3s7laU9l7ijntcr?=
 =?us-ascii?Q?Hr3DN7ePANcZ/t9BW/pQlHazi7PjGOR1/IdusxrNdWSrkyJN0AGBL/HD4YDZ?=
 =?us-ascii?Q?Huzlx+Z4rOcYeJhU35RdQqYghM/yGjCKlpaTPqrXc5O2gvW5evgHgQOEF/HQ?=
 =?us-ascii?Q?CobQbVEvEGlEyFKR6Ah2UbYRW9G4p7N5brLpeRKKwSalhPIu1jT+KoPeFJWi?=
 =?us-ascii?Q?byyd3TzqR/kkAXA14F1x3HQNBfRn+7VF2bpUEphLr4G6zqx7CG0RKFJrxY5w?=
 =?us-ascii?Q?F9PMUpMu2nzP9NS1GMNI+0yx4czsY+gxE1Q8kgfb9y8Bkz0W04T9bnKX07Jg?=
 =?us-ascii?Q?u6bg+w9G7QCUeVJWRDzGr4vDcwXZEIMnB0ZIDU2mzmSgY8kmeBrBvHYu7kNB?=
 =?us-ascii?Q?eW/tCFhnICW6acV7AP4HId8hws9pAxQwYdqsPuyR5RuZIrLoK5dTtePwEonw?=
 =?us-ascii?Q?EGgn1uQzcg3J4JaJouF4cKW7K3GZaYkHii/0R7Ysn2xZYyukDfXvZuiF6GPA?=
 =?us-ascii?Q?uQGyLLgheIXwP/bnPQ9PnN/DZL2EvEttJmjp19Wt40GUjakLHN3YoyqgbPGl?=
 =?us-ascii?Q?TRrqH1ppuMOUObfXUqOYJShesYF0X31QWQgwpkZpj5YrcOjzM4SqKa313zy/?=
 =?us-ascii?Q?wIogePAJQlB8LB4+PuctFZ2+sWXutsTR4pZU9K1yXdSILiNAu6+WcnUcguUi?=
 =?us-ascii?Q?jSC4dtYBQecbnk/UY1ZM8lAdcKU12XOgu60rTUt3PEobnPnc6kIVAQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?EHDH9KodrCEAjgLc4ISU1WihsLKphb6rXuq/9CVLKoipXIm5xrip+exDNU3n?=
 =?us-ascii?Q?Q4eQsS4jKqg33pJbVjC5rEdIGYzs5R/gg1s6lHdZaHmRzSwg1GbJjETm5GD5?=
 =?us-ascii?Q?DNG22krDsF2JRRLM9/Z6Yo7P2V76ozyuAf1F3okDX/2511bF0Pd1H4jin36h?=
 =?us-ascii?Q?05HZQfA6dNo6lzADIIiPWgApu/AfMWPt9kbItVLP4Ndyb5x+GgA4kwm1fORQ?=
 =?us-ascii?Q?vHDKGg5SBCQcb0OSIfPudeWhgjkJSJ8g9HJvRHEkSmTADJMq7KirerWOaWvo?=
 =?us-ascii?Q?zfFLwvQHlzlNVxkW4ZLrH2z3x54733Go27aoFlgyJ11kBTuBqRZYbauR+3PZ?=
 =?us-ascii?Q?/joWq+hxBCOXMSLmxRohJrjXpQgKNX6Cd97uysGAmHu0f1bA9FRLPCpd8jos?=
 =?us-ascii?Q?/LBHjXbbInnFJgOREFEtQAlYFoC7fCdC1PItvRoWA5dDzvUEZRtYmMDmjFdw?=
 =?us-ascii?Q?7wlHkddWbiVejh36QkLkhCWc951eErkoH+ihsYTNP6kFoVr5eHiTwi9XP9N5?=
 =?us-ascii?Q?1OI1Wq2gXlQxzy2OtWTXQWnohBjgpOvRINnOnGwic133g5hqy1Kh9P9SaXXR?=
 =?us-ascii?Q?vL/nJq3vkREVeMs2PKNr8FfesD1Gb7H7iFdm8rP91YcB5yhQq7k2/JAXszOr?=
 =?us-ascii?Q?nFAUof5iOfrYxop3/CWQo4Ql/t7/BYWjvj55Bz6qxiglfHFSJgwjSWFprAdY?=
 =?us-ascii?Q?CTACFQod2HZORN/7GtIjpfe0JPwwthBa0+MQCmYtjCb8AZeMJBFQShsj9HXg?=
 =?us-ascii?Q?Yl23o7ISihG4g6/lESfi33yK2LFV0vwxoR9mP7mLuF+CCvT2RztiG7x6euBt?=
 =?us-ascii?Q?8O7MAKw95F3kijkuib7nZTMMtvVbwAfRF/zdJCqUnEKeBqHsaSYrOaggZ/+Q?=
 =?us-ascii?Q?IX+BgJIuZ/5bieY5hKsSa3MSA4lvtwhyGgbjuTbCdVPNhNUG9vH9AAOpxhsr?=
 =?us-ascii?Q?FLtBP5JAw9/KiLqITHArTRxZ0OfaQievNAmgMKmPmzNAvL0faDxW02jQLLu6?=
 =?us-ascii?Q?xZjAdEHXv2k0jWBhwqqqC3dy3tj7DccD3xh4fJI7VWD3Ykj0qGgALLoNV8Vz?=
 =?us-ascii?Q?fdEQIIf/G42wJDd/XZ3XNaJNd0Nuph/m/vcbpeyrq+kgnoX2QCMfUyo+rm2o?=
 =?us-ascii?Q?L2V92Jc6Mvo3fwNTg2AVIP+C/kknplqdBil7VkFGte8oEii2H+TqhoGxLTLx?=
 =?us-ascii?Q?w1uouZYqWHczTwm4Iah66Ma6NZFAB+fDit2bhtDOaAgdy2a6jmtxKuKxGT3V?=
 =?us-ascii?Q?t7DbccL1ab4gPk53BimSeeO7X+kNlW8gc0WSXSNK4ud9G9hcF6FLUr7nyjIR?=
 =?us-ascii?Q?1Dqjc6zGvCcyV6H+qblImgGj4F7phtPed1V0MlaDO9tllnvnwyaEgJvekix5?=
 =?us-ascii?Q?CIhvEeNZXeI3IjBbqSQIgd4sordsL6HZ0HC1JEC0A6dlfIYUYhPw57Y7WJZJ?=
 =?us-ascii?Q?iYHss8v30RDd5+70Ea1dH3UVwoVIncA7WgFvGd0jnkW8l9gGyt7k53IpOSLF?=
 =?us-ascii?Q?/NofCSuQ60ZkbpoKbszhyXGiMLTm8SYPNZ07GXIQy/cIfDYm+9BMBEDY59Ej?=
 =?us-ascii?Q?gSdCW/ZI/YVPkf02nVB0XO3o+YSGmcoaVyM6HrKW?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a2e9c2-a339-4944-0085-08dd5f97bb35
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 05:52:24.3665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E82s2it6QEaING2MDhfegM10vIyqRwtcJcULXsqUE+qbSXekRBDtqYiRY04pAGaCML2OjR/+OshaT2BPO2WFSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8869
X-Proofpoint-ORIG-GUID: QHDh99BWqE9-gh7zNGNJ31BvkUY1Z5xy
X-Authority-Analysis: v=2.4 cv=QbKcvtbv c=1 sm=1 tr=0 ts=67ce7e19 cx=c_pps a=rPWB9DPlu1VaKM/QD/CSBg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8 a=-CPpxitb5mH_PxBw8qIA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: QHDh99BWqE9-gh7zNGNJ31BvkUY1Z5xy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_02,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2502100000 definitions=main-2503100044
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Mar 2025 05:52:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1170

ChangeLog:
https://github.com/SELinuxProject/selinux/releases/tag/3.8.1

* libsemanage: improved performance of semanage store rebuild

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../selinux/{checkpolicy_3.8.bb => checkpolicy_3.8.1.bb}        | 0
 .../{libselinux-python_3.8.bb => libselinux-python_3.8.1.bb}    | 0
 .../selinux/{libselinux_3.8.bb => libselinux_3.8.1.bb}          | 0
 .../selinux/{libsemanage_3.8.bb => libsemanage_3.8.1.bb}        | 0
 recipes-security/selinux/{libsepol_3.8.bb => libsepol_3.8.1.bb} | 0
 recipes-security/selinux/{mcstrans_3.8.bb => mcstrans_3.8.1.bb} | 0
 .../{policycoreutils_3.8.bb => policycoreutils_3.8.1.bb}        | 0
 .../selinux/{restorecond_3.8.bb => restorecond_3.8.1.bb}        | 0
 recipes-security/selinux/{secilc_3.8.bb => secilc_3.8.1.bb}     | 0
 .../selinux/{selinux-dbus_3.8.bb => selinux-dbus_3.8.1.bb}      | 0
 .../selinux/{selinux-gui_3.8.bb => selinux-gui_3.8.1.bb}        | 0
 .../selinux/{selinux-python_3.8.bb => selinux-python_3.8.1.bb}  | 0
 .../{selinux-sandbox_3.8.bb => selinux-sandbox_3.8.1.bb}        | 0
 recipes-security/selinux/selinux_common.inc                     | 2 +-
 .../selinux/{semodule-utils_3.8.bb => semodule-utils_3.8.1.bb}  | 0
 15 files changed, 1 insertion(+), 1 deletion(-)
 rename recipes-security/selinux/{checkpolicy_3.8.bb => checkpolicy_3.8.1.bb} (100%)
 rename recipes-security/selinux/{libselinux-python_3.8.bb => libselinux-python_3.8.1.bb} (100%)
 rename recipes-security/selinux/{libselinux_3.8.bb => libselinux_3.8.1.bb} (100%)
 rename recipes-security/selinux/{libsemanage_3.8.bb => libsemanage_3.8.1.bb} (100%)
 rename recipes-security/selinux/{libsepol_3.8.bb => libsepol_3.8.1.bb} (100%)
 rename recipes-security/selinux/{mcstrans_3.8.bb => mcstrans_3.8.1.bb} (100%)
 rename recipes-security/selinux/{policycoreutils_3.8.bb => policycoreutils_3.8.1.bb} (100%)
 rename recipes-security/selinux/{restorecond_3.8.bb => restorecond_3.8.1.bb} (100%)
 rename recipes-security/selinux/{secilc_3.8.bb => secilc_3.8.1.bb} (100%)
 rename recipes-security/selinux/{selinux-dbus_3.8.bb => selinux-dbus_3.8.1.bb} (100%)
 rename recipes-security/selinux/{selinux-gui_3.8.bb => selinux-gui_3.8.1.bb} (100%)
 rename recipes-security/selinux/{selinux-python_3.8.bb => selinux-python_3.8.1.bb} (100%)
 rename recipes-security/selinux/{selinux-sandbox_3.8.bb => selinux-sandbox_3.8.1.bb} (100%)
 rename recipes-security/selinux/{semodule-utils_3.8.bb => semodule-utils_3.8.1.bb} (100%)

diff --git a/recipes-security/selinux/checkpolicy_3.8.bb b/recipes-security/selinux/checkpolicy_3.8.1.bb
similarity index 100%
rename from recipes-security/selinux/checkpolicy_3.8.bb
rename to recipes-security/selinux/checkpolicy_3.8.1.bb
diff --git a/recipes-security/selinux/libselinux-python_3.8.bb b/recipes-security/selinux/libselinux-python_3.8.1.bb
similarity index 100%
rename from recipes-security/selinux/libselinux-python_3.8.bb
rename to recipes-security/selinux/libselinux-python_3.8.1.bb
diff --git a/recipes-security/selinux/libselinux_3.8.bb b/recipes-security/selinux/libselinux_3.8.1.bb
similarity index 100%
rename from recipes-security/selinux/libselinux_3.8.bb
rename to recipes-security/selinux/libselinux_3.8.1.bb
diff --git a/recipes-security/selinux/libsemanage_3.8.bb b/recipes-security/selinux/libsemanage_3.8.1.bb
similarity index 100%
rename from recipes-security/selinux/libsemanage_3.8.bb
rename to recipes-security/selinux/libsemanage_3.8.1.bb
diff --git a/recipes-security/selinux/libsepol_3.8.bb b/recipes-security/selinux/libsepol_3.8.1.bb
similarity index 100%
rename from recipes-security/selinux/libsepol_3.8.bb
rename to recipes-security/selinux/libsepol_3.8.1.bb
diff --git a/recipes-security/selinux/mcstrans_3.8.bb b/recipes-security/selinux/mcstrans_3.8.1.bb
similarity index 100%
rename from recipes-security/selinux/mcstrans_3.8.bb
rename to recipes-security/selinux/mcstrans_3.8.1.bb
diff --git a/recipes-security/selinux/policycoreutils_3.8.bb b/recipes-security/selinux/policycoreutils_3.8.1.bb
similarity index 100%
rename from recipes-security/selinux/policycoreutils_3.8.bb
rename to recipes-security/selinux/policycoreutils_3.8.1.bb
diff --git a/recipes-security/selinux/restorecond_3.8.bb b/recipes-security/selinux/restorecond_3.8.1.bb
similarity index 100%
rename from recipes-security/selinux/restorecond_3.8.bb
rename to recipes-security/selinux/restorecond_3.8.1.bb
diff --git a/recipes-security/selinux/secilc_3.8.bb b/recipes-security/selinux/secilc_3.8.1.bb
similarity index 100%
rename from recipes-security/selinux/secilc_3.8.bb
rename to recipes-security/selinux/secilc_3.8.1.bb
diff --git a/recipes-security/selinux/selinux-dbus_3.8.bb b/recipes-security/selinux/selinux-dbus_3.8.1.bb
similarity index 100%
rename from recipes-security/selinux/selinux-dbus_3.8.bb
rename to recipes-security/selinux/selinux-dbus_3.8.1.bb
diff --git a/recipes-security/selinux/selinux-gui_3.8.bb b/recipes-security/selinux/selinux-gui_3.8.1.bb
similarity index 100%
rename from recipes-security/selinux/selinux-gui_3.8.bb
rename to recipes-security/selinux/selinux-gui_3.8.1.bb
diff --git a/recipes-security/selinux/selinux-python_3.8.bb b/recipes-security/selinux/selinux-python_3.8.1.bb
similarity index 100%
rename from recipes-security/selinux/selinux-python_3.8.bb
rename to recipes-security/selinux/selinux-python_3.8.1.bb
diff --git a/recipes-security/selinux/selinux-sandbox_3.8.bb b/recipes-security/selinux/selinux-sandbox_3.8.1.bb
similarity index 100%
rename from recipes-security/selinux/selinux-sandbox_3.8.bb
rename to recipes-security/selinux/selinux-sandbox_3.8.1.bb
diff --git a/recipes-security/selinux/selinux_common.inc b/recipes-security/selinux/selinux_common.inc
index 30109b9..63b048b 100644
--- a/recipes-security/selinux/selinux_common.inc
+++ b/recipes-security/selinux/selinux_common.inc
@@ -1,7 +1,7 @@
 HOMEPAGE = "https://github.com/SELinuxProject"
 
 SRC_URI = "git://github.com/SELinuxProject/selinux.git;branch=main;protocol=https"
-SRCREV = "71aec30d068789e856e7cc429b620ae1cfa890f1"
+SRCREV = "8e9157bbeea1899b7b8b257e7eaa71efef3fffed"
 
 UPSTREAM_CHECK_GITTAGREGEX = "(?P<pver>\d+(\.\d+)+)"
 
diff --git a/recipes-security/selinux/semodule-utils_3.8.bb b/recipes-security/selinux/semodule-utils_3.8.1.bb
similarity index 100%
rename from recipes-security/selinux/semodule-utils_3.8.bb
rename to recipes-security/selinux/semodule-utils_3.8.1.bb
-- 
2.25.1


