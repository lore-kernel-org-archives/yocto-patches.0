Return-Path: <hongxu.jia@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826DAC36010
	for <webhook@archiver.kernel.org>; Wed, 26 Mar 2025 08:14:07 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.17250.1742976844317662872
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Mar 2025 01:14:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=518022dfad=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q5ncFb005020;
	Wed, 26 Mar 2025 08:14:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hje1mfhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 08:14:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnkGOT6ijrGT06VC8wgPNFJItyo9DriXO4lE65D/Ih6KUoaO5Hs8CAEw7sekkeYSmJ468QTss+cBDtcDHHL9M5Su+f59iyjpQxO7hohoQuRzErNScRHTaKjzCxNbasBRrD+zqd+6+RDrs/dJO6b1jpiMmLdVBRyAziauLGND9QsOUNtHx0YVASUnD/Nb67eTF8uWfDif8KJqknEG6jDojgJfvG7aQ0zUULDT4nQwU8jjQ7Vd5f63NRQTCR0886eJrny3oqaNKvuPi9tJhU+kBTwZSHefYbMOxTDSip7ActoasOnv3q8XNwJnZXen5NG4fwrJzMaKs6daPf3rAl48BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4x7RR8TUTqCXtD11pk5WXaqkAnQF8yLufjIRbbfNdRM=;
 b=mkRUVmJKddX4Lk/wWdF9IPpIsTZJO92ar2XYgBWN3iydQ9DIl7bEofoNHnq9OF2bA1hOlZacpI8P8GHfxjHbGPWOW9B1/EQkvceEVLCouhHn8HJ0uwe3xPamciQpC8U6Imf9dJ92BgmwUHD6ZOYcfzVs5b8kranDeNvG/vimgKM4qP9XM7REYqQNWU6wnAfTSV2DDD5nB0fjPC4RTN39EghqQWtVymCwNu42uVQv69MUjnE2fqhnjfaImvJWm6x7zqXH6nMLwWx88TUjDlbLfXklb5U1/DEiJHdHmqJ7aG1c5mR6HG18LMxyF4l44lM+OMtIKfONgXpg1HTDeNCwGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 08:13:59 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e%6]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 08:13:58 +0000
Message-ID: <f14e1921-2dd7-4e0b-a078-1f331147bdf0@windriver.com>
Date: Wed, 26 Mar 2025 16:13:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-tensorflow][scarthgap][PATCH]
 tensorflow.inc: add write permission to 2 more directories
To: Martin Jansa <martin.jansa@gmail.com>
Cc: "yocto-patches@lists.yoctoproject.org"
 <yocto-patches@lists.yoctoproject.org>
References: <20250307075610.2235124-1-martin.jansa@gmail.com>
 <182A7B773A5ECF09.13616@lists.yoctoproject.org>
 <CA+chaQetojj=EwWEA2B+jmL3kk8Ap0FAPv4N0n2NLY-VQ-FRCQ@mail.gmail.com>
 <PH7PR11MB7608B1BFFCA15F5A02EE4FA394A42@PH7PR11MB7608.namprd11.prod.outlook.com>
 <CA+chaQcs6ut65AGwi5_oWpGe-zNpE0tJCH2HRPOT_AXz1TUQ7Q@mail.gmail.com>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <CA+chaQcs6ut65AGwi5_oWpGe-zNpE0tJCH2HRPOT_AXz1TUQ7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SG2PR01CA0122.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::26) To PH7PR11MB7608.namprd11.prod.outlook.com
 (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|CYYPR11MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2038cd-243d-4f0e-0336-08dd6c3e28d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|4022899009|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZTR0TGg1ZUFpNHdPbUtFanpLUExUWmdvMzJwRFFPS0pqbE1uYnc3a0FFNWIy?=
 =?utf-8?B?MDZGRTVVK2U2ZTlsNDBHdis4VFVTamR6QWRtY3A1NEE3VGVhSi9Md3FHaUkv?=
 =?utf-8?B?UzZZbURuVUcrdkNzSkFJQ1FrWmsxL09IYnhJUXowckhIOWtDM0xYdEJ5Q25Y?=
 =?utf-8?B?cFB2c0tMN0VkK0VXK2dhdjFWRllkSWZFay9RUlRINDBremY0THE3QXJCL2FK?=
 =?utf-8?B?SW54S2NQRFpwV3BQTkltUEgwWWlLanJUMW5OcGVUTWMrQzF3U2doeVdTa2xM?=
 =?utf-8?B?WjNBamJFa2thUUN6UDEybEI5cVFiSHhXYTVhODBmMTRJenE2MXFZV2tRdVZ2?=
 =?utf-8?B?a1daL0VpUTRBeGZ6bitwRXp2WG9Qckl0YnBub2xxTDliY3dMclFod0JyaDIr?=
 =?utf-8?B?RFpRQ05QVkF0SHhsVEgwalR1YzV3Q3JxWE8yOWp0UzBGc3k1akhndzFsRlh4?=
 =?utf-8?B?cFlqV2k3Uk1iSGNzSFpiMGIvWjE0OThTSk5laFdqcVZIZ2JqM3dXb2htQnhZ?=
 =?utf-8?B?ZlJwbVV3YmN0V1NIVXl6VVdQNG94SWppRDdpYVR4VUd4eHp0UDBWcDA4eUFC?=
 =?utf-8?B?VytkTHNJVXQyOFE5dkNocWpUSnBwOTdBSEVlU1BSZzZhZkp3L1VjRjNmZWM5?=
 =?utf-8?B?V25TNEdIR0xkbUhjZFJ1eThKZ2x4ZTMwSzJUQ2E2dnBhYkZSOGtVL2JqWFo3?=
 =?utf-8?B?VWZ6ZU9GQTk4VFVYYzJQejFsRlZtc3dXSTh5M3NXd3ZJZDlhZnM0TU1JUnBt?=
 =?utf-8?B?dTdTOHVpL0RjTzNubVhoNVFOaHI5R3EraVh1WSs0ckt3TElGYjFKVlJpeEJm?=
 =?utf-8?B?V01NaGZWcUdUOXprRFdBeURtZXVuL3RKMXZsMW5jYVRXQzZZNitSSDVoVzVh?=
 =?utf-8?B?RVpmQ0tDOHpjM1I2VkFMcklVRmlPKzVlcTE2Ni9ySi8zTkQ4WDdWSjAyRVFE?=
 =?utf-8?B?ZTB5cy9HOE0xU2tBMDlyMzQ3c1kxNENPRm5hWTduWEpZeXpKdHVVOS9GclIz?=
 =?utf-8?B?VlJYVHcwakNzem95NDRJOHZkQmV6V1NKTjVTN1k2cTVvNkFXUHhpMDBhUXJw?=
 =?utf-8?B?MmkrbmtaRGg1dHQ4ckMwbDBVeE9qMWRpcFB0QUFaaEhBUWlhS1g5U0hyOWx6?=
 =?utf-8?B?ZlcvcWU2UDB2QndUZ3FzQXV3bENvTUt1V09aSEFkTkkzdXFhQ3dkQ2kvNGtp?=
 =?utf-8?B?dWNWNG5qbjlqbGY4L3BoaS94WVNKbzU4WHk4eHBza2VSTGo0SnZKbkhqWklT?=
 =?utf-8?B?NGU4b2lBSDZweURuZ28xUUk2aldMZk9XNEdscEJpT0RhT094aGs3TDRDZkpP?=
 =?utf-8?B?M1JiRzBsL1dmazlmQ2ZjcjFVZDBVeGwwaUhRcHkzMjBCdUpDc1Nwd1BKNkhy?=
 =?utf-8?B?R1BXMTNNelBScnNjeXlRTndDQlZSSU5aelNGdjZ3OVp3SkhYNkNSVVhkUXpr?=
 =?utf-8?B?QzhDQVF5YkZiWVZjNHJVVUNVc29OeGJaUlgrd21hUGI4L3pjSjdqQlNEUC8y?=
 =?utf-8?B?NC9WYUJRMlhTWlFITVVFMDV3Q1RMbkVsT0VEZmZ0TCtscWhtOEVaejR1REVr?=
 =?utf-8?B?aEdCbXg2TzlKV0VJS3lNTUZGN0FrWVBRZjRLRnJVVVRtSkV5MnoyNThUcG5Z?=
 =?utf-8?B?WXEyZ1VGTVpkVUZBalRhRTEvOVpEUUVCZWZ6SHJRVmhzWlJ6QkYwcFhUN1FH?=
 =?utf-8?B?Wm5idXh0UmRLd0NFTVp4Smt4YTUvczZjV2lTMFZ5YjlONEh5ci9EdmJybGNW?=
 =?utf-8?B?bk9ra1hYcXdBUjE0KzRJMnBPSFhRbFV5dmhNVlkrN0tDbTJlU0xlbG1SaUNm?=
 =?utf-8?B?ZEl5bjNJcFgzcUdLYXh5dz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4022899009)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZmlOajBaZE15elEwekF0bEZlcW5JN1pPdmxsNzVvS0tza3BmV2tqOUUrTGha?=
 =?utf-8?B?T0pUMUNsY2YwQmF5eWdaU2RBUlBaQ0dTOHNmaUVPNklmQzEyS3FUNHVTVG5h?=
 =?utf-8?B?V3UzVkdXME9iZXlRNDdwRkZRRHhBUG9KbFBFWWVUVUk1T3RZdEpBaHhycFNW?=
 =?utf-8?B?eGxUTE80N3EybVhuRzRRVjlnMm5zaDJQSmlYS1JlTlY4UlhtOHNNTjh0QVNT?=
 =?utf-8?B?aUozK0IvU2s5eDNSS1laL2lGRmloZmc3WXZhQmV2N1J5R2NERTBtbDlGU0Qw?=
 =?utf-8?B?TFZLeEFaNnQzc0R0cTc2OW1yVmxLSHVicE43bkJUS2R6eGUvU2dIZ1ZWZEE0?=
 =?utf-8?B?Rk9QWXZaSm8rMGJCTkZraUEveXNyazhWMnF4eGNHUHB1djcrK0VWbWZxOW1a?=
 =?utf-8?B?V1A1MDJtODVVaE9hUEFVVjdVWERKUWw1dG83U1lkdW5LeXovSjZYQ0RPTUFt?=
 =?utf-8?B?dnVwZG1EK0lWcnlPbnFyRDQvblY4amNlamJhdXFMUlBGVDlpM0FCSzMxeEZL?=
 =?utf-8?B?S0lrbGdHcTdBejdHZm50QjNHMWtWWW4rTGdsVjVtakJmSnFCcFJ3SVRId29B?=
 =?utf-8?B?RDNzUEsyRktrOHE0VmQ1NnVpc1pBekFyZHFSaHNQcWpjVWxCNHRlZGorcm5q?=
 =?utf-8?B?Mk5mSU5kZU1GMU9zYlI4ZW1NbVpLRnJ0alJaM1BSdXp2c0ltNjhFd1Q0Zk5O?=
 =?utf-8?B?enFiSjlLL1V2RXpJOHVVVlFpQWlmdjF6dDNyOHNESFVtS09vYzk2VGtNbUF1?=
 =?utf-8?B?ZEd3ME1sZVl1WXgxK3dZa1QzeDBGSVQyZmx3Qmt3bVZvVjI2WW5tWlVWNnFQ?=
 =?utf-8?B?cjZKM3lnajd6NXdET3V4bFZZSDhZUjVkemhOZDNDbU9Sa3Y3RnU3Y2V0bjdq?=
 =?utf-8?B?c0NFK0ZqZFNJb0srMFVIYlpBY3dmTWQ3TkJiR3l5bTgzSWIyUlI0N01PRDcy?=
 =?utf-8?B?Nk5pdXQwc0FobXI5dUZxS3RaUWdEc1h2UHBIdkRYNk9FWnYyaUpVSnRsSkpW?=
 =?utf-8?B?M2dYU084dUQ4Q2FpYnJJdndvbjREb0hIZFE1emR4MVBWcnRSUkloN2lxenpv?=
 =?utf-8?B?L2F3TmVodkdsc1RtUERiMWw2NkViU3c0Y0ZNRElMV1BwdzRGVFp4NHQvZm0v?=
 =?utf-8?B?U3ZOdDdUdWp6cHRrMmc1eGVxMks5d3dvL1JWS2RVY2R0cGpqY2MzMzZkVFpt?=
 =?utf-8?B?UHRNWUVRZmRLa3pmK1dHUjBRaDZiWGQvZ0QxM2Fld1BxMXEyY054S0NzUm54?=
 =?utf-8?B?TWNFVjZGNEp4U3FyZllsZEhGTmEwVUljb21GNWM1bzhaY3BZVnhVYTJubGda?=
 =?utf-8?B?QXZrU1BHTktud1JkbkJUeURidmJZY2JBZG92Nk5GVENwS0ZITTJlV2YxQ2pZ?=
 =?utf-8?B?cmJUR2xlQTkyckNaajlIcUtqRTU4TW5IK281d08zazdqYlZvSG9TYU9PVHRl?=
 =?utf-8?B?Y1l4SFNoaFd2SEQxU3o0cTZNMU9ibTRGeDUvalVRNmhjSGhVR08rZS9LVlhR?=
 =?utf-8?B?MGo3UnFaTXo1ZHdFUUxJQVdrWFpzZUNoRVhUdERGUDEyYytCUUtrUERMeDRS?=
 =?utf-8?B?N0hwdS9rL1VtbUQ4dUdyRXFwdVdHQVhmMUJZc2NGdDNvRTUrdWplcUo4eEox?=
 =?utf-8?B?dzd0OG5aUmtnVWNFdVJSUC81U0k3YWNUWEY4bUQ4TENIeDJPS1ljejVVc1hY?=
 =?utf-8?B?aTR1ZVd2Vmt6cmdLYVZxc1l1MCtQSCtjeUxTMllSVlhIL3dKbUVzWXVSbk9k?=
 =?utf-8?B?dDQ4OHMvZEd5SDRiQ0pncXdzZnM2eGFmVkJvSjdENWxxRUwxOENnQ2RIRVRq?=
 =?utf-8?B?eXZHblpQUVd0c01JMmx1RVFieHdpbEpuc01WRDZ0d2IxdGdRTzd2bjRVTnlo?=
 =?utf-8?B?OFNaa0ZheEMvdGNPbW45d0lVczREcEE2RW5hMitzL0wzd3RBUXdiOHoxelBB?=
 =?utf-8?B?ZkErdUNpVlg3dUs4MURYN2t3MnlRWHpPNFZZUU5LZWMwRnJLM05ZZ3pWMHh5?=
 =?utf-8?B?SUdXeVcwWmF6RWJVZ3ZIS09aaGhWc1A3a3hURDZCbGcxL0VwbWJBVHNBTFNB?=
 =?utf-8?B?TE1ZMkVvc2R0TTArTHB2VWtFOXpPOXdCWTZGckM1b1BjekFhbWtQNWdmcDBQ?=
 =?utf-8?B?OXBPcytVaFZ3NTFSZHpWVDBvVWo0T1VmUXk1dC9ZZVJHeElQQnBBQ1cxdkto?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2038cd-243d-4f0e-0336-08dd6c3e28d3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 08:13:58.8228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nF1T7+fp9Y8ppIUn4HcaVa/A5cNW0VqfKzKDcFH+sAEGHpPoE5J0ooekoI9jQv5cwXzovKSyZ4vOAf6mrQHy320FTdZ8VVXs/Gfepx87wdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8429
X-Authority-Analysis: v=2.4 cv=KPVaDEFo c=1 sm=1 tr=0 ts=67e3b74a cx=c_pps a=1OKfMEbEQU8cdntNuaz5dg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=NEAV23lmAAAA:8 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=pGLkceISAAAA:8 a=wYDQrIcDh-ke9ta52s8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: VNHh5KrNjAGTmPWp-d8Ah6TC_IFXoeVM
X-Proofpoint-ORIG-GUID: VNHh5KrNjAGTmPWp-d8Ah6TC_IFXoeVM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503260049
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 52Q5ncFb005020
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 08:14:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1252

On 3/25/25 22:07, Martin Jansa wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
>
> yes, that fixes the parsing.
>
> To build it with python-3.13 in walnascar you can backport
> https://github.com/tensorflow/tensorflow/pull/82768 , tensorflow-lite
> builds fine with it.
>
> To build with gcc-15 it needs
> https://github.com/abseil/abseil-cpp/commit/809e5de7b92950849289236a5a0=
9e9cb4f32c7b9
> applied in absl from third_party/absl/workspace.bzl

Done, update master and walnascar branch in meta-tensorflow[1] to=20
support python 3.13

[1] https://git.yoctoproject.org/meta-tensorflow/

//Hongxu

> Cheers,
>
> On Mon, Mar 24, 2025 at 3:37=E2=80=AFPM Jia, Hongxu <Hongxu.Jia@windriv=
er.com> wrote:
>> Sorry for the error, I've corrected for styhead branch,
>>
>> https://git.yoctoproject.org/meta-tensorflow/log/?h=3Dstyhead
>>
>> would you please retry it
>>
>> //Hongxu
>>
>> ________________________________
>> From: Martin Jansa <martin.jansa@gmail.com>
>> Sent: Monday, March 24, 2025 6:13 PM
>> To: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctopro=
ject.org>; Jia, Hongxu <Hongxu.Jia@windriver.com>
>> Subject: Re: [yocto-patches] [meta-tensorflow][scarthgap][PATCH] tenso=
rflow.inc: add write permission to 2 more directories
>>
>> CAUTION: This email comes from a non Wind River email account!
>> Do not click links or open attachments unless you recognize the sender=
 and know the content is safe.
>>
>> Hi Hongxu,
>>
>> I see you've created styhead branch, but the python3-numpy added in:
>> https://git.yoctoproject.org/meta-tensorflow/commit/?h=3Dstyhead&id=3D=
2565836457994a84776e0d02356ead3bbba093de
>> doesn't even parse with styhead because of:
>> meta-tensorflow/recipes-devtools/python/python3-numpy_2.1.3.bb:21:
>> Could not inherit file classes/cython.bbclass
>>
>> Please check that.
>>
>> Cheers,
>>
>> On Fri, Mar 7, 2025 at 10:32=E2=80=AFAM Martin Jansa via
>> lists.yoctoproject.org <martin.jansa=3Dgmail.com@lists.yoctoproject.or=
g>
>> wrote:
>>> Hi,
>>>
>>> thank you for merging both, the way how you're applying the changes
>>> from e-mail still mangles the author and commit message.
>>>
>>> I've tried to add explicit From: in the e-mail body in hope to avoid
>>> "via lists.yoctoproject.org
>>> <martin.jansa=3Dgmail.com@lists.yoctoproject.org>" but it didn't real=
ly
>>> help, instead the From: is still in the merged commit message togethe=
r
>>> with "CAUTION: .." message from your e-mail configuration.
>>>
>>> meta-tensorflow $ git show -1 --pretty=3Dfuller origin/scarthgap | he=
ad -n 14
>>> commit c382865206fe925a02a1cdbdd856e16310bc9dbc
>>> Author:     Martin Jansa via lists.yoctoproject.org
>>> <martin.jansa=3Dgmail.com@lists.yoctoproject.org>
>>> AuthorDate: Fri Mar 7 08:56:10 2025 +0100
>>> Commit:     Hongxu Jia <hongxu.jia@windriver.com>
>>> CommitDate: Fri Mar 7 16:16:58 2025 +0800
>>>
>>>      tensorflow.inc: add write permission to 2 more directories
>>>
>>>      CAUTION: This email comes from a non Wind River email account!
>>>      Do not click links or open attachments unless you recognize the
>>> sender and know the content is safe.
>>>
>>>      From: Martin Jansa <martin.jansa@gmail.com>
>>>
>>>      Missing write permission prevents the WORKDIR to be deleted, e.g.
>>> when recipe becomes unreachable
>>> ....
>>>
>>> On Fri, Mar 7, 2025 at 8:56=E2=80=AFAM <martin.jansa@gmail.com> wrote=
:
>>>> From: Martin Jansa <martin.jansa@gmail.com>
>>>>
>>>> Missing write permission prevents the WORKDIR to be deleted, e.g. wh=
en recipe becames unreachable
>>>>
>>>> Removing 41 recipes from the core2-64 sysroot: 100% |###############=
#########################################################################=
#########################################################################=
#########| Time: 0:00:21
>>>> Removing 35 recipes from the qemux86_64 sysroot: 100% |#############=
#########################################################################=
#########################################################################=
#########| Time: 0:00:00
>>>> ERROR: Execution of event handler 'sstate_eventhandler_reachablestam=
ps' failed                                                               =
                                                                         =
         | ETA:  0:00:07
>>>> Traceback (most recent call last):
>>>>    File "/OE/build/oe-core/openembedded-core/meta/classes-global/sst=
ate.bbclass", line 1293, in sstate_eventhandler_reachablestamps
>>>>      bb.utils.remove(workdir, recurse =3D True)
>>>>      ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>    File "/OE/build/oe-core/bitbake/lib/bb/utils.py", line 751, in re=
move
>>>>      subprocess.check_call(cmd + ['rm', '-rf'] + glob.glob(path))
>>>>      ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>    File "/usr/lib/python3.13/subprocess.py", line 421, in check_call
>>>>      raise CalledProcessError(retcode, cmd)
>>>> subprocess.CalledProcessError: Command '['rm', '-rf', '/OE/build/oe-=
core/tmp/work/x86_64-linux/tensorflow-native/2.17.0']' returned non-zero =
exit status 1.
>>>>
>>>> ERROR: Command execution failed: Traceback (most recent call last):
>>>>    File "/OE/build/oe-core/bitbake/lib/bb/command.py", line 123, in =
runAsyncCommand
>>>>      self.cooker.updateCache()
>>>>      ~~~~~~~~~~~~~~~~~~~~~~~^^
>>>>    File "/OE/build/oe-core/bitbake/lib/bb/cooker.py", line 1646, in =
updateCache
>>>>      bb.event.fire(event, self.databuilder.mcdata[mc])
>>>>      ~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>    File "/OE/build/oe-core/bitbake/lib/bb/event.py", line 224, in fi=
re
>>>>      fire_class_handlers(event, d)
>>>>      ~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
>>>>    File "/OE/build/oe-core/bitbake/lib/bb/event.py", line 131, in fi=
re_class_handlers
>>>>      execute_handler(name, handler, event, d)
>>>>      ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>    File "/OE/build/oe-core/bitbake/lib/bb/event.py", line 102, in ex=
ecute_handler
>>>>      ret =3D handler(event, d)
>>>>    File "/OE/build/oe-core/openembedded-core/meta/classes-global/sst=
ate.bbclass", line 1293, in sstate_eventhandler_reachablestamps
>>>>      bb.utils.remove(workdir, recurse =3D True)
>>>>      ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>    File "/OE/build/oe-core/bitbake/lib/bb/utils.py", line 751, in re=
move
>>>>      subprocess.check_call(cmd + ['rm', '-rf'] + glob.glob(path))
>>>>      ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>    File "/usr/lib/python3.13/subprocess.py", line 421, in check_call
>>>>      raise CalledProcessError(retcode, cmd)
>>>> subprocess.CalledProcessError: Command '['rm', '-rf', '/OE/build/oe-=
core/tmp/work/x86_64-linux/tensorflow-native/2.17.0']' returned non-zero =
exit status 1.
>>>>
>>>> Summary: There were 2 ERROR messages, returning a non-zero exit code.
>>>>
>>>> OE qemux86-64@ /OE/build/oe-core $ find /OE/build/oe-core/tmp/work/x=
86_64-linux/tensorflow-native/2.17.0/
>>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/
>>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baz=
el
>>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baz=
el/output_base
>>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baz=
el/output_base/execroot
>>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baz=
el/output_base/execroot/org_tensorflow
>>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baz=
el/output_base/execroot/org_tensorflow/bazel-out
>>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baz=
el/output_base/execroot/org_tensorflow/bazel-out/k8-opt
>>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baz=
el/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin
>>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baz=
el/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow
>>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baz=
el/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/li=
te
>>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baz=
el/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/li=
te/python
>>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baz=
el/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/li=
te/python/schema_py_srcs_no_include_all
>>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baz=
el/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/li=
te/python/schema_py_srcs_no_include_all/schema_generated.py
>>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baz=
el/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/li=
te/python/schema_py_srcs_no_include_all/__init__.py
>>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baz=
el/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/to=
ols
>>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baz=
el/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/to=
ols/pip_package
>>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baz=
el/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/to=
ols/pip_package/wheel_house
>>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baz=
el/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/to=
ols/pip_package/wheel_house/tensorflow-2.17.0-cp312-cp312-linux_x86_64.wh=
l
>>>>
>>>> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
>>>> ---
>>>>   recipes-framework/tensorflow/tensorflow.inc | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/recipes-framework/tensorflow/tensorflow.inc b/recipes-f=
ramework/tensorflow/tensorflow.inc
>>>> index e48808c..83e2d1a 100644
>>>> --- a/recipes-framework/tensorflow/tensorflow.inc
>>>> +++ b/recipes-framework/tensorflow/tensorflow.inc
>>>> @@ -61,6 +61,9 @@ export TS_DL_DIR
>>>>
>>>>   do_compile[network] =3D "1"
>>>>
>>>> +# Missing write permission prevents the WORKDIR to be deleted, e.g.=
 when recipe becames unreachable
>>>>   do_compile:append() {
>>>>       chmod a+w ${BAZEL_DIR}/output_base/execroot/org_tensorflow/baz=
el-out/*/bin/tensorflow/lite/python/conversion_metadata_schema_py_srcs_no=
_include_all || true
>>>> +    chmod a+w ${BAZEL_DIR}/output_base/execroot/org_tensorflow/baze=
l-out/*/bin/tensorflow/lite/python/schema_py_srcs_no_include_all || true
>>>> +    chmod a+w ${BAZEL_DIR}/output_base/execroot/org_tensorflow/baze=
l-out/*/bin/tensorflow/tools/pip_package/wheel_house || true
>>>>   }
>>>
>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>> Links: You receive all messages sent to this group.
>>> View/Reply Online (#1164): https://lists.yoctoproject.org/g/yocto-pat=
ches/message/1164
>>> Mute This Topic: https://lists.yoctoproject.org/mt/111564223/3617156
>>> Group Owner: yocto-patches+owner@lists.yoctoproject.org
>>> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/133=
88836/3617156/66960823/xyzzy [martin.jansa@gmail.com]
>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>>
>>>


