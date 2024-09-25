Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AA3C369A3
	for <webhook@archiver.kernel.org>; Wed, 25 Sep 2024 07:18:45 +0000 (UTC)
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
 by mx.groups.io with SMTP id smtpd.web11.9665.1727248716539783745
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Sep 2024 00:18:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj1 header.b=fpe/p6Qt;
 spf=pass (domain: fujitsu.com, ip: 68.232.152.245, mailfrom: wangmy@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1727248717; x=1758784717;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=DoJXQWIB5zrvMHktlEZNaWQkxarllVYwaCzUrEbvWNc=;
  b=fpe/p6QtymYBTXFsaGWFypyO/GvY1u3kSYPBwEhNJhfMLBuFplTryk27
   alFLEmmkd69QQrMPHsQQS+AeI3cqqPb6e3hEJIyd2CUTekfNSKla6Q8oc
   l3jFSTWTIhcUNsZPjcvZue8pseM2FnqYuPtRPwzx9GvrjXB/lnQ1k48AJ
   L4fdOzSuwgOGleQJqQt5HEcVFmm4wVlTbPZ9J8KmB4uNIhribkl7m9CfG
   UzFrKjZdBXsC7nd3RU0yAy0zQzXg0HnPlRgR/ihSEs7trA3zrq9RGATii
   TZRakKu0Hv2U6Ncuc/YdDq08qSo8tXkfLoUbLl9sOhIB3EN114HBUZUww
   w==;
X-CSE-ConnectionGUID: bEOi/S+NR86F4X8zovwW0A==
X-CSE-MsgGUID: 1DQiAou6Sey6OUimYm0ajA==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="42878253"
X-IronPort-AV: E=Sophos;i="6.10,256,1719846000"; 
   d="scan'208";a="42878253"
Received: from mail-japaneastazlp17010000.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.0])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 16:18:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvjxLYC6Qkewkcd2kn5KDkgMtaNyACxCKcqYYNNjozhzmU+f/I2WYUy2/sNfGbxiVsOFn3XUHlz3nUw88+urcBGx3qb3Y9gYkTFzxVGGu25n0HKx0Kbjk/qDzhW0syzNRMC+g6MOALG6jBRVGbSxT4y3XelpmM21/WcQ/62/M5t4jgKXuoqjUHwmfZeKFUGjLZSkivFAiaSoJOM8ksHZMu4ZNAWqF1ms2CpxxApkfz9GHVYEl06w13Y5QLfzfWDG6uo4tCUoePwkODVReROdYi+sHo0Af744qZ//g0MWhNIBHrR8mTD47txqJrMkG84FxxfUznoifZ75FEhMFWTwjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoJXQWIB5zrvMHktlEZNaWQkxarllVYwaCzUrEbvWNc=;
 b=blDwNd8WOLnLD8m4oWtVhCftqlpntxmYfJNSlcwCosFwrF7LcKZr6SD1YKXmvtZqtm9tDiVBDtabUsqBWq8ZLtoRrcfyvuo1WTAHlCmF13TTNe4ig++gNgX5yIhKhcbvqqqJBTeRsN9ssXFLqCq04QQuTXS6jgJ264FFTGHfHI5zJHNVkcrg+lqjvVfDwgtItTZadr4BS9g29d+2JyyriDQx24r1DpNOzezv4d1PHd2pkEexYFqKyqJ++6KDIOXApL0jQ9klyP8FT/SxPpvbLgF9/pCJHGMWzLgMyudrzzuTGzcgTP7+TDn8dfmnJV7t4NJtnBevf41gMV/OQpbd+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB11861.jpnprd01.prod.outlook.com
 (2603:1096:400:3fb::13) by OSZPR01MB8632.jpnprd01.prod.outlook.com
 (2603:1096:604:16c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 07:18:30 +0000
Received: from TYWPR01MB11861.jpnprd01.prod.outlook.com
 ([fe80::e0dd:28e5:6a6e:2342]) by TYWPR01MB11861.jpnprd01.prod.outlook.com
 ([fe80::e0dd:28e5:6a6e:2342%6]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 07:18:30 +0000
From: "Mingyu Wang (Fujitsu)" <wangmy@fujitsu.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, Tim Orling <tim.orling@konsulko.com>,
	"geoffrey.parker@arthrex.com" <geoffrey.parker@arthrex.com>
Subject: RE: [yocto-patches] [meta-java] [PATCH] layer.conf: Mark as
 compatible with styhead
Thread-Topic: [yocto-patches] [meta-java] [PATCH] layer.conf: Mark as
 compatible with styhead
Thread-Index: AQHbCmLK7CxPzWH7IU2alS4IfA7aVbJoISBA
Date: Wed, 25 Sep 2024 07:18:30 +0000
Message-ID: 
 <TYWPR01MB1186134E33F5CE853AAA7FC8EDC692@TYWPR01MB11861.jpnprd01.prod.outlook.com>
References: <1726729681-15869-1-git-send-email-wangmy@fujitsu.com>
 <17F69383A11C4523.31299@lists.yoctoproject.org>
In-Reply-To: <17F69383A11C4523.31299@lists.yoctoproject.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=8e964479-3799-4fff-b6a2-4527ce462e1d;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-09-25T07:17:22Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11861:EE_|OSZPR01MB8632:EE_
x-ms-office365-filtering-correlation-id: 059d32f4-b650-495c-49d8-08dcdd3241f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|4022899009|1580799027|38070700018;
x-microsoft-antispam-message-info: 
 =?gb2312?B?Zk1TNGFGR2MvWGpaVDVXc3h1TjMweGUvUndrMlJodURPUmpRNEJBSUdHc0k3?=
 =?gb2312?B?U0dDSS9Ob3IrQ2NUOFRtU0w5cm5UUjZidytkSU9TSEl3ai9tTzh0WTJZMVIw?=
 =?gb2312?B?UXVEYTM2NnJZRXhCTHJraklCdGRHdGFMSW9IS0pXc2VIM1pSN0FjMjJGcURt?=
 =?gb2312?B?OWx6ek4yQU9NQ205R1Uxd3NOU2E2SStFTFJCMWFRVUJDT0pYUjlKZHNvVFFw?=
 =?gb2312?B?VkFSTHd3NVRmeGd2Z0xEcmhuUklFbVB0c2U2RVdVeGFFTGxEOU8yWEdEMUhh?=
 =?gb2312?B?MUJ5L2xra2JOd2NmNmNJQWxaMWp5N0p2WTNsUnJqYlpwWDdSbjV2enpqSlBH?=
 =?gb2312?B?UkdsajJYRldRVXMzdHFhTktEMjcvMzErWDBWMTQ3eDEyQm9vK2FyK3I1endE?=
 =?gb2312?B?a0Z4cXdQNjI4aGd2YzNaVU8wZ2tTS1BxdGErZU5raXBDeDRqUCtjUkFvd2sv?=
 =?gb2312?B?clVNSDFKeEcrSXJVLzYzb1NzQjZDWmtlQ0NHSjZya2NseGF3MGN6NStuaGFp?=
 =?gb2312?B?VWJoczBLYUIrRVkyeXRCRnQ0RkRyVSt1MXdQMmpvdnlUQ1VBZDJoYzA4aFBm?=
 =?gb2312?B?cGJ3N0ZrckVLbUgyN09YQ0d2TVpRNzJCbi9JVmk2MmtIUURDTjVwcEp5SW8r?=
 =?gb2312?B?dzh0WllQa0licnNyOWx2RjU0dHl5cEVxcmpsZlZMOVF6dHVNMmZHU2tPaW1t?=
 =?gb2312?B?NjFCV0g5Tjc4V29CTjFFWlo0VHZOWGVKL2JKcjFDRjNoQ1ArNFM4M0xWYTdR?=
 =?gb2312?B?NE1DRU5vWUdxcWpMY0FzZVR5cWl4elI0c2YwQk83ZUM0SDZsbDQ5cmxlc21E?=
 =?gb2312?B?K095NTFWYkdybDJ6bjBSVDVNWm5ZQ3NsR3RBNVhHRG1ZZVpIMlpNdjhhMktG?=
 =?gb2312?B?djJnQmRtR0s1T2RmdFlFM0x3THRQWlZaVUg0TWNldXh6eHdaRW9rVlNGdjV6?=
 =?gb2312?B?THRUR1h3Rkt0aExUTjV6ODVHY3lWK0lQbGV4ZnM1VzZZTys2TFdOVmV5b0FB?=
 =?gb2312?B?L1RicVBHWDR3ZklpdVIvb2hIZ21qcEhRdExQVi9tditrQTRMZFZZTjUzMmtz?=
 =?gb2312?B?TnFGb0FWdmhwcCtiS2xEc0Y1SzRkVmphOXdxYWFyNUtYUmsvWUVROXJXZ2I0?=
 =?gb2312?B?Y2NMNFFET3dmMUU1WVo0bnA0RE9LcEl0bmo2VEJrRUNLeFUyUnppOHZUR3R2?=
 =?gb2312?B?bDU4L3EzclEwUG94ckVjQ0w4cC9tZG1BSHFkQ1N4alN3MWY4Zzd2b016Qjdx?=
 =?gb2312?B?eTVLaUlVbi83c1RzN012UWNzTmRpQUU5Mng2Ym00NjhGVnhoRlpCbVh0a3VV?=
 =?gb2312?B?K0h1Z3BJVjFjWFJZTnlGYzVCR0J4bngzTDJGM2w1QVBuL3JZcVV4WFZvVVRo?=
 =?gb2312?B?dXlzNnlsd3g2MVh0OWQzSHVkcXBNN2tZZjZNMldMN2RHdFlWdVhIS2p0Syty?=
 =?gb2312?B?YkZlZ3JqQlQ5dVAyd3FFUFFqbEgwVUlVRU83dy9tVXRKMWt1dUxESnNWRHBq?=
 =?gb2312?B?SEhOZDNOWDE4K01kR3k0dFhxeFV6aUtNT08yVlEvaHZMdDJTeFY4Slp3M1Qz?=
 =?gb2312?B?SGNtRytscHE1M0xoWFVuWERpTzhHcUJBRnNmSHFkM0xGVVVxVEwvUEFSSEsr?=
 =?gb2312?B?SllYWE10bmhSaHpsMkJabXR6YUZLUjlpNEYwTVJUYkRoeDdHdTR6aDE5R1dh?=
 =?gb2312?B?YzJtd1NnTk40TlhGRHpzK0FHcXlQeEFValNqR3g1WERUM1RNQ0NFNVlnQnlD?=
 =?gb2312?Q?phPyZ6Oreu3cjQsrTAsdcvIaqRrRRK802tfKz29?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11861.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(4022899009)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?SkFPRFZmNk1Vem5EcmNYMlg2UFlwR3p0dkU1RWQ0UHV1YVhianRmdHNubWpB?=
 =?gb2312?B?NEd3aXFiZmUyQ2Ywblo2dEp3d1F2SDNzUkRhZDZ2UFltTi9MWUJoQlR0NTd0?=
 =?gb2312?B?Wlh2UDZTMnVEOGtOcXlocENIT1J2bzk1NFVmbWJaL1NnbUgvVXM4RTBiM2Y1?=
 =?gb2312?B?aEVVSW5oUEhVVFl6Rmt3c0Nhc05zMkNFOXhiSmxYOFpoUWQ0TkRRRHZmeUZo?=
 =?gb2312?B?L1cxeENiNGJrWCtZR3NVV1k5RGtEUjF5YUJvbzN3aWZlQWJIRXlvd1F6M25C?=
 =?gb2312?B?TFBWa3F5NituYTN0MHZVVVl6TmRXK1BQU280MU5aTExyRmw5MGRlc1o0aGE0?=
 =?gb2312?B?UGtTdkx6QTJheTM3YlYyN1ZiSGo0UjhJdzNzU3NiNjZCUm9CQ1pwanhETmQ4?=
 =?gb2312?B?ZHQ1Y3BraEx6NnNtV3EyUHUvZnpld1R1V1BMU1FNNTJibUsxU1FIZmJIdXV3?=
 =?gb2312?B?WE1MRnMwZkFBZTZrUzFxZTFRZ1lsRjJSQTZybFVkMW5WTDRIQXE1Q2FtamNq?=
 =?gb2312?B?MXBNQVZFQjRzTG82SWJoanlOQ2JScnRZR1laRDdxYTBVNnFyeTZndkplVFI2?=
 =?gb2312?B?UkVuQnRQK3lvQTIwaFFkSGZ4bUplcEZWdDJrQXZFVHJHb24rV25BVUVLSkFu?=
 =?gb2312?B?b1EzS1UwWjhxbWlLK0txVVQreFhzdXBmTGJiMGtQMExpaVBXTWx1UnlIdTc4?=
 =?gb2312?B?N0U2UTAyT3Q5OVN1eEpRYTZva2EzZlVPOGxpREQ3TDNncE5LSnoxU3piM282?=
 =?gb2312?B?eUJuM284RElxNElrNW1SQWoyWWU4K0htajF3c2Zkd2dHb3JObjdQLzFKVVBs?=
 =?gb2312?B?RE5tRUxmdlFXR0lqdTlYVzNQeXl3eTdRTW1vUForWmJ1QjIrOWpWaEE4YzNq?=
 =?gb2312?B?RWZ3VThCYmhrOWZCWllVejUvRkRHOVZ5d2RDN2hZWE1QSTFNY2QvSGlHVnVp?=
 =?gb2312?B?WmY3bHNVaElKUStDeWlLaURHSFhrK0xLT0t3M0IwdlRDTU0zTCtYRHdCT1VJ?=
 =?gb2312?B?eUxDdkoxWDFxN3JUdGMwY0Z5RW93eWRQNW5sdDVmSEdreSttRHlzK0QrbytJ?=
 =?gb2312?B?TGk1UVphZ3ZwWFVkU1R4RjFOejNjRVJabkl3S0IyMzRVZWNtaTF4Qkl1QkJL?=
 =?gb2312?B?QUtOSGdlMDJ0K1N5Zjk2R3h3a1VOTUIxN0czT1lzT0ZnaXM0SW1DV3RYYUNq?=
 =?gb2312?B?b0h1SjZ3VDhDSlJNUUZWOEZqZlljeE4wcmZIOXFyMXVxZzd1ckRHVStjZlNH?=
 =?gb2312?B?VktXVDV3SzJmUlZHb3NDM2F6emNLWVoyRFQrUmNGYlBXVWUvQ1BMUVh4dWl2?=
 =?gb2312?B?a1dFRGJLcFhrekdnMUdLTklnak5EeCtJQ0Z3R3ZaOWkyOEttcXFjMmRZdmdz?=
 =?gb2312?B?QWlMTGpWZmM4YjNkYUtzdytJYkNQNUJMalNuajNDZHRlc1VXTHVoRVpHUWht?=
 =?gb2312?B?WmoyTnRoWC9rOEJnTzV1RTlNTStNM1ZuQ0lKWU5adHpheWtxMmRyTTBxa3Jx?=
 =?gb2312?B?KzhKNUNjU0RtdlArRDg2bXYvaWkzYjk2YkpHSW83bjdHUGM0Y0ZUSTlOMUJn?=
 =?gb2312?B?MlUwUTIwTWRFUmtSaEhHNktIbzBvNWFiQWQyT3BJZUhCcXU0QVhKTG9oUnZP?=
 =?gb2312?B?SWEwaXFWUWdBNWdIZHBVYWpNeFJzSC9XVVVORmt0Vkd4WGxOdzczRkxiOUhZ?=
 =?gb2312?B?U256VVFycUdHNXhBeDJVZFR6alZadWRzcUMvUW9PMHdzZm5vTmFIQWpycS8x?=
 =?gb2312?B?Zzc3REc5QkJFTEg4aDFPb2RZU2xML1VIa0NVS21LeHFpY0NyMEhIbWF0ZHRB?=
 =?gb2312?B?NzROUDJyWHFHRUNNT2RFTmxxMkdWUDJ1a2ZJZ2FBTmhUY3hDMkNhK2pFeWpm?=
 =?gb2312?B?WHROd2I1SytEM3N1a0laR244TWVMYzAxa2lIODgrUlJUTzdyNlltK0UwMWdV?=
 =?gb2312?B?dTFCSkc3ZGJ2SzBKM0FUOGdrb2JmUGFKejVPL1NKVjFicWZJWi9adjdxNlhX?=
 =?gb2312?B?ZUFQY1JoV0htLzVNT3Jha1B6ZzhSNDZpWlRXUFJrUU5JTGVScC9nT3pVektT?=
 =?gb2312?B?azNodDlwSjNZUTJuaU5JclBzdzM0YmEyaFVudUlFU0ZacmFqT09kQXBZcVln?=
 =?gb2312?Q?gi4MFEDy2SYBmYCN8D3/inoXf?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	X4azdIKIsrWnE5baCKZPqufgnZ28kappkx9mMHZfIlMSxmXln0q2wjDAMdzOw7F1X6OvzOlFs/hRDOkdMbbAV5M8FikUFVA+omaboXh1BvPSVL58O//gxSbH0Aa7z5ixsoyZz3rwtA5/PAkdVBn/UFIu8RhCQR3GwdT5DXx8MM6FlEegsHHm9hHhrguH9juMja96CukhrTgPltSDGMSX3nv0ISU1RT++5HqHfv0nTKHpJUPZbAfTI54YImqGVMbnebdy9HRCgWwVcx/6cZH8oh9W6VkO5njtQjqMoNLp3/86+pBPJvcac36GnZERFclZUzSAs5QLJ8qqB0RE3Wmmmk2DjXKKnxKzSsRoaWOYTyIjFyUUX7Q+1+UbDkn0x1cGx2OWJ85Mm3fyqviJafED6ot0sYMieBwEvKt14clrsJppfJL+8PMyPYPb/vAoQf9bypHE20nJ7ZhMG/EAazZnu6804aGqsTvfu3f9vijmrJKdQ04vbsYQzGv/8Rs5HCRnZFjA/EekA0eJVJHdyuq2dObnhmAIBlKZuOgGSXYYRnsMGcskrTfC4ofTa7VQf2UQBnwYVjjQ8TcJQfJq3z1yOEuY7VgYIzDiZy67yJYxCN3j4cY5ey405gl1pf6GUVtU
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11861.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059d32f4-b650-495c-49d8-08dcdd3241f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 07:18:30.3942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T5ZHGJaOQkDKIGxI+jR3Uf251xv/Js2PzuqRu8SYj5M/FDWellUbMWUlqaXNy6qYzfw1k7usod+dlW+ilLPjSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8632
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Sep 2024 07:18:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/667

cGluZw0KDQogIC0tDQpCZXN0IFJlZ2FyZHMNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KV2FuZyBNaW5neXUNCkZVSklUU1UgTkFOSklORyBTT0ZU
V0FSRSBURUNITk9MT0dZIENPLiwgTFRELiAoRk5TVCkNCk5vLjYgV2Vuemh1IFJvYWQsIE5hbmpp
bmcsIDIxMDAxMiwgQ2hpbmENClRFTKO6Kzg2KzI1LTg2NjMwNTY2LS04NTY4DQpDT0lOUzogNzk5
ODg1NDgNCkZBWDogKzg2KzI1LTgzMzE3Njg1DQpNQUlMOiB3YW5nbXlAZnVqaXRzdS5jb20NCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiB5b2N0by1wYXRjaGVzQGxpc3Rz
LnlvY3RvcHJvamVjdC5vcmcNCj4gPHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9y
Zz4gT24gQmVoYWxmIE9mIHdhbmdteSB2aWENCj4gbGlzdHMueW9jdG9wcm9qZWN0Lm9yZw0KPiBT
ZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDE5LCAyMDI0IDM6MDggUE0NCj4gVG86IHlvY3RvLXBh
dGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZw0KPiBDYzogV2FuZywgTWluZ3l1L831IMP56KQg
PHdhbmdteUBmdWppdHN1LmNvbT4NCj4gU3ViamVjdDogW3lvY3RvLXBhdGNoZXNdIFttZXRhLWph
dmFdIFtQQVRDSF0gbGF5ZXIuY29uZjogTWFyayBhcyBjb21wYXRpYmxlDQo+IHdpdGggc3R5aGVh
ZA0KPiANCj4gRnJvbTogV2FuZyBNaW5neXUgPHdhbmdteUBmdWppdHN1LmNvbT4NCj4gDQo+IExB
WUVSU0VSSUVTX0NPTVBBVDogcmVwbGFjZSBzY2FydGhnYXAgd2l0aCBzdHloZWFkIGZvciBZb2N0
byA1LjENCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFdhbmcgTWluZ3l1IDx3YW5nbXlAZnVqaXRzdS5j
b20+DQo+IC0tLQ0KPiAgY29uZi9sYXllci5jb25mIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvY29uZi9s
YXllci5jb25mIGIvY29uZi9sYXllci5jb25mIGluZGV4IDcxZDZhMTAuLjNiNzdiMmQgMTAwNjQ0
DQo+IC0tLSBhL2NvbmYvbGF5ZXIuY29uZg0KPiArKysgYi9jb25mL2xheWVyLmNvbmYNCj4gQEAg
LTcsNyArNyw3IEBAIEJCRklMRVMgKz0gIiR7TEFZRVJESVJ9L3JlY2lwZXMqLyovKi5iYg0KPiAk
e0xBWUVSRElSfS9yZWNpcGVzKi8qLyouYmJhcHBlbmQiDQo+ICBCQkZJTEVfQ09MTEVDVElPTlMg
Kz0gIm1ldGEtamF2YSINCj4gIEJCRklMRV9QQVRURVJOX21ldGEtamF2YSA6PSAiXiR7TEFZRVJE
SVJ9LyINCj4gIEJCRklMRV9QUklPUklUWV9tZXRhLWphdmEgPSAiMTAiDQo+IC1MQVlFUlNFUklF
U19DT01QQVRfbWV0YS1qYXZhID0gInNjYXJ0aGdhcCINCj4gK0xBWUVSU0VSSUVTX0NPTVBBVF9t
ZXRhLWphdmEgPSAic3R5aGVhZCINCj4gIExBWUVSREVQRU5EU19tZXRhLWphdmEgKz0gIm9wZW5l
bWJlZGRlZC1sYXllciINCj4gDQo+ICBMSUNFTlNFX1BBVEggKz0gIiR7TEFZRVJESVJ9L2xpY2Vu
c2VzIg0KPiAtLQ0KPiAyLjM0LjENCj4gDQo+IA0KPiANCj4gLT0tPS09LT0tPS09LT0tPS09LT0t
PS0NCj4gTGlua3M6IFlvdSByZWNlaXZlIGFsbCBtZXNzYWdlcyBzZW50IHRvIHRoaXMgZ3JvdXAu
DQo+IFZpZXcvUmVwbHkgT25saW5lICgjNjYwKToNCj4gaHR0cHM6Ly9saXN0cy55b2N0b3Byb2pl
Y3Qub3JnL2cveW9jdG8tcGF0Y2hlcy9tZXNzYWdlLzY2MA0KPiBNdXRlIFRoaXMgVG9waWM6IGh0
dHBzOi8vbGlzdHMueW9jdG9wcm9qZWN0Lm9yZy9tdC8xMDg1MzU0NzYvNTk3NDk0Ng0KPiBHcm91
cCBPd25lcjogeW9jdG8tcGF0Y2hlcytvd25lckBsaXN0cy55b2N0b3Byb2plY3Qub3JnDQo+IFVu
c3Vic2NyaWJlOg0KPiBodHRwczovL2xpc3RzLnlvY3RvcHJvamVjdC5vcmcvZy95b2N0by1wYXRj
aGVzL2xlYXZlLzEzNjE0MjcxLzU5NzQ5NDYvMTkwMjgNCj4gMzEwNjYveHl6enkgW3dhbmdteUBm
dWppdHN1LmNvbV0NCj4gLT0tPS09LT0tPS09LT0tPS09LT0tPS0NCj4gDQoNCg==

