Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC01CFA46E
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 03:36:53 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3556.1763696205351802518
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Nov 2025 19:36:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=EnHNrBhW;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=342016e232=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AL1f9gM1433358
	for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 19:36:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=cv68+rI5vasevZFj3N2/
	51WDuHpp9YJiopZYEZwqEAc=; b=EnHNrBhWbRfqCgxe0tRShVksKT9XBB/s4Yr8
	eZW9MtATZi7qUeo9uNvW+mR/HXH43VL7j+DP6gHkUe4OAW2nIh+gXp59t56zOer+
	59b3vKq/V8PJbCNWVnHqnreTTdPKTmhMdmexWFIKxccDFXCBzvEjLaa2uv6/BrFG
	RLI6o6W/ylLGiVOKLl0S1DrQ6BmIZE5S7Tq0627KYKeLepw05ZW+CxFdP/haUzkX
	fGnGz4bYy9AwODgMI+Smxhf2qqT7AAb9y9wqbIla6zvZICkT0tWb3vV+GU7i6MEw
	uvFN5fUIryNYM0aaFPZVEh/vQC0XlUQJdAT1XRXZdMtlO9loYQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013047.outbound.protection.outlook.com [40.107.201.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ajemug2pm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 19:36:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHVfnHV6/flOw+uJ+VNUpV/Drawo3PApHBKLsjbayAnYdj7H9tVVmaiH0ra8o7GbCCvm2H1yZd0OWyicM1TGDSNX5Kj0XA2u+l/L5jpxVwWdR4GEiJvawvsdNI+9X26n/6wDw5tOsL1fQkUqOfKc2Om4Klo7hWsY9AoDietMTQXQ6VvfNbr6NSI8QZyow2dy8C/DRLMdjuAgkGlrjZos49qZI8sEJBOVEOxVGY6XY61EYP3IxahpeAOLmGFZIvpSQlXwQY3rNKLdMr7UEv9JNa4tUQ8Glge2ntSwnyYEY8B/12FRkYGM2fpfbsG9C7CVdJhnEZmkltadXHm0Tp5V5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv68+rI5vasevZFj3N2/51WDuHpp9YJiopZYEZwqEAc=;
 b=aXmQ6onsGVLoDblsRYwi/l/E5OMIvl4AGY8ZXBOOSpNh5GGuYAloU2mQL20y2ep0rEoN4C9HYJCZEh5V17/y9DhT2U3ujftehjk+Ddxx3A15Tm98YvedNyjHqOjlxMSWqURjVR7MBeoKQRSqJxanujMjhUYJNLoQtpfSLMbqv0FDEV1wh0NLlETAC57je3RMT0HE9z4nBtjzGYMuE5ASTCloh9j9FJ7DcdoEgkEryLYHSPFIoFgblfsypg7xKKu56QkZx/yzm6uMmzJHmonLNDeRjrqPO3mqa7Hkf6gbVyOfq9BjjWIkMXVoRnoclqXlteVLjRU/T9qEjAAUJ1JTVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SN7PR11MB7666.namprd11.prod.outlook.com (2603:10b6:806:34b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 03:36:41 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 03:36:41 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] libgssglue: add UPSTREAM_CHECK_GITTAGREGEX
Date: Fri, 21 Nov 2025 11:36:26 +0800
Message-Id: <20251121033626.3847896-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0090.apcprd02.prod.outlook.com
 (2603:1096:4:90::30) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SN7PR11MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b5b5a81-e4d2-46a7-b270-08de28af2f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PqrlsTxqdUmc+CSq7bISKAcG4ZerllZql8C3lzXCHCd90vwL/kL74a9lqeEA?=
 =?us-ascii?Q?rNcGT8d/A/3FTxZbBul9RDlGwqxPN/KgqEwPx5RWnIG5Jm9otVX9mrVdLOHZ?=
 =?us-ascii?Q?Tp24WudAR8KjZ2ImJtbqO40xaGfwFzyNTEFhLumRA98cY5Cayo42bIAMgdOz?=
 =?us-ascii?Q?bJo1xy+J9fgd6RS2I2UUePbqVQ2dTX+icsTugBlm16Zt1KKG0+1t04CX1c5M?=
 =?us-ascii?Q?bDWWcBHeIecekl/f9c8ZflAGJNlW9sdF/4udbdNBjXc6JSODRU4sfvj9naPy?=
 =?us-ascii?Q?vWMmN3lm4wImq21s0+4cpjY+GW7xwFUnM9XCPdFTFpwRU4bHDWcZTK2kzIjd?=
 =?us-ascii?Q?FD68yhsl6TvbJM0EJukR/vesH08QtZgdLTidar7wT0bfk7OeIAQDB7153WOz?=
 =?us-ascii?Q?CfzAkpIa2Vf/fwspGUcNs3NET+O/GoRw2NBD0fzivrnHV+1tS5UQ9xWN7uJa?=
 =?us-ascii?Q?WflR3T5p3L47Yegf+cBp5LTUrW0tyP3z+wBEBbWSA95JNxKD4Baqztrkntyx?=
 =?us-ascii?Q?YuW5q8ZHtjgRAWPk2aTiZG+roSr2Rvkeq24x5HLpBYNQl9hbOvSA+u5bHYBK?=
 =?us-ascii?Q?zRNWS8zfDWjV1F8dLkrUh7+CWx/GWESwSJRwFttXMM+CkiRYzcnCpqkob2Ex?=
 =?us-ascii?Q?9yHF7xNeoNuid3SJnWmtbIeQtjoQl1gceY0LzzExXKWHRmxWRmIr5DQ52Dk/?=
 =?us-ascii?Q?IYes5IesvBNe14cfF72+fHhAzvlvfbyFTMuqRjPuCddjyqcqyuA8bZBkDwF6?=
 =?us-ascii?Q?BsBLf2Qy/RUUjPPFhzw18DV9OduodWwlRhs9B0NJuCL8rlE4OIe85B/qHRoQ?=
 =?us-ascii?Q?Y6HyXD/04mhQZbFZjiM9GEzMG9Tj2z7o+qow2FwJfHC2aijJXbgxGwKqIyvj?=
 =?us-ascii?Q?Vx6JH0O4FlyZpVmiBMzcB8kicFsrFg+ygpyHDXd4TmSWsFYHaKW6NGFh81Mu?=
 =?us-ascii?Q?ZBONOcQvhQPPrvYruLG6WO02WTx4+I0AOWeADMpq2pcecgyHuqevY0CLUedZ?=
 =?us-ascii?Q?rPpFnO/nZwm24eMiJ/9hsgtuFg4RCD3cJ/md6vU3fPS2vToTmzx02RVcRMAN?=
 =?us-ascii?Q?VINiSJb51OQfC0f/XeqXVqHSIG5mXPb+UKocxH5BBlzlqq9cg/0qx4H8GBOU?=
 =?us-ascii?Q?vHI68v7Q85q6svWiv5Lrw/oWAzUgMuit116ox+xtWHYf4lFBJt7I4qJ60BX2?=
 =?us-ascii?Q?zwYVlf3SeM2IxydaXh4Q9dy/B7MHcAzC31PpmDBm9emL3qeyzzkDxJFlq2z0?=
 =?us-ascii?Q?0jbyjT1PCZ3+btl7eqW+TkmERB3KwqNrAYF/JNq+KvNMMPpRtvyRzGtYQi4n?=
 =?us-ascii?Q?IsbCwKI1gu82w1MBOTbN730n4KWX+hOiRFTvSLz7frBdKCXpnJK6XCTnJN4r?=
 =?us-ascii?Q?CXTNJgTxbYWqMYzePynqseEjWwNcaRByOG5O9fL4+80WupRUK8gMk8hmMcKz?=
 =?us-ascii?Q?WDrTjrkKYKy9z7gLVhIvOFy8tzhhiS0XLt1rSauqDTi+MsgJD+5HKFef+NI3?=
 =?us-ascii?Q?BuUJ8k1z2WgWrU4CfpHifDQQKzeRylmkhpw7?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JMmTTEOmcAmHobg6Kp3T+M50s37QgRgRiitL+HMYNjOrwnKU1kvf1A1T1Jg5?=
 =?us-ascii?Q?v3GC8+pSdxUa+nloUL5SuRMixYcfRiiFiws2X+4madVdrDoCsAJhXowKN+G6?=
 =?us-ascii?Q?uHQSAVTQHaCiKwJx9c1fHePMb1P6kpW1XhOoSrpAXxRHAIRqsyTMp8bXM2sm?=
 =?us-ascii?Q?dIppMftH8r0y6jYc7hUjRqNbRo24QP7BTA75dILaqcx2lc6XWeGeV3BlPWhS?=
 =?us-ascii?Q?W8BUzL9wXdcqm8RJeMYBqgsD/KjU8jd8QXIoGnxzgmHliOcqyn6Eh6NQUdnl?=
 =?us-ascii?Q?IjePVF033pOwE8ekeeYRDFLwQTfdJZOCGT3uGgy25YtqjALvc5jG64t1Lzrp?=
 =?us-ascii?Q?3rY7d2fxJbRTiYQueqQjZZDGthTOGvfJbml61guzlr01BEB19RnB2djCcao4?=
 =?us-ascii?Q?p3gBwoZHK4eLp2S+8u7UUljU2Ifl6Ks18eeb/LpmE74EDdINiNPMR35F1LYa?=
 =?us-ascii?Q?qFiuCw+uDXhWXmIva90bagvsGf+Ml+FCV6G5j/YMryca9XLXj2WquUxzjhQj?=
 =?us-ascii?Q?lSJkKIWjS5ovUvn8rHSE6rgWmbKy28aWikWaF/Zd4GGgotrs1aib8NWr+xmD?=
 =?us-ascii?Q?AaFczkLz/LNMgRYpqPOvS5QZTUOgq5kZljPffd8JSGnriFJVBDYVnTabzsnl?=
 =?us-ascii?Q?P/FrjsdUx/JBLFtibBGOP1p0tFC/TP2pzpFQiv2lL9qNpsxrldEcMcbhq0Ey?=
 =?us-ascii?Q?SFPMjqpDZs40zSHEc3pmaT3/0tuFOHlfIm0RUfMYOlkqOzBTV45n0Jse8hRg?=
 =?us-ascii?Q?iZqlpD/hfwAinwnl8uDx1WB4kXwWA8ywWXUyRu/IV0sRUeLyHu4TweGmWLWP?=
 =?us-ascii?Q?M4MW5tAc3SzwcK1004qw+v9yxE+nAb38e/WrUfrg/1pVxjqroilk5TJl1oeR?=
 =?us-ascii?Q?uZIpEo+yO0nfHv47in2oxNc63jOYn+bmhNmhCPWeggHyy2q30O+Hru/BOf0r?=
 =?us-ascii?Q?sw5511xMbGGiCcJgRZ3CNjFV/RnYYTH5ivGtGSkjIfAhprOzyghLSfVcQNpu?=
 =?us-ascii?Q?5wUnI95ltcMJWo1y5OJ0OyMUd9PLYYoP1AdNQ2XEqi2IWFJDuDZI+3sDdYjU?=
 =?us-ascii?Q?vHItlTZHLEsdZegm7yEx2kZAeanLs0dvQKGhhqht3yL4d4Ptn5p65fBuL7RY?=
 =?us-ascii?Q?e93w2+PWRhyb1dRW1F0jqMVoAAG3XcaxUTTz9SY2BOsnnUJPsICghqKACSk6?=
 =?us-ascii?Q?NQQUKNeuLAkQFCIpVuyanB/fDWGpXTUnMdzD/tLqZeTwg0i5NQMCZ1/Sj3lk?=
 =?us-ascii?Q?6c5uGwp91OaaCm0SPiKOAtW6phqWFo8nRJ2RE6IAkPxmu2l0/XBsy9pzXNZC?=
 =?us-ascii?Q?sk6iZNCxA/N1+VLCT82yTBjXJaNYFjCTArNv8QsFBhBkZrVowwXz6q8Bp+aj?=
 =?us-ascii?Q?GQexMAg0wyUaebg/aLbFVQb4FC1ZMtLuJmADl1gVaiBSEiU1VgncVAzxPpvT?=
 =?us-ascii?Q?mPSimb0y1657zutmkkoTu1miPdauMdf/L0h+hfsdGPoF0o4PS5pKFcI+SN6V?=
 =?us-ascii?Q?N4G/yviW3U9ODcFuibd2iEQEwDO+XfB1DWiB0tqoMYk6vjxiZw0DvYcLaOUd?=
 =?us-ascii?Q?02/y5WlGr+opi1N4xx4TyBAmNLc9tBqDrKDwXZ9N?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5b5a81-e4d2-46a7-b270-08de28af2f6c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 03:36:41.7519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwL9aNdTDZQaBBqyrK8OLReb/WtV7CWM0w2zqFC0GYhnaHwKlv2E4FR5XxTQK+FUiGyM3dm0iGwnRcAxjHC5AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7666
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDAyNiBTYWx0ZWRfX3hiy6m+bn+x9
 dlOkEZHQcYPvqj9lR65jp+EqR0wC1/hz4jzciCJXpQ/mmEVaHqKJlAU8TWvvZCpiJj2zfXlHnuZ
 vy4SgJs+W+mOD8esbXBFmCVnJcYgrvF73qOsqMEuXAtIiT++gtTrwG2MpBzPtS8eHB2GB0I6Tik
 OyUClMNEYo1AmG6WU2CQyxJzkZ6isAHJm2HJ4yrFnjpTSq6YRdYGZjKVw08h6u5uWoylNrUd1qi
 uQDueXwwc6SNHSljac3T1IxfC3FLvXSvvRf9gI9l57+m+4cKGOSTiKHf3edwg60baRhPD4wCE2+
 Z72338NCri3cwaVJLej8AFlEjHtRDMu7i7IsiEJmCdPkN4UGo45x5C6sINjpq4OJGQ7y9jS26/R
 F4vIFAeKqnPLIgArI8tcGcptoOwFEw==
X-Proofpoint-ORIG-GUID: zRRKZ-dJyCTKVZx19Uj5Pcj-X23YCTyX
X-Proofpoint-GUID: zRRKZ-dJyCTKVZx19Uj5Pcj-X23YCTyX
X-Authority-Analysis: v=2.4 cv=fKo0HJae c=1 sm=1 tr=0 ts=691fde4c cx=c_pps
 a=2P5E0MqkZ2zb1j7CzKDU6Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=p0WdMEafAAAA:8 a=uTDV0Q3B7Burbv6hrfcA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_01,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511210026
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 03:36:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2641

Add UPSTREAM_CHECK_GITTAGREGEX to check the correct latest stable
verison.

Before the patch:
$ devtool latest-version libgssglue
INFO: Current version: 0.9
INFO: Latest version: 011
INFO: Latest version's commit: af30789052a8cc5f86b5b0c8fd4758c7ba1505ff

After the patch:
$ devtool latest-version libgssglue
INFO: Current version: 0.9
INFO: Latest version: 0.9
INFO: Latest version's commit: ada76bdaec665f70505f0b3aefe871b873e7c4b6

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-security/libgssglue/libgssglue_0.9.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-security/libgssglue/libgssglue_0.9.bb b/recipes-security/libgssglue/libgssglue_0.9.bb
index 532227a..a00fae6 100644
--- a/recipes-security/libgssglue/libgssglue_0.9.bb
+++ b/recipes-security/libgssglue/libgssglue_0.9.bb
@@ -26,6 +26,8 @@ SRC_URI = "git://gitlab.com/gsasl/libgssglue.git;protocol=https;branch=master \
           "
 SRCREV = "ada76bdaec665f70505f0b3aefe871b873e7c4b6"
 
+UPSTREAM_CHECK_GITTAGREGEX = "libgssglue-(?P<pver>\d+(\.\d+)+)"
+
 inherit autotools-brokensep ptest
 
 do_configure:prepend() {
-- 
2.34.1


