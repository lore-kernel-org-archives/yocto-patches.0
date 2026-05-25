Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C67CD5BB1
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 10:46:24 +0000 (UTC)
Subject: Re: [AUH] [PATCH 1/2] git: use temp file for commit message to avoid shell escaping issues
To: yocto-patches@lists.yoctoproject.org
From: "Daniel Turull" <daniel.turull@ericsson.com>
X-Originating-Location: Sundbyberg, Stockholm County, SE (192.176.1.77)
X-Originating-Platform: Windows Edge 148
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 25 May 2026 03:46:18 -0700
References: <20260525080418.942183-1-daniel.turull@ericsson.com> <10353a01dd5b874831051216ed82e0a2569ac2df.camel@linuxfoundation.org>
In-Reply-To: <10353a01dd5b874831051216ed82e0a2569ac2df.camel@linuxfoundation.org>
Message-ID: <2348770.1779705978823655794@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="Qu9otMjcue4GRQLL953s"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 10:46:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4039

--Qu9otMjcue4GRQLL953s
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,
thanks for the quick review.

I assumed _cmd had to be called after the "with" block, so I used delete=3D=
False to keep the file on disk after it was closed after the with block.
Moving _cmd inside the with block with a f.flush() is simpler.

I'll send a v2.

Cheers,
Daniel

--Qu9otMjcue4GRQLL953s
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>thanks for the quick review.</div>
<div>&nbsp;</div>
<div>I assumed _cmd had to be called after the "with" block, so I used dele=
te=3DFalse to keep the file on disk after it was closed after the with bloc=
k.</div>
<div>Moving _cmd inside the with block with a f.flush() is simpler.</div>
<div>&nbsp;</div>
<div>I'll send a v2.</div>
<div>&nbsp;</div>
<div>Cheers,</div>
<div>Daniel</div>

--Qu9otMjcue4GRQLL953s--

