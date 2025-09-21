Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1F3CAC5A7
	for <webhook@archiver.kernel.org>; Sun, 21 Sep 2025 13:07:41 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.28556.1758460059548385761
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 21 Sep 2025 06:07:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Dh2cpv6N;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=1359d14e1c=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58LCjZEl2354850;
	Sun, 21 Sep 2025 13:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=KHI091rGT
	X2+z/8XBaKKOrxMoJNQaPOITslPDmPKnIU=; b=Dh2cpv6Nx9omHAyqSB700wAOp
	hBIhgJe59rcftxxX0dSATKh4v9jbqwy02NsqYxawG9KNLxNwHoPzXrL7GcVMIQdy
	EPo5fb1B//fArO5RaF34jYDGEI41TnMZeIQwTRzFggJhocEr0egETmhhVHLVkHYx
	T5t1oWVn0TuN2S2BQ4VxopBYiyoDrhsNdyUOKSeo9GM0CFZJ/4WE3h/IVbu1tvS6
	g3ERorqP82/9zRvffoBZffyKG0xIpns+TosvIocPyp2NDTnzlnbp/nq8k3QldEX3
	niAEVJl//U66Z08ykL3HbRqFPruU6EcNElpJjN0OK89tSCI3NGJXSjRlxMQMw==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 499hg1gyv9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 13:07:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5ThUBQtW92JdUdJ7WXKvm2Bqoi/MzSjZ5ibxKxZjl8vu015DYrebrlNhuOt85v/ahJrdPXSjZBJPFRXoNUMUlPXniiZSZUguqZC+fynMYSJZyGOq7Bnp8z5+jVXUb+8JZxKhoEH3KSUKhQAtIJ6vjOki8VwFFwIhLrthLq/nCRe81ROZ/lR3d7Uf5oF00wU/5FgzDYEDKFqLtVgQS0Qr58yesNx9zoO8xNTJgD8AkDHEniU8OjD6nVblNVpp0J2Ov9TH4+Oukv16PY7w+RxKAjdFOB2Vb/clQGo0Id+TCL7E/ewBgEGSKr+Xlu1+LjGIa6CXxMZvzl99pSKe6R8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHI091rGTX2+z/8XBaKKOrxMoJNQaPOITslPDmPKnIU=;
 b=xDd7TEKJmNmyamYIUfrI45IHywZJIKdkZuW1nm51oys6aCZ8lChh4vcqg0UG4bB3ols4dD0PNkoO51fQvYcn+8G4i44kD5zkHAoq6brJ1aKqXs2QXb4itpjeAnGAvA6jNu/gb9odq8fCplzEa2jeoJr2OvzmbrSv1HVJ8yjPh3e7i+Lh5UIPpkcOCfimEbQ/DdPpMaygKWhDI2KQvRuXWAbEaklduYB7R0y9pgLbJe4U3pwtAjHRCoU4yuuCB8pAPhlm9KGhWU0X+NH+zrFZYqRWP1mT8IP9AHBY1jB8r5raXUOFoFvL+ud3FrfAA1UQ49Yv19VXibi4ff6iq9zxuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 MW4PR11MB8265.namprd11.prod.outlook.com (2603:10b6:303:1e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Sun, 21 Sep
 2025 13:07:34 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%4]) with mapi id 15.20.9137.018; Sun, 21 Sep 2025
 13:07:34 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com, rybczynska@gmail.com
Subject: [meta-security][PATCH] python3-fail2ban: update to latest git rev
Date: Sun, 21 Sep 2025 21:07:14 +0800
Message-Id: <20250921130714.415502-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0019.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::6) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|MW4PR11MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: d4420bc9-adf0-4c4e-3ec6-08ddf90fd47c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?uNnx8jAn+DfasSkM6i74AX/Wc2hC3hsN+fGChejLJi0KwnLPJzhF5isCziLY?=
 =?us-ascii?Q?sEq2542/rwLUOr0oyv7ZgsDe4K8SVD4s54SYKo6SzHqf7CWcqDwag5s80B4C?=
 =?us-ascii?Q?lZalhLPXq2t1pCL+WmV8JKfnWklfYSNkmDhgBBNambfqQ/Ed/+yW+0p9UYGV?=
 =?us-ascii?Q?yWsiuxcQd78RiWBDyWmTqZMK/awJ5bQGVPb2p+5+cCn5aKWvyMLqwW1flELN?=
 =?us-ascii?Q?qyEsQWiHFYBfcgAUrRXVCk7d20XlXzto5ecbsxSDKCMZfJhpPqLP3qbN+H0p?=
 =?us-ascii?Q?NJiq1zVfrOePhhvm1qA5kqbD7lnkeT/w4vxG2K1biTzVhtqofqs68fb2+6b8?=
 =?us-ascii?Q?H+dcip6rh4ar+yLjHF24fHI4HV0P8yfY1a9jItB58TXQZ9xbbBzgYuL4/rar?=
 =?us-ascii?Q?l3x40eCSuKBdRH/wqL0qTKC32nx0j+5kAn25t8fWUrCf4r7qMN4Te9Cz58Zq?=
 =?us-ascii?Q?98eE787o/2GMiGDguUUicj8Zei2PFD6z61iVLxxiKnZ4Bazitagv37g5+KY8?=
 =?us-ascii?Q?7QgCKEugHhg+rEBub9chWW8KzrEyrG/wbRcceKafORG4xbYa8G9LBtydGgsi?=
 =?us-ascii?Q?hoBucvR0FnorjsQ5acmxiXsB0H4HahzlyOpGr89+jL7woyCIV5Gc4d/nxq7w?=
 =?us-ascii?Q?fLouQKUWIZtFYeBXuE72J5Ok8aYj/LqpvGNIWaWLM9049/tPj29vq0dwQIfX?=
 =?us-ascii?Q?00EH+OgBY+u/Six98nj0WVcftQxyPXXfhPXa7YHAh52R6RTYJaN0picxXj7W?=
 =?us-ascii?Q?vRBowNkY6KcRFCjv9NIoECIdnqaZiY5LT6+UMBLbiNrgnZw+SiRDjxeaVnUL?=
 =?us-ascii?Q?qMFpIoBCd4VmkqFYxbqdmwmF6d6lDPir4NFvCBUOiJGuqGObyxFCrW9t/Za9?=
 =?us-ascii?Q?rMfYHXHUbLs/XnSFtiznr03QLw+JZtxGulpUB2IHFgAlm6MLzTQfRx7VMkDW?=
 =?us-ascii?Q?hGFtO1rcw2WCrV+nfOh1sz9vfrOCcpOkQTjiNkRLT2hILaufBFAM4BFdnJ1T?=
 =?us-ascii?Q?PR9aER1g6MWzSUHKli51DeZZqu8ESzMpG+hAS9a2HPFLsFxLziC8Sjd3/rzH?=
 =?us-ascii?Q?yDtfi0mxDWHtZ2MZ1DCHDXxLoq7PV9IvIxl7fKtzQTivRUXMT6SUMjwx+opE?=
 =?us-ascii?Q?30We8dy7qvI+G7WOhi9HCjxUVvVjbaDOQkA1pggDG4jdOmzdnTUPXBV6ym0s?=
 =?us-ascii?Q?N9pr0yxZkj3oZtjFjhDVRU/F707ztN6JlrbOHjNJ4GOWy/PaiJ8fQCZxwxVx?=
 =?us-ascii?Q?iAq1+vL2wuWxbdEcrEj6FCF/Dg/q6Cey34RPnIR806FQ9GauqCOISWeRboZj?=
 =?us-ascii?Q?TbIdeAmY7giBNGiuXKqHA3mF2trBcjfm/zDGSV8mBsmp0+7rxeJPDBqHlBrF?=
 =?us-ascii?Q?jhv3xV6Guig9asbQp2JxO4zoLw3PVHuVYg4X6QcXQwhZ8yzrzn+cef0JmhcG?=
 =?us-ascii?Q?jeIeMs11ThM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(13003099007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XJzEkm4SnfjROUaekIROaURLPmlwYz3Qda/qWoYq62NxrFLh2vuneZ2JU0QQ?=
 =?us-ascii?Q?UBUPll1UUdR9/8IUU3f8LqT9FKjNlszqVotLt+7FFQbA0l0bRzND6XbqOKG9?=
 =?us-ascii?Q?AeKcfznOOUQ1HZf6uxs9zwiE5A5Pkx0Tq3dCJ/xBFkR6Gvm/QPfm8mKu5Oa8?=
 =?us-ascii?Q?U+09SzezxBJ3/OVjmGVGVzavG7u4/HIRGgcpAyNyjCm7b55pRTXywbGc7cwu?=
 =?us-ascii?Q?aly8vuK/xsHh9F0waBT/bOqwkWhZ7WuQt5qktB8Uq1MCflaqcxCliiH9AIrK?=
 =?us-ascii?Q?kB3ertDP3Tqc+EXuEX4GGX4RcwZv3zqNiFJuKfYWez21zXXZivmOfZfj1AiB?=
 =?us-ascii?Q?cEioeBkoJCw/m0u4Cp6K7MNBMnIl/EfC4ZxWDsViBiUuHLTp2Z72Ct1SMzeE?=
 =?us-ascii?Q?aKUWx13iURboqDfrccGgtJ7rTGo10q4tJbO5qm6YGDcjG0oPOQ80HNjBVc0m?=
 =?us-ascii?Q?evqPMYTsAi7Ad65DVnFXnle5Yk5dogsUXVgnxhGo4sixFpheCj5qLNZPgt2n?=
 =?us-ascii?Q?5MPzyc/BCKMNUriDw8pVtjaPp4+n3YY+e5tIElswO3Qk/bsZ/D1mdWVkRfyX?=
 =?us-ascii?Q?HKmocm4COf8ptsIWlrE94F366BAXGtblGXCsQTxouwK+1AyWY8NKTPYnGx5M?=
 =?us-ascii?Q?vZZ4hfLOv1n/GRVzVbdtNR134G3GR8WWdyaBxw7C+i27eE6FoBuSPh6DOm0T?=
 =?us-ascii?Q?mb5r6n9O7QwZnBtWhAgNZ5rcNABfg65FGcAUoutqs77x+b0mU7yGQPGc27Bf?=
 =?us-ascii?Q?MzwPaQGRd791pyLvIHeMlkGLLWDRP6Ho2mTxfW+IptStm4denI2lzANKAu5q?=
 =?us-ascii?Q?lQn1C/2m/MG2mVwIs1obmA2oHcUtOSMdBM8FS0zRb/ttYhW/W0vBTUe31qy6?=
 =?us-ascii?Q?Nju8wAwp/8qUbvI+xv4f9Ix3PX/AfrYwS7z7II+6pzx8ELrHmALJ9pZ+zjCy?=
 =?us-ascii?Q?Yw/KZqCwqhfvml4Ak+M/cbq5ZcW4GJevei5seiajUf3+GsvOFvosFeKTpHLH?=
 =?us-ascii?Q?SPE73R6NryfnqmBIsyMX2N3BBb+qkvDmahLnI+QjKbLrW+u/wmrlRVGyDqVy?=
 =?us-ascii?Q?6iCdNC4mEX43hvlMlzh4Un1W2y5qkiwkShI6jlZxgUoSsfGGd9h2NE0RjEuM?=
 =?us-ascii?Q?GBnlIMnmxFdy4srbYV0dhG0rTTa//T8qrF4mYUOXtsLfgRbTyTqeXphJmjzU?=
 =?us-ascii?Q?I5nrG0oXJoYiD1/SVN6E2vC/ghasy/KgPOv/aNEj+3x5YbCBmQC01W+dZgIo?=
 =?us-ascii?Q?NHZFpmhJ7rObSS2LojeaS09bWReTeCrPss73oXgW8gChTwZh1knObWQV3ibo?=
 =?us-ascii?Q?nk0gURix44HKUWENN/qALiTvBLJt2Wn6mMqha9EgefEHdPXci0ufpbIBZVkf?=
 =?us-ascii?Q?PyTXtNL3IIbm/yvg+u5PpYs+ty762KPjlug93yqs+ZvpwqgpQ57FuPOSo+bY?=
 =?us-ascii?Q?YiuoDbxvPQ+8hZC7CFvvQZ7psYOeTjYA//p5RgySw0jcynx1FvCS+cZo93Zo?=
 =?us-ascii?Q?ovXUFAG9fn22CouAG1lYgsTZKGzcewSjiBUJ0MQtHb29g5hGM5k1TZpcP/Y2?=
 =?us-ascii?Q?3KEODvHC8hQgKurKtbAb7JtF+r2+wAmqGfN94Y1/?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4420bc9-adf0-4c4e-3ec6-08ddf90fd47c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2025 13:07:34.4018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUvwdjYKzYxjKSBohv8h8iJHt8pArdAQDlEgm2M6g5DlNFPGsIdWR0P/IjLx44XkhajmY9Rg37fGhUBdzvJWwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8265
X-Proofpoint-GUID: jtjxGERZxCFadZZgu82C7zZ4Ka-sr3CA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIxMDEzNCBTYWx0ZWRfX4yvdT0O7i+ir
 xUrybDq/1kDgP7ENwAwzS5cYen89vj4FuxY6Y2b5GuEt9PwOpryE6j8MCO3Td6pQ/EsATGh+qzA
 n1TY9HpuJAkUr0DjnrcHjE3ySd69LdrumUALOQnB9609P+LT/KTM0+NBlNDK5Y/CMNhiNs/GQav
 9iC8JaFNIdKLd8LTQcH7RHHAqqj/feO9DkBnwJxgwZD/PG47xh7zWeRWLE30QdWGrZgnUyGZ9qY
 ekUXEh5t+o/ia/9oFZnic3xDR3T2w2cCqbqXpZSlhWQE11vCCRKN4WUhvThncpU+us3SugriYyG
 rziLTzjIvGf+bkCZAhI1klblva6dsZavqcJdATng5o6cuMDY9Hp+TN8+HRDVRg=
X-Authority-Analysis: v=2.4 cv=Yfi95xRf c=1 sm=1 tr=0 ts=68cff899 cx=c_pps
 a=A0MaZ9OvLBUdx9ibaoeqQQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8
 a=A1X0JdhQAAAA:8 a=ktNasmvQAAAA:8 a=1XWaLZrsAAAA:8 a=xqzR1eaSAAAA:8
 a=DT1NhrL8wyKqG5jDLEEA:9 a=2WnUeqSxssMA:10 a=FdTzh2GWekK77mhwV6Dw:22
 a=e0GJpZYNDejI1RnTdwpm:22 a=dV6nhpJrT-yxOfsl7Uss:22
X-Proofpoint-ORIG-GUID: jtjxGERZxCFadZZgu82C7zZ4Ka-sr3CA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_04,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 21 Sep 2025 13:07:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2223

Update to latest git rev as the current version doesn't work with
OpenSSH 9.8+[1].

Ptest result:
$ ptest-runner python3-fail2ban
START: ptest-runner
2025-09-21T12:45
BEGIN: /usr/lib64/python3-fail2ban/ptest

Ran 538 tests in 13.045s
OK (skipped=3)
DURATION: 14
END: /usr/lib64/python3-fail2ban/ptest
2025-09-21T12:46
STOP: ptest-runner
TOTAL: 1 FAIL: 0

[1] https://github.com/fail2ban/fail2ban/commit/2fed408c05ac5206b490368d94599869bd6a056d

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...ges-the-IPs-again.-additionally-it-g.patch | 210 ------------------
 ...case.py-set-correct-config-dir-for-t.patch |  35 ---
 .../fail2ban/python3-fail2ban_git.bb          |   4 +-
 3 files changed, 1 insertion(+), 248 deletions(-)
 delete mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch
 delete mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch

diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch
deleted file mode 100644
index 73014ab..0000000
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch
+++ /dev/null
@@ -1,210 +0,0 @@
-From 5b6c13f0aae79a23d94570bacd1b5796e57f088d Mon Sep 17 00:00:00 2001
-From: sebres <info@sebres.de>
-Date: Thu, 30 Jan 2025 01:05:30 +0100
-Subject: [PATCH] example.com changes the IPs, again... additionally it got
- more IPs, which look unstable now (depends on resolver), so replaced with
- fail2ban.org, that seems to resolve to single IPv4 and IPv6 (can be adjusted
- later for something more persistent)
-
-
-Upstream-Status: Backport
-[https://github.com/fail2ban/fail2ban/commit/5b6c13f0aae79a23d94570bacd1b5796e57f088d]
-
-Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
----
- .../tests/files/logs/apache-fakegooglebot     |  6 +-
- fail2ban/tests/files/testcase-usedns.log      |  4 +-
- fail2ban/tests/filtertestcase.py              | 58 +++++++++----------
- fail2ban/tests/utils.py                       |  4 +-
- 4 files changed, 36 insertions(+), 36 deletions(-)
-
-diff --git a/fail2ban/tests/files/logs/apache-fakegooglebot b/fail2ban/tests/files/logs/apache-fakegooglebot
-index b77a1a6b..024842fd 100644
---- a/fail2ban/tests/files/logs/apache-fakegooglebot
-+++ b/fail2ban/tests/files/logs/apache-fakegooglebot
-@@ -1,5 +1,5 @@
- # Apache 2.2
- # failJSON: { "time": "2015-01-31T14:29:44", "match": true, "host": "66.249.66.1" }
--66.249.66.1 - - - [31/Jan/2015:14:29:44 ] example.com "GET / HTTP/1.1" 200 814 "-" "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)" + 293 1149 546
--# failJSON: { "time": "2015-01-31T14:29:44", "match": false, "host": "93.184.215.14" }
--93.184.215.14 - - - [31/Jan/2015:14:29:44 ] example.com "GET / HTTP/1.1" 200 814 "-" "NOT A __GOOGLE_BOT__" + 293 1149 546
-+66.249.66.1 - - - [31/Jan/2015:14:29:44 ] fail2ban.org "GET / HTTP/1.1" 200 814 "-" "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)" + 293 1149 546
-+# failJSON: { "time": "2015-01-31T14:29:44", "match": false, "host": "51.159.55.100" }
-+51.159.55.100 - - - [31/Jan/2015:14:29:44 ] fail2ban.org "GET / HTTP/1.1" 200 814 "-" "NOT A __GOOGLE_BOT__" + 293 1149 546
-diff --git a/fail2ban/tests/files/testcase-usedns.log b/fail2ban/tests/files/testcase-usedns.log
-index eea6eb44..3e7b36bb 100644
---- a/fail2ban/tests/files/testcase-usedns.log
-+++ b/fail2ban/tests/files/testcase-usedns.log
-@@ -1,2 +1,2 @@
--Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from example.com port 51332 ssh2
--Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:93.184.215.14 port 51332 ssh2
-+Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from fail2ban.org port 51332 ssh2
-+Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:51.159.55.100 port 51332 ssh2
-diff --git a/fail2ban/tests/filtertestcase.py b/fail2ban/tests/filtertestcase.py
-index 20945b78..26961a1b 100644
---- a/fail2ban/tests/filtertestcase.py
-+++ b/fail2ban/tests/filtertestcase.py
-@@ -587,14 +587,14 @@ class IgnoreIP(LogCaptureTestCase):
- 				self.assertNotLogged("returned successfully")
- 
- 	def testIgnoreCauseOK(self):
--		ip = "93.184.215.14"
-+		ip = "51.159.55.100"
- 		for ignore_source in ["dns", "ip", "command"]:
- 			self.filter.logIgnoreIp(ip, True, ignore_source=ignore_source)
- 			self.assertLogged("[%s] Ignore %s by %s" % (self.jail.name, ip, ignore_source))
- 
- 	def testIgnoreCauseNOK(self):
--		self.filter.logIgnoreIp("example.com", False, ignore_source="NOT_LOGGED")
--		self.assertNotLogged("[%s] Ignore %s by %s" % (self.jail.name, "example.com", "NOT_LOGGED"))
-+		self.filter.logIgnoreIp("fail2ban.org", False, ignore_source="NOT_LOGGED")
-+		self.assertNotLogged("[%s] Ignore %s by %s" % (self.jail.name, "fail2ban.org", "NOT_LOGGED"))
- 
- 
- class IgnoreIPDNS(LogCaptureTestCase):
-@@ -607,7 +607,7 @@ class IgnoreIPDNS(LogCaptureTestCase):
- 		self.filter = FileFilter(self.jail)
- 
- 	def testIgnoreIPDNS(self):
--		for dns in ("www.epfl.ch", "example.com"):
-+		for dns in ("www.epfl.ch", "fail2ban.org"):
- 			self.filter.addIgnoreIP(dns)
- 			ips = DNSUtils.dnsToIp(dns)
- 			self.assertTrue(len(ips) > 0)
-@@ -1892,22 +1892,22 @@ class GetFailures(LogCaptureTestCase):
- 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
- 		# We should still catch failures with usedns = no ;-)
- 		output_yes = (
--			('93.184.215.14', 1, 1124013299.0,
--			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from example.com port 51332 ssh2']
-+			('51.159.55.100', 1, 1124013299.0,
-+			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from fail2ban.org port 51332 ssh2']
- 			),
--			('93.184.215.14', 1, 1124013539.0,
--			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:93.184.215.14 port 51332 ssh2']
-+			('51.159.55.100', 1, 1124013539.0,
-+			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:51.159.55.100 port 51332 ssh2']
- 			),
--			('2606:2800:21f:cb07:6820:80da:af6b:8b2c', 1, 1124013299.0,
--			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from example.com port 51332 ssh2']
-+			('2001:bc8:1200:6:208:a2ff:fe0c:61f8', 1, 1124013299.0,
-+			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from fail2ban.org port 51332 ssh2']
- 			),
- 		)
- 		if not unittest.F2B.no_network and not DNSUtils.IPv6IsAllowed():
- 			output_yes = output_yes[0:2]
- 
- 		output_no = (
--			('93.184.215.14', 1, 1124013539.0,
--			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:93.184.215.14 port 51332 ssh2']
-+			('51.159.55.100', 1, 1124013539.0,
-+			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:51.159.55.100 port 51332 ssh2']
- 			)
- 		)
- 
-@@ -2098,10 +2098,10 @@ class DNSUtilsNetworkTests(unittest.TestCase):
- 		super(DNSUtilsNetworkTests, self).setUp()
- 		#unittest.F2B.SkipIfNoNetwork()
- 
--	## example.com IPs considering IPv6 support (without network it is simulated via cache in utils).
-+	## fail2ban.org IPs considering IPv6 support (without network it is simulated via cache in utils).
- 	EXAMPLE_ADDRS = (
--		['93.184.215.14', '2606:2800:21f:cb07:6820:80da:af6b:8b2c'] if unittest.F2B.no_network or DNSUtils.IPv6IsAllowed() else \
--		['93.184.215.14']
-+		['51.159.55.100', '2001:bc8:1200:6:208:a2ff:fe0c:61f8'] if unittest.F2B.no_network or DNSUtils.IPv6IsAllowed() else \
-+		['51.159.55.100']
- 	)
- 
- 	def test_IPAddr(self):
-@@ -2163,13 +2163,13 @@ class DNSUtilsNetworkTests(unittest.TestCase):
- 		self.assertTrue(r < ip6)
- 
- 	def testUseDns(self):
--		res = DNSUtils.textToIp('www.example.com', 'no')
-+		res = DNSUtils.textToIp('www.fail2ban.org', 'no')
- 		self.assertSortedEqual(res, [])
- 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
--		res = DNSUtils.textToIp('www.example.com', 'warn')
-+		res = DNSUtils.textToIp('www.fail2ban.org', 'warn')
- 		# sort ipaddr, IPv4 is always smaller as IPv6
- 		self.assertSortedEqual(res, self.EXAMPLE_ADDRS)
--		res = DNSUtils.textToIp('www.example.com', 'yes')
-+		res = DNSUtils.textToIp('www.fail2ban.org', 'yes')
- 		# sort ipaddr, IPv4 is always smaller as IPv6
- 		self.assertSortedEqual(res, self.EXAMPLE_ADDRS)
- 
-@@ -2177,13 +2177,13 @@ class DNSUtilsNetworkTests(unittest.TestCase):
- 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
- 		# Test hostnames
- 		hostnames = [
--			'www.example.com',
-+			'www.fail2ban.org',
- 			'doh1.2.3.4.buga.xxxxx.yyy.invalid',
- 			'1.2.3.4.buga.xxxxx.yyy.invalid',
- 			]
- 		for s in hostnames:
- 			res = DNSUtils.textToIp(s, 'yes')
--			if s == 'www.example.com':
-+			if s == 'www.fail2ban.org':
- 				# sort ipaddr, IPv4 is always smaller as IPv6
- 				self.assertSortedEqual(res, self.EXAMPLE_ADDRS)
- 			else:
-@@ -2234,8 +2234,8 @@ class DNSUtilsNetworkTests(unittest.TestCase):
- 
- 		self.assertEqual(IPAddr('192.0.2.0').getPTR(), '0.2.0.192.in-addr.arpa.')
- 		self.assertEqual(IPAddr('192.0.2.1').getPTR(), '1.2.0.192.in-addr.arpa.')
--		self.assertEqual(IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c').getPTR(), 
--			'c.2.b.8.b.6.f.a.a.d.0.8.0.2.8.6.7.0.b.c.f.1.2.0.0.0.8.2.6.0.6.2.ip6.arpa.')
-+		self.assertEqual(IPAddr('2001:db8::1').getPTR(), 
-+			'1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.8.b.d.0.1.0.0.2.ip6.arpa.')
- 
- 	def testIPAddr_Equal6(self):
- 		self.assertEqual(
-@@ -2365,10 +2365,10 @@ class DNSUtilsNetworkTests(unittest.TestCase):
- 
- 	def testIPAddr_CompareDNS(self):
- 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
--		ips = IPAddr('example.com')
--		self.assertTrue(IPAddr("93.184.215.14").isInNet(ips))
--		self.assertEqual(IPAddr("2606:2800:21f:cb07:6820:80da:af6b:8b2c").isInNet(ips),
--		                        "2606:2800:21f:cb07:6820:80da:af6b:8b2c" in self.EXAMPLE_ADDRS)
-+		ips = IPAddr('fail2ban.org')
-+		self.assertTrue(IPAddr("51.159.55.100").isInNet(ips))
-+		self.assertEqual(IPAddr("2001:bc8:1200:6:208:a2ff:fe0c:61f8").isInNet(ips),
-+		                        "2001:bc8:1200:6:208:a2ff:fe0c:61f8" in self.EXAMPLE_ADDRS)
- 
- 	def testIPAddr_wrongDNS_IP(self):
- 		unittest.F2B.SkipIfNoNetwork()
-@@ -2376,11 +2376,11 @@ class DNSUtilsNetworkTests(unittest.TestCase):
- 		DNSUtils.ipToName('*')
- 
- 	def testIPAddr_Cached(self):
--		ips = [DNSUtils.dnsToIp('example.com'), DNSUtils.dnsToIp('example.com')]
-+		ips = [DNSUtils.dnsToIp('fail2ban.org'), DNSUtils.dnsToIp('fail2ban.org')]
- 		for ip1, ip2 in zip(ips, ips):
- 			self.assertEqual(id(ip1), id(ip2))
--		ip1 = IPAddr('93.184.215.14'); ip2 = IPAddr('93.184.215.14'); self.assertEqual(id(ip1), id(ip2))
--		ip1 = IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'); ip2 = IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'); self.assertEqual(id(ip1), id(ip2))
-+		ip1 = IPAddr('51.159.55.100'); ip2 = IPAddr('51.159.55.100'); self.assertEqual(id(ip1), id(ip2))
-+		ip1 = IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'); ip2 = IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'); self.assertEqual(id(ip1), id(ip2))
- 
- 	def test_NetworkInterfacesAddrs(self):
- 		for withMask in (False, True):
-diff --git a/fail2ban/tests/utils.py b/fail2ban/tests/utils.py
-index f71ba60a..e6ef54f3 100644
---- a/fail2ban/tests/utils.py
-+++ b/fail2ban/tests/utils.py
-@@ -326,8 +326,8 @@ def initTests(opts):
- 			('failed.dns.ch', set()),
- 			('doh1.2.3.4.buga.xxxxx.yyy.invalid', set()),
- 			('1.2.3.4.buga.xxxxx.yyy.invalid', set()),
--			('example.com', set([IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'), IPAddr('93.184.215.14')])),
--			('www.example.com', set([IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'), IPAddr('93.184.215.14')])),
-+			('fail2ban.org', set([IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'), IPAddr('51.159.55.100')])),
-+			('www.fail2ban.org', set([IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'), IPAddr('51.159.55.100')])),
- 		):
- 			c.set(*i)
- 		# if fast - precache all host names as localhost addresses (speed-up getSelfIPs/ignoreself):
--- 
-2.34.1
-
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch
deleted file mode 100644
index a60b0fd..0000000
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch
+++ /dev/null
@@ -1,35 +0,0 @@
-From 9f26da3cf854e48b7939c2a9baa0cb3ffbee5994 Mon Sep 17 00:00:00 2001
-From: Yi Zhao <yi.zhao@windriver.com>
-Date: Thu, 11 Sep 2025 22:36:07 +0800
-Subject: [PATCH] clientreadertestcase.py: set correct config dir for
- testReadStockJailFilterComplete
-
-In test case testReadStockJailFilterComplete, set configuration
-directory to CONFIG_DIR (/etc/fail2ban/filter.d on the target) instead
-of the hardcoded "config" directory. Otherwise, the config files will
-not be found during runtime testing.
-
-Upstream-Status: Backport
-[https://github.com/fail2ban/fail2ban/commit/9f26da3cf854e48b7939c2a9baa0cb3ffbee5994]
-
-Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
----
- fail2ban/tests/clientreadertestcase.py | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/fail2ban/tests/clientreadertestcase.py b/fail2ban/tests/clientreadertestcase.py
-index e6a2806c..b8ebbbc7 100644
---- a/fail2ban/tests/clientreadertestcase.py
-+++ b/fail2ban/tests/clientreadertestcase.py
-@@ -878,7 +878,7 @@ class JailsReaderTest(LogCaptureTestCase):
- 		self.assertTrue(jails.getOptions())       # reads fine
- 		# grab all filter names
- 		filters = set(os.path.splitext(os.path.split(a)[1])[0]
--			for a in glob.glob(os.path.join('config', 'filter.d', '*.conf'))
-+			for a in glob.glob(os.path.join(CONFIG_DIR, 'filter.d', '*.conf'))
- 				if not (a.endswith('common.conf') or a.endswith('-aggressive.conf')))
- 		# get filters of all jails (filter names without options inside filter[...])
- 		filters_jail = set(
--- 
-2.34.1
-
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
index b0b65de..c85953a 100644
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
@@ -11,10 +11,8 @@ LIC_FILES_CHKSUM = "file://COPYING;md5=ecabc31e90311da843753ba772885d9f"
 
 DEPENDS = "python3-native"
 
-SRCREV = "ac62658c10f492911f8a0037a0bcf97c8521cd78"
+SRCREV = "2856092709470250dc299931bc748f112590059f"
 SRC_URI = "git://github.com/fail2ban/fail2ban.git;branch=master;protocol=https \
-           file://0001-example.com-changes-the-IPs-again.-additionally-it-g.patch \
-           file://0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch \
            file://initd \
            file://run-ptest \
            "
-- 
2.34.1


