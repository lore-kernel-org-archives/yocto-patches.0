Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F3DC369A2
	for <webhook@archiver.kernel.org>; Wed, 25 Sep 2024 07:16:35 +0000 (UTC)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
 by mx.groups.io with SMTP id smtpd.web11.9629.1727248594707426388
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Sep 2024 00:16:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj1 header.b=uybLHguN;
 spf=neutral (domain: fujitsu.com, ip: 216.71.158.34, mailfrom: wangmy@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1727248595; x=1758784595;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Y+jMOGDRRCfs4VvBR/+x0oZ5nysiPG2Es5e3YX9SFPI=;
  b=uybLHguNt6/Iz/kQF3b4agUa0+TWlweEecwrb244TaGqUsWVaRjGw0VV
   1R5JILJXzzXshwNHoL30tovfbl90b6C1bzPSD0pM+7+WWkoWanEFj0miW
   roT4MS8cxG+IX5c/NivzQrIsxCrjBSA5mQHcQw9H6kGY98pwPzXpStyxh
   r8VdxgBI2UchfJGpQH6dXiUORh3dvXJirsZnfPxtT/D3NQDm9hTDcAVzd
   P0QKG1tA0OJZe+FnyE279pvL893/RnhZRX1aiSFmBvddPukmB8Oi+owDa
   zs2Uy+hrDFkCKUky6mWHd1LnB4SOi5zpqbxjN3goJa0rwrlw3ht4coTdP
   A==;
X-CSE-ConnectionGUID: 2xFt/yEwQl2Hq6f3EXGRoQ==
X-CSE-MsgGUID: +sNCh/sHQ2KUuu45sgSevQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="131677882"
X-IronPort-AV: E=Sophos;i="6.10,256,1719846000"; 
   d="scan'208";a="131677882"
Received: from mail-japanwestazlp17010003.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.3])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 16:16:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAuO72zh7AZDIP0Z1+Ox1u+bBcASKi6rxg8dQuL+S5/aU5qo89L6epdxPc2djMKPBCAimbDiFgO06N9qP+qnVfMYdGWHedwUbwrzm25/lXs5Zaa8EJFCqn+EjLUyf/2/3MmMH7JYkmNeOSZ8Dje9VLDo5l1i/MlZfJ1hyFiyHNWB6V7BWA9tvVmNKpZgFL6b6p655Oo6Ud+1yH7nQuCklR3kWF7NCHrBQlckWD0ekH9tkg9xcPfVTZsjc+fCCQcO2CeTAcDYXoChvcfncUEJ5j2t2cymzFOfsuuBPlcoocn+PMYQM6f5XHqZ96+SvcznuCnUtYhe2+CqvqACKAYOGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+jMOGDRRCfs4VvBR/+x0oZ5nysiPG2Es5e3YX9SFPI=;
 b=adXU32d9KP2QCXBrICfbSBxTOn7jXNq7Iu8jr7rlcv9ALya7X7k6lu4EuYaDV5e+aO1nCf+THQygB1/D52FEi7PYTWpQbbT4OrCqHC4B3QKN1dtCV2we6VFKyci4ZUevFakXsrBXto192U25i8Q19tlE9jBIIfpIGwpocvI0Xw0trb0ArwmL5GvcwBTxGKx1QXBlRH+W9uT5N6sOBSINNUuKkDxGIQKsJw4hOMInu4EyIGnBmwXGWOiKZgPHYDQMWfi1RBzMwiZm9l7MdCm+2w5ceDKsDsoR7uKEIdxZ0ONyws4E2MfCrc71uZRTEYX/s4ctvKbF3lxAumyTqKzxFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB11861.jpnprd01.prod.outlook.com
 (2603:1096:400:3fb::13) by OSOPR01MB12137.jpnprd01.prod.outlook.com
 (2603:1096:604:2da::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 07:16:29 +0000
Received: from TYWPR01MB11861.jpnprd01.prod.outlook.com
 ([fe80::e0dd:28e5:6a6e:2342]) by TYWPR01MB11861.jpnprd01.prod.outlook.com
 ([fe80::e0dd:28e5:6a6e:2342%6]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 07:16:29 +0000
From: "Mingyu Wang (Fujitsu)" <wangmy@fujitsu.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, "joe@deserted.net" <joe@deserted.net>
Subject: RE: [yocto-patches] [meta-selinux] [PATCH] layer.conf: set
 LAYERSERIES_COMPAT with styhead
Thread-Topic: [yocto-patches] [meta-selinux] [PATCH] layer.conf: set
 LAYERSERIES_COMPAT with styhead
Thread-Index: AQHbCmLHz6/AHmexuUicQdBLSe1hRbJoIMnw
Date: Wed, 25 Sep 2024 07:16:28 +0000
Message-ID: 
 <TYWPR01MB11861C0221FAAFA6391AD0D5BDC692@TYWPR01MB11861.jpnprd01.prod.outlook.com>
References: <17F693837DCF4DA2.31299@lists.yoctoproject.org>
In-Reply-To: <17F693837DCF4DA2.31299@lists.yoctoproject.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=fa0e3287-069c-4bdf-a469-dc103e1b4086;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-09-25T07:16:25Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11861:EE_|OSOPR01MB12137:EE_
x-ms-office365-filtering-correlation-id: bddecd9d-74c0-4ac1-7ce8-08dcdd31f98d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|4022899009|38070700018|1580799027;
x-microsoft-antispam-message-info: 
 =?gb2312?B?VlVmclpBZHlZNHJwWEJDaGhYN25qU1pDSFhTM2k1RU5BTHNIRHQ1Vzdzanow?=
 =?gb2312?B?amE2TmVEMEpqTW5SYzBoRjRBaHVhQzJmb2VjclViUExkT1dydURpdlFCZ3ZJ?=
 =?gb2312?B?ejAzL1FDZ01tRjdJVVRYdUR5M2x3OVF1V0x5aXhVUmFsNjlKMU9lUDR5Z3hJ?=
 =?gb2312?B?UUZYOFdRd1B4V1pabVJ0N3RGQ2pzTEJIWGFpZzIxUWo3djJ5eVlqMDBuQk4w?=
 =?gb2312?B?Q3kyaVRLbEs3aEhWNGhTekpwSENrTjkxL0JUaWxvQW1TeThOUHRyREM5MWpM?=
 =?gb2312?B?RnJGNjNTQk9iUE9IK21URVp2NFkyMkRNTjVWRU5YUXNnS2VLRlNnR0cwZFRJ?=
 =?gb2312?B?OVNUVUg3SUxPWW9HR0w2QlM0eXJhd25pOUl2aWZ5WWhDb3N2Tml1OTlQcmNH?=
 =?gb2312?B?aVhUUHROU1pEc2ZxcGhrdkJGQlJwWFkwa2JySGI5bWQzell2QjhKVDVVVEp3?=
 =?gb2312?B?OVNBYXRyV1NxODJ6enRQZXgyWXF6cWw3MGhWd3VQbzl6T0Z0Qk1JOUpYQ1VH?=
 =?gb2312?B?amRjYkgxdjBySVFHYkVrdzFWem93NnBjaFZQeVFHY0xMZis1enVrUVkrOUsz?=
 =?gb2312?B?WmhuMmIrQnhIeW5uUzFSNHVTSmJ3emNmYkpzcHFFZWlSTUhacFV5RUFxclVK?=
 =?gb2312?B?Y21wdlJuTVl1a1E5Zk5JMjV6cU1LSG1uVUVLb0daWlRuQjlmeDdhMDdHU1lU?=
 =?gb2312?B?bS9WTDJhL1ppSGYvWWMxdEFFblhoS01CUEdreWprZXdEKytsTHNnZzMwVjVp?=
 =?gb2312?B?bWh2N0dlWklWZjc4TVVJcGZBNTlEbUdwUi90V1RIT09CalVEZ3oybWlBYjky?=
 =?gb2312?B?M3pkYnplVnRxUnphdm40MTNUMnNOQktDNDYxdkRaUnRmVHNLeldoNS9CUGlY?=
 =?gb2312?B?NDRCNHpGVTByTG5DNENHeXkxWUt6QUJaYWtMSkJwbG5DNVFtU2RSVGlqV0kv?=
 =?gb2312?B?QmlKQ1hXKzgzdm8yWS9qU1RlSU9DOWZoNU9DMVQwMkNmcXNrbVYwWWlHSlpz?=
 =?gb2312?B?SzNUV2x4R0Z6MHd2WjFlZ01mdHRIUyt6enMrK1JDVWtaTzZrUXcyWkFvVUNQ?=
 =?gb2312?B?TnNqdzBTcERMVEtXWXFrcXN6Q1BzeTFjRUM2ckxVNEl1UTJqMExvcTNZSDR0?=
 =?gb2312?B?MU4rQ240YmNqbFN2cjBCclMzcStwZTlWUjIwN20zc2NEUkFSYkxFcjMzYjlN?=
 =?gb2312?B?OStYZ2dZMGt6a01PTWk4QUJFeXFRc1FDOHowMlZSMFJES2dZK2ZtN3FKS2M3?=
 =?gb2312?B?NHVNY3VoaVRJTmdkTzVlQTB2UXV6NFlkZ2ZUL0wzUVNBSDYxTExNUjBFeW9s?=
 =?gb2312?B?MlNtNkc3L21aMFdQZEU4WTVHa1diLzVRV3ZaSlVkMWJZUTdvTUZVT0loY21U?=
 =?gb2312?B?K1RnU3Vwem0yeTBkUFZQUFRWS3p2dTh5NjFERjdkNG9rWWNpWnl0WUdDUjZJ?=
 =?gb2312?B?LzQ1bEVTeWZLZTJoRjZEZ25aeitFM0U3S0dlUDNFL0gxelQrNVpUSDloRU9X?=
 =?gb2312?B?c3k3djdKUlhZb2s1UURxN3I4UmJDVU4wZnNFQ0dVZ0tmV1ZtREVycU5qTDNv?=
 =?gb2312?B?cXJpdERNRFI0VWJXbXR0V212Zk9KQlJ2eGMzUTVSNXhTczVaZEZ1dEZCVG1N?=
 =?gb2312?B?L05YbXV5Z1lyc1pHNVpWczYyMUQzZWRRUmp4QUFQd2lCcnI2dzkvU3RjeWVt?=
 =?gb2312?B?WmZaNUdacUVCM2R3bTRFb0h4NmNPWER3YjJmWDVPNGYvSjMweTY5VnhMZTVC?=
 =?gb2312?Q?3XtomukDxNugFnBZp0W6LUzyn5CUDgqEqKaRIba?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11861.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4022899009)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?MkR4MjllUlRPZzA2UlQ4OFZnZDF5K1NaaGVCUlNuRFVXdURaRnNIcW9wQ08r?=
 =?gb2312?B?RHA4dmxOdUtyMlFwZTlsVVVVak84dWN6eTJNeHhneTc5Vll4VFZqbG40V3pE?=
 =?gb2312?B?cFNoVTJBVmJDR0hqdy9GbXlqWnpvNlZzMFNDU0M4U1orcW8xcml3V0pCdnNX?=
 =?gb2312?B?VnVnc2VLeEtHK1VDYXBuSG92NXFidS9LR3ZOREI1SGxaS0VEdjFUMU9pM2xY?=
 =?gb2312?B?UHc2T0FtQ1JCUjBpUzdzcTAzT1QrcnBtdWh0S1p1ZmJlQ0VVSFNOdHc4RlM5?=
 =?gb2312?B?TTh6N2hFbTMwU3FQSTdWUEEzT1NobjNTandRVWQzR1lQeG9DdGhxU05FNmJv?=
 =?gb2312?B?ZUlqQUs5UVkzeFAxeE84dDQ1MlhoYjBCUGlHM1NuRDdIODlVUDVMcHBGSHpO?=
 =?gb2312?B?bFdpekYwd0ZUb1dLZkQwSXFzRk02b09TUGVXMkpZNStGYUFBaWtHN2kxMENt?=
 =?gb2312?B?amtaUHZ2UWpOSyt5TmhtYUtJczJyZGtlK3RUT1BOLzkzSTBpRXk5OEhRb3NW?=
 =?gb2312?B?ZnVhYm5nMVJPNCtjNEMwOEs1Qy8vZ1g3YUo0K0ptWmUwMHcxZXYzd1R6ZlBS?=
 =?gb2312?B?QnBVTEtTRTJ4aHZ0b1lGUlJuTUpvN2tnUFN5RkhYMmI2R3hZVzlyaUM0eldp?=
 =?gb2312?B?NU1qZlByM2RtV0pDNDFMQ3VaVC9BZ0h2OG5ZaHF5c1NzQ0xCdCtoWkNsejJk?=
 =?gb2312?B?VGh6VW5LdEJDMDlzTVpsay8wbHZYRGpmMjEvT014dW5Cb0xHNmxBRzZ0YmI4?=
 =?gb2312?B?OEMzMjhuWlE5RnMxZW9YeEhnZXo0MER5ZWJqSldqdGdGOC9UamNWQ0k0WWJq?=
 =?gb2312?B?MVo3aTJCbitDYmNicnI0dG45UVZuR0RncHJ5ZnEzK2VVQWZTMmVvVzNnSTFG?=
 =?gb2312?B?L0M3cG5Rcmk0RWQ5dzVwS01yTkIwZkY5VnN0eU5iYmUrdVdwTCtEcXFaOGJo?=
 =?gb2312?B?RzV4bDd3NlJKZTJZNzFvRms1cEQyQUQxV21obm5sNVBya0tFVFB0bzdNMm16?=
 =?gb2312?B?Qk03SUhjVE1iVFM5bEF3NHR0QmtXN2w1UDNIM0ZEajBzalNaMHNKOC91MUtH?=
 =?gb2312?B?ckJvTDVRRkpvNURFMkJXb0drSm00Wlk3U1Z0ME5SRzVSVnhyZFVLL1N2OVN5?=
 =?gb2312?B?UmQ3VzhzZkU4dlNQejNGZ1laZ0RYV1pYWGZ2Y0lTc1dYaTFZVkdiajQ0Y0Fx?=
 =?gb2312?B?Mnp5cFlSaEdFcnIwTi9pcUMzRHhHOTE2Q1FhU0ZGZUVYYTZtdTh1YkhzR0Fp?=
 =?gb2312?B?Ty9YNFRYblcxR3hxUjNpQ2VpQy9HQnJMV2VSM0FzOC9qMDlrbHhLTEVsazFs?=
 =?gb2312?B?QitqdGEyRXRZamFGKzFJandFTHRJTUxZUkpzUVpQay80d2I0MTBQTDQyQVZ5?=
 =?gb2312?B?ZmNqMnJUalZ1WUhsOU9jcE9zdC9lWlE0OTZvOTJSZElrdnF3UXBUdnhFMnp4?=
 =?gb2312?B?cFBuTVowWTVVdXhYTytVekRTYWJ5NXo2RkxWTFYzUTFQYjFRSkxnVjY3bEZ1?=
 =?gb2312?B?Y2F4M0RvMXRxaUJQWVBvNzJRd3Z1clc3T1ZRZjBMdlZvRGFjcDhJRHAybEI2?=
 =?gb2312?B?Yk40cm1ZZHAwNkp4K3lISkZKWlRGemEwSTZpQ3d0Tm5jV1d6Z3pzcXlDWVMx?=
 =?gb2312?B?RGdXYXhWbFQyZUFjcnpIRFpHN1pZRW5XYkpyWjg4cDkrTEVhdjlkNzlXbkZl?=
 =?gb2312?B?ejVvcXJDdDNZSzR5ZWMyMHpEdGtnZWdBMVN4cy9STjRNOHZ1MnBQZDNUY2hB?=
 =?gb2312?B?L0pqUUFjYUlDakJJQXUyeEc2T0FLc09DR1VkcWtWNWppNmt5Yi9JNENGNWdi?=
 =?gb2312?B?L01BZC80SjhWRmR4QVJoQzZrT3loOVByUEhUaHNscFE5ZmhIYkpnbm85dnBU?=
 =?gb2312?B?K1NIQlIyajZKMWRPRE5pVERsQlB4UXVPQnRDOGExWmFBSnJFUkx4dm5wZkUw?=
 =?gb2312?B?SmxJbGpONFdBMy9rQndreGF3cEthcWM3aWxaQk9zdGtTemhhY1lyNFZhdlZN?=
 =?gb2312?B?b2hqUUZOUTFqYVluSEFBeVpJRHBRMElIaDVEamhRRE9YdnVuMXBJSklQZ0dm?=
 =?gb2312?B?akNJKzZrTTV6bDJkTDVGU2VVQjJPcUIzR2tkL3dNMDgxWkhudFBsa25TRnZZ?=
 =?gb2312?Q?qvatLMHDpJfIvenANk4AdYHL3?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	u5kBNmTotSfmj3NIRycWf9Lmc19k5xAtYv9eGW5+EwsnJhQUVXDv16wXVrAewKwBo44hdVcUjkr4/U4RQJ9OHdf+JI7IHRloK9kMLWxkAeg0OOnAkZ5XP2cnMPGp028b79m9fc94H4BFD9d36indI8cyii0qzItsi3fwlvzZvY01uJMGTYH0VxAi1WxDnRyxAR7VpdUeR0rfAwnU70HLMw9+olTbcDujQLTUmlnNFzUda72sWlK0bcEVFYhKukTHbkpOhrIkU1s1xQ2o0NKhWpQ8TsNPe83WKpHCFTowP2RQWAUSqbIqhjdi+DztcfMAMY7fOZmyBzrRbCxibfjqAoeNjgtJiUwOSn5Wp7/b6gIPlCu35w/2EyLSwO0EBztTjCxSOn+aplKvlFr2yIuww+MKe39RqAZKw9hO2MHhxyOl5x+7N+rpa9WKpyqebaDghI5dLby7AKEAFrd2lhIepNylKIlGjPKBS12nF2uFaAw0nsvek0EAGKA5wiD3qWNWqzJUp8OjHpkzUi+F8F3P0tD8agngNXwa8ChPKzW8RLk/zaNeRVVTIjpE2odO0fNmWhtyZVBJlF4TFr0rXQK0xrRJ9kDD3w7L5PPtBUjgKTuXxOJwXmjrpKO/v/Ccsfe+
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11861.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bddecd9d-74c0-4ac1-7ce8-08dcdd31f98d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 07:16:28.9294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: im4t8HZNxXjqfXQ799lPNvT0jGQZP8htU4rOLR88nCwm7v+gAaLg3AOWqnBrGnlkZlWaeyG93Za35NAZ3a3QHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12137
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Sep 2024 07:16:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/666

DQpwaW5nDQogIC0tDQpCZXN0IFJlZ2FyZHMNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KV2FuZyBNaW5neXUNCkZVSklUU1UgTkFOSklORyBTT0ZU
V0FSRSBURUNITk9MT0dZIENPLiwgTFRELiAoRk5TVCkNCk5vLjYgV2Vuemh1IFJvYWQsIE5hbmpp
bmcsIDIxMDAxMiwgQ2hpbmENClRFTKO6Kzg2KzI1LTg2NjMwNTY2LS04NTY4DQpDT0lOUzogNzk5
ODg1NDgNCkZBWDogKzg2KzI1LTgzMzE3Njg1DQpNQUlMOiB3YW5nbXlAZnVqaXRzdS5jb20NCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiB5b2N0by1wYXRjaGVzQGxpc3Rz
LnlvY3RvcHJvamVjdC5vcmcNCj4gPHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9y
Zz4gT24gQmVoYWxmIE9mIHdhbmdteSB2aWENCj4gbGlzdHMueW9jdG9wcm9qZWN0Lm9yZw0KPiBT
ZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDE5LCAyMDI0IDM6MDggUE0NCj4gVG86IHlvY3RvLXBh
dGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZw0KPiBDYzogV2FuZywgTWluZ3l1L831IMP56KQg
PHdhbmdteUBmdWppdHN1LmNvbT4NCj4gU3ViamVjdDogW3lvY3RvLXBhdGNoZXNdIFttZXRhLXNl
bGludXhdIFtQQVRDSF0gbGF5ZXIuY29uZjogc2V0DQo+IExBWUVSU0VSSUVTX0NPTVBBVCB3aXRo
IHN0eWhlYWQNCj4gDQo+IEZyb206IFdhbmcgTWluZ3l1IDx3YW5nbXlAZnVqaXRzdS5jb20+DQo+
IA0KPiBTZXQgTEFZRVJTRVJJRVNfQ09NUEFUIHdpdGggc3R5aGVhZCBpbiBsYXllci5jb25mIHdo
aWNoIGFsaWducyB3aXRoIG9lLWNvcmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBXYW5nIE1pbmd5
dSA8d2FuZ215QGZ1aml0c3UuY29tPg0KPiAtLS0NCj4gIGNvbmYvbGF5ZXIuY29uZiB8IDIgKy0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2NvbmYvbGF5ZXIuY29uZiBiL2NvbmYvbGF5ZXIuY29uZiBpbmRleCA0ZTA0
ZTVjLi5jN2Y4ZGZiIDEwMDY0NA0KPiAtLS0gYS9jb25mL2xheWVyLmNvbmYNCj4gKysrIGIvY29u
Zi9sYXllci5jb25mDQo+IEBAIC0xNyw3ICsxNyw3IEBAIEJCRklMRV9QUklPUklUWV9zZWxpbnV4
ID0gIjUiDQo+ICAjIGNhdXNlIGNvbXBhdGliaWxpdHkgaXNzdWVzIHdpdGggb3RoZXIgbGF5ZXJz
ICBMQVlFUlZFUlNJT05fc2VsaW51eCA9ICIxIg0KPiANCj4gLUxBWUVSU0VSSUVTX0NPTVBBVF9z
ZWxpbnV4ID0gInNjYXJ0aGdhcCINCj4gK0xBWUVSU0VSSUVTX0NPTVBBVF9zZWxpbnV4ID0gInN0
eWhlYWQiDQo+IA0KPiAgTEFZRVJERVBFTkRTX3NlbGludXggPSAiIFwNCj4gICAgICBjb3JlIFwN
Cj4gLS0NCj4gMi4zNC4xDQo+IA0KPiANCj4gDQo+IC09LT0tPS09LT0tPS09LT0tPS09LT0tDQo+
IExpbmtzOiBZb3UgcmVjZWl2ZSBhbGwgbWVzc2FnZXMgc2VudCB0byB0aGlzIGdyb3VwLg0KPiBW
aWV3L1JlcGx5IE9ubGluZSAoIzY1OSk6DQo+IGh0dHBzOi8vbGlzdHMueW9jdG9wcm9qZWN0Lm9y
Zy9nL3lvY3RvLXBhdGNoZXMvbWVzc2FnZS82NTkNCj4gTXV0ZSBUaGlzIFRvcGljOiBodHRwczov
L2xpc3RzLnlvY3RvcHJvamVjdC5vcmcvbXQvMTA4NTM1NDc1LzU5NzQ5NDYNCj4gR3JvdXAgT3du
ZXI6IHlvY3RvLXBhdGNoZXMrb3duZXJAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZw0KPiBVbnN1YnNj
cmliZToNCj4gaHR0cHM6Ly9saXN0cy55b2N0b3Byb2plY3Qub3JnL2cveW9jdG8tcGF0Y2hlcy9s
ZWF2ZS8xMzYxNDI3MS81OTc0OTQ2LzE5MDI4DQo+IDMxMDY2L3h5enp5IFt3YW5nbXlAZnVqaXRz
dS5jb21dDQo+IC09LT0tPS09LT0tPS09LT0tPS09LT0tDQo+IA0KDQo=

