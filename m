Return-Path: <bbnpreetsingh@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59482C53219
	for <webhook@archiver.kernel.org>; Wed, 29 Jul 2026 05:08:10 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4695.1785301689414484994
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Jul 2026 22:08:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=d+oaXVVg;
 spf=pass (domain: gmail.com, ip: 209.85.214.181, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2caf228a910so4777325ad.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 22:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785301689; x=1785906489; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+DqWZX78jCk8mbisV5hVlQjhMBIjkCsbSGECPjAVwPs=;
        b=d+oaXVVgzwxF3umKSfunSohQK+Yyf5uAcpc6Mx9SmtqmiJIKacWpNvmQrCgk0ttl7y
         ibuYGJHgvY8RyQLUGHQDZ+QwotCbvGzyjbh9YKwmWdJZLizO+Q+hYCMv/iUIFWkDXVkF
         LC4mgzrd78GlNMD8qcdkUyCUm1oMkdHmtgxLUKeFS73SiHCfsM1v2THY9gcyeAyzNHZW
         JLJWxt4KDkvCHw/Uo6F+E+wudfRD1v/NBaFnipPevs4KOAysafxSk51puSsFmHh75V4Y
         MNMuGUFe83xFsZEJzIRVm8VZsY0PKrzYUWYQFX1J6q5lUajGzPoLmXfeji68jqLkMc0M
         8chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785301689; x=1785906489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+DqWZX78jCk8mbisV5hVlQjhMBIjkCsbSGECPjAVwPs=;
        b=ThzZjaaqmH/f+py90Ozrk04NDvPx41/agqZiYTy21aCYvyljKABsOsu5fETbUF2NaY
         rqRGERMdLsDQBKqTY/QE67nGpRR5HQHZZg+fOOQr90jg+YYRBT3QylM1PxgScvrBSkGF
         YswUPw9LJw2qZTfIxDjliGQxA4JxBVyxSQvsynZeGbGMjK1AJo/G9PVEbBnCZ6alzktF
         mLHuCXVxUPjOdRREbxALMdSxumO+LT90IQVPTR1X5tMus7ffOytU00EnKk+ckeiHkB/i
         QlBLOXoecySinIQ0JcfsoAff93XCiLaw4YUHSYjFhOVDsf88/+U6aVsVV09L4ymHEzvw
         YoJQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJDO2wTLRHrWughu0xk2LT+Tgyalhp/z9rdsKz4q9NW3y1ixQ07QjKXSrsZo4e8hL7IPQb6+8DJKidulto@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YyOpOJ7egmxY7hHLQ9sJ8FajErxEJnidO175dFz6z/3hhFnFxS/
	ECvZZo6W5K0+dErJjECP1whoS10f8mNTJMoJS2weiBqzB/UoU3GiyjyA
X-Gm-Gg: AR+sD13UJnL6uV0Tz9+O1ka4TgPXqGHYRkISRblCLQ3L+O6aRDg+7vVkGpv7/T6Cv54
	mCmXD+bwZ8glSIzIBW2Uh2EmsxeILo2JGaqg11//ExDYZyuykGEK2R7Av94OpVtePL5+FiivY4K
	EvflIWFsf31emxYoJvM6vBrjY6rjuY1ZVx5o27db0X+tDF4G/xDKqiu2Y4FaHkbh+R/jLmQ8uQP
	ICejrMiLK07b519E6jlQTNUgV1jzIk75hyaXklV8JraKICZXSlKKlCFsK+9aIfjSlzr9Nvr2VDS
	tIoagit6ntlGcAAY63/OQhd6qQE4x5T1RCm2TkhNwr9XAa3rH7DFlqCobvyfod+UOWbCL0blFt9
	QAh5va9MGqs/HRRBhr74deZVWRXiRrPm0/Orewy5BXqxd+REombKnyQo9hFbIvIJnbfi4Wv3ZZl
	ivST5fIztw1Zu15sl1FJ1MFSOx75NruAXkZsY7SBG16ybYBAwKFqd7sc1hasYx
X-Received: by 2002:a17:902:f785:b0:2cf:a2d2:84c0 with SMTP id d9443c01a7336-2d015a09143mr59211775ad.0.1785301688690;
        Tue, 28 Jul 2026 22:08:08 -0700 (PDT)
Received: from ydev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bf845asm5169145ad.60.2026.07.28.22.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 22:08:08 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	yocto-patches@lists.yoctoproject.org
Cc: Mark Hatle <mark.hatle@amd.com>,
	Mark Hatle <mark.hatle@kernel.crashing.org>,
	Paul Barker <paul@pbarker.dev>,
	Randy MacLeod <randy.macleod@windriver.com>,
	Vincent Haupert <mail@vincent-haupert.de>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: Re: [pseudo] [PATCH 0/3] closefrom/close_range: protect every pseudo fd, then drop one
Date: Wed, 29 Jul 2026 05:08:07 +0000
Message-ID: <20260729050807.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d7ac8b50020fb439b47c512be36b674cccdc0b86.camel@linuxfoundation.org>
References: <d7ac8b50020fb439b47c512be36b674cccdc0b86.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jul 2026 05:08:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4561

On Tue, 2026-07-28 at 16:59 +0100, Richard Purdie wrote:
> I think the missing piece is this:
>
> - if (op != OP_CHROOT && op != OP_CHDIR && op != OP_CLOSE && op != OP_CLOSEFROM && op != OP_DUP
> + if (op != OP_CHROOT && op != OP_CHDIR && op != OP_CLOSE && op != OP_CLOSEFROM && op != OP_CLOSE_RANGE && op != OP_DUP

Sorry for the breakage, and thanks for chasing it down.

I can reproduce it both ways on master-next at 6d65d74, with a probe that
opens an fd and calls close_range(fd, ~0U, 0):

  no PSEUDO_*_PATHS set                        OK
  PSEUDO_IGNORE_PATHS covering the fd's path   SIGSEGV
  PSEUDO_INCLUDE_PATHS set, path not in it     SIGSEGV
  same env, closefrom() instead                OK
  all of the above, plus your line             OK

For OP_CLOSE_RANGE the path comes from fd_path(lowfd), the ignore check
hits it, and pseudo_client_op() returns early with result still 0, which
close_range.c then dereferences.

Two things before I respin. Do you want the three fd-protect patches
resent, or will you carry the master-next commits since you have already
resolved the conflicts? And the ignore-path line: fold it into the
close_range patch with a Suggested-by, or keep it as your own commit ahead
of it? Either works for me.

Thanks,
Baban

