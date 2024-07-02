Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26671C3064D
	for <webhook@archiver.kernel.org>; Tue,  2 Jul 2024 11:53:39 +0000 (UTC)
Subject: Re: [yocto-autobuilder-helper][PATCH 0/3] scripts: send_qa_email: skip regression report when missing base or target
To: yocto-patches@lists.yoctoproject.org
From: "Steve Sakoman" <steve@sakoman.com>
X-Originating-Location: US (98.142.47.158)
X-Originating-Platform: Linux Chrome 126
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 02 Jul 2024 04:53:34 -0700
References: <20240621155723.33600-1-alexis.lothore@bootlin.com>
In-Reply-To: <20240621155723.33600-1-alexis.lothore@bootlin.com>
Message-ID: <13008.1719921214270264486@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="xLKoaFl1gf3PEegLXlmZ"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Jul 2024 11:53:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/409

--xLKoaFl1gf3PEegLXlmZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I've tested this series with stable/scarthgap-nut and can confirm that it f=
ixes the persistent failures in send-qa-email that I've been seeing.

Steve

--xLKoaFl1gf3PEegLXlmZ
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I've tested this series with stable/scarthgap-nut and can confirm that it f=
ixes the persistent failures in send-qa-email that I've been seeing.<br /><=
br />Steve&nbsp;

--xLKoaFl1gf3PEegLXlmZ--

