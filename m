Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9058CA0EDC
	for <webhook@archiver.kernel.org>; Thu, 14 Aug 2025 04:29:39 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (NAM04-DM6-obe.outbound.protection.outlook.com [40.107.102.72])
 by mx.groups.io with SMTP id smtpd.web11.15461.1755145775844244265
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 13 Aug 2025 21:29:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=yzj64gav;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.102.72, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKXctPIML2VCYG51pbUOpkRg+SkgDdMJ/raxTXckSNLiG96H96O9S0byK8JH4/MTdXujZBJC28fThASrhEey1EkjKPzcF5plPv7FQHtVK7o6HPCItXtpSab/8nyQik+5wTO+nphNoplFjmld14d3Gd8SzWbqehQDRAy16htQpnwGlCU5qvK+rLw9TchuoWONJTrwbRqwdFQcTdEsoSgr0ogN6FEVZyZovxs6/x5ME/XCgW0E0TRqrSoYiXz7eCPMNv2c5MuHA8vK2SOa+z0/R2YGpbUg5kn9BvPnp2TBms6tPTvOJce17f79gLCvOBasajq8qyPvAmszmRRN0vxT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFe/UF2ttn3FS9no29JNyBlQm5BXdXzGLbwRnZK7uz0=;
 b=EC4HDbEsAOOKjRF4yYm7cBGz+kVq0U+Uvak82h6lyTko1S5cm6JrpLOh7Q86Psu61tpOcimSN3hjiCxYxBbOTFoTwujH5NWrHeiqbetFRWpKykLCIqYEyWa+REMsiu+A1a4v8ztPXvd3WbJsQayzMfvtp1hglwR3ixIdYFlW4ayXzOTpbSVMQHw7WhVYidT3uIpCyDFr1vAXvojLNgrKMeDypWPBgZ/7QBCY4+W4UAybiKv2ymszAsEFMD2Qx7ytsDDoSd/VZqbbPae+wslX9AEDfbrTGecGemZI+iyHqUSkRqBO2QKsOGuVs/m/lnr4k9vY7Y6PybleQEOMHxSVQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFe/UF2ttn3FS9no29JNyBlQm5BXdXzGLbwRnZK7uz0=;
 b=yzj64gavNzoJK/mmqxo7bZ9T/6mkMRAGO+pAPJKWWTP69X1JeHcB/WhEqUirc8VG2Xr6VZTQmicWM0AkobdzzwgcKjoSi+iC60X3+ubAzFBiyztDfFEgAZbHp3Wzwz/fCawFqjgq76dKzdrJNe90w5cXy6AWFjwTzH8tpFQOuSw=
Received: from SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
 by SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 04:29:32 +0000
Received: from SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7]) by SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 04:29:32 +0000
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [meta-zephyr][Patch v2] layer.conf: Update to
 whinlatter release series
Thread-Topic: [yocto-patches] [meta-zephyr][Patch v2] layer.conf: Update to
 whinlatter release series
Thread-Index: AQHcDNGsTudjd0Fhd0WL2pN6+8ejS7Rhjivw
Date: Thu, 14 Aug 2025 04:29:32 +0000
Message-ID: 
 <SN7PR12MB87701368DA26F9EEA86B7450DA35A@SN7PR12MB8770.namprd12.prod.outlook.com>
References: <20250814032217.3574830-1-chee.yang.lee@intel.com>
In-Reply-To: <20250814032217.3574830-1-chee.yang.lee@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-14T04:28:37.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8770:EE_|SA0PR12MB4367:EE_
x-ms-office365-filtering-correlation-id: 518c633a-5fc1-4b7e-9693-08dddaeb2a81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|4022899009|376014|13003099007|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?mNvoodqPbUsaF0mMgY9A5Wx1ztV8z3IKcfOtlegXe0BnNDy67/2lPkmItvMQ?=
 =?us-ascii?Q?hhFERlhJznMbXjY9JiysrOamfzkXyuGYiBAhJAMsnFPqTCqMna3pHQiI5wae?=
 =?us-ascii?Q?8wleoH7eDQBTt28DRKWYqDGhPvFF1148MWSoHxWOM8S/C3jd9W5msdlC5dPq?=
 =?us-ascii?Q?KjkBEgbLCVStkJMDWE8or1K+ZSmmGl2IhqNmcEpUMENytr7MjserTr0kpH11?=
 =?us-ascii?Q?Cz53Btnn2YKLIWYWysgDwnYF6j0+DWDY73kqQkoMv00Q+oWaZsyV+Lbu3MEK?=
 =?us-ascii?Q?mRQzNZ4Cj1IeyRIXXQcMNED8+ripHTF55ObH9MTzUHn9Gr3UbmHi7hOr1QfQ?=
 =?us-ascii?Q?onU6yqUpIU9Vxs5J4m3FzBmiB+BEB4ykkG7tjBhspHfklD5zmgFfwxQRlo4I?=
 =?us-ascii?Q?TOvCebhz2xtKTygCVaNiIGOQZgPsxkdSN0q3G30VDRti326MnC9qrqR+raqX?=
 =?us-ascii?Q?sQQyk3dSHkTDc8qX36ky/ENNAlgIotOGyDepgF4dPob3a0T2ZmtToN8gmtiL?=
 =?us-ascii?Q?SNTuHaSyrGhO9K7yhqNdF7cISiQKORrIfBXjiq1Z4L8B11AkdtzRWKWhw5V8?=
 =?us-ascii?Q?KWV+jUxtocFpzq5VF5f2bGt/CYge+Q+LBCSA8CoKxwYIPO78/dDBWHvjBmuV?=
 =?us-ascii?Q?5gM3AP8dJx4L8GCDIpZNfW6usIpVg7oZx+Dn973FwuIifDUPQNBlRijxO+5T?=
 =?us-ascii?Q?p53b4uCFiBbjzIZYg9dTC2AQ1qfdfMiR5hOLt8Zj3a3eQf3F4xv0V/DKJ8QI?=
 =?us-ascii?Q?XlNuSoDVk9q5ULTttKzWoHMRjdc6J+NCkjTtAfwQi45Z+rP0fepaU41OIX+3?=
 =?us-ascii?Q?Pw6lbSpOfoCbUAMcwTWGSgtc2usHJxEZKxd5Aiz3bQAC4b+ZV4kw0apHIGcy?=
 =?us-ascii?Q?V40Zc/AUvYPzejrwGub7QgzKZ9LvDZWns5/gXz+Nze9oIjjmLqQND3wMGkSG?=
 =?us-ascii?Q?4wCEPEtERknA1Hv9qdMAxeGY1OHQ0jZljm+yk5i+VqgZ3OH12OilkX5YpQ5n?=
 =?us-ascii?Q?CcGoktbVb+MV26PUV8rpHiEdRX1ayqnJN4RPz75YVQi3nfpZizi58wfzMHRF?=
 =?us-ascii?Q?JE2pjHyVSd8Ehvdpjm/ZVdomdxrU8hhxHvuGeDqe3Z/XlSY6tCIwmo/rw4Fp?=
 =?us-ascii?Q?edXneKvk8+qHQnelEcdTofXur+mrvzKvg3yNGE8LYPiHFAD409OD/wKvs7y7?=
 =?us-ascii?Q?Nzo4w87WAbvGi7d6lEy8GNGRh8KKgjJ2+2e/xAOWNxGkSORZUlQIzZ99r616?=
 =?us-ascii?Q?vLDEd6hmt2bh99XKdjQmC65to64opzjJsnrdGvhgaEo+9CPJjDhTevVvekfM?=
 =?us-ascii?Q?Mnn8oLEyKEMud2CVCzt5kadvH9+1mrXxh7RVIj70QyQ7rp6znRcLe25b49Mn?=
 =?us-ascii?Q?j1djOEl1p6ITQJVdNkrX+iFxHaRfTKisYZgfD8e/bP8DX/ahl5cxDsf+WCbZ?=
 =?us-ascii?Q?ar8TF4AUc2w=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8770.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(4022899009)(376014)(13003099007)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?/Ml5SVkDmJ1ZFWnY5geYnDylLXASPgdSNLfVjehwcqm161tL2RrYSqOKpigs?=
 =?us-ascii?Q?83x1sLOxRVMOdeKpUv6XaLn2/rk3PbQjrj3sjy2gUqOvh845OfE8MI6fgr6Q?=
 =?us-ascii?Q?853I+zaPshzqJ/ky0Zv1tkpceb+Ta+k0H8TgwZuqNlrs6Plzx7QT9PnHFYfQ?=
 =?us-ascii?Q?OxITYPM++Tj8CpODsBuKTNYt9Zwfd3V5GJBw9bfKKcAox4j+KAm2RlreNQ7U?=
 =?us-ascii?Q?LIoGvp/sHFKGGeEh8xgFRbysuGQCVZOFFyao+2H2LR/JxrANGQsucQMEr7Kn?=
 =?us-ascii?Q?ycTWJcx70DeXzoROBNEWsiN3KdFZZuVLDd+dVWVduoetFcfXXVMAvw5L8els?=
 =?us-ascii?Q?1Kkvk155IWBfUBcEihXqbH9U0kUnDeuTEJQvLgY5DZhriimVVSSDGsWAiu9H?=
 =?us-ascii?Q?yY9vvJ/GJLVzF6xIP7VCLLv9v3JMSFQPfLcBtxRjjCrhoOrEHE3KMz9rrg//?=
 =?us-ascii?Q?O2M9bPmyDRQJKPFbyQe191Oe/d9EDcK8ZDDr73JOURKpljBcCmp61H4lrHIU?=
 =?us-ascii?Q?fmTrzFRaRmIygsO1BI6J7cz6aTqTnNvFYPSSQnaQ+bkAJaNgE0uaL6p3Isvd?=
 =?us-ascii?Q?pxP7zQLcJ5mUeJfDy4bBJAcpSZi197TJZvV3bjCIdJQjm6BfkSyMvDRVoSJs?=
 =?us-ascii?Q?laTQ8ec56FTcfwPDaoHdcGPMmKCAdNbmsCQlE1/lMhoi0DWaXcKRey8zqrqN?=
 =?us-ascii?Q?2u8G9mM+sYKEmsRGxQm3rx1oEk/6EUqityw1RsPAWwL9bYCn9oDHFNw1XPwP?=
 =?us-ascii?Q?vPyxP8Bpxc5pUFRb6GmFYjD2VAOWzkozcnFaatmcbH5r5SejXzWso8RNHNfK?=
 =?us-ascii?Q?d85zPtliIezaC/6xSwAZW+3sAt8XxFnOgIMnssw9mluywpThvaZ0p5sij198?=
 =?us-ascii?Q?dX1KQCJUQZSuCsQI9CCXbegkXmux+Js3oU9KHnTEMEQxSoLu1H+XhKvZ0gmZ?=
 =?us-ascii?Q?xo98sX7X9Aq9BnJc1SnWkW8+4TffTlaGAgG7uOS4PEXFCQHF6m8CAv3XCv8n?=
 =?us-ascii?Q?dzsHsU9sjptw8PrusoTBRWAVmnTAsZurTfj8/lHz6CP0mIFcuLW50MfnwCCI?=
 =?us-ascii?Q?L65kTDWn2GB1T2LJy4ntKVBSkrDtn5+Wqu9XceB90K4ygC9jhXbnnJAdkw9V?=
 =?us-ascii?Q?+h4tnZYhSkF9uhWkzmlfV50IiLGfd+VfBEeX0MLxkEelzBZigL82TFBVOkGq?=
 =?us-ascii?Q?8M/aHt/cF8IIaUGcwFNTASIFLSFbPqcTOwb+PBOq6MYmu7GVpIwP3GmMgWSj?=
 =?us-ascii?Q?h9WgqghPtaJIBQQqBGDTj5yRT8X8FcD8TbYxfY2Lo7eOCAUOO77a6lp+5/nV?=
 =?us-ascii?Q?5GzdHfzp08R32N+r0ud9fey/kY3z2tudkHjXgcY69Fq6Md+HuippRs5nO9Vd?=
 =?us-ascii?Q?NkEdrx/EJW7oFzDNVH/zI8V/nFEOudlVAT2tL9ALwEGntvKnxXRIVi3EnAEM?=
 =?us-ascii?Q?ZcJlIdozYed2T9K4ie6jEeaFCtAEgegXECQpZ3HAS7Hd7c96iJxSsS9r6GZ1?=
 =?us-ascii?Q?BZ0/a9Navc1dqSMKyNpPXKqoS0evN7FitCvClctEotZQCpqAxCdOb2eJrTqu?=
 =?us-ascii?Q?519P2EyQ/gDhxBm/9mU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518c633a-5fc1-4b7e-9693-08dddaeb2a81
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 04:29:32.1461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tH/TPvA6gHRlhy9GsxZMu4f9scQKj33SYwgac8llQtaKN7Cc3MOEEuhyinVKGGc90v8F4KaKy14XqdZ49QeRQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 14 Aug 2025 04:29:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1988

[AMD Official Use Only - AMD Internal Distribution Only]

This looks good to me.

Reviewed-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>

Thanks,
Sandeep
> -----Original Message-----
> From: yocto-patches@lists.yoctoproject.org <yocto-
> patches@lists.yoctoproject.org> On Behalf Of Lee Chee Yang via
> lists.yoctoproject.org
> Sent: Wednesday, August 13, 2025 9:22 PM
> To: yocto-patches@lists.yoctoproject.org
> Subject: [yocto-patches] [meta-zephyr][Patch v2] layer.conf: Update to
> whinlatter release series
>
> From: Lee Chee Yang <chee.yang.lee@intel.com>
>
> Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
> ---
> v2: removed scarthgap
>
>  meta-zephyr-bsp/conf/layer.conf  | 2 +-  meta-zephyr-core/conf/layer.con=
f | 2
> +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/meta-zephyr-bsp/conf/layer.conf b/meta-zephyr-
> bsp/conf/layer.conf index 60a0a80..6c16722 100644
> --- a/meta-zephyr-bsp/conf/layer.conf
> +++ b/meta-zephyr-bsp/conf/layer.conf
> @@ -15,4 +15,4 @@ LAYERVERSION_zephyrbsp =3D "1"
>
>  LAYERDEPENDS_zephyrbsp =3D "zephyrcore core meta-python"
>
> -LAYERSERIES_COMPAT_zephyrbsp =3D "scarthgap styhead walnascar"
> +LAYERSERIES_COMPAT_zephyrbsp =3D "whinlatter"
> diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-
> core/conf/layer.conf
> index 3482c6f..5afec0f 100644
> --- a/meta-zephyr-core/conf/layer.conf
> +++ b/meta-zephyr-core/conf/layer.conf
> @@ -15,7 +15,7 @@ LAYERVERSION_zephyrcore =3D "1"
>
>  LAYERDEPENDS_zephyrcore =3D "core meta-python"
>
> -LAYERSERIES_COMPAT_zephyrcore =3D "scarthgap styhead walnascar"
> +LAYERSERIES_COMPAT_zephyrcore =3D "whinlatter"
>
>  PYTHON3_NATIVE_SITEPACKAGES_DIR =3D
> "${libdir_native}/${PYTHON3_DIR}/site-packages"
>
> --
> 2.37.3
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1987): https://lists.yoctoproject.org/g/yocto-
> patches/message/1987
> Mute This Topic: https://lists.yoctoproject.org/mt/114696490/8188369
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-
> patches/leave/14211927/8188369/518048116/xyzzy [santraju@amd.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


