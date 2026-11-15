Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.619.1794706854278395816
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 14 Nov 2026 17:40:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=PLfsbNjg;
 spf=pass (domain: gmail.com, ip: 209.85.214.179, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ed0e2015aaso10885685ad.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 17:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794706853; x=1795311653; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1IT8MkeqBCgIwNU8Ksroz6s3lTqtmIW21uIQD4HkkX4=;
        b=PLfsbNjgUDzzbrOjpPznmrky2GYucQgiZnJS8fMIPmIfdOshaHwdr3LSXVqHg1X2Mh
         iGHBH0bDBDwqUFzxbAatPH7PUQJhBwhXO1avB/Og/w6ZLaIOlh6doaFOQXwv3k48eWfD
         tohtCEqV6cIVMHIxFhEL/Lw3hufENXU/lvoz9xLDhJ/fLQH52xBcJEaJCLOA+kgCvx3u
         Ta2YDnTW5rQ6OScRXfwy+Kiqsal81pIf4vY2PaAH09b3MXtaAMht3V1XQKxfcSuCSxfa
         JF76VJ9pzZ/3c/JOkTcuzxd/V/545ckDAEVkJJhkTPNgsU6hCedk06IDqCZDoBHYmRrf
         3wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794706853; x=1795311653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1IT8MkeqBCgIwNU8Ksroz6s3lTqtmIW21uIQD4HkkX4=;
        b=uSJTQKbTH2rwurE1Hrcq2rbO35osC835ya6Su5qc6gxSCA7fFK3rztuxi4Pr6F2Q5n
         3vFP2VvVkzMFPc/15mTScjbzwze+BrFi3Ykn1NZH2zgB28R0pQiGOuMivlacdwqeQSMX
         ZK7JMYjtrjWzGCYG6krlHBi+992gpO1crd3jnGdqQxUTbO9W+QTNwmAgKADF5npZb+hz
         ncQAda/PTjL9LVYIBNo3vhtdEzV7AUjKKjwUoBuWc0e6Q6lizvwek8U3EC7FUADPPb2A
         FUtcHtRizJUJWieHPIrm9yuFzcPE0BfBoz2AXxXDD0xALUyeKwrQhp7BcBDIXGKU1eIU
         kuQg==
X-Gm-Message-State: APuU4Z/lxS5H5P1YtmqRU9U1LzOMwbLAhKIm2Zsmb1bROuLJumz7bQFj
	CU8lPfGhCl5U53MelCZd7/340Slcaxcolrlimt6MYt6P3GUg6a6IS6svgRQfSg==
X-Gm-Gg: AYBFou3FZfsNTyzaDnvl89F7EzN8TW8QGo12AlSIRl2vLUvbvZn978asR3JdXcmnj8z
	9h9in0nOyetwiiN3UvDLyacg/69IdB8mNXupaLbHWbG0GHzVohCu3jgZY+p2k6l6IxX9Ig2cm2t
	2DliAPxZOIu2UaouMpQ3b4VGH+sGOcoSIya/ic3Y/NRoqufaW8iYtLJ25+uRcbEkI9v5dJy9AIU
	YIbEA0BqwUWbyPrhQAVVzm9A3oA06Bt76ghbzMXpcET4cL15D9KmqBKyUL+eKf7o5NNmjtiKCZR
	RbddIRXb6x9nIyccRnN/YOrFZMXBbhvfvKj9UXASE3JEQXJWndvG3Js7+6OwewYYVkfxVEEmSZh
	WApnVh1nPhBqzGSiE/QEhEJ/9RlWED7E3qTd3uPXhA3wNobwRL+x+lnXjTvET4cr0xpIH3nDcP2
	Qvn4PQGDfMY7W1lGJxLGACZFJ8xpDoDKf1GhhIwS6UEsWMiDyB68E5eUo0bYl10mJ3FLF50X12r
	5qxmb943Mz995oOC0sjaVkZ7DZcCheYwit60QvkvGLio10hkfqG3Vl0BCWWn57HaAT+0f4ZNhsa
	v2RAgMZ9srIC5rflVoVrOrLUH+P7Sxirz3HNgjyLjpfrBJCDPSly/0KcrFqRNg==
X-Received: by 2002:a17:90b:4c0f:b0:3b0:a757:e372 with SMTP id 98e67ed59e1d1-3b1b0b63d19mr6610099a91.47.1794706853513;
        Sat, 14 Nov 2026 17:40:53 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b24938bdsm5663731a91.1.2026.11.14.17.40.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 17:40:51 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] rrs: show the upstream version column when listing all recipes
Date: Sat, 14 Nov 2026 17:40:19 -0800
Message-ID: <20261115014019.62370-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 01:40:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5386
Content-Type: text/plain; charset="utf-8"

The recipe list hid the upstream version column under the default "All"
filter, so the version a recipe could be upgraded to only showed once
the list was filtered by status. Hide it only for "Up-to-date", where
it is the same as the recipe's version. The recipe detail page already
shows the upstream version for recipes that are not up to date.

[YOCTO #15577]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 templates/rrs/recipes.html | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/templates/rrs/recipes.html b/templates/rrs/recipes.html
index 663f547..1dde703 100644
--- a/templates/rrs/recipes.html
+++ b/templates/rrs/recipes.html
@@ -251,7 +251,9 @@ $(document).ready(function() {
             $('.summary_column').show()            
         }
 
-        if (upstreamStatus == 'Up-to-date' || upstreamStatus == 'All') {
+        // Up-to-date recipes are at the upstream version already; everywhere
+        // else (including All) show which version a recipe could move to
+        if (upstreamStatus == 'Up-to-date') {
             $('.upstream_version_column').hide();
         } else {
             $('.upstream_version_column').show();
-- 
2.56.1

