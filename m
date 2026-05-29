Return-Path: <joerg.sommer@navimatix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44303CD6E49
	for <webhook@archiver.kernel.org>; Fri, 29 May 2026 08:19:02 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5634.1780042740006427199
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 29 May 2026 01:19:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@navimatix.de header.s=selector1 header.b=pkxKNTBq;
 spf=pass (domain: navimatix.de, ip: 52.101.84.135, mailfrom: joerg.sommer@navimatix.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFiizTu70WtlUErFXhSh9WwE8s8uRFhhWIgP3gL2yccO8qjk6WTGwPITl5cCPUr91jHrVO7E6FoMqzzvvGU1xrf3WYWaVv9aFGmzcMGrAfy0yqeLAtpSCOqOHu+er0L4o3PrOefObgSqqKVubFSWAYIi3dPcz9WEv2iNtrcEwG/hz/tV1CCTmtgY3NlgbE2Skq9IvwvHjKf6FTFznFBBQtpm8Gxr5abgmdqtpN0PO3Db4z+WpxadokhdrygwyNiQWI4osDu/uM7740/iWG1Uw11tmNlRrlnARMwdw0qkRXoTfOqQwVNsRgIpd1/5H7STrk0ErLF1XNe4oisutD6qqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rGuKe/WMc8ptcnsyS1Nl4LbIOJUiaLfuUsewslvgFE=;
 b=hlmIemBjBSb+Xtlkf148tyD3dJB9/Pf3MwU8B6AaCa3Lerl3kWeDEzNyjuG/LOZQ4QxIculcBB3x/yOsLK9pqAzGoMaKVmAjAYt68cSkgY2SAVqvDyo0G4pmKwbk7Q17iJxPqHUBnieSwsJaZKb6pAUV/ywuyRBCv2rcxQsodvvVVXCYZX9Obt5ztj5YpuUEA0n8Yrit9C6sp58zHdOENsA36ydJjGhahzf4+JSEHvS30YiVGGnHMwCOGRMZPn/EFxYUPs2DwfhJReNOZUxUuJBUgwsLku/3/a7OTIU0G0VYtN3mvbvxC9NzMIJj0dfa2KzM2+tSXEzKXRxWeSsrbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=navimatix.de; dmarc=pass action=none header.from=navimatix.de;
 dkim=pass header.d=navimatix.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navimatix.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rGuKe/WMc8ptcnsyS1Nl4LbIOJUiaLfuUsewslvgFE=;
 b=pkxKNTBqrsf19vNW98zlilFVLptT5Ynso846CXzJFOUEKcEO6AusG+31+9gg2X0fCQOurRFXLA96WfPflEsbsTvVlz0NNReuhisu5JEk009rfxqYxjPInbyuOn7P+wox1Ya0FrWNM3BXB3/CTOivv7ArKZQR8NHX7pkhbn9sJ+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=navimatix.de;
Received: from GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:2cb::8) by VI0PR01MB12453.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:316::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 08:18:55 +0000
Received: from GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 ([fe80::d5c3:2dea:3d98:25fd]) by
 GV2PR01MB11835.eurprd01.prod.exchangelabs.com ([fe80::d5c3:2dea:3d98:25fd%3])
 with mapi id 15.21.0071.011; Fri, 29 May 2026 08:18:54 +0000
Date: Fri, 29 May 2026 10:18:52 +0200
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Andrei Gherzan <andrei@gherzan.com>, 
	Khem Raj <khem.raj@oss.qualcomm.com>
Subject: Re: [yocto-patches] [meta-raspberrypi][PATCH v2] rpi-base: Use
 MACHINE_FEATURES_DEFAULTS instead of MACHINE_FEATURES
Message-ID: <ahlLlQHELW08YQfI@navimatix.de>
References: <18A5505E57DB46C1.657799@lists.yoctoproject.org>
 <18AB557E65BC6807.2030835@lists.yoctoproject.org>
Content-Type: multipart/signed; micalg=sha256;
	protocol="application/pkcs7-signature"; boundary="nsgrsqymus4w3j3n"
Content-Disposition: inline
In-Reply-To: <18AB557E65BC6807.2030835@lists.yoctoproject.org>
X-ClientProxiedBy: BE1P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::17) To GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:2cb::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR01MB11835:EE_|VI0PR01MB12453:EE_
X-MS-Office365-Filtering-Correlation-Id: acf0d894-c7bc-4a1f-2328-08debd5aec73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|4022899009|376014|366016|18002099003|13003099007|4143699003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	sdnMH0t3d+kmDvOwwoKCkVzy0pBlYitAk6jtobCB6C8XSdz+4EbHKd/h4vmArdPjcVxSqmx6AvAyLWVwuffTV3eBA70RHWR2EOtiC/ZylCSOyeXkRrQ9ZyhZ6bpDCvSwEOqqn8c3f65H/2gvVyv9zZ0S8PQw3GUc9q+2nK8gLYZhcDs/HJ0IuQsLdeUBPuEg4tLGE943BO+ECcwvXdQWgQCuEJkKO78vZRRlmlHF2xUVCgNnvMcH16MfyvcnWmM+GOBcXbeKER6x5OUo0RLay+/+6IPgeuabnLbj/4AROCN7d0gIcVOG/pOFFTJWTxma1OIqwo+quR3r0OVEAd1lrzw8kV+mLKP6+FBqkyJj0elJcGLSA/AVnWK4yI8rUF9LamlPeBTSWO3HiEAPnl987TtXkeyPeZ3Rnk9ullJR5gmJfZL/jM1E7GpckwF6g6kgtYZlESYbQ/RCGFSbzumXPyFmDEyGaFijyH0HIKBZk8eLeQBckkVUCCKkh31xII9pPc1/azf8Gi2lnMGfAJfzblSbHVmu+jHbeKjWOu5hRO3EvO8+GptGIFzfghRZTytyyFTaT8MRuCD+LtTlECog3OzGIu5EI7oZ8EUMueuhxCiMLw/grmzAGVQ8spteO3lVKEhAEvROTWXxYjw3TlJfPg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR01MB11835.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(4022899009)(376014)(366016)(18002099003)(13003099007)(4143699003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?iso-8859-1?Q?ZGQVJqsbjU7DrcSIt1zqLj+SuFQGvamfzzsgFHGu4X21B0f5rspfmz786E?=
 =?iso-8859-1?Q?W8kLaeM1GLz49clmv3sIjd0cJQ3Q9rVEYzdZf1DV3S4+cwaoJ7ExT4aj1O?=
 =?iso-8859-1?Q?KuY0aHVCdLMOvGFxj4bkQbLvkxxJM6OoTk1ALy0Dt8kUCd0s3zL1opZdvI?=
 =?iso-8859-1?Q?xe0Cq6VftdfRpkmYGy5ipnLdH7DVte2k15poX0pVTzYv2sEVgnBxJwHoFH?=
 =?iso-8859-1?Q?bveAeDnlGhJtBOYwrCFDvW257/8Gq2Eb3osOrHpb2kGFWCFbfZLNaK2kwL?=
 =?iso-8859-1?Q?6wdCwCRkiFfkiU1PNZXIz4OLUAuzapnsUaknIn3WQtOFqAsC4HRV56bQIM?=
 =?iso-8859-1?Q?DHbJ/jLLgCGoaAi5C/KwGjqsarmwo4JQ48cJAV0Mv5/0MJZ+dAq/uSczkz?=
 =?iso-8859-1?Q?sojiITKZGVczXXxgVVkuDKwAVpGuJUQEL2zwuQ170YhC9wg7wIYpTMao1c?=
 =?iso-8859-1?Q?mShcTF30jhXt37wwgX+kpA0NtcVF3LE0PWclUuW/Mszew3mDv+ENbjnkHU?=
 =?iso-8859-1?Q?tkrPEt+Yb5dtdkHmpjvwdVLWtGoCHKWogGX8Ey3P374mpxAKSa9SxYWLE8?=
 =?iso-8859-1?Q?J12xBHGOEJM96fMrctJnqRMTP/oD4oj38OJkWHy0dZhpR7oE9EIM3BTBGo?=
 =?iso-8859-1?Q?BO/FZnN8qHwOLsBPFuWDOGf/yqu8aM44StxiSGKz7130NKFpPCbUarHrOv?=
 =?iso-8859-1?Q?gd7cGLQjzWvPVPwAayFwFSZ+fbyT6fiqBYnsZIm2y0Xps0ap4q6FxcB3/R?=
 =?iso-8859-1?Q?UPXosABNcTeEvvgX9t+Wxd33qGflPgQIC0/AQBZzHmrR6UfmxCfqVJTmYW?=
 =?iso-8859-1?Q?vCfN6ZZwl7s/wgLG1Li/LYLEv6JP5AjvpwYebUcrTccX702Hf/NPlo0ap5?=
 =?iso-8859-1?Q?H2v2gllbXTUd3jclyjbZA7fn8mQUjaPkeUi3t7P9vztqsa9wx8C28ebD0b?=
 =?iso-8859-1?Q?IEvYRq46wqvZRpDBsV+C2EzUXti6jqkYaNtc2Z6fEQ8VfImFdBZeipOUr7?=
 =?iso-8859-1?Q?+XX682XkaNwT3eOUZNjlfGCoedWcBxjKNsAkjkiMlU2pRJTzxxqwhHWseM?=
 =?iso-8859-1?Q?EoUaraUWXNhoHBTMG/nOdKFehRagpAPBMygFBXqNq9dG2ApuRVC1YEErJJ?=
 =?iso-8859-1?Q?5S6RmFIgMzvWez6ZmUTMN6rYIZBJuXHrm+xWyeckN/nhnyIBvqbPBzgwPl?=
 =?iso-8859-1?Q?lafIOy7FJ3Ti93mi00BpkgGjgJkLwq/H3FxTcuIg0bLuh9UsBvpiuNJudk?=
 =?iso-8859-1?Q?qVZMfTJCBO5/CKECVWDEu+dNUbWR6BJ0wZ5tuqqCMNyxahs5pCGfs4KlxO?=
 =?iso-8859-1?Q?iQPfh4F8V8jdaPCmQ0LdWhylzSKmQ2zOD2MWN+jUwifL6leJyRpvwfoiEN?=
 =?iso-8859-1?Q?WoKddS5jWWh828jDSiYyC0U1k8EAG9QQUeakZekkklypCPfP0i2D/oyCoM?=
 =?iso-8859-1?Q?vZ1GxlGMDjom6yr77OujYxcNEdiegQxEEHkwc+QDp8uWVJIlUYtc78Xj7O?=
 =?iso-8859-1?Q?mdRc38h5KEwfpEztxdCylM5FI+zjP2kQ6yWf4hzgmWeV2pIPFWu0LqjnHW?=
 =?iso-8859-1?Q?2Uw7FvVQnyl9dQFlyfGxVGy9Ex1+i3q4Zt8prTnnBEnSNh5SvBhS8TGC4n?=
 =?iso-8859-1?Q?R0yWK11UsqYd8FoaoseTvRLrqBV0y0IbdjmBDxCJWoONPQwPN5Yq8i/msj?=
 =?iso-8859-1?Q?HMKkkYpL8HCc+4XZjmsnmIVRLh+1mN38L64gsgI+mR/Hi7uAltP+u0PS/9?=
 =?iso-8859-1?Q?Nd2P/9FonIQCY1McJoTx0nXutGTrqGo+61STzDjMx2wvObpTiGC91pFNqE?=
 =?iso-8859-1?Q?U9OmsllaAwrFEFizNKLbJIvCjKA+pdY=3D?=
X-OriginatorOrg: navimatix.de
X-MS-Exchange-CrossTenant-Network-Message-Id: acf0d894-c7bc-4a1f-2328-08debd5aec73
X-MS-Exchange-CrossTenant-AuthSource: GV2PR01MB11835.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 08:18:54.7116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c87b4f54-b992-4813-8f3f-4a876324197f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9GwIRhIi11Gx/SubgJ6mlc2X1DXu8f1epda98fHSJfXbeqcMgn3oAsyc7o4GYWQT0uQEnVtVu/hH+sqF/p41J3K7/EA2W2TBO52l2l70sA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR01MB12453
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 29 May 2026 08:19:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4085

--nsgrsqymus4w3j3n
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [yocto-patches] [meta-raspberrypi][PATCH v2] rpi-base: Use
 MACHINE_FEATURES_DEFAULTS instead of MACHINE_FEATURES
MIME-Version: 1.0

J=F6rg Sommer via lists.yoctoproject.org schrieb am Fr 01. Mai, 06:07 (+020=
0):
> J=F6rg Sommer via lists.yoctoproject.org schrieb am Sa 11. Apr, 15:26 (+0=
200):
> > From: J=F6rg Sommer <joerg.sommer@navimatix.de>
> >=20
> > This allows the users to opt out from some features like wifi or alsa, =
if
> > they don't use it.
>=20
> Is there a chance to get this merged?

gentle ping

> > Signed-off-by: J=F6rg Sommer <joerg.sommer@navimatix.de>
> > ---
> >  conf/machine/include/rpi-base.inc | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/conf/machine/include/rpi-base.inc b/conf/machine/include/r=
pi-base.inc
> > index db0bbcc..7a38ab8 100644
> > --- a/conf/machine/include/rpi-base.inc
> > +++ b/conf/machine/include/rpi-base.inc
> > @@ -126,7 +126,7 @@ KERNEL_IMAGETYPE_DIRECT ??=3D "zImage"
> >  KERNEL_IMAGETYPE ?=3D "${@bb.utils.contains('RPI_USE_U_BOOT', '1', \
> >          '${KERNEL_IMAGETYPE_UBOOT}', '${KERNEL_IMAGETYPE_DIRECT}', d)}"
> > =20
> > -MACHINE_FEATURES +=3D "apm usbhost keyboard vfat ext2 screen touchscre=
en alsa bluetooth wifi sdio ${@bb.utils.contains('DISABLE_VC4GRAPHICS', '1'=
, '', 'vc4graphics', d)}"
> > +MACHINE_FEATURES_DEFAULTS:append =3D " apm usbhost keyboard vfat ext2 =
screen touchscreen alsa bluetooth wifi sdio ${@bb.utils.contains('DISABLE_V=
C4GRAPHICS', '1', '', 'vc4graphics', d)}"
> > =20
> >  # Raspberry Pi has no hardware clock
> >  MACHINE_FEATURES_OPTED_OUT:append =3D " rtc"
> > --=20
> > 2.53.0
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> --=20
> Navimatix GmbH           T: 03641 - 327 99 0
> Tatzendpromenade 2       F: 03641 - 526 306
> 07745 Jena               www.navimatix.de
>=20
> Gesch=E4ftsf=FChrer: Steffen Sp=E4the, Jan Rommeley
> Registergericht: Amtsgericht Jena, HRB 501480
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3895): https://lists.yoctoproject.org/g/yocto-patches=
/message/3895
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

--nsgrsqymus4w3j3n
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
ATAcBgkqhkiG9w0BCQUxDxcNMjYwNTI5MDgxODUxWjAvBgkqhkiG9w0BCQQxIgQgvgD0tgFt
5W12o32sn3nmyI6oTLF7++diTBXxNfsaQbowNQYJKoZIhvcNAQkPMSgwJjALBglghkgBZQME
ASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBAQUABIIBALege50cr1Oy
eBGriVGWJaHTYKCCl+kVq8AoCsF+zahPU2BJKRBBwD3b6VtxQkcbG+huy+XjdFtdUbebjVhb
bCP7UGGhISVjDM7JrPf32GgZA+frKemw2RLE+NKsV4sEPQg/zVz9YexDNS7Fs23v8yq1M8hk
ESVxHlyDgi38KhcC+y42e6ptMm68Tvx6JT5tnLKPR45WQstW3Wp56n2XMi6+iobY26VdBSJV
ed3uIAcYnSmDW+tSnWB4jH/z9rsUCoAwu8la9m+pqj03k7qfnC1PQCHO8uceXeG2OtXF19m1
eJjw4lQVTtuq6Q8NDxVLF2A2MjDHxZjquUwLW7ioBf0=

--nsgrsqymus4w3j3n--

