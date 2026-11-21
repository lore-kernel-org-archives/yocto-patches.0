Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14465.1795258031775023575
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 21 Nov 2026 02:47:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QE6xxl+J;
 spf=pass (domain: siemens.com, ip: 40.107.162.12, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egWHH53E8Y69CE5TTPoZiDkGtbDjImOj+N/m+c2G/uZ1zpTKHqnrgRmVi0OhZ5JEY+TgXVGUJOUvkYHV6oRAgcYqeuHLQJ9TEshMKr82cqExkOrlznYn5vmTy81eB5IznqYxL3iM23A9vcyFb4sSQzBf5ylbfFLqUN6ht/Q7KPvT3ReAy9bOzuSs7SRzQ2aTbiwC6L1Dgy6idrqi7gH0l1hVkW7k7Xh/hc6DXo2KvxHvWGMnjL0ybzj8770/UMjklIBOvT0n+6INqu0PewUZ6nKicfizDjxupewHX2Yj6+sRbB5rU6BzDZWsVBZBzLRIDPgyx2yBLZ8YUTdW99vZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7axtm0gwwRqJQIXKSP+W86MAGAbJayRpxFgSlqHDDKk=;
 b=dvNmoK1J324W21XIr/UOcVZwAO5D4coNQJVaY6Bi0zlxH8HKnIJaFCpA+NAOnVfyGWeKkkKSYno7gxQyAmVmUXZu4a1jxIEd704zj9FM6WcL/Ji/cHlIx+9TYWASteElpMdXjrGuU6CCh9Y23ELpEXt5wDaLqJV+B+PaSUlj2gd0mPSNBmDa1L3XQzhhXdF9RlhF2MwqxgFiLdG3hDyEholbMdEtkRDN8fIttDXSJ+GIXl070BGgVv8kZp1Qa+g9/yy69vpnzY+MKYasqosbpE7OziGdwroamuongY9bx/HKuFv69J0xd8Y+3yXKGyGqSIYWFlYhoLmzBcYvCSpo7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7axtm0gwwRqJQIXKSP+W86MAGAbJayRpxFgSlqHDDKk=;
 b=QE6xxl+J+lBs0tZdDXXftJ+xQqhEU1LPMHf9Auah1YX9Y6eHPC8z+oJFhInKvNxiVHh69kbiOVLU0RkrODmpn2BGhlr6k2tmRmW35Hpj+Fl0Vc+UYdjW9TcS9GUreRbOh1jd4ZH9SIAi8mqyvFkVJUWhFTUf6fzJh9bGdFvhKztEjL1Mt+RkOgt7TtGlxzzb65iMLBMrXzrmI8BvK16w9sBQGtELkdfgBGjRskvFAya95HMvNFYr6dcMv7el0WE5tvILXzVn27PkfXu64AKFvB5F/0XYNlQQHuOCOEFFipzTHwzN03UqMwtVegMwsk3e1SOdIvKxLd3A+Sx+3xQArQ==
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:420::16)
 by MI9PR10MB555951.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Sat, 21 Nov
 2026 10:47:07 +0000
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008]) by AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008%6]) with mapi id 15.21.0639.006; Sat, 21 Nov 2026
 10:47:07 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [meta-lts-mixins][wrynose/go][PATCH] go: upgrade 1.27.3 -> 1.27.4
Thread-Topic: [meta-lts-mixins][wrynose/go][PATCH] go: upgrade 1.27.3 ->
 1.27.4
Thread-Index: AQHddsK+2YjDL5jwIE6H4QIKcFxZVLc4XbJw
Date: Sat, 21 Nov 2026 10:47:07 +0000
Message-ID: <AS8PR10MB50737AEBF662569121CF0CB2FD472@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
References: <20261117183734.3671902-1-peter.marko@siemens.com>
In-Reply-To: <20261117183734.3671902-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=8f0f7ecd-ae30-4ae3-ae44-489aff73a46b;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-11-21T10:46:48Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB5073:EE_|MI9PR10MB555951:EE_
x-ms-office365-filtering-correlation-id: 977f54e3-a4e1-4107-9cff-08df47bcc9e2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261028144727099003|261021123027099003|261021121427099003|261102130727099003|38070700021|261102123227099003|11063799006|56012099006|10067099003|260925021311599003|260925022911599003|260925021911599003|12006099003|18002099003|22082099003|261009223027099003|55112099003|6133799003|29003799003|25016099003|3023799007;
x-microsoft-antispam-message-info: lW8ay6zBBSq3bKaJXhU02w3zkn24odQZFwnLIqniTr3agp2+3V+Ps87Z43NmGeZ6JoUyxicfEKYbV7/edBVDo7wbAfHaCWb/JJkAeF6/V4+tEgdf7Q7M+N9zuizBz+4oInKk21nOO9k2xbavWtlUMKiGNlLe/nVZaWhkjmylypxOo0GW/3Mjz6vbri+l2UWbN0H+Yc7O3q5NnHppb5uqYsH5/uzA/18xXbtFL39tdD42uTWkZ1ixt737q1sXEk61iWPs0BYd3w8TdWsTy7cFrU/NYMtgHEIMRZLYAMh03X77mUD2J0R0cezTqfkcqPAi9ARbJY5aeWSAij9p8czHfSn/t+t3F/W4q3FNXphIgdrBMEncQ/wYCBhri0VfJK65xCdWDuDEP9fG56q7EwgcX4Qx+17WEHzXGSa3edW07aLkg7gb1gt1LvdLlOgbeATjiLppqNxOy3w6Z0ZjlSwCdY2pERNOQUtMCAyZNZY9RFpokohokfpvV6jot8nkvsVsikzgGNcGeYB9gzcsZvWy40WCtJQ3wZK0WNR8l2fpRh3uvzvXZqfQVev/rlIr79it9Q7jyMigPCTRkw4vRYmlEQ7XbDDijaccU12nZZAGnyO0k6YYcZ1cGHIIjwVVngf4GkyHTqJB4FWu7xPbdS45T1hKylv/ELTz89SY18K6z4E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102130727099003)(38070700021)(261102123227099003)(11063799006)(56012099006)(10067099003)(260925021311599003)(260925022911599003)(260925021911599003)(12006099003)(18002099003)(22082099003)(261009223027099003)(55112099003)(6133799003)(29003799003)(25016099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qkmtKbDDFZ6UinqwDgLB4+jYo/jHsvnrgEHSrv+sFQIF6dZInWNLRvkaXcoR?=
 =?us-ascii?Q?OQ/gkNNWBptzR7pwFY0qvFCCVpoYPNhyzgibJ405Dam+6efiCEoeAUWeFy5k?=
 =?us-ascii?Q?zs7rKubtIqVPPC1plPCuL33ieu6vWzdErRgCuyj9ZTU9uASoU5RBqsOKTudj?=
 =?us-ascii?Q?CBTV5Qofiv40l9r7G50iEj2OxCbf0R+o7W619h7KH+ijytn1/A14z/xT77wR?=
 =?us-ascii?Q?w5ybNShcDll/CQcn/VAk3uD1zkJB9W24qN2q2npMnWhx5QQdQ6u7PmxQ4pGi?=
 =?us-ascii?Q?UwBwAq+HhIgEq29myT8ZMD1oCvdt6lVPKuG8UtMfgyz6k+D8mPB/+c+U0dgg?=
 =?us-ascii?Q?jYq9UAaXen5jUznUnmrME+ymjBex1h/nQUlaKZZMArlo2ST3X6orLbtcZuSV?=
 =?us-ascii?Q?U/H0POZrzZvOT4KcixIb1pQb11wyVnA0dJ/UpBcaNFfamFGVVmB9MnV+3alq?=
 =?us-ascii?Q?S5jPW0/vjL7tx81aYIS0FGH3yL+VtVDFiP08UdxwdhReOsKVvtRBDq4UlwoC?=
 =?us-ascii?Q?gujt121QsT4DHAE1XksYvWK6LjfNMk49pt+vnUB9+ka+/vfBUYVIRyKMZrfv?=
 =?us-ascii?Q?0CwUrNtnC85qzSoArMc1pJbCCs8n5uxDWbFA1ikMGcxiFWaeoiUlO1msTvTn?=
 =?us-ascii?Q?N1H047OFgr/wnSvrGXY8TtzoWI13YpsVzbNUI3eMAf7//awiwSRZq5xKK4YY?=
 =?us-ascii?Q?L67VkT2QV4egfNvBqolpAOOXI6FrPnBLVLiKCOh/XT/DwVJ/rQxgOPdoCh+d?=
 =?us-ascii?Q?HVIX7x4wb/vWAsL7CtRocodcFvnPRzA5v0H44yTjfnPoywudoU8P6SovJJpe?=
 =?us-ascii?Q?JYtCsWlBXebKbv7nrQz+StR/dWZ/3i9KAXdkP9Pd7PUAtXEvsgBQAtLLtATc?=
 =?us-ascii?Q?T1ETV8of7XyUMw8xEyD7Ji/44EBKOh9UIJxetOBxZDw5/sVxXd8HpJtV8YGJ?=
 =?us-ascii?Q?xYdmLbL+t3GXD4na537EYrtvEIO+ApNbzwprMujFkK98nnvnSSETPTQ+L4td?=
 =?us-ascii?Q?JmSVz1C1Sd6mkQ6RVPJOQ3caktNd+HFM+/AqpyGWCZc5zsYv7b5XReZFTile?=
 =?us-ascii?Q?MNaXDTqXAexPHMUa8BZYhAcZvubJjjHnmIFEOKV5OEIvv1jbUc7nALRLUGa2?=
 =?us-ascii?Q?c70nf3UA4kCVpc/EAOk0viFOHJ5FBingR8GatIdSVimJfXAjpLlQReAzdZJ4?=
 =?us-ascii?Q?gDpfpCXI4rP9sNoTVY/qiy93ykjiUTzmKOjwG81pNtS3qQmi/buN8bFTnLBt?=
 =?us-ascii?Q?xVyN1tYYUL6SE6c+Y5trDkVdF4yLEN6uuJr7TYZf2LKBKsa6xX1uF3/86ObH?=
 =?us-ascii?Q?n5vn8ay/7qOdt/YUtBHghac+wWcCYgO5AvF7RyEvKtDucNUnK8LnDjOu9BU+?=
 =?us-ascii?Q?je8dQDVTr7Y2Z2A+wGFw+rSI7tyjzuRtCxxjJ9zPrECRJUzH/18oWqhf1LWN?=
 =?us-ascii?Q?xgfETo33HR4BDIKmBz9LPsYI7TAxQ7ScXL790AZLa5/4td9vjyiHnZxdsNcp?=
 =?us-ascii?Q?+m7zo5sv3rQrM5Imn5wihWnYpzSzpM5o5uNWm5BYZgvfLdAOX4XJr4OdwPPn?=
 =?us-ascii?Q?VikuRagjVpQ0BqwDqwuiD4b03adefrf0R8W4prBPJPIRl6Fs0AvZMhtx/6Ym?=
 =?us-ascii?Q?0NhuA0hAGNUxau0LyDXOB28yRAtRqvuWVM9gmrO0Na2w47zzF35f9Ie+LXrZ?=
 =?us-ascii?Q?JADqXmWxEd4wMgpsewUnGdo0q7eBXejHJ4LF/7KEIRWrG07xTMAkEDHlVRXN?=
 =?us-ascii?Q?fIkWFeqbXg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 977f54e3-a4e1-4107-9cff-08df47bcc9e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2026 10:47:07.6270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0o26MMZRjjPyZX7mdnlTGyf/c4IWuhNFtGG9gFUX+OLlVgU8D7DXLOQAjuMlUM4GUwvxsnwwL+cM8nbuSjQAQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR10MB555951
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 21 Nov 2026 10:47:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5484

This is merged now.

> -----Original Message-----
> From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Sent: Tuesday, November 17, 2026 7:38 PM
> To: yocto-patches@lists.yoctoproject.org
> Cc: jose.quaresma@foundries.io; Marko, Peter (FT D EU SK BFS1)
> <Peter.Marko@siemens.com>
> Subject: [meta-lts-mixins][wrynose/go][PATCH] go: upgrade 1.27.3 -> 1.27.=
4
>=20
> From: Peter Marko <peter.marko@siemens.com>
>=20
> Upgrade to latest 1.27.x release [1]:
>=20
> $ git --no-pager log --oneline go1.27.3..go1.27.4
> 7b2881024c (tag: go1.27.4) [release-branch.go1.27] go1.27.4
> 4c1752a033 [release-branch.go1.27] net/http: prevent HTTP/1 server crash =
due to
> MaxBytesReader header race
> 3eb71096dd [release-branch.go1.27] cmd/go, cmd/compile: unquote //go:cgo_=
ldflag
> and bound slice removal
> e6ea940f9b [release-branch.go1.27] cmd/cgo, cmd/compile, cmd/link: valida=
te
> cgo_import_dynamic library names
> 55515b6fe4 [release-branch.go1.27] cmd/compile, cmd/link: validate cgo sy=
mbol
> names and prevent export overwrite
> b207530349 [release-branch.go1.27] cmd/go, cmd/link: reject .syso files w=
ith Go
> object or unrecognized formats
> e7b9584fec [release-branch.go1.27] cmd/go: disallow pkg-config local .pc =
paths and
> inspect cgoCPPFLAGS
> 51dadca52c [release-branch.go1.27] cmd/go: validate .syso and linker inpu=
t files
> against scripts and embedded options
> 5f05d301a7 [release-branch.go1.27] cmd/go: validate split -Wl, next-arg f=
lags and
> linker script targets
> 0edfcc8731 [release-branch.go1.27] cmd/go: disallow separated -l flag fol=
lowed by
> to_library
> cbd457366f [release-branch.go1.27] cmd/go: disallow -gen-* and -gnat* in =
flag
> allowlists
> c5426cee10 [release-branch.go1.27] cmd/go: reject GCC spec files in linke=
r search
> directories
> 8e7ba03754 [release-branch.go1.27] cmd/go: disallow --sysroot and -target=
, validate -
> isysroot/-syslibroot, and restrict -x
> 251c4ee2e8 [release-branch.go1.27] runtime: match deferring function when=
 looking
> for linked defers in nextFrame
> 1bf5d09e4f [release-branch.go1.27] crypto/tls: omit ML-DSA from
> signature_algorithms_cert
> 5f0af78b52 [release-branch.go1.27] cmd/compile: record method indices bef=
ore
> encoding a named type
> c56bcdef12 [release-branch.go1.27] crypto/internal/fips140/sha3: record l=
egacy
> Keccak as non-approved
> bb19eae15c [release-branch.go1.27] crypto/internal/fips140/tls12: record =
SHA-384 as
> approved in MasterSecret
> 96f62c8958 [release-branch.go1.27] crypto/hkdf: remove unnecessary HMAC k=
ey
> length allowance for HKDF-Expand
> 4d34001816 [release-branch.go1.27] crypto/rsa: apply FIPS 140-3 approved =
checks
> to MGF hash in OAEP
> caa055b6a4 [release-branch.go1.27] crypto/internal/fips140: run CASTs whe=
n
> generating keys
> 41d6346743 [release-branch.go1.27] net: fix zero value address handling i=
n
> Dialer.Dial{TCP,UDP,IP}
> 8b28706da8 [release-branch.go1.27] cmd/compile: teach deadstore about
> CondSelect
> c1ff416cd8 [release-branch.go1.27] Revert "runtime: fix timespec definiti=
on on 32bits
> systems"
> a0c618c225 [release-branch.go1.27] cmd/internal/obj/x86: clear forward-ju=
mp list on
> PCALIGN
> 62cbde4f2f [release-branch.go1.27] cmd/dist: fix GOFIPS140 toolchain comp=
ilation
>=20
> Fixes CVE-2026-97054, CVE-2026-97033, CVE-2026-97034, CVE-2026-97035,
>       CVE-2026-97036, CVE-2026-97037, CVE-2026-97038, CVE-2026-97039,
>       CVE-2026-97040, CVE-2026-97041, CVE-2026-97042, CVE-2026-97043.
>=20
> Release information: [2]
>=20
> [1] https://github.com/golang/go/compare/go1.27.3...go1.27.4
> [2] https://groups.google.com/g/golang-announce/c/iY8TY0wWgbM
>=20
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> (From OE-Core rev: 1c55f09c670898f39df7862192b536b09786b05b)
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> ---
>  recipes-devtools/go/{go-1.27.3.inc =3D> go-1.27.4.inc} |  2 +-
>  ...y-native_1.27.3.bb =3D> go-binary-native_1.27.4.bb} |  6 +++---
>  ...anadian_1.27.3.bb =3D> go-cross-canadian_1.27.4.bb} |  0
>  .../go/{go-cross_1.27.3.bb =3D> go-cross_1.27.4.bb}    |  0
>  .../{go-crosssdk_1.27.3.bb =3D> go-crosssdk_1.27.4.bb} |  0
>  .../{go-runtime_1.27.3.bb =3D> go-runtime_1.27.4.bb}   |  0
>  ...ke-content-based-hash-generation-less-pedan.patch | 12 ++++++------
>  ...0006-cmd-go-make-GOROOT-precious-by-default.patch |  2 +-
>  ...ilter-out-build-specific-paths-from-linker-.patch |  4 ++--
>  ...ear-GOROOT-for-func-ldShared-when-trimpath-.patch |  2 +-
>  recipes-devtools/go/{go_1.27.3.bb =3D> go_1.27.4.bb}   |  0
>  11 files changed, 14 insertions(+), 14 deletions(-)
>  rename recipes-devtools/go/{go-1.27.3.inc =3D> go-1.27.4.inc} (91%)
>  rename recipes-devtools/go/{go-binary-native_1.27.3.bb =3D> go-binary-
> native_1.27.4.bb} (80%)
>  rename recipes-devtools/go/{go-cross-canadian_1.27.3.bb =3D> go-cross-
> canadian_1.27.4.bb} (100%)
>  rename recipes-devtools/go/{go-cross_1.27.3.bb =3D> go-cross_1.27.4.bb} =
(100%)
>  rename recipes-devtools/go/{go-crosssdk_1.27.3.bb =3D> go-crosssdk_1.27.=
4.bb}
> (100%)
>  rename recipes-devtools/go/{go-runtime_1.27.3.bb =3D> go-runtime_1.27.4.=
bb} (100%)
>  rename recipes-devtools/go/{go_1.27.3.bb =3D> go_1.27.4.bb} (100%)
>=20
> diff --git a/recipes-devtools/go/go-1.27.3.inc b/recipes-devtools/go/go-1=
.27.4.inc
> similarity index 91%
> rename from recipes-devtools/go/go-1.27.3.inc
> rename to recipes-devtools/go/go-1.27.4.inc
> index 7c906e8..3e987ea 100644
> --- a/recipes-devtools/go/go-1.27.3.inc
> +++ b/recipes-devtools/go/go-1.27.4.inc
> @@ -17,4 +17,4 @@ SRC_URI +=3D "\
>      file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.pat=
ch \
>      file://0011-internal-cgrouptest-skip-when-cpu.max-is-not-availab.pat=
ch \
>  "
> -SRC_URI[main.sha256sum] =3D
> "6e7749035cf360f06b2575d162ea79df9fda8ef671889e5c375f8e50777f26bb"
> +SRC_URI[main.sha256sum] =3D
> "73cfb8571aec0c01177687db87163d46aa20e9779672772891aa17654d9a6099"
> diff --git a/recipes-devtools/go/go-binary-native_1.27.3.bb b/recipes-dev=
tools/go/go-
> binary-native_1.27.4.bb
> similarity index 80%
> rename from recipes-devtools/go/go-binary-native_1.27.3.bb
> rename to recipes-devtools/go/go-binary-native_1.27.4.bb
> index c245af8..699f984 100644
> --- a/recipes-devtools/go/go-binary-native_1.27.3.bb
> +++ b/recipes-devtools/go/go-binary-native_1.27.4.bb
> @@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
>=20
>  # Checksums available at https://go.dev/dl/
>  SRC_URI =3D "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-
> ${BUILD_GOARCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}"
> -SRC_URI[go_linux_amd64.sha256sum] =3D
> "65efbc80fdc1fa2cd2631cad5b481777a68e8725f34e89f50fc6ac714e379b40"
> -SRC_URI[go_linux_arm64.sha256sum] =3D
> "a06e99309dbcbdca1a8ccd2282c3ee146e55930886e26b4f1193269587165f49"
> -SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "f180f01943865b7942ab3b4acbab6da6f0f669b61da999d004d16c537a49f7b5"
> +SRC_URI[go_linux_amd64.sha256sum] =3D
> "7226736c2339719cda28fbf3a54d71aa63bcefe376e98cef00034268dab24840"
> +SRC_URI[go_linux_arm64.sha256sum] =3D
> "3392582988a273a87ab5043ee1b2c9c17a2c3c00580bf9326c47a2e0aaaeac92"
> +SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "f508314644fa6f466d1935f8a34f01e7980092a4730bfb9d7fa3ffde81910d20"
>=20
>  UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
>  UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
> diff --git a/recipes-devtools/go/go-cross-canadian_1.27.3.bb b/recipes-de=
vtools/go/go-
> cross-canadian_1.27.4.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross-canadian_1.27.3.bb
> rename to recipes-devtools/go/go-cross-canadian_1.27.4.bb
> diff --git a/recipes-devtools/go/go-cross_1.27.3.bb b/recipes-devtools/go=
/go-
> cross_1.27.4.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross_1.27.3.bb
> rename to recipes-devtools/go/go-cross_1.27.4.bb
> diff --git a/recipes-devtools/go/go-crosssdk_1.27.3.bb b/recipes-devtools=
/go/go-
> crosssdk_1.27.4.bb
> similarity index 100%
> rename from recipes-devtools/go/go-crosssdk_1.27.3.bb
> rename to recipes-devtools/go/go-crosssdk_1.27.4.bb
> diff --git a/recipes-devtools/go/go-runtime_1.27.3.bb b/recipes-devtools/=
go/go-
> runtime_1.27.4.bb
> similarity index 100%
> rename from recipes-devtools/go/go-runtime_1.27.3.bb
> rename to recipes-devtools/go/go-runtime_1.27.4.bb
> diff --git a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-
> generation-less-pedan.patch b/recipes-devtools/go/go/0001-cmd-go-make-con=
tent-
> based-hash-generation-less-pedan.patch
> index 92e2a1b..07ae689 100644
> --- a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generati=
on-less-
> pedan.patch
> +++ b/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generati=
on-
> less-pedan.patch
> @@ -108,7 +108,7 @@ index 8dcf324529f5..617b7ece73f0 100644
>   	}
>=20
>   	// Configuration specific to compiler toolchain.
> -@@ -2839,8 +2841,25 @@ func envList(key, def string) []string {
> +@@ -2845,8 +2847,25 @@ func envList(key, def string) []string {
>   	return args
>   }
>=20
> @@ -135,9 +135,9 @@ index 8dcf324529f5..617b7ece73f0 100644
>   	if cppflags, err =3D buildFlags("CPPFLAGS", "", p.CgoCPPFLAGS,
> checkCompilerFlags); err !=3D nil {
>   		return
>   	}
> -@@ -2856,6 +2875,13 @@ func (b *Builder) CFlags(p *load.Package) (cppfla=
gs,
> cflags, cxxflags, fflags, l
> - 	if ldflags, err =3D buildFlags("LDFLAGS", DefaultCFlags, p.CgoLDFLAGS,
> checkLinkerFlags); err !=3D nil {
> - 		return
> +@@ -2867,6 +2886,13 @@ func (b *Builder) CFlags(p *load.Package) (cppfla=
gs,
> cflags, cxxflags, fflags, l
> + 			return
> + 		}
>   	}
>  +	if filtered {
>  +		cppflags =3D filterCompilerFlags(cppflags, false)
> @@ -149,7 +149,7 @@ index 8dcf324529f5..617b7ece73f0 100644
>=20
>   	return
>   }
> -@@ -2944,7 +2970,7 @@ func (b *Builder) runCgo(ctx context.Context, a *A=
ction)
> error {
> +@@ -2955,7 +2981,7 @@ func (b *Builder) runCgo(ctx context.Context, a *A=
ction)
> error {
>   	cgoExe :=3D base.Tool("cgo")
>   	cgofiles =3D mkAbsFiles(p.Dir, cgofiles)
>=20
> @@ -158,7 +158,7 @@ index 8dcf324529f5..617b7ece73f0 100644
>   	if err !=3D nil {
>   		return err
>   	}
> -@@ -3502,7 +3528,7 @@ func (b *Builder) swigOne(a *Action, file, objdir =
string,
> pcCFLAGS []string, cxx
> +@@ -3523,7 +3549,7 @@ func (b *Builder) swigOne(a *Action, file, objdir =
string,
> pcCFLAGS []string, cxx
>   	p :=3D a.Package
>   	sh :=3D b.Shell(a)
>=20
> diff --git a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-
> default.patch b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-b=
y-
> default.patch
> index 77b4bed..5df9e17 100644
> --- a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-default.=
patch
> +++ b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-
> default.patch
> @@ -94,7 +94,7 @@ index 617b7ece73f0..46c0712c5bd0 100644
>   	if err :=3D sh.Mkdir(buildAction.Objdir); err !=3D nil {
>   		return nil, err
>   	}
> -@@ -1923,6 +1940,14 @@ func (b *Builder) linkShared(ctx context.Context,=
 a
> *Action) (err error) {
> +@@ -1929,6 +1946,14 @@ func (b *Builder) linkShared(ctx context.Context,=
 a
> *Action) (err error) {
>   		return err
>   	}
>=20
> diff --git a/recipes-devtools/go/go/0007-exec.go-filter-out-build-specifi=
c-paths-from-
> linker-.patch b/recipes-devtools/go/go/0007-exec.go-filter-out-build-spec=
ific-paths-
> from-linker-.patch
> index e6a5ce5..c5c4f35 100644
> --- a/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths=
-from-linker-
> .patch
> +++ b/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths=
-from-linker-
> .patch
> @@ -18,7 +18,7 @@ diff --git a/src/cmd/go/internal/work/exec.go
> b/src/cmd/go/internal/work/exec.go
>  index 46c0712c5bd0..e7c0459ee4c0 100644
>  --- a/src/cmd/go/internal/work/exec.go
>  +++ b/src/cmd/go/internal/work/exec.go
> -@@ -1598,6 +1598,29 @@ func (b *Builder) linkActionID(a *Action) cache.A=
ctionID
> {
> +@@ -1604,6 +1604,29 @@ func (b *Builder) linkActionID(a *Action) cache.A=
ctionID
> {
>   	return h.Sum()
>   }
>=20
> @@ -48,7 +48,7 @@ index 46c0712c5bd0..e7c0459ee4c0 100644
>   // printLinkerConfig prints the linker config into the hash h,
>   // as part of the computation of a linker-related action ID.
>   func (b *Builder) printLinkerConfig(h io.Writer, p *load.Package) {
> -@@ -1608,7 +1631,7 @@ func (b *Builder) printLinkerConfig(h io.Writer, p
> *load.Package) {
> +@@ -1614,7 +1637,7 @@ func (b *Builder) printLinkerConfig(h io.Writer, p
> *load.Package) {
>   	case "gc":
>   		fmt.Fprintf(h, "link %s %q %s\n", b.toolID("link"), forcedLdflags,
> ldBuildmode)
>   		if p !=3D nil {
> diff --git a/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldS=
hared-
> when-trimpath-.patch b/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-fo=
r-
> func-ldShared-when-trimpath-.patch
> index 6e71187..56b040a 100644
> --- a/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-w=
hen-
> trimpath-.patch
> +++ b/recipes-devtools/go/go/0010-cmd-go-clear-GOROOT-for-func-ldShared-w=
hen-
> trimpath-.patch
> @@ -29,7 +29,7 @@ diff --git a/src/cmd/go/internal/work/gc.go
> b/src/cmd/go/internal/work/gc.go
>  index 49b26e15609b..7c0d2ac9e0f0 100644
>  --- a/src/cmd/go/internal/work/gc.go
>  +++ b/src/cmd/go/internal/work/gc.go
> -@@ -721,6 +721,12 @@ func (gcToolchain) ldShared(b *Builder, root *Actio=
n,
> toplevelactions []*Action,
> +@@ -725,6 +725,12 @@ func (gcToolchain) ldShared(b *Builder, root *Actio=
n,
> toplevelactions []*Action,
>   	// the output file path is recorded in the .gnu.version_d section.
>   	dir, targetPath :=3D filepath.Split(targetPath)
>=20
> diff --git a/recipes-devtools/go/go_1.27.3.bb b/recipes-devtools/go/go_1.=
27.4.bb
> similarity index 100%
> rename from recipes-devtools/go/go_1.27.3.bb
> rename to recipes-devtools/go/go_1.27.4.bb
