Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8B3CAC582
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 18:44:29 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.web11.2989.1757443462153234196
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 11:44:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=k7M0FJc0;
 spf=pass (domain: konsulko.com, ip: 209.85.222.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8173e8effa1so169307685a.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 11:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1757443461; x=1758048261; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wz3xlKbsSQO0L+izRtTEehvmOcPTZelM30xmYlbWFDg=;
        b=k7M0FJc0nSOPp24eRp6hw0TCyR5IhHt88SV+MsOx2i6lR/kKbY/vZtzPSsGcxJU/Rm
         9tD1qz2GCOldwPAgTWok0Ia5CEr6h2Clag18XSWOHverLgqpXXxnqlVJu3Y9dv8RKifO
         yiJ2HQRVYLurXjvhX+QRn3mh8R0OUGtmK63bA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443461; x=1758048261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wz3xlKbsSQO0L+izRtTEehvmOcPTZelM30xmYlbWFDg=;
        b=GJKyK1UkteBdqThgWXlHDAZ4elN9kql2ju11DcuNHopmVw5HDai8WQ+RFh28Oh1ixG
         dxGASKMu4zcLo4vGWosBxvv6hjARh1NHSMTl1sH05LnmIRpOwqX3kLC7vO834lkRIW0T
         4E50oGNvF64ENx+oteZyUFGApph9MObUU9rSnhD1M6SqFjU7dwna1L7Z1OvIkeYG1nMP
         /bGRb2bnQz5pE+SYRvyWS9OBJAM/7aF42kk7wrXAydhfCjfKQXJzCrqynh5gXx3dhy6a
         mcrshgVdo5P75bnIawmhyOTgyvqAOXh9+jO4Wsr0XfeJYyDwEP0DZFUBzYhhNHs12oj+
         0N4g==
X-Gm-Message-State: AOJu0YxwVNXzIYR79UwKgsgrAzJwe+T+4JIjDeGXmBm54BP6Ij3KvFmx
	qLUm0HwGgdh1qN4ASeIuYjLxNv6OrbNeTGA9CcLaerHhUE3pPVTtRzLQIQuXrx1A8n/KThXhcUn
	p86MO
X-Gm-Gg: ASbGncvUvolIedvl3G8dpyDZ8f4KK84q2V1EbdUpKIKBQdNL+lL/wwvZ7TZUH9YcvHQ
	x2GnrZuexfg/zasgJ+I4Xw4qqcuev8+s9JtNNFD3Xkqpr7aG+ehprGUEm8pWqKwkKHxYhutAT/N
	NfDb1pQlpkbUqWydek8CKOmPiyOpGae224a2PihNtmPNQdeTqbXSS45EA/9xuQuT6YegmdN/GDm
	IvwAdkFonocNMbdvyVazDXM4vWdC8T9QaEnHpFUF5LHsQ8dOvD9MDEax4t935adCzbHKTT6eygP
	PW8rXbTm6rODx9VeaaN3GH8Gqpww1Wqzu+vOvcrHGbZv/JMTOpA05lrwckpv4BQrr+m5LCiwI/w
	XQlxYCkfudZKbY4fCi5U7xVV6JG/uiib/pH3DZWD/Idy0ceiaPPSbagkPfTmO9GJTCYuJH1SK+A
	==
X-Google-Smtp-Source: AGHT+IHoK+v/BjAHQcZNVW5oKU1ES0eh2caqUC6CXvAD29ZCmfOi1DMQ4Bkte2eRw4pw+dV8mIN19Q==
X-Received: by 2002:a05:620a:7088:b0:810:98c5:5ed2 with SMTP id af79cd13be357-813c2d0c68dmr1378913385a.44.1757443460830;
        Tue, 09 Sep 2025 11:44:20 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5f715c0bsm160164985a.61.2025.09.09.11.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:44:20 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Soumya Sambu <Soumya.Sambu@windriver.com>
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 7/9] ptest-cargo.bbclass: sort binaries for reproducibility
Date: Tue,  9 Sep 2025 14:44:00 -0400
Message-ID: <fd21c3a45fd19a8670200fd04ed9ec753a821d14.1757441699.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757441699.git.scott.murray@konsulko.com>
References: <cover.1757441699.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 18:44:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2164

From: Gyorgy Sarvari <skandigraun@gmail.com>

When compiling tests with cargo, the produced binaries are created
in a non-deterministic order. The list of binaries themselves are taken from
some of the log info produced by cargo, which contains them in the order
as they were created. The class later writes this list of binaries
in the run-ptest script in the order that it found them.

In case the test suite contains more than 1 or 2 binaries, then the
order of these binaries is different almost each run, making the
resulting ptest package non-reproducible.

To avoid this, sort the list of test binaries before storing them.

Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 0fdc3ce4e3ecc6519aef680884d88f33c805a20d)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/ptest-cargo.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/ptest-cargo.bbclass b/classes/ptest-cargo.bbclass
index 8351644..30463e1 100644
--- a/classes/ptest-cargo.bbclass
+++ b/classes/ptest-cargo.bbclass
@@ -70,7 +70,7 @@ python do_compile_ptest_cargo() {
     cargo_test_binaries_file = d.getVar('CARGO_TEST_BINARIES_FILES')
     bb.note(f"Found {len(test_bins)} tests, write their paths into {cargo_test_binaries_file}")
     with open(cargo_test_binaries_file, "w") as f:
-        for test_bin in test_bins:
+        for test_bin in sorted(test_bins):
             f.write(f"{test_bin}\n")
 
 }
-- 
2.50.1


