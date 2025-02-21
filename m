Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572FDC021AA
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 05:03:21 +0000 (UTC)
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
 by mx.groups.io with SMTP id smtpd.web11.16533.1740114191702835471
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Feb 2025 21:03:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj1 header.b=vElpoMmL;
 spf=neutral (domain: fujitsu.com, ip: 68.232.159.87, mailfrom: wangmy@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1740114192; x=1771650192;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=TpytvoY3UyzjT9SQbnoSLMjZh+rfpUtvWKQBhnaD0ak=;
  b=vElpoMmLlQgV4is9I9h30HuOaUxduIbQrAyRz+VKNR/BqTsLsz5s0gt+
   WUNly2yZgFt9tgEJU3XHcmgIs89E42oyyUWWsxbHCyyS7qR2XXooZp9M8
   n4XN3W8wENkVlUshGYQ39+9M4pF2vgCna2c8YMN0kvN6bMrR46pNnuj+t
   tW460TFh5PMS3uRvGKpkVxe/J8S3YqmIr38r9mCy9v9hvk5aLoBH5GlAf
   TrBq5F3ez/E09L0g9cX3cqcVAifj1M7/AjryMDntT4cmlDUF6c11uFCr2
   0k2Xyu8MgnXwZlMlSy3E5rNK0qtnaqAPx0Jb/A0t5QIk5Pfw67W8jsJ4u
   A==;
X-CSE-ConnectionGUID: ikSayLzuTzq9mc4uAoXW7w==
X-CSE-MsgGUID: alZmiUaoQb2DjYWsTBXS9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="147098535"
X-IronPort-AV: E=Sophos;i="6.13,303,1732546800"; 
   d="scan'208";a="147098535"
Received: from mail-japaneastazlp17010004.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.4])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 14:03:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMZvkWzNnt0BS47ddireB+Rs+sZ8W6+4AWZUYRmjPdVJUaUleM+UVU2JCQFrqxZxVUSyYKHBtpZbhsSI+vYG3MOGtxCKQg1TGgqcOVQiygizh5f283JOiK2Lq5HkHzyWcC7ciSWsltd6H4KOwMzjeTZkhYhw+d362UamYFuZzGNIcckgNI0xFR07cex21uh2ijASHblO819uN2Tyk2WREMC+WIiWHULKl0mAmuHzVALhmCCFhNwqr9Gc9tFOz9X2Np4NnWlV7znmLg/4RSraSgbYjxqQtLhKUemKdEPTWg4TEB9lEcMq/0O0U0XQceIh/Uy13TmD2UtPthqcja/c3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpytvoY3UyzjT9SQbnoSLMjZh+rfpUtvWKQBhnaD0ak=;
 b=vNTzh2N19onKG1K9cudc8YuUtxVqyKdGkWo72lI6p29zvDoTZkQUdhDh2sC4MLM6fZr3WtyYTHf3VhojV0HsqPKf7G/Ww+gc71aqKEWoJe6Keek9RKmPMgHDgNdk5fjeD+Jhhee2dxQLuCKB+Agus65L/hLwc9ltGpJ7UX4Rwb6SnkfmydrdQU2vbydzdMc870pYsEzo1w+cmynlhbNtcUOq0aiPvsUdgYI6wumnhVKTdcFIcgNhBuUGHaI4naMddUAWZFIQbzQ33jJselVo8g8WLPbms6PY42ueU9xB/LaVPwvddWuXC7RNae1cix/I+aLG3L2oG7CC0d0ro3yG8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB11861.jpnprd01.prod.outlook.com
 (2603:1096:400:3fb::13) by TYCPR01MB8222.jpnprd01.prod.outlook.com
 (2603:1096:400:103::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 05:03:03 +0000
Received: from TYWPR01MB11861.jpnprd01.prod.outlook.com
 ([fe80::e0dd:28e5:6a6e:2342]) by TYWPR01MB11861.jpnprd01.prod.outlook.com
 ([fe80::e0dd:28e5:6a6e:2342%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 05:03:02 +0000
From: "Mingyu Wang (Fujitsu)" <wangmy@fujitsu.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [meta-java] issue for icedtea7-native
Thread-Topic: [yocto-patches] [meta-java] issue for icedtea7-native
Thread-Index: AduEDbg5224KG8ljSquniZx/2s3vugAEBnpA
Date: Fri, 21 Feb 2025 05:03:02 +0000
Message-ID: 
 <TYWPR01MB11861ECBC7791393567A5C587DCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
References: <18261A71DE60CB96.20721@lists.yoctoproject.org>
In-Reply-To: <18261A71DE60CB96.20721@lists.yoctoproject.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=29c098d1-ad61-4848-8924-a7464e88232a;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-02-21T05:02:44Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11861:EE_|TYCPR01MB8222:EE_
x-ms-office365-filtering-correlation-id: 7b51c0a0-cb7c-43d8-9a25-08dd523504ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|4022899009|7053199007|38070700018|1580799027;
x-microsoft-antispam-message-info: 
 =?gb2312?B?ZExYSzFDZUhoYTJGelVDOXgwclZmVnBXNTJ5TkowQmszMkdzNFExTkp1WjRU?=
 =?gb2312?B?b1pER3hDUnFob21aVXMvQU1KcWs3NmtDY2xrVUszK1hHWVhtS2V3K28rMi9P?=
 =?gb2312?B?Ujdzc2RuMFFCam5hUmxVRHFvSWhoeCtON2R3cmQ4UlpGQWx6VzRrVjBjVGVm?=
 =?gb2312?B?bzluZ3had3d4b3o5aGRwVGFrT0xtTHFXSWs5OUZqblp6aFJQdVpSL2FYckZs?=
 =?gb2312?B?d2p0WXplQ1RYc2M0Wm5xdFNMdElCUnpwZ3AwMjBrYkZFUWtRd0tldjVaWWNS?=
 =?gb2312?B?Nk13V0dDbkF3Q0lFWXFKcjVObmRZVzlYdTlMKzhWQ25CRDhVQlBmb1RpZW5E?=
 =?gb2312?B?WGxnbGNGaGdtVjlmRTBvdkh5UDVzaWxDSk5WOXhVOWZhMUx1YTBXU3JwYXM1?=
 =?gb2312?B?bUp1VExlMm1QTTFtQ1FMMUVDRkFRSWsvMWNEbFdZbWhVYmlmRC92ckU5TXFo?=
 =?gb2312?B?RlEwWHIvZ2kzT2NsaWo0dnZUY1FGcTZZVXRUNUpiOXkrUmVmTjdXcmxXRExm?=
 =?gb2312?B?dE8vV2U1NWZLR1hSeGF5RzVKeU5sVTlNRXVCcjlMSEllcURGRE1pQXJENFor?=
 =?gb2312?B?TmdQVk9DZlh0SHRldTRLQ3d0S1hpMkVWa0gyVVVBM2JzRmgxQjJHd0tOQzhZ?=
 =?gb2312?B?eDI5RlJHS00vTWRkSkx2RnJIdzdkR0dEYUplc1RoN09ieTh1RmRpTVAwcHFa?=
 =?gb2312?B?NEdSRUZ2eTlaajJNZlBNc3ZHM25XbXZNSW9zbndlcW5yUmNqOExtaDBUM0dV?=
 =?gb2312?B?UHFrUEpJcS9Mem5SVGwrd3ArZ2dhTG4vbE5LcTZNOGEzRHgzazUxeS9kQ1Fo?=
 =?gb2312?B?ZHc1c3VWYXQ1U2g2NVBvQzNSMFN5bkZ4d1grY0RIenFsejF4NWxTZlNqazZv?=
 =?gb2312?B?Vm5xOGU0UzgyOFBtc0FJUVpMa1NWdG9ZS1crT051YVRRb2pPcVgwTTdreTBk?=
 =?gb2312?B?ZDlsTFlCSU1Kc1dkRFZ3d1NGemVqaTF3SUQrR2tPdkZkNk9ORjZNd2MzbFlt?=
 =?gb2312?B?QytjOHJBR3ZSQ3VwU3NOWEhaRFQ4VDRyT3crTkdUd0V5T3JYL0RjNzRxNTFp?=
 =?gb2312?B?REk2Ukc2VFBLckZwNGF4Y3dmZERoVWFDZDY2WWdRNDlteThQT1gwZmRFL0dn?=
 =?gb2312?B?U0hTc2J2QTRoZDkxK1lpL0NFSjlFU1ZZNkhIeUdTMXdlM2hnVG5Gc2h4SmRH?=
 =?gb2312?B?UWVMd0ZNQk44S1cyOXgzMHlRdFhxZ250Y1A1dUl6WFg5TE9vTkNSeDcxYVFZ?=
 =?gb2312?B?ajA4eVRlOW1zTk8zdDBzUnhsTGtNVUNmSjlmRVRLSDRseGM5YWRQdWR5cFJK?=
 =?gb2312?B?a2tnUitxNkREY25aNGkyT25Qa1pQdk1rbzUwTCt0cWdubk1CQVFKRWViOXA5?=
 =?gb2312?B?RlUxYi9sdTYvQVFHaDFwQWN1aENrcnhNM0VkUFNCTUVseURnZGV0ejlCeXFs?=
 =?gb2312?B?YXVHdTN2anA3aXFsL2ovTlpPdUpQa0V3RTc1UGxQTHBsbVc4bEdNcEpMQXVY?=
 =?gb2312?B?RmJKbW0rRnZPcDVHeHl5NmZnMkNWd3E2aDJqZHVNYUt4YStNbTZNa1hTTjRm?=
 =?gb2312?B?TFNPSkxRMyt0MlBYVGsyeHNNbE0wMzdVQXN2eEJLVXhMajZpRlNzYU5qbTNR?=
 =?gb2312?B?ZU5QNlVnZWRmY1dQdWVVQXgyQVd5VEtwVC85dkdlVmNIK2oyeGVRVnk4TGtN?=
 =?gb2312?B?NTUreVpxc01qYUZTYi9xVVc4YTNGV1dHcTZVWW1NUzdVMWNyeitOQnpqLzNx?=
 =?gb2312?B?bWtIMVhTYXpLL3ZMd3M2c3ZXSHdXbHJ4MmVKRWJlVUdweEFyaGwwWHFqSnoz?=
 =?gb2312?B?a1hnM1AzS29UM0tJR1pHNjdiNVJLS0J6SExzakNpajQ2TlhoeTIwaWxtSFZ0?=
 =?gb2312?B?SGVHckx3cmVPY0NPVnRWMVJrclZPaWhvWDZJSWk1T3B6VlE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11861.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4022899009)(7053199007)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?bDQyc0x2eDRTUXQrbFVibjZyMHZRUlBLV3IxSTVNVHB5VDFwNFJGUVl0bGs3?=
 =?gb2312?B?V2NtSWhGbGVBZTNLZ3c4Zjkwd2hxQlVWUXNQOUpEd0MwUHo2ZnBHRlhhZ1dN?=
 =?gb2312?B?OWpEeWdqU3FpZXNJZU42MEtOYVhHQ3ZTRTh0bjBvblV3c016SFpvR2RLZUdP?=
 =?gb2312?B?dWduVGVsSy9BRmFuRUtRZnZoSExZcWV4R2txS3RLUmxJVVpXOG1xMHV0bFFU?=
 =?gb2312?B?NEhQeEx1QW54UVJVeWRyQVFKZFJIeXorbmQ4TWg4ZHJsNEIrK2s3UEFlUlZV?=
 =?gb2312?B?ekpJN3pSU1JRRE9aSkUrNHV5SW5kOHlBd2Vqa0d1WXl0aWp6Y1JmemU2Tk5D?=
 =?gb2312?B?aVh4NzBXVENCWDdkRnVkWnBlMWpDeDlqSVZhZjZwQ0puaDd2MXNQTmpEUVBp?=
 =?gb2312?B?TG92bzZFTVZOMk4xTmZYdCtUNFRtZmtYR29WVTcwa2RHUkJ4V2draDNRakE5?=
 =?gb2312?B?U3h0eDhNbmVyNTZlVkpQdjJUTy9uN2kzbHg4ZW5kZEszTDliK3dSREFTelFs?=
 =?gb2312?B?Q3dNcEtralNwZnRja3NJWktPNWVydHlhS3JpbkRxSFBqOVFGNHNqakFhQXRo?=
 =?gb2312?B?cys2enFJT3o5bkpGcG1LREszdzczeWdsYU9QNzJrL2oyV2E1TTNyOXpmOFEv?=
 =?gb2312?B?Qmx5M3FLQ3VNeEY3MjFGRm41cGRudUxSTUtLVWtIZ2pXMmxvVGVvTlFlWUhE?=
 =?gb2312?B?VDhHVzhtNUF3WllXY0NtU1lETHIxU1d5TmJLUmZSWHhDT2prZ3hqNFQ4akdv?=
 =?gb2312?B?UHVKQUtRL2JHYUtvN3N4dGRvWHdUeDhIYnFsVFFNVHE1eVRvMjMxVjRINFdN?=
 =?gb2312?B?UXNBVDg0amZQY3VjS2dnTm5HL25xTUZGeWgvUWZQTmowb1FtZUNWVXNWZWV4?=
 =?gb2312?B?U1RsTEU2QmpBYVVoQm40aWNTcVIzQ3RyVUtYQ01MeEJjWExmcmd0M2xQcDJS?=
 =?gb2312?B?UUZzNytqeHo2MVR0bkFuT2VJR2g1enpmMjlXdHJJVEJaTjN3RW9qTzNYUkpI?=
 =?gb2312?B?cFBXcUJvMGJIL3hIam0wOEtwdXdkU2RsT1ZsZGRWMzFybWFZNFBXMklHMjVw?=
 =?gb2312?B?UGxKNW84N3Buam0rQlhuajdqQjdYRHNtZHFjK3h1Y2NkZDh5TXdpNUhmdGhM?=
 =?gb2312?B?WGk2Y09kc0ZjcVBSWkM0cXR3VnVYbmMyNHFhNHYwaVpTUktKS3h0ZnlpbEZM?=
 =?gb2312?B?RmdrdFNBbjVKUW5HVGREZC9mODd4cHpUV2dBQUp4ZVZkUTZHZDdoVi8zclN6?=
 =?gb2312?B?ajQzNHd6VlRpd1lTeXJXWm9VT0c4c01QcVd0MHZ1VmxScnV6cEN0U3hMU0Iz?=
 =?gb2312?B?WWhNc1psR0FzSjY0R0FZeG1oTXN5ZDJXUGNsMXhReGJzQnZVK3pYdUp6bytR?=
 =?gb2312?B?ZTlya3RrdFNIbjYxenZCSW9WMzEydFowK0xYMUM2LzlLdm1RUnhtaWtWUzdY?=
 =?gb2312?B?T3Zobnh5V2V2NDdJWkw3anM0bmhkTWZJLzJIc0psYU5kL0lTRFFwcVBXcVht?=
 =?gb2312?B?dlFIVlhVandQYjdOc2dYL2o2UHZUaUUyYXRYdElUOW5zYS9MKzJYMyt6TGZm?=
 =?gb2312?B?dENTdkhkU2ViTjBpMjR4VkhxNlVCVytPdFdLcUNwdDlRSUdMVTk1b2M3ZkNQ?=
 =?gb2312?B?RjV3aWwrTGwxeEcwUXRldURkeEdVVG9jTjZHSnFJZDU5VXdlVm42WHAreDVj?=
 =?gb2312?B?cHd5U042VkR5ZWt1Sk56b3gzYnhVaHh6RGd2NGc0a1ZYMXdjRHo5dFN4VEd2?=
 =?gb2312?B?cGFUbm9mN2d5dlFmUkFIWnZrWGdtVlhhTVpGM0NjSnlaZHhpR1R3cnNtYjVx?=
 =?gb2312?B?WjNHdG95RlpZTXhhc2dLU0UwUWpxRXRKY0lGR2paRE9uWXFIeStmc2hHbVFw?=
 =?gb2312?B?Rm5uSzRCWWVkUldyUXdaWDZ0Y3dYYUtldS9lZTFzd1VsNWNESUxZYjk5OWYw?=
 =?gb2312?B?eEdySlBIbkNmalJyOVhKUVVUeTZxbUtyS2pTT1BxQitnSXZsb0NZZEwrSFM5?=
 =?gb2312?B?U0VRVFhHSnZnTjlQV0M4aXJVR05sMU5YNnl3Y0tUa2dxNk5Gc1pkenhZR3B0?=
 =?gb2312?B?K3BvdDFpYXd2cERidjBDdEU3UzNPWDlhdHRCZ2NWWXZSemxMMm9Qd0IrSzFW?=
 =?gb2312?Q?7i9JCq4vxPfxPQ1jx8VLklZyv?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0BrGHuSWTuocOOurAu1RoUu3kM6jMQpbGT/37aRtcSGT3Xn0QgQnZqXZpPjh09f+BRXv1I5TUvoMmZMIsn2w84EZ521wzrviLB8nhdc8pLTGWAHLh6XM0oV2ku8ydjL0jzRpOsJqR4Dn96UYrDKnsLD2rxtLKQa+YiJlH3SU4C8vlOduuZIGRT+Owr15zh6T76avY1s2/5UI2BjDQ2cwAZtJ+LpoRiVTnbsww56pCpq3cLAsVpqgnrM1yxRd//LRgqApF/H3w/AC+okYy7KaO/d6gAuXRMl65WW0EKKldpgXijDrBHy+Qw7mB6Cud6tRinPtdwkmVM8uoR4r10ru4z36QlUYMkVs3/Xsw4zXV1YjTY1rTVPB2nYy7to17HK4fj1SsLfMwkSVNozMtxK3ZBDrc0dlINypgsnPWPrWmQm1fvD++b0BqPJUAO0Xe4hRa3KhXpmoxtkZwXHWIlpNnxOX377fIkmPZF3lWr1bKta2z3Qc0KfRrn/PpQEoQWiK0aaVfKYSTnJPXj/rUBfjtKgRzAi55byjbZVxqN9eRtG10uAeBaPuJnz4er0m9rC+PSpvtNOGXSqCvHlciLD9e/yyPT8YHmng5ZGfJdX9b96uAJd4fN5mGE6S5Gm6T9/r
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11861.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b51c0a0-cb7c-43d8-9a25-08dd523504ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 05:03:02.5570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dHG8tFEz/7YPaWJe/1AqaCLAu9vcnQioRwhgZzgMo9Px1LpF0jjBeHskPu2hp/pypmK4epk06AtINWG5xRZnbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8222
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Feb 2025 05:03:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1110

UGxlYXNlIGlnbm9yZSB0aGlzIG1haWwuDQoNCiAgLS0NCkJlc3QgUmVnYXJkcw0KLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpXYW5nIE1pbmd5dQ0K
RlVKSVRTVSBOQU5KSU5HIFNPRlRXQVJFIFRFQ0hOT0xPR1kgQ08uLCBMVEQuIChGTlNUKQ0KTm8u
NiBXZW56aHUgUm9hZCwgTmFuamluZywgMjEwMDEyLCBDaGluYQ0KVEVMo7orODYrMjUtODY2MzA1
NjYtLTg1NjgNCkNPSU5TOiA3OTk4ODU0OA0KRkFYOiArODYrMjUtODMzMTc2ODUNCk1BSUw6IHdh
bmdteUBmdWppdHN1LmNvbQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZw0KPiA8eW9jdG8tcGF0Y2hlc0Bs
aXN0cy55b2N0b3Byb2plY3Qub3JnPiBPbiBCZWhhbGYgT2Ygd2FuZ215IHZpYQ0KPiBsaXN0cy55
b2N0b3Byb2plY3Qub3JnDQo+IFNlbnQ6IEZyaWRheSwgRmVicnVhcnkgMjEsIDIwMjUgMTE6MTAg
QU0NCj4gVG86IHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0
OiBbeW9jdG8tcGF0Y2hlc10gW21ldGEtamF2YV0gaXNzdWUgZm9yIGljZWR0ZWE3LW5hdGl2ZQ0K
PiANCj4gV2hlbiBiaXRiYWtlIG9wZW5qa2QtOCwgdGhlIGZvbGxvd2luZyBlcnJvciBvY2N1cnJl
ZC4NCj4gDQo+IElzIHRoZXJlIGFueSBzb2x1dGlvbiB0byBkZWFsIHdpdGggdGhpcyBlcnJvcj8N
Cj4gDQo+IHwgZXJyb3I6IGphdmF4LnhtbC5kYXRhdHlwZS5EdXJhdGlvbjogYmFkIGNsYXNzDQo+
IGZpbGU6L2FybXY4L3RtcC93b3JrL3g4Nl82NC1saW51eC9pY2VkdGVhNy1uYXRpdmUvMi4xLjMv
aWNlZHRlYS0yLjEuMy9idWlsZC8NCj4gb3Blbmpkay5idWlsZC90bXAvcnQtb3JpZy5qYXIoamF2
YXgveG1sL2RhdGF0eXBlL0R1cmF0aW9uLmNsYXNzKQ0KPiB8ICAgY2xhc3MgZmlsZSBjb250YWlu
cyB3cm9uZyBjbGFzczogamF2YXgueG1sLmRhdGF0eXBlLkRhdGF0eXBlRmFjdG9yeQ0KPiB8ICAg
UGxlYXNlIHJlbW92ZSBvciBtYWtlIHN1cmUgaXQgYXBwZWFycyBpbiB0aGUgY29ycmVjdCBzdWJk
aXJlY3Rvcnkgb2YgdGhlDQo+IGNsYXNzcGF0aC4NCj4gfCBlcnJvcjogYmFkIGNsYXNzIGZpbGU6
DQo+IC9hcm12OC90bXAvd29yay94ODZfNjQtbGludXgvaWNlZHRlYTctbmF0aXZlLzIuMS4zL2lj
ZWR0ZWEtMi4xLjMvYnVpbGQvb3BlDQo+IG5qZGsuYnVpbGQvdG1wL3J0LW9yaWcuamFyKGphdmF4
L3htbC9kYXRhdHlwZS9EdXJhdGlvbi5jbGFzcykNCj4gfCAgICAgY2xhc3MgZmlsZSBjb250YWlu
cyB3cm9uZyBjbGFzczogamF2YXgueG1sLmRhdGF0eXBlLkRhdGF0eXBlRmFjdG9yeQ0KPiB8ICAg
ICBQbGVhc2UgcmVtb3ZlIG9yIG1ha2Ugc3VyZSBpdCBhcHBlYXJzIGluIHRoZSBjb3JyZWN0IHN1
YmRpcmVjdG9yeSBvZiB0aGUNCj4gY2xhc3NwYXRoLg0KPiB8IDEgZXJyb3INCj4gfCAxIHdhcm5p
bmcNCj4gDQo+ICAgLS0NCj4gQmVzdCBSZWdhcmRzDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBXYW5nIE1pbmd5dQ0KPiBGVUpJVFNVIE5B
TkpJTkcgU09GVFdBUkUgVEVDSE5PTE9HWSBDTy4sIExURC4gKEZOU1QpDQo+IE5vLjYgV2Vuemh1
IFJvYWQsIE5hbmppbmcsIDIxMDAxMiwgQ2hpbmENCj4gVEVMo7orODYrMjUtODY2MzA1NjYtLTg1
NjgNCj4gQ09JTlM6IDc5OTg4NTQ4DQo+IEZBWDogKzg2KzI1LTgzMzE3Njg1DQo+IE1BSUw6IHdh
bmdteUBmdWppdHN1LmNvbQ0KPiANCj4gDQo+IA0KPiAtPS09LT0tPS09LT0tPS09LT0tPS09LQ0K
PiBMaW5rczogWW91IHJlY2VpdmUgYWxsIG1lc3NhZ2VzIHNlbnQgdG8gdGhpcyBncm91cC4NCj4g
Vmlldy9SZXBseSBPbmxpbmUgKCMxMTA3KToNCj4gaHR0cHM6Ly9saXN0cy55b2N0b3Byb2plY3Qu
b3JnL2cveW9jdG8tcGF0Y2hlcy9tZXNzYWdlLzExMDcNCj4gTXV0ZSBUaGlzIFRvcGljOiBodHRw
czovL2xpc3RzLnlvY3RvcHJvamVjdC5vcmcvbXQvMTExMzAyNTUwLzU5NzQ5NDYNCj4gR3JvdXAg
T3duZXI6IHlvY3RvLXBhdGNoZXMrb3duZXJAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZw0KPiBVbnN1
YnNjcmliZToNCj4gaHR0cHM6Ly9saXN0cy55b2N0b3Byb2plY3Qub3JnL2cveW9jdG8tcGF0Y2hl
cy9sZWF2ZS8xMzYxNDI3MS81OTc0OTQ2LzE5MDI4DQo+IDMxMDY2L3h5enp5IFt3YW5nbXlAZnVq
aXRzdS5jb21dDQo+IC09LT0tPS09LT0tPS09LT0tPS09LT0tDQo+IA0KDQo=

