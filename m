Return-Path: <hemant.jadhav@emerson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95958CFD2F6
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 22:08:22 +0000 (UTC)
Subject: Re: [PATCH 1/2] clamav: Add recipe for version 1.4.3
To: yocto-patches@lists.yoctoproject.org
From: "Hemant Jadhav" <hemant.jadhav@emerson.com>
X-Originating-Location: US (69.41.68.7)
X-Originating-Platform: Windows Edge 142
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Sun, 23 Nov 2025 14:08:13 -0800
References: <20251120231345.1004458-1-hemant.jadhav@emerson.com> <5cf5a43b-152a-099b-1aaf-b5a5f7a9a129@konsulko.com>
In-Reply-To: <5cf5a43b-152a-099b-1aaf-b5a5f7a9a129@konsulko.com>
Message-ID: <672520.1763935693231696616@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="9HCpvwTLicFFpXeJxXH6"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 22:08:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2657

--9HCpvwTLicFFpXeJxXH6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 08:05 AM, Scott Murray wrote:

>=20
> I was just about to push a series with v5 to master-next for a CI run
> after finishing local testing, but I'll drop it for now seeing this.
> Instead of the pkg_postinst, please see if you can get those directories
> and files created in do_install and/or the volatiles + tmpfiles
> configuration, pkg_postinst should kind of be a last resort for changes
> like this.
>=20
> My other recommendation is to squash this and patch 2 together since
> this is an upgrade, I had done this with v5 in my tree. Ideally the
> recipe update would be a rename+diff for a smaller, easier to read diff,
> but in a pinch I can try to fix that up on my end.
>=20
> Thanks,
>=20
> Scott

Hi Scott,

Thank you for your patience and valuable feedback on the previous versions =
of this patch.

I have run additional testing scenarios before sending this V7 patch to ens=
ure all the runtime configuration issues are properly addressed.
The changes now include proper directory ownership handling through pkg_pos=
tinst scripts while relying on volatiles/tmpfiles for directory creation as=
 you suggested.

Thanks ,
Hemant

--9HCpvwTLicFFpXeJxXH6
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Fri, Nov 21, 2025 at 08:05 AM, Scott Murray wrote:</div>
<div>
<blockquote>I was just about to push a series with v5 to master-next for a =
CI run<br />after finishing local testing, but I'll drop it for now seeing =
this.<br />Instead of the pkg_postinst, please see if you can get those dir=
ectories<br />and files created in do_install and/or the volatiles + tmpfil=
es<br />configuration, pkg_postinst should kind of be a last resort for cha=
nges<br />like this.<br /><br />My other recommendation is to squash this a=
nd patch 2 together since<br />this is an upgrade, I had done this with v5 =
in my tree. Ideally the<br />recipe update would be a rename+diff for a sma=
ller, easier to read diff,<br />but in a pinch I can try to fix that up on =
my end.<br /><br />Thanks,<br /><br />Scott</blockquote>
<div>Hi Scott,</div>
<div>&nbsp;</div>
<div>Thank you for your patience and valuable feedback on the previous vers=
ions of this patch.</div>
<div>&nbsp;</div>
<div>I have run additional testing scenarios before sending this V7 patch t=
o ensure all the runtime configuration issues are properly addressed. <br /=
>The changes now include proper directory ownership handling through pkg_po=
stinst scripts while relying on volatiles/tmpfiles for directory creation a=
s you suggested.</div>
<br />Thanks ,</div>
<div>Hemant</div>
<div>&nbsp;</div>

--9HCpvwTLicFFpXeJxXH6--

