Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E9DC3DA64
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 01:06:40 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.web10.46509.1722215198760231618
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 28 Jul 2024 18:06:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Yd5Kmdlp;
 spf=pass (domain: gmail.com, ip: 209.85.128.182, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-654cf0a069eso12912387b3.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 28 Jul 2024 18:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722215198; x=1722819998; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dnG6WiVTx7KINQfPBncy8OO8Ud4T8KWAFeOcqUzAygM=;
        b=Yd5KmdlpyYl9X6c/PFfMbF/ZQJ3I0FXDfKySLT5wJQKa5Wcy/fL9IPF/bJOhblnI61
         0SGgGJllR8nTs797KvvTcVtXHqCMToCe2OMcmhfZzh6GZo6vttd1inuTttpw9e2ja/aU
         mfgsahJQfEGO8nG7u4Yr+4swbR6fRAmZ7/w2u6miYV9s7tRQhX+9zMmF+IhqUG9ennh7
         763eNUk3s1Qv5uMgIO42TBbC5jETCV53+swTQSl0/tjkHVddNV4C8x1POVu8daCBB4LL
         MrCrfwKODUX+LovBB+D93z4O5cWpRSXS22dWsBia/zRllAcMnKIW5XC8CVxkceF0u/xS
         ioBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722215198; x=1722819998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnG6WiVTx7KINQfPBncy8OO8Ud4T8KWAFeOcqUzAygM=;
        b=uuYhStVjs7T2u7LaohluQaGbjyM11cQXR266hJ0S4H3Vn1I5bxIBAsOP52dW5N6Qk5
         WIDccIhPLg/CmSDIvoUwMJQGF3cl1d33O7NnmWj5tbtMTwBRKAl3EtTkrjNGXyztHTSG
         7yOdWmkoONczCBniOAYOJFQ5Y8+9Z2NwZZH/QaJ6VMwzzLCwGMFB970fwUjGSkRzJuPT
         Ag3Teth8kOrPPnzVfVfw04tkI9uJYrQWWxk6h4johVQ6KY3bA0Rh/bej4AicmGJgdoOW
         b8ACpkmiR6YW8SYI+egL+mUAucFXNiOeiEFICSq2IozRPbeKSemFiIhHxAzrhiapNX7F
         Ty5w==
X-Gm-Message-State: AOJu0Yz9MzuGmsPUlNWxf8nTCypgiAw6IlZlsfteQyugYrvmcVQXV/7O
	WvuUr/dQPbOgob3a0oyt61M1STgqPVRZ+8E+rYrk5RvRGowuxNMIVhsHAg==
X-Google-Smtp-Source: AGHT+IHS7m2b6PraF1r1fdkP91wfWeH6nlYuZTZzAm/wscQQFVG/EEj593oj3tR6eCuEq3RifcRl+w==
X-Received: by 2002:a05:690c:ec4:b0:619:5176:5e34 with SMTP id 00721157ae682-67a06b021cbmr69058587b3.18.1722215197830;
        Sun, 28 Jul 2024 18:06:37 -0700 (PDT)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:47bc:453d:d517:b47])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756bc9edd8sm18543157b3.130.2024.07.28.18.06.37
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 18:06:37 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 6/6] arpwatch: Fix compile error
Date: Sun, 28 Jul 2024 21:06:34 -0400
Message-Id: <20240729010634.1991558-6-akuster808@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729010634.1991558-1-akuster808@gmail.com>
References: <20240729010634.1991558-1-akuster808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 01:06:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/486

| ./dns.c:118:24: error: implicit declaration of function '_getshort'; did you mean '__putshort'? [-Wimplicit-function-declaration]

upon others

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 recipes-scanners/arpwatch/arpwatch_3.3.bb | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-scanners/arpwatch/arpwatch_3.3.bb b/recipes-scanners/arpwatch/arpwatch_3.3.bb
index cacfea7..84f93da 100644
--- a/recipes-scanners/arpwatch/arpwatch_3.3.bb
+++ b/recipes-scanners/arpwatch/arpwatch_3.3.bb
@@ -21,6 +21,10 @@ ARPWATCH_GID ?= "arpwatch"
 APRWATCH_FROM ?= "root "
 ARPWATH_REPLY ?= "${ARPWATCH_UID}"
 
+# many configure tests are failing with gcc-14
+CFLAGS += "-Wno-error=implicit-int -Wno-error=implicit-function-declaration"
+BUILD_CFLAGS += "-Wno-error=implicit-int -Wno-error=implicit-function-declaration"
+
 PACKAGECONFIG ??= ""
 
 PACKAGECONFIG[email] = "-with-watcher=email=${APRWATCH_FROM} --with-watchee=email=${ARPWATH_REPLY}, , postfix, postfix postfix-cfg"
-- 
2.34.1


