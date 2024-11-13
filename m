Return-Path: <pbe@trifork.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77032D41C27
	for <webhook@archiver.kernel.org>; Wed, 13 Nov 2024 09:52:40 +0000 (UTC)
Received: from mxout02.netic.dk (mxout02.netic.dk [77.243.50.218])
 by mx.groups.io with SMTP id smtpd.web11.8284.1731491555667261998
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 13 Nov 2024 01:52:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@trifork.com header.s=dkim header.b=K2q/m2pq;
 spf=pass (domain: trifork.com, ip: 77.243.50.218, mailfrom: pbe@trifork.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=trifork.com; i=@trifork.com; l=3302; q=dns/txt;
  s=dkim; t=1731491556; x=1763027556;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  z=From:=20"Paul=20M.=20Bendixen"=20<pbe@trifork.com>|To:
   =20"yocto-patches@lists.yoctoproject.org"=0D=0A=09<yocto-
   patches@lists.yoctoproject.org>|Subject:=20Re:=20[yocto-p
   atches]=20[meta-rockchip]=20[PATCH]=20SOQuartz:=20add
   |Date:=20Wed,=2013=20Nov=202024=2009:52:33=20+0000
   |Message-ID:=20<bee5d935-5f5b-4347-90c0-15462e58c4ae@trif
   ork.com>|References:=20<2f52ba6e-4709-4b66-b23d-838cbf8d9
   d3e@trifork.com>=0D=0A=20<2664ede8-d88f-446f-9419-6372fda
   41361@cherry.de>|In-Reply-To:=20<2664ede8-d88f-446f-9419-
   6372fda41361@cherry.de>|Content-ID:=20<F7AED4D03EB1C84383
   E714E0E4D6E249@trifork.com>|Content-Transfer-Encoding:=20
   base64|MIME-Version:=201.0;
  bh=ebhQjeLGOfsyRBuA9egJlIQtPJHLJXVKUCUl+m7eRpE=;
  b=K2q/m2pqHwT/gsha+4TZqOY5RPkngr0SVvbLi1ioFoaj9aJgQpsSWzdR
   HBC+MG9PYV2e11kH0jYWIhgXunCA74x2uXRAjXbed35lq0iPFy+vQKL6B
   IlT9m+7aa9D1TfON2W24WvRtpx6hbXiFg4WvlAM5xoorfyMr4GPZW4YFQ
   c=;
X-CSE-ConnectionGUID: zwPPx0WWQJmmOsCE77IGXA==
X-CSE-MsgGUID: THllm6bTQZCJlvCP1r7cdQ==
IronPort-Data: A9a23:rhg74q4AJY2NRlxSldthhAxRtGfGchMFZxGqfqrLsTDasY5as4F+v
 mYYCD+Aa6qMa2r3ct4lad+09UkBvcXcy4RmHQtopHw0Eysa+MHIO4+Ufxz6V8+wwm0vb67FA
 +E2MISowBUcFyeEzvuVGuG/6yE6jefQG+KU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjgmQc3l48sfrZ9Eo25a+q4Vv0g3RlDRx1lA6H/5UqJMJHTU2BByOQapVZGOe8W
 9HCwNmRlkvF/w0gA8+Sib3ydEsHWNb6ZWBiXVIPBsBOKjAbzsAD+v5T2Mg0MC+7uB3Q9zxF8
 +ihgLTrIesf0g0gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCAWluVbD09NqbDklc6
 sQgOGgyUSmhgueR25mWFbZNqfQKeZyD0IM34hmMzBn1LtMPYLSbEuPL48NVxi8qh9tDW/rdD
 yYbQWA3NE2SOkETagVNVMJsl7f61COnK28H+Tp5poJui4TX5BR73ZDxKtvbfcaJA85Smy50o
 0qWpjymUkxBa7RzzxK50naog7HFoRrJc6AWCpaAr+Q1i1Gqkzl75Bo+EAHTTeOCol+5UM5Yb
 lQd5iEuoLMa8E2wUsK7ThqzvHmcpBkeVtFMVeog52mwJrH87wWcD2kAFm8Hado6udUuXz0x2
 xmFnLsFGABSjVFcclrFnp/8kN94EXF9wbMqDcPccTY43g==
IronPort-HdrOrdr: A9a23:4MHNdqmjVPCA1BwnjrhGcgjWAfjpDfLK3DAbv31ZSRFFG/Gwv9
 2q2M4W0gKxtzYYMUtQ++xoWZPufZq4z/RICOYqUYtKIzOWwldAQLsSlLcKhgeQYxEWldQy6U
 4DSdkZNDSqNykesS+S2mDRLz9j+qjlzEnPv5a7854Hd3AQV0gP1WpEIzfeOlByTBNdBZI/UL
 6V5s8Cgza7Y3wYYoCaCxA+PtTrlpniiZfvewQHDxlizAGPiHeU87b8CRCTwxcZVHduzN4ZkV
 QsnWTCl8KeWqGAoSPh6w==
X-Talos-CUID: 9a23:CDiiQ2BHP7FGkv36Ezt4zHYEQv8aS1/YyVDLCGLnVkdGeJTAHA==
X-Talos-MUID: 9a23:vxo2Ywmvyo+t2J9/aLQEdnpeFMNs5vqkNHk/urcCpeK8bDYvMDuk2WE=
X-IronPort-AV: E=Sophos;i="6.12,150,1728943200"; 
   d="scan'208";a="81078537"
Received: from DKMAIL03.interprise.dk (2001:1448:248:6e::110:72) by
 DKMAIL09.interprise.dk (2001:1448:248:c8::200:79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 13 Nov 2024 10:52:32 +0100
Received: from DKMAIL03.interprise.dk (2001:1448:248:6e::110:72) by
 DKMAIL03.interprise.dk (2001:1448:248:6e::110:72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Nov 2024 10:52:33 +0100
Received: from DKMAIL03.interprise.dk ([fe80::7100:ad8c:7536:e0a]) by
 DKMAIL03.interprise.dk ([fe80::7100:ad8c:7536:e0a%4]) with mapi id
 15.02.1544.011; Wed, 13 Nov 2024 10:52:33 +0100
From: "Paul M. Bendixen" <pbe@trifork.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] SOQuartz: add
Thread-Topic: [yocto-patches] [meta-rockchip] [PATCH] SOQuartz: add
Thread-Index: AQHbNathMbaEa6iSeUu4tjQXpk56MbK048SAgAADp4A=
Date: Wed, 13 Nov 2024 09:52:33 +0000
Message-ID: <bee5d935-5f5b-4347-90c0-15462e58c4ae@trifork.com>
References: <2f52ba6e-4709-4b66-b23d-838cbf8d9d3e@trifork.com>
 <2664ede8-d88f-446f-9419-6372fda41361@cherry.de>
In-Reply-To: <2664ede8-d88f-446f-9419-6372fda41361@cherry.de>
Accept-Language: da-DK, en-US
Content-Language: da-DK
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [152.115.32.67]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7AED4D03EB1C84383E714E0E4D6E249@trifork.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 Nov 2024 09:52:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/794

T24gMTMuMTEuMjAyNCAxMC4zOSwgUXVlbnRpbiBTY2h1bHogdmlhIGxpc3RzLnlvY3RvcHJvamVj
dC5vcmcgd3JvdGU6DQo+IEhpIFBhdWwsDQo+DQo+IFBsZWFzZSBkbyBub3QgYXR0YWNoIHRoZSBw
YXRjaCB0byB0aGUgbWFpbCBidXQgaGF2ZSB0aGUgcGF0Y2ggYmUgdGhlIA0KPiBtYWlsICh0aGUg
Y29tbWl0IHRpdGxlIHRoZSBzdWJqZWN0IG9mIHRoZSBtYWlsIGFuZCB0aGUgZGlmZiB0aGUgYm9k
eSANCj4gb2YgdGhlIG1haWwpLCB0aGlzIHdheSB3ZSBjYW4gcHJvdmlkZSBmZWVkYmFjayBpbmxp
bmUgYW5kIGRvIG5vdCBuZWVkIA0KPiB0byBvcGVuIGFuZCBkb3dubG9hZCBhIGZpbGUuDQo+DQpP
ayB3aWxsIGRvLg0KDQo+IGMuZi4gDQo+IGh0dHBzOi8vZG9jcy55b2N0b3Byb2plY3Qub3JnL2Nv
bnRyaWJ1dG9yLWd1aWRlL3N1Ym1pdC1jaGFuZ2VzLmh0bWwjc2VuZGluZy1wYXRjaGVzLXZpYS1l
bWFpbA0KPg0KPiBXS1NfRklMRSA/PSAicm9ja2NoaXAud2tzIg0KPg0KPiBpcyB1bm5lY2Vzc2Fy
eSBiZWNhdXNlIGl0J3MgYWxyZWFkeSB0aGUgZGVmYXVsdCBpbiByazM1NjYuaW5jIHRoYXQgeW91
IA0KPiBjaW5sdWRlLg0KPg0KQ29vbCwgdGhhbmtzLiBJIG1pc3NlZCB0aGF0DQo+DQo+IE1heWJl
IHdlIGFsc28gd2FudA0KPg0KPiBNQUNISU5FX0VYVFJBX1JSRUNPTU1FTkRTICs9ICJrZXJuZWwt
bW9kdWxlcyINCj4NCj4gaW4gdGhlcmUgc28gdGhhdCBrZXJuZWwgbW9kdWxlcyBhcmUgaW5zdGFs
bGVkIGJ5IGRlZmF1bHQgaW4gDQo+IG5vbi1jb3JlLWltYWdlLW1pbmltYWwgaW1hZ2VzPw0KPg0K
WWVzLCBidXQgdGhlIGZ1bmN0aW9uaW5nIG9mIHRoZSBtYWNoaW5lIGRvZXMgbm90IGRlcGVuZCBv
biBtb2R1bGVzIGluIA0KdGhlIGRlZmF1bHQgY2FzZSwgc28gSSB0aG91Z2h0IGl0IGJldHRlciB0
byBvbWl0IGl0IGluIHRoZSBiYXNlIGNhc2U/DQoNCj4gQ291bGQgYmUgbmljZSB0byBhZGQgYSBs
aW5rIHRvIHRoZSBTT1F1YXJ0eiBwcm9kdWN0IHBhZ2UgYXMgd2VsbCA6KQ0KPg0KWWVzLCB0aGlz
IGlzIGFuIG92ZXJzaWdodCBvbiBteSBwYXJ0Lg0KDQo+IEkgc2VlIHRoYXQgdGhlcmUgYXJlIChj
dXJyZW50bHkpIHRocmVlIHBvc3NpYmxlIG1vdGhlcmJvYXJkcyBmb3IgdGhhdCANCj4gU29NLCBD
TTQtSU8sIE1vZGVsIEEgYW5kIEJsYWRlLiBJIGRvbid0IGtub3cgaG93IFRyZXZvciB3YW50cyB0
byANCj4gaGFuZGxlIHRoYXQgdGhvdWdoPw0KPiAtIERpZmZlcmVudCBtYWNoaW5lIGNvbmZpZz8g
SWYgc28sIHRoZSBtYWNoaW5lIGNvbmYgZmlsZSBzaG91bGQgDQo+IHByb2JhYmx5IGJlIG5hbWVk
IGFmdGVyIHRoZSBmdWxsIGNvbmZpZyBhbmQgbm90IGp1c3QgdGhlIFNvTS4NCj4gLSBNdWx0aXBs
ZSBEZXZpY2UgVHJlZXMgaW5jbHVkZWQgaW4gdGhlIGltYWdlPyBUaGVuIHdlIG5lZWQgDQo+IEtF
Uk5FTF9ERVZJQ0VUUkVFIHdpdGggdGhlIHRocmVlIERUQnMgaW4gdGhlcmUuDQo+DQo+IENvbnNp
ZGVyaW5nIHRoYXQgd2UgaGF2ZSBhIGRpZmZlcmVudCBkZWZjb25maWcgZm9yIGVhY2ggdmFyaWFu
dCBpbiANCj4gVS1Cb290LCBJIHdvdWxkIGxlYW4gbW9yZSB0b3dhcmRzIHRoZSBmaXJzdCBvcHRp
b24uIERvIHlvdSBrbm93IGlmIA0KPiB0aGVyZSdzIGFueSB3YXkgdG8gZGV0ZWN0IHRvIHdoaWNo
IG1vdGhlcmJvYXJkIHRoZSBTb00gaXMgY29ubmVjdGVkIGF0IA0KPiBydW50aW1lPyBNYXliZSB3
ZSBjb3VsZCBoYXZlIG9uZSBVLUJvb3QgYmluYXJ5IGZvciBhbGwgdGhyZWUgdmFyaWFudHMgDQo+
IGFuZCBsb2FkIHRoZSBwcm9wZXIgRFRCIGF0IHJ1bnRpbWUsIGJhc2VkIG9uIHdoYXQgd2UgY2Fu
IGRldGVjdC4NCj4NClRvIG15IGtub3dsZWRnZSB0aGVyZSBpcyBubyB3YXkgdG8gZGV0ZXJtaW5l
IHdoYXQgYmFzZWJvYXJkIGlzIHVzZWQgYW5kIA0KaXQgaXMgYWxzbyB2ZXJ5IGxpa2VseSAoc2lu
Y2UgdGhpcyBpcyB3aGF0IHdlIGFyZSBkb2luZyA7KSApDQp0aGF0IG9uZSB3b3VsZCB1c2UgdGhl
IG1vZHVsZSBhcyBhIHN0YXJ0aW5nIHBvaW50IGFuZCBjcmVhdGUgb25lcyBvd24gDQpiYXNlYm9h
cmQuDQoNCkluIHRoaXMgY2FzZSBvbmUgd291bGQgaGF2ZSB0byByZWNyZWF0ZSB0aGUgbWFjaGlu
ZSBpbiB0aGVpciBvd24gc2V0dXAgDQppbnN0ZWFkIG9mIGp1c3QgYnVpbGRpbmcgb24gdGhpcyBv
bmUuDQoNCkkgZ3Vlc3Mgd2hhdCBJJ2QgZ28gZm9yIHdvdWxkIGJlIHRvIGhhdmUgdGhlIFNvTSBt
YWNoaW5lIGFuZCBwb3NzaWJseSANCmhhdmUgZnVydGhlciBtYWNoaW5lcyBmb3IgZWFjaCBtb2Rl
bCAodGhlcmUgYXJlIF9hIGxvdF8gbW9yZSB0aGFuIHRocmVlKSANCmJhc2VkIG9uwqAgdGhpcyBv
bmUgb3ZlcmxvYWRpbmcgdGhlIGRlZmNvbmZpZy4NCg0KPiBDaGVlcnMsDQo+IFF1ZW50aW4NCg0K
VGhhbmtzLA0KUGF1bA0KDQo=

