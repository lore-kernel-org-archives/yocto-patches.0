Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D9DC67861
	for <webhook@archiver.kernel.org>; Wed, 10 Apr 2024 03:28:35 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.157891.1712719706887292802
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Apr 2024 20:28:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=KLYQzf7z;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=4830c46787=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43A3LcZ6009909;
	Wed, 10 Apr 2024 03:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=Mzy/jCW7A1BihhCxh+
	cqYZNi3WnOk8mATJts/fuhTPk=; b=KLYQzf7zjrDpYmt9LbWkL1OMRpe2lIaBkE
	W+CrLumx+4z4wZU7T0zprB1n8Z6gA33jQoQBaV8y+T9bIA/PSvTJDnvd12+9IlUE
	dIqSwvp1Xx9rp804W0kCMz4+u2ia459tGjUEEEtC4js2XL1XL5Ou6Xco7mz5h55r
	f4H5zO9eAIAKKe4NpVv3rmpW5+NfLawe9U4tiuf4bfNW5KTGW2scOYCi+bpAP37l
	sH1pxmSUNxfGzCvYqGzG9dAdEEnhVyYGt0vdUaQo5SiHygoaIDjgi49a0DxwzTMu
	TnalqqPI9X1aLuxQaJnFC111JhATNL4JiUCjhJ+NrvMNYvq6PoJg==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xawc6kj94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 03:28:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jbrw4bmXMNyGxFvnlAv8tqRgLoPMKzLQrl13kpDlkngdPm4/NUdwPOZE4Ag6wo9l5QaEEJNg/vL6oI5/TtlID8p1Zy6qohoLVMnZwd7JZKVT09kR5RY8YQYOk+fEiH/3HorCn6E4z47b6Y3qkCYPqNtV260CHsv6wWHwooovpQsS9zZL4CaniX7hsmIFQWBKTsMR3IZd51GWUq6bnD3dNOn7tJNiFOpWNZvbn5ONQFocbjE5onZXnlR+Li81K51oh1ujlu8FeE9u9wjvHMtcj5XJgaKOqxZItlMrHQhRQ3jrA3T2GxUEezAua7/SyOBadFnCPoOe4beKfDbiq4j7tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mzy/jCW7A1BihhCxh+cqYZNi3WnOk8mATJts/fuhTPk=;
 b=XaJ8Ih8cDvLW1jf0rmIinxPROFf1ApCvsHz7vYsQHltH1mhEU9avlBXl0bBRjvpqPLoITOg8z3pX8lDUgn1sD+dVywOjeDjymjsKx7qDPURcs9Y6k6tGmlG8ELYOYGoOZdiQr7zz+ZgXwkGuNGzu3ov5OwIZx6qS1TkQjQaiqARZPPGman/U/oR+rRBUsK6bNtkYzUzSly8qqTffIetR1ggl0qDmEWzE4UyXIGLYLZoeOnRB0yz32ckBSE0R0u8dwNgtYodAXMaifRJfW6t58SfFHm+xfKRc9KkrVQhQO8SRCrwDWV75cy4W5syfDyrgNAPiEukkWK2CCeCaEq++cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7484.namprd11.prod.outlook.com (2603:10b6:8:14c::10)
 by PH0PR11MB5144.namprd11.prod.outlook.com (2603:10b6:510:3e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Wed, 10 Apr
 2024 03:28:22 +0000
Received: from DS0PR11MB7484.namprd11.prod.outlook.com
 ([fe80::97da:833f:8511:a558]) by DS0PR11MB7484.namprd11.prod.outlook.com
 ([fe80::97da:833f:8511:a558%6]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 03:28:22 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, joe.macdonald@siemens.com,
        joe_macdonald@mentor.com, joe@deserted.net
Subject: [meta-selinux][PATCH] MAINTAINERS: update to new yocto-patches mailing list
Date: Wed, 10 Apr 2024 11:28:10 +0800
Message-ID: <20240410032810.93843-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::14)
 To DS0PR11MB7484.namprd11.prod.outlook.com (2603:10b6:8:14c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7484:EE_|PH0PR11MB5144:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FGZrqYFAktD8VSoiFa85zCtGBkN96r6vQKv4JdIne9KHyv++QXZnVmf4DikmZE23dkAQF39lN2igycPLAhDbrR3/Mri629Qxp0sJFgpirx7Ddm77uTND0qPXpBg/27zIzN3ZZdzo1KzMuFHqgHLmK6kP/9yv6f2I99Qrs9skR5b9UmoNHsliZvfKz5mcPBiAOCIWGSWawEhTDW8al+JGCgBiGVGoj6VFpeH7tuSoIuG9wcbiamtIIaAXO6HGedyfCx+EsxiFdS4QXEL12HqaC1XRffp1b4JI/xIr7r3HUEx3AOyCn/STSYe7l+tWjUANQbVNLi2lcGkszyqEKfHtN6WDEg1pkvQoJx9b/8zsvuIEwpdvtlBmaTuOfFMJ3SgRaXXNTQP2wxyf5Oz9aovzA7jgzvsIMTd3KiqSW8pf0TQmXmyZTFtp3hevYEiJe+GOJFkHKvk0fK7JBuw2DgwHrbDk3EHtnh613oO3wWtKU66ZxxcGCE5CVNMowdRNMZguJ2rbeAE8znABcuCH2kG1y6u7aWUuBP1wHEmXyxP0oSShaR0VynFR4OKAZTg08pg7UddkGRwL3zthuP4IZyngK/dbmOyKSFCb9WZIHtEOWaa5HDSp9dIbkhE3DGPXVyyu7luITggkpQ5MFtkVi4+qhFFUO3suNjlLlyKIDFEoluMVkSqabLrILTugMKSv97p3MUqW0U3gL6nYn7KDXf72rg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?g3cH43lo+FtK63swgrkNp5/nXhcvSG6Px+0zL4V+RuuH7ge8tTpofSesk06f?=
 =?us-ascii?Q?DNAhuJmOhR9JuQeUJ9D8FpvufjLTucS0LT4zB8w+skAhXywiA5F1kjyFQq9I?=
 =?us-ascii?Q?3QBe1H7PDQMVQKPt8T7TgUp+351Qb5AGbupuOUwjDBfRXd8V6q8hBRQmVlng?=
 =?us-ascii?Q?N/sApf9SHexxZv9vTp0s4OqP+D4XfrmmP6EsZOxscb4QtvxkA45BullRQeYr?=
 =?us-ascii?Q?f1cFWDxDYLoYx3M9X5PNJFvvmntZqtZ76VXgc2OWOQvvFVBd+0iXc0JNuxvT?=
 =?us-ascii?Q?WK1P+AB3+e0BEtpiHPDr8HsQh7FOnkzgrJPoKX8mQCvyxB98u2j45Ni792Il?=
 =?us-ascii?Q?uZftc2d2N7gEa/9+gSrAJwtReCeIYTLVEzRBgNTt3AlDFI2K+hbLgslSffcs?=
 =?us-ascii?Q?i3570sgNdtTFQneQwcALZFZ06qbFwYg3EgzRt6g+KDw/tKCvbAonRb0AL3gr?=
 =?us-ascii?Q?Ntxb3FKjPbH5JhCluLTuErJg+u8hDuCLBkVVhbhq+RHfwepEzO6py0z078B5?=
 =?us-ascii?Q?B4JFY58v1UI/68QDIpMpRkV+j6au6loLfJC7udfxzIWQZjbFsJxG0Mi9GUe2?=
 =?us-ascii?Q?2Oigj2RZ+q7l+70BwKaWpeaeOK8I063dIrRwnNlJmbmeGPJMeBba4cXNcp+H?=
 =?us-ascii?Q?Kl4a7NJ3TKUtee9pY7A2qGbg3lZm4MqiYZcvIu4AKUpIsdmmEL6iFcQYbuJ7?=
 =?us-ascii?Q?HjIanu4zUk5mcsk195ak59EAkAge8Z+FoPMz0xPxBpSOVErSyGldWwamgMw1?=
 =?us-ascii?Q?KPl+Qvs8dJgBkqZvjJjOUlV4VqfWu0W7cU4psautG0q/DMQTPFNFLPT4Dq95?=
 =?us-ascii?Q?E3dPCkv/ehGBNeF0VEpVY3ASNb0GBzMgS669ntbIPTewP4nqUs4jOdT9+/nH?=
 =?us-ascii?Q?yQDm1k+QIRh7b0dNQvoS4p1uXPFK/cB8A4yWxqrCEB22kT/5IgGHKnrmNzaa?=
 =?us-ascii?Q?NL7quuqVvvZ+1XczvJNDJwFEyzm/DkfEiuVBdLqZ/Y6Zr7CMxmUaGESOUKxD?=
 =?us-ascii?Q?KscJzt2JtJKTfYtqu1ryWKIfMLK4glafe2ErrmDhLiT3mEuc9FvMlCNDVGgc?=
 =?us-ascii?Q?89HB/sZFyDaw1LVgea0lvS6x52xl5noWYR++WScghTZL7FdpZnwRXQEnpImP?=
 =?us-ascii?Q?g/Kta8bXdifZzg4U/5bpLzV9C0zlzJTKPJCDXB58crbf1DlwR3A3WKyPIiPO?=
 =?us-ascii?Q?9zgzyjglmveK+ofGmViRXFbllV8Xty1TzhYOFuJYzaB+KHTs6jjDx9rdyajf?=
 =?us-ascii?Q?5WHeHWTDTbBW/18jK4rzV95Sn+CE2jTzjyNDu7hYAAssIh1SgOdp6m5ph9qB?=
 =?us-ascii?Q?7YHZM1nBkK6ZRGtBYy09OjZ73Cp5ml+jKj6nPL7gBzSlaF3kQWTzddGjpPN0?=
 =?us-ascii?Q?sJ0rn+7F5FCZuBp+RxJXEbCICy9nRaAjH864jDedcVArGYr/+d3uCpLufefh?=
 =?us-ascii?Q?0kQOUZ2thj3KBpEM8T0l9L/wXFht2bMOO8voAm3OuKPVBB8C18TFTtETeO8k?=
 =?us-ascii?Q?VfJf6Z09DO6OZCFsXttnchD07LxtqYXguMllb4NUxoLRj/9ovjcV1HdPF/4J?=
 =?us-ascii?Q?+L/sf77H9FpQuvQ+4Du0FApCWOCzyuJQ4zcJjAUP?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fb30b8-b305-43a8-48d8-08dc590e464b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 03:28:22.6818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNqXKlZk+otLOhNKA0fWkGiEU3muashr3kFYtPbJVwDGX82dMxEtXlphVqe68xGwCmAug7mRocIuY2atrP+K1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5144
X-Proofpoint-GUID: TVViFKYTBngwbaBGoXmC86BUHq2hX3Db
X-Proofpoint-ORIG-GUID: TVViFKYTBngwbaBGoXmC86BUHq2hX3Db
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=847 impostorscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100023
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Apr 2024 03:28:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/17
Message-ID: <20240410032810.odq8VpYi7gHrdwkHZ6JPUSuZ0Kk7gsC78LQxqwjLzas@z>

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa6c484..016f325 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1,13 +1,13 @@
 This file contains a list of maintainers for the meta-selinux layer.
 
 Please submit any patches against meta-selinux to the Yocto Project mailing
-list (yocto@lists.yoctoproject.org).
+list (yocto-patches@lists.yoctoproject.org).
 
-git send-email -1 --to yocto@lists.yoctoproject.org --subject-prefix=meta-selinux][PATCH
+git send-email -1 --to yocto-patches@lists.yoctoproject.org --subject-prefix=meta-selinux][PATCH
 
 These values can be set as defaults for this repository:
 
-$ git config sendemail.to yocto@lists.yoctoproject.org
+$ git config sendemail.to yocto-patches@lists.yoctoproject.org
 $ git config format.subjectPrefix meta-selinux][PATCH
 
 You may also contact the maintainers directly.
-- 
2.25.1


