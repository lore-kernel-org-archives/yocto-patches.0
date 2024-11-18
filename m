Return-Path: <pbe@trifork.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165B9D43FEB
	for <webhook@archiver.kernel.org>; Mon, 18 Nov 2024 08:04:46 +0000 (UTC)
Received: from mxout01.netic.dk (mxout01.netic.dk [77.243.50.208])
 by mx.groups.io with SMTP id smtpd.web11.36338.1731917074892799294
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Nov 2024 00:04:37 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@trifork.com header.s=dkim header.b=AGfsw/4n;
 spf=pass (domain: trifork.com, ip: 77.243.50.208, mailfrom: pbe@trifork.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=trifork.com; i=@trifork.com; l=6664; q=dns/txt;
  s=dkim; t=1731917075; x=1763453075;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  z=From:=20"Paul=20M.=20Bendixen"=20<pbe@trifork.com>|To:
   =20"yocto-patches@lists.yoctoproject.org"=0D=0A=09<yocto-
   patches@lists.yoctoproject.org>|Subject:=20Re:=20[yocto-p
   atches]=20[meta-rockchip]=20[PATCH]=20SOQuartz:=20add
   |Date:=20Mon,=2018=20Nov=202024=2008:04:30=20+0000
   |Message-ID:=20<80bd8690-9f33-4fa1-b7cd-054e2bb8b1ab@trif
   ork.com>|References:=20<3608313a-2d69-435d-807f-3dceb6326
   ca8@trifork.com>=0D=0A=20<fb559dfd-97a7-43ff-812f-ed20952
   fc526@cherry.de>|In-Reply-To:=20<fb559dfd-97a7-43ff-812f-
   ed20952fc526@cherry.de>|Content-ID:=20<EF95A5A46D143D419D
   B1ED21EA1069FC@trifork.com>|Content-Transfer-Encoding:=20
   base64|MIME-Version:=201.0;
  bh=Q71KrzGTuQQbOB8jR3T6T2/PaK6z4NZiAGJSr/l05HE=;
  b=AGfsw/4nTRV2fUh1sPs6F7gjxhdcRXz0CTXaoKKrCTSt/x7w4Yy4VnS4
   LMbPBF0fLDMGorPfM2CTDeyFktLGBTCaZ52cDsRdGI6KBsCSvKYKp48vs
   mbKSri4WZWVuV5k3XFcfixuzSj8XHtFxuilOjs58jqRIT4pYopL8moaKO
   A=;
X-CSE-ConnectionGUID: ggtNdDEBSz6v+wGjusxiIg==
X-CSE-MsgGUID: Rdz0oLfbTFSakRSab3x1pg==
IronPort-Data: A9a23:tsTr+qxHsn9kE9HTfkB6t+doxyrEfRIJ4+MujC+fZmUNrF6WrkVUm
 DBKCzyAbvyNajH2c9F1aoTgoEsA78WDz9QyTwpprC00HyNBpPSeCIXCJC8cHc8ywu4v7q5Dx
 59DAjUVBJlsFhcwnj/0bP656yE6jfzQLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgb/s9JIGjhMsf7a8Uow5KiaVA4w5TTSW9ga5TcyqFFFVPrzFYnpR1PkT49dGPKNR
 uqr5NmR4mPD8h4xPcium7D9f1diaua60d+m0yc+twCK23CulwRqukoJHKN0hXR/0l1lq+tMJ
 OBl7vRcf+uJ0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL/hGVCkL0YMkFulfDm5S0
 /A0BRo2fE6dxP2Zwq+gWuhNiZF2RCXrFNt3VnBI4RL8JNcCGcGFQqPW6MVAxjYri4ZCHp4yZ
 eJDMWI2Pk2cP00dYAtHWpluzrXy3iGtLGwwRFG9/MLb50DLxgFZzKLsPt3PeZqBQsA9ckOw9
 jqbrz+pU09y2Nq38zaXqnWIiOXzsxjyW7gpHbfj5qdyjwjGroAUIFhMPbehmtGojUWiXJdHI
 lAf+ic1hawz71CwCMj6VAG/uGSDvBMXR5xXCeJS1e2W4qbX5g+YAjBVCD9HdNE8rNU3XjFs2
 lzhc87VOAGDeYa9ERq1nop4ZxvrUcTJBQfuvRM5cDY=
IronPort-HdrOrdr: A9a23:G9SiHaCiKgmsG4XlHemO55DYdb4zR+YMi2TDgXoBLiC9E/b1qy
 nKpp8mPHDP5wr5NEtPpTn4AtjlfZqEz+8R3WByB9eftXjd2VdAd7sSi7cKqgeIc0eSygc679
 YDT0EUMqySMbEVt7eA3CCIV/om3dmb4OSJqI7lvg1QpNhRGthdBtFCe36mLnE=
X-Talos-CUID: 9a23:kTkvoW5infKQlCn8+dss+0EIPMwJX1fm3inOYFCXC3tyWLy0RgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AILPEbQ6boQX8q55B2iXaw61cxoxS77b2D2QDm6k?=
 =?us-ascii?q?ogMCHDxd5MWyN1Sy4F9o=3D?=
X-IronPort-AV: E=Sophos;i="6.12,163,1728943200"; 
   d="scan'208";a="80583896"
Received: from DKMAIL03.interprise.dk (2001:1448:248:6e::110:72) by
 DKMAIL09.interprise.dk (2001:1448:248:c8::200:79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 18 Nov 2024 09:04:30 +0100
Received: from DKMAIL03.interprise.dk (2001:1448:248:6e::110:72) by
 DKMAIL03.interprise.dk (2001:1448:248:6e::110:72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Nov 2024 09:04:30 +0100
Received: from DKMAIL03.interprise.dk ([fe80::7100:ad8c:7536:e0a]) by
 DKMAIL03.interprise.dk ([fe80::7100:ad8c:7536:e0a%4]) with mapi id
 15.02.1544.011; Mon, 18 Nov 2024 09:04:30 +0100
From: "Paul M. Bendixen" <pbe@trifork.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] SOQuartz: add
Thread-Topic: [yocto-patches] [meta-rockchip] [PATCH] SOQuartz: add
Thread-Index: AQHbN23Nnct2ufJjiky2t/PBq2jjTbK4XluAgARDAwA=
Date: Mon, 18 Nov 2024 08:04:30 +0000
Message-ID: <80bd8690-9f33-4fa1-b7cd-054e2bb8b1ab@trifork.com>
References: <3608313a-2d69-435d-807f-3dceb6326ca8@trifork.com>
 <fb559dfd-97a7-43ff-812f-ed20952fc526@cherry.de>
In-Reply-To: <fb559dfd-97a7-43ff-812f-ed20952fc526@cherry.de>
Accept-Language: da-DK, en-US
Content-Language: da-DK
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [152.115.32.67]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF95A5A46D143D419DB1ED21EA1069FC@trifork.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Nov 2024 08:04:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/815

T24gMTUuMTEuMjAyNCAxNS41OSwgUXVlbnRpbiBTY2h1bHogdmlhIGxpc3RzLnlvY3RvcHJvamVj
dC5vcmcgd3JvdGU6DQo+IEhpIFBhdWwsDQo+DQo+IFBsZWFzZSB2ZXJzaW9uIHlvdXIgcGF0Y2hl
cyB3aGVuIHNlbmRpbmcgKHVzdWFsbHkgLXYgTiB3aXRoIE4gYmVpbmcgDQo+IHRoZSBwcm9wZXIg
dmVyc2lvbiBudW1iZXIgc2hvdWxkIGJlIGVub3VnaCksIGEgdk4gd2lsbCB0aGVuIGFwcGVhciAN
Cj4gbmV4dCB0byBbUEFUQ0ggaW4gdGhlIG1haWwgc3ViamVjdC4gVGhhdCBpcyBuZWNlc3Nhcnkg
Zm9yIG1haW50YWluZXJzIA0KPiBhbmQgcmV2aWV3ZXJzIHRvIG5vdCBoYXZlIHRvIGZpZ3VyZSBv
dXQgd2hpY2ggb25lIG1haWwgaXMgdGhlIGxhdGVzdCANCj4gYW5kIGdyZWF0ZXN0IHBhdGNoIHlv
dSd2ZSBzZW50IGFuZCB0aGV5IHNob3VsZCByZXZpZXcgb3IgbWVyZ2UuDQo+DQpPaywgbWFrZXMg
c2Vuc2UsIGNvdWxkbid0IGZpbmQgdGhhdCBhbnl3aGVyZSBidXQgd2lsbCBjaGFuZ2UgZm9yIG5l
eHQgdGltZS4NCg0KPiBJIGNhbiBhbHNvIHJlY29tbWVuZCB1c2luZyBiNCB3aGljaCBkb2VzIGEg
bG90IG9mIHRoaW5ncyBhdXRvbWF0aWNhbGx5IA0KPiBmb3IgeW91IDopDQpUaGFua3MgZm9yIHRo
ZSB0aXAsIEknbGwgY2hlY2sgaXQgb3V0Lg0KPg0KPiBTZWUgY29tbWVudCBpbmxpbmUuDQo+DQo+
IE9uIDExLzE1LzI0IDM6NTEgUE0sIFBhdWwgTS4gQmVuZGl4ZW4gdmlhIGxpc3RzLnlvY3RvcHJv
amVjdC5vcmcgd3JvdGU6DQo+PiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIA0KPj4g
cGJlPXRyaWZvcmsuY29tQGxpc3RzLnlvY3RvcHJvamVjdC5vcmcuIExlYXJuIHdoeSB0aGlzIGlz
IGltcG9ydGFudCANCj4+IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlm
aWNhdGlvbiBdDQo+Pg0KPj4gVGhlIFNPUXVhcnR6IGlzIGEgUkszNTY2IGJhc2VkIGNvbXB1dGUg
bW9kdWxlIGFuZCBwYXJ0cyBvZiBRdWFydHo2NCANCj4+IHNlcmllcw0KPj4gVGhlIE1vZGVsLUEg
YmFzZSBib2FyZCBpcyBvbmUgcG9zc2libGUgYm9hcmQgdGhhdCBzdXBwb3J0cyBpdA0KPj4NCj4+
IFdlYnNpdGU6DQo+PiDCoMKgwqDCoMKgIGh0dHBzOi8vcGluZTY0Lm9yZy9kZXZpY2VzL3NvcXVh
cnR6Lw0KPj4gV2lraToNCj4+IMKgwqDCoMKgwqAgaHR0cHM6Ly93aWtpLnBpbmU2NC5vcmcvd2lr
aS9TT1F1YXJ0eg0KPj4NCj4+IFNwZWNzOg0KPj4gLSBSb2NrY2hpcCBSSzM1NjYgUXVhZC1jb3Jl
IEFSTSBDb3J0ZXgtQTU1QDEuOEdIeg0KPj4gLSBNYWxpLUc1MiAyRUUgQmlmcm9zdCBHUFVAODAw
TUh6DQo+PiAtIFJhc3BiZXJyeSBQaSA0IENNIGZvcm0gZmFjdG9yDQo+PiAtIFJBTSBNZW1vcnkg
VmFyaWFudHM6IDJHQiwgNEdCLCA4R0IgTFBERFI0Lg0KPj4gLSBvcHRpb25hbCBlTU1DIGZyb20g
OEdCIHRvIDEyOEdCDQo+PiAtIG9wdGlvbmFsIDEyOE1iIFNQSSBGbGFzaA0KPj4gLSAxMC8xMDAv
MTAwME1icHMgRXRoZXJuZXQNCj4+IC0gV2lGaSA4MDIuMTEgYi9nL24vYWMgd2l0aCBCbHVldG9v
dGggNS4wDQo+Pg0KPj4gRXhwb3NlZCBwcmVyaXBoZXJhbHM6DQo+PiAtIDF4IEhETUkNCj4+IC0g
MnggRFNJDQo+PiAtIDF4IGVEUA0KPj4gLSAxeCBMVkRTDQo+PiAtIDF4IENTSSA0LWxpbmUNCj4+
IC0gMXggRXRoZXJuZXQNCj4+IC0gMXggVVNCIDIuMCBPVEcNCj4+IC0gMXggU0QNCj4+IC0gMXgg
UENJZSAxLWxpbmUNCj4+IC0gMjh4IEdQSU8NCj4+DQo+PiBNb2RlbC1BIGJhc2Vib2FyZDoNCj4+
IC0gMXggbWljcm9TRCAtIGJvb3RhYmxlDQo+PiAtIDF4IEhETUkgUG9ydA0KPj4gLSAyeCBVU0Ig
QSAyLjAgSG9zdA0KPj4gLSAxeCBVU0IgQyAyLjAgSG9zdA0KPj4gLSAxeCA1IHBpbiBVU0IgZXhw
YW5zaW9uDQo+PiAtIDF4IEV0aGVybmV0IHcuIFBvRQ0KPj4gLSAxeCA0MCBwb2xlIFBpMiBjb21w
YXRpYmxlIEdQSU8NCj4+IC0gMXggTWlQaS1DU0kgMiBsYW5lcw0KPj4gLSAxeCBNaVBpLUNTSSA0
IGxhbmVzDQo+PiAtIDF4IE1pUGktRFNJIDIgbGFuZXMNCj4+IC0gMXggTWlQaS1EU0kgNCBsYW5l
cw0KPj4gLSAxeCBQQ0llIG9wZW4gZW5kZWQNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQYXVsIE0u
IEIuIEJlbmRpeGVuIDxwYmVAdHJpZm9yay5jb20+DQo+PiAtLS0NCj4+IMKgwqAgUkVBRE1FwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPj4gwqDCoCBjb25mL21hY2hpbmUvaW5jbHVkZS9zb3F1
YXJ0ei5pbmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE1ICsrKysrKysrKysrKysrKw0KPj4gwqDC
oCBjb25mL21hY2hpbmUvc29xdWFydHotbW9kZWwtYS5jb25mwqDCoMKgwqDCoMKgwqDCoMKgIHwg
MTIgKysrKysrKysrKysrDQo+PiDCoMKgIHJlY2lwZXMta2VybmVsL2xpbnV4L2xpbnV4LXlvY3Rv
XyUuYmJhcHBlbmQgfMKgIDEgKw0KPj4gwqDCoCA0IGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlv
bnMoKykNCj4+IMKgwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGNvbmYvbWFjaGluZS9pbmNsdWRlL3Nv
cXVhcnR6LmluYw0KPj4gwqDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgY29uZi9tYWNoaW5lL3NvcXVh
cnR6LW1vZGVsLWEuY29uZg0KPj4NCj4+IGRpZmYgLS1naXQgYS9SRUFETUUgYi9SRUFETUUNCj4+
IGluZGV4IDA5Zjg2OTEuLjg1YWIyZWMgMTAwNjQ0DQo+PiAtLS0gYS9SRUFETUUNCj4+ICsrKyBi
L1JFQURNRQ0KPj4gQEAgLTQ1LDYgKzQ1LDcgQEAgU3RhdHVzIG9mIHN1cHBvcnRlZCBib2FyZHM6
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJvY2stcGktZQ0KPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByb2NrLXBpLXMNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcm9jazY0DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzb3F1YXJ0eiAob24gbW9k
ZWwgQSBiYXNlIGJvYXJkKQ0KPj4NCj4+IMKgwqDCoMKgwqDCoCBidWlsZHM6DQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAzMi1iaXQ6DQo+PiBkaWZmIC0tZ2l0IGEvY29uZi9tYWNoaW5lL2luY2x1
ZGUvc29xdWFydHouaW5jDQo+PiBiL2NvbmYvbWFjaGluZS9pbmNsdWRlL3NvcXVhcnR6LmluYw0K
Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAuLjY3MTRlZmMNCj4+IC0t
LSAvZGV2L251bGwNCj4+ICsrKyBiL2NvbmYvbWFjaGluZS9pbmNsdWRlL3NvcXVhcnR6LmluYw0K
Pj4gQEAgLTAsMCArMSwxNSBAQA0KPj4gKyNDb3B5cmlnaHQgKEMpIFRyaWZvcmsgQS9TIDIwMjQN
Cj4+ICsjIFJlbGVhc2VkIHVuZGVyIHRoZSBNSVQgbGljZW5zZSAoc2VlIENPUFlJTkcuTUlUIGZv
ciB0aGUgdGVybXMpDQo+PiArDQo+PiArIyBDb21tb24gb3ZlcnJpZGUgZm9yIGJhc2luZyBhIFNP
UXVhcnR6IGRlc2lnbiBvbg0KPj4gKyMgaHR0cHM6Ly93aWtpLnBpbmU2NC5vcmcvd2lraS9TT1F1
YXJ0eg0KPj4gKw0KPj4gK01BQ0hJTkVPVkVSUklERVMgPS4gInNvcXVhcnR6OiINCj4+ICsNCj4+
ICtyZXF1aXJlIGNvbmYvbWFjaGluZS9pbmNsdWRlL3JrMzU2Ni5pbmMNCj4+ICsNCj4+ICsjIEEg
bWFjaGluZSB1c2luZyB0aGlzIGJhc2Vib2FyZCBjb3VsZCB1c2UgdGhlc2Ugb3B0aW9ucyBvciBv
dmVybG9hZCANCj4+IHRoZW0NCj4NCj4gSSB0aGluayBpdCBpcyBhY3R1YWxseSByZXF1aXJlZCB0
byBzZXQgdGhvc2UgdmFyaWFibGVzIGluIGEgbWFjaGluZSANCj4gY29uZmlndXJhdGlvbiBmaWxl
IHNpbmNlIG5vdGhpbmcgZWxzZSBkZWZpbmVzIGEgZGVmYXVsdD8gQW5kIHNpbmNlIA0KPiB0aG9z
ZSBhcmUgbm93IGNvbW1lbnRlZCBvdXQgKGFzIHRoZXkgc2hvdWxkKS4NCj4NCj4gU28gSSdtIGp1
c3Qgbml0cGlja2luZyBvbiB0aGUgcGhyYXNpbmcgaGVyZS4gSSB3b3VsZG4ndCBuZWNlc3Nhcmls
eSANCj4gc2VuZCBhIG5ldyB2ZXJzaW9uIGp1c3QgZm9yIHRoYXQsIGJ1dCBtYXliZSBUcmV2b3Ig
d2lsbCBoYXZlIGEgDQo+IGRpZmZlcmVudCBvcGluaW9uIChvciBmaXggaXQgd2hlbiBtZXJnaW5n
KS4NCj4NCkVuZ2xpc2ggaXMgbm90IG15IGZpcnN0IGxhbmd1YWdlLCBidXQgSSB3YXMgdHJ5aW5n
IHRvIGNvbnZleSB0aGF0IGlmIA0Kc3RhcnRpbmcgYSBuZXcgYm9hcmQsIHRoZXNlIGNvdWxkIGJl
IHVzZWQgYXMgYSBzdGFydGluZyBwb2ludC4NCkNvdWxkIHlvdSBzdWdnZXN0IHdvcmRpbmcgdGhh
dCB3b3VsZCBjb252ZXkgdGhhdCBtb3JlIGNsZWFybHk/IChtYXliZSBJIA0KanVzdCBkaWQpDQoN
Cj4gTG9va3MgZ29vZCB0byBtZSBvdGhlcndpc2UhDQo+DQo+IFJldmlld2VkLWJ5OiBRdWVudGlu
IFNjaHVseiA8cXVlbnRpbi5zY2h1bHpAY2hlcnJ5LmRlPg0KPg0KPiBUaGFua3MhDQo+IFF1ZW50
aW4NCj4NCj4NCj4gLT0tPS09LT0tPS09LT0tPS09LT0tPS0NCj4gTGlua3M6IFlvdSByZWNlaXZl
IGFsbCBtZXNzYWdlcyBzZW50IHRvIHRoaXMgZ3JvdXAuDQo+IFZpZXcvUmVwbHkgT25saW5lICgj
ODEwKTogDQo+IGh0dHBzOi8vbGlzdHMueW9jdG9wcm9qZWN0Lm9yZy9nL3lvY3RvLXBhdGNoZXMv
bWVzc2FnZS84MTANCj4gTXV0ZSBUaGlzIFRvcGljOiBodHRwczovL2xpc3RzLnlvY3RvcHJvamVj
dC5vcmcvbXQvMTA5NTUxNDE5LzkxMTYwNzENCj4gR3JvdXAgT3duZXI6IHlvY3RvLXBhdGNoZXMr
b3duZXJAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZw0KPiBVbnN1YnNjcmliZTogDQo+IGh0dHBzOi8v
bGlzdHMueW9jdG9wcm9qZWN0Lm9yZy9nL3lvY3RvLXBhdGNoZXMvbGVhdmUvMTM3NDE5MDIvOTEx
NjA3MS8xMjUzNjAzMjg2L3h5enp5IA0KPiBbcGJlQHRyaWZvcmsuY29tXQ0KPiAtPS09LT0tPS09
LT0tPS09LT0tPS09LQ0KPg0KPg0KDQo=

