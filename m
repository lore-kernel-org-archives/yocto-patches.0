Return-Path: <dev@qinc.tv>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F85E63C85
	for <webhook@archiver.kernel.org>; Sun, 25 Jan 2026 03:34:29 +0000 (UTC)
Subject: Re: [meta-darwin][PATCH] Patch GCC for aarch64 macOS host build on aarch64 linux host
To: yocto-patches@lists.yoctoproject.org
From: "Eric L. Hernes" <dev@qinc.tv>
X-Originating-Location: US (165.23.88.160)
X-Originating-Platform: Mac Safari 26.2
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Sat, 24 Jan 2026 19:34:22 -0800
References: <20260120170246.94746-1-dev@qinc.tv> <CAHUKmYaTWriiL3A1R4BgxCHU0tiyu+3Xyw_F-XeqTOW2DS+F8Q@mail.gmail.com>
In-Reply-To: <CAHUKmYaTWriiL3A1R4BgxCHU0tiyu+3Xyw_F-XeqTOW2DS+F8Q@mail.gmail.com>
Message-ID: <895666.1769312062734481847@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="ljMDWhTUUV83LS0Bb8z4"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 25 Jan 2026 03:34:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3075

--ljMDWhTUUV83LS0Bb8z4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thanks Etienne,

What is the correct indentation? =C2=A0I guess I didn=E2=80=99t look closel=
y enough at it.

The target is an oversight on my part, I=E2=80=99ll fix that.

The =E2=80=98with-mpft=E2=80=99 was taken straight from the =C2=A0`gcc-cros=
s-canadian_%.bbappend` patch, the same issue is in there too. =C2=A0I will =
fix both.

-Eric

--ljMDWhTUUV83LS0Bb8z4
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div><span style=3D"font-style: normal; font-variant-caps: normal; font-wei=
ght: 400; letter-spacing: normal; orphans: 2; text-align: start; text-inden=
t: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing:=
 0px; -webkit-text-stroke-width: 0px; text-decoration: none; caret-color: #=
000000; color: #000000; font-family: Helvetica; font-size: 12px; float: non=
e; display: inline !important;">Thanks Etienne,</span>
<div style=3D"font-style: normal; font-variant-caps: normal; font-weight: 4=
00; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px=
; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; text-decoration=
-thickness: auto; text-decoration-style: solid; caret-color: #000000; color=
: #000000; font-family: Helvetica; font-size: 12px;">&nbsp;</div>
<div style=3D"font-style: normal; font-variant-caps: normal; font-weight: 4=
00; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px=
; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; text-decoration=
-thickness: auto; text-decoration-style: solid; caret-color: #000000; color=
: #000000; font-family: Helvetica; font-size: 12px;">What is the correct in=
dentation? &nbsp;I guess I didn&rsquo;t look closely enough at it.</div>
<div style=3D"font-style: normal; font-variant-caps: normal; font-weight: 4=
00; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px=
; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; text-decoration=
-thickness: auto; text-decoration-style: solid; caret-color: #000000; color=
: #000000; font-family: Helvetica; font-size: 12px;">&nbsp;</div>
<div style=3D"font-style: normal; font-variant-caps: normal; font-weight: 4=
00; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px=
; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; text-decoration=
-thickness: auto; text-decoration-style: solid; caret-color: #000000; color=
: #000000; font-family: Helvetica; font-size: 12px;">The target is an overs=
ight on my part, I&rsquo;ll fix that.</div>
<div style=3D"font-style: normal; font-variant-caps: normal; font-weight: 4=
00; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px=
; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; text-decoration=
-thickness: auto; text-decoration-style: solid; caret-color: #000000; color=
: #000000; font-family: Helvetica; font-size: 12px;">&nbsp;</div>
<div style=3D"font-style: normal; font-variant-caps: normal; font-weight: 4=
00; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px=
; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; text-decoration=
-thickness: auto; text-decoration-style: solid; caret-color: #000000; color=
: #000000; font-family: Helvetica; font-size: 12px;">The &lsquo;with-mpft&r=
squo; was taken straight from the &nbsp;`gcc-cross-canadian_%.bbappend` pat=
ch, the same issue is in there too. &nbsp;I will fix both.</div>
<div style=3D"font-style: normal; font-variant-caps: normal; font-weight: 4=
00; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px=
; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; text-decoration=
-thickness: auto; text-decoration-style: solid; caret-color: #000000; color=
: #000000; font-family: Helvetica; font-size: 12px;">&nbsp;</div>
<div style=3D"font-style: normal; font-variant-caps: normal; font-weight: 4=
00; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px=
; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; text-decoration=
-thickness: auto; text-decoration-style: solid; caret-color: #000000; color=
: #000000; font-family: Helvetica; font-size: 12px;">-Eric</div>
<div style=3D"font-style: normal; font-variant-caps: normal; font-weight: 4=
00; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px=
; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; text-decoration=
-thickness: auto; text-decoration-style: solid; caret-color: #000000; color=
: #000000; font-family: Helvetica; font-size: 12px;">&nbsp;</div>
</div>

--ljMDWhTUUV83LS0Bb8z4--

