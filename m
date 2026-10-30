Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7724.1793352986877302777
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 30 Oct 2026 02:36:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=sL5dW6kM;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=57637de7c6=sunilkumar.dora@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8GYWf1780285;
	Fri, 30 Oct 2026 09:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=v6VOi4aB0
	jJT+kkueSR0zYVuH6mM63+u5MQvzW0BrtE=; b=sL5dW6kMfo3gHVrIkxf2gHGtp
	OEEieKv330Uxx9C24eVSl9D0qENfp8j2ValYRDATiLmu0oisNCqFhQ8fRB0nOIse
	Nfcni0TSpJsONZlqYBoylS4FpGfU2/0qMZZ1aH+/fffBmWPalnOCee0iqimNySZ3
	oO3up5Th7mAYSBhsXNB1EIzc/07mmbFT1dEEsf3DLn3X1MmBMLAuwXHFe7i7HS4E
	R7KKQaMKiQdK6+MTWAXhduTvgrt+JWv1s88VxmEN7if52wbJBwFTnYRTYegRjReE
	Znh3HhS0CQfczPS2w3azXLFc4J3/kr6WX64qPz7zq19Ea7TpkbSIAhMzgBJsQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021141.outbound.protection.outlook.com [40.107.208.141])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4hme7f8nnb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 09:36:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzCUjnRThQcfSEVKezQ/UvDo155qgD45nvOzOtb+OKJcLZbSSAopOiW4HLQrfCuSj7b+cQV+wwCB6R7lCcUvmqrpji8Ney35l9Ex5dYKIFkgOrqv7dtmP2p8kvW8buKRxSNoVSYyrQ6/EGSs01ndG1CnCyLvbsUUA+f4p7wTk4W9outcIkhVXy11a+SqgrshADyH2rFoGVOtXiLH79p/KMpcYrDP9xmPkywuT0PktT/hj/lp98g2O4MB6aBjtYWM6C5RHAU58oH4TYTyhm+CqCObUEm/3psZIbAEnxLjP7geMEQIqxnTUKNDIHBK8r18C+3o6Gc9zUuKu7msG//2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6VOi4aB0jJT+kkueSR0zYVuH6mM63+u5MQvzW0BrtE=;
 b=MskLZaPRZ/5L1JysLLVaPLoLeyrqKhODUwMbnkGj7hzeD+xiMn0Qflgs+jZJQr7s+Xm0eYziUfqzm1QEUH3gkxjLRoYhCdUDNM55DXIf5/ppfUVMTwQKW4fwDpZhsNGai85cniIIYAJL6qXwXIyPxGlNEeQAiUwbH63hG88EKiFo8Qvo6Xv6sOXMnpDW1GaU3Nm44Xpr1jWq+3C6bW0KlpkAAwb2+CaNBfKJpzooSycnIdnGTwfosX/cDTBgMWU1fV4gYriD2D/CoHd4rTRjZmOmlqpxkBrJ7X6al3g+jXkLc48BmGDHhDjmDC0/b+hDMnyQ2rHKJs+sTgcArqexKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from DS0PR11MB7901.namprd11.prod.outlook.com (2603:10b6:8:f4::20) by
 IA3PR11MB676772.namprd11.prod.outlook.com (2603:10b6:208:621::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:36:19 +0000
Received: from DS0PR11MB7901.namprd11.prod.outlook.com
 ([fe80::4293:7c4b:a0b5:eb5f]) by DS0PR11MB7901.namprd11.prod.outlook.com
 ([fe80::4293:7c4b:a0b5:eb5f%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 09:36:19 +0000
From: sunilkumar.dora@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: mark.hatle@kernel.crashing.org, richard.purdie@linuxfoundation.org,
        liezhi.yang@windriver.com, sundeep.kokkonda@windriver.com,
        Randy.MacLeod@windriver.com
Subject: [PATCH v2] makewrappers: Allow the wrapper architecture to be set for cross builds
Date: Fri, 30 Oct 2026 02:36:01 -0700
Message-ID: <20261030093601.1679750-1-sunilkumar.dora@windriver.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::21) To DS0PR11MB7901.namprd11.prod.outlook.com
 (2603:10b6:8:f4::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7901:EE_|IA3PR11MB676772:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d84203-799a-4276-e6ff-08df36694066
X-LD-Processed: 8ddb2873-a1ad-4a18-ae4e-4644631433be,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|52116014|23010399003|10067099003|11063799006|3023799007|6133799003|261028144727099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|56012099006|261026140227099003|261026121527099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: Xlexm3ttXyLQGGAmQBtyvZT5gKlFRCw4CRDfg37kRyHl0W9u+nEbZeDPzVphVCtd7ns1Bn5Ey18NmKc63S0js6TxJQhekA69vXjzwmU53YA6WRSFZ58XfRfnvr1aRLNyiFL9GyN0T/8tnphVkZFHiWfLeL96HmqcYszJcnOmlKH6TgcMKi8XNDdUvyrLwhxEJq0zjCBCtVgj6S6PBuf5Am2sOM/zyTLrec9Gw1eQJaaWT8++z9GAd6sGUAiioB8NYcT/x7cQ/Oj2hJZl5PmH+xb1QaUnoGOivzMmc2AMOKw0Av/b0I3S3D1E9pTl8yCBdY4TiSPkVNKD6/jdQuQLf60zzp+YEq1ymMgeZ+hLs/RPertdTLPkgutbtiVzq3rtLG4CHkcxdHjjG9X3YziWrH1czD4YUEjfF7ezxtU4SIQCzdzP8d5T3sBDlSOjKf+9cw5u7rK4lQl/27wCPFgWpR52nmMYMM+27akmmcTPjScw16RiiaJLt/m5xTk0LxM0aRh5CRfDPNWeWLIbJJe6O+Z4XIJiZkUr3rmu1MMeK4DWkgl/bD+l8A10UIl//BsYxfoDDlaoRcGcMkBf5yXVZlGpT7G3ZBegLobsg/XmlIXc0cEX/x10XdlwlCiujxHABsTGruISq716g/Yz0QvL49toJLwh0kHGXXWZIHkOEBoHTA2TrIn5x3xc/26yYBGe7PcwMqjfZQbAEON+RPn5MY+uCPK3j31OGStdV1KRg6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7901.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(23010399003)(10067099003)(11063799006)(3023799007)(6133799003)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(56012099006)(261026140227099003)(261026121527099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ERRTTamECPkrz/d6VMNIpv/7ayDCpVGRxmSXYXPK9dmQmcXv8Kevi62TFHPC?=
 =?us-ascii?Q?DeOm1i+IqWQDhI+HUSMHVnBvzljXID7y3k7POHiFRrZ8C2hAfoKeY5+NOekV?=
 =?us-ascii?Q?hW6Zq+I3LKfoelts39ElY5j7LzcYfuYOjLdEZqSJMVLMgPeuy+r6monCMiNn?=
 =?us-ascii?Q?7zsAeTyiZBBRFESJnPchKt18DR4oBtAWxJRDsMKhIKsqtqQq+2B/vyucYCSL?=
 =?us-ascii?Q?SXCzr12IY7eoxoaNTFspOXUfG6UJOVnUHfGF1YE3O7KG90hignsfr5tvJmvN?=
 =?us-ascii?Q?83BRVGpeLnruJx1/CwBXI9AGvMXnySuNuCEU0eLkJlr+k7B9c3r/n4Cj/M/w?=
 =?us-ascii?Q?+e0H5KKrv/IFDJUqJsnlv2eqQ3q7X9+KdxAjX+ZHfMQkgScOEkaH/FrJUzx9?=
 =?us-ascii?Q?0bYldtF5lphtjMTUNmz+seLxY3/GKl/DwWztB3wKcMZV1b9EuQVtLH/yhb8X?=
 =?us-ascii?Q?lQVMAk7RiJKuWV6yFuNvEZM81hHLTs862GH+psoWslOQdmCCwyLD3vWdY14n?=
 =?us-ascii?Q?M2BxmNOkrgSfGOJ0HJ7yUGDRbwOjKe7TpIO5GJJUhWMY1iIzmuna4k0FiOBi?=
 =?us-ascii?Q?Mb9Am7RDfLvFQAK+DXSxTb+9IzinXel4WSNxbQeeVkB8m80B0QO//bgJ3dH9?=
 =?us-ascii?Q?ozY4cFs2D5DThTpojbyw/MVWfXjggsxduVoENozd/PmQkzbP6YB4X9cXOayR?=
 =?us-ascii?Q?9lLBKMCc+hhdxrT84To92yDFAcRYiMjicwETDdixtwwEZu48x3qbTuBCqFnA?=
 =?us-ascii?Q?ib8O4qxOsWdoTI2aN8QDBxX0Ws1lNBcXioRDfbhdopSV/5J+JkW5XKHzCP0k?=
 =?us-ascii?Q?b6Hmz2jY+iXMpjt2qORZrE6NpHnBg6e4B3uMJceBzP6YNoiMLAiS2laAl67K?=
 =?us-ascii?Q?6G6Hv6OycbB2Sdgf0bDBHTR+OXXIq/hl0usVGnZPIBUdmOc9ZAUjEuzIBgUc?=
 =?us-ascii?Q?FxPjPoM52nTKhV+Ag4vsrQAdMjgFbkbk0gPW4YNV8ucPkPdYT8SgQv2oxNsk?=
 =?us-ascii?Q?yyyXUJcNmxhC6f9g7vNdqC6n3v5vDElEXJN/DG0ViOJQ6JGKFEuHZh1YdOMc?=
 =?us-ascii?Q?H50ge6bdZaUWTUuKglTH+3ER19t4XCgl2TpKrzdOAaqu35aYCWQCimsbETS2?=
 =?us-ascii?Q?SjDCLH9WJ+HA3fSAuml31mXaKb/3K0QGH3HXY0Gwas4vESzjOKqdZaH1xkTb?=
 =?us-ascii?Q?wuKgyDPetYQPeztBcqmZN2+Xbu3UFzygyxG4k6Da/LFHmS7wnafJKU3ORFmB?=
 =?us-ascii?Q?mbjbWeWlYWNvuS5jfqCs0jcM6hFgXQzfTe3Jy4wdi1vHpg1OCEgc7wAUitv3?=
 =?us-ascii?Q?9uw9cUHPU5UjjHjJAAWeoXxTM8vciHiQG3cE3QdyYCtwTzpKkfVpa25y8sC9?=
 =?us-ascii?Q?jiUS7mZcf/JH1d3nKyW8a7GncI8EsRD30PGpH8CETnnUZ6Wcvph9DQg2bKxL?=
 =?us-ascii?Q?ayfbzgkZutzaDl04oZrtJAk6uqeP9v7juCv8o6gT8IdygF+F8rc+iZOFtvwZ?=
 =?us-ascii?Q?but/il+IK9uqP9ReF3R2AQTUdkNiFUIuyJnmb1ne6jA8XGGpr/WOHuOw5Rxd?=
 =?us-ascii?Q?B4+qd2RZ8QW+LpFntIT71ifHdeN92qo9U3UwFqBZ3TwR+rADHp9SHW9v9Xzb?=
 =?us-ascii?Q?7cT1EhBLJtQaBzCqJIAlLyGN6s/bC7eriTp71jZc7/ZGmBzKSsVKu38twg9f?=
 =?us-ascii?Q?zRk7IF5JRellvvTiZ1dq0Vv5wBMuVewe9lN58Fbhcr3Ku2iLVz9LRefOc5XA?=
 =?us-ascii?Q?ZtgMpZCW72pCQ9ZDni9RTnE8Zk53dWg=3D?=
X-Exchange-RoutingPolicyChecked: Qx/5oTYXAALYTMC5BU+RC3Q7sIzTWFIMeXQqgPpNkJ+qQ5MokIO6DeT73ZnLAh1aOLDd+SHW3WDGlSAeKsrOuVO/4/1fP8NQ0oYPbaZ78G9Qz9Jn9lEfPmhsW1POKr+EBW83AOpsnrvTdDZabUO657/oaC5qBs+qqHHphaNM3klSGzdNLWdsEdj4wkfNVNHLaUUnLo4KaulxXtk57fOe5u891ZgUnL4bCcEtS54Q+8KmV7wUAW7/sYMDCpp2RjNN/tR0OSWkzVSpF4+fd/rDgNI3pwRMGITz8x7TNKHyJOS3dXNsTcUJ0aKsn5xebjhthWMI+X8C7JtOGo73EP2w3Q==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d84203-799a-4276-e6ff-08df36694066
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7901.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:36:19.1533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+usmQXHsQDXKuPwU7QcCr1pxYTq1VXkVCZnhlVPudUrNeI7CufTR1VvLmeDwogPwvekswbTyphyz7AaQkMBUN9X8mix0bIh6N4vDjx+x2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB676772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzOCBTYWx0ZWRfX/WqmhM5fPFcI
 GiWXgxfGnhGhnZt4mKGdK7xfLtp9B8GZiXMbDuI1U8B1QWsWUMk2Xlj7QB6sYpMJfPPFWUsJZ2p
 JlUFreD+xYmwhEzyschWVc4P7DB33b9RWSf7ZhwaTIFb+ogG9bHc/T8pBZF9dFYK95LQFN4c/GD
 CJj20Ubg7/L2hAVN2alwBUPHJm01MAc6Ricru+qvGTu/DFoRJY3+dpToIwsDWAwCKoe8ReukBs8
 tbjW/pHd63Hmp6XdhZbUx+Woc5sXU1JEd5GoVXXO1T5HBLRbZQuVoScUG0+rKmWyaFaK+fVUD0S
 IODK/50PsYJRmlH5b8VsnokTZsGY1dpiZYBaGx6k7F5Gx2WBTY3aNnV+ulNLiwP/prZmzc5/4d2
 5XNWY3OVrtMU6/FvmUgyCQtaXAv2IYUD2wc2rFAwqMbiCdEx9U5q4qXhTQHwml8gljMEnRYIQvS
 CH6pmGxbIazGKj3Lw7Q==
X-Proofpoint-ORIG-GUID: C2TLvdNHa8EJu3QcyZnbm6aL8jdBcJAo
X-Proofpoint-GUID: C2TLvdNHa8EJu3QcyZnbm6aL8jdBcJAo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzOCBTYWx0ZWRfXxelZgZf80nZE
 0zbm8rRxu8M7xo865l7gPqVBG/jp2cP9HCAG4zF/91Pzzj0S1AzRtfTUVPBek8k0H9REL27HaOS
 XIANMX9AieTxC6HceLqpMTPqgIGM3f5yMHwWysyYsl1AUBbkKZsm
X-Authority-Analysis: v=2.4 cv=AKC+DP5v c=1 sm=1 tr=0 ts=6ae46515 cx=c_pps
 a=azlkv/KBQR0ub+Yip4pvTg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=HQp09vvjJnJxfHRkxWAA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300038
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 30 Oct 2026 09:36:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5188
Content-Type: text/plain; charset="utf-8"

From: Sunil Dora <sunilkumar.dora@windriver.com>

Architecture specific modifiers in wrapfuncs.in, such as
version-aarch64="GLIBC_2.17" on the xattr wrappers, are selected with
platform.machine(), so they follow the machine running the script
rather than the one pseudo is built for. An aarch64 pseudo cross built
on x86_64 ends up with GLIBC_2.3 and the reverse with GLIBC_2.17, which
shows up as pseudo not being reproducible between x86_64 and aarch64
builders.

Add a --target option to configure and pass it on to makewrappers,
which uses the cpu part of the triplet for these modifiers. Without
--target the build machine is used as before.

[YOCTO #16376]

Signed-off-by: Sunil Dora <sunilkumar.dora@windriver.com>
---
v2: use a configure --target option and a makewrappers --target argument
    instead of the MAKEWRAPPERS_ARCH environment variable, as suggested by
    Mark. Without --target the generated wrapper table is unchanged.

 Makefile.in  |  3 ++-
 configure    |  6 ++++++
 makewrappers | 17 +++++++++++++++--
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index 6640a73..9c6da77 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -34,6 +34,7 @@ BITS=@BITS@
 ARCH_FLAGS=@ARCH_FLAGS@
 MARK64=@MARK64@
 RPATH=@RPATH@
+TARGET=@TARGET@
 VERSION=1.99.0
 
 LIB=@LIB@
@@ -146,7 +147,7 @@ tables: enums/*.in maketables templatefile.py $(TABLES)
 	./maketables enums/*.in
 
 wrappers: makewrappers templatefile.py $(TEMPLATES) ports/*/wrapfuncs.in
-	CC="$(CC) $(CFLAGS) $(CFLAGS_PSEUDO)" ./makewrappers "xattr=$(XATTR)"
+	CC="$(CC) $(CFLAGS) $(CFLAGS_PSEUDO)" ./makewrappers --target="$(TARGET)" "xattr=$(XATTR)"
 
 .SECONDARY: tables wrappers
 
diff --git a/configure b/configure
index 68c9962..b43809e 100755
--- a/configure
+++ b/configure
@@ -10,6 +10,7 @@
 opt_prefix=
 opt_libdir=
 opt_suffix=
+opt_target=
 opt_arch=x86
 opt_bits=
 opt_sqlite=/usr
@@ -32,6 +33,7 @@ usage()
     echo >&2 "  configure --prefix=..."
     echo >&2 "           [--libdir=...]"
     echo >&2 "           [--suffix=...]"
+    echo >&2 "           [--target=...]"
     echo >&2 "           [--enable-memory-db]"
     echo >&2 "           [--enable-epoll]"
     echo >&2 "           [--enable-xattr]"
@@ -153,6 +155,9 @@ do
     --suffix=*)
         opt_suffix=${arg#--suffix=}
         ;;
+    --target=*)
+        opt_target=${arg#--target=}
+        ;;
     --arch=*)
         echo >&2 "WARNING: The --arch option is now deprecated. Use --cflags."
         opt_arch=${arg#--arch=}
@@ -341,6 +346,7 @@ sed -e '
   s,@LIBDIR@,'"$opt_libdir"',g
   s,@LIB@,'"$opt_lib"',g
   s,@SUFFIX@,'"$opt_suffix"',g
+  s,@TARGET@,'"$opt_target"',g
   s,@SQLITE@,'"$opt_sqlite"',g
   s,@ARCH_FLAGS@,'"$arch_flags"',g
   s,@DEFAULT_SQLITE@,'"$default_sqlite"',g
diff --git a/makewrappers b/makewrappers
index 19508fa..7cf2862 100755
--- a/makewrappers
+++ b/makewrappers
@@ -15,6 +15,13 @@ import platform
 import subprocess
 from templatefile import TemplateFile
 
+# Set from --target=, empty means the machine running this script
+target_arch = ""
+
+def wrapper_arch():
+    """Architecture the wrappers are built for: the --target cpu or the build machine."""
+    return target_arch or platform.machine()
+
 class ArgumentList:
     """A (possibly empty) list of arguments"""
 
@@ -319,11 +326,11 @@ class Function:
             # Strip all leading/trailing whitespace
             modifiers = {k.strip():v.strip() for k, v in modifiers.items()}
 
-            arch = "-" + platform.machine()
+            arch = "-" + wrapper_arch()
             # Sorted so that versions-foo appear after versions, so overrides are easy
             for key in sorted(modifiers):
                 value = modifiers[key].replace('<equals>', '==')
-                # If the key is version-arm64 and we're on arm64 then rename this to version
+                # If the key is version-arm64 and we're building for arm64 then rename this to version
                 if key.endswith(arch):
                     key = key.replace(arch, "")
                 setattr(self, key, value)
@@ -669,10 +676,15 @@ def process_wrapfuncs(port):
 
 def main(argv):
     """Read in function definitions, write out files based on templates."""
+    global target_arch
     funcs = []
     sources = []
 
     for arg in argv:
+        if arg.startswith('--target='):
+            # A GNU triplet such as aarch64-poky-linux, only the cpu part is used
+            target_arch = arg[len('--target='):].split('-')[0]
+            continue
         if '=' not in arg:
             print("Invalid argument '%s', must be of the form name=value" % arg)
             exit(1)
@@ -702,6 +714,7 @@ def main(argv):
     port = Port('common', sources)
 
     # the per-function stuff
+    print("Architecture for wrapper modifiers: %s" % wrapper_arch())
     print("Writing functions...")
     all_funcs = port.functions()
     for name in sorted(all_funcs.keys()):
-- 
2.49.0

