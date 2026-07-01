Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBC9C43327
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 13:13:42 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44824.1782911620737753245
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 06:13:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OA8PZsvu;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4720d22c94aso586352f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 06:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1782911619; x=1783516419; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VMgfiNjmVYo0V29h5q5zEZ5lmJeIMhlBiAJvtttDOpo=;
        b=OA8PZsvudZ93Tv3r0hcI0o0/9x14o1DyZLPnAqHFmGywIiMexhu1IqqQPkOK4h04R7
         8ocrjg67zPk88E0aubR0i6L1lApHj7bBI5mZXQY+OkeQEs9kMWIJ4IKCAclQo45kb03j
         /TWl33TNuKM/7iGDCYqzRTaAasl6kqYP2HCss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782911619; x=1783516419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMgfiNjmVYo0V29h5q5zEZ5lmJeIMhlBiAJvtttDOpo=;
        b=n4jIxmPVSj3F5/b5adRN9d913USE4OAjlH5BeL7Va36LTWJj5SVMcooM5wjL8J4p0U
         JmfXEwbO7bshTVgj77mDmDRSP7vD2pLlFtBtpArawIucPvYqfcBhK6NrOatttwJVswmc
         5x7bUeai3u91QhuLGoxeIO+tjHjvYq2co/mJIPf2QdE4cMjPcUM1PSA2YH8+G8Ny32dz
         33lgLT3Wbkr/oqlMcUcSXK0uloD1hh9OP1vVJpQlOa44cOKODGfTRjmk4xjl7Tn7Rtbw
         iTxaesmuSoyTXDXYrJf8CBRzPo99Ty0zQ1qJThJSfDsTXSpP4XHuAk2HSfaEIcgMb0zh
         S2Ng==
X-Gm-Message-State: AOJu0YypOj68DZxyxwN9EcSBPP3NUSr3tHv3hnB5/u1xdx3jmPrrl95T
	MTqAcBC+2ZkeHSgilF9yi21u+IrJQsVr4kc+JEf1GniLuo1Y2pZRoQcMFP6p5izLYG2kImYrso/
	QWxSZ
X-Gm-Gg: AfdE7clKBelYHyItIJwoJb8evgI/VhYxava/adeeMWWBxorRYiUIRvP2VQtMR8ozuSa
	DUMgTZ5Kg6Wnvkm5FmXxEPjQDMtFmpzvGNKYh9Ox3cGC7kbhK/NTskzLydnAuBaF/WFuJ2ijot3
	awk0zH42B37OmHVOMcjWbQosg13jvm0qnCnqnN8C2z5FdBvcYGPvGBRabBsZZBDu54iWf5KUDPZ
	Qk616hkR/xxB/suQ/KXFQ82OkimoDyb2XEo6f2ctSaF8x5WXy3lPvjyfBcelzga+Oct6V1XP6Hh
	hXevLhh9kRD1rCl4M6xLM7tMJT9A428/dRv0qswD7V77xvmguqC0Q7vX++VMyMYpUIfmC+LTFWs
	o+uDpgKD4FpeMSz5G5VtXE7JwDERevHcfeWDb73k/zrVw39vRKIQ9d00/Cf+hOPn9JS28P+h810
	zbHrNcAkGkCWkXIdMFYEp/Iniz/UdEwm3SR5qJvjkGBQ==
X-Received: by 2002:adf:e006:0:20b0:473:1ccc:15be with SMTP id ffacd0b85a97d-477b11002f4mr657060f8f.39.1782911618572;
        Wed, 01 Jul 2026 06:13:38 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:6b3f:20f2:ee05:f032])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47567884770sm17568280f8f.33.2026.07.01.06.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 06:13:37 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [pseudo] [PATCH 1/7] pseudo.h: Avoid accessing unallocated memory
Date: Wed,  1 Jul 2026 14:13:30 +0100
Message-ID: <20260701131336.3578279-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 13:13:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4343

We can call STARTSWITH in cases where the item being searched for is longer
than the string itself. Switch from memcmp to strncmp to avoid accessing
unassigned memory.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 pseudo.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pseudo.h b/pseudo.h
index b6c13f2..1152c19 100644
--- a/pseudo.h
+++ b/pseudo.h
@@ -99,7 +99,7 @@ extern char *pseudo_version;
  #define PSEUDO_LIBDIR "lib"
 #endif
 
-#define STARTSWITH(x, y) (!memcmp((x), (y), sizeof(y) - 1))
+#define STARTSWITH(x, y) (strncmp(y, x, strlen(y)) == 0)
 
 #ifndef PSEUDO_LOCALSTATEDIR
  #define PSEUDO_LOCALSTATEDIR "var/pseudo"

