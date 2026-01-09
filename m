Return-Path: <stephan.wurm@a-eberle.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73654D185DC
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 12:05:57 +0000 (UTC)
Subject: Re: [meta-security] Upcoming (?) breaking change in veritysetup format output
To: yocto-patches@lists.yoctoproject.org
From: "Stephan Wurm" <stephan.wurm@a-eberle.de>
X-Originating-Location: Berlin, State of Berlin, DE (178.15.155.2)
X-Originating-Platform: Linux Chrome 142
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 09 Jan 2026 04:05:51 -0800
References: <88AE90DC-46C2-6F46-8E7C-9CFDB12E6218@hxcore.ol>
In-Reply-To: <88AE90DC-46C2-6F46-8E7C-9CFDB12E6218@hxcore.ol>
Message-ID: <545067.1767960351323525992@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="B1Ye8GAG3CAVXzf44lbQ"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 09 Jan 2026 12:05:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2924

--B1Ye8GAG3CAVXzf44lbQ
Content-Type: text/plain; charset="utf-8"; markup=markdown
Content-Transfer-Encoding: quoted-printable

Have a look on https://lists.yoctoproject.org/g/yocto-patches/message/2906 =
where I have patched the dm-verity-image.bbclass to address those upstream =
changes.
I think this is now really relevant as cryptsetup-2.8.3 gets picked in whin=
latter.

--B1Ye8GAG3CAVXzf44lbQ
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p>Have a look on <a href=3D"https://lists.yoctoproject.org/g/yocto-patches=
/message/2906" target=3D"_blank">https://lists.yoctoproject.org/g/yocto-pat=
ches/message/2906</a> where I have patched the dm-verity-image.bbclass to a=
ddress those upstream changes.
I think this is now really relevant as cryptsetup-2.8.3 gets picked in whin=
latter.</p>

--B1Ye8GAG3CAVXzf44lbQ--

