Return-Path: <sputnik@on-the-web.ch>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCE4CD98F0
	for <webhook@archiver.kernel.org>; Sun, 21 Jun 2026 21:19:32 +0000 (UTC)
Received: from mail-4396.protonmail.ch (mail-4396.protonmail.ch [185.70.43.96])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30862.1782076768576357893
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 21 Jun 2026 14:19:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@on-the-web.ch header.s=protonmail2 header.b=X0+6W/wJ;
 spf=pass (domain: on-the-web.ch, ip: 185.70.43.96, mailfrom: sputnik@on-the-web.ch)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
	s=protonmail2; t=1782076764; x=1782335964;
	bh=s1uXvMi3mOVNOoFIn8TpU9WThxkzn7GyErICSdgi6q8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=X0+6W/wJ1OuVXnJwrsauWF+xW9UG6uk5bUOMynhjIsgg6wuzSMAylLXX1SkSa3Bza
	 oNyKULTmXDoHynwS7t2n2HN7Ffiww0gMScg77J6x6KpTn+4RDbLOfi9aGuwOS2Iq4P
	 JxjQIBaz0ZA9Tz4Dv77AVJT4pGSOqg0GFIHwL8vnut87I+of9lp5ToIoT9Ii8jk8lM
	 K247+PL9RVljxAlqgV3a2SEL7rSlbth4UNdshnTcMWkSZEvHozpLnxKx9qxJTIqJ5G
	 0LR/LFnK7AGHwvE/TRDyC7qqFzYXe2mhXJByT5iIO9dTTSIbtI7oEguF8K1Fwyg+Tr
	 03Py0/ouMesdg==
Date: Sun, 21 Jun 2026 21:19:20 +0000
To: yocto-patches@lists.yoctoproject.org
From: sputnik@on-the-web.ch
Cc: Trevor Woerner <twoerner@gmail.com>, Martin Herren <sputnik@on-the-web.ch>
Subject: [rockchip][PATCH 0/2] rk3576: rock-4d: initial support
Message-ID: <20260621211915.72650-1-sputnik@on-the-web.ch>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: 447d84b8f05c7aaa8017ae0acae17c615fcdaea5
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------f046496a085dbb97aabd906416c6634a30f8ce9303e9cef2d9d29b6c08cb442d"; charset=utf-8
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 21 Jun 2026 21:19:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4252

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------f046496a085dbb97aabd906416c6634a30f8ce9303e9cef2d9d29b6c08cb442d
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
From: sputnik@on-the-web.ch
To: yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <twoerner@gmail.com>,
	Martin Herren <sputnik@on-the-web.ch>
Subject: [rockchip][PATCH 0/2] rk3576: rock-4d: initial support
Date: Sun, 21 Jun 2026 23:19:11 +0200
Message-ID: <20260621211915.72650-1-sputnik@on-the-web.ch>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0

RnJvbTogTWFydGluIEhlcnJlbiA8c3B1dG5pa0Bvbi10aGUtd2ViLmNoPg0KDQpyazM1NzY6IHJv
Y2stNGQ6IEFkZCBpbml0aWFsIFNvQyBhbmQgYm9hcmQgc3VwcG9ydA0KDQpUaGlzIHNlcmllcyBh
ZGRzIHN1cHBvcnQgZm9yIHRoZSBSb2NrY2hpcCBSSzM1NzYgU29DIGFuZCB0aGUgUmFkeGENClJv
Y2sgNEQgYm9hcmQgdG8gbWV0YS1yb2NrY2hpcC4NCg0KVGhlIFJLMzU3NiBpcyBhbiBvY3RhLWNv
cmUgU29DICg0eCBDb3J0ZXgtQTcyICsgNHggQ29ydGV4LUE1Mykgd2l0aCBhDQpNYWxpLUc1MiBN
QzMgR1BVIGFuZCBhIDYgVE9QUyBOUFUuIFRoZSBSYWR4YSBSb2NrIDREIGlzIHRoZSBmaXJzdCBi
b2FyZA0KaW4gdGhlIFJvY2sgNCBzZXJpZXMgdG8gdXNlIHRoaXMgU29DICh0aGUgcmVzdCB1c2Ug
dGhlIFJLMzM5OSkuDQoNClRoZSBzZXJpZXMgaXMgc3BsaXQgaW50byB0d28gY29tbWl0cyBzbyB0
aGF0IHRoZSBTb0MgaW5mcmFzdHJ1Y3R1cmUgY2FuDQpiZSByZXZpZXdlZCBhbmQgbWVyZ2VkIGlu
ZGVwZW5kZW50bHksIHByb3ZpZGluZyBhIGJhc2UgZm9yIGZ1dHVyZQ0KcmszNTc2LWJhc2VkIGJv
YXJkczoNCg0KICAxLzI6IHJrMzU3NjogYWRkIGluaXRpYWwgc3VwcG9ydA0KICAgICAgU29DIGlu
Y2x1ZGUgKHJrMzU3Ni5pbmMpLCBya2JpbiBhZGRpdGlvbnMgZm9yIHRoZSBERFIvQkwzMS9CTDMy
DQogICAgICBibG9icywgdGhlIFRGLUEgYmJhcHBlbmQsIGFuZCB0aGUgVS1Cb290IGZvcmsgYmJh
cHBlbmQuDQoNCiAgMi8yOiByb2NrLTRkOiBhZGQgaW5pdGlhbCBzdXBwb3J0DQogICAgICBCb2Fy
ZCBjb25maWd1cmF0aW9uIChyb2NrLTRkLmNvbmYpLCB0aGUgbGludXgtcm9ja2NoaXAuaW5jDQog
ICAgICBjb21wYXRpYmlsaXR5IGVudHJ5LCBhbmQgUkVBRE1FIHVwZGF0ZXMgKGJvYXJkIGxpc3Rp
bmcgKyBhDQogICAgICAicmszNTc2IGJvb3RpbmciIG5vdGUgZG9jdW1lbnRpbmcgdGhlIFNQSS1m
bGFzaCByZXF1aXJlbWVudCkuDQoNCktOT1dOIExJTUlUQVRJT05TDQo9PT09PT09PT09PT09PT09
PQ0KDQpUaGUgdS1ib290IGZvcmsgbGl2ZXMgb24gYSBwZXJzb25hbCBjb250cmlidXRvciBicmFu
Y2gNCihzb3VyY2UuZGVueC5kZS91LWJvb3QvY29udHJpYnV0b3JzL2t3aWJvbywgYnJhbmNoICJy
azM1NzYiKSB3aGljaA0KY291bGQgYmUgcmViYXNlZCBvciByZW1vdmVkLiBUaGUgcGlubmVkIFNS
Q1JFViBwcm90ZWN0cyByZXByb2R1Y2liaWxpdHkNCnRvZGF5LCBidXQgZmV0Y2ggd291bGQgYnJl
YWsgaWYgdGhlIGJyYW5jaCBkaXNhcHBlYXJzLiBBIHZlcnNpb25lZA0KYnJhbmNoIG5hbWUgKMOg
IGxhIHRoZSBleGlzdGluZyByazN4eHgtMjAyNC4wNyBjb252ZW50aW9uKSBtYXkgYmUNCnJlcXVl
c3RlZCBmcm9tIEt3aWJvby4NCg0KTWFydGluIEhlcnJlbiAoMik6DQogIHJrMzU3NjogYWRkIGlu
aXRpYWwgc3VwcG9ydA0KICByb2NrLTRkOiBhZGQgaW5pdGlhbCBzdXBwb3J0DQoNCiBSRUFETUUg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxNyArKysrKysrKysrKysr
DQogY29uZi9tYWNoaW5lL2luY2x1ZGUvcmszNTc2LmluYyAgICAgICAgICAgICAgIHwgMjQgKysr
KysrKysrKysrKysrKysrKw0KIGNvbmYvbWFjaGluZS9yb2NrLTRkLmNvbmYgICAgICAgICAgICAg
ICAgICAgICB8IDExICsrKysrKysrKw0KIHJlY2lwZXMtYnNwL3JrYmluL3JvY2tjaGlwLXJrYmlu
LWRkcl9naXQuYmIgICB8ICA0ICsrKysNCiAuLi4vcmtiaW4vcm9ja2NoaXAtcmtiaW4tb3B0ZWUt
b3NfZ2l0LmJiICAgICAgfCAgNCArKysrDQogcmVjaXBlcy1ic3AvcmtiaW4vcm9ja2NoaXAtcmti
aW4tdGYtYV9naXQuYmIgIHwgIDMgKysrDQogcmVjaXBlcy1ic3AvcmtiaW4vcm9ja2NoaXAtcmti
aW4uaW5jICAgICAgICAgIHwgIDIgKysNCiAuLi4vdHJ1c3RlZC1maXJtd2FyZS1hXyUuYmJhcHBl
bmQgICAgICAgICAgICAgfCAgNSArKysrDQogcmVjaXBlcy1ic3AvdS1ib290L3UtYm9vdF8lLmJi
YXBwZW5kICAgICAgICAgIHwgIDUgKysrKw0KIHJlY2lwZXMta2VybmVsL2xpbnV4L2xpbnV4LXJv
Y2tjaGlwLmluYyAgICAgICB8ICAxICsNCiAxMCBmaWxlcyBjaGFuZ2VkLCA3NiBpbnNlcnRpb25z
KCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGNvbmYvbWFjaGluZS9pbmNsdWRlL3JrMzU3Ni5pbmMN
CiBjcmVhdGUgbW9kZSAxMDA2NDQgY29uZi9tYWNoaW5lL3JvY2stNGQuY29uZg0KDQo=
--------f046496a085dbb97aabd906416c6634a30f8ce9303e9cef2d9d29b6c08cb442d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0Fgmo4VVgJEIiu+thqKlAPNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmctP1bPhucIm7bj308t8k34FiEEJgeVlthQxcLg
gu1biK762GoqUA8AAF/jAQD0LZC2SE46sSB7YFbltAuAJpu6Eqi3TFA3RXPc
Kz9jpAEAgU9uYCF8eFxjA9cGdXqIOJC4TMyhxoJecWtdSoykZgw=
=ZpNJ
-----END PGP SIGNATURE-----


--------f046496a085dbb97aabd906416c6634a30f8ce9303e9cef2d9d29b6c08cb442d--


