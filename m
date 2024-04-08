Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0F0CD128A
	for <webhook@archiver.kernel.org>; Mon,  8 Apr 2024 05:19:20 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.99467.1712553558423223045
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 07 Apr 2024 22:19:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=gTD4Vsys;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=482879bfaa=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4384splc020849;
	Sun, 7 Apr 2024 22:19:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=5q9bAGOqFNMMcokYnu
	vjq7eCUEzz74r84UrhEt2YpcM=; b=gTD4VsysqDo60F6COUzSyCS+WBfl4ZawtR
	r0mE91RQ5JRxtHemBOB87A/+x+e8fDt5KhhfyOAWPG3XJ4MbV0SkIFmYrH3KSYse
	hwY1Xu4b0v8T7GHM2uIN6GSo6W6/OFwwHS0ECtNxvtl2v78YMdmnlsHCXWk/n6RU
	uXeI3SX8/Kdia9/M9lg9BURttgDdJbqbOrNOknN3Nkumdbo80xMujgRJMdYBRdzq
	LCqthgIeKyJlWhS57sUbHvWdNK/XEtvB5//G/fK14ZGxpdqwnGQWELQ+DLDQ/L7E
	79u2S/KN+kR3r7oJob+RCo90YMcs0g8NaJg23H0WwWGjTAfDiglA==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xb1p0988n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Apr 2024 22:19:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPPVJgSfRBG3G2HRMRNqp6X04478oVekwfe+70V3A1fqPrf0knkTixz6JdXLHbagTsZt7/be4XeFSEaGQpGhLO8HA93wkbwEZa6Y0f/GglbUtoFkQp3LQ5iVzGr0nTv8P3zps0TNbjAEPTBhNKsqxyy/pBfjnmdDOmE+nnBdaf1L+ALrNC1rCR8/a8iqEaF68zR2BRKTUiamRWGDhrxPksSfbw6ucVzYNU15/9hRdP8iEz4VL7llydhVIrDvdcEIBETVcBpHO9O8i9uzjfiNDBQAhJJtEs4MgD50Ifsu14LiateG1nhiuVmulCoYVXkyuQuwvUF8xw8CViFYjCFSsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5q9bAGOqFNMMcokYnuvjq7eCUEzz74r84UrhEt2YpcM=;
 b=mAD6NS3cRniI5QpF00OCqYrxB52c/Tw9SJfvFeG7lhY0SGweUxK2JITPQoMvDYJxrkFe0tAoPFqMaMRxARnO8d138Bf3GhuAXL5HiXYxQri+zmjc58Cw9qCHyO0vjLSu+NQAsWH5cgI25TnPDEzFXZzWPH6R6cC7lZidVcTetzC9NEpIAP25n+kphgurcSJPJmvCPh7DkSN+jyYPu8LOSavMeIFfv43FqNLryDrjmtof4K3qibGkkcajbnyGybQ//1lnZq3CKnUtwwZ6evxI8s3XZCkZRDbGb4bDokXwPkjNoeVSRDxz9gCJqdLDbJH+0REIXH6qXbK/yLvvECNbUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7484.namprd11.prod.outlook.com (2603:10b6:8:14c::10)
 by PH7PR11MB8502.namprd11.prod.outlook.com (2603:10b6:510:30c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Mon, 8 Apr
 2024 05:19:14 +0000
Received: from DS0PR11MB7484.namprd11.prod.outlook.com
 ([fe80::97da:833f:8511:a558]) by DS0PR11MB7484.namprd11.prod.outlook.com
 ([fe80::97da:833f:8511:a558%6]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 05:19:14 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, joe.macdonald@siemens.com,
        joe_macdonald@mentor.com, joe@deserted.net
Subject: [meta-selinux][PATCH] refpolicy: update to latest git rev
Date: Mon,  8 Apr 2024 13:19:02 +0800
Message-ID: <20240408051902.189739-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To DS0PR11MB7484.namprd11.prod.outlook.com
 (2603:10b6:8:14c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7484:EE_|PH7PR11MB8502:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	T5dG4kvXSjzCsVDVR1FWb+fZ4dqCTxTWrTjbaVdXINk8A+KiqoMIn0cZl5/GzuTlfcXEdaWo34umVSPczZHxn7uTfijOyHfkrsmDGIefwFoYCvjMCXt9sIzrRVnTJLCzXoueUGJnHXYZEQhhXGbWXm2GMm3wULB+hg2dZ441LKCBJR1/mIUlqwdxwLeLhJsqX9wKuR39Bvi12sHX5+ZALn2v8Gjk5XpgHiVK9r1QxUBkz1pku/Nj8n4b6T1CwidB4ihcdHOOdJHN3K4UVVYtzeIV5AZSO+jO81F1o/OMvhDQV172IYP8Tj0aUXY0EaEKpZixalJQ+7xjVEvA/xp3uNli139YS0rxw9IpMJXKljRxzt1aIVrXsXoJkn88Zl6GYYhkTzRRleW79iAduk9xcRlCLyWdYuY6g0PvwYdRDsnuiWohcDRx+zD2ipjxbprTppgRkNll9LeZz9ZRd8YcsAShavo0ygord+k8qdmyWJb7Opd57nb52QlmSwnXraPj6gyJFjgEZhIb70NoeTuQRT8BPOuqSxBcPtIEV+VM8taAg7SiLF+Depr26a35dw9zUT2GgSJ4KdnWS/a9PpFuZqyq3wygLHR0kkX2boqLgG4/xv4kGHBio8Pem89LNHBdA9ZWvwe2irIJ/ZIO3Ec2jedviJ4JsoFP1DbZuxfdDyglF5lVcXGuTbmoPhfIUj1az2+dPfbTEls96zsDl34QAo2FI1BrIbqM/jiPflpCFUw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wYEP5C/NIq9NSEUdCBaB1NCstDbSBO9vW2c/d8dNbxc8THsd7dnFbvqgH5xF?=
 =?us-ascii?Q?IoF9L7S6on7uFtAWU3JU8x16bL9tt3uPP8GrSw0DrXt1oItkFeVzEZg9e9xT?=
 =?us-ascii?Q?6qngJu1yD/GMIQ483SfpPE/JtHn/9chSn6a7acJXavyrvUFuC2fciXVJ/unN?=
 =?us-ascii?Q?G620dtlutx0h/w0hB75otjmmM6vdS6NaG3huhbQ2UK+rdJsfbvkE87V8Q8b0?=
 =?us-ascii?Q?QAKOIXra+AdI1FqCa/UJmSWt2sHuw3TbVgvWNYnRSj39AoQu9De5qIiXKuGk?=
 =?us-ascii?Q?nyqTQtk74cPSui5xBhfaXRYfsKoLUAms1mge07sOq+Rh6o4F8XPSWcjYz88s?=
 =?us-ascii?Q?efZkFX9QsDkrB2UTkJcd9x80F6137VtMNvZU3VqDnq2Uc/5Z6V2A/jf297wY?=
 =?us-ascii?Q?BKseUw2SlLChs/pkFFLR9foqpEda6Sjm7LlYQ1cdDIGXTW2PWL1mFBYV843M?=
 =?us-ascii?Q?O0iK8GmymLNH7VdgpA6HYXKah/eIwUOFBT8C0Q+BZ7QlRWZgQfQJlserme36?=
 =?us-ascii?Q?evXwP/JLn/NiZKYV+cwnE5T4jiw2pqdkV0Cn5AQWpyDQC9MFGG5wL+rbv22r?=
 =?us-ascii?Q?jhvz3hb/8xsPAPMPAvTV8Qh0md+Y5NntMUdiJPqW2ImtvG6vgmxK+LEiP0JE?=
 =?us-ascii?Q?DjDfQMaGt2a21ljSatwrSYgvydHc9gjUziu8uHxlsX5Cf/Z+Z1+sQZuNCxY1?=
 =?us-ascii?Q?OFWo4PAPuxYyO/UUpjWjvuMBoFgZ/0tTlmagsvdv5lyxXalJL5ysiQ3P+mYG?=
 =?us-ascii?Q?Vva3ZkRAUu5sK3sX81lbzNExf+yICPk59bfRfFkrWIjStwMSfqgTFeHrEZx1?=
 =?us-ascii?Q?cDCEuHeJExSd+04sUY3PXboypJ9eN1C46+uZdAfvdnnYDF7f02Pl8Ceu9gKu?=
 =?us-ascii?Q?BqWQc4d1sckEjjjN7E/oYkG7QT+8nzdVfGhv/JnOS3DKp46J938P0ObeAqEp?=
 =?us-ascii?Q?gUTZ7EcUB6R7AEZxSh53RpHcrLigUjVQBbHqNmK6ZdLndsjAZLHYS/0iZo+L?=
 =?us-ascii?Q?KpxRYTRvPlGlHMhkfOXUlDu8A0dOC0N7RsnE2Dalu4gwhepIDEutsFYNNqjO?=
 =?us-ascii?Q?sSPa2HCOCchFqVkmq6862qxBr1caDIU6+ynGjXi8BsoAPLbfY+6b0a3DWAfj?=
 =?us-ascii?Q?Y2PkE+R7ldlVtiuXG9CMlO9JjejrcCzgQrnACbunBjiGw+seKjsNwhpjSO7b?=
 =?us-ascii?Q?O7E8iNxyJgxfo6tiaSa+Z63zeZrJOVk8lG8NUfcz2wrVSSNaEdF7Dzwe8ET1?=
 =?us-ascii?Q?aNNz5D8FhxFoKV22i9zJR2zm8H/GRkJUMbpk+01KzGWdq8ZHt2xSqdodhFx2?=
 =?us-ascii?Q?b8V+weinnxWT3ylctVUqGFLjgmEbRfkcJqp1+hOvcjciwLJ08MgULWHN9LU/?=
 =?us-ascii?Q?KweMRzrNaPLuIVQq7cg4ukgYajx7OUuL6BkcA541To2G2GlbFpbYNV+E/ZTK?=
 =?us-ascii?Q?vARWc8zt6hUy7u36FuVDKl/F6oRKghGyFyrrbqC1wZrLt6DEZvWlqw1LCu5p?=
 =?us-ascii?Q?lo0dyHTItNHO6m+NawS9tjdVN2/3plympPOGl1dlQZXbzHYhZcrPsVkFXcwG?=
 =?us-ascii?Q?bqmKTADsDJxqzWmXbyeoDqyeT6V1BsqZg0rW/Joz?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8381f1a-47af-4013-ed93-08dc578b6e44
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 05:19:14.5098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7p5tbBE1xQ6dQ9NtM7ZgUK3MK+JTfGS8jvGqjBiHmv0omi04K6t/qP0m9tcn7hWdQbfp5Tscy9d7QqoLpZUIKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8502
X-Proofpoint-ORIG-GUID: 82Fe1dlJXC4ph5hw0nvliaK536CQ-8yj
X-Proofpoint-GUID: 82Fe1dlJXC4ph5hw0nvliaK536CQ-8yj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_03,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=728 spamscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080038
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 08 Apr 2024 05:19:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/12
Message-ID: <20240408051902.cnomKG4jVvyr3ZG62Hlk41FXrLTpkqha0YN6au2dU-8@z>

* 0aff1990e quote: read localization
* ab13c0421 getty: grant checkpoint_restore
* 3643773ae Update SOS report to work on RHEL9
* 523b279bd Setup domain for dbus selinux interface

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-security/refpolicy/refpolicy_git.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
index e13fc96..322c277 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -2,7 +2,7 @@ PV = "2.20240226+git"
 
 SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
 
-SRCREV_refpolicy ?= "fa84ee8fc04af56cced5ab8ed7abfb1abbd246dc"
+SRCREV_refpolicy ?= "6507eebc238b4495b1e0d3baa2bc0bb737f9819a"
 
 UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
 
-- 
2.25.1


