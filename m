Return-Path: <ben.cownley@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578A8D1AD5E
	for <webhook@archiver.kernel.org>; Wed, 16 Oct 2024 13:45:17 +0000 (UTC)
Subject: Re: [meta-zephyr][PATCH 1/2] topics/baicow01/zephyr-ARCH-remove: Remove ARCH from meta-zephyr
To: yocto-patches@lists.yoctoproject.org
From: "Ben Cownley" <ben.cownley@arm.com>
X-Originating-Location: Cambridge, England, GB (217.140.106.32)
X-Originating-Platform: Linux Firefox 131
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 16 Oct 2024 06:45:08 -0700
References: <CO1PR11MB5026C4AF87F23C156D2A3724C4462@CO1PR11MB5026.namprd11.prod.outlook.com>
In-Reply-To: <CO1PR11MB5026C4AF87F23C156D2A3724C4462@CO1PR11MB5026.namprd11.prod.outlook.com>
Message-ID: <18350.1729086308007900268@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="m52EeHut0GUfEV52TSzn"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Oct 2024 13:45:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/718

--m52EeHut0GUfEV52TSzn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Saini,

The issue seems to be pervasive in our testing.=C2=A0 We were able to isola=
te the change to GCC14, but our debug stopped there.=C2=A0 We are unsure as=
 to why it works with the zephyr gcc compiler but not the yocto one.=C2=A0 =
We think it might be related to some patches or compiler configuration, but=
 have not had sufficient time to debug

--m52EeHut0GUfEV52TSzn
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div><span style=3D"color: #d1d2d3; font-family: Slack-Lato, Slack-Fraction=
s, appleLogo, sans-serif; font-size: 15px; font-style: normal; font-variant=
-ligatures: common-ligatures; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; tex=
t-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width:=
 0px; white-space: normal; background-color: #1a1d21; text-decoration-thick=
ness: initial; text-decoration-style: initial; text-decoration-color: initi=
al; display: inline !important; float: none;">Hi Saini,<br /></span></div>
<div>&nbsp;</div>
<div><span style=3D"color: #d1d2d3; font-family: Slack-Lato, Slack-Fraction=
s, appleLogo, sans-serif; font-size: 15px; font-style: normal; font-variant=
-ligatures: common-ligatures; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; tex=
t-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width:=
 0px; white-space: normal; background-color: #1a1d21; text-decoration-thick=
ness: initial; text-decoration-style: initial; text-decoration-color: initi=
al; display: inline !important; float: none;"><span style=3D"color: #d1d2d3=
; font-family: Slack-Lato, Slack-Fractions, appleLogo, sans-serif; font-siz=
e: 15px; font-style: normal; font-variant-ligatures: common-ligatures; font=
-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2=
; text-align: left; text-indent: 0px; text-transform: none; widows: 2; word=
-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; backgro=
und-color: #1a1d21; text-decoration-thickness: initial; text-decoration-sty=
le: initial; text-decoration-color: initial; display: inline !important; fl=
oat: none;">The issue seems to be pervasive in our testing.&nbsp; We were a=
ble to isolate the change to GCC14, but our debug stopped there.&nbsp; We a=
re unsure as to why it works with the zephyr gcc compiler but not the yocto=
 one.&nbsp; We think it might be related to some patches or compiler config=
uration, but have not had sufficient time to debug</span></span></div>

--m52EeHut0GUfEV52TSzn--

