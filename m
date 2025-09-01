Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ACBCA0FF0
	for <webhook@archiver.kernel.org>; Mon,  1 Sep 2025 11:42:29 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.35])
 by mx.groups.io with SMTP id smtpd.web11.49019.1756726946848917306
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Sep 2025 04:42:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=JGhkeE1E;
 spf=pass (domain: axis.com, ip: 40.107.159.35, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEJhIxMGP6VQvHmJSABaMA87YEjGZ4myHa8tXIiLhNykrSRGdY3/A4H6yDBFnA2V1vkQUkVqfT4No6e61QoReqbGT4WUt1bWdd1R2/03fqfSiA3u9UCE15wmsvtcqn9uMmBi6wSlfGYbMoTGIIGT3nMBQMVQQBhTo4Zdo08Sl/V+cJXNiFo8XIcTvTcrJR8vUCahP/emR9FAmUrufypfK4fuDIBKwGxpbEPuF7eZ1UclBTpVIJkd0IAW3wJyw+j4LjvU35JZ5dFicZIolf1y2ukGkVedzP7XnZHCWptY1R3jnhuwU2ThWsiRyDAGh2HKW4f+sUiQjiAoj3hHv8wljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DPwussUAfGXuU7k56IwKrUB8daAA0TAe9Bnk/672mM=;
 b=N7c1MY6jV1E+GFs7zHO4yfn8JV38o5BnXJS0fHeOvvzAZwr89MEhr8Ht2NgEO1mWdWaWeRwcT7Iz1t+guEU9Wwtd+oYqZq8n5NIU5h02D0TZpZqZEV4lnM0K78rDGnuBnfayPgwRqf9QZoSwEqnJo0fz++Nwm4D0djh8Y24G/z/gShG8LJn2zqbsamsVTCmC5f/ScZxFGJd4E0calWb+yDi9yeE9WbBtBf/kYSNjCRGWs2Sk5ccr7VVF8GgoRU1TGkVaKdDJdbaiNTfS49+lmDLi4pHAYayk0OyJjNMx8JMNklAX4tWyq7C9qz/obbCxMjNlmpNI56RTo3VWGSoE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DPwussUAfGXuU7k56IwKrUB8daAA0TAe9Bnk/672mM=;
 b=JGhkeE1EPRRxQFHdp28Svd8nEC3zsd7N4foxg2abiwEJ/5H/pJsJoT/O3gxOugPBp2vz5fzK8ATQ14iEAoCXkvRclktoFq9+qq/L0olQ0hXq4QynuZ30Un0M8TCLP+ggHG0FkFAjL/YdRLSBZkRzGaC+EGV+XLjurQTLgptK3HM=
Received: from AS8PR02MB10201.eurprd02.prod.outlook.com (2603:10a6:20b:63d::6)
 by DB8PR02MB5945.eurprd02.prod.outlook.com (2603:10a6:10:11f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 11:42:23 +0000
Received: from AS8PR02MB10201.eurprd02.prod.outlook.com
 ([fe80::90d0:ca74:2479:bbdb]) by AS8PR02MB10201.eurprd02.prod.outlook.com
 ([fe80::90d0:ca74:2479:bbdb%4]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 11:42:22 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: Scott Murray <scott.murray@konsulko.com>, "MacLeod, Randy"
	<Randy.MacLeod@windriver.com>
Subject: RE: [yocto-patches] Insights from Integrating mixins rust into
 kirkstone-based
Thread-Topic: [yocto-patches] Insights from Integrating mixins rust into
 kirkstone-based
Thread-Index: AQHcGCUREa5GxjpiDEWeb+Itb15curR5ZaMAgAADF4CABMpHgA==
Date: Mon, 1 Sep 2025 11:42:22 +0000
Message-ID: 
 <AS8PR02MB10201C038E988CBC466E2B409EF07A@AS8PR02MB10201.eurprd02.prod.outlook.com>
References: 
 <CY8PR11MB7921AAF6CFDC45DD76C7B40B813BA@CY8PR11MB7921.namprd11.prod.outlook.com>
 <CANx9H-Dy+hRXngzUdRew-v4xR8dsg-4_r=j=aJZrtKXwe2yPSQ@mail.gmail.com>
 <CANNYZj9i7Yh5ZbifZsd_=uTkDk5_C50fbWyM=7BJrEgF+vLL0w@mail.gmail.com>
In-Reply-To: 
 <CANNYZj9i7Yh5ZbifZsd_=uTkDk5_C50fbWyM=7BJrEgF+vLL0w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR02MB10201:EE_|DB8PR02MB5945:EE_
x-ms-office365-filtering-correlation-id: 5113c4d7-e4eb-4425-43c8-08dde94c9db8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bWExR2RTQjJLTGdVaWxPRStIMk4wRUNMclJqZXZtbEcwekVQcXB2V2NoUnhZ?=
 =?utf-8?B?cHRmazUxV05CWmdsb1lhN1pPSDc4eHh1Y2I4ZjVrOW0rR3VmejNSRXdLMFNk?=
 =?utf-8?B?azk2YkN6RVRWL2VyM0pzZ081aXJwNVRCRGw4WXllazg0SmhiNWRNZkRCMkF4?=
 =?utf-8?B?V05pZTFvMnFXQXpVRFRuemdBWlRaenQ2MEUyZlE5b2dLTy9PUDg1NEl1SFVy?=
 =?utf-8?B?ODNteEp6Znd1ZWVwOGc1UkVIVGxtZTdGcHJXL28zMTV2NUEybjBocFRNM1BX?=
 =?utf-8?B?UFBMNWVUYmdXTE9JL05rclBhaUl2Szl0ZXlEeStYVVdtdTBkYnBpUTRHY1Fu?=
 =?utf-8?B?a0locXV0OFQyQWYrL2RVZzF3a2U0UFdtbTc5OTNFSzNmUGhvWmVIR2dCMGhR?=
 =?utf-8?B?SDNxMVJXeGRDRlpDTldGZjl0MkEvSlVRcWZya212OHkxYThJNkw4MlhJOHRM?=
 =?utf-8?B?VkhMYnFhek1ueFdXRFlqcnl1Z1dXT01oamk5RDRMMVB0YUNXQmQ3Y3JVNzgr?=
 =?utf-8?B?WjZpb3Nja3NpZGg0ajlFWDFWTmE2MGFURWdpczc1cEF6azZjRFE2UDUzOEgv?=
 =?utf-8?B?NFpyYjZoOUFNcmxqZGQ4WTZyMitPWlhBaVg5bC96bVh0UnE5VVlwWHBUNmp6?=
 =?utf-8?B?dUYwRFJ2U1NLd1IzRUErbXA3ak9RRENVSGVLMWJIQkE0aWJDZlNwVFJTVmwv?=
 =?utf-8?B?eXFvNlpFaEphK2puK1NYQk1BR09QaUtzSXVPNEptbmRVMjFpVUhmYnRjRFd2?=
 =?utf-8?B?YUQ2RTVwcmMxeEI1R0dRTUt5ZVRMVHlZNGdYSmZQdy82Ny9TTTJFRFNCbVU2?=
 =?utf-8?B?RTByTXpIaFVjcmRuNWpsTEFBYlRuM1d6L2Z0VlZlU0JhcGVRUzZXK3ludVVD?=
 =?utf-8?B?cFdmNXhJSHQ3V3J0cEF3dVJ6MWRTU0JadWJwRDliamg4Mzl2ZHREZmwrQmxQ?=
 =?utf-8?B?a3hnVmtIN1kvVVFCWEd5NXdNdjBab0UxTmJod1k3NkN6VXFuMjkrdmtzZjlQ?=
 =?utf-8?B?b0k3dXByWU5SUWxWN2lPcGxsOUZqOWwrZklnVDRXNUNBMzZWQnBRaDRrMUND?=
 =?utf-8?B?THdmb05kZ1RjV2FVcTlQWERxM2ZPUjVTenVWZllFY0ord1k2M29VTGtOMWtM?=
 =?utf-8?B?QWxQZUVzbUcwS0laR1liSGp3YXN5ZzdrZVVKelN2emxkdWpJN1RWblBZWGoy?=
 =?utf-8?B?d2NGbTJjQzdlY2tKTGFVVnZnZkJRMUFEWE56RFVZTnFtZGRiWHB3TFFSSGJt?=
 =?utf-8?B?aWt5MERlMUFVeXY0ZEJHZWdVdE5NVE14RVJtckZkZmh0eFRJNDZ0OWVxbUdF?=
 =?utf-8?B?OCt1MENwbU9tTzNmUGVFTnhhazhEY01JbVpJZTZQY1BKOCsxeEgxdU9QRGNU?=
 =?utf-8?B?MUV1NUhyQlBNSHg3dTM4OHg0eDErWWc0MnB1SWNrczl3RHJ6QW11NDYzcVRa?=
 =?utf-8?B?QmF6ZVUzcmdQb1gyNitPRnBFMlZDb3h3LzR3WVVMdUI1Z3Rzd1ROYk95RkQ5?=
 =?utf-8?B?MGNGd0ZIU1RaK1Z1dDRpc204Yzdyb0FKSzF1Z1Noa3UzYTVPUGRVcE9wZE1v?=
 =?utf-8?B?eUhIaFBsVVBtWklpbCtZVXZaVnNvTG1kRkxaRzZrS3V0SGxxejBvVUp0ZmNu?=
 =?utf-8?B?SUZxeThraXJqNUtneWZGNS9Uem5pUzNWNm01b0gwM21wbSsxWVZtdnA4dUFz?=
 =?utf-8?B?czZPV0RLR2lqUVZJVnBFQTU2MXc2eThqT1JYM1dWODNOa0s2ZTRISk4vLzkw?=
 =?utf-8?B?RGE2N1NOektEOThCOGlBanN4dWo0SUFweUl5T3h2aEdWQ3FMTnNTamk2WHhz?=
 =?utf-8?B?a3JoaWtOa3V1U3hZU0luTXNoVWtKMk1PTi9GbFMyamw1TThnTExxOWVjei8y?=
 =?utf-8?B?amZRV2VmSWxiQzVMWEd3SHpEQTdneG1KOHNNcHR4bWducXdSMCtOc1ZVNUIr?=
 =?utf-8?B?bHJCbW9NSVVVUXFoL0ZEMnY2UU1WM3MxaitWUmdvQ1g0WGphZUxONWdic2FC?=
 =?utf-8?Q?M+d5ybBRM3ZmHWM7inDxURk/Lau/FY=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB10201.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dmZIMjV0QmVHcUcxSFozbThzckJvUkJHSGhnMWNXNUcwVUljR2xqa0F6MHdp?=
 =?utf-8?B?aDk3d1Z4UENudFBmdkI1YWVpdVprb1hZYjNyZU5mY3hSM0Y5UHlPblBBWW0v?=
 =?utf-8?B?Vm5IR2x6K1JMb1hFaGhLTFpidlJ4OWQ2RmF4TGNRMHJza3ZvQzNjMUVsSnMy?=
 =?utf-8?B?YTVGcjhhNWpKOFJVNUlGdXVkdHY5cDhxUWs0YmhCYnNvLy96aDRnZ1ArdjVB?=
 =?utf-8?B?ancvYno0ekFFVThHWDVFODBzM0dCL3hpT1d3TUZyb1N2T0JNR3dhcy9XZTZN?=
 =?utf-8?B?K0l6RkQ0VzdTYmI0NSs2RG5NM0lBWU02dERDTUpVaVNPZnhaVWpjK2hCZUt0?=
 =?utf-8?B?cEdSc3ZQWVhGN294TUQremdnWUpnOWdnNHhaZUc4Wmk5S2hLRi9JUksvZXl0?=
 =?utf-8?B?cG5xbEM1cGF0OElBZk5ybjdKenk5UDRmeUdwaG9yNTFsRVNoOWRSWFprYVBs?=
 =?utf-8?B?R3JRWW9zcGJudkx2UGFCRzduYmxuZmt2TDBrOXROUW51Qms1cW5kN0NXSHE3?=
 =?utf-8?B?dWsvRFU2a2NnVlJ0R1k3U1d1QTRMQzhTbGVtM252cTFIaFo2bjBTSENSMldy?=
 =?utf-8?B?cXdzWGdaUmN4KzRuL1R5WVJjYjUvQkJqWEIvNUZsOE9mWjFYeHdvbFdpQm9Z?=
 =?utf-8?B?NE1VdzdRZXJ3bW9BanNRVXF1WjVSOVBtZWxGWFBWamNXYVhWcU1FcXNma2hD?=
 =?utf-8?B?ODdLNHlObUVvdWQ4MklMREJmUnpLaTIxTG8vaW1zNkZOU0RiZVB3LzEzdUoz?=
 =?utf-8?B?M3M1T3VFcWUzSGczYjhRcWx6TEt4L3VuUGpRMXNvcTNrRWhPY2UrREY1SGlw?=
 =?utf-8?B?RTZYdlJrbTJXZFJuN3VVNjJYSHd4WDVSNVhCZnhmWXpnbTZlMEFNMGtCU3F5?=
 =?utf-8?B?cDk0azJmQ3pCbFZqWCt1UVk3cTliUCtYMjhhSmtEeTJaV2UyRlVFR09xTjlz?=
 =?utf-8?B?L2tQNzArYTYyYXZEVHR4ejB4WEZWOXJHMmR3SFJpTWV6aEd6bU5kbUNHQ2cy?=
 =?utf-8?B?c0RkSitUeXZTSGJ1R1hHaTZveCtnSUVlYVFleHEycDNSdGE3dWgxcVZORzJJ?=
 =?utf-8?B?R2xCV2pYR2JiSDFlZncxam1mWTVlbnFhK2xpTFJvaEV6U2M5NTVHNDM1OTFI?=
 =?utf-8?B?NlNFZWtJZzluUWtCR2RaYUFZeURtZk41cTRJMzJVUE8xVGJyZEM5MzlidXM1?=
 =?utf-8?B?RCtLcmNydkZ1RnhVU3RrWjdUSk1vck5TNUF0RnA1RmRxdGozTkxkOW1MSmg2?=
 =?utf-8?B?d2tyczBIcm1IeUNvSzcxWDlCN0R2QUJBaCtWTW94cGdNWDQxNzBjdklZTXlC?=
 =?utf-8?B?MERGQVg4MGprUERVS01YV25VTjErdldCWUF1ckh2MEVLWkc2Rk0ybzAzVjFj?=
 =?utf-8?B?Tmoyam9yU2llMnhCUnQyYUZaT3F2b3NxY2UwRFBscTJBOE1ZdFY5aVovR2VD?=
 =?utf-8?B?QzJCL0tiWHltMUZPdld3czBjUnkxV2xRdklobVRLM0ZsaUpVMU9sTG9oRkVM?=
 =?utf-8?B?L3ZOYnJBOXpXcnlka3dPVUlxYmNmTWozT3ZTQzBmZWVpY3ZFS1kvT2YxbE9L?=
 =?utf-8?B?RjZnZm9OUFZtTCtlb2RYMkRZMEw3dFB4Z2VkOU40NngxbXhXUm80ZXNVUitz?=
 =?utf-8?B?eXA2MXF4ci9EbDBRZkRYcC9oSm9zT2x0MXJwQ2FzV3VndWU0YlpmM0pIMkh3?=
 =?utf-8?B?VG83SkJQNGZmekg5R2NmMzlaM0o5dUJyTXcra3BpU2pyLzUxVEZJQUNUaDVn?=
 =?utf-8?B?UzlQdVZoaFhROThZdkRDdTFkZlpJQmtJSjhUWjY5VTY4M2NReHY5dWNRRXBm?=
 =?utf-8?B?QU5SSmNodldWaTVTT1pEMEVvenRFV1JsWDFDdGdpMjdxNGZrQzJzZGE5VVdM?=
 =?utf-8?B?R0U4QXI4QjlUNktmcllSTnphTm54NUMzVlFwZDlXK2hhdUJUdjliVzBLcG5B?=
 =?utf-8?B?dUo4VjR1N2k0a1FnSFdZczVqamREWmFnRGRqVzlyRTFzMXcxbU8vTHdnRGJt?=
 =?utf-8?B?dVlwOHIxWlhUMEhoR3E0SStvN0pXckQrUVJhRDlIWEFBMklYcGlmcWJCdTV4?=
 =?utf-8?B?RE5tVnZqejNkV1dVRmV3U2hPL3p5WTRXeHVOdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB10201.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5113c4d7-e4eb-4425-43c8-08dde94c9db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 11:42:22.9295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d0HjXcOm8TN65l/ZAwHuBfX9PVjnF/ofYF4NJJ5e46v4+XT1jMbu3PfclEuhyT3h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5945
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Sep 2025 11:42:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2100

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiB5b2N0by1wYXRjaGVzQGxpc3Rz
LnlvY3RvcHJvamVjdC5vcmcgPHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZz4g
T24gQmVoYWxmIE9mIEFsZXhhbmRlciBLYW5hdmluIHZpYSBsaXN0cy55b2N0b3Byb2plY3Qub3Jn
DQo+IFNlbnQ6IGRlbiAyOSBhdWd1c3RpIDIwMjUgMTI6MDYNCj4gVG86IHlvY3RvLXBhdGNoZXNA
bGlzdHMueW9jdG9wcm9qZWN0Lm9yZw0KPiBDYzogU2NvdHQgTXVycmF5IDxzY290dC5tdXJyYXlA
a29uc3Vsa28uY29tPjsgTWFjTGVvZCwgUmFuZHkgPFJhbmR5Lk1hY0xlb2RAd2luZHJpdmVyLmNv
bT4NCj4gU3ViamVjdDogUmU6IFt5b2N0by1wYXRjaGVzXSBJbnNpZ2h0cyBmcm9tIEludGVncmF0
aW5nIG1peGlucyBydXN0IGludG8ga2lya3N0b25lLWJhc2VkDQo+IA0KPiBPbiBGcmksIDI5IEF1
ZyAyMDI1IGF0IDExOjU1LCBUaW0gT3JsaW5nIHZpYSBsaXN0cy55b2N0b3Byb2plY3Qub3JnIDx0
aWNvdGltbz1nbWFpbC5jb21AbGlzdHMueW9jdG9wcm9qZWN0Lm9yZz4gd3JvdGU6DQo+ID4gWW91
IHdvdWxkIGxpa2VseSBhbHNvIG5lZWQgYSBtZXRhLWx0cy1taXhpbnMgbGF5ZXIgZm9yIHB5dGhv
bi4gTm8gb25lDQo+ID4gZXZlciBzdGVwcGVkIHVwIHRvIGRvIHRoaXMsIGJ1dCB5b3UgY2FuIHNl
ZSBhbiBpbXBsZW1lbnRhdGlvbiBhdA0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS93YXJ0aG9nOS9t
ZXRhLW1peGluLXB5dGhvbg0KPiANCj4gQW5kIHRoZW4gaXQganVzdCBlbmRzIHVwIGJlaW5nIG1v
cmUgZGlmZmljdWx0IHRoYW4gZ29pbmcgYWhlYWQgYW5kDQo+IG1pZ3JhdGluZyB0byBzY2FydGhn
YXAgKG9yIGJldHRlciB5ZXQsIG1hc3Rlcikgd2hlcmUgYWxsIHRoZXNlDQo+IHByb2JsZW1zIGhh
dmUgYmVlbiBhbHJlYWR5IHNvbHZlZCBieSBvdGhlcnMuDQo+IA0KPiBXaGlsZSBJIGFwcHJlY2lh
dGUgdGhlIHdvcmsgZ29pbmcgaW50byBsdHMgbWl4aW5zLCBJIHN0aWxsIGhhdmUgbWl4ZWQNCj4g
ZmVlbGluZ3MgYWJvdXQgdGhlbS4gV2Ugc2hvdWxkIGtlZXAgcHVzaGluZyBwZW9wbGUgYXdheSBm
cm9tIHRoaXMNCj4gJ3N0YXkgd2l0aCBhIHlvY3RvIHJlbGVhc2UgZm9yIGFzIGxvbmcgYXMgcG9z
c2libGUnIG1lbnRhbGl0eS4gSXQNCj4gbWFrZXMgaXQgZGlmZmljdWx0IGZvciB0aGVtIHRvIGNv
bnRyaWJ1dGUgdG8geW9jdG8gdXBzdHJlYW0gZm9yIG9uZQ0KPiB0aGluZywgYmVjYXVzZSB0aGUg
Z2FwIHRvIHRoZWlyIGRhaWx5IHdvcmsgaXMgc28gaHVnZS4gTFRTIGlzIGh1Z2VseQ0KPiBzdWNj
ZXNzZnVsIGFuZCB1c2VmdWwsIGFuZCBzb21lIHdhbnQgdG8gaGF2ZSBpdCBmb3IgZXZlbiBsb25n
ZXIgYW1vdW50DQo+IG9mIHllYXJzLCBidXQgaXQgaXNuJ3QgaGVscGluZyBpbiBnZXR0aW5nIHBl
b3BsZSB0byB1c2UgbWFzdGVyLg0KPiANCj4gQWxleA0KDQpXZWxsLCB5b3UgY2FuIGFjdHVhbGx5
IGRvIGJvdGguDQoNCldlIHJlbGVhc2UgZmlybXdhcmVzIGZvciBhbGwgb3VyIDIwMCsgcHJvZHVj
dHMgYmFzZWQgb24gdGhlIGxhdGVzdCANCnZlcnNpb24gb2YgT0UgKGN1cnJlbnRseSBXYWxuYXNj
YXIgNS4yLjIpLCBhbmQgd2UgZW5jb3VyYWdlIG91ciANCmN1c3RvbWVycyB0byB1c2UgdGhvc2Ug
ZmlybXdhcmVzLiBIb3dldmVyLCB3ZSBhbHNvIG1haW50YWluIG91ciANCm93biBMVFMgdmVyc2lv
bnMgb2Ygb3VyIGZpcm13YXJlcywgd2hpY2ggYXJlIGJhc2VkIG9uIHRoZSBZb2N0byANCkxUUyBy
ZWxlYXNlcy4gU28gZm9yIHRoZSBmaXJzdCBmb3VyIHllYXJzIG9mIG91ciB0ZW4geWVhciBMVFMg
DQpyZWxlYXNlcywgd2UgZ2V0IHRoZSBiZW5lZml0cyBvZiBZb2N0bydzIExUUyByZWxlYXNlcywg
dGhlbiB3ZSANCmFyZSBvbiBvdXIgb3duLi4uDQoNCi8vUGV0ZXINCg0K

