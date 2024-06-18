Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7583BC27C4F
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 20:23:08 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.4540.1718742183818153450
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Jun 2024 13:23:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NSCdsK1X;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4217926991fso52557005e9.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 18 Jun 2024 13:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718742182; x=1719346982; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Czyb02sB/EI2NAkGdLUOp8fxeHdWvmCsr8PyjSpcmcY=;
        b=NSCdsK1XWh3tTYyp4V3M8zP7Aa11b6ogrM25ZZeV2LH0qWgsAYVV6U0kPWn57GicH0
         gQlb34B2GOPfX3Dq4Ano2SwBtekUDZR1thubNXh/LuXM+I2FNMl5f5TF/fnchoshkLR4
         04GDu0N9QOCiFiSxZ4btSOBeECzWDCQAsIzdziJGplVgjGQMvQFe/hKtzhgdhfPXhvaa
         059ZrcgQIMd3Ap6JG7ww/Cb9Y2+fxajOAVSahuvHIpeLmVzUg89EIzYFVcuREt2U8wu3
         31kXU35aXrGEDcvSKurvShnljSr1iD58eX9BPGu5Q6oG/7C6cBlBBP7YJZbv7xyGzZTT
         qp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718742182; x=1719346982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Czyb02sB/EI2NAkGdLUOp8fxeHdWvmCsr8PyjSpcmcY=;
        b=Lp7b8yFbxDW/uEav+HJujgvIoQF39O7SOGx4y5/yeIlTty+6wUQLfIXkT7cmdJOJ+L
         vHXJDR6oFIrgYQ2jBVsgUYxTvpAMwaT0Dne5R5NEbd7gKgm4USJJ8Qfc4Z/WFOdD80tG
         0tiRXbqXuWtskJaR+JKV/F2XvhjwMNMv+khb1gBj7vYYVn9vjOirsInWuAToEwwrWLre
         FPgo7zSSEPLvfaGB4ZBPoMmqLqjG3KDxwx//d6FJr+pbV8em4z9RKGsFUtpq+BXE7dp8
         XoUH0n3iVewDGsDVOzXWXHGGvkTlbQFcQNH7aQmq4b8FOK8QQ9GnIGh6eHCjCi7pjJ7Y
         jT2A==
X-Gm-Message-State: AOJu0Yyb91jqBGhYi+ggsPZiUOnqFOwxVfQmN+MvN9Bch0Qt3LroWBlE
	vEVRX6LU9Gnh+gDHhHBbac2wxe1mAvDRBDqarxMksdPtWo+welF6nE9GLg==
X-Google-Smtp-Source: AGHT+IGCpK8c8xLEBP8Dv89vUaWkHWwVin/dkOLeb2u8060YTbEBdhyv0odi/maGcLU2fxogVQprIw==
X-Received: by 2002:a5d:5309:0:b0:35f:2725:1aa1 with SMTP id ffacd0b85a97d-36317b787a4mr480684f8f.31.1718742181665;
        Tue, 18 Jun 2024 13:23:01 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e74c7sm236898065e9.47.2024.06.18.13.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:23:00 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-security][PATCH 1/2] {tcp,udp}-smack-test: fix few more implicit-function-declaration issues fatal with gcc-14
Date: Tue, 18 Jun 2024 22:22:50 +0200
Message-ID: <20240618202251.1850637-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Jun 2024 20:23:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/343

tcp-smack-test:
tcp_server.c: In function 'main':
tcp_server.c:50:16: error: implicit declaration of function 'atoi' [-Wimplicit-function-declaration]
   50 |         port = atoi(argv[1]);
      |                ^~~~
tcp_server.c:62:12: error: implicit declaration of function 'fsetxattr' [-Wimplicit-function-declaration]
   62 |         if(fsetxattr(sock, attr_in, label_in, strlen(label_in),0) < 0)
      |            ^~~~~~~~~

udp-smack-test:
udp_client.c: In function 'main':
udp_client.c:52:12: error: implicit declaration of function 'fsetxattr' [-Wimplicit-function-declaration]
   52 |         if(fsetxattr(sock, attr, label, strlen(label),0) < 0)
      |            ^~~~~~~~~
udp_client.c:67:9: error: implicit declaration of function 'close'; did you mean 'pclose'? [-Wimplicit-function-declaration]
   67 |         close(sock);
      |         ^~~~~
      |         pclose

udp_server.c: In function 'main':
udp_server.c:42:16: error: implicit declaration of function 'atoi' [-Wimplicit-function-declaration]
   42 |         port = atoi(argv[1]);
      |                ^~~~
udp_server.c:57:12: error: implicit declaration of function 'fsetxattr' [-Wimplicit-function-declaration]
   57 |         if(fsetxattr(sock, attr, label, strlen(label), 0) < 0)
      |            ^~~~~~~~~
udp_server.c:84:9: error: implicit declaration of function 'close'; did you mean 'pclose'? [-Wimplicit-function-declaration]
   84 |         close(sock);
      |         ^~~~~
      |         pclose

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 recipes-mac/smack/tcp-smack-test/tcp_server.c | 2 ++
 recipes-mac/smack/udp-smack-test/udp_client.c | 2 ++
 recipes-mac/smack/udp-smack-test/udp_server.c | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/recipes-mac/smack/tcp-smack-test/tcp_server.c b/recipes-mac/smack/tcp-smack-test/tcp_server.c
index 3c8921f..248a5f6 100644
--- a/recipes-mac/smack/tcp-smack-test/tcp_server.c
+++ b/recipes-mac/smack/tcp-smack-test/tcp_server.c
@@ -18,8 +18,10 @@
 // OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 // THE SOFTWARE.
 #include <stdio.h>
+#include <stdlib.h>
 #include <sys/socket.h>
 #include <sys/types.h>
+#include <sys/xattr.h>
 #include <errno.h>
 #include <netinet/in.h>
 #include <unistd.h>
diff --git a/recipes-mac/smack/udp-smack-test/udp_client.c b/recipes-mac/smack/udp-smack-test/udp_client.c
index 976cbdc..00bb548 100644
--- a/recipes-mac/smack/udp-smack-test/udp_client.c
+++ b/recipes-mac/smack/udp-smack-test/udp_client.c
@@ -18,8 +18,10 @@
 // OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 // THE SOFTWARE.
 #include <sys/socket.h>
+#include <sys/xattr.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <unistd.h>
 #include <netinet/in.h>
 #include <netdb.h>
 #include <string.h>
diff --git a/recipes-mac/smack/udp-smack-test/udp_server.c b/recipes-mac/smack/udp-smack-test/udp_server.c
index 7d2fcf5..32b5442 100644
--- a/recipes-mac/smack/udp-smack-test/udp_server.c
+++ b/recipes-mac/smack/udp-smack-test/udp_server.c
@@ -18,10 +18,13 @@
 // OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 // THE SOFTWARE.
 #include <sys/socket.h>
+#include <sys/xattr.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <netinet/in.h>
 #include <netdb.h>
 #include <string.h>
+#include <unistd.h>
 
 int main(int argc, char* argv[])
 {
-- 
2.45.2


