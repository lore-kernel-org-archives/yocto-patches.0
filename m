Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD086C87FC5
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 07:27:31 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.6920.1753342045443465771
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Jul 2025 00:27:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fWR12NMo;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: rybczynska@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so316541f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 00:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753342043; x=1753946843; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzLu83BmvS8tARvGjnfUoQ73TII1WlE85rl9qt+2VXk=;
        b=fWR12NMon0IYHaGFhnLkfLOzpcty1gyG8qYgFQceB31vnP6C2VdEfKzOsN0titlNMW
         hyw6xKjQLSmTZIoHn+6+jYEsg2IjAcXjWatas+LPLi4RB2jBaNZjhGET3tl3UPcIEgkw
         GBiR28gy3cIQpkdoIWZlLJ9tTHmLNxU7Kb9GnIFVm3WCXnMyTx8G125TIP0Ws98QGK9h
         Fbqa257tyDAqCbHoa3hD8nvdqMzUl2jTgZDlCwn4ugycohoTo0EyUeSqzygK8ymS32lq
         +a4jiCOcgHcbS0Rt8Vq9TO+f8/XB93tExN+HB1g3v6pE5IPvwGdufQD4mF0Dl+99GmpP
         7SsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753342043; x=1753946843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzLu83BmvS8tARvGjnfUoQ73TII1WlE85rl9qt+2VXk=;
        b=vKn2b/0dydAlPEPK9gauFeTKgUo1Ytvcuz7rH10LxVaAWqyHhQ1Ho5GoNZQjbkxGgF
         /+bbbFpGNXS4c6mKwvAHVKFnfoAQZSV2tE58il3apQ5HtbU8kjsQwy637ykMRAcfiqU0
         AllJsEDuTSa7datd4rIeXuZMeRgnAepGgDdj25KfZ7HaWG2PXKSKQUZGLowW6jIHoxxA
         oQpb4+CI4PZA5oAv8kJBUrvocwOAqIvDNLSoU0AsUVQ7FvjDM+dohU+jOYm8EOxunMln
         HphnTVIXPS/L95wJV4Y2/q/uUjTBeSqOEU+Gn0F6b5qRVTfb3Vpw//Iv2OGcDDcfJqcD
         r6Jg==
X-Gm-Message-State: AOJu0Ywm1d1UchQ2B1JpZ4q2R3HPbGMidK4nSkuASCocf35TdpLPjz0A
	jXcgSP9YJbTKI0wPU/VmkPeQySsEw+fTAgYSqr9GwzoBmrRUqKiL/mAa++QpEQ==
X-Gm-Gg: ASbGnctvyodT57DVXdmtQOeO0EBqwIarrD+HQ56yiO7hiamTm0GL1VDTBZd3LgZ4IL0
	G6rlgqv9abblbK0XQ9UBZu8pv0bCjPNsZK62nycSgMapF/9JUnhPs3iRUlKfPVHURH7JLZTH9Ti
	VAFq/p813ZNkfYmn+IroJMzDTm94gyayDNex0SRdqrDb9erGJfBKf8/vG/cUoAS/OvNsHP4yh/j
	EZoeXiPOLhoNRsFUMe5c4dUN06Wn6+FUPIwMe36Yknw0cCjJQtA592+XB7dqDownrbnoAgMYcjq
	fEIL6YEe5l8J/hZlgXwLzvFyGrI5lblUL++/tj1BOV0f86g0dYdTOzf6KR2inV/4s4RfOMiRDD1
	zl12evsvA1j0o7YojQAfIl9ohvIBmQ/wU5c0=
X-Google-Smtp-Source: AGHT+IEC1kZvy0Fmy/AAL1f1ecI6bFz14IzADNtQX7w9D00wZGqSYnV8QUuo/9prMYvKlO5D7bJqow==
X-Received: by 2002:a05:6000:248a:b0:3a6:d604:a017 with SMTP id ffacd0b85a97d-3b768eedfa6mr4233965f8f.24.1753342043274;
        Thu, 24 Jul 2025 00:27:23 -0700 (PDT)
Received: from voyage.lan ([2a0d:3341:cd4f:d110:cf6f:2013:cd74:cf4e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm1231723f8f.44.2025.07.24.00.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 00:27:22 -0700 (PDT)
From: Marta Rybczynska <rybczynska@gmail.com>
X-Google-Original-From: Marta Rybczynska <marta.rybczynska@ygreky.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [PATCH 5/7] kas: add common dldir/sstate
Date: Thu, 24 Jul 2025 09:25:47 +0200
Message-ID: <20250724072642.7358-6-marta.rybczynska@ygreky.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724072642.7358-1-marta.rybczynska@ygreky.com>
References: <20250724072642.7358-1-marta.rybczynska@ygreky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 07:27:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1862

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
---
 kas/kas-security-base.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kas/kas-security-base.yml b/kas/kas-security-base.yml
index 6d53071..3ff2ae3 100644
--- a/kas/kas-security-base.yml
+++ b/kas/kas-security-base.yml
@@ -60,6 +60,10 @@ local_conf_header:
     HALT,${SSTATE_DIR},100M,1K \
     HALT,/tmp,10M,1K"
 
+  dlsstate: |
+    DL_DIR = "/home/gitlab-runner/build/downloads"
+    SSTATE_DIR = "/home/gitlab-runner/build/sstate-cache"
+
 bblayers_conf_header:
   base: |
     BBPATH = "${TOPDIR}"
-- 
2.47.2


