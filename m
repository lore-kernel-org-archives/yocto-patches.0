Return-Path: <joerg.sommer@navimatix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3377CF94CC4
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 05:19:00 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.113])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.69577.1776835135093816071
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Apr 2026 22:18:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@navimatix.de header.s=selector1 header.b=tP7Q3Qmj;
 spf=pass (domain: navimatix.de, ip: 40.107.130.113, mailfrom: joerg.sommer@navimatix.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIX89Sv7a3ihYOdenwdOTwM5gPzfG4mDu1QvRxcc/WoW/TqqctR0dBUzZXiQ4mLgqTi3hfSy7I3E/wLwunXN/UokXb6rxbDe6c7OKBR8zniC/DrQaXvCKL3/TLoA+PWxvHWaHPMKjPWz4qWVePbJ3DA1OzIjOkpRGtuQhCdGF0hG90Hi6J62CewP7D6VwEvHYJMyX6eyHTR5UXta7A9mGhcLzXdE3s+GpPC9Dudo06wrrhtORi5Z7VC/10tKqhKdjLfD4/zyCLjFIb05AFB/gC3sRzAd9D98TDu6YHmsA0mo/GRfz5YWJRzLDQQDen2mtrfcTPWOfkR6LZTuf2R4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkgSjKTPMOy5l7y2EU6yK38cE5seeimokFAhqe9y+Cs=;
 b=W/VkXDDx2qSMg/W52la5kGIvWRsgZckg/cR9sITzCoWbTTjQCR9rIPPwdekCfirJNc+BjtDJfF5gV475qPIiP5GC6fMq9jDl0FZO8h8pqiyWbqlih52yU/SJ54x/tIFUDv47iTcCkCls+53L3zGSJAIbHQjenSX+9q0jKTQQwxycr4qUsyKkBEH8RYc6aOBJcck8syKb8wAVi1jsuHnu2T/UwroB6E6CC8GKpAEfoTNU+TWhyVBYZx0nQPS0s6Uqn+t4/QKYQwBcrqnrfYTqPkQGtfr6FTQc3oAPtpp06GOdkXiTUqlJskT08wIOH0vYMGAx5e274FubhJbSIPzRiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=navimatix.de; dmarc=pass action=none header.from=navimatix.de;
 dkim=pass header.d=navimatix.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navimatix.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkgSjKTPMOy5l7y2EU6yK38cE5seeimokFAhqe9y+Cs=;
 b=tP7Q3QmjjD3jte998MQB3Yh/JoA4aZEVwItS3M45vjkbHyAb+eAmBuR4oZmWt9hkimAEjtnSCaKGPOeKiMZtTDn2tdWw0pJdUw916s1xNtCB46S79yGil4Zw5+lCTYPpxn7/a29Tb/x8CVB6ODrdVRglT/GJ+k1S3jMnqjnojTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=navimatix.de;
Received: from AMDPR01MB11848.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:716::14) by VI2PR01MB12522.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:32a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 05:18:49 +0000
Received: from AMDPR01MB11848.eurprd01.prod.exchangelabs.com
 ([fe80::bd09:997f:d01a:43f0]) by
 AMDPR01MB11848.eurprd01.prod.exchangelabs.com ([fe80::bd09:997f:d01a:43f0%5])
 with mapi id 15.20.9846.016; Wed, 22 Apr 2026 05:18:49 +0000
Date: Wed, 22 Apr 2026 07:18:46 +0200
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-raspberrypi][PATCH v2] rpi-base: Use
 MACHINE_FEATURES_DEFAULTS instead of MACHINE_FEATURES
Message-ID: <aehZ8R8krs64qd1O@navimatix.de>
References: <18A5505E57DB46C1.657799@lists.yoctoproject.org>
Content-Type: multipart/signed; micalg=sha256;
	protocol="application/pkcs7-signature"; boundary="xb4qh4osb36oednz"
Content-Disposition: inline
In-Reply-To: <18A5505E57DB46C1.657799@lists.yoctoproject.org>
X-ClientProxiedBy: BE1P281CA0416.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::20) To AMDPR01MB11848.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:716::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMDPR01MB11848:EE_|VI2PR01MB12522:EE_
X-MS-Office365-Filtering-Correlation-Id: c048e206-89ab-4c2d-5084-08dea02ea1ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|4022899009|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	k2Y1WJPv8YhKQmPwIa5atETzjOtyX/oMQwBDaSHS++bbR+rjaBh6yv0o6zzfOoS2JYm7Q9320VGp78f98gudj/UhpurmBZ9jlm1TiueV3/TwQNpc9xnPcQAntMAMWorN2O1EUqB5BYfRPsAVzakSy94ykKBM4TaLKWmqLZQfGeywz0P8dAHjYyAW3kKsrHWdo+XMU0N3agRSk4Tw2BLinSHnaSwdmf6VjVCu6mSiXhv0MLPEnBSyN6tBbxHc1bO9cnM9CHB/BzJfHzISbvIbcC1R41m7VpXzNjDiJxr3HYD6LXJnK1w+LpSCrT2Xa8iXRFdadryokMSrAYnTiieZKPDb8kivd1fxUOxkXqpxQxrgHxriQDiuckHbZymC8u/mphigg6gd1wtOgWWchU440Adrzviz+DMSGIqyYpAgHgU6bp8QZNBd2vBFTTtEfHmrc8EwQ3764NnHKGJCcHEUW4Wt2iZ/1UNAQQ5SzkGCLVuDjpUASCUlIz+wE7YRmaARt38fU94UZLoZWOTRuWJHBEFZoKF2AMGesWyWGdx7sR3ylY8qlZws1bjXehN+PTqB6UAaskoxHf7IqCXgtpG4IU9ATNMpTk/Lca6EmUfElYbCIpwm5lVTAlZ5LIyX5AGfGM+Re4V8QrJxt6WRQ43eNoA2+kj9/ireU1h0OgsaTT4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMDPR01MB11848.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(4022899009)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?iso-8859-1?Q?UIm6vWeBjNLARe8CeJVHrKyLHxG8IzXseB9TYFtRfJad0a1+8yTIgDt1oj?=
 =?iso-8859-1?Q?qtLJnPcwTUUWh58UpDjxyCAg5Br71PAuyEpLWLYwFyVToEo6Q+QSKxAUui?=
 =?iso-8859-1?Q?C7AGi2XO3aj7G5qFj29S3Bm7RCOg6x8ltBXOcSazxTxaG9AYW10vcZixTf?=
 =?iso-8859-1?Q?fFi/xgAOFLLRVlzXXmDRghuln2Kswx8+di0eeRuE2H8mESMunBrskJwiGp?=
 =?iso-8859-1?Q?JTsej7mZRrAgAnWDhKXcaGN5r2htfSaYJPO9ginG8nm4ICeGlx3pRqzM0G?=
 =?iso-8859-1?Q?rOA2fzqE5ceRmxEMy3ipoqhW0w4DNzhddFMhA/qGV2x898XsC690AV1oDN?=
 =?iso-8859-1?Q?cmc5t0PlK/+iA0rvrvmxlVnILjEY7R8lh9XUtfbj2YKwy8M8+ZP4mlJBQP?=
 =?iso-8859-1?Q?KhrMbwUY9hxvbMybZ6sZhI4ZjIH7FBqkb4ClOl5C+BCg7sdYKA+rXwJvnt?=
 =?iso-8859-1?Q?TFXrjPP9v2PiBD27dAeIQJ57EtW20vvRRIBujxpOf9zlGXImz3GUSYswLk?=
 =?iso-8859-1?Q?RF1QLHtDADRgiBOFVTl3HqBMyPpxUp80KVbqpsDYvw5mU1GzyVLDx7vJ9R?=
 =?iso-8859-1?Q?INBMDYr8X8AId03/gao+m/d9LsH29jxywhX9D+bN5qqHw0dlTWVH+2aNnp?=
 =?iso-8859-1?Q?nNvnc9ZP+lqUpsTe/uYYFmwJJEWE0HTpLQkGbC5c4sXORGNaLGO3k3bOA2?=
 =?iso-8859-1?Q?GawjwNPTF38c/TXe1VFC9G5yaN3THVsXiW1/gLfH3nJAXbQJL8I4DmfeS5?=
 =?iso-8859-1?Q?yY+N+vF9paltzRrRXtY3AVW9sj+HkYS7OVOsJpWwA6q48Gf2QQLxyiPEJ/?=
 =?iso-8859-1?Q?drbsOwMbPiyTS1/HXawrzb5oZZ/NgXRGtLFnLwZ0RKCjHOqU5xesQVgcEC?=
 =?iso-8859-1?Q?DmFGZEdhzDuS0cTVFrkJ5j6F+OeUMPoqlwO95EaTt+KN1rA5kJfOs6LWXK?=
 =?iso-8859-1?Q?nFh7EJg3QdUxbTuXJyMqxSnbS0spls1dLKbwvWFOgpB77k9G91FOewpuN4?=
 =?iso-8859-1?Q?0Fcg9+DxfJquXhjQHKOqDQYe5/Sf95opt1xPHRxA9G3AGw7v7pSZKHZk4E?=
 =?iso-8859-1?Q?/Kt/PssacLiEa3DmGNHjYGu2h99RsaXk03MBmKIBKsIKzRjZFzdUAZB8xX?=
 =?iso-8859-1?Q?0v9jnR6r7/G3w0fyhil755zAEz6QTbg4N1OVlmQyFkDl4rjurS2VnHe2VB?=
 =?iso-8859-1?Q?1PsxezFeuuiGq3HmmS9aWZ1+SyLPKKGai4l9jCb99g2KTVVYGzKk4WTMLN?=
 =?iso-8859-1?Q?iuC8R+6SLoSPGpvsGaLkreh1hNA0nLpMo5M/WogLAHijifOwHAHiXNaR3w?=
 =?iso-8859-1?Q?Imj0+T7hYFm3UE/uYiYS9T7P+cjOWKIzD2830DudfuNV2D7qHpd33LjadZ?=
 =?iso-8859-1?Q?VHysZ5m6e3H8IVvTLAQSQpgRvRk7c9s0JBnl2nQI6e8ixg7sSNXc412TB8?=
 =?iso-8859-1?Q?Lz8Hyp/tjvQvhVc2Wpf48+kFuPE8Gl9C+JnTcEKxWJbFOSN6ZrtHUuhM5Q?=
 =?iso-8859-1?Q?q0zdfwWVlz+207+izJzcbEP3cNFmZVgz6pdE1OoWnh7qMSPI9YAlzw0ZpW?=
 =?iso-8859-1?Q?xcm7JosuMiS7hBUIWoSR3dX0TbIpKIBSmcGKbEu9BhF1pPscI7uaw7SkCl?=
 =?iso-8859-1?Q?I8lzalH2RiLiD8dPVN9bA+8D49jXdLzlH5N1XRmII1r0/96e0e4SSzbFcM?=
 =?iso-8859-1?Q?IKkRn2BxAPvOJnivN6seWabTTQ+vH5pgAuBeK2IjywnC+AiN2lBz1FZf4i?=
 =?iso-8859-1?Q?/xTbldl4HznOMXok427/sEcEtjQr4N1U7vfEyGAs5fwrXthrs867wYMFrv?=
 =?iso-8859-1?Q?tyfbFtaux7TtbXsTm3DvEBwpvGHWLmI=3D?=
X-OriginatorOrg: navimatix.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c048e206-89ab-4c2d-5084-08dea02ea1ed
X-MS-Exchange-CrossTenant-AuthSource: AMDPR01MB11848.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 05:18:49.1146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c87b4f54-b992-4813-8f3f-4a876324197f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRvKBrNay+AqaHfPDvs4yAVcw56TlPQiYV1KYKkSRe7gVQ2YhfCMVDGCj004qMY2v5kJ73kyD/UGpzSyLI0Q94JwBiwLjpQyonUM2ujCnJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR01MB12522
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 22 Apr 2026 05:19:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3757

--xb4qh4osb36oednz
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [yocto-patches] [meta-raspberrypi][PATCH v2] rpi-base: Use
 MACHINE_FEATURES_DEFAULTS instead of MACHINE_FEATURES
MIME-Version: 1.0

J=F6rg Sommer via lists.yoctoproject.org schrieb am Sa 11. Apr, 15:26 (+020=
0):
> From: J=F6rg Sommer <joerg.sommer@navimatix.de>
>=20
> This allows the users to opt out from some features like wifi or alsa, if
> they don't use it.

gentle ping

>=20
> Signed-off-by: J=F6rg Sommer <joerg.sommer@navimatix.de>
> ---
>  conf/machine/include/rpi-base.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/conf/machine/include/rpi-base.inc b/conf/machine/include/rpi=
-base.inc
> index db0bbcc..7a38ab8 100644
> --- a/conf/machine/include/rpi-base.inc
> +++ b/conf/machine/include/rpi-base.inc
> @@ -126,7 +126,7 @@ KERNEL_IMAGETYPE_DIRECT ??=3D "zImage"
>  KERNEL_IMAGETYPE ?=3D "${@bb.utils.contains('RPI_USE_U_BOOT', '1', \
>          '${KERNEL_IMAGETYPE_UBOOT}', '${KERNEL_IMAGETYPE_DIRECT}', d)}"
> =20
> -MACHINE_FEATURES +=3D "apm usbhost keyboard vfat ext2 screen touchscreen=
 alsa bluetooth wifi sdio ${@bb.utils.contains('DISABLE_VC4GRAPHICS', '1', =
'', 'vc4graphics', d)}"
> +MACHINE_FEATURES_DEFAULTS:append =3D " apm usbhost keyboard vfat ext2 sc=
reen touchscreen alsa bluetooth wifi sdio ${@bb.utils.contains('DISABLE_VC4=
GRAPHICS', '1', '', 'vc4graphics', d)}"
> =20
>  # Raspberry Pi has no hardware clock
>  MACHINE_FEATURES_OPTED_OUT:append =3D " rtc"
> --=20
> 2.53.0
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3692): https://lists.yoctoproject.org/g/yocto-patches=
/message/3692
> Mute This Topic: https://lists.yoctoproject.org/mt/118774729/7646358
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1317866=
0/7646358/1007512174/xyzzy [joerg.sommer@navimatix.de]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20
>=20
--=20
Navimatix GmbH           T: 03641 - 327 99 0
Tatzendpromenade 2       F: 03641 - 526 306
07745 Jena               www.navimatix.de

Gesch=E4ftsf=FChrer: Steffen Sp=E4the, Jan Rommeley
Registergericht: Amtsgericht Jena, HRB 501480

--xb4qh4osb36oednz
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIIThAYJKoZIhvcNAQcCoIITdTCCE3ECAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0B
BwGgghDNMIIFgTCCBGmgAwIBAgIQOXJEOvkit1HX02wQ3TE1lTANBgkqhkiG9w0BAQwFADB7
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
jnZymQyd/teRCBaho1+VMIIGEDCCA/igAwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkqhkiG
9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkxFDASBgNVBAcT
C0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdvcmsxLjAsBgNVBAMT
JVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwHhcNMTgxMTAyMDAwMDAw
WhcNMzAxMjMxMjM1OTU5WjCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4w
PAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBF
bWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMo87ZQKQf/e+Ua56NY7
5tqSvysQTqoavIK9viYcKSoq0s2cUIE/bZQu85eoZ9X140qOTKl1HyLTJbazGl6nBEibivHb
SuejQkq6uIgymiqvTcTlxZql19szfBxxo0Nm9l79L9S+TZNTEDygNfcXlkHKRhBhVFHdJDfq
B6Mfi/Wlda43zYgo92yZOpCWjj2mz4tudN55/yE1+XvFnz5xsOFbme/SoY9WAa39uJORHtbC
0x7C7aYivToxuIkEQXaumf05Vcf4RgHs+Yd+mwSTManRy6XcCFJE6k/LHt3ndD3sA3If/JBz
6OX2ZebtQdHnKav7Azf+bAhudg7PkFOTuRMCAwEAAaOCAWQwggFgMB8GA1UdIwQYMBaAFFN5
v1qqK0rPVIDh2JvAnfKyA2bLMB0GA1UdDgQWBBQJwPL8C9qU21/+K9+omULPyeCtADAOBgNV
HQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYI
KwYBBQUHAwQwEQYDVR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9j
cmwudXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNy
bDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNlcnRydXN0LmNv
bS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcwAYYZaHR0cDovL29jc3Au
dXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEAQUR1AKs5whX13o6VbTJxaIwA3RfX
ehwQOJDI47G9FzGR87bjgrShfsbMIYdhqpFuSUKzPM1ZVPgNlT+9istp5UQNRsJiD4KLu+E2
f102qxxvM3TEoGg65FWM89YN5yFTvSB5PelcLGnCLwRfCX6iLPvGlh9j30lKzcT+mLO1NLGW
MeK1w+vnKhav2VuQVHwpTf64ZNnXUF8p+5JJpGtkUG/XfdJ5jR3YCq8H0OPZkNoVkDQ5CSSF
8Co2AOlVEf32VBXglIrHQ3v9AAS0yPo4Xl1FdXqGFe5TcDQSqXh3TbjugGnG+d9yZX3lB8bw
c/Tn2FlIl7tPbDAL4jNdUNA7jGee+tAnTtlZ6bFz+CsWmCIb6j6lDFqkXVsp+3KyLTZGXq6F
2nnBtN4t5jO3ZIj2gpIKHAYNBAWLG2Q2fG7Bt2tPC8BLC9WIM90gbMhAmtMGquITn/2fORds
NmaV3z/sPKuIn8DvdEhmWVfh0fyYeqxGlTw0RfwhBlakdYYrkDmdWC+XszE19GUi8K8plBNK
cIvyg2omAdebrMIHiAHAOiczxX/aS5ABRVrNUDcjfvp4hYbDOO6qHcfzy/uY0fO5ssebmHQR
EJJA3PpSgdVnLernF6pthJrGkNDPeUI05svqw1o5A2HcNzLOpklhNwZ+4uWYLcAi14ACHuVv
JsmzNicwggUwMIIEGKADAgECAhEA/OH3TxzsxiYnBai43hD2fjANBgkqhkiG9w0BAQsFADCB
ljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMH
U2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJT
QSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAeFw0yNDA2MDQw
MDAwMDBaFw0yNjA3MDMyMzU5NTlaMCoxKDAmBgkqhkiG9w0BCQEWGWpvZXJnLnNvbW1lckBu
YXZpbWF0aXguZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDNxFyhl/UuZdUp
uQiuqZBMSU/pN5SMIj4lkvTlrtp2jl4Q77wbv4vXdXIFWqKd3qtut55G0ptK4nXs1ARrh3AH
QAYwB0vW+PHVNPLs9yombnTeMgnEv/RQDFkH+DxoKdY5+DRUmcVO/tYl6ExMEBj6oh6b/63w
hIkC61WRETH3FpRCRbyNBD73OWt0KzxoKzW9xmdqfhNtylLcIFMzuv9C1WAqJ3mLbFHYaW4N
EMMckPZJWWYzvA2nwCCryerE3J9z4ZbSK0OK6DDRN9gW/H7+/4pHSIhdooGfQEdgLj+Z4ZPh
vLMF5DncBD8k5DOK8mlDxCKp4GsrLLuBfLQdxilvAgMBAAGjggHiMIIB3jAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQU3lTOaS6cJRsIzzEjdtC4j6GPtWIw
DgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsG
AQUFBwMCMFAGA1UdIARJMEcwOgYMKwYBBAGyMQECAQoBMCowKAYIKwYBBQUHAgEWHGh0dHBz
Oi8vc2VjdGlnby5jb20vU01JTUVDUFMwCQYHZ4EMAQUBAjBaBgNVHR8EUzBRME+gTaBLhklo
dHRwOi8vY3JsLnNlY3RpZ28uY29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFu
ZFNlY3VyZUVtYWlsQ0EuY3JsMIGKBggrBgEFBQcBAQR+MHwwVQYIKwYBBQUHMAKGSWh0dHA6
Ly9jcnQuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2Vj
dXJlRW1haWxDQS5jcnQwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLnNlY3RpZ28uY29tMCQG
A1UdEQQdMBuBGWpvZXJnLnNvbW1lckBuYXZpbWF0aXguZGUwDQYJKoZIhvcNAQELBQADggEB
AANadCCx1OE0/PYv8CMHn1qrbn3u9yIQuut1yAVv1daof2ULxyGOm/M+XnSW1h+xcUukaNTB
qwJx6KTauuWjVL1LRXz9+sNvQfS1KdJF9yfgcCTiIMNjfKap+t/dD275tpVeLbRSWyJaQRhb
GVjarr8yry1mnaaiJqv1TERaHqjDNpEwU/Ex8XetmkdJK01qCP+ZOEHwRr/pEB/oEKYB08+P
CfWWWT0YVlwW3FdYpMi70zyynhyE0ZkxBuwh20CulXlafk9nzu1ly9HDU2MG6fnKLirJLOj1
+9s6RvytgsBtk1dB4lJEMe32RnTa4ABWg2VpdqmG7wjr2BlUCzLzuxUxggJ7MIICdwIBATCB
rDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE
BxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAPzh908c
7MYmJwWouN4Q9n4wDQYJYIZIAWUDBAIBBQCggaAwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwNDIyMDUxODQ1WjAvBgkqhkiG9w0BCQQxIgQgosoX8CoJ
T7agePsQ1hRT0KYsYkdFYxGe3ebLrEYfHzAwNQYJKoZIhvcNAQkPMSgwJjALBglghkgBZQME
ASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBAQUABIIBADLTDOTXWqLC
PeAMUEe2r9wUpDBYuAdxTqrd0sk+aoc4qvKxpWz4E0BQGL+pGAVOpt5IsCFFGqkzG4cchmCc
g0VQR3we/5YAaAqF/ffy8CkH4rcGDwzp9xcJplEjsvq5csM80dvB6Wp4QkPigaUvupx0op+/
pizHUFy3ckvPGHK4Xhzw9LYS8JPGlaWnxG0oohjEdf1pFUbEczYNbEs1WobagqViXUbj+8C6
aTy54vOlo0QM3dnFmqQxaKIhGFg4rf6UBpB3bw+l1q2cvdLFuHFn/4yjo2hhJ0tN5ytjdjcR
wpNqFr2rrOt2w3Zs71/acaoRNanWEnEcp5GBFOJyNw4=

--xb4qh4osb36oednz--

