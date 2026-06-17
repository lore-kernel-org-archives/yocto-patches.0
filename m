Return-Path: <colinmca242@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257D7CD98F0
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 19:28:40 +0000 (UTC)
Subject: Re: [meta-lts-collab][kirkstone][PATCH 1/7] strongswan: Fix CVE-2026-35328
To: yocto-patches@lists.yoctoproject.org
From: "Colin McAllister" <colinmca242@gmail.com>
X-Originating-Location: Shawnee, Kansas, US (146.75.164.89)
X-Originating-Platform: Mac Safari 26.5
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 17 Jun 2026 12:28:38 -0700
References: <20260604080506.274123-1-nitin.wankhade@kpit.com>
In-Reply-To: <20260604080506.274123-1-nitin.wankhade@kpit.com>
Message-ID: <211612.1781724518296245224@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="UhQHeaxMny8xxLXpCT0B"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 19:28:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4237

--UhQHeaxMny8xxLXpCT0B
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi James,

Sorry for the late response, I was not checking this ML over the past month=
. I will be more actively monitoring this list moving forward.

Here is a PR for the strongswan patches: https://github.com/garmin/meta-lts=
-collab/pull/110

Two issues with these patches:
1. The patch filenames should be named after the associated CVE
2. There is no FILESEXTRAPATHS:prepend :=3D "${THISDIR}/files:" in the bbap=
pend (nit: Generally "${THISDIR}/${BPN}" is preferred for consistency)

Can you please send a v2 series with these issues addressed?

Thanks,
Colin

--UhQHeaxMny8xxLXpCT0B
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi James,</div>
<div>&nbsp;</div>
<div>Sorry for the late response, I was not checking this ML over the past =
month. I will be more actively monitoring this list moving forward.</div>
<div>&nbsp;</div>
<div>Here is a PR for the strongswan patches: <a href=3D"https://github.com=
/garmin/meta-lts-collab/pull/110">https://github.com/garmin/meta-lts-collab=
/pull/110</a></div>
<div>&nbsp;</div>
<div>Two issues with these patches:</div>
<div>1. The patch filenames should be named after the associated CVE</div>
<div>2. There is no <span style=3D"caret-color: #333333; color: #333333; fo=
nt-family: system-ui, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'L=
iberation Sans', Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', =
'Segoe UI Symbol', 'Noto Color Emoji'; font-size: 16px; font-style: normal;=
 font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orpha=
ns: 2; text-align: start; text-indent: 0px; text-transform: none; white-spa=
ce: pre-wrap; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;=
 background-color: #ffffff; text-decoration: none; display: inline !importa=
nt; float: none;">FILESEXTRAPATHS:prepend :=3D "${THISDIR}/files:" in the b=
bappend (nit: Generally "${THISDIR}/${BPN}" is preferred for consistency)</=
span></div>
<div>&nbsp;</div>
<div><span style=3D"caret-color: #333333; color: #333333; font-family: syst=
em-ui, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans'=
, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbo=
l', 'Noto Color Emoji'; font-size: 16px; font-style: normal; font-variant-c=
aps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-ali=
gn: start; text-indent: 0px; text-transform: none; white-space: pre-wrap; w=
idows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-col=
or: #ffffff; text-decoration: none; display: inline !important; float: none=
;">Can you please send a v2 series with these issues addressed?</span></div=
>
<div>&nbsp;</div>
<div><span style=3D"caret-color: #333333; color: #333333; font-family: syst=
em-ui, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans'=
, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbo=
l', 'Noto Color Emoji'; font-size: 16px; font-style: normal; font-variant-c=
aps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-ali=
gn: start; text-indent: 0px; text-transform: none; white-space: pre-wrap; w=
idows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-col=
or: #ffffff; text-decoration: none; display: inline !important; float: none=
;">Thanks,</span></div>
<div><span style=3D"caret-color: #333333; color: #333333; font-family: syst=
em-ui, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans'=
, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbo=
l', 'Noto Color Emoji'; font-size: 16px; font-style: normal; font-variant-c=
aps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-ali=
gn: start; text-indent: 0px; text-transform: none; white-space: pre-wrap; w=
idows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-col=
or: #ffffff; text-decoration: none; display: inline !important; float: none=
;">Colin</span></div>

--UhQHeaxMny8xxLXpCT0B--

