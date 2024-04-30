Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CBCC19F4F
	for <webhook@archiver.kernel.org>; Tue, 30 Apr 2024 20:33:52 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web11.26384.1714509225532079950
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 30 Apr 2024 13:33:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ulJPl8hf;
 spf=pass (domain: konsulko.com, ip: 209.85.214.171, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ec69e3dbe5so6814615ad.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Apr 2024 13:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1714509224; x=1715114024; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Hll8c4jFtGb1347J9aeJgNI5UxaGf+9I8ZWmjUp1vQ=;
        b=ulJPl8hfFqW91PQ2X+e1ez0PtVPtBjgUy2sQ5sc5/sWOFPoYw9iYqH59/+zqQ17ZwX
         4JGm57WLNQICrGECPyzHN8UhRw5gS/RZKAF866TnO4ANvG4J3qN820R5k0amdKYkGHuy
         vGSlsOJAXAOPcSoZ07K+6Gcr5C5QHE4HmJyQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714509224; x=1715114024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Hll8c4jFtGb1347J9aeJgNI5UxaGf+9I8ZWmjUp1vQ=;
        b=Wl6a5nXgMcSRrwsjd13fZaF3cEmskUJ0FSXkYZ4emLG1KheQQtLPMlpwtojCY8ZnOd
         Ks/GRoyDB5+HtFNJLYwAPhL5LpDpjIf+/MR75/oX7+SglpsQH/mMAN8gTn+9yQbsOJ20
         mEeOl4b4kPMAyKx0uTECZJ0Do7bQeLDZcWJkgiVm7YjUDXgkoJoojeCYGQq/RlrFJelI
         zPUbKgRqqg/czSWxRkCcCMtOA2SpEFHaU8IVHnTtMfejbI0mlwqvdnt4LUlZu2GURcgh
         WmE5pC7VacTUm4k0uio4XXx1VmfLNl3FjdGECYxqsm2IsOVuel82I118mJzDp2kVPfZe
         w9lA==
X-Gm-Message-State: AOJu0Yycfwi+7XdzvNko/bnsQTkRiW6mScsAETHtVoQHWQ65jtN87zQz
	Ua0JqsaKLfebRUOQulFlwrKYuUPd2KMojgwVnBxH7OqgyxsH5h+srpXZwfXsCaxmZpMtIOATxz/
	b8Q4=
X-Google-Smtp-Source: AGHT+IHYGhMKpz+9sk3sLCHEEMmrQfcAKCqJQL56sr6M/jotD7cgENA9e9T0aQ2vINPEEeTyIPBdhw==
X-Received: by 2002:a17:902:c215:b0:1e6:116b:b0d3 with SMTP id 21-20020a170902c21500b001e6116bb0d3mr607113pll.28.1714509224273;
        Tue, 30 Apr 2024 13:33:44 -0700 (PDT)
Received: from localhost ([2601:1c0:ca00:bd60:e8c5:20ec:b8be:259c])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b001ebd7ef383fsm4362875plg.203.2024.04.30.13.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 13:33:43 -0700 (PDT)
From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [meta-security][PATCH 2/4] tpm2-tools: BBCLASSEXTEND native and nativesdk
Date: Tue, 30 Apr 2024 13:33:33 -0700
Message-ID: <20240430203335.110707-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240430203335.110707-1-tim.orling@konsulko.com>
References: <20240430203335.110707-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Apr 2024 20:33:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/76

tpm2-pkcs11-tools-native needs tpm2-tools-native

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.5.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.5.bb b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.5.bb
index 8119bb1..9bad758 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.5.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.5.bb
@@ -13,3 +13,5 @@ SRC_URI[sha256sum] = "1fdb49c730537bfdaed088884881a61e3bfd121e957ec0bdceeec02612
 UPSTREAM_CHECK_URI = "https://github.com/tpm2-software/${BPN}/releases"
 
 inherit autotools pkgconfig bash-completion
+
+BBCLASSEXTEND = "native nativesdk"
-- 
2.43.2


