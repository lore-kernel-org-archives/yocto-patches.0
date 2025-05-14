Return-Path: <olivier.benjamin@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBB1C3ABD9
	for <webhook@archiver.kernel.org>; Wed, 14 May 2025 09:14:29 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.98278.1747214062885843087
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 May 2025 02:14:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=O4fVuHt6;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: olivier.benjamin@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EDCEF41C84;
	Wed, 14 May 2025 09:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747214061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJmnzKagm2kP4aWRStN1gKrqIRoV/sXMLMFnfqP1Y0Y=;
	b=O4fVuHt6fvbVPdi4QY/KH/ZJhSrf8R9bj9kPhXMuiG93LXvRb46iauUasZEphi6ayzCgQh
	FRS5ruLnrPyaZ9KEy0YpQPI5eoCMY1Omxr1vp+m7vzMF6InCPNu3XSNjeJqn2V0QtvyiKm
	ZCaR8bLS1jGbJ91057try7CJv/5TAWSsXKjeh4Vk5goGtc5pCiO36zCbPF5c8DB7Ck0QzV
	llU7fDl6iZCjBZ2oO2tN/aaZhiYyhHQHLEnAqrs8GpmBC5pRRSedJRZpi3k0uhNBTMLV0L
	Ee3ZLHMZaxg0c+f6WMWKkbnlKnIO3ht793prtbUQXDC1mM7YezSi/bzOu7m/SQ==
From: Olivier Benjamin <olivier.benjamin@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Olivier Benjamin <olivier.benjamin@bootlin.com>
Subject: [psplash][PATCH v2] configure.ac: improve option handling logic
Date: Wed, 14 May 2025 11:14:13 +0200
Message-ID: <20250514091413.451634-1-olivier.benjamin@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250513141757.397196-1-olivier.benjamin@bootlin.com>
References: <20250513141757.397196-1-olivier.benjamin@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeiiedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefqlhhivhhivghruceuvghnjhgrmhhinhcuoeholhhivhhivghrrdgsvghnjhgrmhhinhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeejgeefieeuheeljeejfffhjeetkeehfedvvdffffelhfefvdetjefgvdfgiedvnecukfhppedvrgdtudemvgefgeemvggtfeekmedvgegvtdemfhehtggvmehffeegvdemieehkeejmehfieehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtfeekmedvgegvtdemfhehtggvmehffeegvdemieehkeejmehfieehiedphhgvlhhopehfvgguohhrrgdrrddpmhgrihhlfhhrohhmpeholhhivhhivghrrdgsvghnjhgrmhhinhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeholhhivhhiv
 ghrrdgsvghnjhgrmhhinhessghoohhtlhhinhdrtghomh
X-GND-Sasl: olivier.benjamin@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 May 2025 09:14:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1551

The configure options currently use hardcoded values in the
[action-if-given] branch of the AC_ARG_ENABLE autoconf macro
to determine whether the behaviour by passing GCC flags.
The issue is, that this branch is always taken when the option
is specified on the configure command line, regardless of
whether it is enabled or not.
This means that the opposite option can never be explicitly set
as passing it would match the branch, and result in the decision
variable being set to the same hardcoded value as the other case.

Use $enableval to set the decision variable to "yes" or "no"
depending on whether the option was enabled or disabled to make
it possible to explicitly set the default case.

Signed-off-by: Olivier Benjamin <olivier.benjamin@bootlin.com>
---
 configure.ac | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/configure.ac b/configure.ac
index 2a7da91..c66bc54 100644
--- a/configure.ac
+++ b/configure.ac
@@ -31,25 +31,25 @@ AC_SUBST([FONT_NAME])
 
 AC_ARG_ENABLE([startup-msg],
     AS_HELP_STRING([--disable-startup-msg], [Disable text banner output on startup]),
-    [disable_startup_msg=true],
-    [disable_startup_msg=false])
-AS_IF([test x$disable_startup_msg = xtrue], [
+    [enable_startup_msg=$enableval],
+    [enable_startup_msg=yes])
+AS_IF([test x$enable_startup_msg != xyes], [
     EXTRA_GCC_FLAGS="$EXTRA_GCC_FLAGS -DPSPLASH_DISABLE_STARTUP_MSG"
 ])
 
 AC_ARG_ENABLE([progress-bar],
     AS_HELP_STRING([--disable-progress-bar], [Disable progress bar]),
-    [disable_progress_bar=true],
-    [disable_progress_bar=false])
-AS_IF([test x$disable_progress_bar = xtrue], [
+    [enable_progress_bar=$enableval],
+    [enable_progress_bar=yes])
+AS_IF([test x$enable_progress_bar != xyes], [
     EXTRA_GCC_FLAGS="$EXTRA_GCC_FLAGS -DPSPLASH_DISABLE_PROGRESS_BAR"
 ])
 
 AC_ARG_ENABLE([img-fullscreen],
     AS_HELP_STRING([--enable-img-fullscreen], [Enable the logo image in fullscreen mode)]),
-    [img_fullscreen=true],
-    [img_fullscreen=false])
-AS_IF([test x$img_fullscreen = xtrue], [
+    [enable_img_fullscreen=$enableval],
+    [enable_img_fullscreen=no])
+AS_IF([test x$enable_img_fullscreen = xyes], [
     EXTRA_GCC_FLAGS="$EXTRA_GCC_FLAGS -DPSPLASH_IMG_FULLSCREEN=1"
 ])
 
-- 
2.43.0


