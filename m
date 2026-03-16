Return-Path: <hfranco@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB09FB5E8B
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 23:23:23 +0000 (UTC)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.64608.1773703398789532896
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Mar 2026 16:23:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=TrdORX4/;
 spf=pass (domain: baylibre.com, ip: 74.125.82.43, mailfrom: hfranco@baylibre.com)
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-128e3125372so190170c88.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 16:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773703398; x=1774308198; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9kgX64gSNwFVSVK9EStn3oyrQZi2OG1aDciX8prsuSE=;
        b=TrdORX4/+1avWs9uplYm93NOoperGXlCVMl9ESbLESC1N/RRzqGgPyXCTb3jQzqwKk
         yaTcqTJnG/0sGwNnHdPu+9IhH/5K8lLUHmJ9Z1yY+uoEFv6iYcbkXqcp+6GdXeYgyW51
         06ef9eJ7e4SWMwbLFAIJHhweUI1zx+Qm/ZZS4NyN5c78aTBlfw5s61HWwqIAhVh1oNLd
         mqQ4l+j2ncyHzjcvxEFB/8LWTaOAgFBGnbJm/KKTk6hKaJdOsItVvzmJ9c/uxKYRrwDP
         GgtGGv9WNilr/k+JnOtaECXL1Yv13c8TwZ+U5ggBIGgEW5QM+46vDxyqFHtEU/70cSqp
         IhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773703398; x=1774308198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9kgX64gSNwFVSVK9EStn3oyrQZi2OG1aDciX8prsuSE=;
        b=g3fJpDb+tbZwcoXctQceRJ+RB1oy5CnBdMsc12LMjr07DBqybjzFu8EF1xCKdu7JJ9
         RpMivJP/UyXsJ5j5I9FDWZoQiCy/bFQ1KRLswGj0GjD3Pdim4KRzKUzjVsuvTwfPP0PW
         XMRmJAJx/tYS9z0loLy4N3qSlP0Ku8qGEcsmcuWGMQaZCO8QqUY1RPk+EZln0o0tuHz9
         EtXnefeoFlPc7bFdsr2ZiFYsu7t7L3dIXWXfy/DYc3hZvmK3xPfRd+rLMRZH0xRNB9wX
         PU2w6Yg0TcIRbz9Xo2HvLJHAVpdXsT4MbjXy7c9iiwirgJ13WtWW3YFV4NrTqqyF1To8
         9+pA==
X-Gm-Message-State: AOJu0YwD05Ij8wf1fh5iKzDGfcxN0iXORwXPmHcL+8A9pVklZl3PS0lS
	iT+WsUmMNvaP8yxFzrBTtDdqTDd4oSIdlEcPPpsQ8sC6D1nQQLpEbmV/UidtkRM0hIH4Q0QIw18
	qNikdmNQ=
X-Gm-Gg: ATEYQzynWe7r499PB6LboL5OsfgOMBYY1Fj2Kv0CllF4IRu7vIohxG7+Z3PfD1psZ/B
	G4nSmMXaUVrAjzM9ZiFuEqCC/rrR0SX5o6q+WJrK/sErQhRYapOoDZu4CLshjv4E4g0jm95Arv8
	saFPK6x0MENQpxatOBTrJiibdssbzXEKb8QAMXl6LVdmuz3yftWawJ+cbAB/dyu4B4OyfKZbzjg
	VjgM7r2xPKIUmwJCedi7MNXvVNpjq6TJxWFg7bSR8zhXR9Jv5bpgy2mPaE99enjh+KRCzn/t8tN
	IBPuOBZstXWQJf/yx/awpqYJoC4vRLf8+kieDZWlTA5plHEXGUvoe/aSUyimehky4fXWFtrG4T5
	l9XD5y/0VHMkYSk1FrMHjGdEr7iBsWKCt6zFx+Y8fcqy21HiUARHZX++LiEp5DErTzMEZAyv0Y/
	yeDAOemwORQhp49Ly4gtP9vehQEtWKmCzdVfCQc5TpbMeLAcg8fsJ9lC1LAD/yjgTUWYEVFJ991
	bUSXdBN/OwtAfFES/g0
X-Received: by 2002:a05:7022:90f:b0:128:d5bd:3557 with SMTP id a92af1059eb24-1291720665bmr724678c88.4.1773703397664;
        Mon, 16 Mar 2026 16:23:17 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a7c0:c4f1:ec8d:3c3c:583d:3ed])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f6384e7asm13492586c88.11.2026.03.16.16.23.15
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 16:23:17 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][scarthgap][PATCH 0/2] Backport patches to
Date: Mon, 16 Mar 2026 20:21:56 -0300
Message-ID: <20260316232253.937832-1-hfranco@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 23:23:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3479

This series backports two patches for meta-selinux scarthgap:

The first patch adds support for a configurable policy store root via
the POLICY_STORE_ROOT variable, which, by default, are stored under
/var.

The second patch ensures SELinux file contexts are preserved in tarball
images by appending '--selinux' to IMAGE_CMD_TAR.

This second patch had a conflict between policy version 35 (master) vs
33 (scarthgap), so I preserved version 33.

Sasi Kumar Maddineni (2):
  selinux-image: Preserve SELinux contexts in tarballs
  refpolicy: Add support to configure policy store root

 classes/selinux-image.bbclass                 |  2 ++
 .../refpolicy/refpolicy-minimum_git.bb        |  2 +-
 .../refpolicy/refpolicy_common.inc            |  9 ++++++---
 recipes-security/selinux/libsemanage_3.7.bb   | 20 ++++++++++++++++---
 4 files changed, 26 insertions(+), 7 deletions(-)

-- 
2.47.3


