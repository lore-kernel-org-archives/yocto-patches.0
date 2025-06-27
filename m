Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E148C7EE31
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 10:35:06 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.47])
 by mx.groups.io with SMTP id smtpd.web11.10408.1751020496558598400
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Jun 2025 03:34:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=R2AE7gYv;
 spf=pass (domain: cherry.de, ip: 40.107.130.47, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sh50XRwctdeDlxkm7WNzWy5WagCfylya1sY3kM6zwcToNl9Hbtna7o7GJUc9ykbYZqL6RqLRuLzBfHgTOEfKPcVKbP57RkWQylm8vyctQaBQEuLHGgtGuJ/ClS7eeV1gGoPSl9Ojf8GSv0eKhJAToHKtY3my5HirAdsHLqrZyjOihsjvdp+HDasc3w9XXNey0mCSL9NNUtKgZxUppQxJTJUiVNBjdgED+Ccb6Cm//JUpiOz0dx8dB9RFax37T4E506GvZgqYS1lxIBnxIn9E5tBSzLP/+3SYJ9z1l7ibnjaaxL3tEU62i1E4rmeR5CFMkiLboJQUlC0XMJdKw0D2Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNrA1Jj+ULVhI0rWsOCvh0/d02AduAQXQf4pJPDtq4I=;
 b=qOJhFHb8iBGIZJRhcDgHbUBEdMAVUm+KAhFAY8zgYhEwAECVQbyGBOu+fELXfPljms/G7t1yRI4cmfdQ+imrIZgmf44GILOTFVVd41D2T1IOJ35KIROC4L1/BDQDWBBIP+WhMjZX+e7lKJ1gcLc8Q24cBu/OlZvIxEhbtoFdTkJkCxQc103k7EW4DAGlLd83nhFpp8ypSh9ZoNEnaj5EuBxAa+wact1t2GF7k3oxKLNXzGRToPtR8L4kgHJxfxgFifeWMHSFA8J0cL+hmphv0HNQK/9yi42PaN1xsyZsN+LQQtfyFjeMCwpFWC68RFyJ/J0CiEGiVPos/qtAWaTOwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNrA1Jj+ULVhI0rWsOCvh0/d02AduAQXQf4pJPDtq4I=;
 b=R2AE7gYvTWNNtDNN7qpNgIndWrEkHThfavwNUqoW2P+qfoWR0p4tjZ6r29iwRGra02FcyMFXoTVW5kgnN82FJFdo6Fb/DRwhkaxDv0Ne5F8Zg+ezkKlSow4li3wsr6ZnrCnCVDwcQcnYFULMTpe2K0OYivI7wr7beI6F9UaBq/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10079.eurprd04.prod.outlook.com (2603:10a6:150:1ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 10:34:50 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 10:34:50 +0000
Message-ID: <dbb256bb-e95d-4858-ad52-7bdb9820814b@cherry.de>
Date: Fri, 27 Jun 2025 12:34:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v4] fitimage rework
To: yocto-patches@lists.yoctoproject.org
References: <20250626031810.35828-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250626031810.35828-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0035.eurprd08.prod.outlook.com
 (2603:10a6:803:104::48) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10079:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d73db1d-e400-4c32-0169-08ddb5663e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WENSOEFmM0NWK1JacVdSZXNMM09mSHNQaTV5WlRqbmN2N3VkaXBsdmt5cllv?=
 =?utf-8?B?anlnTytIK1ArWUVYZmZtbkFFT3VwZm5PRjVVVklqamRjT2dJQUg0bFhHcGhh?=
 =?utf-8?B?K28wYmpRODA2OXkvWkZyUmJ0eUVFNXpLMGhIUWd3S01PcUR0THpMQzkzbDlI?=
 =?utf-8?B?Q05ZNU43Q3RzZEZXdWlwbW5PaFI5c0VJNE9la2N5ZURtb3F6VCthY2wrbzRZ?=
 =?utf-8?B?L2F6K3pCRElZQXJZMVFKOTAvTEUyeGxQMStlV0NUZ3BUemNhUTBTczAxMHlh?=
 =?utf-8?B?NldIMlBqQnVIY3puVDlYNnhFSW5wNm1TUnBoMGs4cmFjT2swOFFURlJURzZh?=
 =?utf-8?B?UmJaYUpzQ1VGUjJyWFZrbnBRY04yaFk0Lytpdkw4NDdTbCtHTE5jVHBFSW4y?=
 =?utf-8?B?eVIwdVUxUE5rU2Z5SG0wR3RVZUNVN0pqKzJtQ0gra0lqZUhkeW9YZXpDZys3?=
 =?utf-8?B?dFNVYVAyRWVkRHFrZFlORmUvUHBwOTFVOWFTTnFCNUp0aEllZG1KZHhhTkVR?=
 =?utf-8?B?U0Z6UXc2QkZGYjVEcjNad1BINWFhN256MUlJRSt2bStmdEVWTkMvTWF2SUhM?=
 =?utf-8?B?YXZQTlNML0EvaDNTVmsvZStURGUwOXFEa0JOaTRERTViNWZJRUhGT1Q4RFg1?=
 =?utf-8?B?eXFnVmExRHhzUjJBaEFyTXZFc2NSMUNNYzJsMUQxdFBpU0NYWko0UDhkY2dt?=
 =?utf-8?B?QUVXYklCYytoNG0yeFNIaXpkcWJvUS9jdDRERjFEM2FQQkdTVnFhZWFPaGRj?=
 =?utf-8?B?TUdMakZHRUZjaVVZNEhJVGd5UUZLa2xjYmRZUFc0dGxDMlIzRnMvUmo0NFF4?=
 =?utf-8?B?OE1EQTZzN3daN21SY3JsNEpLNVY1ZzR1aGlSK1RWUFM4R1M4VWFHUFZzZ0xS?=
 =?utf-8?B?VXpPZ2pweXhrblNVY3UvTjNNeWl6QWFvSk16Z2tTTHZ2aFNhOGkvd3RpQis0?=
 =?utf-8?B?MmxYWmo1QjJxNmZxNHgwK1Q5UHBoWXJNcHJ6K1ZPWityVFNZVUhKdEs1UmtK?=
 =?utf-8?B?RkMwbGpaQkRuT09lbjVnbHRkR21ocTgxTmk4ck96MUllRXo2WWhZblRyV2xL?=
 =?utf-8?B?S0J1Ukg3V0xXZ0pManpjY0JWVzRNZytqaUdoUjArbGQvb3lnUDBNT0ViVks0?=
 =?utf-8?B?YmF6Zm9Xelh3ZXRUTzNjQUtFay9Ta2RRZW5tRDMyQ2k5TWpiZnlYV3A4amJY?=
 =?utf-8?B?K1hWTzkzNDdhZkF6aHI4ZEFoSFlGaXo3elpkeStYRjFiNVBrOTBsbE5rc0dz?=
 =?utf-8?B?T3QwemZ1c0RXQ0NHSkJ0cEcxYzQvNFFTZmdmT09ub1pyQUVCdWRrRExXek5n?=
 =?utf-8?B?NThJWnZlOVZRTXRkcVBOR3ovQXRUQkVoMkN4eURiRk83akFnMnpDd0I2Z0Ro?=
 =?utf-8?B?RDZYTHhDNDFBblZrUTgvcUdnNGY4RllYOU9uZDB6MWQrRUg4VUJNQm9ITGor?=
 =?utf-8?B?SXVSM1hCNU9sVUtCZWZlRTB2c0NBc0k2WUkyNVF2cmNTSEZFa1BwdjJqbnhx?=
 =?utf-8?B?Qzc0SS9Gczhmcm9hcDVDQkxEY24yRTUyU2svMUltV0NKQkF5UWR0RW5MeGlU?=
 =?utf-8?B?a1JaRUp0NGxRMFpFa1ZLTS9aZFIycDJZZDhrc2FNT2xKY25aOTNYNVZURi84?=
 =?utf-8?B?TmIyUm81TFNPZWR6a0VwWTFhZkJwMVRoUXdEbWlOZWczQ0FOWUdzY2FwU0tj?=
 =?utf-8?B?TW5hYktlbytMWWlMWkNZbEU5Wll6N3JXSGVzUm1vYS9KbWQzVXlSdmt3Wjhy?=
 =?utf-8?B?bXJNbjhYbUE1VmlEeHpTWHV5RjJxTGlRS3NNZWdVN0FPQUt6STg0YVZQZjlO?=
 =?utf-8?B?RGdDRi93cyt2VU5BbTZrQWtSUUlSUXUrSjYyVXRLNENWY3l1MlNybVE5NExQ?=
 =?utf-8?B?UXh2RDZsNVZLT3I3U2w1SVQ2WGpkYmNqQk85ZDdQemdQWEN4ZTRreXk1c04r?=
 =?utf-8?Q?wqlLEquVMaU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UWx2RVJDeVkvaDk4dTEzbTBTNWp2QSs2SUxIM1o1ZjkyaEFsUWlVUnFxUGh3?=
 =?utf-8?B?bm9veUt5QXljdlI3SkViS0Y3dldQc1pFalFYU2ZjTFo2RlJqLzJTeXhCRmJU?=
 =?utf-8?B?YWJjUUZLUEhuVDZRQUp1WEQwOTRyQmxwbEpWUjliYjV5UnBBa1FUcmJhZmlV?=
 =?utf-8?B?UlI4YXFVUTBNYjlieTZjd29QcE02RytiV2plaVFrUmdiMDFoQ0FJa2FsdXo3?=
 =?utf-8?B?M1RkWkw2ZTMyZDFWbjJKQTdxWEVuc1RvQjNYRnZkaW9hbUUzQTRRZXVmUUtK?=
 =?utf-8?B?bklvaXlVUzA4ZzBySHl2aU1qMGR4anJJMWR1Mi96a1BMQTlEQkpJWlpzektN?=
 =?utf-8?B?SE5LU25NQmoxaEtOV0dVeGoxVEM1VXdZZjVTeVlOSzBJZTdRelFNeUN5RjBi?=
 =?utf-8?B?dzJoYWF6OFFYTkNsNVlMd0swWXBRTDJ1dHFqU3E2UHZ1SkphYW0xYnlGQkNs?=
 =?utf-8?B?MXNmY2drU3FSTXlZUVArajVJcUMxZk9yWHN6Zk1tUXNQaUdqeUFORU9Vd0dt?=
 =?utf-8?B?RmtOdUJ2MytISEtPVS90aVoyRUZJWkI4YjVLVmxpcjZ3c09hNnFnN2E4ZTJW?=
 =?utf-8?B?aDk0N2dEektybjhVbjYwcWhQODFRZmU2NlE3MTllL2hoNkQ4d1AxSWVVSmc5?=
 =?utf-8?B?M0M4Z1hGVWFvOFJ2SHRjcVNjbHpOU3lXNGtHcE83QWdUazFYM2pMM2g5Ky9G?=
 =?utf-8?B?V2xSWTM2cXlhV0hwNTdqQkc0d3g5Q3kyV2w0RmtvZHA1S0xkN0pRbTBPanNP?=
 =?utf-8?B?ZG9nVjBvRS9NRDVTSVBReXI4QzZORlBrM3RydGltV1pkbzFmTWRBWDJ0UmtK?=
 =?utf-8?B?MUhsRjNkbGFRbnN1cFI2T0NLeHpWbjh2MzVpRk1HdlRwTFJYQWcyTk1hMnBm?=
 =?utf-8?B?VjNEUEwvUUZRSzNpSVlnMW9VN2tLZEtUTUc5L2VzYTN1emV5UVo0cm90RnYx?=
 =?utf-8?B?ODA1MDlmZ2M0cDkrNWZEMHNxRnpUWjArb0pySFZpY0Ixb0tlZkxzTUpRc2x5?=
 =?utf-8?B?WVB4TkRvMEE5VWEwZ05UM3R6aWlBN0JyYWlYY0IrUE1QY2MvT2RvVWs3WTZK?=
 =?utf-8?B?d0lLd2szMmZTS01XUVQyUjkrQlc4blNFaHlOSFR3WjRnN0hzS1hFbFcxbkNs?=
 =?utf-8?B?NFVid1lOLzZTUUxjSXVWQmNudDFaTzFHTVNBWG1udDEyNzJyMFNkcHVwU2Q4?=
 =?utf-8?B?aXpNTmVQb0NDeG1vb3pZYlF1OTBHM2N5U045ZTVqUU9TcThEK0dER1VpVmpG?=
 =?utf-8?B?VjVFRXJweGNUSlRUV05qbDRqWkwyemRRWXk4NnM3eHEvVXNoMTlhWTZJcGJG?=
 =?utf-8?B?bFA3NTZkQm5yK1Q1TitTeTFxTmU0Z3BVRjJUV2ptbGJsSHJOWGVrcCtGNHEy?=
 =?utf-8?B?NHppdlJ0VWc4OVlJU3k0elhncFNHbjIvT2NvTEJoTVU1cTNCbXpPdUxqdjgv?=
 =?utf-8?B?MWgwM2o1d2I1RGdNaDV4UlhSZ3RuTnREZUU0V1dsK3h2dnpMZkNib2lSVzFa?=
 =?utf-8?B?ZysrWWJ6TlJqOHg4bzNZaS8vTnN6ZFF5U3ovQ0UyOXd6d2thOVZrbTJkMERD?=
 =?utf-8?B?QnowbzVwRDlNTDU3OFE5cmVsZTVUdXduNjZtOFU3aDEzanB3VTFMcFVxY0JW?=
 =?utf-8?B?UHdnSEN2VC82eFRnbDlHN3A5VFJ4WndNaTZzQ3VqblVTOEs5Z05rbC9uS2I0?=
 =?utf-8?B?UmFqc0lhSCszQzRKd2VSZVVpRi9NSklwdE1qcjZZYlV6aVFNcUFnend0eXpy?=
 =?utf-8?B?eFlNOTRNNHhWYWtOUjN1Z3RGdkprT21CUytzZ21lcjFkemI5aUUvaTdVd2RW?=
 =?utf-8?B?enVyNzV6TVR6TStEOUNrVEtxRlpZWU9ZN1h0ekVJM01BNjVlN3o0S2VDM2VJ?=
 =?utf-8?B?OVJ5YnZHc2N0V3diZkNPTlhsbnFURXdvNnVPbHR4MXhQK0J6NU5kMzlIU2hk?=
 =?utf-8?B?eXkwNWRTTnpFSGcvZ1doRElPRkphd0R0RnU1M0xpbXlSTGJQMC9vbzVPMHd0?=
 =?utf-8?B?bk5GUlhyN25qUklzNXRYMlJWT1MzUmxEdDVQOVdpY1F1VGp5eVBvTnI3WUsw?=
 =?utf-8?B?NDcyQUJpZCtnVndVc0FCNk9aL3Zvazd6d0JQck9xWTV3bE1XejRsMGJ6Visz?=
 =?utf-8?B?bEZPUXpyYkgxSTN6bGZDTGVHampQdTdSdnJsQjhqNFNWWTI1bnBEVW9UdFll?=
 =?utf-8?B?Tmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d73db1d-e400-4c32-0169-08ddb5663e83
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 10:34:49.9323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/GFiFSlZx8Mkl9Ff2O6BQcRd8e8EMaYXbbgUv7SC8iJrSDdlVT/whOSd4WISDQf0t0u7zwaQMofsaNCkll30Xi/YwcuKzjRrB6MOK7YeMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10079
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 10:35:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1711

Hi Trevor,

On 6/26/25 5:18 AM, Trevor Woerner via lists.yoctoproject.org wrote:

[...]

> diff --git a/conf/machine/include/rockchip-defaults.inc b/conf/machine/include/rockchip-defaults.inc
> index 85ec7b944d1d..fc8930635fbe 100644
> --- a/conf/machine/include/rockchip-defaults.inc
> +++ b/conf/machine/include/rockchip-defaults.inc
> @@ -1,9 +1,16 @@
>   # meta-rockchip default settings
>   MACHINEOVERRIDES =. "${@bb.utils.contains('ROCKCHIP_CLOSED_TPL', '1', 'closed-tpl:', '', d)}"
>   MACHINEOVERRIDES =. "rockchip:"
> +
>   # kernel
> +# RK_KERNEL_FITIMAGE needs to be set before the next "require ..."
> +RK_KERNEL_FITIMAGE ?= "True"
>   PREFERRED_PROVIDER_virtual/kernel ?= "linux-yocto"
>   KCONFIG_MODE ?= "alldefconfig"
> +KERNEL_IMAGETYPE ??= "zImage"

Any reason for having ??= instead of ?= here? I would assume that ?= 
would be enough? Can leave as is though.

> +MACHINE_ESSENTIAL_EXTRA_RDEPENDS_KERNEL += "kernel-devicetree"

Any reason for the += here? I believe = should be fine? Can leave as is 
though.

Looks ok to me otherwise!

FYI, I'm on PTO for the next two weeks and won't have the time to test 
this today, do what you will with this info :)

Cheers,
Quentin

