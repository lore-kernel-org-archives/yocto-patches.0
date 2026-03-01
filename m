Return-Path: <florian.schmaus@codasip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ABBFD005F
	for <webhook@archiver.kernel.org>; Sun,  1 Mar 2026 10:57:26 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.136046.1772362635748390458
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 01 Mar 2026 02:57:16 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@codasip.com header.s=selector1 header.b=D8RmPfJH;
 spf=pass (domain: codasip.com, ip: 52.101.72.134, mailfrom: florian.schmaus@codasip.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7DtmIrtuUogPWPBXQBTIL3JEpNo2wn5w5oh75p625e+LWujVtKcUK/GtuQqHkjdYy/JrFmePzCndef9CEda/OCcbZbqhk9aly6Q8BvJGgdpw8d1k7Nxn8HX+q0BmxgW+AQXi4Bb8f2rfhI9X+DB2oeXZ2/YhH5M64v0JCRjwE3ReKHljaeVWmmnifIUVT1OiC+4nHEd6dJRwhHCg+Bves8RVZ5lvA3rxzVhFdGOjvEyh0zDBWqUgt0oUwqBeK+fJYJ84N7xgQKZrw8WdSBvFC7Otaatsf3CnGWb7fl75J0hzu5vkbe1yMwg75MANVXlU8BbTHe922u36xGXq0RCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mbtlt+5mTC/Iww0n2hp2WwSBSIdYzI3URtFqQxQu7/M=;
 b=nDHtLzMtu2DLg4f1D6y7syZuwF6R2vLuXtaAkNKL6dzWxCu9mxY9ZPvaNgXisGXrFo6pPUZ1+ksXYytxZW1c5uSqWVz/yzOOdDaYpVSuHxPVrYqIwgCYsgaDnudp6UyDE19hMjPeiei46JDesTq7gunIMqMPRjw+lxVLDhQ+TC8zHOkRCcfl7Z0/OOXIGXB+iyZilXAhu9F8dqH1UlSvkeEG02xECa9sX4R3+4YWBJaRxhyK4JZQTAZmIzmZYl2oNkv2aNrqtTNTyuajU0hKAJoqvUuKFfUMeqCfccsrBvvzh66QjdEIozqVQNDN035peWbO63qsAP72w5f+cg4z6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mbtlt+5mTC/Iww0n2hp2WwSBSIdYzI3URtFqQxQu7/M=;
 b=D8RmPfJHdSK5Gy6oBSGA/tGJe1AKgrR2/pfELXO6OYMCZWeWvm2x38QpJRR8n8kupDp4M8790rS1lXQLlb/t5SvxRhJdDxJXyJ9HiEonvvTsT6XHAalwoVrbnrBrRFglcwq8dFHITmOq0Z9buoOiHJMD6EvKyv0GzQI8FDzC+Ca0yEmgJFNYGPh+jrWxIVsKuYIX6T5+cN2kb/X8I500T7UYWr5VK1ADRURQ6Od+BU5y7S7P91Yn03dlZKjwQlCOe1A5e0zyus0VSXwAu+5bsieMTVf79uMwmcorMV3QX6xmauhTfSL6v48zXywrOJIcbkixHV8tz7NWVk48MDHk4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
 by VI0P192MB3407.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:332::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sun, 1 Mar
 2026 10:57:10 +0000
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::f0e5:8465:302:9a9c]) by AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::f0e5:8465:302:9a9c%4]) with mapi id 15.20.9654.015; Sun, 1 Mar 2026
 10:57:10 +0000
Message-ID: <290045a9-e932-4808-92ec-6e0d57dd441a@codasip.com>
Date: Sun, 1 Mar 2026 11:57:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix dirname() handling in run_ptests()
To: Anibal Limon <anibal@limonsoftware.com>
CC: yocto-patches@lists.yoctoproject.org
References: <20260227100943.284203-1-florian.schmaus@codasip.com>
 <CAOU5ZMvo8MDDGTRYCJ7nc_mtg0hBQ2tXUD1P3_0z_kWgo22OVw@mail.gmail.com>
 <1a4d6506-cff4-4850-93c9-2bd4ce12a6d8@codasip.com>
 <CAOU5ZMuR6noT6pdL=QVHSrL95mmrvoLg1acHNu+j141ZRg7VwA@mail.gmail.com>
 <1eb39bda-cb9f-4435-b784-540f203c8ef7@codasip.com>
 <CAOU5ZMs+SgsAXWp7rO-C=TYKf90ER9N5fLzVfEx2P6ZXm=dxFA@mail.gmail.com>
Content-Language: en-US
From: Florian Schmaus <florian.schmaus@codasip.com>
In-Reply-To: <CAOU5ZMs+SgsAXWp7rO-C=TYKf90ER9N5fLzVfEx2P6ZXm=dxFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::14) To AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB0983:EE_|VI0P192MB3407:EE_
X-MS-Office365-Filtering-Correlation-Id: b581e1a0-50b9-4c89-b5fe-08de778149b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|13003099007;
X-Microsoft-Antispam-Message-Info: 
	AC1C1a5ebH+nZfxylZfON8H9CDLraXFqLuejLuHKSaTSyL5THmxWlD0ULpHZ1vJF10rmGD9ynnM29FO/THakBbRayHWKMvwd/CaWGcYTrM9/y3OeSdO9vwdSk9eyhJYsHXq4dmMIZJmqV3Vdwsw/XrAeut1bHNfPHoli+rHPNsppxqidLYrjvmiY9IWnp50uPaxjhfkdB/vMhrhpilZ+/UwE1CfVwG1R3ur2ms+G2/LNu6OuU5Ikl1TLd8ykImSIqKxKRJ5QxicJdBwGbGCYRMxdiO9ZMAU2dgXl8FdkMUmpQNUyVSRZ5SSJbIQsjjEH0gPBfXZvjLeZuVbixhEyjuSK6Y5XPPqriFzjeauN2VJe5SG2gVuwT8yYjfrb5DFOSrWff2gKyjUlosXcWbUDbWXG0gJnVIIkddzj23UOPKcXBx+vX8ACY9C59ReL/OlBQ8MnaUj2OyKUxcgnjAC4DNgfYZPm4+0AuGqvA6ya6eaQzXAAZEwfy3FMLmbPyXisQqfu2IP99pvU5s+QVqp5WbuTOtz04bUXKalDpqz9pxd+9uURKzybThN+PhXLgTZdpagZS+bDguvop+DczYjkQ1/9DoDm72I3KyVSEQp4u54B+SA+2N00qjgQ+7D+pFHsjgYG0jlg6vm6UFmkdAKYnBjFEMyzGC4lA45wvuY9jHWhavixy2Xxp1eb8mTBOdoo
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB0983.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4jBrGhRhWnPKE9j/S2E2dBZrzNsuOKGzh5eZbkFV4wu9hbAvsZrvYTTtk6/h?=
 =?us-ascii?Q?iFT1423g7yB9905RgUJV2IejN5ROLhaHsfdkVCmO9PcySo8b3a8H/oS/Fplb?=
 =?us-ascii?Q?ubtloL0ZsJmgCCJ2G1n0Zg3EoW+O9FV5sGX8T3XGvZpqiIAuudp8R4qLawvB?=
 =?us-ascii?Q?yl7+25fPJbP7p0X/tcQ/CesbNluYgO/4Qs6tfDlz+PdOyv/k7LZnECXmyWPW?=
 =?us-ascii?Q?R4LLoguFzHJiOELph+Kt2s5JI/JLRSMDF7SOwlQmBj9qzPb+DziDsn6V47H0?=
 =?us-ascii?Q?6nXmmEy9UasoU0XH4rOqbigf+r90BBQ8HISHRNmueUFQn68KG45Wz4zOV7OI?=
 =?us-ascii?Q?Ti3B/GtGWibUhhUCjQtVixJWLr/BwMj+IGEW4IpOkKIqsUa1LMbBd15nKt5l?=
 =?us-ascii?Q?HOQq5Eg22+Z/lUi8x78WTp5lIcsPhmaQ58PlPXY3w/p92M8JOIA2NJH7fDQ/?=
 =?us-ascii?Q?wMZQNZ2RbBywICSjThm7hNCGbfcEXgp/udymR3pxDXKGsMpzwNIOXiQJHaxN?=
 =?us-ascii?Q?7YL+mDuuTo8lguE4ZUGOscmcCoMvS4Q+07rk+NZ1dFkt0BToNK3UEfuCA7+V?=
 =?us-ascii?Q?NMf2wd03YorD4cJVzEzIGLLNEyatyM8x02W1bHFnLqxPJ4wKRCE0xmOL/JK8?=
 =?us-ascii?Q?inD9KuatMtgMkQ9hlPGgzYKUSvKxeMa24geR3Y7hUYDBrkDACY9PXjrQIWdK?=
 =?us-ascii?Q?Y5GrMmVwHsRrZXt+0dNfpwN86m7xp3j12Nkb4gJz19pzO/ltNPgWxD1A4Z6l?=
 =?us-ascii?Q?xWJU4AO0X/XLy3O4D9TGx7/29w7xYnoh30Iqyo62agIWGPpEw1UmNI1nwz7R?=
 =?us-ascii?Q?1qfstoVRL7yMEHr5drHUUIfdn7NdChkJSAu7bNtwgD3X6yrUAe05aFRZ2S+W?=
 =?us-ascii?Q?lV96NoVWcwCtTr++WdGkaiAD3WJ1zrQsUFA3BijbsZGx4zHeQKe7i5mhLGz1?=
 =?us-ascii?Q?k3hmNlSSa4IGLZNlEMXNWBgQ2BYb3ICWEEEN7U5lXgw/kJ+J5bsklCtlKmu3?=
 =?us-ascii?Q?bkjR2ZWc4BNQyvWMFqG+u1BsteODI/94sCocoZ5FGd6PJ3hAUeddbtS6S1S8?=
 =?us-ascii?Q?4LaGkehXbl24sjvJWq08FkSzZz1/4Cx+N0scc0UTWsJZxO35LJT9WWrFVYSp?=
 =?us-ascii?Q?Wm6hpMPk2tfbmtl0E2nKPlbL+t8pbE5lRtIH+nTN1XIHhTF53p7wTdnaZbox?=
 =?us-ascii?Q?tCXSYgwUyCdmE17aMisbUaKnhod60HQ+OOp/ECaQgQg355J2wzsSV09HVgSG?=
 =?us-ascii?Q?6XJKeX98XKzpE4wUTtmldWqI365Og0atGN4Noy1bZXC4ghB71sLt6FpoOV62?=
 =?us-ascii?Q?RxEN7NSX8pad5ms18TZNi9UjE4s7459mxWor5Rl9zAY3IdeCRgmh/DYUaym2?=
 =?us-ascii?Q?DFVfgc/gzQT5sAGHz67FzQB2uN8SXMNklwq5HH1UflW4wN8ISr2AxoHRCBe4?=
 =?us-ascii?Q?b8a+bc6yKu7BjRSHcbCTn+eS4V3xPQgIZ7V0LsFdrQZPQxGee/F/ZWCYjWUX?=
 =?us-ascii?Q?VJfLDElY5SRgWpvKgHQYJgC5l+uIVcXT41up/vATAq+dmLIj1oDESdutSBVC?=
 =?us-ascii?Q?FjaF0GsIg+g2x1PoF+qDv1nu0etfSBL1tKnrAiTpXd6CV6g7uh5FMlyuzmmk?=
 =?us-ascii?Q?+Xs+Z4SG4C3JGE0NYMowsBwZcK631lwlzkobuhYOALyq/VPflS2Ikoyjmtvv?=
 =?us-ascii?Q?93d7mtcySKEPgkFdYbLB+/k9/bkY9qrzZwtx7h4+X0M2qI2ivndUOmIP2wfp?=
 =?us-ascii?Q?Lk9YK+Zad27G5uMcZKgiC2rT5X0FqtHGCVIllPvrVDJ6BWd5mWsXrJbBTX1+?=
X-MS-Exchange-AntiSpam-MessageData-1: XSP+8Mrw/wdtDiRvAH6/mNww/V1WxK/ahmo=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b581e1a0-50b9-4c89-b5fe-08de778149b5
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 10:57:10.5942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOCINErQr9thopUm+L48gLXT0lTdCEngIRCyvFKKPQP5k0jqle0A0euyjKOposnXcITmRsxn4PDuewa5T8gejcLw1UJC+ocvgEdWlbIwjIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P192MB3407
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 01 Mar 2026 10:57:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3311

On 27/02/2026 22.02, Anibal Limon wrote:
>=20
>=20
> On Fri, Feb 27, 2026 at 2:37=E2=80=AFPM Florian Schmaus=20
> <florian.schmaus@codasip.com <mailto:florian.schmaus@codasip.com>> wrote:
>=20
>     On 27/02/2026 21.20, Anibal Limon wrote:
>      >
>      >
>      > On Fri, Feb 27, 2026 at 1:52=E2=80=AFPM Florian Schmaus
>      > <florian.schmaus@codasip.com <mailto:florian.schmaus@codasip.com>
>     <mailto:florian.schmaus@codasip.com
>     <mailto:florian.schmaus@codasip.com>>> wrote:
>      >
>      >=C2=A0 =C2=A0 =C2=A0On 27/02/2026 16.58, Anibal Limon wrote:
>      >=C2=A0 =C2=A0 =C2=A0 > Hi Florian,
>      >
>      >=C2=A0 =C2=A0 =C2=A0Hi Anibal,
>      >
>      >
>      >=C2=A0 =C2=A0 =C2=A0 > Thanks for the patch, comments below,
>      >
>      >=C2=A0 =C2=A0 =C2=A0Thanks for looking at my patch.
>      >
>      >
>      >=C2=A0 =C2=A0 =C2=A0 > Can you refer me to the musl dirname(3) func=
tion that uses
>     static
>      >=C2=A0 =C2=A0 =C2=A0 > allocation?.
>      >=C2=A0 =C2=A0 =C2=A0 > I reviewed [1] and found that modifying the =
same string anyway
>      >=C2=A0 =C2=A0 =C2=A0doing the
>      >=C2=A0 =C2=A0 =C2=A0 > assignment=C2=A0is needed.
>      >
>      >=C2=A0 =C2=A0 =C2=A0Oh, right. It's the CHERI-enable musl libc that=
 is using a static
>      >=C2=A0 =C2=A0 =C2=A0allocation [1]. I wasn't aware that this is a d=
eviation from
>     upstream.
>      >
>      >=C2=A0 =C2=A0 =C2=A0But it doesn't really matter, the current usage=
 of dirname()
>     is fragile
>      >=C2=A0 =C2=A0 =C2=A0and should be fixed.
>      >
>      >
>      >=C2=A0 =C2=A0 =C2=A0 > [1] https://git.musl-libc.org/cgit/musl/tree=
/src/misc/
>     dirname.c <https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.=
c>
>      >=C2=A0 =C2=A0 =C2=A0<https://git.musl-libc.org/cgit/musl/tree/src/m=
isc/dirname.c
>     <https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c>>
>      >=C2=A0 =C2=A0 =C2=A0 > <https://git.musl-libc.org/cgit/musl/tree/sr=
c/misc/
>     dirname.c <https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.=
c>
>      >=C2=A0 =C2=A0 =C2=A0<https://git.musl-libc.org/cgit/musl/tree/src/m=
isc/dirname.c
>     <https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c>>>
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 > On Fri, Feb 27, 2026 at 4:09=E2=80=AFAM Flor=
ian Schmaus
>      >=C2=A0 =C2=A0 =C2=A0 > <florian.schmaus@codasip.com
>     <mailto:florian.schmaus@codasip.com>
>     <mailto:florian.schmaus@codasip.com
>     <mailto:florian.schmaus@codasip.com>>
>      >=C2=A0 =C2=A0 =C2=A0<mailto:florian.schmaus@codasip.com
>     <mailto:florian.schmaus@codasip.com>
>      >=C2=A0 =C2=A0 =C2=A0<mailto:florian.schmaus@codasip.com
>     <mailto:florian.schmaus@codasip.com>>>> wrote:
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0It is required to use the=
 return value of dirname()
>     instead of
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0assuming that dirname() m=
odifies the input string.
>     While certain
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0implementations of dirnam=
e(), for example glibc, *may*
>     modify the
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0input string, this is not=
 guaranteed behavior. Musl,
>     on the other
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0hand, does not modify the=
 input string but instead
>     returns a
>      >=C2=A0 =C2=A0 =C2=A0pointer
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0to a statically allocated=
 string.
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0Previously, ptest-runner =
would fail on musl systems:
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0$ ptest-runner busybox
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0START: ptest-runner
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A02026-02-27T09:21
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0BEGIN: /usr/lib/busybox/p=
test/run-ptest
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0ERROR: Unable to chdir(/u=
sr/lib/busybox/ptest/run-
>     ptest), Not a
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0directory
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0ERROR: Exited from signal=
 Killed (9)
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0DURATION: 0
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0END: /usr/lib/busybox/pte=
st/run-ptest
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A02026-02-27T09:21
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0STOP: ptest-runner
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0TOTAL: 1 FAIL: 1
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0Signed-off-by: Florian Sc=
hmaus
>     <florian.schmaus@codasip.com <mailto:florian.schmaus@codasip.com>
>      >=C2=A0 =C2=A0 =C2=A0<mailto:florian.schmaus@codasip.com
>     <mailto:florian.schmaus@codasip.com>>
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0<mailto:florian.schmaus@c=
odasip.com
>     <mailto:florian.schmaus@codasip.com>
>      >=C2=A0 =C2=A0 =C2=A0<mailto:florian.schmaus@codasip.com
>     <mailto:florian.schmaus@codasip.com>>>>
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0---
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0 =C2=A0utils.c | 12 +++++=
++++---
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0 =C2=A01 file changed, 9 =
insertions(+), 3 deletions(-)
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0diff --git a/utils.c b/ut=
ils.c
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0index 6cf7705586bc..7614d=
ce99bd8 100644
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0--- a/utils.c
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0+++ b/utils.c
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0@@ -361,13 +361,19 @@ run=
_ptests(struct ptest_list
>     *head, const
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0struct ptest_options opts=
,
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(fp, "START: %s\n", progname);
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PTEST_LIST_ITERATE_START(head, p)
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char ptest_dir[P=
ATH_MAX] =3D {'\0'};
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *ptest_dir;
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char run_ptest[P=
ATH_MAX] =3D {'\0'};
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int pipefd_stdo=
ut[2] =3D {-1, -1};
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int pipefd_stde=
rr[2] =3D {-1, -1};
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int pty[2] =3D =
{-1, -1};
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strcpy(ptest_dir=
, p->run_ptest);
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dirname(ptest_di=
r);
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 > strcpy(ptest_dir, p->run_ptest); // This ass=
umes ptest_dir and
>      >=C2=A0 =C2=A0 =C2=A0run_ptest
>      >=C2=A0 =C2=A0 =C2=A0 > are both PATH_MAX; perhaps improve with a se=
cure version
>     of strcpy?
>      >
>      >=C2=A0 =C2=A0 =C2=A0Not sure if I understand the comment. My patch =
is using
>     strlcpy() and
>      >=C2=A0 =C2=A0 =C2=A0should be safe.
>      >
>      >
>      >
>      >=C2=A0 =C2=A0 =C2=A0 > ptest_dir =3D dirname(ptest_dir);
>      >
>      >
>      > I mean making this change should be enough
>     That doesn't work as it would assign to an array type.
>=20
>=20
> A possible implementation could be:
>=20
> ```
> --- a/utils.c
> +++ b/utils.c
> @@ -361,13 +361,14 @@ run_ptests(struct ptest_list *head, const struct=20
> ptest_options opts,
>=20
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(fp, "STA=
RT: %s\n", progname);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PTEST_LIST_ITERA=
TE_START(head, p)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 char ptest_dir[PATH_MAX] =3D {'\0'};
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 char ptest_dir_tmp[PATH_MAX] =3D {'\0'};
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 char *ptest_dir =3D NULL;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 int pipefd_stdout[2] =3D {-1, -1};
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 int pipefd_stderr[2] =3D {-1, -1};
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 int pty[2] =3D {-1, -1};
>=20
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 strcpy(ptest_dir, p->run_ptest);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 dirname(ptest_dir);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 strcpy(ptest_dir_tmp, p->run_ptest);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ptest_dir =3D dirname(ptest_dir_tmp);
>=20
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (pipe2(pipefd_stdout, 0) =3D=3D -1) {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(fp, "ERROR: pipe2() faile=
d=20
> with: %s.\n", strerror(errno));

Thank you for taking the time to look into this. I noticed your patch=20
uses strcpy() instead of strlcpy(). While I generally prefer=20
size-limited string copies for security reasons, as the maintainer, it's=20
ultimately your call.

- Florian



