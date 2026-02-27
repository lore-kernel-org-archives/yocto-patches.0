Return-Path: <florian.schmaus@codasip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BE81039895
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 20:37:34 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.108])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.105856.1772224651744731711
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Feb 2026 12:37:32 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@codasip.com header.s=selector1 header.b=fheqWYRu;
 spf=pass (domain: codasip.com, ip: 40.107.130.108, mailfrom: florian.schmaus@codasip.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VuMx9P7pCC5Gq9S0P74m9knJ9d35RzAmIqaSCncP3ODtQSqJ9QD7DYwCoHZjPGAPJNu12f2aStpSbapWNWrqFGaP4AI4iujqyMgzTya0plR1/zBMmXJ0CSM7In7m+wIgR5xjGBYLWExYIrz+Ptt/oHuTQZPI2ZT8OOfqzXv9AnHUr/W3EywlS0rNEmNnfdSFPXMQEY4Vpx+ZxBZI8BQwkUMjvg9GG+GFD5n6fogxEa0Bac6bVLXHN7OoSxFMZKCOZMQyeQp4tPe5c77g5mW7z/4/293nL3z3P2Qo+amaJX3PD5Vp/JFmTQxSZ1gOKjamauL59CSREed/hLepziojZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hctd6/iLUNtc2uNBPC+o8fBRVbxBk2O8TdefxLyDGrY=;
 b=sdeJJ526RJpuZpYS6+s8BK4OeHs4X1MVT8c9xhWBaTi/Nk2hkIV2w3uyTDN0IU1OasWfkiump8JCC2y5hV/GqjlhcKTIzh+TRLp9iAsTAQPxiHtyKfUplyz4k5F85I9069jCBsE8cGWOjAURI7hwj1zSjL0EQRQjtkVF5DphjCKtbYkm7Y1PZu6BYLIEcmEMJahOtZPRtPm2nEMEoGBJRjWcudkVucGuVOoYMA43glHZJ2mQae43HYT0fRN0n7WE4XqjwiXiJ3Z0ITIeahEdchdvbsFgW1WGVJ4tR42ulW7cMFfv5D53Vgyh0aG3XmRIvVXslI0SO9AXjK6mayV6KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hctd6/iLUNtc2uNBPC+o8fBRVbxBk2O8TdefxLyDGrY=;
 b=fheqWYRuBZyCPnvLks/KrfO322gBLv0rc0aXIUtaZVgEq75cVkIKgirK6qnG4oO2qVw2PQMZ2kWDXV10UfyWA2mG3ruvFGa73jDxCKZmNDeWV5KNg5e7dVeERlpaM0ou8ER0vhMJktKx1Es0KrLaD7csQeLUhLQ2OxbUp1c2VKIvnZvPAI2ooDYna68oLuDvd4uEaV5ym/kbj1sOLU55VEDTfFLeAQiQWm/sC/MfW/WaBnKzOg35m6JZAH8PVP2iTq6J9YxED2JAL6HzdqPrKeztOjk5sLN8HgB5E2+dDKHjBIvP3NupJUjAlH4NyV6US2blo/mE7Am4BcheNRjqNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
 by PRAP192MB1482.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:27b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 20:37:23 +0000
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::f0e5:8465:302:9a9c]) by AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::f0e5:8465:302:9a9c%4]) with mapi id 15.20.9654.015; Fri, 27 Feb 2026
 20:37:23 +0000
Message-ID: <1eb39bda-cb9f-4435-b784-540f203c8ef7@codasip.com>
Date: Fri, 27 Feb 2026 21:37:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix dirname() handling in run_ptests()
To: Anibal Limon <anibal@limonsoftware.com>
CC: yocto-patches@lists.yoctoproject.org
References: <20260227100943.284203-1-florian.schmaus@codasip.com>
 <CAOU5ZMvo8MDDGTRYCJ7nc_mtg0hBQ2tXUD1P3_0z_kWgo22OVw@mail.gmail.com>
 <1a4d6506-cff4-4850-93c9-2bd4ce12a6d8@codasip.com>
 <CAOU5ZMuR6noT6pdL=QVHSrL95mmrvoLg1acHNu+j141ZRg7VwA@mail.gmail.com>
Content-Language: en-US
From: Florian Schmaus <florian.schmaus@codasip.com>
In-Reply-To: <CAOU5ZMuR6noT6pdL=QVHSrL95mmrvoLg1acHNu+j141ZRg7VwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::15)
 To AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB0983:EE_|PRAP192MB1482:EE_
X-MS-Office365-Filtering-Correlation-Id: 889cffba-1baa-41a3-6315-08de76400309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|13003099007;
X-Microsoft-Antispam-Message-Info: 
	H3qBZjxSLXV/wJImsVpfn61DGkqKHTHu2hH6JztB2UQ0CThDltkf0yNnlPfK22raUfHnj0E4NPSvG0P5acmUNYohFcl2ZV41SilUDZYK0r4MbVCxQe6+xk2jArPqbMd2tpv/U4585AzXAL6s+RxQ0N5aZmoFyR7kSlig6iFn1m8xO6gkh45JChaixXaVE24I+ZYjqbfAmHYXmLKnaA33idpBgsMGEhrav8I6NpMgzL4EWQMIB5GbxsrRIHB5Dku4R3WJmi07P5b15aIK8R+hv83kz6NpmRfZbxqaHoA8adT6RBGHgau1dqN8j/W0cFP4tD/z1xOgkiAvj+zoBB0U2c/pd1MQ3lxxKSTHQVRj8ELlqkA0Cv8q+rmfGLwLxfkKnclZfJE3NGQaJzzzP5BAhTH/WMzto2fq1jPrky1u17R3Uvo461ychiQRa9I0kzXhN6+RphiqVctkdExssy825VtcE7RS6QnSJFYafGXX3e2BDrCbNJKrqXV3fR1DJ8MzvHhpDfsXLDxnfp7f1Aab2cRUkZwMdGr5sUSXTby74uGze438Kdaui54F4bR/jM9HFipL2oKQE7t9RT8tCgpTpf6tXx+Q6h/4Dph79nbzn0W0Mq2cT4P7nKp4BiyoT6ODMhqhCSlcWHCbCTUt/FWxl3xwOMgKvcTekRvsB8ZnykjWyqfuuf/ZXnznbDLY1APu
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB0983.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ryax2Eeky+DBYvApUNRi09YmtqPKgtMmhpy+yX52PT9lHbeZDXTLZwBHGq+t?=
 =?us-ascii?Q?zcoyIfjscb1gTLJZpvw77nO0d9DEAol+SExEa6OKCVDG6LFF9eDU1yI7rgKM?=
 =?us-ascii?Q?SGyFPqLHVSdQski/THjngaGw+oXpm+C+F0OJDhjST2ZpKfAvdDxbS32WOazC?=
 =?us-ascii?Q?LMs2pAFHO8W6mGxJD4HKO8mGzqXlElHarzSEadM0pTgST+QZx8H/J/lVStz8?=
 =?us-ascii?Q?/xIp2dESwPO4TMW4fSfArNvSlMeIIDXQgesjlZf/u3KPqf3epj2vlDeeCb/z?=
 =?us-ascii?Q?CXYwY9mMZe2lq1nR7fgtSLYY+tPFoGQr3h1Qx9C3+UjKNPVvKU2hLSav7tIL?=
 =?us-ascii?Q?9ywPEy0s/16HIZLtDLLxrJrI0W49cUp18wUJgzUpiXCCO4xGl0WSpj57mStd?=
 =?us-ascii?Q?lVR8v85cPE1m92/SlFpeOctUW3kn4e1XDMQ36mNysQjOVz0Qgx8vzt+oAtft?=
 =?us-ascii?Q?ywkxwfGy4C0q6ExNlxDOCIcNHSo45b2PXBe7sAv03oywVDtDoMAUiedSdCy/?=
 =?us-ascii?Q?3xSSoEKkaiXGvbKMrl4rFcRK4YdmhCtqSjSiLV1+kTXRq6jDHm7tQTMhnDfj?=
 =?us-ascii?Q?2Va09cgLIjWxOtzhh8CoOlaFk6FYs+tX0fdDBlo7h6MqVfsxUWIt6ud+ucD3?=
 =?us-ascii?Q?vKLbTBRCCRoxWdzrIKEpyeFYKa2pW4ieM5L89emikBoXs3CA67vaJB9FA1op?=
 =?us-ascii?Q?r0EeKsh9MQJwvbfPq2u6F6+25z4T+SsOFjiUEQ9jAYanjVsFvFyyWcLD0puT?=
 =?us-ascii?Q?KwOlTXNlC1SmKq9WH230T1IGglwWdcCJcCC5wxlxMU4yuYf5xOZ0uL56oZJx?=
 =?us-ascii?Q?P+3B6W8VL6eIgg5Sna+n3rZZC/WlzLe3nYEElJHNUKj2v32bvrI5d690A6N9?=
 =?us-ascii?Q?aQ2P+uAAlzg08cECd6qTi6kn2n8C9QqvtLx1B4m8skIzhXgrDOc2NHgz/PVB?=
 =?us-ascii?Q?+MKBbu9fvRfdexyR3e8pvKckwjGJwJtkiEb6kDa7YgUoCSRHi10uYbwI/OnS?=
 =?us-ascii?Q?xuGAGYtOzQxuDWeru/qnHurGFlvROs6wmghYJW0ZwOJP3enpTahlAJ8QaIKZ?=
 =?us-ascii?Q?bURwU39d8b38TL7FLgBNzXNUdOn6as7gLXIpUmFuIVy3KBfWNVH8Q7oEe5gu?=
 =?us-ascii?Q?Vn4k1gQhgopjnPADUjFuSiPXjjHKzkLdBHRnemZW/XzCcIL+zMQ2VyWEo/TX?=
 =?us-ascii?Q?TAg4dZn98YxLVC5wRrAQiUgfHlNTcI++n3XHWb/ZinbD0VJh3EzDmDQNrnAM?=
 =?us-ascii?Q?3/h7tSWVgLDrYUQenkKkaio4lerHkrWnL42Pzx07Ir7GVn995QquC+L3Y3xb?=
 =?us-ascii?Q?RHOunxCPJmAj5K97w1GqGEUSf4y53oz/12iC1MenaEtx9QwVFtMdxGopiu6h?=
 =?us-ascii?Q?wC1qeqoHD7TNa/rKFAhbAZT5ttwhhsipARi46c9iGsH8yBVng2ru84uSAVf2?=
 =?us-ascii?Q?H2bu42vXwrnBcnUfFpoS+K8o4VPVCunWWltOV1chqfbOK+MSgqYiF6f9y+hC?=
 =?us-ascii?Q?DJN5eG3rT7N0AtkmgoEmwKmYOU84tlWxxOURdaTOFs9+w06ZzRXJP2I0IMys?=
 =?us-ascii?Q?tOXNVq8zFMhTStnCBPH+RDubM+3ZrwEv1fM/HkR4irrDCRKReUk60xEa3yXl?=
 =?us-ascii?Q?1mCCDvaAuAjUKWP2ignUjGm1P4tpHHCNWO7wR/9LNH0Mfj0QyWz7NMnwGeXM?=
 =?us-ascii?Q?nUWu6/L03+EFWOtIbZoIziUK8DSifeE+9vF+cjIQmrm9jLiabxl+uqwFvfUi?=
 =?us-ascii?Q?Piuxt2SCMZrz4zOX+EsQdebx51KiCC1C7JI7pWHlMsM4BazYD8NUHYpiL/Gx?=
X-MS-Exchange-AntiSpam-MessageData-1: U6tGc3jeFNfvpbFdHnUk2PKJPufOs52H7o4=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889cffba-1baa-41a3-6315-08de76400309
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 20:37:23.6003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/M+L0yujVCtovp9bqmD4hhmyGMCuG+vwOzW1Z81Kmu+6LhRTlFlRxhyfzexO1bq60D7GUl030cUgC59Q8q46xgUmgMDJJS8uozGJhKZBXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP192MB1482
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Feb 2026 20:37:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3306

On 27/02/2026 21.20, Anibal Limon wrote:
>=20
>=20
> On Fri, Feb 27, 2026 at 1:52=E2=80=AFPM Florian Schmaus=20
> <florian.schmaus@codasip.com <mailto:florian.schmaus@codasip.com>> wrote:
>=20
>     On 27/02/2026 16.58, Anibal Limon wrote:
>      > Hi Florian,
>=20
>     Hi Anibal,
>=20
>=20
>      > Thanks for the patch, comments below,
>=20
>     Thanks for looking at my patch.
>=20
>=20
>      > Can you refer me to the musl dirname(3) function that uses static
>      > allocation?.
>      > I reviewed [1] and found that modifying the same string anyway
>     doing the
>      > assignment=C2=A0is needed.
>=20
>     Oh, right. It's the CHERI-enable musl libc that is using a static
>     allocation [1]. I wasn't aware that this is a deviation from upstream=
.
>=20
>     But it doesn't really matter, the current usage of dirname() is fragi=
le
>     and should be fixed.
>=20
>=20
>      > [1] https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c
>     <https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c>
>      > <https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c
>     <https://git.musl-libc.org/cgit/musl/tree/src/misc/dirname.c>>
>      >
>      > On Fri, Feb 27, 2026 at 4:09=E2=80=AFAM Florian Schmaus
>      > <florian.schmaus@codasip.com <mailto:florian.schmaus@codasip.com>
>     <mailto:florian.schmaus@codasip.com
>     <mailto:florian.schmaus@codasip.com>>> wrote:
>      >
>      >=C2=A0 =C2=A0 =C2=A0It is required to use the return value of dirna=
me() instead of
>      >=C2=A0 =C2=A0 =C2=A0assuming that dirname() modifies the input stri=
ng. While certain
>      >=C2=A0 =C2=A0 =C2=A0implementations of dirname(), for example glibc=
, *may* modify the
>      >=C2=A0 =C2=A0 =C2=A0input string, this is not guaranteed behavior. =
Musl, on the other
>      >=C2=A0 =C2=A0 =C2=A0hand, does not modify the input string but inst=
ead returns a
>     pointer
>      >=C2=A0 =C2=A0 =C2=A0to a statically allocated string.
>      >
>      >=C2=A0 =C2=A0 =C2=A0Previously, ptest-runner would fail on musl sys=
tems:
>      >
>      >=C2=A0 =C2=A0 =C2=A0$ ptest-runner busybox
>      >=C2=A0 =C2=A0 =C2=A0START: ptest-runner
>      >=C2=A0 =C2=A0 =C2=A02026-02-27T09:21
>      >=C2=A0 =C2=A0 =C2=A0BEGIN: /usr/lib/busybox/ptest/run-ptest
>      >=C2=A0 =C2=A0 =C2=A0ERROR: Unable to chdir(/usr/lib/busybox/ptest/r=
un-ptest), Not a
>      >=C2=A0 =C2=A0 =C2=A0directory
>      >
>      >=C2=A0 =C2=A0 =C2=A0ERROR: Exited from signal Killed (9)
>      >=C2=A0 =C2=A0 =C2=A0DURATION: 0
>      >=C2=A0 =C2=A0 =C2=A0END: /usr/lib/busybox/ptest/run-ptest
>      >=C2=A0 =C2=A0 =C2=A02026-02-27T09:21
>      >=C2=A0 =C2=A0 =C2=A0STOP: ptest-runner
>      >=C2=A0 =C2=A0 =C2=A0TOTAL: 1 FAIL: 1
>      >
>      >=C2=A0 =C2=A0 =C2=A0Signed-off-by: Florian Schmaus <florian.schmaus=
@codasip.com
>     <mailto:florian.schmaus@codasip.com>
>      >=C2=A0 =C2=A0 =C2=A0<mailto:florian.schmaus@codasip.com
>     <mailto:florian.schmaus@codasip.com>>>
>      >=C2=A0 =C2=A0 =C2=A0---
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0utils.c | 12 +++++++++---
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A01 file changed, 9 insertions(+), 3 delet=
ions(-)
>      >
>      >=C2=A0 =C2=A0 =C2=A0diff --git a/utils.c b/utils.c
>      >=C2=A0 =C2=A0 =C2=A0index 6cf7705586bc..7614dce99bd8 100644
>      >=C2=A0 =C2=A0 =C2=A0--- a/utils.c
>      >=C2=A0 =C2=A0 =C2=A0+++ b/utils.c
>      >=C2=A0 =C2=A0 =C2=A0@@ -361,13 +361,19 @@ run_ptests(struct ptest_l=
ist *head, const
>      >=C2=A0 =C2=A0 =C2=A0struct ptest_options opts,
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 fprintf(fp, "START: %s\n", progname);
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 PTEST_LIST_ITERATE_START(head, p)
>      >=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char ptest_dir[PATH_MAX] =3D {'\0'};
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *ptest_dir;
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char run_ptest[PATH_MAX] =3D {'\0'};
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int pipefd_stdout[2] =3D {-1, -1};
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int pipefd_stderr[2] =3D {-1, -1};
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int pty[2] =3D {-1, -1};
>      >
>      >=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strcpy(ptest_dir, p->run_ptest);
>      >=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dirname(ptest_dir);
>      >
>      >
>      > strcpy(ptest_dir, p->run_ptest); // This assumes ptest_dir and
>     run_ptest
>      > are both PATH_MAX; perhaps improve with a secure version of strcpy=
?
>=20
>     Not sure if I understand the comment. My patch is using strlcpy() and
>     should be safe.=20
>=20
>=20
>=20
>      > ptest_dir =3D dirname(ptest_dir);
>=20
>=20
> I mean making this change should be enough
That doesn't work as it would assign to an array type.

- Florian

