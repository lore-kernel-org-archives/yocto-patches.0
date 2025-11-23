Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CE0CFD316
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:43 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5046.1763941537795813370
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=k0y35A7W;
 spf=pass (domain: konsulko.com, ip: 209.85.222.171, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b22624bcdaso481169385a.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941537; x=1764546337; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HJZfxV0y8GsEIC4tyT0hFfqa4Os96Kfl9qY6quyZiY=;
        b=k0y35A7Wv/T+BkV9gwiSkygmMbp0RaBoCtNxCzER6JPhL93rWn1IOdgZMN3y3Wna48
         gMHJReG+Gn1eJOp+tItRDWaWJEBDoi15QGfMffc7dYwp6ljzjCwUkxwWfN8i4p4realG
         Wh6ZnMUZJyQQ8d6cz/MxSIDSLc/qOy95r+Qao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941537; x=1764546337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+HJZfxV0y8GsEIC4tyT0hFfqa4Os96Kfl9qY6quyZiY=;
        b=IRUb8UyIM8p34ijfOsBmW8Wd7OhqM+4p6U04JSw8SiWxa32pB4kqy1jy5iPaCmP84F
         O4l3fV1ASWSwWFRpS+qFsJnKFXJhKTiagTiBDeh8R9OhF/9SfelPRdWRHhc9m5+D81MD
         h0bureMVhilNqxuAUG4ZhkoEF08/9bu/pih4T4p9J4031i/RQQPvzx1bVjEWOnk9f8hL
         0HoybP9wcGqfNBnhg0eAFfrls4k91otoZ9Jsk+tmjtPgbgJmWSdtHsHcvTz/NFZhly4d
         b8X7hIH5JKDCKoRDvIWmtyW/HQ8fAYZdTgnSW+4oBIvV62xKr1G5zDnMuruih/CGBGGq
         tQ5Q==
X-Gm-Message-State: AOJu0Yw66NSqNqviWIiIjNGuAgNCWRGovjkcV7FZsxtYwv/aX7TVfshV
	hk5NVNyKYLw9Zudss2D6phWoJG2PwzVtaup0Cr8r3aQW3Ot14ky6cqQQb18yRMhPzI5q6T5o5Pm
	IXTAz
X-Gm-Gg: ASbGnctricOze+B+VOCM+KWnSG/gf1VyVLaDsjP9WoKjDS9tYoLVyGQrnEicCp7P5YB
	LvV79XQ1u8ev6tbDSjzRV7DmOFdFT6yvvMkbm+EA1gRbjUgpZ1wwqF+/n913FqzrwdNKiFziMa2
	5hE8eF6PqFr67Jpa6Eowiv396fequiKu9c7ge8q0SAGWTqrO6b+PyGiEl/fL0rBm9nJftcdqBGN
	n6ixJg7nzXxntnaE5epDfcKHpvC8wed4QBxfwnpjh+j2giJUxPyCVj+lf9QOnUgs4ZXPqvPaIs4
	P78UnLeEiLKhZwhAVPEh5WKOKrUXmZVlo5/JGVuWoSjJS9v2r+O2bS9y6F3WV8qbbjbAXN2MZb2
	VEQx5Ys6tGpGUf+CLvCywJj5jxDTY2fm68yr3zV4s+iWC8vAGu0BxFPMYsc90EiPWLDcsssc3in
	tDYnTzJCohqDpun6jR46g+NQgd2QsEe0IQVVdFI7XqcToWwlAhamqvl2qg8DByoFA=
X-Google-Smtp-Source: AGHT+IHNAY+dXqSqHfVPjgAFvaM2yxCyZ/A96CKkUGDFOkm0J8R5HNOga4CDCYyG1VNDZilSWYupmg==
X-Received: by 2002:a05:620a:470d:b0:8b2:e666:713 with SMTP id af79cd13be357-8b33d476f8cmr1301540785a.42.1763941536495;
        Sun, 23 Nov 2025 15:45:36 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.35
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:35 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 19/32] smack: Switch to CVE_STATUS
Date: Sun, 23 Nov 2025 18:44:59 -0500
Message-ID: <e748adce70a696e477f7ffed064abf5b9af981e8.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2677

From: Aidan Stewart <astewart@tektelic.com>

CVE_CHECK_IGNORE has been deprecated starting with the Nanbield
release.

Signed-off-by: Aidan Stewart <astewart@tektelic.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-mac/smack/smack_1.3.1.bb | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/recipes-mac/smack/smack_1.3.1.bb b/recipes-mac/smack/smack_1.3.1.bb
index 6c52392..04e7a6e 100644
--- a/recipes-mac/smack/smack_1.3.1.bb
+++ b/recipes-mac/smack/smack_1.3.1.bb
@@ -13,10 +13,9 @@ SRC_URI = " \
 
 PV = "1.3.1"
 
-# CVE-2014-0363, CVE-2014-0364, CVE-2016-10027 is valnerble for other product.
-CVE_CHECK_IGNORE += "CVE-2014-0363"
-CVE_CHECK_IGNORE += "CVE-2014-0364"
-CVE_CHECK_IGNORE += "CVE-2016-10027"
+CVE_STATUS[CVE-2014-0363] = "cpe-incorrect: Affects Ignite Realtime Smack XMPP API"
+CVE_STATUS[CVE-2014-0364] = "cpe-incorrect: Affects Ignite Realtime Smack XMPP API"
+CVE_STATUS[CVE-2016-10027] = "cpe-incorrect: Affects Ignite Realtime Smack XMPP API"
 
 inherit autotools update-rc.d pkgconfig ptest
 inherit ${@bb.utils.contains('VIRTUAL-RUNTIME_init_manager','systemd','systemd','', d)}
-- 
2.47.3


