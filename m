Return-Path: <florian.schmaus@codasip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AA61039880
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 19:52:14 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.85])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.105074.1772221933448969517
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Feb 2026 11:52:14 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@codasip.com header.s=selector1 header.b=aHLDOZMC;
 spf=pass (domain: codasip.com, ip: 52.101.69.85, mailfrom: florian.schmaus@codasip.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjOJfTymnaugvii/La+YXmP371D+DUGmhyjiFaun2cxTA54DkZwF/NuPwkpxmyEk/gUh7Uo31y5FaUgu2NKKJZBY31ltJYJe+dXVLZDnO4Zk4buKybZGIQRfUfovTsHCEWABIxTHBju7BIwmzL2v/x0wSnuYjrcSCqXHx63agI0AaK/J2FD9Xq8wbjKZ7ftHeDcuP/Hz+fy5cxiNc8K0JY5tCDcxYmkL9GQOZ96OLDXdro55KIhBfLLRqNOtci377Qta9jcL+iqCece2RG+tPM1kpYbLrUovjyI13TguBRSAGIcRbfkeSKQgIDBBW8S1KIry6o1PgH3Ebr+Wev1blQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVXpi7C4c/dGSeyhaAhaprO8LrZQ10dvf8+5K9lORW4=;
 b=IPcPfDFNzMuoQfyqCKVUB0i7B6pnkKrkX0XsySew0ZEXuyJrcntuQJBG0EzRrzPDP7CmYXFFqmLn5MZLjuPjr/w9EaWKY2TP2i3A7YS/bgC+3If8IgkCee5lseJrisGbYImEFvXO0Um8nKkmcj/mXCxWopphwes/QpidkaGnZKA/aaboAGQgnwaI3JQSyDAlOjgifGxnEJ16Kk/sghIMPqHsmQv+GbH6bFuLvg7QVF4u8CaycbQgriVT11Ebgku/ojIvoI3hoRanv2At1L8jGsKRuJwaaTUyT1tWb6/TqZoBxrWhuSknQKdjfgLEJEVrUDyGX8wDI5NLPYvA8HkWhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVXpi7C4c/dGSeyhaAhaprO8LrZQ10dvf8+5K9lORW4=;
 b=aHLDOZMCrXhxXiWwvl8aW46ufxZKtH3xg++mIBYSq9W1sw4VmgWbT7RoqJfRtDNnAQ2BY4iQ3GlKzss4GtmSaccWd0ONpablPVJSfIE4m2tFVHmSAIa/egRpgKEBouQmeJeMlTLeOl+1AFWpt52VWUY1JtowjBwk+KQtI7D1HC7YBtXTAmNaCirYOJZ1Yk9qQLpz74p63ZDCLXAvJ68FDonNih2U1ELBm/qddmR+9SDRtfs8G060400YkEx4fiWNBRQC7BdNFVBGAXnRzj/qaR5zYhHXDugNWxvCP0qpB1e1VqDc4sxnAy87k1UqxCdv3lFLDb2+NZlsa352XYxuuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
 by PAXP192MB1606.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:281::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 19:52:09 +0000
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::f0e5:8465:302:9a9c]) by AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::f0e5:8465:302:9a9c%4]) with mapi id 15.20.9654.015; Fri, 27 Feb 2026
 19:52:09 +0000
Message-ID: <1a4d6506-cff4-4850-93c9-2bd4ce12a6d8@codasip.com>
Date: Fri, 27 Feb 2026 20:52:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix dirname() handling in run_ptests()
To: Anibal Limon <anibal@limonsoftware.com>
CC: yocto-patches@lists.yoctoproject.org
References: <20260227100943.284203-1-florian.schmaus@codasip.com>
 <CAOU5ZMvo8MDDGTRYCJ7nc_mtg0hBQ2tXUD1P3_0z_kWgo22OVw@mail.gmail.com>
Content-Language: en-US
From: Florian Schmaus <florian.schmaus@codasip.com>
In-Reply-To: <CAOU5ZMvo8MDDGTRYCJ7nc_mtg0hBQ2tXUD1P3_0z_kWgo22OVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB0983:EE_|PAXP192MB1606:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9972a3-27fd-4b5f-b878-08de7639b147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	2CmwdRp0BiCaBK1v8EH/Txs5gNCJ31o79uFqSDXrTyYn59zDQEtsvtkYwQBIT7FbjHP7MyHmB5pYPRfxjCH63lVLpzGb84nCGxtHf9fRoR8L46LC8x5xh3I5ECe1F87y7m+ovdjb4BlJK1GfU90bhMmzhYNnhn/NqXmx447auDqPvphBl/IApgn9cZaDVIhmEYrlHTQH/aKPpWVxZtFA5/+wV+3Cyep1J/xZMdHF8UDXGGJGEol/tsqBKmnQ4rz34Q3d6sTf0J4vVywhsEO5C5t0ACq7qPXwswW5T8YTJg661eYIPS3Lo/SIZMpoQwg/L1IxpNRbt+psvLmmsPGqBmVg/YXPMILXmcXUNce/uvJJoI1/2l+MAZOE7Df2axQnp6DVO40vJ/IJJcVtk6cDHgaucDXlj4NyJRtGhGI1id88AVB7aQhFOQFP1iss/oOETdqfKKJlsBQkyxs/sbtUvgvun+mYkVNWErgv4V8Cg7T5Xelff4RTppCa5szGCf4TytqZyP3o1bIPtKCzFE1JSWgx8YbSOHFIH82cHsZLFhz1iAg4xg/ZyRWC7h+f6b6qPDig6NwDuKQexS8mE4mdKfjNcopjSwcw8HyNo4Nhq8hbvZQ8DcMdFWvkbN/yCImKZ2NnltWRB/OxPBsKLTvVLVjdpx7oJkN0nIH82jJmsOH7HZcI8Yun3njUyyY0+nIC
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB0983.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xQCQ+5mNaW5Si95eLh4afwUQV9ff7UusP+xK0nv4JF/RAyt6EZGCOyFUcwxY?=
 =?us-ascii?Q?KbXMrmH3mCVAkXHSs34wa1yuLAe3QDpqkD15ftzPfwwHw+WX2umQSG/qyvIu?=
 =?us-ascii?Q?i7hRDQUMT232nU0RnJFzSPSL/YfCiZ5LcmPOCgUJr1STq6wjwMzWQRc38PR5?=
 =?us-ascii?Q?5DDaGPAsai+Tf9Hq7r3yHZDBIsLd2/DJmYcwQWSGz/+aBYl3e80nui4rKNXc?=
 =?us-ascii?Q?nEfiGkJsqX4j6lMAqsrxcF2T9fAoMAA6FRxVMn4iHilLQuGGZ7APWgeoUbx0?=
 =?us-ascii?Q?Kc1XAyODQGzYNtnC+lwG6bNGghfWJNRMjWTGn2AnuaPkdUqc/t7DG0EIWPtL?=
 =?us-ascii?Q?0KOsYzGUPz8aGkyoLxduywszU1aKtwzbUpSswWDKTBhi88QOWYOHP6V/5k82?=
 =?us-ascii?Q?SrsrJCQCTULnNWa92oUsgo2QWKCfVkCd8DKxn6bH/tejq+eSAFF9BG+xhzGE?=
 =?us-ascii?Q?3huLLHmcUPqI4UJBB6YeEs6DdoEagRBAuJqC1cp6SKfA3YGqVGI7Ua1j9dXi?=
 =?us-ascii?Q?Z4lsTVLLjvkSLGEf+upnS7YXto3ZXW8SedmaVGif3tk1kB+wcos0OqNXCmX3?=
 =?us-ascii?Q?q9U4KIqmVz7OXgVrt4I0gJivR74r1UyyckJDAwXD/ann4q2ysLFclQlkUM6z?=
 =?us-ascii?Q?7V1+Nk4iU9vi2Bcu0vhU/TuF06VBtZEPKWrAO2TK/Y8oTR2DNpl0/fLlnLis?=
 =?us-ascii?Q?xuMeR6hUZBybre7E5Szr9PzuZa3ocHNKFamFpuaacnuOxvnBusPeSNzzzJdz?=
 =?us-ascii?Q?eA0PXM2IZmoKKCjg3EgPhxMVYdfSUEyNBY5+e2REzhN8c6L8cOkgLtX8gKzE?=
 =?us-ascii?Q?MJhKfLaqm71lOWG2KkHMHfKtaT0ZHy4JwZ0Ax0FOAfaKErQideVJeSBYlZK2?=
 =?us-ascii?Q?xjzwTTO5vEJ/ARNbyBxRTDwhY8+mdapXvg8SLm282dd+L4mzZQ3y6OGdFOHc?=
 =?us-ascii?Q?0oQP232M2HuOoq9rtJHQy1ppTxakHhhN7gZtfiyQUfSSj8rPQhoH9/BhzQZ6?=
 =?us-ascii?Q?u69HwEIsiuRUc4Z0kYW/4Ho1LA4U2W0T9Dka09qtmh/rbJUe4kjhnJfsf49f?=
 =?us-ascii?Q?MWeiUOoq0tMC5r35L5u7zXW/KsqGCDAU6+pb0ag2xEA7QQuDYpFwCGDktMEY?=
 =?us-ascii?Q?lqeRqyr9b7ey6hs7BM6y94DWiaiSR9tSOrIdlEsNcCpuNGJdZldpeWWBs+R9?=
 =?us-ascii?Q?xQKRmkSCneTTp3oeoqaC4yYp+nitVquUZ2orYiuLGk/NfZ/Ui7oZggTiHoeP?=
 =?us-ascii?Q?+cdtRmFZcCWOGohsI3k1EM4AwGPMDUyOJcBcFN+MgKbXGkkeyEtBQpteG/as?=
 =?us-ascii?Q?2AYNYOoTcja8lDG2viZ0oGh6vDruCAPHel17gbUpki8PcLajc7gp4OE3bUJQ?=
 =?us-ascii?Q?ujog5xdXerLvjQZhtcN5icGRU69/+NYnW6mVZ03M9/R5Fi3lUb2IBpzTPBnC?=
 =?us-ascii?Q?ja9aGwozFnVSGXFYhMuZVjor8sGEO8aefWYaTmWuVhDAwUr2HeCxmHK+nPBQ?=
 =?us-ascii?Q?Vur1FsxOdox6N7fT40xHbfZ3ns4UWy6JEHg016zhgUb1weLDJm/niv8/L0rk?=
 =?us-ascii?Q?a+heOC1zZ8AdY6S6k3NyEidneXKX1T23VjNc53Kt9ApvCbhLCUeuhq+Cun0B?=
 =?us-ascii?Q?RpHHGCcAbPn6wMFVlOhZTCAVUJntRIHjvpmLp8HBRbWimKfKYBEp+Zori6Na?=
 =?us-ascii?Q?dHt4KvAKARKzVB82AWCjy/ySay8hGcGEERSZJ0cokdsOQdaeCjtmn3FEoHGJ?=
 =?us-ascii?Q?FuxdhxAVvuiRaxsbbcEfm/jZzgQ+yPmW23SFzQ+edKbSP0toj8r3jDPqDV8r?=
X-MS-Exchange-AntiSpam-MessageData-1: +/GurFfneTZRAGRte6o8cLATMUY317cxjpA=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9972a3-27fd-4b5f-b878-08de7639b147
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 19:52:09.4097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycpEchymwDcMl06c9PC353aR79SI4kl3Uii92C8fX4JzyBzIj/MWFO9hrTUGCw9F5H1swy3ltEAZoJergYTTe1WueZH9OVr5wjxCdUQso0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP192MB1606
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Feb 2026 19:52:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3304

On 27/02/2026 16.58, Anibal Limon wrote:
> Hi Florian,

Hi Anibal,


> Thanks for the patch, comments below,

Thanks for looking at my patch.


> Can you refer me to the musl dirname(3) function that uses static=20
> allocation?.
> I reviewed [1] and found that modifying the same string anyway doing the=
=20
> assignment=C2=A0is needed.

Oh, right. It's the CHERI-enable musl libc that is using a static=20
allocation [1]. I wasn't aware that this is a deviation from upstream.

But it doesn't really matter, the current usage of dirname() is fragile=20
and should be fixed.


> [1] https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c=20
> <https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c>
>=20
> On Fri, Feb 27, 2026 at 4:09=E2=80=AFAM Florian Schmaus=20
> <florian.schmaus@codasip.com <mailto:florian.schmaus@codasip.com>> wrote:
>=20
>     It is required to use the return value of dirname() instead of
>     assuming that dirname() modifies the input string. While certain
>     implementations of dirname(), for example glibc, *may* modify the
>     input string, this is not guaranteed behavior. Musl, on the other
>     hand, does not modify the input string but instead returns a pointer
>     to a statically allocated string.
>=20
>     Previously, ptest-runner would fail on musl systems:
>=20
>     $ ptest-runner busybox
>     START: ptest-runner
>     2026-02-27T09:21
>     BEGIN: /usr/lib/busybox/ptest/run-ptest
>     ERROR: Unable to chdir(/usr/lib/busybox/ptest/run-ptest), Not a
>     directory
>=20
>     ERROR: Exited from signal Killed (9)
>     DURATION: 0
>     END: /usr/lib/busybox/ptest/run-ptest
>     2026-02-27T09:21
>     STOP: ptest-runner
>     TOTAL: 1 FAIL: 1
>=20
>     Signed-off-by: Florian Schmaus <florian.schmaus@codasip.com
>     <mailto:florian.schmaus@codasip.com>>
>     ---
>      =C2=A0utils.c | 12 +++++++++---
>      =C2=A01 file changed, 9 insertions(+), 3 deletions(-)
>=20
>     diff --git a/utils.c b/utils.c
>     index 6cf7705586bc..7614dce99bd8 100644
>     --- a/utils.c
>     +++ b/utils.c
>     @@ -361,13 +361,19 @@ run_ptests(struct ptest_list *head, const
>     struct ptest_options opts,
>=20
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(fp, =
"START: %s\n", progname);
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PTEST_LIST_I=
TERATE_START(head, p)
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0char ptest_dir[PATH_MAX] =3D {'\0'};
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0char *ptest_dir;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0char run_ptest[PATH_MAX] =3D {'\0'};
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int pipefd_stdout[2] =3D {-1, -1};
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int pipefd_stderr[2] =3D {-1, -1};
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int pty[2] =3D {-1, -1};
>=20
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0strcpy(ptest_dir, p->run_ptest);
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0dirname(ptest_dir);
>=20
>=20
> strcpy(ptest_dir, p->run_ptest); // This assumes ptest_dir and run_ptest=
=20
> are both PATH_MAX; perhaps improve with a secure version of strcpy?

Not sure if I understand the comment. My patch is using strlcpy() and=20
should be safe.


> ptest_dir =3D dirname(ptest_dir);
>=20
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* Copy, since dirname() may modify its
>     input buffer */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (strlcpy(run_ptest, p->run_ptest,
>     sizeof(run_ptest)) >=3D sizeof(run_ptest)) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(fp, "ERROR: %s exceeds
>     PATH_MAX\n", p->run_ptest);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D -1;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto ptest_list_fail1;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ptest_dir =3D dirname(run_ptest);
>=20
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (pipe2(pipefd_stdout, 0) =3D=3D -1) {
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(fp, "ERROR: pipe2() f=
ailed
>     with: %s.\n", strerror(errno));
>     --=20
>     2.52.0
>=20

- Florian

1:=20
https://git.morello-project.org/morello/musl-libc/-/blob/morello/master/src=
/misc/dirname.c


