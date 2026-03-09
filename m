Return-Path: <sebastian.trahm@googlemail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4C3FCA189
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 20:24:50 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24425.1773087888463367016
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Mar 2026 13:24:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@googlemail.com header.s=20230601 header.b=OGN1pJSB;
 spf=pass (domain: googlemail.com, ip: 209.85.128.50, mailfrom: sebastian.trahm@googlemail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-485409ab264so5558475e9.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Mar 2026 13:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1773087887; x=1773692687; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaFMzEcOXdK+q3HY8NzQkSSoZTfv6zxyluxA54i5Ysc=;
        b=OGN1pJSB9UPBwMqH9+MLcuY5n2D8sMXOq0KlTyQygZJpjKu7epUl3iyyh2Ql7zbl/y
         +BPcV5mD7QgixAKFH4QXbobZGz8v+C4N7EPcJG17NQAgLBuBtrWvYihBzmLGmoxFJr2x
         17gvwDLjczjJWMPlJW1NrHfWALiElXLD5PwcCvNjMQj9Sz+/bV/kSoLA7MtQLv7POxZv
         00bTXXafRwHk23m6q+6+Idj/7p7VXHtaepenX2KIL7buMSl014jvc4LgifpL+Xo9uchm
         l5JVHwB2aAfCmukAOeLNMhXXZ8PT8/UpPnoU2wk88knlmvSYIQ8gKXhfS6oOISrWYsrQ
         wYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773087887; x=1773692687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SaFMzEcOXdK+q3HY8NzQkSSoZTfv6zxyluxA54i5Ysc=;
        b=htoXwtc2FSmmD7wj1A0TbEbnskPjhVv3Swwyf+YbWhGygKyZCHrALEheTcGdsnkOGM
         AtOtnf7uUrfl/HAuK9KFiZScMvQXv+jme6VoR6X3XnoHf8rSIdIdksadWFPxSbLN59QG
         aNHuvXwp2gxgHy7YcMZV70cWINCE6u3MW0zp+PPsPpkBJjJj9jpcVqQ5kJsjBIOorBU5
         QPhB5eyOjot/O5OQQcPRaRC/OMOJqvSzGsz2DF5TtDv6VwuaMea3o1RNWMmk2mikeVyy
         d7UvBxmgysVzSNIy7/yElXXwo8LgZzcH/Zp783zptQKZ2dWO6etW352cAE5vx/SU5pfQ
         XjqQ==
X-Gm-Message-State: AOJu0Yx858YXRtas4Gtq0+RKz0l03+RLXDhuz7QxD1V3Ta3hJWz0AaX1
	44NK47tC9reIy1Xd2zTMmyWPZF4sXd+ykWe0JRk2wPSoTsRhSOEH75GzOzhGyXL2
X-Gm-Gg: ATEYQzxehBCJXhStJWV8koUSOLZykBtWkFlLWf1aNLyR7rm0XX8kUiZbQa4zyQZfbB7
	OFamrxmingTSgRjl/TXO7jmS0v+PAA4GTjbmxInt8GGmDilUe1O6oHmM44QNpLqxJQPO8eWJNKc
	bWaqvz2NNfhPp1pe1EzFVhpzWgGuOT1DG3G+G/2Wr0OprFQr0X/Vp+JLOUR40YZPdy8Cm93XpQm
	cpJAq+GwLcqSnQfmpKtj/h7644OS7k7Kbk99z5ugZ8EZ9c8FbPmkA2UFMWWlgfk/2c5bvhk+sjt
	f2BSEZDh9OnvGFkLyQLFfJM/FkVOGbA2+KXK7xDqI4aasGUH08Tc6h/bU9HUQdKjZ19EBduzH0p
	XKVPznjEp2QS3TW9GqrVmkNXQP85hQK6dGiN4rnApVL0Z/AoStDcjYB4KlTZY9JGQ1yhRc8Gbgu
	ZMfUWghP1RGV1INB5LvgtBfNmSeEgiylsnOEn4J9C+WGvzmxCL2xfsSw==
X-Received: by 2002:a05:600c:4744:b0:485:33b7:573d with SMTP id 5b1f17b1804b1-485419a2810mr14996625e9.1.1773087886724;
        Mon, 09 Mar 2026 13:24:46 -0700 (PDT)
Received: from aerie.fritz.box ([2a05:fa40:39e:3200:afca:d5ad:bc4e:39c0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541a8d4desm15126145e9.8.2026.03.09.13.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 13:24:46 -0700 (PDT)
From: Sebastian Trahm <sebastian.trahm@googlemail.com>
X-Google-Original-From: Sebastian Trahm <sebastian.trahm+oss@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: alex@linutronix.de,
	Sebastian Trahm <sebastian.trahm+oss@gmail.com>
Subject: [PATCH 1/1] Unbreak build of nativesdk-librsvg
Date: Mon,  9 Mar 2026 21:24:41 +0100
Message-ID: <20260309202441.295553-2-sebastian.trahm+oss@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309202441.295553-1-sebastian.trahm+oss@gmail.com>
References: <20260309202441.295553-1-sebastian.trahm+oss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Mar 2026 20:24:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3387

Signed-off-by: Sebastian Trahm <sebastian.trahm+oss@gmail.com>
---
 recipes-gnome/librsvg/librsvg_2.61.3.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-gnome/librsvg/librsvg_2.61.3.bb b/recipes-gnome/librsvg/librsvg_2.61.3.bb
index a12ffc3..2e1e32d 100644
--- a/recipes-gnome/librsvg/librsvg_2.61.3.bb
+++ b/recipes-gnome/librsvg/librsvg_2.61.3.bb
@@ -58,6 +58,7 @@ do_compile:prepend() {
 
 EXTRA_OEMESON = "-Dtriplet=${RUST_HOST_SYS}"
 LDFLAGS += " -L${B}/rsvg"
+LDFLAGS:append:class-nativesdk = " -L${B}/rsvg"
 # needed on ubuntu 20.04/debian 11 to avoid 'undefined reference to `dlsym'' errors
 BUILD_LDFLAGS += " -ldl"
 
-- 
2.53.0


