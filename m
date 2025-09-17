Return-Path: <quic_sbanerje@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F190CAC59A
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 15:58:54 +0000 (UTC)
Subject: Re: [meta-tensorflow][walnascar][PATCH] bazel-native: fix build with gcc-15
To: yocto-patches@lists.yoctoproject.org
From: "Sourabh Banerjee (QUIC)" <quic_sbanerje@quicinc.com>
X-Originating-Location: Hyderabad, Telangana, IN (163.116.219.33)
X-Originating-Platform: Windows Chrome 140
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 17 Sep 2025 08:58:51 -0700
References: <CA+chaQfzyyAUbSSbzh-PEM=GWxkW5e4xbAcxvWzypvWvaN92Dg@mail.gmail.com>
In-Reply-To: <CA+chaQfzyyAUbSSbzh-PEM=GWxkW5e4xbAcxvWzypvWvaN92Dg@mail.gmail.com>
Message-ID: <1435.1758124731563679242@lists.yoctoproject.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 15:58:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2206

The commit sha "c382865" is from Mar/2025, has gone missing.=20
Builds since Mar/2025 locked to this SHA are broken now.

I guess there is no way to recover now except editing the SHA at our end?

