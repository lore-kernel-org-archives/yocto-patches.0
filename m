Return-Path: <mingli.yu@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E2BC04FFE
	for <webhook@archiver.kernel.org>; Thu,  9 May 2024 02:14:27 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.682.1715220865784214600
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 May 2024 19:14:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5859e85daf=mingli.yu@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4491ps24007974
	for <yocto-patches@lists.yoctoproject.org>; Wed, 8 May 2024 19:14:25 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xyse19cft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 19:14:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXuGn3icfMdoheizOXsdG3ooGlmx42hcpQrywS+addLikIF25o2ZESRw/PZDIJF7kO72FFPAu4gSDsPnlNRHqSoGkE1Mayx6o1I0Gqb0a1SLQTHFw7fzAJsUy+sN1vHYn1iy1JcOl1N6KQJdlFHaUYBDa7C9dKB2uyEH+wVUtNUzdLoiEkVBSObdcEOqPEhTpNG3kdyJePgqXdF/HkZYqmtSioNM9ml+MjeKe3C3yWClU8fl4xNQFlQ81h0P51KDlFArtOYf8b/yaprfT5nIP8Xb0WsZxIQO+YHWiD642Tr1BUOBGdGJHR1aDaPgmbS4OdXu9NK4NKu1g++0r1ugIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwd0gZQRB9Y1995NYGDtK9NKovuTsFgm/uovZQr80fA=;
 b=by7WdGZ3P+Qo8OAXkfAATMmkgRmLipAUBkb8MlBbf9VpG4tQ4rtUnuxaQatiOXXN3vwhR4BQ3Or2kdY9f5HcE+46dhodNwAyN0jUcib03EE6UbrGFH2PkYDcmQvcoiGN6Sy5TjVf4uXjThD179H7r/sR1k/HfxdbdkchNbMS2hOfajFDkNN52TCoigpqJ3Q4Q3fqK3bVtUsPXAyqdzPjZy0iVcrv+wGLHLl9hQos/0PTGhG9KfKORaCIbdcxRijgMYGEGJaeCZLSsbbHnlJpiGGjHH9N/PqPGJ8PawgaDdrOBVj/IYfP5uA6W7xkIimo5Q0zdyX84wQpQKUDPM+ifA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB5009.namprd11.prod.outlook.com (2603:10b6:303:9e::11)
 by CY8PR11MB6964.namprd11.prod.outlook.com (2603:10b6:930:57::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 02:14:22 +0000
Received: from CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::b792:3207:f838:98a1]) by CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::b792:3207:f838:98a1%4]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 02:14:22 +0000
Message-ID: <7aedf47d-3c8b-4627-b533-3cff6ceacc77@windriver.com>
Date: Thu, 9 May 2024 10:14:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [yocto-kernel-cache][PATCH] preempt-rt: add bfp
 configs by default
To: yocto-patches@lists.yoctoproject.org, Kevin Hao
 <kexin.hao@windriver.com>,
        "He, Zhe" <zhe.he@windriver.com>
References: <20240508070412.2939015-1-mingli.yu@windriver.com>
 <Zju3bQe0KEoRZcpH@gmail.com>
Content-Language: en-US
From: "Yu, Mingli" <mingli.yu@windriver.com>
In-Reply-To: <Zju3bQe0KEoRZcpH@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0208.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::18) To CO1PR11MB5009.namprd11.prod.outlook.com
 (2603:10b6:303:9e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5009:EE_|CY8PR11MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: b81c4065-c1ab-4568-6357-08dc6fcdbd95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bWtmVmkwQVFCc2tqSkFDSjBBNkJBQkZlMVRlY0s1SDM0NTFsWkhZYnFodlA2?=
 =?utf-8?B?enJFOEo5S24xMHVkQW92dEV2UENTR3hVYkNGQ0wwMUN1ZERpaTNmUlBkUmhm?=
 =?utf-8?B?T2c1NndrRDVlYS81K2UvTjl5MVkrZjJPam4xSU1iQUM3M0xWR3B2WTg2MEhU?=
 =?utf-8?B?WHZOQlYrY01IR09hVmhqV3B5K1hwbzMyNTVLMUt6R1ExQlZFZm1RNDFpMytD?=
 =?utf-8?B?b1FkbC83SnJGbUptcWR0K0RnMm9Ua0FRU0xRR0txWm5UT1VBSTdOY2YybUlx?=
 =?utf-8?B?N0dTaEY2eEZ5Q3FxNERRbDJtQ1dHWGtSVjUxTEd1TVA0bXQ5NTNCVGJFNng1?=
 =?utf-8?B?b09pMytRdkVZR0lGK3pnSjhOY3VpTnhOS1kraUZJZ3lnOTVLNmtYRWVUcWls?=
 =?utf-8?B?NCtlZERYNUZWVTBKZmRQNTBOYzJPR0xmTnA5YUxuZEhZdTRsdGdvcUhKbWpr?=
 =?utf-8?B?bm1leHNLQnNnazZlR3pxaHVTN0Z4YTl1bVNYN3d5Zll2RlNZRGg2SHRwNndn?=
 =?utf-8?B?WHFXSGVZZkhyS29yVUVyMnkrVXFCcHhXUVhnOE9ub1Z1UUtxak1vMnFvbmdi?=
 =?utf-8?B?RlFJUHhnUm1RV0d1Nlg1WjVNdEZObE1xMHQ3TndtSUFUQUN1TERZL2tJOStG?=
 =?utf-8?B?UkZQc2tYZDBOSFVZWVg2ZHlmb2tYYm9Fd2hLdFpOODhTblViMnU0QTEwbzhU?=
 =?utf-8?B?UnBFLzdCQktBaVFkYWJTWS9QUjJmWFEwdURYVVEzYzQzRWM2MkF0eExCaFV3?=
 =?utf-8?B?QmtQK29ESU5CUmpCR1ZsUy9meW5EZ0twODFSNk5QOXRDaEZENkwycEExcm1x?=
 =?utf-8?B?YWQ2VkdYb1c2ZDFQSjIzeGtLOFV5ZlhFMGhTQ1A4VUhDbjkzRnZSN3dmNEUw?=
 =?utf-8?B?b3RxaUl1WW11VFhybnEwNi84S0hEM2xXUWgzNGNvUkYzaUliRkRWWXNLcThh?=
 =?utf-8?B?M1dPb01sdWdEc2VYcC9HWDRaTzZpL3kvWTBRcTNJQlVCWHgrUU5STlhVbVI3?=
 =?utf-8?B?dmdrVkEyMDFYaS8zLzNkY3M3NEdqTCtQRGZPWEtpMngzenNHZm5CMElPc0V5?=
 =?utf-8?B?RFcwUWU2MmpqREp1OVFTejhCa0xEaGhFQmkyTVpBRGhGbkZwc2FMd2VCZW5P?=
 =?utf-8?B?aXhRT1JkS1VCbXdLODhHNnhxYzg2R2I4cytDVW5XamtKWDNyUS9QbDk0aHl5?=
 =?utf-8?B?Mm8zTFNsQmx1N0ZFbmVNL2U5Nm1rK29vQTRyYy9EVlh5cmdxSmZLeXdQZ0xv?=
 =?utf-8?B?RDFyM3ExelpjQVhTT0xDakZGb0ZKbm5oWTBvc0swQVd0SW5RSVhMZDUwWXpY?=
 =?utf-8?B?NzFqY2RRMkIybUhKTEhZLzdOa08vQnhUMGVwNDBZWGxnTkMvWHRBbWxQQTB3?=
 =?utf-8?B?NEpWeHJwYmQyOEZMaVlxd2pzdGovK29pWHhUTExpNFVqTHRhQzIvcmh1TlJR?=
 =?utf-8?B?R0Z0dVU2cndMQ1NoRG5aSlIrdHF2eHlIZWhQdFVJeTVLWlNxWWFBQ3dDenZ3?=
 =?utf-8?B?NDR1QjJzYmRYQTRCSW9NL1R2a0dJeEJSc01SNTNpUDVud2tSUHdmZk9NTDhV?=
 =?utf-8?B?RXA4YTZEWEdZUk1tZi9abDdLYWZ0RE5pRXRCaFd1R0IrTzNRQlZWNHlCQ3Vy?=
 =?utf-8?B?Z2pKdElmcXdNNG9KUkRMZ2x4TEYxM3c9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5009.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RWlseGdXUm9PK0dtUTBsUjFzbDlzNkwrMlZtNXAwMGUrNWhrU093RHRvUzcr?=
 =?utf-8?B?K2daOTdOWUxiUlo2enkyZDVPMHB2ZFRSQ3RlTXIyU3NBZk9yekZhRFhBY0xy?=
 =?utf-8?B?UzNrQmlncmdRaVBDRnF5TVVDQmRMK2JqZGt3Sk44SG5jTjNZemVxeTlQd3JZ?=
 =?utf-8?B?NXhuWnREM0t5MGpQamRiSklndEY3OHlYRWxzNEFQeFFOTVNNQ05ZckUzWWtn?=
 =?utf-8?B?Nk5UTS9pNG05YVVaV2d4YmVMUDZIbCt5ZmZibXIwWTNNS0ZaLzY5bDNnZjlG?=
 =?utf-8?B?SURsTG9LdGg1Z3AxN2RaelBjdlJvWkxoWUZUeFRrUUltOTlqNGRtUjdDTEdX?=
 =?utf-8?B?TGJ1SmdCazhDWHR1aGNZeUg3Yi8rdEhZTzlRZlhycExXYkp6TFFZdnlETEpG?=
 =?utf-8?B?OXcybmQ2UndwZEZoTVNSNjgreTYvdElrMU1LSSt3eGdJNnRORURDYkhDU0N2?=
 =?utf-8?B?cjRZVnRLalU3QWlIQW1YOS92L2orV1hQNUJNSUxBNjFjb2YreWJWbVlSYy9k?=
 =?utf-8?B?OWl4NThlb1dmMmN5MkpYTGd4c0lQQ2FRdzFkZ3lLc0dRSzZJdHZMRWRRck9l?=
 =?utf-8?B?Ukc3RVQrUmVFSlA5ODBJbXFEMzVISExoRHBONUFVTkU1REFxY0FvWVhWTExW?=
 =?utf-8?B?ZFhkdEo1QWlvbUkvK2t3aURVcGVZb0NScHhsS092Ymd2blJWU0Q0V0h6Z0d5?=
 =?utf-8?B?QStSdHZoUUpPRmpRTml2QXoxaVMzZ2g2RU9uMzA3NGprT2JhVEdzOWtsdStl?=
 =?utf-8?B?V1NCelowdFB3RnVhV0ExOHRuZFhKRzk2bTlHeFFockc0YkRHbEtCMW1iSmJn?=
 =?utf-8?B?VkpNMUJpR0huY1UvOVNLVHRPOHhTVzR3cjhxTDFQY0hFSVB5S1JyYi8vU3JJ?=
 =?utf-8?B?ODFXR2lMNkFnbVMxVUVLY0RDdFJ5UzRUREZFRS9abUg3WDFpcjEvSWM5T0JI?=
 =?utf-8?B?TVhKTmdpMWVnUjRtR1h0bWtqakRlTmF6cnRyTGpQS0NmenhDVGtlUFZSakht?=
 =?utf-8?B?WnRZb2ZZeXhQS0VwUTl6MEN3ZFMzR0NVdForMS9SeHUwQXZxQWw3d0VXV0R0?=
 =?utf-8?B?MVora2hFY2R2QlAvOHhWVGdwWThwczhMOVpOMGN0VUdqUGJMVE43RW5YTGQ4?=
 =?utf-8?B?M3JhQkFqOU9MSWYwcjRqYXJHK0Q1VHJYNzFlRG9jYVQyMTVFd05GYm9LY2M2?=
 =?utf-8?B?ZmRDM0htNUhwcTduYVFlOU03MVNmUExWV0tidmZwVFM3bGU1bHQwWVpicGtE?=
 =?utf-8?B?QmRjbzRoV2ZsNnY0ak5ab1dyc2Ewd1dwVjNEQ3VUaWNJU1JOVUt1K3lOQUZ4?=
 =?utf-8?B?d1lkKzI0RDBqUVRyU1VOUFQ4d3c0Wko2ZFB0Uk1HR3BoMTltd3RsUHpwV2w1?=
 =?utf-8?B?M0h5YUdHaEg0bURJOE9Wb2hHMkZBOXdIQk1hb3I4UGc1RlJFVGJMUEVRMVc3?=
 =?utf-8?B?Y2dwUCtSaFp5UUNWYmJIc3lTRkROT0RpL3JVSUhZYUNuNUdyQ3FBUlFsN2k1?=
 =?utf-8?B?V1RxRmg5b01PMWdSNUtvOHpEdTRraGNFMHlhZm01aWJ1ZTBQRjk3NzVyRStx?=
 =?utf-8?B?eHJkSGs5SmtSS1N5Yk95Njc2bmdXaVNybGlTSnk4eTRLamRYQ3RtNWpTWUxq?=
 =?utf-8?B?dHlFKzBrY2VNSExvWTdpQWd6WDNtcktBK1NnazhWWnpLOFd5S1E2MFA1QUJk?=
 =?utf-8?B?TFVhUUhWeTVNcTdOaDRIWjQ1MVF0d2ZWZ1Bsb3NvQW1xdzZwVWRjNXhvOEVH?=
 =?utf-8?B?dTdtaCt5ZjhCa3g3TTV5Tm1LNVpkN1FVZE1aNWp4N2M4Q0VxSXZhOURFdnBp?=
 =?utf-8?B?VjI3eEo3aHlzTUJ3aEVYSkkzdk5FUkpZazJNalJRTTlvR2V5OFFwNUIzSTg0?=
 =?utf-8?B?TXdBSmI4c20yWnNIZjlSaktsZGc3cVA2cGxiSm91U2w2Ui8wZSs3VjNJN0Rv?=
 =?utf-8?B?T1ZpeHNVcHZUVlNIbHF0N3dqK0dmTmxKYUFDMEFMNW4yTmo2Z1owOWcxTGRR?=
 =?utf-8?B?aTZkdmp3cktIWUlObC8xQWlMZUE2MllFMVMxS25HRGhyQ25JeFhwNEhTR2JC?=
 =?utf-8?B?aGNjSDNWYmdzVVR1akxubFk3N09tUEhJQ1NXLzMwLzA3UGlrTkhRTDhnRE9L?=
 =?utf-8?B?U2paV0ZwVzdBRFNaZjNueTNIeWpPZHoxemZack1LU0RwaFNmeXMrbFNXSFNa?=
 =?utf-8?B?MUE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81c4065-c1ab-4568-6357-08dc6fcdbd95
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 02:14:22.1499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QByuGA2IOufPW/TKg6S9/9i5L0Tivg0NI1SdcKzSbXP/UniGYVLs01dJFX+IRyZT51MNBpf7gyqgLWygpQ2x+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6964
X-Proofpoint-GUID: Vi1H6G1Idq8U7RBiTj6M6M54HawuWv9i
X-Proofpoint-ORIG-GUID: Vi1H6G1Idq8U7RBiTj6M6M54HawuWv9i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_10,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405090014
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 May 2024 02:14:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/106



On 5/9/24 01:33, Bruce Ashfield wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> In message: [yocto-patches] [yocto-kernel-cache][PATCH] preempt-rt: add bfp configs by default
> on 08/05/2024 Yu, Mingli via lists.yoctoproject.org wrote:
> 
>> From: Mingli Yu <mingli.yu@windriver.com>
>>
>> Userspace functionality that requires BPF is becoming more common,
>> so enable it by default [1].
> 
> bpf used to have locking issues with preempt-rt, which is
> why it isn't already enabled.
> 
> Can you show some logs for your testing that has happened
> with BPF enabled -rt so that we can document what has been
> done to prove it works now.

When CONFIG_BPF_SYSCALL is't enabled, there comes below failure with rt 
kernel.
  # docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
c1ec31eb5944: Already exists
Digest: 
sha256:a26bff933ddc26d5cdf7faa98b4ae1e3ec20c4985e6f87ac0973052224d24302
Status: Downloaded newer image for hello-world:latest
docker: Error response from daemon: failed to create task for container: 
failed to create shim task: OCI runtime create failed: runc create 
failed: unable to start container process: error during container init: 
error setting cgroup config for procHooks process: 
bpf_prog_query(BPF_CGROUP_DEVICE) failed: function not implemented: unknown.
ERRO[0059] error waiting for container: context canceled

And the above issue is resolved once CONFIG_BPF_SYSCALL enabled.

Thanks,

> 
> Bruce
> 
>>
>> [1] https://lore.kernel.org/all/20200224140131.461979697@linutronix.de/
>>
>> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
>> ---
>>   ktypes/preempt-rt/preempt-rt.scc | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/ktypes/preempt-rt/preempt-rt.scc b/ktypes/preempt-rt/preempt-rt.scc
>> index 7ff7c0a8..a5e345f9 100644
>> --- a/ktypes/preempt-rt/preempt-rt.scc
>> +++ b/ktypes/preempt-rt/preempt-rt.scc
>> @@ -39,3 +39,4 @@ include backports/backports.scc
>>   include features/rt/rt.scc
>>
>>   kconf non-hardware preempt-rt.cfg
>> +include features/bpf/bpf.scc
>> --
>> 2.25.1
>>
>>
>>
>>
>>
>>
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#104): https://lists.yoctoproject.org/g/yocto-patches/message/104
> Mute This Topic: https://lists.yoctoproject.org/mt/105976633/3618448
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13176015/3618448/1484545583/xyzzy [mingli.yu@eng.windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

