Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA50C021A1
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 19:17:57 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.web10.1825.1739301471717333010
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Feb 2025 11:17:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=k+fuxSpx;
 spf=pass (domain: konsulko.com, ip: 209.85.222.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7be49f6b331so613418385a.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 11:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1739301470; x=1739906270; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZsN/bqfpOphePxZqdL7QnBDJobyXxALdtqakb46zI0=;
        b=k+fuxSpxWFXIAEi9txuJLuU5lRuriky/4+Vk7SsSDYDl2ej+9x6kGtJslTasnDZkLn
         qdAhva2FT2sdvneLGk6ugW4Qbw0CAXzu+sw2KpP4JH3WkmWuBgf5scxh0u3Sl0n35MST
         VbZye+DzwoDC7TQ/oQXKDCAsd19tk6Cr5yuvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739301470; x=1739906270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZsN/bqfpOphePxZqdL7QnBDJobyXxALdtqakb46zI0=;
        b=ihHT+TsWyCbIs56gW9uBmltJ3HTl7T5KkrqL1nH0WccNyiMotliOi53EegNdLKdEfz
         Gfj5SS0eSCKIuZ2Ip4gYsj14/+i6MsNMOLGeNN2+FVwIxEctI2Yy49ysiyjxhLdSR+9Z
         7TWN4xHJYudBlID6BzIXjyHLpbg75L4VItGJriepm1YrHE32Qu+FSM+bIJFjebu08G0K
         39LbWlpNGlC/FNlAAlmztT7kpSymF6ml3EB/BCFe5Sz8n9p3JrvuTpNpHXvrjv1VeRAM
         hlVR6T9II290au61GbZrBEfxZDou7c5UOPvYA8YtTXehXBNVC4XReiUqyXfKO/opwNl5
         bl8Q==
X-Gm-Message-State: AOJu0YxifVUic7BVgu/OR/ymf2s/ZGi0J5m0B9RilBYNHX5HeS/CwB01
	CK0D32ZpYDvEC4DMMaMCVlTDOjGguX5WPIqckgW2GfrTYBPTwkba02//fK5o0EBa7HfHkuXkSyZ
	W
X-Gm-Gg: ASbGnct0i6EC2I4I9cszlqsKQsww76reE2GWWN3NrD0hMQgJlHdBQEcD1yk27QRt8e/
	mypSS6RXDhPTYs76xqQtnFh/cSWdTh5PfDdDPDCV7pp0PLyc/NZMzPAAgWOzW/mEa2VEmNiCSQ3
	s0gw93ThToAVMhpP6oVm5pyNY2AfE5JmYoBULeiRKP6VGM8VTm3scfkawQwq7dWYE5L8Zws2m0V
	5yKnzgfxtUuk2og3m/utB+dKvqddnEu1Lb+SAkXraRWrNQjtpjvtVfhrCGR6KqaL7/dw1dnBuIS
	leaNDpHZGhWnIn2HIKmuWCLhiZNnXNuJt8kM3KTvJV3FtVHWqrA68uAiTffE6OUvLbE=
X-Google-Smtp-Source: AGHT+IGl2rEYBJ9D09k3J5+Ez3HkMiLs6Lmp9B6ArDSBoFfAgUfwDm4d4xt3LRvj1UejxUZKlaZTgg==
X-Received: by 2002:a05:620a:1724:b0:7b6:d5a6:18ec with SMTP id af79cd13be357-7c06fce29aemr75815685a.48.1739301470362;
        Tue, 11 Feb 2025 11:17:50 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c05e374867sm318561085a.111.2025.02.11.11.17.49
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:17:49 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 08/10] rust: increase test timeout again
Date: Tue, 11 Feb 2025 14:17:21 -0500
Message-ID: <d2432f67014730ec891762bd8982bbfd4242b310.1739300779.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739300779.git.scott.murray@konsulko.com>
References: <cover.1739300779.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 19:17:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1073

From: Adrian Freihofer <adrian.freihofer@gmail.com>

Fixes [YOCTO #15625]

The first attempt to get around the timeout was to double it from 5000
to 10000, which doesn't seem to be enough. Let's try to fix this by
extending the timeout by a factor of 10.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch b/recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch
index b42dda8..bb27ca3 100644
--- a/recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch
+++ b/recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch
@@ -25,7 +25,7 @@ index 11f363d62..c12d66016 100644
      // Just in case `yes` doesn't check for EPIPE...
      thread::spawn(|| {
 -        thread::sleep_ms(5000);
-+        thread::sleep_ms(10000);
++        thread::sleep_ms(50000);
          process::exit(1);
      });
      let output = process::Command::new("sh")
-- 
2.48.1


