Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F4ECA0EEB
	for <webhook@archiver.kernel.org>; Tue, 19 Aug 2025 20:40:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (NAM12-BN8-obe.outbound.protection.outlook.com [40.107.237.63])
 by mx.groups.io with SMTP id smtpd.web11.4178.1755636001509062691
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 19 Aug 2025 13:40:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=KCN3z/RV;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.237.63, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCSVWp1gC+YAVZE0orOrcvVLOn32P9761hCR/9fte4MlKR4as8UwkZXDpYytftTuPlSj2hO2WZwiUkC94Jb8dkCbCVQbeQa/ypEuutajk9oL/Sl+SfXq25LAnE+oHx42TkPmNGgA/laxestNFrtKmhjHzcTZtFNuvAlUUOMaxPdUs26u1WMpsXm2rBWfvLPr+/BqqMmoihiyY0vpjLAZzoxU13LJRNQJlOob9gG3025yuYeRkgcLzfcmbspOZ/Z3pQBZT7LVb+obgekRP/MyoHmSwsTz5T01JshAJSk836bqR+8yG42qx1kr4dGyZRwN76+myzSLCw3YMUI0+zdfxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+A3qWKNLv2m7RbwCCYXDC4IiqpWRb7k4a50/aUW9BA=;
 b=YTWImLxEiEXdCJM617x7045WazlLImZwm2uv6eGQwwj/cutB5NPdmEnakmeLpuisZGYtCX54UCF5ptMxMx2mDK4KDECDX7Aqrioo6qYvll33M5RwwSdbruEdwT9iS/fLDz+O6iCpY3TKbSjxmqjzZ4aw4DhDEVZeCTZvIVxBMWFf1gRY30QAVKdnkjD5bWBUD+Rp6DgzSVXXmcBqFTa/nFuWu8yj8eH2C65+cYig46tj/5iapJez4uL4A/k1MBmk28TC++C6M8OsngHot2BZeetxDQWSCae0eTFx7h6DvbDbnviNErp1XZ5mEbUjREfWU2uFUSb1SRpfMzLhu+Qrtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+A3qWKNLv2m7RbwCCYXDC4IiqpWRb7k4a50/aUW9BA=;
 b=KCN3z/RV0qzmJ3pexV+0NsiQ4MVvUfuvP4NiXODOmvIUU7T9IdjoOBmIk8ih1sBMNuUYF2WgguOE1ilqDGsK5Pye63NC28J8pxBjqijj80BbjA6CuI7iSdzJmTXWEw04rZ2rgWefAkKTEajn+Re6JD66sTzwspDqnjsUiVi7RdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Tue, 19 Aug
 2025 20:39:58 +0000
Received: from SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7]) by SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7%6]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 20:39:58 +0000
Message-ID: <8e385edc-9dff-43c5-b412-0b408c4e98f0@amd.com>
Date: Tue, 19 Aug 2025 14:39:56 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-zephyr][master][PATCH 11/12] zephyr-kernel:
 Add rpmsg multi services recipe
To: yocto-patches@lists.yoctoproject.org
References: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
 <20250815035449.2816001-12-sandeep.gundlupet-raju@amd.com>
 <BL4PR11MB8797B7EFFB60C164F9E3FD61B930A@BL4PR11MB8797.namprd11.prod.outlook.com>
 <7120910e-591a-4e1f-a105-d089b8f9f3fe@amd.com>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <7120910e-591a-4e1f-a105-d089b8f9f3fe@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH3P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::18) To SN7PR12MB8770.namprd12.prod.outlook.com
 (2603:10b6:806:34b::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8770:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a2037c-f4bc-496e-48a1-08dddf609012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|4022899009|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?IrlVp6WHosoe8qS6EUvLRQpKgCFOq7nSnyXRxtCkxwTS7uYpW3zRfmg2/PGd?=
 =?us-ascii?Q?gEGUTpYm7aewSdtVPl/Ht4gkGfVVOti6fSgmUGDaSt5xVf7zNrl2ThbVLd6n?=
 =?us-ascii?Q?uf3CvFUewJdi53Mi09er5S0LU8v4bhW5BVER8pNJ4DMsgo/SkBqhHGc1g5n9?=
 =?us-ascii?Q?C64QtTwWh1TJLhCvK16pQK60SzTTu0k0h/3GMgINDNqDQRv0GdpvRwxT8OUq?=
 =?us-ascii?Q?KBb1GiA6vy7qCUDiIENKVC4HbDK2iCHng+WUjlwr1LxjJaGMvzu9uxhNpLC9?=
 =?us-ascii?Q?stjQDCVWRGlJE9hCQqhAWujx838TGPc56UBSfaWM96MFh1h8QZ683+a8JBfc?=
 =?us-ascii?Q?yaWtYjiFyNKhI5eOjxOwPzGIm4xprLCjJS0nhN2PMJnK9wD76li//P1oMGuD?=
 =?us-ascii?Q?ng1J+/K+CKu7DppwSWRbNu6eczWh27p79RG6FnKeXty71/STdbhwiPKYfb4n?=
 =?us-ascii?Q?+dbikvWx/q5vnZiPmBC6AGXodn5B6BQ84/rAYGBue5X8eYlYjU8eDSQINOlI?=
 =?us-ascii?Q?hSkWs3kKi/u2DWRhsYMM+Yu1KsW352rMuLu5xOP3vm7f07+zcs+etXaOaCHc?=
 =?us-ascii?Q?cXLyXnbzjxU+ayo//mG/Fna53HG/uEOEDI4rNqTGQybxw804rNhqGZX9K2fv?=
 =?us-ascii?Q?l95PGbY7XG+CSXdEIEd7NlTpUyMXMp5VFT11k8btrmk5EMCw4fi9kYP9mway?=
 =?us-ascii?Q?hm/CmDPBUtHIkqzb0+LbrmGMmQtVPuQdXMXRDyXpAoc4TPt2UMoQu3kOfkaT?=
 =?us-ascii?Q?rl6B31hVbx26BiSYJCA+0OuqqCJ+5nqay3ZiPCPVtnujDXhAyRBKo/FaF+s6?=
 =?us-ascii?Q?5TZY8e1MRLNyZQ/hkuL90GDPpyN8dzaNO7AsjTXMULw/pWwc4DQwyadjAQtF?=
 =?us-ascii?Q?+ci1MyYYM7tQDuWiKT3nJF3x+jRNCVTTAjYrj0xxIjeop5KB2xDgpqQAJtzi?=
 =?us-ascii?Q?atQeG3DQ71Ocr8jszzqCcJnSeXiMLx7g932cnChF9o25e9Tm01REC1/WHoHU?=
 =?us-ascii?Q?SVeFTkUVr5bazpgA9er7gPn84ZZR6dn+GitSm0FWgmL9vyxd4mqrFTLebHwB?=
 =?us-ascii?Q?FQy5ZoRr670lj21TQ7MFuzO4h4KXZCXbAZiCZP2ogu7iqk/AMddWWBGYZN9F?=
 =?us-ascii?Q?w3qQ7aTUJXO2AFbSUdeUnvSL9tVvL8owJO9geIdjfTkfn0+88fVqeGthCy9D?=
 =?us-ascii?Q?3vNpLf4SMz7l9OKnS7gizPbkqvic6xXhpycU5a2kxh/eg4MIf1TuMl0h0JQM?=
 =?us-ascii?Q?rH6bbFeYZ5SchLiGNdj4EgfBOFT17cag+4YdiiWN12HeJwvBgqP8EcT1AqX4?=
 =?us-ascii?Q?09vdLzduQb4egbyUxacbN6/XEk0GP5gl0IWErvWdeKgN2kfvwDkSK5ELEncU?=
 =?us-ascii?Q?dMCPMFM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8770.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(4022899009)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aaqPdY9D0ZkQCFezdTfzvISm5Iov7XdRJ0AML442dwaXfylwHykLlMBnV9gY?=
 =?us-ascii?Q?F4xjmWNU4vX1bcZz8SQ29rh4DTp0iGoFUUd0ybfPRc/IBQ8jwJlhVZrBWJHv?=
 =?us-ascii?Q?iBnimPHeuvTeHU1kAu3rzMjh0nDkIlbk1RO0ytyh8CdgR9WQIZZC3a05fKoh?=
 =?us-ascii?Q?smQCqeC7IGF8RB4l9MbE8rCYt/LgaJ3bwqj0syz7Pqn/CjXCn8zWLAXyhZ/w?=
 =?us-ascii?Q?oR8A3KszUO288lmnir3co+mXiWyxDs3S3V4B7RNgij/Xx0jQYvYRv65zlaKV?=
 =?us-ascii?Q?F4xmBE0y1Q/7Gx8DVQimmnUYqbLoFBvSh4gpvo4b+4l/sngabEJuMyVHb8mV?=
 =?us-ascii?Q?azn+svvp20kEB/CtiCqeBbHZJh9sczoBLrGLLT3M1AD0FkuHTiMD1bJRUhBg?=
 =?us-ascii?Q?qP7SD1YDKOveOcXpLuR1SZkyWR6zbzf+CWXNlRSYd+/q7Gdevyy+fBosimSA?=
 =?us-ascii?Q?NDIlj4yVNGbjBc0ykKgRmsejANoUncmVwtp7LUgBVcG1iTGA0+ixNnKKh1Mv?=
 =?us-ascii?Q?TuHR4nydQarnc6Lw1kDe2l1szyQQufE6RhVurVst/fr7M4B6YEdeKujzhrjB?=
 =?us-ascii?Q?CCFyPqOtW6MgecxzNqlH6yRj+jVl8n5Ig/15HhRJssDkksT/pyPH3k2Ez4hb?=
 =?us-ascii?Q?pbLhhlDiSddm1Wy5haLWen23r6wV79kJ7cEoEp55z025MBI91HtpPo3LNiM0?=
 =?us-ascii?Q?colVe6rx/XXfcdLZczQ3jbKx0YG+msnE9NdB7h699ggukk8wtVP03FyGaonl?=
 =?us-ascii?Q?Uv9FsVI5CfwXvAu3pwqV0uNvyb3dj+P4Rp2qAKXQvOlVunQGX/YHEMB0kNPw?=
 =?us-ascii?Q?bYwG6lxANEZpjHEH95AuSj5kilqZrEssFUb4hEt9EiBDCNFpMkcl0pOeHI59?=
 =?us-ascii?Q?A9vHNWk2jgL0E/wa7Fj+PUyWLxD7bJ+oF95wfPjWv7QwPDWLk1lM1DfXN+5v?=
 =?us-ascii?Q?hdLuT+dMANmQaNJZ+gGW0ri9NOz0N5scsNImJy/lOFL06Nq3el028L9RUzSz?=
 =?us-ascii?Q?jpvr5xl2NLH2KoqN55t1cw2HUVRVP13J1jBNy0b5lU4PDPcCwapn0oSPTTAr?=
 =?us-ascii?Q?3HCRN7aPgwapia8aZGY0sw1FT3qUJt3M1SSb8Cxt7mq8qVQx7aC7Pbr0XMHF?=
 =?us-ascii?Q?xIjLi17fUoVIHITQtgUAFMPfkT7N87UmZig4mDHfn8Frn+G8YMLD5Y5zOVpr?=
 =?us-ascii?Q?hG2bl0EydHCKKhmtOGUSz/tp7wKKLoOEJsKA5eMXHWqdAplS9zfoQKB/nSuT?=
 =?us-ascii?Q?wdpcotLeHvy6YGo3Ir6N0exzQaXG0D1RmeAxQ4fD7oFsfHk/9LTfOE3SvZLG?=
 =?us-ascii?Q?zXb88v+MCizwqOkhXFo9AhWhcNv5HIP4nQtgZFbWkv09L+tc7hemTEqC1nMp?=
 =?us-ascii?Q?jAETgB1Zr6YYjtxu6gg9ok7NCjB2LSuWUMnCsqDMB8Xe06RULCKKN2FPvjEn?=
 =?us-ascii?Q?7DbGpFQF8r6tVH0gneT2/yAyUbuFOnwJbCMgKpgdYTqMktJEQk0dtfCsRMRr?=
 =?us-ascii?Q?SzULdcAZYhsf1e1hMzpth8U5JIPAMdDwSTc5JI0ww8jbSht7diCb5u+Wys88?=
 =?us-ascii?Q?yXTdvaPuazZLnmFtf59YvleKSPYE52ai3YwA9Pvf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a2037c-f4bc-496e-48a1-08dddf609012
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 20:39:58.4654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZQKt+0q2O1eJTTb7fkd8XyexoWbxheu+vGTYWfslh0oTYkax51IQR8tgqZrsHEGsz8Nd2Q6ysTyB+U26a7Zxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 19 Aug 2025 20:40:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2060


On 8/19/2025 1:43 PM, Sandeep Gundlupet Raju via lists.yoctoproject.org=20
wrote:
>
> On 8/18/2025 8:02 PM, Lee Chee Yang via lists.yoctoproject.org wrote:
>>
>>> -----Original Message-----
>>> From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
>>> Sent: Friday, 15 August, 2025 11:55 AM
>>> To: yocto-patches@lists.yoctoproject.org; Lee, Chee Yang
>>> <chee.yang.lee@intel.com>
>>> Subject: [meta-zephyr][master][PATCH 11/12] zephyr-kernel: Add rpmsg
>>> multi services recipe
>>>
>>> Add zephyr-openamp-rpmsg-mulit-services recipe to build out of tree
>>> openamp-system-reference example applications.
>>>
>>> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-
>>> raju@amd.com>
>>> ---
>>> =C2=A0 .../zephyr-openamp-rpmsg-multi-srv.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 23=20
>>> +++++++++++++++++++
>>> =C2=A0 1 file changed, 23 insertions(+)
>>> =C2=A0 create mode 100644=20
>>> meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-
>>> openamp-rpmsg-multi-srv.bb
>>>
>>> diff --git=20
>>> a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-
>>> rpmsg-multi-srv.bb=20
>>> b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-
>>> openamp-rpmsg-multi-srv.bb
>>> new file mode 100644
>>> index 0000000..222ed2b
>>> --- /dev/null
>>> +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-
>>> rpmsg
>>> +++ -multi-srv.bb
>>> @@ -0,0 +1,23 @@
>>> +SUMMARY =3D "Open AMP rpmsg multi services"
>>> +DESCRIPTION =3D "Open AMP rpmsg multi services"
>>> +
>>> +inherit zephyr-sample
>>> +
>>> +SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF ?=3D
>>> "git://github.com/OpenAMP/openamp-system-reference;protocol=3Dhttps"
>>> +
>>> +BRANCH ?=3D "v2024.05"
>>> +BRANCHARG =3D "${@['nobranch=3D1',
>>> 'branch=3D${BRANCH}'][d.getVar('BRANCH', True) !=3D '']}"
>>> +
>>> +SRC_URI:append =3D " \
>>> +=C2=A0=C2=A0=C2=A0 ${SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF};name=3Dopen-amp-=
sys-
>>> ref;${BRANCHARG};destsuffix=3Dgit/open-amp-sys-ref \
>> should be " destsuffix=3D${P}/open-amp-sys-ref " for master branch
>>
>> I was facing error while building this recipe
>>
>> CMake Error at=20
>> /data/master/poky/build-zephyr/tmp/work/qemu-cortex-a9-zephyr/zephyr-ope=
namp-rpmsg-multi-srv/4.1.0+git/sources/zephyr-openamp-rpmsg-multi-srv-4.1.0=
+git/modules/hal/libmetal/libmetal/CMakeLists.txt:1=20
>> (cmake_minimum_required):
>> =C2=A0=C2=A0 Compatibility with CMake < 3.5 has been removed from CMake.
> [Sandeep]: Let me check why I didn't see this issue. and send a v2 patch.
[Sandeep]: I was able to reproduce the issue on master will send a v2=20
patch now.

>>
>>
>>
>>
>>
>>
>>
>>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2059):=20
> https://lists.yoctoproject.org/g/yocto-patches/message/2059
> Mute This Topic: https://lists.yoctoproject.org/mt/114713062/8188369
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:=20
> https://lists.yoctoproject.org/g/yocto-patches/leave/14211927/8188369/518=
048116/xyzzy=20
> [santraju@amd.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

