Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CC9C87FD2
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 03:18:03 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (NAM02-BN1-obe.outbound.protection.outlook.com [40.107.212.70])
 by mx.groups.io with SMTP id smtpd.web10.40016.1754882276729468293
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 10 Aug 2025 20:17:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=VxzSBj+T;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.212.70, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6xg1gg1Bg5w6MGAYT4m36G7MF0Uc+a8NCWYsKBJwAoRQbb6v0cx1ft6vy7v+pql5frnguCCkfjfI9gErv4MTPNx1CNHRKdTuitN6jcve95Q9kqybBurYcg7zxmOd446cxRygAiVUR8s5U4zuuZjSF0np8NmK7Vom4VD92PBV5nI4UgesL9hahTbNfIE4cDfx0aXok4IcmDEtJt5NeQtktmxhjobPx6yUhgJvmOpUdpmuFCZGTb+tlhS+gyXpxnvRl0AmpLmUXpktgD3wsow7AtajnopK+V/o3fv7AJ7hiAM3OhK5bR4p3zKWKvbJEJ+5moOjVoUIo1KDbBEnuKjVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbkgdpHpIw7eVFQsqQxCRF6zOf9ywRTRzc4KvLzRKqk=;
 b=fQPv2T2vLV16nqQsgX51qR4OCpoUODjKkaulJ7rw/UuvRc6t6SEqrFH4IpLfQA1JWDaPmQdZxQ1SMH1UeCbtKpPw6ZnEw2BvnENOOezBAhW2vl5nH6YEnjeLKBKgIroTLXcpzXutrlmxqGG9jupVMn5/QcxEnnyqR3b+JGscJ4NLyaeG00XrpIaQZcLm3mo0PURPJ7hsJkgk4elchobeSUO+MIbx1mmp0YfzqmyhEFxQq8q0luYRRLbv8hj/ia4da7t0sR6EmI6gam1r5MjXGrxS77eosuZ/1tsVKDq559H57IL6lUAbL73AYZxiQYQsDdPILRcP9xigBwWr8hG6cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbkgdpHpIw7eVFQsqQxCRF6zOf9ywRTRzc4KvLzRKqk=;
 b=VxzSBj+TMoGLTwOkwtgfUztdlULv4EHwqfH9ArGMqeAwxgulWpAowylzrfulX8DKPcEiVJLugbxC1vDFO6WVp6ASpY7WpYjxQf89maa9YDwBinzfoKhZ3tHYXEnuEa1RZMAXboJF7RzWiuNzPwfPpGRSASLiNRUV6HlypxG7q3I=
Received: from SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
 by PH0PR12MB8032.namprd12.prod.outlook.com (2603:10b6:510:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 03:17:51 +0000
Received: from SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7]) by SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7%6]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 03:17:51 +0000
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, "chee.yang.lee@intel.com"
	<chee.yang.lee@intel.com>
Subject: RE: [yocto-patches] [scarthgap][PATCH v2 0/12] Update for scarthgap
 release
Thread-Topic: [yocto-patches] [scarthgap][PATCH v2 0/12] Update for scarthgap
 release
Thread-Index: AQHcClAC1Pcurpw+RU23CTn53EqxVbRcyFlA
Date: Mon, 11 Aug 2025 03:17:51 +0000
Message-ID: 
 <SN7PR12MB8770FADB218EC3273144368ADA28A@SN7PR12MB8770.namprd12.prod.outlook.com>
References: <20250810233911.1259884-1-sandeep.gundlupet-raju@amd.com>
In-Reply-To: <20250810233911.1259884-1-sandeep.gundlupet-raju@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-11T03:17:36.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8770:EE_|PH0PR12MB8032:EE_
x-ms-office365-filtering-correlation-id: 13f21d73-7cce-4c74-a382-08ddd885a7eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|4022899009|376014|13003099007|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?OMmRjhkLzxpt4IvjAUuR9zrdiUKs6RC0V04L3wX0lfNMGi2DBIXP77XOxOdE?=
 =?us-ascii?Q?3y64adSO48rXyz96Z2h0WtFjJFboRwM89HaZP5W9bWa7IpduNDJAAaZ0hBfb?=
 =?us-ascii?Q?UcpVn9qP4dkWe8TsjtOIOQswyCGOAKkHq4JiAQu+yjgN186a0urtM1TfRP3Z?=
 =?us-ascii?Q?fs6F9at9qTKDXh5r7eogSsimewbLt1b2G5mziWyAnLQXctM6QXINvChvmHOm?=
 =?us-ascii?Q?ASdb8yE6NuKArfZPqBmN10qbrr25kQlneSDByHb57er+ma4gNee79LCA47kc?=
 =?us-ascii?Q?MpNrz3TsyoKKLTn8SbHOtJrCEdYW5MwhV3xZ0CKSrCiwoSdBtT+aVXKqM2tH?=
 =?us-ascii?Q?7KZCxaDBjFfz2rLu/cOqAlePP/1pBQekroYuOKEIDWoz3QNxWFpjqLBQFxVG?=
 =?us-ascii?Q?8k62QtVnw4W8zGcs98XBxmemFPgdktW6WmXw9d3/mRUCi3CTd7/uwNPpfu0y?=
 =?us-ascii?Q?2hcbExEoQZK3Mwg62ilvunO2jZng/3EMRtlNtUtP3JTixfYJVSIAoizVuc7a?=
 =?us-ascii?Q?5QyM3zx9ZiIkCbRMXt9yZ/86LCvASEZhOpzxhmSV9SQOKYsV1kik2aLXtOtu?=
 =?us-ascii?Q?fEMgw0OzHy0Zfigj/ndZRjYA5HNjKiUcg6sGeox4wTS7bFHW6DDddpY2yI7T?=
 =?us-ascii?Q?jfgd2ThTEck+nmvR01VD1XO8Jhd6I8OFfcjDyX2PLP/PkXBuX2V6A7DR+EJh?=
 =?us-ascii?Q?jaZNh20aVVDKZu+uX7QBoQho+riW9E8ZjTUBVksV09DYo+H5qYAQmrlI9x1e?=
 =?us-ascii?Q?b4zza4T3GZufyEEWx2aHrifKX/VvD21q1L5ve6lmKvZhXdK1Ta3WkCq33Cfd?=
 =?us-ascii?Q?KTz+18ERDDBd8r3v7UONuE9m80X4B9CLVBeg9NBruUP/JSOzmF2xVzumGjNT?=
 =?us-ascii?Q?eKH642DqVQaxqp8I7+31i3yLRDJfcsJDrWPxMBDp1BlDsMG1yNKoReEf9Jhk?=
 =?us-ascii?Q?ZWLehRl08vqMpaGrl/Qxi+oyX0x3q17Re053F2GIuAJMSh6McPMfUZ8s/gwM?=
 =?us-ascii?Q?YLz/eht68WnWNVX6NAkladpfShHwYTET5z5tGX1JM9lL4Q4mx8hCWYkWlMWW?=
 =?us-ascii?Q?HvH8tEkC5CG8Skp53naXYcTFg7mbIOkYPFGIh1qgSQKoCnaj2v6q/+uIvUVw?=
 =?us-ascii?Q?BdWKQEQnDFyW162a0cT6Ma923E8BxgUjPmMUCqPUqGCQZg11MFPcduGpTF2I?=
 =?us-ascii?Q?hRalOIbLZZXw/Ei7f3bWkZeh2c2iKL//7VQvjDrbKNZ5JCXCQkJEwBW9ih3u?=
 =?us-ascii?Q?p+YMGoR2tv/F+W5418AJ093Jl47chmxxTL5Owv8Cu7318QdHgkr9ChO9YQss?=
 =?us-ascii?Q?3QIFNden29MNjatmR3VI+aRlU0DEKuudwdervEnSsk5ohHtsQn5ntoPC5GkR?=
 =?us-ascii?Q?83zeDhZbPdvVXYHqaOOD3opY68pr+BREbs9lVZ+jicll7aKCwBo/VMUBa92t?=
 =?us-ascii?Q?OupY2ODi4dk=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8770.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(4022899009)(376014)(13003099007)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?7zPhRrUujZU2Eg9GiYCPVpXNL298nMMKqj6t5Gft0qSUwjh1cVzJm42SNcXE?=
 =?us-ascii?Q?F8U0G1TkmMqsbUATjODSKkiaAHSUKSzho7iT0bFoiFwNdIAttgBX9FwX6bk/?=
 =?us-ascii?Q?NQXMzYuK5RMJSR+3Y94bMfY9ge1Ykey/EWC4vgcp7D4LsZ9OcsKOmA2e9VEa?=
 =?us-ascii?Q?BAxHzF52ns9IYbRpDdBNJ52xAxrn5OJtKGNaNArwlzDOXiJk2etzxBQ2jH4J?=
 =?us-ascii?Q?hQO1PSUySxVwFu2mTNP/sFYyzRjLT3pBmRZJ5Op7QpVvZbLq9bXdG/cE9RZp?=
 =?us-ascii?Q?dBo76XlX/HR+mvAbaM7ok5lKoZnrCYUFXai0ABfaGWH5cBp2jZMeihlc4GVh?=
 =?us-ascii?Q?IOc4ElRgKycSfOT+2o6Rmb57WcNk8nG92vCbeA46afUZpwWT7gQ9VKt/+0aW?=
 =?us-ascii?Q?UJrjfDNBTGziuvxWX4FeIUjuezT53A6irT/FwTRErgQK8CBiNiVvTXzpbZRQ?=
 =?us-ascii?Q?1N3lf0OBCrQAkiJ4zk0BILT2JDYENpmqYvJck6CDtg6QCHXqOS99sT9Rp2AI?=
 =?us-ascii?Q?egc/emoyqH5e7onxkVxaoeexnc3nY8xLGMpTycJEYMESNavIsgB39q4V0CBJ?=
 =?us-ascii?Q?OO5mKPPaa35xjZIlsRCSQs92ZubitZvIiEU8uGRthRyHLEM5wrFs4ex65X4X?=
 =?us-ascii?Q?pMLA3MqQvsW0icLM9koanykFB3UtnUePlOAxTMQPnvzlH/qc6wkAA9sxTKf5?=
 =?us-ascii?Q?gdKJyQorhWrMHFKqW5LUlD6+3mflrKl7RdH7389FCYG+T5mWnJwPqQkgQIWn?=
 =?us-ascii?Q?bQ8aJg5vy6QU/6gQMcvnen2QPyZMfbRRiL+xtcIdvFsXzRYjwItY9ViBL17+?=
 =?us-ascii?Q?t2ynN/dbwqDXZsCv/sMci4XJ/P7uFmufaTBdf2wyTxbPrR2PAAMlzq4WN2fW?=
 =?us-ascii?Q?8bBxCNAzsGUHNos2Mfgiy4ro5f8W5G40FuBlZJA8eSIdXSXpVUer7391H1dX?=
 =?us-ascii?Q?VXZrPmUt2p0cjbQVXIA4TCXRlq6OOnUOxnqStdO1mwEDw87ajvQpvWhOvd42?=
 =?us-ascii?Q?XrhWvS47BuhHZJ81IVcbW8P/XDmjY+8QGxTG416jSEFITISrgHX7oWnMhq8H?=
 =?us-ascii?Q?njvylJxp+Tqc6EpR8H0sPJz046mdJyOlZ/OTQ1+mpuNQpcr9Xtbw61WQmPlV?=
 =?us-ascii?Q?Vu2xLMB3QndyyvYzDf1kddzdp4oPtDPgWBp6Y0zz7/QRzhER1rniWJV+kocQ?=
 =?us-ascii?Q?Ft7zKhr1UI023B7uYo7axS2VGjIEeZBmZs8QcpkZwlxGKbYZYO4luSFZnGsq?=
 =?us-ascii?Q?icZ3fLl2fSn2uh4vM+oJxF1nolI34PROiwbg6y++D0pcDZyxDsdzsI3LQCFv?=
 =?us-ascii?Q?tW1cheGb6NVtl6h+NnHK8IVMcR95Nssa3MpCvWkpI/LF9kx6FsDQQx+2pTeu?=
 =?us-ascii?Q?gJCqpTtFDl9qy+fMCoE2aTRXKodLaef8F/kdj+OlLtItozecv8fiCHW0+4Ys?=
 =?us-ascii?Q?/hRcgk12DiK10IQ4yPtwIKKpmJO9hJY3gbppeyE/0z3PCEeHmp/aO58I5H/l?=
 =?us-ascii?Q?p/kcQd1kBE4C2h4uhpL/YSjwADjCI8RkshxZidLduEZn8liV1pACYymh6vXt?=
 =?us-ascii?Q?/XSQAEqah3oxhQh6Y2Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f21d73-7cce-4c74-a382-08ddd885a7eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 03:17:51.5789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ziuvYo44Wy5oMzkjGz3Gpy05n9SDC0/+Uans+1iiOkftsEHThsUI1Xd8ruWGmTFEgey00QR85PFB+SkNPo2MTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8032
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 03:18:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1923

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Chee Yang,

I'm still working on port forwarding these patches to master. Once ready wi=
ll send the separate patch set for master. If you can get these patches rev=
iewed and merged that would be great.

Thanks,
Sandeep
> -----Original Message-----
> From: yocto-patches@lists.yoctoproject.org <yocto-
> patches@lists.yoctoproject.org> On Behalf Of Sandeep Gundlupet Raju via
> lists.yoctoproject.org
> Sent: Sunday, August 10, 2025 5:39 PM
> To: yocto-patches@lists.yoctoproject.org; chee.yang.lee@intel.com
> Subject: [yocto-patches] [scarthgap][PATCH v2 0/12] Update for scarthgap
> release
>
> Changes in v2:
>    - Move classes to match bbclass scope functionality.
>    - Use relative path to follow best practice.
>    - Convert zephyr-sample inc file to bbclass so that it can
>      be inherited from custom layers to support out-of-tree
>      zephyr applications.
>
> Description of change:
> 1. Fix runqemu errors for qemu-cortex-a9 machine.
> 2. Add new inc file and update to 0.16.9 version for scathgap 3. Remove
> PREFERRED_VERSION_zephyr-kernel from zephyr-kernel-src and
>    move to layer.conf
> 4. Add image artifacts to output files and use these files for qemuimage.
> 5. Add Zephyr LTS3.7.0 support for scarthgap release.
> 6. Update README files.
> 7. Move classes to match bbclass scope functionality.
> 8. Use relative path to follow best practice.
> 9. Convert zephyr-sample inc file to bbclass so that it can
>    be inherited from custom layers to support out-of-tree
>    zephyr applications.
> 10. Add rpmsg multi services recipe for openamp.
>
> Testing:
> Run the following commands.
>
> $ MACHINE=3D<machine-name> bitbake zephyr-helloworld $
> MACHINE=3D<machine-name> runqemu nographic
>
> Summary of changes:
>
> meta-zephyr (scarthgap):
> Sandeep Gundlupet Raju
>     zephyr-kernel: Add rpmsg multi services recipe Sandeep Gundlupet Raju
>     classes-recipe: Convert zephyr-sample inc file to bbclass Sandeep
> Gundlupet Raju
>     zephyr-kernel: Use relative path
> Sandeep Gundlupet Raju
>     meta-zephyr: Update README files
> Sandeep Gundlupet Raju
>     zephyr-kernel: Add Zephyr LTS3.7.0 support Sandeep Gundlupet Raju
>     zephyr-qemuboot: Use image artifact file in qemuimage Sandeep
> Gundlupet Raju
>     classes: Move classes to match bbclass scope functionality Sandeep
> Gundlupet Raju
>     zephyr-image: Add image artifacts to output files Sandeep Gundlupet R=
aju
>     layer: Set PREFERRED_VERSION for kernel and sdk Sandeep Gundlupet Raj=
u
>     zephyr-kernel-src: Remove PREFERRED_VERSION_zephyr-kernel Sandeep
> Gundlupet Raju
>     zephyr-sdk: Add new inc file and update to 0.16.9 version Sandeep
> Gundlupet Raju
>     qemu-cortex-a9: Fix runqemu errors
>
>  b/README.md
> |  163 +++--
>  b/meta-zephyr-bsp/README.md
> |    5
>  b/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf
> |    1
>  b/meta-zephyr-bsp/recipes-meta/meta/generate-zephyr-machines.bb
> |    4
>  b/meta-zephyr-core/README.md
> |    6
>  b/meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass
> |    6
>  b/meta-zephyr-core/classes-recipe/zephyr-sample.bbclass
> |   10
>  b/meta-zephyr-core/classes-recipe/zephyrtest.bbclass
> |    1
>  b/meta-zephyr-core/conf/layer.conf
> |    4
>  b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk.inc
> |    3
>  b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
> |    4
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-3.7-x86-fix-e=
fi-
> binary-generation-issue-in-cross-compila.patch |  106 +++
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-blinky.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-coap-client.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-coap-server.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-echo-client.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-hci-uart.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-helloworld.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-http-client.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
> |   28 -
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-3.7.0.=
inc
> |  274 ++++++++++
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-all.b=
b
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test.bb
> |    4
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-lvgl.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-mqtt-publisher.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg-
> multi-srv.bb                                         |   23
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rsc-
> table.bb                                               |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openthread-echo-
> client.bb                                          |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openthread-rcp.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-peripheral-esp.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-peripheral-hr.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-philosophers.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-synchronization.b=
b
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-websocket-
> client.bb                                                |    2
>  meta-zephyr-bsp/README.txt
> |    1
>  meta-zephyr-core/README.txt
> |    1
>  meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
> |    4
>  meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-sample.inc
> |    1
>  40 files changed, 594 insertions(+), 95 deletions(-)
> ---
> *** Instructions ***
>
> Technical Reviewer - This person should review the changes for technical
>              accuracy.  They are expected to ACK or NAK a change before
>              it is merged.
>
> Gatekeeper - This person decides if this is an appropriate change to make
>              at this time.  While they do not need to perform a technical
>              review, they may also do this.
>
> Issues -     A comma separated list of Jira references for the changes in
>              this request.
>
> Description of change - A verbose description for the changes as a whole.
>              Each change is expected to have good Summary and Description=
,
>              this is just a general overview to help people understand
>              the set of patches as a whole.
>
> Testing -    Describe the testing you performed for this change set.
>
> CI Build Information - Various fields used to control automated CI test
>              builds.
>
> Summary of changes - Automated summary of the changes included in this
>              change set.
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1910): https://lists.yoctoproject.org/g/yocto-
> patches/message/1910
> Mute This Topic: https://lists.yoctoproject.org/mt/114639391/8188369
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-
> patches/leave/14211927/8188369/518048116/xyzzy [santraju@amd.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


