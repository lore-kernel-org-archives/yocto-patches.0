Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99862EF36FB
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 07:44:10 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9005.1773042241186188875
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Mar 2026 00:44:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=SvNjk9KP;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75285c4c5c=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6296VUkM2227192;
	Mon, 9 Mar 2026 07:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=pga0gti77iaj322bYZRiHLsVgoaog5Libo06LnBA54o=; b=
	SvNjk9KPtEH3q2EdJ8PsyFmqf5ZOzAzyl58rcRzDD1djOqWX7IwIkIN6PafwwS2J
	DQPwMRBQUky3K0SihkUQjvUhHjJug4EwBoCZUnYrKCcpgccvXgGmMgtKvmBYCPMy
	kovUTK7fE7IjmR/q+BYtBKZRIop3GYdUC7YUvDpXktMZo2/McSZIfr58PQTtIlv3
	ZzfkLNay35kYqhBofoNggJW9TZsagrbxjKZtV3zSrPrknROCHyeYsyQCJpzaoxUu
	szKCcf4d2QlEBysWhS4yGc8/xvI5S+wmHiy0HhR1lTy0ZDIwnuZUHnNRag+UR/fs
	P9r/N9yd8RLqzockHdmUyg==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010058.outbound.protection.outlook.com [52.101.193.58])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cr97v9mg6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 07:43:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkyurSwP6JkJU9SYMGMKVny5iU0UMD78B+FXwCabM6CWqB3dtexH8R/qRdY8axR0/SaEAfH4UxR3TT5o+jPkdEvBH5kOAHdfQ36hhyMRUFU/CwZZZimbcMgdfPnfDsEwqiDo62OOKWkjNkwu//XV75gHyLQiAulWnkbd7UIOZQwqcSDOxg2041L2I/AVxKQcm7J4Znll2svPa7KRp7WkCrXS0DvjFxWgNMmCMMSHL3DJiG35ZgSJ7qR3OzKDxY0Omy9lfciJ3vySn9/SNpmdVaDdsLLdwJrzZ5vQGjv+xr/AXLod+0+V5qIBJlWtGj98RQIaWiSO4v7tQQF2/ezjmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pga0gti77iaj322bYZRiHLsVgoaog5Libo06LnBA54o=;
 b=s0bj0d1qx9lxBlShZC4aNlcNaGwYM/P+0ezNZyXTi2uHhwMUdW7v/Lc1FbtGUvd8EvUsYHhjUQyIswUQsorfNmxB0jtsJTM5bhklAjNoo2nRGVTcCeJRefzwErCKcM92qQGxjjcyd5v0Lz0hg8QY/iL4QNbpBaMV28zLhCd+76D/9PWmB7xZsIeOScjSEheuF7yTIxXXV1ISsAv6Hj+lRQ+qKMwAYQpXm/mjzOEm4qf33Hk5kfxALlT7jFYOBXidJVN1GksSWzzmOyeDK4mqwv3S/SbAYuaI0jwEBDw0G8BuHKHJCFrCTf7Yl+06MXJLPMN4usKw6HvG8zvsfLl4yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 IA4PR11MB9347.namprd11.prod.outlook.com (2603:10b6:208:565::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 07:43:58 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 07:43:58 +0000
Message-ID: <7aa9d2d3-5e86-4946-94fa-ceced7bac40e@windriver.com>
Date: Mon, 9 Mar 2026 15:43:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH] kmod: add net_admin
 capability to kmod_t
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>,
        Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
References: <20260306063810.3838975-1-quic_sasikuma@quicinc.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <20260306063810.3838975-1-quic_sasikuma@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0047.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bd::11) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|IA4PR11MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f1a734-821e-4ec3-cf4f-08de7daf9f6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	XQuNoXBvsHfbo52KSq04oGSlIPeG5gVk5SWsqFYm1akrbmDZ4sHz1XhyL0ewgLWph1eSDhHuxsGfyabojTnRXX8FGv5WT7qaW3yj7WSEE03C1IQ4ipJi7XVNkYKDiV7rfrOwHibtse1ugu6fLsmbvMFAYJYoM87QlrnA6rbbBwfi4uh92D8SzL2jdKjRb60heehqCx3mnLcoAfdWrAOYWAg59U8VxTt3jyY02YEVK3GtwpwPt8wsb2qEQg94Rc7+OV/hfBksyJoaYhMFwD3Aia9LVLuzN0d7YMqkGkL4A3z93q096+EKzT1uKoPRuHQ9xFx0yOZXJ3+MjYSrcGEe3JQUFIQ/KjSKogKCkBypAjD7o8DS0vY4c1CNdRmK5/L22IuDuGu7EhZ69kGuPqEV9cAAPvyJ5esjH8PKf38ZKH2aYb/NA1r0OnG5iUkRPyRgqkkL7/b2wlfLEnXq8+xpsnin6t9EjpkVW6wC548aDsFN2JKlaulKS8jQDPT+71xn/SQHKmn5uBnpE5sOc9vvFTZiDDy1TU2ptL4OwuIpHqL7bOuIErjkra+tkJNKqTSbYL1zQ2ttj8ieFbsEUqvUk+qrZliSpEKC6xy/JjERgZz1cSjAglAx4ry1utZR2eX1l2ZFH3k43GuI5Me/3KE8XvCixm9ywFaMlJCWE/xU/S6EWgLhydiNt3GxQ33TefM9
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cGg4ZEhmOC8zc0tURGwxQVA0M05hSnNFeTlsR3phKzBHQUVyTENFc2kwbjB0?=
 =?utf-8?B?bE9CT1IyeE03dEZCa1ZDWjVmdWtEYloxanR3YkFWMDgxZ1Bid1ZYYTQySUZK?=
 =?utf-8?B?OCtHVnRVNVRtR2Myb2Vja0VzTE9nd29yMTBDOFRVT1pZZWJjNGhOa202cmFw?=
 =?utf-8?B?aDZoV1RsYy9kRXd5SXdqRndBNFBCdDJ3YkZUQ2JFNC9uTVZuWFFOYk8rTUMy?=
 =?utf-8?B?K0FkVXJndldXNzQvdk5ZUWlHRVUwbGZHd0c0Nml1VzdQNUhQSWNkWGJ5Vjgz?=
 =?utf-8?B?bUJOblFBZEtZSzdSdVUydkU5Y3ZXZWo4SG4xWk41Q1k3U1hRZnhMOTVBcEJY?=
 =?utf-8?B?Q1NUbEtsa1pmVVFSUld1V2RhbC9lUDV1bTlhNzZXMnpsME9VVWh4aTdhbEEy?=
 =?utf-8?B?czRMRFhVN3BkQ3NiVUFqbEFTR1orRENXNkZaZmdsNlYvWFE4UzJRaUFVd3Jp?=
 =?utf-8?B?L1Jmd3hYRGM0ZGl0N2ZXUXJ0a1F0bHRndk5zQ0FmMmd1MW1YRHM1dXFiWjFz?=
 =?utf-8?B?OGw3a2kyeDlOY1FwNXdpVmlGSGFnblBYc09iWXcrN1VPNElCQjk5VnlWV1Jq?=
 =?utf-8?B?eUREZ1doVllRTEh0REZGZlhYeGJDU3prWG5rUDVVL3ZxaityYm42K1k0U2RK?=
 =?utf-8?B?ZE9OYk14ckIySU9kQ29PR3pzcnY2NSsvRTBTQWpNTEZlNksvc0JRYmduZHFt?=
 =?utf-8?B?aHpWdzdvV211b2dob0dnK1hCUVZTTjVnemdjaHlDZGVFN0FqK2hnY1hMWmNV?=
 =?utf-8?B?WmdHNm5PR2xPSTV0UURkaVhhcGF4R2xWS2NsWHlPclFJTmEvS3BUVXRTUzZh?=
 =?utf-8?B?a1FjWmJ6bGttVlcvTEFxT2I5ZU0veHNNYlZwbEpyWGV0cVhKcTZDYTN0ZFBP?=
 =?utf-8?B?K1ArckJtWFJrUlVsYjcyc2RGRS9rRFdWMHBmUW9LWlI0UTNOOExrMHJMNEIz?=
 =?utf-8?B?WHlXK2syN0t2OW9KRDI3TFp3bWsvalREalJJNW1zOTdMdlZLeGU2N2xFdXV6?=
 =?utf-8?B?bUJmQ0pmc3dpeWZXVVNhbDEwemsvNW42WTZEYXVXWnp4Nzh1Z1h6RklDaGNH?=
 =?utf-8?B?T3ZIYVEyR0NxT2NRUWF6TTZMRDlNY2JpNVZWcC8zblpxRWVHWG1jeHU3ZDJK?=
 =?utf-8?B?SHZVL0JBdGthV2htNEV2R1JZMHZ3M1haOEJaSDlKVXlqVTdGRjBMTGRJVUJN?=
 =?utf-8?B?cGNHOXl2NXJxZUVtVnltQnhia2lPY2NYRUo0dW1ISUE3Q3BBMWRjVHNKNVlt?=
 =?utf-8?B?Zzk0Z2lwZVhqOEJySVpoenRKalhZT1lHYTlFcTZaZ1N6NEkwMDFscHZ3TTVM?=
 =?utf-8?B?Mi82dlh2YmFaRVZhRm1aUWxLbk5LYXJ5aEJlTi94a3ZvU29yRytFVnA4M3BE?=
 =?utf-8?B?cndhaVJ3QUZQYWtER1ArT3gvcWJnZHJCcDJsaGErT0ZUaER6YzhpYi9tQ3Nx?=
 =?utf-8?B?ZzJyMGp3WmhYR0xKM0k0T0FCWjdRQkV0RnB2RENmK25jbVFjSGFhVE5DbGRE?=
 =?utf-8?B?RmZCU0VadDZTUlVZajZBZlU0dFB4emlwbEkxMFB6NCtwMldJcDJQcUdQQktG?=
 =?utf-8?B?UnUvMGk5Tnl3VUNxbTB1SVRHNXpYMG9sNFJ3Q0dRa3VlS0RqNDlQdUU1YTRD?=
 =?utf-8?B?eHF5MjAyTnBSN1gyMi9QOU5wbDJQdHVlNHpXMEdHZkNWYUwrblFFQitKVWF6?=
 =?utf-8?B?d0QxdFQ1S0h5elFpM0gvWHR1NGdraDVmVG5ZY0xCY1JBbUJqR04yd0pCS0d4?=
 =?utf-8?B?QWZweTZSSEJ6djF1aHFvUnZvZ3dpYU10Vk5pSTBSSEpJVVZ1WUZRWVBIeDJz?=
 =?utf-8?B?MlNlR1c0SlNtRjArZXVQOUZ6NnhYOFJGWFcyQ0lsN0hCK3JXSkpsNGgyaDNa?=
 =?utf-8?B?T0d3MlZQV3VCcTIrYno0UlNEQSthdnZRdndyTWt6L0VwMXgwQ3QrK0w0UFp0?=
 =?utf-8?B?aGtRSE9HODBucURmY2hObnNZcVpObHQ2ZXVLSU5IdmhDeDhVN3Y1MUphTDNz?=
 =?utf-8?B?RjRrNHVZbGlzZllybDZmemp6VXgzSnJmS0lNYisvckJMVk00L2FYUUY2Sk9a?=
 =?utf-8?B?YzgwQ3Q2Rm5EQ29QaDV4Nlp2Q21WQ3ZKSURTZUFiYi9qenJYK29TSGVGdjFv?=
 =?utf-8?B?clU4ZGpXNW80cENwVGo4VFZZejlpYnVpOCtoWG1NNXJieXg4YVBjWUcxVXJX?=
 =?utf-8?B?Nkk1M0xObjRjam95NG9KK0M0SUlaRXV3SW5qU0JBK3VJSVg2QUthb09uSXlw?=
 =?utf-8?B?NWVzdGMwelQ0Y0dYSnVoY2lVTnJoTFFPRDVzSUN3U0NkRmdUUEtLZ3hyU2Zm?=
 =?utf-8?B?NHI4TG1TY1gzK0M5Q1BacG5mRkdkUWI2U0ZzVS9XTnRGV2F2S3pwZz09?=
X-Exchange-RoutingPolicyChecked: 
	KtMw0g1MLW5JnxKI3pCif0+40YoE0OaotosNh9OffziKrSGcY2H0QeTVXb9IDWGuhojb+kduZDZS5Zh8JKV85oCxSfqNwHwmwsn8P1d0pj6ILlZ+D3bahnMCC/rPMIhEw/UswhVyBrw42GK2Uvokzt2gBbG9KDB5ngd5agapYNmBqKqEKiscsuxIqXKPOt5hb/GPOSK7lbDf8brAIPXQd2SZJWS8Ek88oBOKdS+l4P2zgVnm3T2JDOsziEJD5OggiNy4dF5WyRTy2F/Cwx5+f/qh9hEXWb4FSytq72fMyFq0WQjYDgYynhux7uh3vuVgEsjDrKaXnLpAKJGCal4P/w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f1a734-821e-4ec3-cf4f-08de7daf9f6b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 07:43:58.2814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXu75BNdCdqN5sydiFuro+k02PeNpVGgLcJhrZbrbUc4cYcIYBKtkArSkc1kAYqsOHU5baP2w8NMg0ZZSMvdqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9347
X-Proofpoint-ORIG-GUID: DGzQdWyFMABUUO6AGeefnxwcKiQYBrvt
X-Authority-Analysis: v=2.4 cv=B9a0EetM c=1 sm=1 tr=0 ts=69ae7a3f cx=c_pps
 a=jJEkL6Umpl9hNhu6gfQ4Mg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22
 a=NEAV23lmAAAA:8 a=iGHA9ds3AAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=qkYx55mR6C8dBVdFhCIA:9 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA3MCBTYWx0ZWRfXx2UKfr/EWZdB
 +/w7niH21DVo2JqonnEQ6kbH+ipUDTW2jb/woNG+dF/OdQmz+KOGZPZaoHYkoY8sA3msNBovytR
 bgsAZGn6QG0LHtXRj1reXfzxYlzd4gQrYFj99ogbppqMdWrn9S8512Q2hsCDzQ3tDQrVtLU7Xuv
 FN+36dHF6djx7fPr4LF0oVXEPqfj8HOX74HharP4jde889j6sZssrBLB8vfuRgb5PQOg8/sIXMA
 9GMT++SHVIUFUay763gKLAAQqA4ssE1QPjjS2DJGWGrWUIBbF9XYuGJBdVSR+JzLAdrfcQWIxHX
 yrSZo8WtfaoGJ7HyNjMLS5JdKfJZv7krmD8T03jFno/juAGKw86v5UKm1AUIn27ZrftEzioVb0S
 NtMb/IUBB4jnO6EQd49luKbTTAmorCQIijEo4k7Ei6TzNyk4qnoW2ityW4PYT02DdeXRR5P/Xps
 ORT7vY3+GyN134Jeouw==
X-Proofpoint-GUID: DGzQdWyFMABUUO6AGeefnxwcKiQYBrvt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090070
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Mar 2026 07:44:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3380


On 3/6/26 14:38, Sasi Kumar Maddineni (QUIC) via lists.yoctoproject.org 
wrote:
> From: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
>
> The kmod_t domain attempted network administration operations resulting
> in SELinux denials.
>
> Adding net_admin to the capability set resolves the
> issue.
>
> Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
> ---
>   ...d-add-net_admin-capability-to-kmod_t.patch | 34 +++++++++++++++++++
>   .../refpolicy/refpolicy_common.inc            |  3 +-
>   2 files changed, 36 insertions(+), 1 deletion(-)
>   create mode 100644 recipes-security/refpolicy/refpolicy/0060-kmod-add-net_admin-capability-to-kmod_t.patch
>
> diff --git a/recipes-security/refpolicy/refpolicy/0060-kmod-add-net_admin-capability-to-kmod_t.patch b/recipes-security/refpolicy/refpolicy/0060-kmod-add-net_admin-capability-to-kmod_t.patch
> new file mode 100644
> index 0000000..ebc0d98
> --- /dev/null
> +++ b/recipes-security/refpolicy/refpolicy/0060-kmod-add-net_admin-capability-to-kmod_t.patch
> @@ -0,0 +1,34 @@
> +From 89379c0b2430e80d345e6552c8b8b151c12dc24d Mon Sep 17 00:00:00 2001
> +From: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
> +Date: Thu, 26 Feb 2026 11:46:19 +0530
> +Subject: [PATCH] kmod: add net_admin capability to kmod_t
> +
> +The kmod_t domain attempted network administration operations resulting
> +in SELinux denials.
> +
> +Adding net_admin to the capability set resolves the
> +issue.
> +
> +Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/89379c0b2430e80d345e6552c8b8b151c12dc24d]


I see these are backported patches. I plan to update refpolicy to the 
latest rev in a few weeks, so these patches will not be merged at this time.


Thanks,

Yi


> +
> +Signed-off-by: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
> +---
> + policy/modules/system/modutils.te | 2 +-
> + 1 file changed, 1 insertion(+), 1 deletion(-)
> +
> +diff --git a/policy/modules/system/modutils.te b/policy/modules/system/modutils.te
> +index 271cdb1d4..7355255e0 100644
> +--- a/policy/modules/system/modutils.te
> ++++ b/policy/modules/system/modutils.te
> +@@ -33,7 +33,7 @@ ifdef(`init_systemd',`
> + # insmod local policy
> + #
> +
> +-allow kmod_t self:capability { dac_override dac_read_search net_raw sys_nice sys_tty_config };
> ++allow kmod_t self:capability { dac_override dac_read_search net_raw net_admin sys_nice sys_tty_config };
> + allow kmod_t self:process { execmem sigchld sigkill signal signull sigstop };
> + # for the radeon/amdgpu modules
> + dontaudit kmod_t self:capability sys_admin;
> +--
> +2.43.0
> +
> diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
> index 2e1a929..3bd43cb 100644
> --- a/recipes-security/refpolicy/refpolicy_common.inc
> +++ b/recipes-security/refpolicy/refpolicy_common.inc
> @@ -74,7 +74,8 @@ SRC_URI += " \
>           file://0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
>           file://0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
>           file://0058-policy-modules-system-logging-make-syslogd_runtime_t.patch \
> -        "
> +        file://0060-kmod-add-net_admin-capability-to-kmod_t.patch \
> +       "
>   
>   S = "${UNPACKDIR}/refpolicy"
>   

