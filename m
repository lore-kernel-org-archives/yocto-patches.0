Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9700.1795884897330226024
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:54:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Uynml0i6;
 spf=pass (domain: konsulko.com, ip: 209.85.128.44, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so88098755e9.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795884895; x=1796489695; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8XBD6ALQaJK92nf+7vncZ1lO+0yF5z3VJSCPnraprLA=;
        b=Uynml0i67AVhQxA2BSB/fOlsZ6hGBbd1iV8cSZ1eyKNiTwmQm/oXB791mn7548RCP6
         FzP+bRDQ+8tWR3Imk6GlYdWx+AyDk/oSv0COJ3Irns5oAJ53jKBO5rbvYH6JwoWTMUhW
         wMcB/sbILsI3NQB5QQLmiRRO1Rdg5UCPtBLa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795884895; x=1796489695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8XBD6ALQaJK92nf+7vncZ1lO+0yF5z3VJSCPnraprLA=;
        b=q2EaU+1XLf9iW9Cze1Rpl/N9qjQDSdeW3LbQsJ83GeWNq+bMt0p/03x0jRgksVUfnZ
         CcWsCfsqN05/RyAbkmAdhZvQieTHwk/fw2Z0AsvgjYG6vDDhu8mlAypXGmwsQR/MA72V
         /q1BeHOFWJEBp1wYNbtXSDMb70YKyqyj8CTFecd7yR5JbQisFIhvDJxEtj/oW4OJAFGm
         JFEENQUTQ5Z3KoDYSU+SxyhPEsyzwBZDVRzuLxDDUVETyHDN/tIKfFftrBiiG2fftU/2
         6CrKerjEFT3P3WVcn3sOsQdQE47zYatIGosuA21pFDqpibOvqmMAzi+6f42PckmmhVSk
         7K+w==
X-Gm-Message-State: APuU4Z+PDlAnKRqnOcQrduA1VEqfxSPeqs4rYnjv7ScSA5s9FJTsIkLs
	5PC2p0vKGbOEYfykfc39nc+pXptZLo0ok/SpfwxJyii5Y7MoLyGKa9nOHI5nEXwElHdmEz7oS/o
	40Ou7uWw=
X-Gm-Gg: AZFdTZd+54JInBitEF7ojrOFTZRCoMc2d1isM+2HLqP7chA9h+goHCgh0R8Y9qwVkHT
	v8l0VCgYZLh/wDXc6kSenvB/0cY7hy44xdkS+hrV66N6ErP7NVNmHgTTQzfVjqtmH2ZDBZbjLK0
	jWTRfLfispG7YHK1jlA4OnT0XNgk8etJY1KANovU9/eWcLjXYn52C7BRIoAgwAe/cE6fqk9QB12
	S80+zjqlRbqql6a8IMmtMDBpXQO17E6yOCDRDmQjUGr62HHqyyVihEsQi2rgVdnYlzpQEBQxATC
	hfoi/N7RqS5/snpGCdSUT9Wd4cwaYnRrDGQ7c8QF7/wMIgsvkMdYtwG1PnvhTL7Z+DnLSfbem7p
	AxsPJZiZTmpmIZCe9JkX0Nk+y3fO8N/lhd431k+or3iQhJXQ0opDo9XI+QKDvDoCJHJl4rPpF8e
	3ZxtoU3jmItsuAq247tCNs29izkyUdoGE9P6NRErCXKMbIg/TenTjdQ3HpLh1mdBedFZaHQV/l1
	p4vv7Gr5yKXATQQDKcp/FYWNk1yy5B3f9Xs9EJR9F2HIy4+J8hiQSeB+jXTHLysCaurORwFURJ2
	CIisFwAtkqYD2ogduh3Y739QtpniZC4v32GQbvv89UaMWwcVr/kFdMkaGYa6Y5dHuFmkU79VR9n
	leLWFaiiGjDwtoNWqapkbA+MHvKGTHk5cqFqApAQYJecudSHh9v8=
X-Received: by 2002:a05:600d:1c:b0:4bb:9dbd:feb7 with SMTP id 5b1f17b1804b1-4bb9dbdff35mr301298855e9.9.1795884895549;
        Sat, 28 Nov 2026 08:54:55 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm755951155e9.15.2026.11.28.08.54.53
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:54:54 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 09/14] suricata: drop oe_cargo_build usage
Date: Sat, 28 Nov 2026 18:54:27 +0200
Message-ID: <3a1f0ae15c1cd131fdded7bdf5c3c6cb4fbf11a5.1795883420.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795883420.git.scott.murray@konsulko.com>
References: <cover.1795883420.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:55:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5579
Content-Type: text/plain; charset="utf-8"

Accommodate removal of oe_cargo_build function in oe-core commit
a64ac03a61 by renaming our local override to cargo_do_compile to get
the same effect.  This allows building with the wrynose/rust mixin
layer.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-ids/suricata/suricata_8.0.6.bb | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/recipes-ids/suricata/suricata_8.0.6.bb b/recipes-ids/suricata/suricata_8.0.6.bb
index 2001cb4..29f259b 100644
--- a/recipes-ids/suricata/suricata_8.0.6.bb
+++ b/recipes-ids/suricata/suricata_8.0.6.bb
@@ -86,12 +86,17 @@ CFLAGS += "-Wno-error=incompatible-pointer-types \
 # breaks building this recipe. Providing a copy of the original function
 # Armin 2025/04/01
 #
-oe_cargo_build () {
+# 08/2026 note - oe_cargo_build function inlined into cargo_do_compile
+# upstream in openembedded-core commit a64ac03a61, handle by renaming
+# our forked function to cargo_do_compile to override it directly.
+# This still works since before a64ac03a61 cargo_do_compile did nothing
+# but call oe_cargo_build.
+cargo_do_compile () {
     export RUSTFLAGS="${RUSTFLAGS}"
     bbnote "Using rust targets from ${RUST_TARGET_PATH}"
     bbnote "cargo = $(which ${CARGO})"
-    bbnote "${CARGO} build ${CARGO_BUILD_FLAGS}$@"
-    "${CARGO}" build ${CARGO_BUILD_FLAGS}"$@"
+    bbnote "${CARGO} build ${CARGO_BUILD_FLAGS} $@"
+    "${CARGO}" build ${CARGO_BUILD_FLAGS} "$@"
 }
 
 do_compile () {
-- 
2.47.3

