Return-Path: <Haixiao.Yan.CN@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B9ECAC592
	for <webhook@archiver.kernel.org>; Fri, 19 Sep 2025 06:04:04 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.9447.1758261840676165180
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Sep 2025 23:04:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=GaiX3DNq;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=1357365af5=haixiao.yan.cn@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58J5pEWK728721
	for <yocto-patches@lists.yoctoproject.org>; Fri, 19 Sep 2025 06:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=ufG22RKJn46YcQMN94TG
	FGhOI/8HaW2RYjEQu152Yoo=; b=GaiX3DNq6okUwEtwcUje6nLViVoDCbCumOvP
	H/Qpx2tYO5906huq/qm29704oovVTMJUz9mEhOCFBeEJrL1JJ5+h7QcoPBB5TqhO
	JKDOpgzXR12iqP46OqyMS3obkdB2I8e9WvFWtEg7ALd+um5KMyF2LPhQqJTK2a8I
	PhDmw91YkM8VIhssHSsM0CZlBPZV0nVPXNLdDaF5z5XMpCj0HpyAP51D/hSa5FCR
	ZIsPi5EhDRGf0SvarQf7JNSxY7yy4n3zQWURlbzYPtyfiuobqxo2cBev36CPADZY
	QDSaiiR9YZRGJbXw/Ul7rL0TAtYvGxeghl/DuLRf+Cc0qnKdTA==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012045.outbound.protection.outlook.com [40.107.200.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 498vjw06tf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 19 Sep 2025 06:03:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nl3tbL/o0B1+iLTBvpn6fynNwFDIZmiHJZmydLr6j6lDtCUXc8JhCnSE8KhUTEmS1eP5IU0KVuN0/c4ied4Tushy2b/w7d1caPOatGxREmZ0zboP9s+nADMasy5UJa2j3WhqKZkDjMXY/tU4iTajA34GHIEImiITcZJPcXe8Yi9lnQSMwMwC3jO+PX/uQAlVmBcNQ3yYe7XNECtDsAK/1pKHB5eUmwSBVYKRcfRUFeitRrD9m/URtn8xpW/WtF1DxYIifwyxUCbBuVCv5o1tse/bViAs13mbgWW0N3qN5ZffSwmc4LKQazSqSCDe/WAvZHWiwo+DMATxj9dg+B8gUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufG22RKJn46YcQMN94TGFGhOI/8HaW2RYjEQu152Yoo=;
 b=J/M8DYDJVQ+FI2Y8MAjdw47zNNFJjZlz6EAH8MYbUcPvzVl5ROmjzidUlG+xTBomF5QqiRfEpNI2or1+3EsvuStovLp8LyiWgYOj1RcsMKNBsES8Q6L2CY5hA0oB+YjvwMKvuCfPOu5NvHw5CQKdQa0xKeUlWfh7O9yAhiD/gP2+p3mG979OWyaI0HN7IuDcXx05CQ+wFIvbz6SVYeTgg18vL+IUberm93X6cGg/pei/egZDM4c0Tmw2YGHQJicw3tOs02v7T8IFWB/n71gfQMkv46I5PvVmE8OG/KTW+0JrywI+Q6JeTewoB77bjNMSV6y172O07hqGxDf2PmV1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13)
 by DS0PR11MB7901.namprd11.prod.outlook.com (2603:10b6:8:f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 06:03:55 +0000
Received: from CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4]) by CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4%3]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 06:03:55 +0000
From: haixiao.yan.cn@windriver.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][walnascar][PATCH 1/1] samhain: Adapt test output to Automake format for ptest compatibility
Date: Fri, 19 Sep 2025 14:03:36 +0800
Message-Id: <20250919060336.1326690-1-haixiao.yan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0218.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::17) To CH0PR11MB8189.namprd11.prod.outlook.com
 (2603:10b6:610:18d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8189:EE_|DS0PR11MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: c88066bd-c876-4c0e-c112-08ddf74250eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?onsBtMptkuVhlr6NoJQaLF/TcjXVR7H7DFp3EnKFhEGp+OUXCc+mFRh1FnO3?=
 =?us-ascii?Q?sI/qpym6SWs6Uz0vl73zGgs3wSn33i67t+KqLvOHUDTwdpfAv1WUEOrxUAvV?=
 =?us-ascii?Q?2r7xyymrtbvrCjtecFo6DiO/tdAGXMkNTaUS5fZZy8Blm3wdVLQfkedKjNLO?=
 =?us-ascii?Q?P1GeOVfwxsOYMpAfA+8PJJaOPQW2ooOR+qxqeCT542yGEwxQcJFh5e1utI2X?=
 =?us-ascii?Q?b164O5vi9T/QupaFu1SE4801BrCa7KATI5iXBcvIwRQelFfj86fDpad3CLa/?=
 =?us-ascii?Q?9c18gcZe+RZbdkN66WirhKq66JwzTN4kpQ9r4zUaGdSj8ya6gNLNlYF05oAq?=
 =?us-ascii?Q?Td/6GatgdIgd7WcYCLpvxmyeVTOLH+mkxmmi4wNzNpV4wmtHH8wDRSS/b68S?=
 =?us-ascii?Q?5LwG2L39u2o7weQZol9mP0QXRHcMYOPEEmCyyueQHa0joMOb0Al/jXdBkb7K?=
 =?us-ascii?Q?QEmkiVvBqaPDC42a6TFrDc3KfG3AanolAXu/lZpiFjz74rKt1Xxi+byf7Uyu?=
 =?us-ascii?Q?OThCZUT8yYfkWYhIXpbhx20qbNDSy+8gsySKC9/T0vCqeaRqyIShgoF4Mn6Y?=
 =?us-ascii?Q?TIvNybFM1bVbMmXgPUOfSy4bFKGBQfvS4oQxm7hUoOtVY1hyUVYTbz9GVFiz?=
 =?us-ascii?Q?hinyZGnGnB/kEvq0xlY2VlrWlvkW1TyjVEi9vIchXEdQgRKgUPj2/Gp4U7rS?=
 =?us-ascii?Q?SHDnBudxkY5eGFUGPeq7Am/oDgrDs54m10v/m51L6bG4hLY0g/m8LcDE/3Lt?=
 =?us-ascii?Q?QqOdBsXwF2d0GtGAFvgkwgz2KlxwGIvx4NbLx3VlYbtKU/M3jCd4zXezUJnt?=
 =?us-ascii?Q?eMaTLEywFR77Ni7fov6C2iOXFQCyzbd/p6b75aSCcPvO17+gHOnUUbOaRpo7?=
 =?us-ascii?Q?zfp0zSvXVuI5tfLCEbxlK4iFA0wGOkk0TFdJjLb+p9f+5sd2SFFapvcr94yh?=
 =?us-ascii?Q?OK7NaRzpYSJOjPuCak82Gw6LKAv03sG/eXMulb8duJokv33LEAVsxEDGbdvI?=
 =?us-ascii?Q?L4w5M+2WXcQLP9HrBRXp/HA6BBKs5PxrXSPPjP1e1Ba6StjiA+m6S6nLYaGt?=
 =?us-ascii?Q?nSMlEDKGFvjrosPEa9fK6ZK/zgLB+3T1fRSGGUTSdz/V4dZHi5b/sGEWhwGx?=
 =?us-ascii?Q?zoKYWJBTXSWZ+HdF1IloNE5Wj77BfoCISb7/Iisw8QjwbhDPWjVNT/df4TWc?=
 =?us-ascii?Q?MQ1Ivgbfrk3LyoeRogqKTqkAlLEUF0P13KrIW5RjwXXCu9LvcowsVLmUmU0g?=
 =?us-ascii?Q?HYQD7Aym0JjVGjuFtW+bUZo0anGm+2FEYdS1naKQSuXJcKfCddinG7wbC9ij?=
 =?us-ascii?Q?QOyJ/sC/nxzjudjNIldTajyx0ad4yyLKVnXeS9LedTpzwByUHJ3GNHy/2J4j?=
 =?us-ascii?Q?dsslZki1/4UL3ka0WlnGGFKNXDEZ5rPmgnbKTxDuDIPbB9cqJAFFz2yo1eAH?=
 =?us-ascii?Q?1InkSQzKzyI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8189.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?I0uuvoZQDBeU53GDQ3/Be5ueP+BHKBpplZOSSDhdI6wWnQln/c0ZBbmZFwa6?=
 =?us-ascii?Q?5ph4XUD8uC19GPgNPAexiAPdWrtZESh7V3JoJKdXPEJNzaYxU6zm3dj6eosh?=
 =?us-ascii?Q?0HDirla7vGN3xsU+9w2m7vg/tuzVWnoDh4ltLMdJZpkq9WpHCBlVdJwbUcyr?=
 =?us-ascii?Q?5E4gL29fiojHTDYVSrfTuvldPJtRN7nBzLWA9kHrO18qAul3YvWg0BJk6Aas?=
 =?us-ascii?Q?RXJ1FJuf8RU6k8AMaBOh3NCLNrrltG68BVp0En/EljHSwKzPm40NmpbAFjQe?=
 =?us-ascii?Q?IvxlN21GJB/MFRHmVElwLul3CFPDIvlKX0gFJXqKR5LsOcawOksnCzf+Peho?=
 =?us-ascii?Q?zRuPSk1Jbdx0XYeBI4gFVGc17ZUQUadKVOmNAqNYJEtwQJCuIsald1VhFiXj?=
 =?us-ascii?Q?faRtpgtHc7fFcAuBMhK+5vZZBnKny9eiLKZBw7k/jmpK7pkCms8+VIHmlpCG?=
 =?us-ascii?Q?CkyWuxnSpvW45QJjsJQlacpnflJwDkCVwnPqWLBvLcbYIEGWuhq9SMU/3IkW?=
 =?us-ascii?Q?HtYwnTSCMsm4csXe87TCqCHLoXMFRIYSXC7veADGbiCNrfxByJxmMhGwx++/?=
 =?us-ascii?Q?bluyBbt7IJnTravjTIYJ9H2SYie6cESlBQCbr/oLzpHWYR5sfu2ef+wCa0pt?=
 =?us-ascii?Q?wKQVtcPEhR/g0wz+exeI0cXK4P563q9K/jTkZcXO03Gxzk5R9gVpt0AtASAh?=
 =?us-ascii?Q?SkmBuexjg0sT27q+y6twfCB6K0KsFy5VT+T/LE60cSOyaueVtGR9cJy0Mq57?=
 =?us-ascii?Q?0Oyim3juWRfui4N4+yMJkzrEp4dBSAFQ8+t0WI8XGRvYSzz7p86RolLOeH5t?=
 =?us-ascii?Q?2r680Ihkhx73RTft22cn7tw7uNX42eQ7cUM3soTOxznnpPGtJNHaSV6/6L/M?=
 =?us-ascii?Q?U11k+MzSPsIV0Pk2JrnQE8r72/xXhF18InZkzrsHs0r/1yARp5EGypj0SGAd?=
 =?us-ascii?Q?J8z9bIlttCeibuovJh4zfwSJt2e0r+zX+/x1ItyPn/MeOSxTbIPp6E7430IH?=
 =?us-ascii?Q?GS6Pgl3VEewJR0uT6odCHMu5+8W1HnsjeitvuETylC+Yi6utwvfWeoZESbmx?=
 =?us-ascii?Q?PzB8dMsdI6/QTabkGwFhsHsMtbJbH7kd8h8Epo7PRcKsTk43EoZT+1yFL+kT?=
 =?us-ascii?Q?AFfX1bHNvPSiP3SHluw/Zi78VSq/OeGmvfV0rFA0a960AZ7O8Z7WZr1MOycB?=
 =?us-ascii?Q?Qr4uGUQrmFHaF1uz9a41fJKGpPJZgDUJLMdr2UlQXNXvS7IOg1IcfA5u72K/?=
 =?us-ascii?Q?KBGimz38Tk6WXqKl/l7J4PSdbDsRz4IRspOHYnH/qcLqsFWoEqOIfnA2yhNR?=
 =?us-ascii?Q?v96Igg7tvJHduk/Vi9Ftck6B+u/vN5kxXM518Bpbx+c2LJUbQMszLKeJrScM?=
 =?us-ascii?Q?kfyqgtWevqcAuRJRZURr6Zhm9iKCsZBZ5pGbJFtyr6OOinAjvSIMzgpCTXn5?=
 =?us-ascii?Q?6AOblfeb7R7ahGyXt1+ALZTYU3FCXflmqUPSIgrcQ76cFWv2xmuXygKzSFuW?=
 =?us-ascii?Q?ie0FXNPyT0TFbK0qciXUX/+VDzaHuGIrrANIc+PQiCPfnAuS34/JWq50Il+C?=
 =?us-ascii?Q?SFDLxpbprnM8fVW60bB0SINiDZepTWKazfBBrg5GryXHcns3MPb5DqneST9o?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88066bd-c876-4c0e-c112-08ddf74250eb
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8189.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 06:03:55.6928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SS1b2u+PGDOyK63qFYceGsVD3sIvoN79FwNvlsMiqPTNEcDWoi2UrCZZLBAdjkTh47HOuQBns8lZ4UWRxlC2NywjVFd+k2TunZ4R+vkj0Hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7901
X-Authority-Analysis: v=2.4 cv=Hrt2G1TS c=1 sm=1 tr=0 ts=68ccf24e cx=c_pps
 a=HkOkC5mvV7OaefGfpXsf6A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=nDJU2pNIAAAA:8 a=t7CeM3EgAAAA:8
 a=k-42gJp3AAAA:8 a=u-Ki5qhF6FRpIUQTSuQA:9 a=cvUpGn6QkLxiVzwzn9tb:22
 a=FdTzh2GWekK77mhwV6Dw:22 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-ORIG-GUID: Ux3N7n4qNvMJoeLxaHmKXJjQlkzGoAJK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDA1MiBTYWx0ZWRfXzJaXyezfU9/L
 4v3/fqIiEn/DYEEAVqCv2yD2GPMovlc/vNTcoRydYxjVWVbMs5ZUSWxik2rEDKgxEyYoqDoHfFO
 abeGZe3pkI0KkGufWSdsAi0Q9TYjfkbNx6j8Vfw8LsUryn38S8snK8nweLyxUnnJkN1oBgTkBHv
 9gL7kyi4oEY9sNoKmDngpqraGDEoDr4RXsJuLxFOFTOx/K+cARqkEwt09voZANeXUs/mQ90MqvW
 8zjH+ZNbL0vmVBogtN+5xUmVeiYwjgklFNUqcxVPhQiPFLlXx68DU2PUUh3NvDRe3bDWIp83Ed3
 m/2GcptlBuiqnC2MPeaqDyBJdbMNPJO/oiTEUy472XJnqM/yNcw0zJ3QDyCiUQ=
X-Proofpoint-GUID: Ux3N7n4qNvMJoeLxaHmKXJjQlkzGoAJK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Sep 2025 06:04:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2218

From: Haixiao Yan <haixiao.yan.cn@windriver.com>

Convert CuTest output to follow Automake-compatible format
(PASS:/FAIL:) so that ptest-runner can correctly parse and
report test results.

root@qemux86-64:~# ptest-runner samhain-standalone -t 3600
START: ptest-runner
2025-07-06T09:38
BEGIN: /usr/lib64/samhain-standalone/ptest
PASS: Test_quote_string_ok
PASS: Test_unquote_string_ok
PASS: Test_csv_escape_ok
PASS: Test_tiger
PASS: Test_tiger_file
PASS: Test_tiger_file_with_length
PASS: Test_sh_tools_safe_name_01
PASS: Test_sh_tools_safe_name_02
PASS: Test_sh_tools_safe_name_03
PASS: Test_sh_tools_safe_name_04
PASS: Test_sh_tools_safe_name_05
PASS: Test_sh_tools_safe_name_06
PASS: Test_sh_tools_safe_name_07
PASS: Test_is_numeric_01
PASS: Test_dnmalloc
PASS: Test_sh_unix_lookup_page
PASS: Test_sl_strlcpy
PASS: Test_sl_strlcat
PASS: Test_sh_util_acl_compact
PASS: Test_sh_util_strdup_ok
PASS: Test_sh_util_strconcat_ok
PASS: Test_sh_util_base64_enc_ok
PASS: Test_sh_util_dirname_ok
PASS: Test_sh_util_basename_ok
PASS: Test_sh_util_utf8_ok
PASS: Test_sh_util_obscure_ok
PASS: Test_sl_stale
PASS: Test_sl_snprintf
PASS: Test_sl_ts_strncmp
PASS: Test_sl_strcasecmp
PASS: Test_zAVLTree
PASS: Test_sha256
PASS: Test_entropy
PASS: Test_fifo
PASS: Test_file_lists
PASS: Test_file_dequote
PASS: Test_uuid
PASS: Test_ignore_ok
PASS: Test_inotify
PASS: Test_ipvx
PASS: Test_login
PASS: Test_login
PASS: Test_portcheck_lists
PASS: Test_processcheck_watchlist_ok
PASS: Test_processcheck_listhandle_ok
PASS: Test_restrict
PASS: Test_cmdlist
PASS: Test_srp
PASS: Test_string

DURATION: 0
END: /usr/lib64/samhain-standalone/ptest
2025-07-06T09:38
STOP: ptest-runner
TOTAL: 1 FAIL: 0
root@qemux86-64:~#

Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
(cherry picked from commit 06bd60600e8db1b843cf5cc0f074a11eac7e9a80)
---
 ...t-output-to-match-Automake-standards.patch | 102 ++++++++++++++++++
 recipes-ids/samhain/samhain.inc               |   1 +
 2 files changed, 103 insertions(+)
 create mode 100644 recipes-ids/samhain/files/0001-Format-test-output-to-match-Automake-standards.patch

diff --git a/recipes-ids/samhain/files/0001-Format-test-output-to-match-Automake-standards.patch b/recipes-ids/samhain/files/0001-Format-test-output-to-match-Automake-standards.patch
new file mode 100644
index 000000000000..eccd24290ce1
--- /dev/null
+++ b/recipes-ids/samhain/files/0001-Format-test-output-to-match-Automake-standards.patch
@@ -0,0 +1,102 @@
+From 065813e5ec274942c4e8803d813ae863fb17313f Mon Sep 17 00:00:00 2001
+From: Haixiao Yan <haixiao.yan.cn@windriver.com>
+Date: Sun, 6 Jul 2025 14:34:08 +0800
+Subject: [PATCH] Format test output to match Automake standards
+
+Upstream-Status: Pending
+
+Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
+---
+ src/CuTest.c      | 63 +++++++++++++++--------------------------------
+ src/make-tests.sh |  1 -
+ 2 files changed, 20 insertions(+), 44 deletions(-)
+
+diff --git a/src/CuTest.c b/src/CuTest.c
+index c1884daedbd8..44007fdb97ff 100644
+--- a/src/CuTest.c
++++ b/src/CuTest.c
+@@ -302,49 +302,26 @@ void CuSuiteRun(CuSuite* testSuite)
+ 	}
+ }
+ 
+-void CuSuiteSummary(CuSuite* testSuite, CuString* summary)
+-{
+-	int i;
+-	for (i = 0 ; i < testSuite->count ; ++i)
+-	{
+-		CuTest* testCase = testSuite->list[i];
+-		CuStringAppend(summary, testCase->failed ? "F" : ".");
+-	}
+-	CuStringAppend(summary, "\n\n");
+-}
+-
+ void CuSuiteDetails(CuSuite* testSuite, CuString* details)
+ {
+-	int i;
+-	int failCount = 0;
+-
+-	if (testSuite->failCount == 0)
+-	{
+-		int passCount = testSuite->count - testSuite->failCount;
+-		const char* testWord = passCount == 1 ? "test" : "tests";
+-		CuStringAppendFormat(details, "OK (%d %s)\n", passCount, testWord);
+-	}
+-	else
+-	{
+-		if (testSuite->failCount == 1)
+-			CuStringAppend(details, "There was 1 failure:\n");
+-		else
+-			CuStringAppendFormat(details, "There were %d failures:\n", testSuite->failCount);
+-
+-		for (i = 0 ; i < testSuite->count ; ++i)
+-		{
+-			CuTest* testCase = testSuite->list[i];
+-			if (testCase->failed)
+-			{
+-				failCount++;
+-				CuStringAppendFormat(details, "%d) %s: %s\n",
+-					failCount, testCase->name, testCase->message);
+-			}
+-		}
+-		CuStringAppend(details, "\n!!!FAILURES!!!\n");
+-
+-		CuStringAppendFormat(details, "Runs: %d ",   testSuite->count);
+-		CuStringAppendFormat(details, "Passes: %d ", testSuite->count - testSuite->failCount);
+-		CuStringAppendFormat(details, "Fails: %d\n",  testSuite->failCount);
+-	}
++    int i;
++
++    for (i = 0; i < testSuite->count; ++i)
++    {
++        CuTest* testCase = testSuite->list[i];
++        if (testCase->failed)
++        {
++            CuStringAppendFormat(details, "FAIL: %s\n", testCase->name);
++        }
++        else
++        {
++            CuStringAppendFormat(details, "PASS: %s\n", testCase->name);
++        }
++    }
++
++    CuStringAppend(details, "\n");
++    CuStringAppendFormat(details, "# TOTAL: %d\n", testSuite->count);
++    CuStringAppendFormat(details, "# PASS:  %d\n", testSuite->count - testSuite->failCount);
++    CuStringAppendFormat(details, "# FAIL:  %d\n", testSuite->failCount);
+ }
++
+diff --git a/src/make-tests.sh b/src/make-tests.sh
+index b6cf814e7030..01399ca75775 100755
+--- a/src/make-tests.sh
++++ b/src/make-tests.sh
+@@ -45,7 +45,6 @@ cat $FILES | grep '^void Test' |
+ echo \
+ '
+     CuSuiteRun(suite);
+-    CuSuiteSummary(suite, output);
+     CuSuiteDetails(suite, output);
+     if (suite->failCount > 0)
+       fprintf(stderr, "%s%c", output->buffer, 0x0A);
+-- 
+2.34.1
+
diff --git a/recipes-ids/samhain/samhain.inc b/recipes-ids/samhain/samhain.inc
index 6b8d30e1bcdb..fc4e4237fe2a 100644
--- a/recipes-ids/samhain/samhain.inc
+++ b/recipes-ids/samhain/samhain.inc
@@ -19,6 +19,7 @@ SRC_URI = "https://la-samhna.de/archive/samhain_signed-${PV}.tar.gz \
            file://0008-Add-LDFLAGS-variable-for-compiling-samhain_setpwd.patch \
            file://0009-fix-build-with-new-version-attr.patch \
            file://0010-Fix-initializer-element-is-not-constant.patch \
+           file://0001-Format-test-output-to-match-Automake-standards.patch \
            "
 
 SRC_URI[sha256sum] = "0b5d3534fd60ecf45dfd79bd415e81f7a56eba7f1755771735e204f334033578"
-- 
2.34.1


