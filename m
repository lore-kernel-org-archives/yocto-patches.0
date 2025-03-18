Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98930C28B30
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 03:39:10 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web11.3654.1742269142128326111
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 17 Mar 2025 20:39:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jG0lcTfQ;
 spf=pass (domain: gmail.com, ip: 209.85.216.52, mailfrom: raj.khem@gmail.com)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff797f8f1bso4160140a91.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 17 Mar 2025 20:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742269141; x=1742873941; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wk55SVNqyXiqtXuV2lD2Zx3K4awztggfA+j0KjEWqQY=;
        b=jG0lcTfQytiVZULBL/a9HIYGqie6H+/c2orXjETJyFOyumXXiEcmPZDVgNNb0MJk2N
         TnhACHVDXqaqxCRXweRGaD6OFAsHzbmtS0mVjh7L3xSPojC4jXyYI6wi7YQgVtR2ac/k
         xzwbGsAzbRMoX7ajD+SagzMiND5QGnILs8LuX4A4erSORUsPNyLUWkDUUlS+6paTsvKc
         y1o7pKEMT4aC2PvJ8bizNqqJbgN5rILpa2S2JN1zCtD/46XscWBrrjU0kQzu+wCxfbHv
         /1STmME7UrGzpMf9aEVP6TQlC999047yfMK5REM6feyhraoOp2rL2iUJSO88kiNGpLvV
         9zMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742269141; x=1742873941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wk55SVNqyXiqtXuV2lD2Zx3K4awztggfA+j0KjEWqQY=;
        b=cx+tygZymeTkW1mZdaYW+wdMzOSyNFntctD+FJ0/f+9DGzNA2me+vlEeE4TgOsmPtW
         jNX79PKCeFGrPG3V1HsrjUGi1BheCReEI6rFao1eS+Yd8BY88Vro5T5X8LBkRsZ2UNB7
         ivgLWGfhp+yMJC7o82gIsZOTyHuFZHFoQ7ENdMlHqR+Cke5M9I5DevaCm1NOomCbaxWI
         29N5oW9/oK7lUor5OF0ghE9s2uywYrd59ohS+UkU6BefMCJZs4L79Su3ph8/1MUjHWXT
         FgH5UVgtPXwApPlKtRFLGnRCgf2vKCrE/qLwmNWxXmx2/6DdoRK3KuBKRxE3mHHCryro
         T/Jw==
X-Gm-Message-State: AOJu0YwZlNQkjJDUZI0ytDkc+y4BcCnR5NSLJbETvxWr9B77cDIsxb/a
	U2NU5KCyFAcN4CupUR4FyeoPkXEJaLfWF0t2djsd3xM0hpn68LPDViev6K/T
X-Gm-Gg: ASbGncty0LXfc90+4TRbW1cB1ESKTxMHQDnN+TcDvcmIfkVpdAkq2RiMHZSvOezgEJu
	GkZxDzlXIgWaNehby+VRhyIXL5h5QSw5+mSeN8UTql2/jmHXmp/v4j/w3LlC8iDqB+6ZwIR9l1q
	UOs/o/g3xNcTQMWeMrtIRbwfUfrDmL0tG8GFnFBoBvkHLoAKPcZKUBiZOwvPtlmJ/boW9JlnyL7
	/nkPdEJuruieUv70isQMnyz5yccw82eEjS0tfPl7ovnyz5FZWjhLY+DKCz44KPVFLY3tU9jnoIt
	T8xnZVZQOJYiAajxs7DDxBdmoR/8UYdcew04
X-Google-Smtp-Source: AGHT+IFFX2AKV6lxzJqtr0FaJ35Wa0vvlt7S6ATEWdjbNUArfSfLxzXDYFY6GerHhk0GveIetIfdyA==
X-Received: by 2002:a17:90b:4ac5:b0:301:9f62:a944 with SMTP id 98e67ed59e1d1-301a5b965bcmr1075226a91.33.1742269141137;
        Mon, 17 Mar 2025 20:39:01 -0700 (PDT)
Received: from apollo.localdomain ([2601:646:8201:fd20::6874])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301534f477csm7000408a91.5.2025.03.17.20.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 20:39:00 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [psplash][PATCH 1/2] psplash: Only define bool if using C standard older than C23
Date: Mon, 17 Mar 2025 20:38:57 -0700
Message-ID: <20250318033858.2400370-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Mar 2025 03:39:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1213

gcc-15 switched to -std=c23 by default:

https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=55e3bd376b2214e200fa76d12b67ff259b06c212

only typedef int bool for __STDC_VERSION__ <= 201710L (C17)

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 psplash.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/psplash.h b/psplash.h
index 1c42ec7..138e49d 100644
--- a/psplash.h
+++ b/psplash.h
@@ -37,7 +37,10 @@
 
 typedef uint8_t  uint8;
 typedef uint16_t uint16;
+
+#if defined __STDC__ && defined __STDC_VERSION__ && __STDC_VERSION__ <= 201710L
 typedef int            bool;
+#endif
 
 #ifndef FALSE
 #define FALSE 0

