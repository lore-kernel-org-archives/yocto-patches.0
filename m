Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91828D46631
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 22:46:58 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.691.1768517215697060685
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 14:46:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=A6NAV1LH;
 spf=pass (domain: konsulko.com, ip: 209.85.222.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c52c67f64cso157666485a.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 14:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768517214; x=1769122014; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KozeKux5Q+OSvFJ8f0a3DWSynxBoZ3n6AU5Zw54i9Bo=;
        b=A6NAV1LHj/MAHqvk/W9G5tW7Lzjd2LqCExDtuP3azB1/FTpf58d7OzYzKNBr5+gBKZ
         baRXH6B6264ktrcrhhH5aEqELnhXiew6kr4aKI9qIf/+iyMcgf4qAuliK00zbGmq+SdL
         UUJoDIUYoP/LUMw84HmWQP9NvjFqJe+uZaOt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768517214; x=1769122014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KozeKux5Q+OSvFJ8f0a3DWSynxBoZ3n6AU5Zw54i9Bo=;
        b=FOa5xR4sfcZ0U3qznQRBdVo5PLOvWKJbRFY2VFtiPtBJJg2GFADDV7oM7V+W8hJaks
         shjWu7Pf/Q7dXEAajiZ/PpzGSkjIaXAiagxE473Z60Brg0f8YNmt4NMg2FB6+i7vjhhe
         RAfE5EHRBrj9Fp6ucQ2QJ016mlh2vNTivTidBy3UGUdEuTAc1y5Tghap84Qlmon5yK+U
         RC4FoAWxushjRtnW5zEOWodNZbS0OnEYs2cfiB44ceHp/8oHA9M+qon5q386qFv0IfnL
         Aplq47TBy9GGXpPnFbbKZt8nSqvDxmaWtZVq9leIa02NhOSs+Ilaj8lSuZKmoQU5qVLJ
         JeYQ==
X-Gm-Message-State: AOJu0Yw7tuE3hvylw6eJcXNL2kI60MNGN/Ql2CycQc88b5hV5H/YSzH/
	hmzWXMlfHzXdx49IRASqVEPzW8mBORUlqFeMONVh4gkfr4HRteZU/8gGXnAZXORayyBBRsCqtm8
	epXut
X-Gm-Gg: AY/fxX4s/SgDc8eT1NZJmnXp9QtavGtUuophPeSVhqkOVBuSKoYo9OHll9G6aAaUW5h
	0P4t5YSLXayJmIHIdNUOjMYC2i1j/F7KebapUrXaMnmTBzmP88wQ+JuNf1duO2IxnVIRB2DedXq
	3synYaZpp1wiq4FJFX5dQLVlKV4HyUBeyRRVJ/qnT2FqqQepDXyPZx7AfEh5ygXMPFEiv3wcJN8
	COptPKPOyNvfbWRfhg6SWKDWOdWJmO1a9OPS+GuQ6SrezFs8lhiCOCpUZUYqVQcl4ckWZ5Elyge
	htvXEejduAnQ/H47ZNFg0LGhkfgzOc2c41XK9zDxh4vb/bjd8U/UaA66BO6Zi5FudRxGEvdNhZH
	M+BbB7y6hxCXqRsl3KNgq4D6GFUkSVYEj/CMdhjrymO6omtg9khoT+YPlu3avSyOoXdAf1BCfnF
	xMFegzSNmoVhfD6MVwVxG6C5zN7wAXrU1coixnc3f+9F02PaCC1SsWExVvYIEBR7PUF0QF78dLV
	InUJ+vfyYvphnL+W7lAgMwAVj5033WpbknFWTJ07Z4i+NPIlmI/sBkRXJu/FZM=
X-Received: by 2002:a05:620a:710a:b0:8b2:d56a:f2f1 with SMTP id af79cd13be357-8c6a66d6d75mr159356485a.12.1768517214412;
        Thu, 15 Jan 2026 14:46:54 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6040casm7921436d6.21.2026.01.15.14.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:46:54 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][kirkstone][PATCH 4/9] chkrootkit: update SRC_URI
Date: Thu, 15 Jan 2026 17:46:25 -0500
Message-ID: <4ea1bb4f16fb8c89a21e936a27900d119bfa4805.1768515491.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768515491.git.scott.murray@konsulko.com>
References: <cover.1768515491.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 22:46:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2969

From: Armin Kuster <akuster808@gmail.com>

0.55 no longer hosted from main source. Use Ubuntu archive

Signed-off-by: Armin Kuster <akuster808@gmail.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-scanners/rootkits/chkrootkit_0.55.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-scanners/rootkits/chkrootkit_0.55.bb b/recipes-scanners/rootkits/chkrootkit_0.55.bb
index 20015a1..4293aec 100644
--- a/recipes-scanners/rootkits/chkrootkit_0.55.bb
+++ b/recipes-scanners/rootkits/chkrootkit_0.55.bb
@@ -5,7 +5,7 @@ SECTION = "security"
 LICENSE = "BSD-2-Clause"
 LIC_FILES_CHKSUM = "file://COPYRIGHT;md5=fdbe53788f7081c63387d8087273f5ff"
 
-SRC_URI = "ftp://ftp.pangeia.com.br/pub/seg/pac/${BPN}.tar.gz"
+SRC_URI = "http://archive.ubuntu.com/ubuntu/pool/universe/c/${BPN}/${BPN}_${PV}.orig.tar.gz"
 SRC_URI[sha256sum] = "a81c0286ec449313f953701202a00e81b204fc2cf43e278585a11c12a5e0258b"
 
 inherit autotools-brokensep
-- 
2.51.0


