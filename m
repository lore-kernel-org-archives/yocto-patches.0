Return-Path: <Haixiao.Yan.CN@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE12CCD1BB
	for <webhook@archiver.kernel.org>; Wed, 22 Oct 2025 02:06:19 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.4553.1761098773212529930
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Oct 2025 19:06:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=YTegzUqr;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=2390f65e28=haixiao.yan.cn@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59M0viTo2199387
	for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Oct 2025 02:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=X3DbxlSi82V9KLtwW6Tk
	zCLGLStJnB/H7hoSPALo8Wc=; b=YTegzUqrWIp6fGGFgnQNeLJsYtBZSEWvAjkp
	t/p2wxd7jBq94T+LTtyx2PGT8I1uppQMz8wqtVV/NfJmALkRxk28TH3jaaNwTuwm
	eGpIsRxJwmZ+EeznbwPeK48bhJA0BbGBQnTVq+2n1Xgw3ia9Qveft89zIAGCg9eQ
	q1BK6GsY4NQAklRzlslgi8s6CaOjKqtFb6jv8iv8c0ustV7DleBV0I1s4inqFTke
	cWiOzhHbIYv+LWsMXQMa4DQilqz5eNiwwoVSuiIlgWF19QwaFkYZUvjQIbGjeA7L
	RV0r6wXpqvIqvP+W9fIJi4MqeVm9R3B4xJLY32f5s716HFgJ6Q==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010043.outbound.protection.outlook.com [52.101.193.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49wrpx9wk9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Oct 2025 02:06:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrLB/JwB0s//QcsxKjm4PYOn/T3CSIeTj1vim2tkaCvKXEe+XkXOee00rDOp4Y8r4Qg+Kl6BW2hEFpmS9s64gLhPOoVxzuYGdHMBPUCmLJBpo0vCk4AOzRdsCEXqldJBeYp8NTVWhWO01euklDXEwlVbl/jN5VkPywOSnGhdmJ0wK0v+sJPrcNkF1nBzYbvoeCW/bzCqzG7UKudo+glkdV/JkM7nB0+UpeJo0xOtBhj2LQ3wfa/LaAQCHW/W5cYeoTc5wfn5JUd1WwMbr5ffT+58XEAOqIVqnqk6+2IpYCW/JmgEXqyKzl/1LhV6MHQqyqg5PK8QngErbD6Ku3VvZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3DbxlSi82V9KLtwW6TkzCLGLStJnB/H7hoSPALo8Wc=;
 b=UVWVdMqF3h7dWbRFsXUICwhhkK9HysIuRmJSSxo8lcoElcQIUwtfeIbzjrFKVgRTsXBjt1YKlqWi7kJi33jQVlTYtxHMmGwHwsVghoQ1U5OlxUdU0XSgfEK1HGbU+kEJz3UJ+/aTUeFhgQboTpbflrPLiG+Zi5KJ5E3Qeo8Wo6L9TXHNFtBCNSNP/3kSKEUCzK6Awtv8CHcX4QB62CA1Nd/+ncRZRVIrPawNLlgZPMa1N8E++bZJGXRNxpFItpWLFhwJgCl6fKFE/zO5s+oal+itvZqE3B6gccWOs8vIQ0TY8goxW5XasZtWFt6k/hTP1aHWiJB/GcRnZRGPHgY08g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB8200.namprd11.prod.outlook.com (2603:10b6:208:454::6)
 by DS7PR11MB5967.namprd11.prod.outlook.com (2603:10b6:8:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 02:06:09 +0000
Received: from IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::b6d:5228:91bf:469e]) by IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::b6d:5228:91bf:469e%4]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 02:06:09 +0000
From: haixiao.yan.cn@windriver.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][walnascar][PATCH 1/3] python3-fail2ban: fix ptest failures
Date: Wed, 22 Oct 2025 10:05:46 +0800
Message-Id: <20251022020548.3644179-1-haixiao.yan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0135.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::19) To IA1PR11MB8200.namprd11.prod.outlook.com
 (2603:10b6:208:454::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB8200:EE_|DS7PR11MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1ceff1-78f3-4eae-8fc1-08de110f9128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Dm3R815K7OCk9Tk706kSJ6Ri3eMm5sY1OhSWY3jwFSq79QHvzDGlbDAGW7ET?=
 =?us-ascii?Q?Mp1V5wirCpJtTEPckKOtoI+wGyXchrBSuesWSK+WMjJdo89MU3/sYbw62k2/?=
 =?us-ascii?Q?scT1/vXVThLvjd4ts3Z2bI/INwRgZN783UFz+f8IEhv832iDm7w/fjDPjD6m?=
 =?us-ascii?Q?UPTjpi98pnl7iAaY/wbJoNLSb5OzK8oyOZaTNewjD5iHSmkeSkqgXOU0W1+Q?=
 =?us-ascii?Q?0DKG7r++zSyUJKwUrkN9P0KwiTer5R+e0fOQw0kGAcaaYmouj2DZjNkLJub5?=
 =?us-ascii?Q?gen5VqDUZXXYEVxNA8Og6ao/sezNm+buoa3u1wb0LlfmpWs9mxlBrZi9IJ0R?=
 =?us-ascii?Q?IgROOhIvZ8lbAu3rvJVwuHyxTqtNyBDY9evmffJnqzNBTK8HytpYNHXK/BIT?=
 =?us-ascii?Q?Fm1GLMuTMe3UgzhqJqO/i8xifU8sS1/7Od6qLz2WVtywxj1EeI5GYupbw8LJ?=
 =?us-ascii?Q?zCvM2nW67XLp95sbgTlYyZmMrlTXEPuLd58zQ7wbOyTI0ErG9iLJwsUAD/9d?=
 =?us-ascii?Q?KJQ4X7HcO7uu8w6HEpsqHJoePZry+ZI37kcK6B7co03ZrdPwY2Lw/svBtCa4?=
 =?us-ascii?Q?vyprkUckWcp4yZDTRoqRfp4N0t1Gxdz9wDVJMQC8ZKEqd27aM8NJTWbLDr7S?=
 =?us-ascii?Q?inGsYJ6Shj9MbWoqXWQ5yyRimbe2DUHYSKdFnFNlQuiu0suOykTpQfUxC6Qm?=
 =?us-ascii?Q?o002yIA7w6NfrItso38M6zbIXWvsvZFTxtJ+taxzZ7DgeIosKN9BWVnoey2h?=
 =?us-ascii?Q?kH/FLXcs0+v8toMtbrfK7UGI7rmixPGVjcAbRS8+1dhYClKQtjI9IQDppxEr?=
 =?us-ascii?Q?4vlPOjaXNox9+4Rg00nyUyoufGzndgFq1LPdmIPN0c4/wkGY18OfyOcH6ctx?=
 =?us-ascii?Q?by7qQTUzUnBqETc83qnRDZ1pYx4KO74nThtDKYE42b9AWyF5nVHEVB8wMlOD?=
 =?us-ascii?Q?3v1w4mckz6pX8rfEB4hEG9oebTvKNUoJicNB9FR1VyJp711sNM2EiNiHfs2t?=
 =?us-ascii?Q?7H5eN25vC1PRFIxXThzBziQm5NFv3HMX025SVbaC7jgbqmtKyTsNBrMPcCHV?=
 =?us-ascii?Q?FMk0y0eQj5YG7SItpBFam0XknaOzKn/qIBbFMsaXDPLBAoZwyfGEXFbUN6ET?=
 =?us-ascii?Q?8RcLGAiXCiOdku8OxoPHl+H/EVloSWWn5oObcXAPVnDzNEQB/cgEhxy5NSJF?=
 =?us-ascii?Q?xjfogArTBNkBq4jL9VSbxQSNVtZgzbKCvJYPD7ZxTyG0so6In0gxNMFPfMXK?=
 =?us-ascii?Q?hK6wOYFQmGDJaGt0l0kPtrMuSg0hyK+EEITEks+pgth2mLOZkKlG3CJ/hufe?=
 =?us-ascii?Q?2F7ej1tB8qfezxBBbfJ6yKsJruNfXQBcCxNIZXAmBHq9+8G8ZNNWpSDidrca?=
 =?us-ascii?Q?XyiQuavrCDutPCV0TxOHS1w2jlqkHISuTlE23htaCVg/OFiupBe9RmZVyFQC?=
 =?us-ascii?Q?noPlkyJN1mTASa3p7g3ek6xuoa4chsexf4HN79SSMfBNc1OMlKlN/A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB8200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(13003099007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8HheMMAo3FUklpecG49avDEMpfbs/nKkwvRFmQM9v0SgRMbiXUzyRMWMlAuG?=
 =?us-ascii?Q?sDWgN4hEgRlmqYktHJvngRhPD9Jln53ODvQ+12MUibivxbbpPC+KVFxmDoND?=
 =?us-ascii?Q?xQTUNh6s25gSvV39F//1+lrXkCB73R3O2m98bUXzbcAIczjOfXaP8MXBnDwG?=
 =?us-ascii?Q?kuRXZHqM5mjcv3yFW3n1MVnCzZ+B3J30rx5ZhbStjtdl+x4bGpAaPCDW1arb?=
 =?us-ascii?Q?OYZakkx24HlrWhlQrlAONAGDwSCLrpZyLVTMP/Kw8zR2uh6WG5YI3yu0PCed?=
 =?us-ascii?Q?HcClrTrR39gqlBlQHnrLtxIrEPVhGwuCoU3cAKax9sEDkf2A6hpS4pRnYcqU?=
 =?us-ascii?Q?5K0ADaz1ff/RLnbyu2ze6r9V+czH8MrX9H9w9lxNHmhYOG+8VnrC+jGmcEfc?=
 =?us-ascii?Q?tMjZLJr5eBjkefmLlgU3ZKo1IgVUhRiRkXFHgA/1Pcq8QVi0jZ6XO1x7oY5X?=
 =?us-ascii?Q?uXthr4COPYQ1j8qdRhbG06ySX/tb4mKe7ifAnS8vEYNDDkV+vkzskUQm5TO1?=
 =?us-ascii?Q?pB1Aqd0ZGz2wwDM44IlkusZI1ILARFiZkBztsv/fdZCt7U+AvkOsTAANi4GE?=
 =?us-ascii?Q?leRno68zjY+0xnRdMT2OlvO3+6xvthKaDy6wsHoVOifBZLCHm57I2Axk6uZX?=
 =?us-ascii?Q?ehK3LF1iG+gqxeisrQp+GUgsoeUzjXguVb1NmAM9Vgk21E1ydDH4YA+OhzDr?=
 =?us-ascii?Q?sXmDpUZV44fxIwAbrlA+IXvP8g6QGbh0OhcNBIo72zEHMst1bIXgg6VNiZYY?=
 =?us-ascii?Q?HHSlzwU/E+OxoY+azGmBzl2yJwwCBDwGgLGKjr6zBwoSZwlfOUyrg7ohzFh6?=
 =?us-ascii?Q?f42tw2Jyjq+f4cnG/UQukveDW6REDRjLNH4JrlthNAThM3E7r++8nDZyXMQe?=
 =?us-ascii?Q?UshDwzt8utAyFbPT0NW+/7P/Q9kTWcuXVH/WBTJvKDi+3GIM5PQleA8Z3ELp?=
 =?us-ascii?Q?UaXtuWVaVIaFlvHK2RlyPhv7ro4SxO7SBfwAECX4xpi0/JRDtY4crdmbk3yl?=
 =?us-ascii?Q?jaszaLqYlcM1SlrvgoPc2Z3+G9bQnrknyqJWVpBwxbokHFH8QiL9qIhemdRB?=
 =?us-ascii?Q?44J6Cbjzf5dm0wVJ6lvUzsAblkdeDxIvXluPH8vL60HyQEGq8zCFsNMCTFDq?=
 =?us-ascii?Q?22/EPqsRA7W7fdZZtf5bx+0mi29Zv2pim3m2+qol/J5KoV+dEm5oiq5lb+AB?=
 =?us-ascii?Q?Wtl9ON14EFg5cP3+OlPR+0xYJqziuEWG5vRy3rJzTyK31o5ztJVdfPFqLOYp?=
 =?us-ascii?Q?qL4DaPEr0mo0ohk8vN/1RB21lb9GqEMAd8S39zRaojgZQ1Ts4DOXra3csBqx?=
 =?us-ascii?Q?Dm4npcqsXDDo/QmLzc5aEV8n/EJMjIuu6VmUY6amqq7FuaHZJOjGa+Yg51Mr?=
 =?us-ascii?Q?9kwAduH4VgMCgaESsZR3hWAHlInKnHUVMH9ByQbQE1RfmRLWjbC6+vXoc5Vd?=
 =?us-ascii?Q?1xgzq/mAlrczyypMuLfYTNI18zAvUgp6F5KXEiGit/jnb0FLC/u6eODoPX+3?=
 =?us-ascii?Q?m91JiT87Whjqy0uMchA12fk/Fe7RrWA8YomK58e/8iSKQ/dXJGesBCWirxac?=
 =?us-ascii?Q?fWKLVUsUpcDrM0wSJISGLSqNCCgKPS35x90ai1tsDQr/Hau47CKHdlrBcvjX?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1ceff1-78f3-4eae-8fc1-08de110f9128
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB8200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 02:06:09.2911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Esk5IY+vzrxNSoPgGJiZdT4HemNoRQgf5YBPTPag82AzXF4W/A4tEwm5xDeSwQysDJtcJXROPKHoN4NkZYfVQ9VgIQ1mqFN0hAddErnJzy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5967
X-Authority-Analysis: v=2.4 cv=b9O/I9Gx c=1 sm=1 tr=0 ts=68f83c14 cx=c_pps
 a=91GdPAjHHMbPGBWG17ie4w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=1XWaLZrsAAAA:8 a=t7CeM3EgAAAA:8 a=A1X0JdhQAAAA:8
 a=ktNasmvQAAAA:8 a=xqzR1eaSAAAA:8 a=_XDxjdB5o6fYZ9oTqksA:9 a=2WnUeqSxssMA:10
 a=FdTzh2GWekK77mhwV6Dw:22 a=e0GJpZYNDejI1RnTdwpm:22 a=dV6nhpJrT-yxOfsl7Uss:22
X-Proofpoint-GUID: 60cbggWFbnkMlltRksJt4_ehmPVz826U
X-Proofpoint-ORIG-GUID: 60cbggWFbnkMlltRksJt4_ehmPVz826U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDAxNiBTYWx0ZWRfX39anNrytoQhy
 W1/dwb/dkxHtoNCYt3j7pULTjttxs2fGakeMQWksjj0wRKy+D7oXdpIRbRGcH+0LuSgMZjLroxO
 OlNiCHKynP1kf0QuHK/yP3QE/xfobSkomnUxGUY/cwJiiq+2iXmhw3rMDIuoBDcnhsLwJrTYhFW
 K+WNypQjpyU+GBtN6OzP6k8z4xbfxEpnpw34cxnDLsFDZJMRoYksKQj+rX6rb4o1dSr9pdIEVas
 Aaq5sk1i7IxQjJSNmmTHniiFcm8KGwGaHKUopg9zpcdmzXN+tfzGvIZSO75wCS8ub68SRWDsCja
 xiRa/QZCU8k3R4m4dgQSc1VnEwympfFyhODSRXFayCXx8SOJdexGnCvjcsCk6sSECzbnca8srhJ
 zg9s1TX2CUZUf9l1KHFmLNUJZNAqFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510220016
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 22 Oct 2025 02:06:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2379

From: Yi Zhao <yi.zhao@windriver.com>

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
Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
---
 ...ges-the-IPs-again.-additionally-it-g.patch | 210 ++++++++++++++++++
 ...case.py-set-correct-config-dir-for-t.patch |  35 +++
 .../fail2ban/python3-fail2ban_git.bb          |  12 +-
 3 files changed, 256 insertions(+), 1 deletion(-)
 create mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch
 create mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch

diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch
new file mode 100644
index 000000000000..73014ab96a15
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
index 000000000000..a60b0fda80cb
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
index 52d35f85c955..4d67f85c23f6 100644
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
@@ -49,8 +51,16 @@ do_install_ptest:append () {
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


