Return-Path: <Haixiao.Yan.CN@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBB3CAC592
	for <webhook@archiver.kernel.org>; Mon, 22 Sep 2025 08:35:47 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.46794.1758530145683476743
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Sep 2025 01:35:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=GeaeuPQy;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=13604ae5a3=haixiao.yan.cn@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58M5eioK332802
	for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Sep 2025 01:35:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=hjTWSwks596+UTL1YzoR
	sGRNc7wKynZJPMue7lzq2h4=; b=GeaeuPQyxBLW0KXMscpxLSOyNW4qSzmUuoeF
	J0L6PHn5gVA8XEzA/4HdYQF5o1/VJFxiHXSzBse9nktTTx5TQyiPCtLIEEkXnT3Z
	k2jWqMgH9NCw0LX9O7DvRAHFsaGqnVQZQLwLMCG3hXOVQJ2dE0FM+9cl9jJn/oST
	RxXXZw6E+svGJB94vGaDTK3g5CXwa3zp8cfmmjkGTpBFgysZEKEtX9TtxFRUd/O1
	4z7VPshrkOq8SePjeARald3QZNDJVxWkyt2pHwMktjHPSxi410XOR4UF1fSZoTJ6
	smaTXdK2vXkAkFt9Top7J3DyT7DPIp1oQD+BrxcYQWXIyi9Jfw==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 499qj2sdba-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Sep 2025 01:35:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NizLTNwWs4lMqKCsvvbO9WDGY1o24A94TZKEQgN/TjH7Hhi93bzdyjzvxjPRlLitM0GaXYOaf/ZX6VLLMWKRTY9uoTWtPkHooV+7m3iD3YqIrX+ayy1H+2qkDBoZIX3OJiu3i1qB32rDwD12ay4YD33Ob2MRKKSCEzkt0P6D+rR1VdMZ3iRMLSKGPrDaXzYJ5stqYliJcAcLIbu5nzpmnnOpEh795MtdXA946OwcxFh0BvpCNKECf0cb5/2tKOgjgct/JlpJW0caZmcPHQolQl+6hnPk9MDGTZmyW+agIcHvYaZvOAwPsc2vLAtZwDHJ6vR56SB0Cil5ZW7nbxZcXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjTWSwks596+UTL1YzoRsGRNc7wKynZJPMue7lzq2h4=;
 b=P18Ei8pSRv1fwgMZY4hJTZUvxCsIhyaCxLyuKqDr35EYdm8Yk6S48elUNkvoYicw9WLx7/v+1UVkz47q0CjRo1PLrE5HbdJUnA8I0gdzhqe637v1IjojZ+sW8GK1RRCFin4LtDKCx/qPtr9vPgoHxJlv5w2qYVs2ffdqsfvD7wOHi0JRpuSkBvfoZa05GwTTsONrwBbp+9LL/cs5R0Bu3pgJP31VyWq+F2pWgSp9tr3e6P0n0E8Vkx4El6iBuMnw9OmY3OnULOQ982+o06HFik/95w/tPJ5KHB9NRyv/isuj8QR1GW170rE+dBiprVN2nFW8GadsCSbnjShgNsWc8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13)
 by CH3PR11MB7913.namprd11.prod.outlook.com (2603:10b6:610:12e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 22 Sep
 2025 08:35:42 +0000
Received: from CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4]) by CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4%3]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 08:35:42 +0000
From: haixiao.yan.cn@windriver.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH] fail2ban: Adapt test output to Automake format for ptest compatibility
Date: Mon, 22 Sep 2025 16:35:22 +0800
Message-Id: <20250922083522.1681882-1-haixiao.yan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:a03:331::35) To CH0PR11MB8189.namprd11.prod.outlook.com
 (2603:10b6:610:18d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8189:EE_|CH3PR11MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: ab67d96d-468d-4e97-77fc-08ddf9b3041f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qiNwR1Gax+gT2QPGjvcw1HWb2g2v/5DBD0FailEEs+kedBPYZsPJg6VrZD7n?=
 =?us-ascii?Q?EG4gxZGXnFXlT4BlEJWuHLhYDDV3EiWFKv4vKOp8W3iJwZQpjPODfRvw/nfo?=
 =?us-ascii?Q?wTlYViSZbYy0mV26SRpP6J4rSwnMNKj/sK8fWISjCGRc7hNrHZZc1zCwtEKF?=
 =?us-ascii?Q?cmPPrvZ21+3Wl8bZ8a+Exl2V8IOZ753SOwV45argohwlYus/aAvwNVxgW2F6?=
 =?us-ascii?Q?PoCD7XyZuZkOWU/J8E5VJUpBUDHe9yWxIivbXNyCtZo0Gxsk/RibDAPjceaS?=
 =?us-ascii?Q?T2IENQiNb5BhW/PLtEGbe3dZ17DcIBhdtMRrG1Qr51XGg9jj7wEqTNfv8T75?=
 =?us-ascii?Q?wq6xQaQ4utwOcNTgJeGck5J5AWPJitBDQWneZw9puR1p0TGDYn4/KJ3s3v5X?=
 =?us-ascii?Q?N+958/1rvEEf6IR5OyEAShTd+L6K5L0/9v4EuOrcWM3f1z9jVXLRT8ezUcl2?=
 =?us-ascii?Q?3IFFHocgxypPqQBvq3OgMymeWDgjWiJzpv1QZjzOflCTVtckIpx0BJtsmAzo?=
 =?us-ascii?Q?lZZDmcThhxd04qKB4PXTGOn0p5fM4biyH+YvIk0WtTwKFxw6TeF31P5PHvIw?=
 =?us-ascii?Q?6fHKJDxvfxITH97wVAU7Jj0yH6j6vuZ6L9031UslG/2P1dUxZirTiW2VUD2t?=
 =?us-ascii?Q?fC3CG7AxjpMqXhk532tCZ4yQD8Sgk099EG1jv5/EgCK608N8I0OqKbvnE9y7?=
 =?us-ascii?Q?rJlQp7EL0CBHoZTQJa+QGUKIHXOqEghjM72SghklNMtQaR35ujraxU9nlvf9?=
 =?us-ascii?Q?qO+7d2eVqY+f1We2yTCmQ1wSmhJwGYiAvgnG7bW/yR3DdTtLaZ+nUgLgwKBW?=
 =?us-ascii?Q?UxkZkVxHG2Q1fObBBLHPI+BlCzCujGUCHbNOUP57ZSr+rK3nd9+SfxyNK5Gs?=
 =?us-ascii?Q?U2aUbWzBlMzM/d31hHg6wMzUKFgh8QNHMWkBaF9EsRMrdOSxe7s7aZV0DRUf?=
 =?us-ascii?Q?5hg3nweeTJhRvVwTSH0Tb2wRrf/BzOn0YS9YhD9DVZywjOzXRwDYP7Yd6npG?=
 =?us-ascii?Q?EBHsg3YMDlJJcJAR54FjPCuofoDSwkdcpuqkOOM4Hk/jS/f6QMever0expMQ?=
 =?us-ascii?Q?seEMhu+b12CPBv9gjkOynDROflLQiZ1UCN8IvPE07J7VMdUEh2f8pdBnCDMd?=
 =?us-ascii?Q?QrGzypRV7ZtXlw46t2B3u0ijbK0BveT6UtbIrHH1qgimrxaYs6DMEtspkyV3?=
 =?us-ascii?Q?cJlSq24ZXWEL7DtZ4tkzQqD8FDOsGut4nZKAUrSvnk5GTDx1KiR4iGdQbQ4+?=
 =?us-ascii?Q?cuFHbpRhwhUdbXYtRATgMXO6pEFrmcUemuTaW6XVFO7GkQbeaq2FqGUuEhz+?=
 =?us-ascii?Q?P0YnwxllEy7cy3vfqDLhoNxRoQvwvvfFwigMCj6hDtK8p5+nsxLwUstZaoZ+?=
 =?us-ascii?Q?QzzsSlywxZRJhkAqfHZgtM5YMNrHFfh+vM8gqKlzsFehme+LbkW+s6kBGTbi?=
 =?us-ascii?Q?lkEfim//z9ABhFANNbORoszDjXKLWuKv8Q1ing/UBMM1nLd0HVJdBg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8189.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gmhSAZcvWOKxV2UjnTY3V/GQbe+FrWPWUwfGj/WDrBubOkyz6jATLcCNH7/0?=
 =?us-ascii?Q?2Lhz2skKuy1dp67s/xfd4T7a123wngY7aClJRZWWBiPIGVhh/5aL2j/84jsx?=
 =?us-ascii?Q?KeSTfkyGpDGLeJ7m/CFUTgvoklGkxuYakAuBy7ZUQ6ZghfexU+d6HHGmsgwo?=
 =?us-ascii?Q?9RTgLna6VZJKWLdRu+70kABG7q0UKRQKOP3le6MteWG3WgQl1/w2k8Rrfb8y?=
 =?us-ascii?Q?QNKNWguyrxlooJsqt7RMxlXKdccg4zzrfaLD1I3qYbQEPcdLDMP/mHiDn46X?=
 =?us-ascii?Q?zTwqS27DJBFHWAvLFCPNBv8AfD2i6uXTzyaNnDH4qiEhvDiU+woBq2YUq9zh?=
 =?us-ascii?Q?MbLhjFXNqwj4YGsbuSmBTuoqIKN7PHyuRNnyT2t+YXkEPPe9UPjq6ENqXQzX?=
 =?us-ascii?Q?hAQRbgi6l879iH5uG+DpVunZRxdarQys85GDwcritZ21mQBiLPFt3cQ4RJ/D?=
 =?us-ascii?Q?j/nJZP2awYarMsqT/k8sGkBwK69jlnUcgEGjhnl8bFEQ9yeAFwkWnRiGYGQy?=
 =?us-ascii?Q?CPwDhFvmk65ZziyqwgFXi6KBqwzcbZgqI5U6aE6S54s+zCGqcBncOKrugkEi?=
 =?us-ascii?Q?JHM/X/sibtzcBxbkDiHJWCAXj4KDGMzQKPffT+S6Yz5pRE7D3e7HadeSyEph?=
 =?us-ascii?Q?pcj+Bz4+JbLfzhQdZk6Xb/bwRlR8YS20kpGzwBYLcHx+SZcBFOMDSVRHrOHY?=
 =?us-ascii?Q?Cj/N2rLTW7VMwM7harLsCntB2rCvwuNGZUWull4SD+5BB3izOco50+5AU7CB?=
 =?us-ascii?Q?0t46adOAY8M4RYsZW5Tpkls8wmXPbeCsJmLt2WCBqjyvkEsbKwBgfGJ/dZ1j?=
 =?us-ascii?Q?2M0OMhZLUETgfOEIypyFqUkLUCMItrHZmdhkgrnVFFxXeWF+WFOZMEaJ7+ri?=
 =?us-ascii?Q?ikqltUl7t6g0lAqbCI3TbMjFJWEAGGlhVlYVqcbqzvFGxLGrgvaILoCvT/QS?=
 =?us-ascii?Q?AQ71nzWYoVFwq+S3C/kFSkHkR3v1fo+wu5XPdMUv2uwkphsOXMOp9BdQKo4s?=
 =?us-ascii?Q?YKidslYNDbVDdeP1t7XWIA2qFM+AW3SmV6gm3njVP3KCIgklmK1tsjctbgmj?=
 =?us-ascii?Q?cKBg3aChB/iPAcc/pftdW5IP67MmQ8f2V7m/o6D0QldMUmg1SQCH35/eppYu?=
 =?us-ascii?Q?zxBepGjSevFjkvI/ZwvQTBA9bq144gZajvWfdzbHusTdVQ835zgkdqkr4Zt1?=
 =?us-ascii?Q?C6cri7n1AKgbQxnWDw0t5QZjJTo+/qjEu9+mh4+z6M1ImC3m4M2Ieno0O5vX?=
 =?us-ascii?Q?Y+F29CCWl9HRd7oN8UfWblmskD8oOQRWABaX2iXp1iQtUCMGSBqVhJPISvYW?=
 =?us-ascii?Q?2o1MDJPkiQZJTN0S38+WuF6N2d0bJWkfTvy9/Q5M/Z9AkkYkT5Fa5z2tEO4V?=
 =?us-ascii?Q?zxychOhw78MsoO25uCwV00gaemTqT+dRKycQ1pGKm0nBFrE4aIud9lLyKIs9?=
 =?us-ascii?Q?aenUMst6Q2cTxvNUnlIKJhoCxW5YUHTHr3PsWxcKmDr+J9DZy/ePS8reHaXE?=
 =?us-ascii?Q?tjpUDdh7llPJUpH8UWmXCTMa17FkZEHmL6eKjrCe1lEin40w6M0rVjPUhkse?=
 =?us-ascii?Q?pg/OokHUGtU6H4950nfj4uzP2608+TsL62apGOKEM2+AWTuYKlR+pu2VRKsR?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab67d96d-468d-4e97-77fc-08ddf9b3041f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8189.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 08:35:42.1225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Bhi1Wjb31AHa1QJIuJlvAzeL/Z0NUOdIZ6tK0bcQomzaOW7ZN0dwE8ha2t1R2yWCSHQ40KpudzSZAalTvQwZsfAP6G2dIlyUpA0GWZRqZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7913
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4MyBTYWx0ZWRfXxCq5+0P/Ozdh
 C+6J5yi5yIxrhkHUMcB8lem4jCHOmmqrs4LcLYE2e7PUpQLhnQkAiD/BQUCE9cEFiUgOk1d0SzS
 cMS5teW7bgTeZiJcY4oQ6BW1/E2JZ0D9faP/h/qccAgcYN+IuyMr0NNCp+07tSTYB1Q0Wrud5RY
 Q37/V16yySyQb6r08BgPqlt3Vfukrg0LOTv7RN5Xzdt0gCJ6Ox+Lery18OdHO85hIYjz4qG1HVT
 ljsIvUyrtELHQqZvSv3uwuZhVgC/+9lE0mPAT7OJrlQH0Z5aOW+mFhDN8mFwI7+EIyISPqkbJLz
 NqrktIPGiFRGxpgiB46QH39JsJmTx30M5YOcz7jqOHNaLlxEru+l/kZFr94r64=
X-Authority-Analysis: v=2.4 cv=btpMBFai c=1 sm=1 tr=0 ts=68d10a61 cx=c_pps
 a=8tq6Qs2DEm6oQ1m+I15oQA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=t7CeM3EgAAAA:8 a=NEAV23lmAAAA:8
 a=3d01TAmHAuPuTfK4mfwA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: zQkgyAfSTV0vy4nyd49eutCZD7FZQj_-
X-Proofpoint-ORIG-GUID: zQkgyAfSTV0vy4nyd49eutCZD7FZQj_-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 phishscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Sep 2025 08:35:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2224

From: Haixiao Yan <haixiao.yan.cn@windriver.com>

Convert fail2ban-testcases output to follow Automake-compatible format
(PASS:/FAIL:) so that ptest-runner can correctly parse and
report test results.

root@intel-x86-64:~# ptest-runner python3-fail2ban -t 300
START: ptest-runner
2025-09-22T07:57
BEGIN: /usr/lib64/python3-fail2ban/ptest
Fail2ban 1.1.1.dev1 test suite. Python 3.12.11 (main, Jun  3 2025, 15:41:47) [GCC 13.4.0]. Please wait...
I: Skipping smtp tests: No module named 'smtpd'
I: Skipping SSL smtp tests: No module named 'aiosmtpd'
PASS: fail2ban.tests.servertestcase.Transmitter.testAction
PASS: fail2ban.tests.servertestcase.Transmitter.testAddJail
PASS: fail2ban.tests.servertestcase.Transmitter.testDatabase
PASS: fail2ban.tests.servertestcase.Transmitter.testDatePattern
PASS: fail2ban.tests.servertestcase.Transmitter.testGetNOK
PASS: fail2ban.tests.servertestcase.Transmitter.testJailAttemptIP
PASS: fail2ban.tests.servertestcase.Transmitter.testJailBanIP
...
PASS: fail2ban.tests.servertestcase.TransmitterLogging.testBanTimeIncr
PASS: fail2ban.tests.servertestcase.TransmitterLogging.testFlushLogs
PASS: fail2ban.tests.servertestcase.TransmitterLogging.testLogLevel
PASS: fail2ban.tests.servertestcase.TransmitterLogging.testLogTarget
PASS: fail2ban.tests.servertestcase.TransmitterLogging.testLogTargetSYSLOG
PASS: fail2ban.tests.servertestcase.TransmitterLogging.testSyslogSocket
PASS: fail2ban.tests.servertestcase.TransmitterLogging.testSyslogSocketNOK

============================================================================
Testsuite summary
DURATION: 48
END: /usr/lib64/python3-fail2ban/ptest
2025-09-22T07:58
STOP: ptest-runner
TOTAL: 1 FAIL: 0

Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
---
 ...ao.unittest.TestRunner-for-ptest-out.patch | 43 +++++++++++++++++++
 .../fail2ban/python3-fail2ban_git.bb          |  9 +++-
 2 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch

diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch
new file mode 100644
index 000000000000..c6729cc1818e
--- /dev/null
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch
@@ -0,0 +1,43 @@
+From 7b42974b5bf20d9db8e788e9d6817004556d660d Mon Sep 17 00:00:00 2001
+From: Haixiao Yan <haixiao.yan.cn@windriver.com>
+Date: Fri, 19 Sep 2025 15:03:56 +0800
+Subject: [PATCH] fail2ban: use putao.unittest.TestRunner for ptest output
+
+Switch the test runner from unittest's default TextTestRunner to
+putao.unittest.TestRunner (provided by unittest-automake-output) so
+that results are reported in Automake-compatible PASS/FAIL format.
+This enables ptest-runner to correctly parse and summarize individual
+test results.
+
+Upstream-Status: Pending
+
+Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
+---
+ bin/fail2ban-testcases | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/bin/fail2ban-testcases b/bin/fail2ban-testcases
+index 48aae4b5ffdc..20db4a01a3d6 100755
+--- a/bin/fail2ban-testcases
++++ b/bin/fail2ban-testcases
+@@ -28,7 +28,7 @@ import logging
+ import os
+ import sys
+ import time
+-import unittest
++import putao.unittest
+ 
+ # Check if local fail2ban module exists, and use if it exists by
+ # modifying the path. This is done so that tests can be used in dev
+@@ -63,7 +63,7 @@ tests = gatherTests(regexps, opts)
+ #
+ # Run the tests
+ #
+-testRunner = unittest.TextTestRunner(verbosity=verbosity)
++testRunner = putao.unittest.TestRunner() 
+ 
+ tests_results = testRunner.run(tests)
+ 
+-- 
+2.34.1
+
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
index 762ae8f135d5..74e35bd58a6e 100644
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
@@ -15,6 +15,7 @@ SRCREV = "ac62658c10f492911f8a0037a0bcf97c8521cd78"
 SRC_URI = "git://github.com/fail2ban/fail2ban.git;branch=master;protocol=https \
            file://0001-example.com-changes-the-IPs-again.-additionally-it-g.patch \
            file://0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch \
+           file://0001-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch \
            file://initd \
            file://run-ptest \
            "
@@ -71,6 +72,12 @@ INSANE_SKIP:${PN}:append = "already-stripped"
 RDEPENDS:${PN} = "${VIRTUAL-RUNTIME_base-utils-syslog} nftables python3-core python3-pyinotify"
 RDEPENDS:${PN} += "python3-sqlite3"
 RDEPENDS:${PN} += " python3-logging python3-fcntl python3-json"
-RDEPENDS:${PN}-ptest = "python3-core python3-io python3-modules python3-fail2ban"
+RDEPENDS:${PN}-ptest = " \
+    python3-core \
+    python3-io \
+    python3-modules \
+    python3-fail2ban \
+    python3-unittest-automake-output \
+    "
 
 RRECOMMENDS:${PN} += "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'python3-systemd', '', d)}"
-- 
2.34.1


