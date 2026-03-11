Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2129BFD0629
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:36:37 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14982.1773210995862195692
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:36:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=T3yFVPPv;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B5kVNZ616543;
	Wed, 11 Mar 2026 06:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=Iduc+cqeeDpnzhUhg8U6NtkjFF298dJiFEA+0W5nCv0=; b=
	T3yFVPPv10BQx8hUe97onlXVQrLxIeKVU9fbryjWjn2tqgxFBlgLEVxslrj0yFA2
	dLFEpVRx+7jUhUj+o7STgPYI6KNhrJCZPogpgLfmTtj9kkn04DfI7acHgWZqSNl6
	uGtPoQDYOzM08UyNjyafgvYZY+PRQ9rarBL/Kg3rlyzFDObdyUFagF1ySMqL9qRS
	jhP9y1TE+QAzcjPRjTlD3UNkTCpGWLTeEXtxSDJ+zgu1DTfDYoiAVS1M1qUtNEpz
	1GfIQAJi5Z5KGdAcKBFG3BjRGr2zPojC7XuV+zmZKrrWSTOiHKjsIW0tVMmBYJgw
	CfXE3/1SM2mWg/IwB4GMQg==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty578712-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 06:36:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymfCw9zcqh8vfs460VAw+YSnQyKDz1XNfOo2+BohamNw+oh48k1A9coNR1cWHXfpLPABozH9zUSlMRmpxU8r7hqmdjmHXreEjyrIQdi2WnFepoy5jLu1D736456xL3CZ0DrmIjD1J7NpNKbaNPzdSI+A+/O3XjXc7Lcws0HwfMOnCErPFi32xdnRCjhHTZ4o0CZ+AK+umZfOgtJoNk8SvMOk3lNFjh4MfWbDSqKW8Ui0wGcfFNyIlZfSnHx1pGOwyGgEVbNsZ9TQOLk9GLYb7rOcYwHbEmmTf/JdIN+3Yf9BjDuDiN09RHyC1Qs87lciuenXOWduLHz5uzI33KFpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iduc+cqeeDpnzhUhg8U6NtkjFF298dJiFEA+0W5nCv0=;
 b=PLlpE+Xb6DrcMhQOIioVdvK1WPzt9W9PCH+ElGdegA+g89or1e5RT4U4znXIDLQKgnFSdxWzwa7AQNVxSKe0t+qG0zElxi3rdWwimRYWFNm93EnlBl2+HKAuEWa/whRnIkmKcLwnhQCa3z9CKkFpRogRP6s+BvUdkWctWDQva17QSSUJb0/irNdpcIDvptiFbl1QbtAKNkgYRMpf3mriTYFEHgqnL/CZ4xmJ4ZajUv+FTvk/oKlfaME6gLdBvAMbYAMzjQmiikP//+44N56++Kd/iekAh/VOj3qORT0woPryoo2lY8nsB2xJesnTJKdrQFUYoKJgrBygum1Wx3Mb+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB8787.namprd11.prod.outlook.com (2603:10b6:208:598::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 06:36:32 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:36:32 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH 10/11] upgrade-helper.py: use global_maintainer_override if it's set and the recipe has no maintainer
Date: Wed, 11 Mar 2026 14:35:56 +0800
Message-Id: <20260311063557.229656-10-Qi.Chen@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 691deb7e-c5cc-4187-18a3-08de7f3888ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	uaXEEtRgemxJbTjxuaz45fvEABHIKrpenVg/oW6F83qQHRv20zsBnZypiFQ5wS0G5rYsR2cSqpB13RbVLKPsyqXjngTzUdqj0Rx1kqswUS+MNPajQMSqJuoup28sU2Dvty1hFhSo5169w30W0PQt9qzkas9bNJ24vbny2YGM/h4ywF+j0QLmYYhFwjaBbps9tDPyHHpmThPKde4r0n3BYDwBexKTmlURWcmiVszAzzRCUcyfUmKfxl41u3TfwYrq/x8oZskGK5vzr6KYUMlYW0v8aozUhR6wS9CCCvtXDh4hvC8gtNX/fbJht7OAWRJtmXCw+yn3WH4eWAG3EYvpHOQx5PZWw1hS5MQ95fNBk+X1XkgWA84qWHyMO0QhCZyx6stM/RqCzRvpaJT0FYMEG4INRfMMRlvEE7RUt8r7s9RwHu23JjQFtQeMXbwFcPkXMxWopcBnStC8hXRRl4Lx9xtPTYi7XIa9ZdyWajREjEEoncwlDxCckDJQ4V0OU4bdIQ8+jSk4RLcdMVZB/gkDPQqSmjiPs8YRkiyYsSXxPSANzs76KICJRfxt0fK4AFHrh76YR6YdE2IbuHOPXCmYL6HnXtTYkpqb1GbrI+y2Ec5wIMG4Pv+WfxS1zptlZh6ZmNFnbzuXdyvzNtjGyK8gnLpNj3XwglWXqeBwFx5c6BNo6BnJBacZ/3okqx2XbfuKTdgfcAuiDH2W801ftOvndAq/s0KUgWMizJmiR0Qc9uY3Uc+2aqAWoKx6vt+gti52KZpSPcxgCvPXX3frhTUtjL2Rf1cQSIUj1QVwcd951fs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?x4wYn1AmgyjOBBdA4QKtFX6Jn9Jvhnt+bqlQeK4SJpGWe1DKTfKKp4CAQXUI?=
 =?us-ascii?Q?P5xEYRtv7iTK//hXgfoV2vu5OtKY9Iv5Ksjb4gLd6Ma72KMysUAQWonUrjn+?=
 =?us-ascii?Q?1r+YBBHEhYNnS6BO4VFlrKPC8Dw5izdWths9DtcGhjzg45WEZ8nO+yOQ+Yrv?=
 =?us-ascii?Q?KVsAe659k9kXcV1j3JidL4A4dFs2ayAlrvyvJrQRzhedkdXIz8guSwOuKajd?=
 =?us-ascii?Q?nvFTV1oRb0TxC7dmOcXsIPb0WbjZPg+r4ZJWuhUHJ8nPN+BgwqwRrqNHXbJA?=
 =?us-ascii?Q?36SShlFOqE3djpoL9lbQC4U/kZmoFsbNOx1m7/Wt8wS4ut5Dh1WQmYZk7xMJ?=
 =?us-ascii?Q?36Hcj5xRh39ImNUUzR5kVt13EPP6D4qB6cNbC1HXZjKcMcoXIwo4jDtYKofi?=
 =?us-ascii?Q?aZr3yQ4zCPwhNtc4+p4CbqnNYey2P/1Xc2mVfaWKPp2g2wqDd7NpLchxdXlH?=
 =?us-ascii?Q?3mlRlOkeYt2/4XcHT65BbormAzqvAEu0XCFQZZhelv6KILRWvw0cq6dtjBRb?=
 =?us-ascii?Q?HT4mKF7x4pg3QVS3LrrN/TazQ2Nlkty1StWjwsveKbZA/1Wyt+RJk6GTHlx1?=
 =?us-ascii?Q?XLO5mS+aDd9KFzAJ3BzKd02f6e8EqaekTVHVWdzhwLmk3YrVGSMA16azyjNS?=
 =?us-ascii?Q?2ulLMcSGt856XZ36AT/0SYEIA0oWMXL47KuXsGeb28aPyBU0DeBichPczXXx?=
 =?us-ascii?Q?X2TTRG1vVZLTsglUhkaAx03N6KRFUU5YgDIb4JlwfNSE9O81DXr9F5os1xpZ?=
 =?us-ascii?Q?x2tpzxlu8Xstmsu6oXRZ3iIUPoOPNLfRSLJCbaU2fA817VfVeJwGRPEskuqg?=
 =?us-ascii?Q?qbMe21mUr776l25TZJzhxA6rO8ne/dEM5bHVuhnLZGf4mhFRAr/W1V+3tSIl?=
 =?us-ascii?Q?Hp15WXdU6GuirwpNCsYLrzdN7QsxChn3aMVMqfXsUwSXP69S9wQVAYezj/8A?=
 =?us-ascii?Q?aCKXjlFsHdvieyS23hgNUqNX6uaz32MTWCikCIB6E3aqemyH0JmosFtISQ1U?=
 =?us-ascii?Q?ckn5h64H3vv9ozxId7RbElgnCEvQXdLwG0uLk31rPdE9zehH6indq/BGlnJ7?=
 =?us-ascii?Q?lswU4EfGZ3UR5oLgq6X9wsQBF6sSrX4pB10ejMkZ/SRYyxZt7XgioP9dmacr?=
 =?us-ascii?Q?5bdvgr02JPcuxadWYTLAVm6rD4nU0va44aDE8iO1G77w5CK2whGogrT9evrK?=
 =?us-ascii?Q?QxwPqPmZMRk/hq4B5FU6h/WmF1WxObDfs2f58TcwSBre49Z8qliKnGDp8ML5?=
 =?us-ascii?Q?2PhxSN+GMyMBslSSIPw3IVIWBuyK8XAEhiji+qyK+2RU93x4Gs033PZCpg32?=
 =?us-ascii?Q?oCo2V0cvpPAqulkCE+9bXcVEVM8N++elr+rLMPP6x3WilahrePMBG6dROPi9?=
 =?us-ascii?Q?ThJahQEDQdoRBJoAGQMyw8m7iE1Nw22eTrjWSBDcsT3Fjm2V2dwgds9DZZbS?=
 =?us-ascii?Q?4OWH1nnx7d0MAG0OsZzs7ZLC2vglJEJ+FlVKPga2ID2B1C+MvWCGp7PB+H4M?=
 =?us-ascii?Q?zt7eo+DY5KJr+ThhINkMasfc9K/CJEtBPLX5KknscAHa3G88BN47G422z28J?=
 =?us-ascii?Q?zlbb1UWUtb7RiUJr9Fofx2eP9RgcTR+JHp7hnn0+Mdwq1zJQ+V2SFPncI2ke?=
 =?us-ascii?Q?Q689Y8VigJe/94aQ4E+WTdfx8RsTN4SdcPH95ld79YEXUEsuEmD8yeUYwOSE?=
 =?us-ascii?Q?IavSSMq34RhzvN1fmbsPfu0N9atp9LZHQgZe9FuK3miVtdfGPzzOo9jOri1m?=
 =?us-ascii?Q?sOeprKTPcg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	TcK9wKJQu4im8s4lSQJfFo+DPnOZ77v0rBZDVAA7b4XnXCXJIOc6h0lmX2DZ6AbFYbJRHMzZE/VLNT6mNjDAxQGx9x9v7fkkwSby8dH361gdlIPR9gnk+gzHQklJZ0XaoK39ZZk6RBiUVRvDCenT2Iav0FG9nhn9jQsSlz83SUkMK0ziTwq+7hmMzWlBgTjT7dV690vCS57B015JMunM1lUp85z63catQALcV4Aoi2VF1Jai2Z/eIO+nhn60fl+Oeq3hn8QVCKNzBITJLF25YJFx5Uyrn5YSeDjBzsHYHnzfki7kyAtPuB9gCRvZAh8y1Qr5+qMtPXJwuqySemewBA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691deb7e-c5cc-4187-18a3-08de7f3888ae
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:36:32.2926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtGJZ7W6AXjMSTgsf/oo06aMyWK86V+oL1I/34Izv+XdteECjVIROzIPk2WoM9dXhZ1haRRLGYd7upr3+CkwoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8787
X-Proofpoint-ORIG-GUID: -H2UxSXRu4d_oRzuGa99HAOfbMr2MqiG
X-Authority-Analysis: v=2.4 cv=fpnRpV4f c=1 sm=1 tr=0 ts=69b10d72 cx=c_pps
 a=jlQ7B5VXLElZiQQO4hIw4A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=slLyD0mBEoi4DCJX:21 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22
 a=t7CeM3EgAAAA:8 a=43dznphUI-UhAOROJDwA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: -H2UxSXRu4d_oRzuGa99HAOfbMr2MqiG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NCBTYWx0ZWRfX8l9YTRBY5MR9
 1CVeC4sqPcdswqU5aUNMr9fF+8BStIzkyQOry+P02bARj5rB8s16kzemeetHIhNtb1h1JJT+e8N
 cTX1bIZJ00XZV1aG4ckEcf70PzEZDSnI4hx0vi2fQjRC5lskUtoubHU6JymEiU2S/0u743WM/TF
 ln8wPvzST/KckFphyMaxmSCSITZilQDfO7Z5wNgv5/UQCyCpqWoMSLrJVfxqn4xqThxtl4dBwcw
 12rEYFgUW2oaC3cCBnTv6hBWXYD+R+jVTI1fMQHoU6QmOAqR8BcpcoHjwGgOu0Atbi05Sdz1vrl
 W/1YcEx5IhfipXMhWD+b3Bim6nzqOBBk9z/tA6tbi5nmuSm8opdbdrupGeUdhpoUTKbmnN+SKmD
 0elhtyWO+yyyXy9zAl4OwP82Y91fndmk8YY8mh61kovRU+PTMWmbUOuSxQ84+FKoL9Z8QvIahdz
 D90i1qpNHs5nIIOgWGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110054
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:36:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3411

From: Chen Qi <Qi.Chen@windriver.com>

If a recipe has no maintainer, it will be skipped, and there's currently
no switch to force the upgrade. Note that for recipes out of oe-core,
it's so common that they do not have some dedicated maintainer.

The global_maintainer_override setting has the meaning of sending
upgrading emails to the specified person. When it's set, someone
must be using auh to do upgrade. In such case, skipping a recipe
merely because it has no maintainer does not make much sense.

So We could extend the meaning of global_maintainer_override a little
bit so that when people set it, recipes with no maintainer can still
be upgraded.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 upgrade-helper.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 9920126..8589f8d 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -712,7 +712,10 @@ class UniverseUpdater(Updater):
             for group in pkggroups:
                 upgrade_group = []
                 for pkg in group:
-                    pkg_to_upgrade = _get_pkg_to_upgrade(self, layer_name, pkg['pn'], pkg['status'], pkg['cur_ver'], pkg['next_ver'], pkg['maintainer'], pkg['revision'], pkg['no_upgrade_reason'])
+                    maintainer = pkg['maintainer']
+                    if not maintainer and 'global_maintainer_override' in settings:
+                        maintainer = settings['global_maintainer_override']
+                    pkg_to_upgrade = _get_pkg_to_upgrade(self, layer_name, pkg['pn'], pkg['status'], pkg['cur_ver'], pkg['next_ver'], maintainer, pkg['revision'], pkg['no_upgrade_reason'])
                     if pkg_to_upgrade:
                         upgrade_group.append(pkg_to_upgrade)
                 if upgrade_group:
-- 
2.34.1


