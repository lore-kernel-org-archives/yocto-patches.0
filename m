Return-Path: <changqing.li@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49250C25B78
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 02:46:24 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.4634.1716950776896191585
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 May 2024 19:46:16 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=6879088241=changqing.li@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44T16jAv004312;
	Tue, 28 May 2024 19:46:15 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ybb90bhdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 19:46:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Krd6T4S5zZHgtW1YmI4emprHqVpyArOLKzm5DflLoLGT8T4su/1cncqppZGJMB4OWesz+w5kA2IbgQ/lvSgpHufV1cZCL74gox46HNuhQdFMcPoqOZtVQAi18XUpd7NNMBapQdTiRF8XUETZ8A3smuEvDOyJisLntGtSmsJ9prNgw4yQ65EbAilNVi+tzbX4fBvOiGoBKxvLQXdgKei2nxUibFIyNbZRwC5Y3C7L3w34PqXsT/USOcvNQRUlNe2JDQtUANUi/0jiOqUN5gPjmidB6h/6g3vI86o0N6mE3CmJ57s7M4cUjGKTA5Vi6L8wQtM9f/gCbfM6SoMUq7FOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icOYtwdD8zFu1lzQ5jqFLDIxxsfG3PUEI91UjXolAX0=;
 b=V4w4H401jKT+9i26dP7o5seIU5AAuQtMrWn86APoacbzKOV0bTltReCwZYpoqklqTBHOE0hwiplxlgyxy66i8CkVepY/deH5/TuvEACrkJ3xNyufRktGa/I9Uco+XPTdCxXcyCbtj39WSMItHrnhABoBQ6LNEH7w/8t2kdBK91PjBVWqU0pfYtpSm0d9WE12wBAdLtz4hL33NLqrBwwvpgf+hrwOY8w8FGTuk0lgzO6ikNsrc0ggTqA0U40H9gbCl3N3wnMTBgWlcgqbE72Kjx6/Xq+ZAUH/mKSZBZPoX0asMVvX4UOTZzjViBHDgBDjuMX6rEQZCpYnPQti7rYB9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB7297.namprd11.prod.outlook.com (2603:10b6:610:140::19)
 by CYYPR11MB8330.namprd11.prod.outlook.com (2603:10b6:930:b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 02:46:10 +0000
Received: from CH3PR11MB7297.namprd11.prod.outlook.com
 ([fe80::9196:38bd:6b0:2d0b]) by CH3PR11MB7297.namprd11.prod.outlook.com
 ([fe80::9196:38bd:6b0:2d0b%4]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 02:46:10 +0000
Content-Type: multipart/alternative;
 boundary="------------K1fa8LDePzid9rF10apKu8Ry"
Message-ID: <8135c741-753c-4c49-8f2f-c7713a8a5964@windriver.com>
Date: Wed, 29 May 2024 10:46:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH]
 tcp-smack-test/udp-smack-test: fix do_compile failure
To: akuster808 <akuster808@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
References: <20240528054424.4037114-1-changqing.li@windriver.com>
 <ac164a4c-c5be-4b19-ab48-546c0cc269c0@gmail.com>
Content-Language: en-US
From: Changqing Li <changqing.li@windriver.com>
In-Reply-To: <ac164a4c-c5be-4b19-ab48-546c0cc269c0@gmail.com>
X-ClientProxiedBy: TYCP301CA0074.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::14) To CH3PR11MB7297.namprd11.prod.outlook.com
 (2603:10b6:610:140::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7297:EE_|CYYPR11MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: b1fb437b-9931-4400-81d4-08dc7f897f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YlZVRjdCTEdlWTZVejN4eTR0K1EzMFNJZVZGZXhWWUlMeXR2UHNwOWdWeXpt?=
 =?utf-8?B?cEx4MGtkWFROSE5NVVc4cXhmYy8xRFdTZnVtZXZJRGxYLzZ4T2pQaXNUbWJC?=
 =?utf-8?B?Wjc4RmlFNkx6VnlocC96ajR4cHJLUVBhM2xrYmVMME9LOVBtWHpqS2tUZHdu?=
 =?utf-8?B?ZzVlSWVnaGU4M3RqVk5rTGh2RStLYUJOQURlUFc1ZXJCd2ErTmdWSGNXNi9R?=
 =?utf-8?B?MlFIQ0dhTFlpV0xlMkdYalVUcktsTjBoMW5CVVhrL2pmTWFsV0Q5SmhaZE1o?=
 =?utf-8?B?MGxEaEM1TGFoNXRqd2pYdGFIbk5LcTFVTE5JYU96UmhNZ0tGdkJKQ2lvcGdL?=
 =?utf-8?B?TTBNRlhqd1VQZDNFa3p5Nld1dFFYUkx5MnQyR2FFVDgxNWFBL3ZVeGlLVkE0?=
 =?utf-8?B?bzg5ZlV0R0hNU2JPT1VjSkZCZzUzejI0aTA5Z1hESDRmZE9BZjNBTnA4Q1kv?=
 =?utf-8?B?SEVsUS9ybUJGbXhJdVJLSUJTSXNmNXE3aU8rdGkrNFJJNGxMMUhlS2g0OXhl?=
 =?utf-8?B?eGIrOHF6OEtKUHRZT3ZKVU5SZE12QnI3b3NkUlBrNWV3TzBlbUlPOC92bTBq?=
 =?utf-8?B?VDVBZGNyYy9SWWdqcCtVVFpnSjdUL0xTeENsUzdkZFR4aUUxcm1pNUNzTjVw?=
 =?utf-8?B?MEFBbzVXTWVXSXU4WFFCRUNtR3Y5M1ZnaC9MbGxFY3p5eVEyQnpOTGVvL2ti?=
 =?utf-8?B?WFhTT25vVnJVUDlsYUxLeWxQWUlDanlQYTZoVlc3QkNFQzZLL2hvM2ZDb0Qz?=
 =?utf-8?B?a0Y4WFdYTkY2citBT1RhZEhqVVpIUjBDb3N5aVJSWE1UMzg1bFpMaGVJZ2tk?=
 =?utf-8?B?bUcxRmozaVVTQWlOVVB4bGJnakpqWWZCUzV2TStrcW5YZnBkb0pielNTaFcr?=
 =?utf-8?B?bjh6MHlEckhHQkNlN05JaUJRNGFHd0ZXblVDWnZsVHQvTDV4SnlpRXZVVVVC?=
 =?utf-8?B?S0YzN2Q3VXhkdUh3dHVRUW84YmhiZVNyVUhGV2ZBekhvMkhOWEUySjdvT2Fx?=
 =?utf-8?B?VjlNa3Vjdzh0MkRoY2Q4R0xWMWQ4SkxpbXpFQlluSTUvUldqZEl2TklMY2Y4?=
 =?utf-8?B?SzR0ejlZRER1M21zbE5sa2RXbkZIV1hXY1pOZW9SL0kzTjFtdlFoODczOTBv?=
 =?utf-8?B?R2p3YmdRMmxyY2p4azhPTHJpT04zaTFJaVhsQ042azJrQ09aK2FDSVg5V04v?=
 =?utf-8?B?ZlBpYkpOTUxjZzhnbHNEOUdyWnJLYUF0cUhWekdqbGM4N2FEajVHZzl1VnhI?=
 =?utf-8?B?ZUNGME5yM1E4ZFZYdFAvSXFvTXpDRHdTOG54Tmt1QUpEOEJSMHJqOXJVT0Jo?=
 =?utf-8?B?VzlnV3V1RWRYTlp4b09LZEZCQ2xlWFdhWFJsanh5WmNRUy85R1ZGdmtSK2pR?=
 =?utf-8?B?MFRiTnh3Wkg0WGc1M3IyMjM3M3lPbFNJS09taUQrWFF4RzJ1ZnRTMm5KQWJa?=
 =?utf-8?B?RUZtVDFnQlloSThSVXBFM1lqcW9QMWx0TFJIZFJqMXdRRHBick9VZitaWnhk?=
 =?utf-8?B?Mm41WC94T3FnVis0S1RrcmJkbmZwcVlRY1diWFlVVXA3NmU2QzVWbmxYdkh1?=
 =?utf-8?B?YWZ3eDRNWitVdTJ2YW1GSlRRcU1zSUFDVXNheHluK0FWRHJTSXNRYjVCQ2xZ?=
 =?utf-8?B?ckdNb3VTV0FYUGxvbjYzbVcweXVIWTlGczQxYXhDQmZoRHBQQ01tazBGZXNn?=
 =?utf-8?B?dzc0eXI5bFRJMWZvcFg5RVA1MUxmV1RVY09pUWR6MlhsQVN4NTR6OUZBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SzNBQ253U3NLR0R0TUxYR2Z2aWZhZXhQQm1pZi9XTk00QmlUbEExbFBZM0lr?=
 =?utf-8?B?dnIzOHovdnRyOXhwWGRZbEVhODdDUkpOWm9aK2J1MmpXTUVOWmdyM2s2YUo3?=
 =?utf-8?B?VFlIelQvZVZZRjJaYXNmTjNsSEZqNzMxWG4yRUU3NlFIWTBsSkkwTGhWamFQ?=
 =?utf-8?B?MzVVSmJYVFFvVVlkeHBwaXl1cEJ3N2s0a2lvbXRzWmpxZ1RWUkFSdEQySmp1?=
 =?utf-8?B?ejR3bXFWZTZlcngvK1NTVWExUFNEUzlPM1FIZ0FuSXlHb1Q4a0VFRUxkVzdx?=
 =?utf-8?B?cTlmcEJWdTBITkQ2UzdyQnFYQzBNMk9JUnVlWVM5SUZzbmJhdG1uN1l0NkNH?=
 =?utf-8?B?ZXRiemoxTFZVbXZZTWV6YUF5THFZZ0lqbWRrV085dGh1clRPaVJuY1UySTFv?=
 =?utf-8?B?OUxpRFY1bWVibGdDNVhHekVxNFVENE45b3lXcXZET3hwL2tyVTQxTUw4Y2t2?=
 =?utf-8?B?WFVqM01DNDNLditQeG4vKzZPNEozV0xMUnJ2Vk1kSFp2ZFlhRTNjMkVTRkx1?=
 =?utf-8?B?TXdBWlJ6ZVowc2NOc2ppLzllMDhubjRPdU1mbytDUUVoYitLa1RLaE9iUElj?=
 =?utf-8?B?dUw3TnNvU1Fhekg1cXNmbStONlBTajRkbGI5dEIrejRZdWdheXduSjcvRThk?=
 =?utf-8?B?V2FRclJLUEhrSGlxUStualVyS29aVDhPQVovOURDN1huRlY0UVRNTnJQOGhn?=
 =?utf-8?B?RVlKbEl3dk9ZK0NTeENwU2RiRFpUWmszZjlBRlRudDNoeFJsRGdSZjAzTmhU?=
 =?utf-8?B?QytBQ2JlaWFhdjZKNmpHY0YwUE10WjVmTHRsd1NYWVFjRFpsQmw3emd5TXhi?=
 =?utf-8?B?dXh0SkZJV3hVTCtVRUFScDZtR1JTdDB4Q3hRQ0NIKzRYZkFSeDdydk92eG44?=
 =?utf-8?B?Q1NMR0cxVU1wMDZjTWtFdTBHNnM3aWtKelhlUjdBRk9GSDJZbUlWd0VmUGZE?=
 =?utf-8?B?QWk5c2JzUXloV1hHVi9pNXdBd1YweHJUcTJvcFlCRUx2blBBY3JRbHZxYUND?=
 =?utf-8?B?NkJEYTI4Y2hmM1h2c3FYY2tsMVRJNk9rWk1QZFcxUWF1R1NHWlRBbnI0OHIz?=
 =?utf-8?B?enBKWXVSeEpqSmRLUHpheEdRcGM1WDNSMEtRU1pocnk3aHFEQk1rLzFTdWFH?=
 =?utf-8?B?Slh1aWw3MmxJaUtRc0hpbEVRamZsLzdaZVNMTnBxcjgwaTl6dTU1Vlo0Zi9h?=
 =?utf-8?B?VDZiQXRGWVlvRXQwK1BvSjB3SGRZVENrYlYwSTdGcWZGWHlMMHd1VVIxWExP?=
 =?utf-8?B?cjM2cE9FNFA3dVNGa25vYi9QejJpQktPamE2YUMwczhQQy9zUXZFRmswNVBX?=
 =?utf-8?B?ZTJBbGQyVlVucHJWc0piaCtXMXZRV1psR0QvaTJiNFVXcmp2bGNxOUgzR0VO?=
 =?utf-8?B?aFZNWHJTT2wzRWh3cG42bFNjMTFEOVRPaUMzK1hYUUpobnFNVXYrTVhrczA1?=
 =?utf-8?B?cmVQUGR6U3dsMUxqUlRCeVF0Y3pwUE4vS0t2YTFHMDZPODVDY0h2amRMK1lB?=
 =?utf-8?B?WWNNd0pWQmpsRDBXOFZqSGFIUDlvVytyT0I1ZnZQWG5QTTkydjlKMS95RkhK?=
 =?utf-8?B?NVBLM3orMjROLzFWa0FvTTBRL2E2TGI2MlRCOCs4VVdITnNGTEs2c0wveThq?=
 =?utf-8?B?cHI1aU8vRnRhNjUzQzE5TGh5V0dGQzRCL0hzcWU4SytzMVlmK05oUkZ5U3Nk?=
 =?utf-8?B?WnFsRFhkaXo5bS8rYlJSeTZjN0F4dkFRa0F3ZG1jN0tMei93WXQ0cmxET0g0?=
 =?utf-8?B?RnV6QkhDZG95ZmNqZTZXUFdJZk9KM2k2QnZ3WTl0Z1drTVB0YkZNeXB1N2g1?=
 =?utf-8?B?a3Q0VnZBdGNkR1k4aC84bGdmM0plNnFuZktjQ3lmZ0FKbkJHam9NSVFnK2FW?=
 =?utf-8?B?VGtpTHN6VExQNFNHM2JDeXdnNnc5MVlJTjMyR2JSTDFGZzVZY2w5cllueTJH?=
 =?utf-8?B?WDlOdHJIcjFvSWdxZFhjWUx6K2tVWlZPNTNTdFpnQll1cEZHYS9MVVkzbUxM?=
 =?utf-8?B?d2tzWXdJc2dITytneStGeld2cFYxSTBCWUswSlMrY1hkTStsTUVMUTVVNXgx?=
 =?utf-8?B?dWRTdjY1bEJmZzU3ZFlTNm9lb005WmRTbGFnTmlYenpvNDFFWWcxRW81Rm9U?=
 =?utf-8?B?bGVER3J3YnhjL0hTaUdVK0szUnI4Z2lMN3BGa0htTjRVaVgzNHBVbUpGZlo2?=
 =?utf-8?B?ZWc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fb437b-9931-4400-81d4-08dc7f897f0a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 02:46:10.1009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgW9AIwUZdSQYH3NzbpjdDxRhRFpL58DabNV1zlTo6srrcrjM0WotmDC55xrQquJtfG7/NoTAJRVupinl38WOQQA/l6MgC2szNSaMqCdbHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8330
X-Proofpoint-ORIG-GUID: P7ufXF4knI0G_dA1EL1irzIMLwhF0Bqb
X-Proofpoint-GUID: P7ufXF4knI0G_dA1EL1irzIMLwhF0Bqb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=948 mlxscore=0 clxscore=1011 impostorscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290016
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 May 2024 02:46:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/239

--------------K1fa8LDePzid9rF10apKu8Ry
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 44T16jAv004312


On 5/29/24 02:16, akuster808 wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender=20
> and know the content is safe.
>
> =C2=A0Hello Changging,
>
> Martin sent a patch to fix this earlier.
>
> thanks.
> Armin

Hi, Armin

Thanks. I just saw Martin's patch on master-next, but seems like not all=20
the needed header is added in that patch.

Maybe there will be compile error for these recipes.

Changqing

>
> On 5/28/24 1:44 AM, Changqing Li via lists.yoctoproject.org wrote:
>> From: Changqing Li <changqing.li@windriver.com>
>>
>> Include proper headers to fix following errors:
>> | udp_client.c:41:16: error: implicit declaration of function 'atoi'=20
>> [-Wimplicit-function-declaration]
>> |=C2=A0=C2=A0=C2=A0 41 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 port =3D atoi(argv[1]);
>> | udp_client.c:52:12: error: implicit declaration of function=20
>> 'fsetxattr' [-Wimplicit-function-declaration]
>> |=C2=A0=C2=A0=C2=A0 52 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if(fsetxattr(sock, attr, label, strlen(label),0) < 0)
>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~
>> | udp_client.c:67:9: error: implicit declaration of function 'close';=20
>> did you mean 'pclose'? [-Wimplicit-function-declaration]
>> |=C2=A0=C2=A0=C2=A0 67 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 close(sock);
>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^~~~~
>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pclose
>> | tcp_client.c:55:16: error: implicit declaration of function 'atoi'=20
>> [-Wimplicit-function-declaration]
>> |=C2=A0=C2=A0=C2=A0 55 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 port =3D atoi(argv[1]);
>> ...
>>
>> Signed-off-by: Changqing Li <changqing.li@windriver.com>
>> ---
>> =C2=A0 recipes-mac/smack/tcp-smack-test/tcp_client.c | 1 +
>> =C2=A0 recipes-mac/smack/tcp-smack-test/tcp_server.c | 3 +++
>> =C2=A0 recipes-mac/smack/udp-smack-test/udp_client.c | 3 +++
>> =C2=A0 recipes-mac/smack/udp-smack-test/udp_server.c | 3 +++
>> =C2=A0 4 files changed, 10 insertions(+)
>>
>> diff --git a/recipes-mac/smack/tcp-smack-test/tcp_client.c=20
>> b/recipes-mac/smack/tcp-smack-test/tcp_client.c
>> index 6c0a474..b82b575 100644
>> --- a/recipes-mac/smack/tcp-smack-test/tcp_client.c
>> +++ b/recipes-mac/smack/tcp-smack-test/tcp_client.c
>> @@ -18,6 +18,7 @@
>> =C2=A0 // OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHE=
R=20
>> DEALINGS IN
>> =C2=A0 // THE SOFTWARE.
>> =C2=A0 #include <stdio.h>
>> +#include <stdlib.h>
>> =C2=A0 #include <sys/socket.h>
>> =C2=A0 #include <sys/types.h>
>> =C2=A0 #include <errno.h>
>> diff --git a/recipes-mac/smack/tcp-smack-test/tcp_server.c=20
>> b/recipes-mac/smack/tcp-smack-test/tcp_server.c
>> index 3c8921f..6de7ccd 100644
>> --- a/recipes-mac/smack/tcp-smack-test/tcp_server.c
>> +++ b/recipes-mac/smack/tcp-smack-test/tcp_server.c
>> @@ -24,6 +24,9 @@
>> =C2=A0 #include <netinet/in.h>
>> =C2=A0 #include <unistd.h>
>> =C2=A0 #include <string.h>
>> +#include <stdlib.h>
>> +#include <sys/xattr.h>
>> +
>>
>> =C2=A0 int main(int argc, char* argv[])
>> =C2=A0 {
>> diff --git a/recipes-mac/smack/udp-smack-test/udp_client.c=20
>> b/recipes-mac/smack/udp-smack-test/udp_client.c
>> index 23f3e00..3d2ee31 100644
>> --- a/recipes-mac/smack/udp-smack-test/udp_client.c
>> +++ b/recipes-mac/smack/udp-smack-test/udp_client.c
>> @@ -19,6 +19,9 @@
>> =C2=A0 // THE SOFTWARE.
>> =C2=A0 #include <sys/socket.h>
>> =C2=A0 #include <stdio.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +#include <sys/xattr.h>
>> =C2=A0 #include <netinet/in.h>
>> =C2=A0 #include <netdb.h>
>> =C2=A0 #include <string.h>
>> diff --git a/recipes-mac/smack/udp-smack-test/udp_server.c=20
>> b/recipes-mac/smack/udp-smack-test/udp_server.c
>> index 7d2fcf5..25ad1ef 100644
>> --- a/recipes-mac/smack/udp-smack-test/udp_server.c
>> +++ b/recipes-mac/smack/udp-smack-test/udp_server.c
>> @@ -22,6 +22,9 @@
>> =C2=A0 #include <netinet/in.h>
>> =C2=A0 #include <netdb.h>
>> =C2=A0 #include <string.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +#include <sys/xattr.h>
>>
>> =C2=A0 int main(int argc, char* argv[])
>> =C2=A0 {
>
--------------K1fa8LDePzid9rF10apKu8Ry
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#cceed0">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/29/24 02:16, akuster808 wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ac164a4c-c5be-4b19-ab48-546c0cc269c0@gmail.com">CAUTION:
      This email comes from a non Wind River email account!
      <br>
      Do not click links or open attachments unless you recognize the
      sender and know the content is safe.
      <br>
      <br>
      &nbsp;Hello Changging,
      <br>
      <br>
      Martin sent a patch to fix this earlier.
      <br>
      <br>
      thanks.
      <br>
      Armin
      <br>
    </blockquote>
    <p>Hi, Armin</p>
    <p>Thanks. I just saw Martin's patch on master-next, but seems like
      not all the needed header is added in that patch. <br>
    </p>
    <p>Maybe there will be compile error for these recipes.<br>
    </p>
    <p>Changqing<br>
    </p>
    <blockquote type="cite" cite="mid:ac164a4c-c5be-4b19-ab48-546c0cc269c0@gmail.com">
      <br>
      On 5/28/24 1:44 AM, Changqing Li via lists.yoctoproject.org wrote:
      <br>
      <blockquote type="cite">From: Changqing Li
        <a class="moz-txt-link-rfc2396E" href="mailto:changqing.li@windriver.com">&lt;changqing.li@windriver.com&gt;</a>
        <br>
        <br>
        Include proper headers to fix following errors:
        <br>
        | udp_client.c:41:16: error: implicit declaration of function
        'atoi' [-Wimplicit-function-declaration]
        <br>
        |&nbsp;&nbsp;&nbsp; 41 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port = atoi(argv[1]);
        <br>
        | udp_client.c:52:12: error: implicit declaration of function
        'fsetxattr' [-Wimplicit-function-declaration]
        <br>
        |&nbsp;&nbsp;&nbsp; 52 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(fsetxattr(sock, attr, label,
        strlen(label),0) &lt; 0)
        <br>
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~~~
        <br>
        | udp_client.c:67:9: error: implicit declaration of function
        'close'; did you mean 'pclose'?
        [-Wimplicit-function-declaration]
        <br>
        |&nbsp;&nbsp;&nbsp; 67 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close(sock);
        <br>
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~
        <br>
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pclose
        <br>
        | tcp_client.c:55:16: error: implicit declaration of function
        'atoi' [-Wimplicit-function-declaration]
        <br>
        |&nbsp;&nbsp;&nbsp; 55 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port = atoi(argv[1]);
        <br>
        ...
        <br>
        <br>
        Signed-off-by: Changqing Li <a class="moz-txt-link-rfc2396E" href="mailto:changqing.li@windriver.com">&lt;changqing.li@windriver.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; recipes-mac/smack/tcp-smack-test/tcp_client.c | 1 +
        <br>
        &nbsp; recipes-mac/smack/tcp-smack-test/tcp_server.c | 3 +++
        <br>
        &nbsp; recipes-mac/smack/udp-smack-test/udp_client.c | 3 +++
        <br>
        &nbsp; recipes-mac/smack/udp-smack-test/udp_server.c | 3 +++
        <br>
        &nbsp; 4 files changed, 10 insertions(+)
        <br>
        <br>
        diff --git a/recipes-mac/smack/tcp-smack-test/tcp_client.c
        b/recipes-mac/smack/tcp-smack-test/tcp_client.c
        <br>
        index 6c0a474..b82b575 100644
        <br>
        --- a/recipes-mac/smack/tcp-smack-test/tcp_client.c
        <br>
        +++ b/recipes-mac/smack/tcp-smack-test/tcp_client.c
        <br>
        @@ -18,6 +18,7 @@
        <br>
        &nbsp; // OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
        OTHER DEALINGS IN
        <br>
        &nbsp; // THE SOFTWARE.
        <br>
        &nbsp; #include &lt;stdio.h&gt;
        <br>
        +#include &lt;stdlib.h&gt;
        <br>
        &nbsp; #include &lt;sys/socket.h&gt;
        <br>
        &nbsp; #include &lt;sys/types.h&gt;
        <br>
        &nbsp; #include &lt;errno.h&gt;
        <br>
        diff --git a/recipes-mac/smack/tcp-smack-test/tcp_server.c
        b/recipes-mac/smack/tcp-smack-test/tcp_server.c
        <br>
        index 3c8921f..6de7ccd 100644
        <br>
        --- a/recipes-mac/smack/tcp-smack-test/tcp_server.c
        <br>
        +++ b/recipes-mac/smack/tcp-smack-test/tcp_server.c
        <br>
        @@ -24,6 +24,9 @@
        <br>
        &nbsp; #include &lt;netinet/in.h&gt;
        <br>
        &nbsp; #include &lt;unistd.h&gt;
        <br>
        &nbsp; #include &lt;string.h&gt;
        <br>
        +#include &lt;stdlib.h&gt;
        <br>
        +#include &lt;sys/xattr.h&gt;
        <br>
        +
        <br>
        <br>
        &nbsp; int main(int argc, char* argv[])
        <br>
        &nbsp; {
        <br>
        diff --git a/recipes-mac/smack/udp-smack-test/udp_client.c
        b/recipes-mac/smack/udp-smack-test/udp_client.c
        <br>
        index 23f3e00..3d2ee31 100644
        <br>
        --- a/recipes-mac/smack/udp-smack-test/udp_client.c
        <br>
        +++ b/recipes-mac/smack/udp-smack-test/udp_client.c
        <br>
        @@ -19,6 +19,9 @@
        <br>
        &nbsp; // THE SOFTWARE.
        <br>
        &nbsp; #include &lt;sys/socket.h&gt;
        <br>
        &nbsp; #include &lt;stdio.h&gt;
        <br>
        +#include &lt;stdlib.h&gt;
        <br>
        +#include &lt;unistd.h&gt;
        <br>
        +#include &lt;sys/xattr.h&gt;
        <br>
        &nbsp; #include &lt;netinet/in.h&gt;
        <br>
        &nbsp; #include &lt;netdb.h&gt;
        <br>
        &nbsp; #include &lt;string.h&gt;
        <br>
        diff --git a/recipes-mac/smack/udp-smack-test/udp_server.c
        b/recipes-mac/smack/udp-smack-test/udp_server.c
        <br>
        index 7d2fcf5..25ad1ef 100644
        <br>
        --- a/recipes-mac/smack/udp-smack-test/udp_server.c
        <br>
        +++ b/recipes-mac/smack/udp-smack-test/udp_server.c
        <br>
        @@ -22,6 +22,9 @@
        <br>
        &nbsp; #include &lt;netinet/in.h&gt;
        <br>
        &nbsp; #include &lt;netdb.h&gt;
        <br>
        &nbsp; #include &lt;string.h&gt;
        <br>
        +#include &lt;stdlib.h&gt;
        <br>
        +#include &lt;unistd.h&gt;
        <br>
        +#include &lt;sys/xattr.h&gt;
        <br>
        <br>
        &nbsp; int main(int argc, char* argv[])
        <br>
        &nbsp; {
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------K1fa8LDePzid9rF10apKu8Ry--

