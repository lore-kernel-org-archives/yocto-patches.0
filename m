Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.11])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14655.1795258049590822207
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 21 Nov 2026 02:47:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vsZg9mrG;
 spf=pass (domain: siemens.com, ip: 40.107.162.11, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QaZH3sY29PHfu4vKXkkT+873+P42AjHb3GDkeCeycAT+gMQcd7NLT6x2n1E9A58g7GH6ebxWWOfYZJvAq1uRAofQqxOxBuCmE+jV/keRDvkUVs1JnMAOYEX+i0LX4fpYZpO7mfKWJktybjyPJTCwnD8Lqn33rzvX9wj6owQquutxUEZdBZH6sPh0YXPaQQB0CbdFx1Zw9UU4tOTyv4oHUtjFNkMKUcfalOcHzzOtEovdqfnGXg+Do67yuFk7JUvlhy4IqIXVPVBHIW9I7SP/wfCTJgX0N5bdEcvMqOdjcB8QDuk3yOsefoEam7aaGsheSD+yl1sWTm6e/+oQ9X/RnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73f12DAy8/aezS50YyU7l5zVs3gvId6Lfz331ZgIVZ4=;
 b=tYqoknSMTsGJ5K7qqeVwSCWQHrJ7OQIq6HxlSmtMVWxjTu7NZwVg8xbVS12F2amPBDZjCPVKHqkEw+jHnc08veq7OeA1yV+ELZriccLKeg5qnpgmM0l0WnMYMsQSIU7ba5ipEplqhBTs4xWp0ljil4bLIB/p6FK4DeXOb7MXF+duTqTeGwOKWTXstDkqL3MeEn/DFrrI59tP6vuHn24rcvagyYA4HU+Zv5ftJM1Gzorpv+QL2cYt5Hl5uxDCNBS956oPkuG5JH3KlJJ70A1n66f4hcwhEaWSSkVtrOyeBwTBh0vtxgyIEJ8yRJUccx735O623gshhIX9mW81YvMV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73f12DAy8/aezS50YyU7l5zVs3gvId6Lfz331ZgIVZ4=;
 b=vsZg9mrGtlQdqq6MuTyyAFHMgPwPNE6yz7OHs0PC3vlxB6QevNM1RNZQ8KH/Bn1g2ShYfdIW9gtEdF7tKT0Cp+bZZcl1/MTqBE4QVE4eO5xxe6+UW0Ml+Z6x3c41ZhXXJVTHykVWCmTNh8yft4ONFqWKO68igdyuod8WWmq3hlrWRpTSrmO5hlBZdLg5IRQRUNDjnXn+dfyuPu0ifx/sKCRs/RS7+Dx47TtO3gj/dBJ1Z9ns3mDx/E3JrxEjHKpqNs7RE3b5AUDYNyuVQ0voRA2OTQjOzRQE0W+PDJmiundLIeGQsykaozy4jCKYW0YKCRR5RplkCEq4vP0jxxxx8g==
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:420::16)
 by MI9PR10MB555951.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Sat, 21 Nov
 2026 10:47:27 +0000
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008]) by AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008%6]) with mapi id 15.21.0639.006; Sat, 21 Nov 2026
 10:47:26 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.27.3 ->
 1.27.4
Thread-Topic: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.27.3 ->
 1.27.4
Thread-Index: AQHddsLJoeJqxl75+UWislkTu/q3d7c4Xb7Q
Date: Sat, 21 Nov 2026 10:47:26 +0000
Message-ID: <AS8PR10MB5073F9407CA433E0FF81C90DFD472@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
References: <20261117183758.3683114-1-peter.marko@siemens.com>
In-Reply-To: <20261117183758.3683114-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=0159b548-4a99-4a06-86c1-eea5fffa1200;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-11-21T10:46:58Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB5073:EE_|MI9PR10MB555951:EE_
x-ms-office365-filtering-correlation-id: 869e0b95-60cb-4b80-496b-08df47bcd562
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261028144727099003|261021123027099003|261021121427099003|261102130727099003|38070700021|261102123227099003|11063799006|56012099006|10067099003|260925021311599003|260925022911599003|260925021911599003|12006099003|18002099003|22082099003|261009223027099003|55112099003|6133799003|29003799003|25016099003|3023799007;
x-microsoft-antispam-message-info: 9+2yxs4Exm7OWUj4X6jLMLHiJM7Kp5PZ0sX8eSi/6k6MiFPVHNM2aWsJVek3wGXT/1gIcoZF87V9O+vX1cKBmL1o4WRBl3wuxF9ALPCnZWkkPfOuwJuSaJ1h1zm9dBPV4tG3byNtlQgGJJ6PZwHrO0cfPuN9ZTf0vTgWdyQUukHoCLXk/taE17bcziIyoJpvlmQc2xR6HESnSWiz5/hKlD0BkXSYk2PC/RucYagq31nP9oWpeD6joHIhrPU3GTxHaOgZ2lXpxeKQ/45veHa50qCIf3N5SWu1b1VCqwoIHxEukGmZxylCcYzdN7FdHm4pUNpt3QnoAxlLCG34H0a+d80moXqk4YG2AN4xmrz/VDt+5schPOi/vDbGh+TjCpI8unuqYKcTi/4Uxu+o4uRhrjJoh6qLg6hk6tXaGLWSn6bFDR2f531jsMnfS0jT+gnBZ5tAHS1zpgLszOIa2a4wKCeK8D63HKTcCQiGSEMUPFbhhSQqSgxcOtMabB1O2qqvVG8LCeyjB8rqGo+tpAVTRIkcEQM/4GuXUZlAeG25ua+Ezu6SyGDibDWdUhztWWgAdyO2j/ugy/IpRStCjZWnoi4yx7Q8O6Qq6BWcs/TN6SpE+cMvy93hhnyV58HcS8oID2dmu821L+SYI0Np2Pe5xNfMRM0UzCE5koh/+ET83Fo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102130727099003)(38070700021)(261102123227099003)(11063799006)(56012099006)(10067099003)(260925021311599003)(260925022911599003)(260925021911599003)(12006099003)(18002099003)(22082099003)(261009223027099003)(55112099003)(6133799003)(29003799003)(25016099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Be2TAa5jUzqlnnfHeUWCCa6rFf/qfdt0iw/HJPRhWTQD8B4x5VNEre6XNzxE?=
 =?us-ascii?Q?M0hca0xCPhoeo2Lc5d0URcEJd5+DQnMr+WGLBoYSNznODauZ8zucIYZWWFUe?=
 =?us-ascii?Q?FUJMhgRWtGjepxHjfXqsSypUPaQ7Lh9hPFkfM1Y8FlZv9H+Xor+Tl9UBWhaT?=
 =?us-ascii?Q?ADfm+Rs5WOXqKzNpRnPK9iMEwp1sydvRQMvZ6p97Bf0IqqRFs817Ucj/VS0X?=
 =?us-ascii?Q?encO76St1eHKprpPA/uwpmwfWN7+l0sybb2lNwmwH43Q6mHuh7bThzyeYSlN?=
 =?us-ascii?Q?pj3X/PYmzu1okIvngx4NomTA6pY/BYoKv3LTOyml0g6rzSbzTt6oI7OsJ7Nr?=
 =?us-ascii?Q?tNEzC0U62VZML6z1pj2qHLjxfKCN4dky2Y+LpIfQIxslHHnQrwyzzgozKk7W?=
 =?us-ascii?Q?3PzSpKSFKIHBgk1iMfeBuug2AwgnWO0/p0kKzBzCQV5wL/2YRdiasHeHqE5k?=
 =?us-ascii?Q?UWQC1zAKWkduPDJMm00QP2pawiO22Wko/paG1M/QFEOJbRtRkB5UTbFbvr/n?=
 =?us-ascii?Q?XCtPvUKL9ehd6mxmiO6KxrsIRzpH9zvgSUIQljlNaiUWNIVT3quhGi2YHaDx?=
 =?us-ascii?Q?Xtu2fIfZ0LTEasMdcYBwXU7kXw0bgMAWQL4+VqlDxU3MDPfGAHRVilbrg5n1?=
 =?us-ascii?Q?0mgBvAxvu9WQqrjuD9wjULgKG9caWrZoghOWhOToQ8Ek3RrgHEVaPwjJW20y?=
 =?us-ascii?Q?lFeePsyoW+/zxSfXRGYuKvs7siXSQbQDbxswFCkA8pXnwU+B2w2RuWCZxwI0?=
 =?us-ascii?Q?LuyF8QH0CtCXXk1YHonARj+HPvK5E5ZPPjrBPzP6uW+1v6/wVHSpxsbkPzc0?=
 =?us-ascii?Q?f9jJePgJIxdCnMXbu3bRnXcfrarvoEP63sjETlCzbYqsvBJECVsGTvlfdAJD?=
 =?us-ascii?Q?jK8GYiVhzRKd4acCnAmE7QsyCDO7pnCI9UB53ddl3ZUQ/Q9RR205ifB4uF0o?=
 =?us-ascii?Q?VJFT65NWjQoufJ6BpUxGVHk242FuXqrvBrhfWzUmq8XShtZxsH38KD5hhdxq?=
 =?us-ascii?Q?iVhTtnURXeYtveXxXEBE+58NxJIMj3EubsOYG13lYOSimjrZrnNbg99BiVGo?=
 =?us-ascii?Q?4TQJPolndtHyUR7uxc+Be6KFOQtBf/M19ca4fmznTULA7AgYTVxM387se8Bx?=
 =?us-ascii?Q?ffrKFYPbFyibHkdv2+kd9lsVCNQXU8Kjl7f+sSzSP1nTt8HaAqWN+oLP4nXe?=
 =?us-ascii?Q?LF/7jp2ZvRJTuXCZmHfvubeh6R9+DoC35llUW+40hwyJ90No5G430+b72hve?=
 =?us-ascii?Q?4iajE7Lh8Jx1Fe3P/PuxCWL8uqcDOD5D+uWhhLOkCksSop4ZM3+U2khVl03n?=
 =?us-ascii?Q?f3Q0KksH4yQ2r9dux0KplUjOFBlsr5/oh6N5CFujs6nsHZqp2+7o4XUgLhWN?=
 =?us-ascii?Q?gjvQ8zuNsvLAY8kFYBmH1JqGwzOa68p+ZgXyMb4cale32mlHAadWvv5+s6fB?=
 =?us-ascii?Q?tsivKYmptKnldU2tW6OTPtaF/SjEqo4z8r+1YGnz2dHZoEsqBtSwLtkxcckA?=
 =?us-ascii?Q?7tJuTTb9BPhr0gFULKAeBbVBU40b8DoH0HnSzF68oVYNjVg+JcOIdfJK/BN9?=
 =?us-ascii?Q?8SboE2ZEoqXgRaxap+io9NyDAytVHCYvhGeG0uBO5mOEMxT7TR6NUBYLb2yZ?=
 =?us-ascii?Q?9boEwuI5U3yNvZCDSLx2YDY7EG9Xlksay8C43Eu1eajpLXNGD+2y5idCU2e4?=
 =?us-ascii?Q?naDhoHXesk9zNxzMDmlWM2BcPboS1oK3g8EOSNz3mlAmc9hSxOnpIqty5ox/?=
 =?us-ascii?Q?e0XuKqrQxw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 869e0b95-60cb-4b80-496b-08df47bcd562
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2026 10:47:26.8812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8N/wDJD1JlepYIM+P5Ts0UbrWOWescCxCXeXZcK5tZ3MECVd7YGWBD40Lw2Ob3MIrzLIfqARE3qvZHPu3c6jpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR10MB555951
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 21 Nov 2026 10:47:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5485

This is merged now.

> -----Original Message-----
> From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Sent: Tuesday, November 17, 2026 7:38 PM
> To: yocto-patches@lists.yoctoproject.org
> Cc: jose.quaresma@foundries.io; Marko, Peter (FT D EU SK BFS1)
> <Peter.Marko@siemens.com>
> Subject: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.27.3 -> 1.2=
7.4
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
> index cc4664e..55cf81a 100644
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
