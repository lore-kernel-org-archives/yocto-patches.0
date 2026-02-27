Return-Path: <dev@qinc.tv>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28A8FEFB70
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 17:24:13 +0000 (UTC)
Subject: Re: [meta-darwin][PATCH 1/1] Add DMG and PKG SDK installers
To: yocto-patches@lists.yoctoproject.org
From: "Eric L. Hernes" <dev@qinc.tv>
X-Originating-Location: US (165.23.88.160)
X-Originating-Platform: Mac Safari 26.2
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 27 Feb 2026 09:24:05 -0800
References: <20260202165146.3727-2-dev@qinc.tv> <20260202165146.3727-3-dev@qinc.tv> <CAHUKmYZW+-5=5q8mz_NOjECnG00yuZkPg1ZQ7g07BzqQqEUzdA@mail.gmail.com>
In-Reply-To: <CAHUKmYZW+-5=5q8mz_NOjECnG00yuZkPg1ZQ7g07BzqQqEUzdA@mail.gmail.com>
Message-ID: <1061013.1772213045503087087@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="s8LKwdgxstJz4F2keC2f"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Feb 2026 17:24:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3303

--s8LKwdgxstJz4F2keC2f
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Etienne,

Thanks for the review. I'll get this cleaned up and re-submitted.

Regarding the file sizes - yes, that's expected. =C2=A0The .pkg uses xz com=
pression, which doesn't get as small as bzip2. =C2=A0The .dmg (which is mor=
e correctly a .img), is uncompressed. =C2=A0I think it needs to be uncompre=
ssed in order to relocate and code sign the binaries. =C2=A0When I tried us=
ing a compressed (and real) .dmg file; it was read-only. =C2=A0It's probabl=
y ok to have it uncompressed when in use on the target system - it's no dif=
ferent than the .sh installer after installation. =C2=A0I'll add a step to =
bzip2 compress it so that it can be smaller for distribution.

I'm open to any other comments about pathing, naming, etc. =C2=A0I just bli=
ndly made up some of it as a hybrid between what Yocto would do and what ma=
cOS would do. =C2=A0It could be the worst of both worlds ;)

-Eric

--s8LKwdgxstJz4F2keC2f
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi Etienne,</div>
<div>&nbsp;</div>
<div>Thanks for the review. I'll get this cleaned up and re-submitted.<br /=
><br />Regarding the file sizes - yes, that's expected. &nbsp;The .pkg uses=
 xz compression, which doesn't get as small as bzip2. &nbsp;The .dmg (which=
 is more correctly a .img), is uncompressed. &nbsp;I think it needs to be u=
ncompressed in order to relocate and code sign the binaries. &nbsp;When I t=
ried using a compressed (and real) .dmg file; it was read-only. &nbsp;It's =
probably ok to have it uncompressed when in use on the target system - it's=
 no different than the .sh installer after installation. &nbsp;I'll add a s=
tep to bzip2 compress it so that it can be smaller for distribution.</div>
<div>&nbsp;</div>
<div>I'm open to any other comments about pathing, naming, etc. &nbsp;I jus=
t blindly made up some of it as a hybrid between what Yocto would do and wh=
at macOS would do. &nbsp;It could be the worst of both worlds ;)</div>
<div>&nbsp;</div>
<div>-Eric</div>

--s8LKwdgxstJz4F2keC2f--

