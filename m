Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9695.1795884890822638092
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:54:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=HjKqg+cS;
 spf=pass (domain: konsulko.com, ip: 209.85.128.44, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so92680945e9.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795884889; x=1796489689; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DGJ33Sv6mrFv0EKY2paYZsuyffqNuvLNLm0BK3iNdGA=;
        b=HjKqg+cSigaCbzatFq3LZRfiY4UnBC+cwNiscRwrVaWPu021aekA5PQcpwdxwXomAj
         03YP3C8VgmgAgut05NK43kbkFNrMXpBudCMfvFrQcex589+00mE+jPeYqJWm10dLByRB
         YUN/Ak9EwjWehqfyLzyowPwRtg01T5o0aSS+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795884889; x=1796489689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DGJ33Sv6mrFv0EKY2paYZsuyffqNuvLNLm0BK3iNdGA=;
        b=dANgp5XsWLTj7HsgxhF8wriTOqZ+DN/vdRT+h6BX1p7ppHiunSbXnza4sWvp91pFvV
         7sxyj5p9FD2Fi68saImCkWx59W6hqU1u3a95JjZeG8Ay/thORvfDfRptumPZaefIkwDP
         6gCDQ1vGPW17mvwO3pHQh9AluDQGjkcLNNm0kY9dNZ5op49s/gRhcsxUDRupbW0WdMUK
         aNLDhY0BzLfTYrfv9L0FHjMkfiM6HjIyHU9VcMQzLDNkhvcSqjnBIakB/iXLEDHrwOr7
         wCU2BFGutA+RoViDgMnWRoi9SbPzIg1L+RVzvNN5m6LFa65zOvJxaok9iT9+3DD7gO1H
         aFJw==
X-Gm-Message-State: APuU4Z81dsVC+4vg9Cv6Au/Yvxxa7V+h8qAx2XEUZDubAYQHQKGZ8Z3R
	WZmciJ6buGlVu2VY0de9OGkpOAr7+wFOODe2aiMkn1HzRvUTeDZe5Grxp6+Q6KIiXZiH/fXysSW
	s+owYOjM=
X-Gm-Gg: AZFdTZezS5K4tLoWU5TmhvwEnpoc2kmcdq9hciPhAK39Q6D2yrJVZpUnjta+wm2agS2
	PJHrDy6mOvxqjGw+Q5rq8XJUAxrJ37dQBbkwbFLu55DAcqoFk9LMvRvImaMxkp9/y84woSZGsoj
	VAQ3nMX/M0IjCvLP3rNrLc7cs++8+AzZ7VL9b9v6HIKXUayMbgTD+293XlSviDY01H8VVTzEnru
	cBBYjrhX6/nCsvbk1Gkyw43Ug3jUPSWd554ETxfYydeqZMRExN6IOcQyFGYxFEKTIa1xpBQBzJ6
	W63qJr2zgzrSot+H9GQSx4GJJVi/KsdIXFzzkxPmLBoAlqvI04rCkS+RU2GYIIPkrkBAVsi4R/+
	04BfgANmJ8+LcuO5kGYVD68+fVE/WT/nvR33MoDJcx+yXjE2FlAZ/C9qBm584zQ5efCYGu7sOqn
	+FxdDiR623RYGGiUw/5OnCi8Nz70tV8BFN+BAIToQlhky6ANDDTsSF/vKYLXzvJ+YxEe3ZY+Ct2
	e01DYttoDVpjTOvOLxg6rOr9GKqekqLHbQkzJwKR++lL1WpGUTEGoUzYqeEfwZavswuCxLBHRrL
	R4V8Jl3kxAsK3wePqrFFNU+ciA/Ddhg3YOzWLNfUAu9fNAQed4Q0Qse8UVCZxLbCq8AYXq6XyAa
	YggYfT9zZxN0UEaY8YoaREigKhO4OwQ==
X-Received: by 2002:a05:600c:45d4:b0:4a2:84c:52f3 with SMTP id 5b1f17b1804b1-4bb8880988cmr587736825e9.6.1795884889034;
        Sat, 28 Nov 2026 08:54:49 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm755951155e9.15.2026.11.28.08.54.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:54:48 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 03/14] swtpm: Add missing useradd inherit
Date: Sat, 28 Nov 2026 18:54:21 +0200
Message-ID: <f6ec42c446996eabe949e7058de13e70af939256.1795883420.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795883420.git.scott.murray@konsulko.com>
References: <cover.1795883420.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:55:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5573
Content-Type: text/plain; charset="utf-8"

The swtpm recipe has USERADD and GROUPADD definitions, but has never
inherited the useradd bbclass, fix that.

Reported-by: Ehsan Emami <ehsan@emami.net>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
index 8472f02..8488d01 100644
--- a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
+++ b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
@@ -12,7 +12,7 @@ SRC_URI = "git://github.com/stefanberger/swtpm.git;branch=stable-0.10;protocol=h
 PE = "2"
 
 PARALLEL_MAKE = ""
-inherit autotools pkgconfig perlnative
+inherit autotools pkgconfig perlnative useradd
 
 TSS_USER = "tss"
 TSS_GROUP = "tss"
-- 
2.47.3

