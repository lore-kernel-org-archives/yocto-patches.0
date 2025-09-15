Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1CCCAC597
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 12:21:51 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.web10.31619.1757938910052170685
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Sep 2025 05:21:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=g2v/7g5H;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 79E0BC8F1FF
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 12:21:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C3A036063F
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 12:21:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AE821102F2ABB;
	Mon, 15 Sep 2025 14:21:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757938908; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=e3QSHulVeaW41Qdp6vf4E9rwJXtMSMalVBA1oBWgB60=;
	b=g2v/7g5H9I/vN9fEWnChA0nrnOpSlDLS5WIFM9HPuP6aN8RFXQzoGTVxkuZRq+BqMRrh3f
	Y4XgtAONmZL3uG0BU1Bf+yijfSYcvafrR8o5IAJtArRbDXeG7OvFdqWfvfKfALhdJTZohA
	j/0X/Uo/VCxSRLDzAQrKOyhdcXVxts7m6WJdQdjil/yIsIGLbZs9zLXUBVYLAeGPcJo6ki
	6ElzSaBBahrO5kt0QO1gH+yXWfZ0NBJ2liNiXFmJEg2cnxt0TChcVDZu1Oc9vPzOuUeUBQ
	bhgByy0VEfMPKKlVdD35wYvihYZO3ckuxmF8J71yHVS/s5ayns5kPcYBT7fNgQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 15 Sep 2025 14:19:48 +0200
Subject: [yocto-autobuilder-helper][PATCH 2/3] scripts/run-docs-build: pass
 active releases to bitbake
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-pass-bitbake-active-releases-v1-2-a5530a97b9ef@bootlin.com>
References: <20250915-pass-bitbake-active-releases-v1-0-a5530a97b9ef@bootlin.com>
In-Reply-To: <20250915-pass-bitbake-active-releases-v1-0-a5530a97b9ef@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2213;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=OMpDvD0qaWQgFtX2ann49/q1hDFJeJ0uGmAmLrTZdok=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBoyATaf1d7OTk+QgKTPNg/ZmjpOGq8w+zbGc0rv
 O0N9F9zS6OJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaMgE2gAKCRDRgEFAKaOo
 NrJoD/sHcbRiFQO21DlfIKuq3VFrtazZcGInahNhrGMW7crsEh7hqeAWL63odfSGSwRNhxrYTWQ
 IE0HPj/MNHx3Ll+eId/3lkjyLZlo3PphRMG22dG4rOFHRNC9z6/lHzm+9NxhWukZzb5sETN472t
 EzZpXhQz5XL0EeRz74ipJNugfWRD6Ep39tegsrSiqHgqOooOnq4ndVrpTrlvgVWww9OKrgvuUvV
 w0ARq+v7RgP0/WBJk62IhcGxM488Iodwz6ce+fE4MFFOuQbZiDFXYNYBHp+AB53CJTjDpRvDExz
 5P9d8uC8hkbXSSGdyYwOr6k3qQA8TUqphQBZ/Ul7iBRgclW/gtFNQJ/QDXcyZqtWZQ3X/KAE5vV
 YQykXqCFg3ok52TlOrUh51keeGl5jBxmAIjXWri0Pcruk5jrcssx3Ly6DCdUqLHob/guMLbsl5T
 AIEr0yL/chPrLY/R19XJSReW7buLvIiycPn47GGK1X33KintNH7l4oIRVEAQ6cVNHMYaeYJbien
 WXWED2KagYz19zzbMNVdtJ2RlyRCm5afxMvJVZzpX6SjKJhbGyL3gwDNJL6pqltfqPJoox0Nl1v
 MPv5ShKWkHkSsWeabw34thgnVKIRFqVF6LooHKYbcBv/EehyIBCM0sGI/e9XLUeMof1DusxRd8o
 w/wqo7I2GYD/GwQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 12:21:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2189

BitBake's doc now supports setting the active releases in the switchers
menu from an environment variable. Pass the active releases from the
list in yocto-docs/documentation/set_versions.py. This way we only have
to maintain active releases from the yocto-docs location.

The latest_branch information is retrieved from it, otherwise we land on
the in-development branch (2.14) instead of the latest stable one
(2.12) - at the time of writing this commit message.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index aa1847d..549032f 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -111,6 +111,11 @@ tar --exclude=eclipse -xJf ${docbookarchive_localpath}
 
 $scriptdir/docs_add_banner.py
 
+# Retrieve the active bitbake releases from the yocto active releases, by using
+# set_versions.py from yocto-docs
+BITBAKE_ACTIVE_RELEASES=$("$ypdocs"/set_versions.py bitbake-active-releases)
+export BITBAKE_ACTIVE_RELEASES
+
 cd $bbdocs
 mkdir -p $outputdir/bitbake
 
@@ -121,7 +126,8 @@ mkdir -p $outputdir/bitbake
 # see the latest releases.
 first_sphinx_commit=84ccba0f4aff91528f764523fe1205a354c889ed
 
-latest_branch=$(git branch --remote --contains "$first_sphinx_commit" --format '%(refname:lstrip=3)' --sort='-version:refname' | grep --max-count=1 "[0-9]*\.[0-9]*")
+# Get the latest branch from the active releases in BITBAKE_ACTIVE_RELEASES
+latest_branch="$(echo "$BITBAKE_ACTIVE_RELEASES" | cut -d',' -f1 | sort -V | tail -n 1)"
 
 for branch in 1.46 $(git branch --remote --contains "$first_sphinx_commit" --format '%(refname:lstrip=3)'); do
     if [ "$branch" = "HEAD" ]; then
@@ -132,7 +138,7 @@ for branch in 1.46 $(git branch --remote --contains "$first_sphinx_commit" --for
     git checkout $branch
     git reset --hard
     git clean -ffdx
-    git checkout origin/master releases.rst
+    git checkout origin/master releases.rst set_versions.py sphinx-static/switchers.js.in Makefile
 
     (
         . $builddir/buildtools/environment-setup*

-- 
2.51.0


