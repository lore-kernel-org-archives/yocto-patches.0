Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A16FF8855
	for <webhook@archiver.kernel.org>; Wed,  6 May 2026 12:52:55 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.30])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17531.1778071973354228297
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 06 May 2026 05:52:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Rx3+7M+f;
 spf=pass (domain: siemens.com, ip: 40.107.130.30, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GiWCzqKU8uKTEvUK8frSiuRUPPT5hegPiGB5X0pzNhY90jB6IDk33z5MSMRqEW1X/XMIiDWUuY1GH0jSxDZm/wLoszZDrtRwe4/pCZZSRpD0ZvOvCA27uRXoTU0Q0vL0sGGv2DMkcuPTRvuY3nAa+sS3eYLz91tV8pBS4+tOtncQT+KS/hKMBVH8YW/4LbnN/t9d6lCyRS1IrvAr7Cschm2pDJgOzwUCW908gcGsRI9Ug8BvkQ2uFFnLtgwe/YM61sRIkk+4x2Z7oG9bWTk2sr1DSANwqeVUaRl7aHiXORwaPf+A/fwLDnPu0QzfY7KoXI80qyJXdVYs9OUW/V50HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baXjEG+ReEJaYx8uMtrGDSYs6AKR6AI/KchNkviXhqg=;
 b=qqn9P4HgDCU6Gk2StLOI98tWymz/931rUT05xvwzZehA3NpLNdXYs2RJpzc4Ll4olTDC3IfThkvRjnBfe172WKFDTtr6+oRd7X3FVnv2caUoD5vrKShaATcYqiP1/pRsUcyyRgHxmV+/FZjAEW1dma6h1kllNBBGTZuhDTSOf712+L9Sj6TF65U10bBRTvOQ7/M8V9LZQ2A+SMIJ820ZOa5OzBoXkZBp6PGB0wpL5djEK9mciT72GAbVdWIzICKJZVUGg64f9W7XKDlbrl5bKNpJm/h8TWlKJ8rb2s96SLb8QCWRV/T0LE+1GdgGc6wmQyAPSqk+QcVjfNvpcogLrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baXjEG+ReEJaYx8uMtrGDSYs6AKR6AI/KchNkviXhqg=;
 b=Rx3+7M+fue/0j69amnxPhUDoIkHqIRRlxVfvcnkNfauBfZuAqlB1DuiGs4X6ezHMfBDxM6yGEBGBKScAhhN/vh25m7lJjmpdpMC4KYnSpqHeWm2ZgkOQVsQj63pCRdnWSshSJ52pssMLhCwA6rox/j+HBSSw6/cisutm9Ph2ST16b7iw2y7iaxX0RyiQvHxKC3hubRVlcWeZmD8G/eaZVthbv01ZW6Uy4iFeXod9V50/kMITPYi2Lf2BzLPEQfo1orr794xPOqnM+RE/EM+LJVK4J5U9GArdKYQ2541HHbHTvgM6VnuqBafGUByAqO7DoTzpE45fz61wE0lS+CMBew==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by GV1PR10MB8536.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 12:52:46 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 12:52:46 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [meta-security][PATCH] tpm2-pkcs11: upgrade 1.9.1 -> 1.9.2
Thread-Topic: [meta-security][PATCH] tpm2-pkcs11: upgrade 1.9.1 -> 1.9.2
Thread-Index: AQHc3JlymdZgIBR7QUWsXo+YNSmviLYA9Q6w
Date: Wed, 6 May 2026 12:52:46 +0000
Message-ID: 
 <AS1PR10MB5697A7A56FEB041F6A5FC929FD3F2@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20260505141353.3142456-1-peter.marko@siemens.com>
In-Reply-To: <20260505141353.3142456-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=efcfa980-ea3a-484e-8b7f-6785d6c79628;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-05-06T12:51:59Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|GV1PR10MB8536:EE_
x-ms-office365-filtering-correlation-id: be2da94f-d227-4321-4fa3-08deab6e5f64
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|38070700021|56012099003|22082099003|18002099003|12006099003;
x-microsoft-antispam-message-info: 
 95dLq8jHnpwxafnc0UN+sOlGp1+wRUkeSY11neUVucQBxcfkRN+CxeweVspf4Tq6l7VSYfpzWjSonBR5p6IL5rPS7hT12ZO21k80v9JJPEfIzAcyFRSAd4tNBNJXcxIgQnVJXNx9+1UuLomsIivRCA2aEZk8EsrHL1uBFUGH0G0q+W9igHuLomKhweIVqmrw4ou8Fi3EmCX/tjBWYhZdXLqfIYOftlNbN60R3FMQyGXJpzi1O7rzQ1Dp/fX1ylTjZGOnD7vzuFKbeJHkNjCj8noDYewjtqpcj/OxZk1tSDf7KWBhyEVBXSZK0KxzlB5VD765M5lVYXnBBB4k60dt3/ey/iOlP7wdjRMOlaYfrIPZvpoMDbeunzWQJUyxYIlWXenEZcvQFjl+7smD6Q7ZYce/0pLzTG4odeyab9M7GOtxT21jhOujQkWnj7kkKmLObH+NvV7HmqZCEYs9ChsY+716FfDUuBnDBW5bpiXwb8sXx0lLNJre6NRcXsWQ31kUEb/uzGqogI9OCf8np4mw9t3e7/0yy46qCGdBSZW7P0LRAcM7hwARwFQ+IAqyBzGn9JW9AER6p0fv/28nce0jPciy5R2VE0dTRB5blpo4DA7DoHKgpXaK3AbCcCNLvJ70/q9GKlzxiUgoIFB4jP1HXE2RKP7bABvCXhz4mfzn8qks+KGyrWT9wp4Cck8cGU1Jv1s5b3bnEb4eRdDzYRz6XIQyA5heXEDm8XZ2V4VYYUAJgZdy3gXAnivr0utNmMYq
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(38070700021)(56012099003)(22082099003)(18002099003)(12006099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?39SETGLO/bY6SPzB+Un/pFojHRWsH1960RRovvORwwVXEoRohcvz+VC3La17?=
 =?us-ascii?Q?wOUN3r1CfbkIiPxhW+azpPQsX5bf29Q9evlKS5e//0/rYEIB2MVQaH36vLq/?=
 =?us-ascii?Q?mjzLCznL52Liz+matZIWJQJzoswolrafkd3U9gvCCoEGSpUseIlNXEKBuIH9?=
 =?us-ascii?Q?0pUAcnYR01Lmf/zCpk1YtXMFRuHqTS3zQLS+AZFEoig5vIjnP1EUxeVIoTC7?=
 =?us-ascii?Q?baIvaUfhWmtCbhAYKA7+tGBW4H5f1DMjf+q7EAq8aDJvtrOoTDvsM0Fe46BF?=
 =?us-ascii?Q?6VJIHYiRuVrMN69jOCSycD4jfmkYUZP716GffNL9fXtXvbUvPH/ksmfS4H8Q?=
 =?us-ascii?Q?mViLRGejmav93ecwUqQyWm+YcmqPZpB/2R5dWouO6dtzR3Bb0sH6EjaZL87W?=
 =?us-ascii?Q?ZipZ7A7C8Cehh4ye1y6eJ4ESaGpQs34Dha3GDNXgE+yQDbRqoqcP0FFXo+4M?=
 =?us-ascii?Q?J2i+6pgyHAoUXygLojEsF4Z/9BydkzxznlIfIQuyhQ7bwtrWc222/b4luGDo?=
 =?us-ascii?Q?rOXgDMtaZA9YRJUVUPqUuVElY8iDh0SGclvihvhWcOXS4BN0poZs0DPXpHOk?=
 =?us-ascii?Q?BTi47DKyzFolxvvCDC+TYSoUJyCjuQofMkzZZwtFjwNM0c9rD2oh3FVsBIJY?=
 =?us-ascii?Q?OZPgBCgcaokMoycehV+LOkwB50ihNoIxxchK8JO+kNAjGK/qlD2vF3hX5Wq2?=
 =?us-ascii?Q?MJBGUCyVFpzNpE69dBjs6Y4ZtQSk9cbbmvgU/9kYxk4CDi9xKBn0bKjwUlJA?=
 =?us-ascii?Q?2YBQ43YDSGQlB04qZCAk1gl92v9hTL92LmWcQ+5gAAcVztfaj2+Nsl7+e4tj?=
 =?us-ascii?Q?Q7d+KNwoyKLbNPQz/NxMA61Mv1/FpmC0ydUzwtET4UvYh28hDR2NnD4sf8aB?=
 =?us-ascii?Q?HkH5W8UCT2ho6RGytxL7I31jtSBTH5T4dq7RV7Z9Jw4Usr44p6syAV6Jmz4u?=
 =?us-ascii?Q?M55ldtLEi3CxeyBUBVy2dhvC41me0+3kji86o7BBnJauTwGMejjLQiMz1VLk?=
 =?us-ascii?Q?SieDWMCnjtAxxCjgUbTG/BibwmFCSzt/P3cdoWVCi2YACJZ2qvnINsQXW0wJ?=
 =?us-ascii?Q?UUKXpzaQFNq4CuSxipItrLtSpPwLU5VMBCTbypL62eehpUr4SrolUgx4KMc7?=
 =?us-ascii?Q?vH/lH7cTHZU0mVHXNOtTtb5Vwkfk2cFTFPY4MfW3uaeuPv7L/1Q79fnZxZV5?=
 =?us-ascii?Q?+MNkA2Q7/BFNPMDAinRP4cu3L9CuolSYLEumbLyLeDtzX5scbed2ka45RWTi?=
 =?us-ascii?Q?wEeutTOrfSSJNoOjJwmZetTIiCofVyr5+9fbS+EzAif7FuTf7zNbnLTM8zeq?=
 =?us-ascii?Q?vfMig5Yi8+nHfmNAU7J94H87TX1VLbWxnb7D43rFTncdqCL7Bu7GMLAz1tOT?=
 =?us-ascii?Q?UwXThxfghA022sAqErJF2cN124IeJ0ydIewPX0eEkR92pPJuxq/pbCKNLlAH?=
 =?us-ascii?Q?77RE1JlHEeMPFC/6AlnaYPh7THMS/PQYzUr0blWsWpLHNDssss1QQ6paCRLv?=
 =?us-ascii?Q?XYJeQIRb/rIJKQsj9liwPLruTmt7K7rnLa9sTU6XHYjPJ9PL1ss8skeYe8V8?=
 =?us-ascii?Q?s6Pg8noaIahoSy6ejTN8VxHAjdPFLYz4yLlv+5veY9IaJerJhPn5GKW9/3pP?=
 =?us-ascii?Q?DWn/Nl2IYsU5EfoHekQsvSx4mzlQHPkVWjfiV6z2AmvmbBjGJOXfRPhkUX/Q?=
 =?us-ascii?Q?5aZzbQxlO9AW89ckacHaDzzZeyLOl58yjzSF296oRcDDdwgRWZwfoHw3LrXb?=
 =?us-ascii?Q?wPjDpN5jiA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: be2da94f-d227-4321-4fa3-08deab6e5f64
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 12:52:46.8240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vO2tskaphtppHsYPWWYDU3pGR+sIGKkeYlT4dgOyxRmiHkurmtT202j4F3Swtfl8BkUdWuzfLpirS9Ml/UelcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8536
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 06 May 2026 12:52:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3921

This is also needed for wrynose, please pick it there, too.

Thank you,
  Peter

> -----Original Message-----
> From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Sent: Tuesday, May 5, 2026 4:14 PM
> To: yocto-patches@lists.yoctoproject.org
> Cc: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Subject: [meta-security][PATCH] tpm2-pkcs11: upgrade 1.9.1 -> 1.9.2
>=20
> From: Peter Marko <peter.marko@siemens.com>
>=20
> This contains fix for building native recipe with security flags
> enabled:
> * https://github.com/tpm2-software/tpm2-
> pkcs11/commit/be97b21ae641303ce83a8fbb54002701c1aede31
>=20
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> ---
>  .../tpm2-pkcs11/{tpm2-pkcs11_1.9.1.bb =3D> tpm2-pkcs11_1.9.2.bb}  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename meta-tpm/recipes-tpm2/tpm2-pkcs11/{tpm2-pkcs11_1.9.1.bb =3D> tpm2=
-
> pkcs11_1.9.2.bb} (95%)
>=20
> diff --git a/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb b/met=
a-
> tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.2.bb
> similarity index 95%
> rename from meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb
> rename to meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.2.bb
> index 762b82f..3d04e5b 100644
> --- a/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb
> +++ b/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.2.bb
> @@ -9,7 +9,7 @@ DEPENDS =3D "autoconf-archive pkgconfig sqlite3 openssl
> libtss2-dev tpm2-tools lib
>  SRC_URI =3D "https://github.com/tpm2-
> software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz"
>  SRC_URI +=3D "file://0001-src-lib-tpm-return-NULL-for-twist-on-auth-fail=
ure.patch"
>=20
> -SRC_URI[sha256sum] =3D
> "ce24aa5ec2471545576e892b6f64fd873a424371bbf9be4ca3a0e689ea11c9b7"
> +SRC_URI[sha256sum] =3D
> "1bdabdaed6a5fa4ce8a1e82307f4612c30e30b0a0415e1bc7d9c30f713227480"
>=20
>  UPSTREAM_CHECK_URI =3D "https://github.com/tpm2-software/${BPN}/releases=
"
>=20

