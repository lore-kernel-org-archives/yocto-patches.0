Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5110CF99359
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 09:11:49 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15447.1776935482665814606
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 Apr 2026 02:11:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=NiCh/FJe;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=8573f998c0=xiaozhan.li.cn@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N3ZHTd985311
	for <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 09:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=+3CWSfuJoI4Apj7HKCPi
	yjfMQN94hgcoOoqIYuBH+9U=; b=NiCh/FJevnSj5CYvbKWE0Qj6EBZfAKwfiI54
	cKRa6F+MzHRxiSQ/nLH3vQ4xPLLtXh2b/KREqKek+Pq2LxNhuSg0GaiNucZ8ELCi
	8dOVqJAhx9vvaTpH4SYLJ+WA0CAmNZFWny3AgTDUg0Jl1a4rBZfE9U8Pd7SOayUJ
	j5yfW9rUEvKWJUYiBDZ1MaLkGvsYh+9croyVKvZ7D+cr1mvH+3gZrumVpU/6LxHF
	QWszU+qt3btGsrzE0CrabnGVQw5SJR++5UbbpB94R3NfNJRdJDLxI+LL3vfOddDf
	VWGTtYwpJGB9DkyphT0NV48zI0RpVt6hV52H0GdTqemZZi6CbA==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013058.outbound.protection.outlook.com [40.93.201.58])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dq8qc0d1m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 09:11:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bc//KeYcLdBvMxIG+qBZR9+qX35vdGzTbvIa6uvwBJvpGm8AB1nwlkMCMyQGhTWldnJNjARPnRQaR5AhRPcoxp0OHSxlbE58uvpqwEih4AL+N2TrfGlbTYiSc5uFrVIHTNSiAH1hjUgCjzhKhU7poafT5ra4QVvPizmgjhZTj1J6yDITSK2K6Npm5whCaByif7caIPzrGqXl82SgqDB+sMcuEdP4N0+Lg02khN+XYK9IduG4Vd0AwpKAACha6KZAfvaBd+4pQTttsuszO/Cjhhn9Qv7iikASeMyRQ0sGlYEhWVSoz4spNUK75Eyt3OORA5ifeADsy1RqNWwwD1KHDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3CWSfuJoI4Apj7HKCPiyjfMQN94hgcoOoqIYuBH+9U=;
 b=ZV/TPdUVjBg/AkV6iqeV5nf+bwebh8YrE2M41S1bBn6vnImYaXak4FU26NMOo0XFE1wl9QOtuBqpuzB0rVgaSLa4NeoSvrdpreLrP628AlzXetEqUQUCUeaSzGmDMNl3MAE3WZxPtWWTCPhGMFsVcagzNq8b5pFPOAu2TaCMktwcc0z9DLu0UYF1m6EToCQ5Lr/Tjfwis3CRz4kmpW7IM4vYVZ+88u81Tv9h9wS+eDVmw+cjlARmVfoisQVwlOqtL00D5CsngPa79v/ZpPuxu5GNbV0Bl1uNfQPdG76GKRu80DBMWyzToqcPudXZbvqMZP3ZSkwx7nz7rO+6IXhEOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8344.namprd11.prod.outlook.com (2603:10b6:610:17f::13)
 by SA1PR11MB6823.namprd11.prod.outlook.com (2603:10b6:806:2b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 09:11:18 +0000
Received: from CH3PR11MB8344.namprd11.prod.outlook.com
 ([fe80::5596:e734:3fd5:4fc4]) by CH3PR11MB8344.namprd11.prod.outlook.com
 ([fe80::5596:e734:3fd5:4fc4%6]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 09:11:18 +0000
From: "Xiaozhan Li" <xiaozhan.li.cn@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] arpwatch: fix wrong init script permissions
Date: Thu, 23 Apr 2026 17:11:05 +0800
Message-ID: <20260423091105.3247841-1-Xiaozhan.Li.CN@windriver.com>
X-Mailer: git-send-email 2.43.0
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To CH3PR11MB8344.namprd11.prod.outlook.com (2603:10b6:610:17f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8344:EE_|SA1PR11MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: 7217c74e-7287-4121-6a71-08dea1184736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	P5BgS1fGwHREMz7XDYMoUUIadatldnHWDp2cfofR4heRO8h2uUdKmuxRSTY9ocM3KSrn6Mwb5uKcrw2vtmMNgoX7kVzKfdncVP9D2oX6yHNHrA3P5VUnkmLChO4J46CkcxoPZbLMu9QmKFfHgP+X3wi6hlInGbvj/pmg1P9D9VXkZO9OKAxMjahRA7bfhRB26GnH8/2xhs5rm83kcJObP4dsiTGQmQDduGhrECRWg5BbV9mtS1U3kPnY4XkYwGyNCbJDud6UDqR35gonuiv2IJUC8JYS4mSQaDbtlGjsKXsMHFnVmsv+rzez4PD3RAQ1w+GRoOoI7I16rAkSmg3/05+fxFPznoS9XAADIb1Eu7MsewEtwyPX1xENtj4DTXOPD0ROaBV5q7+WS4x6rQR5C/llxISAdWKOShyQNUsWBiTUi6HoRlkFAXKysyj8F7QHpa3Dsl5Ts8CwjwXVb1rGEl1yolb1cNgUP6bhcQ7YjsuwL+WTNxtVLbVbygcS5Pv5TYQB0lOQgBFrL76wApi7VdBhaDN/2oO7jP8fN0AlasWfx7c+s2+sFuhJlwfq02BzOEWrqPQwLLs8MOqIwshlcEZV2V26hEBNyDOjxa/ahvqdHzP5s50RZTvPXQMuQJ4bFI88OVgekTwwtvVgMEBo7G03D/xJPjkqD/uNSzMg6XJrxW8tGPMzDB2AwyWBxnks90KxRkMzx5465mlDvVPkZ+Tn7+HXVQ07JRIoiotApI4N2ijx0PMdeNcqXquvUtPrA+5XXRrVY7CTUePoxLTcGdl0K7gEgDaeaJQS7qOaKfc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8344.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xkLGJXi42vAhqaegB1mwy5z/r0Vj+vAuGRiK2KutNg4hDeS+tCKA5Nheda4B?=
 =?us-ascii?Q?UH33CD5zgJFx0MkUM9JF1Tmklm6+tEoCoR8/r+tg9T2v9fMnHfmJ8Li9Mtzp?=
 =?us-ascii?Q?zL4mGNxKqChqmA95wg0HfmDNNW7hDGaXvsrwzE/XT1/l0t0xA7W5HPfNJkuQ?=
 =?us-ascii?Q?eZnqFYkDY9hwdOX4sfgDuI63H9OnVtuPfTx8hdnKK+X7pPWX3jIXOWLdLPZo?=
 =?us-ascii?Q?+tq03/insxCIFoqqV/+EudbYaLeMaDCwVvUIBwrrxOmcHUY6Rd/283jVdmDF?=
 =?us-ascii?Q?uYIQ3X23FEO4tO+UTZSsD5AxS0nD9zszaq9mLJkPa215EW23sEVe1H6/j1sK?=
 =?us-ascii?Q?3z2QK0uBqrjblLnA1yjyMDB6GYQEj5msKCrXzvpFkRzrzdx3zaloMa+7kxie?=
 =?us-ascii?Q?7SK4gljqabvE5ulUjeTOomkJfrVAMgdDhmor5H5+Wipl52EStd7PhBFofMiY?=
 =?us-ascii?Q?0Q7PLPZuUkFCSkIofkafrKkUp4pqWCKmwvCtb7cp3VD9GiPHLJBpYT6bARo7?=
 =?us-ascii?Q?aL1Hl+kNW3z31I3QS57V0W4mBs0eOiuJY2rUK/l/ASe8ASzPgHWaN24dosNN?=
 =?us-ascii?Q?Vb7UIVBa3OOHaxfDhmm0XpPPjFoqKvbDUuzU+xDMkcFMmSestT0vEm8obKP2?=
 =?us-ascii?Q?PcgrdMire8B+wE11DJOwIr9x1zRekQA2nyGuSNGk3HY/vBfilZpthW9vhBtr?=
 =?us-ascii?Q?V6aRBQM2vfqYOnH1ANC+6F0nRZHFhbHfHow7kc8oAF5ATK3hrd1lUeLgne9P?=
 =?us-ascii?Q?pkEsWvXad7EUUYlfejY8qjC41BZJEFMu4fRUS+jYTkdeC5np17zKrGWUjV/a?=
 =?us-ascii?Q?T8xeChGZWNYsldDvEDJnPwBRZZ0weW9ouuUqBPd7E/5FQg6O8ASTuq+F1W5v?=
 =?us-ascii?Q?45sqhU6DtkAeDJqtx3fpP27eqH3BNkoB/WaOZJCSRuxfah2DAd2wSAyDQerp?=
 =?us-ascii?Q?6ZsNTXtN0IChcmgLzI/lnGnc3GEi6N+8dZnh8e3BwAkMo4dXx0LB7N9Ah5/D?=
 =?us-ascii?Q?rnESeI13b+XoPdjN4UUVrZHS0Q3gtiYYKh2MX4SGnfv27BDjMqxt8yZdyTbw?=
 =?us-ascii?Q?0xVOblqa3vkaNkCb6NZPywtB18OqziONXZ4Xnu2sfvhiEizLKAtAllyC8heU?=
 =?us-ascii?Q?KZNwelnLgVQYeevztfWUgNNXGoumBFbimWsQuT8DPPjw9NJnvi1SHmd8tolw?=
 =?us-ascii?Q?Zz6vFkpXWslJ7WmlMcC7syomU2bV87bUQ7DMCKyDuE5BTHgjgfuGk9eGPe6N?=
 =?us-ascii?Q?Lc5UwjYt9IwVoBEuNfaxpQmzkbbBkoDnZM6gqltDdhsyZIsgygOlbQHXvfk4?=
 =?us-ascii?Q?DxHZ1usB9Fanea9PexFhaeVFdklqejA1uu/+63LMLxR7VuFMxHqClVThBD1e?=
 =?us-ascii?Q?3A7GL54xzBPGP2m+dJ7/BeBjIxAtUiYuRg9nsdYh/8LM3F9etnpexT7k3jLU?=
 =?us-ascii?Q?8ztSl+BDaormMjfFR7pVxnJJn9lpwX1jnageroSQTUzS9WWmdww1A7MNXgA+?=
 =?us-ascii?Q?DLSMRBSFJY96YWCRJ7Hnx3yV0YvdhTPcwYFsv7/mSH84JNevZrG0b+wkDPzB?=
 =?us-ascii?Q?ISZJszFqmWrXzV7zQvHTvKyoi8emYE52i59+q2pbh13MroXHCHOHyPes6uhj?=
 =?us-ascii?Q?iN4y1CPWvkP4DwOjQC9Zq7n/IbzEPwNhRmfS1M+GoNQyKQMIoKatILJvMqvd?=
 =?us-ascii?Q?OchIXEO+3CSaepCAgPb8G+nfLOtm4lcch9v/HUWgu99Zt8YH5wOFWQsD4tYy?=
 =?us-ascii?Q?wm9/u1kwHhsCyE87cSfbdX046vNDkaA=3D?=
X-Exchange-RoutingPolicyChecked: 
	GiLefdOcjFyk18q1l7MGaV09WxH5h4avSou/G32ubP67iDpsY8mA18zv7XwcqN0sykE/7V4/ETbTCDQd5hE5BSMG5Vv2m2nlAyuMSySNxXB9A8tc5WCaoQDOtIkjR3LAO0z3unTjhN5mivkNqjAg7ULdFZ1KP0znIpsAdJ2TURHAXYIJAR339HANYQA5sWzKK8/7cJgFCY5QDuxtIFbkcE2i5wMXVxO5MInzBypK4f72jhyGqb4s0nKcTq5QG6zAJSPEt1zdaB6p07xzOdNK+ZIFuREzLluG/T0vFi2pjkx4Du03zErQ9F5chDc/4J4M7hXYZ6UBGdyg6EUS0HUiFw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7217c74e-7287-4121-6a71-08dea1184736
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8344.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 09:11:18.2990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJ4xq50ZBZds2VaRQ1RfVhr0Qq9yA3wQt/XqYZ8h82UkY7fpfjo9/tyAjoMSBSeA8p5Frxi9ODil6ubLbZchtaDCvPUh0PwjYec9KDK5UpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6823
X-Proofpoint-GUID: 3pB6ffM5hxfwELlibyvdTLXb7No7nFzz
X-Proofpoint-ORIG-GUID: 3pB6ffM5hxfwELlibyvdTLXb7No7nFzz
X-Authority-Analysis: v=2.4 cv=EY74hvmC c=1 sm=1 tr=0 ts=69e9e239 cx=c_pps
 a=+UayH2mdqs80qU9+PBkj6w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=-HhFvLZS0_GLIt-yJWcA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDA4OSBTYWx0ZWRfX7AAyLv7cyi3v
 LJICEBIgilBPVIC2x42olulnKjAoMTtWjn7A1TTCAMw3tm/w+t1pkGd7fHidO88J/2AYsXTq/2e
 BOZRFPiLMwEUzCgEdTyJd/qwjaymhHuljsnFiYx6mCFPIPEa7+B5mM2HGejpdA7TUzr/o2tnwf5
 jt4/30WWuQcTGAz0JxWfxr58XeLjXIt+oSC8Ce/iUSgfRi5ox5SzHLrYw4slXBvSFqoAOaXU9Tx
 eEn7xz9T6uAopqvpJ2NUCIncDMPjFcZFIoSBm6FHN8sLexs+kXzVY8WxdRpf1wqXnOZs07RCdJ8
 BaDdp54RkkmuoDt9RjsPaqmiccaMWR8KCW5ef/jQlNlVEXkFn4/6vDZbF4sliWsxgNXOtfNmlyK
 nvSiNs/W7VobRQS630ngfFYevd6M7xUJj8OGwZXPbMiK+i5pAb1uAGl90u/ujY2FmReBnnlVOCJ
 QZdOFSNRp5zLHFdwftg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 adultscore=0 clxscore=1011 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230089
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 09:11:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3774

The permission in "install -m 655 ${UNPACKDIR}/arpwatch_init ${D}${sysconfdir}/init.d/arpwatch"
should be changed to 755.

Signed-off-by: Xiaozhan Li <Xiaozhan.Li.CN@windriver.com>
---
 recipes-scanners/arpwatch/arpwatch_3.3.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-scanners/arpwatch/arpwatch_3.3.bb b/recipes-scanners/arpwatch/arpwatch_3.3.bb
index 3ab5993..3769706 100644
--- a/recipes-scanners/arpwatch/arpwatch_3.3.bb
+++ b/recipes-scanners/arpwatch/arpwatch_3.3.bb
@@ -65,7 +65,7 @@ do_install () {
 
     oe_runmake install DESTDIR=${D}
     install -m 644 ${UNPACKDIR}/arpwatch.conf  ${D}${sysconfdir}
-    install -m 655 ${UNPACKDIR}/arpwatch_init  ${D}${sysconfdir}/init.d/arpwatch
+    install -m 755 ${UNPACKDIR}/arpwatch_init  ${D}${sysconfdir}/init.d/arpwatch
     install -m 644 ${UNPACKDIR}/arpwatch.default  ${D}${sysconfdir}/default
 }
 
-- 
2.43.0


