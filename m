Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBD1C5516D
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:23 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4466.1785497600916141308
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=BhWj47sX;
 spf=pass (domain: konsulko.com, ip: 209.85.219.53, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8f186025973so9486236d6.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497600; x=1786102400; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Vo1pATRuz+AvP8sRhGmFNBKWXuojRwnT1UJCSDo89QQ=;
        b=BhWj47sX0lAXb3KAXbq0SLs/G084bM0YVKZ5pau1kmex3+PMAmBBSwQtkKlE/dWNQ+
         Nc482F3QmSiomys4Ljl7d0ERZMmtQTd63/bQbrDHP3J1MVJB9e8MHVsfD2y/D63HzSOx
         gW3DNa4mB9dunqojiZNrOS/VIkIN0Rt6amsLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497600; x=1786102400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Vo1pATRuz+AvP8sRhGmFNBKWXuojRwnT1UJCSDo89QQ=;
        b=GeUmqkP9/eMe7U4RxADar+5rXFC39+joF8YyBxTeKxhrrz5DcjXRwOjlLUdZ+1iDMa
         VeRgo1xgLjj5lZ3y7W9LsHgviFHC67YA5tLxYG6aCG497iB7Xk7euR+Tk7+rgrYdvqKN
         WPnbuXu99QSWo1NCFttUl/h9rxKbCOyJ54Ak+zYB0P75DSHXb23+s9i9hP9Mwd6GPV5x
         9MI2WrxvlwuYxRbtzGye5FExKyjpgoMzvK6f/m9ISCA6h0G+fsYC4vLm+j4k65Qd05on
         0+Gf9E4qnO+btvAqQQ/jIzMesAKIiu4p3I4IfBw/egJw2+YDfsdOiI7j+co+vGsdJTxn
         r3iQ==
X-Gm-Message-State: AOJu0YxXFHuzXfzf5aqNPgOmBWCk2wcOAa75iPoEeN6DXH9jU99WdA+F
	1YeuWgEw7uOgqSkNYB9FlM/T8dDWsqYPHNxN6jmWpovufXU3WDecCtXluOhIK2HybA3rzYDt2NN
	9j9RU
X-Gm-Gg: AR+sD12rNVr7GNeukq2S3v+yKdwW9y8MdvGFH/muHN2/VsOdJZNyJDlFvh7YfieUe7I
	yyt9JRVFdlv42Eo1vnarXtebr8qFINcZPNZphIouGuzQCnr+xuS1ImgC5GXU0jWRXewGbE36v7y
	Pq2jZVC6B48ZWH5m/gxvrF2zqecn78cUUgsCjlzXKYk5u1W+YKUG92MMdnFeXYqk2dhoD0Va6xL
	ppIg6cr+LZ2PYtHTahLgnHrDnN9uM/nrKZ1zJpS6Lbo3UV3ls30iH0dCIouyU/OcNc35KlNqppr
	CdtJ4uOVFsHjah4JeyFsian7A4z+eXarysCvvFSZx9SG+buIP8mR5YLxz6olxJHQzCafnuIPCX9
	CMFB+cKQxH/ILUH+LgcDuo6+zXTLrVQXR5s3xSjvlStQDg0V4H7NA+pfG2xbLutm4g/9adHTRt0
	EB+98TCnFIaeXluY8oKTjqm0N0VShOSimZdSw531qxPi52LQPITnaVXMicME/nwKk72SZh3fpy9
	wkG1qbcpu4ctDRXqZCjOOGPiICadYRF2XY3igyIncoEbCXKvHkk+9P7+nLcUVqi7AqyzklICbJe
	qIB8t01yK5YrpQRR6cPqCfnI9Q==
X-Received: by 2002:a05:620a:2715:b0:933:a17:c0c4 with SMTP id af79cd13be357-934965b4617mr247898885a.9.1785497599691;
        Fri, 31 Jul 2026 04:33:19 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.19
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:19 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 03/35]  cargo-update-recipe-crates: Properly close target file after writing
Date: Fri, 31 Jul 2026 07:32:33 -0400
Message-ID: <f0cba7dcc24d81f9c1b3752dfd8fa5d92488c75a.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4579

From: Martin Schwan <m.schwan@phytec.de>

In do_update_crates(), properly close the target_file after writing to
it using the "with" statement.

Signed-off-by: Martin Schwan <m.schwan@phytec.de>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit c48e7308c19a7f804c2383b68e5afcd1517a7162)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/cargo-update-recipe-crates.bbclass | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/classes-recipe/cargo-update-recipe-crates.bbclass b/classes-recipe/cargo-update-recipe-crates.bbclass
index ffc658f..47e845c 100644
--- a/classes-recipe/cargo-update-recipe-crates.bbclass
+++ b/classes-recipe/cargo-update-recipe-crates.bbclass
@@ -72,7 +72,8 @@ for root, dirs, files in os.walk('${CARGO_LOCK_SRC_DIR}'):
                 crates += c
 if crates is None:
     raise ValueError("Unable to find any Cargo.lock in ${CARGO_LOCK_SRC_DIR}")
-open("${TARGET_FILE}", 'w').write(crates)
+with open("${TARGET_FILE}", 'w') as f:
+    f.write(crates)
 EOF
 
     bbnote "Successfully update crates inside '${TARGET_FILE}'"
-- 
2.55.0


