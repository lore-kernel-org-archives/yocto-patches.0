Return-Path: <changqing.li@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C309C25B78
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 03:18:34 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.5167.1716952711373804261
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 May 2024 20:18:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=6879088241=changqing.li@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44T2U1Ea026128;
	Wed, 29 May 2024 03:18:30 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yb56xbrqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 03:18:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eujnf1rUmTmSDmpBv0fJ5til7ET+1w8Xx2mqYRGVSHIoaCA/8q7auU4Klh8zN2Yi+WniFkzXI3mIWAQkEuDijtbRQ0xTjnyj7mH38dtVyi64Rl2v1Nyu4SYTvJxUcLxG8RYLpFI6jDYJYJSx2BNd6eQl5z7kJ8Wu9ZFiq1Jv99RmTxcVvNOuqmFcedtxzHPp2UNXLY8iHxE0BhjMYFUaJIQIFjuJqlC5wbFq4FZEFOnGB23/j4BXb9PMKWMLgXAM7fVAgL0n7cirEVIYj0mDideZKnJx0EU2FnR9v6GB8Khv3izXq3f0DyNVRoOh0ANay1GZ5h+Chc2duZK2wVLADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjVsnO/B3fkjvu7tsoheJa/Z9wmKVBM0tBilHtwOpRA=;
 b=ijn5MVuJsxbWpVCpzinKZjLxm8v59ceqSNh851mtm3ANpvBoM0YiRMBSmTTA9z5GpvEPA41nEA3Nr0Q51DauX3jOltxGmMSkw2GtqAhyMrx13vVCFkU0SGqtfIjPdxOWKbXeFX51qBCKoxIEcW0Hz/6fTNbiwRa+atow7KCQwETT5QVSijpqxKqf7F6YcaA4agvREXLvcLKFEFAz6zw7B3egN2Da5yULlTAGW9nKE2VO0EsafvwXtJr9wpMHMUIpctefvq3NB/1zOj5edCw20gIbzof6mcKbKcUh4jCaxN68pY/ZcEi3nQdtcjGv9+rxYu3DypCLFVD9z+XA3/q9RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by IA0PR11MB7883.namprd11.prod.outlook.com (2603:10b6:208:3de::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.26; Wed, 29 May
 2024 03:18:25 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c%4]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 03:18:25 +0000
Content-Type: multipart/alternative;
 boundary="------------R75FD7eQkhaMGLhpBHOOW98S"
Message-ID: <05fb243a-d572-4380-87f9-76546a6b08ca@windriver.com>
Date: Wed, 29 May 2024 11:18:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH V2] scap-security-guide:
 upgrade 0.1.72 -> 0.1.73
To: yocto-patches@lists.yoctoproject.org, akuster808 <akuster808@gmail.com>
References: <17D390C542482B45.24533@lists.yoctoproject.org>
 <bb06fd56-1a73-42d7-b6d7-98032d57e5b4@windriver.com>
 <854527e2-c51e-4580-92f6-d498088975f6@windriver.com>
Content-Language: en-US
From: Changqing Li <changqing.li@windriver.com>
In-Reply-To: <854527e2-c51e-4580-92f6-d498088975f6@windriver.com>
X-ClientProxiedBy: TY2PR0101CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::28) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|IA0PR11MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac19e06-87ba-4725-3977-08dc7f8e0056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZFE4cGlaMjRoWjZveEpDWmlRbGRrbTgrckQ3U3pCMnVGNmIzcTFxd3c2T1Rw?=
 =?utf-8?B?OGUxSEhRRzUvb2RYRGZtNERscTBROEpIeERHbDB4cTVMNmIyQ1hwTytnNllN?=
 =?utf-8?B?ZlVxbHZvckF4bUxTZkpKaFlmeEh6aFVuWkIxc2R1RUNLV0dGNGF6NGUrV1h2?=
 =?utf-8?B?UVNJSWVsUHhrOVNRU2VHSFA2SzhPd09sMVVsY3JGRWo0WGpOTVJlSHhlbmw0?=
 =?utf-8?B?K25vUkZvOENON2dhY29mYVozMzZBWFZUVTdXMnZUZ1VWNlg0UnY2YVBSK2R2?=
 =?utf-8?B?cVJDQzhueE4xODg4am9vVFBtbEJOYi9ZNzF2Q01JbElvWFl3YjU0WkNwTHpJ?=
 =?utf-8?B?amttY3E0TExCZ0hiWXN5amJHMWZxYzQvOWlaOFdJT0JuY0d2TGlTQ3pOUmVG?=
 =?utf-8?B?OEtJcDlmelZjdzJHS2wzbmx0emFZanFNN1VObzJ4eDQrck84bWw0LzdnR1oy?=
 =?utf-8?B?Vnlib3pMbnRBR0p5Vy9TSFM5b2hMT2Z1ZFlFbFViVjBibEdHUW5Ga2pvcFhp?=
 =?utf-8?B?NnJ2TTFQb0cxODV6RFJkelJMN3RxeW5oYTB0VzlWQStaakdzV1ZEMCt6NHJZ?=
 =?utf-8?B?a1QvTTM2cnh1dlZIVVU0ZlpIaCtGR1VzTU5tdDRNcmllM0p4REd3YVRBVGk4?=
 =?utf-8?B?RjNYbWFYQW50UHZBcEhzcVRsR1A3QS83UE9JNVAwUEZib01BbDIzTDdiSGxR?=
 =?utf-8?B?SU9RUjRmbkh3Ym0rSFkwTXpwWnEwMmdtUHcyWmthSzE4Z01PZWwrUDFnZk8r?=
 =?utf-8?B?M2YxbnZXSjMwRDY0NnJ4S0p0dkFSUjVGa3llY0Yvbzc1ZW1RS0ZFM3U2Vnkw?=
 =?utf-8?B?TmZGcm5pN0xVK0xCT2pVTTI4Z0hidFhFcWw3bEo5TUp1YW5Hdm42MGFJMlMr?=
 =?utf-8?B?WDdJb0J4UG5GeVhFallkVXJyYzcwYUNQT1VXQnJmc1h5dHFGQUlhNXJjM1U5?=
 =?utf-8?B?NkJhM3ZVOVhkOXZROFlTOVZLZWxnd2Q1NTNpZWtOdzJOeXVGYWkyTkhvMFpj?=
 =?utf-8?B?UGxKT0dGU29PSWQrQXpRL01xbVFwbURINnZEQXNuWTB6c1hhTXhQZ0ZGWE52?=
 =?utf-8?B?cXdwU2drV3g1N3JpbUxFZ3BjaGR4MEVnaC9Mc2xSQVc1WXAzV0dJMWN0TStp?=
 =?utf-8?B?Z0o0TTAvWjB6cE9YZW9GYmtaNDF2T1hBMmx6MnNwSFJvd3I2NVpGWGRISEg0?=
 =?utf-8?B?cHJUam1zbXljS0FvQ096dXlNRXAzemZkR0pSa2c1TlJMdDhnOWNqWjhRTHdG?=
 =?utf-8?B?UEhDVzl0NmtTQXpMREkrcm9PejBYTGJ0S01mUExJUVJyQ0xQQzdrWW1nQ29h?=
 =?utf-8?B?VGNjUjlOSEJYaGFDN0pKZXZOTWRROW42QzZjZDhBZjNnOUJseFhoQzBpN1lx?=
 =?utf-8?B?Z0FPT1k2blM1Vm0yMlJTeXgvQ3AwNURUaGJvS1h6QzBhQjNJV2lKYXdBTTVE?=
 =?utf-8?B?cVBweVU4dGFWcnZuMkNERHdnTTVaWmRPNmVHNlZXZmE1SXE2VXp4SU00UUJN?=
 =?utf-8?B?d01naGRBczM2UTcyK080R1R0dVd0Y1RjNC9hb3JNVXkyWDBjdHZSRGdmZDFk?=
 =?utf-8?B?YitmeTQwSjNsNi96d0cwaHorOVdiTVlIcGMxUjNveU41cDdKc1hKT2lUUnhM?=
 =?utf-8?Q?XaVb+Q2mJ2O9GSLaETIPRbGn1qxbPdAc35wbQnUexk48=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZmN2VkE4YUVnQTVvSjhMK0lSTVhOVng0UmdnWEdXekhDSVAvcVhxRDNQS3Aw?=
 =?utf-8?B?OWh0bU8zK0ZQeCtlTkhHZzBkUEVYTFQ2WHNjbi9Jb2s5VUNLMVpPcWpDNXk0?=
 =?utf-8?B?ZnUvUVRlbGFlVHY2YWtEd2t6RVZ2a21SMFVlYTI0M2UvV2dtOWJrU3liWDU3?=
 =?utf-8?B?Rkg2VDJVUVlEZWp4MXYwVVhpZnYrOVJZQXlxYVByVlZYYWgyYVBmYVpZeUtY?=
 =?utf-8?B?SExiV0VWWGhkZFFaaUxocG5nTnYwUWlQemo3N0NnRUVoVUgyWVpsOXdYRXhy?=
 =?utf-8?B?SXJrd21nZnl3RXg2VFVrUTFWWmpqZ1hqUVpwOFJPbC9hdmh3dHI0Tnp4V2cz?=
 =?utf-8?B?SmpEdnV0QzA0RVdIZnQ1dzExWFp6QVl4K0dLM2VjbjZ0YTdOaDRrY1BSM04y?=
 =?utf-8?B?eTAzS3FONWt5T2wwYXdCaXlMRzBMMVJMUWM3TGEyTXFBSTNGR1ExVlFOMXI2?=
 =?utf-8?B?bFhpKzF0YS9iNzBYTENJLzJnK2pmQkZRQkJvYldqNlA2RUo5QU1RWjAvSFRk?=
 =?utf-8?B?RnE2QzZQZzhTQmRUeDFJVHhIR0VleWdObFpWSGVleXluU2haOWRrdlhOQ0NI?=
 =?utf-8?B?UHhjd1lwWWhPQmNNamxLNERiUjIrUENIN2YxelZyQTEzU2VVcGxZdElkYWFw?=
 =?utf-8?B?am5MdUtwL2FEdDZzbHRXdk1yT0pCUEkyL2V0YU5YOVJKL0ZaWXNCclF2R25M?=
 =?utf-8?B?VWFGUVdnL3VJWVk1dTUzMS9tT2xLbVRCK0Z6bi9kLzc3eGNLOUdqOGp5cHli?=
 =?utf-8?B?Uy82Z2NXOTFLL2V3Q3JPQ2tYL3JUdC9aYTNJdHBTbUJyR1JYcFlHQW1sL3hp?=
 =?utf-8?B?cGJEb0toMUFsYTFRQVlzTnNkV1VFcDZjdDNPcTFGbjRQZTEzcm5lSUtKK0Rw?=
 =?utf-8?B?bkk5SlRUSlVMMGZ4LzhvRWo0azlrY2xtQjJabityclQvY3p6OWpuRVJwQmtD?=
 =?utf-8?B?OVlnTkZWUGNDZFN6TnNPVjJhNGsxKzJKeUtpUmJMcTNXaHVOdW1LOUdtaFFl?=
 =?utf-8?B?bU8ycVlMcVlJUkIyMXE2alNHMmpPUHdXWU5IME1kM3VzeG15WmJMOWFpbU9r?=
 =?utf-8?B?MVhrZVFQMmhmVXJZVzFINSs4Qy9KZDkvcUEwTlVCdnlWai9iUk9hSEFKOEJI?=
 =?utf-8?B?UjExVDY5Q2RlazQ0QzBZbUZDclcwdEZBK2JFUEV1Mks3elJGSkNjbnB2NUlk?=
 =?utf-8?B?UExodjZkMGJZWm42cDMvV01hUWFMbE5PMlMvRmJQK3N4NXdsUDIwRUxnK0xZ?=
 =?utf-8?B?Tk82MFViQnFOU1VOR1pWVWllcnJFYzBTOHVnSWRUdzQvZS9ZcHNHVVVLTnZh?=
 =?utf-8?B?dkxpUlNyUkxaeEhDT0s0a1hqcDNMUUJvWXBPM2krSFJ0dE5XbmViV0xydWpr?=
 =?utf-8?B?cElRUVIyNkhZV1E3cjJMcUs3VnE1QnJtNzVtdDJlWDlFQkIvcVVFc1l5MWNz?=
 =?utf-8?B?ZTVpY0JWWDFkRHpDZEM3ZEdjWngrZnArT1NzWEU0R3BkNnVXN3EwOWxMaFNT?=
 =?utf-8?B?Z1I1Rk9hT0ZWdExWcjZVUFc4T0Via3hPK3IxVnA0R01RU0NZRXVaRjBvYm5M?=
 =?utf-8?B?M0YySm5vYUxEaFprZHlSWWdsNzBETUR3QjBIek4wRXdaUS9WbEdyRThvNElS?=
 =?utf-8?B?WEJhQVIzd0xmVFA1MEc2ZEZhZlhTZytudjRHeDFFR1Y2bWVQdmFJTlh2ZXpt?=
 =?utf-8?B?SXNLcG9PMEFieDdBUEM5WWltTVU3ME9uMjJTSUNWcVRLZGlZTTZaWm1tYWV6?=
 =?utf-8?B?cFBoRnJ5NG5EMElvOXovK2dHNE1PdmdIUVYrNFRMU0RoL0lOQ1E0TStZb241?=
 =?utf-8?B?bThieWdtM3VPUFd6T29ockVJdFRwMGdZYmtZdzFUZVJYdzQwT3Flbnd6M2hi?=
 =?utf-8?B?SVV6bE5teFNOWWRPd2VGTUcrSW8rdzA1UlpPc01oWE02V0tDYllTOHcxM3ox?=
 =?utf-8?B?a2ZGdGFXU1dQSlNCL3I2Z0JnZnRhQlEyUjJBTnpVTkwwRkpvUjhWOXk5dmxE?=
 =?utf-8?B?c2VqYkxueTdrbXIzd091VElGQm1jUkFzb055MGpDNDBiZGlhZ25FSDFRNk9H?=
 =?utf-8?B?ZG5FT1VPRG1CU2pNc0ZHUktUQVA0WG9yUGlkYnBnajUwWU83eWJpWThkZ1M2?=
 =?utf-8?B?RFRkRnc0T0tQOFIrR1l0R005VFM0RDVIeGtPNUd2SUxwejNGcVM4S0lxQVJn?=
 =?utf-8?B?T1E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac19e06-87ba-4725-3977-08dc7f8e0056
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 03:18:25.0184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDBjskaqDz2sYzfeifyIy4X4I864vbsrfFQQyvPQWoIIGK/SSBMztUto82XtRd07Lu0YC8MsLHSg6EAm1I+IciTeFHSM7YwNuZ7raxd3RCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7883
X-Proofpoint-ORIG-GUID: 7UGrnm8oK1A05_eoasUAxT18CFGedUra
X-Proofpoint-GUID: 7UGrnm8oK1A05_eoasUAxT18CFGedUra
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290020
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 May 2024 03:18:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/243

--------------R75FD7eQkhaMGLhpBHOOW98S
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 44T2U1Ea026128


On 5/29/24 11:13, Yi Zhao wrote:
>
>
> On 5/29/24 10:50, Changqing Li wrote:
>>
>> Hi, Armin
>>
>> This patch rework Yi's=C2=A0 patch for upgrade scap-security-guide, so=
=20
>> marked as V2.
>>
>> Add the fix for WORKDIR -> UNPACKDIR.
>>
> Hi Changqing,
>
>
> Could you please send a new patch based on the original one? Because=20
> the original patch also needs to be backported to scarthgap branch.
>
>
> Thanks,
>
> Yi
>
OK.=C2=A0 I will resend one based on the original one.

Regards

Changqing

>> //Changqing
>>
>> On 5/28/24 13:44, Changqing Li wrote:
>>> From: Changqing Li<changqing.li@windriver.com>
>>>
>>> ChangeLog:
>>> https://github.com/ComplianceAsCode/content/releases/tag/v0.1.73
>>>
>>> Signed-off-by: Yi Zhao<yi.zhao@windriver.com>
>>> Signed-off-by: Changqing Li<changqing.li@windriver.com>
>>> ---
>>>   ...security-guide_0.1.72.bb  <https://urldefense.com/v3/__http://se=
curity-guide_0.1.72.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsr=
fMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFX5VQ3ULw$>  =3D>s=
cap-security-guide_0.1.73.bb  <https://urldefense.com/v3/__http://scap-se=
curity-guide_0.1.73.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsr=
fMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFX8DHVmEw$>} | 4 +=
+--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>   rename recipes-compliance/scap-security-guide/{scap-security-guide_=
0.1.72.bb  <https://urldefense.com/v3/__http://scap-security-guide_0.1.72=
.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoK=
CSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXnOZEZ5Q$>  =3D>scap-security-guide_=
0.1.73.bb  <https://urldefense.com/v3/__http://scap-security-guide_0.1.73=
.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoK=
CSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFX8DHVmEw$>} (96%)
>>>
>>> diff --git a/recipes-compliance/scap-security-guide/scap-security-gui=
de_0.1.72.bb  <https://urldefense.com/v3/__http://scap-security-guide_0.1=
.72.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99=
HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXnOZEZ5Q$>  b/recipes-compliance/=
scap-security-guide/scap-security-guide_0.1.73.bb  <https://urldefense.co=
m/v3/__http://scap-security-guide_0.1.73.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TE=
RKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJO=
OodFX8DHVmEw$>
>>> similarity index 96%
>>> rename from recipes-compliance/scap-security-guide/scap-security-guid=
e_0.1.72.bb  <https://urldefense.com/v3/__http://scap-security-guide_0.1.=
72.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99H=
oKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXnOZEZ5Q$>
>>> rename to recipes-compliance/scap-security-guide/scap-security-guide_=
0.1.73.bb  <https://urldefense.com/v3/__http://scap-security-guide_0.1.73=
.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoK=
CSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFX8DHVmEw$>
>>> index 3d739c2..62b1c63 100644
>>> --- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.=
72.bb  <https://urldefense.com/v3/__http://scap-security-guide_0.1.72.bb_=
_;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-=
TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXnOZEZ5Q$>
>>> +++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.=
73.bb  <https://urldefense.com/v3/__http://scap-security-guide_0.1.73.bb_=
_;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-=
TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFX8DHVmEw$>
>>> @@ -6,7 +6,7 @@ HOME_URL =3D"https://www.open-scap.org/security-polic=
ies/scap-security-guide/"
>>>   LIC_FILES_CHKSUM =3D"file://LICENSE;md5=3D9bfa86579213cb4c6adafffac=
e6b2820"
>>>   LICENSE =3D "BSD-3-Clause"
>>>  =20
>>> -SRCREV =3D "7fb44f78bf33232aad587e87a799afcf576f9b47"
>>> +SRCREV =3D "2bf9d43840d3ed36a25262d4f45a4015f9b77d8d"
>>>   SRC_URI =3D "git://github.com/ComplianceAsCode/content.git;branch=3D=
stable;protocol=3Dhttps \
>>>              file://run_eval.sh  \
>>>              file://run-ptest  \
>>> @@ -38,7 +38,7 @@ do_configure:prepend () {
>>>  =20
>>>   do_install:append() {
>>>       install -d ${D}${datadir}/openscap
>>> -    install  ${WORKDIR}/run_eval.sh  <https://urldefense.com/v3/__ht=
tp://run_eval.sh__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sj=
bCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXjOLskRQ$>  ${D}${datad=
ir}/openscap/.
>>> +    install  ${UNPACKDIR}/run_eval.sh  <https://urldefense.com/v3/__=
http://run_eval.sh__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2=
sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXjOLskRQ$>  ${D}${dat=
adir}/openscap/.
>>>   }
>>>  =20
>>>   do_compile_ptest() {
> _._,_._,_
> -----------------------------------------------------------------------=
-
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#242)=20
> <https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-pat=
ches/message/242__;!!AjveYdw8EvQ!Y7xq9pg70jCXN8J2zFwTBvveucSkbClh3VLMIqyv=
4vd91FQ4Rb_hD1N7ImAwVADMSXNic7IjtWp1O0NwTAKIlbhsmllPwRs$>=20
> | Reply To Group=20
> <mailto:yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re%3A%20%5=
Byocto-patches%5D%20%5Bmeta-security%5D%5BPATCH%20V2%5D%20scap-security-g=
uide%3A%20upgrade%200.1.72%20-%3E%200.1.73>=20
> | Reply To Sender=20
> <mailto:yi.zhao@eng.windriver.com?subject=3DPrivate:%20Re:%20Re%3A%20%5=
Byocto-patches%5D%20%5Bmeta-security%5D%5BPATCH%20V2%5D%20scap-security-g=
uide%3A%20upgrade%200.1.72%20-%3E%200.1.73>=20
> | Mute This Topic=20
> <https://urldefense.com/v3/__https://lists.yoctoproject.org/mt/10634402=
6/3616873__;!!AjveYdw8EvQ!Y7xq9pg70jCXN8J2zFwTBvveucSkbClh3VLMIqyv4vd91FQ=
4Rb_hD1N7ImAwVADMSXNic7IjtWp1O0NwTAKIlbhstiFuFuc$>=20
> | New Topic=20
> <https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-pat=
ches/post__;!!AjveYdw8EvQ!Y7xq9pg70jCXN8J2zFwTBvveucSkbClh3VLMIqyv4vd91FQ=
4Rb_hD1N7ImAwVADMSXNic7IjtWp1O0NwTAKIlbhsI7pGlnM$>=20
>
> Your Subscription=20
> <https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-pat=
ches/editsub/3616873__;!!AjveYdw8EvQ!Y7xq9pg70jCXN8J2zFwTBvveucSkbClh3VLM=
Iqyv4vd91FQ4Rb_hD1N7ImAwVADMSXNic7IjtWp1O0NwTAKIlbhsbbysPg4$>=20
> | Contact Group Owner=20
> <mailto:yocto-patches+owner@lists.yoctoproject.org> | Unsubscribe=20
> <https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-pat=
ches/leave/13170723/3616873/476927670/xyzzy__;!!AjveYdw8EvQ!Y7xq9pg70jCXN=
8J2zFwTBvveucSkbClh3VLMIqyv4vd91FQ4Rb_hD1N7ImAwVADMSXNic7IjtWp1O0NwTAKIlb=
hsieOpnUs$>=20
> [changqing.li@eng.windriver.com]
>
> _._,_._,_
--------------R75FD7eQkhaMGLhpBHOOW98S
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#cceed0">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/29/24 11:13, Yi Zhao wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:854527e2-c51e-4580-92f6-d498088975f6@windriver.com">
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 5/29/24 10:50, Changqing Li wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:bb06fd56-1a73-42d7-b6d7-98032d57e5b4@windriver.com">
        <p>Hi, Armin</p>
        <p>This patch rework Yi's&nbsp; patch for upgrade
          scap-security-guide, so marked as V2.&nbsp;</p>
        <p>Add the fix for <span>WORKDIR -&gt; </span><span>UNPACKDIR.</span></p>
      </blockquote>
      <p>Hi Changqing,</p>
      <p><br>
      </p>
      Could you please send a new patch based on the original one?
      Because the original patch also needs to be backported to
      scarthgap branch.
      <p><br>
      </p>
      <p>Thanks,</p>
      <p>Yi<br>
      </p>
    </blockquote>
    <p>OK.&nbsp; I will resend one based on the original one.&nbsp; <br>
    </p>
    <p>Regards</p>
    <p>Changqing<br>
    </p>
    <blockquote type="cite" cite="mid:854527e2-c51e-4580-92f6-d498088975f6@windriver.com">
      <p> </p>
      <blockquote type="cite" cite="mid:bb06fd56-1a73-42d7-b6d7-98032d57e5b4@windriver.com">
        <p><span>//Changqing
          </span></p>
        <div class="moz-cite-prefix">On 5/28/24 13:44, Changqing Li
          wrote:<br>
        </div>
        <blockquote type="cite" cite="mid:17D390C542482B45.24533@lists.yoctoproject.org">
          <pre class="moz-quote-pre" wrap="">From: Changqing Li <a class="moz-txt-link-rfc2396E" href="mailto:changqing.li@windriver.com" moz-do-not-send="true">&lt;changqing.li@windriver.com&gt;</a>

ChangeLog:
<a class="moz-txt-link-freetext" href="https://urldefense.com/v3/__https://github.com/ComplianceAsCode/content/releases/tag/v0.1.73__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFWyB6fRrQ$" moz-do-not-send="true">https://github.com/ComplianceAsCode/content/releases/tag/v0.1.73</a>

Signed-off-by: Yi Zhao <a class="moz-txt-link-rfc2396E" href="mailto:yi.zhao@windriver.com" moz-do-not-send="true">&lt;yi.zhao@windriver.com&gt;</a>
Signed-off-by: Changqing Li <a class="moz-txt-link-rfc2396E" href="mailto:changqing.li@windriver.com" moz-do-not-send="true">&lt;changqing.li@windriver.com&gt;</a>
---
 ...<a href="https://urldefense.com/v3/__http://security-guide_0.1.72.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFX5VQ3ULw$" moz-do-not-send="true">security-guide_0.1.72.bb</a> =&gt; <a href="https://urldefense.com/v3/__http://scap-security-guide_0.1.73.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFX8DHVmEw$" moz-do-not-send="true">scap-security-guide_0.1.73.bb</a>} | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename recipes-compliance/scap-security-guide/{<a href="https://urldefense.com/v3/__http://scap-security-guide_0.1.72.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXnOZEZ5Q$" moz-do-not-send="true">scap-security-guide_0.1.72.bb</a> =&gt; <a href="https://urldefense.com/v3/__http://scap-security-guide_0.1.73.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFX8DHVmEw$" moz-do-not-send="true">scap-security-guide_0.1.73.bb</a>} (96%)

diff --git a/recipes-compliance/scap-security-guide/<a href="https://urldefense.com/v3/__http://scap-security-guide_0.1.72.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXnOZEZ5Q$" moz-do-not-send="true">scap-security-guide_0.1.72.bb</a> b/recipes-compliance/scap-security-guide/<a href="https://urldefense.com/v3/__http://scap-security-guide_0.1.73.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFX8DHVmEw$" moz-do-not-send="true">scap-security-guide_0.1.73.bb</a>
similarity index 96%
rename from recipes-compliance/scap-security-guide/<a href="https://urldefense.com/v3/__http://scap-security-guide_0.1.72.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXnOZEZ5Q$" moz-do-not-send="true">scap-security-guide_0.1.72.bb</a>
rename to recipes-compliance/scap-security-guide/<a href="https://urldefense.com/v3/__http://scap-security-guide_0.1.73.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFX8DHVmEw$" moz-do-not-send="true">scap-security-guide_0.1.73.bb</a>
index 3d739c2..62b1c63 100644
--- a/recipes-compliance/scap-security-guide/<a href="https://urldefense.com/v3/__http://scap-security-guide_0.1.72.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXnOZEZ5Q$" moz-do-not-send="true">scap-security-guide_0.1.72.bb</a>
+++ b/recipes-compliance/scap-security-guide/<a href="https://urldefense.com/v3/__http://scap-security-guide_0.1.73.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFX8DHVmEw$" moz-do-not-send="true">scap-security-guide_0.1.73.bb</a>
@@ -6,7 +6,7 @@ HOME_URL = <a class="moz-txt-link-rfc2396E" href="https://urldefense.com/v3/__https://www.open-scap.org/security-policies/scap-security-guide/__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFVDVhZOoA$" moz-do-not-send="true">&quot;https://www.open-scap.org/security-policies/scap-security-guide/&quot;</a>
 LIC_FILES_CHKSUM = <a class="moz-txt-link-rfc2396E" moz-do-not-send="true">&quot;file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820&quot;</a>
 LICENSE = &quot;BSD-3-Clause&quot;
 
-SRCREV = &quot;7fb44f78bf33232aad587e87a799afcf576f9b47&quot;
+SRCREV = &quot;2bf9d43840d3ed36a25262d4f45a4015f9b77d8d&quot;
 SRC_URI = &quot;git://github.com/ComplianceAsCode/content.git;branch=stable;protocol=https \
            <a class="moz-txt-link-freetext" moz-do-not-send="true">file://run_eval.sh</a> \
            <a class="moz-txt-link-freetext" moz-do-not-send="true">file://run-ptest</a> \
@@ -38,7 +38,7 @@ do_configure:prepend () {
 
 do_install:append() {
     install -d ${D}${datadir}/openscap
-    install  ${WORKDIR}/<a href="https://urldefense.com/v3/__http://run_eval.sh__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXjOLskRQ$" moz-do-not-send="true">run_eval.sh</a> ${D}${datadir}/openscap/.
+    install  ${UNPACKDIR}/<a href="https://urldefense.com/v3/__http://run_eval.sh__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXjOLskRQ$" moz-do-not-send="true">run_eval.sh</a> ${D}${datadir}/openscap/.
 }
 
 do_compile_ptest() {
</pre>
        </blockquote>
      </blockquote>
      <div width="1">_._,_._,_</div>
      <hr>
      Links:
      <p> You receive all messages sent to this group. </p>
      <p>
        <a target="_blank" href="https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-patches/message/242__;!!AjveYdw8EvQ!Y7xq9pg70jCXN8J2zFwTBvveucSkbClh3VLMIqyv4vd91FQ4Rb_hD1N7ImAwVADMSXNic7IjtWp1O0NwTAKIlbhsmllPwRs$" moz-do-not-send="true">View/Reply Online (#242)</a> | <a target="_blank" href="mailto:yocto-patches@lists.yoctoproject.org?subject=Re:%20Re%3A%20%5Byocto-patches%5D%20%5Bmeta-security%5D%5BPATCH%20V2%5D%20scap-security-guide%3A%20upgrade%200.1.72%20-%3E%200.1.73" moz-do-not-send="true">Reply To Group</a> | <a target="_blank" href="mailto:yi.zhao@eng.windriver.com?subject=Private:%20Re:%20Re%3A%20%5Byocto-patches%5D%20%5Bmeta-security%5D%5BPATCH%20V2%5D%20scap-security-guide%3A%20upgrade%200.1.72%20-%3E%200.1.73" moz-do-not-send="true">Reply To Sender</a> | <a target="_blank" href="https://urldefense.com/v3/__https://lists.yoctoproject.org/mt/106344026/3616873__;!!AjveYdw8EvQ!Y7xq9pg70jCXN8J2zFwTBvveucSkbClh3VLMIqyv4vd91FQ4Rb_hD1N7ImAwVADMSXNic7IjtWp1O0NwTAKIlbhstiFuFuc$" moz-do-not-send="true">Mute This Topic</a>
        | <a href="https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-patches/post__;!!AjveYdw8EvQ!Y7xq9pg70jCXN8J2zFwTBvveucSkbClh3VLMIqyv4vd91FQ4Rb_hD1N7ImAwVADMSXNic7IjtWp1O0NwTAKIlbhsI7pGlnM$" moz-do-not-send="true">New Topic</a>
        <br>
        <a href="https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-patches/editsub/3616873__;!!AjveYdw8EvQ!Y7xq9pg70jCXN8J2zFwTBvveucSkbClh3VLMIqyv4vd91FQ4Rb_hD1N7ImAwVADMSXNic7IjtWp1O0NwTAKIlbhsbbysPg4$" moz-do-not-send="true">Your Subscription</a> |
        <a href="mailto:yocto-patches+owner@lists.yoctoproject.org" moz-do-not-send="true">Contact Group Owner</a> |
        <a href="https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-patches/leave/13170723/3616873/476927670/xyzzy__;!!AjveYdw8EvQ!Y7xq9pg70jCXN8J2zFwTBvveucSkbClh3VLMIqyv4vd91FQ4Rb_hD1N7ImAwVADMSXNic7IjtWp1O0NwTAKIlbhsieOpnUs$" moz-do-not-send="true">Unsubscribe</a>
        [<a class="moz-txt-link-abbreviated" href="mailto:changqing.li@eng.windriver.com">changqing.li@eng.windriver.com</a>]<br>
      </p>
      <div width="1">_._,_._,_</div>
    </blockquote>
  </body>
</html>

--------------R75FD7eQkhaMGLhpBHOOW98S--

