Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7612C3ABC3
	for <webhook@archiver.kernel.org>; Tue, 13 May 2025 14:09:32 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.14])
 by mx.groups.io with SMTP id smtpd.web10.77043.1747145362220708955
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 13 May 2025 07:09:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=Mp+HCTSp;
 spf=pass (domain: axis.com, ip: 52.101.69.14, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/IEQrj1MgkFcb8GOhBvfEjunNrXr0HCa5wrZkdvt5mTENtdo7Ll0+/9Ten0VZaK02O340mxObEhgfi9HTnDloaI+XhF0BDDq0gTNyyCo7ufTvq63M9y5cHt6McRvJLQ2hvGCbm4WQGRqpkZT4PUHYiYy8d9/LgNk5mL184ji/coygQW8io0Lm2LQPDh7ElZ2Kygn4wtCIhPYYjlqnLXFeuWxLzxqI8Da3dVrliiH2aQW+zbuJIya8WNMDd1xbw50RPMGe80zFZQUM4Y3usCluJ02vZvozriyehA2SnK39+WVe9wQYUN2PC3vOqE0VCeo1ImS90t0SA40ZN+hs71DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=firNJuyN5Ub9Ivwcl5r+92gY3l6PUVfJeCfzc4QtSBo=;
 b=UrtwlLncTAmW58LSLA7peqYK7nreGM6vJFwWtOmznRrvm/PtW2Fz0bipBCw5M+ux4oJHeyhZGPc1kNIc/QL0m6k+tlIhzTC3Jyb/rtWAOXeEyAJfXDWFaBDU5WFym4GT6+ZkHyVQfuJS0/3N7jdm7L/NZa07EEQnyDM5Q5ISM1Y95SUFen4oNPLKP2a2jkMYZ7/7LDVGXPWQ7avJoQDwrfr+ES/DtPllTBbmOFXfRjyPdAiRnVuTC1iANUjotrUeAhgp8S4kX60W+bONDH41jYquodfnbzHaYG5vIzxWiSffE8sYD96yIJOoV49OG4QAqYIwqrTGtgiu6sCAxhxuIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=firNJuyN5Ub9Ivwcl5r+92gY3l6PUVfJeCfzc4QtSBo=;
 b=Mp+HCTSpTdmNa6KIqfWlDUwDcrkj4azfCivtrlXY7BAsbbvbNwxopriwU6UyNyvLc0Wdb1NIaIRsZ0cc1aQoUzeTxKV6EmTCFtKnSGjQjgLMrSR90Zf5AclQWwJ2g6OaS61wE6VNR45OHGHoiUJFSpf26qarcqLTflWtEqob0rY=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by PAVPR02MB9988.eurprd02.prod.outlook.com (2603:10a6:102:31f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Tue, 13 May
 2025 14:09:18 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%5]) with mapi id 15.20.8722.024; Tue, 13 May 2025
 14:09:18 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "seebs@seebs.net" <seebs@seebs.net>, "mark.hatle@kernel.crashing.org"
	<mark.hatle@kernel.crashing.org>
Subject: RE: [yocto-patches] [pseudo] [PATCH] pseudo_client: Add support for
 PSEUDO_INCLUDE_PATHS
Thread-Topic: [yocto-patches] [pseudo] [PATCH] pseudo_client: Add support for
 PSEUDO_INCLUDE_PATHS
Thread-Index: AQHbwcNNSUXcSX48iUCBxzy+J2kWQ7PQnUBg
Date: Tue, 13 May 2025 14:09:17 +0000
Message-ID: 
 <DB5PR02MB102139B5B2C45450768FB9150EF96A@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20250510155038.871646-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20250510155038.871646-1-richard.purdie@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|PAVPR02MB9988:EE_
x-ms-office365-filtering-correlation-id: fcc7db1d-179e-4b7e-ae0d-08dd9227c011
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?yXg2ZzEt163dQrq3MEaoB2nnOBOEzZmDj+zeGewakEoH1LXXaTB51ZkvorS6?=
 =?us-ascii?Q?Tk+bVmXUPcEUu0LLIQABqFb9iZuhQCBNITSRrkSLJqnfteOgw1ET4vVNqTFK?=
 =?us-ascii?Q?wNLmUTOb2y+ZBJggR3hD42APtjYwNSR1aZm6zKbsrnrcbcCZBJRKTQXvXjEc?=
 =?us-ascii?Q?pz4vT1SXfcOsTadXzFUirvp/BazoMQ5arZgDthtDVd7YWbXhkO4+N9btuAiK?=
 =?us-ascii?Q?1G5qQlOuoFnu8tniUOSLxzmi4Shx7s/3nuv/CzdDvssx0rCesSgp0EG7LklI?=
 =?us-ascii?Q?gU33NK2eAK7NF8Kx58W36Z8OQ5U1idjESaMInuh9LzRr+h+RVj9hVIlyGfSj?=
 =?us-ascii?Q?JNufARssE/4njn1PE/XmAoiK0IUlf29paxJmoCZWttCV5h+5B4hAICHlitEk?=
 =?us-ascii?Q?fMToPHFU87JEYsfDzN9gYtrAc6ca+qxrWobcLi6h5y5bmyYSbO6gBeAmnCyC?=
 =?us-ascii?Q?bbdvLgx6wqgregRu+gE92ppYmGplhWF3DfIhOVdDkbnWv9XdArTiKOzeFGDA?=
 =?us-ascii?Q?tUOMUeIlPGkRg3RllgaXo5VtgNtHHIA7gZSqXj2aV5wA3GCKXEspObMr4uAj?=
 =?us-ascii?Q?L610I3/+itMnnkAW9teHOQt/hfHL1NdL1n9cGms7Nt7f1oSKI2DrfF1/PVsn?=
 =?us-ascii?Q?JhkrNimaDw1Vve1wIaZv2ynBzN4g6QbxSN5ucMTqMFCOClDo/yybD8p1hqlk?=
 =?us-ascii?Q?BhB97M6LwfQO4c5LeZIXu1PrO85Pnz/puVpBLIS6pNV4joLGtSpaqFOtevJV?=
 =?us-ascii?Q?VIHt3niW/cQu3P4zDHAgUKJTkFjStm4YMkZQEZbHT9qsc51fILfq1sjsP4K8?=
 =?us-ascii?Q?qdg3fJgIFhDoiXVjxkRbsXzXNJWsmnS6IqXHmTJahZHx85BXgSKQTLTVatd4?=
 =?us-ascii?Q?AIjXghTITkfEr2GZWJOuo47rZAy3cnMm+PO1i8GU8x8RoUg48rwI+4zRNjid?=
 =?us-ascii?Q?C5+pEqQ1Xd/TyIKzDNHCEeEMISXZxQUnuVPMSV7gyZ7o9M99FLI0ShiETeMs?=
 =?us-ascii?Q?pa1VBp8PQHqK8JA1KMpgWmmHn7Zul1VbBkuDligbNgQFs2faC1+AGt0+yK5r?=
 =?us-ascii?Q?evoCm4nh950XiET3jTfA6nruaUiIHAYP0BuX62C6WC1mOY9mR5rSVZReKk/T?=
 =?us-ascii?Q?KCJjLRkdPl5RqX/pdpmnWfPGe9j4T3ULYTcfO7IsHbAfR84ulZ6vmebQOwFM?=
 =?us-ascii?Q?aXGNyVoEqj2BU/SfX7+XWjky2IE5wLcy81nCmqh22d3kD93BRaEoegHZ86Zy?=
 =?us-ascii?Q?If/QWbGOXPKOhMAaof5SBdPty1s5vqIn8X8xVO3BSBEDESk3juQH1AaKLOwY?=
 =?us-ascii?Q?4bbGrvCVSclYe7tlWuUOdhd2zUxYdzH9kZut9VHRzxFOl7ENsqy6tZtisBRk?=
 =?us-ascii?Q?GW20u61hhpWoETqg4FN84WBzHykzzU2TvdDwghodcUvlkePAQ1W20CV6IWcK?=
 =?us-ascii?Q?FwHJYus7uv/pOBiiqOOhXHbPnBncQDUFFIEmIEuWjKO8wN6bsQNOyg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?bnZnIFDK3qs2QXeXBpNavFZI9SQX1tpSSnPX3E7C7R6Zq9cSNHxM8NfzSCUY?=
 =?us-ascii?Q?Z0NwZy52LPkimBrV8P6dT3r3TY0CaGrw+TNBCrAOD/cMHQhHKSZcpG0rpXJA?=
 =?us-ascii?Q?VeogFUSffh81DIZYZokAI8hLmlFFyPjGfSPzq28mAdSTvL3nrZVggiyeUHqb?=
 =?us-ascii?Q?ugPmTHnysV78Xnc7BSKKabLpUv2DEhrnvGH1qBE4sDMZCdvxARcEY7N1HLNB?=
 =?us-ascii?Q?P2VY0p/QvD0VmMsdEG/Hf51+PoFy2YdVjUqvSp+tRHKLyB2uMNXBmqzfwdad?=
 =?us-ascii?Q?SNAVTRRZ2Kf1XBzac6KKfmsJT9gKE6kV/LdIdsCFA5rGP6E2X7HkaFp4hOLs?=
 =?us-ascii?Q?EQ9zuuz7R/hbhPsRKkk60q/OJfTQ0KKNXM7zEZdQRnUVGcr+47pxCKVLSbh5?=
 =?us-ascii?Q?F4RKSZm3HD7vLDGnaBiHksV0uXoYdN/Tnmehrv68YxV/KlbEQRQ+wd8icqas?=
 =?us-ascii?Q?VsfJD6onM3B5TxfLM1h4iUPb0YXs+y5uFUYv2+qKpqJNtXGdwOGG2kuAweFN?=
 =?us-ascii?Q?PK+4v5v5vezhS2CZv8ItrZXzH3VkeBI3E/JFGj48G+ti5jRu9e183kKIpmvY?=
 =?us-ascii?Q?Vkqjg7QYcSDi1sxI3aXnzvnu6rTnFo3HoNDg0eqRGp/6KdWc/gzUYmQm1O5v?=
 =?us-ascii?Q?sKlNbQF7tAcPcVgBFMdM1/rWpmkqgxbDqVZldGZ8kz18SMuc+UvowoOOQViF?=
 =?us-ascii?Q?fLSzWcsHv9J512IZzoROwAFbJGdSxUq+d1kDwdRGcz6rIUa8HamkSF71LWC1?=
 =?us-ascii?Q?dRhbtr8beJDY6xbsIcJ2DYJLFyHa7+6KeTfUK5qfvlYWcdZjwLiuuHaWbW7R?=
 =?us-ascii?Q?RhbIgpWvV2Jxb3yHkJOMOMqt8KS9IXfx1paydrCGq+VRljuH3Fmy/LPPsH5e?=
 =?us-ascii?Q?TCIX/hcrV5+IokIfTduuSsdiH9W1ImdRRIPv9N4Wx9RDUwF5GkNe1JvWAi9T?=
 =?us-ascii?Q?L1XvNUlGLhTlkGmBSqNzbBPiyMPijOktRgLK2WFytEdZJXBhKzlwYArp23Wz?=
 =?us-ascii?Q?XPhUi8RDmXvpMG398qsrRV9DNngU1C5V9W1qyfrKEWlrwYpWZwNIW1C3SEzD?=
 =?us-ascii?Q?rbiJ+NluVH2JXvliurYLIKzgMpAUbZzHsJNATV1jmeFgLw6HcGd/vE4lX+96?=
 =?us-ascii?Q?BwuP0B7v2/h0qMi4W2faFY4cpY85C7yM5SQ5UkCW5AEsgYJSmTuAqj2EqW0e?=
 =?us-ascii?Q?Tu5ZbDzKBxVNUwsupMFHfObRBsOsyOt6azyFTz1fOY4xFJYzETJ/5D8pq2ny?=
 =?us-ascii?Q?sZ2pzftLI7Pn0bcc3UPEGwHZtHKxU4asMuPalUVcbPShJMArXvS+EgxlhTQQ?=
 =?us-ascii?Q?UnlRlcoYs0Fr5KK8Uc1XE4Pjet6aAkhxy+CPitoT4+bKhD0SH6Y3EJQkZKSQ?=
 =?us-ascii?Q?bNm/mV4i3hZZz/NdGbifFFoFldULKji/IquARXxuoldlWDBI3zW603LmyPUg?=
 =?us-ascii?Q?qV9Sg1UwWtK6pq+7KxrBzsI5p91cEdp4HAHm2CwcptyGfQP3s89NOUDFydRk?=
 =?us-ascii?Q?0+y9c+srROwDGMrSepuKQMeSKf7UTxPVX9cQbqb3Qcfyf+LuKqk9fyhQ+dYd?=
 =?us-ascii?Q?LAbHebcpdDu0qDCLN1k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc7db1d-179e-4b7e-ae0d-08dd9227c011
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 14:09:17.9804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RvMiI4u5C3pGRKIJwaD89grU+O2/+YUeH2HXPbV/CgoWpuiOErY3By9XlHJmbc2D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9988
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 13 May 2025 14:09:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1549

> -----Original Message-----
> From: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproj=
ect.org> On Behalf Of Richard Purdie via lists.yoctoproject.org
> Sent: den 10 maj 2025 17:51
> To: yocto-patches@lists.yoctoproject.org
> Cc: seebs@seebs.net; mark.hatle@kernel.crashing.org
> Subject: [yocto-patches] [pseudo] [PATCH] pseudo_client: Add support for =
PSEUDO_INCLUDE_PATHS
>=20
> We've often wondered if things would be better with a path include
> list instead of an exclusion list. Add support for this so we can
> test that theory
>=20
> If set the include path takes precedence over the ignore path list.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  pseudo_client.c | 22 ++++++++++++++++++++++
>  pseudo_util.c   |  1 +
>  2 files changed, 23 insertions(+)
>=20
> diff --git a/pseudo_client.c b/pseudo_client.c
> index 9fd68b5..8a07341 100644
> --- a/pseudo_client.c
> +++ b/pseudo_client.c
> @@ -1566,6 +1566,28 @@ int pseudo_client_ignore_path_chroot(const char *p=
ath, int ignore_chroot) {
>  	if (ignore_chroot && pseudo_chroot && strncmp(path, pseudo_chroot, pseu=
do_chroot_len) =3D=3D 0)
>  		return 0;
>=20
> +	env =3D pseudo_get_value("PSEUDO_INCLUDE_PATHS");
> +	if (env) {
> +		char *p =3D env;
> +		if (*path =3D=3D '\0') {
> +			free(env);
> +			return 0;
> +		}
> +		while (p) {
> +			char *next =3D strchr(p, ',');
> +			if (next)
> +				*next++ =3D '\0';
> +			if (*p && !strncmp(path, p, strlen(p))) {
> +				free(env);
> +				return 0;
> +			}
> +			p =3D next;
> +		}
> +		pseudo_debug(PDBGF_PATH | PDBGF_VERBOSE, "ignoring path: '%s'\n", path=
);
> +		free(env);
> +		return 1;
> +        }

Wrong indentation (spaces instead of a tab) on the line above.

> +
>  	env =3D pseudo_get_value("PSEUDO_IGNORE_PATHS");
>  	if (!env)
>  		return 0;
> diff --git a/pseudo_util.c b/pseudo_util.c
> index aa989cb..a94a4da 100644
> --- a/pseudo_util.c
> +++ b/pseudo_util.c
> @@ -43,6 +43,7 @@ static struct pseudo_variables pseudo_env[] =3D {
>  	{ "PSEUDO_BINDIR", 13, NULL },
>  	{ "PSEUDO_LIBDIR", 13, NULL },
>  	{ "PSEUDO_LOCALSTATEDIR", 20, NULL },
> +	{ "PSEUDO_INCLUDE_PATHS", 20, NULL },
>  	{ "PSEUDO_IGNORE_PATHS", 19, NULL },
>  	{ "PSEUDO_PASSWD", 13, NULL },
>  	{ "PSEUDO_CHROOT", 13, NULL },

//Peter


