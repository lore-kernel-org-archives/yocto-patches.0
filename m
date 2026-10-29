Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.1])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1374.1793300311656013346
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 29 Oct 2026 11:58:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fYmFXR0l;
 spf=pass (domain: siemens.com, ip: 52.101.66.1, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ey7edQU6/pQZEt8vSnvg89thorIVhjLXusNE6yz5oi7hyuLsNcvd98sL+qJwBF67zyXC5x/5qBtzDQkSnhf8OWMfKQb0GMg6TyDMuSJGE6QmKsT9TdAnCbnyPA/azHhVWfT/fMbRmvcSyBV66zUQlr362HX2JfAlooxUayFoTsYoSt1Trgc1y8eVTvrHoEbZT30Bp2rCcPPs/maYms24DywK+hdwEnqzDqznV0+bjQV2P/gqd3E2HHw8vZvkFObjy18ISLIy/8NiKMlmn+guqAnwTIxwjGsPS2O0AVWrpejELnza1QFDjBkyxtoQtN/E8+ti5AXnoefjv//4H3FSxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUBc5qND3YBLW6S5S+qX7aauscNvZLZLxVRcCjABmXk=;
 b=C/dXtb0tHRo7K/ahVLa0AzStSZuEZnLFNtZ0XG+pdxKmc5vdh8trNsCI2mNHS+8JYVxz/QguswX4ufQa8xnqTNuVfguzMoaK8aYo4LqABLb+LUEVSMPOnvHg9MwPOv2h56xo3ZIj6+rWmQCRkKAC7c5hYWgKrgz3cRszLcXFUiDXZNngE+HEFTQr+NgqMPyWROoixMeDqu/BVsNjqos6lcgCM0TclCeKuUG0nISvkm8ZBrBP30cQQPzyrh8grysZY+x+mz2c2CQk/tdSjp8UpQr8z1NFHLRRiUN4y1fbKbwufTBYLOMFcNoqG48MwPmHzmtVj/A89wXEv8p8jFOiIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUBc5qND3YBLW6S5S+qX7aauscNvZLZLxVRcCjABmXk=;
 b=fYmFXR0lsAocGZsQfXk9SFpKPSWqXj3XmlvbLxl1rI6oTm4PirBYs/bdDyNxIjjSC1cEPMTM3kLhbxvdQ0+FGb8y+6bBLOlHdvNKcXtSRaSzPerB+yUgZl/wptk1b7hb0xk0VJyEtWFrDSseT/GYfb/ir/dQcdY9OkH3bfPeVQEWUaa8XCz0Mx6ezQfRvJuPe+rGG2QzYrLq5e98N0b3de7P11PLoSdLfRDAA/htEuN797nA3i63J+QkY+8jm6glehu1uuJffyw38hngKU+saMuo4n88G3aOYKFKd/Fs+6YUsWpqoqsCHko2F9g8w80FVLeKQ72Dq7cHF+91aiXcVw==
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:420::16)
 by AM0PR10MB3170.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:180::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.4; Thu, 29 Oct
 2026 18:58:27 +0000
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008]) by AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008%6]) with mapi id 15.21.0592.003; Thu, 29 Oct 2026
 18:58:27 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: Richard Purdie <richard.purdie@linuxfoundation.org>, Paul Barker
	<paul@pbarker.dev>, Ross Burton <ross.burton@arm.com>
Subject: RE: [yocto-metrics][PATCH] patch-status: add blacksail
Thread-Topic: [yocto-metrics][PATCH] patch-status: add blacksail
Thread-Index: AQHdYnSKa/6F17pvAEqNeNFL/EdeDLcU6acg
Date: Thu, 29 Oct 2026 18:58:26 +0000
Message-ID: <AS8PR10MB50739292AD7EA1C46276411BFD6E2@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
References: <20261022222715.3775519-1-peter.marko@siemens.com>
In-Reply-To: <20261022222715.3775519-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=4903bca4-06df-4951-a48a-22005dec6855;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-10-29T18:57:02Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB5073:EE_|AM0PR10MB3170:EE_
x-ms-office365-filtering-correlation-id: 385d351c-5529-4f7d-2289-08df35ee9d8b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|55112099003|18002099003|22082099003|38070700021|56012099006|11063799006|261026140227099003|261022075727099003|261026121527099003|261022113327099003|261021123027099003|261022105027099003|261021121427099003|261009223027099003|261028144727099003;
x-microsoft-antispam-message-info: +mN3ToIlHw6vDjie6j/JiGwEeQMFLzcZRfsZ7r56tVevwCBFSBYMraYI2b5UjrlbUjaoKIFZDotgLqtKO0gKQ4WA37RiM781r2cnXKFNgnsmfVtK0i5R7/FYV3B4I35Ene1XbDA1hzQ7Nd3Y5aWrQszYrbTibyP8/bxFvAiCN1/jrAnZwepk6kue5anftlFthgSoPBGqeS6a4zQe23jcMqlwyl4VFZPhvJAdT8M8TKV9Oy+g22QeMj5ZNVMLtqJjQnhWuu7UkDjnA3SWqcf4dbAPVosGkVo3DEgqXRJqAxCx1zFvYEwluPIjjKaXNlt7J5clQ7EzMGWs9/9+Pv6ym+6COi8alWppMrtTSfzqtM5OMNJMASXSv9osjOB4uD7nVXKYSyMBswfzGigj4YopnGV8jOWjTudLlc6P5ATa1uL+Mq6Q8tBkNIREGts55Y4EBWDdVjpP9fH/jkqKuJo3qb9PcozBGvI14CzmlJE8LNvuPq735O6FiMfFNMlKHMQC+R3uKguovXwhLkMdwqCv2OCLvlox8nfd8AJoiXR4wgN/4backWF2b28TwL9SSpP2+oOUyQzubFD2hEHGTZGp/T9dwa4Vu9jJrZpmt9AnJxkdkU1uphZGrVw5RZsgp07Nk+ToXUw+2cZxmaabcRKwSszNo1l9CUJ7Q7twU0EE3QQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(55112099003)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006)(261026140227099003)(261022075727099003)(261026121527099003)(261022113327099003)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/eNEtD2IdQLoznZku/JC5tODBkehVum6E6Zn4JqgauKGH6Hk0srllECxVeht?=
 =?us-ascii?Q?WXGeIVxEUVQ0xZbs6OWSUndxV2AydnZ3weiItsCmXxyLA80luMS/hhHZPrsF?=
 =?us-ascii?Q?Cki3TqcLMhGXH8WRmO861Or00AcQtUrkPe6mLgN7FQN4tLLrDNcXaKC4Uu1M?=
 =?us-ascii?Q?+wjlXA0Ny5nFYeXwm7Mu5kq9syVbQ00N9Lw+4TTP+ieLjSuIacRfmkq0pAlg?=
 =?us-ascii?Q?/Wlhrd39Z0qJ20Zy7jPgruZNef1xWrvUJ2UXBKGRmx3HbWs9Xp0p0XhYj/Wa?=
 =?us-ascii?Q?YiYv4Qmld6V3SlmNy1ld23gGHplj5DbUTlOvBDLOia2n537Fv84iajkJS9rh?=
 =?us-ascii?Q?PGYTgVAaMBBB/PqUqtWbRl8duLWNJPwvjQQfqSzDfOMnI1Rx3yiTJlc1LcN3?=
 =?us-ascii?Q?f9F/GpljjoZc97Pa4DIQwLXJXKP9UgBpysCe7XdAv7hsp7V18m40XwuxLiSx?=
 =?us-ascii?Q?UoG18fdc/uvqY0XWlGV2k59LNuKOy9xP+Fv0YihhN9JmcSkevfP83DyGTTtG?=
 =?us-ascii?Q?L4ClWNz0Xc+slj/Z7GeGrqwLY9JCb9QSUysKwZeCQdtJleg5o49SWkqpbgPz?=
 =?us-ascii?Q?Y1B1WuJXvJxgvwfiFgqrTva8wF7JqKu4pj2+JPMqP1F2YMJj5QNNzcYmbINe?=
 =?us-ascii?Q?qgu6k7meJWU6D+Bi/W41XUa6XQDsiPfX8pbbTGl+OpctDMyWaOaTUea9aHyb?=
 =?us-ascii?Q?g9d1m5Ur+CgTMvRX9+56OvuSgYMGRzSr0ZDeaEk8wS0POD1ReEFbpFDGQhZn?=
 =?us-ascii?Q?PRhbaOI0bludzfphbivQoSgIplp1HGxLR8Lmtn4dINqZeLyAIwH/6lrjgyZI?=
 =?us-ascii?Q?nwQwpBiAvxvZBGZlZowvbC6c5VANa4pk1yC8PKLnm+26t1U2hMa+fdKduWIe?=
 =?us-ascii?Q?C9jPoFUjmtAIvyUZsCxg6J51AhKFL7YbdvBk5q7xbl/DfvZdjnRB+/gLJi/M?=
 =?us-ascii?Q?56VqBOIg8RV/CPmPMiGX8uPB3opoUcYCC3ZeWh6XJ2zygYD11LyBYAAkbKnm?=
 =?us-ascii?Q?gc+rbcgXnClz8ePvz7tscorBjBP+76aX395vEHD5o6dnDANzmRAsghBMJXbW?=
 =?us-ascii?Q?lTvPuno+u962o7SKot7cQHa3eKuK/OshupYHCCqXJK5q5YLOtmyU2F0MStNz?=
 =?us-ascii?Q?yRkVzHuooXHh+PkrVLmJDcND1/fAg+PM/AXccvE34eyYtEA6eAjMtf15gOh5?=
 =?us-ascii?Q?BO1PKOV6v7iyAdPu3kF0wX10BoKdWGWf6L/rafgiKfTERA8JRxQGpuB/iJkA?=
 =?us-ascii?Q?OmlTIkscbSqCmVHi2oVf5B7QMDZaaD+IXxcFQFf5Qt0Sc0pR6y/5k/aQSZFe?=
 =?us-ascii?Q?iOTl6eNSvFeiUMQwNmCNe9czhyrwIT81pNLicKGZYVqV5UKAw6DbnyGIkCX0?=
 =?us-ascii?Q?2pAdCOrdtP5aBQ7ox2AxQwRASH3tqPCium1bRlRXzb2WZFAX/rS1gg1Wmx8i?=
 =?us-ascii?Q?XLDGOfh0mKZjbWxOhBeQEFgskWvXrhVkHvYFNsvMzpQQHOql6aFxMQoXI+3p?=
 =?us-ascii?Q?YNX/3xq8QWDnmR5DBXc8rNGpRdKWGKhPEDAIqVAqMtkIkeXoIkZntldMbIap?=
 =?us-ascii?Q?ZGA7gmpFVuYJbiihLpNZUNKGDmsgH0bmXZCU9AqizIyGLBbzLwiLxkHYjerY?=
 =?us-ascii?Q?tuIWoNPgZ2E8etPB3HNjkFO9dEX3/KX6y1YwZvCjsaZafrCugS9gZQpeaj0G?=
 =?us-ascii?Q?Ls+p4tYVvJJYEPr219Z2FsS2ykaVI6G/wnbCWlFqble5a5lZjqdCdHRdGJX3?=
 =?us-ascii?Q?GYmzLcmM/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 385d351c-5529-4f7d-2289-08df35ee9d8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 18:58:27.0497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oOSjeeYSO3pfj0P/hjnLjkR1/AJ3n2PWZdKjxulxZcwTjl3Lqd0oFS+NUSivKtWCRZQ+e8OLZFvBSbDEUXQZOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3170
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 29 Oct 2026 18:58:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5187

Gentle ping (also for the yocto-metrics-meta-oe patch).

> -----Original Message-----
> From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Sent: Friday, October 23, 2026 12:27 AM
> To: yocto-patches@lists.yoctoproject.org
> Cc: Richard Purdie <richard.purdie@linuxfoundation.org>; Marko, Peter (FT=
 D EU SK
> BFS1) <Peter.Marko@siemens.com>
> Subject: [yocto-metrics][PATCH] patch-status: add blacksail
>=20
> From: Peter Marko <peter.marko@siemens.com>
>=20
> See https://lists.yoctoproject.org/g/yocto-announce/message/397
>=20
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> ---
>  patch-status/index.html   | 12 +++++++++++-
>  patch-status/releases.csv |  1 +
>  2 files changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/patch-status/index.html b/patch-status/index.html
> index 9d0ebac6..ef5c009d 100644
> --- a/patch-status/index.html
> +++ b/patch-status/index.html
> @@ -170,6 +170,10 @@ SPDX-License-Identifier: MIT
>            <summary>master</summary>
>            <div id=3D"cve_status_master"></div>
>          </details>
> +        <details>
> +          <summary>blacksail</summary>
> +          <div id=3D"cve_status_blacksail"></div>
> +        </details>
>          <details>
>            <summary>wrynose</summary>
>            <div id=3D"cve_status_wrynose"></div>
> @@ -377,6 +381,12 @@ SPDX-License-Identifier: MIT
>          createCVEList('cve_status_master', data);
>        })
>=20
> +    fetch('cve-status-blacksail.txt')
> +      .then(response =3D> response.text())
> +      .then(data =3D> {
> +        createCVEList('cve_status_blacksail', data);
> +      })
> +
>      fetch('cve-status-wrynose.txt')
>        .then(response =3D> response.text())
>        .then(data =3D> {
> @@ -471,7 +481,7 @@ SPDX-License-Identifier: MIT
>        upstream_status: 'Malformed Upstream-Status',
>        inactive_upstream: 'Inactive-Upstream'
>      };
> -    const branches =3D ['master', 'wrynose', 'whinlatter', 'walnascar', =
'styhead',
> 'scarthgap', 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'honister=
', 'hardknott',
> 'gatesgarth', 'dunfell']
> +    const branches =3D ['master', 'blacksail', 'wrynose', 'whinlatter', =
'walnascar',
> 'styhead', 'scarthgap', 'nanbield', 'mickledore', 'langdale', 'kirkstone'=
, 'honister',
> 'hardknott', 'gatesgarth', 'dunfell']
>=20
>      const general_options =3D {
>        tooltip: {
> diff --git a/patch-status/releases.csv b/patch-status/releases.csv
> index 48368ed5..324d4a0d 100644
> --- a/patch-status/releases.csv
> +++ b/patch-status/releases.csv
> @@ -1,4 +1,5 @@
>  Name,Date
> +6.1 (Blacksail),2026-10-21
>  6.0 (Wrynose),2026-05-13
>  5.3 (Whinlatter),2025-12-16
>  5.2 (Walnascar),2025-05-08
