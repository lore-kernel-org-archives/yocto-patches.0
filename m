Return-Path: <joerg.sommer@navimatix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AD2FF885A
	for <webhook@archiver.kernel.org>; Fri,  1 May 2026 04:08:07 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.80])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7599.1777608477900729724
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 30 Apr 2026 21:07:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@navimatix.de header.s=selector1 header.b=r0gF96OF;
 spf=pass (domain: navimatix.de, ip: 52.101.70.80, mailfrom: joerg.sommer@navimatix.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8BnsNDYTjjWmsXCrFyITeQ31mp6DGFFmGLgPIa2Nppx8gK5OY8+U2H2x0Iwk7FvdyT04H7btpPggjYk6eq7hn493yJxTNH4jv0jEiOpYuovAN8EbfYUv+0KX3Tn/VltOs13ZNpSCxfnwLOE4b25qh7CdtKQsdVcpIjoVI0a/cnWNKq8wilkJGkFv1ma/Ew8ja90RcGI0yIB5UoVvLzYGwVI35bXnU4cMIglvlTGUYEsnYKfxCvYV6ppYJOBkZcxokL9GxlEcl7mP4Opee1fwZ/3T01daB4dzFVhk05heCXsIRXDrZ0HOFrUd824M/8QJnY7TSc+lXnOALePWr0jkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5DMoF3dEkIQr0jMxqCBvuJuKJTtJ9GFyJELISM+mBg=;
 b=vlWbbX99GSI+tnQ664sJwKAakxFEHgbnc3QNcHqtgUN6jZjSvnO/0zTVesPNgXtW7ix9SA6dVd0MHvsYVcgThMg/MHcCQ+oNFg272VtKMfQFVnQUNqXze/lRTooVxfaKHqy/PiuQ2Ob4i5I9LFDUmE3np7qSMyMmIhQ1wd49xpiRpxrWXSfPVP9bw7s+WbIyaPCHmAPn8OLY6ixvMlQrmyD/T+3xTelfIXuxW0I2KJ9lIOL/kXlyQmjTUdmdkE764CWRJyXSDcX35OnyZnwchcqbS8lbpwP1EKq2xfHHG6QUZtwOf3GpnE0FVlwnezpEkYV33QNZ/to8FcETsujjYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=navimatix.de; dmarc=pass action=none header.from=navimatix.de;
 dkim=pass header.d=navimatix.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navimatix.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5DMoF3dEkIQr0jMxqCBvuJuKJTtJ9GFyJELISM+mBg=;
 b=r0gF96OFF+xMiyj+KIZ3nKeOb6afkaMKVY+9jEkHES9YXaAfxUWaI17/twPgntiadtw2futyBjcb24jUnk0o2OeWDSrCk8PexF0WUBFzYRgVpd1LoxTbthjQp9zQCMfoGYy4Hg7mav0mVkai7DUwk9xco5e23zIYr3Ka+EiOUZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=navimatix.de;
Received: from GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:2cb::8) by PA1PR01MB11080.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:48b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Fri, 1 May
 2026 04:07:53 +0000
Received: from GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 ([fe80::d5c3:2dea:3d98:25fd]) by
 GV2PR01MB11835.eurprd01.prod.exchangelabs.com ([fe80::d5c3:2dea:3d98:25fd%3])
 with mapi id 15.20.9870.020; Fri, 1 May 2026 04:07:53 +0000
Date: Fri, 1 May 2026 06:07:50 +0200
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
To: yocto-patches@lists.yoctoproject.org, 
	Andrei Gherzan <andrei@gherzan.com>, Khem Raj <khem.raj@oss.qualcomm.com>
Subject: Re: [yocto-patches] [meta-raspberrypi][PATCH v2] rpi-base: Use
 MACHINE_FEATURES_DEFAULTS instead of MACHINE_FEATURES
Message-ID: <afQmVQnM7iwMPiFg@navimatix.de>
References: <18A5505E57DB46C1.657799@lists.yoctoproject.org>
Content-Type: multipart/signed; micalg=sha256;
	protocol="application/pkcs7-signature"; boundary="glnz7pa7xspyyxfd"
Content-Disposition: inline
In-Reply-To: <18A5505E57DB46C1.657799@lists.yoctoproject.org>
X-ClientProxiedBy: BE1P281CA0307.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:85::8) To GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:2cb::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR01MB11835:EE_|PA1PR01MB11080:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c27d6a-0d54-470e-7b04-08dea7373762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|4022899009|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	1etyH34nmKplusBNvHrsDqbaIctBtbYvCTHy4JBtJFSXgUyhG3chPzHDVo4zAHStxkX6EFW0oWPZ+5YG1XpIhGcsC8lC/Ibns22zt4wsS347+9ogXCueeEfe5iO6+YEFTgQUOIVpYwMEsRusCzrdsZd+foJkGPE5CM8RuIvHgSc6q4jMOYkxtMRP4G9eBdVlqf9kXTcFYwBSOfxuq4AQNswduHbznEOjlKn1yS9Wq+NfsLVURL/xl3D0gAxu0vn/adkxF/1g2Tv5E9syhpg1I/LozKdLCsTNiobPkS4yisI5D18A/YBXiiX4+ycHHKTGwbEh17ioj67BV9NFMeBMkBJQZhCHN7dpsAzMAyhCz+sEXnVJGF1dy0ri/DEqWQR3s7i/IGt0Zd7LUXEHuTz0fWAI/q16MPK4LyukCaXlfIsQt1e6Z2FXKmLzBhq85sq+u8W5kV9LtkV3D38aS6EWf6W7f9P7oz55hC3HmRP5BbdHvpDNuRrfJJ3hQ95LJyKr/SjduAYtwdDocCt7JqkVy5KQf9alqo0McfLo+MW6vC++e2swJGBytv0EfHoJCS98UwbiN952P3JUOnlwDOzIFrwQWSzaOW7GAtN7gxFkpfDAhD+bzr5wHaXTETDWKiRQjk8FMgcHFk/W46vI5e4TRQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR01MB11835.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(4022899009)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?iso-8859-1?Q?JIraM69cmwq+PoXiAvnXOxRzcJ5Bdjjsfln2AVuz73AeKb8C3sOAr+c7ZQ?=
 =?iso-8859-1?Q?pZrlaxsJz6DecqQPf9GQZnXUGWOwdhUjfLFlDAYgwG8l7hQ6vhPr2lTfZI?=
 =?iso-8859-1?Q?b18MqxMaBPzKQxNcp03iHQCDwNN2jejcIT+kyj0VcBgcpsGYAE5byhLIU5?=
 =?iso-8859-1?Q?9lRrwN/uyoQrZl9GLe93BToTZsQ1tLgxJXjbCjeVrjxIIU5KIoylZ2Orb2?=
 =?iso-8859-1?Q?WSbjg37+Sc4NzqZlvple//EveunX/3eQbQXodpjllXCfliCErYElSLtYdJ?=
 =?iso-8859-1?Q?hYhGMK6UKxTIKmd3OvBzgHq0I//9uRCyBZx40Xyo4Gr0z2nXTsgdHfEIgV?=
 =?iso-8859-1?Q?bwMOBobL1jirjByaOG0//w+dX3tfj3Ml1RCHSCVYdmSHsiQvHmdqEhxw2h?=
 =?iso-8859-1?Q?/neqZ/TgORAUjKcMCNXy3Fo5Y693ZTttLeLqOifHP46YmtY0atQIUsQl62?=
 =?iso-8859-1?Q?UivItLg5GPNWPK2RMefUqSG5um6PGwCG31QoXPM8cnlc8idUwF6x/05s9X?=
 =?iso-8859-1?Q?8SawhumAciglzXskqukg9/USpHNTc0NDtTh2Ai6S4OyDtzJ2cyYXssnE6J?=
 =?iso-8859-1?Q?74eeWwbNca4ttWKVMhBrvqa0HvDf2WsnPdPGRBfwXg1VyPaPgOKSPgEAMd?=
 =?iso-8859-1?Q?l5RAZ5mZZiqNQVmPQcN8A70frw5gd0a0ubpCaV32aZ53Wwni8fxminkODt?=
 =?iso-8859-1?Q?8DeFQGQm1qLoGKLNsH6n1a2d0ilUp/nf/QDP9cVFdiV8Q/tIYhZzSqEaKM?=
 =?iso-8859-1?Q?t4hV7kRuPnKzSI1f6rVoMnG5Ek7XP7BjusUezbbkiQrFWvxsX0Gu8mxV4u?=
 =?iso-8859-1?Q?Knz3RspMdbmbs+AK/JZWqqXQ+KQotac3yEBdJe14MSEtBzzwZg5tH/Q5Zg?=
 =?iso-8859-1?Q?um5RYqEBnxHcIddT+RTcb256Dr0uhN+qvtgwYsoLzneQ0Cdt7jru7J64Fz?=
 =?iso-8859-1?Q?BDyk/9cBdgLR+sZ76E+wt1WTM3sgtlIC1GZ/4FnlASPWKfJacycgUCSryU?=
 =?iso-8859-1?Q?Pa8TwXr1RDDkXZ0NU3w6lsaXuUKkC4yDu5XHr5lq6L9L1NS5y6cSVi16ZH?=
 =?iso-8859-1?Q?iIQrzGwlBLCU4ZYRwH3+YjbItOL/Vyql5iFj2cTZqLSPR8/Hyp0dUegm3g?=
 =?iso-8859-1?Q?DfV4+PhYHrkwrYpburVKCYyJqRvinl3MoMrpwraPq/avdp6Y0iCNRIuQ1s?=
 =?iso-8859-1?Q?jYuGpgqoZo6hzJxLOzALRTTFtaxB/Gn3X80x+JuU+l9Ra2w9bQQOugtGf+?=
 =?iso-8859-1?Q?8oWo6mL9I6fVwPqzpICEL8CXj/NGQgKEHNNdjWuGeVeSxW5u7Gy3ARRBM0?=
 =?iso-8859-1?Q?5PcWH5CkAWHRzamnmlO/q3iHcwUDx+lOKhK01EoYnqxSUOwcGsMSp/VKHJ?=
 =?iso-8859-1?Q?+cTrIeYxtU+kbYI6B6k/i1m7CfdR/jwgv8F7tiMIo9G0GrfJzzFIldIaAx?=
 =?iso-8859-1?Q?nkNY5rM0yG93Gi2GzhAkkFLYaEMSaM50MiMpYnAbkkwnADQiVQ70UwTKKm?=
 =?iso-8859-1?Q?Cfhd3ZenmxvrSBGCWRLwTNlBv3IwQ5lWlgpTeGqmmXj1Zx7e9HXOPPZIpu?=
 =?iso-8859-1?Q?9m3UwtfbjDUHW+84kUdgOYgqrefjHFkAQ0a/AiWBIzknuFXOP17j1XyRGv?=
 =?iso-8859-1?Q?t+SOifrI8W6Z72yJvB5K+unDnd7XyVgJzBrU8KE5eQ05coG8Je1lu1LxED?=
 =?iso-8859-1?Q?8Yj23dSXds+NJxk/E41hnKhkPuJRh7qTwZFsdEF4Xv0zU63MslANpTbMAQ?=
 =?iso-8859-1?Q?3SHtNijKmyQuHfKODvsxPPsBenkU4ryt5ebDtATXAvctiMnuLD8+2l2BFk?=
 =?iso-8859-1?Q?ZSl2y1yoelyygX9M8YBagLpYzweicgE=3D?=
X-OriginatorOrg: navimatix.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c27d6a-0d54-470e-7b04-08dea7373762
X-MS-Exchange-CrossTenant-AuthSource: GV2PR01MB11835.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 04:07:53.0113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c87b4f54-b992-4813-8f3f-4a876324197f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuUFIYeUKxJ1t6xzP0uE9Xz5xY2hK3co5PQum5bsb3x0TAc9A9ZXBX6y+ioLLJhEe3TmoTlkwo9l5Wt33UKoo/K34chHPk+cAYouVwcDEgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR01MB11080
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 01 May 2026 04:08:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3895

--glnz7pa7xspyyxfd
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

Is there a chance to get this merged?

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

--glnz7pa7xspyyxfd
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
ATAcBgkqhkiG9w0BCQUxDxcNMjYwNTAxMDQwNzQ5WjAvBgkqhkiG9w0BCQQxIgQgBTvIEXui
dnzXGJq/0B7LfriSarzDSBOQIOL7jir9mOIwNQYJKoZIhvcNAQkPMSgwJjALBglghkgBZQME
ASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBAQUABIIBAFEHLri1wQcE
LGzu8jUaeKtRobem8YamJDDLW1eIw3cPs7jJ5/KFujyninU9u1q2G6i775Q+t7RvIKumrI3j
3Sc8mj9nCP0BupRFq6QGhotCc7pbqU0TWsDVY7He+l9uPrdtTqtfwh5l4Il/DqTEmnKYBfcc
rgPzTBsI+HSWQwKOlbigFKZ7sCHfzv4QuL/gf+ocBCO9gVjKSycpWGDY0h775fFZ1x3mobWQ
G9vm+hFnBdxNvBx+LvUgIc3sRoyU/1fcRxhKvWoV177KilY6HOm1S/6FNFnmaPygAsS6sFwa
qwRObSYX8xcTACUBU+DEif+ZvyJH/sYtNID800ejWH8=

--glnz7pa7xspyyxfd--

