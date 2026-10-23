Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.67])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2419.1792743309698960595
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Oct 2026 01:15:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eXiC/W2U;
 spf=pass (domain: siemens.com, ip: 40.107.159.67, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBJg0vBHI4EW8fwwygpUDnKC2n3t1urwPC+z0ZzxCS4+x345QjUfGA5yruv+yLIpJ6xi6QQZ8np63h2Iw4Y0h34yASE1ifdAxTxQWd2QaWOS+HWDm2JWNEJJm5jVp0aqAnosD9hYdrVyXqMN2o8yG/U5aTah8JKhkb5lChpZe5VjhKhFBssqVFtj57OpOd6f9dOx2FlnG5eSYY1OIy3RENuguUs2SYWri01r4FR1HMPyUHcS6G8yFPqxqoRCiCVyClCJoztjsE2Rjv7HpGPycfZEQz2KgFNWExZa9B3cPwf5yd/NpAvafCyM84gkAl7q8CgMwGqqbXoGsGoi85znWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6O03Tv5tZ02tY+9we2Dg95dCdU9RmZJYMn06xHSMOvE=;
 b=ggyl4LeHj+yVKlFUvpRx0nE+ruUcpIQn0jY2RP9gj46WGa2O1rAVEBhiYGQ0tnze0w69V3mS6dNhmbnzyI3KhxIlavH2jMKMiglZ8I/aoIJepPVPDF2EIAmSilUCWqZFveERtWRQNLplGm0DZ/1OGgy0ZxH5d3MYoJVUqyUu0qPIV0ph/Br8jmp9pmM0ldQe/oU9+msCc5+u6atoXXN1zcHepn2/TByT7HkpUSkj1Eu/58fjAv1Ou/lH5MyohrByG3Hfth4p/iYATjs6PLpEua3CmVl7Po6ofxfHJ8hZQCNUyU+3/2Xhab858NRyML/hePyDXr3s9ivldfVSiNOa3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6O03Tv5tZ02tY+9we2Dg95dCdU9RmZJYMn06xHSMOvE=;
 b=eXiC/W2Ug4Klb4+CN1fX39pWEoj5XGvWXfEySfOIzHWp27O4aVgEdonL0VGgX493OcsWLYiRuxjL3HHIvxrRAI2G7axD6flRhvu2r9Wm9YGLSu3A1m3SH/JuQ4PBkwgeW8lPcCvLpgOh6lT+jd3QOnOzWskj7hAUnAIljJdplb3xfX9FZ1ciSobsM1JrQEYQJGv60chrQrjYpkp7RVkLMMVN65BY6Z3XgPNVAI1j2gIowpI846b5qc5AEaZwtMzgAEHBw1EVUN4Cqm/0LgeTe472CcP8I0CncPhiH6qgBphpSWUzPWdGz0Be6U+lcmes2wH3dW4J3bqlbYUhJBbKog==
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:420::16)
 by DB4PR10MB7471.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3cd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.3; Fri, 23 Oct
 2026 08:15:04 +0000
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008]) by AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008%6]) with mapi id 15.21.0569.002; Fri, 23 Oct 2026
 08:15:04 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: Antoine Lubineau <antoine.lubineau@easymile.com>,
	"yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: RE: [meta-lts-mixins][wrynose/go][PATCH 2/2] go: upgrade 1.27.1 ->
 1.27.2
Thread-Topic: [meta-lts-mixins][wrynose/go][PATCH 2/2] go: upgrade 1.27.1 ->
 1.27.2
Thread-Index: AQHdX9pikOBIBdwgQECIHpj7xWrSLrcKzWIA
Date: Fri, 23 Oct 2026 08:15:04 +0000
Message-ID: <AS8PR10MB5073DC11D5341BF6A508F6E6FD642@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
References: <20261019145853.154403-1-antoine.lubineau@easymile.com>
 <20261019145853.154403-2-antoine.lubineau@easymile.com>
In-Reply-To: <20261019145853.154403-2-antoine.lubineau@easymile.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=395c2a3a-ed38-4be1-abd9-9e95aee6b7c8;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-10-23T08:14:37Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB5073:EE_|DB4PR10MB7471:EE_
x-ms-office365-filtering-correlation-id: 6939d39e-5e66-419a-5f64-08df30ddbe35
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|3023799007|261009223027099003|260925022911599003|261022075727099003|261021135927099003|261021123027099003|261022105027099003|261021121427099003|260925021911599003|260925021311599003|10067099003|56012099006|6133799003|29003799003|12006099003|25016099003|22082099003|18002099003|55112099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: vfEE6V9iuJJvAfMSEFgUbwOlT5T6pERgwj0/2RL3yurO0Spqzv2k3Tfw8oJfhiK+95f1RuLEyXi8sGL9OpEs4bXNhRaLZuaMV8UWSt1nTh0MEXZGJyCxwypeWAjxbab6AHcOEvlv1TBDgS//RKzWfX230qP+fV9Iz3qzYuElVbx+4uKhjB6cdooaRJynfqOI7OTCVe88js1vGVawxEm5l9t5A9heSQZps9JK21dOzNekrOlA+FkZIag/6ow/7qarWaTmbp9dAACNFPz2K1aytBIo08RYPY5IDDQMaMQqG2p5x0ldTVonMMXmXbh/QqdGOm3FxrL+yA42njLORBz81V9QigiyIpTHKl2EjgUWEK7iIBVuhfhs8aftl7+usssW7RBKWABoG+NmCWdIgP+dY3cY9hye3zU5XSJGjnFWhKsnYUSyo7TAXXF04EAYEcW3gicujSU4hb5IO/AsFayGarECNuVfHGE4R+oXa/bGyv/rAJL1udmUdMnjDwP9slk4Z5ZepWS5p4aoZhf06mNU2e16pUTSXT+1mPu6qSbJ1bwZGq/XvyvDtE+4hH312sHPMHY/wYj8sQDQfXPmzDmeeBdocS5py4M+xok39tmF0oy1NszIDk2TCyHnFIjrYJjBjRx5YJXdyFEzjpZhvp3+poVI1DjaHLC/lDD6TUe/0VY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(3023799007)(261009223027099003)(260925022911599003)(261022075727099003)(261021135927099003)(261021123027099003)(261022105027099003)(261021121427099003)(260925021911599003)(260925021311599003)(10067099003)(56012099006)(6133799003)(29003799003)(12006099003)(25016099003)(22082099003)(18002099003)(55112099003)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Grc4KURKpjCoYV4aB/9fy31Z0foLQyhD9wqC3I77xyZruGUc5SFb/Tmlgr?=
 =?iso-8859-1?Q?1VIvMQsllJ/E1VHcZuo8D3mZ2XJU6B/QplegIr9xIROeLa7pe9dtj4Qrs+?=
 =?iso-8859-1?Q?Wesd2riNzT3d96vWvVeiYJrAb+QCcvnuDCFgSpvW0ImHgW3n1P8hqI4muz?=
 =?iso-8859-1?Q?Hru0sbKad+G4UgyKSgj7RU5vaPwnPII+3sBQSf8yiryZSHSrvNCzsvNcsa?=
 =?iso-8859-1?Q?bJA5K/m+rea4R3TnvrI6itSqnmPGCm8KvEV9lDMkE3eJdYC4eA7Ko6+Dz+?=
 =?iso-8859-1?Q?SrEyktZCszeuQC811JNWGqUiZbHtwq2cXhP67ive+81n6dxOLRcuXh2G8T?=
 =?iso-8859-1?Q?MOThkuDzZAhxkeQa4ZLubhmNhuNkxEX0vAiWEQ6ZcKRnlOjA1GXktbZc14?=
 =?iso-8859-1?Q?0WYmRwjmtkLNaBrlBfl1gBLSePjiRwaGyX4gnZ9CWROwyx8vyL3szdjhM2?=
 =?iso-8859-1?Q?So7LNVipuoxPk2nbmGRAoy4xFSJ6mnaPz+S3NyNWq2TA1yzXDV3hnHvAiV?=
 =?iso-8859-1?Q?v0t1BhYtI0yzMwdAe8DQ2S3YUUh02+XKIa4OGiFAJ9/NgNRUJlGgQZXfyI?=
 =?iso-8859-1?Q?yMR1BSKIv+whoPQ/V19uegK4FSkq5YaKKWP0lHebVfYrm+ajI1F5RQCq/e?=
 =?iso-8859-1?Q?w2bhxLxYvXWQ4hmxLqmytDL0TW89iqWjdOmj83pVw+OqVffwIIBRksXx3U?=
 =?iso-8859-1?Q?ph7Fomgz1rIwdO/B2oLvJC1j9WxwmfdxbV5dNl+L8Hchha15MeqO/MAGtG?=
 =?iso-8859-1?Q?4ibjhdd2qo5G3QzgrWp1+c0CJdnOgs8c3SuHjvm3G6VPP3FZ43P7NU4o0b?=
 =?iso-8859-1?Q?tc9xnQiOHAJuyra0IcXEKaDixrZDgb8zyHA8hd3TVOYgv7FIgMupGswQZZ?=
 =?iso-8859-1?Q?l0pVawkbTFezAFVmgJykUfTp4iazM9PfB9cvxSPn20XiNpdOud3Dhp7nvJ?=
 =?iso-8859-1?Q?Rj+7eXkQBTwXITGH+fvahalHI5lHgy+AyrpB38k7uC60eYd68iNFDQA80F?=
 =?iso-8859-1?Q?NPV9AfWGYIBpe7GxbqF/UEmRD0WlzM2MBXTpZx7Uwp38faVT0Z22PbK1f2?=
 =?iso-8859-1?Q?pdzZjWsBeq2u/NDn5670zH4er2lgOT2C2PDqae8cpe1a8ZMWrlfZ4j+Er6?=
 =?iso-8859-1?Q?6cO+ttKZbafW+Br6gHvTJ6zEvLh5+P9Wf1ILPCvx1Pz9OBMndTXI26naUP?=
 =?iso-8859-1?Q?Vj8w3jZCLHmbd1FBVJiJoK+T/gfYtYlicb1bXn6R9avK39krFhjSTDHhJT?=
 =?iso-8859-1?Q?TKJOj4iQEvhjO1fBJ8iGVTfslsCEj2X4rOAZQ4fB47/SOqDUgttzfIBZdK?=
 =?iso-8859-1?Q?siXCc2Nsd0WSsZSS11TA6bUMMffw86g7uruU3Vlev6WIeH8iRE5iQyTSuH?=
 =?iso-8859-1?Q?jO+wUXkxJwBFQkh6V3V55z+GREKIKet/bJMopptrEkJV5EIAux3bjxfLOv?=
 =?iso-8859-1?Q?VX/30LnQJUVjTxvM0ZoPDpC794ajdu+nFwZ9T81w6buorhVg1lMchtoIYr?=
 =?iso-8859-1?Q?F5AXHcTBVnuU+LenJydPuneSx7JVCrDZsln+mLZK8vHVbmFoUWLuGM8LrI?=
 =?iso-8859-1?Q?heh2BK3U7lswAgo2cMoByP3AaULwR3G7OGcn/VC/fNz1PPPvnRGKhosvqY?=
 =?iso-8859-1?Q?4rRNSXmtD2E6jgsS7PSWliPy80gmwH82okw3L3JRGjjIm/NHOq7RlrPGIN?=
 =?iso-8859-1?Q?CH67DJpay9WdGH6mXCetyWZ5EBERWiEXu48aomnQFJHYrrLK15sZWzQMmk?=
 =?iso-8859-1?Q?XhHfeP342SB8f0SeBYxnhbGPK9VhELDSUwqDxhoj+EzejEBg9U4lOl+s/Q?=
 =?iso-8859-1?Q?2yHkoXiD1w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6939d39e-5e66-419a-5f64-08df30ddbe35
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 08:15:04.6896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kpt3ulVVkDcc4QcmQ3Sk4yixnkfQGGgFX2pZbUdSY2eO/oa/6Nb/Ojg92kocb2MBzI0lxiZ7mP2ayRV0OXlBqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7471
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Oct 2026 08:15:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5142

This series is now merged

> -----Original Message-----
> From: Antoine Lubineau <antoine.lubineau@easymile.com>
> Sent: Monday, October 19, 2026 4:59 PM
> To: yocto-patches@lists.yoctoproject.org
> Cc: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>; Mathieu
> Dubois-Briand <mathieu.dubois-briand@bootlin.com>; Richard Purdie
> <richard.purdie@linuxfoundation.org>
> Subject: [meta-lts-mixins][wrynose/go][PATCH 2/2] go: upgrade 1.27.1 -> 1=
.27.2
>=20
> From: Peter Marko <peter.marko@siemens.com>
>=20
> Upgrade to latest 1.27.x release [1]:
>=20
> $ git --no-pager log --oneline go1.27.1..go1.27.2
> 022c863611 (tag: go1.27.2) [release-branch.go1.27] go1.27.2
> cbb0fb8b51 [release-branch.go1.27] net/http: apply header limits to Trail=
er
> headers too
> 12acaf3086 [release-branch.go1.27] net/http/internal/http2: prevent crash=
 due to
> HPACK encoder race
> 31dc9e2449 [release-branch.go1.27] net/http/internal/http2: avoid 2x refu=
nd on
> stream close with buffered data
> 1d58cdaa10 [release-branch.go1.27] net/http/internal/http2: avoid excessi=
ve work
> on initial window changes
> ababc3cd87 [release-branch.go1.27] net/http: limit the size of range head=
ers
> parsed in ServeContent
> 9636ab0f17 [release-branch.go1.27] os: correct Root junction handling on
> Windows (avoid mkdir escape)
> e92229e24a [release-branch.go1.27] net/http: avoid server reuse of connec=
tion
> after CONNECT
> 76875df0f3 [release-branch.go1.27] net/http, net/http/httputil: avoid pos=
t-
> CONNECT pool corruption
> 7c79b50a74 [release-branch.go1.27] net/textproto: enforce MIME memory lim=
it on
> first line
> f022e61963 [release-branch.go1.27] crypto/tls: validate ECH outer extensi=
on
> references
> 68fa7699a2 [release-branch.go1.27] cmd/go: always verify toolchain downlo=
ads
> with sumdb
> 1e4f1fec6f [release-branch.go1.27] cmd/go: bundle go.sum h1 hashes for
> golang.org/fips140
> 6e2cfab0a1 [release-branch.go1.27] html/template: recognize `yield` as re=
gexp
> preceder keyword
> b26d150e69 [release-branch.go1.27] html/template: reset JS context for te=
mplate
> expressions
> bd9992d1d1 [release-branch.go1.27] cmd/link: pass -no_fixup_chains to C l=
inker
> when building plugin on macOS
> ce0ff94df1 [release-branch.go1.27] cmd/cover: preserve statement counts w=
hen
> splitting coverage blocks
> 87b06e2c18 [release-branch.go1.27] runtime: create Windows threads on the
> system stack
> 9c26a3af46 [release-branch.go1.27] cmd/internal/obj/ppc64: fix async pree=
mpt
> safepoint bug
> b73c143090 [release-branch.go1.27] cmd/compile: use a 32-bit type for rew=
ritten
> rotate amounts
> 8ada93d797 [release-branch.go1.27] encoding/json: fix
> UnsupportedValueError.Value regression
> d995fb820d [release-branch.go1.27] net/http: populate Request.TLS from HT=
TP/2
> connection state
> 322f1785b0 [release-branch.go1.27] encoding/json/v2: avoid setting with e=
rrors
> parsing float
> bc516c2b36 [release-branch.go1.27] cmd/go: include VetxOnly in the vet ac=
tion
> ID
> 4e4eec75bd [release-branch.go1.27] os: preserve completion notification m=
odes
> for NewFile handles
> 359bec41ae [release-branch.go1.27] cmd/compile: support unified V5 export
> data (method indices)
> bd8f7a67b7 [release-branch.go1.27] cmd: vendor changes for "go fix"
> fa3bd01f47 [release-branch.go1.27] cmd/compile: call racefuncexit before =
a tail
> call
> aee72efe29 [release-branch.go1.27] testing: escape framing markers only i=
n
> test2json mode
> 620e2e0a1a [release-branch.go1.27] runtime: keep the working directory fo=
r non-
> bundled ios/arm64 binaries
> d16d95ce1d [release-branch.go1.27] compress/flate: do not emit the preset
> dictionary into the output
> e89d44fee0 [release-branch.go1.27] os: handle unsupported
> OBJ_DONT_REPARSE on older Windows
> c407a15ec8 [release-branch.go1.27] cmd/compile: don't stack-allocate a sl=
ice
> whose element interior escapes
> ff5898f7aa [release-branch.go1.27] internal/runtime/syscall/linux: sync E=
pollEvent
> with the kernel header
> 072779d815 [release-branch.go1.27] net/http/internal/http2: delete malfor=
med
> framing-related headers
> 2e4b38eeb8 [release-branch.go1.27] net/http: discard trailer when drainin=
g a
> response body
> 8cd5a090e0 [release-branch.go1.27] net/http: return nil from Body.Close a=
fter a
> failed Read
> db5314201a [release-branch.go1.27] net/http: read Response before signali=
ng
> eofc in readLoop
> aa6fc252ed [release-branch.go1.27] net/http: fix HTTP/1 deadlock on concu=
rrent
> response body Read and Close
> 1cfd8f0112 [release-branch.go1.27] encoding/json: avoid calling MarshalTe=
xt on
> named string map keys
> f8a45f672b [release-branch.go1.27] cmd/compile: fix large riscv64 move/ze=
ro
> 072330d2ed [release-branch.go1.27] cmd/compile: correctly mark interface =
calls
> as used for tail call wrappers
> 1e44a4c9d9 [release-branch.go1.27] runtime: don't add the itabs of a plug=
in twice
> 2ee6421c51 [release-branch.go1.27] runtime: netpoll: fix 32-bit little-en=
dian
> eventfd type confusion
> 33c04bd7da [release-branch.go1.27] runtime: disable mutex profile during =
async
> preemption on windows
> 113a7a0a0f [release-branch.go1.27] crypto/mlkem: fix FIPS 130-3 CAST
>=20
> Fixes CVE-2026-97032, CVE-2026-78659, CVE-2026-97031, CVE-2026-94444,
>       CVE-2026-94447, CVE-2026-94448, CVE-2026-97030, CVE-2026-94440,
>       CVE-2026-56866, CVE-2026-94439, CVE-2026-78669, CVE-2026-78660,
>       CVE-2026-56857, CVE-2026-78667 and CVE-2026-78663.
>=20
> Release information: [2]
>=20
> [1] https://github.com/golang/go/compare/go1.27.1...go1.27.2
> [2] https://groups.google.com/g/golang-announce/c/U2fTuyDJznI
>=20
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> Signed-off-by: Antoine Lubineau <antoine.lubineau@easymile.com>
> ---
>  recipes-devtools/go/{go-1.27.1.inc =3D> go-1.27.2.inc}      | 2 +-
>  ...binary-native_1.27.1.bb =3D> go-binary-native_1.27.2.bb} | 6 +++---
>  ...oss-canadian_1.27.1.bb =3D> go-cross-canadian_1.27.2.bb} | 0
>  .../go/{go-cross_1.27.1.bb =3D> go-cross_1.27.2.bb}         | 0
>  .../go/{go-crosssdk_1.27.1.bb =3D> go-crosssdk_1.27.2.bb}   | 0
>  .../go/{go-runtime_1.27.1.bb =3D> go-runtime_1.27.2.bb}     | 0
>  ...go-make-content-based-hash-generation-less-pedan.patch | 8 ++++----
>  .../go/go/0003-ld-add-soname-to-shareable-objects.patch   | 6 +++---
>  .../go/0006-cmd-go-make-GOROOT-precious-by-default.patch  | 2 +-
>  ....go-filter-out-build-specific-paths-from-linker-.patch | 4 ++--
>  ...rnal-cgrouptest-skip-when-cpu.max-is-not-availab.patch | 6 +++---
>  recipes-devtools/go/{go_1.27.1.bb =3D> go_1.27.2.bb}        | 0
>  12 files changed, 17 insertions(+), 17 deletions(-)
>  rename recipes-devtools/go/{go-1.27.1.inc =3D> go-1.27.2.inc} (91%)
>  rename recipes-devtools/go/{go-binary-native_1.27.1.bb =3D> go-binary-
> native_1.27.2.bb} (80%)
>  rename recipes-devtools/go/{go-cross-canadian_1.27.1.bb =3D> go-cross-
> canadian_1.27.2.bb} (100%)
>  rename recipes-devtools/go/{go-cross_1.27.1.bb =3D> go-cross_1.27.2.bb} =
(100%)
>  rename recipes-devtools/go/{go-crosssdk_1.27.1.bb =3D> go-crosssdk_1.27.=
2.bb}
> (100%)
>  rename recipes-devtools/go/{go-runtime_1.27.1.bb =3D> go-runtime_1.27.2.=
bb}
> (100%)
>  rename recipes-devtools/go/{go_1.27.1.bb =3D> go_1.27.2.bb} (100%)
>=20
> diff --git a/recipes-devtools/go/go-1.27.1.inc b/recipes-devtools/go/go-1=
.27.2.inc
> similarity index 91%
> rename from recipes-devtools/go/go-1.27.1.inc
> rename to recipes-devtools/go/go-1.27.2.inc
> index d7ba03b..86598ad 100644
> --- a/recipes-devtools/go/go-1.27.1.inc
> +++ b/recipes-devtools/go/go-1.27.2.inc
> @@ -17,4 +17,4 @@ SRC_URI +=3D "\
>      file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.pat=
ch \
>      file://0011-internal-cgrouptest-skip-when-cpu.max-is-not-availab.pat=
ch \
>  "
> -SRC_URI[main.sha256sum] =3D
> "4e408abae126d916b6164627193f2c54f0e3ca1312d693b86db45f862ab238b1"
> +SRC_URI[main.sha256sum] =3D
> "03495da2ba64894d40f5c4992e49454fa78b50690604ff92b6afff5081b76e62"
> diff --git a/recipes-devtools/go/go-binary-native_1.27.1.bb b/recipes-
> devtools/go/go-binary-native_1.27.2.bb
> similarity index 80%
> rename from recipes-devtools/go/go-binary-native_1.27.1.bb
> rename to recipes-devtools/go/go-binary-native_1.27.2.bb
> index f909581..19482f7 100644
> --- a/recipes-devtools/go/go-binary-native_1.27.1.bb
> +++ b/recipes-devtools/go/go-binary-native_1.27.2.bb
> @@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
>=20
>  # Checksums available at https://go.dev/dl/
>  SRC_URI =3D "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-
> ${BUILD_GOARCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}"
> -SRC_URI[go_linux_amd64.sha256sum] =3D
> "63d339f0da5ab53635a56f2490a7984dfe12dfcff22ad749f63edaf590168445"
> -SRC_URI[go_linux_arm64.sha256sum] =3D
> "3450b45a3f9ee8568792736a5c5e70a1f2e9b36c35a8f74958c03e51d7d92bec"
> -SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "ad1ff83c24f783c2d4a025852b928a05c199e8742a14a5482d88de0293d2bd0d"
> +SRC_URI[go_linux_amd64.sha256sum] =3D
> "ecbadb99091a3f46e31f5f934b068b1864eafa7995211b39eaddf76996045fe5"
> +SRC_URI[go_linux_arm64.sha256sum] =3D
> "94f3e30b8e374bc285e7dadc11e0865726b9bc6e85b841ccceaabc0214c6b7c8"
> +SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "059d5f01b1607a724ea5ae87c5589041a51c577a6f3f20099e49d00f31c803fa"
>=20
>  UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
>  UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
> diff --git a/recipes-devtools/go/go-cross-canadian_1.27.1.bb b/recipes-
> devtools/go/go-cross-canadian_1.27.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross-canadian_1.27.1.bb
> rename to recipes-devtools/go/go-cross-canadian_1.27.2.bb
> diff --git a/recipes-devtools/go/go-cross_1.27.1.bb b/recipes-devtools/go=
/go-
> cross_1.27.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross_1.27.1.bb
> rename to recipes-devtools/go/go-cross_1.27.2.bb
> diff --git a/recipes-devtools/go/go-crosssdk_1.27.1.bb b/recipes-devtools=
/go/go-
> crosssdk_1.27.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go-crosssdk_1.27.1.bb
> rename to recipes-devtools/go/go-crosssdk_1.27.2.bb
> diff --git a/recipes-devtools/go/go-runtime_1.27.1.bb b/recipes-devtools/=
go/go-
> runtime_1.27.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go-runtime_1.27.1.bb
> rename to recipes-devtools/go/go-runtime_1.27.2.bb
> diff --git a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-
> generation-less-pedan.patch b/recipes-devtools/go/go/0001-cmd-go-make-
> content-based-hash-generation-less-pedan.patch
> index 6372b78..92e2a1b 100644
> --- a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generati=
on-
> less-pedan.patch
> +++ b/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-
> generation-less-pedan.patch
> @@ -108,7 +108,7 @@ index 8dcf324529f5..617b7ece73f0 100644
>   	}
>=20
>   	// Configuration specific to compiler toolchain.
> -@@ -2838,8 +2840,25 @@ func envList(key, def string) []string {
> +@@ -2839,8 +2841,25 @@ func envList(key, def string) []string {
>   	return args
>   }
>=20
> @@ -135,7 +135,7 @@ index 8dcf324529f5..617b7ece73f0 100644
>   	if cppflags, err =3D buildFlags("CPPFLAGS", "", p.CgoCPPFLAGS,
> checkCompilerFlags); err !=3D nil {
>   		return
>   	}
> -@@ -2855,6 +2874,13 @@ func (b *Builder) CFlags(p *load.Package) (cppfla=
gs,
> cflags, cxxflags, fflags, l
> +@@ -2856,6 +2875,13 @@ func (b *Builder) CFlags(p *load.Package)
> (cppflags, cflags, cxxflags, fflags, l
>   	if ldflags, err =3D buildFlags("LDFLAGS", DefaultCFlags, p.CgoLDFLAGS,
> checkLinkerFlags); err !=3D nil {
>   		return
>   	}
> @@ -149,7 +149,7 @@ index 8dcf324529f5..617b7ece73f0 100644
>=20
>   	return
>   }
> -@@ -2943,7 +2969,7 @@ func (b *Builder) runCgo(ctx context.Context, a
> *Action) error {
> +@@ -2944,7 +2970,7 @@ func (b *Builder) runCgo(ctx context.Context, a
> *Action) error {
>   	cgoExe :=3D base.Tool("cgo")
>   	cgofiles =3D mkAbsFiles(p.Dir, cgofiles)
>=20
> @@ -158,7 +158,7 @@ index 8dcf324529f5..617b7ece73f0 100644
>   	if err !=3D nil {
>   		return err
>   	}
> -@@ -3501,7 +3527,7 @@ func (b *Builder) swigOne(a *Action, file, objdir =
string,
> pcCFLAGS []string, cxx
> +@@ -3502,7 +3528,7 @@ func (b *Builder) swigOne(a *Action, file, objdir =
string,
> pcCFLAGS []string, cxx
>   	p :=3D a.Package
>   	sh :=3D b.Shell(a)
>=20
> diff --git a/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-
> objects.patch b/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-
> objects.patch
> index 59ae99c..2e46e22 100644
> --- a/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patc=
h
> +++ b/recipes-devtools/go/go/0003-ld-add-soname-to-shareable-objects.patc=
h
> @@ -22,7 +22,7 @@ diff --git a/src/cmd/link/internal/ld/lib.go
> b/src/cmd/link/internal/ld/lib.go
>  index 9cbc12919f1d..0f33521777d1 100644
>  --- a/src/cmd/link/internal/ld/lib.go
>  +++ b/src/cmd/link/internal/ld/lib.go
> -@@ -1672,6 +1672,7 @@ func (ctxt *Link) hostlink() {
> +@@ -1680,6 +1680,7 @@ func (ctxt *Link) hostlink() {
>   				argv =3D append(argv, "-Wl,-z,relro")
>   			}
>   			argv =3D append(argv, "-shared")
> @@ -30,7 +30,7 @@ index 9cbc12919f1d..0f33521777d1 100644
>   			if ctxt.HeadType =3D=3D objabi.Hwindows {
>   				argv =3D addASLRargs(argv, *flagAslr)
>   			} else {
> -@@ -1687,6 +1688,7 @@ func (ctxt *Link) hostlink() {
> +@@ -1695,6 +1696,7 @@ func (ctxt *Link) hostlink() {
>   			argv =3D append(argv, "-Wl,-z,relro")
>   		}
>   		argv =3D append(argv, "-shared")
> @@ -38,7 +38,7 @@ index 9cbc12919f1d..0f33521777d1 100644
>   	case BuildModePlugin:
>   		if ctxt.HeadType =3D=3D objabi.Hdarwin {
>   			argv =3D append(argv, "-dynamiclib")
> -@@ -1695,6 +1697,7 @@ func (ctxt *Link) hostlink() {
> +@@ -1703,6 +1705,7 @@ func (ctxt *Link) hostlink() {
>   				argv =3D append(argv, "-Wl,-z,relro")
>   			}
>   			argv =3D append(argv, "-shared")
> diff --git a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-
> default.patch b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-
> by-default.patch
> index 74fd1fa..77b4bed 100644
> --- a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-
> default.patch
> +++ b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-
> default.patch
> @@ -94,7 +94,7 @@ index 617b7ece73f0..46c0712c5bd0 100644
>   	if err :=3D sh.Mkdir(buildAction.Objdir); err !=3D nil {
>   		return nil, err
>   	}
> -@@ -1922,6 +1939,14 @@ func (b *Builder) linkShared(ctx context.Context,=
 a
> *Action) (err error) {
> +@@ -1923,6 +1940,14 @@ func (b *Builder) linkShared(ctx context.Context,=
 a
> *Action) (err error) {
>   		return err
>   	}
>=20
> diff --git a/recipes-devtools/go/go/0007-exec.go-filter-out-build-specifi=
c-paths-
> from-linker-.patch b/recipes-devtools/go/go/0007-exec.go-filter-out-build=
-specific-
> paths-from-linker-.patch
> index 0cc770a..e6a5ce5 100644
> --- a/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths=
-from-
> linker-.patch
> +++ b/recipes-devtools/go/go/0007-exec.go-filter-out-build-specific-paths=
-from-
> linker-.patch
> @@ -18,7 +18,7 @@ diff --git a/src/cmd/go/internal/work/exec.go
> b/src/cmd/go/internal/work/exec.go
>  index 46c0712c5bd0..e7c0459ee4c0 100644
>  --- a/src/cmd/go/internal/work/exec.go
>  +++ b/src/cmd/go/internal/work/exec.go
> -@@ -1597,6 +1597,29 @@ func (b *Builder) linkActionID(a *Action)
> cache.ActionID {
> +@@ -1598,6 +1598,29 @@ func (b *Builder) linkActionID(a *Action)
> cache.ActionID {
>   	return h.Sum()
>   }
>=20
> @@ -48,7 +48,7 @@ index 46c0712c5bd0..e7c0459ee4c0 100644
>   // printLinkerConfig prints the linker config into the hash h,
>   // as part of the computation of a linker-related action ID.
>   func (b *Builder) printLinkerConfig(h io.Writer, p *load.Package) {
> -@@ -1607,7 +1630,7 @@ func (b *Builder) printLinkerConfig(h io.Writer, p
> *load.Package) {
> +@@ -1608,7 +1631,7 @@ func (b *Builder) printLinkerConfig(h io.Writer, p
> *load.Package) {
>   	case "gc":
>   		fmt.Fprintf(h, "link %s %q %s\n", b.toolID("link"), forcedLdflags,
> ldBuildmode)
>   		if p !=3D nil {
> diff --git a/recipes-devtools/go/go/0011-internal-cgrouptest-skip-when-cp=
u.max-is-
> not-availab.patch b/recipes-devtools/go/go/0011-internal-cgrouptest-skip-=
when-
> cpu.max-is-not-availab.patch
> index f13cf78..cf6283b 100644
> --- a/recipes-devtools/go/go/0011-internal-cgrouptest-skip-when-cpu.max-i=
s-not-
> availab.patch
> +++ b/recipes-devtools/go/go/0011-internal-cgrouptest-skip-when-cpu.max-i=
s-not-
> availab.patch
> @@ -21,13 +21,13 @@ Signed-off-by: Khem Raj
> <khem.raj@oss.qualcomm.com>
>   1 file changed, 6 insertions(+)
>=20
>  diff --git a/src/internal/cgrouptest/cgrouptest_linux.go
> b/src/internal/cgrouptest/cgrouptest_linux.go
> -index ad9599c..a4b9b52 100644
> +index ad9599c9..a4b9b52d 100644
>  --- a/src/internal/cgrouptest/cgrouptest_linux.go
>  +++ b/src/internal/cgrouptest/cgrouptest_linux.go
>  @@ -82,6 +82,12 @@ func InCgroupV2(t *testing.T, fn func(*CgroupV2)) {
>   		}
>   	}()
> -
> +
>  +	// cpu.max only exists when the kernel supports CPU bandwidth control
>  +	// (CONFIG_CFS_BANDWIDTH), even if the cpu controller is enabled.
>  +	if _, err :=3D os.Stat(filepath.Join(path, "cpu.max")); err !=3D nil {
> @@ -36,4 +36,4 @@ index ad9599c..a4b9b52 100644
>  +
>   	migrateTo(t, path)
>   	defer migrateTo(t, orig)
> -
> +
> diff --git a/recipes-devtools/go/go_1.27.1.bb b/recipes-devtools/go/go_1.=
27.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go_1.27.1.bb
> rename to recipes-devtools/go/go_1.27.2.bb
> --
> 2.55.0
>=20
>=20
> --
>=20
>=20
> *This email and any attachment contains EasyMile's confidential
> information, and must not be modified or circulated without EasyMile's
> prior written consent. It is intended exclusively for their recipient.s. =
If
> you received this message by mistake, please notify us promptly and
> immediately delete this email and any of its attachments.*
>=20
> *As data
> controller, EasyMile processes personal data, in compliance with the
> European GDPR (EU) 2016/679 of 27 April 2016. To exercise your rights, yo=
u
> can contact EasyMile at privacy@easymile.com, and if necessary, you may
> contact the local competent supervisory authority."*
>=20
> *Cet e-mail et toute
> pi=E8ce jointe contiennent des informations confidentielles d'EasyMile et=
 ne
> doivent pas =EAtre modifi=E9s ou diffus=E9s sans le consentement =E9crit =
pr=E9alable
> d'EasyMile. Ils sont destin=E9s exclusivement =E0 leur destinataire.s. Si=
 vous
> avez re=E7u ce message par erreur, veuillez nous en informer rapidement e=
t
> supprimer imm=E9diatement cet e-mail et toutes ses pi=E8ces jointes.  *
>=20
> *En
> tant que responsable de traitement, EasyMile traite des donn=E9es
> personnelles, conform=E9ment au RGPD europ=E9en (UE) 2016/679 du 27 avril
> 2016.
> Pour exercer vos droits, vous pouvez contacter EasyMile =E0
> privacy@easymile.com <mailto:privacy@easymile.com>, et si n=E9cessaire, v=
ous
> pouvez contacter l'autorit=E9 de contr=F4le locale comp=E9tente.*
