Return-Path: <ehsan@emami.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849F2CA5FED
	for <webhook@archiver.kernel.org>; Tue,  6 Oct 2026 16:03:30 +0000 (UTC)
Received: from PAUP264CU001.outbound.protection.outlook.com (PAUP264CU001.outbound.protection.outlook.com [40.107.160.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.49249.1791302601456562465
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 06 Oct 2026 09:03:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@emami.net header.s=selector1 header.b=tznqRGXG;
 spf=pass (domain: emami.net, ip: 40.107.160.134, mailfrom: ehsan@emami.net)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIoTwg8/JYm+0pNUjlS4KV/LtpZJJI5ryy7wrXMtm+bP8ARyLYp+r1+bQepQMP2/94dfvIH7jViV+1P3K0kKR/bvR7K7hQU6QMZM/yHj4bSgUBoDUgBDkhjQogO19jCYl7BTRIZNBS2REr8PgYo5SAG9oiFm79geI37Te8WdgH+ph9Rp3M6w+KPuUTsflFUQCqR+Y2tHYWcA2Pq5tdAYusn7km9j6i+YnTrKa9HZuas1fZqh2mzsZ3kIN/r12R8IR2p4Z6d98Tqh47zJBeLnuZiNS4tqV32Tfx2W51gDYVtAFCQlMwR5sglT1YiZy4SvQLqgDJ6nmycHe1MwrgHH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NlzMsYiyr8fem+D/Vxg8mcg1HC3neKRclYeDnSr8xY=;
 b=L6S1vB6kodLM3wc0ElxRPP3x9R0A7B+VGU/GhXRW1GThBfUhVSGnfjN47I8gvCXpub4TITjzCB6fjyBvTyoS0v+eNS4GlavyupKX9LDWde88qSiIR5ZafurFomtGLISCFqZqoS2A6zQUjZtbBfh308x6QPSGahx8FzGkSXXt17+hLfXJ5cdD3ixDcBVFUT7E5Aj0Ek5kOf5S1aGYeLF5sNzqFJBBcnQw6DmgEHlo5EAiqAQOvAWJT2Se9k/wgtA3Pt7K2ixdJl63xU+673VTPXad6Z84K5Gzr1RSibr3XZcwLSdDW6HOmdzrRUFRlsQIIVjtU5gD7mfeyXsYvMElxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emami.net; dmarc=pass action=none header.from=emami.net;
 dkim=pass header.d=emami.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emami.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NlzMsYiyr8fem+D/Vxg8mcg1HC3neKRclYeDnSr8xY=;
 b=tznqRGXGq69hzcGPHlvi8/Jhb4Sz86t9v3jQgXiTS+eXrgHgZ5EDNZDnMyE/yX8ezKU8QRo49tA1kV6NjvmR9mNA04Rw6WZYoWAebhV/lYgQ89pHE0/hNEzBuQ6hW6k+WQ3D98j3cJx5t6vLpnA/FBhdlAc1JBcPaZavqXPrGUD2tj1qz0noQAgygk0dGyim9X8VwgvqG87c/eZduhB73/33SK/2OiU94ZicdT/9oeGdyVEc+2nciL338TRiVQzh/62A4g76M2JPN+O4/GHoij4NthETI5UkfJLWppPzE1HOq1GJM3uLvCKt1R1lYD44r8AKzXMVLlzwF+HRkWsKmQ==
Received: from PAZP264MB2960.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e6::22)
 by PATP264MB4577.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:42a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 16:03:16 +0000
Received: from PAZP264MB2960.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8a9:7624:3a37:6da]) by PAZP264MB2960.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8a9:7624:3a37:6da%4]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 16:03:16 +0000
From: Ehsan Emami <ehsan@emami.net>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: Re: [meta-security][PATCH] swtpm: inherit useradd
Thread-Topic: [meta-security][PATCH] swtpm: inherit useradd
Thread-Index: AQHdVartMkzj9qZuJ0eNQUBj6+b5SLbwrQGA
Date: Tue, 6 Oct 2026 16:03:16 +0000
Message-ID: <002EC865-B05F-4FC8-BFED-3D541947DE27@emami.net>
References: <1C882C13-9FFC-4A2A-9F90-8708E040FA19@e2technologies.com>
In-Reply-To: <1C882C13-9FFC-4A2A-9F90-8708E040FA19@e2technologies.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=emami.net;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAZP264MB2960:EE_|PATP264MB4577:EE_
x-ms-office365-filtering-correlation-id: 122a23b7-50ea-4157-1dab-08df23c35510
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|10070799003|23010399003|1800799024|10067099003|3023799007|56012099006|6133799003|8096899003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 
 iw4cpAL/hp4Dj5mBV0fL4zf6OlZnM2G0ONIVzRYUEZkLNJX2q+i6q1h4OAEpz5UgFn8DyMocKJzVCXMNqTyVlxfNWySmRAHLZZ1taKOOytOxcmGWgFncF7kFD064sBv2DtLlqQtFGvh51W9H0AX1EWBGOvYpaEz72ii6y9DhgqvjOBbMKyH3CNwnZ1GMXbmJycyG8dxVzsi3ecaYeKXnPnx4j6YY0K0IHjgRyxjqCQ/YW9nvOd6fojk+eJ9CRTk7nGK/B0B0Wt7IIYmzBXsPqwq0/X9K5B6ik0R5uDuzMhiqW4Ttlvy01SD+c7pQpNmLs6wub3V4xsfT5MBfo9v3zaGagEHGc1xTPcqgHVsEYJ2QG1oX5q+sN0rnEv9fakbuGKy72bQNfUUnjikwcbnFh3dhrc7+sUSIB/Ed0BkoaQlmn7/dRtEyJIFGu90oL8efd5M6g7Oblf4JfBBu/oSL5Xok6+ZE0/Gtuu4S4N8tgHlRKyTtWESBhchOoehABeRRRrznz29YaFtjcnAOaRsYVR2Ilazmg9cRVRd1+Dvs+yksgH4nFMXdY2SF4bxm8e0s7Qc0eqZJP7folCpl0p3U74dY7u6eaBPuWBsDgiQX9/x3ClJOIxT6JKigxL9q/Wn7zCK8GyN17VJM2ITrkE8C0CMsP6/lga/JL0ab3D9BpK5u6Xmf09avK4Y7I8Cv5Omwqq9R079SzOr/8ShE4WsNIhZHGOFnlBk7OCizldz7Yi8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAZP264MB2960.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(3023799007)(56012099006)(6133799003)(8096899003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?XZQX2XBbqqlzuNi7RDiUo4OyMtCUE2JkNuYSnwwwv3td05IwM3b+uPDOMgcd?=
 =?us-ascii?Q?a+su2j4CxI1AKfJ0z2IGhL9qdLA00iui8iEnnDsXvggA1lMHVa/Q1wH1cuXQ?=
 =?us-ascii?Q?9bf2PCjTwnDVNHtzPwyOj9kYnXs5cac60KqiZ96wg8wTYbdNeZo788SfsnQT?=
 =?us-ascii?Q?6HC+HkggeEOgHEjyYb9XGUkQ0ROwApZVdTLvhi4tpdOHHZkY+gR2WObAuDom?=
 =?us-ascii?Q?3vhAfjK7/eCIJkxi4g5JlU1T4z1dzpA2eahjQJ5fVjbJ+0vDvWHhTXEGFH4M?=
 =?us-ascii?Q?7qPtwLlgmUigGwtYlCV3ZThtpuAXJmguz5ll9Wb6gwYDDeWl1/GjH0LEOfrb?=
 =?us-ascii?Q?3E9J7/JZRs/0gpRJb+swfvVQDZMHHHHwD+m0BZBwjWQl5rSHs3bPed+DMClS?=
 =?us-ascii?Q?fm80osY0AfEgD6QJnxdppOaUDRit5zfX2ezDy8FZQlpl6eUzk1NNhoyKfN1m?=
 =?us-ascii?Q?V+H7Yq6zB7ZbOnWx/fdORstZhFAi5AiTKaii27Es4yp67wMXLApkA5zVeDO4?=
 =?us-ascii?Q?LNB3r02/YtJ525cG7G4w3czptOqjrByby50rjR1orp0bh1vexrsuQKTcg59D?=
 =?us-ascii?Q?IVUU/Ui9GERYBpXiRlhNKfMT48BZGhP5niCVZoAs4l3fy6DYx5rXuWeCt231?=
 =?us-ascii?Q?soXpn8l5yas6C2U2xaCBbkcfx55EZ+oMBpIj7P7CwG0vnn0Sajiwxli+RojG?=
 =?us-ascii?Q?z/S82tlKdWJE2qVjfV+6tiqREpaba+5Gk+gBw3TmoDvRzibc7FGhorGpHN5k?=
 =?us-ascii?Q?2mZpxpyKXSgSJFw95knYj0zln5eo2fEQQvTZvoAxwWxSdtwOCvEfnPd3cQwf?=
 =?us-ascii?Q?Dr1zT8O4RjwgkNXUNviV6imAatDavdCvqRrPA/PDd3+mEi/mskUb/kxPaRqO?=
 =?us-ascii?Q?73or6E6+sRm8K3LyoTLRMhZk1wgQvx18kRWaejkT9mJtIYbs4oVYxomWDDKM?=
 =?us-ascii?Q?6LaNK2mXGTkL7h2eXZ3lE46PkDVWM5SAHVEwGmrvvDxMDpteuGt3lq4lZ5HO?=
 =?us-ascii?Q?ZjLjy/wvHNHqnGglAH3xI2T6wyku4TX3/F7u+dctDdXoFuHGsj3yIcaxNbKr?=
 =?us-ascii?Q?WvRZO9KyV34wkH2Mi8XxeGsVWpU0kmRLck4dSxfB0uEnhOmQnpacgq4iJvlN?=
 =?us-ascii?Q?t2D57AnVgcr1DaeV2/2nIhedGCKCwpVRUoHmAHnIOMykDtuNicqbDhWTQDz1?=
 =?us-ascii?Q?DXamp3xG+7bcUvFcisZingcH+xbSCImt+SM6bk/KdyPDsb5aDWYTOLTR+mDY?=
 =?us-ascii?Q?j5YWZevID8x8aQQeB+d7DyD4GuAM3jZYgjb3y6cA1oSZtbYSOnUxE+NhFUPQ?=
 =?us-ascii?Q?Pu3weVtnrL/yp4P183Mxvi+aO22JmT53EYKkjwWwlJd11yzIAlbBe6iUWX6s?=
 =?us-ascii?Q?HZZwLOfkKNfnF7OymShmDYKY+LknxdhiE43Hn8PSYPfHg4fnxWjKGbr9kPSA?=
 =?us-ascii?Q?PyitcHjXe0lQq43Q1q97w7Ym8A10/mLJPpu2seboIIkqRlkM5r6gFZSuq4KP?=
 =?us-ascii?Q?St6H8chyemBJgrK6s0u8zZjiqn7A3kb3RHvczkLrQls7r27s8Zn3IAv2rHP3?=
 =?us-ascii?Q?V7RcJ00tLaWSB5Vaw+ShUi9hgAYYc+8PMrT4j+L3nDYWx/L71EYfUAogVVdg?=
 =?us-ascii?Q?E/Yx9o+NhMwvixfmjBWOCtMUK+Gr29oovZQtHQ/nJIuA/H4EKDWktSv9HSYD?=
 =?us-ascii?Q?5pobUfzgWh1k0nFB0T4tH2KIcB8d+D6J+O792pYm/l/JuOTYji4kLmZwOIgQ?=
 =?us-ascii?Q?tDyORwzMvkiFUxfMI9VFxYZssw0kghlbdd97UupUyV8MPeImqrtPPIqh65hG?=
x-ms-exchange-antispam-messagedata-1: Ah7Xhest86H0Lg==
Content-Type: multipart/alternative;
	boundary="_000_002EC865B05F4FC8BFED3D541947DE27emaminet_"
MIME-Version: 1.0
X-OriginatorOrg: emami.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB2960.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 122a23b7-50ea-4157-1dab-08df23c35510
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 16:03:16.2328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b2077de5-a9ba-4ff3-a70c-f84ca16e8199
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /PSUArwhzI5bys7DmsHe0W8brDR3N9z56rWFhXk20XVo97ROwjkL3h4971ACT10Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB4577
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 06 Oct 2026 16:03:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4993

--_000_002EC865B05F4FC8BFED3D541947DE27emaminet_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello meta-security maintainers,

This is a one-line fix for the swtpm recipe in meta-tpm.

Problem. The swtpm recipe declares the user and group it needs (USERADD_PAC=
KAGES, USERADD_PARAM, GROUPADD_PARAM), but it never inherits the useradd cl=
ass. Without that class, BitBake ignores those variables. The swtpm user an=
d the tss group are therefore never created on the target. Any service that=
 starts swtpm with --runas swtpm (or with User=3Dswtpm in a systemd unit) f=
ails at startup.

How we found it. We build a Yocto image against meta-security commit 270397=
4d (swtpm 0.10.0). The swtpm account is missing from /etc/passwd on the tar=
get. It appears as soon as a bbappend adds inherit useradd. The recipe on m=
aster (6824bd7) has the same problem.

Fix. Add useradd to the recipe's inherit line.

---
 meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb b/meta-tpm/recipes-=
tpm/swtpm/swtpm_0.10.0.bb
index 8472f02..8488d01 100644
--- a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
+++ b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
@@ -12,7 +12,7 @@ SRC_URI =3D "git://github.com/stefanberger/swtpm.git;bran=
ch=3Dstable-0.10;protocol=3Dh
 PE =3D "2"

 PARALLEL_MAKE =3D ""
-inherit autotools pkgconfig perlnative
+inherit autotools pkgconfig perlnative useradd

 TSS_USER =3D "tss"
 TSS_GROUP =3D "tss"
--
2.43.0

Thank you for reviewing it.

Ehsan Emami
E2 Technologies

--_000_002EC865B05F4FC8BFED3D541947DE27emaminet_
Content-Type: text/html; charset="us-ascii"
Content-ID: <C5F08D3A13224249B098C3CC5F48DC76@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable

<html aria-label=3D"message body">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; line-br=
eak: after-white-space;">
<p>Hello meta-security maintainers,</p>
<p>This is a one-line fix for the swtpm recipe in meta-tpm.</p>
<p><b>Problem.</b>&nbsp;The swtpm recipe declares the user and group it nee=
ds (USERADD_PACKAGES, USERADD_PARAM, GROUPADD_PARAM), but it never inherits=
 the&nbsp;<code>useradd</code>&nbsp;class. Without that class, BitBake igno=
res those variables. The&nbsp;<code>swtpm</code>&nbsp;user
 and the&nbsp;<code>tss</code>&nbsp;group are therefore never created on th=
e target. Any service that starts swtpm with&nbsp;<code>--runas swtpm</code=
>&nbsp;(or with&nbsp;<code>User=3Dswtpm</code>&nbsp;in a systemd unit) fail=
s at startup.</p>
<p><b>How we found it.</b>&nbsp;We build a Yocto image against meta-securit=
y commit 2703974d (swtpm 0.10.0). The&nbsp;<code>swtpm</code>&nbsp;account =
is missing from&nbsp;<code>/etc/passwd</code>&nbsp;on the target. It appear=
s as soon as a bbappend adds&nbsp;<code>inherit useradd</code>.
 The recipe on master (6824bd7) has the same problem.</p>
<p><b>Fix.</b>&nbsp;Add&nbsp;<code>useradd</code>&nbsp;to the recipe's&nbsp=
;<code>inherit</code>&nbsp;line.</p>
<pre>---
 meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb b/meta-tpm/recipes-=
tpm/swtpm/swtpm_0.10.0.bb
index 8472f02..8488d01 100644
--- a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
+++ b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
@@ -12,7 +12,7 @@ SRC_URI =3D &quot;<a href=3D"git://github.com/stefanberge=
r/swtpm.git;branch=3Dstable-0.10;protocol=3Dh">git://github.com/stefanberge=
r/swtpm.git;branch=3Dstable-0.10;protocol=3Dh</a>
 PE =3D &quot;2&quot;
=20
 PARALLEL_MAKE =3D &quot;&quot;
-inherit autotools pkgconfig perlnative
+inherit autotools pkgconfig perlnative useradd
=20
 TSS_USER =3D &quot;tss&quot;
 TSS_GROUP =3D &quot;tss&quot;
--=20
2.43.0</pre>
<p>Thank you for reviewing it.</p>
<p>Ehsan Emami<br>
E2 Technologies</p>
</body>
</html>

--_000_002EC865B05F4FC8BFED3D541947DE27emaminet_--

