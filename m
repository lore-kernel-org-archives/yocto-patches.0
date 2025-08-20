Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F92CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 18:59:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.81])
 by mx.groups.io with SMTP id smtpd.web11.5357.1755716338573435280
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 20 Aug 2025 11:58:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=f/Us0fTW;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.94.81, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpF/qgQLVTsfaYS70KtcxZJf03bwUx9xzDgWJHUKUHQtZoENdWJKkw4p1d+mwYBizCE+DmLrFSyeQIqk93vkYujrvoC11fNX+PTLdPMRzpFLV7glQutii2gbn/72lej12C7K//ueshWB20utu5eWCGOxAs9nt/NW+At6E1k8hTo864vcdwrzA3nAVnxzOga93MWJTCNhAz36g+JfGIPlt8gQIKVvRCKoL5Uje772pPc5RaqObv5ChhN+B+zGS1OtL4F48HmJwZMUQGkUPcu1q6KPwY6PNGtkVz2ps/VIZM8FBzZ5xVYgpYvWOkZ4NW7G9L68T8vqO0kySQbesQi9Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IqZR4TAXV7oBWKVYvsIZGA927uMKZdIUdoXvBqF8/k=;
 b=xLPO0cVYSEdTjLio7HHQ5xl3fHNSz75WwWuu0DwiuXyhKK0155gdCC+ocXg4DA61gqw3bCy5yMgcLpIF5HZLoyFoO0vN5rUKyCYEjvsIbClHyqGefigz4CAaGxaryY20QUa8q6fEdMJBufZmSPMmHovJF05RFkwdscro9Qjygg8qhmYo1j6B8xFmJFgriNWRrMn/uzjcDZ7ZyG7qssECsrgbHs9GuTvVN6D0N/OAA6UVzXFI1rPTXsMJbKGBSSUQpQ5PKicd4rN7fe4Xg08L2iOm62WKmpnqYawEhrIaSLd/0VJ0rIybWwWCn0TMgQ9CAXtgdUrNxPnFbKuxiX2l5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IqZR4TAXV7oBWKVYvsIZGA927uMKZdIUdoXvBqF8/k=;
 b=f/Us0fTWI/vD1+gjqhL+MZff8VG5FujJR+QEmi6ZEh7tGkG5cswbd3BO16JzwhZGoK9M77Ow1uUQB3OYpujyVn+RDzRdw9uGFt38kXxVpLJy1O2yLIazHTbbw8475RtyaqybyzlJvGZGXOeUWE51uP51nhJsTugIfQuXgLnNbmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
 by SA1PR12MB6751.namprd12.prod.outlook.com (2603:10b6:806:258::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 18:58:55 +0000
Received: from SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7]) by SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 18:58:55 +0000
Message-ID: <d16c3447-77c2-40ed-af75-91c1b4bc37ac@amd.com>
Date: Wed, 20 Aug 2025 12:58:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-zephyr][scarthgap][PATCH v6 10/11]
 zephyr-kernel: Add rpmsg multi services recipe
To: yocto-patches@lists.yoctoproject.org,
 "Lee, Chee Yang" <chee.yang.lee@intel.com>
References: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
 <20250818220304.2300436-11-sandeep.gundlupet-raju@amd.com>
 <BL4PR11MB879791DA10D548D88531B23DB933A@BL4PR11MB8797.namprd11.prod.outlook.com>
 <185D7DB1A09D3E98.23467@lists.yoctoproject.org>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <185D7DB1A09D3E98.23467@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN7PR12MB8770.namprd12.prod.outlook.com
 (2603:10b6:806:34b::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8770:EE_|SA1PR12MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7e000c-5f04-4591-74da-08dde01b9cc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|4022899009|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?WyRpCc6+o6nJyo+FzvQ3LLfP67KhbFK5k4EGdOneQpa4hxOVqAcp9YFt+UnP?=
 =?us-ascii?Q?6Og63X6/LNL7uoH0+piKJlqASAGCv8yTAWcF0S+WDCqON8YCmqzUwlN7Gw+G?=
 =?us-ascii?Q?AbxlbT7e/r8ewlHOQIFMZfEL8yT2/5XLuxtf9OWYxAzcG02KwFb+iaYVtuTA?=
 =?us-ascii?Q?MIl84BVfhfHsfvqBZ3F+L6SBCxk5t8OHJS1zDcNugZ2zHSjDnSHlNfCDPile?=
 =?us-ascii?Q?jZyaCIa6NE0TdKCft/eJsbz3juy89QvSK0XD786IB+pQ40nWfkIaZaMFZ/Zc?=
 =?us-ascii?Q?tBr/NChSxeTHWFPyMCB3ezNv6J7t/6OWZ4nV26nEB6lMwmSgXQXpfKgwz5PQ?=
 =?us-ascii?Q?1uvDB7IfP+JExMYa4yU1oHrakiG5JOKf6kBpF8G7UbwmhJwjdS2W/D2jstuJ?=
 =?us-ascii?Q?EbXrZqkYnwJNCHeYF4+W1fM2aWsAEe+qp5WIPBcd0KKXtt9NH/6L3jFQvGoE?=
 =?us-ascii?Q?ssZhQRDDA2VR4bQQY01JAnJxFlgUQ/pKXM/LhZT30l2oCeWDp6Jgkc6jLxQY?=
 =?us-ascii?Q?6YszI2jAommJkgTC9NBq/BHz/pfPAIcntnzID7fGNjMGiQHtzpP8Var8TKrk?=
 =?us-ascii?Q?Z+a48GbWr/2/B7SXzt0kAQGm5FC+8G+P9d0lOaWYlqTNpmlV+uoUNaRKhUo7?=
 =?us-ascii?Q?R1pxwk9KjQnMSzTs2BrRah4w7pOo689gRZsoA+2MoMTwtZh/jA5Z2ewD2tDr?=
 =?us-ascii?Q?RShAikQzP4JgpGamDgVdVeV6dPotxL6tvdaAidgOLpRYgGgOWYNvF2+UAAa+?=
 =?us-ascii?Q?Tlds/2qQFxKXbFFX855tdk92MvkbV5ovZgXzINP/16BqWoAiZS5uiP/3rphJ?=
 =?us-ascii?Q?FWsK5hrOLyuH35MdHmJgwtsf94E4L9w1xygtIblh/VQKhkSYTNK+WaUcE7zb?=
 =?us-ascii?Q?7D3mz6MNciytswIVWv5cVOxxjB3GXD0MFzmDbsWm+GT+nTEjDba36bBV/IQF?=
 =?us-ascii?Q?KFpSySjZ79ZJpaBI9hlaKMZaRfKW52wF+5CndD2QuK6HLaBX4n2YrLnt501d?=
 =?us-ascii?Q?2jLEr0PpkUkgNhli1zVWCuafmv48STk/dWwWI1wZTiFcZ2Xxa/ug8KKN3bQK?=
 =?us-ascii?Q?v00BaqtneAYDLQwP+VVbM7aEgr46HclmmmqzUIkbeHnxx9mStEC2p7yrYF7u?=
 =?us-ascii?Q?5qOaRWG432OKsaIKvyg6+rRqFqfuuExmP1LrTqftOb5ZMciRwC/F19Hj6T7n?=
 =?us-ascii?Q?0LuMXJB23iVmcAIqVUbA9p8h/7JKnh9BIN5R5iEA6UP9yyMCT/TGGYeY134D?=
 =?us-ascii?Q?y9e9hMTiV4D7eMFVmwGRCNF74cvj8Y5TmAjxjgKhWkWiVek41H6PZpMqusKw?=
 =?us-ascii?Q?3RGtcwm7ajfHTd72V7shmPsHeNU39JP1qkY69hQmm+0agZAzP3n5vXqN4Ffk?=
 =?us-ascii?Q?dz2BjNI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8770.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Y8d/zl7kM+S9ItWoPdgRSJlYG8/aiQxQ4SL7XqhaFnqHr11s/jatBGf5Sq0A?=
 =?us-ascii?Q?ADVfZ5T6PpPa/zhTCeGolRHtGZXSQ4uGdS4NSqEfiAHwrQE5UrvG8b6lxKbX?=
 =?us-ascii?Q?He3b/hlx21rGeMjTVRDwJDjj5vQ7fem8W+f03g7/8IbjXYq3GDijWV5+EZ8G?=
 =?us-ascii?Q?tWEXYaa2zXUqB9oJX9b1cQu3z+hBdKyvbazjCw3tgIuapllaB944ARtKr0nw?=
 =?us-ascii?Q?RDSJwqtWQBszieedTunztrW1zwoBb1mAf5p8+nofc5ZCQoqrQDYEcEZVtPHA?=
 =?us-ascii?Q?i0hK2DKz0YAMJzpy5pYvyjP1F5MAI36yIt89fcQumcLw8n2wbqKmfzSANsjt?=
 =?us-ascii?Q?H/l/cbI8eOIamD7mF7jXqwdZASdRdrDhF0seFpjaiVWk4V6EIkq0RV4ziq8i?=
 =?us-ascii?Q?AuHKHiaemAgyAUWNmGsSCOypjshKtedobLJjNbDJa8ocaZXPuaDwnSZ7H7TJ?=
 =?us-ascii?Q?QiCqFVjPeg/KlmddNQwyTKPQNdRHhjnHr3jk+QcuvNcc2SQOFKKXJjsT4WRm?=
 =?us-ascii?Q?ekkd/oVHpsrbfHC5Nj4I7VzN2y7ZRi9yfftOeJ+zjOC0NJcFqi+QFi/R50pU?=
 =?us-ascii?Q?zeW3yNw6fVKPXK6SAcy7SVozpn9omflvOyap1hESRP+8bTC0Q70dRUY5KeVu?=
 =?us-ascii?Q?WUIh/cLMnhY6zhHzGOXgOR/4cUm2KjP62Hukx5RJu5laPKtKnjTxEQqkvMKp?=
 =?us-ascii?Q?CHu+5ClI9OyVqnL+goiTGvhtKgK11LE20u40WljhVNQisSMnOCHY4GS4DOlz?=
 =?us-ascii?Q?FluTXvP+WfdhuMqmzpE8SnrDXsVH/PxydryqyeMDyKQtEsH90+VEcrbKA1tY?=
 =?us-ascii?Q?f5nfJXLlxbBROK4ueUdxt17FjuP4V6veUSaUhdpCnLmGoBdK953pYfhL+S1t?=
 =?us-ascii?Q?ewbVwhablNO5vSPnZjJlbgzR2VxW9IWeubfXn+qeBHstJdyG/A+uJHHuNquv?=
 =?us-ascii?Q?j9V6tnZ13v9wvJiroKzykupOkwzIEDp27tJb7m11U1MJPyKff2Qe3w51ok8y?=
 =?us-ascii?Q?rlgHlR4xhhcVK/pZeCETQKqbcTMIngKdTSBy4frNRfjzttpu6tU4cq7E1Pol?=
 =?us-ascii?Q?Zu6bkMsa/afVtqn0YIAEAL53sK0rHCjULWELY9BoK6cNLjdLPAoR31cWsjU6?=
 =?us-ascii?Q?ghn+GXn9qMyM80/VYQdIqu5hs+ddfIQsz//oqc3z4iOKsggKkMjnaQ8pSp7e?=
 =?us-ascii?Q?/gmy8cznji/u76ncF1oSYn7mEzywpQUcOL6Z/uCSwaXUIYvV17M5tGBNqccm?=
 =?us-ascii?Q?m6KXIJSWgvgjHLPx/M/38ou1BZJ9wiDpK4npJY3V+oGTd3GhZizchoAnSjtN?=
 =?us-ascii?Q?DSqmATrPz/6tEgvn3cyOA/9Ll7HO3pHAeToJW9vwCm8JmSy7DB7nwAIQxq/j?=
 =?us-ascii?Q?V5mW9dPY6c+1RFaF/YhXCyzxf9dkIhDHV9U5U79ds+JPRGJ9a4/nLjq9AYKU?=
 =?us-ascii?Q?Q2f00adrhOwX7Pmj6oCOWFdCh+LXZ8WpfZIgx+KwPIxJQzw953Pa8J3RIG2n?=
 =?us-ascii?Q?1iGlQokrTQYNMdlY71/UzBdT2/AKx8gQru9Hkj6Xz6Sl79KurNJlEO5kKr+S?=
 =?us-ascii?Q?XDNt8UKArb/84SsLNEvcK2//aYbEJZyFXB0Ns1X5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7e000c-5f04-4591-74da-08dde01b9cc2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 18:58:55.6271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xx+2CRxm2iDmty3tw+PeyfwnvBP8LaoPK/Rp7qG9N4kwcGdzIuzs3nFIdYwAMwP7ySyQ1QhnFWLuwUeQ7fBBCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 20 Aug 2025 18:59:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2074


On 8/20/2025 7:47 AM, Sandeep Gundlupet Raju via lists.yoctoproject.org=20
wrote:
>
> On 8/20/2025 2:02 AM, Lee, Chee Yang wrote:
>> I got this error while building the recipe
>>
>> |=20
>> /data/scarthgap/poky/build-zephyr/tmp-newlib/work/cortexa9-vfp-yocto-eab=
i/zephyr-openamp-rpmsg-multi-srv/3.7.0+git/git/open-amp-sys-ref/examples/ze=
phyr/rpmsg_multi_services/src/main_remote.c:26:2:=20
>> error: #error "Sample requires definition of shared memory for rpmsg"
>> |=C2=A0=C2=A0=C2=A0 26 | #error "Sample requires definition of shared me=
mory for rpmsg"
>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 ^~~~~
>> | In file included from=20
>> /data/scarthgap/poky/build-zephyr/tmp-newlib/work/cortexa9-vfp-yocto-eab=
i/zephyr-openamp-rpmsg-multi-srv/3.7.0+git/git/zephyr/include/zephyr/toolch=
ain/gcc.h:98,
>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from=20
>> /data/scarthgap/poky/build-zephyr/tmp-newlib/work/cortexa9-vfp-yocto-eab=
i/zephyr-openamp-rpmsg-multi-srv/3.7.0+git/git/zephyr/include/zephyr/toolch=
ain.h:50,
>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from=20
>> /data/scarthgap/poky/build-zephyr/tmp-newlib/work/cortexa9-vfp-yocto-eab=
i/zephyr-openamp-rpmsg-multi-srv/3.7.0+git/git/zephyr/include/zephyr/kernel=
_includes.h:23,
>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from=20
>> /data/scarthgap/poky/build-zephyr/tmp-newlib/work/cortexa9-vfp-yocto-eab=
i/zephyr-openamp-rpmsg-multi-srv/3.7.0+git/git/zephyr/include/zephyr/kernel=
.h:17,
>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from=20
>> /data/scarthgap/poky/build-zephyr/tmp-newlib/work/cortexa9-vfp-yocto-eab=
i/zephyr-openamp-rpmsg-multi-srv/3.7.0+git/git/open-amp-sys-ref/examples/ze=
phyr/rpmsg_multi_services/src/main_remote.c:7:
>>
>>
>> Build With
>>
>> meta=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=20
>> "scarthgap:6f7e929ea6ea557f107c8ccffea69a7d73439591"
>> meta-oe
>> meta-python=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=20
>> "scarthgap:c29a18fa39ede952f3f6108ec007c1906e2d9a0d"
> [Sandeep]: Looks like you are building for cortex-a processor. rpmsg=20
> works for only these platforms=20
> https://github.com/OpenAMP/openamp-system-reference/blob/main/examples/ze=
phyr/rpmsg_multi_services/sample.yaml#L8-L10=20
> I used "MACHINE=3Dqemu-cortex-r5 bitbake zephyr-openamp-rpmsg-multi-srv"=
=20
> to test this recipe.,this way we can avoid the issues. I can add a=20
> machine compatible for only these available machines. I will send a v2=20
> patch.

[Sandeep]: Sent v2 patch here is the testing logs.

$ time MACHINE=3Dqemu-cortex-r5 bitbake zephyr-openamp-rpmsg-multi-srv
Loading cache: 100% | | ETA:=C2=A0 --:--:--
Loaded 0 entries from dependency cache.
Parsing recipes: 100%=20
|##########################################################################=
###########################################################################=
########################|=20
Time: 0:00:07
Parsing of 2495 .bb files complete (0 cached, 2495 parsed). 4348=20
targets, 491 skipped, 0 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D =
"2.8.0"
BUILD_SYS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D "x86_64-linux"
NATIVELSBSTRING=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "ubuntu-22.04"
TARGET_SYS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D =
"arm-yocto-eabi"
MACHINE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D "qemu-cortex-r5"
DISTRO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D "zephyr"
DISTRO_VERSION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "1.0"
TUNE_FEATURES=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "armv7r vfpv3d1=
6 cortexr5 idiv"
TARGET_FPU=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D =
"softfp"
meta
meta-poky
meta-yocto-bsp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "scarthgap:6f7e929ea=
6ea557f107c8ccffea69a7d73439591"
meta-oe
meta-python=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "scar=
thgap:c29a18fa39ede952f3f6108ec007c1906e2d9a0d"
meta-zephyr-core
meta-zephyr-bsp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=20
"scarthgap-dev:a6a77268ce663082b6b33644fa2ba8521ceee147"

Sstate summary: Wanted 427 Local 0 Mirrors 0 Missed 427 Current 0 (0%=20
match, 0%=20
complete)##################################################################=
#######################=20
| ETA:=C2=A0 0:00:00
Initialising tasks: 100%=20
|##########################################################################=
###########################################################################=
#####################|=20
Time: 0:00:00
NOTE: Executing Tasks
NOTE: Tasks Summary: Attempted 1314 tasks of which 0 didn't need to be=20
rerun and all succeeded.

real=C2=A0=C2=A0=C2=A0 9m36.340s
user=C2=A0=C2=A0=C2=A0 0m3.668s
sys=C2=A0=C2=A0=C2=A0 0m1.022s
$ time MACHINE=3Dstm32mp157c-dk2 bitbake zephyr-openamp-rpmsg-multi-srv
Loading cache: 100% | | ETA:=C2=A0 --:--:--
Loaded 0 entries from dependency cache.
Parsing recipes: 100%=20
|##########################################################################=
###########################################################################=
########################|=20
Time: 0:00:05
Parsing of 2495 .bb files complete (0 cached, 2495 parsed). 4343=20
targets, 490 skipped, 0 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D =
"2.8.0"
BUILD_SYS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D "x86_64-linux"
NATIVELSBSTRING=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "universal"
TARGET_SYS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D =
"arm-yocto-eabi"
MACHINE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D "stm32mp157c-dk2"
DISTRO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D "zephyr"
DISTRO_VERSION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "1.0"
TUNE_FEATURES=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "armv7em cortex=
m4"
TARGET_FPU=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D =
"soft"
meta
meta-poky
meta-yocto-bsp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "scarthgap:6f7e929ea=
6ea557f107c8ccffea69a7d73439591"
meta-oe
meta-python=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "scar=
thgap:c29a18fa39ede952f3f6108ec007c1906e2d9a0d"
meta-zephyr-core
meta-zephyr-bsp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=20
"scarthgap-dev:a6a77268ce663082b6b33644fa2ba8521ceee147"

Sstate summary: Wanted 11 Local 0 Mirrors 0 Missed 11 Current 308 (0%=20
match, 96%=20
complete)##################################################################=
######################=20
| ETA:=C2=A0 0:00:00
Initialising tasks: 100%=20
|##########################################################################=
###########################################################################=
#####################|=20
Time: 0:00:00
NOTE: Executing Tasks
NOTE: Tasks Summary: Attempted 990 tasks of which 970 didn't need to be=20
rerun and all succeeded.

real=C2=A0=C2=A0=C2=A0 0m51.588s
user=C2=A0=C2=A0=C2=A0 0m0.372s
sys=C2=A0=C2=A0=C2=A0 0m0.096s
$

>>
>>> -----Original Message-----
>>> From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
>>> Sent: Tuesday, 19 August, 2025 6:03 AM
>>> To: yocto-patches@lists.yoctoproject.org; Lee, Chee Yang
>>> <chee.yang.lee@intel.com>
>>> Subject: [meta-zephyr][scarthgap][PATCH v6 10/11] zephyr-kernel: Add
>>> rpmsg multi services recipe
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
>>> +=C2=A0=C2=A0=C2=A0 "
>>> +
>>> +SRCREV_open-amp-sys-ref =3D
>>> "d78315763fbacba8a74552d0ad570bd01c42ccf9"
>>> +
>>> +ZEPHYR_SRC_DIR =3D "${ZEPHYR_BASE}/../open-amp-sys-
>>> ref/examples/zephyr/rpmsg_multi_services"
>>> +
>>> +ZEPHYR_MAKE_OUTPUT =3D "rpmsg_multi_services.elf"
>>> +
>>> +EXTRA_OECMAKE +=3D " \
>>> +=C2=A0=C2=A0=C2=A0 -DCONF_FILE=3D"prj.conf" \
>>> +=C2=A0=C2=A0=C2=A0 "
>>> --=20
>>> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2070):=20
> https://lists.yoctoproject.org/g/yocto-patches/message/2070
> Mute This Topic: https://lists.yoctoproject.org/mt/114772377/3619217
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:=20
> https://lists.yoctoproject.org/g/yocto-patches/leave/14411013/3619217/657=
730681/xyzzy=20
> [sandeep.gundlupet-raju@amd.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

