Return-Path: <Haixiao.Yan.CN@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A8FCCF9E0
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 08:45:43 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.27585.1761554733133940804
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Oct 2025 01:45:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=qUF/uui+;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=2395649734=haixiao.yan.cn@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R4eXJo768704
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Oct 2025 01:45:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=umWNl0ViDXXG/jlWO7MT
	L2ygzH5GS597+Z633KmLaaY=; b=qUF/uui+Gn6OYc+4Mq3/993L+YIscg7WNnn7
	fPTXp7hajZm1bMRkuUvApX+MHWJfVcPAkhQUCBuR6p6XSue1JMdBE86xB37Rz1iy
	qcgjoCq+Y/iJyl0pIt2tZdkbqqEGNSSSoHlJH31XIo23b6xekxcaYyRAksGPTs2W
	qtr1b32fB/yk5PlvkKqWZc7ehP1jUj6ekqKNVg42FxS4KpsA0qgOyxnisqiuiCNn
	rm6M8lI/FM4emJbLVRnoBbKy0cDWmWjGzfl3M+AQul+WoAJW6JpynqdhwRfEXHx0
	5itHpqhLiSd+7dd/Oc4Jp3AJzvQTxkn+dqQ01pv0cOuqjV8Lmw==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010015.outbound.protection.outlook.com [40.93.198.15])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a0su1heua-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Oct 2025 01:45:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4nEj9kd/+07nRlard7xUTWyv/0V4E1nsomIvDC20wG/9IYeymA87poClWkOTmxdrtFETlfp76QkKGooJScbb4Z2AlWp/aOvo1dj8xPV+ihAlBUdHjyQcMO8NCEDzXAx+dci0P9e7UToBi21KUJxCPr9FIIAIF11yWYjEVFIp1Vats4wdmoZD1tkxFjC8s2SWiRYAGukbcCn2nd21+3hcQDnIPujXU2CxgWA+TKxyyviHzwJjmgH9uLSTa148iXsmRYG2Wr6wvZWb/+pe/i8tL9sYD94JFA7FVx0wYClmPjBiGmT4MrCK7AP1cdZcHEYbtq9k+J1qJcM+LVQCnifGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umWNl0ViDXXG/jlWO7MTL2ygzH5GS597+Z633KmLaaY=;
 b=RmTqMe6e0rBE6j5CqrddYtRykdYqTWNBG/M8009hs8Nzxb0jn6Mzs/GD0w+T21CruveZ3ItcVaW1EPtAROE8QowShh4NzHU+fy9MggkmRfzMVHMdIqlkXeyCBxIi3x8+NeVf+YwcbtUIyTg5Ywd5UskgEbefON9l+WCmuA9psCs+GsJSfwJK+XVPiC+JGK6/XBMs4t0pc3b6dmhAcdQWd1c80rTZyEgxkGmmxDheiL3qAavn2YK3tpxMKUqNCN03ZbIWr11WAfPsIm3bvL7yvwxYClr4mCXp3PwZhngGwMUOTrxDjXsnPSUk0HzL1/4tM9IIdK3XIau/BdWLzphIvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13)
 by CH3PR11MB7298.namprd11.prod.outlook.com (2603:10b6:610:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 08:45:30 +0000
Received: from CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4]) by CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4%3]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 08:45:30 +0000
From: haixiao.yan.cn@windriver.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] fail2ban: replace fail2ban-python shebang with python3
Date: Mon, 27 Oct 2025 16:45:13 +0800
Message-Id: <20251027084513.4015382-1-haixiao.yan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To CH0PR11MB8189.namprd11.prod.outlook.com
 (2603:10b6:610:18d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8189:EE_|CH3PR11MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: 23db2c9b-7101-4c93-1411-08de15352f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qSoy5SWMYkfbNT8yOBGe/wSKTIOj7dazGHVGWeHxUAOaCUL3i1ZM55l+trOl?=
 =?us-ascii?Q?T6suyn+uzmuNBkdnK7FgUmwMDJ3YAh3PyjiZa4aadgt4k3icbp1WkOQ1+aMm?=
 =?us-ascii?Q?wO4KKCOndM1lEvFz88ig1oZbcwyK7PduJ087BFoEkZKbR4NzoQpU0LQ59+aO?=
 =?us-ascii?Q?Bk8y3qQk50+pRimAbwU4TE1Y1pf3m7SvTeZjCiizquIwWAh8RwrRSN05BB7a?=
 =?us-ascii?Q?qSDSPkhK9+qAgVA9knMtL1MbCByr94pKXbjKOhKFDqDBbkBjTKmiU783w7fm?=
 =?us-ascii?Q?ncnzfvFQ0Gzollj0j9zGQ4Vm8FXDbKFfEtXtroCdKI4NRBIzg6fy4WaOHfjG?=
 =?us-ascii?Q?eYxbC2+NMlW4i7+7BN+BPmwiSUN7RqW0bVgWQL+1vVjwCA49+Tx/R0oJQt2A?=
 =?us-ascii?Q?XwFp0rBGzVzj520+eb3neDQWOz3EPJj4yGY16+MZpmdN8rKwMUJyA/DZlDlC?=
 =?us-ascii?Q?Uj/DvGbtFfLLDt/MD3n9Do1Yekam/OInqL4SNP6zmUWQqpANSf3+tuswnDIJ?=
 =?us-ascii?Q?evNSreVUyo8A+4vBN+8OpMeqqq90dWfbhgQsPbSLX0etwLLHgmLub7L27Z/N?=
 =?us-ascii?Q?mZ7d69zdCAys3aotnKswD4WxImW6ZPuoRcyQkJAMRcmIomj5wTKEviuzpTHQ?=
 =?us-ascii?Q?REWVJ4LWiVZF7/Doghf6QP3qx+oxOYHbAjZGAkWS/5iC0nivV29lPySk4iEj?=
 =?us-ascii?Q?fPWCyo0nYJm7Us5YKV6Hsb31nm6o2YTcCKgI213UmeWUqWqvmWrRJWS1yVMY?=
 =?us-ascii?Q?4RJVArOqa16vHwvNVl5diPNMxfvPnZc5Wr3F/E8qA3ABWFYr1j7VHdMX3cq4?=
 =?us-ascii?Q?iH0N7fIEUs04fV7bnjYgbPC2udYh0IveH493KbT/0hutXiCyKttfTqJLtgBZ?=
 =?us-ascii?Q?ODzuLqmwBzVR+KVur3HtN9K0KYFEshxT+CD1hedEwKiRdGdcRFOHI+pRPEe7?=
 =?us-ascii?Q?z4qXSG3r5o4rFDA1HIKBnDmipsUlmJXJTqVGt0COf7RgRLNwv9T5jo7kkNC7?=
 =?us-ascii?Q?gUfUrcYN21lqlw/kLIQnBNk4b60Sdjr3jFMQbh4y8/WksLn3DL5NcVerPaRM?=
 =?us-ascii?Q?UotwQZXV6TLglSkMIUIpI1GQlHbP+GX7RtVNvS0G46Tfxh2KHZQ1xjlzV33Z?=
 =?us-ascii?Q?8FO6FQaEiqJSI7w5zlBqLA95Px5ZGbDbN1eKI2PwuVqkYAc7f8ryacEOV6eG?=
 =?us-ascii?Q?n+LmI2qsdxg7Oc810NDN0OPvIhzur459ibFMJ3SJyZUpavBO+DICv5ncwBBZ?=
 =?us-ascii?Q?FPZop+gTZwsVy1CIzBOPIw1+8XZzhzt0r7taY1b7FFtGYpF5F8hJQVCae6bn?=
 =?us-ascii?Q?Zi6eTuUamjBhuaK6xy1pGMmx8/5xAE4J3GcNGn2powkchQZ2kbygbMc8sgaH?=
 =?us-ascii?Q?cQrjprJGOhSEY10PUzLV5hfmtaJNs8fdubN6K18GE4asF1RfwxQsKWl6/CoH?=
 =?us-ascii?Q?1DQ49spIVZn9fnzAztnxdTI8bzh5bEgDz5MSuF4E9FX7Zv6BWOCYasbv6sMP?=
 =?us-ascii?Q?HgRu+ejmu70Y5tr3euKsdD+XIl9hXPBe7rLA?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8189.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7Rcc57NYnyZ9cb4UtLh3HNXRVMtpXrueznxyzB72pR7XKzSu7vzVJYcZ64rt?=
 =?us-ascii?Q?CLW+hkMUL2BJ5qlfHberEXUWt7xxj2kW5mRkym1zOn7Ax+384Jdo7z4Mgppy?=
 =?us-ascii?Q?NkiabWDbpmolq2zlznnttr1o8+o72Scj+Mk5khwzL2T6ms9fkA0VegYZWgX1?=
 =?us-ascii?Q?sZMZC6RD0Ox1nk8jKggFNXgrKtoMA9uh6mT/7iQaKHTSU1daLiytewBnpUMZ?=
 =?us-ascii?Q?xR45GjD3EzZ5r96I9LuZ7Q7N/YV8UC/rgZoOZyXZy7+MOuWs6v/d15ZjaUYt?=
 =?us-ascii?Q?6vp3h2c9iBtwevymPpsgeXki5ZKVkqJ7NylvrLvf2qKx2ioPbqrNCBuy45wW?=
 =?us-ascii?Q?mqYpgKabW+WYJAR6RyFVvqiooaSqZolMRDddCshP18agIfvECBfNrwGQ1NlC?=
 =?us-ascii?Q?UGVOLKiLfAaN+NJnjlBoIB84j5o/RE+o91DJGFWRkHDed/xtn3xxan/KF4xE?=
 =?us-ascii?Q?DMMKZdkjDP2MSRsnA94Y93XGk6x3bSPtYZWxcm3cV7LzxKNpNXef2KvCa97J?=
 =?us-ascii?Q?2XAB21noty/jpXMcCOh6P8j84QrvXIlv2ypmfUUaJCz90N77vpTuYyDBPXHw?=
 =?us-ascii?Q?DnhyWbjruUauucTQOb9eTUI95xuUFApkLQQpkgvu5Ofss6A+DkvyQc4u89eJ?=
 =?us-ascii?Q?tw2ZSI+31oQvLXemr7kfG3Mp14szaFm8HqrqE61hwjwJo6kHyRd1BuZ5Q5vg?=
 =?us-ascii?Q?kwQgwoyBc3sx8bLlz+eBkftRUgHBjvhSe9tLT4gA/LT6a4fdYxgs0D/fhTqb?=
 =?us-ascii?Q?SPQjte4zDDagGjr3pnaQQ7+KCw+f6/OxkAjrSqBtBTPBUC9hr6C+InnRMYbH?=
 =?us-ascii?Q?kvJE31T0F5sUuKTAcSsorM9pUD34+kspyamK+mqeajSGsKwqRC0v3HcV+1UP?=
 =?us-ascii?Q?l7EcL2fo/MJxvC0zujBYiEKobgGfp56NnzewaEVC7MHBtDsg8fSGZTWW4hbg?=
 =?us-ascii?Q?OWQx48bOz5sKX0NcRV3H+5+YOd4adme9pseVS1lYRGNgbN4omSjArLZYc6fd?=
 =?us-ascii?Q?wtXlsiMILIPVT9+JPKO8X9ga8Pgjzu2qHal2BpXvm3VWnc3hEL5f6UmJQURi?=
 =?us-ascii?Q?xmtZEh41ssPI0ObPCXf/K2N23VU2O1elocc6vxyMUc4d2suXQHXWqPEfD7+n?=
 =?us-ascii?Q?i0jM2LlNo4uxxlNmv0qdMeJ4SE9WoZia6QYABSndfEgMYF/qyp9LQG+u+nLc?=
 =?us-ascii?Q?MeD1ZKCG3/uS1jJxzEC2XJFVBL7nRRtNfv7QHmpVR9ctbPtwULn1gGJr6Z2I?=
 =?us-ascii?Q?vderjiiojthbOfyokvgNNNA3bAbJnN3mo5yjXZiec/MGVV4X9MpGPmAK24eK?=
 =?us-ascii?Q?q3czVcyT7L1h1CntmVIT/vRrpchTjCRWREmpoSXtoM8xFNCpQw8OmZfy4lS5?=
 =?us-ascii?Q?KKXXwke1k+vZrjDrlffUwtYr98sryrgH5j+SoYKzR7s3Y4H0omonmEoZ76af?=
 =?us-ascii?Q?fEAc5HVnSF3ueRacap0m18Dqc3RIuoLFGqZvvk9yxTAWyUL2RQ/OfuT2n0hK?=
 =?us-ascii?Q?GfeHWaWe7oPww5h4z29GI28i4N46kohp7DXGaUepNrfxxNc18wNQkR56x5+i?=
 =?us-ascii?Q?m7ps84+c1QnyOcDHAr1hGK6W9dv2j3LYNuNAntn1ez9HGQeWpOr2rk+9nqt/?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23db2c9b-7101-4c93-1411-08de15352f38
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8189.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 08:45:30.4603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qku/7KflWlp6V72OQsGSny7VAlnVEzt+hLM/l2h74pR9ILvFNsV7RXNHmYhkWuDfV3MQJXYXoXaw64URTLhXOs2iseqSar3WnYvWypsX+r8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7298
X-Authority-Analysis: v=2.4 cv=SuadKfO0 c=1 sm=1 tr=0 ts=68ff312c cx=c_pps
 a=41oIdeUvPxzefjUhlJkc5Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=tUg6EFNUFFAtlYByzcIA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA4MCBTYWx0ZWRfX7tw+otvXVX+r
 CuO19YcdaZ05vMtsC0M0Eg2l+6EB5PquTqjJe1TFLN4z4Ozs9XKQuSHERIDoRZzjxtiZ0NwKX46
 zHGOvo5cp5ZjtS3TPwQ0dD80xH+LUa5ruewJfleIahJ7jWzs9nSMpshs4cQ3pNZCaP6QSILxtWM
 joveovPPUpxwcYMbiuFv9IdIcQTv8irnJ1agp9vFaNt3hwM1LdnztzBH5Up+Agz6a8w9x6LnZOk
 NnGJMPuGWEKa4feCZ0WJE8m6jNDy6EjxHJbhuqG8EGAvXPlFbfB5c2mQFe32YwrTIw+EFP1VOVF
 sDnAKRCQYoTs7HWW+ftR2fjIswBKPxwou+GfHdhumSPjkG+08dDe4O/tGpKqeOvpwmF5Pp9wTcq
 8aT7VTtdUmjAiR2rOS/VS9QHSO1Ykw==
X-Proofpoint-GUID: J4SKNYi_6EOLg3CvLszO2HDkHTRH1w1I
X-Proofpoint-ORIG-GUID: J4SKNYi_6EOLg3CvLszO2HDkHTRH1w1I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270080
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Oct 2025 08:45:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2392

From: Haixiao Yan <haixiao.yan.cn@windriver.com>

In Yocto, there is only one Python interpreter (python3), and the
auto-generated "fail2ban-python" symlink is not used. To ensure
all installed scripts can run correctly, replace the shebang line
from "#!/usr/bin/env fail2ban-python" to "#!/usr/bin/env python3"
during installation.

Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
---
 .../recipes-security/fail2ban/python3-fail2ban_git.bb          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
index 4238c9f59f82..cb7a4ad4de7b 100644
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
@@ -40,6 +40,7 @@ do_install:append () {
 
     chown -R root:root ${D}/${bindir}
     rm -rf ${D}/run
+    find ${D}${sysconfdir} -type f -exec sed -i '1s/env fail2ban-python/env python3/' {} +
 }
 
 do_install_ptest:append () {
@@ -57,6 +58,8 @@ do_install_ptest:append () {
     install -m 0644 ${S}/README.md ${D}${PTEST_PATH}
     sed -i -e 's|^logpath = README.md|logpath = ${PTEST_PATH}/README.md|g' \
             ${D}${PYTHON_SITEPACKAGES_DIR}/fail2ban/tests/config/jail.conf
+    find ${D}${PYTHON_SITEPACKAGES_DIR} -type f -exec sed -i \
+            '1s/env fail2ban-python/env python3/' {} +
 }
 
 INITSCRIPT_PACKAGES = "${PN}"
-- 
2.34.1


