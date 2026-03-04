Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1976EF8FFC
	for <webhook@archiver.kernel.org>; Wed,  4 Mar 2026 15:59:54 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21785.1772639992003118856
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Mar 2026 07:59:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=0oPnxaZw;
 spf=pass (domain: smile.fr, ip: 209.85.128.54, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48371bb515eso105051915e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Mar 2026 07:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1772639990; x=1773244790; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NKGpKgXoTOjkdcByt+UwouH1OTTwvcM5aP6yRiJ7E20=;
        b=0oPnxaZwxh7WL+qNPcoQdSwye9WPvbUjV5vbvScD8d0VDpqN46/g6TktJQFP7nj9tq
         1QkvFIaQ4W8Xuy8EoDJ724bA+Nv13FGCMef4buCwSmew6YUZrEuqIvnTGlJU6LtKdWY3
         vFQ//BJEy8+zqKaiXMLxfZhQSLdlIrTIDu38M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772639990; x=1773244790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKGpKgXoTOjkdcByt+UwouH1OTTwvcM5aP6yRiJ7E20=;
        b=WXlNQupDPBFMrr+IayBTstjzH93ad72PqI64c1TZ7VkXrwovZ9pe+YZI1/BnGSn47u
         NAVtcMQIFLZtXdCrpi5ml26/1VSPxu8evivtEZPXtNaApvAR+xvxUG7LgyY8MCt32gP3
         qHm1B4vZAKI/4Xpw20YPnrYZMPjIF3nlIyGZumNb5NMledYzEnVx2Rio7kRgbbMd3NKk
         b0tc3ItxTGSqNg0y3JmUEpFgdBjOFiaVb6UC1UJD07rAAlE3vDqGmzJhPhjjc4gt4J5S
         G8ul9Vd+9/sfcFmLBsX/qPtZ35UPJjQF9+/IlQje9H0ELn+Te2kEWFN5oKWGQT0hxB0H
         lvYA==
X-Gm-Message-State: AOJu0Ywp+6HUmYBxhDjigh7z+B+pJXsXtBugpBdwNY9NqmEfOiRvbTt2
	g5FKcA5NQ0zfDIFmkcqSrfgLRMsWEj9WMgKToDaeP54L6H4bXqt+ghAI/GmkX0eu2TaOM0XTFjE
	ROanZ
X-Gm-Gg: ATEYQzz0VYQyX5kjy//0kDeWKPa9RjXySxGgM38VPAJrS59zQ8KlX84IEOHNPeyq9uv
	Jshg99a1Z97WxZ54d2vU6RRPDP7AUam53Tdky3sxuIcUuZozsq56Fh33kq9xjpJ/GNMkY1M75NA
	OfkTIn5fNtSa6sIcDu9rEUaHAapmOQNKzjy1CegCKQCQMA1/asOjC6u6tet9c/uJQtsGnGn0FPi
	/m/Bczlt1ONH7ql0f3WczRC8kBKsGWk/Qjk8GXn9vTs7CTAWmnPvaDm0o3FouhbJPFPO+KUDrou
	f1JO8bm0tT+/GjtsmeWzuF+e0sl8ast2uC8nlygrG8QP9YdPjqEZ8338eRPsi5Gq98etb9t7l7s
	OuD/HW3rZfdSLk+8iD8No6j6465bBvpN9kZkeUOmNeIjVWxW8cTDVMEyaKyaxvXXzuZ1FWF6P3N
	bYrXkGcy7VAPFuGZHA5NY4RIsogT0aCsV21pUEBrJmkTck4mYGWlVCA5hcLpbmmusoP4Q1RjCAa
	ZYrqn4NddlWnufrN2/OBOe10rUjKk5SKQ==
X-Received: by 2002:a05:600c:1d05:b0:47e:e57d:404 with SMTP id 5b1f17b1804b1-48519886971mr48120635e9.16.1772639990179;
        Wed, 04 Mar 2026 07:59:50 -0800 (PST)
Received: from FRSMI25-LASER.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851acf9b89sm11584115e9.13.2026.03.04.07.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 07:59:49 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Anibal Limon <anibal@limonsoftware.com>,
	Alexander Kanavin <alex@linutronix.de>,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [ptest-runner][PATCH v2] ptest-runner-collect-system-data: add info to logs
Date: Wed,  4 Mar 2026 16:59:22 +0100
Message-ID: <20260304155922.1121052-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Mar 2026 15:59:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3330

From: Yoann Congal <yoann.congal@smile.fr>

Print a banner to make it more clear what is happening when reading the
logs.

Add used commands to stdout by using shell's "set -x" (which prints used
commands to stderr, so, also redirect stderr to stdout).

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>

---
v1->v2: add comment for "exec 2>&1; set -x"
---
 ptest-runner-collect-system-data | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/ptest-runner-collect-system-data b/ptest-runner-collect-system-data
index ba335da..8023a74 100755
--- a/ptest-runner-collect-system-data
+++ b/ptest-runner-collect-system-data
@@ -1,5 +1,14 @@
 #!/bin/sh
 # Other ideas on what to do when a ptest gets stuck welcome.
+
+echo "Collected system state:"
+
+# Use set -x to print used command.
+# Since "set -x" prints on stderr and we log stdout, redirect stderr to stdout
+# first.
+exec 2>&1
+set -x
+
 dmesg
 pstree -a -l
 df

