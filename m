Return-Path: <pbe@trifork.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEA7D41C1E
	for <webhook@archiver.kernel.org>; Wed, 13 Nov 2024 09:07:00 +0000 (UTC)
Received: from mxout02.netic.dk (mxout02.netic.dk [77.243.50.218])
 by mx.groups.io with SMTP id smtpd.web11.7667.1731488815538113761
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 13 Nov 2024 01:06:56 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@trifork.com header.s=dkim header.b=gT3t9ZDp;
 spf=pass (domain: trifork.com, ip: 77.243.50.218, mailfrom: pbe@trifork.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=trifork.com; i=@trifork.com; l=4777; q=dns/txt;
  s=dkim; t=1731488816; x=1763024816;
  h=from:to:subject:date:message-id:mime-version;
  z=From:=20"Paul=20M.=20Bendixen"=20<pbe@trifork.com>|To:
   =20"yocto-patches@lists.yoctoproject.org"=0D=0A=09<yocto-
   patches@lists.yoctoproject.org>|Subject:=20[meta-rockchip
   ]=20[PATCH]=20SOQuartz:=20add|Date:=20Wed,=2013=20Nov=202
   024=2009:06:53=20+0000|Message-ID:=20<2f52ba6e-4709-4b66-
   b23d-838cbf8d9d3e@trifork.com>|MIME-Version:=201.0;
  bh=AJtchaSIxCl8RIfWcYlUBJcKqqq0sWwW6MiseIQ8i+o=;
  b=gT3t9ZDphVT57v/CtHbSpzuafryslnugiZLvjunk7J4ZuRrGH7YPEGT9
   nWARi1L9G5SkMnqDSw2j4yUjVjmeUIixgeCaRPj8RlKur62JgnFy1+NKJ
   D/CY6FA0uknld/fRgEWXtkegiBbZRyZjGBo0YLBoRD8199+O2g5E7Y6ua
   E=;
X-CSE-ConnectionGUID: 6Knz9YYMSTCO4XvsbUXsow==
X-CSE-MsgGUID: qYhhsgFuRdiw50CH0UgkrA==
IronPort-Data: A9a23:xVBb4a3ZnGNA/umxo/bD5Yxwkn2cJEfYwER7XKvMYLTBsI5bpzFSn
 WFOUGDSafzYZmb8Kdp/bd62o0JUvZ6BztdgSFRrqSg9HnlHl5HIVI+TRqvS04N+DSFhoGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9T8kiPngqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvU0
 T/Ji5OZYQXNNwJcaDpOt/va8Ug35ZwehRtD1rAATaES1LPhvylNZH4vDfnZB2f1RIBSAtm7S
 47rpJml/nnU9gsaEdislLD2aCUiGtY+6iDX1xK684D76vRzjnRaPpQTbZLwWm8O49m9pO2d/
 f0W3XCGpafFCYWX8AgVe0Ew/yiTpsSq8pefSZS0mZT7I0Er7xIAzt02ZHzaM7H09c4pImdcp
 M0pDQsxRTfft/ytyo+LUe5z05FLwMnDZOvzu1lM7hTwLNJ+ENbCRbnH/8dC3Sw9wMxNdRrcT
 5BBMWM9NUicM08VZgdFA8Jszr3w3iugIlW0q3rMzUYzy3DZwSRtyrnjN8DWPNeNQK25m27I/
 zqZoTqlX3n2MvSG+DqF6X2Cm9XDnDymAKkyTIC39eRD1Qj7Kms7TUd+uUGAiei+gVK5HspWN
 0cU9zEGqakp6FftX972QxqgunmGsxUAHd1KHIUHBBqlxqnR6gedXjlCTzhdZcY+rs4tSHom1
 Tdlgu/UONCmi5XNIVr1y1tehWra1fQ9RYPaWRI5cA==
IronPort-HdrOrdr: A9a23:aNDi86i0hOjlbwrduZy1wgHT6XBQXtoji2hC6mlwRA09TyX+ra
 qTdZUguCMc7Qx7ZJhOo7y90cW7Lk80l6QV3WBhB9mftWDd0QOVxepZjbcKrQeQeRHWx6pw0r
 phbrg7KPCYNykesS8i2njaL+od
X-Talos-CUID: 9a23:ZeUDa2wsrB9w14phOp8ZBgVKOcY3I0zs6UzsCGjkOXhyQoClUliPrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AqoS+kw+FaWof+2iY4cX+k7OQf95Z46S1B24Qq5k?=
 =?us-ascii?q?HpJTcHgwoBjielh3iFw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.12,150,1728943200"; 
   d="scan'208,223";a="81076645"
Received: from DKMAIL03.interprise.dk (2001:1448:248:6e::110:72) by
 DKMAIL09.interprise.dk (2001:1448:248:c8::200:79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 13 Nov 2024 10:06:52 +0100
Received: from DKMAIL03.interprise.dk (2001:1448:248:6e::110:72) by
 DKMAIL03.interprise.dk (2001:1448:248:6e::110:72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Nov 2024 10:06:53 +0100
Received: from DKMAIL03.interprise.dk ([fe80::7100:ad8c:7536:e0a]) by
 DKMAIL03.interprise.dk ([fe80::7100:ad8c:7536:e0a%4]) with mapi id
 15.02.1544.011; Wed, 13 Nov 2024 10:06:53 +0100
From: "Paul M. Bendixen" <pbe@trifork.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: [meta-rockchip] [PATCH] SOQuartz: add
Thread-Topic: [meta-rockchip] [PATCH] SOQuartz: add
Thread-Index: AQHbNathqGTY9kKYWU+R3eNpoUoXUA==
Date: Wed, 13 Nov 2024 09:06:53 +0000
Message-ID: <2f52ba6e-4709-4b66-b23d-838cbf8d9d3e@trifork.com>
Accept-Language: da-DK, en-US
Content-Language: da-DK
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [152.115.32.67]
Content-Type: multipart/mixed;
	boundary="_002_2f52ba6e47094b66b23d838cbf8d9d3etriforkcom_"
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 Nov 2024 09:07:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/792

--_002_2f52ba6e47094b66b23d838cbf8d9d3etriforkcom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBED705D1DFBE9459322DCCF9B74F8D3@trifork.com>
Content-Transfer-Encoding: base64

VGhlIFNPUXVhcnR6IGlzIGEgUkszNTY2IGJhc2VkIGNvbXB1dGUgbW9kdWxlIGFuZCBwYXJ0cyBv
ZiBRdWFydHo2NCBzZXJpZXMNCg0KU3BlY3M6DQotIFJvY2tjaGlwIFJLMzU2NiBRdWFkLWNvcmUg
QVJNIENvcnRleC1BNTVAMS44R0h6DQotIE1hbGktRzUyIDJFRSBCaWZyb3N0IEdQVUA4MDBNSHoN
Ci0gUmFzcGJlcnJ5IFBpIDQgQ00gZm9ybSBmYWN0b3INCi0gUkFNIE1lbW9yeSBWYXJpYW50czog
MkdCLCA0R0IsIDhHQiBMUEREUjQuDQotIG9wdGlvbmFsIGVNTUMgZnJvbSA4R0IgdG8gMTI4R0IN
Ci0gb3B0aW9uYWwgMTI4TWIgU1BJIEZsYXNoDQotIDEwLzEwMC8xMDAwTWJwcyBFdGhlcm5ldA0K
LSBXaUZpIDgwMi4xMSBiL2cvbi9hYyB3aXRoIEJsdWV0b290aCA1LjANCg0KRXhwb3NlZCBwcmVy
aXBoZXJhbHM6DQotIDF4IEhETUkNCi0gMnggRFNJDQotIDF4IGVEUA0KLSAxeCBMVkRTDQotIDF4
IENTSSA0LWxpbmUNCi0gMXggRXRoZXJuZXQNCi0gMXggVVNCIDIuMCBPVEcNCi0gMXggU0QNCi0g
MXggUENJZSAxLWxpbmUNCi0gMjh4IEdQSU8NCg0KU2lnbmVkLW9mZi1ieTogUGF1bCBNLiBCLiBC
ZW5kaXhlbiA8cGJlQHRyaWZvcmsuY29tPg0KDQoNCg0K

--_002_2f52ba6e47094b66b23d838cbf8d9d3etriforkcom_
Content-Type: text/x-patch; name="0001-SOQuartz-add.patch"
Content-Description: 0001-SOQuartz-add.patch
Content-Disposition: attachment; filename="0001-SOQuartz-add.patch";
	size=2385; creation-date="Wed, 13 Nov 2024 09:06:53 GMT";
	modification-date="Wed, 13 Nov 2024 09:06:53 GMT"
Content-ID: <09484EEB531411439BD7A5627BD7276C@trifork.com>
Content-Transfer-Encoding: base64

RnJvbSBlOWYwZGRlMmJmNWNhYzJjNjYzODBjOGJhYjkyOTZhYmM3OTFkNjJjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiUGF1bCBNLiBCLiBCZW5kaXhlbiIgPHBiZUB0cmlmb3JrLmNv
bT4KRGF0ZTogV2VkLCAxMyBOb3YgMjAyNCAwOToyOTo0NiArMDEwMApTdWJqZWN0OiBbbWV0YS1y
b2NrY2hpcF0gW1BBVENIXSBTT1F1YXJ0ejogYWRkCgpUaGUgU09RdWFydHogaXMgYSBSSzM1NjYg
YmFzZWQgY29tcHV0ZSBtb2R1bGUgYW5kIHBhcnRzIG9mIFF1YXJ0ejY0IHNlcmllcwoKU3BlY3M6
Ci0gUm9ja2NoaXAgUkszNTY2IFF1YWQtY29yZSBBUk0gQ29ydGV4LUE1NUAxLjhHSHoKLSBNYWxp
LUc1MiAyRUUgQmlmcm9zdCBHUFVAODAwTUh6Ci0gUmFzcGJlcnJ5IFBpIDQgQ00gZm9ybSBmYWN0
b3IKLSBSQU0gTWVtb3J5IFZhcmlhbnRzOiAyR0IsIDRHQiwgOEdCIExQRERSNC4KLSBvcHRpb25h
bCBlTU1DIGZyb20gOEdCIHRvIDEyOEdCCi0gb3B0aW9uYWwgMTI4TWIgU1BJIEZsYXNoCi0gMTAv
MTAwLzEwMDBNYnBzIEV0aGVybmV0Ci0gV2lGaSA4MDIuMTEgYi9nL24vYWMgd2l0aCBCbHVldG9v
dGggNS4wCgpFeHBvc2VkIHByZXJpcGhlcmFsczoKLSAxeCBIRE1JCi0gMnggRFNJCi0gMXggZURQ
Ci0gMXggTFZEUwotIDF4IENTSSA0LWxpbmUKLSAxeCBFdGhlcm5ldAotIDF4IFVTQiAyLjAgT1RH
Ci0gMXggU0QKLSAxeCBQQ0llIDEtbGluZQotIDI4eCBHUElPCgpTaWduZWQtb2ZmLWJ5OiBQYXVs
IE0uIEIuIEJlbmRpeGVuIDxwYmVAdHJpZm9yay5jb20+Ci0tLQogUkVBRE1FICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxICsKIGNvbmYvbWFjaGluZS9zb3F1YXJ0ei5j
b25mICAgICAgICAgICAgICAgICAgfCAxMiArKysrKysrKysrKysKIHJlY2lwZXMta2VybmVsL2xp
bnV4L2xpbnV4LXlvY3RvXyUuYmJhcHBlbmQgfCAgMSArCiAzIGZpbGVzIGNoYW5nZWQsIDE0IGlu
c2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCBjb25mL21hY2hpbmUvc29xdWFydHouY29u
ZgoKZGlmZiAtLWdpdCBhL1JFQURNRSBiL1JFQURNRQppbmRleCAwOWY4NjkxLi5jNTA3OWE1IDEw
MDY0NAotLS0gYS9SRUFETUUKKysrIGIvUkVBRE1FCkBAIC00NSw2ICs0NSw3IEBAIFN0YXR1cyBv
ZiBzdXBwb3J0ZWQgYm9hcmRzOgogCQkJcm9jay1waS1lCiAJCQlyb2NrLXBpLXMKIAkJCXJvY2s2
NAorCQkJc29xdWFydHoKIAogCWJ1aWxkczoKIAkJMzItYml0OgpkaWZmIC0tZ2l0IGEvY29uZi9t
YWNoaW5lL3NvcXVhcnR6LmNvbmYgYi9jb25mL21hY2hpbmUvc29xdWFydHouY29uZgpuZXcgZmls
ZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi4wMTg2MGI3Ci0tLSAvZGV2L251bGwKKysrIGIv
Y29uZi9tYWNoaW5lL3NvcXVhcnR6LmNvbmYKQEAgLTAsMCArMSwxMiBAQAorI0NvcHlyaWdodCAo
QykgVHJpZm9yayBBL1MgMjAyNAorIyBSZWxlYXNlZCB1bmRlciB0aGUgTUlUIGxpY2Vuc2UgKHNl
ZSBDT1BZSU5HLk1JVCBmb3IgdGhlIHRlcm1zKQorCisjQFR5cGU6IE1hY2hpbmUKKyNATmFtZTog
U09RdWFydHoKKyNARGVzY3JpcHRpb246IFNPUXVhcnR6IGJvYXJkIGZvciBwaW5lNjQKKworV0tT
X0ZJTEUgPz0gInJvY2tjaGlwLndrcyIKK3JlcXVpcmUgaW5jbHVkZS9yazM1NjYuaW5jCisKK1VC
T09UX01BQ0hJTkUgPSAic29xdWFydHotY200LXJrMzU2Nl9kZWZjb25maWciCitLRVJORUxfREVW
SUNFVFJFRSA9ICJyb2NrY2hpcC9yazM1NjYtc29xdWFydHotY200LmR0YiIKZGlmZiAtLWdpdCBh
L3JlY2lwZXMta2VybmVsL2xpbnV4L2xpbnV4LXlvY3RvXyUuYmJhcHBlbmQgYi9yZWNpcGVzLWtl
cm5lbC9saW51eC9saW51eC15b2N0b18lLmJiYXBwZW5kCmluZGV4IDU1MjhiYWIuLjU2ZWM5ZDcg
MTAwNjQ0Ci0tLSBhL3JlY2lwZXMta2VybmVsL2xpbnV4L2xpbnV4LXlvY3RvXyUuYmJhcHBlbmQK
KysrIGIvcmVjaXBlcy1rZXJuZWwvbGludXgvbGludXgteW9jdG9fJS5iYmFwcGVuZApAQCAtMjIs
NiArMjIsNyBAQCBDT01QQVRJQkxFX01BQ0hJTkU6cm9jay0zYSA9ICJyb2NrLTNhIgogQ09NUEFU
SUJMRV9NQUNISU5FOnJvY2stNGMtcGx1cyA9ICJyb2NrLTRjLXBsdXMiCiBDT01QQVRJQkxFX01B
Q0hJTkU6cm9jay01YSA9ICJyb2NrLTVhIgogQ09NUEFUSUJMRV9NQUNISU5FOnJvY2stNWIgPSAi
cm9jay01YiIKK0NPTVBBVElCTEVfTUFDSElORTpzb3F1YXJ0eiA9ICJzb3F1YXJ0eiIKIAogU1JD
X1VSSTphcHBlbmQgPSAiIGZpbGU6Ly9yb2NrY2hpcC1rbWV0YTt0eXBlPWttZXRhO25hbWU9cm9j
a2NoaXAta21ldGE7ZGVzdHN1ZmZpeD1yb2NrY2hpcC1rbWV0YSIKIFNSQ19VUkk6YXBwZW5kOm5h
bm9waS1yNHMgPSAiIGZpbGU6Ly9uYW5vcGktcjRzLnNjYyIKLS0gCjIuNDMuMAoK

--_002_2f52ba6e47094b66b23d838cbf8d9d3etriforkcom_--

