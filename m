Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12187CFD31E
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:23 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4858.1763941521505632063
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=V+KciGB7;
 spf=pass (domain: konsulko.com, ip: 209.85.222.171, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b2dcdde65bso560141485a.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941520; x=1764546320; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dk0sqIDojMb2T9OfmW4/C/2COwUIzFghRpNrzozFCU4=;
        b=V+KciGB7q21MDt6SE7gBtPjfBX+qdV1E1pLkLJoM1MAoMxfGtRGbQ39kj6RfhVAIEv
         uMYOFLCQ5/eg4sCNxgnwki7eqzJqmqbxxiJC/n80qf17WZ0XOssuUX2HkVQAW39wRmoc
         lRMhA/uuXgYsYmEZ1esPtbuU7AcKQXBihFmsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941520; x=1764546320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dk0sqIDojMb2T9OfmW4/C/2COwUIzFghRpNrzozFCU4=;
        b=nhUU47TjZ0W32FRKKOdji6XcfxJobvvA7IFJWWLYrDlqLmKdMD6BjL3+O2j0i5rZ+S
         cQQAtVySFiD7ALuywtTztgXol7mwxjmjs5HrPHOIaHVINCzRqu90msS33BQNEOhym6EX
         KZSivyynhbOmQcxjr28no3tIzMBZa9aXFpgaaUmOA2ZzlU6rifFKng/eXlDIMOcc1C7T
         fU50ePCmqcONltlw2njOqIiNqsQWtbvL6oLAMbtw1UsBi5YhKpYlxf0/LHVGxTO9+Nk9
         qS6aj6QEO4y3xyVB2yk8hre1ZMpdFVsQxuNXdDgqzaNRRW/9szgqPfin8Adi62XNfQZB
         yMMA==
X-Gm-Message-State: AOJu0YyhjcgbDDAxdzypfY8Z1nHXc0qWys90VNhQMr1uOCx/oQQhG84p
	BZ1Lzmvrj9jWn1dYTWwwtuxCpIYGR5poauAeTxBirHXUBA3uSAiclqyalXi0MJNtuk5j2u5iUrc
	EgXNy
X-Gm-Gg: ASbGncuFa3riIh4t+2auzWDLVACrqmVBMeeCr6NcZQwz75gHF20whY1x1MlGL3S5PXb
	MQn9vBZ1DmWNw8VsTB3U6Kbc91sTpeqxwh0/Jl0yWw858rWD4R2af0CIvIlTTxwA5sa0YM66nus
	SQyfz+UH894z3OFRQHBhee7nCFNlzPAuH0Khe7IvDRj6kUYFiKtg2XfnimGI22ygdVG3lXcY0nN
	gzhLtfaSZBl7QJhaGxoUbd6uWwUNkWxEJsl3bOYySO/GGXZkjpy8Rn/85//rIUTY8n4kWJwdCVM
	wcUAdV2ujnf2VFsGpCWNGxqdU4uNlH3qG+lnL9jNVkOrKNmaAt2lyR+OWybENYN4iorzdhARCtY
	bThC+et7jkBbbSiFPFIXufT5x5gwHZgqLAJ0mH2q6YYidHGzJrG7uIZUb2XhuknSBxaVzwYNzAe
	CNf/6CiEIuaUKCwNfMoCdikkhHd9aHWs6OaPbwxWOcEp3+GKGrlSontSVOAuadCXAS8wuNdoQnG
	Q==
X-Google-Smtp-Source: AGHT+IFihaBZCFIsJd6D9UKrCJSvXeCFeciW9xfdJYQD1zmf0x7kCJa+0Z18tqPO99Cb0uwZ72EDIw==
X-Received: by 2002:a05:620a:4110:b0:811:3f8a:24a6 with SMTP id af79cd13be357-8b33d4b4e27mr1229307585a.53.1763941520197;
        Sun, 23 Nov 2025 15:45:20 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.19
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:19 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 04/32] scap-security-guide: fix fetch
Date: Sun, 23 Nov 2025 18:44:44 -0500
Message-ID: <7425c3ca03c6dbb21ba02d7a97787709cb51f8ee.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2662

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

The project does not keep releases in branches, instead they tag them. The stable branch
does not contain releases, so we use the revision only.

See upstream issue [1] for details.

[1] https://github.com/ComplianceAsCode/content/issues/13543

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
---
 .../scap-security-guide/scap-security-guide_0.1.71.bb           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb
index 5e45332..e277ccf 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb
@@ -7,7 +7,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820"
 LICENSE = "BSD-3-Clause"
 
 SRCREV = "459f0abf2ac08d36e5fc4a2619bc75cff7000da9"
-SRC_URI = "git://github.com/ComplianceAsCode/content.git;branch=stable;protocol=https \
+SRC_URI = "git://github.com/ComplianceAsCode/content.git;nobranch=1;protocol=https \
            file://run_eval.sh \
            file://run-ptest \
            "
-- 
2.47.3


