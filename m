Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B01C35FFA
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 12:57:41 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.7121.1742389053370155129
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Mar 2025 05:57:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=O0uTOcXU;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-391342fc1f6so5522380f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Mar 2025 05:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742389051; x=1742993851; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6a/cHufkX4W8NlMbfQqvGQ523jgoeEjFM/c0BDREdxM=;
        b=O0uTOcXUw3ZLVc7aJ8gXcWtOyc4IXXxEcaPxlI5y1jwY5tj3lNSQiRy4ueBXM+ssUC
         KzPkHXSgEftHi7sNE1ZPG/qLqR8f7WCUoG+NPjbvUP0NIUzgVFHKn8Z7Di3B8CUWhD48
         Cru1+BHxRKKZ+raf8SkiLRFPB4kaF827OFGaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742389051; x=1742993851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6a/cHufkX4W8NlMbfQqvGQ523jgoeEjFM/c0BDREdxM=;
        b=sr2W7V3Wzxr1HNH8fMe6mNbA2ArmdPDRgYXbvFZ/Pa9UmI1XNiwNIKBP5KVQvOIMyM
         0ZyGeCwIG5JKmbahyF9iAmNEA4EPzs7V8JLCnkRCmYu+1SwFwan9pVrUk0YrulDmLXjm
         gwtlzrPSqrN+wsOF8o4hkl/1z6YxpgPAfDXysgeyp91w7/xJpRhpgLp4gIUiVtz9losD
         a1NDyUCKO0h56sM+ssNq+w9Mb0v8R5vv8FPfCb3DZGrQE4QTXtvCFemprwPtMapIjFFi
         +KvDxmIRxxLkhX/CtaLqalaRslBY4fMRQaASQrUk7HPGQ/npui+wfd4t3+/ynl0SMP4m
         ueTg==
X-Gm-Message-State: AOJu0Yx+dHGKeMdgkHAv7tsYEgUYnxKTr42CsyXPEG1GJXy4z+DDIz+b
	uiDbfwqzL/ZsvCIl1vev4WuGKqtWiQWMC/SDNNO/gaPIR/vJEOylEsdhZJcO15rYchmUDLJ6gTT
	o
X-Gm-Gg: ASbGncs5O46OhybFe7FbODuusUParhXlMeUNAN+Wru7C5dFDutzSpFZ7Tx/ewW0bPRr
	7IWVyx2GCwNkFeqk/TDsiSzUo61uhAcU2SQ5wcI2AaDwxcPBcWpbK0s4rfp6bgiuhGTuL0ojzNr
	UKLFXAypWg9+RJLcGQ0E5ks/F2jVfWVcv9JsgiKRMF5bHs2HN9aYBoV0g6zZCaGvA/wsHgrQW8z
	dMNIHhrE9KklIog8ThpRREtBl06EpGY/rwEZ9nJ3JHwC17ernX8RQemhvA0N0ovKv6ulPXZHoxE
	t189Ako0TJc8D6ddRfBMT7ytER8bLlVRo6Tgvz9LtG4ZVROUcuIqy6AL5VT6aEghTVmWlbAO
X-Google-Smtp-Source: AGHT+IGHy7uon5tcu9ODfZUqEQoo6pJGFdPWatI1W6kNxo7rk/Yu43JpNLbRTTjlbGMBzUNs8bKPmQ==
X-Received: by 2002:adf:9bca:0:b0:398:fd9b:b935 with SMTP id ffacd0b85a97d-39973b35379mr2403495f8f.53.1742389050920;
        Wed, 19 Mar 2025 05:57:30 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:dad:b471:9c34:4577])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7e9f8asm20808886f8f.81.2025.03.19.05.57.30
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 05:57:30 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [libmatchbox] [PATCH v2 2/2] README: Document where/how to send patches
Date: Wed, 19 Mar 2025 12:57:27 +0000
Message-ID: <20250319125728.646406-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250319125728.646406-1-richard.purdie@linuxfoundation.org>
References: <20250319125728.646406-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Mar 2025 12:57:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1223

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 README | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/README b/README
index 83ea0f3..0cdaaf3 100644
--- a/README
+++ b/README
@@ -9,3 +9,14 @@ git://git.yoctoproject.org/libmatchbox
 
 Issues can be files at:
 https://bugzilla.yoctoproject.org/enter_bug.cgi?product=Matchbox
+
+Contributing
+============
+To contribute to this layer you should submit the patches for review to the
+mailing list (yocto-patches@lists.yoctoproject.org).
+
+When creating patches, please use something like:
+    git format-patch -M -s --subject-prefix='libmatchbox][PATCH' origin
+
+When sending patches, please use something like:
+    git send-email --to yocto-patches@lists.yoctoproject.org <generated patch>

