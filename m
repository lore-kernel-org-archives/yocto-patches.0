Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0F7C61DD6
	for <webhook@archiver.kernel.org>; Fri,  4 Sep 2026 13:07:17 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13447.1788527229181471463
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Sep 2026 06:07:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=m3V3q/R/;
 spf=pass (domain: gmail.com, ip: 209.85.208.52, mailfrom: frezidok1@gmail.com)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a5ebf75d62so1470659a12.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Sep 2026 06:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788527227; x=1789132027; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v6EBY4Dx1P6C9gqi2K2em2Qe3lOO/I+Zui+O3PQFEXM=;
        b=m3V3q/R/eVKxcxUhNPlX2uF9HXXliACOZp2sibiCoHRN4kXtt9muCh9I5k33w7DKpp
         tXJrhiv3Vbcc2i1hjmxBCA5oPp08szoLV8bQV+/P10VLgm+xQuEjY2Z+7CG0Qqd5GETv
         ZG2bJdSzUa8iy4Z7S4rzS9AyekES3R6QmyZDyJdHnBEJUc5GMW907c7VGSJcOK0n7Ck1
         ++WCtY5ABBTUtBdIrpqPhCdP/BsycScogdDY1HD8BYcEF9BtZnIoemwCfSTSi8mRDadx
         kXd1gM5uOio3H93cU7aFPDnScUtJSA0RUpXnXERfNbmGezxs9/abi0Q1BRVvjTncKfQV
         rPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788527227; x=1789132027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v6EBY4Dx1P6C9gqi2K2em2Qe3lOO/I+Zui+O3PQFEXM=;
        b=ZcFpBPRocVODGjjuzP9Vi5Ec0ryvmbWb6rZjQfv201i2wIc21gMtRj4MRinLfbMEJx
         d2l3qBabXj2y2aH+TCTcAXb+Sr8sQUwcwK0+3Ve7emUKXASmgWtEBxQFp9aMs+3i/HRP
         uvqrFGhX9U87bxQePnYO4HAVrSL9n3cdPEpXCyiNHqvCujsjtN3QBczCFV3dIclzq27t
         ih2ZA6zReEW4BiJIUYHLI/6Ai1B+pT18aECQrPqD3nBLwk9XsisWfgVpeJU9LOjtV5R2
         a3YBZAR6QJabiYGOcooLp3FG1KRgQEIB0jUbX5FxvDQjra7Q1NZOrECn2b9ck5QzU1Yl
         eUug==
X-Gm-Message-State: AFuF++kO/j0AdW5NSuDmnnlIBFpp66z3SdwLEP3lxW7u9O/Ui89IX3OO
	kZMY/xUKKwPyB5QXMCVeYP69T8cAkc3GOWZaKqIvswh0dUdX/kH8A+586fqamwXr
X-Gm-Gg: AYBFou3WmOwVLtCh9O6qt2hH7npihhJi1ogOM7mQ9WhFTjlkcQKeb5XHUl7AZgNdI31
	inBRWqNU4nbs4vSgSn1flAg4VFb1cCrt7zpc8TB+7OyS57VIljuynq3SysVCRllyuxmPUp0ft9B
	eImLrZ/XTYp4JXmZreMpHKrIV/DdavrL5A8WKN/Imqa3VzwgAxOA+HylJMqDIYLHDa0DlNF5vLG
	7zfFz/oYXAMktG3A18zcA6UZCLPWhXRqFQ9yx+wvL0Y9yT/U25k4QZmfJQAZduYQVqHZWF/Krzj
	QlP9hVP7NDkylb9THfJqgeIWB5JYQS9+WpHuJieFEt2ivR0wjeyQqeKgudF1+dVFM4JrLx14EHx
	/WcUtZIW7s3bftzGj8U1UkNlWbfPmOPwAS1x2w5sh79lzcJ818HlhpScfKHRGgk1MBEbeAsZcB8
	6nOzrGEV4p4AmwWJ77HLLt0xd/yeFiGb2k/iVo8fi/
X-Received: by 2002:a05:6402:270c:b0:6a6:b2b9:61f9 with SMTP id 4fb4d7f45d1cf-6a7e9520211mr1740041a12.13.1788527226922;
        Fri, 04 Sep 2026 06:07:06 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68c3d88sm1173158a12.15.2026.09.04.06.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:07:06 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH v2 0/4] Add open_tree() wrapper
Date: Fri,  4 Sep 2026 16:06:23 +0300
Message-ID: <20260904130627.453678-1-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Sep 2026 13:07:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4728

From: Dmitry Sakhonchik <frezidok1@gmail.com>

v2:
- Handle relative paths correctly in the open_tree wrapper
- Add fallback to SYS_open_tree when libc function is absent
- Add tests coverage with relative paths (dirfd != AT_FDCWD)
- Add support and tests for syscall(SYS_open_tree, ...)

Dmitry Sakhonchik (4):
  ports/linux/guts: Add open_tree wrapper
  test: Add open_tree test
  ports/linux/pseudo_wrappers.c: Add syscall support for open_tree()
    wrapper
  test: Add open_tree syscall test

 ports/linux/guts/open_tree.c   |  46 ++++++++++
 ports/linux/portdefs.h         |   9 ++
 ports/linux/pseudo_wrappers.c  |  14 +++
 ports/linux/wrapfuncs.in       |   1 +
 test/test-open_tree-syscall.c  | 152 +++++++++++++++++++++++++++++++++
 test/test-open_tree-syscall.sh |   5 ++
 test/test-open_tree.c          | 139 ++++++++++++++++++++++++++++++
 test/test-open_tree.sh         |   5 ++
 8 files changed, 371 insertions(+)
 create mode 100644 ports/linux/guts/open_tree.c
 create mode 100644 test/test-open_tree-syscall.c
 create mode 100755 test/test-open_tree-syscall.sh
 create mode 100644 test/test-open_tree.c
 create mode 100755 test/test-open_tree.sh


