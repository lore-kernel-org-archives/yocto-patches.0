Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17771D5B16C
	for <webhook@archiver.kernel.org>; Sun, 14 Dec 2025 18:47:09 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30998.1765738026647254474
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 14 Dec 2025 10:47:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mZOrNKoX;
 spf=pass (domain: siemens.com, ip: 52.101.69.47, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ae8F508icdGDN9ovZIAbyPp6TsBiSp5IKqX1o815WB8ejxJdpMK8b8lyKDSFr5FFVtbC7Zdi0ryR79C8SD7IZjicUuxTOvmP03nbMVREaDPxFKOMn7mEv39JfoxBQOzN0Gud4W3iYlJDRPy32CrSzHU2cboiTlLIP/0tf4hjoHAqnVyvzx2BhzuAJxo3dCzbnKIi4l8PKcZm9CPmOQz4URklK3HDAnRqvWzCdRkl6BzjjBBgLivAOjIqEQDym+bopm3Sigw0iaAvolsX7u4elkUL+m9ltwt547JcQ1rtE88qz+DTTKplD3f8j4yGoxfUJjz2Rrqk8O6buwbobSaRvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iV7wHQeA5scwTsTOY2KOxQH/8PU28NQnqUJwTztYXGQ=;
 b=Vxw5UwOFIpNcQxp22o5A/YwH8Hz+oKrAZPR01NftK+EOMvzEv5KyTW2Bns4E/NJE+PuOTLWKaaA0skbjVnaUKrXAGJMRwwPiaAmZYJM4Ylwm4HsXRdOFZrG4/hWceUvF0qkzJhTxXgc8W1CDdLozzO1pTfde1AE2QHQPLcMqwI4SHwLuoXq9sZqdLtPmcEwSpNFqLC5MhKfzKOn/wuBT359tnzDnUpvtRD4sRUOqEKCGFS9pMRJ1SGnYjdSPqlxb+imrAPD4Z+G2W8kN5YqlzJw4U2ps4nJVPwHhv0xQCMKKplOn0w9UuGahdfm7AuKm9I2XK6YcttF2H4FIB01ReQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iV7wHQeA5scwTsTOY2KOxQH/8PU28NQnqUJwTztYXGQ=;
 b=mZOrNKoXqVRHKGVPGBxSMo7J+4zsqyuiJpSKwxQmVD6hjfFu/SupOyVvQ3bkS2NRc1DNOLPrt9DG64VYzmSIorCCm1BeRoe2xaO4czCFxarntjLeNB5b6ErP8Ot8+8iubscrff+UjMqIuUL12JJ5g9NIqjYA4Bliyf3QAFwj0ToOzbHAjeXQeDJAOk6ydqxHneFXZZ3R00ax1QFdp0WsBj2UloKIjNm4jJPkMK3uc/pxIUnVUuA07sK8j4QZq9NfWVDYHaTDi2a4BhjntGjqzuYD4aC/h/tSQ3qZJ9a4sprr2OIXIYNn8TQ0REk6wj8HrzWnF3yE+J7cJrl/ciUHmQ==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by AS4PR10MB6039.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:576::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Sun, 14 Dec
 2025 18:47:01 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7%6]) with mapi id 15.20.9412.011; Sun, 14 Dec 2025
 18:47:01 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [meta-lts-mixins][kirkstone/go][PATCH] go: upgrade 1.25.4 ->
 1.25.5
Thread-Topic: [meta-lts-mixins][kirkstone/go][PATCH] go: upgrade 1.25.4 ->
 1.25.5
Thread-Index: AQHcahVcBt0+Rz3AyUCY7dBuyipBO7Uhf8rg
Date: Sun, 14 Dec 2025 18:47:00 +0000
Message-ID: 
 <AS1PR10MB56974700619AB437EA70C7A3FDACA@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20251210204125.10132-1-peter.marko@siemens.com>
In-Reply-To: <20251210204125.10132-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=49eaf8ee-654a-4dc8-849a-5f3d292da8e5;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-12-14T18:46:37Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|AS4PR10MB6039:EE_
x-ms-office365-filtering-correlation-id: 97cee612-18e5-4ee6-90b0-08de3b412ae2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?3ku7BZpLL7d7KU4lLfFenLU6K5RW8g3ruSb1E2S5o2nYD73wKxc+vhZSYPQm?=
 =?us-ascii?Q?EXDebgsPFyQKcTf9pM8wBXCQ7cOXJts8CwlnGpyhuq3h5xajWeii8L0xDp32?=
 =?us-ascii?Q?VDxW/BW+JXyMwetccOYd5KTlYaFtanr5ewLTgGcWvm1eVLcC0VxOD9TyVEIk?=
 =?us-ascii?Q?R/RP3mW111dA+bOjum9A4y3+3nG5/twWL5vqlo3TcYxysgeKw2tRDL9SH2OM?=
 =?us-ascii?Q?UE6kx+gtaa2ztOaN7ToEuLvc9I3kdIBoduu8KEggpSTfk/uVkOlqNBOjpa0+?=
 =?us-ascii?Q?7I7Z1MlbnyPNM7fQezzNCHHpLHbjRtXgjRbnoct/eszlsOuEbx+sfOtoSuSa?=
 =?us-ascii?Q?cjAIEFa/24PaHT0XYM066tzzJyjFhDB2kbH061255YOhgzyuGgrmWbcOjMQ+?=
 =?us-ascii?Q?v5ACztoDDy+ZtpJDcMmjSFObwVWYHtzrnlsVs6FezFdMeSWBVOhmLF8qOMKs?=
 =?us-ascii?Q?iTOSTErqcMGbFSr84vJr8hcYBtIAYA7F7CRGevUk2qnx3YHgkJFQfiyjDetD?=
 =?us-ascii?Q?Ksh68FtvMnkakBI+s2H5XcEfUtrar9xsz/fS68O505C9jWVfT5AbEIVJQis4?=
 =?us-ascii?Q?O8nVDeDPsvS2r33UoFnk2GXZ0t9VyduWMjbQwSuqMkNF3OztBPhG3v7scNqI?=
 =?us-ascii?Q?7RIsb2RIFv9g/xtNLkq7CvMNWuiZFTmx2+ie/qpzwvatsU+40JN9r82RzBvN?=
 =?us-ascii?Q?epNvfh3zSKwufnrtrPrjD6/Xj3FI3s6mtz353blrjLnlgHUTYT4XpwtLaUQy?=
 =?us-ascii?Q?m7Iy3w+9CnDd+EoqK34rT0GPgOjaAxo4EQlz5VUdpnsK4WPMRm7+Oe/N3Ukp?=
 =?us-ascii?Q?5N0W9LWM20i4Iey26tvQXf904AGoXOINU8Tx/Q+cMTXF/aOQcbpE3w3FoRLV?=
 =?us-ascii?Q?nbNqtxNTw+RzW1heLuEkYHasR92M5CcPlK8uxsDHEkAfAlc6p19A5cFjqC3Z?=
 =?us-ascii?Q?lQzM1lnuTUkDm5cFOIjzpzRpLuMzjLMdhFCKmLXK9PCx5ve9N97hlOgEt70g?=
 =?us-ascii?Q?pm+/G85V/NqyfWy0H03n1+izkbiBCzk3WXjm867Gs8eWqcjgQ1bH/6d9u2uU?=
 =?us-ascii?Q?fDzUO27VLfzpx5o4qTt2qkw23ao7YyEbQjc7NlclDiSKOYgfTEem+8u7Ykxu?=
 =?us-ascii?Q?I3Nzrzo+/0eesqMlJQ2ie0KRjIEzYlwh4zg1LjFUYtjY/VdvYvMV8xCSRNjC?=
 =?us-ascii?Q?tjEEJ9cdcWytQHO7zRztJRzqjb9e96Qu4FUZONPJZAhqAHy8nq1xc0Ur9H2e?=
 =?us-ascii?Q?3hPSXcclzRcN7ChPjr1cGc4OZpE0q4iau4NjDuAr4/h37vi/UdUIvZZPcBdJ?=
 =?us-ascii?Q?Eq+VH0xdl8TaX+S4SXcHJzA1urlC0JAMPMU/zGq7HCVXoO7El8YTEV/aFwSr?=
 =?us-ascii?Q?HQrSIovs6J9Nl0td+VlCG1y8t9HbPdmRIibUOGRQ440huobfY+7a6hFXAwx6?=
 =?us-ascii?Q?uCkiZXnbuC8A3FzaU8npPh/EsDbgClMM511XLvmz8gyxbBHx4FQ9+mv/Qrqq?=
 =?us-ascii?Q?notC0wOoqE2g+UoactPdG7ZUwyBLuOhtWgIa?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?0wkKE42Qru/NiIA584AuZuYbTt/D1QmBaJ1IpVwA9f/hsSAHiJdLsbJoCj0X?=
 =?us-ascii?Q?Uh2Fm78K0r4Gf5nRzEY4JZwdkTQSj/32WizYxVUQYmQeCFvZEO3O3YhHKqzz?=
 =?us-ascii?Q?N2DwE7tcmUwAXl48RxO58vTrIZlCBkiYhp53ZSE7BQTxTcPJ9QB1Tbh6IHH/?=
 =?us-ascii?Q?UZRozYEOqcUBLp5I7/mJF2/PWu/MV7W+AlnDZFZnJuvrp3DNty7q3cCTT2Ti?=
 =?us-ascii?Q?+ccMxSVxVuAJr+IkMpL7myb7mM794pJyHqRCi7dRGDbhpqs7L9+r8N6l7CZf?=
 =?us-ascii?Q?agl8wOb/X5Nt2zhQe/jFGA862oddJOAXcLNvL+SyS4W2xEKxI/2BrkZilWhU?=
 =?us-ascii?Q?CG7rRnEGw+6RD/QoEPXaIYJpCEt3xo2M0vhv1jvsVwnM02XuBMlhuagNJbyp?=
 =?us-ascii?Q?Jtyi7elZ223NV90sVQwIHWS4xRSCVYJSbsrXpwDcGuvJMsK/fmLp1btli9Ch?=
 =?us-ascii?Q?m9RqZs1v6zIKpghLwtFW2VSv/2nUaLmC9XNNUGTKsjV/i2cbCYQp7d2BSgjl?=
 =?us-ascii?Q?g58gf6GvM0/2LiNZQYJZkk+KLHzxCOkXzuOokLcoR0pzC+9qOJuBAvqQ+VPl?=
 =?us-ascii?Q?x6pn+Y9ZQcMBqekbl0u/5svLti20kp0ZIBOk+pdtCO6+lVs8TvLPmMRqBDwm?=
 =?us-ascii?Q?obTo9GYhf+QmVMPOH7oQC/eHfKO7U9Xb6lJljD/ykX8aPPlUmMDQ0wrJGlXy?=
 =?us-ascii?Q?TSjQABa5DrvC73va8R6jQLycJv/tTLak506iw6qav60BmZ+mm275lYRQlCIq?=
 =?us-ascii?Q?oxZLyxAnU+PWrW3gL4WBTonSwv6dldrwUP4367oxAWB+QuenGXSpWisPCDUH?=
 =?us-ascii?Q?zPht9UV94t+2X+IJA6JkaU8KQDCR4RNBKd8e1nW/VetANEDeyV2LYjhvvEd/?=
 =?us-ascii?Q?VD77U+zrb5pN5fwoihFOcoVbBYpIrILCua5HFkE/5+6+t8Ex21Z7pBOxYfp/?=
 =?us-ascii?Q?KWARh5ZyazPr5wkxO19dpXWZDma7hmx2s8ijdL+mfzoxuJbJpV9mBA9BFsU4?=
 =?us-ascii?Q?xsxJlzg0gElFy5tJrDbiQ5lyl2rj7El+o6VliXo9RuIIVr1lyauEHeimV7zc?=
 =?us-ascii?Q?c9uCcnflL7wIXnmZshnDXce3RqTyrjDkbN6rNR/nhw5W/OQ2zBYqiuke4WrP?=
 =?us-ascii?Q?kL82bns2+IdHKzg0e1aiSUtkLtutgKJ98AubbJXXymQ2l739xyeTGDRNDGBS?=
 =?us-ascii?Q?fSuS54v7s6A8S+CiU1vXHgkoGWsHRsYC5IkMl+EoPUcxgZCEM0ahsk6jLDvv?=
 =?us-ascii?Q?pwdFJDHCBYjem1rQtQdWkd2pd4ZyGbhI60byGSqoWEgOpe11xKzoukKCItqv?=
 =?us-ascii?Q?vMjAmXtJ4tlzeXZyyuU7sfnFILbzd4W/5PdeMmrM7c9n0th0fNo4/AJFcCC0?=
 =?us-ascii?Q?vl260epU0MOklUZMrlbHpqwV8OnTH55JVzAIPrVBm91tRGUit4yXV9ekGlmK?=
 =?us-ascii?Q?vrxNV9z8Uymiwtm+8HhwpY88oHK08YplEjnHyyroS/nbClUNosuyZLN1VnJi?=
 =?us-ascii?Q?vj4HkoZue3DZbT9gJ3vq8oZBtvjPqFHCsL7/rT0A8sDLtIRbezlwgjTzUxt+?=
 =?us-ascii?Q?1TSpLgAB2bG/Pm87+tL2/Jy0m6DIlE5qaRH7AK3q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cee612-18e5-4ee6-90b0-08de3b412ae2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2025 18:47:01.1098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wsYj9HEt38yGQ9KP/iiaRS/ZGB8Bosjp/FKrkFPpIJjFRY+/8V7wDAj6OkTaS+J8zRQ6+LpFWCIVXSB+lJXvuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6039
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 14 Dec 2025 18:47:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2782

merged

-----Original Message-----
From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>=20
Sent: Wednesday, December 10, 2025 21:41
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io; Marko, Peter (FT D EU SK BFS1) <Peter.Marko=
@siemens.com>
Subject: [meta-lts-mixins][kirkstone/go][PATCH] go: upgrade 1.25.4 -> 1.25.=
5

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.25.x release [1]:

$ git --no-pager log --oneline go1.25.4..go1.25.5
fefb02adf4 (tag: go1.25.5) [release-branch.go1.25] go1.25.5
f7bce4bd6f [release-branch.go1.25] crypto/x509: prevent HostnameError.Error=
() from consuming excessive resource
287017aceb [release-branch.go1.25] crypto/x509: excluded subdomain constrai=
nts preclude wildcard SANs
e1ce1bfa7f [release-branch.go1.25] mime: parse media types that contain bra=
ces
433c01e94e [release-branch.go1.25] internal/syscall/windows: fix ReOpenFile=
 sentinel error value

Fixes CVE-2025-61729 and CVE-2025-61727.

Release information: [2]

[1] https://github.com/golang/go/compare/go1.25.4...go1.25.5
[2] https://groups.google.com/g/golang-announce/c/8FJoBkPddm4

(From OE-Core rev: 91c007b0f5fff728cc7803a56a4df8438f20bdea)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 recipes-devtools/go/{go-1.25.4.inc =3D> go-1.25.5.inc}        | 2 +-
 ...o-binary-native_1.25.4.bb =3D> go-binary-native_1.25.5.bb} | 6 +++---
 ...cross-canadian_1.25.4.bb =3D> go-cross-canadian_1.25.5.bb} | 0
 .../go/{go-cross_1.25.4.bb =3D> go-cross_1.25.5.bb}           | 0
 .../go/{go-crosssdk_1.25.4.bb =3D> go-crosssdk_1.25.5.bb}     | 0
 .../go/{go-runtime_1.25.4.bb =3D> go-runtime_1.25.5.bb}       | 0
 recipes-devtools/go/{go_1.25.4.bb =3D> go_1.25.5.bb}          | 0
 7 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-devtools/go/{go-1.25.4.inc =3D> go-1.25.5.inc} (91%)
 rename recipes-devtools/go/{go-binary-native_1.25.4.bb =3D> go-binary-nati=
ve_1.25.5.bb} (79%)
 rename recipes-devtools/go/{go-cross-canadian_1.25.4.bb =3D> go-cross-cana=
dian_1.25.5.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.25.4.bb =3D> go-cross_1.25.5.bb} (1=
00%)
 rename recipes-devtools/go/{go-crosssdk_1.25.4.bb =3D> go-crosssdk_1.25.5.=
bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.25.4.bb =3D> go-runtime_1.25.5.bb=
} (100%)
 rename recipes-devtools/go/{go_1.25.4.bb =3D> go_1.25.5.bb} (100%)

diff --git a/recipes-devtools/go/go-1.25.4.inc b/recipes-devtools/go/go-1.2=
5.5.inc
similarity index 91%
rename from recipes-devtools/go/go-1.25.4.inc
rename to recipes-devtools/go/go-1.25.5.inc
index f88d7fe..47d5c39 100644
--- a/recipes-devtools/go/go-1.25.4.inc
+++ b/recipes-devtools/go/go-1.25.5.inc
@@ -18,4 +18,4 @@ SRC_URI +=3D "\
     file://0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch=
 \
     file://0001-runtime-when-using-cgo-on-386-call-C-sigaction-funct.patch=
 \
 "
-SRC_URI[main.sha256sum] =3D "160043b7f17b6d60b50369436917fda8d5034640ba39a=
e2431c6b95a889cc98c"
+SRC_URI[main.sha256sum] =3D "22a5fd0a91efcd28a1b0537106b9959b2804b61f59c37=
58b51e8e5429c1a954f"
diff --git a/recipes-devtools/go/go-binary-native_1.25.4.bb b/recipes-devto=
ols/go/go-binary-native_1.25.5.bb
similarity index 79%
rename from recipes-devtools/go/go-binary-native_1.25.4.bb
rename to recipes-devtools/go/go-binary-native_1.25.5.bb
index 997c4bd..94de9ce 100644
--- a/recipes-devtools/go/go-binary-native_1.25.4.bb
+++ b/recipes-devtools/go/go-binary-native_1.25.5.bb
@@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
=20
 # Checksums available at https://go.dev/dl/
 SRC_URI =3D "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH=
}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] =3D "9fa5ffeda4170de60f67f3aa0f824e42642=
1ba724c21e133c1e35d6159ca1bec"
-SRC_URI[go_linux_arm64.sha256sum] =3D "a68e86d4b72c2c2fecf7dfed667680b6c2a=
071221bbdb6913cf83ce3f80d9ff0"
-SRC_URI[go_linux_ppc64le.sha256sum] =3D "38c8ac8463537c99fbc1ef368f243b626=
144446c09db71b1d20634a4237c966d"
+SRC_URI[go_linux_amd64.sha256sum] =3D "9e9b755d63b36acf30c12a9a3fc37924371=
4c1c6d3dd72861da637f336ebb35b"
+SRC_URI[go_linux_arm64.sha256sum] =3D "b00b694903d126c588c378e72d354554993=
5d3982635ba3f7a964c9fa23fe3b9"
+SRC_URI[go_linux_ppc64le.sha256sum] =3D "f0904b647b5b8561efc5d48bb59a34f2b=
7996afab83ccd41c93b1aeb2c0067e4"
=20
 UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.25.4.bb b/recipes-devt=
ools/go/go-cross-canadian_1.25.5.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.25.4.bb
rename to recipes-devtools/go/go-cross-canadian_1.25.5.bb
diff --git a/recipes-devtools/go/go-cross_1.25.4.bb b/recipes-devtools/go/g=
o-cross_1.25.5.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.25.4.bb
rename to recipes-devtools/go/go-cross_1.25.5.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.25.4.bb b/recipes-devtools/g=
o/go-crosssdk_1.25.5.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.25.4.bb
rename to recipes-devtools/go/go-crosssdk_1.25.5.bb
diff --git a/recipes-devtools/go/go-runtime_1.25.4.bb b/recipes-devtools/go=
/go-runtime_1.25.5.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.25.4.bb
rename to recipes-devtools/go/go-runtime_1.25.5.bb
diff --git a/recipes-devtools/go/go_1.25.4.bb b/recipes-devtools/go/go_1.25=
.5.bb
similarity index 100%
rename from recipes-devtools/go/go_1.25.4.bb
rename to recipes-devtools/go/go_1.25.5.bb

