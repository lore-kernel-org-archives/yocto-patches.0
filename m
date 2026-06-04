Return-Path: <jackson.james9803@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B24BCD6E4A
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 08:05:46 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6282.1780560344378882384
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Jun 2026 01:05:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=pSGuubvh;
 spf=pass (domain: gmail.com, ip: 209.85.210.169, mailfrom: jackson.james9803@gmail.com)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8423f236418so214115b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jun 2026 01:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780560344; x=1781165144; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfMu4H33QnILISSD/eLvSkp1gh4+OD2oEdIT8f6p8m8=;
        b=pSGuubvh8HV7C/95o5bl79m9NlZmkXJK/AOwewyZWu4zrg1WGRFSu+V5ewqqqLWGV4
         D52JOynImpqL3sp9oIrQYQAJovckyUbYCjFcQ7TD1+UE6C2/ouSpigN8+3FjDLGB0/eP
         //RTWco1Zk/ST3thzOMijsREaJFSu1cmpsWWbb6RYHVaDva28UbvByLsrkM+oM8Xzsrh
         Fl/DZnl2E5fsAUzGBdHoGEiKKl9fEDuWcKPr9Scu/kJkA7nefBwARdPlImz9IzLRE2TS
         fe6/KBoU4uAGEGwkVKWxG09eMcCNL0Hisi4IsC8BRSMlTQVcZJ3TAiq6UiAaUgxRqsFT
         30Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780560344; x=1781165144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tfMu4H33QnILISSD/eLvSkp1gh4+OD2oEdIT8f6p8m8=;
        b=LMTfocsfkzCXYyIqlbT7k3Jv7MKR4hpAzYJarfCvDe4YlNmPI0h4YuLlWSqRXISLrM
         zQ2danWiSt989eYtyxrUjauGwrwGH/AjS19UgTyKpzQ1dR0FhZ07cnD3i3CO4JgAB3nO
         gIWi4MpDXEIgYAzfnICoNRWn2zxWzVKbYXK8fqfKNyzeL6UtwWjrov5owx2KSt8rCOWM
         BuIZ4c7hor+Sjjg4PcL5Za8Sx4zEGrWrF+30eJ5t++sALLgeNOZqz8LJTndwM3YtGC8N
         IgX/jLC/6YcoqqkX4KxiAJmX2BX5uc7KDce1YxlI6Vv/I0uEyRm6R6yCYoV5l1fmpARd
         roCw==
X-Gm-Message-State: AOJu0YyE/NfGz6lN0DwFcmLE9pGm2gQZyxUckhE5zNH9EgKFNyAPWDdo
	CWI4/C+hJTxQUOXbKHoAo5aSBa/x9OW4xkUPgyFK+xcoTW9+Tsouw4cpoAhTdw==
X-Gm-Gg: Acq92OFr29y7eSkj5V4UxF0FcGx1YM6vEXzYkotoeIPYdE8CGl+F70rvUun3ok3G6u6
	WXxaAG5ELc1HHbOskXdH9KQ+BhlxqghqatUqJlkHj1jU1vhZ3gCLFb4THSZIswzTdrt0A6fACFa
	91XuT1HNySuVyd4F61HXW0uokWw88H9swHpof/snHZ67uOKIT1OtKUbA8LkZw2Va3KdHLGxKrIu
	1RhFy0Dnv817r4fAdCE9wzx//uX7NmBd1N6Nit73r90otsR0MZM/rfotA0YpXslMnBubKqOr6an
	UB0CPGlweTwXpiU7Q+e/0JzUWQT6a63pVeTuoh9d5oQxoN/j2+JCb+G0CcFu1N8fCNf8rAJW7kL
	pZR3ZhP3FShGY7UfElsmaX29BHKLcs69C5HzlHo/qFJuJA1MpW+ev2AEd/6gipmhGvcAy1xTYCh
	H61MoPtJ11dER8rSlcFUqYo0W2fTPXMJkfCRZ4b6M71TxYiw==
X-Received: by 2002:a05:6a00:94d5:b0:842:5a8d:302c with SMTP id d2e1a72fcca58-84284fd2f60mr6974682b3a.38.1780560343703;
        Thu, 04 Jun 2026 01:05:43 -0700 (PDT)
Received: from LL-868L.kpit.com ([103.155.222.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e21c8sm6139001b3a.49.2026.06.04.01.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 01:05:43 -0700 (PDT)
From: Nitin Wankhade <jackson.james9803@gmail.com>
X-Google-Original-From: Nitin Wankhade <nitin.wankhade@kpit.com>
To: yocto-patches@lists.yoctoproject.org
Cc: nitin.wankhade@kpit.com,
	Nitin Wankhade <nitin.wankhade333@gmail.com>
Subject: [meta-lts-collab][kirkstone][PATCH 5/7] strongswan: Fix CVE-2026-35332
Date: Thu,  4 Jun 2026 13:35:04 +0530
Message-Id: <20260604080506.274123-5-nitin.wankhade@kpit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604080506.274123-1-nitin.wankhade@kpit.com>
References: <20260604080506.274123-1-nitin.wankhade@kpit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jun 2026 08:05:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4136

From: Nitin Wankhade <nitin.wankhade333@gmail.com>

Upstream-Status: Backport [https://snapshot.debian.org/archive/debian-security-debug/20260422T125423Z/pool/updates/main/s/strongswan/strongswan_6.0.1-6%2Bdeb13u5.debian.tar.xz]

Signed-off-by: Nitin Wankhade <nitin.wankhade333@gmail.com>
---
 ...accept-non-empty-ECDH-public-keys-wi.patch | 51 +++++++++++++++++++
 .../strongswan/strongswan_5.9.13.bbappend     |  1 +
 2 files changed, 52 insertions(+)
 create mode 100644 meta-networking/recipes-support/strongswan/files/tls-server-Only-accept-non-empty-ECDH-public-keys-wi.patch

diff --git a/meta-networking/recipes-support/strongswan/files/tls-server-Only-accept-non-empty-ECDH-public-keys-wi.patch b/meta-networking/recipes-support/strongswan/files/tls-server-Only-accept-non-empty-ECDH-public-keys-wi.patch
new file mode 100644
index 0000000..a46479f
--- /dev/null
+++ b/meta-networking/recipes-support/strongswan/files/tls-server-Only-accept-non-empty-ECDH-public-keys-wi.patch
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
index 5b30348..8ccb230 100644
--- a/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
+++ b/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
@@ -3,4 +3,5 @@ SRC_URI += "\
     file://pkcs5-pkcs7-Avoid-NULL-pointer-dereference-when-veri.patch \
     file://libsimaka-Reject-zero-length-EAP-SIM-AKA-attributes.patch \
     file://constraints-Case-insensitive-matching-and-reject-exc.patch \
+    file://tls-server-Only-accept-non-empty-ECDH-public-keys-wi.patch \
 "
-- 
2.34.1


