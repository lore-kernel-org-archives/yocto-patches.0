Return-Path: <t.f.g.geelen@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75EDC2A066
	for <webhook@archiver.kernel.org>; Sun,  4 Jan 2026 00:48:29 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35368.1767487702791552132
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 03 Jan 2026 16:48:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=N/O9dXE+;
 spf=pass (domain: gmail.com, ip: 209.85.208.48, mailfrom: t.f.g.geelen@gmail.com)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b9b0b4d5dso22498681a12.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 03 Jan 2026 16:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767487701; x=1768092501; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AvTX07hziodeXBFZsffkGokPkWV7pV4VfLMk+TdqRs=;
        b=N/O9dXE+5EpGg0D79GLjk3XFWGjKPlhO+BYYFOEZWo+Y0guuDlKC2HrDFQE1Zw4LNa
         HAjZnjK/MDd+qH8f/JwaRmYmjSN/h2JCVTUpVlqvDdw4qGR+iWMPmqtnUrNFk6euIGc0
         cm51vdXF4YZiS28T4bLLhlXyN/kMyO/Nnfg5RRo7qBnEUyySdZI6VyTb23CTUDxYWEQZ
         XaBzVYxb4cv+u6kgG4KkIqXDDysz5rNuIQCRcvRgAYX0keFfk1a574hFV879oL/05+Lw
         Gt0F9FP8r4ZS0TxKuThKVCggMG3Lbi+8C6PEK23Z0iTb0jHSVe6Zsw6+bJycsGS5Yd4C
         eUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767487701; x=1768092501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4AvTX07hziodeXBFZsffkGokPkWV7pV4VfLMk+TdqRs=;
        b=lmrLOY494Dzsa2IiLKsK8JpUnyLrpj8Icm+aM5Q24IyF9sQe76/xVJEZ8QfKmgMY/7
         i8hvc0q9h4BBt9G6A+I2OorGvlDjyyXLil0Zeb0RtEXAD7PoR02nfMDvldpA2rnc9ITL
         csB2k5QoAzEvvZNjVo7QAvsAWzGjp5ZbdvR3SLQ916uBxbtpaJ4KzGAD9o3RO+VwZKAs
         bG4cNRsj18o9dAbELhFYKbnOShWkL49XjihrEDNYJaMVl+6vtxln80VZokCzrIi5ecx1
         smMH2HdWdP6r39peFl+/HHJ6aboEJWFRmq9LOHHJEq7UZuPmJdwjqqt8XREAgZLv9suR
         /vyg==
X-Gm-Message-State: AOJu0Yz32ViClxOk4CzEvaGXIeUabBIxozquF0gXXTTLIIKFGvL5Puy3
	9i8m4ewUK6A/vZb8A0ajHLd0tVC6J4XpKCb5vay3fJp+qmN0GlFSKhTmkJoEvEqu
X-Gm-Gg: AY/fxX55wLMY1Zzim8r6kIL2yKIW+zeXGxQTpVhU7nJZZO4MHC7K8iJ1gslAr03x2yd
	qppPmcXmtz8KGhL+TWoDCKCALs2CXFdArHNs9xMlbQNP5omkKEZSmqoWTUYgzXy4lb2UINNGAEE
	b/G1+8Kw1b9Iihqzh+SsO1+fbmWfoqLxPLytK3ofxKemtxNWSjZLZ5wU4z4nFQdMxa3v6fSGmeo
	OHZzFK0YTRKbDQl0s+M+3wtcmeyTj9y/ke7P+qVUSVZKLWRNCGJbUBMdON7qZHHHaJdK5trUUHv
	hTxazcVT0Lvf/SuehcKTSiYpLoAqTq+jBYFDQiYp4lIiXA71gyK6jqTtiRDGMhgL7NON3HzcvSt
	bZxC7cC2tmgdiixlIx43yzjzWKL9NeNYy0IRiGkHCbEeWPZR1bXYkmEerp/XVTiE+KoaAvFAejb
	fmRO3ctKPszQtlYfbJeMhIoLXLK6wF1adCXok2+HetbAlnFEYuF7N3XCyZUfAZHtbU
X-Google-Smtp-Source: AGHT+IGyOLeGOdMX0gQmJe8FT82g/NakVX/whuXQMAOgdRIWtmHt/ZqqcvRqFbl3KxerfkC4L/R+Nw==
X-Received: by 2002:a17:907:3f28:b0:b7a:1bde:a01d with SMTP id a640c23a62f3a-b8037228e19mr4541831966b.65.1767487700648;
        Sat, 03 Jan 2026 16:48:20 -0800 (PST)
Received: from control-center.fritz.box (150-12-20-31.ftth.glasoperator.nl. [31.20.12.150])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a5bdfesm5104839066b.10.2026.01.03.16.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 16:48:20 -0800 (PST)
From: Tom Geelen <t.f.g.geelen@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alex Kanavin <alex.kanavin@gmail.com>,
	Tom Geelen <t.f.g.geelen@gmail.com>
Subject: [auh][PATCH 2/5] Fix identation error
Date: Sun,  4 Jan 2026 01:46:59 +0100
Message-ID: <20260104004708.2494403-4-t.f.g.geelen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260104004708.2494403-2-t.f.g.geelen@gmail.com>
References: <20260104004708.2494403-2-t.f.g.geelen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 04 Jan 2026 00:48:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2890

This module was not working correctly due to a mis-indentation of the
__str__ method.

---
 modules/errors.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/modules/errors.py b/modules/errors.py
index 48e8b70..7adb103 100644
--- a/modules/errors.py
+++ b/modules/errors.py
@@ -109,5 +109,5 @@ class IntegrationError(Error):
                 % pkg_ctx['PN'], stdout)
         self.pkg_ctx = pkg_ctx
 
-        def __str__(self):
-            return "Failed(integrate)"
+    def __str__(self):
+        return "Failed(integrate)"
-- 
2.43.0


