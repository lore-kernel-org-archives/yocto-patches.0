Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B6BFD062F
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:36:37 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14979.1773210987593975629
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:36:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=ZGV4NNIm;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B49hOP2711153;
	Wed, 11 Mar 2026 06:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=VfZB1YEW3TN3HS+PPRuJJpL+corUGKZ44A3sCqsGQWI=; b=
	ZGV4NNImrIxBE4ftbH3ByU7QNeJ2dFQA20mZpkyixvTNqqf3SSlz2nvhIvh1rrkj
	3v6QgzljBaCxIYLbhNHQRyEBGem0pNpEHDhJYgMxCSy9eriOShFO3wO7V6NoXYGr
	66mjyTNDxAY/qpJG4jmriqMNixldAf5YAbxR55k9XkOwecs2obKRSBAM3kniezQc
	pwfhVQZ4Wd7z+sgv0VjgJTAAj8EbidZj79knmDh4nON0edIDlSoXfXHI9BayjGi6
	6v5jZkHV6QM4lMdf93pe135rgeHGIzZl2jr4oMpVgl7flAtNV35v6WwGL/gakYf9
	UnY7raiOKBp4bPFufAj9/g==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010059.outbound.protection.outlook.com [52.101.46.59])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty22r76s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 06:36:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzPbS65UmH1UNqX09m8qYOzpTlC10UVPYspXS+Re/duXI5/Ba+K0ocjAT9orPpRFP8JY4RO1LR5/MAgUeKvYyLW9Q30mH5gtDAUAzthrOg1DQSOQpFjyel/zuOI+ELlCYeaD6bFIaQW75sGS4UfPskk/iD41rO5mtEwwKJXwWsJ4LXSJyhwq1bLSMkN57axHkilcvWbaEYr1GrjEV5RJ2kmFVweDvu2HiYyRcQiKdbpPyfH2Qxi1Y7vr4gnvqm0+1VHzlRtaSt8/TMEIAhoIkmqOa+QRtn4bxmToMx9Fowtqdrpf7eEOl23cZa84EX2W5uLOvcj1mwZSVMbJ2u5TQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfZB1YEW3TN3HS+PPRuJJpL+corUGKZ44A3sCqsGQWI=;
 b=g5bmnBZFPFtOVOMrCZKdfibBaNCsSb6TjiCvmM0A3p+KYtmMQ6EIkjPgAye6G1Amk0klgvrrDgBXmJEn3ObYtM0p00YJ4Ur82S1MpfdybBrJx3KHfcZ2zIWENShS4N2cNW7EaXCm1oh6Kd8IVtyRXthcEebtAvRPG/61WmCZv8h4jfaXvhLs37CfSRiGHbtsj3B7kvZ68LfmiUxPhMurdRsxII8hjKImIEnAlpP3f3hnFkZOtWwkGVmEcyGm+CtYLKU4MWNu4KmLYkH3uJWSYnrgYxCBdbHFvowhGARIfHqohsmTofi6H0/XhS77PmN0NHjZ+ThRSmr+Ls4dHA6I7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB8787.namprd11.prod.outlook.com (2603:10b6:208:598::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 06:36:23 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:36:23 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH 05/11] modules/utils/git.py: cleanup the __init__ function
Date: Wed, 11 Mar 2026 14:35:51 +0800
Message-Id: <20260311063557.229656-5-Qi.Chen@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 692b8246-930d-4a04-ce6b-08de7f388358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	pT4k09DyqXuo/wHvrSPbNnrX/G55+IDC7aCefBzkiZgE+sdEwlsFB673A7W5bkloLXx+YWIRM2ksgc2LPtVaDxnmNwciv00GhTeyC7ggmYgiNKNG0PG40P460e+fmnE3NgpNM8lxQznTMCF5r+kW0va1Fw3Zkis5taxOMS3b3Q9CF4g1JiESnmzPn9lFmuQUU+sLsjlWF4NdvmUIo6o4R68zouA0HxhIzBfJMxNoFvVR71CJLQ6xFrRRvqvplyHYuYSNVROI25+QozkV8NLOryZ4YgWB3vsm++ap08+2deH3U/rVZvUUL4DL0D4D+MyWYUNOWynYlKoBfRYKGdBXiJOgcHhf66yD6DzMd0iiWFUsmMj+m0aDn5q4DNQmiwWAff5UUmBQda2tuhgzhfXaHD9CeWjtj1j9olzjCUEmddAz8XOH/ZnqoNh47iqoydFkr1BXOsFH6Sj/2MaQYGydVdXtBIUAvJK8/YVCRNUCO9rToolkKSSg/OsomU17Royg3CBpv0eLik7uJdliDchEy9ARsM4IWN1zdZLBBB3f9Kk0cyXfFzqVnETK/WSZhDVN/vEGWRwxKO9grkjdXnDEyXzIyaGTtcBx0hAZ9mrevpybmEsLeu+J0BVp9hahQ7ASGsNK8C2rpOzLHzE8oecwSj0Ev5soDZL8plYXspLPgGaOdBIaLWFFT5HO44nWyBlqv+FhTV83JwCM0myFf8XDm9LyTTs3OynOK+LJ64joPocO66HPMkjLaUP9J3xA2WVwRQhP24wi4FuyiMG2Bgx2P4US+kUppj08qFcnURSSJxc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?63hLrxbrAZouS1Qu79FzCW+gpbN60apD6FaI9mYgKK1PDALGZXuwat0U1YCL?=
 =?us-ascii?Q?hHkFrAwb6OMpxMzRViESQWwZhPKLj6ST+Oncc6WYzrYKqSCFKmKItCh7WsKx?=
 =?us-ascii?Q?TydC4sukMTF1SQBzP1k+cNzMp6MjrH7b2U1hUA5G9YjYm+e73BmHZO+4ptNX?=
 =?us-ascii?Q?OestI49umIiBRaoSVX03p7QlH6nhMtahn5ksu67vG6Bldp+dpJbHWndw7sZG?=
 =?us-ascii?Q?BvgFRfTRUT1LyKYkxRxVzEEgzygzBGA56/yqIZ6WVZ7+3wTOFcBAOU2o5NQA?=
 =?us-ascii?Q?SOAx/S7lAQZTq1WXJVBoTrCrEE4VzM7SDzO0YfjUj9tWf7DSUHjyquURjNTi?=
 =?us-ascii?Q?KF/iUb5c8X9UaOcVgXy6EtaBsVh/pDxQTH6Lgs4lgwQqv+XbP87hLmS9IXs+?=
 =?us-ascii?Q?CxLYZGwFWr5bn9GNCHB2lIsHzCpdM7dMEIwZl6WXvW5jVS/9fn9CGta5Nyz+?=
 =?us-ascii?Q?q7HpqYpy8ahfxje+2fAAzlGoamACYak5c/NDNtjFbHbUnLnYVm0XfVK6iaTv?=
 =?us-ascii?Q?KKpGEntKiHaYqUzMF2TB73fEWRYOYUNfbY5jmN5zR04Koj0orLIv5S08wqZg?=
 =?us-ascii?Q?li8ouQOuN91o5elhdVex/bcbsRIjtBKNRphWMiQdeUwjp3Xf2HDU8pG9OCtS?=
 =?us-ascii?Q?30CflCOdDvdopRnk1l5E9roy4GkAVP3l2Ea8U+Lm+gSXC23GSgQplSAu9FO5?=
 =?us-ascii?Q?+V393fNJKj0D0panoFCGV+rG9jOviiXWYDAzr1uiSWgKJxB6Bnycj4A8hGR2?=
 =?us-ascii?Q?yPmtAXEUx+TFnqUI6V1iX75l63kqSO1qGUh+tl+AUJvZ3NBVKLzwKF/XqN63?=
 =?us-ascii?Q?5dRCoa/OD3TgKxG/LreFDGAgKQG1ZkyyNYdB3Y4dwQeeYwa6uFAfCRVTU4sC?=
 =?us-ascii?Q?k/O0bLKn0Q0uHWrzyPOpHlLM7gdHHig5e4kA9XXfO7fPYpUd4HgdWnLm14q+?=
 =?us-ascii?Q?znnc3uE4P4A0AlTuhD6dYGGnOmNJg8Af5i5O5ytuTFcYUGpsE+PplHSqkUhb?=
 =?us-ascii?Q?pCcTyyPAg6XL1pm8au5K+hq/KP/p6BeuekpB3E0a5UdZkAnHkm81ph3R/C78?=
 =?us-ascii?Q?1d4K8fqVbEfdWZiwrxR3JWpi6Tk34JrT+fPs8HmG3AKfqBscQR5cHXk7w4XT?=
 =?us-ascii?Q?jq4BYE+2fO0o/X2Hwfx7U5KD0bykcEdARxDN2ImG36YVUlVKFn79nxVLa44t?=
 =?us-ascii?Q?JAc1fgo4kX5OTCwCXZItfDUFzDDrlBl8j4C/w8Hn5m4452ASzuqIbUMzFtPH?=
 =?us-ascii?Q?ypvqKAXXu3GzLVKSKgrnbviuZMaZjR+5+DwNYqHJyRXqSnUVt5u4k54nKUCl?=
 =?us-ascii?Q?BmYonDE4+kpzpcInmHeTUNfMFu3xocn2+hOFC4ADiyzSEpG4ycHvabzU1PA6?=
 =?us-ascii?Q?1+4g2nUnVvZh6RLkO5Ct29J4nvhSP9nXnpq31ckOMH6r9a7b2bimmxUyT7H+?=
 =?us-ascii?Q?GkSR8iQiFcSGGlw8uxzxjTmLHmnDNwilcN5oGocm39ATwASw7y2o0gyi3b6I?=
 =?us-ascii?Q?+Emut6+6OnaLk9rwhf3OWHb292N0+/Pr53MTCEnMlA0fRDpsIJhcHcze5mtE?=
 =?us-ascii?Q?XQnh4Ee/RclHne7cSpoOK7lMal5jjKaudmUdAvk2mg/0rtUC9+8Mih0kx4O0?=
 =?us-ascii?Q?SaJcr/shcxwRJJa/0N+AQq/zdD+qLlu1g/dlB5PvfN1H974xjI2UdAxCBVoL?=
 =?us-ascii?Q?ncyqt/DPuGn8W0nAfGk+hXdBQoCNlxMqyAsH2FeB7LDHsrDXEskNvHzamVw/?=
 =?us-ascii?Q?q+cUFuhCkA=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	gw0vg9tXM3vjewHZjUQtlueYHaRIafEfWUaO1KBsLX+AJuyNUQZzXDmbzUXiE4JV9kKJr3aTKEq3rVFwn2CyGrPe4kA5O3pLQCG9+lMq0KvlsZRBUq8HaDtsYBg8MWjXFUFcZsQZU8LvpWJsp9sZdDDIOSWu3RBEBkyrqfnG2Aa1aRvYS2T+8ApL3KbdtX8Ug3N8zdfNO0/0zGPcBnfeR72sZGgykZ7pjnxKFHbx6+3KRoTegAAtLWQDzH+IriIFpAL5inD4YCKa8DLOoYxBDUbC/P4yrp6LwqLhTDFbrhMhtguKhrT6C2Hnu+D9pDRZKyhoCmliAEiH3bslly6qbQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692b8246-930d-4a04-ce6b-08de7f388358
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:36:23.4573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmU8igavi3U6syOgORDCuX7uTzxNHmkhhCgbzSK1jnoXRWFRBTt3TesVOfNo+6Knh+FBYSbh/cT2S55HioukUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8787
X-Authority-Analysis: v=2.4 cv=LqOfC3dc c=1 sm=1 tr=0 ts=69b10d6a cx=c_pps
 a=4QxnTjFVIeqV5CvpKlqXuw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=llld9UTGmMUyhnCEcBEA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: LB0FSQAQSbpELI4FAjwLbl65eANHBg2a
X-Proofpoint-GUID: LB0FSQAQSbpELI4FAjwLbl65eANHBg2a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NCBTYWx0ZWRfX+5Qh2FtjnIh7
 MqP+/iBwG4pivMt8vO9UzZG7JW3qt9eJ0h0bWHxsK9vxM1bgtv8LQKd4RwmGt3MghoU8wClNVae
 dzfT4rDS20M1uK5xXQBVmbY1syGN+gcg1PLbGnZ5eFrFQGzn4iKTeL28vkbx7tXTefR9Kzsqreg
 3bzh7zubyvL2UXHCCaeDuMapAoSNR3++TC/8CXHOY90ezBRUEM7VLJX1aJq+M3JLMfyUpNJeth2
 y5/8u1Bw088ZmBUr13e2pe18FkIjJmEn69vmLNayViabZXnXqpI2G48E/xVlli1B8JBGo6/DBef
 JaNNySUay3ET27LScMC9VzEO+W2fCHaaPkrqpa8pW3s6RogP1x31DMqT1auI5PUyUpGwzmWZuK8
 eOFVhGLKV3QvOr6r6YkaRQDOfSV+HFrfluyF2dJX8BWXF0+JG6YnuL9X/vyz0PgTn+nE6tki0Ff
 GPuCIQyyk83a2DwgRMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110054
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:36:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3406

From: Chen Qi <Qi.Chen@windriver.com>

The "dir" is not a good parameter name as "dir" is a built-in function
of python. Use repodir instead.

Besides, the super() call is not needed as Git inherits object
directly.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 modules/utils/git.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/modules/utils/git.py b/modules/utils/git.py
index 0482d26..b504ab0 100644
--- a/modules/utils/git.py
+++ b/modules/utils/git.py
@@ -30,9 +30,8 @@ from utils.bitbake import bb
 from errors import Error
 
 class Git(object):
-    def __init__(self, dir):
-        self.repo_dir = dir
-        super(Git, self).__init__()
+    def __init__(self, repodir):
+        self.repo_dir = repodir
 
     def _cmd(self, operation):
         os.chdir(self.repo_dir)
-- 
2.34.1


