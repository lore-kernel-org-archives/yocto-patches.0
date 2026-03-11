Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD2DFD0634
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:48:37 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14796.1773211716348062694
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:48:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=HvWxB2uc;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B1stek2572456;
	Tue, 10 Mar 2026 23:48:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=HSdBEaLMuZxEimeuPZyTMklM4Rx9REu278g/fVOyl+4=; b=
	HvWxB2ucOOP9WSKEkPForkpvId98Ac9p/jsd2ntqHsqhPkT+Gc3NVGNAWadpDdKc
	eVLvEFRYRDbwr1vkkpOHiRECpq8WQ8xN8PkJkfl3E3hYACSlkw9p8egJrZjfqXsw
	IIT1iWKH1X35uhliMSj3lUE+Lm0gXBqc5atVvIiX9cqBRyk2+1yRwJqMVMp5jOd1
	3MR2LWpP2TTme7Ickr6cS9QEczO1ouH9hvJ3HSjMpqZ/k1gGHhvCk+qj2riO/vON
	joNX4+9j4dpPwiwjwP721iVzRYuhfeFiXWhIpj0DwRYXfBNTBcmLonPFF4imCplb
	GYnG7RAlpGssvOCfRJsXCA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty53075n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 23:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZC1omhZ5yR24kClEmxEb4nBVvwMN/rE6FIM6wmnbnxchew6gKZIa4mwkio+HUFfpQ2zRr2caaqc3XguT1GLqor4BHYGFXjnj3kE64nnnqcPC8evaSwyx3mK1piYV14TNe8dCNnG0HH/c6fwSKkAjnbRZKHViK9hNm/8qX+dZdoZ8avSHtziW+J5E95DShSJX64RHkyHc6FFGIX+KBDxtLjW2Y3WpUM8yxBc7ZESdVqNYjDOsscBl/DhV9g3XHa0morv8lljig2CwJnG4O/oG4oWMnQKWZkGjjQZABrzmqvDr7x/Ax41fmE0Fwx9DXHH6HACK8r6hXRZaceQlsVzQAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSdBEaLMuZxEimeuPZyTMklM4Rx9REu278g/fVOyl+4=;
 b=LCrukSsVC7m7SoEvFMT8e8SO2sYy12CDrTyvslW3fFDMwMK1x4SGggjRiiHnz2OZPjiYqjHOnE+E5nQA3lHm2Ci5mH7f4NrHO5nd6GCC97LUsZGqDr5QhEGmePLeOcrD4NSLj5xOpGaOYvuEpDlyw7k9zr/Qv6WVAFUMpe6r1ElpQ8zY75aI4wEwa9z3eqXkfwmToIbTeVh2hlVCNaWSZMZhNWuhAS11cjgodf7+upwGT+l++PW+3SilM9pM30QMY4YSPDeQtvtrOv6R1ZKLTk/x5DwUpfYyTLHegrjG5OAfhdreRUKKmqy5AbWscaSQdyVcxTGPA84E0y/4lr6gvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SJ0PR11MB4974.namprd11.prod.outlook.com (2603:10b6:a03:2d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 06:48:33 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:48:33 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH V2 04/12] modules/utils/git.py: use warning instead of debugging logging for git command error
Date: Wed, 11 Mar 2026 14:48:05 +0800
Message-Id: <20260311064813.619683-4-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311064813.619683-1-Qi.Chen@windriver.com>
References: <20260311064813.619683-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0181.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::7) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|SJ0PR11MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: d7adf8fa-80e8-4a4d-360e-08de7f3a362d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	eqitpB8+63UTZUBbiWmDAvpTYH/BmR1mIslKoZbmHozd6T6slv7B7vEVRDVuiFORR/OqoenzkM//NmX6JlWV974SNdI+V2POBRO5c1k+CNrvU4dBxjDwFWUCAB6jQPUj1QjqwJwkm3oi8g+ehMCb3IEif4H8HYNp8kLLSAcIAc9/iSYOK5YxukoAbWjSqp/0lZIGmYzalomDwf7mI0fU2W+nMdscegpvrcIUA4bQo6wgQgjD4KYojB3iQaXsppmSeOaLdsTX/600NqzyvrGySjZeSS56/NfipqpP6ww8CSYCPi71YgBc4og0tge4XOvDCv+JbsbBzca9Yt9zRJO0KQ/SJekmR6oBDYqxDcTmkTk4F5En4A/wIIhNV/Kk3Wef2UIuZYz0SUWnILfyVunMlKY+AI84lZOqQh4HX5TcDG92ftjb1MNWGv2udxv3jddjZfF27ofwnLh9vDuRisfwmQDEPm2/PveOw0vrkAEoRMzKrkt5FMe7v2MfvEqs+5+K/851zxDbGrQhnKhdShUI6ynl2sNfJOqPFO5VwTvk0WwbATrEZJMuZ/nW+sUBe2Xvhn3aYPEzSbwuGkghh38ymAzYeFIOQrrGZtPay771mKYNioK8WGBT7oEqSBXfc9by44B01IY1PMQAZladW4671+iAMWv2vmo4ai7Cwn1pRImopzDIUS7Cx6ihQdWV6Otmel9ZB72zWcDhxCNN1+M0QacyfPJ78R/rJK58151YNudrTvxBmVpF3s7z+jIs0dcidIAwLE6nm/wnGoaTrNgpr3mM3VXIx7l4zrlR851wavk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?t4C0VXTzet+F1xVfwxlvqOd/Srpxo0cbEIEf8XnFLhhCkxTvUq9Q1xEhD3ZC?=
 =?us-ascii?Q?kuUs/a6CgcKhWgaGb35bLDAC12pQ8RFR4ttDb1ob0xDjE/hz2eabJvquGpEg?=
 =?us-ascii?Q?Keg297P0HhmMxNqfiZfMiMkMqnq6q2WgL8MMgJxdpcvMRJ5hvcpO8ataZQUX?=
 =?us-ascii?Q?wmzZwzS0fjLXhUjRBaiFQLFPOTnbNf34AwKD+osbshQV6FmO2E4co4k31Yua?=
 =?us-ascii?Q?EQ3/wAEnGETzyzVdBlR3/ksfVcVd9qmQEzT7C7LJ+t6RzBSpPn46uR5+AowT?=
 =?us-ascii?Q?IHHGylBXs5waoGOkx442HFq7wJpRo3lILd3kY/AN7TMcsGq901j6bBxj+9rG?=
 =?us-ascii?Q?w+a94w8D6KHA5LKJKSeNAT51IsWes9/4HuYOKNEnjPGt7W/J5dvAf68v1QDe?=
 =?us-ascii?Q?qnQBGxXvANf9ZvO+VJHUAhxqucIz2ezZuUM19M0yQyaryK1HBVF6Ror/SDQB?=
 =?us-ascii?Q?u8Bom20752cFDVusuVOs2iHHFSyZggbI1dClU+L/cn+s/kVN66IURlXHqtSk?=
 =?us-ascii?Q?PGcsW+NT5Mjg1KQQfWKZ7bVSyByt0qDnI9Ccd09DUALb3g/AosQHZXCngK/J?=
 =?us-ascii?Q?0uMGSH00E4D99D5RYNCcG12+d6y+o+1xoSjmxRpdlV6B9BRxFSVeAbdPg4N7?=
 =?us-ascii?Q?fKSb6nVQR6ukC+b1N5cGuvqVozL7nDGtTPDby3FjTfSSGRivRyd/ke2yAQZj?=
 =?us-ascii?Q?ab5avwi2+QhHnP9K+puFGsg7Rh9uSbQ29Xwtn+kW0/xgHqkORa7gxwXqlw45?=
 =?us-ascii?Q?c2Uf67guRSHPk4KNk/D7Ke4P6vfDixOB/l3Fd7xWlC1LtozcFGgrEC+FPgaV?=
 =?us-ascii?Q?ndp5hVx/rzpqCXvg4CxCdPDqDYfbke4MsbXRTHHnzlXA1sO5x9l2VC0WZqcH?=
 =?us-ascii?Q?ROT/7mDCF2UyBFxaYoJXxOMajM5p8IhMURESO9lQbEqe/H8tUaCIVBuFMqjD?=
 =?us-ascii?Q?voHbBZG5zrs7Mie7S8RGk2P8XUhv9MQaMd3eP3Hsq9sbfnXRX7ndqV3xlpxz?=
 =?us-ascii?Q?TBgCeaQ3XmbMc8Mkv1DTTDt4F/Ll1Zq+h3BIhg74j5hwbAB79gQc2LVb6fQR?=
 =?us-ascii?Q?o5kCuEtmMzkdK3tpaSJxb25/DUdzKBopozYgT8nejMteBpOiIlKS5ynDwwNf?=
 =?us-ascii?Q?jPdOH2uMUN+g0PH9wx7xE5dZ8GURZYJoqSYUM3dP3UuViJdFJVhl6CviAP06?=
 =?us-ascii?Q?/6zFCDlrxrL9TtEqht8MyKtOLcjTN1GgZvpsawIDhYkrR++OlHgm7mGwr/Bz?=
 =?us-ascii?Q?jWKpTrGuw1GFnEuDCCn6EfL5WfdrGOUfdJ/EZRwglDM717wbme+60+Onwk6i?=
 =?us-ascii?Q?ne1OmT4qXcsvt8S41CVHkw/C9OoXqDj7y0NSvezbF8Aga0ONc+46f5PUKBH6?=
 =?us-ascii?Q?268k2bM4Ei3YleHr5nLMGOl5nPhBwAw6ZXlD5nVoI82gcoOusBK3OkEDRjPd?=
 =?us-ascii?Q?6P2Z5aAzIvd1+GJi5Apv8vZ3oZWhulk84V/50fkOZa1+ezh56Gr+v1/0rZoK?=
 =?us-ascii?Q?CtL01SFe/IMzK/9gJtbc5AQLzt83fkxbJycb0UO2oN+Kdy/6vvEX4LvJFRsN?=
 =?us-ascii?Q?4cqC96AKBCK9uSMp8CERbFXCN+SXPXSm0VDYeM6py6K1D5UDSUrs3ZGq54qr?=
 =?us-ascii?Q?58mW918/9vYmVPyiXhlUUmUxn9BbZQDFAy5DS0RfV98lq9neCnozWz6yGMCD?=
 =?us-ascii?Q?q97s1moiHgeW12LhZzv/kRGJTS8XxDnKyIWD23u2zY6bGxZNBFQIc+3Y7H4B?=
 =?us-ascii?Q?MrMNg0nP2g=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	wh0eDo2Km0Q7rM6GsFkQZRoCyYJbIlsOk+MBn80FyBXQg0lZuhKOmICoHnlyBGErNA4FcfliXgDr3OeyP3Kqwfv1nbGy4wAPDBYXwxwmmeFaks/WYqcxpqMXh2HMRX2zA5UEPw3GF7HDU3DolSbrmiwbZu85OY7ddLeJQAdTu6yNMRaKx9/ldzR601NQwQgNbNAnCDzOtqK5sGvV1c2vDTN+FT5ZaSxpy4QMMSBSU6x8BhOH8OlXcz9Y7+PYXrqUJh9I6uVww32jQuMEiYlx+sRP7LTMMfNNMLD8XMBAgqeeYU9gGuVUrkTORHBCMWau62pSNWorfrl2Q3CqHcf50g==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7adf8fa-80e8-4a4d-360e-08de7f3a362d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:48:32.9418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLNrLx+TUGDrz0A1UeGjeb1z5kDoZw19eymqtZdl8pw74uWgIHuDxtEILSf57e+ExMLyJCK9nHGrfpbnfkdkTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4974
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NiBTYWx0ZWRfXwAj3TvOpDnX0
 XdPGGpS92MliwvL1frd6giiI049F+DkoC9qS3HvhJvYTEo/fgAlN9iYB5flEX8rp5RbAc9bHovs
 fkFrInjXR71uTk8yxDdvTzQwEwbVG4Nkbs1esbwZPHNGYxRdtoss2c+zpfn4DoPpOEVrC62hhMl
 aqrBHEpRE0LDJe+Bhqa2SZZ4VstJRpylB0kV7TshkmJJL0pzjFP1ALi1ILlLQcDIBKNXKLG6KAU
 OhlTHKqOgZ8UIhCU169PbdZ7T4AM/uT6vDh+QzP8JS/I+SMkkbCXoDo9JmEgzkF8hlUb4Nccom8
 A+uJckvwFQo69/J2pA4W+G5YZZNJAbgc45a09yd03V4Re0PtkIa/a13siri6rg4ePmZVALRHeyp
 w0oSGEsCsw5O7bYHUJu0LbU3G6t9atd64pYuSmup96O7x/LgAVWW2heyiTY0twxKk8MBN3/ufXE
 k+EiClA3DDv8Wrm6lgQ==
X-Authority-Analysis: v=2.4 cv=PvWergM3 c=1 sm=1 tr=0 ts=69b11042 cx=c_pps
 a=IzBZuH+2DL2Wyeknq0uBXA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=vHUYwgvStcVnrVGJbo8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: aC7OqnOla5jgDiz61Xh9x99fTYcI5HNL
X-Proofpoint-ORIG-GUID: aC7OqnOla5jgDiz61Xh9x99fTYcI5HNL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110056
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:48:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3417

From: Chen Qi <Qi.Chen@windriver.com>

git command error is obviously critical and should be presented to
user more clearly.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 modules/utils/git.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/modules/utils/git.py b/modules/utils/git.py
index 3be75bf..0482d26 100644
--- a/modules/utils/git.py
+++ b/modules/utils/git.py
@@ -24,7 +24,7 @@
 #
 
 import os
-from logging import debug as D
+from logging import warning as W
 
 from utils.bitbake import bb
 from errors import Error
@@ -41,7 +41,7 @@ class Git(object):
         try:
             stdout, stderr = bb.process.run(cmd)
         except bb.process.ExecutionError as e:
-            D("%s executed from %s returned:\n%s" % (cmd, self.repo_dir, e.__str__()))
+            W("%s executed from %s returned:\n%s" % (cmd, self.repo_dir, e.__str__()))
             raise Error("The following git command failed: " + operation,
                         e.stdout, e.stderr)
 
-- 
2.34.1


