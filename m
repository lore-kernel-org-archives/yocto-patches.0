Return-Path: <nitin.wankhade333@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C41CDB470
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 06:10:48 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14780.1782195031907802940
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Jun 2026 23:10:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=i68e8xKr;
 spf=pass (domain: gmail.com, ip: 209.85.214.181, mailfrom: nitin.wankhade333@gmail.com)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf332e9457so4679845ad.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Jun 2026 23:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782195031; x=1782799831; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SFzqP3JKpZ3YGeSI3O4RrOIUQeRiK4T1ZwC3HVpFzE=;
        b=i68e8xKrWbr9rdbuFUH7WnYLnQ80+E0jvhXYkcPrNiS7dAtq9b0xL70NE5nrw5jcbM
         t840IYPM586UEYNmeLjgwCfVNNxgTXq7u4zXQETv53QercNg6ohFlWHWXS2TDYY2Ufq2
         8Ki+aqv2v8S5gPso77Xp2G8eW2wO6o2ITBFhFkjnb/SXHJ44bB7+lc6/qQ3l+Bf1235t
         t7LXIEkPI4GGLMqhIrIVMcC74WelsrWiz/KmD/GZsYgL4ctObjC+lH2D6pE1x8Sy9R9e
         sidsQYa0la6UHnV6MruxeQsx0doAgYsZVKKWXh/zPJxkUNMxA0rMgJbn8mJp4WrUw9Oy
         dD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782195031; x=1782799831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2SFzqP3JKpZ3YGeSI3O4RrOIUQeRiK4T1ZwC3HVpFzE=;
        b=E1K9gWCLkdAEErVu2Dv/AcyEmTuLyAYr5lGqMFOc75P6tmMJYDk1FT87qIXvwrRsH5
         MRJkwIfSZWKA2bD364k3S7l7wkKC+RPddnYYNk0OAVWDrRzVnbjEFoix7fWBNLwu27XH
         d7gwQlqllwlhC5a2DFc4WHglcu1gyv56iCrQfg9MXOaljvxKnTARDijFMnVmadpgYs9I
         FyIsMNPzD/UjTZebinrlnT7CDdafcjWlddjBZQvXR2zwQneHfWW7++XqiqFKYMHk1XUO
         QiFvbwk2oQqmdOHERDhrEza6OebpRsXsDKjcEb+lqC0FIvOPGiipXtWseFYo2VecKW9O
         oJ1Q==
X-Gm-Message-State: AOJu0YwQ9CX+10k9O8NDncAOzwBpphyF4UJCgcSzOXo5ac/rMylbVrqY
	s73YU8k39uilrNgfvVPp2j27i2orepCNMKBLenyaWh0TnyTkiF1BKkRssP5pJeieYrw=
X-Gm-Gg: AfdE7clKEFJdm8f8LZvKJiVQlo0By15Cg6Bs48fNy7p6vzIeQHLnfGZF3kTXjGdhjHp
	q6F6oYhN2oSKwCVpR2/j5kDxFmlmPW4ET71xV27Ju8XOHs/EufPTbLZhH6jM5rAyPd/nkH3Pe6x
	gimXq514vcl+Z2/A9LxNDnIZ+/MaGBwyGCAIxoEuE7KnHlvwikEltQECcibt+Ld49z2cRd5gQZv
	7d+UxGnbwxbzRcxKM3XxYYGngyqDWhlAXha/pfWeI/TuMCBfA2zIjNaJnwiiDGZiPQAJFR7+Akm
	+T3nZPh7GSieMsOBwvbAJOGZqXhcWRQr6R2ml6zN1rM1An7Ch8mrxZ+P/SUeb1fnC5PRFgeA9eJ
	dn6mUuT+v5P8Rfkg12vo6GffYsHvN4sLTMxm1Cl43dL7sTkoxAtH8s8HGgpAEhTpBKktey92KX7
	fh4YJgOiXycviVt3f9lWoFFXI=
X-Received: by 2002:a17:902:f54e:b0:2c6:d204:10b1 with SMTP id d9443c01a7336-2c7bf228529mr17637935ad.8.1782195031170;
        Mon, 22 Jun 2026 23:10:31 -0700 (PDT)
Received: from LL-868L.kpit.com ([49.206.129.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f85f1sm99844045ad.42.2026.06.22.23.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 23:10:30 -0700 (PDT)
From: Nitin Wankhade <nitin.wankhade333@gmail.com>
X-Google-Original-From: Nitin Wankhade <nitin.wankhade@kpit.com>
To: yocto-patches@lists.yoctoproject.org
Cc: nitin.wankhade@kpit.com,
	Nitin Wankhade <nitin.wankhade333@gmail.com>
Subject: [meta-lts-collab][kirkstone][PATCH V2 5/7] strongswan: Fix CVE-2026-35332
Date: Tue, 23 Jun 2026 11:39:59 +0530
Message-Id: <20260623061001.644583-5-nitin.wankhade@kpit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623061001.644583-1-nitin.wankhade@kpit.com>
References: <20260623061001.644583-1-nitin.wankhade@kpit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 06:10:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4271

From: Nitin Wankhade <nitin.wankhade333@gmail.com>

Upstream-Status: Backport [https://snapshot.debian.org/archive/debian-security-debug/20260422T125423Z/pool/updates/main/s/strongswan/strongswan_6.0.1-6%2Bdeb13u5.debian.tar.xz]

Signed-off-by: Nitin Wankhade <nitin.wankhade333@gmail.com>
---
 .../strongswan/files/CVE-2026-35332.patch     | 51 +++++++++++++++++++
 .../strongswan/strongswan_5.9.13.bbappend     |  1 +
 2 files changed, 52 insertions(+)
 create mode 100644 meta-networking/recipes-support/strongswan/files/CVE-2026-35332.patch

diff --git a/meta-networking/recipes-support/strongswan/files/CVE-2026-35332.patch b/meta-networking/recipes-support/strongswan/files/CVE-2026-35332.patch
new file mode 100644
index 0000000..a46479f
--- /dev/null
+++ b/meta-networking/recipes-support/strongswan/files/CVE-2026-35332.patch
@@ -0,0 +1,51 @@
+From: Tobias Brunner <tobias@strongswan.org>
+Date: Fri, 20 Mar 2026 17:38:07 +0100
+Subject: tls-server: Only accept non-empty ECDH public keys with TLS < 1.3
+
+This prevents a crash due to a null-pointer dereference when processing
+an empty ECDH public key.
+
+The previous length check only applied in the `!ec` case, so in the `ec`
+case, the access to `pub.ptr[0]` was unguarded.  If a crafted TLS
+record ends with an empty ClientKeyExchange, then `read_data8` sets
+`pub` to `chunk_empty`, causing a null-pointer dereference.
+
+Note that if some data follows the empty ClientKeyExchange, this just
+causes a 1-byte out-of-bounds read that has no further effect as the
+TLS session is aborted immediately.  Either because the read value
+doesn't equal TLS_ANSI_UNCOMPRESSED or because the empty public key
+is rejected by `set_public_key()`.
+
+The referenced commit that introduced the pointer access, added the
+check for `pub.len` specifically to the `!ec` case, while the pointer
+access was initially unconditional (probably because the code was just
+copied from `tls_peer.c` which processes ECDH public keys in a separate
+function, so there was no `ec` flag).  The latter was fixed a couple of
+days later with 7b3c01845f63 ("Read the compression type byte for EC
+groups, only").  However, that commit didn't change the length check.
+Anyway, it's possible that the original intention was to add the check
+to the `ec` case on the previous line, or that there was some confusion
+with the parenthesis and something like the current code was intended to
+begin with.
+
+Fixes: e6cce7ff0d1b ("Prepend point format to ECDH public key")
+Fixes: CVE-2026-35332
+
+CVE: CVE-2026-35332
+Upstream-Status: Backport [https://snapshot.debian.org/archive/debian-security-debug/20260422T125423Z/pool/updates/main/s/strongswan/strongswan_6.0.1-6%2Bdeb13u5.debian.tar.xz]
+Patch is refreshed as per the source code version 5.9.13
+Signed-off-by: Nitin Wankhade <nitin.wankhade333@gmail.com>
+===
+diff --git a/src/libtls/tls_server.c b/src/libtls/tls_server.c
+index 7b2238e..bffc01c 100644
+--- a/src/libtls/tls_server.c
++++ b/src/libtls/tls_server.c
+@@ -857,7 +857,7 @@ static status_t process_key_exchange_dhe(private_tls_server_t *this,
+ 	group = this->dh->get_method(this->dh);
+ 	ec = key_exchange_is_ecdh(group);
+ 	if ((ec && !reader->read_data8(reader, &pub)) ||
+-		(!ec && (!reader->read_data16(reader, &pub) || pub.len == 0)))
++		(!ec && !reader->read_data16(reader, &pub)) || pub.len == 0)
+ 	{
+ 		DBG1(DBG_TLS, "received invalid Client Key Exchange");
+ 		this->alert->add(this->alert, TLS_FATAL, TLS_DECODE_ERROR);
diff --git a/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend b/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
index b5d1966..1e90b1c 100644
--- a/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
+++ b/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
@@ -4,4 +4,5 @@ SRC_URI += "\
     file://CVE-2026-35329.patch \
     file://CVE-2026-35330.patch \
     file://CVE-2026-35331.patch \
+    file://CVE-2026-35332.patch \
 "
-- 
2.34.1


