Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32474C28B23
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 10:25:22 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.10290.1741170320414519882
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Mar 2025 02:25:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aYvUJwv6;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f2f391864so3664551f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 02:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741170318; x=1741775118; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ybsoC9JuIDqD3mMD9sebBQhtbyPmJu1RqGbOajCVTVU=;
        b=aYvUJwv6jrajT4hIUYRbeZAOKw65QgOTR94wCkb5WQae7H3jYxpBPJVbt1yI4uKcH2
         ew95O7Pw9AdtA+dHg8m6zrEO516+nEhg+69ywfv5xnKXRwALWyda3vb93I3Qcf5oe65q
         9/sRaOYh/O8HXZ9vIfzezIttLJwY4mtrA6RmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170318; x=1741775118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybsoC9JuIDqD3mMD9sebBQhtbyPmJu1RqGbOajCVTVU=;
        b=NVsVDjfoF1+T8wPwD3Z3Ek0pzRg+IWaOkrauF57Rn6K8gjN/tCabGVDa80PCN4da62
         S2j7VNmPzBJ2/hUu2TDdKYuxES6IPznABaokeF4gFvuKBcRVQRd5xi/mUSostxbx2caX
         hl7jy5x1tHZuuP4W8cB8IYwiyUbLztJh/dJ1nrUuIwWGsNihd9RN4hGXvIP7zwlLXdDS
         HQDmP6XM7Zt8dVM9UNV0IEK8lv1sjt5uqEuUAy0AdNozn02QMMDzauvYCEp7PImFLcGr
         8Zv+/IrUugU+s+VsA6xA/q8EG1LAJ7Ymo6N8kt6eEaG9korFgbWSE53SZIDMT7Z+sBud
         paZQ==
X-Gm-Message-State: AOJu0YwywyZDDMSqB39oABBkAoN62/Iq4yn+BfhdRVDG0lZih+IEIrT3
	t3VNlyIZRli1/fPbBWXTNYWk93vD2SCqejjIqOrjhEq5V2JRD6WMRPyMh6PvS1MOseUa1HlyCGS
	l
X-Gm-Gg: ASbGncuXS2KR9/C8OTY9C0C6mAkb8s/w27f5NugGbtbIvls5NxNfLWlOS9KtrgsLEUt
	awiYg2ElkBjNHxVEjFFoWizfgxWyE4GpNOH1GE6wxbsJItr7TGmjU6SN+Hil/nqdeGjA9y0X+a6
	vcnutJ0EgU6y4ZIyH3yRw0fG/90i1JeDopXBxjNj/tf03PvUGsrpB69EbVSRdV8VfGG8KTow+ia
	P09Gc2/D9TbDLMBm7xkofgT3TBOHgE45gE3d6Gfhplhe6N+KbxOhN9HbdGKCysQojS0CvF89tGd
	la85YquuTr+MihCF0EPXS9YQCAUIvptr5f/MqN8mxFol3U/tBeOjN4rFRTPuq2tQF+Si0vy0cg=
	=
X-Google-Smtp-Source: AGHT+IHUJZHYaBm2BTEK72qiNjFOJG5x4ec1zDzrg4dHA14AwyJnn+AaKD0SU50eFBd+dC9Hc/O7VQ==
X-Received: by 2002:a05:6000:401f:b0:38f:3c8a:4c0a with SMTP id ffacd0b85a97d-3911f725934mr1838717f8f.7.1741170318448;
        Wed, 05 Mar 2025 02:25:18 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:939e:c44d:2366:e8da])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352eb1sm12973495e9.31.2025.03.05.02.25.16
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:25:17 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 09/11] config.json: Fix SANITY_TESTED_DISTROS and run earlier
Date: Wed,  5 Mar 2025 10:25:04 +0000
Message-ID: <20250305102506.2043524-9-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250305102506.2043524-1-richard.purdie@linuxfoundation.org>
References: <20250305102506.2043524-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 10:25:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1153

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/config.json b/config.json
index c5d3913..adb85d1 100644
--- a/config.json
+++ b/config.json
@@ -511,6 +511,11 @@
                 "extravars" : [
                     "SOURCE_MIRROR_FETCH = '1'"
                 ]
+            },
+            "step2" : {
+                "removevars" : ["SANITY_TESTED_DISTROS"],
+                "shortname" : "Compare AB workers and SANITY_TESTED_DISTROS",
+                "EXTRACMDS" : ["${SCRIPTSDIR}/yocto-supported-distros --config-from-web --release-from-env --compare"]
             }
         },
         "trigger-build-posttrigger" : {
@@ -519,10 +524,6 @@
                 "shortname" : "Source Mirror Selftest",
                 "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest -a -t yocto-mirrors -j 15"],
                 "ADDLAYER" : ["${BUILDDIR}/../meta-selftest"]
-            },
-            "step2" : {
-                "shortname" : "Compare AB workers and SANITY_TESTED_DISTROS",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/yocto-supported-distros --config-from-web --release-from-env --compare"]
             }
         }
 

