Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4AACAC582
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 18:50:30 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.web11.3157.1757443827657503404
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 11:50:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=eUcLezIm;
 spf=pass (domain: konsulko.com, ip: 209.85.222.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-811b06efefdso501071085a.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 11:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1757443826; x=1758048626; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUn7W7w+7bdAFfa1VIoFDKUI/GPoo3P1/hrD4g6Je1s=;
        b=eUcLezImcuLP9tXF0tj/UMl+nXylkNW7Iiux5eMsHLg6FRcoxlAQEdw4A6M0QpjxCn
         Rt+faEOz2vWH6p08fgJX7wPilY/4orWjpF/CAlHF51+Uz/Iesv/nUTCXgJUQbhpO6HHF
         ERcnYHBtGLjeGONSL2fwBv3MyhcvRGmsAp4xE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443826; x=1758048626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUn7W7w+7bdAFfa1VIoFDKUI/GPoo3P1/hrD4g6Je1s=;
        b=OVa5nI+SWtUkVx5+RUCvGTMxRBwjquckBy5+Nl0OjiKAhVTfA9lLjxd09HKvASCTrP
         kOJJGz59e18T+ruTWZKykZF4asl25OWegC9zrmMcu1d+TUqUIY9559+HijpQ02lUNNRT
         vNE7k7AeHhblsu1RIfvDF5OuW9Gos4BaUY+8uF2m0sOFGzmOPDbJZ8cZypA4Bwu4cRR2
         5phnQ+npT/yv+3unNg36Vt7vy85wI6ZzSmMepRGTJezKrIsdJPZrTZPNDi2/C2USN69o
         ZhukwzzN6OoP8qFwnyFL9+h9Ql47J5R5PEgDNMBl9Bn1bDFIwoKyfyjpAt/qg6Kwizb6
         zzVA==
X-Gm-Message-State: AOJu0Yy01racyEwpazug78zQFkWkui4p7yfwdWUa4jRA244XRqHoPmeL
	x3uU0y7iuecmikLkwe4iiry43TsyPQf/ixEqgKYBdFOnkIWwZQ9BDP3vT8GMmSUBMuoNugWzpJr
	IOK9n
X-Gm-Gg: ASbGncviokaoyvPUiTsG8zmjgxu9D6MmMOesNBCtdyc9FB3M2RqPo/LVqSQhTwA8bkI
	w/JqL2UG9qthnuQwf+PYc05zoGJmIa5M+hxmRGv8U40mHejX6wCk7YZZ1HutvXufLV5bTGZwNru
	fh2Y5NQMULDoErIOiJZghdmcgaM2ng3s7K20t0D1ILw554VR6fJcJhMH6Q+Lad0i7KaPb7/KsnJ
	eKgboyr3H8YtuI6W0UPkpghO9+xKaW86VdFE/6l/kdg5Y+ij6yyTgUmfDjSs4uExCeQqKMVx6G2
	VCEsYTxD+G8xFhbFSfWY7n5zb3McgtUUqrosB2oChZDIGQMj46GsRxCfKvUT2H7fTmwqD62SSLZ
	MqMGZyuRurRMgzQhdGlALHWVBqbL3K0d1Mn4QllfGPCKq9VG5QvRcl9FJw4Gdmhji9ZyC7km90A
	==
X-Google-Smtp-Source: AGHT+IGW87scon/O2LOM3FjvWCZYXN30CyH1fYRFzMtGMGscQXLV9JP4Edi0L09o9EpsBgzIgIhkUg==
X-Received: by 2002:a05:620a:ab04:b0:813:de67:afff with SMTP id af79cd13be357-813de67b39cmr1137088485a.46.1757443826429;
        Tue, 09 Sep 2025 11:50:26 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5ec7d3c8sm161168685a.46.2025.09.09.11.50.25
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:50:26 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 8/9] ptest-cargo.bbclass: sort binaries for reproducibility
Date: Tue,  9 Sep 2025 14:49:56 -0400
Message-ID: <17d79ec169633c06dc7a4274a9b2664f46029f4a.1757443674.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757443674.git.scott.murray@konsulko.com>
References: <cover.1757443674.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 18:50:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2175

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
 classes-recipe/ptest-cargo.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes-recipe/ptest-cargo.bbclass b/classes-recipe/ptest-cargo.bbclass
index 8351644..30463e1 100644
--- a/classes-recipe/ptest-cargo.bbclass
+++ b/classes-recipe/ptest-cargo.bbclass
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


