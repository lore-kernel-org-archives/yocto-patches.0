Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E2EC44520
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 10:55:08 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6333.1784544904067275419
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Jul 2026 03:55:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JAOSKsPV;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so7242088f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jul 2026 03:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784544902; x=1785149702; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cq29+addh5wgAOiNFIYb+TZ5jq4jcQXBMT8UCDvPu0Q=;
        b=JAOSKsPVBlP9uDdLKVeWsbMa3hF7SDq+wR4TrjbOjpJkF5IdwE8ESvSVKnruaBlayO
         Igv9WjHDi3B9yizQEA2XNg5gdRW6EOEZuvneq3blIN+C5aXf5+vzDEOLMJbzOLszNC+0
         dmO51HzVMa7xbKetdao26+2ORBtEFMpHY+Obo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784544902; x=1785149702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cq29+addh5wgAOiNFIYb+TZ5jq4jcQXBMT8UCDvPu0Q=;
        b=cqnLyP7OD+VpZcqZ4hTDfqbM1TIN6s5L9v+O0OfEvEYPpVuSTI0A5jbhNVEpFpn7jC
         luJDwgKf+DmYKa4CcMdkqIE5aFLhACQzZuL3QBqnLTFUBknkF90RLfNyhORX7XuL+0g7
         UZ7WfyUvdlMxO6AY1YSQEo9iJxEmVypYLKw2z717PdAneZ2ErgdeHq/Xnh0MjGK6R+WA
         XBHrfnQZghfJSmffD6iqZU4N5mqdw7F/4JMhq7GGaUpvQnEI0HA/784RrgPONBBleSet
         7OCN7A5/JDDgdMS5XcmA1SOTIOkzMOjKWQJ8COq8PYkzTUDtUzz7U7Zlbext5CKdiQPh
         Sybw==
X-Gm-Message-State: AOJu0YyQcp7vcUP7iGqQ0XHtuZdu5wI4RhwtFho63bp8VZ9fPHkybp2N
	hC0Ft43JU2NLvPUGEft7N8wZw3UtaskxVhpFvnFnVWsr0O3D3ymFLtAqH3THGTrkI3h5gaQjUGT
	frDr8SRc=
X-Gm-Gg: AR+sD105boXkH+po9F/ciCm2qHJ9u65X4XHPM9KUTVPM20WqkSleM1HdaozdNy0AXMG
	WYinvHlgFh21nJzp9+eGQHTOVIuDdgavXmVUZVl9MEjkikKDprxTNUVSOsvnLwMGHfKGmMisWgq
	4oXQVam7/q5nEV44aKBxmJcOhU4oO6MpjEsloGSvEB//1QZOGCbnSeG3+JGqeGqybP44/nLIVBZ
	pOJa74IURRl8yewTrDtFc495eKSRfuro5vm0Y67h0AFyf5O21F4KU+qgnq9YrYt6ITWueNhXoFu
	N9qNFqg7QemiLFu3znzLOmGEVeQvQekhKNcjvh/tmqc2FWYTRYKA3PMFjwmDjESUi9mzmFRRQv8
	HlQA0Yn3tcu7bNCtal7pnvuXc7Gr1vTTcSahGj14xjVTMQ+D1VgxmitRX3C/hxZXtRX83KYIBIU
	6MzQNxIKNi8CcIQin3osXl/6NPpxBQ24s=
X-Received: by 2002:a05:6000:4301:b0:47f:6e08:bd51 with SMTP id ffacd0b85a97d-47f6e08bdf8mr9810119f8f.23.1784544902013;
        Mon, 20 Jul 2026 03:55:02 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:f231:f082:3d95:2084])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49500sm30628196f8f.2.2026.07.20.03.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:55:01 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [pseudo] [PATCH v2] linkat: Fix AT_EMPTY_PATH handling
Date: Mon, 20 Jul 2026 11:55:00 +0100
Message-ID: <20260720105500.1055844-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jul 2026 10:55:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4520

Currently we don't cover the case where AT_EMPTY_PATH is set for linkat.
Update the code to handle this case in a similar way to the /proc/self
case which is similar.

This is used by some systemd tools which OE might run at rootfs time
such as hwdb generation.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 ports/unix/guts/linkat.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/ports/unix/guts/linkat.c b/ports/unix/guts/linkat.c
index 60fbf63..3fd708c 100644
--- a/ports/unix/guts/linkat.c
+++ b/ports/unix/guts/linkat.c
@@ -35,13 +35,18 @@
 	}
 #endif
 	oldpath = oldname;
-	if (pseudo_chroot_len && !strncmp(oldpath, pseudo_chroot, pseudo_chroot_len) &&
+	if (oldpath && *oldpath && pseudo_chroot_len && !strncmp(oldpath, pseudo_chroot, pseudo_chroot_len) &&
 		oldpath[pseudo_chroot_len] == '/') {
 		oldpath += pseudo_chroot_len;
 	}
 
 	newpath = pseudo_root_path(__func__, __LINE__, newdirfd, newname, AT_SYMLINK_NOFOLLOW);
 
+	if ((!oldpath || !*oldpath) && (flags & AT_EMPTY_PATH)) {
+		tmpfile_fd = olddirfd;
+		// call actual link
+		rc = real_linkat(olddirfd, "", AT_FDCWD, newpath, flags);
+	} else
 	/* weird special case: if you link /proc/self/fd/N, you're supposed
 	 * to get a link to fd N. Used in conjunction with opening a directory
 	 * with O_TMPFILE in flags, which actually opens an already-deleted

