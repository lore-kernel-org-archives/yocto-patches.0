Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9794DD2ECEC
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 20:40:23 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44589.1768855221116786548
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 12:40:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=bgwYcJCi;
 spf=pass (domain: konsulko.com, ip: 209.85.222.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c538d17816so616993185a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 12:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768855220; x=1769460020; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cermduJ9NzDmicLfoeS7Wu9tOaO08S61cUCQdgteFI=;
        b=bgwYcJCi1x8spmGcwSaZQi5B+pVoOTHRnmg0SXN23VMMEOoSmFQN4SqmGGpcjjOPR2
         Po0MIlGvsLzEDeJ5SzNkD9usejWuckvJWxkO79J+x25gQZWoMQkgO0HwZsIQcr/gzq/L
         j2TQElFVvjMvD10RmYVn2lq+C95AQe1ju3fww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768855220; x=1769460020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+cermduJ9NzDmicLfoeS7Wu9tOaO08S61cUCQdgteFI=;
        b=c964HW5xrE4xWVjIPlRdPA9qXMyKlaWkIFWlaRUF3LXsQyrryTEQq8ldTgnNOpTn7t
         HESTJ3EK3RHaXtdCgh6EtsFk+vmq1bnnO5CBLId+QMGfP4nsFuMJ87oYaOqfH9U3+IwS
         SX0ZmCcaL6UgRrkQ0uuIkx+jrYx+tYPtrMwSSCPX71dqh+lE7xS/Mfq0BB8vkcw8eQ94
         yH31J+uAnt0BLTUwU/D1+QH3T/10te8vpO6XaVqOtfS7+en5m83w7tQ55VJ5NKwkwcnF
         /W98Jnc2JlV+fEbMu5oCfaHIoh6KlNjYYVLChZ0jaXyQQV6Hpqy5h17xR4gAW2iDHpus
         9w8w==
X-Gm-Message-State: AOJu0YzhIoUr2k9NWg9yHu2mfrIrIfWWe5p+Wtht7c+3dEr19erZGzNh
	2bkHsLAY8pjilSx8eh4k35vI6VIOwN7ogUga6gznpY/Rx05o9+gk9eUbDt7bMgQQdFK2NI52Zy8
	8L0cx
X-Gm-Gg: AY/fxX5VSasBBMNSF3+sNSe/2GIik601LWMgQgOrFwt3OvuEpIprY1K0Li7zU4tLAoV
	yyHbVN9VjSnaYY+Y13EmIpZngbCfW1Jq6NRXntmKp+4rUjnmOeCYuvOQxy0GkOAIiXilck50k/g
	Nv0M+CNbeCS6+Z1wApncejqXI/NU3BmMCjk0mTKn/c7N9iZGC3bMeNl2rl7hznjYF9tIxVW/EPE
	KI+Wnj3AdohZJk4Nx3GEyEaW+NLv9e2Tl9lMUDvem8CTv6FzlSYltRoMTZzfJ0bN7kPWQwc8NUu
	NkguDQVi4rc9EZK9H+/tEYzk8yROatU9bUl7RATSQ2c6rH1EXzgT79ytWZ0q7ZV7BRMSK8fZXGy
	ZxskOic7Bd5Fpa6VGMgWa6tiK6RFUKNVvehTvPh1ZIghwP2A0yC+zbow1xhMKytv1DeWtMJ1kVO
	Z1JFW/kfCT5Znq7rHzhxZTw5A3KQ0bKgOvOz+3gyJkazHcu0SlO6+iyTe8EVEyuke6F+jGoRxqB
	Ld7k8yhUxT5AxNSeqYkf71y3z3LDlpZpsnBIgc3rOftKoWAm7n/
X-Received: by 2002:a05:620a:4095:b0:8b2:e4f0:74d2 with SMTP id af79cd13be357-8c6a696524bmr1548688185a.88.1768855219801;
        Mon, 19 Jan 2026 12:40:19 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a70f1fe1sm851462085a.0.2026.01.19.12.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:40:19 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][scarthgap][PATCH 4/6] lynis: update to 3.1.5
Date: Mon, 19 Jan 2026 15:39:59 -0500
Message-ID: <4fa748a3e886549fa99ca86ec2c4c843c8a953a3.1768854779.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768854779.git.scott.murray@konsulko.com>
References: <cover.1768854779.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 20:40:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3028

From: Michael Opdenacker <michael.opdenacker@rootcommit.com>

Tested on master (whinlatter) with beaglebone-yocto

New in version 3.1.5 (2025-07-29):
https://cisofy.com/changelog/lynis/#315

Added:
- Support for OpenWrt
- Bitdefender detection on Linux
- Detection of openSUSE Tumbleweed-Slowroll

Changed:
- Corrected detection of service manager SMF
- Extended GetHostID function to allow HostID and HostID2 creation on OpenWrt
- Check modules also under /usr/lib/modules.d

Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
(backported to scarthgap)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-compliance/lynis/{lynis_3.1.4.bb => lynis_3.1.5.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/lynis/{lynis_3.1.4.bb => lynis_3.1.5.bb} (93%)

diff --git a/recipes-compliance/lynis/lynis_3.1.4.bb b/recipes-compliance/lynis/lynis_3.1.5.bb
similarity index 93%
rename from recipes-compliance/lynis/lynis_3.1.4.bb
rename to recipes-compliance/lynis/lynis_3.1.5.bb
index 9cce848..6264edc 100644
--- a/recipes-compliance/lynis/lynis_3.1.4.bb
+++ b/recipes-compliance/lynis/lynis_3.1.5.bb
@@ -8,7 +8,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=3edd6782854304fd11da4975ab9799c1"
 
 SRC_URI = "https://downloads.cisofy.com/lynis/${BPN}-${PV}.tar.gz"
 
-SRC_URI[sha256sum] = "c4dbcddd429624d5b2319cd3b19728e18a7885b70b8eb0a9fdd3ca5f0ae28eb6"
+SRC_URI[sha256sum] = "8d2c6652ba60116a82514522b666ca77293f4bfc69f1e581028769f7ebb52ba4"
 
 #UPSTREAM_CHECK = "https://downloads.cisofy.com/lynis"
 
-- 
2.51.0


