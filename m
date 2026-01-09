Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3F5D232E1
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 05:26:45 +0000 (UTC)
Subject: Re: [meta-selinux][PATCH/V6] refpolicy: Add support to configure policy store root
To: yocto-patches@lists.yoctoproject.org
From: "Sasi Kumar Maddineni (QUIC)" <quic_sasikuma@quicinc.com>
X-Originating-Location: Hyderabad, Telangana, IN (163.116.219.55)
X-Originating-Platform: Windows Edge 143
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 08 Jan 2026 21:26:43 -0800
References: <20251229090000.3305357-1-quic_sasikuma@quicinc.com> <98922eaf-0ab3-4dcb-8a77-65eda40be1b1@windriver.com>
In-Reply-To: <98922eaf-0ab3-4dcb-8a77-65eda40be1b1@windriver.com>
Message-ID: <596925.1767936403179770247@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="yWTyMWiy3IXsgv3QNTxZ"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 09 Jan 2026 05:26:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2918

--yWTyMWiy3IXsgv3QNTxZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi @Yi Zhao,

V7 patch is submitted with changes in refpolicy-minimum. By the way, POLICY=
_STORE_ROOT variable is defined in both libsemanage and refpolicy_common, s=
o we need to configure at both the places, if we are configuring a custom P=
OLICY_STORE_ROOT.

--yWTyMWiy3IXsgv3QNTxZ
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi @Yi Zhao,</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>V7 patch is submitted with changes in refpolicy-minimum. By the way, <=
span style=3D"color: #333333; font-family: system-ui, 'Segoe UI', Roboto, '=
Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, 'Apple =
Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'; font=
-size: 16px; font-style: normal; font-variant-ligatures: normal; font-varia=
nt-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text=
-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spac=
ing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; background=
-color: #ffffff; text-decoration-thickness: initial; text-decoration-style:=
 initial; text-decoration-color: initial; display: inline !important; float=
: none;">POLICY_STORE_ROOT variable is defined in both libsemanage and refp=
olicy_common, so we need to configure at both the places, if we are configu=
ring a custom <span style=3D"color: #333333; font-family: system-ui, 'Segoe=
 UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans=
-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Col=
or Emoji'; font-size: 16px; font-style: normal; font-variant-ligatures: nor=
mal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; o=
rphans: 2; text-align: start; text-indent: 0px; text-transform: none; widow=
s: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-w=
rap; background-color: #ffffff; text-decoration-thickness: initial; text-de=
coration-style: initial; text-decoration-color: initial; display: inline !i=
mportant; float: none;">POLICY_STORE_ROOT.</span></span></div>

--yWTyMWiy3IXsgv3QNTxZ--

