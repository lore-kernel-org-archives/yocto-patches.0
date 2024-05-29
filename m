Return-Path: <changqing.li@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED34C25B78
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 03:10:24 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.5019.1716952219386689427
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 May 2024 20:10:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=6879088241=changqing.li@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44T0pj2s012595;
	Wed, 29 May 2024 03:10:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yb6y5kpqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 03:10:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FB5YxGsKoCvUzeHX7nuDdxXyRa1CNxyXu/N/0x18xTcNL8ZwWbMFQzHZeBbItHQ3WBTr6rpHrxWIFOZi3oDrFSgPmbNa8UYUnASBz3Rxm5Qy3MPeQRXZuNdxh8Ewd4/xbfEdipHTasBUOrlXZnu8yTs5kG3l6t5AkPoqjsilhNHeh0QSjmf7htC1Mom06JWlbUj7aD97/UehQSqV8rnv1Nei9Gwj853sb/RLQdkKqf8CryEbMtyGmzWhDXSKrfyqXQW7twSaFt30893S0w5/yp9+rqNYZn8XkLZ0eDV+D7yJGgJUVfKVsiGefWQ5YR5YrHsIEWZcj8ueMNIw3NYxEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqYmQlFWeqcNvPvA1MiWG+EJDDonVwenIyop47a33E4=;
 b=VzK+WcNBZ7cag1FYPQomXDcFD558/n0LEJpnoBt7zMtY815xyttcXtzg/Sq2H8zYkDrYx0UfGciJijt/zeOJjNCYaqkB6m2p+SD4XBpVs/zu3TTUcl4qNVZ54tAE75PvfKZC+Jz9ONuyT4CMAdgJiYc1WDJmK270XiZkWi7ErEgbAmduobRdaQcPmgDLkS2VakMBf3gtD+YGjsGs2FtHBvgFTO3AFzWOoq3iGsus5l8h8AFS8Dex2QVtRjFSovcpEeXAdxNLWUG/p3VzTepbfv+CJ3bEL0/LIQSnzS/LiELH3x+urJcJzaVJxiHMIJUP2WWJ/cph+v+GCo0BZCleMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by CY8PR11MB6961.namprd11.prod.outlook.com (2603:10b6:930:5a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 03:10:14 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c%4]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 03:10:13 +0000
Content-Type: multipart/alternative;
 boundary="------------JE0mOKKmyNF9FeDW5LUPsrtO"
Message-ID: <5e83e1c5-0f41-4509-8e37-69a6f964c8d7@windriver.com>
Date: Wed, 29 May 2024 11:10:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH]
 tcp-smack-test/udp-smack-test: fix do_compile failure
To: yocto-patches@lists.yoctoproject.org, akuster808 <akuster808@gmail.com>
References: <20240528054424.4037114-1-changqing.li@windriver.com>
 <ac164a4c-c5be-4b19-ab48-546c0cc269c0@gmail.com>
 <17D3D5A286221927.9428@lists.yoctoproject.org>
Content-Language: en-US
From: Changqing Li <changqing.li@windriver.com>
In-Reply-To: <17D3D5A286221927.9428@lists.yoctoproject.org>
X-ClientProxiedBy: SI2P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::19) To CH3PR11MB7297.namprd11.prod.outlook.com
 (2603:10b6:610:140::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|CY8PR11MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: eee1ab4c-25d6-4765-280a-08dc7f8cdb13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?akJMbGxyWlpDL3FQMUxOeDhFU0RpV242U3JGcncwRnh1d3poZEtOSFNQaDVs?=
 =?utf-8?B?dTFkbEtaSFpjS1dGR2dwMkRKaXlLOU0vTFhicmZkVkJGeEZON2syWnZ1NFJL?=
 =?utf-8?B?TDZacTFvT3dWdzZvd1NsRW9XSXl6U1NtT1hiRmRwMUl5UmFkbXhFWndjc1l6?=
 =?utf-8?B?Uy9BTy9yK1NYRlJsRmpkbjlqbnFTRXJjQkZTM3lZK3lWSUx1VHRmdlo2UXJo?=
 =?utf-8?B?SU1sV01jZC9XUTZHNGJDZXArZ2R3aG9RMXNkTnM2eE5Bb1FvTVhKOU9vb0hO?=
 =?utf-8?B?SFA4b2gwbkZwa1RlNjk1U2RwdVowTkw4YW1CQkl0ajVGSXZpaEl1TE0rVnN4?=
 =?utf-8?B?TXpxU0t2d2YrU0EyY2kyamJoaGorQ0dZMEh0bXk5ZXhkL1RBWlB3V3B2b3JJ?=
 =?utf-8?B?a1pOWU05Ukl3Z3lzV2FFRVhEQ2cvcnFjU1pjV0dkVEgyMzI4WTF6K091SVhx?=
 =?utf-8?B?L3p6WUtIQW5oYUV6RXV6aEZBL3JVaXJ1S0R1UEx4V2NyQm9vWmpremtsMVZq?=
 =?utf-8?B?ZitNV0k4K1htU3g0UTdmSTRnUUo1eC9ETkcrdzl4UHhmaVFGRG0wcTVIdXg2?=
 =?utf-8?B?Z0pqNTFDd21oZ2x1OU04L2NLdGt4azZQdTdSZUN6dDF4Mk4rS0ZEMGNDb2Jn?=
 =?utf-8?B?U3N1VDlvNW5ULy8vZndwTUJ6TUo0SG5BVzc4dGdDN2xPTDk2cVpxV2phRndt?=
 =?utf-8?B?RmJnMnNINU4xV1h0UjFKMVB4Yno3S2g5Y0I5d2RuemFBK1NhUnZlMW56Z3dY?=
 =?utf-8?B?Um9DOUl3QVFkWDErZEpzZGNIRUh3Y1Nvd0lmL1JpQjdLb0VKcWdYaHJHQjl4?=
 =?utf-8?B?U3M5VnlyUldyOXFuS3lwWW1EeFFsa0VKeHFwNHlqWlI3WDU1ckdNaDVBc2U2?=
 =?utf-8?B?a3U3WTZ6YWxNODRJYU02WDJRN1ZqZUMvWDBXVkREZUJXWWkvemtCeWdYRDdr?=
 =?utf-8?B?S09CNklSRnR1Z1ZKUzU3enlic1p6dEpFc2twTmtEaFViZlk3YWhROUZqZVFX?=
 =?utf-8?B?YiswOUtxcHBFclRTMU9oaGdzYVJyRE9FV21objhQY3JjRHlnMnMrNlljNkRo?=
 =?utf-8?B?NkU0aDdHOFpmSjE2RjdidFF2RGgzbU1uTGNEZVphRno4M0FZa0llbmxoRVd4?=
 =?utf-8?B?L3BXUUo5ODhMYnZFV3RPUTdIaHcvL3VZWjZ2MjNhL01Pb0tzaFJOcjBoWVgx?=
 =?utf-8?B?ZVc4VThGRStSeklXTnVrbDlBVUZwb2FCd1MxcjhtQVo5UnJzUldHQWdKU0tH?=
 =?utf-8?B?OW5SQzB4Q3ltOGpNRlZlOGszbkRYRUd0b0NIdm5BbEpuTXJYSEt4Q1hTdU1S?=
 =?utf-8?B?MFY0QkNzN3J0VTZXNXNOek93cXNJUEtuSGdyd20xTkF5dndkUWQxZkRNMmpM?=
 =?utf-8?B?cDBZVElLRVJteUdURjJCRVc3aWVDMlhmVCtYQXBNcXdtSllPTjhVV2lDY05Q?=
 =?utf-8?B?cDVUWEFmakFYR0E3dEJSTFloa09zYXp3bFJyYUkwY1B2TkdrM1lsaEpuVEZu?=
 =?utf-8?B?cEFMc1d5azVBU3VHM0ExVDhVczN5R3gzekZCQlNYL0FJemszU0hNd0YzRGZx?=
 =?utf-8?B?OVFyTGllMW5ZVnY4VitzV1BCcEFmV21hbmJmdEovVURud3I4TWxGRU1sZ3pj?=
 =?utf-8?B?Vnhpb2ovTEx5MEdvQ1I1eGdTSFVIenc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b3I3clFkUzhhSFpGcXlYRCtVbzU2SVhlZWQwYnFJK1J3bEc4VDY2Q1h5QldZ?=
 =?utf-8?B?aENHVWx3dGlwRE90ZmZzd3RGdk0xZFNzQlpKVk5EdE5KVTZPbDhoUXNnSFFF?=
 =?utf-8?B?Z1ZOUUkzN1kvZ2xXTFhabjVEd2xtMjBnUmlsVy9aandDWnJCa0FrS3duREFF?=
 =?utf-8?B?RDZmME5UYWcxMXlIcEVkeXdndXV4REdCaVk0QmZSUHg0bTZIekp6TTdsQlZQ?=
 =?utf-8?B?S3UxUXAyY1dvQlg0cHMvNEdGdmRNZUZMN1Vlamg2eVRzUzZiUFlCbnlhWWF5?=
 =?utf-8?B?M09YTGxBSGhXV1I1VTRPTVp3KzFuUDhZZ29SZW5uRnBsSjBya2VNekFvQ2Ux?=
 =?utf-8?B?UC9nYm53ZkZPM0Y3SUVmTTQxNnBOVnVtQitBRGduUEdYcGxnTU53MUh4TlZG?=
 =?utf-8?B?YllVOUlNdXBIK3dJSGllSG5nWmJSMGlBNTNFYjNLSTVibnRpUkpmRjJjZzEv?=
 =?utf-8?B?WnhCYjRjS1B4enBEaDB0RmxqeUgxaVU5Uk1yVjZHTUM3T2tyN1lBZDZOTVFx?=
 =?utf-8?B?djFXenR5aWY2b1JuZEFpVjJCTCtBR1V6ekYzTmIrTlU4c010a1Erb01Zc3NV?=
 =?utf-8?B?QjNZMVBCemJKL3ppditjQkRHeVYxcWpWVVlmVkRtNDVqc1MzbUkzN3R3cG9a?=
 =?utf-8?B?RmV1eWFYOVg4djlRVVV1SnlWR2dCdGFLcVVFVThZNFNZdEV5dmhyV1Nvblov?=
 =?utf-8?B?bTZVRTJJYjVYUG9tN1RVdEpMMng5ZUlaeVo4KzZrc0ExNmtyc0RwTG5OZTlI?=
 =?utf-8?B?dlZGTlFUa2o5K2Z5alRsQUNCSHE4ckRYV0ZPeXNkbFRLaWxFMURXV0NqOXk1?=
 =?utf-8?B?Ri9xYno1YWJ3VHgzd3B1M29GcFhGcVA0RjNSR0E5NnVuemtmeGw1SDl3SDE0?=
 =?utf-8?B?cWtUYjYrVWt1bE82eVBZZUlLRFYreFpYZTJFQ3ErbEhpTm8xU2Y5SHQ3U01B?=
 =?utf-8?B?Ynd2NjA2Uk1GSVYyRFl1c3R3SGdjNXJJM0UvY2d3ajhEblhRMzZGSFQ4cUVX?=
 =?utf-8?B?dHZPdTBLN3JpeVl6RGFYYnQ1emxtSjc0b04zMEFHUlIzYzVTQ3paUlR5dGFj?=
 =?utf-8?B?RGh2U3VCVWV6UlVCaHZJSWJyTHVJY1BxOHlsb2xqbG1CUmI2YThHSEtEUi9F?=
 =?utf-8?B?dlBWVlVvZXhBekl2Q0FwTXJQcEJGa3hXcG9HQ0Q1WGxCcTh2MS9XbWludE9k?=
 =?utf-8?B?Zk5Kek12U1NvaVV2dGxkL2RTdkVFdEZHODM0dWJVZVhoajVJakJ0aXp2dGVq?=
 =?utf-8?B?bnN4NlEvNHdFVUszRTJPYUtDMkpRNmJmQTBhbmtqRnJwcmgyM0htTGwzZS9Z?=
 =?utf-8?B?QnRicEpLYjRSdVJDTHgxTXhYOUZhM3R4NVdvTnpJTHZZeGtXVzNjZXQ3R1JG?=
 =?utf-8?B?ZHdySHBmSjhoVWZpd1RGMFJFSkJlWWhDSHRUL25UZ2VUWXFkeVlneFVEQmV1?=
 =?utf-8?B?RmhmempNYnBkcFNZczFKVUZUZXJXb2xrOVBudWo2TmVGamZuaEU5KzU5cWpW?=
 =?utf-8?B?cFRzS2NHSDg1MkR3dUUvUlk4NHJxblhpVC8wcVRqeWdmbDl1blFzbk5HTWE0?=
 =?utf-8?B?M3dWQmVIV3ZxaXJDY1oxR2NiTmtJSlR2bUpicytTTFFPclMvbXd2WGJ5NDR6?=
 =?utf-8?B?M1gxWWU5ZmEyUE1FcUFpQ0FIZVdKS1RHek8vRkpFRzdkYloxaXhmNjRCQ0t2?=
 =?utf-8?B?WUUrSDR2alFYb3NzVWNiT2JQb2dWUlBvb0diOFQzdWgyRHdub1ZJcVYyZVAy?=
 =?utf-8?B?eWFVa0RYSTJYbXdiazVwbTFYWG1GeUVOb2NHd3RuK3NsbjJxWm92TTV4dW9o?=
 =?utf-8?B?Wm5tKzMwYVpnb0NJOE80MWV0cit0c2VoYXpJWWpsNWMzbmFRNy9ObDN2NXkz?=
 =?utf-8?B?NkFRUHN6aTJ1bG91SndhSG9xYUZ0ZC9pNVJ2b0Z0My9nUDkwN3pzenY1WmtG?=
 =?utf-8?B?ajVuTUVHcHl6OHJHa1hjc2M1VU84MTRPZmt2cHVMc2hVOHJFcmZJZWRWcjEr?=
 =?utf-8?B?cUJIR0s0V1JPcFBGZ0VYaHk4WTFSNlZBRm53aE82ZytvTUljMzUxU0RLTENS?=
 =?utf-8?B?SVhKOWVDRHFwamp3MXJlcWNVWEdubTBGdEtDbFc0M1pnMk9CUU9iaTc1bW16?=
 =?utf-8?B?OVFub1l2UU10b0Y1a3U5ZW9ycGtLTlVOQ0d4YlpuYzdVVVorMU9OSGY0V0tI?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee1ab4c-25d6-4765-280a-08dc7f8cdb13
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 03:10:13.2993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgrKlS9hiSmxjciOkikGM3N87V/I0x4ulXBuFFtJIfeDnunQOVRLDdM8pccJcUaIRPQrQg0AhHDMMlHIHHMPnFxkdaVg5KsDp3dLc7JgKt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6961
X-Proofpoint-ORIG-GUID: BRJ_cq03wdEhAGSZnfgVfoVn_8Gn1EOJ
X-Proofpoint-GUID: BRJ_cq03wdEhAGSZnfgVfoVn_8Gn1EOJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 bulkscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2405290018
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 May 2024 03:10:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/241

--------------JE0mOKKmyNF9FeDW5LUPsrtO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 44T0pj2s012595


On 5/29/24 10:46, Changqing Li wrote:
>
>
> On 5/29/24 02:16, akuster808 wrote:
>> CAUTION: This email comes from a non Wind River email account!
>> Do not click links or open attachments unless you recognize the=20
>> sender and know the content is safe.
>>
>> =C2=A0Hello Changging,
>>
>> Martin sent a patch to fix this earlier.
>>
>> thanks.
>> Armin
>
> Hi, Armin
>
> Thanks. I just saw Martin's patch on master-next, but seems like not=20
> all the needed header is added in that patch.
>
> Maybe there will be compile error for these recipes.
>
Should I send a patch based on Martin's patch?

Thanks

Changqing

> Changqing
>
>>
>> On 5/28/24 1:44 AM, Changqing Li via lists.yoctoproject.org=20
>> <https://urldefense.com/v3/__http://lists.yoctoproject.org__;!!AjveYdw=
8EvQ!eGfBaYJsXLlZaaX4RSJ9li6ztnC7C5RsWG_o6EU-6gJj0Go6kivGpd3QPGIoKwZGz8rx=
UCN_SFxGvybJ3DQ1P06l764F63Aau4EFFg$>=20
>> wrote:
>>> From: Changqing Li <changqing.li@windriver.com>
>>>
>>> Include proper headers to fix following errors:
>>> | udp_client.c:41:16: error: implicit declaration of function 'atoi'=20
>>> [-Wimplicit-function-declaration]
>>> |=C2=A0=C2=A0=C2=A0 41 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 port =3D atoi(argv[1]);
>>> | udp_client.c:52:12: error: implicit declaration of function=20
>>> 'fsetxattr' [-Wimplicit-function-declaration]
>>> |=C2=A0=C2=A0=C2=A0 52 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if(fsetxattr(sock, attr, label, strlen(label),0) < 0)
>>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~
>>> | udp_client.c:67:9: error: implicit declaration of function=20
>>> 'close'; did you mean 'pclose'? [-Wimplicit-function-declaration]
>>> |=C2=A0=C2=A0=C2=A0 67 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 close(sock);
>>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^~~~~
>>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 pclose
>>> | tcp_client.c:55:16: error: implicit declaration of function 'atoi'=20
>>> [-Wimplicit-function-declaration]
>>> |=C2=A0=C2=A0=C2=A0 55 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 port =3D atoi(argv[1]);
>>> ...
>>>
>>> Signed-off-by: Changqing Li <changqing.li@windriver.com>
>>> ---
>>> =C2=A0 recipes-mac/smack/tcp-smack-test/tcp_client.c | 1 +
>>> =C2=A0 recipes-mac/smack/tcp-smack-test/tcp_server.c | 3 +++
>>> =C2=A0 recipes-mac/smack/udp-smack-test/udp_client.c | 3 +++
>>> =C2=A0 recipes-mac/smack/udp-smack-test/udp_server.c | 3 +++
>>> =C2=A0 4 files changed, 10 insertions(+)
>>>
>>> diff --git a/recipes-mac/smack/tcp-smack-test/tcp_client.c=20
>>> b/recipes-mac/smack/tcp-smack-test/tcp_client.c
>>> index 6c0a474..b82b575 100644
>>> --- a/recipes-mac/smack/tcp-smack-test/tcp_client.c
>>> +++ b/recipes-mac/smack/tcp-smack-test/tcp_client.c
>>> @@ -18,6 +18,7 @@
>>> =C2=A0 // OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTH=
ER=20
>>> DEALINGS IN
>>> =C2=A0 // THE SOFTWARE.
>>> =C2=A0 #include <stdio.h>
>>> +#include <stdlib.h>
>>> =C2=A0 #include <sys/socket.h>
>>> =C2=A0 #include <sys/types.h>
>>> =C2=A0 #include <errno.h>
>>> diff --git a/recipes-mac/smack/tcp-smack-test/tcp_server.c=20
>>> b/recipes-mac/smack/tcp-smack-test/tcp_server.c
>>> index 3c8921f..6de7ccd 100644
>>> --- a/recipes-mac/smack/tcp-smack-test/tcp_server.c
>>> +++ b/recipes-mac/smack/tcp-smack-test/tcp_server.c
>>> @@ -24,6 +24,9 @@
>>> =C2=A0 #include <netinet/in.h>
>>> =C2=A0 #include <unistd.h>
>>> =C2=A0 #include <string.h>
>>> +#include <stdlib.h>
>>> +#include <sys/xattr.h>
>>> +
>>>
>>> =C2=A0 int main(int argc, char* argv[])
>>> =C2=A0 {
>>> diff --git a/recipes-mac/smack/udp-smack-test/udp_client.c=20
>>> b/recipes-mac/smack/udp-smack-test/udp_client.c
>>> index 23f3e00..3d2ee31 100644
>>> --- a/recipes-mac/smack/udp-smack-test/udp_client.c
>>> +++ b/recipes-mac/smack/udp-smack-test/udp_client.c
>>> @@ -19,6 +19,9 @@
>>> =C2=A0 // THE SOFTWARE.
>>> =C2=A0 #include <sys/socket.h>
>>> =C2=A0 #include <stdio.h>
>>> +#include <stdlib.h>
>>> +#include <unistd.h>
>>> +#include <sys/xattr.h>
>>> =C2=A0 #include <netinet/in.h>
>>> =C2=A0 #include <netdb.h>
>>> =C2=A0 #include <string.h>
>>> diff --git a/recipes-mac/smack/udp-smack-test/udp_server.c=20
>>> b/recipes-mac/smack/udp-smack-test/udp_server.c
>>> index 7d2fcf5..25ad1ef 100644
>>> --- a/recipes-mac/smack/udp-smack-test/udp_server.c
>>> +++ b/recipes-mac/smack/udp-smack-test/udp_server.c
>>> @@ -22,6 +22,9 @@
>>> =C2=A0 #include <netinet/in.h>
>>> =C2=A0 #include <netdb.h>
>>> =C2=A0 #include <string.h>
>>> +#include <stdlib.h>
>>> +#include <unistd.h>
>>> +#include <sys/xattr.h>
>>>
>>> =C2=A0 int main(int argc, char* argv[])
>>> =C2=A0 {
>>
> _._,_._,_
> -----------------------------------------------------------------------=
-
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#239)=20
> <https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-pat=
ches/message/239__;!!AjveYdw8EvQ!eGfBaYJsXLlZaaX4RSJ9li6ztnC7C5RsWG_o6EU-=
6gJj0Go6kivGpd3QPGIoKwZGz8rxUCN_SFxGvybJ3DQ1P06l764F63BlfKSNJA$>=20
> | Reply To Group=20
> <mailto:yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re%3A%20%5=
Byocto-patches%5D%20%5Bmeta-security%5D%5BPATCH%5D%20tcp-smack-test%2Fudp=
-smack-test%3A%20fix%20do_compile%20failure>=20
> | Reply To Sender=20
> <mailto:changqing.li@eng.windriver.com?subject=3DPrivate:%20Re:%20Re%3A=
%20%5Byocto-patches%5D%20%5Bmeta-security%5D%5BPATCH%5D%20tcp-smack-test%=
2Fudp-smack-test%3A%20fix%20do_compile%20failure>=20
> | Mute This Topic=20
> <https://urldefense.com/v3/__https://lists.yoctoproject.org/mt/10634402=
8/3616873__;!!AjveYdw8EvQ!eGfBaYJsXLlZaaX4RSJ9li6ztnC7C5RsWG_o6EU-6gJj0Go=
6kivGpd3QPGIoKwZGz8rxUCN_SFxGvybJ3DQ1P06l764F63Cq4ktsZw$>=20
> | New Topic=20
> <https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-pat=
ches/post__;!!AjveYdw8EvQ!eGfBaYJsXLlZaaX4RSJ9li6ztnC7C5RsWG_o6EU-6gJj0Go=
6kivGpd3QPGIoKwZGz8rxUCN_SFxGvybJ3DQ1P06l764F63DB4jdNLg$>=20
>
> Your Subscription=20
> <https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-pat=
ches/editsub/3616873__;!!AjveYdw8EvQ!eGfBaYJsXLlZaaX4RSJ9li6ztnC7C5RsWG_o=
6EU-6gJj0Go6kivGpd3QPGIoKwZGz8rxUCN_SFxGvybJ3DQ1P06l764F63DfYL6wfg$>=20
> | Contact Group Owner=20
> <mailto:yocto-patches+owner@lists.yoctoproject.org> | Unsubscribe=20
> <https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-pat=
ches/leave/13170723/3616873/476927670/xyzzy__;!!AjveYdw8EvQ!eGfBaYJsXLlZa=
aX4RSJ9li6ztnC7C5RsWG_o6EU-6gJj0Go6kivGpd3QPGIoKwZGz8rxUCN_SFxGvybJ3DQ1P0=
6l764F63C6a56Nwg$>=20
> [changqing.li@eng.windriver.com]
>
> _._,_._,_
--------------JE0mOKKmyNF9FeDW5LUPsrtO
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#cceed0">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/29/24 10:46, Changqing Li wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:17D3D5A286221927.9428@lists.yoctoproject.org">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 5/29/24 02:16, akuster808 wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:ac164a4c-c5be-4b19-ab48-546c0cc269c0@gmail.com">CAUTION:
        This email comes from a non Wind River email account! <br>
        Do not click links or open attachments unless you recognize the
        sender and know the content is safe. <br>
        <br>
        &nbsp;Hello Changging, <br>
        <br>
        Martin sent a patch to fix this earlier. <br>
        <br>
        thanks. <br>
        Armin <br>
      </blockquote>
      <p>Hi, Armin</p>
      <p>Thanks. I just saw Martin's patch on master-next, but seems
        like not all the needed header is added in that patch. <br>
      </p>
      <p>Maybe there will be compile error for these recipes.<br>
      </p>
    </blockquote>
    <p>Should I send a patch based on Martin's patch?</p>
    <p>Thanks<br>
    </p>
    <p>Changqing<br>
    </p>
    <blockquote type="cite" cite="mid:17D3D5A286221927.9428@lists.yoctoproject.org">
      <p> </p>
      <p>Changqing<br>
      </p>
      <blockquote type="cite" cite="mid:ac164a4c-c5be-4b19-ab48-546c0cc269c0@gmail.com"> <br>
        On 5/28/24 1:44 AM, Changqing Li via <a href="https://urldefense.com/v3/__http://lists.yoctoproject.org__;!!AjveYdw8EvQ!eGfBaYJsXLlZaaX4RSJ9li6ztnC7C5RsWG_o6EU-6gJj0Go6kivGpd3QPGIoKwZGz8rxUCN_SFxGvybJ3DQ1P06l764F63Aau4EFFg$" moz-do-not-send="true">lists.yoctoproject.org</a> wrote: <br>
        <blockquote type="cite">From: Changqing Li <a class="moz-txt-link-rfc2396E" href="mailto:changqing.li@windriver.com" moz-do-not-send="true">&lt;changqing.li@windriver.com&gt;</a>
          <br>
          <br>
          Include proper headers to fix following errors: <br>
          | udp_client.c:41:16: error: implicit declaration of function
          'atoi' [-Wimplicit-function-declaration] <br>
          |&nbsp;&nbsp;&nbsp; 41 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port = atoi(argv[1]); <br>
          | udp_client.c:52:12: error: implicit declaration of function
          'fsetxattr' [-Wimplicit-function-declaration] <br>
          |&nbsp;&nbsp;&nbsp; 52 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(fsetxattr(sock, attr, label,
          strlen(label),0) &lt; 0) <br>
          |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~~~ <br>
          | udp_client.c:67:9: error: implicit declaration of function
          'close'; did you mean 'pclose'?
          [-Wimplicit-function-declaration] <br>
          |&nbsp;&nbsp;&nbsp; 67 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close(sock); <br>
          |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~ <br>
          |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pclose <br>
          | tcp_client.c:55:16: error: implicit declaration of function
          'atoi' [-Wimplicit-function-declaration] <br>
          |&nbsp;&nbsp;&nbsp; 55 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port = atoi(argv[1]); <br>
          ... <br>
          <br>
          Signed-off-by: Changqing Li <a class="moz-txt-link-rfc2396E" href="mailto:changqing.li@windriver.com" moz-do-not-send="true">&lt;changqing.li@windriver.com&gt;</a>
          <br>
          --- <br>
          &nbsp; recipes-mac/smack/tcp-smack-test/tcp_client.c | 1 + <br>
          &nbsp; recipes-mac/smack/tcp-smack-test/tcp_server.c | 3 +++ <br>
          &nbsp; recipes-mac/smack/udp-smack-test/udp_client.c | 3 +++ <br>
          &nbsp; recipes-mac/smack/udp-smack-test/udp_server.c | 3 +++ <br>
          &nbsp; 4 files changed, 10 insertions(+) <br>
          <br>
          diff --git a/recipes-mac/smack/tcp-smack-test/tcp_client.c
          b/recipes-mac/smack/tcp-smack-test/tcp_client.c <br>
          index 6c0a474..b82b575 100644 <br>
          --- a/recipes-mac/smack/tcp-smack-test/tcp_client.c <br>
          +++ b/recipes-mac/smack/tcp-smack-test/tcp_client.c <br>
          @@ -18,6 +18,7 @@ <br>
          &nbsp; // OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
          OTHER DEALINGS IN <br>
          &nbsp; // THE SOFTWARE. <br>
          &nbsp; #include &lt;stdio.h&gt; <br>
          +#include &lt;stdlib.h&gt; <br>
          &nbsp; #include &lt;sys/socket.h&gt; <br>
          &nbsp; #include &lt;sys/types.h&gt; <br>
          &nbsp; #include &lt;errno.h&gt; <br>
          diff --git a/recipes-mac/smack/tcp-smack-test/tcp_server.c
          b/recipes-mac/smack/tcp-smack-test/tcp_server.c <br>
          index 3c8921f..6de7ccd 100644 <br>
          --- a/recipes-mac/smack/tcp-smack-test/tcp_server.c <br>
          +++ b/recipes-mac/smack/tcp-smack-test/tcp_server.c <br>
          @@ -24,6 +24,9 @@ <br>
          &nbsp; #include &lt;netinet/in.h&gt; <br>
          &nbsp; #include &lt;unistd.h&gt; <br>
          &nbsp; #include &lt;string.h&gt; <br>
          +#include &lt;stdlib.h&gt; <br>
          +#include &lt;sys/xattr.h&gt; <br>
          + <br>
          <br>
          &nbsp; int main(int argc, char* argv[]) <br>
          &nbsp; { <br>
          diff --git a/recipes-mac/smack/udp-smack-test/udp_client.c
          b/recipes-mac/smack/udp-smack-test/udp_client.c <br>
          index 23f3e00..3d2ee31 100644 <br>
          --- a/recipes-mac/smack/udp-smack-test/udp_client.c <br>
          +++ b/recipes-mac/smack/udp-smack-test/udp_client.c <br>
          @@ -19,6 +19,9 @@ <br>
          &nbsp; // THE SOFTWARE. <br>
          &nbsp; #include &lt;sys/socket.h&gt; <br>
          &nbsp; #include &lt;stdio.h&gt; <br>
          +#include &lt;stdlib.h&gt; <br>
          +#include &lt;unistd.h&gt; <br>
          +#include &lt;sys/xattr.h&gt; <br>
          &nbsp; #include &lt;netinet/in.h&gt; <br>
          &nbsp; #include &lt;netdb.h&gt; <br>
          &nbsp; #include &lt;string.h&gt; <br>
          diff --git a/recipes-mac/smack/udp-smack-test/udp_server.c
          b/recipes-mac/smack/udp-smack-test/udp_server.c <br>
          index 7d2fcf5..25ad1ef 100644 <br>
          --- a/recipes-mac/smack/udp-smack-test/udp_server.c <br>
          +++ b/recipes-mac/smack/udp-smack-test/udp_server.c <br>
          @@ -22,6 +22,9 @@ <br>
          &nbsp; #include &lt;netinet/in.h&gt; <br>
          &nbsp; #include &lt;netdb.h&gt; <br>
          &nbsp; #include &lt;string.h&gt; <br>
          +#include &lt;stdlib.h&gt; <br>
          +#include &lt;unistd.h&gt; <br>
          +#include &lt;sys/xattr.h&gt; <br>
          <br>
          &nbsp; int main(int argc, char* argv[]) <br>
          &nbsp; { <br>
        </blockquote>
        <br>
      </blockquote>
      <div width="1" style="color:white;clear:both">_._,_._,_</div>
      <hr>
      Links:
      <p> You receive all messages sent to this group. </p>
      <p>
        <a target="_blank" href="https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-patches/message/239__;!!AjveYdw8EvQ!eGfBaYJsXLlZaaX4RSJ9li6ztnC7C5RsWG_o6EU-6gJj0Go6kivGpd3QPGIoKwZGz8rxUCN_SFxGvybJ3DQ1P06l764F63BlfKSNJA$" moz-do-not-send="true">View/Reply Online (#239)</a> | <a target="_blank" href="mailto:yocto-patches@lists.yoctoproject.org?subject=Re:%20Re%3A%20%5Byocto-patches%5D%20%5Bmeta-security%5D%5BPATCH%5D%20tcp-smack-test%2Fudp-smack-test%3A%20fix%20do_compile%20failure" moz-do-not-send="true">Reply To Group</a> | <a target="_blank" href="mailto:changqing.li@eng.windriver.com?subject=Private:%20Re:%20Re%3A%20%5Byocto-patches%5D%20%5Bmeta-security%5D%5BPATCH%5D%20tcp-smack-test%2Fudp-smack-test%3A%20fix%20do_compile%20failure" moz-do-not-send="true">Reply To Sender</a> | <a target="_blank" href="https://urldefense.com/v3/__https://lists.yoctoproject.org/mt/106344028/3616873__;!!AjveYdw8EvQ!eGfBaYJsXLlZaaX4RSJ9li6ztnC7C5RsWG_o6EU-6gJj0Go6kivGpd3QPGIoKwZGz8rxUCN_SFxGvybJ3DQ1P06l764F63Cq4ktsZw$" moz-do-not-send="true">Mute This Topic</a>
        | <a href="https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-patches/post__;!!AjveYdw8EvQ!eGfBaYJsXLlZaaX4RSJ9li6ztnC7C5RsWG_o6EU-6gJj0Go6kivGpd3QPGIoKwZGz8rxUCN_SFxGvybJ3DQ1P06l764F63DB4jdNLg$" moz-do-not-send="true">New Topic</a>
        <br>
        <a href="https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-patches/editsub/3616873__;!!AjveYdw8EvQ!eGfBaYJsXLlZaaX4RSJ9li6ztnC7C5RsWG_o6EU-6gJj0Go6kivGpd3QPGIoKwZGz8rxUCN_SFxGvybJ3DQ1P06l764F63DfYL6wfg$" moz-do-not-send="true">Your Subscription</a> |
        <a href="mailto:yocto-patches+owner@lists.yoctoproject.org" moz-do-not-send="true">Contact Group Owner</a> |
        <a href="https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-patches/leave/13170723/3616873/476927670/xyzzy__;!!AjveYdw8EvQ!eGfBaYJsXLlZaaX4RSJ9li6ztnC7C5RsWG_o6EU-6gJj0Go6kivGpd3QPGIoKwZGz8rxUCN_SFxGvybJ3DQ1P06l764F63C6a56Nwg$" moz-do-not-send="true">Unsubscribe</a>
        [<a class="moz-txt-link-abbreviated" href="mailto:changqing.li@eng.windriver.com">changqing.li@eng.windriver.com</a>]<br>
      </p>
      <div width="1" style="color:white;clear:both">_._,_._,_</div>
    </blockquote>
  </body>
</html>

--------------JE0mOKKmyNF9FeDW5LUPsrtO--

