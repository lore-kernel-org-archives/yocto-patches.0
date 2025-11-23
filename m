Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2710ACFD2F6
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:33 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4859.1763941523500719030
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=qz0WOmuq;
 spf=pass (domain: konsulko.com, ip: 209.85.222.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b22b1d3e7fso386917285a.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941522; x=1764546322; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KqhYTOH+OXlPfOJSQv4qMw2n2i7qpTBcLg0hUDCuAU=;
        b=qz0WOmuq8pUcIrmVlFqwZLFyeFWcJM8/cALRx4jtYnUigjbi6UPam2iotD5LQ1YPzx
         uB6yU4yfKbi4S5TeQWfJv1lqLX2UzaT+5vVh/eydCChb5VyqYe3agz//IpO8myNdSliI
         qYKF4r2/QZM/si6ZUekOrHjcTJ2kBk0/C+ypo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941522; x=1764546322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+KqhYTOH+OXlPfOJSQv4qMw2n2i7qpTBcLg0hUDCuAU=;
        b=J3+aENFUrc4RFrwK2ck7fRGiR81y+8bCM2nD5jTJbYpIyzyIKW55sTIJoTuqwRQORE
         TwQtLPOiPDI0GnmpWmuYySaXhXnZ7iqidd8ZRqO0RF6kLuqEslziks5AzNvFb0W+coMl
         ZsNM6bXM2O7fumlvEpl6Ht+sB/pG8AhTOGGTk7rln02hqnUXTzK0elv1H01FcyVsDfAK
         jwCuJYaJkB0Q3pF5OknVHAtqN4i2uyBxkVXBGPki2M/ylTszfgjNN+KgsqLzfe1sUy3j
         +xbLagMGltfdmUyAOJsmHbcELGrn6zaqSxsUelVaYDnADJrinv0fAlpJJfwOSJ1CqaQ2
         eZGg==
X-Gm-Message-State: AOJu0YxHWhN/SGTrnaHG72RlFO4x7G62IKJrV7g0QQonCsUor3W/Mt18
	oObnTrWpwg8tEulBKmzymdoyqiDhUhnaibysmGKAS4t7d3+gaQcotsCYsMC9AGheua8+8fciu1T
	zy8Sn
X-Gm-Gg: ASbGncttVau1EuB5ceaeO59EXKcsFYvLTCCIwkM04l8mwtc9Skf8UuH9ZfV7nQNyf5j
	wGPvmQoanRX39WRlS7MRekihn9nVPTHMy82M7vtjhWpC7j4nm4tpvmZb0X8snMqMA+XnnoLh7rl
	AbCSmgdmakbjEYGIMPu9/yHllUVPpuVL1faJfJpBd/yN6iJCaSnYb1YobY40eusoD6Z8E3NolHc
	zpkVKoDo4S4o0CEoQgPj8Huox127/M16HvfuH4bQkowoHHdkFQybG/d3blxISjB6+ltE/OmR6RO
	VotF/tLcAvoIcTNfU3G1N5w/fi1pANXl8xsLkqJLCkjE15MbVk5FfJd+y6nKUB3irO+8PMM9cKx
	Vvo2UsblKDK+KXabmM6N0DNL4qa2raPMuB7UphEOPdjCnD/Nnqs9xwZHjU+QysallUK3Ft+x0Gf
	G0U0b7Hx5uJo04P9yi/HNA2yhWbeliqVH58tEfczzJFLzud/R83rwKg2jXeMnFyd4=
X-Google-Smtp-Source: AGHT+IEy3CPPcWkbwpb6YxFfQeuAge/7MltQ08QCooaZMauLuf64Jywkv4Lfm/0vuxcB2ek15Ut3tA==
X-Received: by 2002:a05:620a:4005:b0:8a9:eb9d:512b with SMTP id af79cd13be357-8b33d23b370mr1147982085a.6.1763941522107;
        Sun, 23 Nov 2025 15:45:22 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.21
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:21 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 06/32] chkrootkit: use debian mirror
Date: Sun, 23 Nov 2025 18:44:46 -0500
Message-ID: <e3c2d031bc01ec2d16d24b01b155aa37437a08e3.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2664

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

Use the debian mirror as the ubuntu one is failing frequently.

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
---
 recipes-scanners/rootkits/chkrootkit_0.57.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-scanners/rootkits/chkrootkit_0.57.bb b/recipes-scanners/rootkits/chkrootkit_0.57.bb
index d35f5f6..c3d2f9b 100644
--- a/recipes-scanners/rootkits/chkrootkit_0.57.bb
+++ b/recipes-scanners/rootkits/chkrootkit_0.57.bb
@@ -5,7 +5,7 @@ SECTION = "security"
 LICENSE = "BSD-2-Clause"
 LIC_FILES_CHKSUM = "file://COPYRIGHT;md5=fdbe53788f7081c63387d8087273f5ff"
 
-SRC_URI = "http://archive.ubuntu.com/ubuntu/pool/universe/c/${BPN}/${BPN}_${PV}.orig.tar.gz \
+SRC_URI = "http://deb.debian.org/debian/pool/main/c/${BPN}/${BPN}_${PV}.orig.tar.gz \
            file://musl_fix.patch"
 SRC_URI[sha256sum] = "06d1faee151aa3e3c0f91ac807ca92e60b75ed1c18268ccef2c45117156d253c"
 
-- 
2.47.3


