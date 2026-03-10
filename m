Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FF0EB1043
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 10:28:00 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36821.1773138472254232272
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 03:27:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lbZXvQM8;
 spf=pass (domain: gmail.com, ip: 209.85.221.44, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b7c2788dso6579658f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Mar 2026 03:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773138470; x=1773743270; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40kJO6oi0+pe4q7VLdIs6MhQpRmUO87/T9f+SfSQ0mA=;
        b=lbZXvQM8L1JnCIgf1zNykL2egaBRASe7RPItQ9/5Ur1C7L8Ae1KlTXVpiQVTr3EKan
         AI2UhwZ+Q6VRpCU38mm158A3zZVyzF5LMRS7rb6atZZlEniYpIxuYujtQBNU0i3fEpF7
         gTcMA4xUlmF217FrrSQ57zzd80msSRUKI91GeM2/isMXsTacDW7j0ov785LqG6CmdDHj
         lkML1IgR4BdjhsV6nhEgOUuWvvykW6vnCTelNTxdeHjkmFrXCNZFIjPngfcBbpITmNlW
         8GuPIrYV/TNOTFuy57C+1LdK8XrKSfHY24h9DvUKu+wb/WK00jDv8KeprqaB9cUp/ogz
         R+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773138470; x=1773743270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=40kJO6oi0+pe4q7VLdIs6MhQpRmUO87/T9f+SfSQ0mA=;
        b=Pv8g5wDlePAQ0f1vv/aLYaFj/4J6hR8+LP5+BwaLJFy+y6Tjywk0yeM6gyJdARFNQx
         b/7XbgLx5RvJ/jcAuxJ8QoT4eXg0bQvsj8XUbTwTuxRq5096WtkwWOh4dYtx7+ae+AP+
         9Gt/gB+ShT3ig6EQoT3sEP/LL6bq3FoKF6bmA9AiAtHvZbiEn/VbBRetdXh8zj2697Bs
         y4R151Ih3heBZlXFR+wvAWqOING32m4EdLxjMABOgv+G982nfczya/oDDqMveYCcTU0l
         ZAJVlak5xtbh/hSeBb0TOT2bv2DhqPxb0Vu8WZs5uTdUA2HJL4rp8nBKVhTFnsJYJmCF
         xPIA==
X-Gm-Message-State: AOJu0Yyhb+U8Fmuk1BxSdhjHhGHqc1pUE/57X5DO6xh1H2jKn1XCd1QE
	TfnfrRi1fX/uKBHiJjemmYX/gHx9FfAaLnuNMdh7In3IDrwXGq09ZPJEXg3lTRfJ
X-Gm-Gg: ATEYQzyAGQo7DRDigWQt1bhHjvvEouRoqoXQWyenziuxxkXiDgV31FE1pP98JplayFZ
	NG9FIjxk1wLcEaQrjV/7RAbt6LAxFPxjKekIucc7QPVbmN4vc7GoXLDO8LjYClOHt7RVBqpWw8l
	yYinS+1y9v+N3ftmhPauoR/xf7i/CDnlBufOmsVoUCF20CE9n3yuUaVSpQUy1DMNr7AgmdbCV6K
	hEQ3+JHZuwDGi4lV4UrT7wXO+actnKbMhdzf1GPnYa4MwiRHzXztkc2pk6IdpBs7CKI8gc+gOhu
	ojBEL4E+20BeycVtTyx76TTcZCuo2RUCbmgKr48E9ppxTlYaVREeWTAF4UKsejhS8mfTQl7zADh
	o5ZRxi7RxT9p7nMFr3DCT//TJ7FxVlRrfff7U6YbDZbDFja5Tlo9OQ3+tRX7jx6+apsFBEqjgAb
	hGqFnzQfs4idG356O+P5Jj4zhdsuefF4KYFtAw
X-Received: by 2002:a5d:5f82:0:b0:439:b3bb:276b with SMTP id ffacd0b85a97d-439da67bd0fmr24980519f8f.43.1773138470444;
        Tue, 10 Mar 2026 03:27:50 -0700 (PDT)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae3f267sm33049251f8f.31.2026.03.10.03.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 03:27:49 -0700 (PDT)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Armin Kuster <akuster808@gmail.com>
Subject: [meta-security][kirkstone][PATCH 3/4] packagegroup-core-security: add perl pkgs grps
Date: Tue, 10 Mar 2026 11:27:38 +0100
Message-ID: <20260310102739.2743995-3-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310102739.2743995-1-martin.jansa@gmail.com>
References: <20260310102739.2743995-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Mar 2026 10:28:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3393

From: Armin Kuster <akuster808@gmail.com>

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 .../packagegroup-core-security.bbappend        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 dynamic-layers/meta-perl/recipes-core/packagegroup/packagegroup-core-security.bbappend

diff --git a/dynamic-layers/meta-perl/recipes-core/packagegroup/packagegroup-core-security.bbappend b/dynamic-layers/meta-perl/recipes-core/packagegroup/packagegroup-core-security.bbappend
new file mode 100644
index 0000000..475a24d
--- /dev/null
+++ b/dynamic-layers/meta-perl/recipes-core/packagegroup/packagegroup-core-security.bbappend
@@ -0,0 +1,18 @@
+
+
+PACKAGES += "\
+   packagegroup-security-hardening \
+   "
+RDEPENDS:packagegroup-core-security += "\
+   packagegroup-security-hardening \
+   "
+
+SUMMARY:packagegroup-security-hardening = "Security Hardening tools"
+RDEPENDS:packagegroup-security-hardening = " \
+    bastille \
+    "
+
+RDEPENDS:packagegroup-security-scanners += "\
+     nikto \
+     checksecurity \
+     "

