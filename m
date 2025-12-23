Return-Path: <Ruiqiang.Hao@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A33E6F08D
	for <webhook@archiver.kernel.org>; Tue, 23 Dec 2025 12:37:53 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.100211.1766493466197114154
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Dec 2025 04:37:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=QSH/p/F0;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=4452e635ca=ruiqiang.hao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNBpZ2Z3605745;
	Tue, 23 Dec 2025 04:37:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=6dWWiVDRC2agirWPrUlH
	htRXWOqWt4+/g6EUrV+mKJo=; b=QSH/p/F0dhBkemR7kxRkv3ekQeMuRe+aUSqw
	c2wc4XySCqMptSXKULL3lx5nPADFp6dwytcfwDxJ83OnMN96uaf3gRxMk8MWsqO4
	3b8IDuclgBSFnlqMSbPNB7a8VzKhOfBhnfADqSKFAW4sm0HSu42NWn80YGIGlr3A
	kYUVGAidj+h87S7fhoLwsxWEZZ2F3nvZ0pgDBo2WbSit9n6sw6TXZnajmlDyAEgr
	HVpkCUATM5wMqRrLHBRzMVrZMODSEBuOUQ3e15cCgqG/5O8xOqTbrWJOmpIRUOHC
	/j1hFdqJknskyWCtD6mJ0hMFDwxzzJ7n5kFhKBpgNU0oQvhjkA==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4b5v6hapt5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 23 Dec 2025 04:37:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNrt91MVJiH8VPAby2zRkfS0QBqEi+Ce7ZDgeEwsmd+TFlft8iCf31pVdGtR6qi00ZkAUHJCo1e+OzAl9kMubz0KQK3ErYH+CfoxrIxtcGoxy9kmQrcSaa3XHkSuknXdr/AkyB84pHZ14CFb6UV+Zx9GbSiGQYgeGQYccF/BPSW9JB0sVBWmTM7Px/7pWJlm7HaC1ZMxKKdo5x804l8Dlx/rJ6obc1JYJLnizlRpG3aWvLh/aEmpSt764IwB9AijYpBDUv5c/54bL4zdidUuKCnP+gs7So3djlbgq3I6aHuh+OS7oomvpFKdvPZORrMfWmdSia3AQ1a3XfetXdZzEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dWWiVDRC2agirWPrUlHhtRXWOqWt4+/g6EUrV+mKJo=;
 b=joL9iZnTB2ol8NaRUJqMavO/wNwTFjvcDGW9u+kTZaQCl+f2aUxwA+KppYq2PheXjnHDGhQvMAkldB5jmJPK/y2igCRuldcwowqq9PrCUpHfNmp+522mZDfZND+oEzxbLVx7kTjCTBGT/bADYQUrlDs1YpuhR17T21j74fAAC+/0d4Tfxs7IPboaOKxGGUvCkMijjYGmbMVAz+zhW/GqEvmTu1qw7wwlAt0LH/62bONqWa81kz7f1qbDqA2/Ao+zJZT0wSoGX9+E5MxJ3d2auK7skvpqpoar8v5hh6mPdKTl4bpckily27gOJZU8Hh7G4B6XgUmLdK6sOj8Fi6cpuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN7PR11MB8025.namprd11.prod.outlook.com (2603:10b6:806:2dc::19)
 by SJ5PPF50B3E12BC.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::828) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 12:37:42 +0000
Received: from SN7PR11MB8025.namprd11.prod.outlook.com
 ([fe80::a5fe:8f1a:b4b:d00a]) by SN7PR11MB8025.namprd11.prod.outlook.com
 ([fe80::a5fe:8f1a:b4b:d00a%4]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 12:37:42 +0000
From: Ruiqiang Hao <ruiqiang.hao@windriver.com>
To: anuj.mittal@oss.qualcomm.com, yocto-patches@lists.yoctoproject.org
Subject: [meta-dpdk][PATCH v4] dpdk: upgrade 22.11.7 -> 25.11.0
Date: Tue, 23 Dec 2025 20:37:16 +0800
Message-ID: <20251223123716.3025878-1-ruiqiang.hao@windriver.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::15)
 To SN7PR11MB8025.namprd11.prod.outlook.com (2603:10b6:806:2dc::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8025:EE_|SJ5PPF50B3E12BC:EE_
X-MS-Office365-Filtering-Correlation-Id: 7abb9651-e646-4592-25de-08de42200efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1ie6gxrT8DKTQC901dSpLkZEyfAZgEMkUfcfXIXdqgqcm9aQTmLJYLyBDMQu?=
 =?us-ascii?Q?qfo+vdylgWlHHPykZOt1QOr79wiP2UdcWW4t3CdWXz/U2RSiHyOBGPWOUo9p?=
 =?us-ascii?Q?ACbhzEJC9dr59z4eVqid/7hrAUGMWkg+0jfGXiCVi0lbvpEndVsf9diVwOMQ?=
 =?us-ascii?Q?HI5ZuFWOv1cV5AymYlj3iZNA7M45/yZB7YO2vp8gp7tALXweygAUwJyUcGFi?=
 =?us-ascii?Q?BZ+umI1XSrY4rviicACE0qKL8GzEqBcbwQ6bXOgIX9+JdFs0xAyXxU6XVq3J?=
 =?us-ascii?Q?j8DK5NbAheacqHrOAyL8R1zlOBH3ELDmJENzVVvlh1tT9MC93uKcz7Ex6kKw?=
 =?us-ascii?Q?4Zfo8cMmrmQKo1xzaxcAsK5T9WE0OOkyaQLnoscJMIusPqMw8G6OQ+a/qVTR?=
 =?us-ascii?Q?i25caPzXrFF4vNzln4ATCtXfz/7INhcJoBEHkju71CCnhZE19vOlGR5p3T+f?=
 =?us-ascii?Q?51CBgghFR+y8ZeVnfX2Oj6u1j3Vgt4+4imzTbQDvSo1Hb+DtvSimC/pS2ydl?=
 =?us-ascii?Q?de5uCtxX1hptsyn/JvU92iyrsGcLykvQ2zCCvupKwTt3j4tOSbiAlZn0+TLm?=
 =?us-ascii?Q?fOiK6053I9ESrDj7qF+uuGPjSfQfDjpSy25ETVCnUJ5FOC9xdj+G46YtxZ+y?=
 =?us-ascii?Q?YpUnoWctH5vpYfqXEAp91uI5ERNIz72wdd9k0DbfVNwUsSoEsnQ+0Ym8rN4y?=
 =?us-ascii?Q?6+Ljtz9JXlcMdLSTg5lJnamA25l8IT7Dg7VbA9KHHdtYoi6gPYljHQ82YEWv?=
 =?us-ascii?Q?DULVWHmTEDOQhqPtywrfzVp0QdbgBnC4Kh2zCvdUNHfurzausI11GDndRKP6?=
 =?us-ascii?Q?+mnZU4FJNFSO58Nok3WmrlluXKyQmDbie9WBux5eW+cXpa3/u15cCRHt2tLf?=
 =?us-ascii?Q?+JlMSo/rNpho9OFMVSYXFTaX0yBMDHIpzoRiQExBqxFgfaOb+0kv7H4Rx+nR?=
 =?us-ascii?Q?Y4T3pUl+tOdQD4beQraRbZbqttTOA1H7F958koU6JW/dv0hHqcAmH0CMX2ON?=
 =?us-ascii?Q?lsMPZKQGO26U3MdIqttr1zHBOo67lWOdsE6htSVQUA9BVn7OhE1S/8W+aO7s?=
 =?us-ascii?Q?CYkzdBsEcG+vniy22K38CC8hWo7n3AZTiS733gyffYP4lcOriVHxfJM4LbIU?=
 =?us-ascii?Q?c2rZDDnTtvb/BcMl8VJT9QeW3Z3tM5OFfz3CpKoULnLlZVmF+xd0M1ZlurwK?=
 =?us-ascii?Q?27Xo+hzvgkMotDH5ay1XYs+4bXIPLxnnvRq8Zf6W45jjEVw/NrPii0ZNQapJ?=
 =?us-ascii?Q?SmG+p4Uv2m/Kl2TGf9M/fqIoDHXaRItjgBxOpFBrx+lwQXitx4uKr/Ovq7Zu?=
 =?us-ascii?Q?pJnIQYIXdEL8maN45HG+7PwKtb1mJXpuOyoIb82wD/vCPsJ3zP1ihp9f9o4N?=
 =?us-ascii?Q?SfQiY+dVLBwB034LV+r8w5QPmcbCy9pXPkffhxPPOrG+oju2WQoY8zRfdG7o?=
 =?us-ascii?Q?lpLupJZbesca/Oqe9PbUY/ebE2Ghtwroa/nI51jXeWZRT6VRMYx3jtePrYNw?=
 =?us-ascii?Q?Elfg2QTTX4JWPlPcUjNxYX/iQHHrrTEy1DYV?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8025.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?O62h+o/jFI3KHjSv0WZNTCFVTzxWHtjstjRtaJ4SdN6b08lqSkEnDuRJBc9y?=
 =?us-ascii?Q?b/cYOGV0tbrUYhWIODHPJmwDfel+Q1AmG2R9z0HnAgoAZubeuXLBwjjFlnBv?=
 =?us-ascii?Q?lcktBqxO0BB/iaoD6Q7EhzHgj3+jUzeiajlDt6C/GNmfBRdrZOBpVvoQJy77?=
 =?us-ascii?Q?VIdUGp+sUirJVS0hc5+JKjfolw0L7N2qCCiIptdmCragB/+ACI0L1PmTP8f7?=
 =?us-ascii?Q?8M/z1+Nt208958iIRFzGNvenspmOWyCtL8DxhOIP6z6blxADT27/8OLf32gB?=
 =?us-ascii?Q?n629ly8BbAWhQMN2JDcLVSr+9PGvZtdBQd1pvYPbBPLN22txvGxPABA7sAZP?=
 =?us-ascii?Q?LLgfw+a9JjWc3ac5P3nf4bMPxKvvgWE/QifDqV/vvTd9MIoc7KGf7rbl+XJX?=
 =?us-ascii?Q?MaZLLhOn0Z2tT8Bw2HpBUba2bueZHcAL35KUttNNSirb87xP1GUohUyrJ36a?=
 =?us-ascii?Q?tN1s4UcpW5JDCh6XVvnj80jALZTNmITl9hw2NEihTHh2we3WGbl9OTMYeBNH?=
 =?us-ascii?Q?iD1asSuAPO8DKFG1a44D2UH5Xrp8/bfPvO4aFzTKbLKVDhzO6D4Kk4bGXZkH?=
 =?us-ascii?Q?NlHlOU4d0gyNnsIkqODJy8UAd0sTBVV/UDz12nGaAvU/pt6y41RaSwVgvnJW?=
 =?us-ascii?Q?RBgZHQXpeNCfl9tyC4g8wY8rH+IgpBqPNcVbHWLnQ5oJzBaQQbipeWpEfE68?=
 =?us-ascii?Q?FnaC05Hom7T4m9RRDfaA3K0FWEHasJOB9UiK60gji7QJqjRn3mv+xbVeh2bz?=
 =?us-ascii?Q?XhsqsOiVxSq3XhCFGMYilNg+dfHNPktS0SNVNJwecio5WtYiPWH34gju1fiW?=
 =?us-ascii?Q?Ko5U4BIV93Ef/nn8OFr2E4PpJ+bVffntH8kJu4H8gc1qlfBZOxZjezG7OiUn?=
 =?us-ascii?Q?7wYwShM/TxrlznPC0AmWmxVPNHsGNXisounRvcbyK/iiChFdrpBtNDAkfb8F?=
 =?us-ascii?Q?CzuJ+JuwluKcFlis5Y1BEftkfAS29euKPK+dB2gWQ6aLGK7beRUII4ds3Kyh?=
 =?us-ascii?Q?/T4JatlsOdYk/mp/MrzvKlZhBnFMF+RVAd3M1ayKdFKoCOL9ixulSP9Hjw8p?=
 =?us-ascii?Q?6iekFJiYTepQv3ue0XLWgPP54JXiF5lPt8bv8sFFSRlqPjhsKy5CJ3K87R3A?=
 =?us-ascii?Q?CyXCkhWch2ATTUStvDhnJ953NOtylYvBP3O5OrYs4PcryO3FB93aprY6ItAq?=
 =?us-ascii?Q?aV0o/IjDMxjlqOOg+mlFkYuBkOUo5crxxatxf7cCDuTA2KDxEztAk8/Rj+BI?=
 =?us-ascii?Q?D2wEZaRfNcvkc/P5WL/5RbeUSjwiJJe46GYpxdRk4KfYDGxkF4iJT+InuSy+?=
 =?us-ascii?Q?PfQFaWVdDxfxjNQdSMSlzTF66PrYUbiYvlRjXTpTy4Q3RSMM9C7vepwRfuDD?=
 =?us-ascii?Q?BjA9ZLjzYFt6RR8dfCeNTJhfeXmIF/FcViIkHjGDmvd9ehkn7QNmbDMQjVZj?=
 =?us-ascii?Q?2wVyze7J/KKJ08jhbAt4KxQwR6g+PKxfhlM0mcfjskTfxF5TC9HGRjkcxzU/?=
 =?us-ascii?Q?81UTBwmWkbONJXMurPSG9zVMP5BqOZaf/i6S6vjl4VH9UZ09rSMN9gFmHgvQ?=
 =?us-ascii?Q?BmZNpcnS+6jLSNSMR0SyX/r5quV5mGrJlEK81W7hG0bCibqCiJcX66ChjJxA?=
 =?us-ascii?Q?GcNccrP7ZSTHyQc3ZvL6kmS/q50Z/S4cTx6N7C3m1qzZf+UkpZjBcctL3GMR?=
 =?us-ascii?Q?1Suo2dYYokXZiM5OtYBZjywQSo14zCQ8G9TNJ1xFKo0aIOz/t7lNLoKDPMYG?=
 =?us-ascii?Q?UA2dWN/jWdFNxoZpB0ftsuzIDwtaHwI=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abb9651-e646-4592-25de-08de42200efd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8025.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 12:37:42.7107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwQs80v54nPVPuShMRAgko4fazUXHzUquVHI/ByOnzOPeqa3oACZcoB0plc+tapY2KwCtIedyARooCmBOKg6WGLjxY2p1emcH+dv500SHx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF50B3E12BC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDEwMiBTYWx0ZWRfX/0mty2MuvU78
 NU/AA+7rihsFupIF02FGxsLbXx4azcew9VPsrZmCEZpAKIOvPfHhBMKubxZZHHia1u2jC+Y2Y8P
 /HsVGZ3AQrL7Ood0XQeEnQ6DskEapo3GL3CbpXla3xeF1iJ+lDmjsA8EFnLxYDxhcpemZpuHUbk
 1+z0mWUzlg/BA189BKtGxLOfV0qE8NmIcsYx3o5QfsACfPByKXxJq85BDna/2QcuFXhNjhOqCEk
 bwRkA1oBeazWns/7xsf6PUwI10FldL9irqnG9mHCsPM/BsJFG/fVJx96fWktvPlJbeYIJad0r5/
 X3Ab4f8feJmdc4MV270RipJPAcVubvrQQeK1+1RXrIYs2XjS7TSlbbrl2T/Cdx+kEZeuhPZSHu2
 CBmfImgHVEOQBTXfCOgsMHShcueE1gQt76Y39qKVVVEnIQQvuJ8+Sr69NOd52nk6ajkP/bZB8Df
 /VuCcDmhCwe3v/Vn6vw==
X-Proofpoint-GUID: idlB6cJFZ308H40IS-QTwa_B4kh2fRAi
X-Proofpoint-ORIG-GUID: idlB6cJFZ308H40IS-QTwa_B4kh2fRAi
X-Authority-Analysis: v=2.4 cv=KYffcAYD c=1 sm=1 tr=0 ts=694a8d19 cx=c_pps
 a=R4qMYQySjg0trGpnu7oNJw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=QyXUC8HyAAAA:8 a=xNf9USuDAAAA:8 a=QJRr86HnzN8_0WUMcAcA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230102
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Dec 2025 12:37:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2862

From: Ruiqiang Hao <Ruiqiang.Hao@windriver.com>

Upgrade to DPDK 25.11 LTS release.

- Update SRCREV and branch references
- Update library path to pmds-26.0
- Remove dpdk-module
- Remove patches that are no longer needed in 25.11.0:
  * 0001-Makefile-add-makefile.patch
  * 0001-meson.build-march-and-mcpu-already-passed-by-Yocto-21.11.patch
- Set the cpu_instruction_set through EXTRA_OEMESON

Signed-off-by: Ruiqiang Hao <Ruiqiang.Hao@windriver.com>
---
 recipes-extended/dpdk/dpdk-module_22.11.7.bb  | 49 ------------
 .../dpdk/0001-Makefile-add-makefile.patch     | 75 -------------------
 ...d-mcpu-already-passed-by-Yocto-21.11.patch | 38 ----------
 .../dpdk/{dpdk_22.11.7.bb => dpdk_25.11.0.bb} | 23 +++---
 4 files changed, 13 insertions(+), 172 deletions(-)
 delete mode 100644 recipes-extended/dpdk/dpdk-module_22.11.7.bb
 delete mode 100644 recipes-extended/dpdk/dpdk/0001-Makefile-add-makefile.patch
 delete mode 100644 recipes-extended/dpdk/dpdk/0001-meson.build-march-and-mcpu-already-passed-by-Yocto-21.11.patch
 rename recipes-extended/dpdk/{dpdk_22.11.7.bb => dpdk_25.11.0.bb} (72%)

diff --git a/recipes-extended/dpdk/dpdk-module_22.11.7.bb b/recipes-extended/dpdk/dpdk-module_22.11.7.bb
deleted file mode 100644
index 1ce396c..0000000
--- a/recipes-extended/dpdk/dpdk-module_22.11.7.bb
+++ /dev/null
@@ -1,49 +0,0 @@
-include dpdk.inc
-
-FILESEXTRAPATHS:prepend := "${THISDIR}/dpdk:"
-
-SRC_URI += " \
-            file://0001-Makefile-add-makefile.patch \
-"
-STABLE = "-stable"
-BRANCH = "22.11"
-SRCREV = "077a7044cc5b2533410f691c8db6fb4f6667b1ca"
-
-inherit module
-
-#kernel module needs 'rte_build_config.h', which is generated at buid time
-DEPENDS += "dpdk"
-
-COMPATIBLE_MACHINE = "null"
-COMPATIBLE_HOST:libc-musl:class-target = "null"
-COMPATIBLE_HOST:linux-gnux32 = "null"
-
-export S
-export STAGING_KERNEL_DIR
-export STAGING_INCDIR
-export INSTALL_MOD_DIR = "dpdk"
-
-do_configure[noexec] = "1"
-
-do_compile() {
-    cd ${S}/kernel/linux/kni
-    unset CFLAGS CPPFLAGS CXXFLAGS LDFLAGS
-    oe_runmake KERNEL_PATH=${STAGING_KERNEL_DIR}   \
-           KERNEL_VERSION=${KERNEL_VERSION}    \
-           CC="${KERNEL_CC}" LD="${KERNEL_LD}" \
-           AR="${KERNEL_AR}" \
-               O=${STAGING_KERNEL_BUILDDIR} \
-           KBUILD_EXTRA_SYMBOLS="${KBUILD_EXTRA_SYMBOLS}" \
-           ${MAKE_TARGETS}
-}
-
-do_install() {
-    cd ${S}/kernel/linux/kni
-    unset CFLAGS CPPFLAGS CXXFLAGS LDFLAGS
-    oe_runmake DEPMOD=echo MODLIB="${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}" \
-               INSTALL_FW_PATH="${D}${nonarch_base_libdir}/firmware" \
-               CC="${KERNEL_CC}" LD="${KERNEL_LD}" \
-               O=${STAGING_KERNEL_BUILDDIR} \
-               ${MODULES_INSTALL_TARGET}
-}
-
diff --git a/recipes-extended/dpdk/dpdk/0001-Makefile-add-makefile.patch b/recipes-extended/dpdk/dpdk/0001-Makefile-add-makefile.patch
deleted file mode 100644
index 0fc849b..0000000
--- a/recipes-extended/dpdk/dpdk/0001-Makefile-add-makefile.patch
+++ /dev/null
@@ -1,75 +0,0 @@
-From 768cef60957d5e840071d1d6514d4add3f3c2904 Mon Sep 17 00:00:00 2001
-From: Naveen Saini <naveen.kumar.saini@intel.com>
-Date: Wed, 14 Apr 2021 17:25:53 +0800
-Subject: [PATCH] Makefile: add makefile
-
-Current meson build for kernel module build does not fit in Yocto.
-So added Makefile to build rte_kni.ko
-
-Upstream-Status: Inappropriate
-
-Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
----
- kernel/linux/kni/Kbuild   |  6 ------
- kernel/linux/kni/Makefile | 35 +++++++++++++++++++++++++++++++++++
- 2 files changed, 35 insertions(+), 6 deletions(-)
- delete mode 100644 kernel/linux/kni/Kbuild
- create mode 100644 kernel/linux/kni/Makefile
-
-diff --git a/kernel/linux/kni/Kbuild b/kernel/linux/kni/Kbuild
-deleted file mode 100644
-index e5452d6c00..0000000000
---- a/kernel/linux/kni/Kbuild
-+++ /dev/null
-@@ -1,6 +0,0 @@
--# SPDX-License-Identifier: BSD-3-Clause
--# Copyright(c) 2018 Luca Boccassi <bluca@debian.org>
--
--ccflags-y := $(MODULE_CFLAGS)
--obj-m := rte_kni.o
--rte_kni-y := $(patsubst $(src)/%.c,%.o,$(wildcard $(src)/*.c))
-diff --git a/kernel/linux/kni/Makefile b/kernel/linux/kni/Makefile
-new file mode 100644
-index 0000000000..19897ee06e
---- /dev/null
-+++ b/kernel/linux/kni/Makefile
-@@ -0,0 +1,35 @@
-+#
-+# Makefile for building rte_kni.ko
-+#
-+MODULE_CFLAGS += -include $(S)/config/rte_config.h
-+MODULE_CFLAGS += -I$(S)/lib/librte_eal/include
-+MODULE_CFLAGS += -I$(S)/lib/librte_kni
-+MODULE_CFLAGS += -I$(S)/kernel/linux/kni
-+MODULE_CFLAGS += -I$(S)/lib/kni
-+MODULE_CFLAGS += -I$(S)
-+MODULE_CFLAGS += -I$(STAGING_INCDIR)
-+
-+rte_kni-objs = kni_misc.o kni_net.o
-+
-+ccflags-y := $(MODULE_CFLAGS)
-+cflags-y := $(MODULE_CFLAGS)
-+obj-m := rte_kni.o
-+
-+
-+KERNEL_MAKE_OPTS := -C $(STAGING_KERNEL_DIR) M=$(CURDIR)
-+ifneq ($(ARCH),)
-+KERNEL_MAKE_OPTS += ARCH=$(ARCH)
-+endif
-+ifneq ($(CROSS_COMPILE),)
-+KERNEL_MAKE_OPTS += CROSS_COMPILE=$(CROSS_COMPILE)
-+endif
-+
-+build:
-+	$(MAKE) $(KERNEL_MAKE_OPTS) modules
-+
-+install: modules_install
-+
-+modules_install:
-+	$(MAKE) $(KERNEL_MAKE_OPTS) modules_install
-+
-+clean:
-+	$(MAKE) $(KERNEL_MAKE_OPTS) clean
--- 
-2.17.1
-
diff --git a/recipes-extended/dpdk/dpdk/0001-meson.build-march-and-mcpu-already-passed-by-Yocto-21.11.patch b/recipes-extended/dpdk/dpdk/0001-meson.build-march-and-mcpu-already-passed-by-Yocto-21.11.patch
deleted file mode 100644
index a74869d..0000000
--- a/recipes-extended/dpdk/dpdk/0001-meson.build-march-and-mcpu-already-passed-by-Yocto-21.11.patch
+++ /dev/null
@@ -1,38 +0,0 @@
-From 9aeb0bedf63f0f8f132194705b63ed0045452354 Mon Sep 17 00:00:00 2001
-From: Naveen Saini <naveen.kumar.saini@intel.com>
-Date: Wed, 8 Dec 2021 11:48:27 +0800
-Subject: [PATCH] meson.build:-march and -mcpu already passed by Yocto
-
-Upstream-Status: Inappropriate
-
-Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
----
- config/meson.build | 12 ++++++------
- 1 file changed, 6 insertions(+), 6 deletions(-)
-
-diff --git a/config/meson.build b/config/meson.build
-index 805d5d51d0..620331a736 100644
---- a/config/meson.build
-+++ b/config/meson.build
-@@ -127,12 +127,12 @@ dpdk_conf.set('RTE_MACHINE', cpu_instruction_set)
- machine_args = []
- 
- # ppc64 does not support -march= at all, use -mcpu and -mtune for that
--if host_machine.cpu_family().startswith('ppc')
--    machine_args += '-mcpu=' + cpu_instruction_set
--    machine_args += '-mtune=' + cpu_instruction_set
--else
--    machine_args += '-march=' + cpu_instruction_set
--endif
-+#if host_machine.cpu_family().startswith('ppc')
-+#    machine_args += '-mcpu=' + cpu_instruction_set
-+#    machine_args += '-mtune=' + cpu_instruction_set
-+#else
-+#    machine_args += '-march=' + cpu_instruction_set
-+#endif
- 
- toolchain = cc.get_id()
- dpdk_conf.set_quoted('RTE_TOOLCHAIN', toolchain)
--- 
-2.17.1
-
diff --git a/recipes-extended/dpdk/dpdk_22.11.7.bb b/recipes-extended/dpdk/dpdk_25.11.0.bb
similarity index 72%
rename from recipes-extended/dpdk/dpdk_22.11.7.bb
rename to recipes-extended/dpdk/dpdk_25.11.0.bb
index e69a2df..0978004 100644
--- a/recipes-extended/dpdk/dpdk_22.11.7.bb
+++ b/recipes-extended/dpdk/dpdk_25.11.0.bb
@@ -1,17 +1,20 @@
 include dpdk.inc
 
-SRC_URI += " \
-            file://0001-meson.build-march-and-mcpu-already-passed-by-Yocto-21.11.patch \
-"
+SRC_URI += " file://0001-config-meson-get-cpu_instruction_set-from-meson-opti.patch"
 
 STABLE = "-stable"
-BRANCH = "22.11"
-SRCREV = "077a7044cc5b2533410f691c8db6fb4f6667b1ca"
+BRANCH = "25.11"
+SRCREV = "ed957165eadbe60a47d5ec223578cdd1c13d0bd9"
 
-# kernel module is provide by dpdk-module recipe, so disable here
-EXTRA_OEMESON = " -Denable_kmods=false \
-                -Dexamples=all \
-"
+def get_cpu_instruction_set(bb, d):
+    import re
+    march = re.search(r'-march=([^\s]*)', d.getVar('CC'))
+    if march:
+        return march.group(1)
+    else:
+        return "core2"
+
+EXTRA_OEMESON = " -Dexamples=all -Dcpu_instruction_set=${@get_cpu_instruction_set(bb, d)} "
 
 COMPATIBLE_MACHINE = "null"
 COMPATIBLE_HOST:libc-musl:class-target = "null"
@@ -49,7 +52,7 @@ PACKAGES =+ "${PN}-examples ${PN}-tools"
 FILES:${PN} += " ${bindir}/dpdk-testpmd \
 		 ${bindir}/dpdk-proc-info \
 		 ${libdir}/*.so* \
-		 ${libdir}/dpdk/pmds-23.0/*.so* \
+		 ${libdir}/dpdk/pmds-26.0/*.so* \
 		 "
 FILES:${PN}-examples = " \
 	${prefix}/share/dpdk/examples/* \
-- 
2.46.2


