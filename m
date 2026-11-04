Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5539.1793784745471638524
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Nov 2026 01:32:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=jLIDh+Ge;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 62A0A4E413F5
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Nov 2026 09:32:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3930460770
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Nov 2026 09:32:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D5769103291F8;
	Wed,  4 Nov 2026 10:32:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793784742; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=benTEhhGzb7q52ggWJlgUJ2TezcbTCYD2PVD2kskx4o=;
	b=jLIDh+Ge/i4InHrCi1/Y73MsIn6sYFVk63rhUZ5KgVBzfukeyZDY9tvVKvsM2XdI2qyGZL
	mUfZwU5oYTUtN418cLXA1GPLf8SxqANp4du6YlQR1LVRoZ84v9JniRpJRB41Pv4rKbx0ik
	5AbpUvWKCuzWy3pwE7hn7fdxuEKjXc+zxfd+toLU3T4Tr4Cr5unXhOI5kawmWvoTrJSq1P
	96Uil2Av2VGI8HBl9u2icTNq9lmnCbfQ7aYZFPWo3Re0HK4O2wWaScStMs/9cu91fT8DBJ
	40hGg8Jn4TFfj0g0kXSlwYxu0RKoYLIkk3DnHiEu8/sBvX+8Wqy2Ws/VurlcVg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH yocto-autobuilder2 0/5] releaseselector: Fix know issues
 and improve configuration retrieval
Date: Wed, 04 Nov 2026 10:32:11 +0100
Message-Id: <20261104-mathieu-release-selector-fix-v1-0-a245895c0093@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJz76moC/x2M0QrCMBAEf6XcswdNqAr+ivhwJlt7UBu5NKKU/
 ruHT8ssw2xUYYpKl24jw1urlsUhHDpKkywPsGZnin08hdAP/JR1UjQ2zJAKrr5pLcajflgwjOG
 c5JgB8sTL4Pc/f6VvcY+lreXedM6wSLd9/wHFjJnhggAAAA==
X-Change-ID: 20261104-mathieu-release-selector-fix-ae4f17ca5dee
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793784741; l=1432;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=bDUMJQnWNtTrNIiHzyh1n9ZhUN0/UwU5EWwzWD8gpQQ=;
 b=XFnl2+6enXD6L84RY1C1GOE6PJOJR7Iqy0nHLz34ooeb6mIMXF1+3wv9mizxvZNYCOngnwW7L
 /B0rqj1cknRBH9C9bsrqffynTTXswZRyzIuDzoQjU9ILoZUow+y5liX
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Nov 2026 09:32:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5225

Try to fix known issue [1], where the selected configuration is not
applied correctly. Also improved the way we retrieve the configuration,
so we no longer use this hack where each list items contained the whole
configuration.

This was AI-assisted quite a lot, because JS... Still, the code looks
sane.

[1]: https://bugzilla.yoctoproject.org/show_bug.cgi?id=16291

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Mathieu Dubois-Briand (5):
      docker: Use https instead of git protocol
      docker: Refresh patches and fix configuration
      releaseselector: Fix release selector not applied on keyboard use
      releaseselector: Fix checkbox filling
      releaseselector: Read release shortcuts from the force scheduler spec

 docker/Dockerfile                                  |   8 +-
 docker/entry.sh                                    |   1 +
 ...builders-Do-not-create-tags-during-builds.patch |  10 +-
 ...Modify-free-space-check-to-work-in-docker.patch |  21 ++--
 yocto_console_view/src/releaseselectorfield.ts     | 107 +++++++++++----------
 yocto_console_view/yocto_console_view/__init__.py  |   9 +-
 6 files changed, 78 insertions(+), 78 deletions(-)
---
base-commit: 41f0281bea933dd4603a4fe25ddb9de8a062526f
change-id: 20261104-mathieu-release-selector-fix-ae4f17ca5dee

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

