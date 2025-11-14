Return-Path: <hemant.jadhav@emerson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF022CE8D7C
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 19:16:26 +0000 (UTC)
Subject: Re: [meta-security][PATCH v4 1/2] clamav: Add recipe for version 1.4.3
To: yocto-patches@lists.yoctoproject.org
From: "Hemant Jadhav" <hemant.jadhav@emerson.com>
X-Originating-Location: US (69.41.68.7)
X-Originating-Platform: Windows Edge 142
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 14 Nov 2025 11:16:21 -0800
References: <20251114154052.3651845-1-hemant.jadhav@emerson.com> <58f6364a-0faf-9296-588e-1798cb52653c@konsulko.com>
In-Reply-To: <58f6364a-0faf-9296-588e-1798cb52653c@konsulko.com>
Message-ID: <475758.1763147781661145661@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="CFnmbl3GC86picxA3jIg"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 19:16:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2573

--CFnmbl3GC86picxA3jIg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 12:05 PM, Scott Murray wrote:

>=20
> To save me from digging into this myself, can you elaborate on why
> upstream now has all these license files as opposed to the one the
> previous version had? Are they vendoring a bunch of code from all
> those projects now? If so, can we disable vendored libraries to use
> system provided versions?

The multiple LICENSE files are present because the upstream project embeds =
modified portions of several third-party libraries directly within libclama=
v, rather than linking against system versions.
Actually, the same embedded code existed in 0.104.4 as well. The old 0.104.=
4 recipe only declared LICENSE =3D "LGPL-2.1-only", but it should have incl=
uded all the embedded licenses too. I think this was missed/incomplete in t=
he old recipe.

Answering to your next question: Unfortunately, NO - these are not optional=
 external dependencies but embedded code that is integral to ClamAV's funct=
ionality. The recipe is already using system libraries where possible (bzip=
2, zlib, pcre2, openssl, libxml2, etc.) - the embedded code is only for com=
ponents that must be vendored. (regex, YARA, inflate64 etc.)
I haven't explored lot, but I think system equivalents does not exist for Y=
ARA fork and specific LLVM bytecode components.

--CFnmbl3GC86picxA3jIg
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Fri, Nov 14, 2025 at 12:05 PM, Scott Murray wrote:</div>
<div>
<blockquote>To save me from digging into this myself, can you elaborate on =
why<br />upstream now has all these license files as opposed to the one the=
<br />previous version had? Are they vendoring a bunch of code from all<br =
/>those projects now? If so, can we disable vendored libraries to use<br />=
system provided versions?</blockquote>
<div>The multiple LICENSE files are present because the upstream project em=
beds modified portions of several third-party libraries directly within lib=
clamav, rather than linking against system versions.</div>
<div>Actually, the same embedded code existed in 0.104.4 as well. The old 0=
.104.4 recipe only declared LICENSE =3D "LGPL-2.1-only", but it should have=
 included all the embedded licenses too. I think this was missed/incomplete=
 in the old recipe.</div>
<div>&nbsp;</div>
<div>Answering to your next question: Unfortunately, NO - these are not opt=
ional external dependencies but embedded code that is integral to ClamAV's =
functionality. The recipe is already using system libraries where possible =
(bzip2, zlib, pcre2, openssl, libxml2, etc.) - the embedded code is only fo=
r components that must be vendored. (regex, YARA, inflate64 etc.)</div>
<div>I haven't explored lot, but I think system equivalents does not exist =
for YARA fork and specific LLVM bytecode components.</div>
</div>

--CFnmbl3GC86picxA3jIg--

