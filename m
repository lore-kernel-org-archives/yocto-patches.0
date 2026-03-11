Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FCDFD062E
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:36:37 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14665.1773210989067893924
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:36:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=k0nGdNYm;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B49hOQ2711153;
	Wed, 11 Mar 2026 06:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=bFZc5xJ/TvTV8AhL45TFCAR6bz2x6rUZ2aoXODq9lVU=; b=
	k0nGdNYm1NL4+zwYapm1B2l93ZmoXAnpRtNSIzJrVEQYemEwzeYFGUJPXOpgfDIw
	XIvfCAJr2kyNbDRCMy2PHkxCNbgW538neFNukgP5ZBBWdpg+casG4ej8UL3yDU0M
	4DRvuG+UzCWZvv7105AAxQgMbTrcPxGczNXhzr5mNSKWXs6eaEfKO8d5iqpaq4l8
	1p/qakdroHHCZxy5i2OBEImbb0w/F+pP5kWEXH2/2Yk+RUG++XHY8awNPrOu2WXj
	guYaR1yGz3r9NsgQGpi3PR/yvgqof9hZe0Job2aRF7Eus8UbpcFAjBEMLUkmHHy/
	WhehNtWSHklp0OtgbyAzHQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty22r76v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 06:36:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7bPiv52/VrqKvoUCcE8hAZdxy8lanoT8ynad0A967zTeybPsUzw6A4PnDNf0m2LLk4Ia4TjTSUV+UgzLM+udsKUX+xkPJ3LggLBZc3pSXSSwEjV2QYEYdohAadY8DK8R5BzkWl7zvY3L/S+OuTGeHAnuYf+2VkVKWX/L0eAJ6m9MQCrotaMXCHLwx3XsOwpw9dCE6OA8SyzYl5YkdxHBno3RFKc327r/TGS9vD3M7n8iCvXn5y+DUmQ6K0t3y1iLtiCNRJq830yg5ZlnBsqgJvC03Y/9oXRIGgbZQmhsr9l3Sr6gZ+8ukpGQDBjV88njd9ucDUU6zN8SilAU6GhrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFZc5xJ/TvTV8AhL45TFCAR6bz2x6rUZ2aoXODq9lVU=;
 b=VZlofBfBlTetkzv79pbbGzB+YK2nVb8wgLM1i5vSvlyg7NrhR16jbDD96f1kQxKerbZSER7y0aPccPbBnmKdDkknOh+dOxh0ekSrgEJt/KeMmESMmVNoQ7uCqF4wFRGrEoR7MPEn5zoSJdF0VXQbq+9S4tLinv+7Ss4+YCfsehYYGDk6REJhLy8aVs66X2j25WsIudc6JvCSjz1KteHQECzUNR5wbaiflVjXnLzVWKRBE31J5rYbOpTWybQxYBeFgxTqwO8nRu6TjZz97yTcXfUFwuC902B82B9gL8Dg1aDhvMqgp/I5h+YBDBu8YgDd1oqGHOr2jCm3/9nfWyQk2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB8787.namprd11.prod.outlook.com (2603:10b6:208:598::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 06:36:25 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:36:25 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH 06/11] modules/utils/git.py: include repo_dir information in the raised exception
Date: Wed, 11 Mar 2026 14:35:52 +0800
Message-Id: <20260311063557.229656-6-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311063557.229656-1-Qi.Chen@windriver.com>
References: <20260311063557.229656-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|IA1PR11MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: f5177acc-f56c-40cf-1cdc-08de7f388475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	Bjxg/ozmlzy1b6Xk+U6ACafWnH+nAP6fhHNfSgHvKM1md/Dj8PWNr9lKfTpY/fcRc2Oh3CZMEl5jmPl9nqDlpRE8uO5eRil5JJ69uuxg9OxAK9lHmx81h2FeILctQ83tvSihUE5pwdTIbi/KocsE9ycBCqQFmipr7z0QWProKw+1z/reT8ZmNQOhLrjc+tmrdfwBW3txf90BvHstGqqu5Ets3Zf2cOolj/7LHgjXu2QzyFgkSuu+Pslw0fCXUEUOd4LpYL+yXgYx23wU1oIXxpOMRwBas1l11eDEsc05FfJHd84TAiJJ5oVLcFlG9sjk0nCfBftAKZd51eCX7Ou3CGi+K8NaXgfY85cbXAU9hAy1UQ9V/amQ8xWhhHeqgYTOapFcP0HzqqiGXG4AuiNWGlPBNJTpJwX2nwQjcgynIl/WXNZZV8s1kaaZcvYrHuTm/vkqEs3XIVJOuCnQLrhXEnkewFJz8/s3uY00HPE6FedZnWxCuJ8Eg+E0ki5avchQWx/Y1WJOIYL4il7HwMgh2aWL57xo+g2Ya5mpFCsiU48fCkuCpgFQJelApQcZHfOqnddsuSk10NOkRv7SKFxNmKG+Q1dH4ixavPh1MtMHgszZ1teNM5iSvt97IFx4JQYE832EOH1M3U4LpaCnuXbTcVLAMYUwjw5aaoh1J07ZOFkSWmu3tEnVAjUrsdNiEaBx77m22ecLBayhVYCEn77IWzZph4/82Je4SKGr0htWqdGFNuFrk8zXmm++mwyvkZZlkFpAhxtiK8LudMhCd5cOgcO9JeA8kiMG+RnuOkmZE9E=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YxvjJdv0PPFdTI7J9qOn5mU8vvytUJyzmcP/Sh9nW6n7/aFrgzjJMMNj8YXR?=
 =?us-ascii?Q?QTx6qHQ0YmI+cubaJKeEWNYGsnBN3wzEFZ/F83OB1EYNdJ9Wg4E4DTFg6eQd?=
 =?us-ascii?Q?JpWc3RLixrNpsIK7ddrXysT+I8D3YaxowqcY+EUlqv2/xTbq0FmTDrlvorAi?=
 =?us-ascii?Q?ZApjlH5Bt/3CCekTcIusN5rPFQ0UQ47kHgksQIS0ZUtBy2B4knzCKuKpmYCs?=
 =?us-ascii?Q?N7qsSDCzjyhx8t7wjPZAU5CvBUjabqgR+WJCDijc1fRKtF4RIm0HnLMbEmy4?=
 =?us-ascii?Q?vDtV5kHSg1NemETnIowdQez3AJKLl9nJtoZ37NlDZC/X5d+Nf9YSjddUhvOx?=
 =?us-ascii?Q?oU1GZQSb0N8kKI55ZW/ycY15VHQ2ee53gneTghlyB7W7AZYGfzpnKkM/TLVO?=
 =?us-ascii?Q?94IiP3MldQP7y/xVxyBF28mx5Np+PPdm3dubW0Db4t6FaJjvgCMoPAg4KS0/?=
 =?us-ascii?Q?C/YKaGFL4KgWo8BJmb8jLxARvCYzna8ZDFHwHRn6RJxAPNYVD03t08Fu+uPw?=
 =?us-ascii?Q?wQ8pysGNXdGnCswWu1z4u47V68R0evEgO05zC9Rjr3Y3vfWuyY4fI23on3tT?=
 =?us-ascii?Q?y/rRf26r1Q/IXrI5OVDPBV0OuakDK1+ebi/g0nxzR8BMygCSzgSIbXjCFVVw?=
 =?us-ascii?Q?HA0/jv4dgdABcOAsYrYwBu6KtgYYSiUZLtd5K1xoUobX6hvFylxlu/grRXS5?=
 =?us-ascii?Q?DmAsYfyk7mDh4G4malmWFPW6zZ1HHHCs69x/NAAqJTdN85tRIrFpclyrxiR0?=
 =?us-ascii?Q?LKTq0iXbjARoAqwhsh6r25tiv+zy0rrgXqeZTFt9N2yPPEhut8FdC2o1Wq6o?=
 =?us-ascii?Q?c+grD4I74G4sBRXpcNxh7GwMeGgrMg3Ir6eakIAOG1fuC793F8XfOtD6k9eV?=
 =?us-ascii?Q?zU6HXs/q7DNwfOnfyvLFzQxzBpd5djeuWVFnvcIAv5Z9bKVSzW9fSiJAR6qs?=
 =?us-ascii?Q?40y433XWXsa35/WSKN6m8mjiPPjrK0M0GZEg2MMgANXd4XfZFskkXOruWjpF?=
 =?us-ascii?Q?fWwJA/U0sVwB0LsSsQM4n69hqtnnftEaRTJZMAocED5StFDDe9pkOxTcfVX6?=
 =?us-ascii?Q?cSI0X2Zd/mQzGgW8xoutCZIRtoY7FIJBeU0PCNCPUyXAP2RlKHsGmPJ1w1wb?=
 =?us-ascii?Q?slCtm3MAV4wyefZTzSgJrLiLBK5Hj4Bz123MpYVm/cQeyAsght+dMJywQfhC?=
 =?us-ascii?Q?IkjmIwD8E4ZyHtW8pG0pcBqCRLLtogG+y4Rzfw97//Tp6f4c5xMUXoXz+Vhl?=
 =?us-ascii?Q?UWFkZ+61YK6alIluaY7GnFgHVe9eY6akfw80itROCXReADZzUixmeDZnJAkn?=
 =?us-ascii?Q?DgDEmbHknxNffue7qb1cP68udSbymYYX5lWyUFFf3K4hngeNhBhDl6a+9Ymm?=
 =?us-ascii?Q?kOojvTcU1Y3gu4bftd/YiAtJ2Mod+IEgaTgk2fQCRmqrqtPuq1B2zqbZx8+H?=
 =?us-ascii?Q?A9V/dGRNDAIjeiPj3pZ8EUGpPCJnnrBs+o8FCXIl6VoMFHnvWMOrJbnngxcM?=
 =?us-ascii?Q?TuP3QAnDsH0lN9g+nWlKmBonRwlFtDBeuhvVpXt8eKEVOXQY8F/ilqpdnTaf?=
 =?us-ascii?Q?0kS0j+iy0kSS7aFz8WOLCcn5IbSslD1elDrf8kQ9bMe+cPAuplM9OdaV8jGv?=
 =?us-ascii?Q?9mw+C79rOs6kwcdGSdB3Cu7FZ1vu6NB+lZGs7Rp0O4DfwEqs+DTA7rIvAX3E?=
 =?us-ascii?Q?pdf5sDJ21aQXx/IE/pR4Oe83WiAGEMePW7Bxu6Cq2ZVviRh6EuaHGMDnBtse?=
 =?us-ascii?Q?fTr+FDJ6Rw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	E9M1slj7mb4VQjMSDUOKQFlsXw4fzDt7AxU5wqGHg0PfHNwzeCIFT1AgRVDAJ2LouFDJNJO+/C3BF56GWAVfIXQyqpi75mdsIbx89RY0PU6ShTiyvG6rUIXvINt6bhcMN6qmtJCM+INurXiZOIzyUpDoPLizR/BAZ6AHCvk26gf+7kqrlwdgqDgMwd6b4iPiLSlE/11yP6qnKH3QXxjJcGnunACFLzlissCmgvdHtA5+3rW/25ZR0kUO8iFxOXob+T05MtJKncLyY58B0dFthTWOc55XpWhudZRZbTWhniNiw45+//UKlFtw8qr2Pvue5nImFfuVmNqSkJRjAOzZKw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5177acc-f56c-40cf-1cdc-08de7f388475
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:36:25.3400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrUkSnPOBaPAjStxjqDhud5bPgSknk5NZU2qXy14HI10wuear5vdo5g+514BC6j9woIkpr9ro5q03WGA5GMDtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8787
X-Authority-Analysis: v=2.4 cv=LqOfC3dc c=1 sm=1 tr=0 ts=69b10d6b cx=c_pps
 a=GxUr472PnxEa6H6od3s2nA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=jz8R8Z8616863Q2mrucA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: rrp7oohj2KY6_q3Il1rXPG04_XzaWu0S
X-Proofpoint-GUID: rrp7oohj2KY6_q3Il1rXPG04_XzaWu0S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NCBTYWx0ZWRfX5Uukwl27OvFq
 MeG3hK1VhbMX0wjqEBHfq6+XXnKgpNuj9ghpoabcjYs74CVu1OWspfkaYq8T173m1eGoRgNkwRB
 EXKtSj20+n6HQnzXTLPN/HEij/0RrvGo5IpINRba1ecDKKgT9W+1JLUB/s3u5394I3gztzptWcs
 WdXoctHWbheiAilFp4YnL9ljxIcRA8yM8cEsd1Q2pw8wbxXVrao8U+aJT2KScPkwiFHUCunlrQz
 PoLMBscUCuZYcjvJ4qTvz4ORPuYdCZEApNWKOtVC9/3GKNqCeEbiSv0c5vEmlVl4gkPY2BzvZw5
 uJMawbeSczUaON/8kuV5wsCGKJuqBvGhC439wWhNlpaRcil/EJye56kzFtQ6Tw7cKoXLt9vUzZ2
 iKWm8efs6WOBMM3CWuu0WFY7UaY5lNPDBnGKeggPLEjcLdCwfDYKHVRtmRrx9tyFFWWOmMtrAQQ
 aNjyHmi/3Jj6RXXe5Pg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110054
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:36:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3407

From: Chen Qi <Qi.Chen@windriver.com>

This help people know where the git command is actually executed.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 modules/utils/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules/utils/git.py b/modules/utils/git.py
index b504ab0..38c6a72 100644
--- a/modules/utils/git.py
+++ b/modules/utils/git.py
@@ -41,7 +41,7 @@ class Git(object):
             stdout, stderr = bb.process.run(cmd)
         except bb.process.ExecutionError as e:
             W("%s executed from %s returned:\n%s" % (cmd, self.repo_dir, e.__str__()))
-            raise Error("The following git command failed: " + operation,
+            raise Error("The following git command failed in %s: %s" % (self.repo_dir, operation),
                         e.stdout, e.stderr)
 
         return stdout
-- 
2.34.1


