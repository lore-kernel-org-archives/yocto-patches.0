Return-Path: <nitin.wankhade333@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257B4CD98F0
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 06:10:17 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14775.1782195012191959732
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Jun 2026 23:10:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Q9kiSvgJ;
 spf=pass (domain: gmail.com, ip: 209.85.216.47, mailfrom: nitin.wankhade333@gmail.com)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-37c5a6be9c9so849737a91.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Jun 2026 23:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782195011; x=1782799811; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QbBr3lFKfZg5PTJw9FuamsSxSbCi6pXXttxlyM2Atcg=;
        b=Q9kiSvgJELocUx6nWkUHvs3/YnDZ6/CPGv/8iJDzJwLgWu/62pYFQbl+PP2aPuOmxc
         Ir58IvD/sNml+HTNMaKUacN6z10pCnx0QZzWLUWiQ+Md1w8AIHPkcXFCh8x1GNgT2Efk
         6sYAW+3FmDzLyeg/dscBiPEkvnaZg7pfVt9bAqWt7Clfz7R9bfwew9eZNmqjT1CnEWeq
         7jLvd3qlqPIcBQ8jNo1t0RkyGFWyzScp4bkIPswdGxVnKoZzeSw2SP30li46BXq8VjZy
         N8HE57tCCoVz41DzECTKjWVI/tOJwPNw8QC6z2m4uW2FFxaDnNYjZVzJzGLuzVdLYgPq
         HYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782195011; x=1782799811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbBr3lFKfZg5PTJw9FuamsSxSbCi6pXXttxlyM2Atcg=;
        b=P2NJtQ0nphZF274z8udqRpKNs6NCM/6VEyDAXFcblsalqdEXg7Jsx6O0CtcLs6BHCQ
         p/wFS06MwgaWcmEfCWRC7i6khDxfEbAdY2bsR4b1Q3X/cH/AKKX8kPOvp4BHeQkWs3u9
         919h1GdL+cbBfFGZ8vkbRorVyWtYxSARxVsTkF0bUq3IcEDnAjQvE1weWxY+cLq+nrWt
         x2X64idb57CLyljyh6Tjy48o5391dWkrAvzv+xbp9hz5po7uVKP4gxDdrzvwQnvFlaCH
         b4kjrvBzf5fmfdA7aHyq0Bf7EOdcWQeoiy8Xuk2ErMTSFbkFFYMPZ0T8qsyDmU+ADfsC
         fPQQ==
X-Gm-Message-State: AOJu0YzcclvmuhDHnb4tvezfqKB4TyDEWLdLB4jkrymqx9tUTioHAGew
	QgN37TTvbNVuC0H2VDGFikSScHE3qxAmTwx6/peCr1KSn/U3u2rmGvrcoJz9BA==
X-Gm-Gg: AfdE7cnC9Ad3KuxuBZsnjrlHANGNXLyfjgjCulX5uEuEjjYd1DJdAZss118GBHNckML
	+0oOndEZb6Pi+8/3oNZPFYgKsQ2JiySoi1u408EJaKz7J17MEV8dr1qhRgJTMF9GxydH62BsO9R
	rabKhZR8VorWRZ71rrSF03MX42QNKA4lf4JpgxZfqE93wYYpzBSY7yKgHpWe/A8IDw9cZwPt2mN
	BbEZOr8cUAWgVQBwc7ncDd4xJjVp8+3H+O9OO1rYIWu5ThDmUm6Tt1wjyTXE9uoz4uik7YFPzA7
	TZpHXZU+xPInlq/wU0OjNYpyrOyOlyECsn35XkyJhhdG2Yn/OrMIrcfPoIOY6fFltvLGuJY0KZX
	I6uUI+bibwCkZTZhVMH17CohQMctSBAhPUN+gWbcbphtIQUsDzplTEm6sUUY3hKfzpRU+S2K1We
	4bY/vFFgx86izaUVZMvLgyGdg=
X-Received: by 2002:a17:903:2f0b:b0:2c4:397:dd9a with SMTP id d9443c01a7336-2c7bf1b3aacmr16186745ad.4.1782195011450;
        Mon, 22 Jun 2026 23:10:11 -0700 (PDT)
Received: from LL-868L.kpit.com ([49.206.129.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f85f1sm99844045ad.42.2026.06.22.23.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 23:10:10 -0700 (PDT)
From: Nitin Wankhade <nitin.wankhade333@gmail.com>
X-Google-Original-From: Nitin Wankhade <nitin.wankhade@kpit.com>
To: yocto-patches@lists.yoctoproject.org
Cc: nitin.wankhade@kpit.com,
	Nitin Wankhade <nitin.wankhade333@gmail.com>
Subject: [meta-lts-collab][kirkstone][PATCH V2 1/7] strongswan: Fix CVE-2026-35328
Date: Tue, 23 Jun 2026 11:39:55 +0530
Message-Id: <20260623061001.644583-1-nitin.wankhade@kpit.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 06:10:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4267

From: Nitin Wankhade <nitin.wankhade333@gmail.com>

Upstream-Status: Backport [https://snapshot.debian.org/archive/debian-security-debug/20260422T125423Z/pool/updates/main/s/strongswan/strongswan_6.0.1-6%2Bdeb13u5.debian.tar.xz]

Signed-off-by: Nitin Wankhade <nitin.wankhade333@gmail.com>
---
 .../strongswan/files/CVE-2026-35328.patch     | 42 +++++++++++++++++++
 .../strongswan/strongswan_5.9.13.bbappend     |  4 ++
 2 files changed, 46 insertions(+)
 create mode 100644 meta-networking/recipes-support/strongswan/files/CVE-2026-35328.patch
 create mode 100644 meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend

diff --git a/meta-networking/recipes-support/strongswan/files/CVE-2026-35328.patch b/meta-networking/recipes-support/strongswan/files/CVE-2026-35328.patch
new file mode 100644
index 0000000..32a23b3
--- /dev/null
+++ b/meta-networking/recipes-support/strongswan/files/CVE-2026-35328.patch
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
index 0000000..9d48481
--- /dev/null
+++ b/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
@@ -0,0 +1,4 @@
+FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
+SRC_URI += "\
+    file://CVE-2026-35328.patch \
+"
-- 
2.34.1


