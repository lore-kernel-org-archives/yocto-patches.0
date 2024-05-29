Return-Path: <changqing.li@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB02C25B78
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 02:50:54 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.4713.1716951048771275093
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 May 2024 19:50:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=6879088241=changqing.li@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44T1RUZv006602;
	Wed, 29 May 2024 02:50:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yb56xbqx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 02:50:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjhauhuQdMUdJp7rqxe98Iu+Euj6I2CIauCNvHTdal7wrQadp9mwSDiatzdB1CfDCLEG8/iiUPRI0+Vi6jTXdn+DelCmVLwqA6XWL91jXWg/zEgl73G/PZIeHh/n8r5jgeko1Sj1yptQ9O1EAVZS/SbN0TIgDdJpdManjHTZX2Ijya7i2ppjl/x4jRyKlcWIiEgSEf5TLOS69lfZNWIYSZgUDx/fvsI/MAXoMGmDq2knylRAa5MKGPJQ/7kFdrH5LT5a/YEIqy+AbjAhfE+UtNwHuJIcRCtYbxYMl9TMlSKIR+oYq+owRheyhzAdjutqR/+xNIrmL2aDl4jjxtwq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GX5Sg+gOcLWEiNcNt9xURqB3DZDDqPMA+8ZlIS/3+bs=;
 b=ErqpA5yZ0lmLW8AYgkOKrXQTkmp6ukmGG+Iw4eUSfZ5QDBT8CPPOLbu2UXQ+bMQn0CD9+ke7y9vqttQbQrQ0+9AlIP8kcBYRSfykEgZmuCmvb/x/hhUWLPl39vu98fdI+aT4GVbExaFS4fs4gyM/MaVj4HV0i1gAQqJb29CZx979GENXzPo9Mgxk94ViXEuwzyUquqf+x6eDFzl11LPoRFe1xJ9BbYN+1fzcufEy7JRAo70bYRfHxXrQHVj3wi2aKwsyWAf3m3tyDtnvWtAMraQvLQtbhWBlp5ppnjoRJ6rz4VU8MrOF0JuyuvCwKFsX9ySAt73PsMRRl8Co1OJGyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB7297.namprd11.prod.outlook.com (2603:10b6:610:140::19)
 by PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Wed, 29 May
 2024 02:50:42 +0000
Received: from CH3PR11MB7297.namprd11.prod.outlook.com
 ([fe80::9196:38bd:6b0:2d0b]) by CH3PR11MB7297.namprd11.prod.outlook.com
 ([fe80::9196:38bd:6b0:2d0b%4]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 02:50:42 +0000
Content-Type: multipart/alternative;
 boundary="------------0RLNqmRcGxXi1nCzv4tr2uDN"
Message-ID: <bb06fd56-1a73-42d7-b6d7-98032d57e5b4@windriver.com>
Date: Wed, 29 May 2024 10:50:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH V2] scap-security-guide:
 upgrade 0.1.72 -> 0.1.73
To: akuster808 <akuster808@gmail.com>
References: <17D390C542482B45.24533@lists.yoctoproject.org>
Content-Language: en-US
Cc: yocto-patches@lists.yoctoproject.org
From: Changqing Li <changqing.li@windriver.com>
In-Reply-To: <17D390C542482B45.24533@lists.yoctoproject.org>
X-ClientProxiedBy: TYAPR01CA0137.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::29) To CH3PR11MB7297.namprd11.prod.outlook.com
 (2603:10b6:610:140::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7297:EE_|PH0PR11MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b7b5481-0617-4f4d-ae7c-08dc7f8a2129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UVo4RW1yMGZKR0hvamRVVTc2aFo5VXowZUowQmJnZ3U0bk0xRWZNbDZzcDRx?=
 =?utf-8?B?K0h2WTlCSEQxQU5QSEtwUnlmZFEwZHRUT1FsV2s3ZHVqNkx3bTlxTWNsMkxQ?=
 =?utf-8?B?UkNxSFQveU8yb2N6d0lESmI0S1RaUDE5UDRYZzNHMCtpVytuek81cjVGZ2s3?=
 =?utf-8?B?NnBrSHMwZEhtbkFHS3BIbm5ZTnpZYVBGRzZWWXRzWlJSWUpudk0vYWJqelIw?=
 =?utf-8?B?L2F1bEFmbjdRVHhTTkMxcWpQcEQ2em9wMTB4dk85d0tiUFAvRjlWQXRGMGVI?=
 =?utf-8?B?eGkyZGNvellCNTdFZXc0NzJzQzRiUVpGdDdqa2xrZElzbGhvNk1XT2NTTzI3?=
 =?utf-8?B?L2VWNUxiTC8zN2NDQ3dObUUzUUREMlA0UFJ2THhSeDhFWWk5cHczU2pqajg4?=
 =?utf-8?B?MWhOZjA2RDlPM2NJZzhIeE0yTGpQK3BDYmhwWXJGcEZBZjFCdll1eTIzOEM2?=
 =?utf-8?B?SUpqVkU3RlIzMlk3czlMNU5CRTBJM0NMWUk2UFZJMHBORTc0UjlhRGtMTzZa?=
 =?utf-8?B?T2Y3TU1KcWpPMWNtWnY1V1N6MGo0T2xQRzI5VmFkRjA3dVRjaytLNStXQita?=
 =?utf-8?B?UTF1RmV1VHJNZDViVnd4QWxWVE9LVFM0eWpuMGMxdG1td1NGS1RROElOTVIy?=
 =?utf-8?B?WkFmSXppSFk5dnlkalhQQnNMZC9qblFsNUVISmVGWDZuanVJRWgxcUZzN2hW?=
 =?utf-8?B?M2tyN3FSSzB6TTBHdXRtbzBiUFVMZXVxODZ2WUVVYmVaZDhkS1lIMEExdk5O?=
 =?utf-8?B?eElVNDV0d1BrWU93MmdicmFoTXNjOW80VTliTkUzMXF5bUM3cEczMlRvZjJl?=
 =?utf-8?B?V0N5Ym8xcDEzWVdFQzlERGZCdkpPZ2g1MUFDSEozYy91dmNuVisvVlZPUGVq?=
 =?utf-8?B?RENRaDJ4ZUpCZURDeWdMUFpJa2wrN3h1ZnZXeFFGWktLUFkyUXpOODUzSEtR?=
 =?utf-8?B?MmJiTDZCRCtHWHc5WWE4ODNyYXBNUUVOTk42UDFSOVV6cHR3b1dnQ3Jubitn?=
 =?utf-8?B?cnFNanplL3N0eDM0S2NINmphbWNhdVcyQjh6dVZQVGJaa0wwSHQycE5DZGZJ?=
 =?utf-8?B?VHcyQjhxQXg4cUd1YlRhWFhyODdtVW1LdGprYkZ0R2xsU0xQY1B0UXVFalVa?=
 =?utf-8?B?NTZ0dHVGNmRLUGl3Q0hMbzhRMlNXRE5hMFMyVmZENjRtL2xYSGhLYzJhSUZ3?=
 =?utf-8?B?STBmSGxFSmhMdXJDaGI2Tyt2dVBHTTNzamVHZkJRTktVdU1kZmE0MUpPZ2w2?=
 =?utf-8?B?WGFrZFNMRmtvRVU4QjlCMkd1K2VKc3IrWUp6eGRMNmpZbGVwaGVLNlRGQ2Jr?=
 =?utf-8?B?T2VRM0tHNWtsM3NMVDNmWFF4UDgrUzhLR1hOMzNBMmczaGpCQVArRUlYVUFy?=
 =?utf-8?B?ai9TeWhNdW82djVOVjNZcUI5a1BoT2FmTHVTNDVxQTBrS1BTZ2pJYU5DN1hm?=
 =?utf-8?B?ZDBHZzJXTkhIMkpqM2lja1ZLUU4vc2ZTaEh4aUZwWHhnM3ZIZkM3bDhXb3lr?=
 =?utf-8?B?azQ3a3hyMDc1L0hscllTY0JVeG83cXEvOHJBelFHQ25zOFRsMnVTM3NCenJE?=
 =?utf-8?B?RVd1V0l6bjlPbngwTU1uSlRsWFcwSFNGWFZOazBxSzNWRFNCZndVd0FFL2ZH?=
 =?utf-8?Q?1cHGoih3c3glFRwCKBFQaQwZ2MPut4r9xLq0gF0Xszc4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cjBDUVA0QkVWN05DTC9vR0JiMjdDZlNZWUZpNGNIUFFTVzhidTM5a1BGNytp?=
 =?utf-8?B?eE5uSmNNNkRlQ1MxcHBGU1pOM0dqeW9BV0VZYUlqZHB3UnZMaTd3NzhGWVla?=
 =?utf-8?B?ci9mN3ZTMUlPMnJldlY4UzVDUWFtTXRPVGRYa0lFdC9xMFlZVVRpdnoxUDA0?=
 =?utf-8?B?TGNMbGwxWDF4VWV5YVQ2UWpaRFkxQnUvWmFlVS9YRGZHN1QzbUc3WFhCQUNX?=
 =?utf-8?B?alcxWmFndHN5bHYyMFVjVUl2YUw1WmJXU0t2YVZZdHpScFVWWjJpZVJhR250?=
 =?utf-8?B?aXJBQW52VFQ3eHVhTWhwa2NIL3FCN0xyTzdVMkFqcmlqZzNxZ2RmaWdhSFNs?=
 =?utf-8?B?bHFYdUJaZ2liNVlrcTNidUxqRXdsdnp5MEZ3ZVc3RFN0dzYrSjFmMlp4N3NY?=
 =?utf-8?B?UXgxaTIwNHJGVkJOWkQ4RlN0WXliUS9xM0FGSGlhYnM4ZVlkNzR2UE1rUks3?=
 =?utf-8?B?ekFGajRzL0NOTGRycDB5QjloalJWaExLTVEzQy8vNGw0OWVRbjFxaHAxa1FC?=
 =?utf-8?B?WXh4N1pLbTNKUi9tV0RXTmJSZlFNNllqQkh6MlQ1SlRXaW03aDBtUXAzSkRX?=
 =?utf-8?B?UzI5QXdQZlZydy8xME00b0VQOEg4VFFsWTA5dy9CR0RmMlV0d3REWEdwMks5?=
 =?utf-8?B?c0FrK0tlejN3ZVg4RWlwcXVLNmQrTlZKTVBHZlZGNU8xKzZUVTkrNmFOS1Zy?=
 =?utf-8?B?M3FSSVJZTE9kM1QzNTQvWmdNNHhmQzlCWmRXcnBIdGxveWJuckQvR0tJdXZC?=
 =?utf-8?B?YVpoaElKaU1SSlh1VktwaUc3NDlCc1c3REtqSy9UaFhvRHBDT2hWaHpoY0Zs?=
 =?utf-8?B?QnB4MWJUTnE3Nk1DZXdqQ0dMOStCa3ZqU0l3ckZmdzJhNmY3WEFqT2lnK2lu?=
 =?utf-8?B?c0xGQTNxbUZyZWxTdFNWbVFRUEpXamFFNUFUNjA4NWRrS0c5azdZM3lPRnV6?=
 =?utf-8?B?SzdHOWVQS1RaWDQxdzE2cmlyQXZnamxaMEZGWVZ4MG92RWdWaEVoaTM4Vlor?=
 =?utf-8?B?TWpleVl1R1VnaUU4NnpkV080MjZHZVd1MHFkTjBjZ3lKSzZRM2tLdUZGMjVj?=
 =?utf-8?B?T0Y5Vmd6Z1FzSkRaZFFTRHI5WjJrbGlGdFpKSG9ZS2N0UC93YTBZTEVZV1U0?=
 =?utf-8?B?Y1lWb00xZWlyOUN4eUEyZWNpQmV5dnI3UVNxSFNTSDN6aXo4UWo5c3BzdXRW?=
 =?utf-8?B?V0dpR0NSZjhVdHoyZVVROHpMeXAxbXJhSENaK1VUYWFmOWxCcEFtRGg5Y2h1?=
 =?utf-8?B?dTJWdSt5OURvV1hXbTVaUmVybHZkR09jRlJqM0gxcFdVUjRLY2I3MDVvVWVw?=
 =?utf-8?B?bUdJZUtTWmVBYnhtdjQ2cGM0VTVzMmFrNmhnaEFmTkhHc2xoaUwvKzQ5YTlK?=
 =?utf-8?B?U2wwZUNFNEpZTWVUbnArNE0zMlJmY3cvSEtvY2ZuUHk4NEN2L2kzV3grZnB6?=
 =?utf-8?B?bzkxY3Z6VFE0K0ZDTDhvbzNSamlITEMxV2ZCZ0loSGN0SnhXa25MaVowTVJu?=
 =?utf-8?B?QWQzeTNUR2F6ZWlUK1NwV1M1MDVrUmpWNzY1RzF6c285YkxNYVV4SzlYTHNF?=
 =?utf-8?B?UmEyWms4NmxzbS80V3BsaXBpcGhJS01GRWVsRmdaY2hYVEhKS2I1VTZPcGtN?=
 =?utf-8?B?alJOUjcwYVV3SkZSQzFXRXFxelYvU25hY1VWcTM0S3BjZU5mQWFNUmJiZEtT?=
 =?utf-8?B?ZlZUR1dyWHhKMkYvNVAwZXZvOXpaWGJSaENnTU9oMmRjaU4xZXY1OUlvazRQ?=
 =?utf-8?B?VUtWcGdHMDhOSFByWExrQWJLRUFMdHVwS3BOT3pJeDdIeVN3UFFRMERFSFAw?=
 =?utf-8?B?S2lMNlNHZVh2bG9QZkpVcitrRG90RUF5NEhxWW15TkNQZHV5UmVFc3dDU2N3?=
 =?utf-8?B?ZUpJdDZsZm1zVFdRUEFWd3R3eTVXb2Y1NjJuclhJUmFmMW85TGZhYjloQ3Bu?=
 =?utf-8?B?TlRDWVkydWVBVWV2WlVsTkMraUpZeFhUSjlVTUw3djFhOXR4M2JSSE9zcFlr?=
 =?utf-8?B?ZW5nR0lMblBtT3dIRHZoQkxDKzd0cVBRWXUwVUIrTXFvQ0JubytpTGpXYjc0?=
 =?utf-8?B?eG9UU3M5SWpzbGpwQVFMVmh5dzJMbmlVbTFrRHBlRDBpYlViTGNDQnNHVUR0?=
 =?utf-8?B?VlpHMW5uMzlQWGUxZ1J6V212UEJHYWVBc2VMRHBqblUxMSs5UkpVUGVmSHhD?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7b5481-0617-4f4d-ae7c-08dc7f8a2129
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 02:50:42.0665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v99joWkmvJNFY1L7PyklbjzcyvuxOza8hO3b7/AU1gmgy5h+XkZYYdsYU4U8G9LdoYkGTZwLos6PzjZYOC5pfG0DsS9iC68XFoQyDXDhx6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7522
X-Proofpoint-ORIG-GUID: z0jALgKkWsSXDOKsrLU3V3PpD92A9s8I
X-Proofpoint-GUID: z0jALgKkWsSXDOKsrLU3V3PpD92A9s8I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290016
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 May 2024 02:50:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/240

--------------0RLNqmRcGxXi1nCzv4tr2uDN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 44T1RUZv006602

Hi, Armin

This patch rework Yi's=C2=A0 patch for upgrade scap-security-guide, so ma=
rked=20
as V2.

Add the fix for WORKDIR -> UNPACKDIR.

//Changqing

On 5/28/24 13:44, Changqing Li wrote:
> From: Changqing Li<changqing.li@windriver.com>
>
> ChangeLog:
> https://github.com/ComplianceAsCode/content/releases/tag/v0.1.73
>
> Signed-off-by: Yi Zhao<yi.zhao@windriver.com>
> Signed-off-by: Changqing Li<changqing.li@windriver.com>
> ---
>   ...security-guide_0.1.72.bb =3D> scap-security-guide_0.1.73.bb} | 4 +=
+--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>   rename recipes-compliance/scap-security-guide/{scap-security-guide_0.=
1.72.bb =3D> scap-security-guide_0.1.73.bb} (96%)
>
> diff --git a/recipes-compliance/scap-security-guide/scap-security-guide=
_0.1.72.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0=
.1.73.bb
> similarity index 96%
> rename from recipes-compliance/scap-security-guide/scap-security-guide_=
0.1.72.bb
> rename to recipes-compliance/scap-security-guide/scap-security-guide_0.=
1.73.bb
> index 3d739c2..62b1c63 100644
> --- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.72=
.bb
> +++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.73=
.bb
> @@ -6,7 +6,7 @@ HOME_URL =3D"https://www.open-scap.org/security-policie=
s/scap-security-guide/"
>   LIC_FILES_CHKSUM =3D"file://LICENSE;md5=3D9bfa86579213cb4c6adaffface6=
b2820"
>   LICENSE =3D "BSD-3-Clause"
>  =20
> -SRCREV =3D "7fb44f78bf33232aad587e87a799afcf576f9b47"
> +SRCREV =3D "2bf9d43840d3ed36a25262d4f45a4015f9b77d8d"
>   SRC_URI =3D "git://github.com/ComplianceAsCode/content.git;branch=3Ds=
table;protocol=3Dhttps \
>              file://run_eval.sh  \
>              file://run-ptest  \
> @@ -38,7 +38,7 @@ do_configure:prepend () {
>  =20
>   do_install:append() {
>       install -d ${D}${datadir}/openscap
> -    install  ${WORKDIR}/run_eval.sh ${D}${datadir}/openscap/.
> +    install  ${UNPACKDIR}/run_eval.sh ${D}${datadir}/openscap/.
>   }
>  =20
>   do_compile_ptest() {
--------------0RLNqmRcGxXi1nCzv4tr2uDN
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#cceed0">
    <p>Hi, Armin</p>
    <p>This patch rework Yi's&nbsp; patch for upgrade scap-security-guide, so
      marked as V2.&nbsp;</p>
    <p>Add the fix for <span style="white-space: pre-wrap">WORKDIR -&gt; </span><span style="white-space: pre-wrap">UNPACKDIR.</span></p>
    <p><span style="white-space: pre-wrap">//Changqing
</span></p>
    <div class="moz-cite-prefix">On 5/28/24 13:44, Changqing Li wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:17D390C542482B45.24533@lists.yoctoproject.org">
      <pre class="moz-quote-pre" wrap="">From: Changqing Li <a class="moz-txt-link-rfc2396E" href="mailto:changqing.li@windriver.com">&lt;changqing.li@windriver.com&gt;</a>

ChangeLog:
<a class="moz-txt-link-freetext" href="https://github.com/ComplianceAsCode/content/releases/tag/v0.1.73">https://github.com/ComplianceAsCode/content/releases/tag/v0.1.73</a>

Signed-off-by: Yi Zhao <a class="moz-txt-link-rfc2396E" href="mailto:yi.zhao@windriver.com">&lt;yi.zhao@windriver.com&gt;</a>
Signed-off-by: Changqing Li <a class="moz-txt-link-rfc2396E" href="mailto:changqing.li@windriver.com">&lt;changqing.li@windriver.com&gt;</a>
---
 ...security-guide_0.1.72.bb =&gt; scap-security-guide_0.1.73.bb} | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.72.bb =&gt; scap-security-guide_0.1.73.bb} (96%)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.72.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.73.bb
similarity index 96%
rename from recipes-compliance/scap-security-guide/scap-security-guide_0.1.72.bb
rename to recipes-compliance/scap-security-guide/scap-security-guide_0.1.73.bb
index 3d739c2..62b1c63 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.72.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.73.bb
@@ -6,7 +6,7 @@ HOME_URL = <a class="moz-txt-link-rfc2396E" href="https://www.open-scap.org/security-policies/scap-security-guide/">&quot;https://www.open-scap.org/security-policies/scap-security-guide/&quot;</a>
 LIC_FILES_CHKSUM = <a class="moz-txt-link-rfc2396E" href="file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820">&quot;file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820&quot;</a>
 LICENSE = &quot;BSD-3-Clause&quot;
 
-SRCREV = &quot;7fb44f78bf33232aad587e87a799afcf576f9b47&quot;
+SRCREV = &quot;2bf9d43840d3ed36a25262d4f45a4015f9b77d8d&quot;
 SRC_URI = &quot;git://github.com/ComplianceAsCode/content.git;branch=stable;protocol=https \
            <a class="moz-txt-link-freetext" href="file://run_eval.sh">file://run_eval.sh</a> \
            <a class="moz-txt-link-freetext" href="file://run-ptest">file://run-ptest</a> \
@@ -38,7 +38,7 @@ do_configure:prepend () {
 
 do_install:append() {
     install -d ${D}${datadir}/openscap
-    install  ${WORKDIR}/run_eval.sh ${D}${datadir}/openscap/.
+    install  ${UNPACKDIR}/run_eval.sh ${D}${datadir}/openscap/.
 }
 
 do_compile_ptest() {
</pre>
    </blockquote>
  </body>
</html>

--------------0RLNqmRcGxXi1nCzv4tr2uDN--

