Return-Path: <colinmca242@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A22CD98F0
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 20:21:10 +0000 (UTC)
Subject: Re: [meta-lts-collab][kirkstone][PATCH] binutils: Fix CVE-2025-69652, CVE-2025-69649 and CVE-2026-4647
To: yocto-patches@lists.yoctoproject.org
From: "Colin McAllister" <colinmca242@gmail.com>
X-Originating-Location: Shawnee, Kansas, US (146.75.164.88)
X-Originating-Platform: Mac Safari 26.5
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 17 Jun 2026 13:21:07 -0700
References: <20260527102201.520139-1-jacksonj2@kpit.com>
In-Reply-To: <20260527102201.520139-1-jacksonj2@kpit.com>
Message-ID: <211612.1781727667049839162@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="DsVEvW4p1w5BK3e8yJk6"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 20:21:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4238

--DsVEvW4p1w5BK3e8yJk6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi James,

Thank you for this patch.

Here is a PR for the binutils patches: https://github.com/garmin/meta-lts-c=
ollab/pull/108

CI is passing and the patches mostly look good. Two issues I see:

1. Can you please use ${BPN} instead of ${PN} in FILESEXTRAPATHS?
2. I'm a little uncomfortable with the signed-off-by lines in the patch fil=
e:

>=20
> Signed-off-by: Shaik Moin <careers.myinfo@...>

https://github.com/garmin/meta-lts-collab/pull/108/changes#diff-c439e3658bd=
57bd33eb3480d519538b2fec0a0f7192cf22b9a8200a474fd9b9eR18

I would prefer for this address to match the other kpit addresses in your o=
ther submissions instead of the careers.myinfo gmail address. Can you pleas=
e submit a v2 patch with either Shaik's email corrected or with you persona=
lly signing off these patches?

Thanks,
Colin

--DsVEvW4p1w5BK3e8yJk6
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi James,</div>
<div>&nbsp;</div>
<div>Thank you for this patch.</div>
<div>&nbsp;</div>
<div><span style=3D"caret-color: #333333; color: #333333; font-family: syst=
em-ui, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans'=
, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbo=
l', 'Noto Color Emoji'; font-size: 16px; font-style: normal; font-variant-c=
aps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-ali=
gn: start; text-indent: 0px; text-transform: none; white-space: normal; wid=
ows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color=
: #ffffff; text-decoration: none; display: inline !important; float: none;"=
>Here is a PR for the binutils patches: <a href=3D"https://github.com/garmi=
n/meta-lts-collab/pull/108">https://github.com/garmin/meta-lts-collab/pull/=
108</a></span></div>
<div>&nbsp;</div>
<div><span style=3D"caret-color: #333333; color: #333333; font-family: syst=
em-ui, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans'=
, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbo=
l', 'Noto Color Emoji'; font-size: 16px; font-style: normal; font-variant-c=
aps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-ali=
gn: start; text-indent: 0px; text-transform: none; white-space: normal; wid=
ows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color=
: #ffffff; text-decoration: none; display: inline !important; float: none;"=
>CI is passing and the patches mostly look good. Two issues I see:</span></=
div>
<div>&nbsp;</div>
<div><span style=3D"caret-color: #333333; color: #333333; font-family: syst=
em-ui, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans'=
, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbo=
l', 'Noto Color Emoji'; font-size: 16px; font-style: normal; font-variant-c=
aps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-ali=
gn: start; text-indent: 0px; text-transform: none; white-space: normal; wid=
ows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color=
: #ffffff; text-decoration: none; display: inline !important; float: none;"=
>1. Can you please use ${BPN} instead of ${PN} in <span style=3D"caret-colo=
r: #333333; color: #333333; font-family: system-ui, 'Segoe UI', Roboto, 'He=
lvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, 'Apple Co=
lor Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'; font-s=
ize: 16px; font-style: normal; font-variant-caps: normal; font-weight: 400;=
 letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; t=
ext-transform: none; white-space: pre-wrap; widows: 2; word-spacing: 0px; -=
webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration: =
none; display: inline !important; float: none;">FILESEXTRAPATHS?</span></sp=
an><span style=3D"caret-color: #333333; color: #333333; font-family: system=
-ui, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', =
Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol'=
, 'Noto Color Emoji'; font-size: 16px; font-style: normal; font-variant-cap=
s: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align=
: start; text-indent: 0px; text-transform: none; white-space: normal; widow=
s: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: =
#ffffff; text-decoration: none; display: inline !important; float: none;"><=
/span></div>
<div><span style=3D"caret-color: #333333; color: #333333; font-family: syst=
em-ui, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans'=
, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbo=
l', 'Noto Color Emoji'; font-size: 16px; font-style: normal; font-variant-c=
aps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-ali=
gn: start; text-indent: 0px; text-transform: none; white-space: normal; wid=
ows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color=
: #ffffff; text-decoration: none; display: inline !important; float: none;"=
>2. I'm a little uncomfortable with the signed-off-by lines in the patch fi=
le:</span></div>
<div>
<blockquote>Signed-off-by: Shaik Moin &lt;careers.myinfo@...&gt;</blockquot=
e>
<a href=3D"https://github.com/garmin/meta-lts-collab/pull/108/changes#diff-=
c439e3658bd57bd33eb3480d519538b2fec0a0f7192cf22b9a8200a474fd9b9eR18">https:=
//github.com/garmin/meta-lts-collab/pull/108/changes#diff-c439e3658bd57bd33=
eb3480d519538b2fec0a0f7192cf22b9a8200a474fd9b9eR18</a></div>
<div>&nbsp;</div>
<div>I would prefer for this address to match the other kpit addresses in y=
our other submissions instead of the careers.myinfo gmail address. Can you =
please submit a v2 patch with either Shaik's email corrected or with you pe=
rsonally signing off these patches?</div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>Colin</div>

--DsVEvW4p1w5BK3e8yJk6--

