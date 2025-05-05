Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3C4C3ABAA
	for <webhook@archiver.kernel.org>; Mon,  5 May 2025 14:33:58 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.61])
 by mx.groups.io with SMTP id smtpd.web10.51601.1746455634109810384
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 May 2025 07:33:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KAp/JRXs;
 spf=pass (domain: siemens.com, ip: 40.107.22.61, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tV2gkIb+44tG+kOakhzvRVu8QwaLm2S7N1cU7+g9p+AVftNNXzFlm1U5qTK9YFGl5bAsh+NP8gEm/4Tm8Av/mSMhBN7r8ivxGCuupTxLA1VPBzqtRiZaZSBSlZFIAPzvF+x531xTjsXogDvKa2L+rSFEcVteyN1Y1ypGC1Vyg3VVp4733j7RbNz25IUFCdKX500CBprpOcFvFG3cUBKuBHHXyTVKlG/OATglrp92Of/5BHxo3Fo7nNmCc/XdSCh5BwTBM9O5FpDAX7xKntQ/2fn9mJjS7Sod/d66sOPH7ebG49a4vnlSeEgTRsbFBIVDJc7iLMrof1rWBA1Tjn3fJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXLs70fId+rc1dpGrD+IB9MRCiDfJ04ka1n1tLIafs0=;
 b=r8O/Y+5/Yi1ndfSS4gUdu/SJmH7qgPVfYf4/4xHMAgVCbtKj/Q6PRiDfMVGOZqVMlxaNRsoHy9rhG2mWt0muKUST4ChrPJYLd51kHPX4/kzGDjXMICuIU24RfyBX9jda5fuYyOz7QDzc4ZM6Ug2FVplMZ1keoLPSOeATPT+yn7ul7pj7pJhxdf3I5Rgrpsjc7z361iaHV7BSfXcSbmgwL7j7PyNImbNQW4Kr9aTwWtC4zM7YDQdI4fbCb/ZL1SjY1XwoIBq6ZQN+etu4oA4WTQlK2gr/OKrXyjmNjId21KXzLe1T5Q9tHGIz83tdnL7wkRaNveVIO8s5Nb0HhUeqMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXLs70fId+rc1dpGrD+IB9MRCiDfJ04ka1n1tLIafs0=;
 b=KAp/JRXsH+L/3kh+n0hUNACV6mTtS4u+Ud0fUkp2L2hzBo97M7r/hZ81Yxqo5VYS/nqmaCHPZatNVi79Bp6tIsXGhu0wMqJdxoGIo1tELMSkqxFLNvglwUqM0bzHpuJ4W8tKQMNio2EywsFHfnaBtkH0T80py1O9KcR52wsY92JevObAI2lO2XYjGFUQuvFI0+A4u2OJ2M/P1wL91IW/W3mffP9I1rNHfEO0iuiTAyjTd+MQ+hoKtq1NDzmKiFKJmN/JSYfl2mGkVPGpXl1+kNTvOb96PJX9fJOI6lQp29jGyUXpncSt+II6CsfrXBQij6DJqtby/W0DzMQwXShorw==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by GV2PR10MB7078.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 14:33:48 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2%4]) with mapi id 15.20.8699.019; Mon, 5 May 2025
 14:33:48 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: Scott Murray <scott.murray@konsulko.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 19/38]
 cargo: pass PACKAGECONFIG_CONFARGS to cargo build
Thread-Topic: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 19/38]
 cargo: pass PACKAGECONFIG_CONFARGS to cargo build
Thread-Index: AQHbutl9++bmKa+kcky/wvWumDo4kbPCr2kQgAFpIgCAAACLsA==
Date: Mon, 5 May 2025 14:33:48 +0000
Message-ID: 
 <AS1PR10MB5697F1856764460365441738FD8E2@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1746130391.git.scott.murray@konsulko.com>
 <e5d4f65414368beed7b69e2c94482075aa2a0d81.1746130391.git.scott.murray@konsulko.com>
 <AS1PR10MB569727FD0B9979F109D1CD53FD8F2@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
 <a6380ec1-ff7a-68b6-25b7-021467d77acb@konsulko.com>
In-Reply-To: <a6380ec1-ff7a-68b6-25b7-021467d77acb@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=595f71f5-b261-43e8-8618-eef1bd6583ca;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-05-05T14:10:02Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|GV2PR10MB7078:EE_
x-ms-office365-filtering-correlation-id: b7b162c8-73d5-4aec-9482-08dd8be1d967
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|4022899009|376014|1800799024|38070700018|13003099007;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Msie2EMHmAcj9J/HstQ9TeiXXvPMciig3rp9RmDBTLVqvBlIhltQLfSEOqhf?=
 =?us-ascii?Q?bOxyq9XjYKoXvVJnRd0s4D02xGjPsDbxvZYZ0ouKhq5Iu9JTTji2JySOedKd?=
 =?us-ascii?Q?Zcj8hMh3uoSbjSPKJkyM81c5ES7vJV6bRf717ZKp08caY7tMJF8y5j+WVKcW?=
 =?us-ascii?Q?jaP84p6Q9uUObUxVH/HRIOr7eeisj3yDtFvuVIrzvKOvlHErp1cZScFOnF/w?=
 =?us-ascii?Q?2kVP/qhmDn+m9D8c3pMkB8l+u34kb+sk1c2N8RRSWlyf1NMsr9IcXKHdeqTe?=
 =?us-ascii?Q?PPUotiy6X/Lf6oe2zjRTp75E1Cv+d3kS+JDsXE/ddUC5pcqSNGfQ6Z4GR7wn?=
 =?us-ascii?Q?6hH0GjKA6jwfG/RPMCARI+hUz4nbHv9da1hvGyxhxbc4rkl2cDs4mw9/OnNy?=
 =?us-ascii?Q?4WIl1tekPUAXcGsqhZz2y+Xhcu4IebXwaMTHFvDUhw0Zt5wIdmx2TktjwMEL?=
 =?us-ascii?Q?6jxw61GconVN/JgUEowtd7h241Qup0+8kQVbTLtD6OKsXPoF0EyVH9RwkqJd?=
 =?us-ascii?Q?+Cg/fs8/cBOzC2BcVqJN6j7L66DnQdDo4WtDhtvU95i2z+nqWSzLOfQ49dmI?=
 =?us-ascii?Q?BYI9x5VdZrHVMXMX4lgFdKuHH1xbHkRkE6+GjP6RxqNH8jjH3natLvA6urc9?=
 =?us-ascii?Q?wLulpBQ6SZ8zX8uqSFeaeYVSSfqw2EojcTY4kdYiTAq3yQ8lgXdjTbrk2gTF?=
 =?us-ascii?Q?C7e9k/zZgfnMjaovHs89CQhoXzP+cCL3rzCCOPs1RlJxToTJ313uPoH7TMyR?=
 =?us-ascii?Q?STeYBe0z2QYqBV+saw1tl+aS4LKReswEfav/E+LvlmBCdsOTv7QqmXCc9GZH?=
 =?us-ascii?Q?MEa4G3BLeVpjeI3UqU8BmJSODULsuu6oXAbHN/4XlifwC2sxjMRf/yrAhyKS?=
 =?us-ascii?Q?A+JCYkV53bwm0jhszmuHbn1kkNzkTKPExs8obcvfRGrhnQYFNT4izKJJXFFA?=
 =?us-ascii?Q?khkLIOk64Oz0m/1WaXi74hmCl6kaeNgpGjwi5uPEmXCHwTkEygcQruPq3gzw?=
 =?us-ascii?Q?PKTfpFqVu2GJqZZnRrsDTSVRoJOxHvT4HqTdxdxaqHZgS4YLnMXbpPV1+4L9?=
 =?us-ascii?Q?61thQizcoM3Ik0O1quMQQI368mVzRt4ACzJuf3Kiw1YXLY0qxX3bD6pCJZIU?=
 =?us-ascii?Q?cmSaCxi8Kpu2rW9CubnKYczdWlKLAZie55gY68zITxsL/E6zZiTSVaxry9HW?=
 =?us-ascii?Q?LrrQ9oBJcbIIAgOOuJx/T40KQN1erVNztzzN6nuYOORNGPVph3PdW0RnBT7d?=
 =?us-ascii?Q?VnpHD2pfnyumBBdguOKmjA90CL58h7QFVWinzhhA/ddZqFUkGw/QOTC/dR4h?=
 =?us-ascii?Q?Eu7mEQJJkB6MTlrHYraHo8atsvEjquBa68UZUi5yxxYO3norUIQb7pjRkZMP?=
 =?us-ascii?Q?l0QEHgAC2aoZPvgMtwC7ownOUfCasKPsWN3G0WW98kHRgBCTvNVT9I0EaquR?=
 =?us-ascii?Q?xDvNqelbeho=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(4022899009)(376014)(1800799024)(38070700018)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?yv26MVlPWE1e/lxJfDvNHtxyGMDAZrHAkNhRcpj2/r3kokdZhRUGL0AMoaTg?=
 =?us-ascii?Q?cbe2YPZo7Aae74aIq72gEBMBSMAzJ/quzmjm9p9ROkJbLt+4CfsCdkOY+8cz?=
 =?us-ascii?Q?x/gyU+v8XglSSXYIYvhvh0HwRP8qHpMezknRC/pEKu12DqA5wXHH1YRj7yy/?=
 =?us-ascii?Q?VMTV89eVVd49D5B44ZQYUCUPrwPCVmEDSTxbk0GNOkLuZjkzcpSNMoCcg5H1?=
 =?us-ascii?Q?k9Tihna0hKj5aZ23nu8eDdZdAkUnKFXW155taZFXXagMboH1nSPfIDt+WD97?=
 =?us-ascii?Q?piQtk79QY8G7DYr//FcEgKGBtGobvE0JSsaJqHW1UL71tcxqrugCXAdvmxmV?=
 =?us-ascii?Q?adES54ZfHcxXRu8VMA2FSMqSh8nMaTdWt4axv953useuqp4vLHgf5r2t73aW?=
 =?us-ascii?Q?cYmo8xg+i6J9pSJFD/e1A3gjT7LSS18kAjKTANofo5sur65sQhfliF6qchMN?=
 =?us-ascii?Q?CFWV5l1+18qEUokN1jjQ+/1jrEBG0RY+S6yGDg9/dmAVc21WOe71fDBcGwhY?=
 =?us-ascii?Q?tdDkS2bYQ2RKFcOhNqGmWVA968gPP2mTe2pZVfSYYGtSvL6k+2cWaM7wt3cR?=
 =?us-ascii?Q?hkRTqDFcLUIMy1bZ7Z5CcXed8FmhBvPC1wRu1TnBQJ5cGfzYpLlRnTU/at1j?=
 =?us-ascii?Q?6Lvp68K5vMp3mFwfJYOImnrwThFhxZ/Mh8gTTsygjlVLnLYLHUnYrntpUMFq?=
 =?us-ascii?Q?2kBWlwSuwSERegsogvwf3vS9dvI0EcQZ/aKoM5gTcj9WWyVbciMoePU0mRo0?=
 =?us-ascii?Q?oWDn+A9fmcVGZzH6a5pvKPlfXzybHhLJIwTOzu60GnU7DtT53feB/qTbTES5?=
 =?us-ascii?Q?1gZUrdZq1Eq0iXEA2B8rJH4v/D1iBApBlxv2KxGAph9tE/zZsLzOgn3l97qX?=
 =?us-ascii?Q?BrjY5Tr7t7JkVBsOaUHhroroeGWzK1dsEDwLlolrPTNwZRR+w4Kb2kCOrgLD?=
 =?us-ascii?Q?buxJEA9Z16aZQUmZMbh0CV4dJQp8FBrROqjXUrjRFzxDJf0e7nqNVOBLIbt3?=
 =?us-ascii?Q?xtdj1SoNSSjLCa4nop6Ks6NlCaz7OnujKm2/pVjE0KA9EIxS1I0nSOTyFpd8?=
 =?us-ascii?Q?zUYojfRkSDCJZ1+Yu7YM6KqpgTHbfGOW1HTlR876o68d3H0dRSlT20tTBxsi?=
 =?us-ascii?Q?NgfyNOi+VXiV/kTTLiX5EFkdCxxpIaDpr/OLVPUQgmjxxApkin34GB/NPLo1?=
 =?us-ascii?Q?BzUGm0fh0qEuIzG3p26SH7ok2a7BQH5VC/PM4ueHJWdSiN8TgGtQJSzSb5RT?=
 =?us-ascii?Q?mp9nU8BNMEkBDjdz+L+B+foaEnYAT0zTTgvjZgFlzm8WLKaGA8E8n19IU4Rs?=
 =?us-ascii?Q?S3Nk1FfGpvG1thSBE58w3AOhspN4uSDa4z82DcoFqpzIaYx1yEsVjDIkgkqL?=
 =?us-ascii?Q?uqriyw3yg5lfmQEjNaBS/dTJoBxKspUpw8DPni2VYrhuKsPzDgKlZX7WXYEH?=
 =?us-ascii?Q?aW9n4TUsiawF1fGEU05i00XE6qoDvxsT7VASWJV9lS26yd3l6o8kMB7UPqjT?=
 =?us-ascii?Q?9+9/Md3bNa8EnD3d0aY4tYblZG6Rk3wHHNa/f/HRQ4aZbVArPzsKZwrmOx5r?=
 =?us-ascii?Q?8CP3n6fRyHONmqdpiSOx9HbPvNggu+Ute58pB4Hx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b162c8-73d5-4aec-9482-08dd8be1d967
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 14:33:48.7787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zIbPgKj8mzN/PzzprGOZOfhrCsUn2g1GqWMTCyEyErMD6GwohwE/mjUq7Kes/emOAvVYOhPb3k/qicgt/uy72A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7078
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 14:33:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1512


> -----Original Message-----
> From: Scott Murray <scott.murray@konsulko.com>
> Sent: Monday, May 5, 2025 16:08
> To: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Cc: yocto-patches@lists.yoctoproject.org
> Subject: RE: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 19/3=
8] cargo:
> pass PACKAGECONFIG_CONFARGS to cargo build
>=20
> On Sun, 4 May 2025, Marko, Peter wrote:
>=20
> > This commit creates discrepancy between cargo.bbclass (from mixins) and
> ptest-cargo.bbclass (from oe-core)
> > It needs https://git.openembedded.org/openembedded-
> core/commit/?id=3D98d03d31de4010534b1a00d29409d3486a0ab0b9
> > Same is true for scarthgap/rust (which triggered me to send that patch =
when
> testing last scarthgap/rust update).
> > We probably need to copy ptest-cargo.bbclass into mixins to apply that =
change.
> >
> > Peter
>=20
> Thank you for mentioning this, it pointed out a lacking in my backporting
> scripting that resulted in it missing ptest-cargo.bbclass changes.  I'll
> try to get things fixed up in the next day or two.  Do you happen to know
> if python3-bcrypt on scarthgap branch would serve as a reasonable test of
> the class?  It's the only non-selftest user in oe-core that I see on firs=
t
> glance.
>=20
> Thanks,
>=20
> Scott

python3-bcrypt is not a good candidate for testing my patch because it does=
 not use PACKAGECONFIG but it also does not seem to use ptest-cargo.bbclass=
.
Grepping ptest-cargo in oe-core and meta-oe yielded single hit - hello-rs, =
which also does not use PACKAGECONFIG.
And I have seen patch for rpm-sequoia to use ptest-cargo, but again, not PA=
CKAGECONFIG there.
So it seems that it's a feature only for custom layers right now until rust=
/cargo recipes emerge.

Peter

>=20
>=20
> > > -----Original Message-----
> > > From: yocto-patches@lists.yoctoproject.org <yocto-
> > > patches@lists.yoctoproject.org> On Behalf Of Scott Murray via
> > > lists.yoctoproject.org
> > > Sent: Thursday, May 1, 2025 22:40
> > > To: yocto-patches@lists.yoctoproject.org
> > > Subject: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 19/3=
8] cargo:
> > > pass PACKAGECONFIG_CONFARGS to cargo build
> > >
> > > From: Jean-Pierre Geslin <jarsoper@gmail.com>
> > >
> > > In order to allow rust packages to define PACKAGECONFIG options, appe=
nd
> > > the contents of PACKAGECONFIG_CONFARGS to the build command.
> > > This patch was already submitted by Bartosz Golaszewski on older
> > > version but was never merged. It will be really usefull for Rust reci=
pes.
> > >
> > > Signed-off-by: Jean-Pierre Geslin <jarsoper@gmail.com>
> > > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > > (adapted from oe-core commit
> 16745b20452de60ae2474433cc1a2fb1ed9f6a64)
> > > Signed-off-by: Scott Murray <scott.murray@konsulko.com>
> > > ---
> > >  classes/cargo.bbclass | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/classes/cargo.bbclass b/classes/cargo.bbclass
> > > index 76a3966..461d100 100644
> > > --- a/classes/cargo.bbclass
> > > +++ b/classes/cargo.bbclass
> > > @@ -48,7 +48,7 @@ oe_cargo_build () {
> > >  	bbnote "Using rust targets from ${RUST_TARGET_PATH}"
> > >  	bbnote "cargo =3D $(which ${CARGO})"
> > >  	bbnote "${CARGO} build ${CARGO_BUILD_FLAGS} $@"
> > > -	"${CARGO}" build ${CARGO_BUILD_FLAGS} "$@"
> > > +	"${CARGO}" build ${CARGO_BUILD_FLAGS}
> > > ${PACKAGECONFIG_CONFARGS} "$@"
> > >  }
> > >
> > >  do_compile[progress] =3D "outof:\s+(\d+)/(\d+)"
> > > --
> > > 2.49.0
> > >
> > >
> > >
> > > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > > Links: You receive all messages sent to this group.
> > > View/Reply Online (#1446): https://lists.yoctoproject.org/g/yocto-
> > > patches/message/1446
> > > Mute This Topic: https://lists.yoctoproject.org/mt/112569359/4454441
> > > Group Owner: yocto-patches+owner@lists.yoctoproject.org
> > > Unsubscribe: https://lists.yoctoproject.org/g/yocto-
> > > patches/leave/13703729/4454441/683413657/xyzzy
> [peter.marko@siemens.com]
> > > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > >
> >

