Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78E7F8A144
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 08:25:36 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.0])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8910.1776327926247663172
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Apr 2026 01:25:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=selector1 header.b=JhogRjHf;
 spf=pass (domain: fujitsu.com, ip: 52.101.229.0, mailfrom: wangmy@fujitsu.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2g6wvsi9evogsDdBtRJ91vs1iu82DC+FpQK/140vw93SrpSSammwiPTNuGjqoQdiUw+uRLY0kqopnOxUAf5NrV3jYKoEVd9luqPxbFk/EdN1YsLDA5+tirNoh/Da8QBpCzGkDzqDvQ5zVSgyoK71sw9D3Mc8R6kG85ZOeeeUxRl+tvNFDbPDjk5++BszaS7VMJbTr24x3nlnBuEree34K51VpjI3m3JJK8FzI1ErMnp3wmmEYL3Gm79VU0BmTwGTK5goOXP50NSrqkIgCLNGq7jZg+v9lq77fKtZQH9or3gN/bf0nkI8bhFhxKjHL/N7iJunA/aAGbIkQ5w/hNPpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBWjhU5z4KLZ1LvaIPVVVIp/YGtT51bIinG1cSO0fWQ=;
 b=A9jiQs9hrCd88UMbGzZgO1PD0mkgTw3rTfhkpEzaO1qC90sSNXxcYfgmqsK98R+1n0QnmH/ziiH0UvMW4OK5KuVm6Ci2UwGxVqj1D5L9aMW2owTWHc2AFVcfy/c/bDCngC31p7ny043/mQ3cZCHjIp6C5cG/g5g7rlEaMmGGQN01ntjhiWhr1+INw6YqwAqelwyjPMU6uHfI+gCPstW3OS4CyWY26QvzjhUoDEoXnckpCpTiUNnD4APyf1ZcMPur6tUxicRJ8yNC/WYLNJsm8hTHMFyTghM232TX9akz8qPmyBYz60MJut9TTk5u7MjEHZtuSC5eyCUHXnlFN/KOHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBWjhU5z4KLZ1LvaIPVVVIp/YGtT51bIinG1cSO0fWQ=;
 b=JhogRjHfkUHVo2vx9LIr5azLQ+Wjg9viom56J8YcU6ACTaGhu0h3OCu5j7FQKjx6QF56oXNuQMlUSWTdsIktuNVL2OP9ppNTFPouplo4f/zsLHjkpdyNRDpdvdnohiVEes3AXqmseOCfdUOYVCOj6rEnm/e8oZLzVspjPw6p0pOEIoqLY1excuCkl5G2Jp5RtYG8aeuYyxeS0RIKFnMyPSukhJoVPC+wCsSTQcxgivo9TPkUYYKaW3D8fWLGED/3htIw3kcxSGr6VbUDWkByCB0+SnhIJ/QvUuIbWJIsJ50cwbCP527FJXM34AbecDJBr70OYW4B3OQI/wrYIbBOyA==
Received: from TYRPR01MB13423.jpnprd01.prod.outlook.com (2603:1096:405:1c7::8)
 by TY4PR01MB12593.jpnprd01.prod.outlook.com (2603:1096:405:1e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 08:25:21 +0000
Received: from TYRPR01MB13423.jpnprd01.prod.outlook.com
 ([fe80::3d11:d8ae:995f:1776]) by TYRPR01MB13423.jpnprd01.prod.outlook.com
 ([fe80::3d11:d8ae:995f:1776%4]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 08:25:21 +0000
From: "Mingyu Wang (Fujitsu)" <wangmy@fujitsu.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [meta-cgl] [PATCH] layer.conf: Add wrynose
Thread-Topic: [yocto-patches] [meta-cgl] [PATCH] layer.conf: Add wrynose
Thread-Index: AQHcw0PPxnlsNmBvHU+7L/Jeh3jsHbXhbpPg
Date: Thu, 16 Apr 2026 08:25:21 +0000
Message-ID: 
 <TYRPR01MB13423483E05357C24BD6F294DDC232@TYRPR01MB13423.jpnprd01.prod.outlook.com>
References: <18A2CB707C61701D.732937@lists.yoctoproject.org>
In-Reply-To: <18A2CB707C61701D.732937@lists.yoctoproject.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=ab352488-9e06-409b-be56-fe37fbb2052e;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2026-04-16T08:25:15Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB13423:EE_|TY4PR01MB12593:EE_
x-ms-office365-filtering-correlation-id: 0cea09b0-3d88-4ac0-6625-08de9b91b35f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|4022899009|366016|376014|1800799024|1580799027|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 Z6ZDaY4Hlhi5VrX4DLsz8BXSBlSfI0siuETAOnlnGQnlXr6FBfDklhVbRBmm9IgfhBaUeBVGSVW2CKPAXL9nBanfp6Sc0L9EiHhX84r620u5GHBUgtgI4kJUvhdG8OwYITJxxdzQhG80Y1HwWRqBpz09mdSHR72HK3WJoQiTPmL0Qhi2lGNkK4a4Qr3aArpB7glBOZAXH0mUQH3uD9Wkgc48q5TmGpH6R7ZBITJ3PoTq5SaN0CvXxb/vUZb4QT+jy3ERUsFzOA1X63jwr6dZufAPkSSz4zJe2yjdXEM3E01/11vFJJk+YH/nJ+Qw264T6puGsbyi9/pQJE5Ayew8EQcVqfIXJpF7QeJJ/sNO0cCmIM+wo62HcciBrL2vabAifN0puBXUtCpkV1xdLHxbsHadWo1lfXyoAuTQlefWDXU/yYYL2aLKnAUc0AHYdH1/6bumY9Jp9Tm2qe9xTPGWGEKf3Ucmkv9eSprUCjaNV3FjlRZ104DKa42CtkPT+ilBM+TRK5h58p4Q4AoykPLOsQrKVqV7hAer2VWui6qtPGcOkzAwJSlNTg190RsesvJOwgnEaYSy1J/kgLso2SiPNZtpdE6IjeK4hQfLRfsTpyjz9MieC5851LQPkT5Axw8bZf2tk20z8ADcaNeXTPv8vP6UEKMmDgDqL84iY93hQS9h+xv73lohVniOItkESPGFkuvvJLRB0rNmIRjC2LvIsiWgItRb1a89IMDgfHYJuMdEfOXAhujb1w/+PcVVWip1P3xLxPRLXTuoNwLavIsGwQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13423.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(366016)(376014)(1800799024)(1580799027)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?ZEgyMi9WQUgxdE80RGJKVVFNWnFLOVVrcXBoTk9xV1J0L0VCR0RqRUg2N3J3?=
 =?gb2312?B?WjZpQklhUkt1VGhBZFFUdkg0MU5teEd5RHprSE1hRGVSelNCUnJ3N2xiZXND?=
 =?gb2312?B?V1Q5dEpTRUl2dndVUlR0UDVkZVVOSGJLbUg2VzJLWVV6bWRDQkR4SG1FL2I4?=
 =?gb2312?B?dzFSZVh2V0t1MklvZ2M5VGpFUTVkTWdRbjliNVUvZFFYbU52WG9nMGJYMUVr?=
 =?gb2312?B?Y3NmK0F1MWtqdStRK3M4bXpycU9Tc3FRTmdqZE9RWjZMeXhvVktnclRJMGdm?=
 =?gb2312?B?RzdQNW9TMmJSaWljUGtKdGFPZ3ZJU0pvM3RIalcwMUp1bnA1YWdtMjFsUjBT?=
 =?gb2312?B?bWNTSmpBSGlaNnB3bjZjTkxuU0MwU1pWZ1krMVFraFB3dnkyajJIL3VmdHlL?=
 =?gb2312?B?RUNrZUhwcGMvUzg5bGpTWGdnVGhXVFJKbjFvakt1T1pJMWY1TWIvL0xvaHBV?=
 =?gb2312?B?cHl4SzAxbmI2ZlRqSEsrTVV1S0hMcGh4dmlLWDBKblkwZ1ZOelhCbVhkU2hW?=
 =?gb2312?B?VlZUbjlVUnphK3J0Ry9PbDljdWdKS3pYVTM3eGw0eGg3alJpZ3I0cDFmMUF3?=
 =?gb2312?B?bnovdGNNcURwZ0JKaU1SMHNXS0p0SzdpVVVWMHdWQVdqK3Z1SzB6NVQxSlRj?=
 =?gb2312?B?U3gzamYzbWxBZE1YODVNbEY1c2NLaXhiT2VrUm9BK0t6Ly9NUVdQOU9BYjcw?=
 =?gb2312?B?dXFZRTk4QUo4cVhUbXUyNGdNemhnNVI3TFRLYzV4MHk2THJlU3FrU0F5eDZU?=
 =?gb2312?B?RkR6ZDlMTkdxdGxEc2o0VHByWEo4MGc0aWlTa2xlTGMwa3JqR0wvdmpMSEZw?=
 =?gb2312?B?THgvV0tBdVg1WFNCQU5sRGZla2NiLzdoemg1TjFLODVnelBQNVoraDE3Q1cr?=
 =?gb2312?B?SlRKTE1xcDBSbEtJUWFzOU1jTWZqVmRJYUxPL1d1Umx2VGxGNE83ejBXeE5t?=
 =?gb2312?B?MHdNQ25rR1R4WEFhYURudWx0bXYrcE96dTIzcUp2d2p3WnZwQi9oQkczQURH?=
 =?gb2312?B?TkpwWTlPV0tyNlF2a3N0K1FGbTdJQ1E5ME5WUlE3S0YrbThaZEQyaGhoa3Uv?=
 =?gb2312?B?YkdNZGd3bm9SZEQ0b3hMOWt3cW9nbE1XUEE3bE5tTWdkTEU4ZkdZbnBSMUY5?=
 =?gb2312?B?c29YRXp3d1BIZy83Q1lpZktMT1FRK1crdUprRmlIRExvekd4T1dQNk9kOFpW?=
 =?gb2312?B?RG5LVU9QUE96cEdGaDNUOHErVTVWOEJQRmJ4U1JXU2Y1b0xaL1dsb3RRWEVn?=
 =?gb2312?B?OWRnZG0rWGMrK1lIT29sMVBQZ25KVmFTNGhSUVRWV1lwcmU1bHpFV3dZQVZX?=
 =?gb2312?B?Wkk2SHRCMmNQVmVkU3hQUGtUS1dsalVyZWhzaC9YZTRmSkFnRWR5MWFxT1dC?=
 =?gb2312?B?QnRXY3U0dnJOQ0xjb3gyUktxTTBpbEZQK2ZPZnJFRnpvS1U4dTc4NnFpN05t?=
 =?gb2312?B?OFJaaXpObVNXeEw0ZDdSSjZQcE9CT2hCQ1FSVTFTNlpCTVYzcnFtWURRZDJz?=
 =?gb2312?B?NmpiTkd5OGpib2owWXp2T05YaTRFVEI3SFZ3bTB5MC93QWdTZFlPVVNZVVVq?=
 =?gb2312?B?bWJwZmJqMDdGZEZKNVlzMUR1UkdvWTl6bndZdlJUcDlTSndOMnpWOWQ0UVFl?=
 =?gb2312?B?cVZVN0d5VXhaWjlLUTR5WGErbDBqNncvVmZoRlpmaW8zdk1odDA2M090cHYw?=
 =?gb2312?B?N1JwZm56YWZFanVXNFRaZVZqSnhZUk5LSkhDWnZXSnNmNk9qbFAwUVBnTVNw?=
 =?gb2312?B?STNsWGJKOG5VekljUDQ3OExtMDRoT3o4WE5VT292K0RHN3NVQ01sVnBFeWwz?=
 =?gb2312?B?dkhtS3IzemVYNUgyWWhZWWxOZVc1R1JXVjJQSXpVUk1MYTVBTGR6NE81bC93?=
 =?gb2312?B?R3p0VHRuOG1sVjdDV1VQdnBDWkhocUxwSTN5K0pRdG5vRjhUZWwyWEQrTzlH?=
 =?gb2312?B?Q1c2VVhIWllBbVd6TlcyMmJGT01GUHowV3I1TndQVFlXbm11MWR5R1l1b2cw?=
 =?gb2312?B?R2lNKzgycUJWQXpEQ1JXdlFEM2JqeHcxOVpiS29ILzI5eWc5UWc0djA5czdF?=
 =?gb2312?B?dVhPbVUvWXlDalZ6SEhiT0YyNHlJRmZMeUlvWStmSTA5M2FMeWY0ZXQrOXha?=
 =?gb2312?B?MWppU1ZqTDc3U1Q4MXhYTWxFRG1mYkxkMFNJN2tUaE9TZEpiTk93RjBEZURX?=
 =?gb2312?B?SmFsTExOTTBtZ1A1UHRBdzNVRW1UckxhOEw4d0xodWNGL2NyRXA4Wng1QzFU?=
 =?gb2312?B?enhIOWdWK295bTRrRndvTllLT1R6WjluSjRzR1ZIdFBOVjNuTy8reG5hK0sy?=
 =?gb2312?Q?R9gUVv9PcAjfLnuNbT?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	DZbX/CDAFTujLcTmT0PZbcemfeLFHV0caT+S1niltO+Blff/m6Y3gumloMwXya6K3ZzJIeOQ08qWPylPFQUsKqBIUBaOM94FWufzKpXLelGYOwKMjwX5pEUOuYb9R1owLj/TV2b3BIWo4n4vipxw2dOTNsvNYhEyz7DoA6kaO9Bnw1hgukQQchRSa2+YUu25RabB6s1wuKod3nfaChbqDKiQBagD7rh8ykcRKTRFPjVPDLbgCAHViD+COeHgHOsxjzuKpRwm6mxa3G5CqZOARM/uQtj1b0A0LVEzaXhNe48Sx5JBF/vFYsF19g+gZUWKxIWYssp4gTAtLqb4ngz2Iw==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13423.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cea09b0-3d88-4ac0-6625-08de9b91b35f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 08:25:21.4847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4iqwGGJXVY1TZZ2/G/ks2ia0wUe6qACnNjwQAuA6d8r9GYvCtPjGDgEsW/gMl+ILiQJaBHz02sHVs63LRiHdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12593
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Apr 2026 08:25:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3722

cGluZw0KDQogIC0tDQpCZXN0IFJlZ2FyZHMNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KV2FuZyBNaW5neXUNCkZVSklUU1UgTkFOSklORyBTT0ZU
V0FSRSBURUNITk9MT0dZIENPLiwgTFRELiAoRk5TVCkNCk5vLjYgV2Vuemh1IFJvYWQsIE5hbmpp
bmcsIDIxMDAxMiwgQ2hpbmENClRFTKO6Kzg2KzI1LTg2NjMwNTY2LS04NTY4DQpDT0lOUzogNzk5
ODg1NDgNCkZBWDogKzg2KzI1LTgzMzE3Njg1DQpNQUlMOiB3YW5nbXlAZnVqaXRzdS5jb20NCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiB5b2N0by1wYXRjaGVzQGxpc3Rz
LnlvY3RvcHJvamVjdC5vcmcNCj4gPHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9y
Zz4gT24gQmVoYWxmIE9mIHdhbmdteSB2aWENCj4gbGlzdHMueW9jdG9wcm9qZWN0Lm9yZw0KPiBT
ZW50OiBGcmlkYXksIEFwcmlsIDMsIDIwMjYgNDoyOCBQTQ0KPiBUbzogeW9jdG8tcGF0Y2hlc0Bs
aXN0cy55b2N0b3Byb2plY3Qub3JnDQo+IENjOiBXYW5nLCBNaW5neXUvzfUgw/nopCA8d2FuZ215
QGZ1aml0c3UuY29tPg0KPiBTdWJqZWN0OiBbeW9jdG8tcGF0Y2hlc10gW21ldGEtY2dsXSBbUEFU
Q0hdIGxheWVyLmNvbmY6IEFkZCB3cnlub3NlDQo+IA0KPiBGcm9tOiBXYW5nIE1pbmd5dSA8d2Fu
Z215QGZ1aml0c3UuY29tPg0KPiANCj4gTEFZRVJTRVJJRVNfQ09NUEFUOiBhZGQgd3J5bm9zZQ0K
PiANCj4gU2lnbmVkLW9mZi1ieTogV2FuZyBNaW5neXUgPHdhbmdteUBmdWppdHN1LmNvbT4NCj4g
LS0tDQo+ICBtZXRhLWNnbC1jb21tb24vY29uZi9sYXllci5jb25mIHwgMiArLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvbWV0YS1jZ2wtY29tbW9uL2NvbmYvbGF5ZXIuY29uZg0KPiBiL21ldGEtY2dsLWNvbW1vbi9j
b25mL2xheWVyLmNvbmYgaW5kZXggNTIyZTEyMS4uOGFjMjgxYiAxMDA2NDQNCj4gLS0tIGEvbWV0
YS1jZ2wtY29tbW9uL2NvbmYvbGF5ZXIuY29uZg0KPiArKysgYi9tZXRhLWNnbC1jb21tb24vY29u
Zi9sYXllci5jb25mDQo+IEBAIC0xMSw2ICsxMSw2IEBAIEJCRklMRV9QUklPUklUWV9jZ2wtY29t
bW9uID0gIjciDQo+IA0KPiAgTEFZRVJERVBFTkRTX2NnbC1jb21tb24gPSAiY29yZSBvcGVuZW1i
ZWRkZWQtbGF5ZXIgbmV0d29ya2luZy1sYXllcg0KPiBwZXJsLWxheWVyIGZpbGVzeXN0ZW1zLWxh
eWVyIHNlY3VyaXR5IHNlbGludXggeW9jdG8iDQo+IA0KPiAtTEFZRVJTRVJJRVNfQ09NUEFUX2Nn
bC1jb21tb24gPSAiaG9uaXN0ZXIga2lya3N0b25lIGxhbmdkYWxlIG1pY2tsZWRvcmUNCj4gbmFu
YmllbGQgc2NhcnRoZ2FwIHN0eWhlYWQgd2FsbmFzY2FyIHdoaW5sYXR0ZXIiDQo+ICtMQVlFUlNF
UklFU19DT01QQVRfY2dsLWNvbW1vbiA9ICJob25pc3RlciBraXJrc3RvbmUgbGFuZ2RhbGUgbWlj
a2xlZG9yZQ0KPiBuYW5iaWVsZCBzY2FydGhnYXAgc3R5aGVhZCB3YWxuYXNjYXIgd2hpbmxhdHRl
ciB3cnlub3NlIg0KPiANCj4gIHJlcXVpcmUgY29uZi9kaXN0cm8vaW5jbHVkZS9jZ2xfY29tbW9u
X3NlY3VyaXR5X2ZsYWdzLmluYw0KPiAtLQ0KPiAyLjQzLjANCj4gDQo+IA0KPiANCj4gLT0tPS09
LT0tPS09LT0tPS09LT0tPS0NCj4gTGlua3M6IFlvdSByZWNlaXZlIGFsbCBtZXNzYWdlcyBzZW50
IHRvIHRoaXMgZ3JvdXAuDQo+IFZpZXcvUmVwbHkgT25saW5lICgjMzYyMyk6DQo+IGh0dHBzOi8v
bGlzdHMueW9jdG9wcm9qZWN0Lm9yZy9nL3lvY3RvLXBhdGNoZXMvbWVzc2FnZS8zNjIzDQo+IE11
dGUgVGhpcyBUb3BpYzogaHR0cHM6Ly9saXN0cy55b2N0b3Byb2plY3Qub3JnL210LzExODY0Njc4
OC81OTc0OTQ2DQo+IEdyb3VwIE93bmVyOiB5b2N0by1wYXRjaGVzK293bmVyQGxpc3RzLnlvY3Rv
cHJvamVjdC5vcmcNCj4gVW5zdWJzY3JpYmU6DQo+IGh0dHBzOi8vbGlzdHMueW9jdG9wcm9qZWN0
Lm9yZy9nL3lvY3RvLXBhdGNoZXMvbGVhdmUvMTM2MTQyNzEvNTk3NDk0Ni8xOTAyOA0KPiAzMTA2
Ni94eXp6eSBbd2FuZ215QGZ1aml0c3UuY29tXQ0KPiAtPS09LT0tPS09LT0tPS09LT0tPS09LQ0K
PiANCg0K

