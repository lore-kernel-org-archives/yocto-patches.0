Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF45CA0ED3
	for <webhook@archiver.kernel.org>; Mon,  2 Sep 2024 16:51:53 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.3668.1725295906937872985
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Sep 2024 09:51:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=POgAk85d;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374bb1a3addso1618314f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 02 Sep 2024 09:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725295905; x=1725900705; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M74M4c+3UHkFlW4RQ/demSB69OpOJT47p0cZtajw2Cc=;
        b=POgAk85dGI5OE02RFjS8ICWWi5K8KRjisAleasWZJCykBsw52QiJ0gQI6uqRWk1HNV
         iflTDWaJUH0zCFlOIutfRzUuDdQkVcwFwcses2BwGV02Wz589MaH9scGtCwwqTPJm92i
         32KFFe2WafyLf7PHaZMxnjUYCsKXr2/hFPntOovAhx0XU/+5ZTfcVqRirUh6j0+ZDt0N
         kvz41/yYDdXDdBUbV7689BchRtf1nx/+tEAJ2WUZ7pa0bjqUjF3l95yGUtu+eaUiLgdK
         +F2FA1QogGievPLikfnAex+4gMOxBj0ftl4q0/5OuEi2qPRmyRJqpexToPGMQYbTaq1e
         YIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725295905; x=1725900705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M74M4c+3UHkFlW4RQ/demSB69OpOJT47p0cZtajw2Cc=;
        b=eUroDye56pMmfnp6NGzwylGc9LrRe8cGAhCtp8wLEh93F0rwhNlpETL6b6/zLLbyaF
         6cdnMqS2o4F6KpTUwBmAdun40kzz1TOq5880lv6Wuw+MrLt+fzThaTw+jOdfQjpKdXOg
         id1hJBMTlCn0LnHyqnzx3GW0UhgJe57jyFPig1UxNMg/So43ua/wkMkYYv23GKL1rFQS
         sEW9q3MBy0YanCyQUnFihpicQSnqTMbaIxsLHrIbuah0onuqO6FbtW4bmORG/thL2P4z
         m/0438hy4BVDZStgyyGKHb4qR9S9jEL7WAAaRBXNIwOTHbvvu9a+B++Hh5UG7p1h1Af4
         SklA==
X-Gm-Message-State: AOJu0YwvB4ek6eVOWlLf05DGN91jdPPn8SWQtRNEQNXGjRfPUtuwP7SW
	EX2HWVQJipWnLq4JHTIQL1jdg5lZk7nqg94vpYZbANkjWXoV7mrCjDAXQw==
X-Google-Smtp-Source: AGHT+IHJvVTXWQhJokOZVxgVLU6U2K94uCU53A9JNonSeHr7T+SRDv5RsFsMrnpBFFZQGr7gitHn1w==
X-Received: by 2002:adf:f747:0:b0:371:8dcc:7f9f with SMTP id ffacd0b85a97d-374cc925557mr1816976f8f.5.1725295904741;
        Mon, 02 Sep 2024 09:51:44 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c958c471sm3960715f8f.25.2024.09.02.09.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 09:51:44 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-security][PATCH] suricata: run whole autotools_do_configure not just oe_runconf
Date: Mon,  2 Sep 2024 18:51:39 +0200
Message-ID: <20240902165139.2986841-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 02 Sep 2024 16:51:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/610

Otherwise Makefile isn't regenerated and do_compile fails with:
suricata/7.0.0/suricata-7.0.0/missing: line 81: aclocal-1.16: command not found
after automake upgrade from 1.16.5 to 1.17 from:
https://git.openembedded.org/openembedded-core/commit/?id=b98328a6ff07119e7ba4f1072090d789e69edef8

Fixes:

CDPATH="${ZSH_VERSION+.}:" && cd . && /bin/bash 'TOPDIR/BUILD/work/mach-distro-linux/suricata/7.0.0/suricata-7.0.0/missing' aclocal-1.16 -I m4
TOPDIR/BUILD/work/mach-distro-linux/suricata/7.0.0/suricata-7.0.0/missing: line 81: aclocal-1.16: command not found
WARNING: 'aclocal-1.16' is missing on your system.
         You should only need it if you modified 'acinclude.m4' or
         'configure.ac' or m4 files included by 'configure.ac'.
         The 'aclocal' program is part of the GNU Automake package:
         <https://www.gnu.org/software/automake>
         It also requires GNU Autoconf, GNU m4 and Perl in order to run:
         <https://www.gnu.org/software/autoconf>
         <https://www.gnu.org/software/m4/>
         <https://www.perl.org/>
make: *** [Makefile:465: aclocal.m4] Error 127

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 recipes-ids/suricata/suricata_7.0.0.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.0.bb
index 9795e95..6e6c426 100644
--- a/recipes-ids/suricata/suricata_7.0.0.bb
+++ b/recipes-ids/suricata/suricata_7.0.0.bb
@@ -68,7 +68,7 @@ do_configure:prepend () {
     # use host for RUST_SURICATA_LIB_XC_DIR
     sed -i -e 's,\${host_alias},${RUST_HOST_SYS},' ${S}/configure.ac
     sed -i -e 's,libsuricata_rust.a,libsuricata.a,' ${S}/configure.ac
-    oe_runconf
+    autotools_do_configure
 }
 
 CFLAGS += "-Wno-error=incompatible-pointer-types"
-- 
2.46.0


