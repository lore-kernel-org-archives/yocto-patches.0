Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5995C10F15
	for <webhook@archiver.kernel.org>; Tue, 23 Apr 2024 11:03:41 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.15825.1713870214048501617
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Apr 2024 04:03:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=keV2CuQg;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=4843ca2dfc=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N1Cksw014597
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Apr 2024 04:03:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=dYop1IdCOyj9DVmma6
	qVsCdK5KbRV1P2+XS22Esok9o=; b=keV2CuQggYjf/c6atvrBA+epxIc1Cus1v5
	6YdknZJzLNH2ov1aI3OFD+WLAyUqjhJiDrYT6z7SH+RjpCVeX5tnWdsIgtfbZaq4
	YPqvFcLaTg9ULcMz58CArl8aNXLAsb8LXIJKCIVSP1s5BR2nrUQKnKZWxeOVMzfZ
	RmA8VmE88bdFH3Bczmvi9uHEvdRj/dwTUexlySVp5fPqRCvdwsw1B1ULD2z9pSTL
	8Bj5JWVyKdoRQ5iwDmxX/LhX13fsig2wdxmiS2cwnfTXwNE/KQ5ZLYP1T1tUdVj0
	8HHZLUGUSpGsr+vBPkQ4vn6niqRl8hckBCZYg+C9MGv8leR/YiKw==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xmd7gjf3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Apr 2024 04:03:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=au4wAt1JBpKccEoqgVcQ+s0BbiA7r65+oHzNZeuN3kDXrTgXj2ksTpPyj19tB400DueIiyHpEP+Nym0FFL0agdY+XCfFcHO4FQa27BCWXEIlVl2T6OOh7BTmqcyWU9t7Oy8bPJAKp81FmoduTF5l1gJBGaZLoXj/pstlFGgZUbf4K6CRkkpiVGm8h/FnN5d+/wM0AsVod3SKA+b8WezMltxJ20+X6pt/t4NCaumIaMBz8Se4+jdKGp7J1YsL7m6OGmiSJ0iBq9g9F+EefZCr0d5YUwhPpRBYyCnAVprir0uNBiQY7I4JiK02hSysW+Okr4p77TtvBc3zAz+1DKi97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYop1IdCOyj9DVmma6qVsCdK5KbRV1P2+XS22Esok9o=;
 b=Qw94X8oBy5F2e9XboWM/os9A2MQ3nZgm/JHLbB/VGQeTxKX5+sdzcQaZ4xGXkmDhP4pnn7t4Z6ZJQHkGYc6sQ7qoYeANIOL+l1wQns/+7KmR4bUwCRDJHwYfgys18AdJPfaxMSz6pNYn7EHWRP7qpkfjy9fM1ceuL2PbsGDBYnYH64mkoQhjgjWL2K0uMMpbvmEc8yxuJOy4BrMmnPbNaaQetlFBLMqdx2JJx5W7/mZH35t+nwL1v5cP+JdungXEKhRJ/XgZevfII2S2SqztR2Kqko7We8t+5CiUb2yJQ+sKC3FdVIiHgjUgFb7S1k4w86ScREtUX7unFewVFg1t6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7484.namprd11.prod.outlook.com (2603:10b6:8:14c::10)
 by SA2PR11MB5113.namprd11.prod.outlook.com (2603:10b6:806:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 11:03:30 +0000
Received: from DS0PR11MB7484.namprd11.prod.outlook.com
 ([fe80::97da:833f:8511:a558]) by DS0PR11MB7484.namprd11.prod.outlook.com
 ([fe80::97da:833f:8511:a558%6]) with mapi id 15.20.7519.020; Tue, 23 Apr 2024
 11:03:30 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] scap-security-guide: remove __pycache__ in ptest directory
Date: Tue, 23 Apr 2024 19:03:19 +0800
Message-ID: <20240423110319.1053510-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To DS0PR11MB7484.namprd11.prod.outlook.com
 (2603:10b6:8:14c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7484:EE_|SA2PR11MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: 1263ce71-755f-4f6c-525e-08dc63850282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|1800799015|52116005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?POB71bFJt+rMzDB+IbOvSijHsi5pD9EqrwPWDWHK+mVyKXIy38BPgAz3u5oE?=
 =?us-ascii?Q?ODKeAlO8xCspFl8LPX9eBQdT4q2bnxVXLPsc500gDnTcvPQrV51byABdzRFi?=
 =?us-ascii?Q?qXb/aiuidqMypmhjyZX6RYudqDdrp0XvDZ7hhZl2oajDF7Xhd7Pu5V2trTF6?=
 =?us-ascii?Q?LRD89i1jmClm8r2nTnED9AUBtvCGOGIbOOCvoSxvi3DzmGDttJ+ReOBwyqUq?=
 =?us-ascii?Q?2QGnmNZwnicYRN5RgLfDbDTLtZ3TfDxjXo2a1rc4p7HGMWEnMX9UVdBHYndx?=
 =?us-ascii?Q?y/J69R13yJE2tDfeUjj0kmmysHuzpjpoMQ89KrozC8TXT/rv2HNUDyQGxluT?=
 =?us-ascii?Q?5pmyn52FuIFp8z0YvPIHYShS86kDpZ3xrdkE85dt0XP8rpFGfS9vDCMYTiyE?=
 =?us-ascii?Q?rPbgCxzq2MS0uP99k/ktLKZ1/QM87PKzjmldOTtroPt0fsGPnFSMraGjoO29?=
 =?us-ascii?Q?bEmyxs75M+w0qyD6Vj5yTmplT/cHR/m1QLvzboMO9/CtAtTK7jJe5BruRObd?=
 =?us-ascii?Q?zS5MCVPUN3pUbki4+8+GA6x8lU7ku/V+1foo6Xpmqo8ViePED0bt26itEM7U?=
 =?us-ascii?Q?QOT9RyymaO6qmj2NZFnPgFvfSVzAgV0ch8ujHDl2WjGO+L1lYBxkh8iES+XM?=
 =?us-ascii?Q?ovUTwat5F9keaL/e8uM9110IBcSz27JjaYgkQqUf65YAzGhehMBkTKIWeR4B?=
 =?us-ascii?Q?2UaAsiSX0scPVqMTUa4z7FpHVVc0gMsX7Dtvz/BVPpzG8WiX6v6i3ZjQo5TT?=
 =?us-ascii?Q?9gnfctMZjSJG4aJM0WevdZa3LoRkaaw8gWeAdzSLJkQ95d+2YiRPcFsPUmJj?=
 =?us-ascii?Q?HTW05jI9h6sFdrBcEjWWw6McngZhochyGFKFb4d8vjYjvR7UhqGItnTrlpYc?=
 =?us-ascii?Q?mMWNWXb1IIkdMd4VGQ8Jtsd2/SJ/hOOGwXlUVInfJqewdt4faL16eazFauXA?=
 =?us-ascii?Q?pg834+T4FHc5o/sgtJnZYEaJvgqK9mdpuLiWBZCqTLFKPHw1HymOgoXrorog?=
 =?us-ascii?Q?8ZlN58Cb3yTYEsRlQvFvBUHqiqY4nB4eD43GkgAjIo9k9bRaIzOJjEJfwHyU?=
 =?us-ascii?Q?491AbWEkaAsCdTy6IqlRJCUcDpqls7y+m2FVT3ER10afyCUYsWmICachmxtl?=
 =?us-ascii?Q?3Sw32z8JMzhbxLr+J+CDnpZOv4Z5+DPnehEVVrSdCLRsgbK2vafLZlxyNMaS?=
 =?us-ascii?Q?yMVugUOjvUprhywd8mp11fVgKv5ShlpvLgSwCx9PeW7jjdtbloyUoAwpwruF?=
 =?us-ascii?Q?7KZNDS9q7rXuAe+4Q11jJo44RnMNMmN/28/gUuT6y8N70rnsSzySgcDDANNq?=
 =?us-ascii?Q?t25Zu9v6C8wyyPdrYVXMUM86I6NkUjkg7tXnSC7yYuUulA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HmvPcF1hYeaHNo90yXY8C5EZId1Qp1Mu0JaIGIoCPSxJnPQJ2rVl+PhnBckx?=
 =?us-ascii?Q?/lbq4KyEFFlBiomM+5/jNX0JwzDG5ZhM7Q+Wg1s98ei6G+1Y7V8gqgGV7YYq?=
 =?us-ascii?Q?Xzzo1EtFG7CtBEkXhVHQJUNJqJDGHg+JB4tpA8aJDNEA3p3E3QNdinu3zrkJ?=
 =?us-ascii?Q?J/f6j0vl4GMi7u76wnzEUXifi0jEsA58xMnRM5M3XJWWF0+bq+CvKfJqq6A+?=
 =?us-ascii?Q?a3AQ7OTUFpBDSWb2ObGV3gqp1qV5FY0CFBoe9iSX98s8KcbA+EiF0hDC66Uj?=
 =?us-ascii?Q?y262oFcKGma8CKUAPZ+6zGbNemXyKG68xghjpz/jkJGf+q052QUve1F26GRs?=
 =?us-ascii?Q?1gu5cXGxwwA7s2ICs8EYULcbvswXv2w6ZquWsO4Zewix+Op/VZ/JZKwRCXVv?=
 =?us-ascii?Q?grNgiv+TWUadfTx9YJU9y6DIVmYcBwc/N43X6oPJD8jxFnMw+f+pUav8PWde?=
 =?us-ascii?Q?ZiBm5aF4g88tCLwTN7AihMjXDPMt4W+TIGDKCVlBomJ0cYR+w9NLPnH3SNEI?=
 =?us-ascii?Q?GoX3cWzAOaxTskHKDGTSTt+dm9Pw5cOpEgljCorzjCMgp4mHHUzocz/h8wn2?=
 =?us-ascii?Q?bt1M69VOS1+LSwEjMVg4LYW0eKQInv1A3VkJMYqExYIBiDMfVZ4Fdm/RFnMF?=
 =?us-ascii?Q?FV+QAt6wGLXoY5IA8jeL1e8ItIvJ+mEJaTaScwUFshASqV2PGoigHBzgxMuW?=
 =?us-ascii?Q?U9+FWY9djcYIbVGWiuR+t4ylG/Lal2a+gC33O6nepLoiC3VwAB9pJJnmKSpS?=
 =?us-ascii?Q?vyFNHW1E1TqG+DZl0lxwlyaEuKTsu+5WEAQvZWEISB0xVSKa+5WdRuqcX0up?=
 =?us-ascii?Q?yDEpUZHX8ishDIOFOvyr4/T+sZBZH+RczZuugiwD4vV7lH1XOFYGRuCCWJav?=
 =?us-ascii?Q?Xdp01GhGY0knzT7uvSX4GKKwvkp0OBlDrS+S3z14xGrW6YcmyhY5+8IptUFE?=
 =?us-ascii?Q?d4/Rbd78bkXKOeBrNkumcy0eGnWDncf1ZLzdwKmyUDZJiQNv1ihM+u2nnX/i?=
 =?us-ascii?Q?ZR9pFbaskRWedncMfFWLatbC/FUhZy/X8eEKp0eeunc/WQ+r8d0C67Km9k0/?=
 =?us-ascii?Q?d8Rs+AEBF+gDKNr0Mld2eQkTcSWicqkljxyOLgR7Xrim0qqK30Nt6aMKRMyg?=
 =?us-ascii?Q?8Szv4+gQdSduB6aCzhxLtb6B7R4Q6CaT54QvgMj/oJas7nCMyCu0+HxcfdRv?=
 =?us-ascii?Q?0fQSZtVVOZIGNEJV3LrqG4NIg4QR+Sp4Xrk9+Oc6yfRpgaeIyQfD6SsKA9rw?=
 =?us-ascii?Q?KNbvlp7Rf5KHyTmorpCe+z6onTyfqrIzCbJjYhwMAICWMA+Bcu2eKsZ1XCRZ?=
 =?us-ascii?Q?AKcbLF/wpfORCgGsCKH1en3kWAOUA3Kc2DOcG+QKWahPt4YfisOG+Qpva05K?=
 =?us-ascii?Q?NhHWy5IkN0Sq6MJLZA+w3oNkB7mqoyPqHAI6C/53rdg7k7nesMes9Su/WV/y?=
 =?us-ascii?Q?vLj+l8hSPqM5SAZOUO/KQjEyZpZIF33JSaS1EilxDEjkxPXUgHx48Cn6S//3?=
 =?us-ascii?Q?rmXDO0FC7q9WUtkMgWjFol88R73ilnpA/MJnj/UqQQOepM4+seVk3hJuyq4w?=
 =?us-ascii?Q?I7jzYjiehZzMCnIw+VYGMAbjKEXp5zV2rEa51apo?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1263ce71-755f-4f6c-525e-08dc63850282
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 11:03:30.6868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2upB5p3jMh+ShT0TKC+73zoOP+0EZJ/VYTGekHqZ7f+OzL5UZkZwOBc/PmcwOSJ/DJWlm3IUuJJOaR6yI2utg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5113
X-Proofpoint-ORIG-GUID: RP8qDRRC1A0449Hq39d-J0mmy2z6IiiD
X-Proofpoint-GUID: RP8qDRRC1A0449Hq39d-J0mmy2z6IiiD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=821 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404230029
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Apr 2024 11:03:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/54
Message-ID: <20240423110319.pUmpxVg85Zi8Q-lVxNdgX5AsZA2lD_z_lzqCE9h1ic4@z>

Remove __pycache__ directories as they contains references to TMPDIR.

Fix QA warnings:
WARNING: scap-security-guide-0.1.71-r0 do_package_qa: QA Issue: File
/usr/lib64/scap-security-guide/ptest/git/utils/_pycache_/gen_reference_table.cpython-312.pyc
in package scap-security-guide-ptest contains reference to TMPDIR

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../scap-security-guide/scap-security-guide_0.1.71.bb        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb
index 5e45332..43c8b8d 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb
@@ -82,6 +82,11 @@ do_install_ptest() {
         install -d ${t}/$d
         cp -fr ${S}/$d/* ${t}/$d/.
     done
+
+    # Remove __pycache__ directories as they contain references to TMPDIR
+    for pycachedir in $(find ${D}/${PTEST_PATH} -name __pycache__); do
+        rm -rf $pycachedir
+    done
 }
 
 FILES:${PN} += "${datadir}/xml ${datadir}/openscap"
-- 
2.25.1


