Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11015EF9001
	for <webhook@archiver.kernel.org>; Wed,  4 Mar 2026 16:05:05 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21809.1772640299212383114
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Mar 2026 08:04:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ety3Ogg6;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439c9eb5d36so721404f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Mar 2026 08:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1772640297; x=1773245097; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ghFLcYGGVkswGGXn4VTfWLY1qr7NlOxlVt2Resx7eaE=;
        b=ety3Ogg6h9zhFbjD1M/mw+L33mmNfLWlscvYSOhS12Qr9eAD5ywVthMrl8to+2riVl
         kZ5xB785Gr2f0vhJ3Sf1uCRBrifPEQZyKA6HyttEU8XBQYdVOCzNdYtOoDvqoMWJFOxY
         1lOx63aKHZQUH9g9b95HiXBVk4wCo+b7kPzUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640297; x=1773245097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghFLcYGGVkswGGXn4VTfWLY1qr7NlOxlVt2Resx7eaE=;
        b=IR3ZJIBEwAzBbT10939kA9Er8IiFIT2wzCpS2kqKSlONWo/U3wkzBgWt50pwF/8fmS
         Z0eqj88OLGacgAp2ZzCG1sySMIbdNktDpSbWTPKbqroWyL4Qyo18mp8f2wKZ710fgkLH
         sU5H0O2iHixUgnNgUtAm3hnJLDT3/s+jXYXbEDTMzLHIVfHd4j1CzqoPSR9q5VG5F33n
         5jVgBuB8TdMMmoRlbtgV45Z0xEEZF6kfbX91qcVW4IxyoXuFoRrqfJ076CeFf1zt72aJ
         zHGZ6bADpl3w9m5iqmxmYzegPncdF+KWYzQ/TUyHMEQdnggLnMGqSMnvytjrtY9D5YMg
         R6QQ==
X-Gm-Message-State: AOJu0Yzqx8m49/cabqWHiA3FTIBZ0jJq97qfcuvbkUo53k5vLIdtwDJW
	kDFP7r2bqPox8KOYtNDKeuqpleH0Og+PWC60w8BEAys1xiXP85JgPkv43srdpJldAepv3e0QlhZ
	n4xjnbM0=
X-Gm-Gg: ATEYQzxzO6B9rrfd4JmVXpo7/Zk0ET3zos0iCNFC9ziHrgh3yiUmfFXw6g29+ayKvhq
	vyRD64kDL6Ro5AlI98BPzJ5kEXO92zXz3EllPBa1YsWo28+Ia/SnSYBc37czx8jvA+aM67AdJSv
	tql2d5ZEW8/2pQwKLXL8lMnKiJtHFCif+dT6eAuXpYoAdmemHYNuM96JGj67g4OLvRvsutBqYC/
	9EdP0ho+2kmYwBmVnQxHsTU33WjvBHPRUGHyRLvHwF02Y6gVHB04+PheqeDpPNO8cvWyjTnKIZs
	eklUGSrE0cmE4TIVHniRsow6Z36S0NH2Q2nra1YOJOk2fd1eXnAnL4wrMww2GL47izwgSg2R8XS
	J8YM9+EHjVgTVUYhB9vcJgRUt88NHCtMwYNipdy87s8rB0HEU20vSHR0GQLwNnF4HEqI4Ld/su5
	opMNk6Lt2oEfJe50g2bhQg9lxxQydszZrvbu8/NIHKT6bZE8qHcmKNnK4V/GucnQ==
X-Received: by 2002:a05:600c:1d0c:b0:482:df17:bbbc with SMTP id 5b1f17b1804b1-48519874e2amr38083315e9.20.1772640296579;
        Wed, 04 Mar 2026 08:04:56 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:d88a:b244:a11f:d7c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851884a24asm61179755e9.7.2026.03.04.08.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:04:55 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: anibal@limonsoftware.com
Subject: [ptest-runner][PATCH] main.c: Set PYTHONUNBUFFERED in the environment
Date: Wed,  4 Mar 2026 16:04:54 +0000
Message-ID: <20260304160454.1988923-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Mar 2026 16:05:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3332

When python tests are run, on a normal terminal they output unbuffered but
they behave differently, buffering the output. This creates issues with the
timeout handling that ptest-runner uses. This is the cause of some of the
strange ptest timeout issues we see.

Set the environment variable in all cases to avoid this. An alternative
would be to update every ptest runner script that uses python but that seems
to be a lot of work for no good reason when we can just set it here.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/main.c b/main.c
index 594d198..3d5b0d4 100644
--- a/main.c
+++ b/main.c
@@ -238,6 +238,13 @@ main(int argc, char *argv[])
 	for (i = 0; i < ptest_exclude_num; i++)
 		ptest_list_remove(run, opts.exclude[i], 1);
 
+	/* python programs need to use unbuffered output for our timeouts to work correctly */
+	rc = putenv("PYTHONUNBUFFERED=1");
+	if (rc) {
+		fprintf(stderr, "Couldn't putenv: %d\n", rc);
+		exit(1);
+	}
+
 	rc = run_ptests(run, opts, argv[0], stdout, stderr);
 	fprintf(stdout, "TOTAL: %d FAIL: %d\n", ptest_list_length(run), rc);
 	if (rc > 0)

