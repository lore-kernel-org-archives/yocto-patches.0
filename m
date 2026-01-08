Return-Path: <ghaderer@wyplay.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C42CF6A85
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 08:36:39 +0000 (UTC)
Subject: Re: [pseudo] [PATCH] unix: realpath fails if the resolved path doesn't exist.
To: yocto-patches@lists.yoctoproject.org
From: "Gauthier HADERER" <ghaderer@wyplay.com>
X-Originating-Location: FR (193.248.130.121)
X-Originating-Platform: Linux Chrome 142
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 08 Jan 2026 00:36:36 -0800
References: <20251219140600.212527-1-ghaderer@wyplay.com> <18d3c7cf-d644-42ac-a53c-3920014deb60@kernel.crashing.org> <502343.1767620059571907902@lists.yoctoproject.org>
In-Reply-To: <502343.1767620059571907902@lists.yoctoproject.org>
Message-ID: <583437.1767861396752509344@lists.yoctoproject.org>
Content-Type: multipart/mixed; boundary="0Mk213qc5XMFLPzHlKI5"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 08 Jan 2026 08:36:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2913

--0Mk213qc5XMFLPzHlKI5
Content-Type: multipart/alternative; boundary="WdONQDneX6um7IPb1fNH"

--WdONQDneX6um7IPb1fNH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Here's an updated version of my patch with a fix regarding the type of the =
stat structure.

--WdONQDneX6um7IPb1fNH
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Here's an updated version of my patch with a fix regarding the type of=
 the stat structure.</div>
<div>&nbsp;</div>

--WdONQDneX6um7IPb1fNH--

--0Mk213qc5XMFLPzHlKI5
Content-Type: text/x-patch; name="0001-unix-realpath-fails-if-the-resolved-path-doesn-t-exi.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-unix-realpath-fails-if-the-resolved-path-doesn-t-exi.patch"

RnJvbSAxNGFiZjE3N2JlODZhZmM4NjJkMTk3Y2IyNTMxNjUzNzE4MDIzN2I4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHYXV0aGllciBIQURFUkVSIDxnaGFkZXJlckB3eXBsYXkuY29t
PgpEYXRlOiBGcmksIDE5IERlYyAyMDI1IDA4OjU1OjMyICswMDAwClN1YmplY3Q6IFtQQVRDSF0g
dW5peDogcmVhbHBhdGggZmFpbHMgaWYgdGhlIHJlc29sdmVkIHBhdGggZG9lc24ndCBleGlzdC4K
ClRoZSBwc2V1ZG8gaW1wbGVtZW50YXRpb24gb2YgYHJlYWxwYXRoKCknIG1heSByZXR1cm4gYSBw
YXRoIHdoaWNoIGRvZXNuJ3QKZXhpc3QuIFRoaXMgaXMgbm90IFBPU0lYIGNvbXBsaWFudCBhbmQg
Y2F1c2VzIHRyb3VibGVzIHdpdGggdXV0aWxzIChjb3JldXRpbHMKaW4gUnVzdCkuCgpGb3IgZXhh
bXBsZSwgdGhlIHRhaWwgY29tbWFuZHMgdHJpZXMgdG8gZGV0ZXJtaW5lIHRoZSBmaWxlIHBhdGgg
b2YgaXRzIHN0YW5kYXJkCmlucHV0IGZpbGUgZGVzY3JpcHRvciBieSBjYWxsaW5nIGByZWFscGF0
aCgiL2Rldi9mZC8wIiknLiBXaGVuIHRoZSBpbnB1dCBpcyBhCnBpcGUsIHRoZSBHTlUgQyBsaWJy
YXJ5IHJldHVybnMgTlVMTCBidXQgcHNldWRvIHJldHVybnMKYC9wcm9jLzxwaWQ+L2ZkL3BpcGU6
W3h4eHh4eF0nLiBBcyBpdCBnb3QgYSBwYXRoLCB0aGUgdGFpbCBjb21tYW5kIHRyaWVzIHRvCm9w
ZW4gaXQgYW5kIGZhaWxzLgoKVXBzdHJlYW0tU3RhdHVzOiBQZW5kaW5nCi0tLQogcG9ydHMvdW5p
eC9ndXRzL3JlYWxwYXRoLmMgfCA4ICsrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvcG9ydHMvdW5peC9ndXRzL3JlYWxwYXRoLmMgYi9wb3J0cy91
bml4L2d1dHMvcmVhbHBhdGguYwppbmRleCA4ZDgxMThiLi5iMTA3OGRiIDEwMDY0NAotLS0gYS9w
b3J0cy91bml4L2d1dHMvcmVhbHBhdGguYworKysgYi9wb3J0cy91bml4L2d1dHMvcmVhbHBhdGgu
YwpAQCAtMTQsNiArMTQsMTQgQEAKIAkJZXJybm8gPSBFTkFNRVRPT0xPTkc7CiAJCXJldHVybiBO
VUxMOwogCX0KKworCS8qIFdlIG11c3QgZmFpbCBpZiB0aGUgdGFyZ2V0IHBhdGggZG9lc24ndCBl
eGlzdC4gKi8KKwlQU0VVRE9fU1RBVEJVRiBidWY7CisKKwlpZiAoYmFzZV9sc3RhdChybmFtZSwg
JmJ1ZikgPT0gLTEpIHsKKwkJcmV0dXJuIE5VTEw7CisJfQorCiAJCWxlbiA9IHN0cmxlbihybmFt
ZSk7CiAJCWNoYXIgKmVwID0gcm5hbWUgKyBsZW4gLSAxOwogCQl3aGlsZSAoZXAgPiBybmFtZSAm
JiAqZXAgPT0gJy8nKSB7Ci0tIAoyLjQ3LjMKCg==

--0Mk213qc5XMFLPzHlKI5--

