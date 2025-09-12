Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D043CAC582
	for <webhook@archiver.kernel.org>; Fri, 12 Sep 2025 14:46:16 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.18659.1757688373031881131
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 12 Sep 2025 07:46:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=JC8df0Pw;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=1350451926=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58C9lLtF1986229;
	Fri, 12 Sep 2025 07:46:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=KsOF3fWK/
	liGBm9MxaewkMBjeR9qjqVY2f/AdbP+xTI=; b=JC8df0Pw74yOObijWcU848mgU
	6v5vDeBwFHSId2pQH+nKfDilRgWA2WPyXP0LBSk0sHICAjbP9xg7OE7hxBsFbu/d
	ZHBrBqWlDuvzDqQ5wyLCSIxzSPuwPmsF/dvj1tSAmMETrkKn2Hif+FKhthilLcud
	XrgdQA6HtX9/vCmTiLNrsdKoHZ8Lo4Cu93TeF0SO8wlqgxv+1s9QZOVMkn/bNKwL
	xx5+mB/7QsejagWjhaLRkapHGfLG7K1Qr1NVkrwyxoBCi5MnKZL4FfnUSw+zedVS
	0uGeeuZwpkuio8A0ba7TDVFR1czEo5otJTEddUU5d1yM8k3uAIRvFXcyDaUbg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 490g80fnwm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 07:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dj5w0DP5q5a7deeSTyKcjGZi3UW26hWSQPy/p/5b8qGop2/LEyR2PkejCvlnHcg/cVqJR8I9yhr1E4K+er0kRPTFjgj2U6P2dWxghJn8s1md6d61N/PB5hm1FG+03ouXWKql15l9CLxnRG2d25domG3KiBgqQLN/OlzCBrb/5Yq+Nhoh7M/couKSL5nDWkZjZcOrAs/7JpUZHk17wivS0qYdt9FGIXjp0VOO5W688MvbsgthHpALPObcr5gQRyQn+lmn61OT8ZlzD+lDeybzx311JH15M4q9amM5km/32X29bq8gtWAl4t9mWzGIXcdcqhLodB3SxEo6O4Oqi3sEHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsOF3fWK/liGBm9MxaewkMBjeR9qjqVY2f/AdbP+xTI=;
 b=gzAnT3j6/f1tHm0T1XADlchfH/0XzEhYtrkRY0OpWf6ivVzduxh9AiFwYoRxuffAs2+Q3XoxND/ji/Xs02Fbn0lG0ZUW30ZHTm40U3+u97fz5FoVq1rIxRDqaWfvLHF/hInEXVSpFyoXvipeceF2G8G+VQ/JQiBL1WbRVmbN//QnWyEfIX672tJua0jMqxa97uuLJu8rROJwP+OOma4+0GsPpKTVffv04jhyvzPjTILJYkNDpNVMxO6TkI3l9okUfWvAUSlr0hn1wXmaXxvPW7SZuE+koubVPI03A0BIj6LYQlxNWzkfsWXgTmQj8YSdpbXvToIXHnNSJK78cGo+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 IA0PR11MB7743.namprd11.prod.outlook.com (2603:10b6:208:401::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 14:46:06 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 14:46:06 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com, rybczynska@gmail.com
Subject: [meta-security][PATCH] python3-fail2ban: fix ptest failures
Date: Fri, 12 Sep 2025 22:45:49 +0800
Message-Id: <20250912144549.3285438-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0052.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::17) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|IA0PR11MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f33182-bf3d-4230-23c7-08ddf20b1a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?AGwW9eg4vtR3nBqQ3pUnpjj40i8BbUVejzc8mrTQoRCqfGHOkbO0liveXC0i?=
 =?us-ascii?Q?xNbm33PBqn0LPnhqcFUN26ijqw8hyVu4lq9Sd7nKCFwvM7X4wsN2rydCnwu+?=
 =?us-ascii?Q?Xuqt/3ffpgu6yaHlexBSFe2jx4x6ufMd8ugPCS0MDIEqPZ5mW0lJ/8N2SrAI?=
 =?us-ascii?Q?TAlNxnOrqUqfKOY2XnRajKQrBF+NItIqMuQEWACgqfAJbXhZD0mpNczx2j7V?=
 =?us-ascii?Q?3YBR9NRLCLrXEvDOeFJIC/KXrC0VLzPbM4cbfBHv1tl/1UpE/zXzKw/xieji?=
 =?us-ascii?Q?LHj60UVuO+naJ4s8iFSYxdvj2Tzqk74Q6u//UMmmjZG8PseyzTDWsaRC+0b/?=
 =?us-ascii?Q?c4u2BYUE5ZngY4uEkSxHAh9jpFGrJNXnKm6TDpvg2zhlgBBCDZ/BaW+XP+HL?=
 =?us-ascii?Q?eJb748igMimHyi+mWG/n8C+RbDSojzx4ZRd1MB4zvH7TNUnDAASNZa6o08mV?=
 =?us-ascii?Q?HAGFCGADGoK8GTSwOT1ej+AErt8PHd7C5gO0NPIYI/KB5Tjr7Hm/UyU8V0GH?=
 =?us-ascii?Q?YnXtKJQ+FSeojyTm+JTwNtP/1Re9AIro8X3d/4AILI7EDmNOcHJpLVW2aFLo?=
 =?us-ascii?Q?SzcPLXzfnZwfDxQXtAa/UsfL1H8HkoVOFrn7m9W4flhjMJq8Rc9CSgNNuVSh?=
 =?us-ascii?Q?OzeoxL7KXBBAelBRAY0Q92iIG9oO30N7H96d1sKdtz2w579eAc/C+JVt5Auz?=
 =?us-ascii?Q?ES/SUfVZnm2nnP5z8WjgNGKps2mdOxL96D36MXDrPLrA/lQkcBECFpun2GA4?=
 =?us-ascii?Q?Gxfbc3P4s6WNlgKZ0lBDWyBTaW6KLBgRhn1f8jUYAg0SCpE7f/4VDX98X+F2?=
 =?us-ascii?Q?e2nnVT5z5lHWnWlPgcN4udpeLLsv+f9PHtiC+t3myHSFDMCQbarLxF1pOUpw?=
 =?us-ascii?Q?yRGj9Bk4uPSXjAQ/LC+E+zRtSt4TunNu0zdHM5Yly8EFgZN5fcRUtC/hVPwH?=
 =?us-ascii?Q?fGe/m6yo4PneRkimwtSxi2D2UB3e16rYiMTWqRKSs+NPG9IMNjnMRzoKnMwb?=
 =?us-ascii?Q?1CjtqbAjMlwyZiCnY8KSuZHD/2CZv94vXy5p2vSCkQwFM1nuj8BHkagiBvkC?=
 =?us-ascii?Q?oH408mxII/uvW3KvZUvsAwRNUzzZL/0/xS90j2coNtp4XbEeB7Fh/gCOCsR9?=
 =?us-ascii?Q?wdrVHCn5L96EiO3tmWR7qB7Sq2Ln3EtcHNQD2fR2HSLLj0ZA8/qMdZnJ5Fn7?=
 =?us-ascii?Q?YgTQQBa8Hbc6+MJ4KQWhBjw0zABX6osPSNCb+4IALwBoxK1kYEZl+doXWDI5?=
 =?us-ascii?Q?Vcks2nYZxfV5x4QecNwO/AUme0xeBuhDSeknrI4sEDkvIGzpMFqBScShB6fX?=
 =?us-ascii?Q?7ZjK6qB3mRaRdh3Vkn+aw7Yj6CCRjZ5kZf+MIih01lDlgv9PorY+QG9NucB9?=
 =?us-ascii?Q?JFFJ5TIwltnRKngD4ek5flvdpBV7T41dRtUDmyYPUojQ93o4mJ8rhI/3sw2B?=
 =?us-ascii?Q?ITO6myJ9Rio=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(13003099007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Qrib1odxR2fsD1NxF4N607tdxevAb+3yAfC8hqyOdEk6XDjJcB6JY4UCFz3w?=
 =?us-ascii?Q?mEsm61EMltLmOFn5z85x98zsC97mnlZ12G8j9Q1d86P4eTHHtBIqXjhfy8E/?=
 =?us-ascii?Q?TxqFoeBcbXze7M/dUOYxu9bo0c9I4NpTnn4zJHP0fGovgHdN5mx9aep9KNay?=
 =?us-ascii?Q?smnkhPcdznkHycBgnVmOuytSRT7oJofTpu9z7KWuwYteonoUtzMT5824OQ19?=
 =?us-ascii?Q?hesA8df9ve/Wq4xX/3vCWk4BkRC6UDkK7f0SU91F375WOynSFUhwvVJ+G/Gw?=
 =?us-ascii?Q?DktLsEolxsj1/9yURw6ppyShBDLkiRZLKRP9sKnYcq2YcyXjmjbSF5wr3uf4?=
 =?us-ascii?Q?hprgfA/ZI3sKK4+u3/1bWiFA44g4nU38THDC9ClzitjGDiMtlxHYKr7LRo7q?=
 =?us-ascii?Q?XhRuq/S4UHyy7JJsnpgrPa3X/8+gjRX862vQOWvM1h6fSwyqQkS7FoMD9t87?=
 =?us-ascii?Q?2KHGV9YbJNsU/s+cP8Gop9Jb8PtBX0ndK9cF0Xmb2Q2psXcE8z3hXvCv4UI6?=
 =?us-ascii?Q?czskIuQomWMA5KFKByeIb117+Iyf7nzvROJ1zRQIl9RklZbY9zkIJmJs1z7T?=
 =?us-ascii?Q?ThBJgnjPf0OMHeZXATMiuEjs4sqPNiVwvYYNk4rSJCU8i+MvWPo8WuxN70to?=
 =?us-ascii?Q?7ckpeHjUD/O8eyoaHj1rxYFkE0ZcRs8eu93rUslYafqEndenpiInnHM3D77S?=
 =?us-ascii?Q?9GFxb5yeKmDxke1wVNLe2LAN6wGV/aXRq9eriUTFhK4WBzZL54YG1xIxp83p?=
 =?us-ascii?Q?YQRa/XEJN5pCckMYoRqw8R4BmdGcAFuVrJ3iEjbR4n8fgeg3qK5lyizBv/gd?=
 =?us-ascii?Q?wUGU0DK/hav523+vnN6oXcIX6raxDOssBNyJZQX94e2up2tGhL9hI9A1yXkb?=
 =?us-ascii?Q?cZZsA2SekFTfjtQMdqX7xwAmrWAPDX2etqqw1N/iaqly7dvdTVrm3n7ubDhQ?=
 =?us-ascii?Q?LwRptMEotZc7ctR1tayCUeMHBsjGNTc8F/pS8MEamuUobT7j8Kmn9JP7Y6tl?=
 =?us-ascii?Q?PLU+RX6EDSwt4AHkaDVvf1WD4v8IAwiZTsfaGxuNnuGQUqkqFEqoTNhkI3cX?=
 =?us-ascii?Q?rAxn3+oR7Ae6T6ATPD8WuMqAvubdzNCZ+seEnpTmWHDdcvhAobh2PVBYSQrr?=
 =?us-ascii?Q?UKonQO3gX1S3gk3zyT8TO7djh9g1sgJaiD++TXwX5PqHQgYY54KYuAFqI9Ek?=
 =?us-ascii?Q?KgZHZlQaWlHLwbEtlYhQKh1kaLw3Foz1coognmrQX3l97lE9X61FR/TUklwA?=
 =?us-ascii?Q?56b8wrGOBxbGRl93ZKrTVaiXIr7VUdxanp3fj2LrDTsJwfsSmB7jk3olas++?=
 =?us-ascii?Q?PHp9cmhTguUXNj2Yy6Oa8gTUWsnq67cMJcFk83rNC13n0QzrJ8U7CTsBtRny?=
 =?us-ascii?Q?iSmDwMeh+qEACbbeLFMGVEXJ7y5DVQgK+NE54jHSt3nmIPe+wDH8t1S7mdQ9?=
 =?us-ascii?Q?0MTnEqgfdGp0IbqWOHVLRsvDXiNkQ+n5qEYjhgWdHVSU6SLcG0Qghgtx9kPs?=
 =?us-ascii?Q?7AJxOjqkJVO++EuCY0rGP6znRePb5ADtRtu6vTpQOqXlBPbeBttjZzAIsdmj?=
 =?us-ascii?Q?PzGsycnqiebtTmUtHGliq7Eyd4m/P0Es2HaAqo3y?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f33182-bf3d-4230-23c7-08ddf20b1a82
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:46:06.3515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDqtFiPisKS9VBCLcY61ky8N9FVVGm8ezD6z4ou0J9EuKFBL/i/4HsERFgWkJjrY+sXagT1S54tjSVfJMNez1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7743
X-Proofpoint-ORIG-GUID: FNCOlRBRuYilvVk3Hj-cmcm4vx_e6hiZ
X-Authority-Analysis: v=2.4 cv=RaOQC0tv c=1 sm=1 tr=0 ts=68c43232 cx=c_pps
 a=kuLTmBVh2a3dvdeKPdY0HA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8
 a=A1X0JdhQAAAA:8 a=ktNasmvQAAAA:8 a=1XWaLZrsAAAA:8 a=xqzR1eaSAAAA:8
 a=_XDxjdB5o6fYZ9oTqksA:9 a=2WnUeqSxssMA:10 a=FdTzh2GWekK77mhwV6Dw:22
 a=e0GJpZYNDejI1RnTdwpm:22 a=dV6nhpJrT-yxOfsl7Uss:22
X-Proofpoint-GUID: FNCOlRBRuYilvVk3Hj-cmcm4vx_e6hiZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEyMDEzNyBTYWx0ZWRfXwjSbCRfT48ri
 0P6yI0NwGPebaaFtAFeUVIKddnK6Md54hqBrMA6hEXUA3lhO3PXXarHjw5gpQ94tmNMop/M8uEK
 uB1dDHIXE9FQC7j6ECpJZ6yMKRDefZjmOGn9QrO8HjZ2Fcx44JajE66A9LJg136LdQEtYyuTi7t
 BqS6njCfMaQ0nMgntnl13fMj+UarTxyF/3IU/anDRt9HzUfp+tjP/IkZVyWyV0JMfCcc6ZM5B+A
 uGzViKsUBkR/ZRTcTJWeUg1Pm9y71SRQ8Wt8ap3sMphQojvH37riVrrFLqswuC9s5IiT44Imgax
 36G45LwFUD6BNWA4TvYaoAVKBrlOLifCWNu3WZzemd8gO0VcFEadUk212A3g2s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_05,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 12 Sep 2025 14:46:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2184

Fix ptest failures by backporting patches and updating test case config
files.

Before the patch:
  $ ptest-runner python3-fail2ban
  START: ptest-runner
  2025-09-11T15:42
  BEGIN: /usr/lib64/python3-fail2ban/ptest
  <snip>
  Ran 524 tests in 23.023s

  FAILED (failures=5, errors=7, skipped=3)
  DURATION: 24
  END: /usr/lib64/python3-fail2ban/ptest
  2025-09-11T15:42
  STOP: ptest-runner
  TOTAL: 1 FAIL: 1

After the patch:
  $ ptest-runner python3-fail2ban
  START: ptest-runner
  2025-09-11T15:59
  BEGIN: /usr/lib64/python3-fail2ban/ptest
  <snip>
  Ran 524 tests in 25.982s

  OK (skipped=3)
  DURATION: 27
  END: /usr/lib64/python3-fail2ban/ptest
  2025-09-11T15:59
  STOP: ptest-runner
  TOTAL: 1 FAIL: 0

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...ges-the-IPs-again.-additionally-it-g.patch | 210 ++++++++++++++++++
 ...case.py-set-correct-config-dir-for-t.patch |  35 +++
 .../fail2ban/python3-fail2ban_git.bb          |  12 +-
 3 files changed, 256 insertions(+), 1 deletion(-)
 create mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch
 create mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch

diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch
new file mode 100644
index 0000000..73014ab
--- /dev/null
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch
@@ -0,0 +1,210 @@
+From 5b6c13f0aae79a23d94570bacd1b5796e57f088d Mon Sep 17 00:00:00 2001
+From: sebres <info@sebres.de>
+Date: Thu, 30 Jan 2025 01:05:30 +0100
+Subject: [PATCH] example.com changes the IPs, again... additionally it got
+ more IPs, which look unstable now (depends on resolver), so replaced with
+ fail2ban.org, that seems to resolve to single IPv4 and IPv6 (can be adjusted
+ later for something more persistent)
+
+
+Upstream-Status: Backport
+[https://github.com/fail2ban/fail2ban/commit/5b6c13f0aae79a23d94570bacd1b5796e57f088d]
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ .../tests/files/logs/apache-fakegooglebot     |  6 +-
+ fail2ban/tests/files/testcase-usedns.log      |  4 +-
+ fail2ban/tests/filtertestcase.py              | 58 +++++++++----------
+ fail2ban/tests/utils.py                       |  4 +-
+ 4 files changed, 36 insertions(+), 36 deletions(-)
+
+diff --git a/fail2ban/tests/files/logs/apache-fakegooglebot b/fail2ban/tests/files/logs/apache-fakegooglebot
+index b77a1a6b..024842fd 100644
+--- a/fail2ban/tests/files/logs/apache-fakegooglebot
++++ b/fail2ban/tests/files/logs/apache-fakegooglebot
+@@ -1,5 +1,5 @@
+ # Apache 2.2
+ # failJSON: { "time": "2015-01-31T14:29:44", "match": true, "host": "66.249.66.1" }
+-66.249.66.1 - - - [31/Jan/2015:14:29:44 ] example.com "GET / HTTP/1.1" 200 814 "-" "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)" + 293 1149 546
+-# failJSON: { "time": "2015-01-31T14:29:44", "match": false, "host": "93.184.215.14" }
+-93.184.215.14 - - - [31/Jan/2015:14:29:44 ] example.com "GET / HTTP/1.1" 200 814 "-" "NOT A __GOOGLE_BOT__" + 293 1149 546
++66.249.66.1 - - - [31/Jan/2015:14:29:44 ] fail2ban.org "GET / HTTP/1.1" 200 814 "-" "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)" + 293 1149 546
++# failJSON: { "time": "2015-01-31T14:29:44", "match": false, "host": "51.159.55.100" }
++51.159.55.100 - - - [31/Jan/2015:14:29:44 ] fail2ban.org "GET / HTTP/1.1" 200 814 "-" "NOT A __GOOGLE_BOT__" + 293 1149 546
+diff --git a/fail2ban/tests/files/testcase-usedns.log b/fail2ban/tests/files/testcase-usedns.log
+index eea6eb44..3e7b36bb 100644
+--- a/fail2ban/tests/files/testcase-usedns.log
++++ b/fail2ban/tests/files/testcase-usedns.log
+@@ -1,2 +1,2 @@
+-Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from example.com port 51332 ssh2
+-Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:93.184.215.14 port 51332 ssh2
++Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from fail2ban.org port 51332 ssh2
++Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:51.159.55.100 port 51332 ssh2
+diff --git a/fail2ban/tests/filtertestcase.py b/fail2ban/tests/filtertestcase.py
+index 20945b78..26961a1b 100644
+--- a/fail2ban/tests/filtertestcase.py
++++ b/fail2ban/tests/filtertestcase.py
+@@ -587,14 +587,14 @@ class IgnoreIP(LogCaptureTestCase):
+ 				self.assertNotLogged("returned successfully")
+ 
+ 	def testIgnoreCauseOK(self):
+-		ip = "93.184.215.14"
++		ip = "51.159.55.100"
+ 		for ignore_source in ["dns", "ip", "command"]:
+ 			self.filter.logIgnoreIp(ip, True, ignore_source=ignore_source)
+ 			self.assertLogged("[%s] Ignore %s by %s" % (self.jail.name, ip, ignore_source))
+ 
+ 	def testIgnoreCauseNOK(self):
+-		self.filter.logIgnoreIp("example.com", False, ignore_source="NOT_LOGGED")
+-		self.assertNotLogged("[%s] Ignore %s by %s" % (self.jail.name, "example.com", "NOT_LOGGED"))
++		self.filter.logIgnoreIp("fail2ban.org", False, ignore_source="NOT_LOGGED")
++		self.assertNotLogged("[%s] Ignore %s by %s" % (self.jail.name, "fail2ban.org", "NOT_LOGGED"))
+ 
+ 
+ class IgnoreIPDNS(LogCaptureTestCase):
+@@ -607,7 +607,7 @@ class IgnoreIPDNS(LogCaptureTestCase):
+ 		self.filter = FileFilter(self.jail)
+ 
+ 	def testIgnoreIPDNS(self):
+-		for dns in ("www.epfl.ch", "example.com"):
++		for dns in ("www.epfl.ch", "fail2ban.org"):
+ 			self.filter.addIgnoreIP(dns)
+ 			ips = DNSUtils.dnsToIp(dns)
+ 			self.assertTrue(len(ips) > 0)
+@@ -1892,22 +1892,22 @@ class GetFailures(LogCaptureTestCase):
+ 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
+ 		# We should still catch failures with usedns = no ;-)
+ 		output_yes = (
+-			('93.184.215.14', 1, 1124013299.0,
+-			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from example.com port 51332 ssh2']
++			('51.159.55.100', 1, 1124013299.0,
++			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from fail2ban.org port 51332 ssh2']
+ 			),
+-			('93.184.215.14', 1, 1124013539.0,
+-			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:93.184.215.14 port 51332 ssh2']
++			('51.159.55.100', 1, 1124013539.0,
++			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:51.159.55.100 port 51332 ssh2']
+ 			),
+-			('2606:2800:21f:cb07:6820:80da:af6b:8b2c', 1, 1124013299.0,
+-			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from example.com port 51332 ssh2']
++			('2001:bc8:1200:6:208:a2ff:fe0c:61f8', 1, 1124013299.0,
++			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from fail2ban.org port 51332 ssh2']
+ 			),
+ 		)
+ 		if not unittest.F2B.no_network and not DNSUtils.IPv6IsAllowed():
+ 			output_yes = output_yes[0:2]
+ 
+ 		output_no = (
+-			('93.184.215.14', 1, 1124013539.0,
+-			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:93.184.215.14 port 51332 ssh2']
++			('51.159.55.100', 1, 1124013539.0,
++			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:51.159.55.100 port 51332 ssh2']
+ 			)
+ 		)
+ 
+@@ -2098,10 +2098,10 @@ class DNSUtilsNetworkTests(unittest.TestCase):
+ 		super(DNSUtilsNetworkTests, self).setUp()
+ 		#unittest.F2B.SkipIfNoNetwork()
+ 
+-	## example.com IPs considering IPv6 support (without network it is simulated via cache in utils).
++	## fail2ban.org IPs considering IPv6 support (without network it is simulated via cache in utils).
+ 	EXAMPLE_ADDRS = (
+-		['93.184.215.14', '2606:2800:21f:cb07:6820:80da:af6b:8b2c'] if unittest.F2B.no_network or DNSUtils.IPv6IsAllowed() else \
+-		['93.184.215.14']
++		['51.159.55.100', '2001:bc8:1200:6:208:a2ff:fe0c:61f8'] if unittest.F2B.no_network or DNSUtils.IPv6IsAllowed() else \
++		['51.159.55.100']
+ 	)
+ 
+ 	def test_IPAddr(self):
+@@ -2163,13 +2163,13 @@ class DNSUtilsNetworkTests(unittest.TestCase):
+ 		self.assertTrue(r < ip6)
+ 
+ 	def testUseDns(self):
+-		res = DNSUtils.textToIp('www.example.com', 'no')
++		res = DNSUtils.textToIp('www.fail2ban.org', 'no')
+ 		self.assertSortedEqual(res, [])
+ 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
+-		res = DNSUtils.textToIp('www.example.com', 'warn')
++		res = DNSUtils.textToIp('www.fail2ban.org', 'warn')
+ 		# sort ipaddr, IPv4 is always smaller as IPv6
+ 		self.assertSortedEqual(res, self.EXAMPLE_ADDRS)
+-		res = DNSUtils.textToIp('www.example.com', 'yes')
++		res = DNSUtils.textToIp('www.fail2ban.org', 'yes')
+ 		# sort ipaddr, IPv4 is always smaller as IPv6
+ 		self.assertSortedEqual(res, self.EXAMPLE_ADDRS)
+ 
+@@ -2177,13 +2177,13 @@ class DNSUtilsNetworkTests(unittest.TestCase):
+ 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
+ 		# Test hostnames
+ 		hostnames = [
+-			'www.example.com',
++			'www.fail2ban.org',
+ 			'doh1.2.3.4.buga.xxxxx.yyy.invalid',
+ 			'1.2.3.4.buga.xxxxx.yyy.invalid',
+ 			]
+ 		for s in hostnames:
+ 			res = DNSUtils.textToIp(s, 'yes')
+-			if s == 'www.example.com':
++			if s == 'www.fail2ban.org':
+ 				# sort ipaddr, IPv4 is always smaller as IPv6
+ 				self.assertSortedEqual(res, self.EXAMPLE_ADDRS)
+ 			else:
+@@ -2234,8 +2234,8 @@ class DNSUtilsNetworkTests(unittest.TestCase):
+ 
+ 		self.assertEqual(IPAddr('192.0.2.0').getPTR(), '0.2.0.192.in-addr.arpa.')
+ 		self.assertEqual(IPAddr('192.0.2.1').getPTR(), '1.2.0.192.in-addr.arpa.')
+-		self.assertEqual(IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c').getPTR(), 
+-			'c.2.b.8.b.6.f.a.a.d.0.8.0.2.8.6.7.0.b.c.f.1.2.0.0.0.8.2.6.0.6.2.ip6.arpa.')
++		self.assertEqual(IPAddr('2001:db8::1').getPTR(), 
++			'1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.8.b.d.0.1.0.0.2.ip6.arpa.')
+ 
+ 	def testIPAddr_Equal6(self):
+ 		self.assertEqual(
+@@ -2365,10 +2365,10 @@ class DNSUtilsNetworkTests(unittest.TestCase):
+ 
+ 	def testIPAddr_CompareDNS(self):
+ 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
+-		ips = IPAddr('example.com')
+-		self.assertTrue(IPAddr("93.184.215.14").isInNet(ips))
+-		self.assertEqual(IPAddr("2606:2800:21f:cb07:6820:80da:af6b:8b2c").isInNet(ips),
+-		                        "2606:2800:21f:cb07:6820:80da:af6b:8b2c" in self.EXAMPLE_ADDRS)
++		ips = IPAddr('fail2ban.org')
++		self.assertTrue(IPAddr("51.159.55.100").isInNet(ips))
++		self.assertEqual(IPAddr("2001:bc8:1200:6:208:a2ff:fe0c:61f8").isInNet(ips),
++		                        "2001:bc8:1200:6:208:a2ff:fe0c:61f8" in self.EXAMPLE_ADDRS)
+ 
+ 	def testIPAddr_wrongDNS_IP(self):
+ 		unittest.F2B.SkipIfNoNetwork()
+@@ -2376,11 +2376,11 @@ class DNSUtilsNetworkTests(unittest.TestCase):
+ 		DNSUtils.ipToName('*')
+ 
+ 	def testIPAddr_Cached(self):
+-		ips = [DNSUtils.dnsToIp('example.com'), DNSUtils.dnsToIp('example.com')]
++		ips = [DNSUtils.dnsToIp('fail2ban.org'), DNSUtils.dnsToIp('fail2ban.org')]
+ 		for ip1, ip2 in zip(ips, ips):
+ 			self.assertEqual(id(ip1), id(ip2))
+-		ip1 = IPAddr('93.184.215.14'); ip2 = IPAddr('93.184.215.14'); self.assertEqual(id(ip1), id(ip2))
+-		ip1 = IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'); ip2 = IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'); self.assertEqual(id(ip1), id(ip2))
++		ip1 = IPAddr('51.159.55.100'); ip2 = IPAddr('51.159.55.100'); self.assertEqual(id(ip1), id(ip2))
++		ip1 = IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'); ip2 = IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'); self.assertEqual(id(ip1), id(ip2))
+ 
+ 	def test_NetworkInterfacesAddrs(self):
+ 		for withMask in (False, True):
+diff --git a/fail2ban/tests/utils.py b/fail2ban/tests/utils.py
+index f71ba60a..e6ef54f3 100644
+--- a/fail2ban/tests/utils.py
++++ b/fail2ban/tests/utils.py
+@@ -326,8 +326,8 @@ def initTests(opts):
+ 			('failed.dns.ch', set()),
+ 			('doh1.2.3.4.buga.xxxxx.yyy.invalid', set()),
+ 			('1.2.3.4.buga.xxxxx.yyy.invalid', set()),
+-			('example.com', set([IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'), IPAddr('93.184.215.14')])),
+-			('www.example.com', set([IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'), IPAddr('93.184.215.14')])),
++			('fail2ban.org', set([IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'), IPAddr('51.159.55.100')])),
++			('www.fail2ban.org', set([IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'), IPAddr('51.159.55.100')])),
+ 		):
+ 			c.set(*i)
+ 		# if fast - precache all host names as localhost addresses (speed-up getSelfIPs/ignoreself):
+-- 
+2.34.1
+
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch
new file mode 100644
index 0000000..a60b0fd
--- /dev/null
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch
@@ -0,0 +1,35 @@
+From 9f26da3cf854e48b7939c2a9baa0cb3ffbee5994 Mon Sep 17 00:00:00 2001
+From: Yi Zhao <yi.zhao@windriver.com>
+Date: Thu, 11 Sep 2025 22:36:07 +0800
+Subject: [PATCH] clientreadertestcase.py: set correct config dir for
+ testReadStockJailFilterComplete
+
+In test case testReadStockJailFilterComplete, set configuration
+directory to CONFIG_DIR (/etc/fail2ban/filter.d on the target) instead
+of the hardcoded "config" directory. Otherwise, the config files will
+not be found during runtime testing.
+
+Upstream-Status: Backport
+[https://github.com/fail2ban/fail2ban/commit/9f26da3cf854e48b7939c2a9baa0cb3ffbee5994]
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ fail2ban/tests/clientreadertestcase.py | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/fail2ban/tests/clientreadertestcase.py b/fail2ban/tests/clientreadertestcase.py
+index e6a2806c..b8ebbbc7 100644
+--- a/fail2ban/tests/clientreadertestcase.py
++++ b/fail2ban/tests/clientreadertestcase.py
+@@ -878,7 +878,7 @@ class JailsReaderTest(LogCaptureTestCase):
+ 		self.assertTrue(jails.getOptions())       # reads fine
+ 		# grab all filter names
+ 		filters = set(os.path.splitext(os.path.split(a)[1])[0]
+-			for a in glob.glob(os.path.join('config', 'filter.d', '*.conf'))
++			for a in glob.glob(os.path.join(CONFIG_DIR, 'filter.d', '*.conf'))
+ 				if not (a.endswith('common.conf') or a.endswith('-aggressive.conf')))
+ 		# get filters of all jails (filter names without options inside filter[...])
+ 		filters_jail = set(
+-- 
+2.34.1
+
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
index 7312bf8..b0b65de 100644
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
@@ -13,6 +13,8 @@ DEPENDS = "python3-native"
 
 SRCREV = "ac62658c10f492911f8a0037a0bcf97c8521cd78"
 SRC_URI = "git://github.com/fail2ban/fail2ban.git;branch=master;protocol=https \
+           file://0001-example.com-changes-the-IPs-again.-additionally-it-g.patch \
+           file://0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch \
            file://initd \
            file://run-ptest \
            "
@@ -47,8 +49,16 @@ do_install_ptest:append () {
     sed -i -e 's/##PYTHON##/python3/g' ${D}${PTEST_PATH}/run-ptest
     install -D ${S}/bin/* ${D}${PTEST_PATH}/bin
     rm -f ${D}${PTEST_PATH}/bin/fail2ban-python
-}
 
+    for i in checklogtype.conf zzz-generic-example.conf zzz-sshd-obsolete-multiline.conf; do
+        sed -i -e 's|^before =.*|before = ${sysconfdir}/fail2ban/filter.d/common.conf|g' \
+            ${D}${PYTHON_SITEPACKAGES_DIR}/fail2ban/tests/config/filter.d/${i}
+    done
+
+    install -m 0644 ${S}/README.md ${D}${PTEST_PATH}
+    sed -i -e 's|^logpath = README.md|logpath = ${PTEST_PATH}/README.md|g' \
+            ${D}${PYTHON_SITEPACKAGES_DIR}/fail2ban/tests/config/jail.conf
+}
 
 INITSCRIPT_PACKAGES = "${PN}"
 INITSCRIPT_NAME = "fail2ban-server"
-- 
2.34.1


