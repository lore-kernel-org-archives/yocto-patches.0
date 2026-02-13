Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8EDEDF16F
	for <webhook@archiver.kernel.org>; Fri, 13 Feb 2026 14:28:23 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.72853.1770992899339065011
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Feb 2026 06:28:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=mN1RaCqW;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2D7F51A0EC0
	for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Feb 2026 14:28:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EFFE3606BE
	for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Feb 2026 14:28:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E05B10368E63;
	Fri, 13 Feb 2026 15:28:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770992896; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=yFqUK1+4pUgkH3lm71yQA8anUuj91HIAWVFQ2lNT12w=;
	b=mN1RaCqWGGbPTYQA29R2gB75t1gT6SxyHl0O2v122WGS63cmqNzLyxEB9aChm1YPCHY0Z5
	qRcqmwBar8qshNnzI3S7Zx7+rZEE/wRD9xaaaV/WPVb0KORfklMwnaReYpQMo+IZ5BBIp8
	Cf5PXfM3PsQ+YH6kgkJQ8fh9prDHEzLyuIPPEQNjxK7te2lDrD5zsvt7rAKI4DnTpxXW7r
	Iz3vcTiV1vTB0OaeZt67eJ4l2RqxPhdtZbX4qSjpI1HFMDh1DcIRtMaB4Afpk16vWWHQoh
	ksQ7JppbdLN+mUXKMtLrl+cDJBjYvI0AdVuKaRah2sqd3OsgnBPjelebKGO9+Q==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH error-report-web 0/2] settings: Increase maximum upload
 size
Date: Fri, 13 Feb 2026 15:28:08 +0100
Message-Id: <20260213-mathieu-too-big-data-v1-0-2f2c28ebb28a@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPg0j2kC/x3MQQ6CMBBG4auQWTtJW9FEr2JctPQXZiFDpkVNC
 Hencfkt3tuowASF7t1Gho8U0bnBnzoapjiPYMnNFFy4uuDP/I51EqxcVTnJyDnWyEMK7uZdyug
 v1NLF8JLff/sgmKmxYVGr/EWi574fESV9OHgAAAA=
X-Change-ID: 20260213-mathieu-too-big-data-cb20910bde45
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770992895; l=685;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=1F7kLl+mwTZt6K9qwv1iLT3akRHwr+JH6PNjNsaNkPs=;
 b=zDTrCH8q/G+Pakdduw7JvL6a1x8hphtGxaGH+QsLZTDgK5aHWyUR2cnUCj8xQOeqqI0pB2V6V
 YNA1kkZBHRABjRqPxfuDSp9iIm1Qj6xURfscOfbh8iKj0fkK9eyjb3f
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Feb 2026 14:28:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3235

Fixing errors on the "Sending error reports" step of recent a-full
builds with long failure logs.

https://bugzilla.yoctoproject.org/show_bug.cgi?id=16165

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Mathieu Dubois-Briand (2):
      views: Return descriptive error on too big request
      settings: Increase maximum upload size

 Post/views.py       | 8 ++++++--
 project/settings.py | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)
---
base-commit: 88b1f10aa3ca477ba28f6a2497d0c8bbe4d85642
change-id: 20260213-mathieu-too-big-data-cb20910bde45

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


