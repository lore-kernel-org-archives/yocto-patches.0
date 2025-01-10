Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8782EE77188
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 15:30:40 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web11.21314.1736523032702465373
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 10 Jan 2025 07:30:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=XLf3d8Kv;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9E1AFFF80D;
	Fri, 10 Jan 2025 15:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736523030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wDmCE/jDXopJPMMz2fZ69heQKG41WgmxCPy47l4dC2A=;
	b=XLf3d8Kv++XvDRqumGKy8OgEaTU1/le+vtcOfXW3wnoq/fCM4rcDtETSHUSFTcApYfplbm
	uKQl2trEmq0TjsMe1MBXvk7GBfyKJC8u/zNn7EPMGmFRzDjQBaLWXOlCHWuQw0ji0Cskpr
	/euh6rmYv8HmTWF3ToQv7ZLhHah0CNMZWwIccOaqAWMVEm+2mBJ20v1pdi+Q1A0sGTJHS7
	thxDfgIZMXgO9UoRScr1zxe63lK5ABi7SkhL4iF3dU59OE5OzceycT63ZG3Sludpue/XQF
	zwyY8SkImwlRoYGISfXw7C2NXK7YPewY2rxm2z50ZGLUdkBKfo0nR6/72uHdog==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [yocto-autobuilder2][PATCH v2 0/2] Fix the docs build parameters
Date: Fri, 10 Jan 2025 16:30:04 +0100
Message-Id: <20250110-docs-build-shared-repos-v2-0-a83a7a09915d@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPw8gWcC/4WNTQqDMBBGryKz7pTEENSueg9xYX6sA9aRjJUW8
 e5NvUCX78H3vh0kJooCt2KHFDcS4jlDeSnAj/38iEghM5SqtEorg4G9oHvRFFDGPsWAKS4saPx
 gamfrJlQG8npJcaD3WW67zCPJyulzHm36Z/83N40aK2crZUPd2F7fHfM60Xz1/ITuOI4vM8NND
 MAAAAA=
X-Change-ID: 20250103-docs-build-shared-repos-3cf38b589d73
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=846;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=uTeb33BvyWuqxUa4+9+ERDHSjazFf8deieRIY7V4was=;
 b=kA0DAAgB0YBBQCmjqDYByyZiAGeBPRWgKN0Y+UMhgDqtZKAya6R/hIEZfFJcdRFzQsyBNFG13
 4kCMwQAAQgAHRYhBIZIclGI3UAbuaDT/9GAQUApo6g2BQJngT0VAAoJENGAQUApo6g2iaEP/0ZB
 7MXLAwz64wM1SMSKanG0wnUme+N79v+QNTPOKj+JbeZig5uHO8XGpouVap/NzuYq7z20sBhhR35
 IevwP69F4Spma53siESNkIhoZa7OvjJAfLT6IIt/QK0FlXA/fnmkfpTyrMyd6BmUEbe5aqIMQB2
 l4I9vtTi4lmvrpytA07uHiDPoNn+862EVBjU7EyqSei97ZGiCr5En/IYU4dvEXToXIRz5dSi+5Z
 AEmu2nPsYFZ+ACPdzXelfDR6zUJU/xqfigVF4usbbb/iT9a1ZQfzjw6h3VKnXFC1DWi8HlGHiJN
 1s9qhq3J9dy1T96EVqF2bVZv2U1imKSCriIc1hNmGC4D9QLvssgwmIiOlSM57bGWgSn6KGKxXAX
 VvwLONZhOz3Z62s6CpF5Ec+adpYxZah7UAaKd0ygoRGcyNGIxlvzQsur/oCtldyh6p9gazEb4nY
 smJeIOqasYU1uLP10T596F++uamV6jywxQc0ZhViprdrDrvbiXrxaiSYfwJxvEdlFCHjvbg0utN
 IxY3oPROxi3fQWYedVIwZNZySiv13f7yukVYfyNiJO3AJjySJ30YwhD9iqbF09OpHMKYo8iEEL0
 nbqUqW6Y1h4bk7IwEaFRMmuRkZLgtuD/XnCDXsQvIA3zdZBG7d2JZVXn178gL15M/wJ74P+gutO
 0w8es
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 10 Jan 2025 15:30:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/977

It wasn't possible to override the build properties when forcing a
build, fix it.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v2:
- Compared to v1 this does not require changes on the helper repo.
- Link to v1: https://lore.kernel.org/r/20250103-docs-build-shared-repos-v1-1-7b5705d895a1@bootlin.com

---
Antonin Godard (2):
      docs build: make it possible to override repo settings
      schedulers: docs: pass properties to branch schedulers

 builders.py   | 12 ++++++------
 config.py     |  2 +-
 schedulers.py | 35 +++++++++++++++++++++++++++++++----
 3 files changed, 38 insertions(+), 11 deletions(-)
---
base-commit: adb36c2213d331fd4a4fdcb5f48969b37bf1feb2
change-id: 20250103-docs-build-shared-repos-3cf38b589d73

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


