Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C07C88E5C
	for <webhook@archiver.kernel.org>; Sun, 13 Sep 2026 16:42:40 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2350.1789317755831943795
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 13 Sep 2026 09:42:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=I2EPk2QJ;
 spf=pass (domain: siemens.com, ip: 52.101.69.6, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYxIXnJ1pLi+do7A/4C/h5lPFbdONTWH8xljZ9lHrzXkV6Ha+qsTokq7+YQbWfqraa2N07a9Ss9RJ/97rBsW0pvd3SvuY+VUS9F3L3bKn/nz6s+ocKCPpHEw6Sigxbaeng0B1CqWmBZdqRDtOHPMWSAq8m1BezIwVF1DfddjDMLNXI0lsyCAlPNknA4MAgjEDLSPprn98hZ8lN0NFz4ZN/PKXlymk63Va/D7YUwI6T3zAwoLH1mehjsmIc6cPkeDRC00foyGihk+LpW07POGNJNA/FcsWwcrIoH9jn+m33RxH9N9D/FghuyVc362hL/L3ZzPu/H3zGDbtxFgVxBhIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wtZ8BspyRviSQ2gpgh7HiVLnEeHIUKPz6M5u7+DQhU=;
 b=nGbBtM+aeF0LHEE4YlYjZ2ABV6vukcc3p9/lChE2t6D0w0zwJJ7Z2r0EfklWVMYShGcCWV3ibkVl4rNYoDcnVe9d4KI4JguK12tVTGui+ssWXA+j0ShRs+MtfZZUm7bsNAVoqqClFWpu5NYzdFhD8evdatsbn6liIsDudOzdeQJXfbUxtwaXiASlqem4He+e5ZLR7bk/KUGh7/KhuLgFf8pieBAGKfGBhgxtV51HZf4whHxzferxls/CVTWvOBCqDHKzoX8s4sXm19MPMUVFiGpnTmRRIh/R1m3tmnFnZzpugYY/jSjc5XaVerPc6rJjKeP78BZCwPN2O1+TyNJjmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wtZ8BspyRviSQ2gpgh7HiVLnEeHIUKPz6M5u7+DQhU=;
 b=I2EPk2QJwElBptmbtTWW57e6JG3XV++YZHyfU4tp2vIiqGsO27lWy8r5/EJ3OE6cmvpqy4jKTcg6gdUSH50iM5lvAVNhujkFePc86oidXs6zbuuLkQjnoWytNkU9+o1y++sPLQHbVepja802TsmUHigwtt29u6ao20yDLmHcCbiZLygJLQoSy1/xPuT5SlvJwWC5KNS4Riv2e4I5T/x7bwo3YBa0a0+OyGHc8ZyTBAU3pqbjr1Fg3r1CsoQ/1lpgiEn63JgeEwzSUvUklKOPHvB9WkpxkEd4fsQraDXRUSTNYQxzGIVzXtp4cu9BlTC4jkFaFOG9lfz5utj9+yajOQ==
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:420::16)
 by AM4PR10MB9477.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Sun, 13 Sep
 2026 16:42:31 +0000
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008]) by AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008%4]) with mapi id 15.21.0406.007; Sun, 13 Sep 2026
 16:42:31 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, Scott Murray
	<scott.murray@konsulko.com>
Subject: RE: [meta-security][wrynose][PATCH 1/2] tpm2-tools: set status for
 CVE-2017-7524 and CVE-2024-29039
Thread-Topic: [meta-security][wrynose][PATCH 1/2] tpm2-tools: set status for
 CVE-2017-7524 and CVE-2024-29039
Thread-Index: AQHdGTCIiv+fBpq+30qgU70oqs/+3rbNCynQ
Date: Sun, 13 Sep 2026 16:42:31 +0000
Message-ID: 
 <AS8PR10MB507351E265141452DAE68DEFFDBC2@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
References: <20260721164643.39248-1-peter.marko@siemens.com>
In-Reply-To: <20260721164643.39248-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=aad381e8-1708-4833-80b6-19f93b9959f4;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-09-13T16:41:48Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB5073:EE_|AM4PR10MB9477:EE_
x-ms-office365-filtering-correlation-id: fb2619de-eb37-4475-e7c9-08df11b60177
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|6133799003|55112099003|18002099003|22082099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: 
 AhTAlnhbyBKYLKIBbUzwAO6soDjWsA9HhJZ7DmIP8+gnS569fXPg+LfwLse+YVQSijxVoKf2PgDSNYP213ETk/w3zVNJWMFISyiwZdDSRHlH1zqbpTfob/9xbBdCT5T8gxQFYuQ/o+ptZfsrpbL9OeHtAX1dSDJLI2jDZBEqL1jIxypPY/0mej2J0FC7EQk8EMzVUVNZZL8g2Sv9DjtdacfLyx3szwjBrZa3IoL4Q5GUhbyl2uQVPkbmy8fyDhBHzgmnnqnIP+4s/2htdcRfbAl1dipZlrU7KZ0Wiz5Za3lqiuMHpOSy7Kss7oBYDtk6ImEU4L3B8f1ZhyauKjiQXGarvKhm9gaO4tY1Mx8e1u/aBsw30UlHgCniAoXqMMVdl8zM2xKzSeEamiA7dcm1CfX7NQpbDp2GEP/c4aOmm2DKcmrWER0Znjw/jhtOOZOV63pohT4zEDc2JL/9qn0goF1uRPM5HciR6PvM3nQTMWvKDG3r0ObSLWZrtqpYEeT23j77UzI5svRTa2V3p6fMHM3toMGoRtg36RXd0GPoQxN3c+jBisy4ZSPUMp7Ns3++yr2L0RU8hgdgfyOt4KPnFjuljHK+FDoRdd2Wafomj/Kjr5mH1z+NdXByvm74b6mLtxqXurEbSB6n/jrFSmJvgOcpuq1+sJ3hD4bGXalhUFizCBAjYQH5dSp+tdSBMmBER6MbJogFMFb+TeMk6bKVFEQXU+n4/5aaVBg+Exuv/Ws=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(6133799003)(55112099003)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?BPQxfocIGT4XWFkSing9gVRpw3GQXOnrKXW3eATqG0WX/sbFC+j8ECm1VDls?=
 =?us-ascii?Q?SPVqKOvigu0DClYvU71haaie2niNZ4siXd4Zf2pjWDp2egXuF+FRKofVWOqJ?=
 =?us-ascii?Q?Hd9awOP2SkxdC165UFKPDKFAHdAzWnaK6/1lKfYH7kpmhm0G8OXtrf70BQJZ?=
 =?us-ascii?Q?WTfoHKg7XJdSn14XxoI2nDpYftXwWisMVO/XvQFIYPYDxUYz+11mHV/+isSz?=
 =?us-ascii?Q?s57zldkcMbQe79HZNqNMnRpVky5nn3We+hmXvtTdx7dviJDc8lmhUJXGAjuE?=
 =?us-ascii?Q?o+oWcK3+MhZ/6zwg8D/RGSnNVjsfjH0w5uToGWiwvo7rV1JA6ubU6Y4sMa3a?=
 =?us-ascii?Q?UGuwfAM8G2m1ZGh5BAa7EC9AceHJEhCxBAfOnJA2Kyy5oiR/HLsdfrnV7Yph?=
 =?us-ascii?Q?gCwA7EelOo1JuYZhX2DxxfI7lt7buazfBM0+r0uqWtp25F66rWnp/SD7Hfkm?=
 =?us-ascii?Q?tgKEo52x3VkvB2bjK1ZQo0F/5irgAYy77GJj3fk63O0EAGVzgg4jEU4MD/cc?=
 =?us-ascii?Q?LB+9+4RKSkbuPcR05FBAfAPwa+qzhKxj2NSwcM15XMgpkCFxhIFVmCUyzr8H?=
 =?us-ascii?Q?r2KdQpBlmd4Y4VeY2JWP4BE7z+ZPCe8WC9UlCVAuXPu0bnGku3+igvc+dUPW?=
 =?us-ascii?Q?QLBqEmER4mOjVSuFsB2jfmy1vJ2/fTisxyR4J0+p6GQwyff+XNYXB3hR/Z3e?=
 =?us-ascii?Q?Z5KNPvTzNQel3T6iJkxXkyzPjLkg7TPVAPLjJoFy9MPXb1DhpNcrXix2DyR3?=
 =?us-ascii?Q?xhfDCoLEGCHhzMDnxXrvj2DrALUPqhBi1dq55S1Nyjf1EUzrOAtmMvtkXhxV?=
 =?us-ascii?Q?pnxC4QhrS4bVcYBm4/3iikXtkbYMOOxiXwB7gGDW0MTbkU1zg1AR5YObX0qQ?=
 =?us-ascii?Q?Y9XAEHQmlMmJt9OBA3VvteiDc2C50SzSag2QU1hKKUaWFDD/qh8qCrdeoQap?=
 =?us-ascii?Q?0mENi67sMensvUXP+o9j+Tc13PGu+BILeEQ3L+dKcc+3XbNIWsbpSEompwib?=
 =?us-ascii?Q?v9zShfkDWvzUW2brjLvi3m9nlgW5KmFciAJIuX3VeTv21Yz2H1IfGpc4KC4N?=
 =?us-ascii?Q?4Nroe80w4al/eplVE//ltMvmD2TL3cy6kCsBs1yGPm0tko5pnjYKfCfm2EL5?=
 =?us-ascii?Q?Hlyyb69jElHbqM99s+6rXkqrv+itpajPWUYzRD1aQKYeCB/aNokXT5wJg/x3?=
 =?us-ascii?Q?BgmMMQ+7+n7kLqPXstKWBHY+YRcqj2kwm5xmorJqLU9Q7Di1tHjakbbdi25E?=
 =?us-ascii?Q?Ahb4y9/zY5kW0401SvMqVbgCdBYfvAJA9WWc3U20cWSCZ6jl/88HE7hb+Uw9?=
 =?us-ascii?Q?5BUz8gWloxK+vbx+XPS+xEUaYAmNpu6zuEUzbrZCpRSjA2YvZp3E8NyLI4sV?=
 =?us-ascii?Q?ATQTxW+GMuCZTj8iyw5qMiiRCn4CMjZgBwVYl+7ztYT42FUY2Q7umj+sc9J9?=
 =?us-ascii?Q?v1tOprquAuAbXV7ptrBC4vVieXfzHBwx24T/9WY7Ldx5sNXrrQW07fslALI5?=
 =?us-ascii?Q?8ctjg7XxZ2n2m8hBy8tVTMfEnlP7yTugPduGgwWHdQMbHCT8rRkYa8Da6eIf?=
 =?us-ascii?Q?5+xK2zmxKFV8svhTajXo/IuoBzK13J0qBFS6mXltqU50Th+QWL4LRUUVpU5G?=
 =?us-ascii?Q?6BSIfDPTlH1EqeEZS4lu6cFcaeI4M4Vn+vnkK04cVM5sTc+WLadIttmWp1w7?=
 =?us-ascii?Q?ywdkLV+U9+QouWa/fjhtv1TCgsqHUm8lptjPRnoPgzR2bYDD9pz6VKCYd2/L?=
 =?us-ascii?Q?2b8gFnCqqQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2619de-eb37-4475-e7c9-08df11b60177
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2026 16:42:31.5651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SYsewM/TD/H6kxTnIhf5oKIQyiCyk0QE52M77j7T7a4AU+0qPGcq/fGhvuuVdvEbIgTXiAItsqlFWxL+Hk/E7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR10MB9477
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 13 Sep 2026 16:42:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4825

Gentle ping for updating wrynose branch

> -----Original Message-----
> From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Sent: Tuesday, July 21, 2026 6:47 PM
> To: yocto-patches@lists.yoctoproject.org
> Cc: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Subject: [meta-security][wrynose][PATCH 1/2] tpm2-tools: set status for C=
VE-2017-
> 7524 and CVE-2024-29039
>=20
> From: Peter Marko <peter.marko@siemens.com>
>=20
> CVE-2017-7524 is a historical CVE and new cve-check does not undestand
> fixed version data. Debian report [1] shows fix commit which can be
> linked to release information.
>=20
> CVE-2024-29039 is per Debian report [2] fixed in 5.7.
>=20
> [1] https://security-tracker.debian.org/tracker/CVE-2017-7524
> [2] https://security-tracker.debian.org/tracker/CVE-2024-29039
>=20
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> ---
>  meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb b/meta-tp=
m/recipes-
> tpm2/tpm2-tools/tpm2-tools_5.7.bb
> index e1a0c5d..c06115b 100644
> --- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
> +++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
> @@ -18,3 +18,6 @@ PACKAGECONGIG ??=3D "efivar"
>  PACKAGECONFIG[efivar] =3D "--with-efivar,--without-efivar,efivar"
>=20
>  BBCLASSEXTEND =3D "native nativesdk"
> +
> +CVE_STATUS[CVE-2017-7524] =3D "fixed-version: Fixed since version 3.0.0"
> +CVE_STATUS[CVE-2024-29039] =3D "fixed-version: Fixed since version 5.7"

