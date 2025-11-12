Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDEFCCFA1A
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 05:35:33 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6496.1762925728207200996
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Nov 2025 21:35:28 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=NElojE+p;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=3411dc7477=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC5Pq463529426;
	Wed, 12 Nov 2025 05:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=MtzSZD3asVaZF/0fQ2FdG0LuDWOaG2ZWm8DUbzU8G2g=; b=
	NElojE+p/TThX2Y2TgCFzyT0/u/wBPnuF6WmyRqanUOm0qTA5Swgl9Gn7fgR/hjU
	dJ/XYU4uOzVa4+tORoSFvN5pmuzFHd2J+3Fi5QKzH3g8nqzgFb9M7Mhd4OdaPRTI
	wvcNsi3cwJ8WiauVObWLIIc7CCnkRTyLeBQ2mEt+0f0qnseBYD6I1MZsh4kSAgwk
	buEoEMNLdXqgzwzTHksNPeJQFl+Wf5tWFXWEtAoYIIK0HXQc5EyIycTv3+nFU8gk
	Z964PJo131gCIQJX21JsNzLkf64QIcDbyvseUNmkI49plOsYLfDYP/7ZSAw3hlTh
	t02J0pd00xpdW57PBc+VMA==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013062.outbound.protection.outlook.com [40.93.201.62])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a9u2x4n6x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 05:35:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQETqsbYVkeoM5wHmJkXB3fohlJgQDOw1j2rI+POSLNtwDChJ93DVpa3x1Ny28bGPIU0+6u6vps9vTtzK/I10U/FcEknBnOAcJbnFaDhPKbtXu/VXl/UsuPLSA5RzNWURE8HLocJp8wvqeL8qQiZMlo4u61mgPQ/+MGNpO/YwkEhlj676M85gGYjrGPLM4+GoIr58GoNsKBnnT/Zhe6REa+pDtVf5NHDeJpe3mo7mO4r0uDTgmsqoRhPH8t3TexS1nqZf+SDwzJeHPaRozcXXoB66c7exYtFHtYnpFF2lnDVyAy95rBzQiHdXijnDpqOHsLz9GsWY/sgJIKFtXCyLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtzSZD3asVaZF/0fQ2FdG0LuDWOaG2ZWm8DUbzU8G2g=;
 b=tJCATPi9oazJnll3aruj4JU+ZxwjHvSa4OwTEBxOXlmCxNrySHs9SZyjfhtIE9Se1sqsnMTgJLSz+H2SNjs64L19WMantbJsGWOZfKhiPsAGJ0q6QTA6Fzh0yuZnkUTyGpicTcq4aghTUGnbH1w0okJF9La9nnqGSo9B9/hB35YR9LohMnzDk2oZuTr1HFH80Asfpz9+xZ/jIZfQRgoyyGzaYow4OQA99wS5OnmjXKg8slJIAcidvknu73o2mVAzSvt5bYkEnlvkLjiazchYBnW6wGwpQq9c8u3tHmkXoLD+aejWNM5oJz4THOz5epzmrwP4nB7O0qpvegs+WNa9KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 05:35:22 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 05:35:22 +0000
Message-ID: <87e0a761-ad36-44aa-b262-464aaeb97471@windriver.com>
Date: Wed, 12 Nov 2025 13:35:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-mingw][PATCH V2] meta-mingw: support generating Windows SDK
 with no symlink
To: Joshua Watt <jpewhacker@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org, paul@pbarker.dev
References: <20251103021848.3068540-1-Qi.Chen@windriver.com>
 <CAJdd5GYib3yt92tuSDcr0UQqcDL251EFXpvNuNGHrmrujnpDDg@mail.gmail.com>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <CAJdd5GYib3yt92tuSDcr0UQqcDL251EFXpvNuNGHrmrujnpDDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: TY4P286CA0036.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::17) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|CH3PR11MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f92f82a-099c-4b5f-76ee-08de21ad4632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SUNCMVNqakd2SUxIR201S1BWMkpDK1NXUXpOWFdxeXYrWTRjbnNDVE1TL1hs?=
 =?utf-8?B?MXJSa21JdGRlQ1Q3a25XVnJOQWFlK0JjYk5aSTBmSERGNXNaMjlZQjJ2clVS?=
 =?utf-8?B?SCttWFl2Nk1YeUsxdW85UkF6SEJoRTlCN2lKWmNWSll4cTMzK2d1TGdFamxi?=
 =?utf-8?B?OTd1VVBwS0EwNHNNcDdtemhNczcxK0VIcmhnS0hhalRqeEZLSHJSM3BNeUE3?=
 =?utf-8?B?L2FXVStDZTFkbkt2MXVwakVxK00vWG9wUys2alExSXhPbDg0TEZ5bkRMSEpa?=
 =?utf-8?B?Z2dXVS85WFlTV2JtR0oxcXhjc1A4Q2ZaVVFnWXFiQlJWSEtzSEVRNllzUnRk?=
 =?utf-8?B?RG9uaTAybVQ0WE9hNGlmT25xRGoxdzRlakdGVDhCQ3lTeXgvcmlpZmw5WjJ0?=
 =?utf-8?B?eEhFR2s1Y0NqbjZXTHhuM21rdWJFOTEzOXQxc2FKZ1REVThnb1AzbElJZkRa?=
 =?utf-8?B?K0s2dCt2MHBiaitmSDd0UGIraU9wUTFzSkJxL2JHSStQb3NxMkxzUzhxcmxB?=
 =?utf-8?B?VWxXd3NLNGdxdnAvK0dES2d4dTJUTVZadHJVR0lHNWthTDdCQ08yVDd4ejc3?=
 =?utf-8?B?cjc1WTd6QXl5bWI4L2tOR2NJU0FhVC9oNjIxcERRaEhud1VFN25Yb2JaS2Ro?=
 =?utf-8?B?Ky9JRnlFRW1LNng5cGZZeXBzRFNPYlZGd2RZeDdNai9wWHhlK0tZcGxVc0F4?=
 =?utf-8?B?dGhhaTdJVWhLZGRCcjJNZjF5ZUVJcEcyT3U4K3BjU0lSVlBhV3prcHpLQjhM?=
 =?utf-8?B?MVk2cEpHZ0FrMFNIK21QQkFKREl3YTY3TGdOQVA1VytCNlQzZDljb2h2NHVY?=
 =?utf-8?B?VmRuaHVxUGVnVG9XRzRZNWdBT0QyOG9CQS84SVZlczUyRzEvMDR1a0w2TlBQ?=
 =?utf-8?B?cC9PR0tlV2FvZ3NvTzR4aE85Q1dueGh1RXFIQVZHNGorR3N6aW16aWp0UkU3?=
 =?utf-8?B?UFNqV0tMVVV1clpIVDZIYmp6N3V4K2YybUpWTjhMWDRYVVVucExPc3FNeVZu?=
 =?utf-8?B?NUtLRG83VUdJTDFHQmtueHNLR0dvOVpvT1lwd1I1bGhOeGIwOGFYa2Z0aGJm?=
 =?utf-8?B?YTlsS3M5NUVPSjFwQmpIUmx2YlRqUDA3Y0F5VXBFb3ovV1h3UjR3VGU5OVEw?=
 =?utf-8?B?WUtDd25qSEdSWDZpTjBNdFlZYm1VbVpidlNlWnU0VitGMU4wSHV2VTFCeSt5?=
 =?utf-8?B?Mkpma0RTMXByUThSUHF2Y3NRSTA4aWR6OU41bGFrNmxxUzd4VFRIVE8xV2ZY?=
 =?utf-8?B?S3RiZ0ZwczNQQ3ZkdmpCdnJXR25OMHVNTEg0b0RPcHR4M083TTh3SjNjZUxt?=
 =?utf-8?B?UGxDaUNCNE0rcW5LbDRoSGFuT0svd0JRbms4SG04S0gxYi9VVFIrRm1ybkdW?=
 =?utf-8?B?KzhkUWRwTjBVRis3RXZUMXZCUnNPaXQ3cHlvWkNNUzUrNWx5TWs2VTZZbSsw?=
 =?utf-8?B?Ym92cCt0UUdVUEFSVmR0MzErRmdPL24wOTJnQkZyUVdmVGU5TVpwY2FGMGtn?=
 =?utf-8?B?TG02YVI3bUhjSnhBTkNETWVsRkdWYjBwbjF5VmVXTWlpZVBYQVVSMmcrM29o?=
 =?utf-8?B?OEVqc002VHhHQk5Ncy9lbmp5VmVOSFRtWWVzNTIwQ3FQSEZpd21kc1Y5NSt0?=
 =?utf-8?B?MTFLdVg3MWR3cy8rd1owOGMyd0d0K1M2YWJZSStSRTRMaGIydzZyZG9BMlRF?=
 =?utf-8?B?VmlxekR5L1VhSXNkTzI2MHdCYzYvZk9kS0NsVFhqSWlYMktsK3FxOE1yc1Vn?=
 =?utf-8?B?WW9rZFQ3WWx2bE5RQmU5amp6UVZjQ3VvVUVZOGxKc1NCdEJMOG9DWmNhbEdh?=
 =?utf-8?B?KytEcm5obSsrMEZVTUFIKy80LzQ1SFVSUUFKc0tkVjFvVlk1WU81SnExQ3Vz?=
 =?utf-8?B?WjB0cEliWGl0Um4vbExhWmNQYnJUbVRERU5zMVF6dDhNNlZUL0w5QzY5RUFj?=
 =?utf-8?Q?7nx/I077vt8Bd3Din1l2rbXDIPKYfTsN?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eHJ6ZG9YWmlKb01YWVVmeHBmTWhqODdzU09YWWRqVHNWWjI3ci9JTHAwaFB1?=
 =?utf-8?B?NFVFeEF6cmREUW5OMFhHdWpsM0lHQ0hpdjNZM2s4ZjJmMzZlU3d4R1h4NnhF?=
 =?utf-8?B?SlVpYnYyOWgzbk53MTVFTEFEMzh5WDR0WXArWEY0WnpxZmZPSEJBQ0NIc21W?=
 =?utf-8?B?OW5TNmt0VTlNbVpRN3ZXY09uUmJhNDB4b0oyRjdMbGZMek54U29XMHZ4ZHp1?=
 =?utf-8?B?VFAyWDZ2WU1EcW9ldzBKeFJ3MHVVa3pXMmp6OGJhQlR6VjM5UDZVemQ5ZTV4?=
 =?utf-8?B?QkxicHZ4enlHN0VPVmJ5Uk4zNTNHYlo4ZzBYS0dZT1lpc3lrL2ltSzJnT2dJ?=
 =?utf-8?B?OHhGOStLeFdhd24vaitHVmZjRjBUZjdHcVdvU2hTcTRVRmdtR0JKaHhCdkVo?=
 =?utf-8?B?NmNzb1RHSXBhOXZvL2J3aWtJNll2NndHemtnMFBjb0ZGTXNkNE5ISWhPNlNn?=
 =?utf-8?B?RS9rd3piQTc1NHgza3pIL241NE4xWkZjQzZNakxyWWRYdFlLOE5WNHFVZURl?=
 =?utf-8?B?bWxMS1VuUm43eVZOQS95ZmJxRXV5VUkzQ2FqZFZBWWJTUldpc0lOUWF3d3Rp?=
 =?utf-8?B?dEpxMEl3dlEvRzcwclJ6cFJuZjNITjdQa3VFRTdHYmlOb3RBbmRHQWNjR3k0?=
 =?utf-8?B?bFd6WVFUUWRoK2FYN3N1SmMwbWdWNUQ2VXdMMmxVZUVpVWp0cHpBbElsZmN5?=
 =?utf-8?B?d0JjUElFV3RyeDRkMTVVdW5pZ3ZUR0RBNnVmY1ByTHNUMWZqVzVkR2RKSEFP?=
 =?utf-8?B?YnBDKzZHbUwzWEV5YzBJNCtaVUtHTkRBZitxeFZ3bTZoR29RS1hwYmw0U1d5?=
 =?utf-8?B?NWdMM3MyZy9lZzhPV1Zvdm5abG5jZmcxcXBlK1c2cVlqVmNpT0d5ZE81YXND?=
 =?utf-8?B?cHNHOWhTNDJnZXRqZzBxa1BHY1h0ZDE2QnYrYktXZnpKaGZ1Q1lvOXREeU5B?=
 =?utf-8?B?cFNGNjZ5SE8wYjYrbjBZSDBVREU2NDF5K3VhbHVXWjJZM3dhaHVlSnNWcHNK?=
 =?utf-8?B?ZnpRLzIyZG1lVkt6WVBnalZCblNtS3FWL2srbjhEM1E3bFNPRVdJNVNuMEFx?=
 =?utf-8?B?cFpuZDZVOTA5d0ZSZExHRkk0cGQrY1c5U1JyWnZhSThod3BwaGJUMllyS1Nm?=
 =?utf-8?B?aFBweitWTVM4SDFBTFhGRTJ4cHd2WHFzT3lpWU0wTndvSVlEU1NwVDdrU21q?=
 =?utf-8?B?dkVZRmJQcURYM1BHWmFQUGN6Q21vZlJQRXNHNUtucGxtM09STWZlQTN2ZFNo?=
 =?utf-8?B?NE5ySTNQcldXSEJEYWdZd0crRVM4SUtTL0R1RU9hY0VrelVkUEYyaTZ3OTBs?=
 =?utf-8?B?YUIwRDM0cDdTeGVXcytmOTVzMFFaa2YxZ0JFQmIwOUY1R3g4L1JocGY1cGxH?=
 =?utf-8?B?ZnliZndMNkNVcTA0RHYrOTFrS216NVcrOHZLa0k4WG5NZ2FBc1JGbWNxVnJI?=
 =?utf-8?B?TUlKdkw1dWFySDdRSjRVTzBJNFplNnVuSVgrQmtmVEVMVStKNkxkRmI3REl1?=
 =?utf-8?B?S2NHZHZVcWk4TWgwK1pTd2pDRlNGNDUvaURtdkRIRkRwSHlubm1INzdCcTBp?=
 =?utf-8?B?TlBETnpTb0N5K2xYV0sycTBibHZSS3hUNlE1UEh4Slo1OG0rU2w2L1gwQ09s?=
 =?utf-8?B?aEk0RmlKVnR4TnBNeEpmWDhvZ3I1VFNVL3ZpZFdHWVQydGdhdDI5MVoyV0xL?=
 =?utf-8?B?ci9oYlByZ2EzbXJTdFJwMk90VzZVazJHTHhudEg1bDhxZU1hK3Z6M24ycmM0?=
 =?utf-8?B?RmVmSlozNCsxRkpqYjNZZXM2MmFuTmRoWTQwZUVGck5IWVdmT1pQRGNwYVBR?=
 =?utf-8?B?SnlMcXoxeXNaT1BzRWx1VTV5RXpRYnZWbGd2eXQzUTlyTEtFUy9WNVJqQVlB?=
 =?utf-8?B?ejRobDFVenpHMW9wZnFTcDZCVWduT0E2VHI3S2t1WkRkTTNyeGZuNDlKdEJP?=
 =?utf-8?B?cW1PM0dqSXFFUmFZSHJyNmRFOCs5a21XaHpwdXZtM2dDVS9jUEdrMHVZem5T?=
 =?utf-8?B?eGxZNDJQVDE1dzVDTWxQbnY5RkJWaXZWb3E4biswQno2QmUvcVNxYXpaYXV2?=
 =?utf-8?B?aWFuOVZnUEYrZnVNT1ZEUVdpdURuQ0Z3blQ5WkhYU3I4OFoydGZXSWVEZWVF?=
 =?utf-8?Q?CJBwVFo1prpTfvj7FygDMONIN?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f92f82a-099c-4b5f-76ee-08de21ad4632
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 05:35:22.6363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZjTFe0nA9L0OXuwYjy561lYMFtxhTifbaMQQw0uAiZSTPtOp15giUuFE4jJcD6M8LpKdB1vney5qClKpQdgTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8701
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA0MiBTYWx0ZWRfX7QVmGJYZXIq2
 sFpkuD8aCKXKLPbPnAw2R+Ui4bbTP8WHwcEk+ydbBNuwTS25aDOKByDs2iVMrSmox1ZZht19U2c
 NTOUBlItBT+4aDvDJyKpC1hvnDvWPYuE92nXf6YfZsVwxcFGv1Td3bL+TqactMj/RahGQb5B4Be
 1StQkGA+tnbrLDprTUgejBiqQagqGTc3CNri/tGAdUL5sLI4AKrFRgHR8xPwiqWMAjjjgbURTUu
 IJZtJSEhhKf437Y22QATpQMGOaaYDui3LPI8wsPnf2pCN7tqev2qmqY1NYHPN5qB0eei6XlmDNF
 21KppHQKjWUwt/dtVDPd8l+l4hHckMdIHRO3259JLmDnoRNUhcXXMqgEurAFcqn/p9oxY5bUOg/
 MFhnqObZjdciTHStkLEss+Xeq7HU8w==
X-Proofpoint-GUID: vTc71JJWg1_9avUYC5DMU-YNzRkJNNXU
X-Authority-Analysis: v=2.4 cv=Uvpu9uwB c=1 sm=1 tr=0 ts=69141c9e cx=c_pps
 a=RBuBYZrARuxyk0NLsDi/4w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8 a=GwDgieEeV8SkZ_6yr5AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: vTc71JJWg1_9avUYC5DMU-YNzRkJNNXU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_01,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120042
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5AC5Pq463529426
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Nov 2025 05:35:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2488

On 11/11/25 23:25, Joshua Watt wrote:
> On Sun, Nov 2, 2025 at 7:19=E2=80=AFPM <Qi.Chen@windriver.com> wrote:
>> From: Chen Qi <Qi.Chen@windriver.com>
>>
>> On some Windows systems, symlinks are not allowed due to IT policy.
>> We need to be able to generate Windows SDK without symlinks.
>>
>> To do this, a new variable, WINSDK_NO_SYMLINK, and a new bbclass,
>> mingw_sdk_handle_symlink.bbclass, are introduced to achieve this.
>>
>> By default, things work as before; when setting WINSDK_NO_SYMLINK
>> to "1", SDK will replace all symlinks with the actual contents.
>>
>> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
>> ---
>>   classes/mingw_sdk_handle_symlink.bbclass    | 25 +++++++++++++++++++=
++
>>   conf/machine-sdk/include/mingw32-common.inc |  3 +++
>>   2 files changed, 28 insertions(+)
>>   create mode 100644 classes/mingw_sdk_handle_symlink.bbclass
>>
>> diff --git a/classes/mingw_sdk_handle_symlink.bbclass b/classes/mingw_=
sdk_handle_symlink.bbclass
>> new file mode 100644
>> index 0000000..2f6dbe6
>> --- /dev/null
>> +++ b/classes/mingw_sdk_handle_symlink.bbclass
>> @@ -0,0 +1,25 @@
>> +WINSDK_NO_SYMLINK ?=3D "0"
>> +
>> +archive_sdk:prepend:sdkmingw32 () {
>> +       if [ "${WINSDK_NO_SYMLINK}" =3D "1" ]; then
>> +               for parse_type in "file" "directory"; do
>> +                       find "${SDK_OUTPUT}/${SDKPATH}" -type l -print=
0 | while IFS=3D read -r -d '' symlink; do
>> +                               target=3D$(readlink -f "$symlink" || e=
cho "NOTVALID")
>> +                               if [ "$target" =3D "NOTVALID" ]; then
>> +                                       continue
>> +                               fi
>> +                               if [ ! -e "$target" ]; then
>> +                                       continue
>> +                               elif [ -d "$target" ]; then
>> +                                       if [ "$parse_type" =3D "direct=
ory" ]; then
>> +                                               rm "$symlink" && cp -r=
 "$target" "$symlink"
>> +                                       fi
>> +                               else
>> +                                       if [ "$parse_type" =3D "file" =
]; then
>> +                                               rm "$symlink" && cp "$=
target" "$symlink"
>> +                                       fi
>> +                               fi
>> +                       done
>> +               done
>> +       fi
>> +}
>> diff --git a/conf/machine-sdk/include/mingw32-common.inc b/conf/machin=
e-sdk/include/mingw32-common.inc
>> index 56b8052..bf3f14e 100644
>> --- a/conf/machine-sdk/include/mingw32-common.inc
>> +++ b/conf/machine-sdk/include/mingw32-common.inc
>> @@ -59,3 +59,6 @@ GCCPIE:mingw32 =3D ""
>>
>>   # wine and wineserver are required to test MinGW SDKs
>>   HOSTTOOLS_NONFATAL +=3D "wine wineserver"
>> +
>> +# handle symlinks
>> +INHERIT +=3D "mingw_sdk_handle_symlink"
> Does this need to be unconditional? I'd prefer something like
> INHERIT:mingw32 instead if that works

Hi Joshua,

I just tried it out. Using INHERIT:append:sdkmingw32 works.
We have to use :append instead of "+=3D" to avoid overriding settings.

I'll send out V3.

Regards,
Qi

>
>> --
>> 2.34.1
>>


