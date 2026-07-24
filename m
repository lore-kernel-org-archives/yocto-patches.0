Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A16C531C9
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 11:50:38 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17429.1784893831507154735
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Jul 2026 04:50:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ScEyIWiF;
 spf=pass (domain: gmail.com, ip: 209.85.160.177, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51bfe810293so2157921cf.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 24 Jul 2026 04:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784893830; x=1785498630; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mZXDHg05dcQ1BOu43Ov+KWbJAGdkOpJL6OrIZQ4WYTY=;
        b=ScEyIWiF2FyqGpflpqAaJjyk4/GEin7hhanTaJQx/LbuoCk7RX5/cRsilRIfXXkSSN
         FZBqgrsTpnk7yQRQUrGT3VrSMpq6e9wMjHI2RaJta5fSfraxoKn0qEyZ6so37Hu4tDEy
         sQSeTkTw0GWYBtP850Nx7+9Kz/0+1plhEJp8vla5AQ3KOZ/QgsvpeytOZxrUj7Rb2p3a
         V6Pynv/0qRIlsM2uk6MD0ySjv04eX0rZ4lK3QNf7y4yPbOVxHMOtBVYpryRu+oo6JL90
         nyi+U1K56u2r6sJUh5Bna3jhZ8IhDO3DPBh0q8m8KC7GUmvDK195TUz0fQ8dNR/H5UzF
         tvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784893830; x=1785498630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mZXDHg05dcQ1BOu43Ov+KWbJAGdkOpJL6OrIZQ4WYTY=;
        b=OAEp7LM8muCgcRoOmXsejjF5xwIR8UbqpIqh7+twbrJPMHRG879jTi/uMRgmgqXPAB
         M5D7vSMO0bNZweP6UpHYi3pNto2RiK14L/uJFhg8MpAPB9J3nfUIM7VwrwZwFgb9mcOD
         qsUS3Arfk3fCJX/XIBhOkEKE/CTCh/po+8HjrWcZ29J+pRG4S0gIdyNCU49yiH3m3jcK
         QmahpIU4zIVHzLsy6zB4/2G/B9xn9ayA9XL8pZpQPfS4fhkBb7SUZSD1ITDdJG9GoMMO
         euchDmb17Q/EBL+Cznyor9rgrCuBB/B4V4qY9BuAYFeaukYxtnJtaXXUlz3s+VwV/qqF
         GHTw==
X-Gm-Message-State: AOJu0Yxnn1AY7SXej3k2X1lmO0LnKL7SEJ6/3wYF9s3CQVuGsO4blH3W
	EdEbwkDJA4xG+iQnpHXABBLFlE1w5gpWCpikpmnf+aRkFZvxwxidXI6FTMER4w==
X-Gm-Gg: AR+sD13rb6frUwXGe5DRsfn1TQ+SM3MKGL4b0WBFzbqZulhSTZpd5zuopISIfCpQxtI
	Wko0ZVxY9+q/sSO6J+NBQSzU5NyYymJmcEctYO55mTJbPW5G++0S6ITzeGvoZAJwbqz2ILYrh5I
	v/vRFn8jTg22BtCzsOMT7oByIIBzQpRXXVEYU3r3/goPq7Hxn1CV8K3Gv/vqzwZ6cIArPIpLPQK
	LYzTUqk1csq4Ei36NVZQwl2Ar8Z5cmfKOsIPbWo5V3bnDvtKk/22qSyc86Mmv9sK9fOYjxhHgC9
	S4eKpxQHJ4AZpsJJqRolvv2qWtevcLIC3wU0noL69NoPykpo/3Ubz7ILz7dka23gy6rMiJgYERl
	LCozPxj+Ghz6aiX6W/v3BroKNzfCazStMgk+AwrS2CSQ1ctDF0bZ/PpCouVD6+5Fk5GLhfW+/ca
	TQ1gGZFoI/k6kQ1zo/afTt6apF8q7nFqB1237wBrBw27SjSbP62/NPK3c=
X-Received: by 2002:a05:622a:54b:b0:51c:f3e:781d with SMTP id d75a77b69052e-5283df78640mr67851791cf.66.1784893830330;
        Fri, 24 Jul 2026 04:50:30 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907baa27cf1sm66582796d6.46.2026.07.24.04.50.29
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 04:50:29 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v2 1/4] oe/path: fix bare `false` NameError in __realpath's isdir guard
Date: Fri, 24 Jul 2026 07:50:17 -0400
Message-ID: <20260724115020.38079-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260724115020.38079-1-twoerner@gmail.com>
References: <20260724115020.38079-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Jul 2026 11:50:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4533

__realpath() finishes by deciding whether the resolved path is a
directory, tolerating any error from the stat:

    try:
        is_dir = os.path.isdir(file)
    except:
        is_dir = false

but `false` is not a Python name -- the intended value is the builtin
False. os.path.isdir() swallows almost everything and simply returns
False for a path it cannot stat, so the except branch is rarely taken;
that is why the typo has stayed hidden. But when isdir() does raise --
for instance an OSError deep in os.stat() on a broken mount -- the
handler that was meant to absorb the error instead raises
NameError: name 'false' is not defined, masking the original failure
with a misleading one.

Use the builtin False so the fallback behaves as intended: a path that
cannot be stat'd is simply reported as not-a-directory.

AI-Generated: codex/claude-opus 4.8 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v2:
- No change; carried over from v1.
---
 src/wic/oe/path.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wic/oe/path.py b/src/wic/oe/path.py
index 3e95ea0ec923..862edc532ade 100644
--- a/src/wic/oe/path.py
+++ b/src/wic/oe/path.py
@@ -233,7 +233,7 @@ def __realpath(file, root, loop_cnt, assume_dir):
     try:
         is_dir = os.path.isdir(file)
     except:
-        is_dir = false
+        is_dir = False
 
     return (file, is_dir)
 
-- 
2.50.0.173.g8b6f19ccfc3a


