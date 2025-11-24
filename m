Return-Path: <hemant.jadhav@emerson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8642CFD313
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 15:04:58 +0000 (UTC)
Subject: Re: [meta-security][scarthgap][PATCH 00/32] Roll up outstanding fixes
To: yocto-patches@lists.yoctoproject.org
From: "Hemant Jadhav" <hemant.jadhav@emerson.com>
X-Originating-Location: US (69.41.68.7)
X-Originating-Platform: Windows Edge 142
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 24 Nov 2025 07:04:55 -0800
References: <cover.1763938436.git.scott.murray@konsulko.com> <1a0d3267-8887-48d1-b970-39f7de3b4268@gmail.com>
In-Reply-To: <1a0d3267-8887-48d1-b970-39f7de3b4268@gmail.com>
Message-ID: <672520.1763996695257453690@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="VOtVsFPtc9yshFsmiteH"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Nov 2025 15:04:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2696

--VOtVsFPtc9yshFsmiteH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Clayton,

The ClamAV 1.4.3 recipe patch submitted for master is also tested on scarth=
gap.
It can be ported to the scarthgap branch with minimal changes:
Required Changes for Scarthgap:
- add S =3D "${WORKDIR}/git"
- Replace all `${UNPACKDIR}` with `${WORKDIR}`

That's it! Everything else remains identical.

Thanks
Hemant

--VOtVsFPtc9yshFsmiteH
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>
<div>Hi Clayton,<br /><br /></div>
<div>The ClamAV 1.4.3 recipe patch submitted for master is also tested on s=
carthgap.&nbsp;<br />It can be ported to the scarthgap branch with minimal =
changes:</div>
<div>Required Changes for Scarthgap:<br />&nbsp; &nbsp;- add S =3D "${WORKD=
IR}/git"<br />&nbsp; &nbsp;- Replace all `${UNPACKDIR}` with `${WORKDIR}`&n=
bsp;<br />&nbsp; &nbsp;<br />That's it! Everything else remains identical.<=
br /><br />Thanks<br />Hemant&nbsp;</div>
</div>

--VOtVsFPtc9yshFsmiteH--

