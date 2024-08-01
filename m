Return-Path: <ranjitsinh.rathod@kpit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D583C3DA4A
	for <webhook@archiver.kernel.org>; Thu,  1 Aug 2024 09:28:46 +0000 (UTC)
Subject: Re: [meta-lts-mixins][kirkstone/rust][PATCH] rust: Add new varaible RUST_ENABLE_EXTRA_TOOLS
To: yocto-patches@lists.yoctoproject.org
From: "Ranjitsinh Rathod" <ranjitsinh.rathod@kpit.com>
X-Originating-Location: US (136.226.233.81)
X-Originating-Platform: Linux Chrome 127
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 01 Aug 2024 02:28:43 -0700
References: <9390f93f-5267-410a-8ce6-3d2cf3d00b0b@cherry.de>
In-Reply-To: <9390f93f-5267-410a-8ce6-3d2cf3d00b0b@cherry.de>
Message-ID: <6975.1722504523892375589@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="SCxxS0VAfVzVsXPw95wn"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 Aug 2024 09:28:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/506

--SCxxS0VAfVzVsXPw95wn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Quentin,

The mentioned change is removed by the below commit and if I check the comm=
it message, it says that there is a need to build extra tools like rustdoc =
and so they have removed the customisation.
https://git.yoctoproject.org/poky/commit/?id=3D3f69d525d813ee071bd20c7577a0=
653cb0f0a210

Now we need to decide, which way we want to go ahead. Should we remove the =
configuration for build -> tools or we need to use my changes.

Please suggest further here everyone.

Thanks,
Ranjitsinh Rathod

--SCxxS0VAfVzVsXPw95wn
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hello <span style=3D"color: #333333; font-family: system-ui, 'Segoe UI=
', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-se=
rif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color =
Emoji'; font-size: 16px; font-style: normal; font-variant-ligatures: normal=
; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orph=
ans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: =
2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; =
background-color: #ffffff; text-decoration-thickness: initial; text-decorat=
ion-style: initial; text-decoration-color: initial; display: inline !import=
ant; float: none;">Quentin,</span></div>
<div>&nbsp;</div>
<div>The mentioned change is removed by the below commit and if I check the=
 commit message, it says that there is a need to build extra tools like rus=
tdoc and so they have removed the customisation.</div>
<div><a href=3D"https://git.yoctoproject.org/poky/commit/?id=3D3f69d525d813=
ee071bd20c7577a0653cb0f0a210" target=3D"_blank" rel=3D"noopener">https://gi=
t.yoctoproject.org/poky/commit/?id=3D3f69d525d813ee071bd20c7577a0653cb0f0a2=
10</a>&nbsp;</div>
<div>&nbsp;</div>
<div>Now we need to decide, which way we want to go ahead. Should we remove=
 the configuration for build -&gt; tools or we need to use my changes.</div=
>
<div>&nbsp;</div>
<div>Please suggest further here everyone.</div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>Ranjitsinh Rathod</div>

--SCxxS0VAfVzVsXPw95wn--

