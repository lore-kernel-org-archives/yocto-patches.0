Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C316DC27C5E
	for <webhook@archiver.kernel.org>; Mon, 10 Jun 2024 14:33:01 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web10.21156.1718029976318698097
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Jun 2024 07:32:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=baTTWEeU;
 spf=pass (domain: snapchat.com, ip: 209.85.208.54, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a4d7ba501so5946262a12.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Jun 2024 07:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1718029974; x=1718634774; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjWVFcfjmNqA8xIyPhHTy1TTWy0LI0qu7eu1qBYqHS0=;
        b=baTTWEeUdo268ESAuTHsZotZHU8KddSAZ0qWi50PQweBoe2R6OqQ3fjYY5diUuACzg
         LAzEhHx/Rp3yfAkeKggT2WPaQF6PSIElhbqvtlHAn3tfkO/aQGbuZDzmr14A0ZLU/NTW
         6ntyleVxAKZcq4iRqLOsmHJ37S4ao1zGGv8Zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718029974; x=1718634774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjWVFcfjmNqA8xIyPhHTy1TTWy0LI0qu7eu1qBYqHS0=;
        b=BqRXqAp94M7gmyZPSVzwYyCGpm0YVKuJpiOUMXANt+xGlhkZ8rcZGIkL0gfhVe9h0N
         exM8mIL/vqYAA20Y7opeup3qtVKSLLlHya6zlwI/6jbZBmQwtrunozT5sTuhpzMw82av
         +QoOTbqbWfHW0wKArAoRmOw2AO+I7I+YpHjvPXpLinbGrre7EbxuPBw7MiVwu2ishJPO
         /lyKAzUw5mSbkeYfw8OFobM8d+mTdmQKelyJ8qyKXhoT2aETuYJI91S6uLSkT2UZ4c6x
         Ymv7VwCeSUjQG3+G2skbEqF+swuggQpzjsmcqLIo9ATlsrVHKD1p7AZXjraq+qXL/EcO
         1iOg==
X-Gm-Message-State: AOJu0YykqM0l4KWFwsTKQSjoriYpx3a+SL/asUaRAKRdfF02fQCuJXtJ
	zQ1ReVKaMeZat0nlEvTrKJZDOeAqiH2L7Yj5KVTV/XJ7bqfqLGzzvlFrFT/TJyrWLJ0bsvwZCkf
	oJ8c=
X-Google-Smtp-Source: AGHT+IF0SpA1efm9ybhO5EQbEsRca+SfGvvyY2FsvVY01g9DkrhzB40kurx5g1HdIxqboupkUMhfWw==
X-Received: by 2002:a50:931a:0:b0:57c:6114:3efb with SMTP id 4fb4d7f45d1cf-57c6114405bmr4945921a12.6.1718029974478;
        Mon, 10 Jun 2024 07:32:54 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae237408sm7504233a12.93.2024.06.10.07.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 07:32:54 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 07/11] clang: fix nativesdk-perl dependency which was re-added
Date: Mon, 10 Jun 2024 16:32:10 +0200
Message-Id: <20240610143214.2376414-7-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20240610143214.2376414-1-ecordonnier@snap.com>
References: <20240610143214.2376414-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Jun 2024 14:33:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/289

From: Etienne Cordonnier <ecordonnier@snap.com>

For some reason this fix regressed in scarthgap.

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 recipes-devtools/clang/clang_%.bbappend | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-devtools/clang/clang_%.bbappend b/recipes-devtools/clang/clang_%.bbappend
index ce2a3b3..e55dff6 100644
--- a/recipes-devtools/clang/clang_%.bbappend
+++ b/recipes-devtools/clang/clang_%.bbappend
@@ -10,7 +10,7 @@ DEPENDS:append:class-nativesdk = " clang-crosssdk-${SDK_SYS}"
 
 # perl tries to call readelf, which does not exist on darwin (it would need
 # to call objdump instead but the detection logic does not work for some reason)
-RDEPENDS:${PN}:remove:class-nativesdk:darwin21 = " \
+RDEPENDS:${PN}-tools:remove:class-nativesdk:darwin21 = " \
     perl-module-digest-md5 \
     perl-module-file-basename \
     perl-module-file-copy \
-- 
2.36.1.vfs.0.0


