Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD08C79F99
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 11:19:40 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32728.1788779970636890397
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Sep 2026 04:19:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gQ/zvSfb;
 spf=pass (domain: gmail.com, ip: 209.85.208.46, mailfrom: frezidok1@gmail.com)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so5074528a12.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 04:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788779969; x=1789384769; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7v+ubDANetaWbzT5wbRTpx5HILRKLe1vgl5Lj+35D7Q=;
        b=gQ/zvSfbJceQuqWENRmQ0C+LyZgRueIDy3Z634PUF7Xmdd9bUnsArNvtJgYiRgFiPU
         kKp8tx0Rbg1euXz5nbqXtFpukeBDhVQeQBTr/4eb0++/MEyYzb9PCaYn0Hge/DeEoN+Y
         OgEg4n1KUrvLXptG6whx5S7nEqluskgD+pDxpANmVDvYPrV4GR8nXIDh+DpuFhNgrQKy
         Z3nLEAx9iD/rTl7qOAQnGtvca6+S/n0Ou0vapJgpIojRBAbPuXYaa6er7CUJKkY6OzAq
         smCIyF0jGmU43qhagtNyMeXife1Z21Oqrm7Mkq1ijs+dbctaiXCNveaeLQFy8ZeEB+W/
         C/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788779969; x=1789384769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7v+ubDANetaWbzT5wbRTpx5HILRKLe1vgl5Lj+35D7Q=;
        b=PLvDDZ1KBEatqWjvB22I/6B/1Vq4S3MVX59q78QNjQuQsHr+twsxY8InRR9krz3x6G
         M0Qqhl0r//jhRRsr0tx3jlo8T36n6UjJu3tYIrI1oZW/0o/kEcDYt9UUpzjMVBfvB5yN
         7R1UOmwXOwwRaG6fa8FznRA3PUn67VO2WlDed0KoHMtZZT93bYYpL2CoWX2EG+WjVWpu
         /1j7DOb9MWj0/KwEkMP1wE4EtbVrlh7L8vEumZbSYIyORYgcw4f9dgLIOrYyYW4eNDte
         o4a8Ujrj+7l5fvBVtZWQeUzLNDjDRF9WLCS6+tIZ533tzp3gbwY7blRIjWhgI1qZg0kA
         sHSQ==
X-Gm-Message-State: AFuF++kr+S9c08pEAtGgBZ8BA1s0hYGf1j658eCFSanYSPMoMPxv00PM
	vufCsLJ4OeOj1oyawwXlEu4nsyYeU58+wOFXerDBikUKJXHM9uCr8jEcTx+oFYA8
X-Gm-Gg: AYBFou3URGx3KHhEZGIM6sSw5F3K16VmjKRTQcTt24DsntOH0ZcN3JwOyk1cIAjmSMX
	JQGSy3ost7XF11Uhv3wm3hA5hY7mmJTtzKQNVaAncvBpeNhoTBaCrXvvF2qE9ZOE+hcJM0x9kPv
	iziTZIk1VP/7j48/afJAADm/7r2u11vupO8z39ekCT6k8hnZTwjjVQmKSrv87HY35slADXcPhNj
	cK2iMkPeUDWohH0XZZZO6AKAInkfOfxI4NTQ338DWaOAKzswYY9XwUyF7/3VJLheIgI6aNAtwAF
	/WEa69trl3dzXulLCJBwClxZNXDcv+/GL48G0SPzSiz0Bkiay6l0ljFJATuIS47K2cteX18sZOp
	oveY4llpiK8dNJ4KABwfIQHclc4pluiCUd7fqWFBQxRJz+kp7YPIwnMMcp8y7CuEL9i/0H9DyoY
	Tc/DW8mEUKemGUaOndQkbuRgY03Q+r2/4ujFr1OvZL6p+W07zgKsHYA4t1
X-Received: by 2002:a05:6402:27c9:b0:6a8:58e:50f with SMTP id 4fb4d7f45d1cf-6a8058e098amr3977117a12.6.1788779968598;
        Mon, 07 Sep 2026 04:19:28 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6c20a41sm4200117a12.31.2026.09.07.04.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:19:27 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH v3 0/6] Add open_tree() wrapper
Date: Mon,  7 Sep 2026 14:18:37 +0300
Message-ID: <20260907111843.26746-1-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 11:19:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4741

From: Dmitry Sakhonchik <frezidok1@gmail.com>

v2:
- Handle relative paths correctly in the open_tree wrapper
- Add fallback to SYS_open_tree when libc function is absent
- Add tests coverage with relative paths (dirfd != AT_FDCWD)
- Add support and tests for syscall(SYS_open_tree, ...)

v3:
- Add open_tree_attr wrapper
- Add open_tree_attr syscall test

Dmitry Sakhonchik (6):
  ports/linux/guts: Add open_tree wrapper
  test: Add open_tree test
  ports/linux/pseudo_wrappers.c: Add syscall support for open_tree()
    wrapper
  test: Add open_tree syscall test
  test: Add open_tree_attr syscall test
  ports/linux/guts: Add open_tree_attr wrapper

 ports/linux/guts/open_tree.c        |  46 ++++++++
 ports/linux/guts/open_tree_attr.c   |  48 ++++++++
 ports/linux/portdefs.h              |  18 +++
 ports/linux/pseudo_wrappers.c       |  30 +++++
 ports/linux/wrapfuncs.in            |   2 +
 pseudo_wrappers.c                   |   1 +
 test/test-open_tree-syscall.c       | 152 +++++++++++++++++++++++++
 test/test-open_tree-syscall.sh      |   5 +
 test/test-open_tree.c               | 139 +++++++++++++++++++++++
 test/test-open_tree.sh              |   5 +
 test/test-open_tree_attr-syscall.c  | 165 ++++++++++++++++++++++++++++
 test/test-open_tree_attr-syscall.sh |   5 +
 12 files changed, 616 insertions(+)
 create mode 100644 ports/linux/guts/open_tree.c
 create mode 100644 ports/linux/guts/open_tree_attr.c
 create mode 100644 test/test-open_tree-syscall.c
 create mode 100755 test/test-open_tree-syscall.sh
 create mode 100644 test/test-open_tree.c
 create mode 100755 test/test-open_tree.sh
 create mode 100644 test/test-open_tree_attr-syscall.c
 create mode 100755 test/test-open_tree_attr-syscall.sh


