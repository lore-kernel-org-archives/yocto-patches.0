Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F17C61DBE
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 20:59:03 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22435.1787777933493548057
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Aug 2026 13:58:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=D9ZqBbsY;
 spf=pass (domain: konsulko.com, ip: 209.85.219.46, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-9087fb771d3so8864786d6.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 13:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1787777932; x=1788382732; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d2K+A9aMaJzVR8BxiZn+zkAAp7c2uRwXNlQwTYVyD84=;
        b=D9ZqBbsY95hKugnLp/Abdr95N1upT+QspVt/Pq8gMUTE3ax9kCfTk6bTY16DCtaS+s
         tx2HHAJV+AQvafISv8ei0syOc3QgJEv/Eya845KAMnLlUoo0JID/FtArxVsW/Q/jGnEU
         wLPrUwKy4WkUbI7RqhGY3MPiIML901NyOhA24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787777932; x=1788382732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=d2K+A9aMaJzVR8BxiZn+zkAAp7c2uRwXNlQwTYVyD84=;
        b=qyMqpNrrC7B7XfCOfntqgofl4JzwENHJ25tc/QbfvSbssfd55ga1hatx4VhM4UEsbq
         vLANYy16yYQVOTdSlxIb/BJiwwPCCQX+2HQJKBfq4996kTu3l6o8gIqjbe+kjwfFiOzc
         eMpEoyZwobjE+QNdTWrRYYA/JHab3idW151gplgG8qsrTgR/aNQVsWqmKL/FGh2uphRt
         2K8+Rr/oJD67duVHMmFeE14TK1MYXO+MzF+1GfEFmazL+mG7L/hRtVQUbj8L4doJO7Mb
         OkPFyYQh3wyKq+Gso9PcijQEmCTd3jaW3c3QFJn6jb8BKIP1bM8o9B4PJW2x4jHV14Mo
         xKAw==
X-Gm-Message-State: AFuF++k6OIRcoZZRa02OwuKADPGaYkZmgHGwSxQxWa9sRL42Tuzb0BHC
	tZcMLENdNYyemEkwrExu84drbZh+VpXLbhXjG/bTu1/FaklUn4FTB+m7uVVEMADt2c/7Sg81h4g
	jdzqW
X-Gm-Gg: AR+sD12hTl3hqyDZlwnIipP8vx4CM9Vviist+KBpDDhNa0x3R0sx88UlLpjyWnaCePX
	vPaxCypWxO9b/QGPOl18+jmDzwuWB62fQDIQ99EL3HxmGq+5M7lkoH95qtbyqkJS2X1HOxoPvV/
	YEVoXL+kajYQkoiA++Pv3PegUDOM/imxOEDKe36S0sKrEz8c5yjR9BNRw5EOYVQHOujx9UFJwou
	Tg1T813rV4fYBo2bOgI7tM3zXjOE1Ks9mlQPlRSR7LVDdU1Ow5NaXBj9wZ0YjlbObgP2bSgUY4A
	gYbiGbkY6Nj3CQ/9i79AWZLMcwn0jRbFbwrAJ+3/M8+MJv17sPZHzBmOy5hOGgHIojVHmyM6fnw
	+nrgZpJP083SXMbHt8D/N+xiadiN1dV22YsecQXF33FZodSjFGJ/Yl7qIbCrC5Gpx4ithzH2dYl
	hLRBFs3Naem784pSt2S9xBOwfirfGjOx47RASBQ3HuBx9aecR/uvVk+EnpMOnatPR8+Gdaqaa2C
	AkuOnM+q6GfaJdzHArBJqNh5B+L/5NaYO1pP0MvNN7tt3TfFUcSpXQZYvcoROODQFJ5R38r+jRi
	3krLMZtVnA+ymi8XWN6iWKFh7g==
X-Received: by 2002:a05:6214:460a:b0:908:9045:217a with SMTP id 6a1803df08f44-90cc7a7126fmr121844346d6.29.1787777932351;
        Wed, 26 Aug 2026 13:58:52 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc65093d5sm35135856d6.26.2026.08.26.13.58.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 13:58:51 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 09/15] tpm2-tools: set status for CVE-2017-7524 and CVE-2024-29039
Date: Wed, 26 Aug 2026 16:57:43 -0400
Message-ID: <603cd3ff492a2e53897774569b20f544c8f4ff49.1787777775.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787777775.git.scott.murray@konsulko.com>
References: <cover.1787777775.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 20:59:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4701

From: Peter Marko <peter.marko@siemens.com>

CVE-2017-7524 is a historical CVE and new cve-check does not undestand
fixed version data. Debian report [1] shows fix commit which can be
linked to release information.

CVE-2024-29039 is per Debian report [2] fixed in 5.7.

[1] https://security-tracker.debian.org/tracker/CVE-2017-7524
[2] https://security-tracker.debian.org/tracker/CVE-2024-29039

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
index 04ada78..5c968dd 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
@@ -19,3 +19,6 @@ PACKAGECONGIG ??= "efivar"
 PACKAGECONFIG[efivar] = "--with-efivar,--without-efivar,efivar"
 
 BBCLASSEXTEND = "native nativesdk"
+
+CVE_STATUS[CVE-2017-7524] = "fixed-version: Fixed since version 3.0.0"
+CVE_STATUS[CVE-2024-29039] = "fixed-version: Fixed since version 5.7"
-- 
2.55.0


