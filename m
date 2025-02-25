Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872BDC021A4
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 00:21:22 +0000 (UTC)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
 by mx.groups.io with SMTP id smtpd.web11.372.1740442875283337072
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Feb 2025 16:21:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj1 header.b=pVN/siUT;
 spf=neutral (domain: fujitsu.com, ip: 216.71.158.38, mailfrom: wangmy@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1740442876; x=1771978876;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hesfS/tE2EKszP+25y0xbVHv+lDEP8/DKPJovfBhgqs=;
  b=pVN/siUTHHTMjwodJuS9XKw6WeYJyT9XIJTE0Ie4XHJXs7xlefMdfLhH
   ZkFsy8XLevkxHbb3MVOs7qsqUuVE3An9P1Th6ljLqWITio3mscePXr8xn
   kEv5oZCXY0jTnKBxb7/agzVlVv/EOJsfEEqtvMo5BtSYpGSDoD49wFCIJ
   teK4hSefQQRZqXbbz2Z/NU9D5eN1JEJKyjT/kQ5v953LTKj5PnIOo6HXc
   nbPI6WVGlS6/8glpAMX+1wfavXH9d0uHGoTZBEZ432yuLnOafzLkYWLB9
   Ty705RQh6mf8ZjpaKYDJHde3PRgc3YqH50G93y9I0qnfl/AxdJeN5ni74
   Q==;
X-CSE-ConnectionGUID: rmtDWy3aSdKfXMVrTWqjsw==
X-CSE-MsgGUID: wLCNb7iPQaqu/3IL8ngfdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="153605849"
X-IronPort-AV: E=Sophos;i="6.13,312,1732546800"; 
   d="scan'208";a="153605849"
Received: from mail-japanwestazlp17010000.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.0])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 09:21:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGhMr1yCF2gGzQa8GlmPDcq601QmEdoCkLvt++C4h950zgltVcvKu7JZ44xlcGCtRGiWax3+jg9eGJ07Nn1AZ77Xh50U6LlTWHAc5rngKDoHqjwAmMPGlr1+a7A2+iCusxRTfNUWZGecZCy2ClXISenvdZwWUlbB+DVE3ZOLnHttx28e8UQxWKNTNUTBV9DhJXl2QHl84S7PjdRG8bd2WuQpeE2ct+vX1HwQdXO17QaJ9ymKupsMYvmjHzifD9/kKSXbwbf7UaoYK8QUjSbmEAFb/ZXEfG6ucvuYtXo/5lxUa0pnZxyEEQ9sJdDV9cWge0opU6/HgUK2WcRV2B+Yqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hesfS/tE2EKszP+25y0xbVHv+lDEP8/DKPJovfBhgqs=;
 b=hH7ESawEVNJuImtsZNuZzlv50l0UO+GNImln/avAWS5TAJL99mZtoDmhVenI596F7kME+tgVWoP5JOMzmWPGxvBmg+q/gO/osAtiMk8RAm4HfjtW5yLt90E5OkvHqvirqytQ4ZD1nN0Nqa1DX5nTctZQFISGF2r6PdFsV8rkqJk9UfJWvgdhhN5qV7eG35A0Al+tXxPcpWabD9C2fCn1i4GGs/OfXh+d/Gjxz8YXSymvxE7WfHULtDAGWl3UGFHxGR48tl59Rz/sLWDpEbrQ61XzFaI5Z31GxN4UbMuWukB49x8pqyYDKt2X3oIVQPfjOEnYTfBT5B0gzxgVkoONIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB11861.jpnprd01.prod.outlook.com
 (2603:1096:400:3fb::13) by OS7PR01MB11615.jpnprd01.prod.outlook.com
 (2603:1096:604:244::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 00:21:07 +0000
Received: from TYWPR01MB11861.jpnprd01.prod.outlook.com
 ([fe80::e0dd:28e5:6a6e:2342]) by TYWPR01MB11861.jpnprd01.prod.outlook.com
 ([fe80::e0dd:28e5:6a6e:2342%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 00:21:07 +0000
From: "Mingyu Wang (Fujitsu)" <wangmy@fujitsu.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: Tim Orling <tim.orling@konsulko.com>
Subject: FW: [yocto-patches] [meta-java] QA Issue: Missing Upstream-Status in
 patch
Thread-Topic: [yocto-patches] [meta-java] QA Issue: Missing Upstream-Status in
 patch
Thread-Index: AduEDy+sEghkbMChQESqJcifNyWPJgAAxogAAAnxstAAAafPAAAASvSAALZIUZA=
Date: Tue, 25 Feb 2025 00:21:06 +0000
Message-ID: 
 <TYWPR01MB118611CBFD42C4CA304D6A552DCC32@TYWPR01MB11861.jpnprd01.prod.outlook.com>
References: 
 <TYWPR01MB1186118665B16406BD0571151DCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
 <CAMKF1sqJ3MS8gnN8gv1AMLNNZt=UEXtzXyQim-5TA+H9funFUw@mail.gmail.com>
 <TYWPR01MB11861B276559403A8AA76A8EFDCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
 <49dec7e116d95938712d10e4d76b78ed2df01ca9.camel@linuxfoundation.org>
 <CANNYZj-RPuuU+Ub5d0VBz7gmqg-LEB-yKN9dkJL8Qp-2UY2K1A@mail.gmail.com>
In-Reply-To: 
 <CANNYZj-RPuuU+Ub5d0VBz7gmqg-LEB-yKN9dkJL8Qp-2UY2K1A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9MWI5MzBjY2MtYzU5Yy00ZWIwLTlmY2ItZjRkNzlmYjYw?=
 =?utf-8?B?MGEwO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI1LTAyLTI1VDAwOjE5OjU1WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?B?ODFlMS00ODU4LWE5ZDgtNzM2ZTI2N2ZkNGM3O01TSVBfTGFiZWxfMWU5MmVm?=
 =?utf-8?B?NzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX1RhZz0xMCwgMCwgMSwg?=
 =?utf-8?Q?1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11861:EE_|OS7PR01MB11615:EE_
x-ms-office365-filtering-correlation-id: fb657a33-0dd3-4964-c381-08dd55324c05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|4022899009|1800799024|376014|38070700018|7053199007|1580799027;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MWc1ZGtRbkY5QnpseUtxKzVweXk0WU83d1JyT1VwZkx6c1JaMTlwMnMwYjNN?=
 =?utf-8?B?aFllazZiZ2RyRTcrSWQ1aTVQMzlNRnhaeld3bE56VGJXT0JTQWozdkVlcEJ2?=
 =?utf-8?B?ZkF4c0hhVlZuRmJvcE1qa0lRVEhiTnhQdEFoZk5WL1RxRmJEQ3REaGhuRERh?=
 =?utf-8?B?RTRueUdWbEFVNEVnRDBwb0FUOFBHMmVIekg1bnZ6RGZRMWZJYXZWYWF1VGh1?=
 =?utf-8?B?OEsrQ0JydXpEbWhJQU5PWTdYcDV4ZkxpbGNLbDVySjZoWDhnVmJadGdaVHpK?=
 =?utf-8?B?ZjdCYTVlWGhWc0JXVkgrRFhSR1p1TGlGKzc5cDgyVlZXMXRPRlI4ZTJ3ZTF5?=
 =?utf-8?B?NjhOVVR3UHlmK3YyZGlhemlZUS9rOXI1amZIUEJPVlVNTVR0TGE0elB1eWJy?=
 =?utf-8?B?UlBCVmhUdmMyY2l4MzNERzJqU2R1VlJMN3Nzd05zcEFXb0FDUXNvblNFRklo?=
 =?utf-8?B?TTdOTzBBajVIcCtyTDExT3FtY1NQQTNZVzZoc0NPaFdpVStnREZVOStmSkdr?=
 =?utf-8?B?c3lpVG5jN3NJclRIZ29PT2NGb3hmSEdGVXRPUk4wcXpTTDk1UTZZbXZOcmZW?=
 =?utf-8?B?d2pQMjQzZ2ljODAvM014bGhYcENPQWtKMXFyUFFlL0VXTU90aWtyNi9pRlJo?=
 =?utf-8?B?YlI1L3NZMGhEMlVjUUFwTzlaREhqMmpBU04wNzNRQTJqVWROT2VWN2hzTnJy?=
 =?utf-8?B?bVEvZlI2RGE1aUw5YlJGR2JhOEJlYTF3V3o5UVB5bmVzVFRCc0lleDZhTmt6?=
 =?utf-8?B?OW45dXBBbXViV0hpZlZyRHRKc0xWK21YMUZ3ckpVYW91anNkNVk4NHNlaEd3?=
 =?utf-8?B?WlhSd3Zzd1pVODhzZ3oxcGpWVldPRm1ETmJwaVpCZ29OS09ieFNQaVcvTFdz?=
 =?utf-8?B?cnNCWkZndHpNVHpSTldTSXV1TWp1N3JmdzI2M3NkUVlxbUlKT3hvVmhsWGxL?=
 =?utf-8?B?bFVxUWN3YW9QckdoVnErYnlqaXhDbmJjdkV5TDduVDIrMFpzVk1ySmZ4TUJ4?=
 =?utf-8?B?Zm9oWkRTME94aTVUQm8ydnNSOG56Y0tNeXZ3aXkwWDJNZjU3WXUrYmRPTkhC?=
 =?utf-8?B?KzJUczdRQXdLdXdWUG5BQ1FJL2JQek16YzZQOWRUcHo3RjVDbTFmemZQdWUv?=
 =?utf-8?B?VjRsSk5jWlp1elNQRnNzdysxRC9waFJ5K2RrcHg4dmsyeFhhNHVRTHpodnFO?=
 =?utf-8?B?L2VUZ3k2RUNRd3htbStxc3M4TS9tblIvUUdPMmRYSHJFdjEyVzJRNjhRVkxB?=
 =?utf-8?B?cWpYVkVXc3gyVGhmSHJXMHNIM2krZ0RGdUF4eldHR3gvWVhnakNBY0ZZSDhM?=
 =?utf-8?B?bUl4MUVWOXhDMDBqeEg0WStFSU9hYjNHR3Y4TGkyS0lJU0RueWkyNUs4WVNK?=
 =?utf-8?B?eDZzdWp2QVA4V3cyZzhreHpXR3ZkR0h1Ti85ZXF2VGNwb2Y5MnFobDg4YnZK?=
 =?utf-8?B?dEpqWGNHRHFheE9qNjhpUDRzL05ob2JDWm0rUFIyOTRGN3ZZVml3MzNmemNi?=
 =?utf-8?B?dlVYYTFBL0RVeEwyMFlyYUMvZGxsUGRKT1IwdGo5QWdURzNCT3FER3JPQ3hN?=
 =?utf-8?B?NW42ZnpFRmlKNWVvakNHRXNIY3Z0Y1RIdWhrc2k2ZTBHQXdPRWJnczJBcFl0?=
 =?utf-8?B?aHB5bEMzSEdOV0N4UUg3WnJBakI5OTlBbUlIZlAvSW84SGgrWmtrb0VQcWtK?=
 =?utf-8?B?RnNaY1EwN0tkU2Zic1dta0ZHZTJEcVFRVGxGNFYvSjY2QjJIdWRXbUVoUnpK?=
 =?utf-8?B?czkwUzhYWFhBOVpUeHEreCtjU2h6MmtaMHJ2dmxqRUFOZ2M2NUZvWFhGa0th?=
 =?utf-8?B?U3lrZ1JPTEY2TUdoT3M0bklDN016TmkxUnNodms5YnJtb2drLzFJMkpqdHhm?=
 =?utf-8?B?alVrYzZsM1FSQm5lZUVjeXhQZGY2cUpwNDdscHd2TGhHVnJCVTFQVkF2Rll1?=
 =?utf-8?Q?iqmpizqTBRQ=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11861.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(4022899009)(1800799024)(376014)(38070700018)(7053199007)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WTNET3VvTGZDdDJGbHBaK0YxRkdLR1RXdVBSZjNra0hPTWdlM1NnZE1YeEtJ?=
 =?utf-8?B?clRyUFYwc2lnd1p0em5uM2d0cmlybFJxaml1R0xwV25SWlhrRTBYMTg1RFcx?=
 =?utf-8?B?R1NMTUxscFBJWW1RUFo5VWdUNmtuRUtsSXV5RndjWlNXc3psU0Z5NEYwbmtl?=
 =?utf-8?B?SE5qb1A2TXcwVFBDTkE4cDJ4R0lIekpiSFV4UDd2VUxMQ2pScGVpQ0ZxWEZp?=
 =?utf-8?B?dnVXaVZ3NHlzbUNhS3lGN1VrMWZ4QjlnT0J4UENJZ2tSM2RrYmdjc2FPOTFV?=
 =?utf-8?B?N3pGVjBVWTUzamcrVGl2WDV4bGNhdFY2R2FneUN0ZStoV2p6Z1NkcW9oTS9p?=
 =?utf-8?B?dnJ0Z3JoTVAxM1lGOUIvM1pnNVdBWlhPcXcra2FsVVZGQnZRTDBBSnRvUGxr?=
 =?utf-8?B?WURQbnkzZU9BNnpJa3g1ajdSRERNUkhmUHhmSUNsOXhqWkNkVzdPcHpTN1Rj?=
 =?utf-8?B?bWNiaTEyQTV4RWtCRmxFRzFZWkRpUUxvYU52bXV2cWQwL2pMQkkrMDcvcVhV?=
 =?utf-8?B?bXBaZXk5c3h1eHREc24wbXBhMFFhU3krUFVZSFdzWlJZd3ZvWHBDRTliR2E2?=
 =?utf-8?B?ZmZDZU5lN0RialZOYVBUYTE0R3c0MlIvc1V3VjNvUHJxVmhHMitOanBkd3k5?=
 =?utf-8?B?MlB3VEhSZ0hKQ0NzRlppNmxOdUlyc2xrKy8yNG9IVFhhZlZQZW4rQ2h4NWkx?=
 =?utf-8?B?YTdqRGNETWNOR3FzME1DcW9KRjBkM2tQeFJRd253V2JIVTd5eEhYSnpwSGp2?=
 =?utf-8?B?dEdzNzBsYmZCUHR4cGpGbjJoK3AvU1VHelpjSCtBV2RqVDNaRGIwRTVGd3ZR?=
 =?utf-8?B?YWROVGIzQkJGVllXSWRHL1RFdjdLVDNCWE4ySkFGazVzelRka25uUnRmb3J6?=
 =?utf-8?B?UEFYQ0piRjBNYk5VWW9kek51M1MvNG94c1NXckphWnJ4a083YWhMOTFNRjdN?=
 =?utf-8?B?N0M1Wmh0UE1Md1A0clFZYTFTY1NBSFl5R0c4N2hZS0hPVTdZTlhSbWJ5V2NQ?=
 =?utf-8?B?K2IzQTRyWmdkVmtRa2drS2t4WklSS1E4ck5raHdHc3VhdTJkSUlvNU56Y1JE?=
 =?utf-8?B?NE0rYm56T0w2MlFVYm1wVW1UdGZpZ1A4UytqR1hUM0tzdjhrdy8reTVid2h1?=
 =?utf-8?B?VDg4UkJBTXBxSytnajV6dmdQTVEwVXI0clAxNGYzZlEzTlR2M0lHMEo1bUk3?=
 =?utf-8?B?a3BZZ0JFN24vbkw1SG9IM1B0bHBQL2R3WVd0eHVkcXhRRGhlSVhuZW5Xdk42?=
 =?utf-8?B?bjVmM0VtbWZoZjJqUXZiNlJhV081emFVQjZsbGZGVmk0WVFLdzdJaGlUSlhy?=
 =?utf-8?B?YWxvdWVqSk9WSzF4TDZJL0tENjMxc2VJZ2t1YnJERFR2d1gyVVBDWVhvNVdN?=
 =?utf-8?B?SWlhblNQeVBzTnp5Mk5pNFljMWkxejlldTR1VWV4VlFvQUJ2dG9pZnhIYXpH?=
 =?utf-8?B?OXRhOW5qRW1KVXlPNTlwNExuaWVjdWlrblIwRnFEMk1BYy9TUUpPdEp6MmMy?=
 =?utf-8?B?RkNRa0tSWjFJSHphOU1PbWFNREZhWGFiK000VDRFQ0E5KzhBQUFYZjdnWTdq?=
 =?utf-8?B?VXF5STNCL1g5T1dFTFErelFVOUttT0dlNStiWVlnUjRlYlJkZk1EWEFHbGNL?=
 =?utf-8?B?eFFhZ0p0RmFVWDU4elVyNEJieHB6cEJoMFQ4eXBxU1NqRThZNmFlcFR1cCts?=
 =?utf-8?B?ai9BSjhXZzNZbkZnM1JsblcxNHAxcTY0RzdjV1pXYm5EcEFTUFA5UzlSbUN0?=
 =?utf-8?B?T2NvS1IwcllBeklHUXBiNnlBVTk2UDBXVnVmM3pGL2xNNkxjKy82elhEaXIz?=
 =?utf-8?B?dmFVZlppZlU5T01seXRvZTZnMytKa21RY0lWTXpFLzFlTUtXdk1SWEhPSlVX?=
 =?utf-8?B?YS81YWkxdnA2TzZQRFhCTEUva1grMEFrS2lLQWZnRDJjNlZqdDNBUzd3UGFU?=
 =?utf-8?B?VlAweDdpTFFPSWE1ZzcvQXdtSW8vaXIyMnZqbWdaTld0eEZncnNxRmt5V2ty?=
 =?utf-8?B?dWF4V3FiY01mUlRPUjRNV2FOblhQbVl4UGdkd0lqU3BtM0hRUnpmRXJSNkMw?=
 =?utf-8?B?bTNoUURzMmhrRUlaSFFIVXljRDRTb3BkRW9CSWR4b25sSTBiMVhmQmZqUUhY?=
 =?utf-8?Q?tPda5946RLlVMN8GodRgSfngu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5Kov8pvwSCB+k6dXQJ3mP5ESvy7zA0qwjeJeRznE+kr/fgR75NpSHf285kr6yWxEh7TRXj/Rnv0bF2ZkHIh0YytBtFJufpPIyIuHix0P6ib9b6EX6f6SALWw3C34i6IdfYSDAEXOYrXqBhq7l/swkc3x5Fio/nNxoBd/xFZi3s7uvcVM+QwIju9xUiEdimoRUYIbwB1BulZLL0Tsto0ii/O22XxzbYOb1GnbyszOVjATnbCS+WNyxb8ppZOaGoejryYaLfhnNkHERI0zeyDOvuS/Tq4AcgxBa9mrft/KPJp3F8B6p/LqfEUhrtRw+d+UBDKStI3xkAKdEK9fJOueTBbQ2fqWWhgdzopu7BqwcmemNNYUEeDZ40+gCIMcmX5uPRg82lyOYlTpuRA48yHbAcEHfLZUF4J7hyWCLGKiLsXmPM9dW5XrHmjW4N21QZCl2MzBaJmNpa1r0xIIAHXOp72Iwkm+z8UpjWPW7+8LV6dfneialUjULgwSAE0w+G6Qv3obMdEHC479e6zKz+7AfQIgIy2AVZ0yoLgnIh1x6IDVq3La8Wmqgm6zxCV9FfZ+3ZgmGqu/hlxnu6o7EgRJzhaFtJMnRNNWk9jPIVs4b2kt1fAyZHTehMIDfH3nLxb0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11861.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb657a33-0dd3-4964-c381-08dd55324c05
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 00:21:06.8044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I97ktPD5mpFtF4QKWHeRHHr2UBTJxF+pRfdj9FiiAaiciu4cRSTumotJSeBUfqoEazZDPGKSlFTH9enNhBwWHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11615
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 25 Feb 2025 00:21:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1126

VGhlcmUncmUgbWFueSBwYXRjaGVzIHRoYXQgaGF2ZSB0aGUgZm9sbG93aW5nIGVycm9yIHdoZW4g
YnVpbGQgdGhlbToNCmRvX3BhdGNoOiBRQSBJc3N1ZTogTWlzc2luZyBVcHN0cmVhbS1TdGF0dXMg
aW4gcGF0Y2gNCg0KRG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zIHJlZ2FyZGluZyB0aGUgVXBz
dHJlYW0tU3RhdHVzIGVycm9yPw0KU2hvdWxkIEkgZml4IHRoZW0gYnkgYWRkaW5nICJVcHN0cmVt
LVN0YXR1cyIgdG8gdGhlIHBhdGNoIGZpbGUsIG9yIGFkZCAiIEVSUk9SX1FBOnJlbW92ZSA9ICJw
YXRjaC1zdGF0dXMiICIgdG8gY29uZi9sYXllci5jb25mIHRvIGlnbm9yZSB0aGUgZXJyb3IuDQpP
ZiBjb3Vyc2UsIHRoZSBsYXR0ZXIgcmVxdWlyZXMgYSBsb3Qgb2YgdGltZSB0byBmaWd1cmUgb3V0
IHRoZSByZWFzb25zIGZvciB0aGUgZXhpc3RlbmNlIG9mIHRoZXNlIHBhdGNoZXMgYW5kIHRoZWly
IGxhdGVzdCBzdGF0dXMsIGFuZCBwcm9ncmVzcyBtYXkgYmUgc2xvdw0KDQogIC0tDQpCZXN0IFJl
Z2FyZHMNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KV2FuZyBNaW5neXUNCkZVSklUU1UgTkFOSklORyBTT0ZUV0FSRSBURUNITk9MT0dZIENPLiwg
TFRELiAoRk5TVCkNCk5vLjYgV2Vuemh1IFJvYWQsIE5hbmppbmcsIDIxMDAxMiwgQ2hpbmENClRF
TO+8mis4NisyNS04NjYzMDU2Ni0tODU2OA0KQ09JTlM6IDc5OTg4NTQ4DQpGQVg6ICs4NisyNS04
MzMxNzY4NQ0KTUFJTDogd2FuZ215QGZ1aml0c3UuY29tDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiB5b2N0by1wYXRjaGVzQGxpc3RzLnlvY3RvcHJvamVjdC5vcmcgPHlvY3Rv
LXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9mIEFsZXhhbmRlciBL
YW5hdmluIHZpYSBsaXN0cy55b2N0b3Byb2plY3Qub3JnDQpTZW50OiBGcmlkYXksIEZlYnJ1YXJ5
IDIxLCAyMDI1IDU6MjEgUE0NClRvOiB5b2N0by1wYXRjaGVzQGxpc3RzLnlvY3RvcHJvamVjdC5v
cmc7IFdhbmcsIE1pbmd5dS/njosg6bij55GcIDx3YW5nbXlAZnVqaXRzdS5jb20+DQpTdWJqZWN0
OiBSZTogW3lvY3RvLXBhdGNoZXNdIFttZXRhLWphdmFdIFFBIElzc3VlOiBNaXNzaW5nIFVwc3Ry
ZWFtLVN0YXR1cyBpbiBwYXRjaA0KDQpPbiBGcmksIDIxIEZlYiAyMDI1IGF0IDEwOjEyLCBSaWNo
YXJkIFB1cmRpZSB2aWEgbGlzdHMueW9jdG9wcm9qZWN0Lm9yZyA8cmljaGFyZC5wdXJkaWU9bGlu
dXhmb3VuZGF0aW9uLm9yZ0BsaXN0cy55b2N0b3Byb2plY3Qub3JnPiB3cm90ZToNCj4gPiBJdCdz
IGRlZmluaXRlbHkgdGhlIGJlc3QgdGhpbmcgdG8gYmUgYWJsZSB0byBkbyB0aGlzDQo+ID4NCj4g
PiBCdXQgdGhlcmUgYXJlIG1hbnkgcGF0Y2hlcyB3aXRoIHRoaXMgcHJvYmxlbSwgYW5kIGl0IGlz
IHVuY2VydGFpbiANCj4gPiB3aGF0IHRoZSBwdXJwb3NlIG9mIHRoZSBwYXRjaCB3YXMgYXQgdGhh
dCB0aW1lIChtYW55IHBhdGNoZXMgZG8gbm90IA0KPiA+IGhhdmUgY29tbWl0IGluZm9ybWF0aW9u
KS4NCj4gPiBJbiBhZGRpdGlvbiwgbW9zdCB1cHN0cmVhbSBoYXZlIG5vdCBiZWVuIG1haW50YWlu
ZWQgb3IgdXBkYXRlZCBmb3IgYSANCj4gPiBsb25nIHRpbWUsIHNvIHRoZSBmZWFzaWJpbGl0eSBv
ZiBtb2RpZnlpbmcgdGhlbSBhbGwgc2VlbXMgbm90IHZlcnkgDQo+ID4gaGlnaC4NCj4gPg0KPiA+
IEl0IGlzIGJlc3QgZm9yIHRoZSBhdXRob3Igb2YgdGhlIHBhdGNoIHRvIG1ha2UgdGhlIG1vZGlm
aWNhdGlvbnMuDQo+DQo+IFRoYXQgbGF5ZXIgaXMgc3RydWdnbGluZyBmb3IgbWFpbnRhaW5lciB0
aW1lIGFuZCB0aGUgYXV0aG9ycyBvZiB0aGUgDQo+IHBhdGNoZXMgaGF2ZSBtb3ZlZCBvbiB0byBv
dGhlciB0aGluZ3MgYSBsb25nIHRpbWUgYWdvLiBJIHRoZXJlZm9yZSANCj4gZG9uJ3QgdGhpbmsg
aXQgd2lsbCBoYXBwZW4gYnkgdGhlIGF1dGhvciBvciB0aGUgbGF5ZXIgbWFpbnRhaW5lci4NCj4N
Cj4gV2UgZG8gcmVhbGx5IG5lZWQgdG8gd29yayBvdXQgdGhhdCBpbmZvcm1hdGlvbiBidXQgaXQg
aXNuJ3QgYW4gZWFzeSANCj4gam9iLiBUaGlzIGlzIHdoeSB3ZSBub3cgcmVxdWlyZSBpdCBidXQg
dGhlc2UgcGF0Y2hlcyBkYXRlIGZyb20gYmVmb3JlIA0KPiB3ZSBkaWQgdGhhdC4gSXQgd2lsbCBu
ZWVkIHNvbWVvbmUgdG8gc3BlbmQgdGltZSBvbiBpdC4NCg0KVGhpcyBpcyB0aGUgc2l0dWF0aW9u
IHdpdGggbWV0YS1qYXZhOg0KaHR0cHM6Ly9saXN0cy5vcGVuZW1iZWRkZWQub3JnL2cvb3BlbmVt
YmVkZGVkLWRldmVsL21lc3NhZ2UvMTE0OTU4DQoNCkknZCBzYXkgeW91IFdhbmcgbmVlZCB0byBj
b21taXQgdG8gbWFpbnRhaW5pbmcgdGhhdCBsYXllciBpZiB5b3Ugd2FudCB0byBrZWVwIGl0IGlu
IHNvbWUga2luZCBvZiB3b3JraW5nIHN0YXRlLiBUaGVyZSdzIGp1c3Qgbm8gb25lIGVsc2Ugd2hv
IGhhcyBhbiBpbnRlcmVzdCBpbiBpdCBhbnltb3JlLg0KDQpBbGV4DQoNCg0KLT0tPS09LT0tPS09
LT0tPS09LT0tPS0NCkxpbmtzOiBZb3UgcmVjZWl2ZSBhbGwgbWVzc2FnZXMgc2VudCB0byB0aGlz
IGdyb3VwLg0KVmlldy9SZXBseSBPbmxpbmUgKCMxMTEzKTogaHR0cHM6Ly9saXN0cy55b2N0b3By
b2plY3Qub3JnL2cveW9jdG8tcGF0Y2hlcy9tZXNzYWdlLzExMTMNCk11dGUgVGhpcyBUb3BpYzog
aHR0cHM6Ly9saXN0cy55b2N0b3Byb2plY3Qub3JnL210LzExMTMwMjcxNS81OTc0OTQ2DQpHcm91
cCBPd25lcjogeW9jdG8tcGF0Y2hlcytvd25lckBsaXN0cy55b2N0b3Byb2plY3Qub3JnDQpVbnN1
YnNjcmliZTogaHR0cHM6Ly9saXN0cy55b2N0b3Byb2plY3Qub3JnL2cveW9jdG8tcGF0Y2hlcy9s
ZWF2ZS8xMzYxNDI3MS81OTc0OTQ2LzE5MDI4MzEwNjYveHl6enkgW3dhbmdteUBmdWppdHN1LmNv
bV0NCi09LT0tPS09LT0tPS09LT0tPS09LT0tDQoNCg0K

