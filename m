Return-Path: <bbnpreetsingh@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC646C561E6
	for <webhook@archiver.kernel.org>; Wed,  5 Aug 2026 06:23:02 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34400.1785910980674661660
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Aug 2026 23:23:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=oxgGVFSw;
 spf=pass (domain: gmail.com, ip: 209.85.214.182, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caced6038eso8262815ad.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Aug 2026 23:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785910980; x=1786515780; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=otf/iB+RQwD98PDG3BM6gOif+SO9rjvnmAaj1Ph9wMQ=;
        b=oxgGVFSw/m0F7Q8hVrIRX+kQ0zOfh74z6Crowf2cc4ObAMTxMNXUCbLAkRKJbWZBh/
         Q/8/fjxn71YE6UW/zY362N23Nqf8ILh60tuLB/JeYXSVgrUBhd5ODWpmDrGipvEIU81C
         0d5bsEAXvesvQPbuquvg/9E59uNSZ6xLYMECXa8O4On1ud/+oSx5ATmondb4En53ODTv
         0jqaQw7byiHRdzqB/fpihHGF6FFoUMtpjSeC73gVM2VerC0vw4h9iddyFPgUIbkqPeVa
         8qqUOyzXkD7sKs8g94zM6gkENHLdjxnb6IZ7TFPbFNvffKAeLYZ6cLmcZTF0Nc8bSYCj
         tBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785910980; x=1786515780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=otf/iB+RQwD98PDG3BM6gOif+SO9rjvnmAaj1Ph9wMQ=;
        b=BOoOlDfhIbP3NvC5daWJQK4z/wCGSligDTy8/uANp/BRcGR/tWR/cI77cdEvWW0d0z
         uCbKni0nvlZhyLkGklcefg0MLX2AvKXuFbTNEBB3tqfF9FoNpt45+dndXwAe0+Jf5SNo
         uq7KUqNoY5vxZwBD9y0tHm9veu2+d1Db6f27qhqrBqHdMiPaVUKSeMZTN3/QEsp17WFJ
         1ENpy6mIczSG5Pp2gpF+QLrIMrHiK7h5MJ4G6WWzK6L5n/E1w6P0VXTxZCWgz7BcRaAH
         BOU17sshfevJivLr3+F/H840hsfsqx6Po+d9L3GF1vg1kYaTYlSHyNxezvwEkB6kUFNQ
         uHfg==
X-Gm-Message-State: AOJu0Yy5RnOtKE2s9wOS/nobcEDFF8pnMPN0TYD6ict/FIQEYCE9tr/I
	c/bP7HaSsysHPQyqgkVEqfJXth7CTI2L7bmpb460OWRnn/KDILeSo+fR2OYVIqolh6M=
X-Gm-Gg: AR+sD10sWtJV4E6IeYhXqIUljAXKao08EK1yzIy3T0aDXvYed0ow6XwpSb9CPPJC/Gh
	vKt+O4+40q/3tGg/tfkxeS+BruBgVvjfou66W3uagO1NZ7Rw+OVl3HqFvlG/mCobVfWTQ6jGMi1
	7Fbe6bbzO1JWh+ZEmGrPzet6CXBUQ0+eCOnu+lW9Lb1o0FKAOzMb9lW+naD+6TjiFy5xSEwLwFj
	HRadmsde7aJ/rggtrjdo7/iXZOKFbRx2dd14IDjtCrzRk98P3P6lIZmDMrbu4CtyDcDVZE4eEAW
	/kpf5hmxlyBxKVDRZgM3ysQmdsRGb5CxXjuaD74CcfDyJ2saOVP36w17EJSSFm/RigmJ8fBsbq1
	L3kM5uYO/QY0i3rWISIZYMUMBSvyOUanhY2QMST4CxEJmVIGSopWq18sC7MkBHrv/I6fpRvmK+F
	K+KAOPOJKMn99IvtHaA2DHHh3D/X4orAqBgm6zLwOs5FoV13xeKLgUoGtCRfQa
X-Received: by 2002:a17:902:ebd1:b0:2cc:db7a:251 with SMTP id d9443c01a7336-2d08aa1ca92mr93604915ad.2.1785910979822;
        Tue, 04 Aug 2026 23:22:59 -0700 (PDT)
Received: from ydev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa492c7fsm14230065ad.43.2026.08.04.23.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 23:22:59 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Mark Hatle <mark.hatle@amd.com>,
	Mark Hatle <mark.hatle@kernel.crashing.org>,
	Paul Barker <paul@pbarker.dev>,
	Randy MacLeod <randy.macleod@windriver.com>,
	Vincent Haupert <mail@vincent-haupert.de>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [pseudo] [PATCH v3 0/2] close_range: implement it rather than return ENOSYS
Date: Wed,  5 Aug 2026 06:22:56 +0000
Message-ID: <20260805062258.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <92c180949cc82cbd9025c7673c2ffb8a43896fda.camel@linuxfoundation.org>
References: <92c180949cc82cbd9025c7673c2ffb8a43896fda.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Aug 2026 06:23:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4627

Richard, I took the writing rather than leave it to you. This is the one
op version.

close_range() and closefrom() both go through OP_CLOSE_RANGE now. Based on
the two commits you have on master-next (5ce47e3 + 2d235dd), and the only
changes from those are:

  - OP_CLOSEFROM dropped from enums/op.in.
  - Its case in pseudo_client_op() went with it. OP_CLOSE_RANGE already
    does the same walk over pseudo's own descriptors, and the ignore-path
    exemption now names one op instead of two.
  - closefrom() calls the op with INT_MAX for the maximum.
  - pseudo_client_closefrom() folded into pseudo_client_close_range(),
    which clamps to nfds anyway, so INT_MAX means what closefrom() wants.

The rest is your version, tweaks and all. pseudo_client.c comes out at
+28/-10 against master rather than +67/-1.

2/2 is your test commit with nothing touched in it. I dropped your
Signed-off-by from both, since 1/2 is no longer the code you signed off on
and carrying it on 2/2 alone looked worse than dropping both.

Tested on x86_64, glibc 2.39, kernel 6.17.0-22:

  - ./run_tests.sh: 45 tests, 5 skipped for missing xattr and acl support
    in this container, everything else passing except test-parallel-rename
    and test-parallel-symlinks. Those two are flaky here rather than
    broken by this: they fail on pristine 2a5521e as well, and across
    three runs of this branch one of them passed once.
  - The probe matrix from July, run against this branch and against a build
    of your master-next version: byte identical output. It covers
    close_range(fd, ~0U, 0) with no path lists, under PSEUDO_IGNORE_PATHS,
    and under an OE-style PSEUDO_INCLUDE_PATHS, the maxfd variants
    (~0U, UINT_MAX-1, INT_MAX, 4096, fd), closefrom() under that same
    include list, and pseudo still faking ownership after both calls.
  - linux-libc-headers do_install, with pseudo-native built from this
    branch: succeeds. That is the task that died on valkyrie in July.

One gap I should name: the suite has no closefrom() test, so what the
rewiring did to closefrom is covered by that probe and not by anything in
the tree. I left it out because closefrom() is not declared before glibc
2.34 and I did not want to guess at what that does to the test build on
older hosts. Happy to add a case to 2/2 if you would rather have it.

Babanpreet Singh (2):
  ports/linux/guts: Implement close_range() instead of returning ENOSYS
  tests: Add close_range() test

 enums/op.in                    |   2 +-
 ports/linux/guts/close_range.c |  59 ++++++-
 ports/linux/guts/closefrom.c   |   3 +-
 ports/linux/portdefs.h         |  16 ++
 pseudo_client.c                |  38 +++--
 test/test-close-range.c        | 283 +++++++++++++++++++++++++++++++++
 test/test-close-range.sh       |  24 +++
 7 files changed, 406 insertions(+), 19 deletions(-)
 create mode 100644 test/test-close-range.c
 create mode 100755 test/test-close-range.sh

-- 
2.43.0


