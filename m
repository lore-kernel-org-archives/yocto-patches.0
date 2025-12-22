Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4C7E677F4
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 16:52:23 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.83949.1766422342448516943
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Dec 2025 08:52:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=F/7mGTCs;
 spf=pass (domain: konsulko.com, ip: 209.85.219.41, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8887ac841e2so35879366d6.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 08:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1766422341; x=1767027141; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOZ5v6hZ/ZfNQgDsLwMIByqil5plDShg4u5BM4YWm8w=;
        b=F/7mGTCsUPvgEAB8t0VZ+QcChaZIIdbjoBOhvZytkum/RscAgqUvEKqCH7o2ouctOw
         johAGmcDfFlqehmAauwByxNT+pzORliZVFxobpJ1fJygMbVWmZ1ahtpCsDcupXEONOL6
         9ZEL+UZ75+bJtcMwGGwX/j2Obpsl+6Olo6im0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766422341; x=1767027141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aOZ5v6hZ/ZfNQgDsLwMIByqil5plDShg4u5BM4YWm8w=;
        b=LJ+MLm718TEs0fY8tGg7WJjnERJT8q/NvBMRHaa94wKrBm96vxKouYdEiOPXcsqxB7
         XmAi/1iJ6HkBfkWxHJmKlM87iz80MEfIsQqFBZylLe0Lbf9gdGIa96Vs7plGhyfIU9zB
         VGtYJjKXtcL4KkSbFoMRO0VfhPnET9mqN4cObMIEy+UujokxrcLlRykNpOAJvgr82nub
         v8V46biL61oYmnaUAjdB0w50vlD9eJlFc8N174JGZLC2EJ8e9m9VS6lUmYV1HMtYXo6/
         jaIlSxkXzK29JMq9KyrgBDVMVzBshqndLM5soCkA2s1RKzpPe7e+OoG1fY7Q17iMzziY
         qCbA==
X-Gm-Message-State: AOJu0Yzbkdm1M4J5QEs7xiY67iOh4tR0egaGjkx8ey/4TdGqltKJTjPk
	BhgjsVhLYBR9bFQoTTMLM1hJgpS6SILVed93QwqzmNhbYf+r/lNVa4R7J/SvXcQmZyQ6wFmlot7
	57YIg
X-Gm-Gg: AY/fxX6TgqcWxos8r9Z1M1EZFi6FSk/eKZii0wBCp06AcpnX8LgGGGRc0VB+zNIUFWK
	U2XfJWg70ZKdLKcHCnm0XiShu5pB1e1QCUVM8XMTVUTXI77OEooUERsht1dVgL5XCZBETzf/c4Z
	4YktiBDpqj7Mb75u7C/jg+chs20WFQWQE2y8qc8dfwcvOmx8p3aagvQYKL+myIatYB1STPdOtab
	59TFnEC8TcI+5ZYW/541Swufj/BFXRl4Hsq0qKUfjGN16/IzhxwfFDdpd5eZ4jCT+y+Vki7j2d1
	rhNAMdUs/xYRKSndeJ123u7y9UbepwiryLjRzOflA7u4S5DkGDvnfZouVpCTu3ymT6ifNgn2GsJ
	Mun3Pbm/mhGMiTCqAUWcVZA5sl58M1Z4RsdYx+1iBV/9H7KkKClwYxPzUmxBZrPfCJJL2eoUYiE
	GfjVFbXpfez1V1+bAwFeKGn47Wt7w96/pIBSgyUHb4LAifjNfyc5ubegKL+W0apmQ8kAczgurLk
	7nFT3yotLzerQqProbWnNjzsAVD61uR68TlW4Zl+qlII/SWawL4
X-Google-Smtp-Source: AGHT+IFiBK5JNitLpcMUwjrFUbLPEh1LTIpFJhEg+wR2E7FvXJMFeZdLf67AbWqdpulL7iUhKvj8Pg==
X-Received: by 2002:ad4:5c63:0:b0:882:5291:23d0 with SMTP id 6a1803df08f44-88d85ca9307mr188283246d6.20.1766422341126;
        Mon, 22 Dec 2025 08:52:21 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9623fdfdsm87149726d6.5.2025.12.22.08.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 08:52:20 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][PATCH 3/8] libmhash: add UPSTREAM_CHECK_URI
Date: Mon, 22 Dec 2025 11:51:51 -0500
Message-ID: <2ac6e7ccac51356146aae73e7cd1b9da9c1b2321.1766420960.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1766420960.git.scott.murray@konsulko.com>
References: <cover.1766420960.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 16:52:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2853

From: Yi Zhao <yi.zhao@eng.windriver.com>

Add UPSTREAM_CHECK_URI to check the correct latest stable verison.

Before the patch:
$ devtool latest-version libmash
INFO: Current version: 0.9.9.9
INFO: Latest version:

After the patch:
$ devtool latest-version libmash
INFO: Current version: 0.9.9.9
INFO: Latest version: 0.9.9.9

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-security/libmhash/libmhash_0.9.9.9.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-security/libmhash/libmhash_0.9.9.9.bb b/recipes-security/libmhash/libmhash_0.9.9.9.bb
index 805cf05..7c7fb11 100644
--- a/recipes-security/libmhash/libmhash_0.9.9.9.bb
+++ b/recipes-security/libmhash/libmhash_0.9.9.9.bb
@@ -23,6 +23,8 @@ SRC_URI = "${SOURCEFORGE_MIRROR}/mhash/mhash-${PV}.tar.bz2 \
 SRC_URI[md5sum] = "f91c74f9ccab2b574a98be5bc31eb280"
 SRC_URI[sha256sum] = "56521c52a9033779154432d0ae47ad7198914785265e1f570cee21ab248dfef0"
 
+UPSTREAM_CHECK_URI = "https://sourceforge.net/projects/mhash/files/"
+
 inherit autotools-brokensep ptest multilib_header
 
 CFLAGS += "-std=gnu17"
-- 
2.51.0


