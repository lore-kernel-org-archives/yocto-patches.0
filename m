Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C58BFF885E
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 13:56:56 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45882.1777298209829757024
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 06:56:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector1 header.b=lb0+Yj3q;
 spf=pass (domain: ericsson.com, ip: 52.101.72.21, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1WuW3oOndUxbKTkGBour3tioS3HDDhCgGi2VBW35xw7J+yN8rnZLcBTCTQt/ztOqmD528YhBgZTjbtauRXeJMffO4yXM1gKWsPgDJXduxGXb4z/FZZBtm8h77Z0kS7EwCUlX5ZNye1lPq7+7cEzPagOp2Ks4z4R+zozLqMrEPB1qtQXvQ6xRUQ0afLfZ1WmzG9sJaKE4y+xD0Jjqoy3zYU1nQ0fk1KjSEFXIjMYOTsjOdqBQs1qBPmdwvLKkcXS61wgCnFYwc/pSBelDXQLuD9dGgjBnQz5tRuAcPGQjpZuhGdaRH1P/5riLPNKvXDOkay/T7cksITVgD8yLFI4kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnlhlH4oYASwDgfA9/7DbFtSZk3fI2zKuEzenSHHrFE=;
 b=ggymbHZIzz5RgImfHNv9CGjc9AYAkJPbRxLVzTH2QGCha4A7EuRy7xb1uHJLsYxKsBj0/Y+DhtTPFB+WUb1rquWURy2cRLHOdi2B3iKvPBeZSZoKTPlFFAW/4rJix8FS1x0C75evrt4Y+MnVoxa4LoJevY0/D+iMmp6Gyx/Y6mv5I/FYo0WDtgYPyte6ZYN8aYOaJZ4UHLCogh/2yZBvMEp9AtnoDhzIzm9i5EMtdkvZ9JmzJ/eV1OPNje2RW2pjiN8JcRSlxuI2LD7MBrSXLsmj+RKE33oGEWL2wgMplUdjDEb0qNDl6iRFu66viT1sRrm5IWSha+FQdAOvJPNPkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnlhlH4oYASwDgfA9/7DbFtSZk3fI2zKuEzenSHHrFE=;
 b=lb0+Yj3q/sewQo/gT0Ods+YTDNqu2wT9KnNHuUZtFjio5C5qLdW0MKx1e/mIiYXnNQZxJZQjh0w/HRLVNXJAdgIBh1SgzvJcHf2YvKlLjNQP6GUsuGT17hBykEyiprU7teOlKXv0Y4IOn2L6zlPy0D72W9fAHPB5Qf5bovWT/xB2HeeTYD4g+9+wy4TXlOMGCHs3vt7ShTyKaODT+5vYWyIAYeyP7RT/TGfcHIOxtElVTVPGshpb6AaedoPeLnuN9UTejI8kyPje08KrB4cjD3Y7+53P+T3InrIMFe/siqs5C4iT1uEOObHoDeyAItK5bTzLRC8N9fJgsfLsgvGBsw==
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com (2603:10a6:102:4af::6)
 by PR3PR07MB6842.eurprd07.prod.outlook.com (2603:10a6:102:77::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 13:56:46 +0000
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7]) by PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7%7]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 13:56:46 +0000
From: Daniel Turull <daniel.turull@ericsson.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>,
	"yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
CC: "paul@pbarker.dev" <paul@pbarker.dev>, "ross.burton@arm.com"
	<ross.burton@arm.com>, "yoann.congal@smile.fr" <yoann.congal@smile.fr>
Subject: RE: [yocto-patches] [AUH][PATCH v2 4/9] upgrade-helper.py: add
 changelog flag
Thread-Topic: [yocto-patches] [AUH][PATCH v2 4/9] upgrade-helper.py: add
 changelog flag
Thread-Index: AQHc09/6hWRQSUvlQ0O3bFSy/GqsGbXyxvTjgAAn+OA=
Date: Mon, 27 Apr 2026 13:56:45 +0000
Message-ID: 
 <PA3PR07MB10721A91191F9AD24E138AB028A362@PA3PR07MB10721.eurprd07.prod.outlook.com>
References: <20260424114603.2444938-1-daniel.turull@ericsson.com>
 <20260424114603.2444938-5-daniel.turull@ericsson.com>
 <18AA2E7887D04BD3.1773850@lists.yoctoproject.org>
 <CANNYZj-1u7A9cjE6Uqyah0oaVWKBxcTe0-VLtcSzOwj=JwEV4w@mail.gmail.com>
In-Reply-To: 
 <CANNYZj-1u7A9cjE6Uqyah0oaVWKBxcTe0-VLtcSzOwj=JwEV4w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR07MB10721:EE_|PR3PR07MB6842:EE_
x-ms-office365-filtering-correlation-id: 4087ef4e-718b-4c5f-a726-08dea464d1ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 
 Q2DoFqmx8vT9evgFwx08ZTChzqjsdS7QLd39PU31sv6yC0LPOhXe9vMh5sFLev4ky51OgaCrbPpqVPYdd5H726vsoBh9ltDlNThJPLg/R7D5/bQo/u1i/wcoTsyzgg3LM8AdzvXZPSiIGn8y5s/cfGN23i39TAp2mT4FT/cmc/m35YZJdftwVJQ2jxnqdtzHX7La/7R4AkQ9FqJvijnaLXLqdwJSg3fq9Q2pg64LE6cd2BWyXWpCXPYLiL3Ih5zH32XwLmg1ddkyF8FY0hXo/gxFSW6tp4Dl6aKznZJEgpP6BaR/wVbwNpKJrraTOYVtCwLFTVMDmCGzgbJx/0fqx1RpHsriBpw2EmGI6Ibw97yvOTxLAmNahI7thxg0rdJeRZkX/a9zogxY21YBP/JuxnBhZ9R1szH950bnp0oNyEC6MPL4B/bUNo6bozvLb33M7R2WkwoTcxZhHWLKSC046s61WSwwQXFbQiTSv02POrqttNKZ/3tgNdaP+zOGCGNsu2/ZlFWJ3ENJYyt/eH2LEBMLG2wxI58mw095lthxQ6vFRZb4xhvW55qouXWx6DS1yuQe/tm82dVwLUQhODK2KJWzHndYY4zNwjni95EEP43Vpvm0AZ/Oz5Fh3vPjs5L+IvZLReiscPTo/PMuLpODGij9gQpW73Y/J+4XOWRN6LXScDBwkxYV2HJjjeFWavgnr/AgjCBhozLKJ2gXkDKD9a2aA18z7nbIDOphLE94bErhUh5vw/dbzm61LoM+0xpMS6jJ6DHcg281cYpU7d5aR2syzkFeMEpSkZrwt3xo54M=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR07MB10721.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WU1Ra2ZKdGN2cVZrRXlZY3o3TmQ5WXF1aUZCbFJqOHJBSmJBb0k1R1BWKzlj?=
 =?utf-8?B?aEREMGNWejFIVitwbXRLYzgybXkzU1M5bGxxU3p5N3NadGxHbXR3djVhMjQ2?=
 =?utf-8?B?VWdjcXBuRmNwQUdwL2gyYUNMd0M0aGw3a01leFNHRGM5enBzRWFNUGRCR1VG?=
 =?utf-8?B?UGdXNk9iSGVqQk9OTXFRMndLSHB6ZzVsb2p3eWRNRGtESHJDQjhkYUc3STFh?=
 =?utf-8?B?MW90UzBXQ3R1TXpqa2xXaVc2NGFiRGVFQlJiVnE4MFJuWno5d25YV0gwN1Ba?=
 =?utf-8?B?T0dUZHZOSzJ2aTZvMUpLV005UHhGWjFFM01iYnV0UWlQKzlxTTRHZlh0UE5v?=
 =?utf-8?B?M3NpL0dhSitRMEpZdXFudWRwL295VUxRSTZqOGx0UkZsbkRBbU5lZ0VUTnQx?=
 =?utf-8?B?d1JyYTdMREZMSEVEb1BLdHJzRThxbkJXb0o1UjZ0VzErRkhIRk51ZUo5Qjd0?=
 =?utf-8?B?U0x2SGdUK0ZxZ1poS2dpcCttek44cENMWjFvdkZSTXBjYlVZTGE4YlJQTGVS?=
 =?utf-8?B?MHh1MVN0aUY4cFZNN0ZZbGJFeVNNOXdqcWg4d1lybllacEI2M0xYTU9DamtC?=
 =?utf-8?B?Ni9IeVJBNHpOcHoycW9YTmZzVEJ6VVhDdDBQMXRFS08wZExVZjkreGZRUW9P?=
 =?utf-8?B?enc3MVYxRHpvNUxLWlhSVnNSUi9UcHJpNW9lSmo2bFhQTzVJeDVVQzM1VUtT?=
 =?utf-8?B?V1k2SEo5TG1LWnhjbURvTGhOMWxEb3hFTDRENVNaMTVDWFJPelZkbkhrRE5a?=
 =?utf-8?B?NFFMZ2hlVWlGbzVEUUdueVBzRGszbmJCeUlHMlI3VW04anNjUDRTTU5yQ0I1?=
 =?utf-8?B?UnFJeWg0V2FSdGRMaTQ4WkxjVVdJK3RtR3JsRFR5NGRvN2t3OWhsVUU4ZG9K?=
 =?utf-8?B?UXlrdThHQ3YwZ3F4YnFEcUVXdUJsRGJNcTFZVytUTDAzcTNtVnRpMmFZRU1z?=
 =?utf-8?B?L2xMdWsybVNYenhYSGFiZnlQWkVpc1doZk80MDdTdzE1YW10YUpEY0tiUlZX?=
 =?utf-8?B?U3J3cmlCUWRYY3I4RVl1MlFicWx6L1I3VCt5Z0pnN3pJV0RHWDdCUmFBRDRC?=
 =?utf-8?B?b3BDeVQxajNMcDErTEdLUmRiaU5yOU5PYjVGL1gzaGgrR3ZqSUk4NDNCQkxY?=
 =?utf-8?B?Yyt5Z2lMRWRiNXBEWGRZR2xDdkFGM09BVE5hOUt2amlNRnhyemlrRm9yVHBT?=
 =?utf-8?B?Qm1ZM1Y3ZzVOdDB5VjZITDFvdzlvR2g4Ky93dHB4UkpHd2lmNkV0bmdHdnB0?=
 =?utf-8?B?YkVjaVFsZElhV1ZzT1psYmxCVFgvZUUwWEhwQmR1VHlmOXZIUjNmajQzTDFP?=
 =?utf-8?B?akhlVExJdDF2U2h5RCs0WkkvY3EwbWhVZ0pqejVuWVlBUnUvSElrdXNRcXF0?=
 =?utf-8?B?RTg4SUFYVm1oMFZQSWNaVjRzZWFTNTFRMlI3eTBaZUMxRmxlQ2hGQ1BsNEhn?=
 =?utf-8?B?SVlPcGRhamNZazBObWFpa2ZRUUw3c3hqQU5kM296SEFVWVUvbTJvcjNmandC?=
 =?utf-8?B?UGJqZUhTWkFYYlpFQVI1cXRtVE9NR0luUC9vcFJEV2FocFN6TjBoQUp6cmlD?=
 =?utf-8?B?c1pEZkp3Tkp5N0t1cXN2VWRLK3hpRkJJem53VVhTb3Nud3lKd1YweTF2T2t5?=
 =?utf-8?B?R2k4REd2YUs5RGw1aFdheVJ1d2l6K21HUzRNa05Ja2RIM1U0YkNGa0pTR2NG?=
 =?utf-8?B?ZHd5OG44U2pKK0JaVkYwTDl2ei8rUHMwVVB0Ri85b1pweFhlc211cTJ6U1R6?=
 =?utf-8?B?MWs1MFBwZTBDMW8xVFp5SC9oN3gvYm9TUkJSUnBxZDlQSmpManhVVnVwV05t?=
 =?utf-8?B?NGVYMDlBZUdXNXBPejZPcE5jbDM5R0RMOUtiMWlQeDMzNG8vcVlSZXViMHl6?=
 =?utf-8?B?b2VNVjkzZExKZGp0SS9ZaDAxVzVuK29PL1U0Y1QyL3BJQXZEd3pPNk9lTjJK?=
 =?utf-8?B?bWxwZ01yU1pNbkxZMFRkc2hrcFlrNUxIM003YTBYNkszd2tNYy9KV29VcGIv?=
 =?utf-8?B?clBGanZqYzYvT2c3aks0U21TaFhHQkl5azFIZkMzUVFFdXNIcHduSVU3Zmla?=
 =?utf-8?B?L251Y3hFeDVkMjg1RXlsT21qTGMvQXY3WVordkNjM1RBWjNMRDlDbm1zRFU4?=
 =?utf-8?B?dG5ySHlWNXdCeG50RVQyMWYyMlRFUzJsWndmOFBpRjRvd3BHbFdlQ2x1M2Zx?=
 =?utf-8?B?eTlQZzkrQXE2Z3QzcnpkZ0dyU3JDdW82QkpYM3YzSHluYWdTWmMwblJJeDB0?=
 =?utf-8?B?MkxibDBRQXlYS2VIRTA1TklLNWVZL0EvT29iRDM0eGNnTExQd05IVWlBcUxO?=
 =?utf-8?B?UzZTdThYalJuQTA1THZ6bE9welg3V1RQSytkQS9KWEN2N3pGZll4QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR07MB10721.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4087ef4e-718b-4c5f-a726-08dea464d1ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 13:56:45.9921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MtnI3+2lhat4PvOv01kIXfh+wR4EQt+7npwy75SpICyu9xCfnlR0hPQtrNtfrTU1eNFeZ76lZNjs3lTpB1XmUyzM6ll/LyLP3bhI3caGLTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6842
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 13:56:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3848

SGkgQWxleCwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCkhlcmUgYXJlIHNvbWUgZXhh
bXBsZXMgZnJvbSBzY2FydGhnYXAgLS1zdGFibGUgcnVuICgxNDggcmVjaXBlcyBhdHRlbXB0ZWQs
IDk5IGNoYW5nZWxvZ3MgZXh0cmFjdGVkKToNCg0KU3RyYXRlZ3kgMSDigJQgQ2hhbmdlbG9nIGZp
bGUgcGFyc2luZyAoNTIgcGFja2FnZXMsIGUuZy4gYmFzZS1wYXNzd2QgMy42LjMg4oaSIDMuNi44
LCBmcm9tIGRlYmlhbi9jaGFuZ2Vsb2cpOg0KDQogIGJhc2UtcGFzc3dkICgzLjYuOCkgdW5zdGFi
bGU7IHVyZ2VuY3k9bWVkaXVtDQoNCiAgICAqIERlYmNvbmYgdHJhbnNsYXRpb25zOg0KICAgICAg
LSBUdXJraXNoICh0aGFua3MsIE51cmkgS8Ocw4fDnEtMRVI7IGNsb3NlczogIzExMDI0NjQpLg0K
ICAgICogdXBkYXRlLXBhc3N3ZCg4KSB0cmFuc2xhdGlvbnM6DQogICAgICAtIEZyZW5jaCAodGhh
bmtzLCBCYXB0aXN0ZSBKYW1tZXQ7IGNsb3NlczogIzExMTk5MTQpLg0KDQogIGJhc2UtcGFzc3dk
ICgzLjYuNykgdW5zdGFibGU7IHVyZ2VuY3k9bWVkaXVtDQogICAgLi4uDQoNClN0cmF0ZWd5IDIg
4oCUIFBlci12ZXJzaW9uIGZpbGVzICgxIHBhY2thZ2U6IGdpdCAyLjQ0LjAg4oaSIDIuNDQuNCwg
ZnJvbSBEb2N1bWVudGF0aW9uL1JlbE5vdGVzL3YyLjQ0LnsxLi40fS50eHQpOg0KDQogIEdpdCB2
Mi40NC4xIFJlbGVhc2UgTm90ZXMNCiAgLi4uDQogIEdpdCB2Mi40NC40IFJlbGVhc2UgTm90ZXMN
Cg0KU3RyYXRlZ3kgMyDigJQgR2l0IGxvZyBiZXR3ZWVuIHZlcnNpb24gdGFncyAoNDYgcGFja2Fn
ZXMsIGUuZy4gYXNjaWlkb2MgMTAuMi4wIOKGkiAxMC4yLjEpOg0KDQogIDIxZTMzZWYgRml4IHNl
dHRpbmcgdXAgZGViaWFuIGJhY2twb3J0cyBpbiBEb2NrZXJmaWxlICgjMjczKQ0KICAyMmYzYmYw
IEJ1bXAgdmVyc2lvbiB0byAxMC4yLjEgKCMyNjkpDQogIGMzMGQzMTEgRml4IHJ1bm5pbmcgdGVz
dCBzdWl0ZSBmb3IgcHl0aG9uIDMuNSAoIzI3MikNCiAgNmQ5Zjc2YyBVcGRhdGUgR2l0SHViIGFj
dGlvbnMgYmFkZ2UNCg0KNDkgcGFja2FnZXMgaGFkIG5vIGNoYW5nZWxvZyBmb3VuZCAobm8gY2hh
bmdlbG9nIGZpbGUsIG5vIHBlci12ZXJzaW9uIGZpbGVzLCBubyBtYXRjaGluZyBnaXQgdGFncyku
DQoNCkknbGwgYWRkIHVuaXQgdGVzdHMgZm9yIHRoZSBjaGFuZ2Vsb2cgbW9kdWxlIGluIGEgc2Vw
YXJhdGUgY29tbWl0IGluIHYzLg0KDQpSZWdhcmRpbmcgbW92aW5nIHRoaXMgdG8gZGV2dG9vbCDi
gJQgSSBhZ3JlZSB0aGF0J3MgdGhlIHJpZ2h0IGxvbmctdGVybSBhcHByb2FjaC4NCkkgY2FuIHNl
bmQgYSBwYXRjaCBmb3IgZGV2dG9vbCB0byBvZS1jb3JlIG1hc3RlciBhZGRpbmcgdGhpcy4gSWYg
YWNjZXB0ZWQsIHdlIGNvdWxkIHJlcXVlc3QgYSBiYWNrcG9ydCB0byBzY2FydGhnYXAgdGhyb3Vn
aCB0aGUgWW9jdG8gVFNDLCBhbmQgdGhlbiBkcm9wIHRoZSBwYXJzaW5nIGZyb20gQVVIIGluIGZh
dm91ciBvZiBqdXN0IHBpY2tpbmcgdXAgZGV2dG9vbCdzIG91dHB1dC4NCg0KRm9yIG5vdywga2Vl
cGluZyBpdCBpbiBBVUggbGV0cyB1cyBpdGVyYXRlIG9uIHRoZSBleHRyYWN0aW9uIGxvZ2ljIHdp
dGhvdXQgcmVxdWlyaW5nIG9lLWNvcmUgY2hhbmdlcy4gSWYgeW91IHByZWZlciB0aGUgZGV2dG9v
bCBwYXRoLCB3ZSBjYW4gcHV0IHRoZSBjaGFuZ2Vsb2cgcGF0aCBvbiBob2xkDQoNCkNoZWVycywN
CkRhbmllbA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXhhbmRl
ciBLYW5hdmluIDxhbGV4LmthbmF2aW5AZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIDI3IEFw
cmlsIDIwMjYgMTM6MTcNCj4gVG86IHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9y
Zw0KPiBDYzogRGFuaWVsIFR1cnVsbCA8ZGFuaWVsLnR1cnVsbEBlcmljc3Nvbi5jb20+OyBwYXVs
QHBiYXJrZXIuZGV2Ow0KPiByb3NzLmJ1cnRvbkBhcm0uY29tOyB5b2Fubi5jb25nYWxAc21pbGUu
ZnINCj4gU3ViamVjdDogUmU6IFt5b2N0by1wYXRjaGVzXSBbQVVIXVtQQVRDSCB2MiA0LzldIHVw
Z3JhZGUtaGVscGVyLnB5OiBhZGQNCj4gY2hhbmdlbG9nIGZsYWcNCj4gDQo+IE9uIE1vbiwgMjcg
QXByIDIwMjYgYXQgMTI6MDEsIEFsZXhhbmRlciBLYW5hdmluIHZpYSBsaXN0cy55b2N0b3Byb2pl
Y3Qub3JnDQo+IDxhbGV4LmthbmF2aW49Z21haWwuY29tQGxpc3RzLnlvY3RvcHJvamVjdC5vcmc+
DQo+IHdyb3RlOg0KPiA+IENhbiB5b3UgYWRkIGV4YW1wbGVzIHBsZWFzZT8gVGhpcyBpbXBsZW1l
bnRzIHRocmVlIGRpZmZlcmVudA0KPiA+ICdzdHJhdGVnaWVzJywgYWxsIG9mIHRoZW0gYXJlIGRv
aW5nICdndWVzc2luZycsIHNvIGl0IHdvdWxkIGJlIHJlYWxseQ0KPiA+IGJlbmVmaWNpYWwgdG8g
c2VlIHdoYXQgdGhleSBhY3R1YWxseSBwcm9kdWNlLg0KPiA+DQo+ID4gSXQgd291bGQgYWxzbyBi
ZSBzdXBlciBuaWNlIHRvIGhhdmUgdGVzdHMgZm9yIHRoaXMgbW9kdWxlLCBlc3BlY2lhbGx5DQo+
ID4gaWYgcGVvcGxlIHN0YXJ0IHR3ZWFraW5nIGl0IGZ1cnRoZXIuIEl0IGxvb2tzIGxpa2Ugc29t
ZXRoaW5nIHRoYXQgY2FuDQo+ID4gYnJlYWsgc3VwZXIgZWFzaWx5LiBJIGtub3cgQVVIIGhhcyBu
byB0ZXN0cyAoSSBpbmhlcml0ZWQgaXQgaW4gdGhhdA0KPiA+IGNvbmRpdGlvbiksIGJ1dCBhdCBs
ZWFzdCB0aGlzIHBhcnRpY3VsYXIgcGFydCBjb3VsZC4NCj4gDQo+IEkgc3RpbGwgbmVlZCB0byBz
ZWUgZXhhbXBsZXMsIGJ1dCBjb21lIHRvIHRoaW5rIG9mLCB0aGlzIGNoYW5nZWxvZyBleHRyYWN0
aW9uDQo+IHNob3VsZCBiZSBpbiBkZXZ0b29sLCBhdCBsZWFzdCBwYXJ0aWFsbHkuIGRldnRvb2wg
Y2FuIGRpZmYgdGhlIHNvdXJjZSB0cmVlDQo+IGJldHdlZW4gdGhlIG9sZCBhbmQgbmV3IHZlcnNp
b24gKGl0IGNyZWF0ZXMgc3BlY2lmaWMgZGV2dG9vbCBzcGVjaWZpYyB0YWdzIGZvcg0KPiBib3Ro
LCBldmVuIHdoZW4gdXBncmFkaW5nIHRhcmJhbGxzKSwgYW5kIHRoZW4gZmlsdGVyIHRoZSBkaWZm
ZXJlbmNlIHRvIG9ubHkNCj4gZmlsZXMgdGhhdCBjYXJyeSBpbmZvcm1hdGlvbiBhYm91dCBjaGFu
Z2VzLCB3aGljaCB3aWxsIGVsaW1pbmF0ZSBtb3N0IG9mIHRoZQ0KPiAnZ3Vlc3NpbmcnLiBUaGVu
IGl0IGNvdWxkIHdyaXRlIHRoYXQgaW50byBhIGZpbGUgc29tZXdoZXJlIGluIHdvcmtzcGFjZSwg
YW5kDQo+IHRoZW4gZnVydGhlciBmaWx0ZXIgaXQgdG8gaGlnaGxpZ2h0IENWRXMgb3IgYW55dGhp
bmcgZWxzZSB0aGF0IGxvb2tzIHBhcnRpY3VsYXJseQ0KPiBpbXBvcnRhbnQuIFRoZW4gQVVIIG9u
bHkgbmVlZHMgdG8gcGljayB1cCB0aG9zZSBmaWxlcyBhbmQgaW5jb3Jwb3JhdGUgdGhlbQ0KPiBp
bnRvIGNvbW1pdCBtZXNzYWdlcyBvciBlbWFpbHMuDQo+IA0KPiBBbGV4DQo=

