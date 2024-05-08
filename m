Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0652C25B4F
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 15:31:53 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web11.15797.1715182307486444818
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 May 2024 08:31:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=IgERf7xC;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.208.43, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-573137ba8d7so1834697a12.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 08:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715182306; x=1715787106; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cBRmZbus9vnO7Czy/NK11E/fisy87qzTLHyAltCA4Q4=;
        b=IgERf7xC02LAYVF7vr4tUHVZRT6TNKdUqsogfSD2Gz2KD8CFXHqLgN6f0IMqGyiHGs
         EvEjvF7lTmOentavS47gGxXlrbm6i1cf1ygIQ4Kk/9qw0XtdFaX26ocOTXXRgLAukMap
         nvqLCROqovNoh8mWz8TDLgKNypujjCq8Bz7SOTWqyqv0icADBGxy9AXB1nqCsnAQNkjE
         zLVgYEHUN7jf8ijwCTnsri+3YoqEavrCy31NsiNAg17VKfdjE6kDN/H0/HO1rK5q+EJM
         WLXzXXkL3qpFowY8sxTFV786o8Hnd7Z9+fWtmRIivbflCLHCsU3QUC5Xv1UPXu/BQDfu
         EwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715182306; x=1715787106;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cBRmZbus9vnO7Czy/NK11E/fisy87qzTLHyAltCA4Q4=;
        b=kkYAj8YBxatGu+E9nn1xlE/VqdMT4D29clil1IR0vqkSxTMZAHlsOXsNVaEEkmatRt
         FxslVM7uilxDVElKVTGjJt/gQDHqhlc2CK65g/yvlZni7ctdcMwxbJjJlBBnJz/vFPpK
         ztY3DautZOElGujnac+2+XHFpbxHgqFk/eytspf7Zh0llvO5mxVB9kOzleUr4Yox2MX/
         zy/rxmzu51NsyF8xzCC2OPubzamNFabc406PRokBDMHSNtXdDT/02DR4FkIiY6kVxjJt
         +bziy6inEmBNGzh7UzPU5u9jC1AFZozQINsminsC0lbTyy8jAII63cEn1GJicnrLsPvF
         W4SA==
X-Gm-Message-State: AOJu0YzjU+4S9LQDspKvOFvB8NXkf88zpT8dDTJxDKURdAuMPDPhhWW6
	mB/wPnIGjgrlfXs9r0ceugkJWuJcIp0PXV4PlLZjo0M+Cx0MjVz2wJU9R8lo3HZNnhLZDaOr4Ie
	P
X-Google-Smtp-Source: AGHT+IEI7bmdVKHz6dKw9ANVTdDZVteAwKiJw8mYsqVKRwG0WEwOwp8p52eiutQDKnGB3jXGgkx0VQ==
X-Received: by 2002:a17:906:c94e:b0:a59:aa7a:3b16 with SMTP id a640c23a62f3a-a5a115c1f9fmr893766b.4.1715182305856;
        Wed, 08 May 2024 08:31:45 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeba4.dynamic.kabel-deutschland.de. [95.90.235.164])
        by smtp.gmail.com with ESMTPSA id c17-20020a1709060fd100b00a526a992d82sm7784897ejk.4.2024.05.08.08.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:31:45 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <hello@alexfeyerke.com>
Subject: [PATCH 09/12] index.html: Move raw data to own section element
Date: Wed,  8 May 2024 17:31:24 +0200
Message-ID: <20240508153131.94270-10-ninette@thehoodiefirm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240508153131.94270-1-ninette@thehoodiefirm.com>
References: <20240508153131.94270-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 15:31:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/100

From: Alex Feyerke <hello@alexfeyerke.com>

Signed-off-by: Alex Feyerke <hello@alexfeyerke.com>
---
 patch-status/index.html | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/patch-status/index.html b/patch-status/index.html
index 8089a1c0..31c5bfe5 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -346,6 +346,15 @@ SPDX-License-Identifier: MIT
 
     <div id="recipe_chart" style="height:400px;"></div>
 
+    <section>
+      <h2>Raw Data</h2>
+      <ul>
+        <li><a href="patch-status-pie.json">patch-status-pie.json</a></li>
+        <li><a href="patch-status-byday.json">patch-status-byday.json</a></li>
+        <li><a href="cve-count-byday.json">cve-count-byday.json</a></li>
+        <li><a href="releases.csv">releases.csv</a></li>
+      </ul>
+    </section>
   </main>
 
   <script type="text/javascript">
-- 
2.39.3 (Apple Git-145)


