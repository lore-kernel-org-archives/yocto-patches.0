Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E503C021B2
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 12:42:41 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web11.7076.1740487360437702800
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 25 Feb 2025 04:42:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=AEF4Vcc4;
 spf=pass (domain: linaro.org, ip: 209.85.208.181, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3061513d353so58429721fa.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 25 Feb 2025 04:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740487358; x=1741092158; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyablY+F7s/8cxyCAP9KQ8BqTEp8tA5RzYP1TSDezNw=;
        b=AEF4Vcc4AdajMkVrKDVl3eLCiQxaK+TnobtANhs9oO3HCT214OBRARELWv+SKiyv4d
         s8ooRopT+D3lLW3I/NsnvZkTbD5YCFPXhlFegShiHpfoCAetSApXp4ZKQl7W1FO08Rpx
         KbRF8qIJqEzColJh93ijEXk3fNsIYc9evtpFnie6klQaRv4W9F4T7+PGaRfH/ZMdiOf/
         GbZ/T6EnBbrbQBwffg1JGaPkSaG7ut7Qmghxxb3zRRth2EGKrMnJ7fudD39qdNs0nSuv
         sRArBOsBglpZ9N5BDeMm0vdkgHJ6xZMzCQ0Qy9oqzpc3HE5YEI5uCReSAkAvB6+TqPHQ
         QVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740487358; x=1741092158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyablY+F7s/8cxyCAP9KQ8BqTEp8tA5RzYP1TSDezNw=;
        b=feJO4wexLsG6Rdq/ckJ6HZTlu4iAnBVAouOB2LTPd59CMTLuCKoidMIDJH52FHsike
         3MqQ0v0FmJaN1N+16nRBagVOsDGw4cb1JbCj4cs4H5K9u86r9yHh4TeyEe1NtmSRd/C2
         wrqKKEz8loaBW+4FZGnkpSd4qTqaqz+wfg904UnAEpvChhK6v+TGEj9AoRfBUlVjwD1L
         VZj15y+Za10PS1Ad8zyKsAeCpiGD4mN+quBW/PZ48bhaPwxFkDRmjk/VwPUaC3KDkLkQ
         DT5cwl0hOk043UQaEE6QCNiDShGC44u/AX27++tW6VdlbfPBF58k9yrodB9t1/imHa0g
         Dr1Q==
X-Gm-Message-State: AOJu0YwYCHP6YLxzQHJGLTwpkZ1ouRLnF0q52+VrTvDL7LRH7IxYXhcw
	adELByg3VMjJy/cOb+7186ata05iDUQKRZ1iJGf0kAKGlQY3bQkc3XSyqJoG8NqVzJ6Xg8CDmyM
	s
X-Gm-Gg: ASbGncsx9AXvHKYgMmBdtwHaDcZTKWunstK8ghoqKWvKrKWHpRUn7SmewsdWBVqfJE/
	nFbY93VstIrpwF3trwHXeTz0w/XAt72YO8GED0sraIQSXke58aIJqfNreOUT0Ht1B8EHbod4Zf+
	a6njOnak16CuG3EbstsXESaoqWcxaFFHo/eb5Hr8w1FIDNz7zpSCNtfeV7TwNXpgb4fl5uwcVp+
	58f46NK+LLSt8fLyOH770bFhG4963o5dlprhEAMUlNta6a/FR8huRH05wi/wPRNkewL/IN5qo9M
	zQO/TlG6MgNY+xQXbGd4U5UTFQ70mNUyLyx1KwkOchc0fid932AzhxIXFX2krYuxMVUvz5k=
X-Google-Smtp-Source: AGHT+IGu/qmbSjfHxRRY78fyJzAcC3de4u4UdfoNEeekfR7belpK84V6gaIl5Z7Y869lZir718f0Pw==
X-Received: by 2002:a2e:81d1:0:b0:309:2267:32c2 with SMTP id 38308e7fff4ca-30a5b21d59dmr70770871fa.34.1740487358098;
        Tue, 25 Feb 2025 04:42:38 -0800 (PST)
Received: from localhost.localdomain (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819ebdf6sm2149711fa.35.2025.02.25.04.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 04:42:36 -0800 (PST)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [yocto-autobuilder-helper][PATCH] config.json: add ssh server to meta-arm builds
Date: Tue, 25 Feb 2025 14:42:16 +0200
Message-ID: <20250225124216.2352401-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <182772F952E9D685.15758@lists.openembedded.org>
References: <182772F952E9D685.15758@lists.openembedded.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 25 Feb 2025 12:42:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1130

testimage tests fail without ssh server on target:

https://autobuilder.yoctoproject.org/valkyrie/api/v2/logs/1586278/raw_inline

There may be additional failures once ssh communication works
and tests start checking things on qemu target.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 config.json | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.json b/config.json
index f2f4be5..f3e8797 100644
--- a/config.json
+++ b/config.json
@@ -667,6 +667,7 @@
                 "MACHINE": "sbsa-ref",
                 "extravars" : [
                     "IMAGE_INSTALL:append = ' ssh-pregen-hostkeys'",
+                    "IMAGE_FEATURES += "ssh-server-dropbear",
                     "TEST_RUNQEMUPARAMS += 'slirp'"
                 ],
                 "BBTARGETS" : "core-image-minimal core-image-sato core-image-weston",
@@ -678,6 +679,7 @@
                 "MACHINE": "sbsa-ref",
                 "extravars" : [
                     "IMAGE_INSTALL:append = ' ssh-pregen-hostkeys'",
+                    "IMAGE_FEATURES += "ssh-server-dropbear",
                     "TEST_RUNQEMUPARAMS += 'slirp'"
                 ],
                 "BBTARGETS" : "core-image-minimal core-image-sato core-image-weston",
-- 
2.43.0


