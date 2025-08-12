Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6C6C87FCB
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 13:57:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.40])
 by mx.groups.io with SMTP id smtpd.web11.74784.1755007026355364812
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 Aug 2025 06:57:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=V4gMAcRA;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.243.40, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLoMb6uq/VIjNtbkr+Dqo7I+RHpuFZr6GX0EPX1R1wIlysvBvAfK1KHAbB6VDx4nVMQ/OKS8FEVZ3QIMKgmAVkHlsxZneeZfhOufIuRtySj4ltxNHXHXd5ES8DaiYmCh9ei41+iFkyreB9/DPGNJtopdJ4qQbcXHPkQj8Kmpxw2+tvdvRWgsQnNonw30e7W1GjZ5VX54l+b1xT8NVOemvvGSrBvKdEfoUBAyi8ef8Vm1RYCM18IsJeOnwq/nSQqGLRt/uYPcmtzNy/QDHmEulFAsH6qoT31vdsbrttrv/+Qr/ExzCMOmHOtPi0cQIE6gTR0Fu64mgRYXh2+va/AM7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rf4hUepaCOoV4HBVWclMiFhOdGguZBkup0w1zo8W2mI=;
 b=khLgWz7Bp+SGkDOqSyI0hkClJaPD3YEqldE4QxCGTOfptlxv8FDFnUN59UgdNtjF23R7+ybkJT6dcCRf8+HuoDcEvvkF2tYmP6Y9CT//yAVmnCd8bWrXzJWPxjIGU9qmRH4M0wfTWbNKdfFZti1nR0oFu24lyoPIV4OxWJ2j7pAkDVonALqszHt+c0vQmoJiT0oNdVXW5OLL+AXrEvy0jS99qVYWJXn2r0o5M57lzZSbBZ9p5T4rURIbaMXKFfan6myvJ3S24NzIf5Cm/Cfi1+vzFLx6LFE6D/aRmVyLRKuO97IF7qramF6SHEt2G3jIK3lgd/dC9kt3bSBT79Ag7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rf4hUepaCOoV4HBVWclMiFhOdGguZBkup0w1zo8W2mI=;
 b=V4gMAcRA7+YeJnT2QYBuqO/rOqI+DCRFwudtEnOy4zuSqQQj6UqiBXxqsUe/394pH/15QlUv8AEolo8RiEWRP7c17+6hBexEyyEaXBwi49XLIAEyszjpMLJMEnBTcc4gyz0yBkFyewGKuTVX+86KpEJ3CyTQR2x9rojywGCu8wo=
Received: from SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
 by SA3PR12MB8809.namprd12.prod.outlook.com (2603:10b6:806:31f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 13:57:03 +0000
Received: from SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7]) by SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7%6]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 13:57:03 +0000
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, "chee.yang.lee@intel.com"
	<chee.yang.lee@intel.com>
Subject: Re: [yocto-patches] [meta-zephyr][scarthgap][PATCH v4 4/13] layer:
 Set PREFERRED_VERSION for kernel and sdk
Thread-Topic: [yocto-patches] [meta-zephyr][scarthgap][PATCH v4 4/13] layer:
 Set PREFERRED_VERSION for kernel and sdk
Thread-Index: AQHcCvi4cfrV5NJlw0aglc8xmkBHmrRes+yA///zRYA=
Date: Tue, 12 Aug 2025 13:57:03 +0000
Message-ID: 
 <SN7PR12MB877023CD9B238C89D3B17487DA2BA@SN7PR12MB8770.namprd12.prod.outlook.com>
References: <20250811194646.3408854-1-sandeep.gundlupet-raju@amd.com>
 <20250811194646.3408854-5-sandeep.gundlupet-raju@amd.com>
 <e66f8715-91fa-4968-ba95-3c4cff296835@gmail.com>
In-Reply-To: <e66f8715-91fa-4968-ba95-3c4cff296835@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
x-ms-exchange-imapappendstamp: SN7PR12MB8770.namprd12.prod.outlook.com
 (15.20.9009.009)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8770:EE_|SA3PR12MB8809:EE_
x-ms-office365-filtering-correlation-id: e2d8cbf6-3e6e-4407-eebe-08ddd9a81df7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|4022899009|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?OS85UEZOZ256ZjVmMDFpelNianhQRHJGWUcxazlTdU02UFhiVWpLSFl1RTdx?=
 =?utf-8?B?QUFSamJVbHRlamg5M3RZWUlVNW5WdllNYUhWdGVWby9VWWo3bFFEUDA1Ums0?=
 =?utf-8?B?ekdneDNrOE5FZ2NidjhaNU9rMnJaSDJYQjFqdmIwTDFDdGloSkV0WFIrejRD?=
 =?utf-8?B?UlYzNWFJNzVtUjlBd2hSWGxKSHFnUDNaMm9jZk1XbXRnbkNmeG9BbGhHVkdt?=
 =?utf-8?B?VWVDbUl0Z3pUbHM3ZGF4bXZqbnlGOXlKNnVxNGZEZlVMNm5Ua1dkajRzemFp?=
 =?utf-8?B?d2Nhc3JvaXg2OGJzQlNrTEpiWk1KRUkzQko5ekIwSEt0RWxlNWFUU2hsYnlN?=
 =?utf-8?B?bktQTERVekJsQXFHL0psK09Kb0dHeFY3elNLRkNsMUtoQTZDZWdJdzRJN2Uz?=
 =?utf-8?B?NnJLcVZQeHpYbFpLTVZKcUlQRnl2TGFCckNuSWZEUzgyOGNpcnVNeUQwZDV6?=
 =?utf-8?B?L0xic3dkTW0weVVzbFN0RFdhaWtJWnU5U05ZUm41QUtYdy9CTml1ek83S0ky?=
 =?utf-8?B?cDFMbXFNWGN1NENPcDB2WVpYWlVvTk4xUEd2VDQ4Wk4zWUdTalpvZ2VnVmp2?=
 =?utf-8?B?RHYwdmVjNnBCZGdqUzFCeXQrQTRaWXNHTkZxaitZOEJzTDlrK2JkRFRZWGEx?=
 =?utf-8?B?bWNTUGdqV2d1Rmdjd2wvNUlReFVaaWI3WjNGYVhxb0x6YW80ZWxEcUNJWVRI?=
 =?utf-8?B?RXMyQ1JKekVVOVc5ZTNYNG9WNW9UNEt0ZzdnWEZ5OGZBVGplNGkzekg1UGE2?=
 =?utf-8?B?QUZzSHJWYytUSnp6Q3orVXlHTUZhR2hVdTBhTW9FWCtQOTdReW8vb1p4Y1FW?=
 =?utf-8?B?WkpVT1gzNlNSQlpjNElXblVBTDF0ZjV3V3lXRm1Fc0dUWmlIWWpackwrODBL?=
 =?utf-8?B?dGdiWG9tenF5MzhiSE1pNHBLNiszMWtzczVpR2R2MVBqUkZ4WWlMUWhXTWtz?=
 =?utf-8?B?YUdHZHdkWExIVEs1WDgvTVh0eEVJbm15Q1FCMHYrY01YMTFyZmhMZDgwOGJr?=
 =?utf-8?B?WUt3c0VrM1dybU1QWElPZ2F1WnpzWmFlTXZuREdoVlEwSGRGUGt4K3FQaGhI?=
 =?utf-8?B?eEYrcVJpY21Zb3lWQVBtc2NkUDRZT0lPZzBmMFU0cXBrSUZJaUcyaG51S1VN?=
 =?utf-8?B?b21NTHVuRzZkMkZVcHlmZDY2WldyREQxMCtwbW1vdXF1QjdNdi9XSGkreThp?=
 =?utf-8?B?dUhIbnpLN1NFc1haT2MyanNvUWRiNk5OaGhEakh3amlnSW9PSG1BS1FVSEVK?=
 =?utf-8?B?V3o1VDRlK0lQblBJVVVUTmd0aCtPeTY2SXczTXBPc1p3V09zcEw5c0NNK3oz?=
 =?utf-8?B?SktkTEg2VnVJYkdaNG1peVVVc3VkRHZuamVueHlZYmtQODdGTUdQR3dQL0RO?=
 =?utf-8?B?RmRibHZRL21tZGRZUDhSOUFkenA2c3Y5Z0dPdHN5NmxtaVM0S1I2cjZ5bXBU?=
 =?utf-8?B?MHNCVjVBVXI3WVgwUjdtQUFJanBCdHNURXFWdlhhR3ZaWVZVVHN5QXdiZ3Ar?=
 =?utf-8?B?KzBNeHN6c0p3WjZqNDNFL3FIYUd2NmwzMGd1d3pFWGl1T3ZjeTl6U2VKWlhK?=
 =?utf-8?B?emFWRytVMkFlbXdCY3J4ZzBqVy9XSm5XbDlJRTEwUURwY2JZTDhBSjF5aFdK?=
 =?utf-8?B?RkM1T2pRMDQ0N3JaMlg2UXFqTWV2RnN5eG52akVvU3VaNi9pdzVialpLc2VG?=
 =?utf-8?B?NkFWZEpBRzQ5NTZOMnR2OUVQZUswTDBjZlgvUTdSUDI4aGx0YnZNMGlpUVIz?=
 =?utf-8?B?ZWNaK1FWMThZNFBCMEExSStKME4wblpFTXRUZ1RuaUhjcE90aTNpT3d1Q1Mv?=
 =?utf-8?B?emYvOTJ1Wk1KNUo4elloREZsU1VGWGFWVWNVNFJXQWExcXNqcXBROXg5WFZH?=
 =?utf-8?B?bk5LWG9RdHROazBsZXVlVDhic3dweUZMZk5xQmI4c0luRWdYWHBySjhtZ1hu?=
 =?utf-8?Q?LKetyzhFqBg=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8770.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(4022899009)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Uk15Y3pjYnprVGdraWZHVk16cTNNcE4xRG5haHB1YkszR1hSRlBsL2VoaEkz?=
 =?utf-8?B?MFlCL0hER1FPTnpoZ3BQbkhtakpEWTdBby8wUDlzVTZsNS9xR0ZHMjc2dWU0?=
 =?utf-8?B?U1kyMzRUZTlNSmhueDM3ZjNFazJxeDU2L0c4dXJBczM2dEcrbjB1Zis4bkkr?=
 =?utf-8?B?bXIxOVQwVTFFRVZYTXlGTDlobDIrRENPejJEejZCM2ZhMWJEUVBTT0tiOHly?=
 =?utf-8?B?cWFDSThnNG9SQ0srTnZlMThvcXpydTRlTnRIdzNYVWJabEQrOU1ZcHU2NGlQ?=
 =?utf-8?B?bjgzUVpWb2tRVzdtV1pqcDl0QnJrRlZ2YzZzQ0JDTTFpVzZxTjN4US9DaE1r?=
 =?utf-8?B?NThWV2NFMVFRQXE1ZEVhOG1DSWpzK1dEZ2xaN3RIQUtEcTNrblN6VWhkN3VH?=
 =?utf-8?B?TU5yNTRVNE5uSlhzSTFKYnNPZzM4OEl0d1NaL1NZZE0wYkR0Y2VrMFF3bWE5?=
 =?utf-8?B?UlBuMlltSUFzRlE2NVdYVlorZHBjak9maDBNcWE5NE04akhlRGtjV0M4dGps?=
 =?utf-8?B?ZDAraWJ4WDZlVnZHMXRjcGF4U1NUZlEvcG12RFVnbGRvVzlNZUtSY255aEpE?=
 =?utf-8?B?dXJHVkwzbm1yQkRjSERoMll3U0RhQ2RlcHdoOVFjL2VNM2tSM01qNmQ2NGhl?=
 =?utf-8?B?bWQ0dW45bkF3bGl0R1JWUThFdjU1dGJqamNCbkEreDJwNW1uVDBzNWc3N3BK?=
 =?utf-8?B?ZEFtWmQ4T01tL1ZJN24vd3l6Y093aVpqNUZmRDJQWjhXMVJueEtxOTRjNUFH?=
 =?utf-8?B?QjhmSi9ibk9GYTBIOHVPRi9LOXlmRGhKcFUxMGJ6OWlOaEJndDRzNEVxb3Jl?=
 =?utf-8?B?R2xzbXgyVGllTUhvaGgvVEhLNUlwOFArZmVQY2Z6V2s2SGNoUGJrOHNOUlNj?=
 =?utf-8?B?NU5jT1Rwbnp5MzR4S01oa2tzNCtZNERwVzROc3VFQWdYTW5LNUVCNHVTVUZl?=
 =?utf-8?B?anFid1NlSXJ2aDd6MkI0dHlVT21hY3lXSG43T3Q2WXM5WlZUdVVidHEwRUVT?=
 =?utf-8?B?RkdKL0FjM0FRVGFHcFB4YmV5cExyQkNWOW8raityOU5udndJMkJ2QXYzanRt?=
 =?utf-8?B?SllOVEgyMkVTcFVmemRuZ0dvNlJBZWJoeXlKeXYrWm9Fc2g0ZFdjMUJQbUl2?=
 =?utf-8?B?Q1liWC8xK2NCWDgzN2VXaktXQnl2aytwRkZ3cHNyUzBJS01EZWFVK0p3S2tB?=
 =?utf-8?B?cmFONWlQNnBTVGJiOG9FL0hSbmprQjhHbGlsdDlOcWZEV1N1NnNGNTErdktk?=
 =?utf-8?B?c1oxenUza0FWVVpRdlFEd3MzY2dZcGQ2dWlzREE4UEZvWVRsV1l0UEVGT29M?=
 =?utf-8?B?VFc3U1pXejgrcUh5dFlrZFdTNThtMjRodjVVcHgyNHdReWZaaFdlVUovUFd4?=
 =?utf-8?B?Ymk5di9xZGhOSlRMK1p4UG9LQnVzd0lyb05pcGdVRDd5WDVHcHJrWWxHOVdN?=
 =?utf-8?B?Mkk1eFQ4bXZaNEZ0aXRQRFduQTRKUWFwUW5xNWtLdVU5T2JFUStoLzZjVFA3?=
 =?utf-8?B?MzRaR0V2a3AxVGIwQmMvVDc4T2phbThhVC9xNStacU9XRFdZdkpYM1FuRk0z?=
 =?utf-8?B?cUx2dUlISlgxd01HcnJuck4xSHRrQXprRjF4Qk1NYlBhS0FCRTFySzh2UEdM?=
 =?utf-8?B?TVdBZGl0YzRsUlNCOWpkTXA1b2JGb3gwUnF4UEZTOEpHOTl2djRkN2FjKzM2?=
 =?utf-8?B?TFpiZTBGMmM3WDFieVNVL2N4S2pjaG45U1BkYkxjSjNNdjNTY1V4MERXOUow?=
 =?utf-8?B?K0tWVy9ZTHY3YUh3V3RNY2poVTBXYUVmbDZyZ2xTSktWZUE5YkR3NzNnOURp?=
 =?utf-8?B?T2pad1h0Q3p6R0lOVU1xdXY5c1RUNWZVZHhGTGxmS1FtMGMxREdFWE03N2tF?=
 =?utf-8?B?aEI5Q2xCYkVwMzdtajNRczI2ejg4bERRRUQzK2VuUWVrTDNTSUc1RVFSMmFs?=
 =?utf-8?B?UnIrNisrU2E3KzlWNStBbDJEbGp0aE5iWHdLOTV2aDFCMzVab1FjR25IUDRS?=
 =?utf-8?B?TjlDcnk2MHJlVTl3ZVpNb1dmWjVZZzNuOXJjTUQ5ZUxtL2pSSDdHUW52RjBr?=
 =?utf-8?B?OGVTT0JRb1AvWmpGRXVmM25Fc2wyNHhmdkFsVG42VkxHYVFlYzR5b3I0NGx4?=
 =?utf-8?Q?Avi4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE6025AA35B3034987B3B6A3B6D22BDF@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d8cbf6-3e6e-4407-eebe-08ddd9a81df7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 13:57:03.6478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dg24wTH0ryCFXVgMd7AcirSHuFDSPFEiAH0G9+qz9uS39n1ue161z+zwUQ8d5Jc0Zu8YWyqkhIQbhy1R17gXfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8809
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 12 Aug 2025 13:57:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1960

DQpPbiA4LzEyLzIwMjUgMjo0MSBBTSwgR3lvcmd5IFNhcnZhcmkgdmlhIGxpc3RzLnlvY3RvcHJv
amVjdC5vcmcgd3JvdGU6DQo+IEkgdGhpbmsgdGhpcyBwYXRjaCBjb3VsZCBiZSBtZXJnZWQgd2l0
aCAzLzEzLA0KPiBvdGhlcndpc2XCoFBSRUZFUlJFRF9WRVJTSU9OX3plcGh5ci1rZXJuZWwgd291
bGRuJ3QgYmUgZGVmaW5lZCBiZXR3ZWVuDQo+IHRoZXNlIHJldmlzaW9ucywgYW5kIGJpc2VjdGlu
ZyBjb3VsZCBzdXNwcmlzZSBwZW9wbGUuDQpbU2FuZGVlcF06IEFncmVlZCBpdCB3aWxsIGJlIGVh
c3kgZm9yIGJpc2VjdGluZy4gSSdsbCBnZXQgaXQgZml4ZWQgaW4gDQpuZXh0IHZlcnNpb24gb2Yg
cGF0Y2ggc2V0Lg0KPg0KPiBPbiA4LzExLzI1IDIxOjQ2LCBTYW5kZWVwIEd1bmRsdXBldCBSYWp1
IHZpYSBsaXN0cy55b2N0b3Byb2plY3Qub3JnIHdyb3RlOg0KPj4gU2V0IGRlZmF1bHQgc3RhYmxl
IFBSRUZFUlJFRF9WRVJTSU9OIGZvciBrZXJuZWwgYW5kIHNkay4NCj4+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBTYW5kZWVwIEd1bmRsdXBldCBSYWp1IDxzYW5kZWVwLmd1bmRsdXBldC1yYWp1QGFtZC5j
b20+DQo+PiAtLS0NCj4+ICAgbWV0YS16ZXBoeXItY29yZS9jb25mL2xheWVyLmNvbmYgfCA0ICsr
KysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9tZXRhLXplcGh5ci1jb3JlL2NvbmYvbGF5ZXIuY29uZiBiL21ldGEtemVwaHlyLWNvcmUv
Y29uZi9sYXllci5jb25mDQo+PiBpbmRleCBlMWJiMjYzLi5lMzU1YjNmIDEwMDY0NA0KPj4gLS0t
IGEvbWV0YS16ZXBoeXItY29yZS9jb25mL2xheWVyLmNvbmYNCj4+ICsrKyBiL21ldGEtemVwaHly
LWNvcmUvY29uZi9sYXllci5jb25mDQo+PiBAQCAtMjAsMyArMjAsNyBAQCBMQVlFUlNFUklFU19D
T01QQVRfemVwaHlyY29yZSA9ICJraXJrc3RvbmUgc2NhcnRoZ2FwIg0KPj4gICBQWVRIT04zX05B
VElWRV9TSVRFUEFDS0FHRVNfRElSID0gIiR7bGliZGlyX25hdGl2ZX0vJHtQWVRIT04zX0RJUn0v
c2l0ZS1wYWNrYWdlcyINCj4+ICAgDQo+PiAgIGFkZHB5bGliICR7TEFZRVJESVJ9L2xpYiBvZXFh
DQo+PiArDQo+PiArIyBEZWZhdWx0IHRvIGEgc3RhYmxlIHZlcnNpb24NCj4+ICtQUkVGRVJSRURf
VkVSU0lPTl96ZXBoeXIta2VybmVsID8/PSAiMy42LjAiDQo+PiArUFJFRkVSUkVEX1ZFUlNJT05f
emVwaHlyLXNkayA/Pz0gIjAuMTYuOSINCj4NCj4NCj4gLT0tPS09LT0tPS09LT0tPS09LT0tPS0N
Cj4gTGlua3M6IFlvdSByZWNlaXZlIGFsbCBtZXNzYWdlcyBzZW50IHRvIHRoaXMgZ3JvdXAuDQo+
IFZpZXcvUmVwbHkgT25saW5lICgjMTk1Nyk6IGh0dHBzOi8vbGlzdHMueW9jdG9wcm9qZWN0Lm9y
Zy9nL3lvY3RvLXBhdGNoZXMvbWVzc2FnZS8xOTU3DQo+IE11dGUgVGhpcyBUb3BpYzogaHR0cHM6
Ly9saXN0cy55b2N0b3Byb2plY3Qub3JnL210LzExNDY1NDE3NC84MTg4MzY5DQo+IEdyb3VwIE93
bmVyOiB5b2N0by1wYXRjaGVzK293bmVyQGxpc3RzLnlvY3RvcHJvamVjdC5vcmcNCj4gVW5zdWJz
Y3JpYmU6IGh0dHBzOi8vbGlzdHMueW9jdG9wcm9qZWN0Lm9yZy9nL3lvY3RvLXBhdGNoZXMvbGVh
dmUvMTQyMTE5MjcvODE4ODM2OS81MTgwNDgxMTYveHl6enkgW3NhbnRyYWp1QGFtZC5jb21dDQo+
IC09LT0tPS09LT0tPS09LT0tPS09LT0tDQo+DQo+DQo=

