Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927B4C021B3
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 08:27:52 +0000 (UTC)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
 by mx.groups.io with SMTP id smtpd.web11.18954.1740126464511463123
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Feb 2025 00:27:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj1 header.b=AiXZixEs;
 spf=pass (domain: fujitsu.com, ip: 216.71.158.38, mailfrom: wangmy@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1740126465; x=1771662465;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=a+IZCg9EemVpIAZ5G2Lkjml3xyBSRoWNbHLfD+WZBls=;
  b=AiXZixEsr34kC+v5uxUQH5y6HCB9iYLB09t/WvdeiW7XF4gUb7n4AA1S
   iFCFs18dWWVLnAjC8H9qP654QlBMjlC1113h/E5p9bnvAwPiGOYhsCWDL
   b6aUaisowf372kYD1Xads84PM5WWQ4KUSZ6iYHKBy1V9bk+UAzxhC2yUM
   fos+qwTeYdf5GNwcE0OuxjPCNMFfbAhilwS70jgJOQKcAJRTTYqBT0iUb
   l/xkg8c9HX1pelwWrokfJiUmbFgcDPNvEGKNBEYJcotk+JBpLjnNr+12R
   w5G35BVvW7DWt+IBzRFkS18yMS1nieyhS7Dj+ux9BUuZW96MFbP+0SYUF
   A==;
X-CSE-ConnectionGUID: PmULbYIbSomW5OhTiAoS/A==
X-CSE-MsgGUID: dOrkCVH3SNKDoYGu4o9bUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="153381264"
X-IronPort-AV: E=Sophos;i="6.13,304,1732546800"; 
   d="scan'208";a="153381264"
Received: from mail-japaneastazlp17011027.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.27])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 17:27:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzJKWFgqphA21OKvZZDKbAE9r89+rxGt9kFAblEpFIDcviTZlAvUPyVEK7nYxrifUa7zKuMhYrXJqHK6zQ+aLY4i9WkLnaGttMpZkAp2vnfHzWUakugMcLNEvUAd5pMtU4NqgTsC2Z6+b5vjP4BOKi5KRdGm7tRB//WQeY3FwC4DSl5POGlclKx9EoUPxPbTU+//1014WaWG42+/fGHNFuyWKJhQFxhhHzv1/MGvkrH0f/TIXWIh7/1DKPHybeT3lqL0Xg6fi0nvX7+q4PJrbe7FVQAzduo3CdXI7IjPNhC/h2RGbmhz1OArAIhW80jCM4FhLl5wIzvWL7xwCysnkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+IZCg9EemVpIAZ5G2Lkjml3xyBSRoWNbHLfD+WZBls=;
 b=hsuaImpMY9yORdwJMMvUNQ5GsUXZk+0UjFpI7qluo4OFQaqPx1olMNYKHXtWSEvJzZ1D8zSFRwBKni/lwbx9JjwdaZLMGqGHeX1Ign1/LIWYRnUQJOz4oLvLO0j1JJyM3VnrxpArYkUPMlItHFgjgrALzMLRHF/Pd+tvapUyHUHi/k70plrd90HO7QUGdLlNEx/ML6MWwMhYAVj8Nru8hUPjw/PuxYWu7Wzq0teYptSlJ3W5gO7sDhVzk74YXPwIMlMypKCPmFVWY1CtE/8ghmnm4/8/QOxVMxscWs/hXTqptDvCky5NuHxmWIwBqWhUZJJ5IwmFCY7mHB9JsCmuUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB11861.jpnprd01.prod.outlook.com
 (2603:1096:400:3fb::13) by OSCPR01MB12659.jpnprd01.prod.outlook.com
 (2603:1096:604:33c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 08:27:38 +0000
Received: from TYWPR01MB11861.jpnprd01.prod.outlook.com
 ([fe80::e0dd:28e5:6a6e:2342]) by TYWPR01MB11861.jpnprd01.prod.outlook.com
 ([fe80::e0dd:28e5:6a6e:2342%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 08:27:38 +0000
From: "Mingyu Wang (Fujitsu)" <wangmy@fujitsu.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [meta-java] QA Issue: Missing Upstream-Status in
 patch
Thread-Topic: [yocto-patches] [meta-java] QA Issue: Missing Upstream-Status in
 patch
Thread-Index: AduEDy+sEghkbMChQESqJcifNyWPJgAAxogAAAnxstA=
Date: Fri, 21 Feb 2025 08:27:38 +0000
Message-ID: 
 <TYWPR01MB11861B276559403A8AA76A8EFDCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
References: 
 <TYWPR01MB1186118665B16406BD0571151DCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
 <CAMKF1sqJ3MS8gnN8gv1AMLNNZt=UEXtzXyQim-5TA+H9funFUw@mail.gmail.com>
In-Reply-To: 
 <CAMKF1sqJ3MS8gnN8gv1AMLNNZt=UEXtzXyQim-5TA+H9funFUw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9NmM3ZWU1MDctMjQ3Yi00MGZlLTk4ZDgtNjIwOGU1Y2E1?=
 =?utf-8?B?ZDhlO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI1LTAyLTIxVDA4OjI0OjUwWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?B?ODFlMS00ODU4LWE5ZDgtNzM2ZTI2N2ZkNGM3O01TSVBfTGFiZWxfMWU5MmVm?=
 =?utf-8?B?NzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX1RhZz0xMCwgMCwgMSwg?=
 =?utf-8?Q?1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11861:EE_|OSCPR01MB12659:EE_
x-ms-office365-filtering-correlation-id: f4a19e8a-dca2-41e1-ae15-08dd525199b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|4022899009|38070700018|7053199007|1580799027;
x-microsoft-antispam-message-info: 
 =?utf-8?B?R085ckJ6OFhzTHc0a1NSMFAzVFpiREU4VFRLb0o0VFV1cEtXazU2Z3BkZFJ5?=
 =?utf-8?B?VjhycGV4bEZGVkRJTXlWVHE2SG1LQzZaTmtHQnpBUXRFUTIrTDJFSVI1Mkx6?=
 =?utf-8?B?NndwOTd0djR4TWRlMUVoc2hkWUtmNGFNaEN0dXpqa2xMdFcrMHBFbklUNlY1?=
 =?utf-8?B?cUNJbDRMOE0ya3BKTlh6RE80c0dtZXNQa3pmT1g0YUE5TW5nbGxHckMvdlNy?=
 =?utf-8?B?WGpyOThEYXgzMTFhTWFBeDB0bURnNlc2UkJ6V2JBdDFRcFJPRGlJcGRQYjl4?=
 =?utf-8?B?SmlYbWVYN0ZtYXlmT1ZoTFRnVmkxQjJ1OXdtbUh5dHdSbDJpbzJLcWtuTFI5?=
 =?utf-8?B?VzVuZS83dERSdzRadjU0Vm9zWmxVQnVROWxRZkRqNEV6b1N6QTNMalVZMmtz?=
 =?utf-8?B?S24zZmtCR1FIck5OeGVxRStncnVwT29maWk3QlA2STVMOFlwUC8rMEkyamM4?=
 =?utf-8?B?Q2VLeWRuZ1VFMXp4NXBmdmczdmxJZlVIY21zSHVpK2NKZjJDY1Bld2lUTWRX?=
 =?utf-8?B?ZktiWXA3Lys3WWt4RXNFVTVrNGt2enFSaDRXeG9wbzdpNjBxWjc0YUZQM0Jh?=
 =?utf-8?B?dHFQOC81UG94WGIwdXFBNUNHR1lOZWdkNkVWTmtHMHo0THFSQ3A0RkRTRHdz?=
 =?utf-8?B?bU1nTU5hc3A1N29PdjJYaTR1d1lMOFpzdTE1aEdBSERPbjM3N2QycXJkYi9L?=
 =?utf-8?B?a3B5VHVveGtoTFhGcXhmUXd4UzVxWjZ3TzlXWXZxdDVuNC9uaDk2MVYxM05r?=
 =?utf-8?B?QUpwdXhkMmxQdGg4NlRGbzY3VWJaVnh4U3dUTkFEeEs1cHFOeXJralJoMVNw?=
 =?utf-8?B?cC8zZmNuajFIWUtEdkt5MUVKb20zazJ3QmtmT2Q4NWJzS01JYVJuZk0xaUlo?=
 =?utf-8?B?Ky9IdXVIQlU4K1EyVVVVa1RiN3UxYWh6WGxTSVNDT0VhaytjRkl4dnZDR09X?=
 =?utf-8?B?TzZIN2MvOFIxR2ZMdGsyR3pBaU1GOEZJTDhhd2ZHYVpkZkd4UVllWHNtU1Z0?=
 =?utf-8?B?OSs3eUFjYm5wL1pWaG80MUFZTjA4VzdXZTZEYXVxTEM2bEVBNFYrYmVTU0F4?=
 =?utf-8?B?elFncFFwcnVpSlNGMTEvYWd0ZTRYWUtXTU1uUGxRaS9vdzRFVGhqL1dNc29s?=
 =?utf-8?B?T0RkQzhSTGVraTI3S0RkYVVkYmVEdlRyakVGaWhZSVJTU1FybDNNWFVpMVFX?=
 =?utf-8?B?SDZOS3Q3bW5sUjM3K0N4NE1WSU5MR0oxbjJ3T25VODZKZzJQK0tNLzl6OXI1?=
 =?utf-8?B?eWhPaXhxZWVIbFdEWmFKc0ViUWd4cFJreDE4RFZCYlYxUkIvUElJbWxwNU0w?=
 =?utf-8?B?SE5MU01yWnlyZTVEUDE1SmtsMHQxZHZiM0t0cXJKcEp0akE1elV4NEg0TmQ3?=
 =?utf-8?B?OFJQNEFWM045NDRIaklXNU9nOW8wOHFpbmRtaFF3VXdid1Flekx2OUdCc3FD?=
 =?utf-8?B?UUZFQWNhQ1RITmdNZHZpYWVBUk5QZW44UnM1TFpUOC9wMnl0L1Q1OHNuVzRK?=
 =?utf-8?B?WGtpV05KK0pqYnNoVzhCdXFDdjR6ejZYUDlpamRhL2hjeXdKRlZoTFFlVjls?=
 =?utf-8?B?SzlDU3F2YkpFMUxLazJ2S0M0bHFGc0s2bDZxa0RmVm1KcjBDMGU2M2VVVEJC?=
 =?utf-8?B?UjNjUmN0SmJvVTFFYjF5eUtTMFNHUHlScDRMTTVjTnd1bE1RelRnR3RFUUlG?=
 =?utf-8?B?WGxsUnpsZVNrU29kVFU0UzNkeDZWWVBjclhKREhobFlwYlZDM29RYk1iVkZD?=
 =?utf-8?B?SC81QStWU1pQaEJYSGc4L2pGdUNKRE5STU5XV29TRHV5NG5iWm10SHljakts?=
 =?utf-8?B?VEl0NGR6dzZMZFJJOWNRbTMweUc2ckJIRE5qMUczWWRBMkpqa05iZGszV3Fk?=
 =?utf-8?B?K3JWbTRCb0U5UUE0aVNJMVpjQWNIWERNb2c1eE9ZbkNsVnp6ZzkrSmtaU0NB?=
 =?utf-8?Q?GUMU5XB1gkE=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11861.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4022899009)(38070700018)(7053199007)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ekNaYk5yOFV6UnRxQXlhRGpFNHZ6aW1Uckg3cUxrcG12L2ZzTElqbCs4ZU1p?=
 =?utf-8?B?eVhvRUNSd000ZjNLZTl3RjRWODhOS3YrT2xUOHRkZmE4dThrSEVpWld6Y1B3?=
 =?utf-8?B?VWU5SFRGSmlnTGpvV2lGQXFMYW1XaGg0Q1NidFJ5MFdUR00raEZOY0FnQjgr?=
 =?utf-8?B?bTNUSW5uMytCOUJQRy9SNXVNSFU0MUNSUHVLaitKcytTZTB2YnpUWkpzZGF5?=
 =?utf-8?B?ZkNveS9ma2RGSE9OaFlrWC9JZFA2L2h4U1hKREk3VDVDWU9vZVlOV1R1Q29u?=
 =?utf-8?B?ajJMN1ZoWmZvSVpEbnUxZkx5cTJNbFdkSXRGbm9EYU1HVnJIK0tqcEQ2NSt0?=
 =?utf-8?B?cTM4Zm1LeVQzZW9odk5sK2JBTzIwUmFoSzBocUpNUWVraEJ5OENyVGR6RGxx?=
 =?utf-8?B?ZlBmTXZWY2VKRk5UYUZMcCtNVFJoRHdCaTMyMzBTQWJiRjQrRzluWmpjQzBy?=
 =?utf-8?B?dFZiSm1qQjlsWUxHNHBEa3FzdDFqSHRmRmdpMHBZY1Q5NHB0R3dOUzYvVER1?=
 =?utf-8?B?eTQrK0lWcU55YVJDVnJLcEorSytRTEJrWDlTMHViYVBHemk4S1NaSHlLMGN2?=
 =?utf-8?B?TE1YdDNpOURNK0tEQlBUSFlwcVhhNVgzRlJXVGtTNGpFc3pzT2hNR1B4WFNz?=
 =?utf-8?B?SXJSQkpZaVhpZWlmSlRIRDhGZCtFY2lEODI2T2FFNW5Va0k0cVVvY0tBZzgw?=
 =?utf-8?B?NnJvblAzbjVHQVM2ZjNhcmtyaDBFd3pUdWRyQWptZkJwS1htRWVqOWxMMVZV?=
 =?utf-8?B?Yy9tYVV0WlEyZkU4RzFUclA3c0tTQVZMWndORlFmeS80c2MzMWRNNTdGUVht?=
 =?utf-8?B?cmh2T2dCVHZpbFlhMXcrYjVMMWZ5Sy9tOVNvU2JrMVdkZzNVK1h6QWR6S0NQ?=
 =?utf-8?B?VzQwNEFVOHEvS3hFTUVVRThjNlNWRjhBSVcySEFyU21rRmQzZHk4aC9IU01L?=
 =?utf-8?B?ZHVmRUVGd1lsOFd1dmo5cmxaTHVLN1Q3OXJ6ZjZQUDVqQWd6L0RxRjJFT1No?=
 =?utf-8?B?ZFVBVUR2eUJOSnR2SGpUbG5sM3pTd20xdmJDZlJXQ1BLa1NlVUVJU3RvQzVE?=
 =?utf-8?B?eTh5ajFDNjY3M3JUTCt5UjFLYW9nOG15ZTVteEZoempzMEh6VDVQc01jU0tm?=
 =?utf-8?B?QktsRDF4enRkYzBUWU1OT1EvblZ1b2JGTmYzNXNnTjBUS2FhK0FOemF5T2pq?=
 =?utf-8?B?K0JuYW9HR2s4dEdDd1BqbUtYbFVBNmtYS1FDMHducGFCeXBhWmJOU1NIT3Q3?=
 =?utf-8?B?NCs2UkVkbGJtRVd5dnVnVEVKOC9pclowbW5SV3doM05XVk5tZjJnb0xyK1p3?=
 =?utf-8?B?RDZkbVk3aUxveHZlcmlFVTFTMjE0cFdvT0tXdjRaZlFvY2VRazR2U2Rickha?=
 =?utf-8?B?UTRKc25sY2xVZTkxUFhsdHlNTHVnMndlbHRsaGh4MVdKZmxERzhGTy81WUVR?=
 =?utf-8?B?R2U1SmVGYlVRdzBtQTBkNnVhSnMzeHdhSjJuU0psdGZTV1Q4eWZHMTVYaVl3?=
 =?utf-8?B?SXgyM2FtSVdLU3ZEMStGaGE5eHRXeGxTVFFIaUxaVFZ1dFNGU3RzNGFCQ1Bo?=
 =?utf-8?B?SGxBMHd5OHBRbmJmTzdsVEptNVJGQWtqSk5nc2lpZnlJSDFhM3lBSTdSNTZL?=
 =?utf-8?B?bWtsSnRTQzUyVlRMWEdEdGdya1dyQVJoVDhCMW5uWm52azZjL2JibUlHSkh1?=
 =?utf-8?B?dVR0SVJEOEV6elpvTllMYk9hMHNXWmZzNnRrbnQxMUxTQTVIZ0grb1pjTmw0?=
 =?utf-8?B?cHVXUTVjZ2F1eXppckE4TC83UGwxTW1PR3BnQ2VhVDV0Z2xIZHljZXZKc0JM?=
 =?utf-8?B?enFzaWJJVGxnVXdsME5VaU80UE1YYmNndXJuVE5kTkxpSjZuaFRVY2MvMGhN?=
 =?utf-8?B?WHFkL2k1TzBtMVVhajN3dzJZTFNtZ04yajVzRWZteGU3K09Od3FZbFNsQkZQ?=
 =?utf-8?B?NFptUHY1aUN6K0pZemJyTkJVNFFzK2xxUnFvQWFkMUN2a3BZeXdsdDM3RFVD?=
 =?utf-8?B?YUhjR29lZkxJRTVpZlVhUWZzcDhNa2NkcitZdTlDbDlSUTN5b1VrNWNwZUZu?=
 =?utf-8?B?cXRFTG1oL0tORUFFbFM2VXFLcWViZ0l0eUJvckREckUrc0FzaEl4NTYwZVlM?=
 =?utf-8?Q?LOrHRLwnJBH0zSb5CmIx3geMG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NzWjuq71BIuDGMqkh+gkIJ2Aecm+saLeyuFPKHw0zuJqEmbmG8KcmKp1jjfmcg9rtdUCnbKPquhRwlKpAhF7pavY8qeoSdcdXY9WrHogxCRJKQXcvUGlqxOMGct/+y3LDCQcfZtA5HOmxHI68WrdQOw2ZGHTmFJUZwUMBStJ9ggqz7prHQVFs3NIDf8iOD3s6VkEyfjRGMdcCEQ1ulftIF/sTSHtt4xtQTRkt23QcfjJIPfGJ82ZgALj87PIaTekaSZa5vdgKi+DFTQWpyxE8XNUw3scf6gEA9w7xxE/1+lZq3V87Z5FZPk6zU6PdYcE4KyWs/1/got73f6OjcEC2CcN1gA71J2bTDsOmB7qj+oJuTUiCjc2Ys5G45tJKIRhAvDZCeoT7IJh/RZjqbWpCLGmIRxZeA28nXKttVcthuzEzMLwGFnj5EgneWez/gz/Y1FFlBcNbbGVeD1bVEZU9/i3Kgo9MdirdQFkHyWz7UTxrZhn/wSzkm43obYpT7WZwleqeiOqDGr82AIVmm+6eVWernL/7szDwrS0i2GJ52PRQpscIQyxUxVLjOd83BqeB7XyjwVTYKvxib/Hbco1fexb8OyEAJyeZrFEJdWdQyDs9wyj2JelkgZ11SKotn2I
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11861.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a19e8a-dca2-41e1-ae15-08dd525199b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:27:38.1135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4TIr/11Y7c+j0/Rpuseoxo8NzlZaCbUyanoDOp5AHlbcIJFTiONYKIw1KL7IyFYbQysbbW8oxONg3ESxLPuWEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12659
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Feb 2025 08:27:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1111

SXQncyBkZWZpbml0ZWx5IHRoZSBiZXN0IHRoaW5nIHRvIGJlIGFibGUgdG8gZG8gdGhpcw0KDQpC
dXQgdGhlcmUgYXJlIG1hbnkgcGF0Y2hlcyB3aXRoIHRoaXMgcHJvYmxlbSwgYW5kIGl0IGlzIHVu
Y2VydGFpbiB3aGF0IHRoZSBwdXJwb3NlIG9mIHRoZSBwYXRjaCB3YXMgYXQgdGhhdCB0aW1lICht
YW55IHBhdGNoZXMgZG8gbm90IGhhdmUgY29tbWl0IGluZm9ybWF0aW9uKS4NCkluIGFkZGl0aW9u
LCBtb3N0IHVwc3RyZWFtIGhhdmUgbm90IGJlZW4gbWFpbnRhaW5lZCBvciB1cGRhdGVkIGZvciBh
IGxvbmcgdGltZSwgc28gdGhlIGZlYXNpYmlsaXR5IG9mIG1vZGlmeWluZyB0aGVtIGFsbCBzZWVt
cyBub3QgdmVyeSBoaWdoLg0KDQpJdCBpcyBiZXN0IGZvciB0aGUgYXV0aG9yIG9mIHRoZSBwYXRj
aCB0byBtYWtlIHRoZSBtb2RpZmljYXRpb25zLg0KDQogIC0tDQpCZXN0IFJlZ2FyZHMNCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KV2FuZyBNaW5n
eXUNCkZVSklUU1UgTkFOSklORyBTT0ZUV0FSRSBURUNITk9MT0dZIENPLiwgTFRELiAoRk5TVCkN
Ck5vLjYgV2Vuemh1IFJvYWQsIE5hbmppbmcsIDIxMDAxMiwgQ2hpbmENClRFTO+8mis4NisyNS04
NjYzMDU2Ni0tODU2OA0KQ09JTlM6IDc5OTg4NTQ4DQpGQVg6ICs4NisyNS04MzMxNzY4NQ0KTUFJ
TDogd2FuZ215QGZ1aml0c3UuY29tDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogeW9jdG8tcGF0Y2hlc0BsaXN0cy55b2N0b3Byb2plY3Qub3JnDQo+IDx5b2N0by1wYXRj
aGVzQGxpc3RzLnlvY3RvcHJvamVjdC5vcmc+IE9uIEJlaGFsZiBPZiBLaGVtIFJhaiB2aWENCj4g
bGlzdHMueW9jdG9wcm9qZWN0Lm9yZw0KPiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDIxLCAyMDI1
IDExOjQwIEFNDQo+IFRvOiB5b2N0by1wYXRjaGVzQGxpc3RzLnlvY3RvcHJvamVjdC5vcmcNCj4g
U3ViamVjdDogUmU6IFt5b2N0by1wYXRjaGVzXSBbbWV0YS1qYXZhXSBRQSBJc3N1ZTogTWlzc2lu
ZyBVcHN0cmVhbS1TdGF0dXMgaW4NCj4gcGF0Y2gNCj4gDQo+IE9uIFRodSwgRmViIDIwLCAyMDI1
IGF0IDc6MjbigK9QTSB3YW5nbXkgdmlhIGxpc3RzLnlvY3RvcHJvamVjdC5vcmcNCj4gPHdhbmdt
eT1mdWppdHN1LmNvbUBsaXN0cy55b2N0b3Byb2plY3Qub3JnPiB3cm90ZToNCj4gPg0KPiA+IFRo
ZXJlJ3JlIG1hbnkgcGF0Y2hlcyB0aGF0IGhhdmUgdGhlIGZvbGxvd2luZyBlcnJvciB3aGVuIGJ1
aWxkIHRoZW06DQo+ID4gZG9fcGF0Y2g6IFFBIElzc3VlOiBNaXNzaW5nIFVwc3RyZWFtLVN0YXR1
cyBpbiBwYXRjaA0KPiA+DQo+ID4gU2hvdWxkIEkgZml4IHRoZW0gYnkgYWRkaW5nICJVcHN0cmVt
LVN0YXR1cyIgdG8gdGhlIHBhdGNoIGZpbGUsIG9yIGFkZA0KPiA+ICIgRVJST1JfUUE6cmVtb3Zl
ID0gInBhdGNoLXN0YXR1cyIgIiB0byBjb25mL2xheWVyLmNvbmYgdG8gaWdub3JlIHRoZSBlcnJv
ci4NCj4gPg0KPiANCj4gR29vZCB1cGxpZnQgd291bGQgYmUgdG8gYWRkIFVwc3RyZWFtLVN0YXR1
cyBhcyBhcHByb3ByaWF0ZQ0KPiANCj4gPg0KPiA+ICAgLS0NCj4gPiBCZXN0IFJlZ2FyZHMNCj4g
PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
PiBXYW5nIE1pbmd5dQ0KPiA+IEZVSklUU1UgTkFOSklORyBTT0ZUV0FSRSBURUNITk9MT0dZIENP
LiwgTFRELiAoRk5TVCkNCj4gPiBOby42IFdlbnpodSBSb2FkLCBOYW5qaW5nLCAyMTAwMTIsIENo
aW5hDQo+ID4gVEVM77yaKzg2KzI1LTg2NjMwNTY2LS04NTY4DQo+ID4gQ09JTlM6IDc5OTg4NTQ4
DQo+ID4gRkFYOiArODYrMjUtODMzMTc2ODUNCj4gPiBNQUlMOiB3YW5nbXlAZnVqaXRzdS5jb20N
Cj4gPg0KPiA+DQo+ID4NCj4gPg0KPiA+DQo+ID4NCj4gDQo+IA0KPiAtPS09LT0tPS09LT0tPS09
LT0tPS09LQ0KPiBMaW5rczogWW91IHJlY2VpdmUgYWxsIG1lc3NhZ2VzIHNlbnQgdG8gdGhpcyBn
cm91cC4NCj4gVmlldy9SZXBseSBPbmxpbmUgKCMxMTA5KToNCj4gaHR0cHM6Ly9saXN0cy55b2N0
b3Byb2plY3Qub3JnL2cveW9jdG8tcGF0Y2hlcy9tZXNzYWdlLzExMDkNCj4gTXV0ZSBUaGlzIFRv
cGljOiBodHRwczovL2xpc3RzLnlvY3RvcHJvamVjdC5vcmcvbXQvMTExMzAyNzE1LzU5NzQ5NDYN
Cj4gR3JvdXAgT3duZXI6IHlvY3RvLXBhdGNoZXMrb3duZXJAbGlzdHMueW9jdG9wcm9qZWN0Lm9y
Zw0KPiBVbnN1YnNjcmliZToNCj4gaHR0cHM6Ly9saXN0cy55b2N0b3Byb2plY3Qub3JnL2cveW9j
dG8tcGF0Y2hlcy9sZWF2ZS8xMzYxNDI3MS81OTc0OTQ2LzE5MDI4DQo+IDMxMDY2L3h5enp5IFt3
YW5nbXlAZnVqaXRzdS5jb21dDQo+IC09LT0tPS09LT0tPS09LT0tPS09LT0tDQo+IA0KDQo=

