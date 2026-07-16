Return-Path: <bbnpreetsingh@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07548C43458
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 05:56:44 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6530.1784181396075573490
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Jul 2026 22:56:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ObE+d6VV;
 spf=pass (domain: gmail.com, ip: 209.85.214.180, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso30892525ad.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 22:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784181395; x=1784786195; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AwKaMWBoxkR+1R3vakqQh6DBR+OCEFK34SFDKGyxf2k=;
        b=ObE+d6VVDc6xdGhkJ+dHN4jUQ1fGsQ4yJdzIlMAsd3My4Lo6BLpsTRPdiyVC1w0KJU
         wq1FVE8hCCN8MQcdVOYPR8xNSekb3vzW/hzDp3BrqMAssfd0+S/LkhwN7gxWLIIdzIOS
         a0LCWCmd/c9AbCtUzdmx7H7F2CAlL/rhpluEtSfBhInUDjLF0G3tpqWeJJThYPbqNk7z
         Jon+G4xFNllycCMbIp8n271ZFepmiaitHU9OhHR3FUtTlUjYpV76g9m15EUScvNneabO
         Ly+pfkX6yAOgwlfNwhqNieIbCZCNJ7Z7TIoJ9E8JtgS2hHzZXdXkYzHdpasUH6Ar4R1u
         /7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784181395; x=1784786195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AwKaMWBoxkR+1R3vakqQh6DBR+OCEFK34SFDKGyxf2k=;
        b=rOiTDVEPS3pM+jqiip1WxW/tV1ypBr70ApEcs8IjMLTKosX56n0i9LTYrjF8DjfHXy
         eMtE7wxXvCDjoBQ3JZTytzY03iEN4VKEU5FcloIBgWbhhdWx7XKnlEEaFFymMftLlk1V
         U+WkaYpe35DagjHBc7nbj7Unvf3zfuGhcdz6BsFI3JEjHLoTWi+CNi6CLQbo90ZGtcPf
         W84SSmzPmv8CEvJ93m5xPNjfBJPCfHFznK7wiA0g/DJQKQ5J/4AUc8B+hvUSA8ARomzX
         JhkXt6VWieNzq33MvyMP1SinQzdKDXibPZEO0j0L6q0uNnmI+Oz3ebV6DvvRBMKmixDe
         CYtw==
X-Gm-Message-State: AOJu0YyvYZgpsGnpBmiyLQ/G69LE/8XmMEOTZ+5a3m8lGZmxSq5XOO2x
	Ltf4CYZqrXpNJfbOQuxU7e+P5lBJqbDTgxz20qIwajgS1vZDJ4zMsrwqpgxhOu0BY7U=
X-Gm-Gg: AfdE7cmgJW+vGArf0eSHTamCnr7eol5xnQ6b4sklreuglkXCwSu/4SjnHWDGtiTwMSL
	VIDMp3isfnUbeaRhww9tE8nJtWvGLrWl6KylJNSwgd8W13B/HU2jRrOj0W1yRZMT3lhvy+HoRBm
	+xjPkzsJChA5Hcz1H+DskmBfj4+WhrfLCDOTelpC1UVWfxGb8UBFsklbNgCpH0bW62qXtwbQU2+
	EZqslkHVFH2Ij0UPdZbyng+BHPjYYcjVNbW5zchpQz0eeLzrdfELIWAtZ3/ms4zA+Vuuv0hVDRF
	TF0YP+8A/HQMXPW8stuZi6DjHzs3TOUl8lUNrCQ7fWgYaR3uzLKQ2dDipaY1/vhpQxiX+o2NiZ3
	qmIvIyftr6Gn5+37u6LoJgCLCYySkVSWCE81Z8qXQr1VWTc6g7myewfemaR9tZ11AIYDZ8NZW5U
	kCbQ==
X-Received: by 2002:a17:902:ecce:b0:2c9:c083:cd50 with SMTP id d9443c01a7336-2ce9e9ac9acmr189912685ad.17.1784181395264;
        Wed, 15 Jul 2026 22:56:35 -0700 (PDT)
Received: from ydev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf100e44ecsm14124585ad.12.2026.07.15.22.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 22:56:34 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Paul Barker <paul@pbarker.dev>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Mark Hatle <mark.hatle@amd.com>,
	Randy MacLeod <randy.macleod@windriver.com>,
	Vincent Haupert <mail@vincent-haupert.de>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [pseudo] [PATCH v2 0/2] close_range: implement it rather than return ENOSYS
Date: Thu, 16 Jul 2026 05:56:31 +0000
Message-ID: <20260716055633.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715054142.7-1-bbnpreetsingh@gmail.com>
References: <20260715054142.7-1-bbnpreetsingh@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Jul 2026 05:56:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4490

pseudo's close_range() wrapper has returned ENOSYS unconditionally since
35433e6 ("ports/linux/guts: Add close_range wrapper for glibc 2.34").
systemd v260 deleted its /proc/self/fd fallback and treats a failure as
fatal, so under pseudo every fork+exec dies. That is [YOCTO #16339]. Full
story in v1:

  https://lore.kernel.org/yocto-patches/20260715054142.7-1-bbnpreetsingh@gmail.com/

Paul, thanks for the review. Changes in v2, both from it:

1/2: no code change apart from one comment. The commit message is
rewritten in plainer language throughout; the "takes descriptors with it
on the way out" sentence and the comment that repeated it now simply say
that invalid arguments are rejected with EINVAL before anything is
closed.

2/2: two real gaps closed.

  - CLOSE_RANGE_CLOEXEC needs a 5.11 kernel while the syscall itself needs
    5.9, so probing only for the syscall made the test fail on 5.9/5.10.
    The shell wrapper now probes for the flag separately, the same
    PSEUDO_DISABLED=1 way, and on such a kernel only the CLOEXEC part of
    the test is left out.

  - CLOSE_RANGE_UNSHARE is now tested against a real sharer, not argued
    from unshare() semantics: a child cloned with CLONE_FILES closes a
    shared descriptor with the flag set, and the parent must still hold it
    afterwards. A second child closes the same descriptor without the flag
    and the parent must see it gone, so a clone that quietly stopped
    sharing the table cannot make the first check pass vacuously.

The new test was checked for sensitivity by deliberately removing the
unshare() call from the wrapper: it fails with "child's CLOSE_RANGE_UNSHARE
closed the parent's fd 3", and passes with the real implementation. The
5.9/5.10 probe path cannot be exercised end to end on this host (6.17
kernel); the --no-cloexec branch it selects was run directly under pseudo
and passes. Full run_tests.sh is unchanged from master apart from the new
test passing (the two pre-existing flaky parallel-* failures show up either
way).

The v1 question about OP_CLOSEFROM stepping around five of pseudo's
descriptors while others exist (pseudo_prefix_dir_fd, pseudo_pwd_lck_fd,
pseudo_util_evlog_fd) still stands; happy to send a follow-up if that list
is short in both places.

Babanpreet Singh (2):
  ports/linux/guts: Implement close_range() instead of returning ENOSYS
  tests: Add close_range() test

 enums/op.in                    |   1 +
 ports/linux/guts/close_range.c |  54 ++++++-
 ports/linux/portdefs.h         |  16 ++
 pseudo_client.c                |  60 +++++++
 test/test-close-range.c        | 283 +++++++++++++++++++++++++++++++++
 test/test-close-range.sh       |  24 +++
 6 files changed, 431 insertions(+), 7 deletions(-)
 create mode 100644 test/test-close-range.c
 create mode 100755 test/test-close-range.sh

-- 
2.43.0


