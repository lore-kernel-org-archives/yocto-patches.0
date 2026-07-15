Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494A8C44507
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 09:06:46 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.479.1784094104802181398
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Jul 2026 22:41:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=cqA0fOab;
 spf=pass (domain: gmail.com, ip: 209.85.210.174, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84861fc51f5so2953546b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 14 Jul 2026 22:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784094104; x=1784698904; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WBHW1WSxrYadLF0M5JpPEM0Or0xr8G9kX3GTaup0HRk=;
        b=cqA0fOabf0XpNwjBnrWGaey6PI6bd/PJKzjycp+HSK0xIN6h/0Hm0aV+Eq288iKy38
         6j9abX9uH4WXgVi+lNelxAX14eOUXZn+X/H+f/PLlkljh5+Ujffi2f1N04yqfkWaC1XI
         m8StMxsEdW6fz7GHLjOh2S6YC80LoynU6KHQtb60b2Lq2fz1Br2TtuJJjCkI1EUrQHPS
         X64WQJI6cbULm7o899dG+emXE5SMTNGsJZEb2JTvM6oVVlXYtlVxLDzMA0jY3XAmJcYQ
         vHINDSuavV8IWCIYCXqzPS9BKmFL8ARx9DOeev4iitiqqhW1YDg9Y50WE2KPCued6bD4
         u//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784094104; x=1784698904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WBHW1WSxrYadLF0M5JpPEM0Or0xr8G9kX3GTaup0HRk=;
        b=G41YS5sZOx3MTQgEQm3283U3CzB+UrQqOLrzgokf86jPVPinMxNx30m6K3+0xvcVKw
         ZhIZBKXSoIgOhAdRPCTtuH9dM4QSZAx48TjUj9xkyZLCGNhKQ0f12D6DIYpu126WGj06
         06/XRMqaALtsPeqdPmX2DKUUdm0NoIysDDh116oKtKOY0owL9waZ2rIU0cPm9vade4yz
         BsmtZ33SQz/vaP4ZS/qaT/Grc7wc38IRG1L36MRJfnKJeTJBbvxTwB4xmRHmXM4tT+EI
         4GCrftLYKMoL9gnYRBuvsyB8YE5/CS+6L+RnCSj5vNx1tQLxNfrhJ4C2vCOQC3ZntYhN
         pkUw==
X-Gm-Message-State: AOJu0YwBVgSLNmGHvR3nY1lNNTSOTvS7tTAQ0jwnYyptUzf5SUJei6UL
	EICKvBm43SLaWNhngK6tEtHBKhEBtC61n5AM2uOs4ijgE3RFD5a3r0zCrbkbFf9+IBQ=
X-Gm-Gg: AfdE7cnW7VYt0fxLFxdPkWPMb1QtiodZbEUQWCwLUh2wPn5RH4KvhxMTl7sT7aS9FeK
	Un4uem8tghGi/ZoJVKIenQdIuVGWGUIDfHJ4RHG+59WE4BUWC2S3JfW5i5UkBiIg7K20P4mViUd
	AQ+Jeyiw/0JdePFBW8tFxh3KnpL6sF2MQs/J0VV3/+0r7eDsMa1FP0UKbu8Rb5JBoqeIhYLWwgZ
	enYmvNDyQAznmTcsOBCBaqO5gHbMJXHcXHKvDl833XCJgyj2yUtsiMxRDma9SZTtyWncVBMtep5
	PAfvMx08QAPvdaaKEwJTJbl5JnGfyNjJ1Hfayq7LEb1tNeKgbls05cqYB8qBSXJespHX6bTj4k7
	JxjsFQVnXCs/0rvJ6X+3INBhU6/zKArERM/ye0T+IL0m5zbqJQ7AeGHNt11Ftp0ss5FaBR5+K3M
	OIef6ABRubGBiS
X-Received: by 2002:a05:6a00:9286:b0:848:65f3:23c1 with SMTP id d2e1a72fcca58-84a673aab51mr1175239b3a.69.1784094104042;
        Tue, 14 Jul 2026 22:41:44 -0700 (PDT)
Received: from ydev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f264989sm2550668b3a.13.2026.07.14.22.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 22:41:43 -0700 (PDT)
From: "Baban" <bbnpreetsingh@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Mark Hatle <mark.hatle@amd.com>,
	Randy MacLeod <randy.macleod@windriver.com>,
	Vincent Haupert <mail@vincent-haupert.de>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [pseudo] [PATCH 0/2] close_range: implement it rather than return ENOSYS
Date: Wed, 15 Jul 2026 05:41:40 +0000
Message-ID: <20260715054142.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 09:06:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4478

pseudo's close_range() wrapper has returned ENOSYS unconditionally since
35433e6 ("ports/linux/guts: Add close_range wrapper for glibc 2.34"). That
was a deliberate call, and the commit message says why: "This one is
straight forward as it allows ENOSYS to be returned and the caller has to
handle it so lets do that."

It held for five years. It doesn't any more. systemd's close_all_fds() has
called close_range() since v247, but v260 raised its kernel baseline to
5.10, concluded close_range() (5.9) is always present, deleted its
/proc/self/fd fallback and started treating a failure as fatal.
safe_fork_full() then aborts the child, so under pseudo every fork+exec
dies:

    Failed to close all file descriptors: Function not implemented
    '(mkfs)' failed with exit status 1.

That is [YOCTO #16339], reported by Vincent Haupert against a
systemd-repart image build.

Vincent - Randy asked on the bug whether you wanted to send a patch for
this, and that question was addressed to you, not to the list. It had been
quiet for a few days and this looked worth picking up, but if you already
have it in progress please say so and ignore this series. I'm happy to
defer.

1/2 implements it. The stub was protecting something real: pseudo keeps its
own descriptors, including the socket to its server, inside the range a
caller asks to close, and the kernel does the closing, so pseudo cannot ask
it to skip one. Returning ENOSYS pushed callers onto the /proc loop, which
closes one fd at a time through close() - a path pseudo already wraps and
can defend itself inside. With the fallback gone, that no longer works.

So this follows the shape 21ff2fb ("ports/linux/guts: Add closefrom support
for glibc 2.34") already established for the same problem: a client-side op
works out the first fd above every descriptor pseudo keeps, closes the ones
below it by hand while stepping around its own, and hands that fd back so
the kernel is only turned loose on the tail that is safe. close_range() has
a top end where closefrom() does not, so both the manual loop and the path
table cleanup are bounded by maxfd.

The flags are settled before any of that. CLOSE_RANGE_UNSHARE has to take
effect first, or descriptors get closed for everyone still sharing the
table rather than just for us. CLOSE_RANGE_CLOEXEC closes nothing and
pseudo's own fds are close-on-exec already, so there is nothing to protect
and it goes straight to the kernel. An unknown flag or an inverted range is
refused up front, matching the kernel.

2/2 adds a test. It probes for kernel support with PSEUDO_DISABLED=1 first,
so that a wrapper which goes back to returning ENOSYS fails the test rather
than quietly skipping it.

Tested on x86_64 (Ubuntu 24.04, glibc 2.39). close_range() under pseudo is
identical to a run without pseudo across eight cases: single fd, bounded
range, both flags, an inverted range, an unknown flag, an already-closed
fd, and an unbounded range. pseudo also comes through close_range(3, ~0U, 0)
with its server connection intact and still tracking ownership, which is
the case that actually matters here. run_tests.sh is unchanged from master
apart from the new test passing (two pre-existing flaky parallel-* failures
show up either way).

Comparing against the real kernel is what caught the argument validation:
without it, close_range(3, 3, 0x80) returned success and closed fd 3, on a
call the kernel rejects outright.

Not tested: x86_64 only, no 32-bit/aarch64/riscv build; no end-to-end
systemd-repart reproduction, the ENOSYS-to-working transition is shown
directly instead; and CLOSE_RANGE_UNSHARE is exercised for return value and
closing behaviour but not against a real process sharing the descriptor
table, so its isolating effect rests on unshare(CLONE_FILES) semantics
rather than observation.

One question while I was in here. OP_CLOSEFROM steps around five of pseudo's
descriptors, but there are others it doesn't mention - pseudo_prefix_dir_fd,
pseudo_pwd_lck_fd, pseudo_util_evlog_fd. I kept the new op consistent with
the existing five rather than change closefrom()'s behaviour as a drive-by,
but if that list is short then it's short in both places and I'm happy to
send a follow-up.

Babanpreet Singh (2):
  ports/linux/guts: Implement close_range() instead of returning ENOSYS
  tests: Add close_range() test

 enums/op.in                    |   1 +
 ports/linux/guts/close_range.c |  55 +++++++++--
 ports/linux/portdefs.h         |  16 ++++
 pseudo_client.c                |  60 ++++++++++++
 test/test-close-range.c        | 167 +++++++++++++++++++++++++++++++++
 test/test-close-range.sh       |  16 ++++
 6 files changed, 308 insertions(+), 7 deletions(-)
 create mode 100644 test/test-close-range.c
 create mode 100755 test/test-close-range.sh

-- 
2.43.0


