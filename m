Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9455CC4345F
	for <webhook@archiver.kernel.org>; Sat, 13 Apr 2024 13:25:48 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.11739.1713014739338994811
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 13 Apr 2024 06:25:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=OOL9HWdL;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=4833893c89=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43DDN3TE000822
	for <yocto-patches@lists.yoctoproject.org>; Sat, 13 Apr 2024 06:25:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=FL6QPmkYFwg7Fx5/ri
	smDWx/OvNWoLMt6OkXUOXmqIo=; b=OOL9HWdLE/eEAbABc2kIGDW+fkQZPZOE5r
	O4tlKvkf/0OvRnp7HKidHhxvT22rRZusJmk3LFWBTN/Uz2DACeOMYdBFCGxXSy5T
	WO3FwXH/UkBr/2+WKLA5KaYZwIw0HuUr0Zq0RTFMdR/+pdU3hTUAskn1jkF+MB4X
	PqVEQsSANIE1rNyMILJie/2xOwmwIk8DV4rxwWRv49WcYDYnByZuRtPQsXEUzhgO
	KBmHTivu0PX9rHOxoKcjR0xUkAC+Q5dM6BYw6+33WcTyF3Ic+bIU7IKiYIi6e0fu
	wPcd12ZlM1DJ3S3GclN78dWqA+sfxIoqC6uXSdgfE/YUoBMyeJIA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xfsjgr1bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sat, 13 Apr 2024 06:25:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSru2qpPp3kkpog97mBSKSTKJUrqxENzJuX/Tf4ZiPL7rERiHt7X5agA/G4a3dAFn6qQrKb0kS+czRmqL6fk8DU5tLov4wNkGGBFivmIALQ/VVj7KBatwp3vnLHqPrRqHvTG1M9aMBI0UGAfzO2VkFOt7FNpDGQ4wHiqWKaZ/wilBpgMuQUjwTLP/nPy6LdQ+3twCPLJfJgiO3B4YdJSBuD0jvLmaK89ELorEykjd5erwMpfz7b+Yl+nDE77jE8DZmJ7KxlIVwkUz1GVFCUgFwqu2ClF/5fvz1ARngPd5jTeIsdykb9GfVsHpU/ZsS0hRefW4jSRmysYHpqo6G18fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FL6QPmkYFwg7Fx5/rismDWx/OvNWoLMt6OkXUOXmqIo=;
 b=BzH2JYm0Ce3GRIWUj7t52HRS35bj5VkJzquBNmuEMj/WZ8eR0EWndqecbG6i/WjPB+K7wn1s4T2Sy3VbQQqabmRZ4UcqtvSJp1gt5hlrZfbwlP4koLUZ04uh6ZZ1zlqteGRfnGx4V11zCjJTrfbVgP1n3hmfdL96iOxi9OWMOu4QthUVH1CMlcNzZFJw9zqodFtkdQnUryYUjQ10nECvf358QEZhyRZqtqEla+mId5WtutY9vhDXZANRR8CM3aEoQKBqdCcqTOeD82VeT/zxo/taQxS+jP154udVXXsEx3RH3A/UzUFZy62V5K8etJas+yqkfG7IO8junr0AqTW15g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7484.namprd11.prod.outlook.com (2603:10b6:8:14c::10)
 by SJ0PR11MB7156.namprd11.prod.outlook.com (2603:10b6:a03:48d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.29; Sat, 13 Apr
 2024 13:25:36 +0000
Received: from DS0PR11MB7484.namprd11.prod.outlook.com
 ([fe80::97da:833f:8511:a558]) by DS0PR11MB7484.namprd11.prod.outlook.com
 ([fe80::97da:833f:8511:a558%6]) with mapi id 15.20.7452.019; Sat, 13 Apr 2024
 13:25:36 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] ibmswtpm2: upgrade 164-2020-192.1 -> 183-2024-03-27
Date: Sat, 13 Apr 2024 21:25:24 +0800
Message-ID: <20240413132524.1910943-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0122.apcprd03.prod.outlook.com
 (2603:1096:4:91::26) To DS0PR11MB7484.namprd11.prod.outlook.com
 (2603:10b6:8:14c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7484:EE_|SJ0PR11MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: a0455ac6-25ef-406a-3498-08dc5bbd346a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	f9pSJVefj/JUqvSMGJMMZBWh9J2WCHPReLeJSCrSfx97UzTlQHJYg29e/mD5pbWZFaQqDVK0vDm94aI/QQMDNFLDkhUEJ9OVOQmGrK5gKm1R7casCzxaG2e1lQlLwyrMHElbcMEH9CWHs5TKNC+hTV9HgeU83KOlNQJ7Sn11H+jCzUWjuwIT+2BtpTzqldU/cVYwgJ2zPHxMv7+8T3GT47C2pmWuAxo7/qdHkDi9Cly10J4D6u8mcNh7bPTk+T1mOm+OmbaJ/XHc150etkqHg+HM0aoHR/guYP0q255xqFk7metywRvX9zV8q3kmUi1odQrHCHWjr2DHy1eNqyxdrnzX9JiTaLQLy5WgHOXs+w1bTn6CwaMPXHNsg3eMwgne2axPSIpSRbmOJeBn8/CoDVm8/qmmWFCMQKLS6lgEIOqDq5bxsoYnp3aImFi83WNxDN3CWB9pTHp7+ZOOiqne+NZyKwIPTiMDZuI7zeINPNQRnxaSC+zT+C1+YNgQ9Vh05RXMtwxRZ1QESowyd9njW8I1MqMo0sZOvcVOmMo7wcmGxzfZJ9eISBqdbF4MH1aak/33wKlw8NVCntvG/0SEDhduC6RAX7wePF+WYlQxNDlpnlWf2iISQJKCxtixnzmfHdaSQBVoDN/kcfURt/19M396TlUVIFUNtFd2KYRSfvY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OG2YLpBbEDez7PI0XPB2qM61U4ZnbOu6stdQls1hjgvd5rnlZo3dSKwjRKMA?=
 =?us-ascii?Q?lpmYBGiFgUS6SUgcFd/qduAJYXvVaViYIilWASn0yENiQECX13ZBt4wPNDFO?=
 =?us-ascii?Q?0XlIuCKh3PF7O6UkR1GFZ+UONMP/S1JNkF+jtIkc3D2+gq/2jRjAvkQ/IZqC?=
 =?us-ascii?Q?vob/YaSd4b3gjujkXRg8/s9sCO+tncd/GHWMZTs5b5LZhlDcp6RoCcr3/laZ?=
 =?us-ascii?Q?cATniG2KE+JHqHhyPav8FWsJ5mORnNYISGYEYgxMcHmHrX+zXxlm4wkS5xzU?=
 =?us-ascii?Q?gi+LaWTVGY7OE/4Eg8JhzKea6CcL2vocWsFso5YLOHw+MI57Ra8ilTl8WU4e?=
 =?us-ascii?Q?ooUlSIpwIRXAFjKRif66AX4QUAYxKnVcDaNbF7WYAoXkTvCuLUf0HjXDjsiC?=
 =?us-ascii?Q?xlf/b9/eU4FhUFM/kgfhcjxzf9kFug0Y2lfbGmErTfEFE5QK+dwKK5pstQbQ?=
 =?us-ascii?Q?G3GncWHYYB8+lVbJZ+xC//DJZ80jb/H1OMXhUUQc4g1AXCzL9Q4iMX5vjM1k?=
 =?us-ascii?Q?vj+HLxuxoafEYO+5WLiXmrlNZ8ZQ9BjIw288B/duRByAo80/yG4lA/1hE0jg?=
 =?us-ascii?Q?l1cTmU9tvmAZ19HlJ50akspTSMQA4dwgh+3hnb+xPPQuIH9UndusirR8bg/Z?=
 =?us-ascii?Q?XxDN7VtM0bhFwxp37AuFGELXFpppFU21/s8TqFzOAcPvd47R7MS0SkkDrUPM?=
 =?us-ascii?Q?jBxKT/udDIg9ZU+mk0addQvq9xVrnlDyE2u/ntaS6MKpMrOdUeXsYh/itzw4?=
 =?us-ascii?Q?F/eKALcpMDLAbgeNJELICKKbGFICiFMlRuxjH0UoNoByeDCdBtgLu3T+QG+X?=
 =?us-ascii?Q?VkHLsrl+EOJ4e3fFgZwjOOpLB7oBYHUUBiHbIfcGyxwkAtVe7Ry7ytfBsx2w?=
 =?us-ascii?Q?YRErCzzOaeBIEoHTrN5wXJ8kBv5hL7ethaY4HASh810tjittSubVvjf+gc6a?=
 =?us-ascii?Q?PUtR9iE3ZBg+hOHeRtTjAh1IpX38zYNyKMNF6QATTdCfuzs4ip0o4ykLL+iu?=
 =?us-ascii?Q?zmYjEdGfS13KkxGF1DcN8ZL97kqSYL24HyL0PQN0ZNgOYeSFozwFOWM2Ce8Y?=
 =?us-ascii?Q?3JUBK3rvVt+662oe/WnKefs4QoAmomWs84Ux73JQtgWYHjwsekizo49+bDaD?=
 =?us-ascii?Q?uZiiN7q1zsuqMvnCTZUqTfTLyH3aNEl7Q1t/BLu+5N3dkapudsaciGEGXx9R?=
 =?us-ascii?Q?3gklK0LjswD87eFudqnhMtzt7d+LrALlmj8oKaS0VtMS+zqAKINysy/GHLHN?=
 =?us-ascii?Q?HP2iq7SZwxbRdrB5nokCLVRQWYZNncZ4RqLBZwWDbtVuC9Uc0V3NBBKtQyPO?=
 =?us-ascii?Q?lJyQ6fWBhNG0bH47CCs8bw96K1gf5N9mdr+CWebZLagir6hxbP0jgW3lG7xR?=
 =?us-ascii?Q?8KW7RSGRT1FgUYjKpmuu2QoQTvA5WORLRDnhLCcTWqn/fyXBQjYYGXLfTZ1V?=
 =?us-ascii?Q?kO0igZQFjzlrOFv4C169bS7Y8HjH3R4BIZtcimF0r0b2ImoIxVZUT3/SDx63?=
 =?us-ascii?Q?O8/MJL3qGTNKBlccEh0ceqMrIdr8pOGAb+qkK9zqoz3++b2J/CbQnKpGIgtt?=
 =?us-ascii?Q?xeHwNwVuSRsMuMP1es0fA9E485IUNqN+JvOPi9aE?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0455ac6-25ef-406a-3498-08dc5bbd346a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 13:25:36.7811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InKofgv6xjkuUkXU9UTDxXuwuJY62VKp99irxuCGSld9odHScqMuUlalXm/N/Dkj6thloLZ2oZMW5GRxXoV0sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7156
X-Proofpoint-ORIG-GUID: uC_z62se0aFs25zqXQvU23-nIodfSnIM
X-Proofpoint-GUID: uC_z62se0aFs25zqXQvU23-nIodfSnIM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-13_03,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=722 phishscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404130098
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 13 Apr 2024 13:25:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/29
Message-ID: <20240413132524.Vi4ofqxPIVuewt2t3ndrCp-3yhIdN4soan111nrVMRc@z>

Remove '-DALG_CAMELLIA=ALG_NO' from CFLAGS to fix compile error:
| TpmProfile_Common.h:109: error: "ALG_CAMELLIA" redefined [-Werror]
|   109 | #define ALG_CAMELLIA                ALG_YES
|       |

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...swtpm2_164-2020-192.1.bb => ibmswtpm2_183-2024-03-27.bb} | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
 rename meta-tpm/recipes-tpm2/ibmswtpm2/{ibmswtpm2_164-2020-192.1.bb => ibmswtpm2_183-2024-03-27.bb} (86%)

diff --git a/meta-tpm/recipes-tpm2/ibmswtpm2/ibmswtpm2_164-2020-192.1.bb b/meta-tpm/recipes-tpm2/ibmswtpm2/ibmswtpm2_183-2024-03-27.bb
similarity index 86%
rename from meta-tpm/recipes-tpm2/ibmswtpm2/ibmswtpm2_164-2020-192.1.bb
rename to meta-tpm/recipes-tpm2/ibmswtpm2/ibmswtpm2_183-2024-03-27.bb
index 7060a64..7ed9569 100644
--- a/meta-tpm/recipes-tpm2/ibmswtpm2/ibmswtpm2_164-2020-192.1.bb
+++ b/meta-tpm/recipes-tpm2/ibmswtpm2/ibmswtpm2_183-2024-03-27.bb
@@ -19,13 +19,13 @@ DEPENDS = "openssl"
 SRC_URI = "git://git.code.sf.net/p/ibmswtpm2/tpm2;protocol=https;branch=master \
            file://tune-makefile.patch \
            "
-SRCREV = "5452af422edeff70fcae8ea99dd28a0922051d7b"
+SRCREV = "c37c74438429e1d5fe465232e7bf894b239a2cd4"
 
-UPSTREAM_CHECK_URI = "https://git.code.sf.net/p/ibmswtpm2/tpm2"
+UPSTREAM_CHECK_GITTAGREGEX = "rev(?P<pver>\d+(\-\d+)+)"
 
 S = "${WORKDIR}/git/src"
 
-CFLAGS += "-Wno-error=maybe-uninitialized -DALG_CAMELLIA=ALG_NO"
+CFLAGS += "-Wno-error=maybe-uninitialized"
 
 do_compile () {
    make CC='${CC}'
-- 
2.25.1


