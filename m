Return-Path: <hprajapati@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CDCD25030
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 05:18:50 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27114.1768195124637608043
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 11 Jan 2026 21:18:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=CSGYTCMY;
 spf=pass (domain: mvista.com, ip: 209.85.210.181, mailfrom: hprajapati@mvista.com)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81f4f4d4822so208073b3a.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 11 Jan 2026 21:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1768195124; x=1768799924; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F5zKVdh0A+EjDPmt6bvMr9KKfUkVRIjmADxa2+3bWCc=;
        b=CSGYTCMYD0rXEcRh52BFbhUxvAqYzVS+Jq2a1YhtJFdx/Zq4/ZnbKHLSYE+TAQ0PYQ
         4CleCa7BzlqIngm4IDiwK+5OEPfojTj7J1EIOd3HASFzh2Qhk5Pxx6zL+IdJFqz022NM
         INiL3Kgooqx8LYZ6OCMry3voK8T2F2rcVWfiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768195124; x=1768799924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5zKVdh0A+EjDPmt6bvMr9KKfUkVRIjmADxa2+3bWCc=;
        b=NIv6k9cMaJRaFbRQNhihgM+e+K0XAeblrSLKWkrT1ukvk+oJRmZG4sS2sebCPtUlSB
         uWHZQBWCeGjiRR2eZYJsMfYFHuuN8IvQGsWKa3iCdk1+cgDX9r2Y+s7ibCKFlD95kfD4
         rkfJxfHtSQXn2C1AKhjAme+kH3qtHRIBaPTb+MtWnLV+bX5+aFEKc0AvNcr2DmKFikut
         rWUHE9P8XQ7q3CXjN//BpKaK5Ytycb3sGgnyIyd7W6Tts1cgkTonbWDcBDPIgzYFKsAq
         6qzvWYqHReZ/XIqEwyLRaCCyf5YL4lguTrn/cpUr/PFz8qCksxwGdC4xSd/oEcAQuFhV
         QO7A==
X-Gm-Message-State: AOJu0YyWfAGnbS1LC/yRCLMTKnahtd0bcVLa1nGd7NNq6knqf/0RJXz2
	10aHrnu49kwsVJqokKCoXbGGvAhZI9wnwfczOk/aMtil4KncOxj1bCwBa71L0IoJeYTBiuyKzeZ
	UIRYE
X-Gm-Gg: AY/fxX4YOKMTkC9xCBJ1KbKAvFbDnolBHU2qoRCrRSPtjcdYhPHuNbJJtIPfGWXck4k
	UAQ23h19aGb5FNrjlmZI7XI8DaPUgOJ2Ei2W6Ix4XJbfeX7h29fkrOCxya2Kp+uBryN9qXmdYoL
	JgN3X9mt2548J86Zty8KJiqiMTQpxz+DSR4n7xEppdtl9b+B/aMRWkYZkpmBnNMCgEY6eLW2BF3
	Mzd+ZgGegTcdggc8jSMSZaBfvZnl9NNG2vjd9LfKqSEOjeqWJom5IdZY23c+BLMKzyofSDK1ckX
	fzElLPF2UNwAsTTuKLwfUAagvign7PUa7wNcgzUHbLgVj9J7beBGKkbJIe629kLtYyYvMu4IFT+
	NX0MjI/FN4P8D2U9RCJn4mq/uiGGu26j3IDR323+Fte90MRDIoLXaORqTxAVOM7U0JMuyAbiiEZ
	Y0+dErWCc6MEx8+TenalNRE9M=
X-Google-Smtp-Source: AGHT+IEQOD/cH/w+wH343nt0WKwmyi1iC8VrZqhMxpaeXSlV1Qgb2pDrTPukvX6ARsv5XCEjfshxKg==
X-Received: by 2002:a05:6a00:338a:b0:81f:3eda:9d69 with SMTP id d2e1a72fcca58-81f3edaa684mr4628899b3a.22.1768195123748;
        Sun, 11 Jan 2026 21:18:43 -0800 (PST)
Received: from MVIN00013.mvista.com ([27.121.101.119])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81e6c8199f4sm4558855b3a.68.2026.01.11.21.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 21:18:43 -0800 (PST)
From: Hitendra Prajapati <hprajapati@mvista.com>
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com,
	rybczynska@gmail.com,
	Hitendra Prajapati <hprajapati@mvista.com>
Subject: [meta-security][PATCH] suricata: fix CVE-2025-64332 && CVE-2025-64344
Date: Mon, 12 Jan 2026 10:48:33 +0530
Message-ID: <20260112051833.59731-1-hprajapati@mvista.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 12 Jan 2026 05:18:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2941

Backport fixes for:

* CVE-2025-64332 - Upstream-Status: Backport from https://github.com/OISF/suricata/commit/ad446c9006a77490af51c468aae0ce934f4d2117
* CVE-2025-64344 - Upstream-Status: Backport from https://github.com/OISF/suricata/commit/d364b04a595facd5980c44f4f9ea39319999bf66

Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
---
 .../suricata/files/CVE-2025-64332.patch       | 44 ++++++++++++++++
 .../suricata/files/CVE-2025-64344.patch       | 50 +++++++++++++++++++
 recipes-ids/suricata/suricata_7.0.12.bb       |  2 +
 3 files changed, 96 insertions(+)
 create mode 100644 recipes-ids/suricata/files/CVE-2025-64332.patch
 create mode 100644 recipes-ids/suricata/files/CVE-2025-64344.patch

diff --git a/recipes-ids/suricata/files/CVE-2025-64332.patch b/recipes-ids/suricata/files/CVE-2025-64332.patch
new file mode 100644
index 0000000..9beb3f0
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2025-64332.patch
@@ -0,0 +1,44 @@
+From ad446c9006a77490af51c468aae0ce934f4d2117 Mon Sep 17 00:00:00 2001
+From: Philippe Antoine <pantoine@oisf.net>
+Date: Thu, 30 Oct 2025 11:27:22 +0100
+Subject: [PATCH] util/swf: move allocation from stack to heap
+
+As it can overflow the stack
+
+Ticket: 8055
+(cherry picked from commit a84addb771846f6d4d55ec535a4591f58369e49c)
+
+CVE: CVE-2025-64332
+Upstream-Status: Backport [https://github.com/OISF/suricata/commit/ad446c9006a77490af51c468aae0ce934f4d2117]
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ src/util-file-decompression.c | 6 +++++-
+ 1 file changed, 5 insertions(+), 1 deletion(-)
+
+diff --git a/src/util-file-decompression.c b/src/util-file-decompression.c
+index dfafdc8..bf65b0b 100644
+--- a/src/util-file-decompression.c
++++ b/src/util-file-decompression.c
+@@ -169,7 +169,10 @@ int FileSwfDecompression(const uint8_t *buffer, uint32_t buffer_len,
+          * | LZMA properties | Uncompressed length | Compressed data |
+          */
+         compressed_data_len += 13;
+-        uint8_t compressed_data[compressed_data_len];
++        uint8_t *compressed_data = SCCalloc(1, compressed_data_len);
++        if (compressed_data == NULL) {
++            goto error;
++        }
+         /* put lzma properties */
+         memcpy(compressed_data, buffer + 12, 5);
+         /* put lzma end marker */
+@@ -183,6 +186,7 @@ int FileSwfDecompression(const uint8_t *buffer, uint32_t buffer_len,
+         r = FileSwfLzmaDecompression(det_ctx,
+                                      compressed_data, compressed_data_len,
+                                      out_buffer->buf + 8, out_buffer->len - 8);
++        SCFree(compressed_data);
+         if (r == 0)
+             goto error;
+     } else {
+-- 
+2.50.1
+
diff --git a/recipes-ids/suricata/files/CVE-2025-64344.patch b/recipes-ids/suricata/files/CVE-2025-64344.patch
new file mode 100644
index 0000000..0a0bc27
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2025-64344.patch
@@ -0,0 +1,50 @@
+From d364b04a595facd5980c44f4f9ea39319999bf66 Mon Sep 17 00:00:00 2001
+From: Victor Julien <vjulien@oisf.net>
+Date: Fri, 31 Oct 2025 09:38:55 +0100
+Subject: [PATCH] lua: remove luajit pushlstring workaround
+
+81ee6f5aadeb ("lua: push correct length back through ScFlowvarGet, work around valgrind warning")
+added a workaround for valgrind warnings in pushing a string buffer
+into the lua state. This is no longer needed as tested with both
+address sanitizer and valgrind.
+
+(cherry picked from commit 52fd61dffdfa50c9a2d4ec24865a54da0b8f0a2a)
+
+CVE: CVE-2025-64344
+Upstream-Status: Backport [https://github.com/OISF/suricata/commit/d364b04a595facd5980c44f4f9ea39319999bf66]
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ src/util-lua.c | 17 +----------------
+ 1 file changed, 1 insertion(+), 16 deletions(-)
+
+diff --git a/src/util-lua.c b/src/util-lua.c
+index 9e65c30..3dd1d31 100644
+--- a/src/util-lua.c
++++ b/src/util-lua.c
+@@ -328,22 +328,7 @@ void LuaPrintStack(lua_State *state) {
+ 
+ int LuaPushStringBuffer(lua_State *luastate, const uint8_t *input, size_t input_len)
+ {
+-    if (input_len % 4 != 0) {
+-        /* we're using a buffer sized at a multiple of 4 as lua_pushlstring generates
+-         * invalid read errors in valgrind otherwise. Adding in a nul to be sure.
+-         *
+-         * Buffer size = len + 1 (for nul) + whatever makes it a multiple of 4 */
+-        size_t buflen = input_len + 1 + ((input_len + 1) % 4);
+-        uint8_t buf[buflen];
+-        memset(buf, 0x00, buflen);
+-        memcpy(buf, input, input_len);
+-        buf[input_len] = '\0';
+-
+-        /* return value through luastate, as a luastring */
+-        lua_pushlstring(luastate, (char *)buf, input_len);
+-    } else {
+-        lua_pushlstring(luastate, (char *)input, input_len);
+-    }
++    lua_pushlstring(luastate, (char *)input, input_len);
+     return 1;
+ }
+ 
+-- 
+2.50.1
+
diff --git a/recipes-ids/suricata/suricata_7.0.12.bb b/recipes-ids/suricata/suricata_7.0.12.bb
index ff022e0..a87bd58 100644
--- a/recipes-ids/suricata/suricata_7.0.12.bb
+++ b/recipes-ids/suricata/suricata_7.0.12.bb
@@ -16,6 +16,8 @@ SRC_URI += " \
     file://suricata.service \
     file://run-ptest \
     file://0001-Skip-pkg-Makefile-from-using-its-own-rust-steps.patch \
+    file://CVE-2025-64332.patch \
+    file://CVE-2025-64344.patch \
     "
 
 inherit autotools pkgconfig python3native systemd ptest cargo cargo-update-recipe-crates
-- 
2.50.1


