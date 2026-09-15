Return-Path: <joerg.sommer@navimatix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C908C88E75
	for <webhook@archiver.kernel.org>; Tue, 15 Sep 2026 06:56:27 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.112])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17601.1789455379256229396
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 14 Sep 2026 23:56:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@navimatix.de header.s=selector1 header.b=U85ropb8;
 spf=pass (domain: navimatix.de, ip: 52.101.84.112, mailfrom: joerg.sommer@navimatix.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZrdUpe3VOE9mU+FRGDuS2aUWxVgtN+cZi9MWdJ5aBWM0dmwuppW3fRSvVn128tcgv4c12exOOmoje8wpNw3QmsqFMlAgkiY55cykZDwkhnOoSuomdyTEcHbVtejAMvImGdcaxMd0ImPMod2QABS8rb05TqP1VHRYjOQzMn1GgQ2SweHXaXMZgEsyVqZ/ZHixbryf3YGFMd3Np/SPPFw/jdeuYGaqbpgJji8YrPfMo2W55COmE1NpvjTJvsNmmb7vTH3jR+3flZ4ultckvXYLdNongF1eDKFltP2GpCDBE7qyniXbz+koBHjKW4LAms7sGYz4bECUlkXZ/efshfz/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swgHNLs3QfVGyAtoU51aYLVSar1/jeDMvWKr21l54DI=;
 b=hoFjaVw0c/WnC9/K8zCrQxhfNyIAJrpbxhqJNtM0b/XRGswdQzqZJDZ3G5rmaWO2HBBaNSsW5rXZLYUhgH4wHDQHnSt+dhpfZtPo/qrqiYstiKVrgxfYmATUNTvPqQeYSmcnv+CjAtvF5uZkptSjqoXNSNHICaVMFizSDAoy6ycq0FpMiRb1hq/7yVNl7SUdjr7fShASwQZStn5/1DT5TR/XTGR6o7BzmjxpTNfFx/8hT3Kdl+JQu0Iu6Ys9ZWJ29TqFkpjXgEhKRqmgVdej4sAqBjy8SHkCIOJ39XCa2xBVMycpeDyHkfcE/+4BN5iQyIchUU1BC8CQyg70bOtRNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=navimatix.de; dmarc=pass action=none header.from=navimatix.de;
 dkim=pass header.d=navimatix.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navimatix.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swgHNLs3QfVGyAtoU51aYLVSar1/jeDMvWKr21l54DI=;
 b=U85ropb8Ei1dlQFRerPb7xgNd+gGm/GcnEXNgBsBK2rdhmNGHHweGUnAiivdIX4PAhDo26NWRVNbDOnIY+tFMwfln4DnhiMEe4jxsYEqiGvs3rDbvcIMo36kAQgGulrhUX1ime0ATxhvvQAlFU3lz7GfU0DAPr+Hh/wzVweSwJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=navimatix.de;
Received: from GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:2cb::8) by VI1PR01MB6366.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:15f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 06:56:13 +0000
Received: from GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 ([fe80::d5c3:2dea:3d98:25fd]) by
 GV2PR01MB11835.eurprd01.prod.exchangelabs.com ([fe80::d5c3:2dea:3d98:25fd%6])
 with mapi id 15.21.0406.007; Tue, 15 Sep 2026 06:56:13 +0000
Date: Tue, 15 Sep 2026 08:56:11 +0200
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
To: yocto-patches@lists.yoctoproject.org, 
	Chen Qi <chenqi_hycx@cetc.com.cn>
Cc: joe.macdonald@siemens.com
Subject: Re: [yocto-patches] [meta-selinux][PATCH 2/2] coreutils: enable
 selinux support for native variant
Message-ID: <aqjrl79KPq7arcPB@navimatix.de>
References: <20260915024100.1955287-1-chenqi_hycx@cetc.com.cn>
 <20260915024100.1955287-2-chenqi_hycx@cetc.com.cn>
Content-Type: multipart/signed; micalg=sha256;
	protocol="application/pkcs7-signature"; boundary="fzfwqjd4uqbmfxkq"
Content-Disposition: inline
In-Reply-To: <20260915024100.1955287-2-chenqi_hycx@cetc.com.cn>
X-ClientProxiedBy: BE1P281CA0317.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::7) To GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:2cb::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR01MB11835:EE_|VI1PR01MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 9997ee6f-fb3e-4105-e55c-08df12f66e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|3023799007|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	juaMChfoCEGDhpYwGLJ1LCSDvXyGoTe0KjlNsZaIpm/MkQmYbFxCjMn/kpOreE8UcIiG1C5TvSLdeLtKdZscjoZD7Pn5+0SkFiElsJSUCh4A01Rjf63+xxVbFWwHUtC08NLAiZU96MI+CfV2nazDEQ/FMOsvDDHBjtt04iSjYKyosoiTnmFvcYUuXpccTxAQ/HgxBBPR+G6ijwN03dYTOtw35Jy/+S0F8AO/iIqtdGJCY4H9STIswxpV/LZ9m1ukT6NZOiaRxtXRGyq60dBFkvQV5897SZvtHVm+HkjX3s2AfCpnhhiJruHtha5gmMOGzYJntkCvu3oSzGotK9yr0zr/MZ8udMXEw1TtImoaMhqO+VLBs7G3zU1/VFqu7WI8w9a7qSYvTm25ARQR/Hn8+OepwIUdAkdCBhM2ny0/4sQKPbxcrRyCZCtnLV1VxIPCD6R5svvx2old2X+I3+L/B0cnYARNdWcCT3pkCzIw5ixcGPsxPAZQxZn5iArV1kW8r4Zd8xrROxxWduHgyU3AccGEx807v6RK3t3BwGIPL/rOOeTav1EDlM6jUnAlctYqnqhFO/i+WS0R/nmaeAaqvNZ5YYtipKDx8fwlxiYO78c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR01MB11835.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(3023799007)(10067099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?iso-8859-1?Q?9My4CJBS+ZO4xSR1nJ08u8UsqXN/fejdUzhSVUBPa1S/Eh5SWSZQTRvh4y?=
 =?iso-8859-1?Q?940TK8+cGMRnEqhAS2DezG5v3gHy+PXPn8vXMckgXwmcTLbJWb5PYd+Ez4?=
 =?iso-8859-1?Q?xB6IM3a/GWem89D8b9L+A8vW9fmpa1ABIC41hrkCJqh/1Jcz4w8RJvvjRs?=
 =?iso-8859-1?Q?uFPDbLLV4FgZlv0+PIRxRyJjXYsvtGOujl3hFFu85uNXXiyC25RbAPvNLl?=
 =?iso-8859-1?Q?0LZHbx5UlVDfZeZEypJ+jNBy6pJLN9VnlupI3foTFjPBEicnb0YGOGcM75?=
 =?iso-8859-1?Q?+j7VKcpSFCoj9FWLtB6oYYtCp/lRTYwPpMdgvApMjHW1myySEjmZLdZo79?=
 =?iso-8859-1?Q?tpi1W2gO/E0ML0NJrsogh3InxJ618nL/uQShtTuxvJWKm4Z2gFqy1lfAgL?=
 =?iso-8859-1?Q?5U24CI6/RnQWj1TCwonVd4baJn4n7Ir5dcuQZbgPDA7rBdRpnytZ6r/+LN?=
 =?iso-8859-1?Q?cDKlYQrOGb8IIEpQMBZzJz7n4HxhiX0c/LWreDUUqhBFM6+OoBcD3zw9US?=
 =?iso-8859-1?Q?NEZHEOUhByKha04ySniy8NcuOIXdF+MokwSeMQ54rkTn2m3jJHF05Hygwa?=
 =?iso-8859-1?Q?pd4a5jiIQ4BI4JKjXm0GWASXSWBMVNIkMgzj8cq8R3PzPMLnqT3yv79Sk6?=
 =?iso-8859-1?Q?BvZYliBl8uyjDg+yP+jcYQ8rmqLSzYkkC5XwXKfXT3xhnTny8fz1I2OUFf?=
 =?iso-8859-1?Q?sf5+xiSwGDqOpO7LhI2i1QjMO7TGzvSm4NlQNqeFig/llU16cqmp8yj+Zd?=
 =?iso-8859-1?Q?3n18Polej5Q8nmh2Hgjk02qVbWU1ErHefJBlNXDAVf97MfTBpjgPGeQmO6?=
 =?iso-8859-1?Q?Aa2/FWe3sAYuhOQjSlsar8kZzkuJaRAq0JQoo8cN1KTYwKHGUz/nRctg+n?=
 =?iso-8859-1?Q?6jC8bgxgOcCTPj6JfbriN+kwgk11O/xNzPTWNXwomkGr//yY69VVVTg00o?=
 =?iso-8859-1?Q?SZl8UONEkZ4jzaHT3WjmMNSX/hgRrla1tRnsS9zKAOqZBS0wN0yl7sBkdl?=
 =?iso-8859-1?Q?B3xv116RT0j6o6rtqRQ8qQp6SES8yllB8sR1hjllT/+Dw6e8ywXZpuhECM?=
 =?iso-8859-1?Q?bvDcX+sp3EP+b3pZ1qz8lDe9xEQxUun0MBf9TF4m7eIAclSGcPyElPTx8k?=
 =?iso-8859-1?Q?5Wo7DQIOXcyRImsP5T+VacT4YVnNUg3Yi38l8LptFnDgXRLYpaROfOdarR?=
 =?iso-8859-1?Q?ssj2RUR60xSuVeuSD8pMrQlYwqe4j1oXxJSyhH/sY72GBe4Nux8h2G6KQR?=
 =?iso-8859-1?Q?0XvMUPhZC8FIgShMx9sEddDaBUZs7QBL5pPTcuQ/JzpjijhT46fbRXyyxH?=
 =?iso-8859-1?Q?rsheHZCx/Qy5SBri4jRfMc1gNJsxSPfYsNmNGGdJy6xHJnStF77XiC1O5V?=
 =?iso-8859-1?Q?D/Z5vz7AcwNHe+wX9QqhVnPvm+CP9luWBU44cs3UpJh51wiV6sbOj+v5XG?=
 =?iso-8859-1?Q?B3/atXDD/cCi8XeamONN534UaKKkwaIlXOezcQ0IxTKvWeKiDHjiVWr0s9?=
 =?iso-8859-1?Q?hKEsgaKCyzIYcBJ3Xv81Wk6ka8kUM5Si+EQtl/JtA0ezmia5z7zstFXhp7?=
 =?iso-8859-1?Q?wJDNn287zJ7aCaG9t8o5GracLE0PF1ybqS1frOU1VW6qUxle6LscDM7mfC?=
 =?iso-8859-1?Q?shKZFlHISwpgyZZQXpfAAvdof/8hy5Q40idH5eb6r5IPXTnGDhH/G353Aq?=
 =?iso-8859-1?Q?HMbmV0/VkbjV2WrstqQhN4TY7uoqwK1wU6xAnmahpiWI2b7/CGhevdryvk?=
 =?iso-8859-1?Q?CQK5EvMcmNcRle/OSP9H/m1KGtRmgXDAMgNFQ5RSDdaxy2UeWgeTglUO1/?=
 =?iso-8859-1?Q?1g+uGqcXaFn1raGjPi1rU5uJ+nO6CyA=3D?=
X-OriginatorOrg: navimatix.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9997ee6f-fb3e-4105-e55c-08df12f66e40
X-MS-Exchange-CrossTenant-AuthSource: GV2PR01MB11835.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 06:56:13.2370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c87b4f54-b992-4813-8f3f-4a876324197f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+yzH2OVkjJW2iBA30bEtWy6QPAn5jiwvvnM5Rw2Vke4JW6B8s7rSpETGt04ZUwj6k90QRYnlWhxMivojyvYD6ssmWhfu8s44Oa6oBW3ebc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR01MB6366
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 15 Sep 2026 06:56:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4850

--fzfwqjd4uqbmfxkq
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [yocto-patches] [meta-selinux][PATCH 2/2] coreutils: enable
 selinux support for native variant
MIME-Version: 1.0

Chen Qi via lists.yoctoproject.org schrieb am Di 15. Sep, 10:41 (+0800):
> From: Chen Qi <chenqi_hycx@cetc.com.cn>
>=20
> It's really a common task to check selinux labels for rootfs to ensure
> that files are labelled correctly. To do this, coreutils-native
> needs to have libselinux linked to make commands such as 'ls -Z' work
> as expected.
>=20
> Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
> ---
>  recipes-core/coreutils/coreutils_%.bbappend | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/recipes-core/coreutils/coreutils_%.bbappend b/recipes-core/c=
oreutils/coreutils_%.bbappend
> index 74e22b3..21de5a7 100644
> --- a/recipes-core/coreutils/coreutils_%.bbappend
> +++ b/recipes-core/coreutils/coreutils_%.bbappend
> @@ -1 +1,3 @@
>  inherit ${@bb.utils.contains('DISTRO_FEATURES', 'selinux', 'enable-selin=
ux', '', d)}
> +
> +PACKAGECONFIG:class-native:append =3D " ${@bb.utils.contains('DISTRO_FEA=
TURES', 'selinux', 'selinux', '', d)}"

Would `bb.utils.filter('DISTRO_FEATURES', 'selinux', d)` be better?


--=20
Navimatix GmbH           T: 03641 - 327 99 0
Tatzendpromenade 2       F: 03641 - 526 306
07745 Jena               www.navimatix.de

Gesch=E4ftsf=FChrer: Steffen Sp=E4the, Jan Rommeley
Registergericht: Amtsgericht Jena, HRB 501480

--fzfwqjd4uqbmfxkq
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIIaGAYJKoZIhvcNAQcCoIIaCTCCGgUCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0B
BwGgghehMIIFgTCCBGmgAwIBAgIQOXJEOvkit1HX02wQ3TE1lTANBgkqhkiG9w0BAQwFADB7
MQswCQYDVQQGEwJHQjEbMBkGA1UECAwSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHDAdT
YWxmb3JkMRowGAYDVQQKDBFDb21vZG8gQ0EgTGltaXRlZDEhMB8GA1UEAwwYQUFBIENlcnRp
ZmljYXRlIFNlcnZpY2VzMB4XDTE5MDMxMjAwMDAwMFoXDTI4MTIzMTIzNTk1OVowgYgxCzAJ
BgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcgSmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEe
MBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNB
IENlcnRpZmljYXRpb24gQXV0aG9yaXR5MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKC
AgEAgBJlFzYOw9sIs9CsVw127c0n00ytUINh4qogTQktZAnczomfzD2p7PbPwdzx07HWezco
EStH2jnGvDoZtF+mvX2do2NCtnbyqTsrkfjib9DsFiCQCT7i6HTJGLSR1GJk23+jBvGIGGqQ
Ijy8/hPwhxR79uQfjtTkUcYRZ0YIUcuGFFQ/vDP+fmyc/xadGL1RjjWmp2bIcmfbIWax1Jt4
A8BQOujM8Ny8nkz+rwWWNR9XWrf/zvk9tyy29lTdyOcSOk2uTIq3XJq0tyA9yn8iNK5+O2hm
AUTnAU5GU5szYPeUvlM3kHND8zLDU+/bqv50TmnHa4xgk97Exwzf4TKuzJM7UXiVZ4vuPVb+
DNBpDxsP8yUmazNt925H+nND5X4OpWaxKXwyhGNVicQNwZNUMBkTrNN9N6frXTpsNVzbQdcS
2qlJC9/YgIoJk2KOtWbPJYjNhLixP6Q5D9kCnusSTJV882sFqV4Wg8y4Z+LoE53MW4LTTLPt
W//e5XOsIzstAL81VXQJSdhJWBp/kjbmUZIO8yZ9HE0XvMnsQybQv0FfQKlERPSZ51eHnlAf
V1SoPv10Yy+xUGUJ5lhCLkMaTLTwJUdZ+gQek9QmRkpQgbLevni3/GcV4clXhB4PY9bpYrrW
X1Uu6lzGKAgEJTm4Diup8kyXHAc/DVL17e8vgg8CAwEAAaOB8jCB7zAfBgNVHSMEGDAWgBSg
EQojPpbxB+zirynvgqV/0DCktDAdBgNVHQ4EFgQUU3m/WqorSs9UgOHYm8Cd8rIDZsswDgYD
VR0PAQH/BAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wEQYDVR0gBAowCDAGBgRVHSAAMEMGA1Ud
HwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0FBQUNlcnRpZmljYXRlU2Vy
dmljZXMuY3JsMDQGCCsGAQUFBwEBBCgwJjAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29t
b2RvY2EuY29tMA0GCSqGSIb3DQEBDAUAA4IBAQAYh1HcdCE9nIrgJ7cz0C7M7PDmy14R3iJv
m3WOnnL+5Nb+qh+cli3vA0p+rvSNb3I8QzvAP+u431yqqcau8vzY7qN7Q/aGNnwU4M309z/+
3ri0ivCRlv79Q2R+/czSAaF9ffgZGclCKxO/WIu6pKJmBHaIkU4MiRTOok3JMrO66BQavHHx
W/BBC5gACiIDEOUMsfnNkjcZ7Tvx5Dq2+UUTJnWvu6rvP3t3O9LEApE9GQDTF1w52z97GA1F
zZOFli9d31kWTz9RvdVFGD/tSo7oBmF0Ixa1DVBzJ0RHfxBdiSprhTEUxOipakyAvGp4z7h/
jnZymQyd/teRCBaho1+VMIIGkDCCBHigAwIBAgIRAJNhG7GFaX1Mm3w/sd+ASzYwDQYJKoZI
hvcNAQEMBQAwgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcgSmVyc2V5MRQwEgYDVQQH
EwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMS4wLAYDVQQD
EyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTIxMDMyMjAwMDAw
MFoXDTM4MDExODIzNTk1OVowWjELMAkGA1UEBhMCR0IxGDAWBgNVBAoTD1NlY3RpZ28gTGlt
aXRlZDExMC8GA1UEAxMoU2VjdGlnbyBQdWJsaWMgRW1haWwgUHJvdGVjdGlvbiBSb290IFI0
NjCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAJHlG/qqbTcrdccuXxSl2yyXtixG
j2nZ7JYt8x1avtMdI+ZoCf9KEXMarmefdprS5+y42V8r+SZWUa92nan8F+8yCtAjPLosT0eD
7J0FaEJeBuDV6CtoSJey+vOkcTV9NJsXi39NDdvcTwVMlGK/NfovyKccZtlxX+XmWlXKq/S4
dxlFUEVOSqvbnmbBGbc3QshWpUAS+TPoOEU6xoSjAo4vJLDDQYUHSZzP3NHyJm/tMxwzZypF
N9mFZSIasbUQUglrA8YfcD2RxH2QPe1m+JD/JeDtkqKLMSmtnBJmeGOdV+z7C96O3IvLOql3
9Lrl7DiMi+YTZqdpWMOCGhrN8Z/YU5JOSX2pRefxQyFatz5AzWOJz9m/x1AL4bzniJatntQX
2l3P4JH9phDUuQOBm2ms+4SogTXrG+tobHxgPsPfybSudB1Ird1uEYbhKmo2Fq7IzrzbWPxA
k0DYjlOXwqwiOOWIMbMuoe/s4EIN6v+TVkoGpJtMAmhkj1ZQwYEF/cvbxdcV8mu1dsOj+TLO
yrVKqRt9Gdx/x2p+ley2uI39lUqcoytti/Fw5UcrAFzkuZ7U+NlYKdDL4ChibK6cYuLMvDaT
QfXv/kZilbBXSnQsR1Ipnd2ioU9CwpLOLVBSXowKoffYncX4/TaHTlf9aKFfmYMc8LXd6JLT
ZUBVypaFAgMBAAGjggEgMIIBHDAfBgNVHSMEGDAWgBRTeb9aqitKz1SA4dibwJ3ysgNmyzAd
BgNVHQ4EFgQUp9eVd+tKwyfNk743TCaEIRR9XZgwDgYDVR0PAQH/BAQDAgGGMA8GA1UdEwEB
/wQFMAMBAf8wHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMBEGA1UdIAQKMAgwBgYE
VR0gADBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVNFUlRy
dXN0UlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwNQYIKwYBBQUHAQEEKTAnMCUGCCsG
AQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0GCSqGSIb3DQEBDAUAA4ICAQBw
pquT4ow8LyRHG6NgR4oUsFncHl+eWLMtEBwv90EpGCGGDDDjoO23j4Zw6tS+THzwgz4SyP0M
FQaMzHj40enm+z1Y29QIQCnJTeDOHWHKMRxeiFD8MBso+XgVM6z6MMDbbJ95btM/4eE3LyaB
uBbheiINaAVieIdxLq6+dVkm00kmvMdlARsTkEvr5a9nYhGAs8T5RBD1DozAv9r89WJcn+QY
X1M2l5vv0ws3Me1ziVSjC2cRhcae4seOFFjkRdJItzfk6H/Wm2FNv2XG8nE1nbgN8UCdhORO
lQGGQ9DN152RmSJ1A6KAJIldo3YrJNiO8J4JLAE5/Tl9CNUHtbdYTOZLCAZ95G1g2GELQ2DQ
1Xxo55iNojqUA4w1feORe86Dq2P08xzolHKepP1LGEw1gDGCkUYR0gVXLJExGd3dfEZDm0mm
U7vWb6vRyLso/GUawFD2MZS4kK8/igkPO2Pkjfd5HD7hknpPVhcuBaWxWj8Q7bjwVlxGwts6
sNZ+UJ5HC4c+11vVoV9cdbb93qpbWn/d+azhit6kRYdUmAUl8Bt5VRBMKCUnSaAAspxb9kFK
+cvm/MjErxN63YNEcMs2QKs3N862V8MQaoKqD+KsKnaLxF6pxRpOotenpfUTNE9GqxP9nI6i
9rSHf16VFwW4NnJ6yUgzHUMdIqtTge98VjCCBiowggQSoAMCAQICEHb3t/4teUvaYKSSf0s+
XMIwDQYJKoZIhvcNAQEMBQAwWjELMAkGA1UEBhMCR0IxGDAWBgNVBAoTD1NlY3RpZ28gTGlt
aXRlZDExMC8GA1UEAxMoU2VjdGlnbyBQdWJsaWMgRW1haWwgUHJvdGVjdGlvbiBSb290IFI0
NjAeFw0yMTAzMjIwMDAwMDBaFw0zNjAzMjEyMzU5NTlaMFgxCzAJBgNVBAYTAkdCMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxLzAtBgNVBAMTJlNlY3RpZ28gUHVibGljIEVtYWlsIFBy
b3RlY3Rpb24gQ0EgUjM2MIIBojANBgkqhkiG9w0BAQEFAAOCAY8AMIIBigKCAYEAk7qaEDRX
E35PMot8PAmiNaWYblItPHGyt1+H+DUs2GAYHofsdeURmjngaB0C3GcUcrVav1HsGjJuoh77
nRif3O0gxUJGnIzj4ppKxxTsMNau8qvL+FnEkK6VrnqqnKIL3myjhJRdghUlK8Lgetl/3Pdz
KQ7JO2xPZFklrLRm8EQSuUdyccvb+auvRdSnwrxsOvV+9n18ZdeahL/RBxM7R31DhVkMPO19
EiQMj4PBl99wuWzXWL7yLgYh2/TJvIpSOf7waFcHkVYvfAPivV/ulUVaN2ncpSvlE4/TjA8d
5NXKOY+C7RcyD3UZIi6XVg7T81gOfnvE/eEGsyHmgjzLFDYpgBwVOd7jLQ9jhLX4hdRbm959
FrXQQrozzfTbyxRIwMwDqgUoPxIQVU9A7qXKu3yRXsn7OvnjYkYve6X0ZifTbjZaf4Hi/KXW
fNn67zqCt0eNONM2QB5bNqg14qLooRQcgRpSNAEB4UsSyhwsJqEhXz4QwPFWn/wwvEJ0FgYD
AgMBAAGjggFsMIIBaDAfBgNVHSMEGDAWgBSn15V360rDJ82TvjdMJoQhFH1dmDAdBgNVHQ4E
FgQUHwSkfkz2MrEJ4pF84WzfUr/PLv0wDgYDVR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYB
Af8CAQAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBEGA1UdIAQKMAgwBgYEVR0g
ADBPBgNVHR8ESDBGMESgQqBAhj5odHRwOi8vY3JsLnNlY3RpZ28uY29tL1NlY3RpZ29QdWJs
aWNFbWFpbFByb3RlY3Rpb25Sb290UjQ2LmNybDB/BggrBgEFBQcBAQRzMHEwSgYIKwYBBQUH
MAKGPmh0dHA6Ly9jcnQuc2VjdGlnby5jb20vU2VjdGlnb1B1YmxpY0VtYWlsUHJvdGVjdGlv
blJvb3RSNDYucDdjMCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTANBgkq
hkiG9w0BAQwFAAOCAgEAWooWgE/1j6esLJfOKB48VUcFaafH6wZcbEln7ls6BP7IvAP2GDRF
33LtQhuVpt7qIqm/RXxWQLaC0yA14LE/pZZdm6CkkoWlTRgzZln6rM9dm2JvqyX2TLS0Z7P1
E6o9EmPx53bRNrnauUu2lYYfpODYq/5LzDPWBjGNK5QW4+oKCykPzzfSveoF5KTuW1xxy+da
EmtXm3hgYwYvTrB/7jHZU2hVbj/8DUAf/JCa/+AdQCtUE5XzKl6o5gGtWahY1yh9smQ3b48/
cto1QW+ZwGCHk5CLr5bDhe2uh2ifn8BXxBOf33D6YHjnrOUyNxi43QD2wZRwyL8arpu/Ljl4
H9zwIM0Q4vfbZuDghYLDnRVC1fGYBArWxw+uvoEMvO7lcc9MTezGkonPmanHYAcGffaIXpIQ
rQWtWS9Pb22jEy6YZCUiqH4YcqkelJHqJD1HBLVMOPaCn2wXgBbv9jvZQsP9yFrD6tKX//ue
D1V12I+L8qjUj17/ZRuxLcPDCF6vb/Svnu38Ejni16jHUO9G/YWFBZOuRbutUEgEp8hMXEzJ
XO43NzBthf80VV86GaC83nNy3TETFF2yav+ioLIK7Qd5NRnI4DXNQYPq6j8qkEnODayXA1bR
7V/qy4BrdrLHJf9NHMiANvCNiDn02MuniTPmb+rp4syaXK409MSG4PYwggVWMIIDvqADAgEC
AhEAsFHj29zvfVPWA2FcnDeJlzANBgkqhkiG9w0BAQsFADBYMQswCQYDVQQGEwJHQjEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMS8wLQYDVQQDEyZTZWN0aWdvIFB1YmxpYyBFbWFpbCBQ
cm90ZWN0aW9uIENBIFIzNjAeFw0yNjA3MDIwMDAwMDBaFw0yODA3MDEyMzU5NTlaMCoxKDAm
BgkqhkiG9w0BCQEWGWpvZXJnLnNvbW1lckBuYXZpbWF0aXguZGUwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQDNxFyhl/UuZdUpuQiuqZBMSU/pN5SMIj4lkvTlrtp2jl4Q77wb
v4vXdXIFWqKd3qtut55G0ptK4nXs1ARrh3AHQAYwB0vW+PHVNPLs9yombnTeMgnEv/RQDFkH
+DxoKdY5+DRUmcVO/tYl6ExMEBj6oh6b/63whIkC61WRETH3FpRCRbyNBD73OWt0KzxoKzW9
xmdqfhNtylLcIFMzuv9C1WAqJ3mLbFHYaW4NEMMckPZJWWYzvA2nwCCryerE3J9z4ZbSK0OK
6DDRN9gW/H7+/4pHSIhdooGfQEdgLj+Z4ZPhvLMF5DncBD8k5DOK8mlDxCKp4GsrLLuBfLQd
xilvAgMBAAGjggHHMIIBwzAfBgNVHSMEGDAWgBQfBKR+TPYysQnikXzhbN9Sv88u/TAdBgNV
HQ4EFgQU3lTOaS6cJRsIzzEjdtC4j6GPtWIwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQC
MAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMFAGA1UdIARJMEcwOgYMKwYBBAGy
MQECAQoBMCowKAYIKwYBBQUHAgEWHGh0dHBzOi8vc2VjdGlnby5jb20vU01JTUVDUFMwCQYH
Z4EMAQUBAjBNBgNVHR8ERjBEMEKgQKA+hjxodHRwOi8vY3JsLnNlY3RpZ28uY29tL1NlY3Rp
Z29QdWJsaWNFbWFpbFByb3RlY3Rpb25DQVIzNi5jcmwwfQYIKwYBBQUHAQEEcTBvMEgGCCsG
AQUFBzAChjxodHRwOi8vY3J0LnNlY3RpZ28uY29tL1NlY3RpZ29QdWJsaWNFbWFpbFByb3Rl
Y3Rpb25DQVIzNi5jcnQwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLnNlY3RpZ28uY29tMCQG
A1UdEQQdMBuBGWpvZXJnLnNvbW1lckBuYXZpbWF0aXguZGUwDQYJKoZIhvcNAQELBQADggGB
AD6hnou447615g2A0y87bR6mtVI+C+wAFCqRqfrCgHu0dB29VPiVXIVYbPN7H6meSMNr2lFo
e81aZfbE7LMQj98hVKA/ljqWKJe6R5W1Tssv1568G9GJ0fvL1iGT74LuqcuYPt0LVH99Q1rH
MfCBKpsyFo7P3JwoqEkuIpbAhaQMYdTcOgeHMYOLrIdx/9wQ1BXjTa/Cajvc3QxJEb308wgJ
PBxhl8FWWm5MNOynBmRZPKeOeMF5113u6b03KTmXhBqSVeN2nZXEZ+B+wNcJv1dr4Sa0/k6p
tbjZcr9ZkK7QtCarYgLDbsSbcLRJMuXUSHf1yaLwihZWJ1asynbFEmv1SrRSQ+3Hv4megEeY
kYmW9Jiu9qh5z6S98F7JhsP4n6tGs24Xz7l2I/T+BmJMRglTeQnzBihH0kFPUanlApSKC99A
clKs/tfOX8HKHs79Bw3PjRjJDog4D4Pbkom8UwQ/m5sCuOf7v632pjK2jm3OErS3XZxIjnFV
4Gl+5jZ1zzGCAjswggI3AgEBMG0wWDELMAkGA1UEBhMCR0IxGDAWBgNVBAoTD1NlY3RpZ28g
TGltaXRlZDEvMC0GA1UEAxMmU2VjdGlnbyBQdWJsaWMgRW1haWwgUHJvdGVjdGlvbiBDQSBS
MzYCEQCwUePb3O99U9YDYVycN4mXMA0GCWCGSAFlAwQCAQUAoIGgMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDkxNTA2NTYxMFowLwYJKoZIhvcNAQkE
MSIEIDdnKg4uVN9CzW/dfjjXJ+TCVYGezuBaspbQyg7AZvVsMDUGCSqGSIb3DQEJDzEoMCYw
CwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzANBgkqhkiG9w0BAQEFAASC
AQAtsvWXVoiIjfbP9Js10ja7d4ZQgkU+7lz7Rod2CWIB2eOpZTyoZeGndoGJy5VEgRU1QYHb
56fRzFuOl/wBJTDTo9hTNG7jQNomZo8wBHjINFMtVHiBebx19X13wKGk50UFrq2AedCIVJIN
TyTe8zfpgyx7MAd4AtpIoXS+RFy1QRVlAF6kM7kl1eyeAG2hNGHozzLsq6s91BEsLXVHDB3D
/6xF4vfs0rZp6pzY4rE0SBpWqfjFvXPcXPioWYxXzJWTEYYfmnTZ1Wm+7is+EtucnFqsAbUd
ucq1UAr/WrZ8/yrjSO9NHSChBonuRg7cMD26NpR3rTf54RR5w9Ut2GUs

--fzfwqjd4uqbmfxkq--

