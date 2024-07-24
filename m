Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901DDC3DA61
	for <webhook@archiver.kernel.org>; Wed, 24 Jul 2024 15:17:20 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.13126.1721834234887744695
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Jul 2024 08:17:14 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=793573a770=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OAK2MW001079;
	Wed, 24 Jul 2024 08:17:13 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40g8h03n2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 08:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFMD4xRibsHpLtDewgnYIfWkCPSqh6k3DJcnpnVY/dpSJrYFf8wyruepwgsbh8k2amU20QoTGq0BxnAbnYgZV6GTuvYC4W+VsdxEOCsMvGZMANL9jMJ+ooLnRRuKyeQ4NbLTn8wc1vpavJi7WVvrPJTjHXPWzfcQpAiQAmhZ0AMQI+nzfchSjRDPvqfcXuCvshYcH1bpf9IBXiGRzMvYmR4v/pHM61XRxvMxD+1zSTwnIs/pjz1wTQyNZpTlxU2fyjiASjXnFp3kybetucZILIbg+pqpAEp8vgZkj187EZen4NR8UzZFXHLOLO3iPPY9qtiSNvkkyxUGrLFrhQSjPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rB6lfWHSfNPsbb1nBl2xCflkyly/vOHHCEQRC1ODEkA=;
 b=XlWJwL3Jpct/j/3486YIc4y8tbsKCsRdAD6dml21ypiSQ98PpyfHWkmRzNYLEM2b87hGTu2sqvuHDvUV1zu7a6XeETZTIxgefJIfz/PQFgSWVoL+AS0NDIvzb5MXom2FlLVTwVN3XI0trwKTnJ4MBk+Mkbz/Cndo+XpJ3exsyQrVBY5F6OndytzzODpYloAQLiRVD24UX8gpFfrzpV6AWM8T0dG/cHMuaIK1TV58kyHpq1A1iCxboS2TQNrHNZMwz3gxeMBNlLOlqzjOh7rC9x5ByDrvSx2HXq0iZfcDKOGcMX/3kdc9N0GRhje/XZWBc6vBzjnBNq/C7nxAXoyg3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 IA1PR11MB8221.namprd11.prod.outlook.com (2603:10b6:208:451::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 15:17:07 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.7784.016; Wed, 24 Jul 2024
 15:17:03 +0000
Message-ID: <df0f4afd-77cc-4cb9-9b84-2f385be71527@windriver.com>
Date: Wed, 24 Jul 2024 23:16:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-selinux][PATCH] shadow: comment out pam_lastlog line in
 login pam file
To: Joe MacDonald <joe@deserted.net>
Cc: yocto-patches@lists.yoctoproject.org, joe.macdonald@siemens.com
References: <20240724141329.3326073-1-yi.zhao@windriver.com>
 <20240724145353.7yxqlbaetvims2tz@nightwinge.deserted.net>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <20240724145353.7yxqlbaetvims2tz@nightwinge.deserted.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::36) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|IA1PR11MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b2612b-cf89-4ddc-a1ca-08dcabf3a958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SHFKT1lOMmQyMWRIdWQzUkZLVnBIYVhZbEhXWG4yblNVM20zaHBLR1BtR2hY?=
 =?utf-8?B?aVNYWllvUlBvM1dDZEthRlVvMHVSVk54T3BERi9vMG92T2l4VllKNUpyYVM3?=
 =?utf-8?B?enZGTGdjZzZ6TitoNFA0K0MwNndhUjR2ZGF5bnlCQzkrSGV5M3hsYUc0dE1r?=
 =?utf-8?B?dERoSkxFZ0JuYUx0TnlMWHVYV2xHemllOTI3L1ZpWEFPUU9YWGcwTXp5cDJL?=
 =?utf-8?B?dHk2M0dUUEYvT0VKdStRWmR2RG5qZGx5MXcvK2gxM3QrcmJJelNwWUp5NEhp?=
 =?utf-8?B?Qmgzai9WbWQ0MTQ1YVIxZzl5S1VqTHQ4NHc2OHpCY0s1cjdnRlY5WTdwZG5M?=
 =?utf-8?B?SFNmRUlabEtoMmJzb3NVYnhhV1lFdUpYQW54MFV2SHJIYXpYRUkrdkhuTFEr?=
 =?utf-8?B?Q0UvaVhwMWNLajlKRWllbGtKSDV2SlVDMGtvTi95anBLNGFzU2VoWnF6Vmtw?=
 =?utf-8?B?cndxMnFGQzlYQk1yT1FSVy9jaEJBc1hCeEp2aTlKcHc4L0pYZXRWOHlZTEtG?=
 =?utf-8?B?TmtHN1NUN0FqSUdRb1JVcW1vb0V3anZjOUFmYkJtanRFZ1Q2aEVqeHc5bEto?=
 =?utf-8?B?Si9XWWl4bW9yYkl5Zi9rZ21jdm1YMlVudk5HNG9VZmtNb3ZSNGkyeEpBSnZl?=
 =?utf-8?B?cVpMZG1rSUhEa0s5M01GT2VqZTlaRnRpbjMvQTdXcUc5RHZUWmU0V01xejFK?=
 =?utf-8?B?cU1RQm1YQVMxa1JSV3U5TzM0cVdGd0Q1bVk5ZWpQc2pOUnFlTGw4Zi9xUHNT?=
 =?utf-8?B?TzlnekNlZkRQTWdsLzZUeS9rN1pzWXlqSUdRYUF0bUZ0REQ0YWxjZmpTS1Bv?=
 =?utf-8?B?NE5ZdXJXT09KSXFjTkxCN2d6bEJGcHZMdmpZYXdxQzdFa2FzdzMvUzBpR3BL?=
 =?utf-8?B?RFducGlUeks0OSt1Uit0dnBrN1NsTDcwcjVGRGtpQVNKeXZwTjk4S3lmZ2du?=
 =?utf-8?B?T1ZsY2VNelBHVld1Wmg4aDhJZDJkOHE3K2RwMGM2NFNvT00vYkNWL3JLRDZI?=
 =?utf-8?B?VUw0SFpVT2ZHYysyR3dxczJrUkFKQjhwRkkrb1grQmFVNy9iRkxyQVdmOWZo?=
 =?utf-8?B?T1dDbXhkdTR1LzBid3RwVE9TQ1ZGaGZrdWpoKzNCRVdUSldmWE8xZitDbnBw?=
 =?utf-8?B?VGp0c1I2bHpxOEEyR3FkdmJybkJwUWdwaG1ySGV2VEVHMFdvTE1GQmFBR2Nz?=
 =?utf-8?B?Z1RjVVFQaGZWUFpRYkk3aktlNlNDbDhxdUkwYit5WktSWXVKaXZOU04zRUh6?=
 =?utf-8?B?ZisxN2NwVHJYV29WQmZjWWZEVmJWWVJad2dPUk1LeXJqNUVmWEI0eWs1ZnAy?=
 =?utf-8?B?Nml0VWM5TXhpZlJ5cG9rZGpRdnN1amptL1VvclFKdW9ZMDNJVjdyanhBUVBj?=
 =?utf-8?B?aE00SjFwVFJaOXZkWVU3R0VLa2tBRmEzNlNHVFVOYnMvVUR1WCtPb1BuT1lt?=
 =?utf-8?B?V0ozSVE4QW5NVGhmQ2crMzh3NUpTd0dMbHFFREprRjJQTUZjWE02VUExelY1?=
 =?utf-8?B?ZVRWR0QySGFEN0EycWJIUE80aDRFNE9MSXJBMjE2OXBwQ2JwVkZkeDMrQnBY?=
 =?utf-8?B?STl5SW5mb0VORW1xcVRTaFVxOUczdGdmNEQ2dXRUUU9kVFJDWUZ2WTJsb2tq?=
 =?utf-8?B?bWlvVXBnRnhrcys2ek5Mc2VMNm5meFZUcnVIcWZRUXN5cmJ5eGxHUzFqcGdh?=
 =?utf-8?B?ckg5NGNHK0UzdGNxK2JuMmViQ01rMzhrblZyVWIvWnFHRVNSN0ZrelBtR2tF?=
 =?utf-8?Q?Ol3oxDqovAVuuSaSTXFj0jVLtIV9a4R5JcBbkQ8?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aUFqMEk0UUdVdzZDaWN2UnFEMXg2Tk85NnAvNHpDWG1OaHZnclRxK0s0WXVV?=
 =?utf-8?B?TDNXTVN0SkZ3QUk3ZVQxMkNNNllzSkQ4bjE4N0diTlVrWEFpamRnVmJZM1hO?=
 =?utf-8?B?VEdOQ0tOeml6N3o5QU9Ea2VuakJ3eG5La2N4bWJDdUZ2b1czL3dRNlVrVEJB?=
 =?utf-8?B?dHlMMUpWWVNFdjAzc3lUR29EZ24xRzhoRWR0TlFJWXdGQVlJejNydFBJQlEv?=
 =?utf-8?B?QVowaFV6VTAzTTduSXBBOW92Zm9US1lvUzJ6QTVEQlpGWjF3SVN3MjdmMU15?=
 =?utf-8?B?b1ZCT3l5bGx4dFpCSXk2U2dPUGxmaWJiY1Y5bklucG8rWGpKN203UXdlODBS?=
 =?utf-8?B?bzMvTm9sWVNDWjhEMWVaQW0reU0wTWc3Y2ovb2JHTVB3NHEyU21KT2hnYjhQ?=
 =?utf-8?B?YitKRkpIb3dtdjcxakNCSTgwYnBMTnljSlhXUlhuR3BiVFRYbjNSSzgwbXY2?=
 =?utf-8?B?ZFVPTEU3NmFhVTZIa0FBUFo5NUM5dTlGYzlwR3U3SW91elhzZ2kwZTM2OXI5?=
 =?utf-8?B?cHZWbkxHZFhiQkZjeTQ1aEZaNW9SYWQyTEExbnRqUytabXBOUG5LdmpCN3VK?=
 =?utf-8?B?NnVVSFk1UkNET1B2M1dNRkxNSEV3RGFxWnVYcjlrdTZvNitWNE9PZWpWTFBP?=
 =?utf-8?B?bkFVeXd5cnBaRnVpMCtGcDVEOFF6cTVEQTRzTVF4RnBnaUtWb3FBUDlSdllM?=
 =?utf-8?B?ODR3NDFrbWNIQVY2cDZoQUpNZWRKNGswY04ySXlkbVluSnc2T1VMeng4UXh1?=
 =?utf-8?B?OXdqTTI4WjdnL0lnWktCaTJMbGh4dnpCL2RrZkNOUzBkTVpLRE9kZnlaZDBo?=
 =?utf-8?B?QXZDbnBVb29rNTlBUURVTTdnS3k3dDdQUmc3RWFaelpqTXRmQVN2N2U4WkJO?=
 =?utf-8?B?UUdQZVZyTS9yeTJkNFF1VmpmZFpaY3RobWtVYUhIWUZLMG5QLzNCblo3eStU?=
 =?utf-8?B?S25EbjNkTjVWYWV0MDBOUlZSREkydUdkUnVTZkdabVBtei9nemRrb1dVK1Ns?=
 =?utf-8?B?YWdqYjZzWENzNUg3UG55Zi9oNnRNektiQ2s4K01TWGlIZkxTVTJRV3VkM2kz?=
 =?utf-8?B?RmRTNGdKQUkzZ0w2aFcyMElyeWxZMVhvR1E2RFQwRVE1bXFVM1dDTVJiV3V1?=
 =?utf-8?B?VThUaThiWWJuSUxscXRvbWZXcG56RHo3Z1l6Q0ZGazZyRWE2TWVVSkxIa1ZB?=
 =?utf-8?B?Tlh6MS81TVRFM1B5SzA2OXR2K1lBdDFpcWtzMWhVRGRZcEdFazlPajc4dmJV?=
 =?utf-8?B?aUV6MTlLZzY5NWxJZ2RpMjlXeFNtS21hTDg4UmVPaW9BUUdkNkhFQi9iUzFE?=
 =?utf-8?B?S1VpbWhxV2V4NTNaL3VUQUM3NERoMWJaZWRpeTUyVk1aS2E0ZmVsZ3Nqb0RC?=
 =?utf-8?B?Wmd4OVcxZDMyUmVocjExSEpaMXNld0pZUzVDNGFEc05GQ0xqcVM2UFNkcE5i?=
 =?utf-8?B?cmpNaHNudkFsZ1lWQTd6aGkySWw4c0w5bEtxS29rRVZQemlRUkdIYmljdmRN?=
 =?utf-8?B?N3EwRkVtWlZxNk5DdGVCRjNDR1piSENmZjBSaTVaTTVyY0ZyOE1Mdlg4RGJw?=
 =?utf-8?B?WjlMK3JWKzk3NkorWUZJdTVBU1pOU202eThLWGJiY08wYTd0MnZMYTk0UXRC?=
 =?utf-8?B?Qk0yMnRDeEdLbTZqQTJ5NjF5bi9ua0lSRVZXUWpsVUV5S280VVZzYkpWVjJk?=
 =?utf-8?B?WDNrTy92VWlWY296K2R3TEsxMWRud1FsSHkxL0RSMzAza0R3SlhzRC91ckR4?=
 =?utf-8?B?N0l3UEdzUytWQ2RqUkhzdkRaWitHTW5mUVYzZXB3Um5aTFcrR2RUY3AvOFFU?=
 =?utf-8?B?dVJSQ0pRVk51SjN1TURleGREVFhpeDRnZkFJYkFsbTc0TTk5cXBxa1V6dEhL?=
 =?utf-8?B?RkpINzdiTVNaYXZKMVFZQkVDNEhHSURLRkFMVnc0Y1hnVHFRbXpVWEJwYWVx?=
 =?utf-8?B?QkJ6eWdQMVNPbU9FRHV1QkZpaU12M2JHaXRzVVR0UENkTjhYM1pHelcyQ21t?=
 =?utf-8?B?dFJPeXhYME5PWDlMZE44S0c0WDByclpxWXpZMXhJb1BFS3Q0eEdNUUttT1lo?=
 =?utf-8?B?RTkzbGRIdzl2MmNGUXpXQnBzR0grSENvc3BGbDJPbllOTUYzUU1lYnNOaFpW?=
 =?utf-8?Q?6jp5vXfch2whYY1Z2tv4rluki?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b2612b-cf89-4ddc-a1ca-08dcabf3a958
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 15:16:58.7768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPQ9efgkyEhLss1FC3RDVIYAhIOp0uPRtmJ2zOxo0l2Yo3hABcvLliTb1u0bCGNQL2v6H+7zcjLyztFPRiy0SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8221
X-Proofpoint-ORIG-GUID: tcix1cSzjYhUqDnaQ-rsBw-cS2IOz6vt
X-Proofpoint-GUID: tcix1cSzjYhUqDnaQ-rsBw-cS2IOz6vt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_15,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 adultscore=0 clxscore=1011 spamscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2407240111
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jul 2024 15:17:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/452


On 7/24/24 22:53, Joe MacDonald wrote:
> Given that this is deprecated and disabled by default, is there any
> reason to keep this in at all, rather than just removing lines 67-70?

Although lastlog is disabled by default, the code is still there and 
users can enable it via configure option --enable-lastlog. So I did not 
delete these lines. In addition, keeping this line will allow users to 
easily switch to lastlog2. Just change pam_lastlog.so to pam_lastlog2.so 
in the line.



//Yi


>
> [[meta-selinux][PATCH] shadow: comment out pam_lastlog line in login pam file] On 24.07.24 (Wed 22:13) Yi Zhao wrote:
>
>> The pam_lastlog module is deprecated and disabled by default in
>> linux-pam since 1.5.3[1]. Comment out this line to avoid loading
>> pam_lastlog module by default. Users can use lastlog2 provided by
>> util-linux as an alternative[2].
>>
>> [1] https://github.com/linux-pam/linux-pam/commit/357a4ddbe9b4b10ebd805d2af3e32f3ead5b8816
>> [2] https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=c2e299d0acb2fa4ad1691452fa0eae76520bbdb0
>>
>> Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
>> ---
>>   recipes-extended/shadow/files/pam.d/login | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/recipes-extended/shadow/files/pam.d/login b/recipes-extended/shadow/files/pam.d/login
>> index ec5bba9..eb43f3b 100644
>> --- a/recipes-extended/shadow/files/pam.d/login
>> +++ b/recipes-extended/shadow/files/pam.d/login
>> @@ -66,7 +66,7 @@ session    required   pam_limits.so
>>   
>>   # Prints the last login info upon succesful login
>>   # (Replaces the `LASTLOG_ENAB' option from login.defs)
>> -session    optional   pam_lastlog.so
>> +#session    optional   pam_lastlog.so
>>   
>>   # Prints the motd upon succesful login
>>   # (Replaces the `MOTD_FILE' option in login.defs)
>> -- 
>> 2.25.1
>>

