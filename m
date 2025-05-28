Return-Path: <ccasciato@21sw.us>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EF6C5AD49
	for <webhook@archiver.kernel.org>; Wed, 28 May 2025 12:53:07 +0000 (UTC)
Subject: Re: [meta-security][PATCH] scap-security-guide: disable ptest by default
To: yocto-patches@lists.yoctoproject.org
From: "Clayton Casciato" <ccasciato@21sw.us>
X-Originating-Location: Denver, Colorado, US (174.29.216.122)
X-Originating-Platform: Linux Chrome 136
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 28 May 2025 05:53:07 -0700
References: <20250528055417.2527453-1-yi.zhao@windriver.com>
In-Reply-To: <20250528055417.2527453-1-yi.zhao@windriver.com>
Message-ID: <445.1748436787375609799@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="EjVyZ3fPzu49dwgXmk3s"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 May 2025 12:53:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1583

--EjVyZ3fPzu49dwgXmk3s
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi, Yi!

Should this use inherit_defer due to the conditional?

Sample:
https://git.openembedded.org/meta-openembedded/commit/meta-networking/recip=
es-support/chrony?id=3D63df976d8eec0fa714e8da30f4333f8af23c57d3

Thank you!

--
Clayton Casciato

--EjVyZ3fPzu49dwgXmk3s
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi, Yi!</div>
<div>&nbsp;</div>
<div>Should this use inherit_defer due to the conditional?</div>
<div>&nbsp;</div>
<div>Sample:</div>
<div><a href=3D"https://git.openembedded.org/meta-openembedded/commit/meta-=
networking/recipes-support/chrony?id=3D63df976d8eec0fa714e8da30f4333f8af23c=
57d3" target=3D"_blank" rel=3D"noopener">https://git.openembedded.org/meta-=
openembedded/commit/meta-networking/recipes-support/chrony?id=3D63df976d8ee=
c0fa714e8da30f4333f8af23c57d3</a></div>
<div>&nbsp;</div>
<div>Thank you!</div>
<div>&nbsp;</div>
<div>--</div>
<div>Clayton Casciato</div>

--EjVyZ3fPzu49dwgXmk3s--

