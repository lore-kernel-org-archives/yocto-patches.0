Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21070.1792669227725461743
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 22 Oct 2026 04:40:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=S5VMTwS5;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso3526095e9.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 22 Oct 2026 04:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792669226; x=1793274026; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/u0BRL1GNU+1N1UBv+Uu+Pszotl9IC938oj7VP3Kt8w=;
        b=S5VMTwS5ivX8bzD8tt43jFgd5nwow9Ai/XwUime3HCA49mYvSKMyO25bHfji1cclQo
         NATlJtdlUB63Xeb2F2RJIg1NDrHdr8w8bhxF9WMAX9ISqDr757fvm/4ciO7XDKkVmdCO
         c8N1BKQVQFt67MNUgZLM7hoQSyUHlYC7JgYiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792669226; x=1793274026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/u0BRL1GNU+1N1UBv+Uu+Pszotl9IC938oj7VP3Kt8w=;
        b=0WliTa+x1Xp6W7dFy5038qiTwo210vvbGvYI038ykGPlEC7JTUcAKNy7Np3v6cmVZh
         ve+J5+Bl3uHy10/bgG9+f0wRH9AbxbdyBKVfukEOHlTl/wD+fl9RVML1/8dqT3gf2Sly
         cbZ9Q/jFzmlvyIOBVQPc7tUtbqwKx4mb4aqJL0Vw8g81alzKNkl6jL28r/eNLmRqjTC/
         DObzYoM9xJ1wuSuiwgjJybuKfFfMKfiRCzSw4HJwEvRQ8Yk72+fW0MtA/eQ+uy0piSXJ
         R4PLX2M7JFpWapiAO4HGTNMdgu4nF3zHoBppIy+1K6F2B+3jskOHMdbcOvLHmR682E5x
         akCg==
X-Gm-Message-State: AFq9FYIcL+QyyWNrto/7v1e/s49DBVn3FWRubOenV/ud/0ULzZIr6Gw3
	EvLFVv6XL8lnUuyDQSF2uzMZT0bM3T4Q2Li0FM2te5hYE47b/sGaK2K6PG3GUJdKq0bPhU/4onQ
	PKQcMZ9s=
X-Gm-Gg: AYBFou14hEAzylF3EuvnxXC5YlCwYM39+v6KvAY0xUs7yY1qtz/mw3FF7LKWr1M/m0l
	RhWC15ocSeaXZpnWzdOltKyioSRUnWsn8xlNKLf92Qj7ayZOURVeI8WTlEcslJJLUYpFwzaIwOK
	mbDVWs9edBL54iXQirJvPgXR7pohAXqm1gmi0iAlYY0AH/iyQM3BTekG84RCvRzV9Zbh3QeE7dn
	GvTs/TMidprSqvawKDkH6bOudsIEs0AF4WO7n2uxxQy74nXd/68/ms+pu9MD/uBmMoNIpZ2iY7Q
	yHL7KjRVkazB/cGbRTt7rdXRZIhVCzfvPOC6UFzaqHCpqliZihXwfYlz1IzDeyXDnFLuWLWfcO5
	cHA+Obgqdtc6xmheN7yVHtef91ys+RNNKbcHQuyswLpokHDFwedA3421dPw1hQXDLGUzh0JiaaK
	x31sRykRPsuM3whLFMwrfUBwGnS/kPP5WxmFxLKgR4fYcgVvnXrtzMj5bkyXdGBwm/uYhzmBfj0
	bmu7E/GW+i+8YjfNtCHSqMd/nlnq8JStewGdqHXHCad9R2rjrWMy5ervm79cxnFcf0aHO0L1w88
	xuc2tSp2
X-Received: by 2002:a05:600d:6401:10b0:4a2:397:73f2 with SMTP id 5b1f17b1804b1-4a2039774a6mr36528005e9.17.1792669225941;
        Thu, 22 Oct 2026 04:40:25 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:b8c1:c201:8aca:1e39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203a3e9ddsm60237625e9.11.2026.10.22.04.40.25
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:40:25 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH 2/2] config: Group reproducible builds together in UI
Date: Thu, 22 Oct 2026 12:40:22 +0100
Message-ID: <20261022114023.3540668-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022114023.3540668-1-richard.purdie@linuxfoundation.org>
References: <20261022114023.3540668-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 22 Oct 2026 11:40:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5132
Content-Type: text/plain; charset="utf-8"

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/config.py b/config.py
index a2b43d82..bc340714 100644
--- a/config.py
+++ b/config.py
@@ -336,6 +336,12 @@ builder_tags = {
     "oe-selftest-centos": ["selftest"],
     "oe-selftest": ["selftest"],
 
+    "reproducibile": ["repro"],
+    "reproducibile-arm": ["repro"],
+    "reproducibile-arm-cross": ["repro"]
+    "reproducibile-cross": ["repro"]
+    "reproducibile-meta-oe": ["repro"]
+
     "metrics": ["metrics"],
     "metrics-gitstats": ["metrics"],
 
