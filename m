Return-Path: <youenn.lejeune@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE73F107527A
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 08:50:34 +0000 (UTC)
Subject: Re: [PATCH] dpdk: replace CVE_CHECK_IGNORE with CVE_STATUS
To: yocto-patches@lists.yoctoproject.org
From: "Youenn Le Jeune" <youenn.lejeune@savoirfairelinux.com>
X-Originating-Location: FR (80.15.101.118)
X-Originating-Platform: Linux Firefox 148
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 19 Mar 2026 01:50:32 -0700
References: <20260316121133.66539-1-youenn.lejeune@savoirfairelinux.com> <CA+s=J=x6j1YGK6E5+ncgr2PLcS1hqiRENwPdrj9kUJFgvBXyVA@mail.gmail.com>
In-Reply-To: <CA+s=J=x6j1YGK6E5+ncgr2PLcS1hqiRENwPdrj9kUJFgvBXyVA@mail.gmail.com>
Message-ID: <482312.1773910232268366968@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="KbcNRc0Z9GN9zwxcwghd"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 19 Mar 2026 08:50:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3519

--KbcNRc0Z9GN9zwxcwghd
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I just tested and you are right, we do not actually need those CVE ignores =
anymore. I'll email a new patch.

--KbcNRc0Z9GN9zwxcwghd
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>I just tested and you are right, we do not actually need those CVE ign=
ores anymore. I'll email a new patch.</div>

--KbcNRc0Z9GN9zwxcwghd--

