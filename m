Return-Path: <hemant.jadhav@emerson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C595CFD313
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 14:55:58 +0000 (UTC)
Subject: Re: [PATCH 1/2] clamav: Add recipe for version 1.4.3
To: yocto-patches@lists.yoctoproject.org
From: "Hemant Jadhav" <hemant.jadhav@emerson.com>
X-Originating-Location: US (69.41.68.7)
X-Originating-Platform: Windows Edge 142
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 24 Nov 2025 06:55:52 -0800
References: <20251120231345.1004458-1-hemant.jadhav@emerson.com> <5cf5a43b-152a-099b-1aaf-b5a5f7a9a129@konsulko.com> <672520.1763935693231696616@lists.yoctoproject.org> <2a78e262-0747-923f-4deb-43036e22711f@konsulko.com>
In-Reply-To: <2a78e262-0747-923f-4deb-43036e22711f@konsulko.com>
Message-ID: <686098.1763996152543724259@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="M379u4vPY55N2qmrcobH"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Nov 2025 14:55:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2695

--M379u4vPY55N2qmrcobH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 23, 2025 at 05:57 PM, Scott Murray wrote:

>=20
> Okay, thanks. I am surprised you have pkg_postinst calling
> populate-volatiles/systemd-tmpfiles, AFAIK those are run by
> default in early sysinit, and shouldn't need to be run
> per-package. Did you test without the pkg_postinst to see if
> that worked?

Hi Scott,
I actually added the pkg_postinst:${PN}() purposefully after testing it for=
 uninstall-reinstall on running system scenario.
Here's what I found:

**For Fresh system boot**: volatiles/tmpfiles work perfectly and create the=
 directories automatically during init.
**For Runtime package installation** where I manually removed/uninstalled c=
lamav and removed directories: the directories are NOT created until the ne=
xt boot.

Without the pkg_postinst:${PN}(), when installing the package on a running =
system, freshclam fails immediately with:
"ERROR: Failed to open log file /var/log/clamav/freshclam.log: No such file=
 or directory"
When I manually ran `/etc/init.d/populate-volatile.sh update`, the director=
ies were created and everything worked correctly.

So the pkg_postinst:${PN}() was added to take care of this scenario to inst=
all or upgrade packages on running systems without rebooting.
So that package is usable right away.

I can remove the block of code, since for the fresh system this is not a pr=
oblem and usually user will reboot after removing and package. Let me know =
your thoughts.

Hemant

--M379u4vPY55N2qmrcobH
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Sun, Nov 23, 2025 at 05:57 PM, Scott Murray wrote:</div>
<div>
<blockquote>Okay, thanks. I am surprised you have pkg_postinst calling<br /=
>populate-volatiles/systemd-tmpfiles, AFAIK those are run by<br />default i=
n early sysinit, and shouldn't need to be run<br />per-package. Did you tes=
t without the pkg_postinst to see if<br />that worked?</blockquote>
<br />
<div><br />Hi Scott,</div>
<div>I actually added the pkg_postinst:${PN}() purposefully after testing i=
t for uninstall-reinstall on running system scenario.</div>
<div>Here's what I found:</div>
<div>&nbsp;</div>
<div>**For Fresh system boot**: volatiles/tmpfiles work perfectly and creat=
e the directories automatically during init.</div>
<div>**For Runtime package installation** where I manually removed/uninstal=
led clamav and removed directories: the directories are NOT created until t=
he next boot.</div>
<div>&nbsp;</div>
<div>Without the pkg_postinst:${PN}(), when installing the package on a run=
ning system, freshclam fails immediately with:<br />"ERROR: Failed to open =
log file /var/log/clamav/freshclam.log: No such file or directory"<br />Whe=
n I manually ran `/etc/init.d/populate-volatile.sh update`, the directories=
 were created and everything worked correctly.</div>
<div>&nbsp;</div>
<div>So the pkg_postinst:${PN}() was added to take care of this scenario to=
 install or upgrade packages on running systems without rebooting.&nbsp;<br=
 />So that package is usable right away.</div>
<div>&nbsp;</div>
<div>I can remove the block of code, since for the fresh system this is not=
 a problem and usually user will reboot after removing and package. Let me =
know your thoughts.</div>
<div>&nbsp;</div>
<div>Hemant</div>
</div>

--M379u4vPY55N2qmrcobH--

