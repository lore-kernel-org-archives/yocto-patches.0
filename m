Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21183.1792669658698493651
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 22 Oct 2026 04:47:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LU+NnWH6;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48b001cd92bso993765f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 22 Oct 2026 04:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792669657; x=1793274457; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O+hU9dpypupzPBuvIXIHgxBfLHkyDfI7bQKnTu7i9iM=;
        b=LU+NnWH6MDGBWDuV3yTBx5aWIu/mpkyTgGjaKLMfaiR3aLplToxIwCcwIjPkxeLTz3
         PWve8mOuGiPp3x2X9NUI6FyRkskTRJe9g9ClVAjQWCzlEi25Z0uZbGsQd0sFI8XgSwzC
         4zgl9JxnFxcYgrymEMOATfbzUKCl8u8/XYl5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792669657; x=1793274457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=O+hU9dpypupzPBuvIXIHgxBfLHkyDfI7bQKnTu7i9iM=;
        b=b9LHXub6ui0Y6VIcP7RGv7VIctYOWna3bDCITgxvE3eVuUh8K5OPN1TbLch3jnO8rb
         o/BCGXxWijrOD6bqPJFXmHRgQSL7dc6qYit1IdPG3hFC50aL44bTrzJ3zHTwXSlGp0nC
         72IeAFuIf6VRg0hq2EChW6vMn+ua+nDk3GkYgo2JyMMZvy8rE0bd2SENJUeIXgSTtsr0
         h8b849Rs22IvZp3rQNSKeLzz84/PpTOGsEdGLYBl5btsE7txoTgJyHUU8JhhpgVOt6Ul
         y9emw3dqQt3p0BurR4KkjweuRqrdYAHwzHQoja0C3wFUdYLbXQxPhUIYWP9RoBkO+N68
         MKGQ==
X-Gm-Message-State: AFq9FYLn+2I96IG99cPDmLnGs+xOuDFkn8qN1B/AtKsKz3M7ZaqM3g80
	mIaChkpq5ISif0jgE9dN/HXv3+N/cg9On8NXFukoEgu6ZjtIHzBdD41ThJ5ZHgnFSdX7BchMhaA
	PQQAmtNU=
X-Gm-Gg: AYBFou09usrJX6W5fUsf3yEIJNDFjKh+7UY693R0B0gGzNun9MOzfv8w6bnqArENIPB
	O6n4IAMSlAHNZeJWRF9QNPs/YkhMoPkvfCiGmG3OAnyBI/ndmo+qrWb2vpx7roVUSKC/AZx7cne
	T+qwS9a3G1rcGJ1qo9zRlQIeNIgjGcP5guYbdX7/TiMTJvZdkfVhNoJ4ZjrRX8tVjCjeFXMdWUE
	R/eKuXtBacbYutizUHLJDRqoHo2xqEwdLtm/SgLPRmtnTIUdVZIVq86h9VDMDJm2Mlb5nd7DTNT
	gnJikLJxAx7Oajaf7JddH69SonKocZ3iYDnzdz62oqmKXkiRtO6hUyDRcO6q4jC5+UnSM8Odf9l
	PEcQgUgHs5lNwrR0AoQ/NV8tf3Fp/Fi/c1wY4L0SA5O+bTklMftXfJ9oUGRIY2i23z4w1O97u6s
	7nwcmkoBLKdicWUK5CUL93VxsJIrQQUhE7CiiRXU092b3izwJ398RXU/mXCLy6sU0nUa5ns0k1r
	SSErrPe+iIvdIernE02Z34wxdGLVvnmn8CFIqjZAuJ2p1C+FWPsa7i9yttyJEhxaXhVqxWsgHJX
	sj95ADWw
X-Received: by 2002:a05:6000:4555:b0:48b:9ed:b81f with SMTP id ffacd0b85a97d-48e264a3c51mr6828375f8f.10.1792669656451;
        Thu, 22 Oct 2026 04:47:36 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:b8c1:c201:8aca:1e39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25827087sm11743499f8f.21.2026.10.22.04.47.35
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:47:35 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH v2 2/2] config: Group reproducible builds together in UI
Date: Thu, 22 Oct 2026 12:47:33 +0100
Message-ID: <20261022114733.3551925-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022114733.3551925-1-richard.purdie@linuxfoundation.org>
References: <20261022114733.3551925-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 22 Oct 2026 11:47:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5134
Content-Type: text/plain; charset="utf-8"

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/config.py b/config.py
index 89597a86..1df8d34c 100644
--- a/config.py
+++ b/config.py
@@ -337,6 +337,12 @@ builder_tags = {
     "oe-selftest-centos": ["selftest"],
     "oe-selftest": ["selftest"],
 
+    "reproducible": ["repro"],
+    "reproducible-arm": ["repro"],
+    "reproducible-arm-cross": ["repro"],
+    "reproducible-cross": ["repro"],
+    "reproducible-meta-oe": ["repro"],
+
     "metrics": ["metrics"],
     "metrics-gitstats": ["metrics"],
 
