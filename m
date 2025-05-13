Return-Path: <olivier.benjamin@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993A5C3ABC3
	for <webhook@archiver.kernel.org>; Tue, 13 May 2025 14:18:12 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web10.77259.1747145882795390332
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 13 May 2025 07:18:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=DAKZOtFI;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: olivier.benjamin@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B8A743B45;
	Tue, 13 May 2025 14:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747145879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vzH6BteJa2+YXyDrmGkX3ycfEP5rW5CVcT1HFBPOPU0=;
	b=DAKZOtFImiVWkLHAkRl17vpuQQHCRVS2fSVVHYubtOQjmty0f0Y9RkPqG6unOudyY6JYNN
	rijeYnvu+AJIHfkCw9rtV1rPCBOeotui6jaX5pd8UBy86rvQjz+g8XuCns7J/wgLQbwAIz
	C068yg0y8HRgSIuyopkoB/7A36O37t0okawOd4aLIH4xwIHbOoZo6N3o1/x0FXYj6s+v1g
	NUM7GOORONCuqkurvSMPSPuynm6weCDHfCqJt5wEEcrPoRIBANtWpaOA1frNemqIDQOTiU
	3xYbp1vO5aJYMNj4mfv1BIQVkqr8p6YrtkkFm8rb9wFpFWfR2+nUCXRRker3eA==
From: Olivier Benjamin <olivier.benjamin@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Olivier Benjamin <olivier.benjamin@bootlin.com>
Subject: [psplash][PATCH] configure.ac: improve option handling logic
Date: Tue, 13 May 2025 16:17:57 +0200
Message-ID: <20250513141757.397196-1-olivier.benjamin@bootlin.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdegfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefqlhhivhhivghruceuvghnjhgrmhhinhcuoeholhhivhhivghrrdgsvghnjhgrmhhinhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfehvdegffettdffieelgeeikeehhfduteejudeiffdutdduhfekudekfefggeelnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemieejieejmeeisgeivgemjeehkegtmeehrghfugenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemieejieejmeeisgeivgemjeehkegtmeehrghfugdphhgvlhhopehptgdqvdelrdhhohhmvgdpmhgrihhlfhhrohhmpeholhhivhhivghrrdgsvghnjhgrmhhinhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeholhhivhhiv
 ghrrdgsvghnjhgrmhhinhessghoohhtlhhinhdrtghomh
X-GND-Sasl: olivier.benjamin@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 13 May 2025 14:18:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1550

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
index 2a7da91..80418e5 100644
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
+    [img_fullscreen=$enableval],
+    [img_fullscreen=no])
+AS_IF([test x$img_fullscreen = xyes], [
     EXTRA_GCC_FLAGS="$EXTRA_GCC_FLAGS -DPSPLASH_IMG_FULLSCREEN=1"
 ])
 
-- 
2.43.0


