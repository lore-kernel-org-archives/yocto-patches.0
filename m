Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A16CC6B2F
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 14:12:44 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14769.1791987155829411668
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Oct 2026 07:12:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=LxsU93Q8;
 spf=pass (domain: snapchat.com, ip: 209.85.128.47, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so10470365e9.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 07:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1791987154; x=1792591954; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q8Wjqhazi2jlR3w/1/1mqqVC9XFa05FKWhLUz/O8rWA=;
        b=LxsU93Q8Ueg5ilBK7k1gYp4HZn/5bMhRGJW8F7h3waj24EEkU5Fmb8Q7yMuaz8beLN
         9GfHzKwImv7dfwZeqegf2GzXQVuILtO1VnBDtTEsqPK7P/K88w2Y6ogqThLbKj9XvTgY
         3/QVbM3NwrbYE8+X7Rhln9TvNfw1L9V/8cOm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987154; x=1792591954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q8Wjqhazi2jlR3w/1/1mqqVC9XFa05FKWhLUz/O8rWA=;
        b=UhzQEDEn0QDsSm/72F0xd/IdZnfaub/jp9+n4ewtsHccsMJbovI5c5Mkc9N2fT4aez
         /uaiv6D5SW5YrCkbjycSIjAoLZksJXZC3MvNu7kt+DAixGCvfDhmJ9Zk5jTrunklb4WW
         XKvrFVqxJhsi6DaY5rV0n2ZemnZJiexRIsWomDmCQBbFC+yVYG9QCujRx6toDsyGlC1z
         QGFc3MQB9+FExg9Js5+RqXXhhQ5ILnU0slmzp7Fm7nJzVcToNYoiIlldio2AlVQsCXMv
         IZvw5aW0vtGrXhy37ThJ0Cvo/h+wBncWnNg6ybLvwv5ivbS+OiXVhHo5+HatjKFqXahb
         9jxg==
X-Gm-Message-State: AFq9FYL3EabXbp85uJnqo+ME/qf1cd7xISWFml3RMLphDceJadxTGaC+
	h+XV3g6AcdiqfLF+9k4Twfmwr5jK0rg5EpGsUc1U7HAoq6S3J2+kRKG9NlV6Hv5BZvR+ut9DSjw
	mFPyTzZs=
X-Gm-Gg: AYBFou02zPnx9S4li+JKd9UxlXLvRg8/nOMXv9XnzcVTNL73v0DdN1ZSY7Q2xJuZlr/
	kMD1mJYm7281PKLEhG4g1H6ulY2qHH6NcK/Qv/um/LrTEfgf9fBUdTmvGWJ8Y5FvpLG2341MHVv
	eSYuClADf9870GHQ9TWQ5oLQnWrZgWzCv0nR/fbYQZc6Y3j+Nb1jeWYkrNDL2mLc7CuTzPcNYjt
	b2pqXrNcwj3irT3aEpsiDp87U4XKiH1Mt2UXpUjYc0eKEWLNW2yGAbyiJgraDhbyvSCRPcbnS/z
	4boIvSfr+L2kvhLZ2TTLh1pdcWjHNCX68476jf326eLoFLiFu5GP5bYUAC7P6EsAIbDE80Q8PfY
	wg/6ejeGemmPtztcdi76g2Ipg7em3jBgcjwUnwvW30CzA7J24yqGTkMHtuFORodF4sodzKmnq5t
	KSPfy8Hl+B5xwmncTtlXa89kEQnXIjoxc14f2v5MPtbr0K0FxXqcND3v8SfN9F2DM7vxuAu5GcM
	KqwuXnqi8IUNmQ2zqGzEGCpt2xnHnfO5y0dseO4n2uObUoQtCwS
X-Received: by 2002:a05:600c:3f0f:b0:49c:ffab:551f with SMTP id 5b1f17b1804b1-4a18e4cd231mr325380805e9.22.1791987154011;
        Wed, 14 Oct 2026 07:12:34 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd202e8esm299965e9.6.2026.10.14.07.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:12:33 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 10/21] libgcrypt: drop libcap capabilities support for Darwin nativesdk
Date: Wed, 14 Oct 2026 16:10:31 +0200
Message-ID: <20261014141209.488034-10-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014141209.488034-1-ecordonnier@snap.com>
References: <20261014141209.488034-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 14:12:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5015

From: Etienne Cordonnier <ecordonnier@snap.com>

Linux capability dropping has no Darwin equivalent, and libcap itself
can't build there (Linux-only headers, priority-numbered
constructor/destructor attributes unsupported on Mach-O). libgcrypt's
capabilities PACKAGECONFIG defaults on and pulls in nativesdk-libcap
transitively for the macOS NDK build, which fails do_compile.

AI-Generated: Claude Sonnet 5

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 recipes-support/libgcrypt/libgcrypt_%.bbappend | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 recipes-support/libgcrypt/libgcrypt_%.bbappend

diff --git a/recipes-support/libgcrypt/libgcrypt_%.bbappend b/recipes-support/libgcrypt/libgcrypt_%.bbappend
new file mode 100644
index 0000000..2435dbb
--- /dev/null
+++ b/recipes-support/libgcrypt/libgcrypt_%.bbappend
@@ -0,0 +1,4 @@
+# Capability dropping is a Linux-only concept; libcap has no Darwin port
+# and can't build for it (uses sys/prctl.h, byteswap.h, priority-numbered
+# constructors, none of which exist on Mach-O/Darwin).
+PACKAGECONFIG:remove:class-nativesdk:darwin21 = "capabilities"
-- 
2.43.0


