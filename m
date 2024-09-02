Return-Path: <martin@dorumtech.no>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDFDCA0ED3
	for <webhook@archiver.kernel.org>; Mon,  2 Sep 2024 11:57:08 +0000 (UTC)
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
 by mx.groups.io with SMTP id smtpd.web11.37007.1725278219050661409
 for <Yocto-Patches@Lists.Yoctoproject.Org>;
 Mon, 02 Sep 2024 04:56:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@dorumtech.no header.s=fm3 header.b=mQ7skvEf;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=YLLNCSmV;
 spf=pass (domain: dorumtech.no, ip: 103.168.172.152, mailfrom: martin@dorumtech.no)
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3E41E114014A
	for <Yocto-Patches@Lists.Yoctoproject.Org>; Mon,  2 Sep 2024 07:56:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 02 Sep 2024 07:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dorumtech.no; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1725278218; x=1725364618; bh=576Mzj0tpM
	MBTF535dY7drOQrIvX/eqXkU1viuv8sxA=; b=mQ7skvEfIsgR080DwjlunVLv8w
	D7Tdmb8ZSNNA0VvUXugPuNLGSJtLcZnPg+h786AYyt0CiWVf0qkRs4tPOhR5FY7Z
	rhvOss+AW32/9NRdl9EwRP4frukLJYr+eDZt9Cc5szjIS1RzwXu/wXQuXS1pAfXw
	xfvJf/e7NpEsPGPTd5+qpAxyxSbsM9T8snXD3LFgSDx5T5eNtzHzEq7Z1/bPEI+i
	IYjAv4LZqeZ5OHnYyr0yyot72VKno5FjVhKuZZq3O7YmXvnruZUj1+cMT8Xhyo7W
	d18Xzfl++bbxrOr7r+J/h5NmV51gV99IgS4jXTxLh0uJsKQlF6xY1Qi37E3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725278218; x=1725364618; bh=576Mzj0tpMMBTF535dY7drOQrIvX
	/eqXkU1viuv8sxA=; b=YLLNCSmV9Gml9cTHeez0jhPFCOcTFLz7Hk2BXVCe0Ul8
	e+u8HP+edzzddqI49Y4QhjQz+DQby7+1h5E/7SSFVSlRHReENUiMrpLkGOBj6AA2
	d8R0itsq/xcqGwZHkRmJibY/r1FoWa/bCAxEtmQ6DjZLh0ej+dWPQz2K6w+UgPtQ
	CFIbXmgiqxy4AfHgxv+qQNnQdehfbZsmdBs9+gARnySBIN82V3LWCqmufF8SXNsC
	EtR0fTOI21iBT8QF3aQwwtl4KtEhFPLV7OFt35p1XcUuwsfKo9wL+hRD42NYUOBU
	tWOuxK67imnxbKYo0dScLcPhstjgMN7GvL93ZAo2/A==
X-ME-Sender: <xms:CqjVZugcBt1Pz7gXov_VksGe36_VdI_tKNAmLvP3oHEu5yApOzLCMg>
    <xme:CqjVZvDaaLeeLsJf58okVNv-nTg67P1WaaT3uAwo81lxZ5ZCCahPRsEZ38EhgozNX
    lNDmWUPMhlKDUhkDcY>
X-ME-Received: <xmr:CqjVZmEw-Tju7WmURNo_i9kWUtn87irLi1QTp3PmQYNytUjBTVbpbfs7vHcd_dnsM6ih>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehfedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhtgfggg
    fukfffvffosehtqhhmtdhhtddvnecuhfhrohhmpeforghrthhinhcuffpprhhumhcuoehm
    rghrthhinhesughorhhumhhtvggthhdrnhhoqeenucggtffrrghtthgvrhhnpeeklefgfe
    ejveekteejveeukeelfeduffdujefhleelleefhefgtdffgfdtgfduveenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrthhinhesughorh
    humhhtvggthhdrnhhopdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhroh
    hjvggtthdrohhrgh
X-ME-Proxy: <xmx:CqjVZnQr4B9e96LNKRm2waTFiIwFQ5OHf40mKPj2ZKZXMVCLWc6YCA>
    <xmx:CqjVZrx8sNwY0ixlIo3mHwmaAUF2jRsOxfl6U_hTxK9cmOR0xc-S4g>
    <xmx:CqjVZl6gbA29vXPl0B1fGc4hqHRItjvDS5GasVPog_bzE--bfIP08w>
    <xmx:CqjVZoxNmhxWQj4Zz5VE1rxK8RxbUPKIPBSfxJRAcbdqd1TTFguTsw>
    <xmx:CqjVZkqx_cX9yiYPv00JONO437lsDZsYRRomRVJqg686HW2PIJnEkjPd>
Feedback-ID: i1281493f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <Yocto-Patches@Lists.Yoctoproject.Org>; Mon,
 2 Sep 2024 07:56:57 -0400 (EDT)
From: =?utf-8?Q?Martin_D=C3=B8rum?= <martin@dorumtech.no>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: [PATCH] meta-lts-mixins kirkstone/go: depend on -crosssdk recipes
Message-Id: <68FCFF96-C849-410C-A25F-3B797A817B67@dorumtech.no>
Date: Mon, 2 Sep 2024 13:56:46 +0200
To: "Yocto-Patches@lists.yoctoproject.org" <Yocto-Patches@Lists.Yoctoproject.Org>
X-Mailer: Apple Mail (2.3776.700.51)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 02 Sep 2024 11:57:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/609

The Go recipes failed to compile for me,
because Bitbake said that the recipes
virtual/${HOST_PREFIX}gcc and virtua/${HOST_PREFIX}binutils
didn't exist.
I took a look at how Poky does it, and Poky's Go recipes depend on
virtual/${HOST_PREFIX}gcc-crosssdk and
virtual/${HOST_PREFIX}binutils-crosssdk,
so I changed the mixin recipes to reflect that.

With these changes, the Go recipes compile on Kirkstone.
---
 recipes-devtools/go/go-cross-canadian.inc | 2 +-
 recipes-devtools/go/go-crosssdk.inc       | 2 +-
 recipes-devtools/go/go-runtime.inc        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/recipes-devtools/go/go-cross-canadian.inc =
b/recipes-devtools/go/go-cross-canadian.inc
index dd485b6..2c6ed29 100644
--- a/recipes-devtools/go/go-cross-canadian.inc
+++ b/recipes-devtools/go/go-cross-canadian.inc
@@ -1,7 +1,7 @@
 inherit cross-canadian

 DEPENDS =3D "go-native virtual/${HOST_PREFIX}go =
virtual/nativesdk-${HOST_PREFIX}go-runtime \
-           virtual/${HOST_PREFIX}gcc virtual/nativesdk-libc \
+           virtual/${HOST_PREFIX}gcc-crosssdk virtual/nativesdk-libc \
            virtual/nativesdk-${HOST_PREFIX}compilerlibs"
 PN =3D "go-cross-canadian-${TRANSLATED_TARGET_ARCH}"

diff --git a/recipes-devtools/go/go-crosssdk.inc =
b/recipes-devtools/go/go-crosssdk.inc
index 1293900..61486a6 100644
--- a/recipes-devtools/go/go-crosssdk.inc
+++ b/recipes-devtools/go/go-crosssdk.inc
@@ -1,6 +1,6 @@
 inherit crosssdk

-DEPENDS =3D "go-native virtual/${TARGET_PREFIX}gcc =
virtual/nativesdk-${TARGET_PREFIX}compilerlibs =
virtual/${TARGET_PREFIX}binutils"
+DEPENDS =3D "go-native virtual/${TARGET_PREFIX}gcc-crosssdk =
virtual/nativesdk-${TARGET_PREFIX}compilerlibs =
virtual/${TARGET_PREFIX}binutils-crosssdk"
 PN =3D "go-crosssdk-${SDK_SYS}"
 PROVIDES =3D "virtual/${TARGET_PREFIX}go"

diff --git a/recipes-devtools/go/go-runtime.inc =
b/recipes-devtools/go/go-runtime.inc
index 413cf6d..86539f2 100644
--- a/recipes-devtools/go/go-runtime.inc
+++ b/recipes-devtools/go/go-runtime.inc
@@ -1,5 +1,5 @@
 DEPENDS =3D "virtual/${TUNE_PKGARCH}-go go-native"
-DEPENDS:class-nativesdk =3D "virtual/${TARGET_PREFIX}go"
+DEPENDS:class-nativesdk =3D "virtual/${TARGET_PREFIX}go-crosssdk"
 PROVIDES =3D "virtual/${TARGET_PREFIX}go-runtime"

 DEBUG_PREFIX_MAP =3D "\
--
2.46


