Return-Path: <jackson.james9803@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450C4CD6E4A
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 08:05:26 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6321.1780560323865218905
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Jun 2026 01:05:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=aX4I5Hu3;
 spf=pass (domain: gmail.com, ip: 209.85.210.169, mailfrom: jackson.james9803@gmail.com)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-842264dde84so808215b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jun 2026 01:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780560323; x=1781165123; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZugkIBxAOKcQiFHJ5MMbRTqB9cyIjBh64IDSsZ8yr/A=;
        b=aX4I5Hu3TBP4KHzwa6iqGxXpOHUMumM2Ax5UsG7HIcTCXHYyPJ4wfsYYHXayPlyLI3
         H9LCnFfrRhAvegtACBdAPBULokYzayzlYBOkE/YfWy43aW0IrQWHPgIg9uhd15TDq1OV
         UKiYqgZaB3OUH+mXkpykYo3x391nANHDKzj4R6r6e0GL721uxF6ikzyodmYjSsG2YGuy
         HKtsEB0X69QRTsBgNiiqva0nkXcvs691QrtaFEE+tXadDCcAPts1OkFzXC2RZHJy3/7/
         uVecP02rMpU5xsq/Gf5WQn7T/twTQbMqGjJn90SNqMfVqIIbSoBRWoAWQA4aDeN4TAvy
         0Iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780560323; x=1781165123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZugkIBxAOKcQiFHJ5MMbRTqB9cyIjBh64IDSsZ8yr/A=;
        b=RKQr7MEYvOcEFcE73RyaefoU0f5KZt/DQlM3s12dfuxdg8U889rvc4kFZeThjYb4Fa
         sYJfmpyTZMEy070zIhqcKScjPhxAVZPf/BqF9+OkYUJZ43R3rNv0/TXblqTgN6r8I/yU
         ttAHqggr/C3WTLs16D5RT01RfAAN37voDQXJ1x7MlXyezxPcgDBs1fXM76e5EYZgCWl6
         2L/PDywFUq7HcWuT6m+xNlulku9YtGygTZj450v6w4ESCYdMTyNBJQN2aBhyC5YCth41
         dny9Jp2gmksjsk6IKjmcltGTiWzZOfdbl6iv0QzVSrGnOC9mqg8qH6++P60XnTQrQaJx
         R0Cg==
X-Gm-Message-State: AOJu0Yzy3KDJFiJoVljRD6hnpnMBtfOOhS6iRTxZtQ9BS6MVCr3uW9ai
	eN7XMaRyL+jNwDISbibjQEA5xYTLWG4NbEBiKGmzFTGPrc5t3Cse4yxYavxlcA==
X-Gm-Gg: Acq92OGn/YRdwr5S8yDJfOzxxB1b3y2ORr212Hpj3rBghXz2mfowjQHCS6GjEiPbuAf
	f5pZiKnYVfHpyz74dVSq9RsZ0TU62LhYbwrJG8/JI+nOvZCHdmRdDIq5+RW4PXbLx1zMprnfQRo
	/t0CbvntKmxqABmKJkZmfD0WAFt9nAGQwvyI5zMQoP/0wrJhF3R+wx/P2uzRrQvzHo2ICU8lp02
	4hAqzhhh0o2TM9ZySa8X/9B0CV/jnqZZKj7VvUj9xfy1IecQJLgJ9qWM+/p26WGbPhUimMfuqH7
	TL4gxS6FO7qPIQ3oHI14VSUyy6YVOMa6AmxfvoB8vw9f5k6tSlWHAp4ZpoLg9EzB7f1OmygCS7/
	+G4Fvu8vd09UTVnXbsaR7zJEA01QcbzFyegJU0+XUyMsYfQXwYpc03Km9MpJAt12fEqFuEeBEEv
	MA5CYJrb5GTO1VhEAXz3EFEJ4pmEvscMSAWMfQ5Vx1JMf52A==
X-Received: by 2002:a05:6a00:448d:b0:842:4a8e:2698 with SMTP id d2e1a72fcca58-8429b5c1480mr2285264b3a.9.1780560323146;
        Thu, 04 Jun 2026 01:05:23 -0700 (PDT)
Received: from LL-868L.kpit.com ([103.155.222.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e21c8sm6139001b3a.49.2026.06.04.01.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 01:05:22 -0700 (PDT)
From: Nitin Wankhade <jackson.james9803@gmail.com>
X-Google-Original-From: Nitin Wankhade <nitin.wankhade@kpit.com>
To: yocto-patches@lists.yoctoproject.org
Cc: nitin.wankhade@kpit.com,
	Nitin Wankhade <nitin.wankhade333@gmail.com>
Subject: [meta-lts-collab][kirkstone][PATCH 1/7] strongswan: Fix CVE-2026-35328
Date: Thu,  4 Jun 2026 13:35:00 +0530
Message-Id: <20260604080506.274123-1-nitin.wankhade@kpit.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jun 2026 08:05:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4132

From: Nitin Wankhade <nitin.wankhade333@gmail.com>

Upstream-Status: Backport [https://snapshot.debian.org/archive/debian-security-debug/20260422T125423Z/pool/updates/main/s/strongswan/strongswan_6.0.1-6%2Bdeb13u5.debian.tar.xz]

Signed-off-by: Nitin Wankhade <nitin.wankhade333@gmail.com>
---
 ...nt-infinite-loop-if-supported-versio.patch | 42 +++++++++++++++++++
 .../strongswan/strongswan_5.9.13.bbappend     |  3 ++
 2 files changed, 45 insertions(+)
 create mode 100644 meta-networking/recipes-support/strongswan/files/tls-server-Prevent-infinite-loop-if-supported-versio.patch
 create mode 100644 meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend

diff --git a/meta-networking/recipes-support/strongswan/files/tls-server-Prevent-infinite-loop-if-supported-versio.patch b/meta-networking/recipes-support/strongswan/files/tls-server-Prevent-infinite-loop-if-supported-versio.patch
new file mode 100644
index 0000000..32a23b3
--- /dev/null
+++ b/meta-networking/recipes-support/strongswan/files/tls-server-Prevent-infinite-loop-if-supported-versio.patch
@@ -0,0 +1,42 @@
+From: Tobias Brunner <tobias@strongswan.org>
+Date: Wed, 25 Mar 2026 10:17:46 +0100
+Subject: tls-server: Prevent infinite loop if supported versions are too
+ short
+
+If the extension doesn't contain a multiple of two bytes, the previous
+code would get stuck in an infinite loop as `remaining()` continued to
+return TRUE while `read_uint16()` failed to parse a value. Initiating
+several connections with such an extension allows a DoS attack as no
+threads would eventually be available to handle packets/events.
+
+Fixes: 7fbe2e27ecf6 ("tls-server: TLS 1.3 support for TLS server implementation")
+Fixes: CVE-2026-35328
+
+CVE: CVE-2026-35328
+Upstream-Status: Backport [https://snapshot.debian.org/archive/debian-security-debug/20260422T125423Z/pool/updates/main/s/strongswan/strongswan_6.0.1-6%2Bdeb13u5.debian.tar.xz]
+Signed-off-by: Nitin Wankhade <nitin.wankhade333@gmail.com>
+===
+diff --git a/src/libtls/tls_server.c b/src/libtls/tls_server.c
+index 3ad9fd2..7b2238e 100644
+--- a/src/libtls/tls_server.c
++++ b/src/libtls/tls_server.c
+@@ -471,15 +471,12 @@ static status_t process_client_hello(private_tls_server_t *this,
+ 		bio_reader_t *client_versions;
+ 
+ 		client_versions = bio_reader_create(versions);
+-		while (client_versions->remaining(client_versions))
++		while (client_versions->read_uint16(client_versions, &version))
+ 		{
+-			if (client_versions->read_uint16(client_versions, &version))
++			if (this->tls->set_version(this->tls, version, version))
+ 			{
+-				if (this->tls->set_version(this->tls, version, version))
+-				{
+-					this->client_version = version;
+-					break;
+-				}
++				this->client_version = version;
++				break;
+ 			}
+ 		}
+ 		client_versions->destroy(client_versions);
diff --git a/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend b/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
new file mode 100644
index 0000000..c47ca7e
--- /dev/null
+++ b/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
@@ -0,0 +1,3 @@
+SRC_URI += "\
+    file://tls-server-Prevent-infinite-loop-if-supported-versio.patch \
+"
-- 
2.34.1


